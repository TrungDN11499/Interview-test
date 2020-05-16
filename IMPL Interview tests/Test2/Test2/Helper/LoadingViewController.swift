//
//  LoadingViewController.swift
//  Test2
//
//  Created by Be More on 5/16/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    let loadingActivity: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var isBlur: Bool = false
    var isBackGroundBlur: Bool {
         set {
            if newValue {
                self.alpha = 0.5
            } else {
                self.alpha = 1
            }
            self.isBlur = newValue
        } get {
            return self.isBlur
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUpViews() {
        self.backgroundColor = .white
        self.isHidden = true
        
        self.addSubview(self.loadingActivity)
        self.loadingActivity.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.loadingActivity.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.loadingActivity.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.loadingActivity.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.loadingActivity.startAnimating()
    }
    
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
}
