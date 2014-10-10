//
//  CocoaFonts.swift
//  CocoaFonts
//
//  Created by Heberti Almeida on 27/08/14.
//  Copyright (c) 2014 CocoaFonts. All rights reserved.
//

import UIKit

class CocoaFonts: UIFont {
    internal override init() {
        super.init()
        
        // Register Fonts
        let paths = NSBundle.mainBundle().pathsForResourcesOfType("ttf", inDirectory: "")
        for path in paths {            
            let url = NSURL(fileURLWithPath: path as String)
            var errorRef: Unmanaged<CFError>?
            let succeeded = CTFontManagerRegisterFontsForURL(url, .Process, &errorRef)
            
            if (errorRef != nil) {
                let error = errorRef!.takeRetainedValue()
            }
        }
    }
    
    class func printFamilyNames() {
        for family: AnyObject in UIFont.familyNames() {
            println("\(family)")
            for font: AnyObject in UIFont.fontNamesForFamilyName(family as NSString) {
                println(" \(font)")
            }
            
        }
    }
}
