//
//  FeaturedCollectionView.swift
//  SwiftMagazine
//
//  Created by Heberti Almeida on 29/09/14.
//  Copyright (c) 2014 CocoaHeads Brasil. All rights reserved.
//

import UIKit

class FeaturedCollectionView: UICollectionView {

    var index: Int!
    
    init(frame: CGRect, index: Int) {
        
        self.index = index
        
        // Layout
        var layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsZero
        layout.itemSize = CGSize(width: frame.width, height: frame.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal;
        
        // Init
        super.init(frame: frame, collectionViewLayout: layout)
        
        // Custom collection
        self.registerClass(FeaturedCollectionViewCell.self, forCellWithReuseIdentifier: reuseCollectionItem)
        self.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
