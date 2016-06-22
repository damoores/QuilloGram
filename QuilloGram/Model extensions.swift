//
//  Model extensions.swift
//  QuilloGram
//
//  Created by Jeremy Moore on 6/21/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

import UIKit
import CloudKit

enum PostError : ErrorType {
    case WritingImage
    case CreateCKRecord
}

extension Post {
    
    class func recordWith(post: Post) throws -> CKRecord? {
        
        let imageURL = NSURL.imageURL()
        
        guard let data = UIImageJPEGRepresentation(post.image, 0.75) else { throw PostError.WritingImage}
        
        let saved = data.writeToURL(imageURL, atomically: true)
        
        if saved {
            let asset = CKAsset(fileURL: imageURL)
            let record = CKRecord(recordType: "Post")
            record.setObject(asset, forKey: "image")
            
            return record
            
        } else {
            throw PostError.CreateCKRecord
        }
    }
}


