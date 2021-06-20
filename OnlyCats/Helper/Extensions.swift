//
//  Extensions.swift
//  OnlyCats
//
//  Created by Clara Jeon on 6/18/21.
//

import Foundation
import UIKit

extension Notification.Name {
    static var signInGoogleCompleted: Notification.Name {
        return .init(rawValue: #function)
    }
    
    static var returnUserSignInGoogleCompleted: Notification.Name {
        return .init(rawValue: #function)
    }
}

//Designables for conveinience in storyboard
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
