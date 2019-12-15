//
//  Photo.swift
//  showPhotosFromAPI
//
//  Created by Hanataba on 12/12/2562 BE.
//  Copyright © 2562 Hanataba. All rights reserved.
//

import UIKit

class Photo  {
    var thumbnail: UIImage?
    var regular: UIImage?
    var userImage : UIImage?
    
    let name : String
    let description : String
    let like : Int
    let view : Int
    let download : Int
    
    init(name : String, description : String, like : Int, view : Int, download : Int) {
        self.name = name
        self.description = description
        self.like = like
        self.view = view
        self.download = download
    }
}
