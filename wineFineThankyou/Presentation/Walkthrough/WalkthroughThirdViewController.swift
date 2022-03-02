//
//  WalkthroughThirdViewController.swift
//  WineFineThankU
//
//  Created by suding on 2022/03/01.
//

import UIKit

class WalkthroughThirdViewController: UIViewController {
    
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "Q. 3"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    lazy var QuestionLabel: UILabel = {
        let label = UILabel()
        label.text =
        """
        와인을 주로
        구입하는 이유는?
        """
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
   
    private var selectedFlag = false
    
    let stackView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.backgroundColor = .white
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    } ()
    
    let meButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("내가 마시기위해서", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 20
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        let action = UIAction { _ in
            button.layer.borderColor = UIColor.standardColor.cgColor
            button.setTitleColor(.standardColor, for: .normal)
            UserDefaults.standard.set("내가 마시기위해서", forKey: "third")
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    let partyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("모임과 파티를 위해서", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 20
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        let action = UIAction { _ in
            button.layer.borderColor = UIColor.standardColor.cgColor
            button.setTitleColor(.standardColor, for: .normal)
            UserDefaults.standard.set("모임과 파티를 위해서", forKey: "third")
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    let presentButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("선물하기 위해서", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 20
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        let action = UIAction { _ in
            button.layer.borderColor = UIColor.standardColor.cgColor
            button.setTitleColor(.standardColor, for: .normal)
            UserDefaults.standard.set("선물하기 위해서", forKey: "third")
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConfigure()
        setupUI()
    }
    
    private func setupUI() {
        numberLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(24)
        }
        
        QuestionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(numberLabel.snp.bottom).offset(28)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(QuestionLabel.snp.bottom).offset(40)
            make.height.equalTo(140)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupConfigure() {
        view.addSubview(numberLabel)
        view.addSubview(QuestionLabel)
        view.addSubview(stackView)
        stackView.addArrangedSubview(meButton)
        stackView.addArrangedSubview(partyButton)
        stackView.addArrangedSubview(presentButton)
    }
    
    private func setupButton() {
        
    }
}