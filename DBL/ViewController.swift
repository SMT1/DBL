//
//  ViewController.swift
//  DBL
//
//  Created by Apple on 26/07/17.
//  Copyright © 2017 SmartMobile Technologies. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableViewHeader: UIView!
    @IBOutlet weak var tableVIew: UITableView!
    var busName: [String] = ["We", "Heart", "Swift"]
    var busNearBy: [String] = ["Shinnoy", "Mettuguda", "Secunderabad"]
    var busKM: [String] = ["0.2", "2.5", "3.0"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let  mapView = GMSMapView.map(withFrame: CGRect(x: 8, y:90, width: 359, height: 243), camera: GMSCameraPosition.camera(withLatitude: 17.447979, longitude: 78.507915, zoom: 5.5))
       tableViewHeader.addSubview(mapView)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 17.447979, longitude: 78.507915)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        //123456

//
//        
//        let maxHeaderHeight: CGFloat = 88;
//        let minHeaderHeight: CGFloat = 44;
//
//        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section:    Int) -> Int
    {
        return self.busName.count;

    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: DataTableViewCell!
        
        let firstCellIdentifier = "DataLoadCell"
            cell = tableVIew.dequeueReusableCell(withIdentifier: firstCellIdentifier, for: indexPath as IndexPath) as! DataTableViewCell
        
        cell.lblbusName?.text = self.busName[indexPath.row]
        cell.lblNearBy?.text = self.busNearBy[indexPath.row]
        cell.lblKm?.text = self.busKM[indexPath.row]


        return cell

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
            return 60.0;
     
    }

}

