//
//  HomeTableViewCell.swift
//  CityListing
//
//  Created by Pardeep on 20/12/17.
//  Copyright © 2017 www.programmingcrew.in. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    //MARK:- Properties
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelCityPopulation: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    func configureCellWithData(cityData : City)
    {
        labelCityName.text = cityData.name
        labelCityPopulation.text = "Population: \(cityData.population ?? "0")"
    }
    
}
