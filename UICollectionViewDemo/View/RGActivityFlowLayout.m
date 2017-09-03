//
//  RGActivityFlowLayout.m
//  Vmei
//
//  Created by ios-02 on 2017/8/11.
//  Copyright © 2017年 com.vmei. All rights reserved.
//

#import "RGActivityFlowLayout.h"

#define pinSection 3
//#define kPinHeaderH 88
@interface RGActivityFlowLayout ()<UICollectionViewDelegateFlowLayout>




@end

@implementation RGActivityFlowLayout

-(void)prepareLayout{

}



-(NSArray <UICollectionViewLayoutAttributes *>*)layoutAttributesForElementsInRect:(CGRect)rect{


    NSArray * superArray = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray * newAttArray = [NSMutableArray arrayWithArray:superArray];
    NSIndexPath *index = [NSIndexPath indexPathForItem:0 inSection:pinSection];

    

    
    for (UICollectionViewLayoutAttributes * arr in superArray) {
        if ([arr.representedElementKind isEqualToString:UICollectionElementKindSectionHeader] && arr.indexPath.section == pinSection) {
            //说明superArray中已经有了悬停header 的 UICollectionViewLayoutAttributes
            [newAttArray removeObject:arr];
            break;
        }
    }
    
    
    UICollectionViewLayoutAttributes * pinHeaderAttri = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:index];
    [newAttArray addObject:pinHeaderAttri];
    

    NSInteger cellCountInSection = [self.collectionView numberOfItemsInSection:pinSection];
    NSIndexPath *firstItemIndexInPinSection = [NSIndexPath indexPathForItem:0 inSection:pinSection];
    
    UICollectionViewLayoutAttributes *firstAttriInSection ;
    if (cellCountInSection > 0) {
        firstAttriInSection = [self layoutAttributesForItemAtIndexPath:firstItemIndexInPinSection];
    } else {
        firstAttriInSection = [[UICollectionViewLayoutAttributes alloc]init];
        CGFloat y = CGRectGetMaxY(pinHeaderAttri.frame) + self.sectionInset.top;
        firstAttriInSection.frame = CGRectMake(0, y, 0, 0);
    }

    
    CGFloat offset = self.collectionView.contentOffset.y;
    
    CGFloat headerY = firstAttriInSection.frame.origin.y - pinHeaderAttri.frame.size.height - self.sectionInset.top;
    // 设置section的Y值，确保section悬浮在屏幕上方
    CGFloat maxY = (offset>headerY) ? offset : headerY;
    
    rect.origin.y = maxY;
    pinHeaderAttri.frame = CGRectMake(0, maxY, pinHeaderAttri.frame.size.width,pinHeaderAttri.frame.size.height);
    // 这里的zIndex需要大于10，不然会被别的attributes覆盖掉
    pinHeaderAttri.zIndex = 20;

    
    
    return newAttArray;
}


-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}






//@end

