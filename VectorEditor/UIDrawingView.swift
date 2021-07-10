//
//  UIDrawingView.swift
//  VectorEditor
//
//  Created by Oleksii Bashuk on 09.07.2021.
//

import UIKit

class UIDrawingView: UIView {
    var elements = [VectorFigure]()

    override func draw(_ rect: CGRect) {
        for element in elements {
            let path = element.getPath()
            let color = element.color
            
            color.setFill()
            path.fill()
        }
    }
}
