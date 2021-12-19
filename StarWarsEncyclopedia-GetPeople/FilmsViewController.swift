//
//  FilmsViewController.swift
//  StarWarsEncyclopedia-GetPeople
//
//  Created by Hell on 16/12/2021.
//

import UIKit

struct Film {
    var title:String
    var opening_crawl:String
    var director:String
    var release_date:String
}

class FilmsViewController: UITableViewController {
    
    var films = [Film]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        StarWarsModel.getAllFilms(completionHandler: {
            data, response, error in
            do{
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let results = jsonResult["results"] as? NSArray {
                        for film in results {
                            if let film = film as? NSDictionary {
                                self.films.append(Film(title: film["title"] as! String, opening_crawl: film["opening_crawl"] as! String, director: film["director"] as! String, release_date: film["release_date"] as! String))
                            }
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch{
                print(error)
            }
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return films.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = films[indexPath.row].title

        // Configure the cell...

        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let filmsVC = segue.destination as! FilmsDetailsViewController
        let indexPath = sender as! IndexPath
        let film = films[indexPath.row]
        filmsVC.film = film
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "FilmsDetailsVC", sender: indexPath)
    }
}
