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
        
        drawingView.elements.append(Circle(frame: CGRect(x: -50, y: -50, width: 100, height: 100), color: UIColor.black))
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drawingView.elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        let element = drawingView.elements[indexPath.row]
        
        let date = element.date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let dateResult = formatter.string(from: date)
        cell.cellDate.text = dateResult
        
//        let calendar = Calendar.current
//        let hour = calendar.component(.hour, from: date)
//        let minutes = calendar.component(.minute, from: date)
//        let seconds = calendar.component(.second, from: date)
//        cell.cellTime.text = "\(hour):\(minutes):\(seconds)"
        
        formatter.dateFormat = "HH:mm:ss"
        let timeResult = formatter.string(from: date)
        cell.cellTime.text = timeResult
        
        let cellViewFigurewidth = cell.cellFigureView.frame.width
        let cellViewFigureHeight = cell.cellFigureView.frame.height
        
        var figureType: String
        var figureView: VectorFigure
        switch element.type {
        case .Basic:
            fatalError ("There shouldn't be basic figures")
        case .Rectangle:
            figureType = "Rectangle"
            figureView = Rectangle(frame: CGRect(x: 0, y: 0, width: cellViewFigurewidth, height: cellViewFigureHeight), color: element.color)
        case .Circle:
            figureType = "Circle"
            figureView = Circle(frame: CGRect(x: 0, y: 0, width: cellViewFigurewidth, height: cellViewFigureHeight), color: element.color)
        }
        cell.cellFigureType.text = figureType
        
        cell.cellFigureView.element = figureView
        
        return cell
    }
}

