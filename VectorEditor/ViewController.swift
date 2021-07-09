//
//  ViewController.swift
//  VectorEditor
//
//  Created by Oleksii Bashuk on 07.07.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource  {

    let elements = ["cat", "dog", "frog"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.dataSource = self
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        cell.animalLbl.text = elements[indexPath.row]
        
        return cell
    }
}

