//
//  CustomTableViewCell.swift
//  VectorEditor
//
//  Created by Oleksii Bashuk on 07.07.2021.
//

import UIKit

class UICustomCellFigureView: UIView {
    var element = VectorFigure()

    override func draw(_ rect: CGRect) {
        if (element.type != .Basic) {
            let path = element.getPath()
            let color = element.color
            
            color.setFill()
            path.fill()
        }
    }
}

class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cellTime: UILabel!
    @IBOutlet weak var cellDate: UILabel!
    @IBOutlet weak var cellFigureType: UILabel!
    @IBOutlet weak var cellFigureView: UICustomCellFigureView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
