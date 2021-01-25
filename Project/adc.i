// CodeVisionAVR C Compiler
// (C) 1998-2004 Pavel Haiduc, HP InfoTech S.R.L.
// I/O registers definitions for the ATmega48(V)
#pragma used+
sfrb PINB=3;
sfrb DDRB=4;
sfrb PORTB=5;
sfrb PINC=6;
sfrb DDRC=7;
sfrb PORTC=8;
sfrb PIND=9;
sfrb DDRD=0xa;
sfrb PORTD=0xb;
sfrb TIFR0=0x15;
sfrb TIFR1=0x16;
sfrb TIFR2=0x17;
sfrb PCIFR=0x1b;
sfrb EIFR=0x1c;
sfrb EIMSK=0x1d;
sfrb GPIOR0=0x1e;
sfrb EECR=0x1f;
sfrb EEDR=0x20;
sfrb EEARL=0x21;
sfrb EEARH=0x22;
sfrw EEAR=0x21;   // 16 bit access
sfrb GTCCR=0x23;
sfrb TCCR0A=0x24;
sfrb TCCR0B=0x25;
sfrb TCNT0=0x26;
sfrb OCR0A=0x27;
sfrb OCR0B=0x28;
sfrb GPIOR1=0x2a;
sfrb GPIOR2=0x2b;
sfrb SPCR=0x2c;
sfrb SPSR=0x2d;
sfrb SPDR=0x2e;
sfrb ACSR=0x30;
sfrb MONDR=0x31;
sfrb SMCR=0x33;
sfrb MCUSR=0x34;
sfrb MCUCR=0x35;
sfrb SPMCSR=0x37;
sfrb SPL=0x3d;
sfrb SPH=0x3e;
sfrb SREG=0x3f;
#pragma used-
// Interrupt vectors definitions
 void lcd_init(void);
void lcd_init(void);
   void lcd_puts(unsigned char *str);
   void lcdLoadCustomChar(void);
    void lcd_data(unsigned char data1,unsigned char type);
    void clear_lcd(void);
          void cmd(unsigned char inst);
 void data_lcd(unsigned char data1);
// void string_lcd(unsigned char *str);
// void lcd_goto(unsigned char  colm, unsigned char line);
 void lcd_goto(unsigned char line , unsigned char colm);
 void lcd_cmd(unsigned char inst);      
 void cal_ascii(unsigned int value);
//#include <lcd16x1.h> 

 // CodeVisionAVR C Compiler
// (C) 1998-2000 Pavel Haiduc, HP InfoTech S.R.L.
#pragma used+
void delay_us(unsigned int n);
void delay_ms(unsigned int n);
#pragma used-
 /* CodeVisionAVR C Compiler
   Prototypes for standard library functions

   (C) 1998-2003 Pavel Haiduc, HP InfoTech S.R.L.
*/
#pragma used+
int atoi(char *str);
long int atol(char *str);
float atof(char *str);
void itoa(int n,char *str);
void ltoa(long int n,char *str);
void ftoa(float n,unsigned char decimals,char *str);
void ftoe(float n,unsigned char decimals,char *str);
void srand(int seed);
int rand(void);
void *malloc(unsigned int size);
void *calloc(unsigned int num, unsigned int size);
void *realloc(void *ptr, unsigned int size); 
void free(void *ptr);
#pragma used-
#pragma library stdlib.lib
 // CodeVisionAVR C Compiler
// (C) 1998-2005 Pavel Haiduc, HP InfoTech S.R.L.
// Prototypes for string functions
#pragma used+
char *strcat(char *str1,char *str2);
char *strcatf(char *str1,char flash *str2);
char *strchr(char *str,char c);
signed char strcmp(char *str1,char *str2);
signed char strcmpf(char *str1,char flash *str2);
char *strcpy(char *dest,char *src);
char *strcpyf(char *dest,char flash *src);
unsigned char strcspn(char *str,char *set);
unsigned char strcspnf(char *str,char flash *set);
unsigned int strlenf(char flash *str);
char *strncat(char *str1,char *str2,unsigned char n);
char *strncatf(char *str1,char flash *str2,unsigned char n);
signed char strncmp(char *str1,char *str2,unsigned char n);
signed char strncmpf(char *str1,char flash *str2,unsigned char n);
char *strncpy(char *dest,char *src,unsigned char n);
char *strncpyf(char *dest,char flash *src,unsigned char n);
char *strpbrk(char *str,char *set);
char *strpbrkf(char *str,char flash *set);
signed char strpos(char *str,char c);
char *strrchr(char *str,char c);
char *strrpbrk(char *str,char *set);
char *strrpbrkf(char *str,char flash *set);
signed char strrpos(char *str,char c);
char *strstr(char *str1,char *str2);
char *strstrf(char *str1,char flash *str2);
unsigned char strspn(char *str,char *set);
unsigned char strspnf(char *str,char flash *set);
char *strtok(char *str1,char flash *str2);
 unsigned int strlen(char *str);
