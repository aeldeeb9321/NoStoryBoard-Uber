//
//  AuthButton.swift
//  UberUikit
//
//  Created by Ali Eldeeb on 9/28/22.
//

import UIKit
//created a blueprint for what we want the button to look like, we subclassed UIButton to make a custom button so we dont need to copy and past for our signup page button. You can make a subclass or make a function, either works
class AuthButton: UIButton {
    //class already subclasses a UIButton so we dont need to instantiate a uiButton or use button for porperties
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
        backgroundColor = .mainBlueTint
        layer.cornerRadius = 5
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
