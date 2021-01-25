#include <mega48.h>
 #include <lcd16x1.h> 
 #include<delay.h>
 #include<stdlib.h>
 #include<string.h>
#define RXB8 1
#define TXB8 0
#define UPE 2
#define OVR 3
#define FE 4
#define UDRE 5
#define RXC 7
void gps(void);  
void send_cmd(void);
void latch_cmd(void);
void gprs(void);

#define FRAMING_ERROR (1<<FE)
#define PARITY_ERROR (1<<UPE)
#define DATA_OVERRUN (1<<OVR)
#define DATA_REGISTER_EMPTY (1<<UDRE)
#define RX_COMPLETE (1<<RXC) 
unsigned int timer_count;
unsigned char i;   
unsigned char j;      
unsigned char k;


// USART Receiver buffer
#define RX_BUFFER_SIZE0 8
char rx_buffer0[RX_BUFFER_SIZE0];

#if RX_BUFFER_SIZE0<256
unsigned char rx_wr_index0,rx_rd_index0,rx_counter0;
#else
unsigned int rx_wr_index0,rx_rd_index0,rx_counter0;
#endif

// This flag is set on USART Receiver buffer overflow
bit rx_buffer_overflow0;

// USART Receiver interrupt service routine
interrupt [USART_RXC] void usart_rx_isr(void)
{
char status,data;
status=UCSR0A;
data=UDR0;
if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
   {
   rx_buffer0[rx_wr_index0]=data;
   if (++rx_wr_index0 == RX_BUFFER_SIZE0) rx_wr_index0=0;
   if (++rx_counter0 == RX_BUFFER_SIZE0)
      {
      rx_counter0=0;
      rx_buffer_overflow0=1;
      };
   };
}

#ifndef _DEBUG_TERMINAL_IO_
// Get a character from the USART Receiver buffer
#define _ALTERNATE_GETCHAR_
#pragma used+
char getchar(void)
{
char data;
while (rx_counter0==0);
data=rx_buffer0[rx_rd_index0];
if (++rx_rd_index0 == RX_BUFFER_SIZE0) rx_rd_index0=0;
#asm("cli")
--rx_counter0;
#asm("sei")
return data;
}
#pragma used-
#endif

// USART Transmitter buffer
#define TX_BUFFER_SIZE0 8
char tx_buffer0[TX_BUFFER_SIZE0];

#if TX_BUFFER_SIZE0<256
unsigned char tx_wr_index0,tx_rd_index0,tx_counter0;
#else
unsigned int tx_wr_index0,tx_rd_index0,tx_counter0;
#endif

// USART Transmitter interrupt service routine
interrupt [USART_TXC] void usart_tx_isr(void)
{
if (tx_counter0)
   {
   --tx_counter0;
   UDR0=tx_buffer0[tx_rd_index0];
   if (++tx_rd_index0 == TX_BUFFER_SIZE0) tx_rd_index0=0;
   };
}

#ifndef _DEBUG_TERMINAL_IO_
// Write a character to the USART Transmitter buffer
#define _ALTERNATE_PUTCHAR_
#pragma used+
void putchar(char c)
{
while (tx_counter0 == TX_BUFFER_SIZE0);
#asm("cli")
if (tx_counter0 || ((UCSR0A & DATA_REGISTER_EMPTY)==0))
   {
   tx_buffer0[tx_wr_index0]=c;
   if (++tx_wr_index0 == TX_BUFFER_SIZE0) tx_wr_index0=0;
   ++tx_counter0;
   }
else
   UDR0=c;
#asm("sei")
}
#pragma used-
#endif
  //--------------------------------------------------------------------------------------------------------
//   unsigned char ME[]="$Hello my world";
 #include <stdio.h>
