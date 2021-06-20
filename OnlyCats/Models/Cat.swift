//
//  Cat.swift
//  OnlyCats
//
//  Created by Clara Jeon on 6/19/21.
//

import Foundation
import UIKit

public class Cat {
    
    var name: String
    var description: String
    var interest: String
    var mainImage: UIImage
    var cuteCatPics: [UIImage]
    var feetPics: [UIImage]
    var cuteCatVid: URL
    var birthdayAge: String
    
    init(name: String, description: String, interest: String, mainImage: UIImage, cuteCatPics: [UIImage], feetPics: [UIImage], cuteCatVid: URL, birthdayAge: String){
        self.name = name
        self.description = description
        self.interest = interest
        self.mainImage = mainImage
        self.cuteCatPics = cuteCatPics
        self.feetPics = feetPics
        self.cuteCatVid = cuteCatVid
        self.birthdayAge = birthdayAge
    }
    
    init(){
        self.name = ""
        self.description = ""
        self.interest = ""
        self.mainImage = #imageLiteral(resourceName: "defaultpp")
        self.cuteCatPics = [#imageLiteral(resourceName: "defaultpp")]
        self.feetPics = [#imageLiteral(resourceName: "defaultpp")]
        self.cuteCatVid = URL(string: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAA1BMVEX///+nxBvIAAAASElEQVR4nO3BgQAAAADDoPlTX+AIVQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADwDcaiAAFXD1ujAAAAAElFTkSuQmCC")!
        self.birthdayAge = ""
    }
    
    static func parse(data:[String: Any], completion: @escaping (_ cat: Cat) -> ()) {
        if let name = data["name"] as? String,
           let description = data["description"] as? String,
           let interest = data["interest"] as? String,
           let mainImageString = data["mainImage"] as? String,
           let mainImageURL = URL(string: mainImageString),
           let birthdayAge = data["birthdayAge"] as? String,
           let catVidString = data["vid"] as? String,
           let catVidURL = URL(string: catVidString) {
            
            //for cute cat pics
            let cutePicsStrings = data["cutePics"] as? [String]
            
            var cuteCatPics = [UIImage]()
            
            var numThroughFirstLoop = 0
            
            for x in 0..<cutePicsStrings!.count {
                let picURL = URL(string: cutePicsStrings![x])!
                
                ImageService.getImage(withURL: picURL) { cuteCatPic, url in
                    cuteCatPics.append(cuteCatPic!)
                    numThroughFirstLoop += 1
                    
                    if numThroughFirstLoop == cutePicsStrings?.count {
                        //for feet pics
                        let feetPicsString = data["feetPics"] as? [String]
                        
                        var feetPics = [UIImage]()
                        
                        var numThroughSecondLoop = 0
                        
                        for y in 0..<feetPicsString!.count {
                            let picURL = URL(string: feetPicsString![y])!
                            
                            ImageService.getImage(withURL: picURL) { feetPic, url2 in
                                feetPics.append(feetPic!)
                                numThroughSecondLoop += 1
                                
                                if numThroughSecondLoop == feetPicsString?.count {
                                    ImageService.getImage(withURL: mainImageURL) { mainImage, url3 in
                                        let cat = Cat(name: name, description: description, interest: interest, mainImage: mainImage!, cuteCatPics: cuteCatPics, feetPics: feetPics, cuteCatVid: catVidURL, birthdayAge: birthdayAge)
                                        print("succes in parsing through cat data. here is the cat's birthday/age: \(birthdayAge)")
                                        completion(cat)
                                    }
                                }
                            }
                        }
                    }
                    
                }
            }
            
            
            
            
            
        }
        
    }
}
