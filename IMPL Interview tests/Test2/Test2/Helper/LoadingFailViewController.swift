//
//  LoadingFailViewController.swift
//  Test2
//
//  Created by Be More on 5/16/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import UIKit

class LoadingFailView: UIView {
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Đã xảy ra lồi trong quá trình load dữ liệu"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    lazy var reloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Thử lại", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleReloadData(_:)), for: .touchUpInside)
        return button
    }()
    
    var buttonAction: (() -> Void)?
    
    @objc private func handleReloadData(_ sender: UIButton) {
        buttonAction?()
    }
    
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpViews()
    }
    
    func setErrorMessage(errorMessage: String) {
        self.titleLabel.text = errorMessage
    }
    
    private func setUpViews() {
        self.backgroundColor = .white
        self.isHidden = true
        // set up content view
        self.addSubview(self.contentView)
        self.addVisualFormatConstraints(format: "H:|-15-[v0]-15-|", views: self.contentView)
        self.contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        // set up label constraints
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addVisualFormatConstraints(format: "H:|[v0]|", views: self.titleLabel)
        
        // set up button constraints
        self.contentView.addSubview(self.reloadButton)
        self.addVisualFormatConstraints(format: "H:|[v0]|", views: self.reloadButton)
        self.contentView.addVisualFormatConstraints(format: "V:|[v0][v1(40)]|", views: self.titleLabel, self.reloadButton)
    }
}
