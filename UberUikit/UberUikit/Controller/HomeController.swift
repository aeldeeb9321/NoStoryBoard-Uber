//
//  HomeController.swift
//  UberUikit
//
//  Created by Ali Eldeeb on 9/30/22.
//

import UIKit
import FirebaseAuth
import Firebase
import MapKit
class HomeController: UIViewController{
    
    //MARK: - Properties
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    private let locationSearchView = LocationInputActivationView()
    private let locationInputView = LocationInputView()
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        checkUserLoginStatus()
        enableLocationServices()
       
    }
    
    //MARK: - API
    
    func checkUserLoginStatus(){
        //if this is nil user is not logged in
        if Auth.auth().currentUser?.uid == nil{
            //since this is UI related we are doing it on the main thread
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                self.present(nav, animated: true)
            }
            
        }else{
            configureUI()
        }
    }
    
    func signOut(){
        do{
            try Auth.auth().signOut() //how to sign out in firebase
        }catch{
            print("DEBUG: ERROR signing out")
        }
    }
    
    //MARK: - Helper Function
    
    func configureUI(){
        configureMapView()
        view.addSubview(locationSearchView)
        locationSearchView.centerX(inView: view)
        locationSearchView.setDimensions(height: 50, width: view.frame.width - 64)
        locationSearchView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        locationSearchView.delegate = self
        //makes the view invisible
        locationSearchView.alpha = 0
        //search bar will go from invisible to visible in an animation
        UIView.animate(withDuration: 2) {
            self.locationSearchView.alpha = 1
        }
    }
    
    func configureMapView(){
        view.addSubview(mapView)
        mapView.frame = view.frame
        mapView.showsUserLocation = true
        //The map will follow users location
        mapView.userTrackingMode = .follow
    }
    
    func configureLocationInputView(){
        view.addSubview(locationInputView)
        locationInputView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 200)
        //making it hidden
        locationInputView.alpha = 0
        locationInputView.delegate = self
        UIView.animate(withDuration: 0.5) {
            self.locationInputView.alpha = 1
        } completion: { _ in
            print("Debug: Present table view")
        }

    }
}

//MARK: - LocationServices
extension HomeController: CLLocationManagerDelegate{
    func enableLocationServices(){
        //We set the location manager's delegate to self so it can trigger the delegate method DidChangeAuthorization
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus(){
        case .notDetermined:
            //here w will request permission to use location services while the app is in use.
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        //here we will update current location
        case .authorizedAlways:
            //Starts the generation of updates that report the user’s current location.
            locationManager.startUpdatingLocation()
            //The location service does its best to achieve the requested accuracy; however, apps must be prepared to use less accurate data. If your app isn’t authorized to access precise location information (isAuthorizedForPreciseLocation is false), changes to this property’s value have no effect; the accuracy is always kCLLocationAccuracyReduced.
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            print("Auth when in use...")
            locationManager.requestAlwaysAuthorization()
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager){
        if manager.authorizationStatus == .authorizedWhenInUse{
            locationManager.requestAlwaysAuthorization()
        }
    }
}

//MARK: - LocationInputActivationViewDelegate
extension HomeController: LocationInputActivationViewDelegate{
    //this wont work until we set our delegate to self, if it isnt set it wont have a value and wont be able to call upon the required fuction
    func presentLocationInputView() {
        //Handle present location input view
        locationSearchView.alpha = 0 //we want to hide the where to label after we click on it
        configureLocationInputView()
    }
    
}

//MARK: - LocationInputViewDelegate
extension HomeController: LocationInputViewDelegate{
    func dismissLocationInputView() {
        //chaining animations
        UIView.animate(withDuration: 0.3) {
            self.locationInputView.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.locationSearchView.alpha = 1
            }
        }

    }
    
}
