//
//  PeopleViewController.swift
//  StarWarsEncyclopedia-GetPeople
//
//  Created by Hell on 16/12/2021.
//

import UIKit

struct Person {
    var name:String
    var gender:String
    var year:String
    var mass:String
}

class PeopleViewController: UITableViewController {
    // Hardcoded data for now
    var people = [Person]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StarWarsModel.getAllPeople(completionHandler: {
            data, response, error in
            do{
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let results = jsonResult["results"] as? NSArray {
                        for object in results {
                            if let jsonObj = object as? NSDictionary {
                                self.people.append(Person(name: jsonObj["name"] as! String, gender: jsonObj["gender"] as! String, year: jsonObj["birth_year"] as! String, mass: jsonObj["mass"] as! String))
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // if we return - sections we won't have any sections to put our rows in
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the count of people in our data array
        return people.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a generic cell
        let cell = UITableViewCell()
        // set the default cell label to the corresponding element in the people array
        cell.textLabel?.text = people[indexPath.row].name
        // return the cell so that it can be rendered
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let peopleVC = segue.destination as! PeopleDetailsViewController
        let indexPath = sender as! IndexPath
        let person = people[indexPath.row]
        peopleVC.person = person
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PeopleDetailsVC", sender: indexPath)
    }
}

