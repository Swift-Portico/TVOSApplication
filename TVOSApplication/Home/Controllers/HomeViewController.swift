//
//  HomeViewController.swift
//  TVOSApplication
//
//  Created by Pradeep's Macbook on 04/11/21.
//

import UIKit

enum CellType: Int, CaseIterable {
    case carousal
    case latestVideos
    case classified
    case tools
}

extension UITableViewCell {
    static var emptyCell = UITableViewCell()
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    func setupTableView(){
        self.homeTableView.register(UINib.init(nibName: "VideosTableViewCell", bundle: nil), forCellReuseIdentifier: "VideosTableViewCell")
        self.homeTableView.estimatedRowHeight = 300
        self.homeTableView.rowHeight = UITableView.automaticDimension
        self.homeTableView.reloadData()
    }
}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: VideosTableViewCell = tableView.dequeueReusableCell(withIdentifier: "VideosTableViewCell", for: indexPath) as? VideosTableViewCell, let cellType = CellType.init(rawValue: indexPath.row) {
            cell.cellType = cellType
            switch cellType {
            case .carousal:
                cell.titleLabel.isHidden = true
                cell.videosCollectionViewHeightConstraint.constant = 540
            case .latestVideos:
                cell.titleLabel.text = "Latest by iCode"
                cell.videosCollectionViewHeightConstraint.constant = 360
                cell.delegate = self
            case .classified:
                cell.titleLabel.text = "Classified"
                cell.videosCollectionViewHeightConstraint.constant = 360
                cell.videosCollectionView.reloadData()
            case .tools:
                cell.titleLabel.text = "Useful Tools"
                cell.videosCollectionViewHeightConstraint.constant = 300
                cell.videosCollectionView.reloadData()
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}

extension HomeViewController: VideosTableViewCellDelegate {
    
    func didSelectItem() {
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
            self.present(detailVC, animated: true, completion: nil)
        }
    }
}