// unsigned int count=0;
// // Timer 1 overflow interrupt service routine
// interrupt [TIM1_OVF] void timer1_ovf_isr(void)
// {
// // Reinitialize Timer 1 value
// 
// TCNT1H=0xFC;
// TCNT1L=0xEC;  
// 
// count++;
// if(count==5)
// {
//  count=0;
// // Place your code here  
// j++;
// clear_lcd();
// lcd_cmd(0x80);
// lcd_puts(ME+j);
// //delay_ms(1000);
//   
// if(j==16)
// {
// j=0;
// }
// }
// } 
//------------------------------------------------------------------------------------------------------
#define ADC_VREF_TYPE 0x00

// Read the AD conversion result
unsigned int read_adc(unsigned char adc_input)
{
ADMUX=adc_input|ADC_VREF_TYPE;
// Start the AD conversion
ADCSRA|=0x40;
// Wait for the AD conversion to complete
while ((ADCSRA & 0x10)==0);
ADCSRA|=0x10;
return ADCW;
}

 unsigned char data=0;      
 unsigned char stop=0;  
 unsigned char cmd1[]="GPGLL,";
 unsigned char cmd2[]=",N,0";     
 unsigned char cmd3[]="A00190D446A";    
 unsigned char cmd4[]="A0019ADCC42"; 
 unsigned char cmd5[]="A0018BFB12C";
 unsigned char cmd6[]="A00190A7059";  
 unsigned char LAT[9],LOG[9];    
 unsigned char msg4[]="ip",ip[16],ipi[]=" Reading IP wait";
       
 
 unsigned char cmd7[]="Rahul";
 unsigned char cmd8[]="Siddarth";
 unsigned char cmd9[]="Nikhil";
 unsigned char cmd10[]="Suresh";
 unsigned char cmd11[]="Ramesh";
 unsigned char cmd12[]="Swipe Ur Card";    
  unsigned char cmd13[]="Invalid";
unsigned char ME1[16];
 unsigned char cmp[12];     
 unsigned char buff[25]; 
 void main(void) 
      
