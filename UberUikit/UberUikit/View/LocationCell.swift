//
//  LocationCell.swift
//  UberUikit
//
//  Created by Ali Eldeeb on 10/3/22.
//

import UIKit

class LocationCell: UITableViewCell {

    //MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel().uiLabel(withText: "123 Main Street", font: UIFont.systemFont(ofSize: 14), textColor: .label)
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel().uiLabel(withText: "123 Main Street, Washington, DC", font: UIFont.systemFont(ofSize: 14), textColor: .lightGray)
        return label
    }()
    
    //MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //no distinct style when a cell is selected
        selectionStyle = .none
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel,addressLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        self.addSubview(stackView)
        stackView.centerY(inView: self, leftAnchor: self.leftAnchor, paddingLeft: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
