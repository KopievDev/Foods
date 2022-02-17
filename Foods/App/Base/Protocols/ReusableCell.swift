//
//  ReusableCell.swift
//  Foods
//
//  Created by Ivan Kopiev on 17.02.2022.
//

import Foundation

protocol ReusebleCell {
    var data: [String:Any?] { get set }
    func render(data: [String:Any?])
}
