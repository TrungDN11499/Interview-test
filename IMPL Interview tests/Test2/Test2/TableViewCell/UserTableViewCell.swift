//
//  UserTableViewCell.swift
//  Test2
//
//  Created by Be More on 5/16/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import UIKit

class UserTableViewCell: BaseTBCell {
    
    let viewContent: UIView = {
        let view = UIView()
        view.layer.shadowOffset = CGSize(width: 2, height: 1)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 2
        view.backgroundColor = .white
        return view
    }()
    
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()
    
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
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email"
        return label
    }()
    
    
    override func setUpViews() {
        super.setUpViews()
        self.backgroundColor = .clear
        // content view constraints
        self.addSubview(self.viewContent)
        self.addVisualFormatConstraints(format: "H:|-15-[v0]-15-|", views: self.viewContent)
        self.addVisualFormatConstraints(format: "V:|-5-[v0]-5-|", views: self.viewContent)
        
        // user image view constraints
        self.viewContent.addSubview(self.userImageView)
        self.viewContent.addVisualFormatConstraints(format: "H:|-5-[v0(60)]", views: self.userImageView)
        self.viewContent.addVisualFormatConstraints(format: "V:|-5-[v0(60)]-5-|", views: self.userImageView)
        
        // name label constraints
        self.viewContent.addSubview(self.nameLabel)
        self.nameLabel.topAnchor.constraint(equalTo: self.userImageView.topAnchor).isActive = true
        self.nameLabel.leftAnchor.constraint(equalTo: self.userImageView.rightAnchor, constant: 5).isActive = true
        self.nameLabel.rightAnchor.constraint(lessThanOrEqualTo: self.viewContent.rightAnchor, constant: -5).isActive = true
        
    
        // name label constraints
        self.viewContent.addSubview(self.emailLabel)
        self.emailLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 2).isActive = true
        self.emailLabel.leftAnchor.constraint(equalTo: self.userImageView.rightAnchor, constant: 5).isActive = true
        self.emailLabel.rightAnchor.constraint(lessThanOrEqualTo: self.viewContent.rightAnchor, constant: -5).isActive = true
        self.emailLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.viewContent.bottomAnchor).isActive = true
        
        DispatchQueue.main.async {
            self.viewContent.layer.cornerRadius = 5
            self.userImageView.layer.cornerRadius = self.userImageView.frame.width / 2
        }
    }
    
    func setData(data: UserListModel) {
        self.nameLabel.text = data.name
        self.emailLabel.text = data.email
        self.userImageView.loadImageUsingUrlString(urlString: data.avatar)
    }
}
