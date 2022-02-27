//
//  LeaveViewController.swift
//  wineFindThankyou
//
//  Created by suding on 2022/02/27.
//

import Foundation
import UIKit
import SnapKit

final class LeaveViewController: UIViewController {
    
    private lazy var alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 22
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text =
            """
            탈퇴 후 모든 정보는 삭제됩니다.
            정말 탈퇴하시겠어요?
            """
        label.textColor = .standardFont
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("아니요", for: .normal)
        button.setTitleColor(.standardColor,for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.backgroundColor = .white
        button.layer.cornerRadius = 1
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        let action = UIAction { _ in
            self.dismiss(animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원탈퇴", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.backgroundColor = .standardColor
        button.layer.cornerRadius = 10
        let action = UIAction { _ in
            let nextViewController = MyPageViewController()
            nextViewController.modalPresentationStyle = .overFullScreen
            self.present(nextViewController, animated: true)
            self.dismiss(animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }

    private func setupView() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(alertView)
        alertView.addSubview(titleLabel)
        alertView.addSubview(cancelButton)
        alertView.addSubview(logoutButton)
    }

    private func setupLayout() {
        alertView.snp.makeConstraints { make in
            make.width.equalTo(310)
            make.height.equalTo(194)
            make.centerY.centerX.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.centerX.equalToSuperview()
        }
    
        cancelButton.snp.makeConstraints { make in
            make.height.equalTo(127)
            make.width.equalTo(44)
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-24)
        }

        logoutButton.snp.makeConstraints { make in
            make.height.equalTo(127)
            make.width.equalTo(44)
            make.trailing.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-24)
        }
    }
}