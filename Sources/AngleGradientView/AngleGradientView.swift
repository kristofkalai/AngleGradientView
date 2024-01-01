//
//  AngleGradientView.swift
//
//
//  Created by Kristof Kalai on 2023. 03. 05..
//

import UIKit
import struct SwiftUI.Angle

final class GradientView: UIView {
    final class GradientLayer: CAGradientLayer {
        @NSManaged var angleInDegrees: CGFloat
        var angleDidUpdate: ((Angle) -> Void)?

        override init(layer: Any) {
            super.init(layer: layer)
            if let layer = layer as? Self {
                angleInDegrees = layer.angleInDegrees
                angleDidUpdate = layer.angleDidUpdate
            }
        }

        override init() {
            super.init()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }

        override class func needsDisplay(forKey key: String) -> Bool {
            key == #keyPath(angleInDegrees) ? true : super.needsDisplay(forKey: key)
        }

        override func action(forKey event: String) -> CAAction? {
            switch event {
            case #keyPath(angleInDegrees):
                let context = action(forKey: #keyPath(backgroundColor)) as? CABasicAnimation
                guard let animation = context?.copy() as? CABasicAnimation else { return nil }
                animation.keyPath = event
                animation.fromValue = presentation()?.value(forKeyPath: event)
                animation.toValue = nil
                return animation
            default:
                return super.action(forKey: event)
            }
        }

        override func draw(in ctx: CGContext) {
            super.draw(in: ctx)
            apply(degrees: currentLayer.angleInDegrees, on: model())
            angleDidUpdate?(.degrees(currentLayer.angleInDegrees))
        }
    }

    var colors: [UIColor]? {
        get {
            layer.color
        }
        set {
            layer.color = newValue
        }
    }

    var locations: [CGFloat]? {
        get {
            layer.location
        }
        set {
            layer.location = newValue
        }
    }

    var angle: Angle /* .zero means top to bottom gradient */ {
        get {
            .init(degrees: layer.angleInDegrees)
        }
        set {
            layer.angleInDegrees = .init(newValue.degrees)
        }
    }

    var angleDidUpdate: ((Angle) -> Void)? {
        get {
            layer.angleDidUpdate
        }
        set {
            layer.angleDidUpdate = newValue
        }
    }

    override class var layerClass: AnyClass {
        GradientLayer.self
    }

    override var layer: GradientLayer {
        super.layer as! GradientLayer
    }

    init(frame: CGRect = .zero, colors: [UIColor]? = nil, locations: [CGFloat]? = nil, angle: Angle = .zero, angleDidUpdate: ((Angle) -> Void)? = nil) {
        super.init(frame: frame)
        self.colors = colors
        self.locations = locations
        self.angle = angle
        self.angleDidUpdate = angleDidUpdate
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
