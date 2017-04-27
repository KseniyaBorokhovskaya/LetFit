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
    
    dynamic var Food : Food? = nil
    dynamic var Activitiy : Activity? = nil
    
    dynamic var date = Date()
    
    override class func primaryKey() -> String?
    {
        return "DailyDataId"
    }
}
