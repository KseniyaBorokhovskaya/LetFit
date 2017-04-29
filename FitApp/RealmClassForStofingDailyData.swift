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
    
    dynamic var DailyDataId = NSUUID().uuidString
    
    var Food : List<Food>? = nil
    var Activitiy : List<Activity>? = nil
    
    dynamic var date = Date()
    
    override class func primaryKey() -> String?
    {
        return "DailyDataId"
    }
}
