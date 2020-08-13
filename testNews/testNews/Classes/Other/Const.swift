//
//  Const.swift
//  testNews
//
//  Created by hjun on 2020/8/5.
//  Copyright © 2020 GD. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.main.bounds.width
let screebHeight = UIScreen.main.bounds.height

func RGBColors(r:CGFloat,g:CGFloat,b:CGFloat)-> UIColor{
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}

func colorWithHexString(hexString:String) -> UIColor {
    var cstr = hexString.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines).uppercased() as NSString;
       if(cstr.length < 6){
           return UIColor.clear;
       }
       if(cstr.hasPrefix("0X") || cstr.hasPrefix("0x")){
           cstr = cstr.substring(from: 2) as NSString
       }
       if(cstr.hasPrefix("#")){
           cstr = cstr.substring(from: 1) as NSString
       }
       if(cstr.length != 6){
           return UIColor.clear;
       }
       var range = NSRange.init()
       range.location = 0
       range.length = 2
       //r
       let rStr = cstr.substring(with: range);
       //g
       range.location = 2;
       let gStr = cstr.substring(with: range)
       //b
       range.location = 4;
       let bStr = cstr.substring(with: range)
       var r :UInt32 = 0x0;
       var g :UInt32 = 0x0;
       var b :UInt32 = 0x0;
       Scanner.init(string: rStr).scanHexInt32(&r);
       Scanner.init(string: gStr).scanHexInt32(&g);
       Scanner.init(string: bStr).scanHexInt32(&b);
       return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1);
}

let keyWindow = UIApplication.shared.windows

let kIsIphone = Bool(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)


//Json字符串转字典
func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
    let jsonData:Data = jsonString.data(using: .utf8)!
    let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
    if dict != nil {
        return dict as! NSDictionary
    }
    return NSDictionary()
}


//服务器地址
//let BASE_URL = "https://lf.snssdk.com"
//let BASE_URL = "https://ib.snssdk.com"
let BASE_URL = "https://is.snssdk.com"
//let BASE_URL = "http://wisdomnj.manjiwang.com"
let device_id: String = "6096495334"
let IID: String = "5034850950"

//站点序号
let wnj_siteId = "fef0791f7bd37b3de92954dd6d04ebb1"



