//
//  QRCodeGenerator.swift
//  QRLib
//
//  Created by Kraig Spear on 8/30/16.
//  Copyright © 2016 Meijer. All rights reserved.
//

import Foundation
import CoreImage

public protocol QRCodeGeneratorable {
    func generate(from: String, at: CGSize) -> UIImage
}

public final class QRCodeGenerator: QRCodeGeneratorable {
    
    public init() {}
    
    public func generate(from: String, at: CGSize) -> UIImage {
        let filter = CIFilter(name: "CIQRCodeGenerator")!
        let data = from.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
        
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("Q", forKey: "inputCorrectionLevel")
        
        let outputImage = filter.outputImage!
        
        let scaleX = at.width / outputImage.extent.size.width
        let scaleY = at.height / outputImage.extent.size.height
        
        let transformedImage = outputImage.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
        
        return UIImage(ciImage: transformedImage)
    }
}
