//
//  DashBoardViewController.swift
//  DBL
//
//  Created by Apple on 28/07/17.
//  Copyright © 2017 SmartMobile Technologies. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
import SwiftyJSON



class DashBoardViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var currentLocationTxtFld: UITextField!
    @IBOutlet weak var DestinationLocationTxtFld: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var btn2: UIButton!
    
    var storeTxtFld = NSString();
    var storeDistance = NSString();
    var Sourcelatitutde = CLLocationDegrees();
    var Sourcelongitude = CLLocationDegrees();
    var Destinationlatitutde = CLLocationDegrees();
    var Destinationlongitude = CLLocationDegrees();


    
    
    
    
    let maxHeaderHeight: CGFloat = 438;
    let minHeaderHeight: CGFloat = 46;
    var previousScrollOffset: CGFloat = 0;
    var busName: [String] = ["1E From:Sec To:E Marredpally", "1E From:Sec To:E Marredpally", "1E From:Sec To:E Marredpally", "1E From:Sec To:E Marredpally", "1E From:Sec To:E Marredpally", "1E From:Sec To:E Marredpally", "1E From:Sec To:E Marredpally", "1E From:Sec To:E Marredpally", "1E From:Sec To:E Marredpally", "1E From:Sec To:E Marredpally", "1E From:Sec To:E Marredpally", "1E From:Sec To:E Marredpally", "1E From:Sec To:E Marredpally", "1E From:Sec To:E Marredpally", "1E From:Sec To:E Marredpally", "1E From:Sec To:E Marredpally",]
//    var busNearBy: [String] = ["Shinnoy", "Mettuguda", "Secunderabad"]
//    var busKM: [String] = ["0.2", "2.5", "3.0"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mapView.camera=GMSCameraPosition.camera(withLatitude: 17.447979, longitude: 78.507915, zoom: 14.5)

        
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude: 17.442793, longitude: 78.505700)
        marker2.title = "Teachers Colony,Entrenchment Rd"
        marker2.snippet = "Secunderabad"
        
        //Creating Marker Pin imageview for Custom Marker
        var imageViewForPinMarker2 : UIImageView
        imageViewForPinMarker2  = UIImageView(frame:CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 25, height: 25)) );
        imageViewForPinMarker2.image = UIImage(named:"bus3")
        marker2.iconView = imageViewForPinMarker2
        marker2.map = mapView

        createMarker()
    btn.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
// Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func createMarker()
    {
        let marker1 = GMSMarker()
        marker1.position = CLLocationCoordinate2D(latitude: 17.447360, longitude: 78.509043)
        marker1.title = "Current Postion"
        marker1.snippet = "E Maredpally,Secunderabad"
        //Creating Marker Pin imageview for Custom Marker
        var imageViewForPinMarker1 : UIImageView
        imageViewForPinMarker1  = UIImageView(frame:CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 25, height: 25)) );
        imageViewForPinMarker1.image = UIImage(named:"current")
        marker1.iconView = imageViewForPinMarker1
        marker1.map = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 17.454160, longitude: 78.512306)
        marker.title = "1E From:Sec To:E Marredpally"

        //Creating Marker Pin imageview for Custom Marker
        var imageViewForPinMarker : UIImageView
        imageViewForPinMarker  = UIImageView(frame:CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 25, height: 25)) );
        imageViewForPinMarker.image = UIImage(named:"bus1")
        marker.iconView = imageViewForPinMarker
        marker.map = mapView
        
        
        let coordinate₀ = CLLocation(latitude:marker.position.latitude, longitude: marker.position.longitude)
        let coordinate₁ = CLLocation(latitude: marker1.position.latitude, longitude: marker1.position.longitude)
        let distanceInMeters = coordinate₀.distance(from: coordinate₁)
        if(distanceInMeters <= 1609)
        {
            print("%@",distanceInMeters)
            
            let speedInMPH = Double(distanceInMeters)
            let speedInKPH = (speedInMPH / 1000)
            print("%@",speedInKPH as Double)
            storeDistance=String(format:"%.1f", speedInKPH) as NSString;
            print("b: \(storeDistance)")
            marker.snippet = String(format:"%@km", storeDistance)
            

//            milesToKilometers(speedInMPH: distanceInMeters)
        }
        else
        {
            print("%@",distanceInMeters)
        }
    }
