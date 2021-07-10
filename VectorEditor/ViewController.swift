//
//  ViewController.swift
//  VectorEditor
//
//  Created by Oleksii Bashuk on 07.07.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var drawingView: UIDrawingView!
    @IBOutlet weak var toolbarView: UIView!
    @IBOutlet var figureButtons: [UIButton]!
    private var pressedButton = FigureTypes.None
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        drawingView.elements.append(Rectangle(frame: CGRect(x: 10, y: 10, width: 100, height: 100), color: UIColor.red))
        drawingView.elements.append(Rectangle(frame: CGRect(x: 400, y: 400, width: 300, height: 300), color: UIColor.blue))
        drawingView.elements.append(Rectangle(frame: CGRect(x: 10, y: 700, width: 10, height: 10), color: UIColor.green))
        drawingView.elements.append(Rectangle(frame: CGRect(x: 700, y: 10, width: 10, height: 10), color: UIColor.yellow))
        
        drawingView.elements.append(Circle(frame: CGRect(x: -50, y: -50, width: 100, height: 100), color: UIColor.black))
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func figureButtonPressed(_ sender: UIButton) {
        var newPressedButton = FigureTypes.None
        for figureType in FigureTypes.allCases {
            if (sender == figureButtons[figureType.rawValue]) {
                newPressedButton = figureType
                break
            }
        }
        
        if (pressedButton == .None) {
            sender.tintColor = UIColor.orange
            pressedButton = newPressedButton
        } else {
            if (pressedButton == newPressedButton) {
                sender.tintColor = toolbarView.backgroundColor
                pressedButton = .None
            } else {
                sender.tintColor = UIColor.orange
                figureButtons[pressedButton.rawValue].tintColor = toolbarView.backgroundColor
                pressedButton = newPressedButton
            }
        }
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
        
        formatter.dateFormat = "HH:mm:ss"
        let timeResult = formatter.string(from: date)
        cell.cellTime.text = timeResult
        
        let cellViewFigurewidth = cell.cellFigureView.frame.width
        let cellViewFigureHeight = cell.cellFigureView.frame.height
        
        var figureType: String
        var figureView: VectorFigure
        switch element.type {
        case .Rectangle:
            figureType = "Rectangle"
            figureView = Rectangle(frame: CGRect(x: 0, y: 0, width: cellViewFigurewidth, height: cellViewFigureHeight), color: element.color)
        case .Circle:
            figureType = "Circle"
            figureView = Circle(frame: CGRect(x: 0, y: 0, width: cellViewFigurewidth, height: cellViewFigureHeight), color: element.color)
        case .None:
            fatalError ("The figure has no type")
        }
        cell.cellFigureType.text = figureType
        cell.cellFigureView.element = figureView
        cell.cellFigureView.setNeedsDisplay()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            drawingView.elements.remove(at: indexPath.row)
            drawingView.setNeedsDisplay()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func tapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        switch pressedButton {
        case .Circle:
            let tapLocation = sender.location(in: drawingView)
            let circleRadius = CGFloat(30)
            drawingView.elements.append(Circle(frame: CGRect(x: tapLocation.x - circleRadius,
                                                             y: tapLocation.y - circleRadius,
                                                             width: 2 * circleRadius,
                                                             height: 2 * circleRadius),
                                               color: UIColor.orange))
            
            drawingView.setNeedsDisplay()
            tableView.reloadData()
        default:
            break
        }
    }
    
    private var panGestureStartPoint = CGPoint()
    @IBAction func panGestureRecognizer(_ sender: UIPanGestureRecognizer) {
        switch pressedButton {
        case .Rectangle:
            switch sender.state {
            case .began:
                panGestureStartPoint = sender.location(in: drawingView)
                drawingView.elements.append(Rectangle(frame: CGRect(x: panGestureStartPoint.x,
                                                                    y: panGestureStartPoint.y,
                                                                    width: 0,
                                                                    height: 0),
                                                      color: UIColor.purple))
                tableView.reloadData()
            case .changed, .ended:
                let panGestureCurrentPoint = sender.location(in: drawingView)
                let upLeftCorner = CGPoint(x: min(panGestureStartPoint.x,
                                                  panGestureCurrentPoint.x),
                                           y: min(panGestureStartPoint.y,
                                                  panGestureCurrentPoint.y))
                let downRightCorner = CGPoint(x: max(panGestureStartPoint.x,
                                                     panGestureCurrentPoint.x),
                                              y: max(panGestureStartPoint.y,
                                                     panGestureCurrentPoint.y))
                
                drawingView.elements.last!.frame = CGRect(x: upLeftCorner.x,
                                                          y: upLeftCorner.y,
                                                          width: downRightCorner.x - upLeftCorner.x,
                                                          height: downRightCorner.y - upLeftCorner.y)
            default:
                break
            }
            
            drawingView.setNeedsDisplay()
        default:
            break
        }
    }
}