//#define kSectionH 88
//
//#define kTopCellH  150
//#define kSubTitleH 44
//#define kMargin 15
//#define kProductCellW (kScreenSize.width-3*kMargin)/2
//
//@interface RGActivityFlowLayout ()
//
//@property (nonatomic,strong)NSMutableArray * attrsArr;
//
//
//@end
//
//@implementation RGActivityFlowLayout
//
//-(NSMutableArray *)attrsArr{
//    if (!_attrsArr) {
//        _attrsArr = [NSMutableArray array];
//    }
//    return _attrsArr;
//}
//
//-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
//{
//    return YES;
//}
//
//-(CGSize)collectionViewContentSize{
//    UICollectionViewLayoutAttributes *lastAttri = self.attrsArr.lastObject;
//    return CGSizeMake(kScreenSize.width, lastAttri.frame.origin.y+lastAttri.frame.size.height);
//}
//
//-(void)prepareLayout{
//    [super prepareLayout];
//    
//    self.scrollDirection = UICollectionViewScrollDirectionVertical;
//    
//    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    [self.attrsArr removeAllObjects];
//    
//    NSInteger sectionCount = [self.collectionView numberOfSections];
//    for (int s = 0; s < sectionCount; s++) {
//        NSInteger itemCount = [self.collectionView numberOfItemsInSection:s];
//        for (int i = 0; i < itemCount; i++) {
//            NSIndexPath * index = [NSIndexPath indexPathForItem:i inSection:s];
//            
//            UICollectionViewLayoutAttributes *itemAttr = [self layoutAttributesForItemAtIndexPath:index];
//            [self.attrsArr addObject:itemAttr];
//            
//        }
//    }
//}
//
//-(NSArray <UICollectionViewLayoutAttributes *>*)layoutAttributesForElementsInRect:(CGRect)rect{
//    NSArray * attri = [super layoutAttributesForElementsInRect:rect];
//    
//    return self.attrsArr;
//}
//
//
//-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    
//    UICollectionViewLayoutAttributes * cellAttri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    
//    
//    if (indexPath.section == 0) {
//        cellAttri.size = CGSizeMake(kScreenSize.width, kTopCellH);
//        cellAttri.center = CGPointMake(kScreenSize.width/2, kTopCellH/2+kTopCellH*indexPath.section);
//
//    }else{
//        NSInteger previousCellCount = [self previousCellCountOfCurrentSection:indexPath.section];
//        UICollectionViewLayoutAttributes *preAttri = self.attrsArr[previousCellCount+ indexPath.item-1];
//        CGFloat PreBottomY = preAttri.frame.origin.y+preAttri.frame.size.height;
//        
//        if (indexPath.section == 1 || indexPath.section == 2)
//        {
//            
//            cellAttri.size = CGSizeMake(kScreenSize.width, kTopCellH);
//            cellAttri.center = CGPointMake(kScreenSize.width/2, kTopCellH/2+PreBottomY);
//            
//        }
//        else if (indexPath.section == 3)
//        {
//            
//            if (indexPath.item == 0) {
//                
//                cellAttri.size = CGSizeMake(kScreenSize.width, kSubTitleH);
//                cellAttri.center = CGPointMake(kScreenSize.width/2, kSubTitleH/2+PreBottomY+kSectionH);
//            }else{
//                
//                cellAttri.size = CGSizeMake(kProductCellW, kProductCellW);
//                if ((indexPath.item-1)%2 == 0) {
//                    cellAttri.center = CGPointMake(kMargin+kProductCellW/2, PreBottomY+kProductCellW/2);
//                }else if ((indexPath.item-1)%2 == 1){
//                    cellAttri.center = CGPointMake(kScreenSize.width-(kProductCellW/2+kMargin), PreBottomY-kProductCellW/2);
//                }
//                
//            }
//            
//        }
//        else if (indexPath.section == 4)
//        {
//            if (indexPath.item == 0) {
//                cellAttri.size = CGSizeMake(kScreenSize.width, kSubTitleH);
//                cellAttri.center = CGPointMake(kScreenSize.width/2, kSubTitleH/2+PreBottomY);
//            }else{
//                cellAttri.size = CGSizeMake(kProductCellW, kProductCellW);
//                if ((indexPath.item-1)%2 == 0) {
//                    cellAttri.center = CGPointMake(kMargin+kProductCellW/2, PreBottomY+kProductCellW/2);
//                }else if ((indexPath.item-1)%2 == 1){
//                    cellAttri.center = CGPointMake(kScreenSize.width-(kProductCellW/2+kMargin), PreBottomY-kProductCellW/2);
//                }
//
//            }
//        }
//
//    }
//    
//    
//    return cellAttri;
//}
//
//
///**
// 当前section之前的cell 总个数
// */
//-(NSInteger)previousCellCountOfCurrentSection:(NSInteger)section
//{
//    
//    if (section <= 0) {
//        return 0 ;
//    }
//    NSInteger previousCellCount = 0;
//    for (int s = 0; s < section; s++) {
//        NSInteger itemCount = [self.collectionView numberOfItemsInSection:s];
//        for (int i = 0; i < itemCount; i++) {
//            previousCellCount+=1;
//            
//        }
//    }
//    return previousCellCount;
//
//}
//@end
@end

