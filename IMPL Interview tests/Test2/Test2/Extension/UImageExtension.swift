//
//  UImageExtension.swift
//  Test2
//
//  Created by Be More on 5/16/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import UIKit

var cacheImage = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    
    func loadImageUsingUrlString(urlString: String) {
        let url = URL(string: urlString)!
        self.image = nil
        if let cacheImage = cacheImage.object(forKey: urlString  as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, respones, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            DispatchQueue.main.async {
                
                guard let data = data else {return}
                if let downloadedImage = UIImage(data: data)
                {
                    self.image = downloadedImage
                    cacheImage.setObject(downloadedImage, forKey: urlString as AnyObject)
                }
            }
        }).resume()
    }
}
