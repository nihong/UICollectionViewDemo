//
//  RGHomePageActivityCVC.m
//  Vmei
//
//  Created by ios-02 on 2017/8/10.
//  Copyright © 2017年 com.vmei. All rights reserved.
//

#import "RGHomePageActivityCVC.h"
#import "RGActivityMainDescribleCell.h"
#import "RGActivityCouponCell.h"
#import "RGActivityAllTitlesReusableView.h"
#import "RGActivitySubTitleReusableView.h"
#import "RGActivityAllTitleMaskView.h"
#import "Config.pch"
#define kAllTitleH 44
#define kSubTitleH 40
#define kActivityCellMagin 10
#define kActivityCellEdgeTop 18
#define kActivityCellEdgeLeft 15

#define kActivityCellW ((kScreenSize.width-kActivityCellEdgeLeft-kActivityCellMagin-kActivityCellEdgeLeft)/2)
#define kActivityCellH  kActivityCellW*420/335
typedef NS_ENUM(NSInteger,RGCVCellType) {
    RGCVCellType_banner,            //活动页主图
    RGCVCellType_mainDescrible,     //活动页描述
    RGCVCellType_coupon,            //活动页优惠
    RGCVCellType_allTitle,          //活动页 总标题 （总是不显示 高度为0，而是显示在footer上）
    RGCVCellType_product,           //活动页 商品
    RGCVCellType_activity           //活动页 链接活动
};

static NSString * const cellIdentifier_banner           = @"cellIdentifier_banner";
static NSString * const cellIdentifier_mainDescrible    = @"cellIdentifier_mainDescrible";
static NSString * const cellIdentifier_coupon           = @"cellIdentifier_coupon";
static NSString * const cellIdentifier_product          = @"cellIdentifier_product";
static NSString * const cellIdentifier_activity         = @"cellIdentifier_activity";
static NSString * const headerIdentifier_allTitleHeader      = @"headerIdentifier_allTitleHeader";
static NSString * const headerIdentifier_subTitleHeader      = @"headerIdentifier_subTitleHeader";

@interface RGHomePageActivityCVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,RGActivityCouponCellDelegate,RGActivityAllTitlesReusableViewDelegate,RGActivityAllTitleMaskViewDelegate>

@property (nonatomic,strong)NSMutableArray *subTitlesArray;
@property (nonatomic,strong)RGActivityAllTitleMaskView * maskView;


@end




@implementation RGHomePageActivityCVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"productDetail_back1"] style:UIBarButtonItemStylePlain target:self action:@selector(turnBack)];
    leftItem.tintColor = [UIColor whiteColor];
    leftItem.imageInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    self.navigationItem.leftBarButtonItem = leftItem;

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"rg_productDetail_share1"] style:UIBarButtonItemStylePlain target:self action:@selector(shareActivity)];
    rightItem.tintColor = [UIColor whiteColor];
    rightItem.imageInsets = UIEdgeInsetsMake(0, -7, 0, 7);
    self.navigationItem.rightBarButtonItem = rightItem;

//    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//    [backButton setImage:[UIImage imageNamed:@"productDetail_back1"] forState:UIControlStateNormal];
//    [backButton addTarget:self action:@selector(turnBack) forControlEvents:UIControlEventTouchUpInside];
//    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:backButton]];
//
//    UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//    [shareButton setImage:[UIImage imageNamed:@"productDetail_back1"] forState:UIControlStateNormal];
//    [shareButton addTarget:self action:@selector(shareActivity) forControlEvents:UIControlEventTouchUpInside];
//    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:shareButton]];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier_banner];
    [self.collectionView registerClass:[RGActivityMainDescribleCell class] forCellWithReuseIdentifier:cellIdentifier_mainDescrible];
    [self.collectionView registerClass:[RGActivityCouponCell class] forCellWithReuseIdentifier:cellIdentifier_coupon];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier_product];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier_activity];
    [self.collectionView registerClass:[RGActivityAllTitlesReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier_allTitleHeader];
    [self.collectionView registerClass:[RGActivitySubTitleReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier_subTitleHeader];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)turnBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)shareActivity{
    //友盟自定义事件
    
}




#pragma mark - UICollectionView DataSource

