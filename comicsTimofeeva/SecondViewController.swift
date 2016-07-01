//
//  SecondViewController.swift
//  comicsTimofeeva
//
//  Created by user on 11.06.16.
//  Copyright © 2016 itransition. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var containerOfElements: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "dTjnnHe1")!)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cangeElementContainerHidden(segue: UIStoryboardSegue)  {
    
        print("GetSegue")
        let hand = segue.sourceViewController as! HandlingComicsController
        containerOfElements.hidden = hand.showElementsController
           
        
    }
}

