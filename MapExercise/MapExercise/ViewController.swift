//
//  ViewController.swift
//  MapExercise
//
//  Created by vibin joby on 2020-01-20.
//  Copyright © 2020 vibin joby. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

    @IBOutlet weak var totalDistanceLbl: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    let locManager = CLLocationManager()
    var locationArr = [CLLocation]()
    var totalKm = Double()
    override func viewDidLoad() {
        super.viewDidLoad()
        setMapsLocation()
        self.mapView.delegate = self
    }
    
    func setMapsLocation() {
        let regionRadius: CLLocationDistance = 2000
        
        let location = CLLocationCoordinate2DMake(43.6960,-79.2937)
        
        let coordinateRegion = MKCoordinateRegion(center: location,
                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.mapType = .satellite
    }
    
    @IBAction func onTouch(_ sender: UITapGestureRecognizer) {
        if locationArr.count < 5 {
            let touchPoint = sender.location(in: self.mapView)
            let cordinates = mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
            let annot = MKPointAnnotation()
            annot.coordinate = cordinates
            if locationArr.count != 5 {
                mapView.addAnnotation(annot)
            }
            let clLocation = CLLocation(latitude:cordinates.latitude,longitude: cordinates.longitude)
            locationArr.append(clLocation)
        }
        if locationArr.count > 1 {
            var firstPoint = CLLocation()
            var secondPoint = CLLocation()
            if locationArr.count == 5 {
                firstPoint = locationArr[locationArr.count - 2]
                secondPoint = locationArr[locationArr.count - 1]
                
                let c1 = MKMapPoint(firstPoint.coordinate)
                let c2 = MKMapPoint(secondPoint.coordinate)
                let p1 = MKMapPoint(x: c1.x, y: c1.y)
                let p2 = MKMapPoint(x: c2.x, y: c2.y)
                let points = [p1,p2]
                let p = MKPolyline(points: points, count: 2)
                self.mapView.addOverlay(p)
                
                firstPoint = locationArr[locationArr.count - 1]
                secondPoint = locationArr[0]
                
                let c11 = MKMapPoint(firstPoint.coordinate)
                let c21 = MKMapPoint(secondPoint.coordinate)
                let p11 = MKMapPoint(x: c11.x, y: c11.y)
                let p21 = MKMapPoint(x: c21.x, y: c21.y)
                let points1 = [p11,p21]
                let p_1 = MKPolyline(points: points1, count: 2)
                self.mapView.addOverlay(p_1)
                
                totalKm = totalKm + (firstPoint.distance(from: secondPoint) / 1000)
                totalDistanceLbl.text = "total \(totalKm) km"
            } else if locationArr.count < 6 {
                firstPoint = locationArr[locationArr.count - 2]
                secondPoint = locationArr[locationArr.count - 1]
                
                let c1 = MKMapPoint(firstPoint.coordinate)
                let c2 = MKMapPoint(secondPoint.coordinate)
                let p1 = MKMapPoint(x: c1.x, y: c1.y)
                let p2 = MKMapPoint(x: c2.x, y: c2.y)
                let points = [p1,p2]
                let p = MKPolyline(points: points, count: 2)
                self.mapView.addOverlay(p)
                
                totalKm = totalKm + (firstPoint.distance(from: secondPoint) / 1000)
                totalDistanceLbl.text = "total \(totalKm) km"
            }
            
            
            
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let overlay = overlay as? MKPolyline {
            let r = MKPolylineRenderer(overlay:overlay)
            r.fillColor = UIColor.red.withAlphaComponent(0.1)
            r.strokeColor = UIColor.red.withAlphaComponent(0.8)
            r.lineWidth = 2
            return r
        }
        return MKOverlayRenderer()
    }
    @IBAction func onResetClick(_ sender: UIButton) {
        mapView.removeOverlays(self.mapView.overlays)
        mapView.removeAnnotations(self.mapView.annotations)
        locationArr = []
        totalKm = 0
        totalDistanceLbl.text = ""
    }
}

