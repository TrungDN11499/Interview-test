//
//  UIViewControllerExtension.swift
//  Test3
//
//  Created by Be More on 5/16/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import UIKit

extension UIViewController {
    func addInputAccessoryForTextFields(textFields: [UITextField], dismissable: Bool = true, previousNextable: Bool = true) {
        for (index, textField) in textFields.enumerated() {
            let toolbar: UIToolbar = UIToolbar()
            toolbar.sizeToFit()
            
            var items = [UIBarButtonItem]()
            if previousNextable {
                let previousButton = UIBarButtonItem(image: #imageLiteral(resourceName: "back-chevron"), style: .plain, target: nil, action: nil)
                //                previousButton.width = 30
                if textField == textFields.first {
                    previousButton.isEnabled = false
                } else {
                    previousButton.target = textFields[index - 1]
                    previousButton.action = #selector(UITextField.becomeFirstResponder)
                }
                
                let nextButton = UIBarButtonItem(image: #imageLiteral(resourceName: "forward-chevron"), style: .plain, target: nil, action: nil)
                //                nextButton.width = 30
                if textField == textFields.last {
                    nextButton.isEnabled = false
                } else {
                    if textField.returnKeyType == .continue {
                        textField.addTarget(textFields[index+1], action: #selector(UITextField.becomeFirstResponder), for: .editingDidEndOnExit)
                    }
                    nextButton.target = textFields[index + 1]
                    nextButton.action = #selector(UITextField.becomeFirstResponder)
                }
                items.append(contentsOf: [previousButton, nextButton])
            }
            
            let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: view, action: #selector(UIView.endEditing))
            items.append(contentsOf: [spacer, doneButton])
            
            
            toolbar.setItems(items, animated: false)
            textField.inputAccessoryView = toolbar
        }
    }
    
    /// Hiển thị alert với 1 nút OK
    ///
    /// - Parameters:
    ///   - title: title của alert
    ///   - message: message của alert
    ///   - confirmTitle: Text hiển thị của nút ấn (Mặc định là OK)
    ///   - handler: Xử lý khi ấn vào nút
    func showAlert(title: String?,
                   message: String?,
                   confirmTitle: String = "OK",
                   handler: (() -> Void)? = nil) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        // Custom action
        let btnOK = UIAlertAction(title: confirmTitle, style: .cancel) { (_) in
            handler?()
        }
        alert.addAction(btnOK)

        self.present(alert, animated: true, completion: nil)
    }
}
