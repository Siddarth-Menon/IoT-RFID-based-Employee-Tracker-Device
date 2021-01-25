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
  // CodeVisionAVR C Compiler
// (C) 1998-2000 Pavel Haiduc, HP InfoTech S.R.L.
#pragma used+
void delay_us(unsigned int n);
void delay_ms(unsigned int n);
#pragma used-
//#include <prototype.h> 
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
//#include<prototype.h>     
//#define INT0_PIN PIND.2         //int0 pin PD.2
//#define INT1_PIN PIND.3         //int1 pin PD.3
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
        PORTB.0=0;
        PORTB.1    =0;    
        PORTB.2  =1;     
        PORTD&=0x0F; 
        PORTD|=msb; 
        delay_us(5);         //6 nops       changed from 10u to 5u
        PORTB.2  =0;
        delay_us(5);         //6 nops
        PORTB.2  =1;
        PORTD&=0x0F;        //sending lsb now       
        PORTD|=lsb; 
        delay_us(5);         //6 nops
        PORTB.2  =0;
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
      PORTB.0=1;
      PORTB.1    =0;     
      PORTB.2  =1;
      PORTD&=0x0F; 
      PORTD|=msbc;         // this being moved to the lsbbits of port instead of msb...
      delay_us(5);        
      PORTB.2  =0 ;                   
      delay_us(5);        
      PORTB.2  =1;
      PORTD&=0x0F;
      PORTD|=lsbc;        
      delay_us(5);        
      PORTB.2  =0;     
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
