//
//  DetailPlaceViewController.swift
//  LuckyTrip
//
//  Created by Saida Dagdoug on 13/1/2023.
//
import SafariServices
import UIKit

class DetailPlaceViewController: UIViewController {
    var placeId: String = "" ;
    
    @IBOutlet weak var textdetail: UILabel!
    @IBOutlet weak var countrydetail: UILabel!
    @IBOutlet weak var kindsdetail: UILabel!
    @IBOutlet weak var namedetail: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    
    @IBAction func click(_ sender: Any) {
        
        guard let url = URL(string: "https://www.freecodecamp.org/news/how-to-make-your-first-api-call-in-swift/") else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc,animated: true)
    }
    
  
    

    struct Postdetail:Codable{
        let xid : String
        let name :String
        let address : Adressse

 
       // let bbox: Bbox
  
        let image: URL
        let kinds: String
        let wikipedia_extracts: Wikipedia_extracts
        let wikipedia :URL

        
      
      

        
      
    }

 
 
    struct Wikipedia_extracts:Codable{
        let title: String
        let text: String
        let html: String
    }
    struct Adressse:Codable{
        let city: String
        let state: String
        let country: String
        let county: String
        let suburb: String
        let postcode: String
        let pedestrian: String
        let country_code: String
        let state_district: String

    }
    
    struct Bbox: Codable{
       let lon_min : Double
        let lon_max : Double
        let lat_min : Double
        let lat_max : Double
        
    }
    struct Point:Codable{
        let lon: Double
        let lat: Double
        
        
    }

    var data = [Postdetail]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        namedetail.text = placeId
     

        let url = "https://api.opentripmap.com/0.1/en/places/xid/\(placeId)?apikey=5ae2e3f221c38a28845f05b6e1e72f6e6fae9bc6a9473af209e333f9"
        
        fetchingApiData(URL: url){ result in
        
            self.data.append(result)
            //print(self.data)
    
           
            
        }
        print(self.data)
        //self.textdetail.text = self.data[0].xid
        /*
        func decodeAPI(){
            guard let url = URL(string: "https://api.opentripmap.com/0.1/en/places/xid/\(placeId)?apikey=5ae2e3f221c38a28845f05b6e1e72f6e6fae9bc6a9473af209e333f9") else{return}

            let session = URLSession.shared.dataTask(with: url) { [self] data, response, error in
                      
                      if let error = error {
                          print("There was an error: \(error.localizedDescription)")
                      } else {
                          let jsonRes = try? JSONSerialization.jsonObject(with: data!, options: [])
                          print("The response: \(jsonRes)")
                          //let dic = jsonRes as? [String:Any]

                          //self.textdetail.text = dic?["xid"] as! String
                      }
                  }.resume()

           
        }
        decodeAPI()
         
 */
 
      
        
    }

   
    
    func fetchingApiData(URL url:String, completion:@escaping(Postdetail)-> Void){
        let url = URL(string: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!){data, response, error in
            if  data != nil && error == nil {
                do {
                    let parasingData = try JSONDecoder().decode(Postdetail.self, from: data!)
                    completion(parasingData)
                    
                }catch{
                    print("failed to convert \(error)")
                }
            }
            
         }
        dataTask.resume()

    
     }
  
    
 
}