-(RGCVCellType)transformTypeBySection:(NSInteger )section{
    if (section == 0) {
        return RGCVCellType_banner;
    }else if (section == 1){
        return RGCVCellType_mainDescrible;
    }else if (section == 2){
        return RGCVCellType_coupon;
    }else if (section == 3){
        return RGCVCellType_allTitle;
    }else if (section == 4+self.subTitlesArray.count-1){
        return RGCVCellType_activity;
    }else{
        return RGCVCellType_product;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
        return 4+self.subTitlesArray.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    RGCVCellType cellType = [self transformTypeBySection:section];
    if (cellType == RGCVCellType_banner || cellType == RGCVCellType_mainDescrible || cellType == RGCVCellType_coupon ) {
        return 1;
    }else if (cellType == RGCVCellType_allTitle){
        return 0;
    }else if (cellType == RGCVCellType_product){
        return 3;
    }else if (cellType == RGCVCellType_activity){
        return 5;
    }else {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RGCVCellType cellType = [self transformTypeBySection:indexPath.section];
    switch (cellType) {
        case RGCVCellType_banner:
        {
            UICollectionViewCell *bannerCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier_banner forIndexPath:indexPath];
            if (!bannerCell.backgroundView) {
                UIImageView * bannerIV= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rg_activityCouponBg"]];
                bannerCell.backgroundView = bannerIV;
            }
            return bannerCell;
        }
            break;
        case RGCVCellType_mainDescrible:
        {
            RGActivityMainDescribleCell *mainDescribleCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier_mainDescrible forIndexPath:indexPath];
            return mainDescribleCell;
        }
            break;

        case RGCVCellType_coupon:
        {
            RGActivityCouponCell *couponCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier_coupon forIndexPath:indexPath];
            couponCell.activityCouponCellDelegate = self;
            return couponCell;
        }
            break;

        case RGCVCellType_allTitle:
        {
            return nil;
        }
            break;

        case RGCVCellType_product:
        {
            UICollectionViewCell *productCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier_product forIndexPath:indexPath];
            productCell.backgroundColor = [self randomColor];
            return productCell;
        }
            break;
        case RGCVCellType_activity:
        {
            UICollectionViewCell *activityCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier_activity forIndexPath:indexPath];
            if (!activityCell.backgroundView) {
                UIImageView * activityIV= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rg_activityCouponBg"]];
                activityCell.backgroundView = activityIV;
            }
            return activityCell;
        }
            break;
        default:
        
            break;
    }
    return nil;

}

-(UIColor *)randomColor{
    CGFloat hue = (arc4random() %256/256.0);
    
    CGFloat saturation = (arc4random() %128/256.0) +0.5;
    
    CGFloat brightness = (arc4random() %128/256.0) +0.5;
    
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    return color;
}



-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        RGCVCellType cellType = [self transformTypeBySection:indexPath.section];
        
        if (cellType == RGCVCellType_allTitle) {
            
            RGActivityAllTitlesReusableView * allTitleHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier_allTitleHeader forIndexPath:indexPath];
            allTitleHeader.activityAllTitlesReusableViewDelegate = self;
            allTitleHeader.subTitlesArray = self.subTitlesArray;
            [allTitleHeader.allTitlesContentView reloadData];
            return allTitleHeader;
            
        }else if (cellType == RGCVCellType_product || cellType == RGCVCellType_activity){
            
            RGActivitySubTitleReusableView * titleHeaderView = (RGActivitySubTitleReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier_subTitleHeader forIndexPath:indexPath];
            titleHeaderView.subtitleLB.text = self.subTitlesArray[indexPath.section-4];

            return titleHeaderView;
        
        }
    }
    return nil;
}



#pragma mark - UICollectionView FlowLayout Delegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    RGCVCellType cellType = [self transformTypeBySection:section];
    
    if (cellType == RGCVCellType_allTitle) {
        
        return CGSizeMake(kScreenSize.width, kAllTitleH);
        
    }else if (cellType == RGCVCellType_product || cellType == RGCVCellType_activity){
        
        return CGSizeMake(kScreenSize.width, kSubTitleH);
        
    }else{
        return CGSizeZero;
    }

}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    RGCVCellType cellType = [self transformTypeBySection:indexPath.section];
    switch (cellType) {
        case RGCVCellType_banner:
            return CGSizeMake(kScreenSize.width, 187.5);
            break;
        case RGCVCellType_mainDescrible:
        {
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
            style.lineSpacing = 2;
            NSString *demo =@"第一行\n第二行\n第3行\n第4行\n第5ashdfsjflaskfkiashfdfiuashdfasnhfjkdhafkhakjhfajhdfdjafkal第5ashdfsjflaskfkiashfdfiuashdfasnhfjkdhafkhakjhfajhdfdjafkal\n第6行\n第7\n第8行\n第9行\n第10行\n第11行\n第12行\n";
            CGRect  descSize = [demo boundingRectWithSize:CGSizeMake(kScreenSize.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
            return CGSizeMake(kScreenSize.width, 67+descSize.size.height);
        }
            break;
        case RGCVCellType_coupon:
            return CGSizeMake(kScreenSize.width, 140);
            break;
        case RGCVCellType_allTitle:
            return CGSizeMake(kScreenSize.width, 0.0f);//不能设置为CGSizeZero ！
            break;
        case RGCVCellType_product:
        {
            CGFloat width = kScreenSize.width/2;
            return CGSizeMake(width, 224*width/160+2 );
        }
            break;
        case RGCVCellType_activity:
            return CGSizeMake(kActivityCellW, kActivityCellH);
            break;
        default:
            return CGSizeZero;
            break;
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    RGCVCellType cellType = [self transformTypeBySection:section];
    switch (cellType) {
        case RGCVCellType_activity:
            return UIEdgeInsetsMake(kActivityCellEdgeTop, kActivityCellEdgeLeft, kActivityCellEdgeTop, kActivityCellEdgeLeft);
            break;
        default:
            return UIEdgeInsetsMake(0, 0, 0, 0);
            break;
    }
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    RGCVCellType cellType = [self transformTypeBySection:section];
    if (cellType == RGCVCellType_activity) {
        return kActivityCellMagin;
    }else{
        return 0;
    }
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    RGCVCellType cellType = [self transformTypeBySection:section];
    if (cellType == RGCVCellType_activity) {
        return kActivityCellMagin;
    }else{
        return 0;
    }
}

#pragma mark - scrollView delegate

/**
 *  向瀑布流下滚动停止后 子标题也要滑动到对应的位置
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.collectionView) {
        NSArray * visibleCellsIndexpath = [self.collectionView indexPathsForVisibleItems];
        NSIndexPath *lastIndex = [NSIndexPath indexPathForItem:0 inSection:0];
        for (NSIndexPath *index in visibleCellsIndexpath) {
            if (index.section > lastIndex.section) {
                lastIndex = index;
            }
        }
        
        RGActivityAllTitlesReusableView * allTitleHeader = (RGActivityAllTitlesReusableView *)[self.collectionView supplementaryViewForElementKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:3]];
        if (lastIndex.section <= 4) {
            allTitleHeader.selectedIndex = 0;
        }else{
            allTitleHeader.selectedIndex = lastIndex.section-4;
        }
    }
}

#pragma mark - UICollectionView Delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"没妆团  ----%ld --  %ld---",indexPath.section,indexPath.item);
}


#pragma mark - RGActivityCouponCellDelegate
/**
 *  点击领取优惠券
 */
-(void)rg_activityCouponcell_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"领取 优惠券 ---%ld --- %ld--",indexPath.section,indexPath.item);
}

