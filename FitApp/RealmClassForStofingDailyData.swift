//
//  RealmClassForStofingDailyData.swift
//  LetFit
//
//  Created by Kseniya Borokhovskaya on 4/27/17.
//  Copyright © 2017 Kseniya Borokhovskaya. All rights reserved.
//

import Foundation
import RealmSwift


class DailyData: Object {
    
    dynamic var DailyDataId = String(describing: Date())
    
    let food = List<Food>()
    let foodCalories = Array<Int>()
    let activity = List<Activity>()
    let activityCalories = Array<Int>()
    
    
    dynamic var eatenCalories = 0
    dynamic var burnedCalories = 0
    dynamic var leftCarbs = 0.0
    dynamic var leftFat = 0.0
    dynamic var leftProtein = 0.0
    dynamic var date = Date()
    
    override class func primaryKey() -> String?
    {
        return "DailyDataId"
    }
}
