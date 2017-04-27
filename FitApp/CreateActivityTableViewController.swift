//
//  CreateActivityTableViewController.swift
//  FitApp
//
//  Created by Kseniya Borokhovskaya on 4/23/17.
//  Copyright © 2017 Kseniya Borokhovskaya. All rights reserved.
//

import UIKit
import RealmSwift

class CreateActivityTableViewController: UITableViewController {

    @IBOutlet weak var newActivity: UITextField!
    @IBOutlet weak var addCalories: UITextField!
    
    
    @IBAction func createActivity(_ sender: UIButton)
    {
        let realm = try! Realm()
        let activity = Activity()
        
        if let nameOfNewActivity: String = newActivity.text
        {
            activity.nameOfActivity = nameOfNewActivity
            if let amountOfCalories: Int = Int(addCalories.text!)
            {
                activity.calories = amountOfCalories
                try! realm.write
                    {
                        realm.add(activity)
                    }
            }
        }
        navigationController!.popViewController(animated: true)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

}
