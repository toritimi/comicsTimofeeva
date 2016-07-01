
//
//  TemplateController.swift
//  ComicsSapego
//
//  Created by user on 6/12/16.
//  Copyright © 2016 w. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreImage
import MediaPlayer
import MobileCoreServices
import AVKit
import RealmSwift

class TemplateController: UIViewController,UIScrollViewDelegate, UIImagePickerControllerDelegate , UINavigationControllerDelegate , UITextViewDelegate{
    
   
    @IBOutlet weak var mainView: UIView!
    
    //var currentTag = 999
    var currentImage : UIImage!
    var imageViewArr = [UIImageView]()
    var scrollViewArr = [UIScrollView]()
    var indexTemplate = 999
    var numberAreasInTemplate = 0
    
    
    
   // var buttonsClearImageArr = [UIButton]()
    var imageTempArr = [UIImage]()
    var CurrentFilterForImageArr = [Int:Int]()
    var filtersOfImage = [Int:Array<UIImage?>]()
    var originalImageInImageView = [Int:UIImage]()
    let context = CIContext(options: nil)
    
    
    var videoViewArr = [AVPlayerViewController]()
    var urlOfVideo = [Int:AnyObject]()
    
    
    var imageViewOfElementsArr = [UIImageView]()
    var imageinElementArr = [UIImage]()
    var numberOfElements = 100
    var location = CGPoint(x: 0, y: 0)
   
    var longHeightImageArr = [Int:Bool]()
    
    var pagesArr = [CurrentTemplate]()
    
