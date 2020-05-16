//
//  ScreenTwoViewController.swift
//  Test1
//
//  Created by Be More on 5/15/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import UIKit

protocol SetText: class {
    func setText(text: String)
}


class ScreenTwoViewController: UIViewController {
    
    static var count = 0
    
    var transferText: ((String)->())?
    
    weak var delegate: SetText?
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 6
        button.setTitle("Back", for: .normal)
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handlePopScreen(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Điền chuỗi kí tự bất kì"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    var contentViewCenterY: NSLayoutConstraint?
    private func setUpViews() {
        // content view constraints
        self.view.addSubview(self.contentView)
        
        self.view.addVisualFormatConstraints(format: "H:|-44-[v0]-44-|", views: self.contentView)
        self.contentViewCenterY =  self.contentView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        self.contentViewCenterY?.isActive = true
        self.contentView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        // button constraints
        self.contentView.addSubview(self.backButton)
        
        self.contentView.addVisualFormatConstraints(format: "H:|[v0]|", views: self.backButton)
        
        // text field constraints
        self.contentView.addSubview(self.textField)
        
        self.contentView.addVisualFormatConstraints(format: "H:|[v0]|", views: self.textField)
        self.contentView.addVisualFormatConstraints(format: "V:|[v0(45)][v1(45)]|", views: self.textField, self.backButton)
        
        hideKeyboardWhenTappedAround()
    }
    
    @objc private func handlePopScreen(_ sender: UIButton) {
        guard let text = self.textField.text?.trimmingCharacters(in: .whitespaces) else { return }
        // transfer data using delegate and closure
        ScreenTwoViewController.count % 2 == 0 ? self.transferText?(text) : self.delegate?.setText(text: text)
        self.navigationController?.popViewController(animated: true)
        ScreenTwoViewController.count += 1
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc fileprivate func keyboardWillAppear(_ notification: Notification) {
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        let keyboardRectangle = keyboardFrame?.cgRectValue
        let keyboardHeight = keyboardRectangle?.height
        let durationNumber = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
        let duration = durationNumber?.doubleValue
        let keyboardCurveNumber = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let keyboardCurve = keyboardCurveNumber?.uintValue
        
        self.keyboardShow(keyboardHeight: keyboardHeight, duration: duration, keyboardCurve: keyboardCurve)
    }
    
    @objc fileprivate func keyboardWillDisappear(_ notification: Notification) {
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        let keyboardRectangle = keyboardFrame?.cgRectValue
        let keyboardHeight = keyboardRectangle?.height
        let durationNumber = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
        let duration = durationNumber?.doubleValue
        let keyboardCurveNumber = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let keyboardCurve = keyboardCurveNumber?.uintValue
        
        self.keyboardHide(keyboardHeight: keyboardHeight, duration: duration, keyboardCurve: keyboardCurve)
    }
    
    func keyboardShow(keyboardHeight: CGFloat?, duration: Double?, keyboardCurve: UInt?) {
        guard let keyBoardHeight = keyboardHeight else { return }
        let keyBoardMaxY = self.view.frame.height - keyBoardHeight
        let contentViewMaxY = self.contentView.frame.maxY
        if contentViewMaxY - keyBoardMaxY > 0 {
            self.contentViewCenterY?.constant =  -(contentViewMaxY - keyBoardMaxY)
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardHide(keyboardHeight: CGFloat?, duration: Double?, keyboardCurve: UInt?) {
        self.contentViewCenterY?.constant = 0
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.view.endEditing(true)
    }
}
