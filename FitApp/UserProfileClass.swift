//
//  UserProfileClass.swift
//  LetFit
//
//  Created by Kseniya Borokhovskaya on 4/28/17.
//  Copyright © 2017 Kseniya Borokhovskaya. All rights reserved.
//

import Foundation
import RealmSwift


class User: Object {
    
    dynamic var id = NSUUID().uuidString
    
    dynamic var name = ""
    dynamic var surname = ""
    dynamic var sex = ""
    dynamic var age = 0
    dynamic var hight = 0
    dynamic var weight = 0.0
    dynamic var basalMetabolism = 0.0
    dynamic var carbs = 0.0
    dynamic var protein = 0.0
    dynamic var fat = 0.0
    
    func getBasalMetabolism(withSex sex: String, withAge age: Int, withHight hight: Int, withWeight weight: Double) -> Int
    {
        let BasalMetabolism = 1300
        return Int(BasalMetabolism)
    }
    
    func setBasalMetabolismAgain()
    {
        let BasalMetabolism = 1300.0
        self.basalMetabolism = BasalMetabolism
    }
    
    func setCarbs() {
        self.carbs = (self.basalMetabolism * 0.4) / 4
    }
    func setProtein() {
        self.protein = (self.basalMetabolism * 0.4) / 4
    }
    func setFat() {
        self.fat = (self.basalMetabolism * 0.2) / 9
    }
    convenience init(name: String, surname: String,sex: String, age: Int, hight: Int, weight: Double)
    {
        self.init()
        self.name = name
        self.surname = surname
        self.sex = sex
        self.age = age
        self.hight = hight
        self.weight = weight
    }
    override class func primaryKey() -> String?{
        return "id"
    }
}
