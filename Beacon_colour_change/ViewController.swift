//
//  ViewController.swift
//  Iflow_beacon
//
//  Created by Parnak on 3/7/18.
//  Copyright © 2018 Parnak. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    func rangeBeacon(){
        
        let uuid = UUID(uuidString: "B825F8C7-57B6-23BA-A1BE-2786CC33B3A5")! // Fill in the UUID value
        let minor = 0// Fill in the minor value
        let major = 0//Fill in the Major value
        let identifier = "TEMP_MEASURE"
        
        let region = CLBeaconRegion(proximityUUID: uuid, identifier: identifier)
        
        locationManager.startRangingBeacons(in: region)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways{
            rangeBeacon()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        guard let discoveredBeaconProximity = beacons.first?.proximity else { print("Couldn't find beacon");return}
        
        
        let backgroundColour:UIColor = {
            
            switch discoveredBeaconProximity {
                
            case .immediate: return UIColor.green
            case .near: return UIColor.orange
            case .far: return UIColor.red
            case .unknown: return UIColor.black
                
            }
            
        }()
        view.backgroundColor = backgroundColour
    }
    
    
}

