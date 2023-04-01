//
//  xSegmentView+Func.swift
//  xSegment
//
//  Created by Mac on 2023/3/17.
//

import Foundation

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
    
}
