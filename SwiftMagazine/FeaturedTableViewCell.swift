//
//  FeaturedTableViewCell.swift
//  SwiftMagazine
//
//  Created by Heberti Almeida on 29/09/14.
//  Copyright (c) 2014 CocoaHeads Brasil. All rights reserved.
//

import UIKit

class FeaturedTableViewCell: UITableViewCell {

    var collectionView: FeaturedCollectionView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
