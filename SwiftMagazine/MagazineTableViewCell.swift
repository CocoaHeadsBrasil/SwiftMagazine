//
//  MagazineTableViewCell.swift
//  SwiftMagazine
//
//  Created by Heberti Almeida on 22/09/14.
//  Copyright (c) 2014 CocoaHeads Brasil. All rights reserved.
//

import UIKit

class MagazineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    var collectionView: MagazineCollectionView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
