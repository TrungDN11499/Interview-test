//
//  Api.swift
//  Test3
//
//  Created by Be More on 5/16/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import Foundation
import SwiftyJSON

class Api {
    static let shared = Api()
    
    func getUserData(completion: @escaping (Bool, String, [UserModel]?) -> Void) {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else { completion(false, "", nil); return }
        var userListData = [UserModel]()
        do{
            let jsonData = try NSData(contentsOfFile: path, options: .dataReadingMapped)
            let json = JSON(jsonData).arrayValue
            json.forEach {
                userListData.append(UserModel($0))
            }
            completion(true, path, userListData)
        } catch { print(error.localizedDescription); completion(false, "", nil)  }
    }
}
