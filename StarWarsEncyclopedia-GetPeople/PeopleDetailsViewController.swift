//
//  PeopleDetailsViewController.swift
//  StarWarsEncyclopedia-GetPeople
//
//  Created by Hell on 19/12/2021.
//

import UIKit

class PeopleDetailsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var genderLabel : UILabel!
    @IBOutlet weak var yearLabel : UILabel!
    @IBOutlet weak var massLabel : UILabel!
    
    var person : Person?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let RP = person {
            nameLabel.text = RP.name
            genderLabel.text = RP.gender
            yearLabel.text = RP.year
            massLabel.text = RP.mass
        }
    }

}