    let filters = ["CIPhotoEffectProcess","CIEdges", "CIHexagonalPixellate", "CIPhotoEffectFade", "CIPhotoEffectNoir","CIPhotoEffectTransfer", "CILinearToSRGBToneCurve", "CIColorPosterize", "CIUnsharpMask"]
    var _currentFilter = 0
    var currentFilter:Int{
        get{return _currentFilter}
        set{
            if(newValue > filters.count-1){
                _currentFilter = 0
            }else{
            if(newValue < 0 ){
                _currentFilter = filters.count-1
            }else{
            
                _currentFilter = newValue
                }
            }
            
        }
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "dTjnnHe")!)
        
        

        
        
    }
           
    
    func GetJsonFromFile(filename:String)->JSON{
        let file = NSBundle.mainBundle().pathForResource(filename, ofType: "json")
        let data = NSData(contentsOfFile: file!) as NSData!
        let json = JSON(data: data,options: NSJSONReadingOptions.MutableContainers,error: nil)
        return json
    }
    func ClearImageInTemplate(sender:UIButton)
    {
        let currentTag = (sender.tag)
        imageViewArr[currentTag].image = nil
        sender.removeFromSuperview()
    }
    
    func importPictureOrChangeFilter(recognizer:UITapGestureRecognizer) {
        
        let currentTag = recognizer.view!.tag
        if imageViewArr[currentTag].image == nil{
        let picker = UIImagePickerController()
        picker.view.tag = currentTag
        picker.allowsEditing = true
        picker.delegate = self
        picker.sourceType = .SavedPhotosAlbum
        picker.mediaTypes = ["public.image"]
        if indexTemplate < 12{
        picker.mediaTypes.append("public.movie")
        }
        presentViewController(picker, animated: true, completion: nil)
        }
        else{
            ChangeNextFilter(currentTag)
        }
    }
    func createDelImageButton(currentTag :Int){
        let x = scrollViewArr[currentTag].frame.origin.x
        let y = scrollViewArr[currentTag].frame.origin.y
        let buttonClearFilter = UIButton()
        buttonClearFilter.tag = currentTag
        buttonClearFilter.frame = CGRectMake(10 + x, 10 + y, 30, 30)
        buttonClearFilter.addTarget(self, action: "ClearImageInTemplate:", forControlEvents: .TouchUpInside)
        buttonClearFilter.setImage(UIImage(named: "90"), forState: .Normal)
        
        
        view.addSubview(buttonClearFilter)

    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        
        let currentTag = picker.view.tag
        CurrentFilterForImageArr[currentTag] = 0
        
        filtersOfImage[currentTag] = [UIImage]()
        
        for _ in 0 ... filters.count{
            filtersOfImage[currentTag]?.append(nil)
        }
        
        
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        if mediaType == kUTTypeImage {
        
        
        var newImage: UIImage
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            newImage = possibleImage
        }else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            newImage = possibleImage
        }else{
            return
        }
        
        currentImage = newImage
        originalImageInImageView[currentTag] = currentImage
        imageViewArr[currentTag].image = currentImage
        scrollViewArr[currentTag].contentSize = newImage.size
        let scrollViewFrame = scrollViewArr[currentTag].frame
        let scaleWidth = scrollViewFrame.size.width / currentImage.size.width
            print("scaleWidth:\(scaleWidth)")
        let scaleHeight = scrollViewFrame.size.height / currentImage.size.height
            print("scaleHeight:\(scaleHeight)")
        let k = max(scaleHeight, scaleWidth)
       

        
           
            
       
            
        scrollViewArr[currentTag].minimumZoomScale = 1
            
        scrollViewArr[currentTag].maximumZoomScale = 10
           scrollViewArr[currentTag].zoomScale = 1
            
            imageViewArr[currentTag].frame = CGRectMake(0, 0, currentImage.size.width * k, currentImage.size.height * k)
            scrollViewArr[currentTag].setZoomScale(1, animated: false)
            
        centerScrollViewContents(currentTag)
            createDelImageButton(currentTag)
                    dismissViewControllerAnimated(true, completion: nil)
        }
        if mediaType == kUTTypeMovie{
            urlOfVideo[currentTag] = (info[UIImagePickerControllerMediaURL])
           let player = AVPlayer (URL: urlOfVideo[currentTag] as! NSURL )
           
           videoViewArr[currentTag].player = player
           changeImageViewToVideoPlayerInArea(currentTag,isSetVideo: true)
             dismissViewControllerAnimated(true, completion: nil)
           createClearVideoButton(currentTag)
            //player.play()
            
            
        }
        
    }
    
    func changeImageViewToVideoPlayerInArea(currentTag:Int, isSetVideo:Bool){
        videoViewArr[currentTag].view.hidden = !isSetVideo
        scrollViewArr[currentTag].hidden = isSetVideo
    }
   
    
    func createClearVideoButton(currentTag:Int){
        
        let buttonClearVideo = UIButton()
        buttonClearVideo.tag = currentTag
        let x = scrollViewArr[currentTag].frame.origin.x
        let y = scrollViewArr[currentTag].frame.origin.y
        buttonClearVideo.frame = CGRectMake(x+10 , y+10 , 30, 30)
        buttonClearVideo.addTarget(self, action: "clearVideo:", forControlEvents: .TouchUpInside)
        buttonClearVideo.setImage(UIImage(named: "90"), forState: .Normal)
        
        view.addSubview(buttonClearVideo)

     }
    func clearVideo(sender:AnyObject){
        let currentTag = sender.tag
        changeImageViewToVideoPlayerInArea(currentTag, isSetVideo: false)
        videoViewArr[currentTag].player = nil
        
        sender.removeFromSuperview()
    }
    
    func centerScrollViewContents(currentTag : Int){
        let boundeSize = scrollViewArr[currentTag].bounds.size
        var contentsFrame = imageViewArr[currentTag].frame
        if contentsFrame.size.width < boundeSize.width{
            contentsFrame.origin.x = (boundeSize.width -  contentsFrame.size.width) / 2
        }else{
            contentsFrame.origin.x = 0
        }
        if contentsFrame.size.height < boundeSize.height{
            contentsFrame.origin.y = (boundeSize.height - contentsFrame.size.height) / 2
        }else{
            contentsFrame.origin.y = 0
        }
        imageViewArr[currentTag].frame = contentsFrame

        
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        
        
                centerScrollViewContents(scrollView.tag)
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
       
        
        

        return imageViewArr[scrollView.tag]
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func setParams (segue : UIStoryboardSegue){
        
        let TempVC = segue.sourceViewController as? SelectTemplateController
        
        indexTemplate = (TempVC?.indexTemplate)!
        imageTempArr = (TempVC?.images)!
        setTemplateFromJson()
        
    }
    @IBAction func setElement (segue : UIStoryboardSegue){
        
        if indexTemplate < 999 {
        let ElementsVC = segue.sourceViewController as? ElementsTemplateController
        
        let indexElement = (ElementsVC!.indexElement)!
        imageinElementArr = (ElementsVC?.imagesElement)!
        setElements(indexElement)
        }
    }

    func setElements (indexElement:Int){
        print("Add Element")
        let imageElementView = UIImageView()
        imageElementView.frame = CGRectMake(20, 20, 130,130 )
        imageElementView.image = imageinElementArr[indexElement]
        
        imageElementView.tag = numberOfElements
        imageElementView.userInteractionEnabled = true
        imageViewOfElementsArr.append(imageElementView)
        if  [4,8,10,11,13,18,22].contains(indexElement){
            longHeightImageArr[numberOfElements] = true
        }
        else{
            longHeightImageArr[numberOfElements] = false
        }
        numberOfElements += 1
        
       
        
        
        
        
        let textView = UITextView()
        //textfield.addSubview(imageElementView)
    
        textView.text = "A"
        textView.textColor = UIColor.blackColor()
        textView.backgroundColor = UIColor.clearColor()
        textView.frame = CGRectMake(40, 50, 40, 40)
        textView.userInteractionEnabled = true
        textView.delegate = self
        //textView.backgroundColor = UIColor.redColor()
        //textView.font = .systemFontOfSize(20)
        textView.font = UIFont(name: "Bradley Hand" , size: 20)
        textView.textAlignment = NSTextAlignment.Center
        
        imageElementView.addSubview(textView)
        
         view.addSubview(imageElementView)
        
        if indexElement > 3 {
        textView.frame = CGRectMake(0,0, 0, 0)       }
        
        
    }
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
   
        
        if range.length + range.location > textView.text?.characters.count{
            return false
        }
        print("range: \(range.location), string:  \(text.characters.count)  ,textfield:  \(textView.text?.characters.count)"  )
        let newLimit = (textView.text?.characters.count)! + text.characters.count - range.length
        if newLimit == 3 {
            textView.frame.size.width = 80
            textView.frame.origin.x = 15
            textView.font = UIFont(name: "Bradley Hand" , size: 20)
        }
        if newLimit == 6{
            textView.font = UIFont(name: "Bradley Hand" , size: 15)
        }
        if newLimit == 15 {
            textView.frame.size.width = 90
            textView.font = UIFont(name: "Bradley Hand" , size: 10)
        }
        return newLimit <= 33
    }
    var kwidth:CGFloat = 0
    var kheight:CGFloat = 0
   override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
    var Tag =  touches.first!.view!.tag
    if Tag >= 100
    {
        Tag -= 100
    let touch : UITouch! = touches.first! as UITouch
    location = touch.locationInView(self.view)
   
    //print("center: \(imageViewOfElementsArr[Tag].center.x )")
    kwidth =   imageViewOfElementsArr[Tag].center.x  - location.x

    kheight = imageViewOfElementsArr[Tag].center.y - location.y
    }
    
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        var Tag =  touches.first!.view!.tag
        if Tag >= 100
        {
            Tag -= 100
        let limit: CGFloat?
        if (longHeightImageArr[Tag] == true) {
             limit = 65
        }
        else{
             limit = 35
        }
        let touch : UITouch! = touches.first! as UITouch
        location = touch.locationInView(self.view)
        print(self.view.frame.height)
        print(Tag)
        if location.y + kheight  > limit {
        imageViewOfElementsArr[Tag].center.x = location.x + kwidth
        imageViewOfElementsArr[Tag].center.y = location.y + kheight
        }
        if location.y + kheight > self.view.frame.height{
            imageViewOfElementsArr[Tag].removeFromSuperview()
        }
        }
    }
    

    
    
    
    
    
    
    
    
    
    
    
    func ChangeFilter(currentTag:Int) -> UIImage{
        currentFilter = CurrentFilterForImageArr[currentTag]! + 1
        if let filteredImage = filtersOfImage[currentTag]![currentFilter]{
             CurrentFilterForImageArr[currentTag] = currentFilter
            return filteredImage
        }else{
        print(currentFilter)
        
        let inputImage = CIImage(image: originalImageInImageView[currentTag]!)
        
        let filteredImage = inputImage?.imageByApplyingFilter(filters[currentFilter], withInputParameters: nil)
        
        let renderedImage = context.createCGImage(filteredImage!, fromRect: (filteredImage?.extent)!)
        CurrentFilterForImageArr[currentTag] = currentFilter
          let image = UIImage(CGImage: renderedImage)
            filtersOfImage[currentTag]![currentFilter] = image
            return image
        }
        

    }
