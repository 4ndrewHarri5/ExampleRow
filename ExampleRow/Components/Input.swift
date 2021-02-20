//
//  Input.swift
//  ExampleRow
//
//  Created by Andrew Harris on 20/02/2021.
//

import UIKit
import Stevia

class Input: UIView {
    
    var textField: UITextField = UITextField()
    var image: UIImageView = UIImageView()
    
    var state: State
    var layout: Layout
    
    var onChange: (String) -> Void
    
    struct State: Sizeable {
        var text: String? = nil
        var placeholder: String? = nil
        var size: Size = .medium
    }

    init(state: State, layout: Layout = Layout(), onChange: @escaping (String) -> Void) {
        self.state = state
        self.layout = layout
        self.onChange = onChange
        super.init(frame: .zero)
        textField.delegate = self
        updateView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateState(_ state: State? = nil) {
        self.state = state ?? self.state
        updateView()
    }
    
    func updateView() {

        subviews(textField)
        
        textField.top(state.size.padding.top)
        textField.right(state.size.padding.right)
        textField.bottom(state.size.padding.bottom)
        textField.left(state.size.padding.left)
        
        let backgroundColour: UIColor = Theme.current.foreground.secondary

        let textColour: UIColor = Theme.current.text.primary
        
        let placeholderTextColour: UIColor = Theme.current.text.secondary

        style { ui in
            ui.layer.cornerRadius = state.size.radius
            ui.layer.masksToBounds = state.size.radius > 0
            ui.backgroundColor = backgroundColour
        }
        
        textField.style { textField in
            textField.text = state.text ?? textField.text
            textField.textColor = textColour
            textField.attributedPlaceholder = NSAttributedString(
                string: (state.placeholder ?? textField.placeholder) ?? "",
                attributes: [NSAttributedString.Key.foregroundColor: placeholderTextColour]
            )
            textField.font = state.size.font
        }
        
    }
}

extension Input: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        onChange(textField.text ?? "")
    }
}
