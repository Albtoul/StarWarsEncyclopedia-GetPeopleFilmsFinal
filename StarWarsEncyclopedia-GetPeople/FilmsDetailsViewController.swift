//
//  FilmsDetailsViewController.swift
//  StarWarsEncyclopedia-GetPeople
//
//  Created by Hell on 19/12/2021.
//

import UIKit

class FilmsDetailsViewController: UIViewController {
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var directorLabel : UILabel!
    @IBOutlet weak var releaseDateLabel : UILabel!
    @IBOutlet weak var openingLabel : UILabel!
    
    var film : Film?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let RF = film {
            titleLabel.text = RF.title
            directorLabel.text = RF.director
            releaseDateLabel.text = RF.release_date
            openingLabel.text = RF.opening_crawl
        }
    }
}
