//
//  UIImage+Extensions.swift
//  InteractionMask
//
//  Created by TSD040 on 2018-02-27.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import UIKit

struct ColorByComponents {
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    let alpha: CGFloat
    
    var isClear: Bool {
        return alpha == 0
    }
}

extension UIColor {
    func components() -> ColorByComponents {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return ColorByComponents(red: r, green: g, blue: b, alpha: a)
    }
    
    static func at(image: CGImage, x: Int, y: Int) -> UIColor? {
        if let pixelData = image.dataProvider?.data {
            let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
            return UIColor.at(image: image, data: data, x: x, y: y)
        } else {
            return nil
        }
    }
    
    private static func at(image: CGImage, data: UnsafePointer<UInt8>, x: Int, y: Int) -> UIColor {
        let index = image.bytesPerRow * Int(y) + Int(x) * image.bitsPerPixel / 8
        let color: UIColor
        switch image.alphaInfo {
        case .alphaOnly:
            color = UIColor(red: 0,
                            green: 0,
                            blue: 0,
                            alpha: CGFloat(data[index]) / 255.0)
        case .none:
            color = UIColor(red: CGFloat(data[index]) / 255.0,
                            green: CGFloat(data[index + 1]) / 255.0,
                            blue: CGFloat(data[index + 2]) / 255.0,
                            alpha: 1.0)
        case .noneSkipLast:
            color = UIColor(red: CGFloat(data[index]) / 255.0,
                            green: CGFloat(data[index + 1]) / 255.0,
                            blue: CGFloat(data[index + 2]) / 255.0,
                            alpha: 1.0)
        case .noneSkipFirst:
            color = UIColor(red: CGFloat(data[index + 1]) / 255.0,
                            green: CGFloat(data[index + 2]) / 255.0,
                            blue: CGFloat(data[index + 3]) / 255.0,
                            alpha: 1.0)
        case .first:
            color = UIColor(red: CGFloat(data[index + 1]) / 255.0,
                            green: CGFloat(data[index + 2]) / 255.0,
                            blue: CGFloat(data[index + 3]) / 255.0,
                            alpha: CGFloat(data[index]) / 255.0)
        case .last:
            color = UIColor(red: CGFloat(data[index]) / 255.0,
                            green: CGFloat(data[index + 1]) / 255.0,
                            blue: CGFloat(data[index + 2]) / 255.0,
                            alpha: CGFloat(data[index + 3]) / 255.0)
            
        case .premultipliedLast:
            color = UIColor(red: CGFloat(data[index]) / 255.0,
                            green: CGFloat(data[index + 1]) / 255.0,
                            blue: CGFloat(data[index + 2]) / 255.0,
                            alpha: CGFloat(data[index + 3]) / 255.0)
            
        case .premultipliedFirst:
            color = UIColor(red: CGFloat(data[index + 2]) / 255.0,
                            green: CGFloat(data[index + 1]) / 255.0,
                            blue: CGFloat(data[index]) / 255.0,
                            alpha: CGFloat(data[index + 3]) / 255.0)
        }
        
        return color
    }
}
