//
//  SecondVCExtension.swift
//  YandexMapsDemo
//
//  Created by NODIR KARIMOV on 07/01/22.
//

import UIKit
import YandexMapsMobile
import CoreLocation

extension SecondViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension SecondViewController {
    
    func setupLocation() {
        mapView.mapWindow.map.isRotateGesturesEnabled = false
        mapView.mapWindow.map.move(with: YMKCameraPosition(target: TARGET_LOCATION, zoom: 14, azimuth: 0, tilt: 0))
        
        let mapKit = YMKMapKit.sharedInstance()
        userLocationLayer = mapKit.createUserLocationLayer(with: mapView.mapWindow)
        userLocationLayer.setVisibleWithOn(true)
        userLocationLayer.isHeadingEnabled = true
        
        mapView.mapWindow.map.addCameraListener(with: self)
    }
    
    func updateLabel(_ target: YMKPoint) {
//        customButton.titleLabel?.text = "Wait ..."
        let newLocation = CLLocation(latitude: target.latitude, longitude: target.longitude)
        geocoder.reverseGeocodeLocation(newLocation) { [weak self] (placemarks, error) in
            if error == nil, let place = placemarks, !place.isEmpty {
                if let street = place.first?.thoroughfare {
                    if let house = place.first?.name {
//                        self?.searchText.text = "\(house), \(street)"
                        print("\(house), \(street)")
                    }
                }
            } else {
//                self?.customButton.titleLabel?.text = "Error ..."
                print("Location error \(String(describing: error))")
            }
        }
    }
    
}


extension SecondViewController: YMKMapCameraListener {
    func onCameraPositionChanged(with map: YMKMap,
                                 cameraPosition: YMKCameraPosition,
                                 cameraUpdateReason: YMKCameraUpdateReason,
                                 finished: Bool) {
        if finished {
            updateLabel(cameraPosition.target)
        }
    }
}


