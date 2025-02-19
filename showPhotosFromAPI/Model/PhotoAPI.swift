//
//  PhotoAPI.swift
//  showPhotosFromAPI
//
//  Created by Hanataba on 11/12/2562 BE.
//  Copyright © 2562 Hanataba. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

private let apiKey = "a26c254d4498de64c13e1b27a16f4f4f11920efe3cdc290d3a72d8c313883db0"
private let url = "https://api.unsplash.com/photos/random?count=30&client_id=\(apiKey)"

class PhotoAPI{
    
    
    func execute(completion: @escaping (Result<PhotoResult, Error>) -> Void) {
        AF.request(url).response { (respone) in
            if let error = respone.error {
                DispatchQueue.main.async {
                    print(error)
                    completion(Result.failure(error))
                }
                return
            }
            
            guard let data = respone.data else {return}
            
            do{
                let json = try JSON(data: data)
                let photos : [Photo] =  json.compactMap { (String, JSON) in
                    
                    let description = (JSON["description"]).string ?? "null"
                    guard
                        let name = JSON["user"]["name"].string,
                        let like = JSON["likes"].int,
                        let view = JSON["views"].int,
                        let download = JSON["downloads"].int,
                        let thumbUrl = URL(string: "\(JSON["urls"]["thumb"])"),
                        let thumbImageData = try? Data(contentsOf: thumbUrl),
                        let regularUrl = URL(string: "\(JSON["urls"]["regular"])"),
                        let regularImageData = try? Data(contentsOf: regularUrl),
                        let userImageUrl = URL(string: "\(JSON["user"]["profile_image"]["medium"])"),
                        let userImageData = try? Data(contentsOf: userImageUrl)
                        else {
                            return nil
                    }
                    
                    let photo = Photo(name: name, description: description, like: like, view: view, download: download)
                    
                    if let thumbImage = UIImage(data: thumbImageData), let regularImage = UIImage(data: regularImageData), let userImage = UIImage(data: userImageData) {
                        photo.thumbnail = thumbImage
                        photo.regular = regularImage
                        photo.userImage = userImage
                    }
                
                    return photo
                }
                let photoResult = PhotoResult(results: photos)
                DispatchQueue.main.async {
                  completion(Result.success(photoResult))
                }
            }
            catch{
                print(error.localizedDescription)
            }
            
        }
    }
}
