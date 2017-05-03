//
//  FoodClass.swift
//  LetFit
//
//  Created by Kseniya Borokhovskaya on 4/27/17.
//  Copyright © 2017 Kseniya Borokhovskaya. All rights reserved.
//

import Foundation
import RealmSwift


class Food: Object {
    
    dynamic var FoodId = NSUUID().uuidString
    
    dynamic var nameOfFood = ""
    dynamic var calories = 0
    dynamic var fat = 0.0
    dynamic var protein = 0.0
    dynamic var carbohydrates = 0.0
    
    override class func primaryKey() -> String?
    {
        return "FoodId"
    }
}
