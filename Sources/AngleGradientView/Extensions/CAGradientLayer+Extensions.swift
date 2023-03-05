//
//  CAGradientLayer+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2023. 03. 05..
//

import QuartzCore.CoreAnimation
import UIKit.UIColor

extension CAGradientLayer {
    var location: [CGFloat]? {
        get {
            locations?.compactMap { CGFloat(exactly: $0) }
        }
        set {
            locations = newValue?.map { Double($0) }.map { NSNumber(value: $0) }
        }
    }

    var color: [UIColor]? {
        get {
            colors?.map { $0 as! CGColor }.compactMap { UIColor(cgColor: $0) }
        }
        set {
            colors = newValue?.map(\.cgColor)
        }
    }

    func apply(angle: CGFloat /* .zero means top to bottom gradient */, on layer: CAGradientLayer? = nil) {
        let x = angle / 360
        let a = pow(sinf(Float(2 * .pi * ((x + 0.75) / 2))), 2)
        let b = pow(sinf(Float(2 * .pi * ((x + 0.00) / 2))), 2)
        let c = pow(sinf(Float(2 * .pi * ((x + 0.25) / 2))), 2)
        let d = pow(sinf(Float(2 * .pi * ((x + 0.50) / 2))), 2)

        let endPoint = CGPoint(x: CGFloat(c), y: CGFloat(d))
        let startPoint = CGPoint(x: CGFloat(a), y: CGFloat(b))
        if let layer {
            layer.endPoint = endPoint
            layer.startPoint = startPoint
        } else {
            self.endPoint = endPoint
            self.startPoint = startPoint
        }
    }
}
