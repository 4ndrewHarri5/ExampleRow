//
//  Layout.swift
//  ExampleRow
//
//  Created by Andrew Harris on 20/02/2021.
//

import CoreGraphics

protocol Layoutable {
    var layout: Layout { get }
}

struct Layout {
    var portion: CGFloat = 1
}
