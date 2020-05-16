//
//  StringExtension.swift
//  Test3
//
//  Created by Be More on 5/16/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import Foundation

extension String {
    var isPhoneNumber: Bool { regex(regex: "^\\d{3}\\d{3}\\d{4}$") }
    
    func isValidName() -> Bool {
        if self.count >= 4 && self.count <= 20 {
            return true
        }
        return false
    }
    
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z]{1,}[A-Z0-9a-z._%+-]{0,}@[A-Za-z0-9]{1,}[A-Za-z0-9-]+(\\.[A-Za-z]{2,64}){1,2}"
        return regex(regex: emailRegEx)
    }
    
    func regex(regex: String) -> Bool {
        let stringTest = NSPredicate(format: "SELF MATCHES %@", regex)
        return stringTest.evaluate(with: self)
    }
}
