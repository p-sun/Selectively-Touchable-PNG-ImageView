//
//  TouchableMaskView.swift
//  InteractionMask
//
//  Created by TSD040 on 2018-02-27.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import UIKit

class TouchableMaskView: UIImageView {
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard let image = image, let cgImage = image.cgImage else { return false }
        
        // i.e.
        // bounds.width == 100 && image.size.width == 400
        // Thus, currentToOriginalRatio == 0.25
        // Thus, a tap at (25, 25) on the current image is (100, 100) on the original image
        let currentToOriginalRatio = bounds.width / image.size.width
        let pointInsideOriginal = CGPoint(x: point.x / currentToOriginalRatio,
                                          y: point.y / currentToOriginalRatio)
        
        guard let colorAtPoint = UIColor.at(image: cgImage, x: Int(pointInsideOriginal.x), y: Int(pointInsideOriginal.y)) else {
            return false
        }

        return !colorAtPoint.components().isClear
    }
}
