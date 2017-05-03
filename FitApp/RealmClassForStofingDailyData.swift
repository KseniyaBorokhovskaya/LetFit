//
//  RealmClassForStofingDailyData.swift
//  LetFit
//
//  Created by Kseniya Borokhovskaya on 4/27/17.
//  Copyright © 2017 Kseniya Borokhovskaya. All rights reserved.
//

import Foundation
import RealmSwift


let dateFormatter = setDateFormatter()

class RealmInt: Object {
    dynamic var intValue = 0
}

class DailyData: Object {
    
    let food = List<Food>()
    var foodCalories = List<RealmInt>()
    var carbs = List<RealmInt>()
    var fat = List<RealmInt>()
    var protein = List<RealmInt>()
    
    let activity = List<Activity>()
    var activityCalories = List<RealmInt>()
    
    
    dynamic var eatenCalories = 0
    dynamic var burnedCalories = 0
    dynamic var leftCarbs = 0.0
    dynamic var leftFat = 0.0
    dynamic var leftProtein = 0.0
    dynamic var date = Date()
    
    dynamic var DailyDataId = dateFormatter.string(from: Date() as Date)
    
    override class func primaryKey() -> String?
    {
        return "DailyDataId"
    }
}
