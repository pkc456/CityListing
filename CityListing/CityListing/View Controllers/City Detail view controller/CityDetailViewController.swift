//
//  CityDetailViewController.swift
//  CityListing
//
//  Created by Pardeep on 20/12/17.
//  Copyright © 2017 www.programmingcrew.in. All rights reserved.
//

import UIKit

class CityDetailViewController: UIViewController {

    //MARK:- Properties
    var cityData : City?
    
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelCityPopulation: UILabel!
    @IBOutlet weak var labelCityCountry: UILabel!
    @IBOutlet weak var labelCityTimezone: UILabel!
    
    //MARK:- View controller life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUIElements()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   //MARK:- User defined action
    private func setUpUIElements(){
        self.navigationItem.title = "City Detail"
        
        if let data = cityData{
            labelCityName.text = "City: \(data.name ?? "")"
            labelCityPopulation.text = "Population: \(data.population ?? "")"
            labelCityCountry.text = "Country: \(data.country ?? "")"
            labelCityTimezone.text = "Timezone: \(data.timezone ?? "")"
        }
    }
}
