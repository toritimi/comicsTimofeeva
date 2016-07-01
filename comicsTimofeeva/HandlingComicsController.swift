//
//  HandlingComicsController.swift
//  comicsTimofeeva
//
//  Created by Mac on 29.06.16.
//  Copyright © 2016 itransition. All rights reserved.
//

import UIKit

class HandlingComicsController: UIViewController {
    var showElementsController = false
 var currentPageTemplate = 1
    var maxPagesTemplate = 1
    @IBAction func pageRightOrAddNewPage(sender: UIButton) {
        if(currentPageTemplate > maxPagesTemplate)
        {
            maxPagesTemplate += 1
        }
        print("nextSegues")
        currentPageTemplate += 1
        performSegueWithIdentifier("changeNextPage", sender: sender)
    }
    @IBAction func pageLeft(sender: UIButton) {
        if(currentPageTemplate > maxPagesTemplate)
        {
            maxPagesTemplate += 1
        }
        print("backSegues")
        currentPageTemplate -= 1
        performSegueWithIdentifier("changeBackPage", sender: sender)
    }
    @IBAction func saveComics(sender: UIButton) {
    }
    @IBAction func changeHiddenElementsGalery(sender: UIButton) {
        print("Send segue")
        if showElementsController == true{
            showElementsController = false
        }else{
            showElementsController = true
        }
        performSegueWithIdentifier("changeElementHiddenSegue", sender: sender)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
