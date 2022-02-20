//
//  Models.swift
//  Foods
//
//  Created by Ivan Kopiev on 18.02.2022.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    var sections: [Section]
}

// MARK: - Section
struct Section: Codable {
    let id, header: String
    let itemsTotal, itemsToShow: Int
    var items: [Item]
    var number: Int? = 0 {didSet {updateItems()}}
    
    mutating func updateItems() {
        for index in 0..<items.count {
            items[index].section = number
            items[index].isSelected = false
        }
    }
}

// MARK: - Item
struct Item: Codable {
    var id: String = ""
    var image: Image 
    var title: String = ""
    var isSelected: Bool? = false
    var section: Int? = 0
    
    mutating func toggle() {isSelected = !(isSelected ?? true)}
}

// MARK: - Image
struct Image: Codable {
    let the1X, the2X, the3X: String
    let aspectRatio: Int?
    let loopAnimation: Bool?

    enum CodingKeys: String, CodingKey {
        case the1X = "1x"
        case the2X = "2x"
        case the3X = "3x"
        case aspectRatio, loopAnimation
    }
}
