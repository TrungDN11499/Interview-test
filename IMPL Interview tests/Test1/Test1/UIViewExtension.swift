//
//  UIViewExtension.swift
//  Test1
//
//  Created by Be More on 5/15/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import UIKit

extension UIView {
    func addVisualFormatConstraints(format: String, views: UIView...) {
        var viewDictionaries = [String: UIView]()
        
        for (key, view) in views.enumerated() {
            let key = "v\(key)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDictionaries[key] = view
        }
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDictionaries))
        
    }
    
    func fillSuperView() {
        self.superview?.addVisualFormatConstraints(format: "H:|[v0]|", views: self)
        self.superview?.addVisualFormatConstraints(format: "V:|[v0]|", views: self)
    }
}
