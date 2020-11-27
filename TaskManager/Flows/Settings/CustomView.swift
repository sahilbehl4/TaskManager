//
//  SeatCustomBackgroundView.swift
//  AirCanadaMobile
//
//  Created by Sahil Behl on 2020-05-29.
//  Copyright © 2020 IBM Canada Ltd. All rights reserved.
//

import UIKit

@IBDesignable
class CustomView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        gradientLayer.startPoint.y = 0
        gradientLayer.endPoint.y = 1
        gradientLayer.colors = [
            UIColor.black.cgColor,
            UIColor.clear.cgColor,
        ]
        gradientLayer.locations = [0, 0.4]
        layer.addSublayer(gradientLayer)
    }
}
