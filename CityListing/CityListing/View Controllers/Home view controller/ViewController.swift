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
    @IBOutlet weak var buttonSort: UIBarButtonItem!

    //MARK:- View life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDataFromDatabase()
        setUpUIElements()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- User defined method
    
    //Initial UI set up will be done in this method
    private func setUpUIElements(){
        buttonSort.isEnabled = arrayCity.count > 0 ? true : false
        
        tableviewHome.estimatedRowHeight = 62.0
        tableviewHome.rowHeight = UITableViewAutomaticDimension
    }
    
    //Load city listing from database
    private func loadDataFromDatabase(){
        
        let managedObjectContext = PersistanceService.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: DATBASE.CityEntityName)
        do {
            arrayCity = try managedObjectContext.fetch(fetchRequest) as! [City]
        } catch {
            print("Failed to retrieve record because: \(error)")            
        }
    }

    // MARK: - IBActions
    @IBAction func btnSortAction(_ sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: "Sort by population", message: nil, preferredStyle: .actionSheet)
        
        //Use weak self to avoid retain cycle
        let buttonAscending = UIAlertAction(title: "Ascending", style: .default) { [weak self]action in
            self?.arrayCity.sort{ $0.population! < $1.population! }
            self?.tableviewHome.reloadData()
        }
        
        let buttonDescending = UIAlertAction(title: "Descending", style: .default) { [weak self]action in
            self?.arrayCity.sort{ $0.population! > $1.population! }
            self?.tableviewHome.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        
        actionSheet.addAction(buttonAscending)
        actionSheet.addAction(buttonDescending)
        actionSheet.addAction(cancel)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        let cityData = arrayCity[indexPath.row]
        cell.configureCellWithData(cityData: cityData)
        
        return cell
    }
        
}

