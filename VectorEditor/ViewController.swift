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
    @IBOutlet weak var drawingView: UIDrawingView!
    
    override func viewDidLoad() {
        tableView.dataSource = self
        
        drawingView.elements.append(Rectangle(frame: CGRect(x: 10, y: 10, width: 100, height: 100), color: UIColor.red))
        drawingView.elements.append(Rectangle(frame: CGRect(x: 400, y: 400, width: 300, height: 300), color: UIColor.blue))
        drawingView.elements.append(Rectangle(frame: CGRect(x: 10, y: 700, width: 10, height: 10), color: UIColor.green))
        drawingView.elements.append(Rectangle(frame: CGRect(x: 700, y: 10, width: 10, height: 10), color: UIColor.yellow))
        
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

