//
//  LibraryTableViewController.swift
//  SwiftMagazine
//
//  Created by Heberti Almeida on 18/09/14.
//  Copyright (c) 2014 CocoaHeads Brasil. All rights reserved.
//

import UIKit

let reuseFeatured = "CellFeatured"
let reuseMagazines = "CellMagazines"
let reuseCollectionItem = "CollectionReuse"
let collectionTag = 123

class LibraryTableViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Swift Magazine"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 1
    }
    
    //MARK: - UICollectionView Data Source
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case is FeaturedCollectionView:
            return 4
        default:
            return 10
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var reuseIdentifier: String!
        
        switch indexPath.section {
            case 0: reuseIdentifier = reuseFeatured
            default: reuseIdentifier = reuseMagazines
        }
        
        var reusableCell: AnyObject = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        switch indexPath.section {
            case 0: // Magazines collection
                var cell = reusableCell as FeaturedTableViewCell
                
                // CollectionView Frame
                var collectionFrame = cell.contentView.frame
                
                // CollectionView
                if cell.contentView.viewWithTag(collectionTag) == nil {
                    cell.collectionView = FeaturedCollectionView(frame: collectionFrame, index: indexPath.section) as FeaturedCollectionView
                    cell.collectionView.tag = collectionTag
                    cell.collectionView.dataSource = self
                    cell.collectionView.delegate = self
                    cell.collectionView.pagingEnabled = true
                    cell.contentView.addSubview(cell.collectionView)
                }
                
                // Configure the cell...
                cell.contentView.backgroundColor = UIColor(red: 1/255, green: 140/255, blue: 185/255, alpha: 1)
                cell.backgroundColor = UIColor.clearColor()
                return cell
            
            default: // Featured cell slider
                var cell = reusableCell as MagazineTableViewCell
                cell.title.text = "Category #\(indexPath.section)"
                
                // CollectionView Frame
                var gap: CGFloat = 52
                var collectionFrame = cell.contentView.frame
                collectionFrame.size.height -= gap
                collectionFrame.origin.y = gap
                
                // CollectionView
                if cell.contentView.viewWithTag(collectionTag) == nil {
                    cell.collectionView = MagazineCollectionView(frame: collectionFrame, index: indexPath.section) as MagazineCollectionView
                    cell.collectionView.tag = collectionTag
                    cell.collectionView.dataSource = self
                    cell.collectionView.delegate = self
                    cell.contentView.addSubview(cell.collectionView)
                }
                
                // Configure the cell...
                var floatIndex = CGFloat(indexPath.section)
                cell.contentView.backgroundColor = UIColor(white: floatIndex/255, alpha: floatIndex*0.02)
                cell.backgroundColor = UIColor.clearColor()
                return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch indexPath.section {
            case 0:
                return 320
            default:
                return 430
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView is FeaturedCollectionView {
            var cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseCollectionItem, forIndexPath: indexPath) as FeaturedCollectionViewCell
            cell.backgroundColor = getRandomColor()
            
            return cell
        } else {
            var cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseCollectionItem, forIndexPath: indexPath) as MagazineCollectionViewCell
            
            cell.title.text = "Magazine name"
            cell.subTitle.text = "January 2015"
            
            return cell
        }
    }
    
    //MARK: - UICollectionView Delegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        switch collectionView {
        case is FeaturedCollectionView:
            var collectionView = collectionView as FeaturedCollectionView
            println("Featured: \(collectionView.index) Item: \(indexPath.item)")
        
        default:
            var collectionView = collectionView as MagazineCollectionView
            println("Magazine: \(collectionView.index) Item: \(indexPath.item)")
        }
    }
    
    //MARK: - Random Golor
    
    func getRandomColor() -> UIColor {
        var randomRed:CGFloat = CGFloat(drand48())
        var randomGreen:CGFloat = CGFloat(drand48())
        var randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
}
