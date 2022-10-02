//
//  LocationInputView.swift
//  UberUikit
//
//  Created by Ali Eldeeb on 10/1/22.
//

import UIKit

protocol LocationInputViewDelegate: AnyObject{
    func dismissLocationInputView()
}
class LocationInputView: UIView {

    //MARK: - Properties
    weak var delegate: LocationInputViewDelegate?
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "baseline_arrow_back_black_36dp-1")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        return button
    }()
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addShadow()
        backgroundColor = .white
        addSubview(backButton)
        backButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 44, paddingLeft: 12,width: 24,height: 24)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleBackTapped(sender: UIButton){
        delegate?.dismissLocationInputView()
    }
}
