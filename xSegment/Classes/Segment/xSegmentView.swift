//
//  xSegmentView.swift
//  xSDK
//
//  Created by Mac on 2020/9/21.
//

import UIKit
import xExtension

open class xSegmentView: UIView {

    // MARK: - Handler
    /// 选中回调
    public typealias xHandlerChooseItem = (Int) -> Void
    
    // MARK: - Public Property
    /// 配置
    public var config = xSegmentConfig()
    /// 当前选中的idx
    public var currentChooseIdx = 0
    /// 子控件
    public var itemArray = [UIView]()
    /// 滚动视图
    let contentScroll = UIScrollView()
    /// 指示线
    let chooseItemLine = UIView()
    /// 选择回调
    var chooseHandler : xHandlerChooseItem?
    
    // MARK: - 内存释放
    deinit {
        self.chooseHandler = nil
    }

    // MARK: - Public Override Func
    open override func awakeFromNib() {
        super.awakeFromNib()
        // 基本配置
        self.backgroundColor = .white
        // 滚动容器
        self.contentScroll.isUserInteractionEnabled = true
        self.contentScroll.showsVerticalScrollIndicator = false
        self.contentScroll.showsHorizontalScrollIndicator = false
        self.addSubview(self.contentScroll)
        // 指示线
        self.chooseItemLine.clipsToBounds = true
        self.chooseItemLine.layer.masksToBounds = true
        self.contentScroll.addSubview(self.chooseItemLine)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.contentScroll.frame = self.bounds
        // 重新计算位置
        let cfg = self.config
        var itemFrame = CGRect.zero
        let contentW = self.bounds.width
        let contentH = self.bounds.height
        let count = self.itemArray.count
        var equalWidth = (contentW - cfg.spacing * CGFloat(count - 1)) / CGFloat(count)
        if equalWidth < 0 { equalWidth = 50 }
        for item in self.itemArray {
            itemFrame.size = item.frame.size
            // 宽度
            switch cfg.fillMode {
            case .equally:  // 等宽
                itemFrame.size.width = equalWidth
            case .auto:     // 自适应宽度
                itemFrame.size.width = item.bounds.width
            }
            if itemFrame.size.width == 0 {
                itemFrame.size.width = equalWidth
            }
            // 高度
            if itemFrame.size.height == 0 {
                itemFrame.size.height = cfg.itemHeight
            }
            if itemFrame.size.height > cfg.itemHeight {
                itemFrame.size.height = cfg.itemHeight
            }
            itemFrame.origin.y = (contentH - itemFrame.height) / 2
            item.frame = itemFrame
            itemFrame.origin.x += (cfg.spacing + itemFrame.width)
        }
        // 更新frame
        let totalWidth = itemFrame.origin.x - cfg.spacing
        let contentSize = CGSize.init(width: totalWidth, height: 0)
        self.contentScroll.contentSize = contentSize
        self.contentScroll.isScrollEnabled = totalWidth > self.bounds.width
    } 
    
}
