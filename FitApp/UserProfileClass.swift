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
    

    
    func setBasalMetabolismAgain()
    {
        var BasalMetabolism = 1300.0
    if self.sex == "male"{
        let weightWithCoef = 13.7 * self.weight
        let heightWithCoef = Double(5 * self.hight)
        BasalMetabolism = 66.5 + weightWithCoef + heightWithCoef - 6.8 * Double(self.age)
    }
        else{
            let weightWithCoef = 9.6 * self.weight
            let heightWithCoef = 1.8 * Double(self.hight)
            BasalMetabolism = 665 + weightWithCoef + heightWithCoef - 4.7 * Double(self.age)
        }
        
        self.basalMetabolism = BasalMetabolism
    }
    
    func setCarbs() -> Double {
        self.carbs = (self.basalMetabolism * 0.4) / 4
        return self.carbs
    }
    func setProtein() -> Double {
        self.protein = (self.basalMetabolism * 0.35) / 4
        return self.protein
    }
    func setFat() -> Double {
        self.fat = (self.basalMetabolism * 0.25) / 9
        return self.fat
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
