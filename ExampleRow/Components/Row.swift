//
//  Row.swift
//  ExampleRow
//
//  Created by Andrew Harris on 20/02/2021.
//

import UIKit
import Carbon
import Stevia

struct Row: IdentifiableComponent {
    
    var id: String
    var views: [UIView]
    
    func renderContent() -> RowContent {
        RowContent(views: views)
        
    }
    
    func render(in content: RowContent) {
        content.updateState(views)
    }
}

class RowContent: UIView {

    var stack: UIStackView

    var spacing: CGFloat = 8
    
    var views: [UIView] {
        didSet {
            //MARK: UNCOMMENT FOR BEHAVIOUR
//            updateView()
        }
    }
    
    public func updateState(_ views: [UIView]?) {
        self.views = views ?? self.views
    }
    
    required init(views: [UIView]) {
        self.views = views
        self.stack = UIStackView(frame: .zero)
        super.init(frame: .zero)
        self.updateView()
        self.addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
    
    func addViews() {
        subviews(stack)
        
        layout(
            0,
            |stack|,
            0
        )
        
        stack.style { (sv) in
            sv.spacing = spacing
            sv.axis = .horizontal
            sv.distribution = .fill
        }
    }
    
    func updateView() {
        
        /*update the views inside of the stack view here*/
        //This is the only way I can think of updating the stack view as the views are unknown
        stack.removeAllArrangedSubviews()
        stack.arrangedSubviews(views)
        updateViewWidths()
        
    }
    
    private func getPortionForView(view: UIView) -> CGFloat {
        if let view = view as? Layoutable {
            return view.layout.portion
        }
        return 1
    }
    
    func updateViewWidths() {
        let gaps: CGFloat = CGFloat(views.count - 1)
        
        let width = bounds.size.width - (spacing*gaps)
        let portions = views.reduce(0, { (res, data) -> CGFloat in
            res + getPortionForView(view: data)
        })
        let portion = width / portions
    
        views.forEach { (data) in
            data.width(portion*getPortionForView(view: data))
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateViewWidths()
    }
    
}

extension UIStackView {
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach {
            self.removeArrangedSubview($0)
            NSLayoutConstraint.deactivate($0.constraints)
            $0.removeFromSuperview()
        }
    }
}
