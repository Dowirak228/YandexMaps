//
//  CustomIconButton.swift
//  YandexMapsDemo
//
//  Created by NODIR KARIMOV on 07/01/22.
//

import UIKit
import SnapKit

struct CustomIconButtonViewModel {
    let text: String
    let image: UIImage?
    let image2: UIImage?
    let bgColor: UIColor?
}

class CustomIconButton: UIButton {
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.textColor = #colorLiteral(red: 0.5960178971, green: 0.596120894, blue: 0.5960043073, alpha: 1)
        label.font = UIFont(name: "Gilroy-SemiBold", size: 17)
        return label
    }()
    
    private let leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = #colorLiteral(red: 0.5960178971, green: 0.596120894, blue: 0.5960043073, alpha: 1)
        return imageView
    }()
    
    private let rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = #colorLiteral(red: 0.5960178971, green: 0.596120894, blue: 0.5960043073, alpha: 1)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(leftImageView)
        addSubview(rightImageView)
                
        updateLayerProperties()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        leftImageView.snp.makeConstraints { make in
            make.left.equalTo(21)
            make.centerY.equalTo(self)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.right.equalTo(-21)
            make.centerY.equalTo(self)
        }
        
        label.snp.makeConstraints { make in
            make.left.equalTo(self.leftImageView).inset(21)
            make.centerY.equalTo(self)
        }
        
    }
    
//    override func draw(_ rect: CGRect) {
//        updateLayerProperties()
//    }
    
    func updateLayerProperties() {
        self.layer.borderWidth = 9
        self.layer.borderColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        self.layer.cornerRadius = 13
        self.clipsToBounds = true
        
        
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 10.0
        self.layer.masksToBounds = false
        
        
    }
    
    func configure(with viewModel: CustomIconButtonViewModel) {
        label.text = viewModel.text
        backgroundColor = viewModel.bgColor
        leftImageView.image = viewModel.image
        rightImageView.image = viewModel.image2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
