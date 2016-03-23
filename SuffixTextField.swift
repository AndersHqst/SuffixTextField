//
//  SuffixTextField.swift
//  suffixtextfield
//
//  Created by Anders Høst Kjærgaard on 23/03/2016.
//  Copyright © 2016 Hqst IT. All rights reserved.
//

import Foundation
import UIKit

class SuffixTextField: UITextField {
    
    // A suffix string that will appear just to the right of visible text
    var suffix:String?
    
    // Color for the suffix, default to the same color as the text
    var suffixTextColor:UIColor?
    
    // Fallback suffix text color
    private let placeHolderTextColor = UIColor(red: 120/255.0, green: 120/255.0, blue: 120/255.0, alpha: 1)
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        // Only draw suffix when we have a suffix and a text
        if (suffix ?? "").isEmpty == false && (text ?? "").isEmpty == false {
            
            // We use some handy methods on NSString
            let text = (self.text ?? "") as NSString
            
            // The x position of the suffix
            var suffixXPosition:CGFloat = 0
            
            // Spacing between suffix and text
            let spacing:CGFloat = 3.0
            
            // Font and color for the suffix
            let color = suffixTextColor ?? self.textColor ?? placeHolderTextColor
            let attrs:[String: AnyObject] = [NSFontAttributeName: self.font!, NSForegroundColorAttributeName: color]
            
            // Calc the x position of the suffix
            if textAlignment == .Center {
                let fieldWidth = frame.size.width
                let textWidth = text.sizeWithAttributes(attrs).width
                suffixXPosition = (fieldWidth / 2) + (textWidth / 2)
            } else {
                suffixXPosition = text.sizeWithAttributes(attrs).width
            }
            
            // Calc the rect to draw the suffix in
            let height = text.sizeWithAttributes(attrs).height
            let verticalCenter = height / 2.0
            let top:CGFloat = frame.size.height / 2 - ceil(verticalCenter)
            let width = (suffix! as NSString).sizeWithAttributes(attrs).width
            let rect = CGRectMake(suffixXPosition + spacing, top, width, height)
            
            // Draw it
            (suffix! as NSString).drawInRect(rect, withAttributes: attrs)
        }
    }
}