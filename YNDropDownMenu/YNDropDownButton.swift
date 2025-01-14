//
//  YNDropDownButton.swift
//  YNDropDownMenu
//
//  Created by YiSeungyoun on 2017. 2. 19..
//
//
import UIKit

class YNDropDownButton: UIButton {
    internal var centerXwithOffsetConstraint: NSLayoutConstraint!
    internal var centerYConstraint: NSLayoutConstraint!
    internal var widthConstraint: NSLayoutConstraint!
    
    open var buttonImageView: UIImageView!
    
    open var buttonLabel: UILabel!
    open var buttonLabelText: String?
    open var buttonImages: YNImages? {
        didSet {
            self.initViewWithImage()
        }
    }
    open var labelFontColors: YNFontColor? {
        didSet {
            self.initFontColor()
        }
    }
    open var labelFonts: YNFont? {
        didSet {
            self.initFont()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()

    }

    public init(frame: CGRect, buttonLabelText: String?) {
        super.init(frame: frame)

        self.buttonLabelText = buttonLabelText
        self.initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fatalError("Will be supported soon sorry")
    }
    
    open func enabled() {
        if let _buttonImage = buttonImages?.normal {
            self.buttonImageView.image = _buttonImage
        }
        if let _fontColor = labelFontColors?.normal {
            self.buttonLabel.textColor = _fontColor
        }
        if let _font = labelFonts?.normal {
            self.buttonLabel.font = _font
        }
        self.isUserInteractionEnabled = true
    }
    
    open func disabled() {
        if let _buttonImage = buttonImages?.disabled {
            self.buttonImageView.image = _buttonImage
        }
        if let _fontColor = labelFontColors?.disabled {
            self.buttonLabel.textColor = _fontColor
        }
        if let _font = labelFonts?.disabled {
            self.buttonLabel.font = _font
        }
        self.isUserInteractionEnabled = false
    }
    
    private func initFontColor() {
        guard let _labelFontColors = labelFontColors else { return }
        self.buttonLabel.textColor = _labelFontColors.normal
    }
    
    private func initFont() {
        guard let _labelFonts = labelFonts else { return }
        self.buttonLabel.font = _labelFonts.normal
    }
    
    private func initViewWithImage() {
        self.removeConstraints([centerXwithOffsetConstraint, centerYConstraint])
        
        guard let _buttonImage = buttonImages?.normal else { return }
        
        let centerXwithOffsetConstraintImage = NSLayoutConstraint(item: buttonLabel as Any, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: -((_buttonImage.size.height+4)/2))
        
        let centerYConstraintImage = NSLayoutConstraint(item: buttonLabel as Any, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        
        self.addConstraints([centerXwithOffsetConstraintImage,centerYConstraintImage])
        
        self.buttonImageView = UIImageView()
        self.buttonImageView.image = _buttonImage
        self.buttonImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonImageViewXContraint = NSLayoutConstraint(item: buttonImageView as Any, attribute: .left, relatedBy: .equal, toItem: buttonLabel, attribute: .right, multiplier: 1.0, constant: 5)
        let buttonImageViewYConstraint = NSLayoutConstraint(item: buttonImageView as Any, attribute: .centerY, relatedBy: .equal, toItem: buttonLabel, attribute: .centerY, multiplier: 1.0, constant: 0)
        
        let buttonImageViewHeight = NSLayoutConstraint(item: buttonImageView as Any, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: _buttonImage.size.height)
        let buttonImageViewWidth = NSLayoutConstraint(item: buttonImageView as Any, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: _buttonImage.size.width)
        widthConstraint = NSLayoutConstraint(item: buttonLabel as Any, attribute: .width, relatedBy: .lessThanOrEqual, toItem: self, attribute: .width, multiplier: 1.0, constant: -_buttonImage.size.width - 10)
        
        self.addSubview(buttonImageView)
        
        self.addConstraints([buttonImageViewXContraint,buttonImageViewYConstraint,buttonImageViewHeight,buttonImageViewWidth, widthConstraint])
        
        buttonLabel.preferredMaxLayoutWidth = 40
    }
    
    private func initView() {
        self.backgroundColor = UIColor.white
        
        self.buttonLabel = UILabel()
        buttonLabel.preferredMaxLayoutWidth = 40
        self.buttonLabel.text = self.buttonLabelText
        self.buttonLabel.font = UIFont.systemFont(ofSize: 12)
        self.buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        self.buttonLabel.lineBreakMode = .byTruncatingMiddle
        self.addSubview(self.buttonLabel)
        
        centerXwithOffsetConstraint = NSLayoutConstraint(item: buttonLabel as Any, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)
        centerYConstraint = NSLayoutConstraint(item: buttonLabel as Any, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        
        self.addConstraints([centerXwithOffsetConstraint,centerYConstraint])
    }
}