#pragma mark - RGActivityAllTitlesReusableViewDelegate
/**
 *  选中并滚动至相应的 子标题
 */
-(void)rg_activityAllTitlesReusableView_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"第 ---%ld --个标题 被点击",indexPath.item);
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    

    UICollectionViewLayoutAttributes *scrolledAttri = [self.collectionView layoutAttributesForSupplementaryElementOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.item+4]];
    [self.collectionView setContentOffset:CGPointMake(0.0f, scrolledAttri.frame.origin.y-kAllTitleH) animated:YES];
}

/**
 *  右向下按钮 显示全部子标题
 */
-(void)rg_activityAllTitlesReusableView_showAllTitleBtnClickedWithSelectedIndex:(NSInteger)selectedIndex
{
    NSLog(@"显示全部标题");

    UICollectionViewLayoutAttributes *scrolledAttri = [self.collectionView layoutAttributesForSupplementaryElementOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:3]];
    [self.collectionView setContentOffset:CGPointMake(0.0f, scrolledAttri.frame.origin.y) animated:YES];
    
    self.maskView.allSubTitlesArray = self.subTitlesArray;
    self.maskView.selectedIndex = selectedIndex;
    [self.view addSubview:self.maskView];
}


#pragma mark - RGActivityAllTitleMaskViewDelegate
/**
 *  点击蒙版 退出 子标题 列表
 */
-(void)rg_allTitleMaskViewBackgroundClicked:(RGActivityAllTitleMaskView *)mask{
    [_maskView removeFromSuperview];
    _maskView = nil;
}
/**
 *  选中蒙版中 某个子标题 使 蒙版退出，并且列表滚动到该子标题
 */
-(void)rg_maskView:(RGActivityAllTitleMaskView *)mask subTitleCellClicked:(RGActivitySubTitleCell *)cell indexpath:(NSIndexPath *)indexpath{

    RGActivityAllTitlesReusableView * allTitleHeader = (RGActivityAllTitlesReusableView *)[self.collectionView supplementaryViewForElementKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:3]];
    allTitleHeader.selectedIndex = indexpath.item;

    
    
    UICollectionViewLayoutAttributes *scrolledAttri = [self.collectionView layoutAttributesForSupplementaryElementOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexpath.item+4]];
    [self.collectionView setContentOffset:CGPointMake(0.0f, scrolledAttri.frame.origin.y-kAllTitleH) animated:YES];
    
    [_maskView removeFromSuperview];
    _maskView = nil;
}


#pragma mark - setter && getter
-(NSArray *)subTitlesArray{
    if (!_subTitlesArray) {
        _subTitlesArray = [NSMutableArray arrayWithArray:@[@"精品推荐1",@"精品推荐2",@"精品推荐3",@"精品推荐4",@"精品推荐5",@"精品推荐6",@"其他活动"]];
    }
    return _subTitlesArray;
}

-(RGActivityAllTitleMaskView *)maskView{
    if (!_maskView) {
        _maskView = [[RGActivityAllTitleMaskView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height-20-44)];
        _maskView.delegate = self;
    }
    return _maskView;
}



@end
