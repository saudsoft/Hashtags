//
//  Extensions.swift
//  Image for Instagram
//
//  Created by Saud Almutlaq on 16/05/2020.
//  Copyright © 2020 Saud Soft. All rights reserved.
//

import Foundation
import UIKit
import TagListView

extension UIView {
    
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

extension UIImage {
    // MARK: - UIImage+Resize
    
    func scaleImageWithAspectToWidth(toWidth:CGFloat) -> UIImage {
        let oldWidth:CGFloat = size.width
        let scaleFactor:CGFloat = toWidth / oldWidth
        
        let newHeight = self.size.height * scaleFactor
        let newWidth = oldWidth * scaleFactor;
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

extension UIStackView {

    func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }

    func removeFullyAllArrangedSubviews() {
        arrangedSubviews.forEach { (view) in
            removeFully(view: view)
        }
    }

}

/// Add border to UIButton like the buttons on AppStore
@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

extension TagListView {
    func fontSize(ofSize: CGFloat) {
        self.textFont = UIFont.systemFont(ofSize: ofSize)
    }
}
