//
//  VideosTableViewCell.swift
//  TVOSApplication
//
//  Created by Pradeep's Macbook on 04/11/21.
//

import UIKit

protocol VideosTableViewCellDelegate: class{
    func didSelectItem()
}

extension UICollectionViewCell {
    static var emptyCell = UICollectionViewCell()
}

class VideosTableViewCell: UITableViewCell {
    
    @IBOutlet weak var videosCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var videosCollectionView: UICollectionView!
    
    weak var delegate: VideosTableViewCellDelegate?
    
    var cellType: CellType = .latestVideos
    
    var latestVideos: [String] = ["debugging","lazyView","appleSignIn","inheritance","copyOnWrite","methodDispatch"]
    var carousalVideos: [String] = ["tvOS_development","iCode_Banner_Small"]
    var classifiedVideos: [String] = ["Interviews", "Swift UI", "Core Concepts", "DSA"]
    var toolsVideos: [String] = ["simsim","instruments","pusher"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.videosCollectionView.delegate   = self
        self.videosCollectionView.dataSource = self
        self.registerNibs()
    }
    
    func registerNibs() {
        self.videosCollectionView.register(UINib.init(nibName: "VideosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideosCollectionViewCell")
        self.videosCollectionView.register(UINib.init(nibName: "ClassifiedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ClassifiedCollectionViewCell")
        self.videosCollectionView.register(UINib.init(nibName: "ToolsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ToolsCollectionViewCell")
    }
    
}

extension VideosTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch cellType {
        case .carousal:
            return self.carousalVideos.count
        case .latestVideos:
            return self.latestVideos.count
        case .classified:
            return self.classifiedVideos.count
        case .tools:
            return self.toolsVideos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch cellType {
        case .carousal:
            if let carousalCell: VideosCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCollectionViewCell", for: indexPath) as? VideosCollectionViewCell {
                carousalCell.type = .carousal
                carousalCell.posterImageView.image = UIImage(named: self.carousalVideos[indexPath.row])
                carousalCell.posterImageView.contentMode = .scaleAspectFill
                return carousalCell
            }
            return UICollectionViewCell()
        case .latestVideos:
            if let latestVideosCell: VideosCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCollectionViewCell", for: indexPath) as? VideosCollectionViewCell {
                latestVideosCell.type = .latestVideos
                latestVideosCell.posterImageView.image = UIImage(named: self.latestVideos[indexPath.row])
                return latestVideosCell
            }
            return UICollectionViewCell()
        case .classified:
            if let classifiedCell: ClassifiedCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassifiedCollectionViewCell", for: indexPath) as? ClassifiedCollectionViewCell {
                classifiedCell.configure(withTitle: self.classifiedVideos[indexPath.row])
                return classifiedCell
            }
            return UICollectionViewCell()
        case .tools:
            if let toolsCell: ToolsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToolsCollectionViewCell", for: indexPath) as? ToolsCollectionViewCell {
                toolsCell.posterImageView.image = UIImage(named: self.toolsVideos[indexPath.row])
                return toolsCell
            }
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch cellType {
        case .carousal:
            return .init(width: collectionView.frame.size.width - 180, height: collectionView.frame.size.height)
        case .latestVideos, .tools:
            return .init(width: (16/9) * collectionView.frame.size.height, height: collectionView.frame.size.height)
        case .classified:
            return .init(width: 360, height: 360)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem()
    }
    
}
