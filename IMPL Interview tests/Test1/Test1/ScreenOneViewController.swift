//
//  ScreenOneViewController.swift
//  Test1
//
//  Created by Be More on 5/15/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import UIKit

class ScreenOneViewController: UIViewController {
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 6
        button.setTitle("Next Screen", for: .normal)
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handlePushScreen(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc private func handlePushScreen(_ sender: UIButton) {
        let vc = ScreenTwoViewController()
        vc.delegate = self
        vc.transferText = {
            if !$0.isEmpty {
                // closure
                 self.textLabel.text = $0
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Lable"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUpViews()
    }
    
    private func setUpViews() {
        // content view constraints
        self.view.addSubview(self.contentView)
        
        self.view.addVisualFormatConstraints(format: "H:|-44-[v0]-44-|", views: self.contentView)
        self.contentView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.contentView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        // button constraints
        self.contentView.addSubview(self.nextButton)
        
        self.contentView.addVisualFormatConstraints(format: "H:|[v0]|", views: self.nextButton)
       
        
        // label constraints
        self.contentView.addSubview(self.textLabel)
        
        self.contentView.addVisualFormatConstraints(format: "H:|[v0]|", views: self.textLabel)
        
        // vertical content view content constraints
        self.contentView.addVisualFormatConstraints(format: "V:|[v0][v1(45)]|", views: self.textLabel, self.nextButton)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - SetText Delegate
extension ScreenOneViewController: SetText {
    func setText(text: String) {
        if !text.isEmpty {
            self.textLabel.text = text
        }
    }
}
