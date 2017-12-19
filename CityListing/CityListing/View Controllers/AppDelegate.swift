//
//  AppDelegate.swift
//  CityListing
//
//  Created by Pardeep on 19/12/17.
//  Copyright © 2017 www.programmingcrew.in. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //MARK:- App delegate methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Load the data once only. To accomplish this, keep a bool variable
        let defaults = UserDefaults.standard
        let isPreloaded = defaults.bool(forKey: CONSTANT.IsDataPreloaded)
        if !isPreloaded {
            preloadDataFromCSV()
            defaults.set(true, forKey: CONSTANT.IsDataPreloaded)
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

    //MARK:- Data fetching from CSV and saving in core data
    
    //Load the data from (static)CSV file
    private func preloadDataFromCSV() {
        if let contentsOfURL = Bundle.main.url(forResource: DATBASE.CityEntityName, withExtension: "csv") {
            removeData()          // Remove all the data before preloading to avoid duplicacy
            
            if let items = parseCSV(contentsOfURL: contentsOfURL as NSURL, encoding: String.Encoding.utf8) {
                let managedObjectContext = PersistanceService.persistentContainer.viewContext
                
                for item in items {
                    let menuItem = NSEntityDescription.insertNewObject(forEntityName: DATBASE.CityEntityName, into: managedObjectContext) as! City
                    menuItem.countryId = item.countryId
                    menuItem.name = item.name
                    menuItem.population = item.population
                    menuItem.country = item.country
                    menuItem.timezone = item.timezone
                    do{
                        try managedObjectContext.save()
                    }catch{
                        print("insert error: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    // Remove the existing items
    func removeData () {
        let managedObjectContext = PersistanceService.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: DATBASE.CityEntityName)
        
        do{
            let menuItems = try managedObjectContext.fetch(fetchRequest) as! [City]
            
            if !menuItems.isEmpty{
                for menuItem in menuItems {
                    managedObjectContext.delete(menuItem)
                }
            }else{
                print("No item to delete")
            }
        }catch{
            print("error at remove data \(error)")
        }
    }

    // Load the CSV file and parse it
    //Parameters
        //  contentsOfURL: csv file path url
        //  encoding: Type of encoding
    func parseCSV (contentsOfURL: NSURL, encoding: String.Encoding) -> [(countryId: String, name:String, population:String, country:String, timezone:String)]? {
        let delimiter = ","
        var items:[(countryId: String, name:String, population:String, country:String, timezone:String)]?
        
        if let data = NSData(contentsOf: contentsOfURL as URL){
            if let content = NSString(data: data as Data, encoding: encoding.rawValue) {
                items = []
                let lines:[String] = content.components(separatedBy: NSCharacterSet.newlines) as [String]
                
                for line in lines {
                    var values:[String] = []
                    if line != "" {
                        // Use NSScanner to perform the parsing(line with double quotes)
                        
                        let range = line.range(of: "\"")
                        if range != nil{
                            var textToScan:String = line
                            var value:NSString?
                            var textScanner:Scanner = Scanner(string: textToScan)
                            while textScanner.string != "" {
                                
                                if (textScanner.string as NSString).substring(to: 1) == "\"" {
                                    textScanner.scanLocation += 1
                                    textScanner.scanUpTo("\"", into: &value)
                                    textScanner.scanLocation += 1
                                } else {
                                    textScanner.scanUpTo(delimiter, into: &value)
                                }
                                
                                // Store the value into the values array
                                values.append(value! as String)
                                
                                // Retrieve the unscanned remainder of the string
                                if textScanner.scanLocation < textScanner.string.characters.count {
                                    textToScan = (textScanner.string as NSString).substring(from: textScanner.scanLocation + 1)
                                } else {
                                    textToScan = ""
                                }
                                textScanner = Scanner(string: textToScan)
                            }
                            
                            // For a line without double quotes, we can simply separate the string by using the delimiter (e.g. comma)
                        } else  {
                            values = line.components(separatedBy: delimiter)
                        }
                        
                        // Put the values into the tuple and add it to the items array
                        let item = (countryId: values[0], name: values[1], population: values[16], country: values[17], timezone: values[18])
                        items?.append(item)
                    }
                }
            }
        }
        
        return items
    }

}
