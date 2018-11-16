//
//  WaveformChartVC.swift
//  ChartsUnderstandAndUsage
//
//  Created by 张海峰 on 2018/11/15.
//  Copyright © 2018年 张海峰. All rights reserved.
////Charts框架地址
//https://github.com/danielgindi/Charts.git
//该demo地址
//https://github.com/FighterLightning/ChartsUnderstandAndUsage.git
/*波浪图*/

import UIKit
import Charts
class WaveformChartVC: BaseVC {
    var lineChartView: LineChartView  = LineChartView()
    override func viewDidLoad() {
        super.viewDidLoad()
        //添加折线
        addLineChart()
        //设置基本样式
        setLineChartViewBaseStyle()
        setXAxisStyle()
        setYAxisStyle()
        //添加（刷新数据）
        updataData()
    }
    //添加折线
    func addLineChart(){
        lineChartView.backgroundColor = ZHFColor.white
        lineChartView.frame.size = CGSize.init(width: ScreenWidth - 20, height: 150)
        lineChartView.center = self.view.center
        lineChartView.delegate = self
        self.view.addSubview(lineChartView)
        //刷新按钮响应
        refreshrBtn.addTarget(self, action: #selector(updataData), for: UIControlEvents.touchUpInside)
    }
    //基本样式
    func setLineChartViewBaseStyle(){
        lineChartView.noDataText = "暂无数据" //如果没有数据会显示这个
        lineChartView.drawGridBackgroundEnabled = true  //绘制图形区域背景
        lineChartView.gridBackgroundColor = ZHFColor.white //背景颜色
        lineChartView.alpha = 0.5//背景透明度
        //折线图描述文字和样式
        lineChartView.chartDescription?.text = "波浪图描述"
        lineChartView.legend.textColor = ZHFColor.purple //描述文字颜色
        lineChartView.legend.formSize = 10 //（图例大小）默认是8
        lineChartView.legend.form = Legend.Form.circle//图例头部样式
        //矩形：.square（默认值） 圆形：.circle   横线：.line  无：.none 空：.empty（与 .none 一样都不显示头部，但不同的是 empty 头部仍然会占一个位置)
        lineChartView.chartDescription?.position = CGPoint.init(x: lineChartView.frame.width - 30, y:lineChartView.frame.height - 20)//位置（及在lineChartView的中心点）
        lineChartView.chartDescription?.font = UIFont.systemFont(ofSize: 12)//大小
        lineChartView.chartDescription?.textColor = UIColor.red
        //设置交互样式
        lineChartView.scaleYEnabled = false //取消Y轴缩放
        lineChartView.doubleTapToZoomEnabled = true //双击缩放
        lineChartView.dragEnabled = true //启用拖动手势
        lineChartView.dragDecelerationEnabled = true //拖拽后是否有惯性效果
        lineChartView.dragDecelerationFrictionCoef = 0.9 //拖拽后惯性效果摩擦系数(0~1)越小惯性越不明显
        //修改背景色和边框样式
        lineChartView.drawBordersEnabled = true  //绘制图形区域边框
        lineChartView.borderColor = ZHFColor.red  //边框为红色
        lineChartView.borderLineWidth = 2  //边框线条大小为2
    }
    //设置x轴的样式属性
    func setXAxisStyle(){
        //轴线宽、颜色、刻度、间隔
        lineChartView.xAxis.axisLineWidth = 2 //x轴宽度
        lineChartView.xAxis.axisLineColor = .black //x轴颜色
        lineChartView.xAxis.axisMinimum = -3 //最小刻度值
        lineChartView.xAxis.axisMaximum = 15 //最大刻度值
        lineChartView.xAxis.labelCount = 18//显示个数
        lineChartView.xAxis.spaceMin = 1 //最小间隔
      
        //文字属性
        lineChartView.xAxis.labelPosition = .bottom //x轴上的数字显示在下方（默认显示在上方 .top .bottom .bothSided .topInside .bottomInside）
        lineChartView.xAxis.labelTextColor = .red //刻度文字颜色
        lineChartView.xAxis.labelFont = .systemFont(ofSize: 13) //刻度文字大小
    
    }
    //设置y轴的样式属性(分左、右侧)
    func setYAxisStyle(){
        //右侧(默认显示)
        //        lineChartView.rightAxis.drawLabelsEnabled = false //不绘制右侧Y轴文字
        lineChartView.rightAxis.drawAxisLineEnabled = false //不显示右侧Y轴
        lineChartView.rightAxis.enabled = false //禁用右侧的Y轴
        //左侧
        //        lineChartView.leftAxis.inverted = true //刻度值反向排列（默认正向）
        //        lineChartView.leftAxis.labelPosition = .insideChart  //文字显示在内侧
        //0刻度线
        lineChartView.leftAxis.axisMinimum = 0
        lineChartView.leftAxis.axisMaximum = 8
        lineChartView.leftAxis.granularity = 1 //最小间隔
    }
    @objc func updataData(){
        let dic: [String: Any] = [
            "5g" : [
                "forty" : ["number" : [0,0,0,0,0,0, 0,0, 0, 0, 0,0],
                    "channelsetting" : [38, 46, 54, 62, 102, 110,  118,126, 134,142,151,159]],
                "eighty" : ["number" : [5,5,0,0,0,1],
                    "channelsetting" : [42,58,106,122,138,155]],
                "twenty" : ["number" : [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
                    "channelsetting" : [36,40,44,48,52,56,60,64,100,104,108,112,116,120,124,128,32,136,140,144,149,153,157,161,165]]
            ],
            "2.4g" : [
                "twenty" : ["number" : [5,0,0,0,0,4,0,0,0,0,2,0,0],
                            "channelsetting" : [1,2,3,4,5,6,7,8,9,10,11,12,13]],
                "forty" : ["number" : [5,0,0,0,0,2,0,0,0,0,0,0],
                           "channelsetting" : [2,3,4,5,6,7,8,9,10,11,12,13]],
            ]
        ]
        
        let dic24:[String:Any] = dic["2.4g"] as! [String : Any]
        let dic2420:[String:Any] = dic24["twenty"] as! [String : Any]
        let dic2420X:[NSInteger] = dic2420["channelsetting"] as! [NSInteger]
        let dic2420Y:[NSInteger] = dic2420["number"] as! [NSInteger]
        let dic2440:[String:Any] = dic24["forty"] as! [String : Any]
        let dic2440X:[NSInteger]  = dic2440["channelsetting"] as! [NSInteger]
        let dic2440Y:[NSInteger] = dic2440["number"] as! [NSInteger]
        let chartData = LineChartData.init()
        //2.4g 20Hz 的图
        if dic2420Y.count > 0 {
            add(xArr: dic2420X, yArr: dic2420Y, HzNumber: 24/5,chartData:chartData,fillColor: ZHFColor.zhf_strColor(hex: "000000"))
        }
        //2.4g 40Hz 的图
        if dic2440Y.count > 0 {
            add(xArr: dic2440X, yArr: dic2440Y, HzNumber: 40/5,chartData:chartData,fillColor: ZHFColor.zhf_color(withHex: 0xff0000))
        }
    }
    /*
     xArr: x轴数组
     yArr: y轴数组
     HzNumber: Hz/间隔代表值
     chartData: 初始化的 chartData
     fillColor: 填充色
     */
    func add(xArr:[NSInteger],yArr:[NSInteger],HzNumber:Double,chartData:LineChartData,fillColor:UIColor){
        var labelStr1:String = ""
        var labelColor1: UIColor = ZHFColor.orange
        var isHaveLabel:Bool = true
        for i in 0 ..< xArr.count {
            let x = xArr[i]
            let y = yArr[i]
            if y != 0{
                if isHaveLabel == true{
                   labelStr1 = "波浪线"
                   labelColor1 = ZHFColor.orange
                }
                else{
                   labelStr1 = ""
                    labelColor1 = ZHFColor.clear
                }
                var dataEntries1 = [ChartDataEntry]()
                let entry1 = ChartDataEntry.init(x: Double(x) - HzNumber, y: -Double(y) - 1)
                let entry2 = ChartDataEntry.init(x: Double(x), y: Double(y))
                let entry3 = ChartDataEntry.init(x: Double(x) + HzNumber, y: -Double(y) - 1)
                dataEntries1.append(entry1)
                dataEntries1.append(entry2)
                dataEntries1.append(entry3)
                let chartDataSet1 = LineChartDataSet(values: dataEntries1, label: labelStr1)
                chartDataSet1.mode = .horizontalBezier //(.line、.cubicBezier、.horizontalBezier、.stepped)
                chartDataSet1.setColor(labelColor1)
                chartDataSet1.lineWidth = 0
                chartDataSet1.drawCirclesEnabled = false //不绘制拐点
                chartDataSet1.fillAlpha = 0.3
                chartDataSet1.fillColor = fillColor
                chartDataSet1.drawFilledEnabled = true  //绘制上填充色
                chartDataSet1.fillFormatter = DefaultFillFormatter { _,_  -> CGFloat in
                    return CGFloat(self.lineChartView.leftAxis.axisMinimum) //向下绘制填充区域
                }
                chartData.addDataSet(chartDataSet1)
                isHaveLabel = false
            }
        }
        lineChartView.data = chartData
    }
}
extension WaveformChartVC: ChartViewDelegate{
    //1.点击选中
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        ZHFLog(message: "点击选中")
    }
    //2.没有选中
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        ZHFLog(message: "没有选中")
    }
    //3.捏合放大或缩小
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        ZHFLog(message: "捏合放大或缩小")
    }
    //4.拖拽图表
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        ZHFLog(message: "拖拽图表")
    }
}
