//
//  PrincipalViewController.h
//  Gravador
//
//  Created by Rafael Brigagão Paulino on 20/09/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PrincipalViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *speaker;

@property (nonatomic, weak) IBOutlet UIButton *gravar;
@property (nonatomic, weak) IBOutlet UIButton *tocar;


-(IBAction)botaoGravarClicado:(id)sender;
-(IBAction)botaoTocarClicado:(id)sender;


//aqui nos declaramos apenas quando eu quero que outras classes acessem esta classe
-(void)animarSpeaker:(float)potencia;
-(void)atualizarInterface;

@end
