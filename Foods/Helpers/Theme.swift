//
//  Theme.swift
//  Foods
//
//  Created by Ivan Kopiev on 17.02.2022.
//

import UIKit

enum Screen {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height

}

enum Theme {
    static let textColor: UIColor = UIColor(red: 50, green: 54, blue: 83)
    static let backgroundColor: UIColor = UIColor(red: 245, green: 246, blue: 247)
    static let selectedColor: UIColor = UIColor(red: 126, green: 139, blue: 277)
    static func getCellColor(from image: UIImage?) -> UIColor {image?.getPixelColor(pos: CGPoint(x: 10, y: 10)) ?? UIColor()}
}

extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIImage {
    func getPixelColor(pos: CGPoint) -> UIColor {

        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4

        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)

        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
}

extension String {
    func add(attributs params: (UIFont, UIColor)) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString()
            attributedString.append(
                NSMutableAttributedString(string: self,
                                          attributes:
                                            [NSAttributedString.Key.font :params.0,
                                             NSAttributedString.Key.foregroundColor : params.1]))
        return attributedString
    }
}
