//
//  LoadJSONFood.swift
//  LetFit
//
//  Created by Kseniya Borokhovskaya on 4/27/17.
//  Copyright © 2017 Kseniya Borokhovskaya. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class PreloadFoodData
{
    static func getJSONAFoodData()
    {
        let realm = try! Realm()
        
        if let path = Bundle.main.path(forResource: "Food", ofType: "json") {
            do {
                let data = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    let clearJSONFood = JSON(data: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers, error: nil)
                    let numberOfFood = clearJSONFood["Food"].count
                    
                    for i in 0..<numberOfFood{
                        let food = Food()
                        food.nameOfFood = clearJSONFood["Food","\(i + 1)", "nameOfFood"].stringValue
                        food.calories = clearJSONFood["Food", "\(i + 1)",  "calories"].intValue
                        food.fat = clearJSONFood["Food", "\(i + 1)",  "fat"].doubleValue
                        food.carbohydrates = clearJSONFood["Food", "\(i + 1)",  "carbohydrates"].doubleValue
                        food.protein = clearJSONFood["Food", "\(i + 1)",  "protein"].doubleValue
                        try! realm.write
                            {
                                realm.add(food)
                        }
                    }
                }
            } catch {}
        }
    }
}
