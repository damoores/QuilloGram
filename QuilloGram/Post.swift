//
//  Post.swift
//  QuilloGram
//
//  Created by Jeremy Moore on 6/21/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

import UIKit

class Post {
    var image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
    
    convenience init() {
        self.init(image: UIImage())
    }
}