{
// Declare your local variables here
//unsigned char AR[]="hello welcome to mesoln";
//unsigned char n3[]="Lcd Testing";
// Crystal Oscillator division factor: 1
#pragma optsize-
CLKPR=0x80;
CLKPR=0x00;
#ifdef _OPTIMIZE_SIZE_
#pragma optsize+
#endif

// Input/Output Ports initialization
// Port B initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTB=0x00;
DDRB=0x07;

// Port C initialization
// Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTC=0x00;
DDRC=0x33;

// Port D initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
// PORTD=0x00;
// DDRD=0xf0;
PORTD=0x04;
DDRD=0xF4;



// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: Timer 2 Stopped
// Mode: Normal top=FFh
// OC2A output: Disconnected
// OC2B output: Disconnected
ASSR=0x00;
TCCR2A=0x00;
TCCR2B=0x00;
TCNT2=0x00;
OCR2A=0x00;
OCR2B=0x00;

// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// Interrupt on any change on pins PCINT0-7: Off
// Interrupt on any change on pins PCINT8-14: Off
// Interrupt on any change on pins PCINT16-23: Off
EICRA=0x00;
EIMSK=0x00;
PCICR=0x00;



// USART initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART Receiver: On
// USART Transmitter: On
// USART0 Mode: Asynchronous
// USART Baud rate: 9600
UCSR0A=0x00;
UCSR0B=0xD8;
UCSR0C=0x06;
UBRR0H=0x00;
UBRR0L=0x33;

// // Timer/Counter 1 initialization
// // Clock source: System Clock
// // Clock value: 7.813 kHz
// // Mode: Normal top=FFFFh
// // OC1A output: Discon.
// // OC1B output: Discon.
// // Noise Canceler: Off
// // Input Capture on Falling Edge
// // Timer 1 Overflow Interrupt: On
// // Input Capture Interrupt: Off
// // Compare A Match Interrupt: Off
// // Compare B Match Interrupt: Off
// TCCR1A=0x00;
// TCCR1B=0x05;
// TCNT1H=0xFC;
// TCNT1L=0xEC;
// ICR1H=0x00;
// ICR1L=0x00;
// OCR1AH=0x00;
// OCR1AL=0x00;
// OCR1BH=0x00;
// OCR1BL=0x00;




// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off        
   
//------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------

ACSR=0x80;
ADCSRB=0x00;
//delay_ms(5000);     
#asm("sei")
//delay_ms(5000);
  
  PORTC.5=1;  
  PORTC.4=1;  
  
// printf("at \r"); 
// printf("at+cmgf=1\r");
// delay_ms(1000);
clear_lcd();
lcd_init();
lcd_cmd(0x80);
lcd_puts(cmd12);
delay_ms(5000);
clear_lcd();       

while(1)
{
lcd_cmd(0x80);
lcd_puts(cmd12);   

  PORTC.5=1;  
  PORTC.4=1;
  
 if(rx_counter0>0)
 {
  while(getchar()!='3');
   
 for(i=0;i<11;i++)
  {   
 cmp[i]=getchar();
 putchar(cmp[i]);
 }
 cmp[11]='\0'; 
   //puts(cmp);   

   
//-----------------------------   
  if(strcmp(cmp, cmd3)==0)
 { 
// puts(cmp); 
// printf("at \r"); 
// printf("at+cmgf=1\r");
// delay_ms(1000);
// printf("at+cfun=1\r");
// delay_ms(1000);
// printf("at+cmgs=");
// putchar('"'); 
// printf("9242838716");
// putchar('"');
// delay_ms(300);
// printf("\r");    

clear_lcd();
lcd_init();
lcd_cmd(0x80);
lcd_puts(cmd7);
delay_ms(1000);  

gps();   



} 

// putchar(0x1a); 
// delay_ms(300);
    

//------------------------------
else
  if(strcmp(cmp, cmd4)==0)
 {
//  printf("at \r"); 
// printf("at+cmgf=1\r");
// delay_ms(1000);
// printf("at+cfun=1\r");
// delay_ms(1000);
// printf("at+cmgs=");
// putchar('"'); 
// printf("9242838716");
// putchar('"');
// delay_ms(300);
// printf("\r");   


clear_lcd();
lcd_init();
lcd_cmd(0x80);
lcd_puts(cmd8);
delay_ms(1000);    

gps();  



}       


// putchar(0x1a); 
// delay_ms(300);
 
 
 //--------------------------------------- 
 else
  if(strcmp(cmp, cmd5)==0)
 {
// printf("at \r"); 
// printf("at+cmgf=1\r");
// delay_ms(1000);
// printf("at+cfun=1\r");
// delay_ms(1000);
// printf("at+cmgs=");
// putchar('"'); 
// printf("9242838716");
// putchar('"');
// delay_ms(300);
// printf("\r");     

clear_lcd();
lcd_init();
lcd_cmd(0x80);
lcd_puts(cmd9);
delay_ms(1000); 

gps();     



}  



// putchar(0x1a); 
// delay_ms(300);
    
 //--------------------------------------     
 else
 if(strcmp(cmp, cmd6)==0)
 {
// printf("at \r"); 
// printf("at+cmgf=1\r");
// delay_ms(1000);
// printf("at+cfun=1\r");
// delay_ms(1000);
// printf("at+cmgs=");
// putchar('"'); 
// printf("9242838716");
// putchar('"');
// delay_ms(300);
// printf("\r"); 

clear_lcd();
lcd_init();
lcd_cmd(0x80);
lcd_puts(cmd10);
delay_ms(1000);    

gps();     



}  
 
// putchar(0x1a); 
// delay_ms(300);
  
//-------------- 
 else
 {

clear_lcd();
lcd_init();
lcd_cmd(0x80);
lcd_puts(cmd13);
delay_ms(1000);
 } 
 }
 };

}    

