//
//  PhotoInfo.swift
//  showPhotosFromAPI
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
    @IBOutlet weak var ViewLabel: UILabel!
    @IBOutlet weak var downloadLabel: UILabel!
    
    
    var photo : Photo?
    
    override func viewWillAppear(_ animated: Bool) {
        guard let currentPhoto = photo else {
            return
        }
        imageView.image = currentPhoto.regular
        userLabel.text = currentPhoto.name
        descriptionLabel.text = currentPhoto.description
        likeLabel.text = addDecimal(number: currentPhoto.like)
        ViewLabel.text = addDecimal(number: currentPhoto.view)
        downloadLabel.text = addDecimal(number: currentPhoto.download)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func addDecimal(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let formattedNumber = numberFormatter.string(from: NSNumber(value:number))
        return formattedNumber!
    }
    
}
