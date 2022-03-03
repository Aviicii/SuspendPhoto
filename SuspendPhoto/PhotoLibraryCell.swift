//
//  PhotoLibraryCell.swift
//  SuspendPhoto
//
//  Created by jekun on 2022/3/3.
//

import UIKit
import Photos

class PhotoLibraryCell: UICollectionViewCell {
    
    private var imageV: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayCell(asset:PHAsset) {
        let option = PHImageRequestOptions() //可以设置图像的质量、版本、也会有参数控制图像的裁剪
        option.resizeMode = .fast
        option.isNetworkAccessAllowed = true
        PHImageManager.default().requestImage(for: asset, targetSize: .init(width: 1170, height: 2532), contentMode: .aspectFit, options: option) { image, info in
            self.imageV.image = image
        }
    }
    
    func setupView() {
        imageV = UIImageView()
        imageV.contentMode = .scaleAspectFill
        contentView.addSubview(imageV)
        imageV.frame = contentView.frame
    }
    
}
