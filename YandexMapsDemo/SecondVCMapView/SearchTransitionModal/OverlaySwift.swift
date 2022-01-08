//
//  OverlaySwift.swift
//  YandexMapsDemo
//
//  Created by NODIR KARIMOV on 07/01/22.
//


import UIKit
import YandexMapsMobile

class OverlayView: UIViewController {
    
    var searchResults: [YMKSearchAddress] = []
    let searchManager = YMKSearch.sharedInstance().createSearchManager(with: .combined)
    var searchSession: YMKSearchSession?
    
    let BOUNDING_BOX = YMKBoundingBox(
        southWest: YMKPoint(latitude: 55.55, longitude: 37.42),
        northEast: YMKPoint(latitude: 55.95, longitude: 37.82))
    let SEARCH_OPTIONS = YMKSearchOptions()
    lazy var geometry = YMKGeometry(boundingBox: BOUNDING_BOX)
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    let cellId = "cellId"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    
    let slideIdicator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        return view
    }()
    
    let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.backgroundImage = UIImage()
        search.barTintColor = #colorLiteral(red: 0.9371626377, green: 0.9373196363, blue: 0.9414473176, alpha: 1)
        search.setImage(UIImage(named: "search"), for: .search, state: .normal)
        search.setImage(UIImage(named: "close"), for: .clear, state: .normal)
        search.placeholder = "Поиск"
        search.searchTextField.font = UIFont(name: "Gilroy", size: 17)
        search.setPositionAdjustment(UIOffset(horizontal: 8, vertical: 0), for: .search)
        search.setPositionAdjustment(UIOffset(horizontal: -6, vertical: 0), for: .clear)
        search.searchTextPositionAdjustment = UIOffset(horizontal: 8, vertical: 0)
        return search
    }()
    
    let searchController = UISearchController()
    
    let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        slideIdicator.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 42, height: 5))
            make.centerX.equalTo(self.view)
            make.topMargin.equalTo(25)
        }
        
        searchBar.snp.makeConstraints { make in
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.top.equalTo(self.slideIdicator.snp.bottom).offset(12)
            make.height.equalTo(35)
        }
        
        searchBar.layer.cornerRadius = 20
        searchBar.clipsToBounds = true
        
        separatorLine.snp.makeConstraints { make in
            make.width.equalTo(self.view.frame.width)
            make.height.equalTo(1)
            make.top.equalTo(self.searchBar.snp.bottom).offset(19)
        }
        
        collectionView.snp.makeConstraints { make in
            make.width.equalTo(self.view.frame.width)
            make.height.equalTo(self.view.frame.height)
            make.top.equalTo(self.separatorLine.snp.bottom).offset(0)
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(slideIdicator)
        view.addSubview(searchBar)
        view.addSubview(separatorLine)
        view.addSubview(collectionView)
        searchBar.delegate = self
        searchBar.searchTextField.delegate = self
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        
        collectionView.register(SearhCell.self, forCellWithReuseIdentifier: cellId)
    }

    
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            //let dragVelocity = sender.velocity(in: view)
            if translation.y >= 150 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
    
    
}




