//
//  ViewController.swift
//  CityListing
//
//  Created by Pardeep on 19/12/17.
//  Copyright © 2017 www.programmingcrew.in. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK:- Properties
    @IBOutlet weak var tableviewHome: UITableView!
    fileprivate var arrayCity:[City] = []

    //MARK:- View life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUIElements()
        loadDataFromDatabase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- User defined method
    
    //Initial UI set up will be done in this method
    private func setUpUIElements(){
        tableviewHome.estimatedRowHeight = 50.0
        tableviewHome.rowHeight = UITableViewAutomaticDimension
    }
    
    //Load city listing from database
    private func loadDataFromDatabase(){
        
        let managedObjectContext = PersistanceService.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        do {
            arrayCity = try managedObjectContext.fetch(fetchRequest) as! [City]
        } catch {
            print("Failed to retrieve record")
            print(error)
        }
    }

    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cellReuseIdentifierN"
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if (cell == nil){
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
            cell?.accessoryType = .disclosureIndicator
            cell?.textLabel?.numberOfLines = 0
        }
        
        let cityData = arrayCity[indexPath.row]
        cell?.textLabel?.text = cityData.name
        return cell!
    }
    
}

