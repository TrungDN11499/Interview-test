//
//  UserTableViewCell.swift
//  Test3
//
//  Created by Be More on 5/16/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import UIKit

class UserTableViewCell: BaseTBCell {

    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Email"
        return label
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "phone"
        return label
    }()
    
    override func setUpViews() {
        super.setUpViews()
        
        // name label constraint
        self.addSubview(self.nameLabel)
        self.addVisualFormatConstraints(format: "H:|-15-[v0]-15-|", views: self.nameLabel)
        self.nameLabel.setContentHuggingPriority(.defaultLow - 1, for: .vertical)
        self.nameLabel.setContentCompressionResistancePriority(.defaultHigh - 1, for: .vertical)
        
        // email label constraint
        self.addSubview(self.emailLabel)
        self.addVisualFormatConstraints(format: "H:|-15-[v0]-15-|", views: self.emailLabel)
        
        // phone label constraint
        self.addSubview(self.phoneLabel)
        self.addVisualFormatConstraints(format: "H:|-15-[v0]-15-|", views: self.phoneLabel)
        
        // vertical constraits
        self.addVisualFormatConstraints(format: "V:|-5-[v0]-5-[v1]-5-[v2]-5-|", views: self.nameLabel, self.emailLabel, self.phoneLabel)
    }
    
    func setData(data: UserModel) {
        self.nameLabel.text = "Name: " + data.name
        self.emailLabel.text = "Email: " + data.email
        self.phoneLabel.text = "Phone: " + data.phone
    }
}
