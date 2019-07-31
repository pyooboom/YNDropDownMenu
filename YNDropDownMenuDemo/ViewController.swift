//
//  ViewController.swift
//  YNDropDownMenu
//
//  Created by seungyoun@zigbang.com on 02/19/2017.
//  Copyright (c) 2017 seungyoun@zigbang.com. All rights reserved.
//

import UIKit
import YNDropDownMenu

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var ZBdropDownViews = Bundle.main.loadNibNamed("DropDownViews", owner: nil, options: nil) as? [UIView]
        ZBdropDownViews?.insert(CustomDropDownView(frame: CGRect(x: 0, y: 10000000, width: 100, height: 300)), at: 0)
        let FFA409 = UIColor.init(red: 255/255, green: 164/255, blue: 9/255, alpha: 1.0)

        if let _ZBdropDownViews = ZBdropDownViews {
            
            // Inherit YNDropDownView if you want to hideMenu in your dropDownViews
            let view = YNDropDownMenu(frame: CGRect(x: 0, y: 88, width: UIScreen.main.bounds.size.width, height: 38), dropDownViews: Array(_ZBdropDownViews[0...1]), dropDownViewTitles: ["金银", "财宝财宝财宝财宝财宝财宝财宝财宝财宝"])

            let normalImages = [UIImage(named: "arrow_nor"),
                                UIImage(named: "arrow_nor")]
            
            let selectedImages = [imageMaskingwithColor(hexStringToUIColor(hex: "FFA409"), image: UIImage(named: "arrow_nor")),
                                  imageMaskingwithColor(hexStringToUIColor(hex: "FFA409"), image: UIImage(named: "arrow_nor"))]
            
            let disabledImages = [imageMaskingwithColor(hexStringToUIColor(hex: "D3D3D3"), image: UIImage(named: "arrow_nor")),
                                  imageMaskingwithColor(hexStringToUIColor(hex: "D3D3D3"), image: UIImage(named: "arrow_nor"))]
            
            view.setStatesImages(normalImages: normalImages, selectedImages: selectedImages, disabledImages: disabledImages)
            
            view.setLabelColorWhen(normal: .black, selected: FFA409, disabled: .gray)
//            view.setLabelColorWhen(normalRGB: "000000", selectedRGB: "FFA409", disabledRGB: "FFA409")
            
            view.setLabelFontWhen(normal: .systemFont(ofSize: 12), selected: .boldSystemFont(ofSize: 12), disabled: .systemFont(ofSize: 12))
            //            view.setLabel(font: .systemFont(ofSize: 12))
            
            view.backgroundBlurEnabled = true
            //            view.bottomLine.backgroundColor = UIColor.black
            view.bottomLine.isHidden = false
            // Add custom blurEffectView
            view.blurEffectView = {
                let view = UIView()
                view.backgroundColor = UIColor.clear
                return view
            }()
//            view.blurEffectViewAlpha = 0.7
            
            self.view.addSubview(view)
            // Open and Hide Menu
            view.alwaysSelected(at: 0)
//            view.disabledMenuAt(index: 1)

            view.showAndHideMenu(at: 0)

            view.setBackgroundColor(color: UIColor.white)

        }
    }
    
    /// Convert String-type hex color codes into UIColor.
    private func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    /// Mask images with UIColor.
    private func imageMaskingwithColor(_ color: UIColor, image: UIImage?) -> UIImage?{
        
        if let image = image {
            
            UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
            let context = UIGraphicsGetCurrentContext()!
            
            color.setFill()
            
            context.translateBy(x: 0, y: image.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            
            let rect = CGRect(x: 0.0, y: 0.0, width: image.size.width, height: image.size.height)
            context.draw(image.cgImage!, in: rect)
            
            context.setBlendMode(CGBlendMode.sourceIn)
            context.addRect(rect)
            context.drawPath(using: CGPathDrawingMode.fill)
            
            let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return coloredImage
            
        } else {
            return nil
        }
    }
}



class ContactModel {
    let name: String
    let phone: String
    init(name: String, phone: String) {
        self.name = name
        self.phone = phone
    }
    
    @objc func demoFunc() -> String {
        return name
    }
}