void gps(void)
{
delay_ms(300);

PORTC.5=0; 
PORTC.4=1;  

delay_ms(300);  

while(stop!=1)
{
if(rx_counter0>0)      
 {
 while(getchar()!='$');
 {
for(i=0;i<6;i++)
{   
 cmp[i]=getchar();
 }
 cmp[6]='\0'; 
}
  if (strcmp(cmp, cmd1)==0)   
  { 
  stop=0;   
  for(j=0;j<24;j++)
  {
  buff[j]=getchar();
  }  
  buff[24]='\0';     

delay_ms(300); 
printf("at \r"); 
printf("at+cmgf=1\r");
delay_ms(1000);
printf("at+cfun=1\r");
delay_ms(1000);
printf("at+cmgs=");
putchar('"'); 
printf("9242838716");
putchar('"');
delay_ms(800);
printf("\r"); 
delay_ms(300); 
printf("@LT");
clear_lcd();
//lcd_init();
lcd_cmd(0x80);
for(j=0;j<9;j++)
{  
  LOG[j]=buff[j];
  lcd_data(buff[j],0);
  putchar(buff[j]);
//delay_ms(1000);
} 
//LAT[9]='/0';

//lcd_puts(LAT);
printf("LG");  

lcd_cmd(0xC0);

for(j=14;j<23;j++)
{   
//lcd_init();
  putchar(buff[j]);
  lcd_data(buff[j],0);
LOG[14-j]=buff[j];
} 



//LOG[9]='/0';
//lcd_cmd(0xC0);
//lcd_puts(LOG);
delay_ms(1000);
putchar(0x1a); 
//delay_ms(8000); 

//delay_ms(1000);     
delay_ms(20000); 
  gprs(); 
  delay_ms(5000); 
  send_cmd();
  printf("@LT");
clear_lcd();
//lcd_init();
//lcd_cmd(0x80);
for(j=0;j<9;j++)
{  
  //LOG[j]=buff[j];
  //lcd_data(buff[j],0);
  putchar(buff[j]);
//delay_ms(1000);
} 
//LAT[9]='/0';

//lcd_puts(LAT);
printf("LG");  

//lcd_cmd(0xC0);

for(j=14;j<23;j++)
{   
//lcd_init();
  putchar(buff[j]);
  //lcd_data(buff[j],0);
//LOG[14-j]=buff[j];
}
latch_cmd();
delay_ms(5000);
clear_lcd();

}
}    
}
}   


void send_cmd(void)
{  
 printf("AT\r");
  delay_ms(100);
  printf("AT+CMGF=1\r");
  delay_ms(100);
 printf("AT+CIPSEND");
 //delay_ms(1000); 
 printf("\r"); 
 delay_ms(1000); 
}  
 
void latch_cmd(void)
{
 delay_ms(1000);
 putchar(0x1A);  
 delay_ms(3000);
//  printf("AT\r");
//   delay_ms(1000);
//   printf("AT+CMGF=1\r");
//   delay_ms(1000); 
}
             

void gprs(void) 
{  
delay_ms(300);       
PORTC.5=0; 
PORTC.4=0;   
delay_ms(300);      

 clear_lcd();
 lcd_cmd(0x80);
 lcd_puts(ipi);
 delay_ms(300);
 printf("AT"); 
 delay_ms(1000);
 printf("\r");   
 printf("AT+CMGF=1"); 
 delay_ms(1000);
 printf("\r");
 delay_ms(1000);
 printf("AT+CIPSERVER=1,1234"); 
 delay_ms(1000);
 printf("\n\r");
 while(getchar()!='K'); 
 while(getchar()!='K'); 
 delay_ms(300); 
 printf("at+cifsr");  
 delay_ms(1000);
 printf("\r");
 while(getchar()!=0x0A); 
 clear_lcd();  
 lcd_cmd(0x80);
 for(i=0;i<16;i++)
 {
  ip[i]=getchar();     
  lcd_data(ip[i],1);
//   if(ip[i]==0x0D) 
//  { 
//   rlt();
//   for(i=0;i<16;i++)
//  {
//   putchar(ip[i]);
//  }
//  printf("\r");
//   rlt1(); 
//   delay_ms(1000);
//   break;
//  } 
 }  
}
 #include <mega48.h> 
  #include <delay.h>         
//#include <prototype.h> 
#include <lcd16x1.h> 
#include <stdlib.h>
#include <stdio.h>  
//#include<prototype.h>     
//#define INT0_PIN PIND.2         //int0 pin PD.2
//#define INT1_PIN PIND.3         //int1 pin PD.3

