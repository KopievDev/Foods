//
//  ItemCounter.swift
//  Foods
//
//  Created by Ivan Kopiev on 20.02.2022.
//

import Foundation

protocol Counter: AnyObject {
    func canSelect(item: Item) -> Item
}

class ItemCounter: Counter {
    
    var countSelected: Int = 0
    var maxSelected: Int = 6
    
    init(maxSelected: Int) {self.maxSelected = maxSelected}
    
    func canSelect(item: Item) -> Item {
        var copyItem = item
        let select = countSelected + 1
        let deSelect = countSelected - 1
        guard let isSelect = copyItem.isSelected else {return copyItem}
        if !isSelect && countSelected == maxSelected {
            Notify.showError(title: "Selected the maximum number of cells")
        } else {
            countSelected = isSelect ? deSelect:select
            copyItem.toggle()
        }
        return copyItem
    }
    
}
