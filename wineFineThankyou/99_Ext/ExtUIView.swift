//
//  ExtUIView.swift
//  wineFindThankyou
//
//  Created by mun on 2022/01/25.
//

import Foundation
import UIKit

class TopView: UIView {
    var titleLabel: UILabel?
    var leftButton: UIButton?
    var rightButton: UIButton?
}

struct StoreContent {
    let img = UIImageView()
    let label = UILabel()
    let btn = UIButton()
    var btnAction : (() -> Void)?
}

class StoreButtonsView: UIView {
    var left: StoreContent?
    var middle: StoreContent?
    var right: StoreContent?
}

func setTopView(_ view: UIView, height: CGFloat) -> TopView {
    let topView = TopView()
    let titleLabel = UILabel()
    let leftBtn = UIButton()
    let rightBtn = UIButton()
    
    topView.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    leftBtn.translatesAutoresizingMaskIntoConstraints = false
    rightBtn.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(topView)
    topView.addSubview(titleLabel)
    topView.addSubview(leftBtn)
    topView.addSubview(rightBtn)
    
    NSLayoutConstraint.activate([
        view.topAnchor.constraint(equalTo: view.topAnchor),
        view.leftAnchor.constraint(equalTo: view.leftAnchor),
        view.rightAnchor.constraint(equalTo: view.rightAnchor),
        view.heightAnchor.constraint(equalToConstant: 43),
        
        view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: topView.topAnchor),
        view.safeAreaLayoutGuide.leftAnchor.constraint(equalTo: topView.leftAnchor),
        view.safeAreaLayoutGuide.rightAnchor.constraint(equalTo: topView.rightAnchor),
        topView.heightAnchor.constraint(equalToConstant: 44),
        
        titleLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
        titleLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
        
        leftBtn.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 18),
        leftBtn.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
        leftBtn.widthAnchor.constraint(equalToConstant: 24),
        leftBtn.heightAnchor.constraint(equalToConstant: 24),
        
        rightBtn.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: 18),
        rightBtn.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
        rightBtn.widthAnchor.constraint(equalToConstant: 24),
        rightBtn.heightAnchor.constraint(equalToConstant: 24)
    ])
    
    topView.backgroundColor = Theme.white.color
    topView.titleLabel = titleLabel
    topView.titleLabel?.textColor = Theme.black.color
    topView.leftButton = leftBtn
    topView.rightButton = rightBtn
    
    return topView
}

func setBackground(superView: UIView) -> UIView {
    let backgroundView = UIView()
    superView.addSubview(backgroundView)
    backgroundView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        backgroundView.topAnchor.constraint(equalTo: superView.topAnchor),
        backgroundView.leftAnchor.constraint(equalTo: superView.leftAnchor),
        backgroundView.rightAnchor.constraint(equalTo: superView.rightAnchor),
        backgroundView.bottomAnchor.constraint(equalTo: superView.bottomAnchor),
    ])
    backgroundView.backgroundColor = Theme.black.color.withAlphaComponent(0.5)
    
    return backgroundView
}

func setStoreButtonView(superView: UIView, _ above: UIView) -> StoreButtonsView {
    let storeContentsView = StoreButtonsView()
    superView.addSubview(storeContentsView)
    storeContentsView.backgroundColor = Theme.gray.color
    let favorites = StoreContent()
    let maps = StoreContent()
    let adds = StoreContent()
    
    storeContentsView.translatesAutoresizingMaskIntoConstraints = false
    [favorites, maps, adds].forEach {
        storeContentsView.addSubview($0.btn)
        $0.btn.addSubview($0.img)
        $0.btn.addSubview($0.label)
        $0.img.translatesAutoresizingMaskIntoConstraints = false
        $0.label.translatesAutoresizingMaskIntoConstraints = false
        $0.btn.translatesAutoresizingMaskIntoConstraints = false
    }
    
    var layoutArray = [NSLayoutConstraint]()
    layoutArray.append(contentsOf: [storeContentsView.topAnchor.constraint(equalTo: above.bottomAnchor),
                                    storeContentsView.leftAnchor.constraint(equalTo: superView.leftAnchor),
                                    storeContentsView.rightAnchor.constraint(equalTo: superView.rightAnchor),
                                    storeContentsView.heightAnchor.constraint(equalToConstant: 61)])
    [favorites, maps, adds].forEach{
        layoutArray.append(contentsOf: [
            $0.btn.topAnchor.constraint(equalTo: storeContentsView.topAnchor, constant: 1),
            $0.btn.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3 - 1),
            $0.btn.bottomAnchor.constraint(equalTo: storeContentsView.bottomAnchor, constant: -4),
            
            $0.img.topAnchor.constraint(equalTo: $0.btn.topAnchor, constant: 7),
            $0.img.centerXAnchor.constraint(equalTo: $0.btn.centerXAnchor),
            $0.img.widthAnchor.constraint(equalToConstant: 24),
            $0.img.heightAnchor.constraint(equalToConstant: 24),

            $0.label.topAnchor.constraint(equalTo: $0.img.bottomAnchor),
            $0.label.centerXAnchor.constraint(equalTo: $0.btn.centerXAnchor),
            $0.label.bottomAnchor.constraint(equalTo: $0.btn.bottomAnchor)
        ])
        $0.img.isUserInteractionEnabled = false
        $0.label.isUserInteractionEnabled = false
    }
    layoutArray.append(favorites.btn.leftAnchor.constraint(equalTo: storeContentsView.leftAnchor))
    layoutArray.append(maps.btn.leftAnchor.constraint(equalTo: favorites.btn.rightAnchor, constant: 1))
    layoutArray.append(adds.btn.leftAnchor.constraint(equalTo: maps.btn.rightAnchor, constant: 1))
    NSLayoutConstraint.activate(layoutArray)
    
    [favorites, maps, adds].forEach {
        $0.btn.backgroundColor = Theme.white.color
        $0.label.textColor = Theme.black.color
    }
    
    favorites.label.text = "favorites"
    maps.label.text = "map"
    adds.label.text = "add"
    
    favorites.img.image = UIImage(named: "favorites")
    maps.img.image = UIImage(named: "findRoad")
    adds.img.image = UIImage(named: "addPhoto")
    
    storeContentsView.left = favorites
    storeContentsView.middle = maps
    storeContentsView.right = adds
    
    return storeContentsView
}

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}