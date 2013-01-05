//
//  PrincipalViewController.m
//  Gravador
//
//  Created by Rafael Brigagão Paulino on 20/09/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import "PrincipalViewController.h"

@interface PrincipalViewController ()
{
    NSString *pathArquivo;
    
    NSURL *url;
    
    AVAudioPlayer *player;
    
    AVAudioRecorder *gravador;
    
    float potenciaLida;
    
    NSTimer *meuTimer;
}

@end

@implementation PrincipalViewController

-(IBAction)botaoGravarClicado:(id)sender
{
    if (gravador == nil)
    {
        //inicio gravacao
        gravador = [[AVAudioRecorder alloc] initWithURL:url settings:nil error:nil];
        
        //permitir acessar as medicoes do arquivo de audio
        gravador.meteringEnabled = YES;
        
        [gravador prepareToRecord];
        [gravador record];
        
        [_gravar setTitle:@"Parar" forState:UIControlStateNormal];
        _tocar.enabled = NO;
    }
    else
    {
        //finaliza a gravacao
        [gravador stop];
        gravador = nil;
        
        [_gravar setTitle:@"Gravar" forState:UIControlStateNormal];
        _tocar.enabled = YES;
    }
}

-(IBAction)botaoTocarClicado:(id)sender
{
    if (player == nil)
    {
        //iniciar reproducao
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        //permitir acessar as medicoes do arquivo de audio
        player.meteringEnabled = YES;
        
        [player prepareToPlay];
        [player play];
        
        [_tocar setTitle:@"Parar" forState:UIControlStateNormal];
        _gravar.enabled = NO;
    }
    else
    {
        //parar reproducao
        [player stop];
        player = nil;
        
        [_tocar setTitle:@"Tocar" forState:UIControlStateNormal];
        _gravar.enabled = YES;
    }
}

-(void)animarSpeaker:(float)potencia
{
    NSLog(@"potencia %f",potencia);
    
   [UIView animateWithDuration:0.01 animations:^{
       //alterando o tamamnho do frame da imagem e arantindo que a img ficara centralizada
       _speaker.frame = CGRectMake(_speaker.frame.origin.x, _speaker.frame.origin.y, 200+potencia, 200+potencia);
       _speaker.center = CGPointMake(160, 230);
   }];
}

-(void)atualizarInterface
{
    if (player.isPlaying)
    {
        //atualizar as medicoes
        [player updateMeters];
        
        //pega a pontencia de gravacao do canal 0 (nosso unico canal de gravacao)
        potenciaLida = [player averagePowerForChannel:0] *1.5;
        
        
        [self animarSpeaker:potenciaLida];
        
    }
    else if (gravador.recording)
    {
        [gravador updateMeters];
        
        potenciaLida = [gravador averagePowerForChannel:0] *1.5;
        
        [self animarSpeaker:potenciaLida];
    }
    else
    {
        //para quando nenhum dos 2 esta fazendo algo
        _speaker.frame = CGRectMake(60,130,200,200);
        
        [_tocar setTitle:@"Tocar" forState:UIControlStateNormal];
        _gravar.enabled = YES;
        
        [_gravar setTitle:@"Gravar" forState:UIControlStateNormal];
        _tocar.enabled = YES;
        
        player = nil;
        
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //o local onde o arquivo de audio sera salvo
    pathArquivo = [NSHomeDirectory() stringByAppendingString:@"/Documents/gravacao.wav"];
    
    NSLog(@"Endereço: %@", pathArquivo);
    
    url = [NSURL fileURLWithPath:pathArquivo];
    
    //fazendo a animacao da caixa de som
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(atualizarInterface) userInfo:nil repeats:YES];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
