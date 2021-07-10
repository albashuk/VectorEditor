//
//  VectorObject.swift
//  VectorEditor
//
//  Created by Oleksii Bashuk on 09.07.2021.
//

import UIKit

enum FigureTypes: Int, CaseIterable {
    case Rectangle
    case Circle
    case None
}

class VectorFigure {
    let date = Date()
    var type = FigureTypes.None
    
    var frame: CGRect
    var color: UIColor
    
    init() {
        self.frame = CGRect()
        self.color = UIColor()
    }
    
    init(frame: CGRect, color: UIColor) {
        self.frame = frame
        self.color = color
    }
    
    func getPath() -> UIBezierPath {
        fatalError ("There is no path for basic vector figure class")
    }
}

class Rectangle: VectorFigure {
    override init(frame: CGRect, color: UIColor) {
        super.init(frame: frame, color: color)
        type = FigureTypes.Rectangle
    }
    
    override func getPath() -> UIBezierPath {
        let path = UIBezierPath(rect: frame)
        return path
    }
}

class Circle: VectorFigure {
    override init(frame: CGRect, color: UIColor) {
        super.init(frame: frame, color: color)
        type = FigureTypes.Circle
    }
    
    override func getPath() -> UIBezierPath {
        let path = UIBezierPath(ovalIn: frame)
        return path
    }
}
