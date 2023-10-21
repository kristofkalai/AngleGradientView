//
//  CALayer+Extensions.swift
//
//
//  Created by Kristof Kalai on 2023. 03. 05..
//

import QuartzCore.CoreAnimation

extension CALayer {
    var currentLayer: Self {
        presentation() ?? self
    }
}
