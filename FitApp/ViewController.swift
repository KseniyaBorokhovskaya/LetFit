//
//  ViewController.swift
//  CalendarPopUp
//
//  Created by Atakishiyev Orazdurdy on 11/16/16.
//  Copyright © 2016 Veriloft. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var basalMetabolism: UILabel!
    @IBOutlet weak var caloriesEaten: UILabel!
    @IBOutlet weak var caloriesBurned: UILabel!
    @IBOutlet weak var carbs: UILabel!
    @IBOutlet weak var protein: UILabel!
    @IBOutlet weak var fat: UILabel!
    
    var user: User!
    
    var aPopupContainer: PopupContainer?
    var testCalendar = Calendar(identifier: .gregorian)
    var currentDate: Date! = Date() {
        didSet {
            setDate()
        }
    }
    

    var numberOfActivityRows = 0
    var numberOfFoodRows = 0
    var numberOfRowsAtSection: [Int] = [0, 0]
    
    let dateFormatter = setDateFormatter()
    
    @IBOutlet weak var CalendarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentDate = Date()
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "CalendarSelectedState"), for: UIControlState.normal)
        button.setImage(UIImage(named: "CalendarSelectedState"), for: UIControlState.highlighted)
        button.addTarget(self, action: #selector(ViewController.showCalendar(_:)), for: UIControlEvents.touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HomeActivityCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateData()
        //print(currentDate)
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int = 0
        
        if section < numberOfRowsAtSection.count {
            rows = numberOfRowsAtSection[section]
        }
        
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "HomeActivityCell")! as UITableViewCell
         //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "HomeActivityCell")
        if let realm = try? Realm(),
            let todayData = realm.object(ofType: DailyData.self, forPrimaryKey: dateFormatter.string(from: currentDate as Date) as AnyObject) {
            try! realm.write {
                if indexPath.section == 0
                {
                cell.textLabel?.text = todayData.activity.elements[indexPath.row].nameOfActivity
                cell.detailTextLabel?.text = String(describing: todayData.activityCalories[indexPath.row].intValue)
                } else {
                    cell.textLabel?.text = todayData.food.elements[indexPath.row].nameOfFood
                    cell.detailTextLabel?.text = String(describing: todayData.foodCalories[indexPath.row].intValue)
                }
            }
        }
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1{
            return "Food"
        } else {
            return "Activity"
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let realm = try? Realm(),
                let todayData = realm.object(ofType: DailyData.self, forPrimaryKey: dateFormatter.string(from: currentDate as Date) as AnyObject) {
            try! todayData.realm!.write {
                if indexPath.section == 0
                {
                    let data = todayData.activity.elements[indexPath.row]
                    todayData.realm!.delete(data)
                    let caloriesData = todayData.activityCalories.elements[indexPath.row]
                    todayData.realm!.delete(caloriesData)
                }
                else {
                    let data = todayData.food.elements[indexPath.row]
                    todayData.realm!.delete(data)
                    let caloriesData = todayData.foodCalories.elements[indexPath.row]
                    todayData.realm!.delete(caloriesData)
                }
            }
                numberOfFoodRows = todayData.food.endIndex
                numberOfActivityRows = todayData.activity.endIndex
                numberOfRowsAtSection = [numberOfActivityRows, numberOfFoodRows]
                
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateData()
        }
      }
    }
    
    func updateData(){
        if let realm = try? Realm(),
            let todayData = realm.object(ofType: DailyData.self, forPrimaryKey: dateFormatter.string(from: currentDate as Date) as AnyObject) {
            user = realm.objects(User.self)[0]
            basalMetabolism.text = String(Int(user.basalMetabolism))
            caloriesEaten.text = String(todayData.eatenCalories)
            caloriesBurned.text = String(todayData.burnedCalories)
            carbs.text = String(todayData.leftCarbs)
            fat.text = String(todayData.leftFat)
            protein.text = String(todayData.leftProtein)
            numberOfFoodRows = todayData.food.endIndex
            numberOfActivityRows = todayData.activity.endIndex
            numberOfRowsAtSection = [numberOfActivityRows, numberOfFoodRows]
        } else{
            let realm = try? Realm()
            user = realm?.objects(User.self)[0]
            basalMetabolism.text = String(Int(user.basalMetabolism))
            caloriesEaten.text = "0"
            caloriesBurned.text = "0"
            carbs.text = String(user.carbs)
            fat.text = String(user.fat)
            protein.text = String(user.protein)
            numberOfFoodRows = 0
            numberOfActivityRows = 0
            numberOfRowsAtSection = [numberOfActivityRows, numberOfFoodRows]
        }
        tableView.reloadData()
    }
    
    
    @IBAction func showCalendar(_ sender: UIButton) {
        let xibView = Bundle.main.loadNibNamed("CalendarPopUp", owner: nil, options: nil)?[0] as! CalendarPopUp
        xibView.calendarDelegate = self
        xibView.selected = currentDate
        PopupContainer.generatePopupWithView(xibView).show()
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
  
    func setDate() {
        let month = testCalendar.dateComponents([.month], from: currentDate).month!
        let weekday = testCalendar.component(.weekday, from: currentDate)
        
        let monthName = DateFormatter().monthSymbols[(month-1) % 12] //GetHumanDate(month: month)//
        let week = DateFormatter().shortWeekdaySymbols[weekday-1]
        
        let day = testCalendar.component(.day, from: currentDate)
        
        dateLabel.text = "\(week), " + monthName + " " + String(day)
        updateData()
        
    }
}

extension ViewController: CalendarPopUpDelegate {
    func dateChaged(date: Date) {
        currentDate = date
    }
}
