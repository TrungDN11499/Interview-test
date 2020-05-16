//
//  UserListModel.swift
//  Test2
//
//  Created by Be More on 5/16/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import SwiftyJSON

class UserListModel {

    var id: String
    var name: String
    var avatar: String
    var email: String

    init(_ json: JSON) {
        id = json["id"].stringValue
        name = json["name"].stringValue
        avatar = json["avatar"].stringValue
        email = json["email"].stringValue
    }
    
}
