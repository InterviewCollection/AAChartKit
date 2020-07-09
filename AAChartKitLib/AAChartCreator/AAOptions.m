//
//  AAOptions.m
//  AAChartKit
//
//  Created by An An on 17/1/4.
//  Copyright © 2017年 An An. All rights reserved.
//*************** ...... SOURCE CODE ...... ***************
//***...................................................***
//*** https://github.com/AAChartModel/AAChartKit        ***
//*** https://github.com/AAChartModel/AAChartKit-Swift  ***
//***...................................................***
//*************** ...... SOURCE CODE ...... ***************

/*
 
 * -------------------------------------------------------------------------------
 *
 * 🌕 🌖 🌗 🌘  ❀❀❀   WARM TIPS!!!   ❀❀❀ 🌑 🌒 🌓 🌔
 *
 * Please contact me on GitHub,if there are any problems encountered in use.
 * GitHub Issues : https://github.com/AAChartModel/AAChartKit/issues
 * -------------------------------------------------------------------------------
 * And if you want to contribute for this project, please contact me as well
 * GitHub        : https://github.com/AAChartModel
 * StackOverflow : https://stackoverflow.com/users/7842508/codeforu
 * JianShu       : https://www.jianshu.com/u/f1e6753d4254
 * SegmentFault  : https://segmentfault.com/u/huanghunbieguan
 *
 * -------------------------------------------------------------------------------
 
 */

#import "AAOptions.h"

@implementation AAOptions

AAPropSetFuncImplementation(AAOptions, AAChart       *, chart)
AAPropSetFuncImplementation(AAOptions, AATitle       *, title)
AAPropSetFuncImplementation(AAOptions, AASubtitle    *, subtitle)
AAPropSetFuncImplementation(AAOptions, AAXAxis       *, xAxis)
AAPropSetFuncImplementation(AAOptions, AAYAxis       *, yAxis)
AAPropSetFuncImplementation(AAOptions, AATooltip     *, tooltip)
AAPropSetFuncImplementation(AAOptions, AAPlotOptions *, plotOptions)
AAPropSetFuncImplementation(AAOptions, NSArray       *, series)
AAPropSetFuncImplementation(AAOptions, AALegend      *, legend)
AAPropSetFuncImplementation(AAOptions, AAPane        *, pane)
AAPropSetFuncImplementation(AAOptions, NSArray       *, colors)
AAPropSetFuncImplementation(AAOptions, BOOL,            gradientColorEnabled)
AAPropSetFuncImplementation(AAOptions, NSString      *, zoomResetButtonText)  //String to display in 'zoom reset button"
AAPropSetFuncImplementation(AAOptions, BOOL           , touchEventEnabled)
AAPropSetFuncImplementation(AAOptions, BOOL           , customEventEnabled)

@end

#define AAFontSizeFormat(fontSize) [self configureFontSize:fontSize]

@implementation AAOptionsConstructor

