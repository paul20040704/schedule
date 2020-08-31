//
//  Global.swift
//  schedule
//
//  Created by TimeCity on 2019/11/21.
//  Copyright © 2019 TimeCity. All rights reserved.
//

import Foundation
import RealmSwift


let US = Share.shared

let UD = UserDefaults.standard

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
let screenOrigin = UIScreen.main.bounds.origin
let totalDic = ["性別":["公","母"],"類型":["貓","狗"],"體型":["大型","中型","小型"],"地區":["臺北","新北","桃園","新竹","苗栗","臺中","彰化","雲林","嘉義","臺南","高雄","屏東","花蓮","臺東","澎湖","金門","基隆","宜蘭"],"年紀":["幼年","成年"],"絕育":["是","否","未知"]]

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

extension UIImage{
   
    func reSizeImage(reSize:CGSize)->UIImage{
        UIGraphicsBeginImageContextWithOptions(reSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return reSizeImage
    }
    
    func scaleImage(scaleSize:CGFloat) -> UIImage{
        let reSize = CGSize.init(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
        return reSizeImage(reSize: reSize)
    }
    
    
    
}
