//
//  UIDrawingView.swift
//  VectorEditor
//
//  Created by Oleksii Bashuk on 09.07.2021.
//

import UIKit

class VectorObject {
    let frame: CGRect
    let color: UIColor
    
    init(frame: CGRect, color: UIColor) {
        self.frame = frame
        self.color = color
    }
    
    func getPath() -> UIBezierPath {
        fatalError ("There is no path for basic vector object class")
    }
}

class Rectangle: VectorObject {
    override func getPath() -> UIBezierPath {
        let path = UIBezierPath(rect: frame)
        return path
    }
}

class Circle: VectorObject {
    override func getPath() -> UIBezierPath {
        let path = UIBezierPath(ovalIn: frame)
        return path
    }
}

class UIDrawingView: UIView {
    
    var elements = [VectorObject]()

    override func draw(_ rect: CGRect) {
        for element in elements {
            let path = element.getPath()
            let color = element.color
            
            color.setFill()
            path.fill()
        }
        
//        let pathReck = CGRect(x: 100, y: 100, width: rect.width - 200, height: rect.height - 200)
//        let path = UIBezierPath(roundedRect: pathReck, cornerRadius: 24)
//        let color = UIColor.red
//        color.setFill()
//        path.fill()
    }

}
