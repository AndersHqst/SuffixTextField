//
//  SuffixTextField.swift
//  suffixtextfield
//
//  Created by Anders Høst Kjærgaard on 23/03/2016.
//  Copyright © 2016 Hqst IT. All rights reserved.
//

import Foundation
import UIKit

public class SuffixTextField: UITextField {
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        clipsToBounds = false
    }
    
    // A suffix string that will appear just to the right of visible text
    public var suffix:String? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // A prefix string that will appear just to the left of visible text
    public var prefix:String? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // Color for the suffix, default to the same color as the text
    public var suffixTextColor:UIColor?

    // Color for the prefix, default to the same color as the text
    public var prefixTextColor:UIColor?
    
    // Fallback text color
    private let placeHolderTextColor = UIColor(red: 120/255.0, green: 120/255.0, blue: 120/255.0, alpha: 1)
    
    private func centerWithPrefix(offset: CGFloat) {
        self.layer.sublayerTransform = CATransform3DMakeTranslation(offset, 0, 0);
    }
    
    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)
        clipsToBounds = false
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
            let offset = (width + spacing) / 2
            let rect = CGRectMake(suffixXPosition + spacing + offset, top, width, height)
            
            // Draw it
            (suffix! as NSString).drawInRect(rect, withAttributes: attrs)
        }
        
        // Only prefix when we have a prefix and a text
        if (prefix ?? "").isEmpty == false && (text ?? "").isEmpty == false {
            
            // We use some handy methods on NSString
            let text = (self.text ?? "") as NSString
            
            // The x position of the prefix
            var prefixXPosition:CGFloat = 0
            
            // Spacing between prefix and text
            let spacing:CGFloat = 3.0
            
            // Font and color for the prefix
            let color = prefixTextColor ?? self.textColor ?? placeHolderTextColor
            let attrs:[String: AnyObject] = [NSFontAttributeName: self.font!, NSForegroundColorAttributeName: color]
            
            // Calc the x position of the prefix
            if textAlignment == .Center {
                let fieldWidth = frame.size.width
                let textWidth = text.sizeWithAttributes(attrs).width
                prefixXPosition = (fieldWidth / 2) - (textWidth / 2)
            } else if textAlignment == .Right {
                let fieldWidth = frame.size.width
                let textWidth = text.sizeWithAttributes(attrs).width
                prefixXPosition = fieldWidth - textWidth
            }
            
            prefixXPosition -= (prefix! as NSString).sizeWithAttributes(attrs).width
            prefixXPosition -= spacing
            
            // Calc the rect to draw the suffix in
            let height = text.sizeWithAttributes(attrs).height
            let verticalCenter = height / 2.0
            let top:CGFloat = frame.size.height / 2 - ceil(verticalCenter)
            let width = (prefix! as NSString).sizeWithAttributes(attrs).width
            let offset = (width + spacing) / 2
            let rect = CGRectMake(prefixXPosition + offset, top, width, height)
            
            // Draw it
            (prefix! as NSString).drawInRect(rect, withAttributes: attrs)
            centerWithPrefix(offset)
        } else {
            centerWithPrefix(0)
        }
    }
    
    @objc func textFieldDidChange(sender: AnyObject) {
        setNeedsDisplay()
    }
}