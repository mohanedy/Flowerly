//
//  WikiServices.swift
//  Flowerly
//
//  Created by Mohaned Yossry on 5/3/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct WikiServices {
    var delegate:WikiServicesDelegate?
    
    func fetchQuery(query:String){
        let wikipediaURl = "https://en.wikipedia.org/w/api.php"
        
        let parameters : [String:String] = [
            "format" : "json",
            "action" : "query",
            "prop" : "extracts|pageimages",
            "exintro" : "",
            "explaintext" : "",
            "titles" : query,
            "indexpageids" : "",
            "redirects" : "1",
            "pithumbsize":"500"
        ]
        
        AF.request(wikipediaURl, method: .get,parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .success :
                if let safeData = response.data{
                    if let safeFlower =   self.parseJSON(data: safeData,title: query){
                        self.delegate?.didLoadFlowerData(self, flower: safeFlower)
                    }
                }
                
                break
            case .failure:
                self.delegate?.didFailWithError("Cannot load data \(response.error.debugDescription)")
                break
            }
            
            
        }
        
    }
    //query.pages[8087628].thumbnail.source
    func parseJSON(data:Data, title:String) -> Flower? {
        
        do {
            let json = try JSON(data: data)
            if let pageId = json["query"]["pageids"].array?.first?.string{
                if   let description =  json["query"]["pages"][pageId]["extract"].string{
                    if let imgURL = json["query"]["pages"][pageId]["thumbnail"]["source"].string{
                        let flower = Flower(name: title, imgURL: imgURL, description: description)
                        return flower
                    }
                }
            }
            
            delegate?.didFailWithError("Couldn't parse data")
        }catch {
            print(error)
            delegate?.didFailWithError(error.localizedDescription)
            
        }
        return nil
    }
    
}


protocol WikiServicesDelegate {
    func didLoadFlowerData( _ wikiServices: WikiServices,flower:Flower)
    func didFailWithError(_ error: String)
}
