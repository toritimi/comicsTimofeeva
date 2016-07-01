//
//  Controller.swift
//  comicsTimofeeva
//
//  Created by user on 11.06.16.
//  Copyright © 2016 itransition. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SelectTemplateController: UICollectionViewController {
    var indexTemplate :Int?
    let images = [UIImage(named: "comics1")! ,UIImage(named: "comics2")!,UIImage(named: "comics3")!,UIImage(named: "comics4")!,UIImage(named: "comics5")!,UIImage(named: "comics6")!,UIImage(named: "comics7")!,UIImage(named: "comics8")!,UIImage(named: "comics9")!,UIImage(named: "comics10")!,UIImage(named: "comics11")!,UIImage(named: "comics12")!,UIImage(named: "comics14")!,UIImage(named: "comics15")!,UIImage(named: "comics16")!,UIImage(named: "comics17")!,UIImage(named: "comics18")!,UIImage(named: "Untitled-1")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//self.collectionView!.backgroundColor = UIColor (patternImage:UIImage(named:"marvel")!)
        let image = UIImage(named: "marvel")
        let imageView = UIImageView(image: image)
        collectionView!.backgroundView = imageView
        imageView.alpha = 0.8
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
       // self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

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
        return images.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        as! Templates
        
            cell.button.setBackgroundImage(images[indexPath.row], forState: .Normal)
             cell.button.setTitle("\(indexPath.row)", forState: .Normal)
                
        // Configure the cell
    
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
    }
    
    @IBAction func switchTempplate(sender: UIButton) {
        indexTemplate = Int(sender.currentTitle!)
        performSegueWithIdentifier("UnwindSegue", sender: sender)
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
