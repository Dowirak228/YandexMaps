//
//  SearchCell.swift
//  YandexMapsDemo
//
//  Created by NODIR KARIMOV on 07/01/22.
//

import UIKit

class SearhCell: UICollectionViewCell {
    
    let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "locationIcon")
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Gilroy-Medium", size: 16)
        label.text = "Государственый музей истории \nТимуридов"
        label.baselineAdjustment = .alignCenters
        label.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        addSubview(separatorLine)
        addSubview(iconImageView)
        addSubview(titleLabel)
        
        separatorLine.snp.makeConstraints { make in
            make.width.equalTo(frame.width)
            make.height.equalTo(1)
            make.bottom.equalTo(snp.bottom)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.width.equalTo(24)
            make.left.equalTo(23)
            make.top.equalTo(21)
            make.bottom.equalTo(separatorLine).offset(-30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(231)
            make.height.equalTo(44)
            make.left.equalTo(self.iconImageView.snp.right).inset(-22)
            make.right.equalTo(-50)
            make.bottom.equalTo(self.separatorLine.snp.top).offset(-30)
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

