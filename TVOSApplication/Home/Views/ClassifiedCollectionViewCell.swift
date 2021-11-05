//
//  ClassifiedCollectionViewCell.swift
//  TVOSApplication
//
//  Created by Pradeep's Macbook on 04/11/21.
//

import UIKit

class ClassifiedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.layer.cornerRadius = containerView.frame.height / 2
        self.containerView.clipsToBounds = true
        self.containerView.backgroundColor = .random
        self.containerView.layer.borderWidth = 10
        self.containerView.layer.borderColor = UIColor.clear.cgColor
    }
    
    func configure(withTitle title: String) {
        self.containerView.backgroundColor = .random
        self.titleLabel.text = title
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if(context.nextFocusedView == self) {
            containerView.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
            containerView.layer.borderColor = UIColor.white.cgColor
            titleLabel.transform = .init(scaleX: 1.1, y: 1.1)
        } else {
            containerView.transform = .identity
            containerView.layer.borderColor = UIColor.clear.cgColor
            titleLabel.transform = .identity
        }
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor.init(red: .random(in: 0.65...1), green: .random(in: 0.65...1), blue: .random(in: 0.65...1), alpha: 0.8)
    }
}