+ (AAOptions *)configureChartOptionsWithAAChartModel:(AAChartModel *)aaChartModel {
    
    AAChart *aaChart = AAChart.new
    .typeSet(aaChartModel.chartType)//绘图类型
    .invertedSet(aaChartModel.inverted)//设置是否反转坐标轴，使X轴垂直，Y轴水平。 如果值为 true，则 x 轴默认是 倒置 的。 如果图表中出现条形图系列，则会自动反转
    .backgroundColorSet(aaChartModel.backgroundColor)//设置图表的背景色(包含透明度的设置)
    .pinchTypeSet(aaChartModel.zoomType)//设置手势缩放方向
    .panningSet(true)//设置手势缩放后是否可平移
    .polarSet(aaChartModel.polar)
    .scrollablePlotAreaSet(aaChartModel.scrollablePlotArea);
    
    AATitle *aaTitle = AATitle.new
    .textSet(aaChartModel.title);//标题文本内容
    
    if (![aaChartModel.title isEqualToString:@""]) {
        aaTitle.styleSet(AAStyle.new
                         .colorSet(aaChartModel.titleFontColor)//Title font color
                         .fontSizeSet(AAFontSizeFormat(aaChartModel.titleFontSize))//Title font size
                         .fontWeightSet(aaChartModel.titleFontWeight)//Title font weight
                         );
    }
    
    AASubtitle *aaSubtitle;
    if (![aaChartModel.subtitle isEqualToString:@""]) {
        aaSubtitle = AASubtitle.new
        .textSet(aaChartModel.subtitle)//副标题内容
        .alignSet(aaChartModel.subtitleAlign)//图表副标题文本水平对齐方式。可选的值有 “left”，”center“和“right”。 默认是：center.
        .styleSet(AAStyle.new
                  .colorSet(aaChartModel.subtitleFontColor)//Subtitle font color
                  .fontSizeSet(AAFontSizeFormat(aaChartModel.subtitleFontSize))//Subtitle font size
                  .fontWeightSet(aaChartModel.subtitleFontWeight)//Subtitle font weight
                  );
    }
    
    AATooltip *aaTooltip = AATooltip.new
    .enabledSet(aaChartModel.tooltipEnabled)//启用浮动提示框
    .sharedSet(aaChartModel.tooltipShared)//多组数据共享一个浮动提示框
    .crosshairsSet(true)//启用准星线
    //.pointFormatSet(aaChartModel.tooltipValueString)//Tooltip value point format string
    .valueSuffixSet(aaChartModel.tooltipValueSuffix);//浮动提示框的单位名称后缀
    
    AAPlotOptions *aaPlotOptions = AAPlotOptions.new
    .seriesSet(AASeries.new
               .stackingSet(aaChartModel.stacking)
               );//设置是否百分比堆叠显示图形
    
    if (aaChartModel.animationType != 0) {
        aaPlotOptions.series.animation = (AAAnimation.new
                                          .easingSet(aaChartModel.animationType)
                                          .durationSet(aaChartModel.animationDuration)
                                          );
    }
    
    [self configureTheStyleOfConnectNodeWithChartModel:aaChartModel plotOptions:aaPlotOptions];
    [self configureTheAAPlotOptionsWithPlotOptions:aaPlotOptions chartModel:aaChartModel];
    
    AALegend *aaLegend = AALegend.new
    .enabledSet(aaChartModel.legendEnabled);//是否显示 legend
    
    AAOptions *aaOptions = AAOptions.new
    .chartSet(aaChart)
    .titleSet(aaTitle)
    .subtitleSet(aaSubtitle)
    .tooltipSet(aaTooltip)
    .plotOptionsSet(aaPlotOptions)
    .legendSet(aaLegend)
    .seriesSet(aaChartModel.series)
    .colorsSet(aaChartModel.colorsTheme)//设置颜色主题
    .gradientColorEnabledSet(aaChartModel.easyGradientColors)//主题颜色是否为渐变色
    .zoomResetButtonTextSet(aaChartModel.zoomResetButtonText)//重置缩放按钮的默认标题
    .touchEventEnabledSet(aaChartModel.touchEventEnabled);//是否支持点击事件
    
    [self configureAxisContentAndStyleWithAAOptions:aaOptions AAChartModel:aaChartModel];
    
    return aaOptions;
}

+ (void)configureTheStyleOfConnectNodeWithChartModel:(AAChartModel *)aaChartModel
                                         plotOptions:(AAPlotOptions *)aaPlotOptions {
    AAChartType aaChartType = aaChartModel.chartType;
    //数据点标记相关配置，只有折线图、曲线图、折线区域填充图、曲线区域填充图、散点图才有数据点标记
    if (   aaChartType == AAChartTypeArea
        || aaChartType == AAChartTypeAreaspline
        || aaChartType == AAChartTypeLine
        || aaChartType == AAChartTypeSpline
        || aaChartType == AAChartTypeScatter
        || aaChartType == AAChartTypeArearange
        || aaChartType == AAChartTypeAreasplinerange
        || aaChartType == AAChartTypePolygon
        ) {
        AAMarker *aaMarker = AAMarker.new
        .radiusSet(aaChartModel.markerRadius)//曲线连接点半径，默认是4
        .symbolSet(aaChartModel.markerSymbol);//曲线点类型："circle", "square", "diamond", "triangle","triangle-down"，默认是"circle"
        if (aaChartModel.markerSymbolStyle == AAChartSymbolStyleTypeInnerBlank) {
            aaMarker.fillColorSet(@"#ffffff")//点的填充色(用来设置折线连接点的填充色)
            .lineWidthSet(@(0.4 * aaChartModel.markerRadius.floatValue))//外沿线的宽度(用来设置折线连接点的轮廓描边的宽度)
            .lineColorSet(@"");//外沿线的颜色(用来设置折线连接点的轮廓描边颜色，当值为空字符串时，默认取数据点或数据列的颜色)
        } else if (aaChartModel.markerSymbolStyle == AAChartSymbolStyleTypeBorderBlank) {
            aaMarker.lineWidthSet(@2)
            .lineColorSet(aaChartModel.backgroundColor);
        }
        AASeries *aaSeries = aaPlotOptions.series;
        aaSeries.connectNulls = aaChartModel.connectNulls;
        aaSeries.marker = aaMarker;
    }
}

