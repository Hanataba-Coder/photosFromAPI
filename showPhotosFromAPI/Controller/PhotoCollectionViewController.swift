//
//  PhotoCollectionViewController.swift
//  showPhotosFromAPI
//
//  Created by Hanataba on 11/12/2562 BE.
//  Copyright © 2562 Hanataba. All rights reserved.
//

import UIKit


class PhotoCollectionViewController: UICollectionViewController {
    var photos : [Photo] = []
    let cellIden = "cellIden"
    let segueIden = "segueRef"
    var photoApi = PhotoAPI()
    var refreshControl = UIRefreshControl()
    let sectionInsets = UIEdgeInsets(top: 1.0,
                                     left: 2.0,
                                     bottom: 1.0,
                                     right: 2.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        collectionView.addSubview(refreshControl) // not required when using UITableViewController
        updateCollection()
        
    }
    
    //MARK: - event
    @objc func refresh(sender:AnyObject) {
       // Code to refresh table view
        updateCollection()
        refreshControl.endRefreshing()
    }
    
    func updateCollection() {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        collectionView.addSubview(activityIndicator)
        activityIndicator.frame = collectionView.bounds
        activityIndicator.startAnimating()
        
        photoApi.execute { (result) in
            activityIndicator.stopAnimating()
            self.photos = try! result.get().results
            try! print(result.get().results[0].download)
            self.collectionView.reloadData()
        }
    }
    
}

//MARK: - UICollectionViewDelegate and Segue
extension PhotoCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIden, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PhotoInfoController
        
        if let indexPath = collectionView.indexPathsForSelectedItems {
            destinationVC.photo = photos[indexPath[0].row]
        }
    }
}

//MARK: - UICollectionViewDataSource
extension PhotoCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("number of cells : \(photos.count)")
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIden, for: indexPath) as! PhotoCollectionViewCell
        let photo = photos[indexPath.row]
        cell.imageView.image = photo.thumbnail
        return cell
    }
}

extension PhotoCollectionViewController : UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: CGFloat((collectionView.frame.size.width / 3) - 20), height: CGFloat(100))
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}

