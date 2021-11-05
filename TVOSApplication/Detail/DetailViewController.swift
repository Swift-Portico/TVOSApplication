//
//  DetailViewController.swift
//  TVOSApplication
//
//  Created by Pradeep's Macbook on 04/11/21.
//

import UIKit
import AVFoundation
import AVKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var similarTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.similarTableView.register(UINib.init(nibName: "VideosTableViewCell", bundle: nil), forCellReuseIdentifier: "VideosTableViewCell")
        self.similarTableView.estimatedRowHeight = 300
        self.similarTableView.rowHeight = UITableView.automaticDimension
        self.similarTableView.reloadData()
    }
    
    @IBAction func didClickOnPlayButton(_ sender: Any) {
        guard let path = Bundle.main.path(forResource: "Debugging", ofType: "mp4") else {
            debugPrint("videos.mp4 not found")
            return
        }
        
        let avPlayer = AVPlayer(url: URL.init(fileURLWithPath: path))
        let playerVC = AVPlayerViewController()
        
        playerVC.player = avPlayer
        playerVC.player?.currentItem?.externalMetadata = makeExternalMetadata()
        self.present(playerVC, animated: true) {
            avPlayer.play()
        }
    }
    
    func makeExternalMetadata() -> [AVMetadataItem] {
        var metadata = [AVMetadataItem]()
        
        // Build title item
        let titleItem = makeMetadataItem(.commonIdentifierTitle, value: "Improve your Debugging Skills")
        metadata.append(titleItem)
        
        // Build artwork item
        if let image = UIImage(named: "debugging"), let pngData = image.pngData() {
            let artworkItem = makeMetadataItem(.commonIdentifierArtwork, value: pngData)
            metadata.append(artworkItem)
        }
        
        // Build description item
        let descItem = makeMetadataItem(.commonIdentifierDescription, value: """
            Because we spend a lot of time in fixing bugs and improving the performance of the apps, it is very important to have good debugging skills.
            In this video, I’ve summarised some of the debugging skills that I’ve learnt from my experience. These include Breakpoints, LLDB (po, p, v), Network Link Conditioner, Identifying tricky issues which do not occur on simulator/debug mode, View Hierarchy.
            """
        )
        metadata.append(descItem)
        
        // Build genre item
        let genreItem = makeMetadataItem(.quickTimeMetadataGenre, value: "Education")
        metadata.append(genreItem)
        return metadata
    }
    
    private func makeMetadataItem(_ identifier: AVMetadataIdentifier, value: Any) -> AVMetadataItem {
        let item = AVMutableMetadataItem()
        item.identifier = identifier
        item.value = value as? NSCopying & NSObjectProtocol
        item.extendedLanguageTag = "und"
        return item.copy() as! AVMetadataItem
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: VideosTableViewCell = tableView.dequeueReusableCell(withIdentifier: "VideosTableViewCell", for: indexPath) as? VideosTableViewCell {
            cell.cellType = .latestVideos
            cell.latestVideos.removeFirst()
            cell.titleLabel.text = "You may like"
            cell.videosCollectionViewHeightConstraint.constant = 200
            return cell
        }
        return .emptyCell
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
