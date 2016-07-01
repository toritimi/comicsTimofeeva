//
//  TemplateDb.swift
//  comicsTimofeeva
//
//  Created by Mac on 28.06.16.
//  Copyright © 2016 itransition. All rights reserved.
//

import UIKit
import RealmSwift


class ComicsDb: Object {
   
    var indexOfTemplate:Int?
    var areas = List<Area>()
    var elements = List<Elementdb>()
    var NameOfTemplate:String?
}