//     func ChangeBackFilter(sender: AnyObject){
//        
//        currentTag = sender.tag
//        imageViewArr[currentTag].image = ChangeFilter(-1)
//        // imageViewArr[currentTag].image
//    }
    
    func ChangeNextFilter(currentTag:Int){
        
        
        imageViewArr[currentTag].image = ChangeFilter(currentTag)
        
    }
    func clearFilter (recognizer:UILongPressGestureRecognizer){
       let  currentTag = recognizer.view!.tag
        imageViewArr[currentTag].image = originalImageInImageView[currentTag]
        
    }
    
    func getInfoOfTemplateFromJson (indexOfTemplate:Int) -> [Int:[String:Float]]
    {
        let json = GetJsonFromFile("TopApps")
        var param = [Int:[String:Float]]()
        let numberOfElements = json["template\(self.indexTemplate)"].count
        for i in 0..<numberOfElements {
        
        param[i] = ["x":json["template\(self.indexTemplate)"]["\(i)"]["x"].floatValue]
        param[i]!["y"] = json["template\(self.indexTemplate)"]["\(i)"]["y"].floatValue
        param[i]!["width"] = json["template\(self.indexTemplate)"]["\(i)"]["width"].floatValue
        param[i]!["height"] = json["template\(self.indexTemplate)"]["\(i)"]["height"].floatValue
        }
        return param
    }
    func DelArrsAndViewOnReChangeTemplate(){
        for v in view.subviews{
            v.removeFromSuperview()
        }
        filtersOfImage = [Int:Array<UIImage?>]()
        CurrentFilterForImageArr = [Int:Int]()
        imageViewArr = []
        scrollViewArr = []
        imageViewOfElementsArr=[]
        numberOfElements = 100
        originalImageInImageView = [Int:UIImage]()
        videoViewArr = []
        longHeightImageArr = [Int:Bool]()
    }
    func setTemplateFromJson ()
    {
        DelArrsAndViewOnReChangeTemplate()

        let json = getInfoOfTemplateFromJson(self.indexTemplate)
         numberAreasInTemplate = json.count
                for i in 0..<numberAreasInTemplate {
            
            let imageView = UIImageView()
            let scrollView = UIScrollView()
            let videoView = AVPlayerViewController()
            let selfFrameView = self.view.frame
            let x = CGFloat( json[i]!["x"]!) * selfFrameView.width
            let y = CGFloat( json[i]!["y"]!) * selfFrameView.height
            let width = CGFloat( json[i]!["width"]!) * selfFrameView.width
            let height = CGFloat( json[i]!["height"]!) * selfFrameView.height
            
            print("Height: \(height)")
            
            
                    
          
            videoView.view.frame = CGRectMake(x, y, width, height)
            videoView.view.hidden = true
            videoView.view.tag = i
            videoViewArr.append(videoView)
           
                    
                    
            
                    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action:"importPictureOrChangeFilter:")
            tapGestureRecognizer.numberOfTapsRequired = 1
            let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action:"clearFilter:")
        
                    
            scrollView.frame = CGRectMake(x, y, width, height)
            scrollView.delegate = self
            scrollView.tag = i
            scrollViewArr.append(scrollView)
                    
                    
            imageView.userInteractionEnabled = true
            imageView.frame = CGRectMake(0, 0, width, height)
            imageView.contentMode = UIViewContentMode.ScaleToFill
            imageView.addGestureRecognizer(longPressGestureRecognizer)
            imageView.addGestureRecognizer(tapGestureRecognizer)
            imageView.tag = i
            imageViewArr.append(imageView)
                    
                    
            scrollView.addSubview(imageView)
              view.addSubview(videoView.view)
            view.addSubview(scrollView)
                    
                    
            
            
            
           
            
    }
        let imageViewBackground = UIImageView()
        imageViewBackground.frame = CGRectMake(0,0, self.view.frame.width, self.view.frame.height)
        print("Height2: \(self.view.frame.height)")
        print("Height3: \(view.frame.height)")
        imageViewBackground.image = imageTempArr[indexTemplate]
        view.addSubview(imageViewBackground)
        let saveButton = UIButton()
        saveButton.frame = CGRectMake(view.frame.width-50,view.frame.height-50, self.view.frame.width, self.view.frame.height)
        saveButton.backgroundColor = UIColor.blueColor()
        saveButton.addTarget(self, action: "saveToDB:", forControlEvents: .TouchUpInside)
        view.addSubview(saveButton)
        
    }
   
    func saveToDB(sender: UIButton){
        let tempDb =  ComicsDb()
        for i in 0..<numberAreasInTemplate{
            let area = Area()
            if isImageInArea(i){
                area.content = UIImagePNGRepresentation( getScreenOfImageViewInArea(i) )
                
                print("SaveImage")
            }else{
                if isVideoInArea(i){
                   
                    area.path = (urlOfVideo[i]?.path)
                    
                    print("SaveVideo")
                }
            }
         tempDb.areas.append(area)
        }
        for i in 0..<imageViewOfElementsArr.count{
            let element = Elementdb()
           element.x =  Float(imageViewOfElementsArr[i].frame.origin.x)
            element.y = Float(imageViewOfElementsArr[i].frame.origin.y)
            element.content = UIImagePNGRepresentation( getScreenOfElement(i))
            tempDb.elements.append(element)
        }
         tempDb.NameOfTemplate = "TestName"
        tempDb.indexOfTemplate = indexTemplate
        let cdb = ComicsDBHelper()
        cdb.saveComics(tempDb)
        
        
    }
    func getScreenOfImageViewInArea(indexArea:Int)->UIImage{
        UIGraphicsBeginImageContext(scrollViewArr[indexArea].frame.size)
        scrollViewArr[indexArea].layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    func getScreenOfElement(indexElement:Int) -> UIImage{
        UIGraphicsBeginImageContext(imageViewOfElementsArr[indexElement].frame.size)
        imageViewOfElementsArr[indexElement].layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    func isVideoInArea(indexArea:Int) ->Bool{
        if videoViewArr[indexArea].view.hidden == false{
            return true
        }else{
            return false
        }
    }
    func isImageInArea (indexArea:Int) -> Bool{
        if scrollViewArr[indexArea].hidden == false {
            return true
        }else{
            return false
        }
    }
    func SavePageInfo(index:Int){
        var currPage = CurrentTemplate()
        if index < pagesArr.count {
          currPage = pagesArr[index-1]
        }
        currPage.filtersOfImage = filtersOfImage
        currPage.imageViewArr = imageViewArr
        currPage.imageViewOfElementsArr = imageViewOfElementsArr
        currPage.indexOfTemplate = indexTemplate
        currPage.originalImageInImageView = originalImageInImageView
        currPage.scrollViewArr = scrollViewArr
        currPage.urlOfVideo = urlOfVideo
        currPage.videoViewArr = videoViewArr
        currPage.CurrentFilterForImageArr = CurrentFilterForImageArr
        currPage.numberAreasInTemplate = numberAreasInTemplate
        currPage.numberOfElements = numberOfElements
        if index<pagesArr.count {
        pagesArr[index-1] = currPage
        }else{
            pagesArr.append(currPage)
        }
        
        DelArrsAndViewOnReChangeTemplate()
    }
    func loadPageInfo (currPage:CurrentTemplate){
        filtersOfImage = currPage.filtersOfImage
        imageViewArr = currPage.imageViewArr
        imageViewOfElementsArr = currPage.imageViewOfElementsArr
        indexTemplate = currPage.indexOfTemplate!
        originalImageInImageView = currPage.originalImageInImageView
        scrollViewArr = currPage.scrollViewArr
        urlOfVideo = currPage.urlOfVideo
        videoViewArr = currPage.videoViewArr
        CurrentFilterForImageArr = currPage.CurrentFilterForImageArr
        numberAreasInTemplate = currPage.numberAreasInTemplate!
        numberOfElements = currPage.numberOfElements!

    }
    func changePage(index:Int){
        DelArrsAndViewOnReChangeTemplate()
        let currPage = pagesArr[index-1]
        loadPageInfo(currPage)
                for i in 0..<numberAreasInTemplate
        {
            view.addSubview(videoViewArr[i].view)
            view.addSubview(scrollViewArr[i])
            if videoViewArr[i].view.hidden == false
            {
                print("\(i): video")
                createClearVideoButton(i)
            }
            if imageViewArr[i].image != nil{
                print("\(i): photo")
                createDelImageButton(i)
            }
        }
               let imageViewBackground = UIImageView()
        imageViewBackground.frame = CGRectMake(0,0, self.view.frame.width, self.view.frame.height)
        
        imageViewBackground.image = imageTempArr[indexTemplate]
       view.addSubview(imageViewBackground)
        for i in 0..<numberOfElements-100{
            if imageViewOfElementsArr[i].center.y <= self.view.frame.height{
            view.addSubview(imageViewOfElementsArr[i])
            }
        }
      
    }
    var h = true
    var h2 = true
    @IBAction func changeNextPage(segue: UIStoryboardSegue)
    {
        let  handVC = segue.sourceViewController as? HandlingComicsController
        print("curr: \(handVC?.currentPageTemplate) , Max: \(handVC?.maxPagesTemplate)")
        if h {
      
        
            SavePageInfo(handVC!.currentPageTemplate-1)
            if handVC!.currentPageTemplate <= handVC!.maxPagesTemplate{
            changePage(handVC!.currentPageTemplate)
            }
        
            h = false
            h2 = true
        }
    }
    @IBAction func changeBackPage(segue:UIStoryboardSegue)
    {
        let handVC = segue.sourceViewController as? HandlingComicsController
        print("curr: \(handVC?.currentPageTemplate) , Max: \(handVC?.maxPagesTemplate)")
        if h2 {
        
            
            SavePageInfo(handVC!.currentPageTemplate+1)
            
            changePage(handVC!.currentPageTemplate)
           h2 = false
            h = true
        }
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
