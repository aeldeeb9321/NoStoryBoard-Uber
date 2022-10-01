//
//  LocationInputActivationView.swift
//  UberUikit
//
//  Created by Ali Eldeeb on 10/1/22.
//

import UIKit

class LocationInputActivationView: UIView{
    //MARK: - Properties
    let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let placeHolderLabel: UILabel = { //in this closure we create the label, give its attributes, then return it.
        let label = UILabel().uiLabel(withText: "Where to?", font: UIFont(name: "Avenir-Light", size: 18), textColor: UIColor.darkGray)
        return label
    }()
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.55
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        //When the maskToBounds property is true, Core Animation creates an implicit clipping mask that matches the bounds of the layer and includes any corner radius effects. If a value for the mask property is also specified, the two masks are multiplied to get the final mask value. The default value of this property is false.

        
        addSubview(indicatorView)
        indicatorView.centerY(inView: self, leftAnchor: self.leftAnchor, paddingLeft: 16)
        indicatorView.setDimensions(height: 6, width: 6)
        
        addSubview(placeHolderLabel)
        placeHolderLabel.centerY(inView: self, leftAnchor: indicatorView.rightAnchor, paddingLeft: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