void *memccpy(void *dest,void *src,char c,unsigned n);
void *memchr(void *buf,unsigned char c,unsigned n);
signed char memcmp(void *buf1,void *buf2,unsigned n);
signed char memcmpf(void *buf1,void flash *buf2,unsigned n);
void *memcpy(void *dest,void *src,unsigned n);
void *memcpyf(void *dest,void flash *src,unsigned n);
void *memmove(void *dest,void *src,unsigned n);
void *memset(void *buf,unsigned char c,unsigned n);
#pragma used-
#pragma library string.lib
void gps(void);  
void send_cmd(void);
void latch_cmd(void);
void gprs(void);
unsigned int timer_count;
unsigned char i;   
unsigned char j;      
unsigned char k;
// USART Receiver buffer
char rx_buffer0[8];
unsigned char rx_wr_index0,rx_rd_index0,rx_counter0;
// This flag is set on USART Receiver buffer overflow
bit rx_buffer_overflow0;
// USART Receiver interrupt service routine
interrupt [19] void usart_rx_isr(void)
{
char status,data;
status=(*(unsigned char *) 0xc0);
data=(*(unsigned char *) 0xc6);
if ((status & ((1<<4) | (1<<2) | (1<<3)))==0)
   {
   rx_buffer0[rx_wr_index0]=data;
   if (++rx_wr_index0 == 8) rx_wr_index0=0;
   if (++rx_counter0 == 8)
      {
      rx_counter0=0;
      rx_buffer_overflow0=1;
      };
   };
}
// Get a character from the USART Receiver buffer
#pragma used+
char getchar(void)
{
char data;
while (rx_counter0==0);
data=rx_buffer0[rx_rd_index0];
if (++rx_rd_index0 == 8) rx_rd_index0=0;
#asm("cli")
--rx_counter0;
#asm("sei")
return data;
}
#pragma used-
// USART Transmitter buffer
char tx_buffer0[8];
unsigned char tx_wr_index0,tx_rd_index0,tx_counter0;
// USART Transmitter interrupt service routine
interrupt [21] void usart_tx_isr(void)
{
if (tx_counter0)
   {
   --tx_counter0;
   (*(unsigned char *) 0xc6)=tx_buffer0[tx_rd_index0];
   if (++tx_rd_index0 == 8) tx_rd_index0=0;
   };
}
// Write a character to the USART Transmitter buffer
#pragma used+
void putchar(char c)
{
while (tx_counter0 == 8);
#asm("cli")
if (tx_counter0 || (((*(unsigned char *) 0xc0) & (1<<5))==0))
   {
   tx_buffer0[tx_wr_index0]=c;
   if (++tx_wr_index0 == 8) tx_wr_index0=0;
   ++tx_counter0;
   }
else
   (*(unsigned char *) 0xc6)=c;
#asm("sei")
}
#pragma used-
  //--------------------------------------------------------------------------------------------------------
//   unsigned char ME[]="$Hello my world";
 // CodeVisionAVR C Compiler
// (C) 1998-2003 Pavel Haiduc, HP InfoTech S.R.L.
// Prototypes for standard I/O functions
// CodeVisionAVR C Compiler
// (C) 1998-2002 Pavel Haiduc, HP InfoTech S.R.L.
// Variable length argument list macros
typedef char *va_list;
#pragma used+
char getchar(void);
void putchar(char c);
void puts(char *str);
void putsf(char flash *str);
char *gets(char *str,unsigned int len);
void printf(char flash *fmtstr,...);
void sprintf(char *str, char flash *fmtstr,...);
void vprintf (char flash * fmtstr, va_list argptr);
void vsprintf (char *str, char flash * fmtstr, va_list argptr);
signed char scanf(char flash *fmtstr,...);
signed char sscanf(char *str, char flash *fmtstr,...);
                                               #pragma used-
#pragma library stdio.lib
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
// Read the AD conversion result
unsigned int read_adc(unsigned char adc_input)
{
(*(unsigned char *) 0x7c)=adc_input|0x00;
// Start the AD conversion
(*(unsigned char *) 0x7a)|=0x40;
// Wait for the AD conversion to complete
while (((*(unsigned char *) 0x7a) & 0x10)==0);
(*(unsigned char *) 0x7a)|=0x10;
return (*(unsigned int *) 0x78) ;
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
(*(unsigned char *) 0x61)=0x80;
(*(unsigned char *) 0x61)=0x00;
#pragma optsize+
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
(*(unsigned char *) 0xb6)=0x00;
(*(unsigned char *) 0xb0)=0x00;
(*(unsigned char *) 0xb1)=0x00;
(*(unsigned char *) 0xb2)=0x00;
(*(unsigned char *) 0xb3)=0x00;
(*(unsigned char *) 0xb4)=0x00;
// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// Interrupt on any change on pins PCINT0-7: Off
// Interrupt on any change on pins PCINT8-14: Off
// Interrupt on any change on pins PCINT16-23: Off
(*(unsigned char *) 0x69)=0x00;
EIMSK=0x00;
(*(unsigned char *) 0x68)=0x00;
// USART initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART Receiver: On
// USART Transmitter: On
// USART0 Mode: Asynchronous
// USART Baud rate: 9600
(*(unsigned char *) 0xc0)=0x00;
(*(unsigned char *) 0xc1)=0xD8;
(*(unsigned char *) 0xc2)=0x06;
(*(unsigned char *) 0xc5)=0x00;
(*(unsigned char *) 0xc4)=0x33;
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
(*(unsigned char *) 0x7b)=0x00;
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
