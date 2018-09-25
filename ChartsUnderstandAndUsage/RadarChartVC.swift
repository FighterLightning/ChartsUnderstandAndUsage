//
//  RadarChartVC.swift
//  ChartsUnderstandAndUsage
//
//  Created by 张海峰 on 2018/9/13.
//  Copyright © 2018年 张海峰. All rights reserved.
//Charts框架地址
//https://github.com/danielgindi/Charts.git
//该demo地址
//https://github.com/FighterLightning/ChartsUnderstandAndUsage.git
/*雷达图*/
import UIKit
import Charts
class RadarChartVC: UIViewController {
    var radarChartView: RadarChartView  = RadarChartView()
    var data: RadarChartData = RadarChartData()
    let axisMaximum :Double = 150
    lazy var xVals: NSMutableArray = NSMutableArray.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ZHFColor.yellow
        //添加雷达图和刷新按钮
        addRadarChartAndRefreshBtn()
        //设置基本样式
        setRadarChartViewBaseStyle()
    }
   //添加雷达图和刷新按钮
    func addRadarChartAndRefreshBtn(){
        radarChartView.backgroundColor = ZHFColor.white
        radarChartView.frame.size = CGSize.init(width: 300, height: 300)
        radarChartView.center = self.view.center
        radarChartView.delegate = self
        self.view.addSubview(radarChartView)
        //添加刷新按钮
        let btn: UIButton = UIButton.init(type: UIButtonType.custom)
        btn.frame = CGRect.init(x: 30, y: 84, width: 40, height: 25)
        btn.setTitle("刷新", for: UIControlState.normal)
        btn.backgroundColor = ZHFColor.red
        btn.setTitleColor(ZHFColor.zhf33_titleTextColor, for: UIControlState.normal)
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.addTarget(self, action: #selector(updataData), for: UIControlEvents.touchUpInside)
        self.view.addSubview(btn)
    }
    func setRadarChartViewBaseStyle(){
        //雷达图描述
        radarChartView.rotationEnabled = true //是否允许转动
        radarChartView.highlightPerTapEnabled = true //是否能被选中
        //雷达图线条样式
        radarChartView.webLineWidth = 0.5 //主干线线宽
        radarChartView.webColor = ZHFColor.black
        radarChartView.innerWebLineWidth = 0.375 //边线线宽
        radarChartView.innerWebColor = ZHFColor.black
        radarChartView.webAlpha = 1 //透明度
        //设置 xAx
        let xAxis: XAxis = radarChartView.xAxis
        xAxis.valueFormatter = self //重写代理方法  设置y轴数据
        xAxis.labelPosition = XAxis.LabelPosition.topInside //X轴（5种位置显示，根据需求进行设置）
        xAxis.labelFont = UIFont.systemFont(ofSize: 10)//x轴数值字体大小
        xAxis.labelTextColor = ZHFColor.brown//数值字体颜色
        
        //设置 yAxis
        let yAxis: YAxis = radarChartView.yAxis
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = axisMaximum
        yAxis.drawLabelsEnabled = false
        yAxis.labelCount = 8
        yAxis.labelFont = UIFont.systemFont(ofSize: 10)//x轴数值字体大小
        xAxis.labelTextColor = ZHFColor.brown//数值字体颜色
       
        //雷达图图例
        radarChartView.chartDescription?.text = "雷达图示例"
        radarChartView.chartDescription?.font = UIFont.systemFont(ofSize: 10)
        radarChartView.chartDescription?.textColor = ZHFColor.zhf33_titleTextColor
        radarChartView.chartDescription?.position = CGPoint.init(x: 80, y: 5)//位置（及在radarChartView的中心点）
        //图例在雷达图中的位置(右上角)
        radarChartView.legend.horizontalAlignment = Legend.HorizontalAlignment.right
        radarChartView.legend.verticalAlignment = Legend.VerticalAlignment.top
        radarChartView.legend.orientation = Legend.Orientation.horizontal
        radarChartView.legend.formSize = 10;//图示大小
        radarChartView.legend.maxSizePercent = 1 //图例在饼状图中的大小占比, 这会影响图例的宽高
        radarChartView.legend.formToTextSpace = 5 //文本间隔
        radarChartView.legend.font = UIFont.systemFont(ofSize: 10)//字体大小
        radarChartView.legend.textColor = ZHFColor.gray//字体颜色
        radarChartView.legend.form = Legend.Form.circle//图示样式: 方形、线条、圆形
        //为雷达图提供数据
        self.data = setData()
        radarChartView.data = self.data;
        //设置动画效果
        radarChartView.animate(yAxisDuration: 1)//展示方式xAxisDuration 和 yAxisDuration两种
    }
    func setData() -> RadarChartData{
        let count = 12
        //对应x轴上面需要显示的数据
        let x1Vals: NSMutableArray  = NSMutableArray.init()
        for i in 0 ..< count {
            //x轴字体展示
            x1Vals.add("\(i + 1)月")
            self.xVals = x1Vals
        }
        //对应Y轴上面需要显示的数据
        let yVals: NSMutableArray  = NSMutableArray.init()
        for _ in 0 ..< count {
            let val: Double = Double(arc4random_uniform(UInt32(axisMaximum - 50)) + 50)
            let entry:RadarChartDataEntry = RadarChartDataEntry.init(value: val)
            yVals.add(entry)
        }
        //创建RadarChartDataSet对象，其中包含有Y轴数据信息
        let set1: RadarChartDataSet = RadarChartDataSet.init(values: yVals as? [ChartDataEntry], label: "雷达星座运势图")
        set1.lineWidth = 0.5 //数据折线线宽
        set1.setColor(ZHFColor.gray)//颜色
        set1.drawFilledEnabled = true ////是否填充颜色
        set1.fillColor = ZHFColor.green
        set1.fillAlpha = 0.3
        set1.drawValuesEnabled = true //是否绘制显示数据
        set1.highlightEnabled = true //点击选饼状图是否有高亮效果，（单击空白处取消选中）
        set1.valueFont = UIFont.systemFont(ofSize: 10)
        set1.valueTextColor = ZHFColor.gray
        let dataSets: NSMutableArray  = NSMutableArray.init()
        dataSets.add(set1)
        //创建RadarChartData对象, 此对象就是radarChartView需要最终数据对象
        let data:  RadarChartData = RadarChartData.init(dataSets: dataSets as? [IChartDataSet])
        return data
    }
    @objc func updataData(){
        //重新设置基本样式
        setRadarChartViewBaseStyle()
      
    }
}
//MARK:-   <ChartViewDelegate代理方法实现>
extension RadarChartVC :ChartViewDelegate,IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if Int(value) > self.xVals.count - 1 {
             return self.xVals[Int(value - 1)] as! String
        }
        else{
             return self.xVals[Int(value)] as! String
        }
    }
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
