//
//  KeyboardButton.swift
//  TVOSApplication
//
//  Created by Pradeep's Macbook on 05/11/21.
//

import UIKit

class KeyboardButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        setTitleColor(.white, for: .normal)
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if(context.nextFocusedView == self) {
            setTitleColor(.orange, for: .normal)
        } else {
            setTitleColor(.white, for: .normal)
        }
    }
    
}
