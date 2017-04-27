//
//  ActivitiesClass.swift
//  FitApp
//
//  Created by Kseniya Borokhovskaya on 4/22/17.
//  Copyright © 2017 Kseniya Borokhovskaya. All rights reserved.
//

import Foundation
import RealmSwift


class Activity: Object {
    
    dynamic var id = NSUUID().uuidString
    
    dynamic var nameOfActivity = ""
    dynamic var calories = 0
    
    override class func primaryKey() -> String?{
        return "id"
    }

}
