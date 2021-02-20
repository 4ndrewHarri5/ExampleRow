//
//  TextFieldDelegate.swift
//  ExampleRow
//
//  Created by Andrew Harris on 20/02/2021.
//

import Foundation
protocol TextFieldDelegate: class {
    func textDidChange(text: String?)
}
