//
//  ComicsDBHelper.swift
//  comicsTimofeeva
//
//  Created by Mac on 29.06.16.
//  Copyright © 2016 itransition. All rights reserved.
//

import UIKit
import RealmSwift
class ComicsDBHelper: Object {
    func saveComics (tempDB:ComicsDb){
        
        let realm = try! Realm()
        try! realm.write{
            print(tempDB)
            realm.add(tempDB)
             print("Data saving...")
            
        }
    }
    func getComics() -> [ComicsDb] {
        let comicsResult = try! Realm().objects(ComicsDb)
        var comics = [ComicsDb]()
        if comicsResult.count>0{
            for dbComic in comicsResult{
                let comic = dbComic as ComicsDb
                comics.append(comic)
            }
        }
        return comics
    }
}
