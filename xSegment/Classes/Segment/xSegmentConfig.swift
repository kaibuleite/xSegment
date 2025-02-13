//
//  xSegmentConfig.swift
//  xSDK
//
//  Created by Mac on 2020/9/16.
//

import UIKit
import xExtension

// MARK: - Struct
/// 颜色数据结构
public struct xSegmentItemColor {
    /// 普通
    public var normal = UIColor.systemBlue
    /// 选中
    public var choose = UIColor.systemRed
    
    /// 实例化对象
    public init(normal: UIColor = .clear,
                choose: UIColor = .clear)
    {
        self.normal = normal
        self.choose = choose
    }
    /// 实例化指定对象
    public static func xNew(_ color : UIColor) -> xSegmentItemColor
    {
        let color = xSegmentItemColor.init(normal: color,
                                           choose: color)
        return color
    }
    /// 实例化透明对象
    public static func xNewClear() -> xSegmentItemColor
    {
        let color = xSegmentItemColor.xNew(.clear)
        return color
    }
    /// 实例化随机对象
    public static func xNewRandom(alpha: CGFloat = 1) -> xSegmentItemColor
    {
        let color = xSegmentItemColor.init(normal: .xNewRandom(alpha: alpha),
                                           choose: .xNewRandom(alpha: alpha))
        return color
    }
}

/// 边框数据结构
public struct xSegmentItemBorder {
    /// 边框颜色
    public var color = xSegmentItemColor.xNewClear()
    /// 线宽
    public var width = CGFloat.zero
    /// 圆角
    public var cornerRadius = CGFloat.zero
    
    /// 实例化对象
    public init(color: xSegmentItemColor = .xNewClear(),
                width: CGFloat = .zero,
                cornerRadius: CGFloat = .zero) {
        self.color = color
        self.width = width
        self.cornerRadius = cornerRadius
    }
}

/// 字体数据结构
public struct xSegmentItemFont {
    /// 普通
    public var normal = UIFont.systemFont(ofSize: 15)
    /// 选中
    public var choose = UIFont.systemFont(ofSize: 15)
    
    /// 实例化对象
    public init(normal: UIFont = .systemFont(ofSize: 15),
                choose: UIFont = .systemFont(ofSize: 15))
    {
        self.normal = normal
        self.choose = choose
    }
    public static func xNew(fontSize : CGFloat) -> xSegmentItemFont
    {
        let font = xSegmentItemFont.init(normal: .systemFont(ofSize: fontSize),
                                         choose: .systemFont(ofSize: fontSize))
        return font
    }
    
}

public class xSegmentConfig: NSObject {
    
    // MARK: - Struct
    /// 指示线数据结构
    public struct xSegmentLine {
        /// 颜色
        public var color = UIColor.red
        /// 高度
        public var height = CGFloat(1.5)
        /// 底部留空
        public var bottomSpacing = CGFloat(0)
        /// 相对于Item的宽度（默认相等）
        public var widthOfItemPercent = CGFloat(1)
    }
    
    // MARK: - Public Property
    /// 是否自适应宽度
    public var isAutoWidth = true
    /// 字体
    public var font = xSegmentItemFont.init(normal: .systemFont(ofSize: 14),
                                            choose: .boldSystemFont(ofSize: 15))
    /// 行数
    public var titleLines = 1
    
    /// 间距
    public var spacing = CGFloat.zero
    /// item指定高度(默认44)
    public var itemHeight = CGFloat(44)
    /// item指定宽度(默认0)
    public var itemWidth = CGFloat(0)
    /// item边距(默认8，自适应计算宽度后留空)
    public var itemMargin = UIEdgeInsets.init(top: 0, left: 8, bottom: 0, right: 8)
    
    /// 标题颜色
    public var titleColor = xSegmentItemColor(normal: .lightGray,
                                              choose: .darkText)
    /// 背景颜色
    public var backgroundColor = xSegmentItemColor.xNewClear()
    
    /// 边框样式
    public var border = xSegmentItemBorder()
    
    /// 指示线样式
    public var line = xSegmentLine()
    
    // MARK: - 更新配置
    /// 更新基本配置
    /// - Parameters:
    ///   - isAutoWidth: 是否自动计算宽度
    ///   - titleLines: 标题行数(默认1行)
    ///   - spacing: 内容间距(默认0)
    public func updateBasic(isAutoWidth : Bool = true,
                            titleLines : Int = 1,
                            spacing : CGFloat = 0)
    {
        self.isAutoWidth = isAutoWidth
        self.titleLines = titleLines
        self.spacing = spacing
    }
    /// 更新字体配置
    /// - Parameters:
    ///   - normal: 普通字体
    ///   - choose: 选中字体
    public func updateFont(normal : UIFont,
                           choose : UIFont)
    {
        self.font.normal = normal
        self.font.choose = choose
    }
    /// 更新Item配置
    /// - Parameters:
    ///   - height: 高度
    ///   - width: 宽度(默认0，自适应计算)
    ///   - margin: 边距(默认8，自适应计算宽度后留空)
    public func updateItem(height : CGFloat,
                           width : CGFloat = 0,
                           margin : UIEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: 8))
    {
        self.itemHeight = height
        self.itemWidth = width
        self.itemMargin = margin
    }
    /// 更新颜色配置
    /// - Parameters:
    ///   - title: 标题颜色
    ///   - background: 背景颜色
    public func updateColor(title : xSegmentItemColor,
                            background : xSegmentItemColor)
    {
        self.titleColor = title
        self.backgroundColor = background
    }
    /// 更新边框配置
    /// - Parameters:
    ///   - color: 边框颜色
    ///   - width: 边框线条宽度
    ///   - radius: 圆角半径
    public func updateBorder(color : xSegmentItemColor,
                             width : CGFloat,
                             radius : CGFloat)
    {
        self.border.color = color
        self.border.width = width
        self.border.cornerRadius = radius
    }
    /// 更新指示线配置
    /// - Parameters:
    ///   - color: 颜色
    ///   - height: 线高
    ///   - widthRatio: 线宽比例(默认1)
    ///   - bottomSpacing: 底部间距(默认0，贴底部)
    public func updateIndicatorLine(color : UIColor,
                                    height : CGFloat,
                                    widthRatio : CGFloat = 1,
                                    bottomSpacing : CGFloat = 0)
    {
        self.line.color = color
        self.line.height = height
        self.line.widthOfItemPercent = widthRatio
        self.line.bottomSpacing = bottomSpacing
    }
    
}
