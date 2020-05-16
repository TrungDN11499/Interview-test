//
//  Api.swift
//  Test2
//
//  Created by Be More on 5/16/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import Foundation
import SwiftyJSON

class Api {
    static let shared = Api()
    
    func getUserListData(pageNumber: Int, pageSize: Int, completion: @escaping (Bool, [UserListModel]?) -> ()) {
        
        var urlComponents = URLComponents(string: "https://5eba40143f971400169923ef.mockapi.io/person")!
        
        let param = [
            "page": pageNumber,
            "limit": pageSize
        ]
        
        var queryItems = [URLQueryItem]()
       
            for paramItem in param {
                let value = String(describing: paramItem.value)
                let urlQueryItem = URLQueryItem(name: paramItem.key, value: value)
                queryItems.append(urlQueryItem)
            }
        print(queryItems)
        
        urlComponents.queryItems = queryItems
        
        // Create request & set header
        let request = NSMutableURLRequest(url: urlComponents.url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            let httpUrlResponse = response as? HTTPURLResponse
            let statusCode = httpUrlResponse?.statusCode
            print(statusCode ?? 0)
            if error != nil {
                completion(false, nil)
            } else {
                guard let data = data else { completion(false, nil) ; return}
                let listJSONnData = JSON(data).arrayValue
                print(listJSONnData)
                var arrayResponse = [UserListModel]()
                listJSONnData.forEach {
                    arrayResponse.append(UserListModel($0))
                }
                completion(true, arrayResponse)
            }
        }.resume()
    }
}
