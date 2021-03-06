//
//  LoginController.swift
//  wineFindThankyou
//
//  Created by mun on 2022/01/29.
//

import Foundation
import Alamofire
import NaverThirdPartyLogin
import KakaoSDKUser
import KakaoSDKAuth
import GoogleSignIn
import AuthenticationServices
import SwiftyJSON

enum NetworkError: Error {
    case badUrl
    case noData
    case decodingError
}


class LoginController: NSObject {
    
    lazy var loginController : LoginViewController = {
        let controller = LoginViewController()
        return controller
    }()
    
    private lazy var naverConnection : NaverThirdPartyLoginConnection? = {
        let nConn = NaverThirdPartyLoginConnection.getSharedInstance()
        return nConn
    }()
    
    unowned var viewController : UIViewController!
    weak var delegate: EndLoginProtocol?
    
    init(_ viewController: UIViewController) {
        super.init()
        self.viewController = viewController
        self.delegate = viewController as? EndLoginProtocol
        
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    internal func loginByNaver() {
        naverConnection?.delegate = self
        naverConnection?.requestThirdPartyLogin()
    }
    
    internal func loginByApple() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    

    
    internal func loginByKakao() {
        guard UserApi.isKakaoTalkLoginAvailable() else {
            UserApi.shared.loginWithKakaoAccount {(authToken, error) in
                guard error == nil else { print(error); return }
                self.sendUserInfoAfterKakaoLogin()
            }
            return
        }
        
        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
            guard error == nil else {
                print(error)
                return
            }
            self.sendUserInfoAfterKakaoLogin()
        }
    }
    
    private func sendUserInfoAfterKakaoLogin() {
        UserApi.shared.me() {(user, error) in
            guard error == nil, let userIdInt64Val = user?.id else {
                print(error)
                return
            }
            
            let userIdentifer = String(userIdInt64Val)
            let email = user?.kakaoAccount?.email ?? getUniqueEmail()
            let type = "kakao"
            let nick = user?.kakaoAccount?.profile?.nickname ?? "User"
            
            let params = [
                "id": email,
                "type": type,
                "sns_id": userIdentifer,
                "nick": nick,
            ] as [String:String]
            
            AFHandler.signBySNS(params) { result in
                guard result == AfterSign.success else {
                    self.delegate?.endLogin(.fail)
                    
                    return
                }
                
                AFHandler.loginBySNS(loginId: email, snsID: userIdentifer, authType: type) {
                    self.delegate?.endLogin($0)
                }
            }
        }
    }
    
    internal func loginByGoogle() {
        GIDSignIn.sharedInstance()?.signIn()
    }
}


//MARK: Naver login
extension LoginController: NaverThirdPartyLoginConnectionDelegate{
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        naverSDKDidLoginSuccess()
//        delegate?.endLogin(.success)
    }
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        naverSDKDidLoginSuccess()
//        delegate?.endLogin(.success)
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        naverConnection?.requestDeleteToken()
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
//        delegate?.endLogin(.fail)
    }
    
    private func naverSDKDidLoginSuccess() {
        Login.shared.loginByNaver(naverConnection)
//        delegate?.endLogin(.success)
//        RequestNetworking.getLoginCheckAPI()
    }
}

// MARK: Google login
extension LoginController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if(error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("not signed in before or signed out")
            } else {
                print(error.localizedDescription)
            }
            
//            delegate?.endLogin(.fail)
        } else {
//            delegate?.endLogin(.success)
        }
        AppDelegate.user = user
    }
}

//MARK: Apple login
extension LoginController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.viewController.view.window!
    }
    // Apple ID ?????? ?????? ???
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let givenName = appleIDCredential.fullName?.givenName as? String ?? ""
            let nick = givenName.isEmpty ? "User" : givenName
            let email = appleIDCredential.email ?? getUniqueEmail()
            let type = "apple"

            let params = [
                "id": email,
                "type": type,
                "sns_id": userIdentifier,
                "nick": nick,
            ] as [String:String]
            
            AFHandler.signBySNS(params) { result in
                guard result == AfterSign.success else {
                    self.delegate?.endLogin(.fail)
                    
                    return
                }
                
                AFHandler.loginBySNS(loginId: email, snsID: userIdentifier, authType: type) {
                    self.delegate?.endLogin($0)
                }
            }
            
        default:
            delegate?.endLogin(.fail)
            break
        }
    }
        
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        delegate?.endLogin(.fail)
    }
}
