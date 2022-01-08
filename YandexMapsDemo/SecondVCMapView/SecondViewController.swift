//
//  SecondViewController.swift
//  YandexMapsDemo
//
//  Created by NODIR KARIMOV on 07/01/22.
//

import UIKit
import YandexMapsMobile
import CoreLocation

class SecondViewController: UIViewController {
    
    var userLocationLayer: YMKUserLocationLayer!
    let TARGET_LOCATION = YMKPoint(latitude: 55.755785999230845, longitude: 37.61763300000001)
    let geocoder = CLGeocoder()
    
    let customButton = CustomIconButton()
    
    let mapView: YMKMapView = {
        let mapView = YMKMapView()
        return mapView
    }()
    
    let pinImageView: UIImageView = {
        let pin = UIImageView()
        pin.image = UIImage(named: "pin")
        pin.contentMode = .scaleAspectFit
        return pin
    }()
    
//    let searchText: UILabel = {
//        let label = UILabel()
//        label.backgroundColor = .lightGray
//        label.textColor = .black
//
//        return label
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        view.addSubview(pinImageView)
       // view.addSubview(searchText)
        
        mapView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        pinImageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 72, height: 88.8))
        pinImageView.center = view.center
        
       // searchText.frame = CGRect(x: 50, y: 120, width: 300, height: 50)
        
        configureYMKMaps()
        topCustomButton()
        setupLocation()
    }
    
    private func configureYMKMaps() {
        mapView.mapWindow.map.move(
            with: YMKCameraPosition.init(target: YMKPoint(latitude: 55.751574, longitude: 37.573856), zoom: 15, azimuth: 0, tilt: 0),
            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
            cameraCallback: nil)
    }
    
    @objc func showMiracle() {
        let slideVC = OverlayView()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    private func topCustomButton() {
        customButton.addTarget(self, action: #selector(showMiracle), for: .touchUpInside)
        view.addSubview(customButton)
        
        customButton.snp.makeConstraints { make in
            make.top.equalTo(35)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.size.equalTo(CGSize(width: view.frame.width, height: 53))
        }
        
        customButton.configure(with: CustomIconButtonViewModel(text: "Поиск",
                                                           image: UIImage(named: "search"),
                                                           image2: UIImage(named: "dict"),
                                                           bgColor: #colorLiteral(red: 0.9371626377, green: 0.9373196363, blue: 0.9414473176, alpha: 1)
        ))
    }
}
