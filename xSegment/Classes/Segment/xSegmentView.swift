//
//  xSegmentView.swift
//  xSDK
//
//  Created by Mac on 2020/9/21.
//

import UIKit
import xExtension

public class xSegmentView: UIView {

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
    /// 子控件Frame
    public var itemFrameArray = [CGRect]()
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
    public override func awakeFromNib() {
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
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        guard self.itemArray.count > 0 else { return }
        self.contentScroll.frame = self.bounds
        // 重新计算位置
        let cfg = self.config
        let contentW = self.bounds.width
        let contentH = self.bounds.height
        var equalWidth = contentW
        let count = self.itemArray.count
        if count > 0 {
            equalWidth = ((contentW - 1) - cfg.spacing * CGFloat(count - 1)) / CGFloat(count)
        }
        if equalWidth <= 0 { equalWidth = 50 }
        
        var itemFrame = CGRect.zero
        for (i, item) in self.itemArray.enumerated() {
            // 默认使用控件自身宽高
            itemFrame.size = self.itemFrameArray[i].size
            // 根据条件使用等宽
            if itemFrame.size.width <= 0 || !cfg.isAutoWidth {
                itemFrame.size.width = equalWidth
            }
            // 根据条件使用指定高度
            if itemFrame.size.height <= 0 || itemFrame.size.height > cfg.itemHeight {
                itemFrame.size.height = cfg.itemHeight
            }
            // 计算起始位置
            itemFrame.origin.y = (contentH - itemFrame.height) / 2
            // 更新 item fame
            item.frame = itemFrame
            itemFrame.origin.x += (cfg.spacing + itemFrame.width)
        }
        // 更新滚动范围
        let totalWidth = itemFrame.origin.x - cfg.spacing
        let contentSize = CGSize.init(width: totalWidth, height: 0)
        self.contentScroll.contentSize = contentSize
        self.contentScroll.isScrollEnabled = totalWidth > self.bounds.width
    }
    
}
