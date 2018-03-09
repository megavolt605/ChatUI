//
//  Tools.swift
//  ssssssss
//
//  Created by Igor Smirnov on 14/02/2018.
//  Copyright © 2018 IS. All rights reserved.
//

import UIKit

extension UIViewAnimationOptions {
    init(curve: UIViewAnimationCurve) {
        switch curve {
        case .easeIn: self = .curveEaseIn
        case .easeOut: self = .curveEaseOut
        case .easeInOut: self = .curveEaseInOut
        case .linear: self = .curveLinear
        }
    }
}
