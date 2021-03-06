//
//  StartViewController.swift
//  wineFindThankyou
//
//  Created by munyong on 2022/04/05.
//

import Foundation
import UIKit
import Lottie

class StartViewController: UIViewController{
    @IBOutlet private weak var imgViewLaunchTitle: UIImageView!
    @IBOutlet weak var launchTitleTopAnchor: NSLayoutConstraint!
    private weak var aniViewWidthAnchor: NSLayoutConstraint!
    private weak var aniViewHeightAnchor: NSLayoutConstraint!
    lazy var lottieAnimationView: AnimationView = {
        let animationView = AnimationView()
        animationView.animation = Animation.named("WinefindThankU_motion_eyes")
        animationView.contentMode = .scaleAspectFill
        animationView.play()
        animationView.loopMode = .loop
        return animationView
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 22
        button.backgroundColor = .standardColor
        button.setTitle("μμνκΈ°", for: .normal)
        button.setTitleColor(.white, for: .normal)
        let action = UIAction(handler: { _ in
            self.goToWalkthroughVC()
        })
        button.addAction(action, for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLottie()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.changeUI()
        }
    }
    
    private func determineNextStep() {
        guard NWMonitor.shared.isInternetAvailable else {
            showAlert()
            return
        }
        
        guard UserData.isUserLogin else {
            startButton.isHidden = false
            return
        }
        
        AFHandler.loginBySNS { status in
            DispatchQueue.main.async {
                guard status == .success else {
                    self.showAlert()
                    return
                }
                
                self.goToMain()
            }
        }
    }
}

//UI
extension StartViewController {
    private func setLottie() {
        self.view.addSubViews(subViews: lottieAnimationView)
        self.aniViewWidthAnchor = lottieAnimationView.widthAnchor.constraint(equalToConstant: 150)
        self.aniViewHeightAnchor = lottieAnimationView.heightAnchor.constraint(equalToConstant: 91.2)
        NSLayoutConstraint.activate([
            lottieAnimationView.topAnchor.constraint(equalTo: imgViewLaunchTitle.bottomAnchor, constant: 34),
            lottieAnimationView.centerXAnchor.constraint(equalTo: imgViewLaunchTitle.centerXAnchor),
            aniViewWidthAnchor, aniViewHeightAnchor
        ])
    }
    
    private func changeUI() {
        self.launchTitleTopAnchor.constant = 94
        self.aniViewWidthAnchor.isActive = false
        self.aniViewHeightAnchor.isActive = false
        self.aniViewWidthAnchor = lottieAnimationView.widthAnchor.constraint(equalToConstant: 266)
        self.aniViewHeightAnchor = lottieAnimationView.heightAnchor.constraint(equalToConstant: 266)
        self.aniViewWidthAnchor.isActive = true
        self.aniViewHeightAnchor.isActive = true
        
        lottieAnimationView.animation = nil
        lottieAnimationView.animation = Animation.named("WinefindThankU_motion")
        lottieAnimationView.play()
        lottieAnimationView.loopMode = .loop
        
        self.view.addSubViews(subViews: startButton)
        NSLayoutConstraint.activate([
            lottieAnimationView.topAnchor.constraint(equalTo: imgViewLaunchTitle.bottomAnchor, constant: 34),
            lottieAnimationView.centerXAnchor.constraint(equalTo: imgViewLaunchTitle.centerXAnchor),
            
            startButton.topAnchor.constraint(equalTo: lottieAnimationView.bottomAnchor, constant: 29),
            startButton.widthAnchor.constraint(equalToConstant: 216),
            startButton.heightAnchor.constraint(equalToConstant: 44),
            startButton.centerXAnchor.constraint(equalTo: lottieAnimationView.centerXAnchor),
        ])
        
        UIView.animate(withDuration: 0.8, animations: {
            self.view.backgroundColor = UIColor(rgb: 0xffffff)
            self.imgViewLaunchTitle.image = UIImage(named: "LaunchTitle")
        }, completion: {_ in
            self.determineNextStep()
        })
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "μΈν°λ· μ°κ²° μ€λ₯",
                                      message: "μ μ  λ°μ΄ν°λ₯Ό λ°μμ€λλ°, μ€ν¨νμμ΅λλ€.\nμΈν°λ· μ°κ²°μ νμΈνκ³  λ€μ μλν΄μ£ΌμΈμ.",
                                      preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(ok)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}

extension StartViewController {
    private func goToMain()  {
        guard let vc = UIStoryboard(name: StoryBoard.main.name, bundle: nil).instantiateViewController(withIdentifier: MainViewController.identifier) as? MainViewController
        else { return }
        vc.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.present(vc, animated: true)
        }
    }
    
    private func goToWalkthroughVC() {
        guard let vc = UIStoryboard(name: StoryBoard.start.name, bundle: nil).instantiateViewController(withIdentifier: WalkthroughViewController.identifier) as? WalkthroughViewController
        else { return }
        vc.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.present(vc, animated: true)
        }
    }
}
