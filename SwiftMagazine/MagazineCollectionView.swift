//
//  MagazineCollectionView.swift
//  SwiftMagazine
//
//  Created by Heberti Almeida on 18/09/14.
//  Copyright (c) 2014 CocoaHeads Brasil. All rights reserved.
//

import UIKit

class MagazineCollectionView: UICollectionView {
    
    var index: Int!
    
    init(frame: CGRect, index: Int) {
        
        self.index = index
        
        // Layout
        var layout = SpringyFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: 160, height: 265)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        
        // Init
        super.init(frame: frame, collectionViewLayout: layout)
        
        // Custom collection
        self.registerClass(MagazineCollectionViewCell.self, forCellWithReuseIdentifier: reuseCollectionItem)
        self.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = UIColor.clearColor()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}