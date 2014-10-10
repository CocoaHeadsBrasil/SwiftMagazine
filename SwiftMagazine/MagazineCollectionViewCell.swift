//
//  MagazineCollectionViewCell.swift
//  SwiftMagazine
//
//  Created by Heberti Almeida on 22/09/14.
//  Copyright (c) 2014 CocoaHeads Brasil. All rights reserved.
//

import UIKit

class MagazineCollectionViewCell: UICollectionViewCell {
    
    var cover: UIImageView!
    var title: UILabel!
    var subTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Cover Image
        cover = UIImageView()
        cover.frame.size = CGSize(width: 160, height: 210)
        cover.backgroundColor = UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1)
        contentView.addSubview(cover)
        
        // Title
        title = UILabel(frame: CGRectMake(0, cover.frame.size.height+18, 160, 20))
        title.font = CocoaFonts().latoRegularOfSize(17)
        title.textAlignment = NSTextAlignment.Center
        contentView.addSubview(title)
        
        // SubTitle
        subTitle = UILabel(frame: CGRectMake(0, title.frame.size.height+title.frame.origin.y+6, 160, 20))
        subTitle.font = CocoaFonts().latoLightOfSize(14)
        subTitle.textAlignment = NSTextAlignment.Center
        contentView.addSubview(subTitle)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
