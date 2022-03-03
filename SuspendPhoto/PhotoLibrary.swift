//
//  PhotoLibrary.swift
//  SuspendPhoto
//
//  Created by jekun on 2022/3/2.
//

import UIKit
import Photos

class PhotoLibrary: UIView {
    
    private var images:[PHAsset] = []
    private var timer: Timer?
    private var count: Int = 0
    
    lazy private var collectionView: UICollectionView = {
        self.collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: self.flowlayout)
        self.collectionView.register(PhotoLibraryCell.classForCoder(), forCellWithReuseIdentifier: "PhotoLibraryCell")
        self.collectionView.backgroundColor = .white
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
//        self.collectionView.isPagingEnabled = true //打开就不能自动滚动
        self.collectionView.isUserInteractionEnabled = false
        return self.collectionView
    }()
    
    lazy private var flowlayout: UICollectionViewFlowLayout = {
        self.flowlayout = UICollectionViewFlowLayout.init()
        self.flowlayout.sectionInset = UIEdgeInsets.zero
        self.flowlayout.itemSize = frame.size
        self.flowlayout.scrollDirection = .horizontal
        return self.flowlayout
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        debugPrint(1)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    deinit {
        stop()
    }
    
    func setupUI() {
        backgroundColor = .yellow
        self.images = getAllSourceCollection()
        addSubview(self.collectionView)
        collectionView.frame = self.frame
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(run), userInfo: nil, repeats: true)
        
    }
    
    @objc func run() {
        if count < images.count - 1 {
            count += 1
        }else{
            count = 0
        }
        debugPrint(count)
        collectionView.scrollToItem(at: .init(item: count, section: 0), at: .right, animated: true)
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    func getAllSourceCollection() -> [PHAsset] {
        
        let options:PHFetchOptions = PHFetchOptions.init()
        var assetArray = [PHAsset]()
        options.sortDescriptors = [NSSortDescriptor.init(key: "creationDate", ascending: true)]
        let assetFetchResults:PHFetchResult = PHAsset.fetchAssets(with: options)
        for i in 0..<assetFetchResults.count {
            //获取一个资源(PHAsset)
            let asset = assetFetchResults[i]
            //添加到数组
            if asset.mediaType != .video {
                assetArray.append(asset)
            }
        }
        return assetArray
    }
}

extension PhotoLibrary: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:PhotoLibraryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoLibraryCell", for: indexPath) as! PhotoLibraryCell
        cell.contentView.backgroundColor = .black
        cell.displayCell(asset: images[indexPath.item])
        return cell
    }
    
}

