//
//  UIViewControllerExtension.swift
//  Test2
//
//  Created by Be More on 5/16/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import UIKit

extension UIViewController {
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
