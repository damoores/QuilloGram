//
//  GalleryViewController.swift
//  QuilloGram
//
//  Created by Jeremy Moore on 6/23/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var datasource = [Post]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupGalleryViewController()
        self.setupCollectionView()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.setToolbarHidden(true, animated: true)
        self.update()
    }
        
    func setupGalleryViewController() {
        self.navigationItem.title = "Gallery"
    }
    
    func setupCollectionView() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(GalleryViewController.pinchedCollectionView(_:)))
        self.collectionView.addGestureRecognizer(pinchGesture)
        self.collectionView.collectionViewLayout = GalleryCustomFlowLayout(columns: 3)    }
    
    func pinchedCollectionView(sender: UIPinchGestureRecognizer) {
        
        let layout = self.collectionView.collectionViewLayout as! GalleryCustomFlowLayout
        var columns = layout.columns
        if sender.state == .Ended {
            if sender.scale > 1.0 {
                columns += 1
            }
            else if sender.scale < 1.0 {
                if columns > 1 {
                    columns -= 1
                }
            }
        }

        self.collectionView.setCollectionViewLayout(GalleryCustomFlowLayout(columns: columns), animated: true)
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
        
    func update() {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinner)
        
        API.shared.GET { (posts) -> () in
            if let posts = posts {
                self.datasource = posts
                self.navigationItem.rightBarButtonItem = nil
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension GalleryViewController
{
    func configureCellForIndexPath(indexPath: NSIndexPath) -> ImageCollectionViewCell {
        let imageCell = self.collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.identifier(), forIndexPath: indexPath) as! ImageCollectionViewCell
        imageCell.post = self.datasource[indexPath.row]
        return imageCell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return self.configureCellForIndexPath(indexPath)
    }
}
