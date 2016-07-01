//
//  ElementsTemplateController.swift
//  comicsTimofeeva
//
//  Created by user on 22.06.16.
//  Copyright © 2016 itransition. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ElementsTemplateController: UICollectionViewController {
     var indexElement :Int?
    
    let imagesElement = [UIImage(named: "444")!,UIImage(named: "555")!,UIImage(named: "666")!,UIImage(named: "333")!,UIImage(named: "3")!,UIImage(named: "4")!,UIImage(named: "5")!,UIImage(named: "7")!,UIImage(named: "8")!,UIImage(named: "111")!,UIImage(named: "222")!,UIImage(named: "897")!,UIImage(named: "bam")!,UIImage(named: "batman")!,UIImage(named: "crunch")!,UIImage(named: "lips")!,UIImage(named: "love")!,UIImage(named: "mask")!,UIImage(named: "mdm")!,UIImage(named: "ouch")!,UIImage(named: "sls")!,UIImage(named: "smail")!,UIImage(named: "star")!]


    override func viewDidLoad() {
        super.viewDidLoad()
self.collectionView!.backgroundColor = UIColor (patternImage:UIImage(named:"marvel1")!)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imagesElement.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        as! Elements
        // Configure the cell
        cell.Element.setBackgroundImage(imagesElement[indexPath.row], forState: .Normal)
        cell.Element.setTitle("\(indexPath.row)", forState: .Normal)
    
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
    }
    
    @IBAction func switchElement(sender: UIButton) {
        indexElement = Int(sender.currentTitle!)
        performSegueWithIdentifier("ElementSegue", sender: sender)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
