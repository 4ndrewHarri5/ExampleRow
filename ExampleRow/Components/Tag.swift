//
//  Tag.swift
//  ExampleRow
//
//  Created by Andrew Harris on 20/02/2021.
//

import UIKit
import Stevia
import Carbon


struct TagCell: IdentifiableComponent, Layoutable  {
    
    typealias Content = Tag
    
    var id: Int
    var layout: Layout = Layout()
    var props: Tag.State
    
    func renderContent() -> Tag {
        Tag(state: props, layout: layout)
    }
    
    func render(in content: Tag) {
        content.updateState(props)
    }
    
}

class Tag: UIView, Layoutable {

    var label: UILabel = UILabel()
    
    var state: State
    var layout: Layout
    
    struct State: Sizeable {
        var text: String? = nil
        var size: Size = .medium
        var alignment: NSTextAlignment = .left
    }
    
    required init(state: State, layout: Layout = Layout()) {
        self.state = state
        self.layout = layout
        super.init(frame: .zero)
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
        
        subviews(
            label
        )
        
        label.top(state.size.padding.top)
        label.bottom(state.size.padding.bottom)
        label.left(state.size.padding.left)
        label.right(state.size.padding.right)
 
        let backgroundColour: UIColor = Theme.current.foreground.secondary

        let textColour: UIColor = Theme.current.text.primary
        
        self.style { ui in
            ui.backgroundColor = backgroundColour
            ui.layer.cornerRadius = state.size.radius
            ui.layer.masksToBounds = state.size.radius > 0
        }
        
        label.style { label in
            label.text = state.text
            label.textColor = textColour
            label.font = state.size.font
            label.numberOfLines = 0
            label.textAlignment = state.alignment
        }

    }
}
