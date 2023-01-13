//
//  MostRecentViewController.swift
//  LuckyTrip
//
//  Created by Saida Dagdoug on 13/1/2023.
//

import UIKit
import Foundation
class MostRecentViewController: UIViewController {



    struct Post:Codable{
        
        let xid : String
        let name :String
        let dist : Double
        let kinds: String
        let rate: Int
    
        let wikidata: String
        let point: Point
        
    }
    
    struct Point:Codable{
        let lon: Double
        let lat: Double
        
        
    }
    
    
 var data = [Post]()

    
    @IBOutlet weak var olacesofinterest: UILabel!
    
    @IBOutlet weak var tableRecentView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableRecentView.dataSource = self
        tableRecentView.delegate = self
        
        configureNavigationBar()
       
        let url = "https://api.opentripmap.com/0.1/en/places/radius?apikey=5ae2e3f221c38a28845f05b6e1e72f6e6fae9bc6a9473af209e333f9&radius=5000&lon=10.63699&lat=35.82539&rate=3&format=json"
        
        fetchingApiData(URL: url){ result in
            self.data = result
            DispatchQueue.main.async {
                self.tableRecentView.reloadData()
            }
        }
    }
        
    

    func fetchingApiData(URL url:String, completion:@escaping([Post])-> Void){
        let url = URL(string: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!){data, response, error in
            if  data != nil && error == nil {
                do {
                    let parasingData = try JSONDecoder().decode([Post].self, from: data!)
                    completion(parasingData)
                    
                }catch{
                    print("parasing error ")
                }
            }
            
         }
        dataTask.resume()

    
}

        
    private func configureNavigationBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .done ,
                                                            target: self,
                                                            action: #selector(didTapSettingsButton))
    }
    @objc private func didTapSettingsButton(){
       
    }
    
    
    
    
    @objc private func didTapDetails(index: Int ){
       
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailPlace") as? DetailPlaceViewController else{
            print("failed to get vc from storyboard")
            return
        }

        
        vc.placeId = data[index].xid
        vc.title = data[index].name
        navigationController?.pushViewController(vc, animated: true)
    }
}





extension MostRecentViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return data.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableRecentView.dequeueReusableCell(withIdentifier: "placesCell") as! RecentTableViewCell
    
        
        olacesofinterest.text = "Places of interest(\(data.count))"
        let test = data[indexPath.row]
        cell.name.text = test.name
        cell.kinds.text = test.kinds
        cell.dist.text = String(test.dist)+"m"
      
        //cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        tableView.deselectRow(at: indexPath, animated: true)
        // Handle cell selection
        didTapDetails(index: indexPath.row)
    
    }
    
}
