//
//  GalleryCustomFlowLayout.swift
//  QuilloGram
//
//  Created by Jeremy Moore on 6/23/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

import UIKit

class GalleryCustomFlowLayout: UICollectionViewFlowLayout
{
    var columns: Int
    let spacing: CGFloat = 1.0
    
    init(columns: Int) {
        self.columns = columns
        super.init()
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.minimumLineSpacing = self.spacing
        self.minimumInteritemSpacing = self.spacing
        self.itemSize = CGSizeMake(self.itemWidth(), self.itemWidth() * 2.0)
    }
    
    
    func screenWidth() -> CGFloat {
        return CGRectGetWidth(UIScreen.mainScreen().bounds)
    }
    
    func itemWidth() -> CGFloat {
        let width = self.screenWidth()
        let availableWidth = width - (CGFloat(self.columns) * self.spacing)
        return availableWidth / CGFloat(self.columns)
    }
}