//@discardableResult func milesToKilometers(speedInMPH:Double) ->Double
//    {
//        let speedInKPH = (speedInMPH / 1000)
//        print("%@",speedInKPH as Double)
//        storeDistance=String(format:"%f", speedInKPH) as NSString;
//        print("b: \(storeDistance)")
//        createMarker()
//        return speedInKPH as Double
//    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.headerHeightConstraint.constant = self.maxHeaderHeight
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField did begin editing method called")
        let acController = GMSAutocompleteViewController()
        acController.delegate = self as GMSAutocompleteViewControllerDelegate
        present(acController, animated: true, completion: nil)

        if textField==currentLocationTxtFld
        {
            storeTxtFld="currentTxtFld"
        }
        else{
            storeTxtFld="destinationTxtFld"
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField did end editing method called")
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("TextField should begin editing method called")

        return true;
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("TextField should clear method called")
        return true;
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("TextField should snd editing method called")
        return true;
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("While entering the characters this method gets called")
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("TextField should return method called")
        textField.resignFirstResponder();
        return true;
    }

    
    @objc func buttonAction(sender: UIButton) {
        print("Button pushed")
        var orginCordinates = CLLocationCoordinate2D()
        orginCordinates.latitude=Sourcelatitutde
        orginCordinates.longitude=Sourcelongitude
        
        var destinationCordinates = CLLocationCoordinate2D()
        destinationCordinates.latitude=Destinationlatitutde
        destinationCordinates.longitude=Destinationlongitude
        
        getPolylineRoute(from: orginCordinates, to: destinationCordinates)
    }

}
extension DashBoardViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(String(describing: place.formattedAddress))")
        print("Place attributions: \(String(describing: place.attributions))")
        dismiss(animated: true, completion: nil)
        
        
                if storeTxtFld .isEqual(to: "currentTxtFld")
                {
                    currentLocationTxtFld.text = place.name
        
                    Sourcelatitutde = place.coordinate.latitude
                    Sourcelongitude = place.coordinate.longitude
                    print("lat lon",Sourcelatitutde,Sourcelongitude)
        
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: Sourcelatitutde, longitude: Sourcelongitude)
                    marker.title = place.name
                    marker.snippet = place.formattedAddress
                    marker.map = mapView
        
        
                }else{
                    DestinationLocationTxtFld.text = place.name
                    Destinationlatitutde = place.coordinate.latitude
                    Destinationlongitude = place.coordinate.longitude
                    print("lat lon",Destinationlatitutde,Destinationlongitude)
        
                    let marker1 = GMSMarker()
                    marker1.position = CLLocationCoordinate2D(latitude: Destinationlatitutde, longitude: Destinationlongitude)
                    marker1.title = place.name
                    marker1.snippet = place.formattedAddress
                    marker1.map = mapView
        
                }

    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: \(error)")
        dismiss(animated: true, completion: nil)
    }
    
    // User cancelled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("Autocomplete was cancelled.")
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    func getPolylineRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D)
    {
        
        let url = URL(string:"https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving")!
        
        /* Fire the request */
        Alamofire.request(url).responseJSON{(responseData) -> Void in
            if((responseData.result.value) != nil) {
                /* read the result value */
                let swiftyJsonVar = JSON(responseData.result.value!)
                /* only get the routes object */
                if let resData = swiftyJsonVar["routes"].arrayObject {
                    let routes = resData as! [[String: AnyObject]]
                    /* loop the routes */
                    if routes.count > 0 {
                        for rts in routes {
                            /* get the point */
                            let overViewPolyLine = rts["overview_polyline"]?["points"]
                            let path = GMSMutablePath(fromEncodedPath: overViewPolyLine as! String)
                            /* set up poly line */
                            let polyline = GMSPolyline.init(path: path)
                            polyline.strokeWidth = 2
                            polyline.map = self.mapView
                        }
                    }
                }
            }
        }
    }
    

}




    extension DashBoardViewController: UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.busName.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell()
            cell.textLabel!.text =  self.busName[indexPath.row]
            
            return cell
        }
    }
    extension DashBoardViewController: UITableViewDelegate {
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let scrollDiff = scrollView.contentOffset.y - self.previousScrollOffset
            
            let absoluteTop: CGFloat = 0;
            let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height;
            let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
            let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom
            
            if canAnimateHeader(scrollView) {
                
                // Calculate new header height
                var newHeight = self.headerHeightConstraint.constant
                if isScrollingDown {
                    newHeight = max(self.minHeaderHeight, self.headerHeightConstraint.constant - abs(scrollDiff))
                } else if isScrollingUp {
                    newHeight = min(self.maxHeaderHeight, self.headerHeightConstraint.constant + abs(scrollDiff))
                }
                // Header needs to animate
                if newHeight != self.headerHeightConstraint.constant {
                    self.headerHeightConstraint.constant = newHeight
                    self.setScrollPosition(self.previousScrollOffset)
                }
                self.previousScrollOffset = scrollView.contentOffset.y
            }}
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            self.scrollViewDidStopScrolling()}
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if !decelerate {
                self.scrollViewDidStopScrolling()
            }}
        func scrollViewDidStopScrolling() {
            let range = self.maxHeaderHeight - self.minHeaderHeight
            let midPoint = self.minHeaderHeight + (range / 2)
            if self.headerHeightConstraint.constant > midPoint {
                self.expandHeader()
            } else {
                self.collapseHeader()
            }
        }
        func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
            // Calculate the size of the scrollView when header is collapsed
            let scrollViewMaxHeight = scrollView.frame.height + self.headerHeightConstraint.constant - minHeaderHeight
            // Make sure that when header is collapsed, there is still room to scroll
            return scrollView.contentSize.height > scrollViewMaxHeight
        }
        func collapseHeader() {
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.2, animations: {
                self.headerHeightConstraint.constant = self.minHeaderHeight
                self.view.layoutIfNeeded()
            })
        }
        func expandHeader() {
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.2, animations: {
                self.headerHeightConstraint.constant = self.maxHeaderHeight
                self.view.layoutIfNeeded()
            })
        }
        func setScrollPosition(_ position: CGFloat) {
            self.tableView.contentOffset = CGPoint(x: self.tableView.contentOffset.x, y: position)
        }
}


