//
//  AngleGradientView.swift
//
//
//  Created by Kristof Kalai on 2023. 03. 05..
//

import UIKit
import struct SwiftUI.Angle

public final class AngleGradientView: UIView {
    final private class GradientLayer: CAGradientLayer {
        @NSManaged fileprivate var angleInDegrees: CGFloat
        fileprivate var angleDidUpdate: ((Angle) -> Void)?

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

    public var colors: [UIColor]? {
        get {
            _layer.color
        }
        set {
            _layer.color = newValue
        }
    }

    public var locations: [CGFloat]? {
        get {
            _layer.location
        }
        set {
            _layer.location = newValue
        }
    }

    public var angle: Angle /* .zero means top to bottom gradient */ {
        get {
            .init(degrees: _layer.angleInDegrees)
        }
        set {
            _layer.angleInDegrees = .init(newValue.degrees)
        }
    }

    public var angleDidUpdate: ((Angle) -> Void)? {
        get {
            _layer.angleDidUpdate
        }
        set {
            _layer.angleDidUpdate = newValue
        }
    }

    private var _layer: GradientLayer {
        layer as! GradientLayer
    }

    public override class var layerClass: AnyClass {
        GradientLayer.self
    }

    public init(frame: CGRect = .zero, colors: [UIColor]? = nil, locations: [CGFloat]? = nil, angle: Angle = .zero, angleDidUpdate: ((Angle) -> Void)? = nil) {
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
