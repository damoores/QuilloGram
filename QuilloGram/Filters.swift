//
//  Filters.swift
//  QuilloGram
//
//  Created by Jeremy Moore on 6/21/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

import UIKit

typealias FiltersCompletion = (image: UIImage?) -> ()

class Filters {
    
    var original = UIImage()
    private var context = CIContext()
    
    static let shared = Filters()
    
    private init() {
        let options = [kCIContextWorkingColorSpace : NSNull()]
        let eAGLContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
        self.context = CIContext(EAGLContext: eAGLContext, options: options)
    }
    
    private func filter(name: String, image: UIImage, completion: FiltersCompletion) {
        NSOperationQueue().addOperationWithBlock {
            guard let filter = CIFilter(name: name) else { fatalError("Spelling error?")}
            
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            
            let options = [kCIContextWorkingColorSpace: NSNull()]
            let eAGContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
            let gPUContext = CIContext(EAGLContext: eAGContext, options: options)
            
            guard let outputImage = filter.outputImage else { fatalError("Error, no output image")}
            let cgImage = gPUContext.createCGImage(outputImage, fromRect: outputImage.extent)
            NSOperationQueue.mainQueue().addOperationWithBlock ({
                completion(image: UIImage(CGImage: cgImage))
            })
            
        }
    }
    
    func original(image: UIImage, completion: FiltersCompletion) {
        completion(image: self.original)
    }
    
    func vintage(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectTransfer", image: image, completion: completion)
    }
    
    func blackAndWhite(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectMono", image: image, completion: completion)
    }
    
    func chrome(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectChrome", image: image, completion: completion)
    }
    func blur(image: UIImage, completion: FiltersCompletion) {
        self.filter("CICircularWrap", image: image, completion: completion)
    }
    func skew(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPerspectiveTransform", image: image, completion: completion)
    }
}


