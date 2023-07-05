//
//  xSegmentView+Func.swift
//  xSegment
//
//  Created by Mac on 2023/3/17.
//

import Foundation
import xExtension

extension xSegmentView {
    
    // MARK: - 添加回调
    public func addChooseItem(handler : @escaping xSegmentView.xHandlerChooseItem)
    {
        self.chooseHandler = handler
    }
    
    // MARK: - 选中
    /// 选中
    public func choose(idx : Int)
    {
        if idx != self.currentChooseIdx {
            self.updateItemStyleToNormal(at: self.currentChooseIdx)
        }
        self.updateItemStyleToChoose(at: idx)
        self.chooseHandler?(idx) 
    }  
    
    // MARK: - 设置Item样式
    /// 设置Item新内容提示
    public func setSegmentItem(idx : Int,
                               hasNew : Bool)
    {
        guard let view = self.itemArray.xObject(at: idx) else { return }
        guard let item = view as? xSegmentItem else {
            print("⚠️ 要编辑的 Item 不是继承 xSegmentItem 类")
            return
        }
        item.newFlag?.isHidden = !hasNew
        item.badgeLbl?.isHidden = true
    }
    /// 设置Item新内容提示
    public func setSegmentItem(idx : Int, badge value : Int)
    {
        guard let view = self.itemArray.xObject(at: idx) else { return }
        guard let item = view as? xSegmentItem else {
            print("⚠️ 要编辑的 Item 不是继承 xSegmentItem 类")
            return
        }
        item.newFlag?.isHidden = true
        item.badgeLbl?.text = "\(value) "
        item.badgeLbl?.isHidden = (value <= 0)
    }
    
}