+ (void)configureTheAAPlotOptionsWithPlotOptions:(AAPlotOptions *)aaPlotOptions
                                      chartModel:(AAChartModel *)aaChartModel {
    
    AAChartType chartType = aaChartModel.chartType;
    
    AADataLabels *aaDataLabels = AADataLabels.new
    .enabledSet(aaChartModel.dataLabelsEnabled);
    if (aaChartModel.dataLabelsEnabled == true) {
        aaDataLabels
        .styleSet(AAStyle.new
                  .colorSet(aaChartModel.dataLabelsFontColor)
                  .fontSizeSet(AAFontSizeFormat(aaChartModel.dataLabelsFontSize))
                  .fontWeightSet(aaChartModel.dataLabelsFontWeight)
                  );
    }
    
    if (chartType == AAChartTypeColumn) {
        AAColumn *aaColumn = (AAColumn.new
                              .borderWidthSet(@0)
                              .borderRadiusSet(aaChartModel.borderRadius)
                              );
        if (aaChartModel.polar == true) {
            aaColumn.pointPaddingSet(@0)
            .groupPaddingSet(@0.005);
        }
        aaPlotOptions.columnSet(aaColumn);
    } else if (chartType == AAChartTypeBar) {
        AABar *aaBar = (AABar.new
                        .borderWidthSet(@0)
                        .borderRadiusSet(aaChartModel.borderRadius)
                        );
        if (aaChartModel.polar == true) {
            aaBar.pointPaddingSet(@0)
            .groupPaddingSet(@0.005);
        }
        aaPlotOptions.barSet(aaBar);
    } else if (chartType == AAChartTypePie) {
        AAPie *aaPie = AAPie.new
        .allowPointSelectSet(true)
        .cursorSet(@"pointer")
        .showInLegendSet(true);
        if (aaChartModel.dataLabelsEnabled == true) {
            aaDataLabels.formatSet(@"<b>{point.name}</b>: {point.percentage:.1f} %");
        }
        aaPlotOptions.pieSet(aaPie);
    } else if (chartType == AAChartTypeColumnrange) {
        NSMutableDictionary *columnRangeDic = [[NSMutableDictionary alloc]init];
        [columnRangeDic setValue:aaChartModel.borderRadius forKey:@"borderRadius"];//The color of the border surrounding each column or bar
        [columnRangeDic setValue:@0 forKey:@"borderWidth"];//The corner radius of the border surrounding each column or bar. default：0.
        aaPlotOptions.columnrangeSet(columnRangeDic);
    }
    
    aaPlotOptions.series.dataLabelsSet(aaDataLabels);
}

