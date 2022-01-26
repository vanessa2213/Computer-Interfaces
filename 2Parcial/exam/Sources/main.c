/*
 * Perla Vanessa Jaime Gaytán A00344428
 * Edgar Damián Reyes Herrera A01634031
 * 2nd exam partial
 * 23/10/2020
 * CLKFreq = 20.97MHz
 * Baud Rate = 9600
 * 8 bit transfer
 * No parity
 * 1 stop bit
 * No Flow Control
 * 
 * 
 * This program uses uart to read and transmit data from the keyboard using an external terminal. When a lowercase letter is pressed,
 * this program converted it to an uppercase and the print it on uart. If the key pressed is an uppercase, the program converted it
 * to lowercase and then print it on uart. When the word end (with all its varitation: EnD, END, eND, etc.) the main program ends 
 * which makes the led turn off and disable the uart.  
 * 
 * 
 */

#include "derivative.h" 			// include KL25z library
#define UART0TXPIN     2

SIM_MemMapPtr SIM = SIM_BASE_PTR;
UART0_MemMapPtr UART0 = UART0_BASE_PTR;
PORT_MemMapPtr PORTA =PORTA_BASE_PTR;
NVIC_MemMapPtr NVIC = NVIC_BASE_PTR;
int con = 0;
int y = 1;

void UART0_init(void);
void UART0_IRQHandler(void);
void delayMs (int n);
void UART0_tx_string(char *txdata_arr, int size);
void UART0_tx_char(char txdata);

int main(void)
{
	//setup
	char string[]="\r\nThe main program came to its end!\n\r";
	UART0_init();

	SIM_SCGC5 |= 1<<SIM_SCGC5_PORTD_SHIFT; 			// able clock for D port to use blue led
	PORTD_PCR1 |= PORT_PCR_MUX(1);  				//Configure as gpio
	GPIOD_PDDR |= (1<<1); 							// Configure D1 as output (blue led)
	
	while(y == 1) {
		GPIOD_PTOR = 0x02; 		//Toogle blue led just to see when the main is running
		delayMs(100);			//little delay to see the led toogling
		
	}
	GPIOD_PSOR |= 0x02; 		//turn off blue led when the main ends
	UART0_tx_string(string,38);	//print that the program came to its end
	UART0->C2 = 0;				//disable uart to stop receiving and transmiting data
	return 0;
}

void UART0_init(){
	NVIC->ICPR = 0; 						//Clear pending interrupts
	SIM->SCGC4 |= SIM_SCGC4_UART0_MASK;  	//Enable clock to uart0
	SIM->SOPT2 |= SIM_SOPT2_UART0SRC(1); 	//select FLL as the clk for UART0
	UART0->C2 = 0; 							//Disable UART0 while configuration
	// Set baud rate to be 9600. 
	//Baud Rate = CLKFREQ/((OSR0+1)*SBR0)
	UART0->BDH = 0;
	UART0->BDL = 73;						//SBR0
	UART0->C4 = 30;							//OSR0
	
	UART0->C1 = 0; 											//8 bit data, no parity, 1 stop bit
	UART0->C2 |= UART0_C2_RE_MASK | UART0_C2_RIE_MASK; 		//Receive and receive interrupt enable
	NVIC->ISER |= (1<<12); 									//enable uart interruption
	
	SIM->SCGC5 |= SIM_SCGC5_PORTA_MASK; 					//Enable clock to PORTA
	PORTA->PCR[1] = PORT_PCR_MUX(2);  						//Configure PTA1 as UART0_Rx pin 
	
	UART0->C2 |= UART0_C2_TE_MASK;     						//Transmit enable
	PORTA->PCR[2] = PORT_PCR_MUX(2); 						//Configure PTA2 as UART0_Tx pin 
		
}

void UART0_tx_char(char txdata){
	while(!(UART0->S1 & UART0_S1_TDRE_MASK));	//wait for transmit data register to be empty
	UART0->D = txdata;							//writes on uart the data enter
}
void UART0_tx_string(char *txdata_arr, int size){	//print desire string
	int txdata_i=0;
	for (txdata_i=0; txdata_i<size;txdata_i++){		//printing char by char
		UART0_tx_char(txdata_arr[txdata_i]);
	}
}
void delayMs (int n){		//a function to make a delay for the led
	int i;
	int j;
	for(i = 0 ; i < n; i++)
		for (j = 0; j < 7000; j++) {}
}
void UART0_IRQHandler(void){		//UART interrupt handler
	char x; 
	if(UART0->S1 & UART0_S1_RDRF_MASK){		 //Transmission received detected
		x = UART0 -> D;						//save the data on char x
		if((x >= 65) & (x<=90)){			// is it uppercase?
			UART0->D = x+32;				//adding 32 makes it lowercase and printing on uart
			if (x == 'E'){					//check if the key pressed was an e
				con = 1;					//internal counter set to 1
			}
			else if ((x == 'N' )&(con ==1)){	//check if the e was pressed before this letter and if this letter is an N
				con = 2;						//internal counter set to 2
			}
			else if((x == 'D')&(con ==2)){		//check if the n was pressed before this letter and it this letter is a D
				con = 0;						//reset the counter
				y = 0;							//set y = 0 to end main
			}
			else{								//any other case reset counter 
				con = 0;
			}
			
		}
		else if((x >= 97) & (x<= 122)){		//is it lowercase?
			UART0->D = x-32;				//subtracting 32 makes it uppercase and printing on uart
			if (x == 'e'){					//check if the key pressed was an e
				con = 1;					//internal counter set to 1
			}
			else if ((x == 'n' )&(con ==1)){	//check if the e was pressed before this letter and if this letter is an N
				con = 2;						//internal counter set to 2
			}
			else if((x == 'd')&(con == 2)){		//check if the n was pressed before this letter and it this letter is a D
				con = 0;						//reset the counter			
				y = 0;							//set y = 0 to end main
			}
			else{								//any other case reset counter 
				con = 0;
			}
		}
		
		UART0->D = x;
		
	}
}




