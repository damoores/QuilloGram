//
//  FiltersPreviewViewControllerDelegate.swift
//  QuilloGram
//
//  Created by Jeremy Moore on 6/24/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

import UIKit

protocol FiltersPreviewViewControllerDelegate: class {
    func didFinishPickingImage (success: Bool, image: UIImage?) -> ()
}