+ (void)configureAxisContentAndStyleWithAAOptions:(AAOptions *)aaOptions
                                     AAChartModel:(AAChartModel *)aaChartModel {
    AAChartType aaChartType = aaChartModel.chartType;
    if (   aaChartType == AAChartTypeColumn
        || aaChartType == AAChartTypeBar
        || aaChartType == AAChartTypeArea
        || aaChartType == AAChartTypeAreaspline
        || aaChartType == AAChartTypeLine
        || aaChartType == AAChartTypeSpline
        || aaChartType == AAChartTypeScatter
        || aaChartType == AAChartTypeBubble
        || aaChartType == AAChartTypeColumnrange
        || aaChartType == AAChartTypeArearange
        || aaChartType == AAChartTypeAreasplinerange
        || aaChartType == AAChartTypeBoxplot
        || aaChartType == AAChartTypeWaterfall
        || aaChartType == AAChartTypePolygon) {
        AAXAxis *aaXAxis = AAXAxis.new
        .labelsSet(AALabels.new
                   .enabledSet(aaChartModel.xAxisLabelsEnabled)//设置 x 轴是否显示文字
                   .styleSet(AAStyle.new
                             .colorSet(aaChartModel.xAxisLabelsFontColor)//xAxis Label font color
                             .fontSizeSet(AAFontSizeFormat(aaChartModel.xAxisLabelsFontSize))//xAxis Label font size
                             .fontWeightSet(aaChartModel.xAxisLabelsFontWeight)//xAxis Label font weight
                             )
                   )
        .reversedSet(aaChartModel.xAxisReversed)
        .gridLineWidthSet(aaChartModel.xAxisGridLineWidth)//x轴网格线宽度
        .categoriesSet(aaChartModel.categories)
        .visibleSet(aaChartModel.xAxisVisible)//x轴是否可见
        .tickIntervalSet(aaChartModel.xAxisTickInterval);//x轴坐标点间隔数
        
        if ([aaChartModel.xAxisCrosshairWidth doubleValue] > 0) {
            aaXAxis.crosshairSet(AACrosshair.new
                                 .widthSet(aaChartModel.xAxisCrosshairWidth)
                                 .colorSet(aaChartModel.xAxisCrosshairColor)
                                 .dashStyleSet(aaChartModel.xAxisCrosshairDashStyleType)
                                 );
        }
        
        AAYAxis *aaYAxis = AAYAxis.new
        .labelsSet(AALabels.new
                   .enabledSet(aaChartModel.yAxisLabelsEnabled)//设置 y 轴是否显示数字
                   .styleSet(AAStyle.new
                             .colorSet(aaChartModel.yAxisLabelsFontColor)//yAxis Label font color
                             .fontSizeSet(AAFontSizeFormat(aaChartModel.yAxisLabelsFontSize))//yAxis Label font size
                             .fontWeightSet(aaChartModel.yAxisLabelsFontWeight)//yAxis Label font weight
                             )
                   .formatSet(@"{value:.,0f}")//让y轴的值完整显示 而不是100000显示为100k
                   )
        .minSet(aaChartModel.yAxisMin)//设置 y 轴最小值,最小值等于零就不能显示负值了
        .maxSet(aaChartModel.yAxisMax)//y轴最大值
        .tickPositionsSet(aaChartModel.yAxisTickPositions)//自定义Y轴坐标
        .allowDecimalsSet(aaChartModel.yAxisAllowDecimals)//是否允许显示小数
        .plotLinesSet(aaChartModel.yAxisPlotLines) //标示线设置
        .reversedSet(aaChartModel.yAxisReversed)
        .gridLineWidthSet(aaChartModel.yAxisGridLineWidth)//y轴网格线宽度
        .titleSet(AAAxisTitle.new
                  .textSet(aaChartModel.yAxisTitle))//y 轴标题
        .lineWidthSet(aaChartModel.yAxisLineWidth)//设置 y轴轴线的宽度,为0即是隐藏 y轴轴线
        .visibleSet(aaChartModel.yAxisVisible)
        .tickIntervalSet(aaChartModel.yAxisTickInterval);
        
        if ([aaChartModel.yAxisCrosshairWidth doubleValue] > 0) {
            aaYAxis.crosshairSet(AACrosshair.new
                                 .widthSet(aaChartModel.yAxisCrosshairWidth)
                                 .colorSet(aaChartModel.yAxisCrosshairColor)
                                 .dashStyleSet(aaChartModel.yAxisCrosshairDashStyleType)
                                 );
        }
        
        aaOptions.xAxis = aaXAxis;
        aaOptions.yAxis = aaYAxis;
    }
}

+ (NSString *)configureFontSize:(NSNumber *)fontSize {
    if (fontSize != nil) {
        return [NSString stringWithFormat:@"%@px", fontSize];
    }
    return nil;
}


@end


