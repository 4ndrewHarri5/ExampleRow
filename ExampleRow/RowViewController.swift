//
//  ViewController.swift
//  ExampleRow
//
//  Created by Andrew Harris on 20/02/2021.
//

import UIKit
import Carbon
import Stevia
import MagazineLayout

class RowViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var state: State = State() {
        didSet {
            render()
        }
    }
    
    struct State {
        var inputText: String? = nil
    }
    
    private let renderer = Renderer(
        adapter: ExploreMagazineLayoutAdapter(),
        updater: UICollectionViewUpdater()
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = MagazineLayout()
        collectionView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 20, right: 0)
        collectionView.keyboardDismissMode = .onDrag
        collectionView.collectionViewLayout = layout
        renderer.target = collectionView
        render()
        
    }
    
    private func render() {
        
        renderer.render {
            Section(
                id: "testing row collection",
                cells: {
                    TagCell(id: 1, props: Tag.State(text: self.state.inputText ?? "no text"))
                    Row(id: "testing", views: [
                        Input(
                            state: Input.State(
                                text: self.state.inputText,
                                placeholder: "placeholder"
                            ),
                            onChange: { [weak self] text in
                                self?.state.inputText = text
                            }
                        ),
                        Input(
                            state: Input.State(
                                text: self.state.inputText,
                                placeholder: "placeholder"
                            ),
                            onChange: { [weak self] text in
                                self?.state.inputText = text
                            }
                        )
                    ])
                }
            )
        }
    }


}

