//
//  CollectionViewCell.swift
//  Foods
//
//  Created by Ivan Kopiev on 17.02.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell, ReusebleCell {
    //MARK: - Properies
    var data: [String : Any?] = [:]
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    func render(data: [String : Any?]) {}
    
    // MARK: - Helpers
    func setUp() {}

}
