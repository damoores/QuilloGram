//
//  Filters.swift
//  QuilloGram
//
//  Created by Jeremy Moore on 6/21/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

import UIKit

typealias FiltersCompletion = (theImage: UIImage?) -> ()

class Filters {
    
    static var original = UIImage()
    
    private class func filter(name: String, image: UIImage, completion: FiltersCompletion) {
        NSOperationQueue().addOperationWithBlock {
            guard let filter = CIFilter(name: name) else { fatalError("Spelling error?")}
            
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            
            let options = [kCIContextWorkingColorSpace: NSNull()]
            let eAGContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
            let gPUContext = CIContext(EAGLContext: eAGContext, options: options)
            
            guard let outputImage = filter.outputImage else { fatalError("Error, no output image")}
            let cgImage = gPUContext.createCGImage(outputImage, fromRect: outputImage.extent)
            NSOperationQueue.mainQueue().addOperationWithBlock ({
                completion(theImage: UIImage(CGImage: cgImage))
            })
            
        }
    }
    
    class func vintage(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectTransfer", image: image, completion: completion)
    }
    
    class func blackAndWhite(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectMono", image: image, completion: completion)
    }
    
    class func chrome(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectChrome", image: image, completion: completion)
    }  
}