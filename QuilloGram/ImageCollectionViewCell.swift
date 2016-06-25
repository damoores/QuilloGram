//
//  ImageCollectionViewCell.swift
//  QuilloGram
//
//  Created by Jeremy Moore on 6/23/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var imageView: UIImageView!
    

    var post: Post? {
        didSet {
            self.imageView.image = post?.image
        }
    }
    
    class func identifier() -> String{
        return "ImageCollectionViewCell"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
}
