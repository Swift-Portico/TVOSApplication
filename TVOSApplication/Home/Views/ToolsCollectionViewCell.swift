//
//  ToolsCollectionViewCell.swift
//  TVOSApplication
//
//  Created by Pradeep's Macbook on 04/11/21.
//

import UIKit

class ToolsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureImageView()
    }
    
    func configureImageView() {
        posterImageView.layer.cornerRadius = 20
        posterImageView.clipsToBounds = true
        posterImageView.layer.borderWidth = 10
        posterImageView.layer.borderColor = UIColor.clear.cgColor
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if(context.nextFocusedView == self) {
            posterImageView.layer.borderColor = UIColor.gray.cgColor
        } else {
            posterImageView.layer.borderColor = UIColor.gray.cgColor
        }
    }
}
