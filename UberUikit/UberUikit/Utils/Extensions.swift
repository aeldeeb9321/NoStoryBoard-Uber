//
//  Extensions.swift
//  UberUikit
//
//  Created by Ali Eldeeb on 9/25/22.
//

import UIKit

extension UIView{
    //Params are all the potential y and x axis anchors we could a UI element, we give them default values of nil because we dont need to add all of them all the time. If you dont specify padding we want to default it to 0. We didnt specify a height and width since Xcode can figure it out for us if not specified.
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat = 0, paddingLeft: CGFloat = 0, paddingBottom: CGFloat = 0, paddingRight: CGFloat = 0, width: CGFloat? = nil, height: CGFloat? = nil){
        translatesAutoresizingMaskIntoConstraints = false //this will be done for us automatically when calling this function. No longer have to type it out everytime
        if let top = top{
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left{
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom{
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right{
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let width = width{
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height{
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    //vertically center any UIelement we want inside any view we want
    func centerX(inView view: UIView){
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    //horizontally center any UIelement we want inside any view we want
    func centerY(inView view: UIView){
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
