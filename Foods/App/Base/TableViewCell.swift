//
//  TableViewCell.swift
//  Foods
//
//  Created by Ivan Kopiev on 17.02.2022.
//

import UIKit

class TableViewCell: UITableViewCell, ReusebleCell {
    //MARK: - Properies
    var data: [String : Any] = [:]
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    
    func render(data: [String : Any]) {}
    
    // MARK: - Helpers
    func setUp() {}

}
