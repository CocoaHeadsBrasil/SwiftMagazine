//
//  SpringyFlowLayout.swift
//  SwiftMagazine
//
//  Created by Heberti Almeida on 23/09/14.
//  Copyright (c) 2014 CocoaHeads Brasil. All rights reserved.
//

import UIKit
import Foundation

let kLength = 0.3
let kDamping = 0.5
let kFrequence = 1.3
let kResistence = 1000

class SpringyFlowLayout: UICollectionViewFlowLayout {
    
    let dynamicAnimator: UIDynamicAnimator!
    var visibleIndexPathsSet: NSMutableSet!
    var latestDelta = CGFloat()
    
    override init() {
        super.init()
        
        self.scrollDirection = UICollectionViewScrollDirection.Horizontal;
        self.dynamicAnimator = UIDynamicAnimator(collectionViewLayout: self)
        self.visibleIndexPathsSet = NSMutableSet()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK - Layout
    
    override func prepareLayout() {
        super.prepareLayout()
        
        
        // Need to overflow our actual visible rect slightly to avoid flickering.
        var visibleRect = CGRectInset(self.collectionView!.bounds, -100, -100)
        var itemsInVisibleRectArray: NSArray = super.layoutAttributesForElementsInRect(visibleRect)!
        var itemsIndexPathsInVisibleRectSet: NSSet = NSSet(array: itemsInVisibleRectArray.valueForKey("indexPath") as [AnyObject])
        
        // Step 1: Remove any behaviours that are no longer visible.
        var noLongerVisibleBehaviours = (self.dynamicAnimator.behaviors as NSArray).filteredArrayUsingPredicate(NSPredicate(block: {behaviour, bindings in
            var currentlyVisible: Bool = itemsIndexPathsInVisibleRectSet.member((behaviour as UIAttachmentBehavior).items.first!.indexPath) != nil
            return !currentlyVisible
        }))
        
        for (index, obj) in enumerate(noLongerVisibleBehaviours) {
            self.dynamicAnimator.removeBehavior(obj as UIDynamicBehavior)
            self.visibleIndexPathsSet.removeObject((obj as UIAttachmentBehavior).items.first!.indexPath)
        }

        // Step 2: Add any newly visible behaviours.
        // A "newly visible" item is one that is in the itemsInVisibleRect(Set|Array) but not in the visibleIndexPathsSet
        var newlyVisibleItems = itemsInVisibleRectArray.filteredArrayUsingPredicate(NSPredicate(block: {item, bindings in
            var currentlyVisible: Bool = self.visibleIndexPathsSet.member(item.indexPath) != nil
            return !currentlyVisible
        }))

        var touchLocation: CGPoint = self.collectionView!.panGestureRecognizer.locationInView(self.collectionView)
        
        for (index, item) in enumerate(newlyVisibleItems) {
            var springBehaviour: UIAttachmentBehavior = UIAttachmentBehavior(item: item as UIDynamicItem, attachedToAnchor: item.center)
            
            springBehaviour.length = CGFloat(kLength)
            springBehaviour.damping = CGFloat(kDamping)
            springBehaviour.frequency = CGFloat(kFrequence)
            
            // If our touchLocation is not (0,0), we'll need to adjust our item's center "in flight"
            if (!CGPointEqualToPoint(CGPointZero, touchLocation)) {
                var yDistanceFromTouch = fabsf(Float(touchLocation.y - springBehaviour.anchorPoint.y))
                var xDistanceFromTouch = fabsf(Float(touchLocation.x - springBehaviour.anchorPoint.x))
                var scrollResistance = (yDistanceFromTouch + xDistanceFromTouch) / Float(kResistence)
                
                var item = springBehaviour.items.first as UICollectionViewLayoutAttributes
                var center = item.center
                
                if self.latestDelta < 0 {
                    center.x += max(self.latestDelta, self.latestDelta * CGFloat(scrollResistance))
                } else {
                    center.x += min(self.latestDelta, self.latestDelta * CGFloat(scrollResistance))
                }
                
                item.center = center
            }
            
            self.dynamicAnimator.addBehavior(springBehaviour)
            self.visibleIndexPathsSet.addObject(item.indexPath)
        }
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        return self.dynamicAnimator.itemsInRect(rect)
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        return self.dynamicAnimator.layoutAttributesForCellAtIndexPath(indexPath)
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        var scrollView = self.collectionView!
        var delta: CGFloat = newBounds.origin.x - scrollView.bounds.origin.x
        
        self.latestDelta = delta
        
        var touchLocation: CGPoint = self.collectionView!.panGestureRecognizer.locationInView(self.collectionView)
        
        for (index, springBehaviour) in enumerate(self.dynamicAnimator.behaviors) {
            var springBehav = (springBehaviour as UIAttachmentBehavior)
            var yDistanceFromTouch = fabsf(Float(touchLocation.y - springBehav.anchorPoint.y))
            var xDistanceFromTouch = fabsf(Float(touchLocation.x - springBehav.anchorPoint.x))
            var scrollResistance = (yDistanceFromTouch + xDistanceFromTouch) / Float(kResistence)
            
            var item = springBehav.items.first as UICollectionViewLayoutAttributes
            var center = item.center
            
            if self.latestDelta < 0 {
                center.x += max(self.latestDelta, self.latestDelta * CGFloat(scrollResistance))
            } else {
                center.x += min(self.latestDelta, self.latestDelta * CGFloat(scrollResistance))
            }
            
            item.center = center;
            
            self.dynamicAnimator.updateItemUsingCurrentState(item)
        }
        
        return false
    }
}
