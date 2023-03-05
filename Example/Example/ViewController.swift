//
//  ViewController.swift
//  Example
//
//  Created by Kristof Kalai on 2023. 03. 05..
//

import AngleGradientView
import UIKit

final class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let gradient = AngleGradientView(colors: [.red, .blue, .black], locations: [0, 0.75, 1], angle: .degrees(-90))
        gradient.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gradient)
        gradient.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        gradient.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        gradient.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        gradient.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        gradient.angleDidUpdateHook = {
            print($0.degrees)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 5) {
                gradient.angle = .radians(.pi)
            } completion: { _ in
                UIView.animate(withDuration: 5) {
                    gradient.angle = .zero
                }
            }
        }
    }
}
