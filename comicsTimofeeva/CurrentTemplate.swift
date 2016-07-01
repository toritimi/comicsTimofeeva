//
//  CurrentTemplate.swift
//  comicsTimofeeva
//
//  Created by Mac on 30.06.16.
//  Copyright © 2016 itransition. All rights reserved.
//

import UIKit
import AVKit
class CurrentTemplate: NSObject {
    var imageViewArr = [UIImageView]()
    var scrollViewArr = [UIScrollView]()
    var filtersOfImage = [Int:Array<UIImage?>]()
    var originalImageInImageView = [Int:UIImage]()
    var CurrentFilterForImageArr = [Int:Int]()
    var videoViewArr = [AVPlayerViewController]()
    var urlOfVideo = [Int:AnyObject]()
    var imageViewOfElementsArr = [UIImageView]()
    var numberOfElements:Int?
    var indexOfTemplate:Int?
    var numberAreasInTemplate : Int?
    

}
