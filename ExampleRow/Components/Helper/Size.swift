//
//  Size.swift
//  ExampleRow
//
//  Created by Andrew Harris on 20/02/2021.
//

import UIKit

protocol Sizeable {
    var size: Size { get }
}

enum Size {
    case small, medium, large
    
    var font: UIFont {
        return self == .small ? .systemFont(ofSize: 16, weight: .regular) : .systemFont(ofSize: 16, weight: .medium)
    }
    var padding: UIEdgeInsets {
        switch self {
        case .small:
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        case .medium:
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        case .large:
            return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        }
    }

    var radius: CGFloat {
        return self == .small ? 5 : 10
    }
}
