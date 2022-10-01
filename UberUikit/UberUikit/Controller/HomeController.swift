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
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        checkUserLoginStatus()
       
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
        view.addSubview(mapView)
        mapView.frame = view.frame
    }
}
