//
//  AngleGradientView.swift
//
//
//  Created by Kristof Kalai on 2023. 03. 05..
//

import UIKit
import struct SwiftUI.Angle

public final class AngleGradientView: UIView {
    private class GradientLayer: CAGradientLayer {
        @NSManaged private var angleInDegrees: CGFloat
        private var context: CABasicAnimation?
        fileprivate var angleDidUpdateHook: ((Angle) -> Void)?

        override init(layer: Any) {
            super.init(layer: layer)
            if let layer = layer as? GradientLayer {
                angleInDegrees = layer.angleInDegrees
                angleDidUpdateHook = layer.angleDidUpdateHook
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

        override class func defaultAction(forKey event: String) -> CAAction? {
            // disable implicit animations
            [#keyPath(angleInDegrees), #keyPath(startPoint), #keyPath(endPoint)].contains(event) ? NSNull() : CAGradientLayer.defaultAction(forKey: event)
        }

        override func action(forKey event: String) -> CAAction? {
            guard event == #keyPath(angleInDegrees) else {
                return super.action(forKey: event)
            }
            guard let animation = context?.copy() as? CABasicAnimation else {
                return NSNull()
            }
            CATransaction.commit {
                animation.keyPath = event
                animation.fromValue = currentLayer.angleInDegrees
                animation.toValue = nil
            } completion: { [weak self] in
                self?.context = nil
            }
            return animation
        }

        override func draw(in ctx: CGContext) {
            super.draw(in: ctx)
            apply(angle: currentLayer.angleInDegrees, on: model())
            angleDidUpdateHook?(.degrees(currentLayer.angleInDegrees))
        }

        fileprivate func set(angle: CGFloat, with context: CAAction?) {
            self.context = (context as? CABasicAnimation)?.copy() as? CABasicAnimation
            angleInDegrees = angle
        }
    }

    public var colors: [UIColor] = [] {
        didSet {
            updateGradient()
        }
    }
    public var locations: [CGFloat]? = nil {
        didSet {
            updateGradient()
        }
    }
    public var angle: Angle = .zero /* .zero means top to bottom gradient */ {
        didSet {
            updateGradient()
        }
    }
    public var angleDidUpdateHook: ((Angle) -> Void)? {
        get {
            gradientLayer.angleDidUpdateHook
        }
        set {
            gradientLayer.angleDidUpdateHook = newValue
        }
    }

    private let gradientLayer = GradientLayer()

    public init(colors: [UIColor] = [], locations: [CGFloat]? = nil, angle: Angle = .degrees(.zero), frame: CGRect = .zero, angleDidUpdateHook: ((Angle) -> Void)? = nil) {
        self.colors = colors
        self.locations = locations
        self.angle = angle
        super.init(frame: frame)
        self.angleDidUpdateHook = angleDidUpdateHook

        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

extension AngleGradientView {
    private func setupView() {
        layer.addSublayer(gradientLayer)
        updateGradient()
    }
}

extension AngleGradientView {
    public override var bounds: CGRect {
        didSet {
            gradientLayer.frame = bounds
        }
    }
}

extension AngleGradientView {
    private func updateGradient() {
        gradientLayer.color = colors
        gradientLayer.location = locations
        gradientLayer.set(angle: angle.degrees, with: action(for: gradientLayer, forKey: #keyPath(backgroundColor)))
    }
}
