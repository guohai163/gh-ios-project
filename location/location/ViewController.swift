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
    
    //保存坐标变量
    var lastLongitude:Float!
    var lastLatitude:Float!
    var lastCity:String!

    @IBOutlet weak var progress: UILabel!
    @IBOutlet weak var coorlati: UILabel!
    @IBOutlet weak var coorlong: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //将事件委托给控制器自己
        locationManager.delegate = self
        //设置定位精度为最佳
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //过滤器每100米更新一次
        locationManager.distanceFilter = 10
        
        locationManager.requestAlwaysAuthorization()
        //检查定位服务是否可用
        if(CLLocationManager.locationServicesEnabled()){
            //开始监听定位
            locationManager.startUpdatingLocation()
            print("localtion start")
        }
        progress.text="-"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currLocation:CLLocation = locations.last!
        label1.text = "海拔: \(currLocation.altitude)"
        label2.text = "速度：\(currLocation.speed)m/s  \(currLocation.speed*60*60/1000)km/h"
        coorlati.text = "纬度：\(currLocation.coordinate.latitude)"
        coorlong.text = "经度：\(currLocation.coordinate.longitude)"
        getCityFromGpsLocation(longitude: Float(currLocation.coordinate.longitude), latitude: Float(currLocation.coordinate.latitude))
        if progress.text == "-"{
            progress.text  = "|"
        }
        else{
            progress.text = "-"
        }
    }
    
    //通过坐标返回城市信息
    func getCityFromGpsLocation(longitude:Float,latitude:Float) -> String{
        var city = ""
        if longitude != lastLongitude || latitude != lastLatitude {
            
            let url = "http://api.map.baidu.com/geocoder/v2/?callback=renderReverse&location=\(latitude),\(longitude)&output=json&pois=1&ak=g5sZlysC3gbXAQOnrnCyEX12FT9iSz5G"
            print(url)
            
            
            //将本次变更存储起来
            lastLatitude = latitude
            lastLongitude = longitude
            lastCity = city
        }

        city = lastCity
        return city
    }
    
    


}

