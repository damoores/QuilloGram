//
//  Color.swift
//  QuilloGram
//
//  Created by Jeremy Moore on 6/20/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

import UIKit

extension UIColor {
    
    func toUIColor(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor{
        let redValue = r/255
        let greenValue = g/255
        let blueValue = b/255
        
        let color = UIColor(
            red: redValue,
            green: greenValue,
            blue: blueValue,
            alpha: a)
        return color
    }

}
