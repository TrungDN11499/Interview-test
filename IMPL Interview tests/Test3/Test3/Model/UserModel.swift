//
//  UserModel.swift
//  Test3
//
//  Created by Be More on 5/16/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserModel: Encodable {

    var createdAt: String
    var name: String
    var email: String
    var phone: String

    init(_ json: JSON) {
        createdAt = json["createdAt"].stringValue
        name = json["name"].stringValue
        email = json["email"].stringValue
        phone = json["phone"].stringValue
    }

    
    init(name: String, email: String, phone: String, createdAt: String) {
        self.createdAt = createdAt
        self.name = name
        self.email = email
        self.phone = phone
    }
    
    func toDictionary() -> [String: String] {
        return ["createdAt": createdAt, "name": name, "email": email, "phone": phone]
    }
}
