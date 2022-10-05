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

//Creating identifiers on top like apple does

private let reuseIdentifier = "LocationCell"
class HomeController: UIViewController{
    
    //MARK: - Properties
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    private let locationSearchView = LocationInputActivationView()
    private let locationInputView = LocationInputView()
    private let tableView = UITableView()
    private var user: User?{
        didSet{ //gets exectured when full name is set to a string
            locationInputView.user = user
        }
    }
    private final let locationInputViewHeight: CGFloat = 200 //final makes sure it cant be changed anywhere
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        checkUserLoginStatus()
        enableLocationServices()
        fetchUserData()
    }
    
    //MARK: - API
    
    func fetchUserData(){
        Service.shared.fetchUserData { user in
            self.user = user
        }
    }
    
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
        
        configureTableView()
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
        locationInputView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: locationInputViewHeight)
        //making it hidden
        locationInputView.alpha = 0
        locationInputView.delegate = self
        UIView.animate(withDuration: 0.5) {
            self.locationInputView.alpha = 1
        } completion: { _ in
            //presenting the table view
            UIView.animate(withDuration: 0.3) {
                self.tableView.frame.origin.y = self.locationInputViewHeight
            }
            
        }

    }
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LocationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        let height = view.frame.height - locationInputViewHeight //frame will be he height of the frame minus the height of the location input view
        tableView.frame = CGRectMake(0, view.frame.height, view.frame.width, height) //x,y will be the origin, our starting point will be the bottom of the screen since we made our y the height of the view's frame and we will slide it up
        view.addSubview(tableView)
        
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
            self.tableView.frame.origin.y = self.view.frame.height
        } completion: { _ in
            //making sure we arent constantly adding locationInputView in our Configure Location input view method
            self.locationInputView.removeFromSuperview()
            UIView.animate(withDuration: 0.3) {
                self.locationSearchView.alpha = 1
            }
        }

    }
    
}

//MARK: - UITableViewDelegate/DataSource
extension HomeController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Recent Locations"
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LocationCell
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //static return for now 
        return section == 0 ? 2: 5
    
    }
    
    
}


