//
//  AppDelegate.swift
//  FitApp
//
//  Created by Kseniya Borokhovskaya on 4/22/17.
//  Copyright © 2017 Kseniya Borokhovskaya. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UISearchBar.appearance().barTintColor = UIColor.white
        UISearchBar.appearance().tintColor = UIColor.lightGray
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "isFirstTime") == nil {
            PreloadData.getJSONActivitiesData()
            PreloadFoodData.getJSONAFoodData()
            defaults.set("No", forKey:"isFirstTime")
            defaults.synchronize()
            let storyboard = UIStoryboard(name: "Main", bundle: nil) //Write your storyboard name
            let viewController = storyboard.instantiateViewController(withIdentifier: "StartScreenViewController")
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
        }
        let dateFormatter = setDateFormatter()
        let currentDate = Date()
        let today: String? = dateFormatter.string(from:currentDate as Date)
        if let realm = try? Realm(),
            let _ = realm.object(ofType: DailyData.self, forPrimaryKey: today as AnyObject) {

        } else {
            let realm = try! Realm()
            let todayData = DailyData()
            try! realm.write
            {
                    realm.add(todayData)
            }
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

