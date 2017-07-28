//
//  DashBoardViewController.swift
//  DBL
//
//  Created by Apple on 28/07/17.
//  Copyright © 2017 SmartMobile Technologies. All rights reserved.
//

import UIKit
import GoogleMaps

class DashBoardViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var txtFld: UITextField!
    @IBOutlet weak var txtFld1: UITextField!
    let maxHeaderHeight: CGFloat = 319;
    let minHeaderHeight: CGFloat = 46;
    var previousScrollOffset: CGFloat = 0;
    var busName: [String] = ["We", "Heart", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift", "Swift"]
    var busNearBy: [String] = ["Shinnoy", "Mettuguda", "Secunderabad"]
    var busKM: [String] = ["0.2", "2.5", "3.0"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.camera=GMSCameraPosition.camera(withLatitude: 17.447979, longitude: 78.507915, zoom: 5.5)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 17.447979, longitude: 78.507915)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.headerHeightConstraint.constant = self.maxHeaderHeight
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



