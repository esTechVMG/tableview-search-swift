//
//  ViewController.swift
//  tableview-swift
//
//  Created by A4-iMAC03 on 30/11/2020.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var tabla: UITableView!
    
    let ciudades =  ["Linares","Granada","Madrid","Málaga","Barcelona"]
    
    var filtradodeciudades = [String()]
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var isSearchBarEmpty:Bool{
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering : Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tabla.delegate = self
        tabla.dataSource = self
        self.title = "Ciudades"
        
        BuscadorInit()
    }
    @IBAction func shareButton(_ sender: Any) {
        //Compartir un texto
        /*let textoShare = "Bajate la app"
        let objectToShare:[Any] = [textoShare]
        let activityVC = UIActivityViewController.init(activityItems: objectToShare, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = sender as? UIView
        self.present(activityVC, animated: true, completion: nil)*/
        //Compartir URL e imagen
        
        let textToShare = "Bajate la app"
        let urlToShare = "https://escuelestech.es"
        let imageToShare = UIImage(named: "Linares")
        if let myWebsite = NSURL(string: urlToShare){
            let objectToShare:[Any] = [textToShare, myWebsite,imageToShare!]
            let activityVC = UIActivityViewController.init(activityItems: objectToShare, applicationActivities: nil)
            if let  wPPC = activityVC.popoverPresentationController{
                wPPC.barButtonItem = shareButton
            }
            self.present(activityVC, animated: true, completion: nil)
        }
        
    }
    
  
    
    func BuscadorInit(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder = "Busque una ciudad"
        
        //añadir el searchBar
        navigationItem.searchController = searchController
        
        definesPresentationContext = true
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filtradodeciudades.count
        }else {
            return ciudades.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaciudad", for: indexPath) as! celda
        
        if isFiltering  {
            cell.label.text = filtradodeciudades[indexPath.row]
            cell.imagen.image = UIImage(named: filtradodeciudades[indexPath.row])
        }else{
            cell.label.text = ciudades[indexPath.row]
            cell.imagen.image = UIImage(named: ciudades[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("\(self.ciudades[indexPath.row])")
    }

}


extension ViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
        
    }
    
    
    func  filterContentForSearchText(_ searchText :String ) {
        self.filtradodeciudades = self.ciudades.filter {(ciudad: String) -> Bool in
            
            if ciudad.lowercased().localizedCaseInsensitiveContains(searchText) {
                return true
            }else {
                return false
            }
            
        }
        tabla.reloadData()
    }
    
}