#define RS PORTB.0
#define RW PORTB.1    //lcd defines
#define EN PORTB.2  
                        
         

//function to clear the lcd & start from first row first column onwards       
void clear_lcd(void)
{
       lcd_cmd(0x01);
       //lcd_cmd(0x80);   //clear screen n start from fist line first column
       lcd_cmd(0x06);     //incremental cursor
}

//lcd initialization function for 4 datalines    
 void lcd_init(void)
 {
        delay_ms(15);               //startup delay
                  lcd_cmd(0x03);
        delay_ms(5);     
                  lcd_cmd(0x03);
        delay_us(160);     
                  lcd_cmd(0x03);
        delay_us(160);            
                  lcd_cmd(0x02);
       delay_us(160);  
                  lcd_cmd(0x28);         //4 bit data , 5*7, 2 line..   //the abouve cmds are necessary
       delay_ms(100);                    
                  lcd_cmd(0x60);         // set CGRAM addr
       delay_ms(100);           
         lcd_cmd(0x0C); 
       delay_ms(1);                          
                  lcd_cmd(0x06);       //increment cursor no shift
       delay_ms(1);           
                  lcd_cmd(0x90);       // 1st column 1st char
        delay_ms(1);                                        
                  lcd_cmd(0x01);       //clear lcd
        delay_ms(2);                              
  }
  //to send lcd commands
void lcd_cmd(unsigned char inst)
{

       unsigned char lsb=0,msb=0;
        lsb=inst&0x0F;        //split msb n lsb nibbles
        msb=inst>>4; 
        msb&=0x0F;   
        lsb=lsb&0X0F;
        msb=msb<<4;
        lsb=lsb<<4;
        delay_us(500);            //busy check duration       500
        RS=0;
        RW=0;    
        EN=1;     
        PORTD&=0x0F; 
        PORTD|=msb; 
        delay_us(5);         //6 nops       changed from 10u to 5u
        EN=0;
        delay_us(5);         //6 nops
        EN=1;
        PORTD&=0x0F;        //sending lsb now       
        PORTD|=lsb; 
        delay_us(5);         //6 nops
        EN=0;
     }   
               
//function to send data to lcd
 void lcd_data(unsigned char data1,unsigned char type)
 {      
      unsigned char lsbc,msbc,temp,a; 
      type=a;
      temp=0;lsbc=0;msbc=0;
      msbc=data1&0xF0;      //msb n lsb split
      lsbc=data1<<4;
      delay_us(600);            //busy check duration       prev 600
      RS=1;
      RW=0;     
      EN=1;
      PORTD&=0x0F; 
      PORTD|=msbc;         // this being moved to the lsbbits of port instead of msb...
      delay_us(5);        
      EN=0 ;                   
      delay_us(5);        
      EN=1;
      PORTD&=0x0F;
      PORTD|=lsbc;        
      delay_us(5);        
      EN=0;     
} 
            
 
//function to put string onto lcd     
void lcd_puts(unsigned char *str)
{
  while(*str !='\0') 
         {
           lcd_data(*str,1);
             *str++;
          }
}




//function to convert int to ascii for dispaly on lcd / serial port          
//  //calculate the ascii values to be displayed on lcd  3 digit int to 3 digit ascii
// void cal_ascii(unsigned int value)   
// { 
//        unsigned char lb,mb,mmlb;
//        mmlb=(((unsigned char)(value/100))|0x30);
//        mb=(unsigned char)(value/10);  
//        mb=(((unsigned char)(mb%10))|0x30);
//        lb=(((unsigned char)(value%10))|0x30);
//       
//       if(value>99){ lcd_data(mmlb,1);lcd_data(mb,1);lcd_data(lb,1); }
//       else if (value >9){lcd_data(mb,1);lcd_data(lb,1); }
//       else 
//       {   
//       lcd_data(0x30,1);
//       lcd_data(lb,1); 
//       }
// }                       


