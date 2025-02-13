//
//  xSegmentView+Kit.swift
//  xSegment
//
//  Created by Mac on 2023/3/17.
//

import UIKit
import xExtension

extension xSegmentView {
    
    // MARK: - 内容样式
    /// 设置普通样式
    public func updateAllItemStyleToNormal()
    {
        let count = self.itemArray.count
        for i in 0 ..< count {
            self.updateItemStyleToNormal(at: i)
        }
    }
    /// 设置普通样式
    public func updateItemStyleToNormal(at idx : Int)
    {
        guard let item = self.itemArray.xObject(at: idx) else { return }
        let cfg = self.config
        item.backgroundColor = cfg.backgroundColor.normal
        item.layer.borderColor = cfg.border.color.normal.cgColor
        if let obj = item as? UIButton {
            obj.titleLabel?.font = cfg.font.normal
            obj.setTitleColor(cfg.titleColor.normal, for: .normal)
        } else
        if let obj = item as? UILabel {
            obj.font = cfg.font.normal
            obj.textColor = cfg.titleColor.normal
        } else
        if let obj = item as? xSegmentItem {
            obj.updateNormalStyle(cfg)
        }
    }
    /// 设置选中样式
    public func updateItemStyleToChoose(at idx : Int)
    {
        guard let item = self.itemArray.xObject(at: idx) else { return }
        self.updateAllItemStyleToNormal() // 只支持选中1个，所以先清空
        let cfg = self.config
        item.backgroundColor = cfg.backgroundColor.choose
        item.layer.borderColor = cfg.border.color.choose.cgColor
        if let obj = item as? UIButton {
            obj.titleLabel?.font = cfg.font.choose
            obj.setTitleColor(cfg.titleColor.choose, for: .normal)
        } else
        if let obj = item as? UILabel {
            obj.font = cfg.font.choose
            obj.textColor = cfg.titleColor.choose
        } else
        if let obj = item as? xSegmentItem {
            obj.updateChooseStyle(cfg)
        }
        self.currentChooseIdx = idx
        self.updateLineScroll(to: idx, animated: true)
        self.updateContentOffset(at: idx)
    }
    
    // MARK: - 指示线
    /// 设置指示线位置（直接跳过去）
    public func updateLineScroll(to idx : Int,
                                 animated : Bool = true)
    {
        guard let item = self.itemArray.xObject(at: idx) else { return }
        // 声明变量
        let cfg = self.config
        let itemX = item.frame.origin.x
        let itemW = item.frame.width
//        let itemH = item.frame.height
        let itemH = self.frame.height   // item高度可能比自身小很多
        let lineH = cfg.line.height
        let lineW = itemW * cfg.line.widthOfItemPercent
        // 起始位置
        var startFrame = self.chooseItemLine.frame
        startFrame.size.width = lineW
        if startFrame.height == 0 {
            startFrame.size.height = lineH
            startFrame.origin.x = -lineW
            startFrame.origin.y = itemH - cfg.line.bottomSpacing - lineH
        }
        // 结束位置
        var endFrame = startFrame
        endFrame.origin.x = itemX + (itemW - lineW) / 2
        // 修改指示线位置
        self.chooseItemLine.frame = startFrame
        let duration : TimeInterval = (animated ? 0.25 : 0)
        UIView.animate(withDuration: duration) {
            self.chooseItemLine.frame = endFrame
        }
    }
    /// 设置滚动结果位置
    public func updateContentOffset(at idx : Int,
                                    animated : Bool = true)
    {
        let cfg = self.config
        guard cfg.isAutoWidth else { return }
        guard let item = self.itemArray.xObject(at: idx) else { return }
        let itemX = item.frame.origin.x
        let itemW = item.frame.width
        let scrolW = self.contentScroll.bounds.width
        let scrolTotalW = self.contentScroll.contentSize.width
        var offset = CGPoint.zero
        // 单页就能显示完，不用管
        guard scrolTotalW >= scrolW else { return }
        offset.x = itemX + itemW / 2
        offset.x -= scrolW / 2 // 居中
//        print(offset.x)
        // 边缘处理
        let minOffsetX = CGFloat.zero
        let maxOffsetX = scrolTotalW - scrolW
        if offset.x < minOffsetX {
            offset.x = minOffsetX
        } else
        if offset.x > maxOffsetX {
            offset.x = maxOffsetX
        }
        self.contentScroll.setContentOffset(offset, animated: animated)
    }
    
}
