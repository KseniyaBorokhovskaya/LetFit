//
//  LoadJSONActivities.swift
//  FitApp
//
//  Created by Kseniya Borokhovskaya on 4/23/17.
//  Copyright © 2017 Kseniya Borokhovskaya. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class PreloadData
{
    static func getJSONActivitiesData()
    {
        let realm = try! Realm()
        
        if let path = Bundle.main.path(forResource: "Try", ofType: "json") {
            do {
                let data = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    let clearJSONActivities = JSON(data: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers, error: nil)
                    let numberOfActivities = clearJSONActivities["Activities"].count
                    
                    for i in 0..<numberOfActivities{
                        let activity = Activity()
                        activity.nameOfActivity = clearJSONActivities["Activities","\(i + 1)", "nameOfActivity"].stringValue
                        activity.calories = clearJSONActivities["Activities", "\(i + 1)",  "calories"].intValue
                        try! realm.write
                            {
                                realm.add(activity)
                        }
                    }
                }
            } catch {}
        }
    }
}

