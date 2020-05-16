//
//  LoadingTableViewCell.swift
//  Test2
//
//  Created by Be More on 5/16/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import UIKit

class LoadingTableViewCell: BaseTBCell {
    
    let spinner: UIActivityIndicatorView = {
        let activitiyIndicator = UIActivityIndicatorView()
        activitiyIndicator.translatesAutoresizingMaskIntoConstraints = false
        activitiyIndicator.style = .gray
        return activitiyIndicator
    }()
    
    let noMoreDataLabel: UILabel = {
        let label = UILabel()
        label.text = "Không còn thêm dữ liệu"
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setUpViews() {
        super.setUpViews()
        self.backgroundColor = .clear
        
        self.addSubview(self.spinner)
        self.spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        // label constraint
        self.addSubview(self.noMoreDataLabel)
        self.noMoreDataLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.noMoreDataLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func setUpCell(hasMoreData: Bool) {
        self.spinner.isHidden = !hasMoreData
        self.noMoreDataLabel.isHidden = hasMoreData
    }
}
