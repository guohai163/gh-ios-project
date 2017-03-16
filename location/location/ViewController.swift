//
//  ViewController.swift
//  location
//
//  Created by 郭海 on 2017/3/15.
//  Copyright © 2017年 gh. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    let locationManager:CLLocationManager = CLLocationManager()

    @IBOutlet weak var coorlati: UILabel!
    @IBOutlet weak var coorlong: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100
        
        locationManager.requestAlwaysAuthorization()
        
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.startUpdatingLocation()
            print("localtion start")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currLocation:CLLocation = locations.last!
        label1.text = "海拔: \(currLocation.altitude)"
        label2.text = "速度：\(currLocation.speed)"
        coorlati.text = "纬度：\(currLocation.coordinate.latitude)"
        coorlong.text = "经度：\(currLocation.coordinate.longitude)"
    }


}

