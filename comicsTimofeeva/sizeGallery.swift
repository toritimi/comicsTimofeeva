//
//  sizeGallery.swift
//  comicsTimofeeva
//
//  Created by user on 13.06.16.
//  Copyright © 2016 itransition. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class sizeGallery: UICollectionViewController {

    
    
    @IBAction func buttonCancel(sender: AnyObject) {
      
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
       
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
           }

    
}
