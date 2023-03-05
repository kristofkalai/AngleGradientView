//
//  CATransaction+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2023. 03. 05..
//

import QuartzCore.CoreAnimation

extension CATransaction {
    @discardableResult static func commit<T>(withAnimation: Bool = true, timingFunction: CAMediaTimingFunction? = nil, duration: TimeInterval? = nil, _ block: () throws -> T, completion: @escaping () -> Void = { }) rethrows -> T {
        begin()
        setAnimationTimingFunction(timingFunction)
        setCompletionBlock(completion)
        setDisableActions(!withAnimation)
        if let duration = duration {
            setAnimationDuration(duration)
        }
        defer {
            commit()
        }
        return try block()
    }
}
