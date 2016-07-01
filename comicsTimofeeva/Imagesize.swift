//
//  Imagesize.swift
//  comicsTimofeeva
//
//  Created by user on 13.06.16.
//  Copyright © 2016 itransition. All rights reserved.
//

import UIKit
import Social
import SwiftyDropbox


class Imagesize: UIViewController , UIScrollViewDelegate {
    
    
    
    @IBAction func Dropboxi (sender: AnyObject) {
        
        Dropbox.authorizeFromController(self)
        
    }
    

    @IBOutlet weak var img: UIImageView!
  
  
      @IBAction func Cancel(sender: AnyObject) {
          self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    var image = UIImage()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
//self.img.image = self.image
   
    
    }
  
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    let totalPages = 9
    

    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        configureScrollView()
        configurePageControl()
        
            
            // Verify user is logged into Dropbox
            if let client = Dropbox.authorizedClient {
                
                // Get the current user's account info
                client.users.getCurrentAccount().response { response, error in
                    print("*** Get current account ***")
                    if let account = response {
                        print("Hello \(account.name.givenName)!")
                    } else {
                        print(error!)
                    }
                }
                
                // List folder
                client.files.listFolder(path: "").response { response, error in
                    print("*** List folder ***")
                    if let result = response {
                        print("Folder contents:")
                        for entry in result.entries {
                            print(entry.name)
                        }
                    } else {
                        print(error!)
                    }
                }
                
                // Upload a file
                let fileData = "Hello!".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                client.files.upload(path: "/hello.txt", body: fileData!).response { response, error in
                    if let metadata = response {
                        print("*** Upload file ****")
                        print("Uploaded file name: \(metadata.name)")
                        print("Uploaded file revision: \(metadata.rev)")
                        
                        // Get file (or folder) metadata
                        client.files.getMetadata(path: "/hello.txt").response { response, error in
                            print("*** Get file metadata ***")
                            if let metadata = response {
                                if let file = metadata as? Files.FileMetadata {
                                    print("This is a file with path: \(file.pathLower)")
                                    print("File size: \(file.size)")
                                } else if let folder = metadata as? Files.FolderMetadata {
                                    print("This is a folder with path: \(folder.pathLower)")
                                }
                            } else {
                                print(error!)
                            }
                        }
                        
                        // Download a file
                        
                        let destination : (NSURL, NSHTTPURLResponse) -> NSURL = { temporaryURL, response in
                            let fileManager = NSFileManager.defaultManager()
                            let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
                            // generate a unique name for this file in case we've seen it before
                            let UUID = NSUUID().UUIDString
                            let pathComponent = "\(UUID)-\(response.suggestedFilename!)"
                            return directoryURL.URLByAppendingPathComponent(pathComponent)
                        }
                        
                        client.files.download(path: "/hello.txt", destination: destination).response { response, error in
                            if let (metadata, url) = response {
                                print("*** Download file ***")
                                let data = NSData(contentsOfURL: url)
                                print("Downloaded file name: \(metadata.name)")
                                print("Downloaded file url: \(url)")
                                print("Downloaded file data: \(data)")
                            } else {
                                print(error!)
                            }
                        }
                        
                    } else {
                        print(error!)
                    }
                }
            }
     
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    // MARK: Custom method implementation
    
    func configureScrollView() {
        // Enable paging.
        scrollView.pagingEnabled = true
        
        // Set the following flag values.
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        
        // Set the scrollview content size.
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * CGFloat(totalPages), scrollView.frame.size.height)
        
        // Set self as the delegate of the scrollview.
        scrollView.delegate = self
        
        // Load the TestView view from the TestView.xib file and configure it properly.
        for i in 0 ..< totalPages {
            // Load the TestView view.
//            let testView = NSBundle.mainBundle().loadNibNamed("TestView", owner: self, options: nil)[0] as! UIView
            let testView = UIImageView()
            testView.image = self.image
//            // Set its frame and the background color.
            testView.frame = CGRectMake(CGFloat(i) * scrollView.frame.size.width , 0 , scrollView.frame.size.width, scrollView.frame.size.height)
//            testView.backgroundColor = sampleBGColors[i]
//            
//            // Set the proper message to the test view's label.
//            let label = testView.viewWithTag(1) as! UILabel
//            label.text = "Page #\(i + 1)"
            
            // Add the test view as a subview to the scrollview.
            
            scrollView.addSubview(testView)
        }
    }
    
    
    func configurePageControl() {
        // Set the total pages to the page control.
        pageControl.numberOfPages = totalPages
        
        // Set the initial page.
        pageControl.currentPage = 0
    }
    
    
    // MARK: UIScrollViewDelegate method implementation
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Calculate the new page index depending on the content offset.
        let currentPage = floor(scrollView.contentOffset.x / UIScreen.mainScreen().bounds.size.width);
        
        // Set the new page index to the page control.
        pageControl.currentPage = Int(currentPage)
    }
    
    
    // MARK: IBAction method implementation
    
    @IBAction func changePage(sender: AnyObject) {
        // Calculate the frame that should scroll to based on the page control current page.
        var newFrame = scrollView.frame
        newFrame.origin.x = newFrame.size.width * CGFloat(pageControl.currentPage)
        scrollView.scrollRectToVisible(newFrame, animated: true)
        
    }

   
   

    @IBAction func facebook(sender: AnyObject) {
        
        let facebookShare = SLComposeViewController(forServiceType:SLServiceTypeFacebook)
        
       
        facebookShare.addImage(image)
        self.presentViewController(facebookShare, animated: true, completion: nil)
        
        
    }
 
    @IBAction func Twitter(sender: AnyObject) {
        
        let TwitterShare = SLComposeViewController(forServiceType:SLServiceTypeTwitter)
        TwitterShare.addImage(image)
        self.presentViewController(TwitterShare, animated: true, completion: nil)
   
       
        
    }
   
}
