//
//  PhotoInfo.swift
//  unsplashAPI
//
//  Created by Hanataba on 13/12/2562 BE.
//  Copyright © 2562 Hanataba. All rights reserved.
//

import UIKit

class PhotoInfoController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    var photo : Photo?
    
    override func viewWillAppear(_ animated: Bool) {
        guard let currentPhoto = photo else {
            return
        }
        
        imageView.image = currentPhoto.regular
        userLabel.text = currentPhoto.name
        descriptionLabel.text = currentPhoto.description
        likeLabel.text = currentPhoto.like.description
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}
