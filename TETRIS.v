`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:15:06 01/07/2017 
// Design Name: 
// Module Name:    TETRIS 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module TETRIS(
    VGA_RED,
	VGA_GREEN,
	VGA_BLUE,
    clk,
    kclk,
    key_data,
    reset,
    hsync,
    vsync,
	SW0,
    SW1,
    SW2,
    SW3
    );
   
////////////////////////////////////////////////////////   
input clk,kclk,key_data,reset;
input SW0,SW1,SW2,SW3;
output hsync,vsync;   
output reg VGA_RED;
output reg VGA_GREEN;
output reg VGA_BLUE;

////////////////////////////////////////////////////////


reg[10:0] pixel_col,pixel_row;
reg [21:0] key_reg;
reg [4:0] key_count;
reg c_state,n_state;
reg [1:0] direction;
reg rotation,down;
reg [70:0]block;
reg [6:0] block_index;
reg [2:0] brick_select;
reg [28:0] counter,counter1,counter2,counter3;
reg [20:0]down_cnt;

wire[10:0] col,row;
wire visible;
wire check;
wire [9:0]row_delete;
wire rele;

reg yellow_start,cyan_start,pink_start,blue_start;
reg[1:0] yellow_type,cyan_type,blue_type;
reg[6:0] next_pos1,next_pos2,next_pos3,next_pos4; 
wire [1:0] bound1,bound2,bound3,bound4;
wire buttom_yellow,buttom_cyan,buttom_pink,buttom_blue;

wire [2:0] overgame,wingame,ha,ha1,final;
wire score;
reg [3:0]score_cnt;

reg [1:0] color[0:70];
reg [6:0]i,j;
reg start;
reg over;
reg cnt;

//////////////////////Initial///////////////////////////////////
always@(posedge clk,posedge reset)begin
    if(reset) cnt<=0;
    else if(SW0==0&&SW1==0&&SW2==0&&SW3==0&& counter==50000000) cnt<=1;
    else if(SW0==1&&(counter==25000000||counter==50000000)) cnt<=1;
    else if(SW1==1&&(counter1==20000000)) cnt<=1;
    else if(SW2==1&&(counter2==15000000)) cnt<=1;
    else if(SW3==1&&(counter3==9000000)) cnt<=1;
    else cnt<=0;
end 


always@(posedge clk)begin
	if(reset)  pixel_col <= 0;
	else if(pixel_col==1039) pixel_col <= 0;
	else pixel_col <= pixel_col + 1;
end 
always@(posedge clk)begin
	if(reset)  pixel_row <= 0;
	else if(pixel_row==665) pixel_row <= 0;
	else if(pixel_col==1039) pixel_row <= pixel_row + 1;
	else pixel_row <= pixel_row;
end 

assign hsync = ~(pixel_col >= 919 & pixel_col < 1039);
assign vsync = ~(pixel_row >= 659 & pixel_row < 665);
assign visible = (pixel_col >= 104 & pixel_col < 904 & pixel_row >= 23 & pixel_row < 623);

assign col = pixel_col - 104;
assign row = pixel_row - 23;



always @(posedge clk)begin
	c_state <= n_state;
	n_state <= kclk;
end

always @(posedge clk)begin
	case({c_state,n_state})
		2'b10:begin
			key_reg <= {key_data,key_reg[21:1]};
			if(key_count==10) key_count <= 0;
			else key_count <= key_count+1;
		end
		default: key_reg <= key_reg;
	endcase
end
assign check = key_reg[1]^key_reg[2]^key_reg[3]^key_reg[4]^key_reg[5]^key_reg[6]^key_reg[7]^key_reg[8]^key_reg[9];
///////////////////////////////////////counter/////////////////////////////////////

always@(posedge clk or posedge reset)begin
	if(reset)begin 
		start<=0;
	end
	else if(score_cnt==9) start<=0;
	else if( key_count==0 && check == 1 )begin
		if(key_reg[19:12]==8'h5A ) start<=1;
		else begin 
			start<=start;
		end
	end
	else begin 
			start<=start;
	end	
end

always@(posedge clk or posedge reset)begin
	if(reset)  counter <= 0;
	else if(counter==50000000) counter <= 0;
	else counter <= counter + 1;
end 

always@(posedge clk or posedge reset)begin
	if(reset)  counter1 <= 0;
	else if(counter1==20000000) counter1 <= 0;
	else counter1 <= counter1 + 1;
end

always@(posedge clk or posedge reset)begin
	if(reset)  counter2 <= 0;
	else if(counter2==15000000) counter2 <= 0;
	else counter2 <= counter2 + 1;
end 

always@(posedge clk or posedge reset)begin
	if(reset)  counter3 <= 0;
	else if(counter3==9000000) counter3 <= 0;
	else counter3 <= counter3 + 1;
end 

always@(posedge clk or posedge reset)begin
	if(reset)  down_cnt <= 0;
	else if(down_cnt==1250000) down_cnt <= 0;
	else down_cnt <= down_cnt + 1;
end 
////////////////////////////////keyboard///////////////////////////////////////////

always @(posedge clk or posedge reset)begin
	if(reset) direction <= 0;
	else if(key_count==0 & check==1)begin
		if(key_reg[8:1]==8'hF0) direction <= 0;
		else if(key_reg[19:12]==8'h6B) direction <= 1; //left
		else if(key_reg[19:12]==8'h74) direction <= 2; //right
	else direction <= direction;
	end
	else direction <= direction;
end

always @(posedge clk or posedge reset)begin
	if(reset) rotation <= 0;
	else if(key_count==0 & check==1)begin
		if(key_reg[8:1]==8'hF0) rotation <= 0;
		else if(key_reg[19:12]==8'h75) rotation <= 1; 
		else rotation <= rotation;
	end
	else rotation <= rotation;
end

always @(posedge clk or posedge reset)begin
	if(reset) down <= 0;
	else if(key_count==0 & check==1)begin
		if(key_reg[8:1]==8'hF0) down <= 0;
		else if(key_reg[19:12]==8'h29) down <= 1; //space
		else down <= down;
	end
	else down <= down;
end

//////////////////////////////////////////////////////////////////
always@(posedge clk)begin    
	if(col >=190 & col < 250 & row >=  0 & row <   60 ) block_index <= 0;
	else if(col>=250 & col < 310 & row >=   0 & row < 60  ) block_index <= 1;
	else if(col>=310 & col < 370 & row >=   0 & row < 60  ) block_index <= 2;
	else if(col>=370 & col < 430 & row >=   0 & row < 60  ) block_index <= 3;
	else if(col>=430 & col < 490 & row >=   0 & row < 60  ) block_index <= 4;
	else if(col>=490 & col < 550 & row >=   0 & row < 60  ) block_index <= 5;
	else if(col>=550 & col < 610 & row >=   0 & row < 60  ) block_index <= 6;
    
	else if(col>=190 & col < 250 & row >=  60 & row < 120 ) block_index <= 7;
	else if(col>=250 & col < 310 & row >=  60 & row < 120 ) block_index <= 8;
	else if(col>=310 & col < 370 & row >=  60 & row < 120 ) block_index <= 9;
	else if(col>=370 & col < 430 & row >=  60 & row < 120 ) block_index <= 10;
	else if(col>=430 & col < 490 & row >=  60 & row < 120 ) block_index <= 11;
	else if(col>=490 & col < 550 & row >=  60 & row < 120 ) block_index <= 12;
	else if(col>=550 & col < 610 & row >=  60 & row < 120 ) block_index <= 13;
    
	else if(col>=190 & col < 250 & row >= 120 & row < 180 ) block_index <= 14;
	else if(col>=250 & col < 310 & row >= 120 & row < 180 ) block_index <= 15;
	else if(col>=310 & col < 370 & row >= 120 & row < 180 ) block_index <= 16;
	else if(col>=370 & col < 430 & row >= 120 & row < 180 ) block_index <= 17;
	else if(col>=430 & col < 490 & row >= 120 & row < 180 ) block_index <= 18;
	else if(col>=490 & col < 550 & row >= 120 & row < 180 ) block_index <= 19;
	else if(col>=550 & col < 610 & row >= 120 & row < 180 ) block_index <= 20;
    
	else if(col>=190 & col < 250 & row >= 180 & row < 240 ) block_index <= 21;
	else if(col>=250 & col < 310 & row >= 180 & row < 240 ) block_index <= 22;
	else if(col>=310 & col < 370 & row >= 180 & row < 240 ) block_index <= 23;
	else if(col>=370 & col < 430 & row >= 180 & row < 240 ) block_index <= 24;
	else if(col>=430 & col < 490 & row >= 180 & row < 240 ) block_index <= 25;
	else if(col>=490 & col < 550 & row >= 180 & row < 240 ) block_index <= 26;
	else if(col>=550 & col < 610 & row >= 180 & row < 240 ) block_index <= 27;
    
	else if(col>=190 & col < 250 & row >= 240 & row < 300 ) block_index <= 28;
	else if(col>=250 & col < 310 & row >= 240 & row < 300 ) block_index <= 29;
	else if(col>=310 & col < 370 & row >= 240 & row < 300 ) block_index <= 30;
	else if(col>=370 & col < 430 & row >= 240 & row < 300 ) block_index <= 31;
	else if(col>=430 & col < 490 & row >= 240 & row < 300 ) block_index <= 32;
	else if(col>=490 & col < 550 & row >= 240 & row < 300 ) block_index <= 33;
	else if(col>=550 & col < 610 & row >= 240 & row < 300 ) block_index <= 34;
    
	else if(col>=190 & col < 250 & row >= 300 & row < 360 ) block_index <= 35;
	else if(col>=250 & col < 310 & row >= 300 & row < 360 ) block_index <= 36;
	else if(col>=310 & col < 370 & row >= 300 & row < 360 ) block_index <= 37;
	else if(col>=370 & col < 430 & row >= 300 & row < 360 ) block_index <= 38;
	else if(col>=430 & col < 490 & row >= 300 & row < 360 ) block_index <= 39;
	else if(col>=490 & col < 550 & row >= 300 & row < 360 ) block_index <= 40;
	else if(col>=550 & col < 610 & row >= 300 & row < 360 ) block_index <= 41;
    
	else if(col>=190 & col < 250 & row >= 360 & row < 420 ) block_index <= 42;
	else if(col>=250 & col < 310 & row >= 360 & row < 420 ) block_index <= 43;
	else if(col>=310 & col < 370 & row >= 360 & row < 420 ) block_index <= 44;
	else if(col>=370 & col < 430 & row >= 360 & row < 420 ) block_index <= 45;
	else if(col>=430 & col < 490 & row >= 360 & row < 420 ) block_index <= 46;
	else if(col>=490 & col < 550 & row >= 360 & row < 420 ) block_index <= 47;
	else if(col>=550 & col < 610 & row >= 360 & row < 420 ) block_index <= 48;
    
	else if(col>=190 & col < 250 & row >= 420 & row < 480 ) block_index <= 49;
	else if(col>=250 & col < 310 & row >= 420 & row < 480 ) block_index <= 50;
	else if(col>=310 & col < 370 & row >= 420 & row < 480 ) block_index <= 51;
	else if(col>=370 & col < 430 & row >= 420 & row < 480 ) block_index <= 52;
	else if(col>=430 & col < 490 & row >= 420 & row < 480 ) block_index <= 53;
	else if(col>=490 & col < 550 & row >= 420 & row < 480 ) block_index <= 54;
	else if(col>=550 & col < 610 & row >= 420 & row < 480 ) block_index <= 55;
    
	else if(col>=190 & col < 250 & row >= 480 & row < 540 ) block_index <= 56;
	else if(col>=250 & col < 310 & row >= 480 & row < 540 ) block_index <= 57;
	else if(col>=310 & col < 370 & row >= 480 & row < 540 ) block_index <= 58;
	else if(col>=370 & col < 430 & row >= 480 & row < 540 ) block_index <= 59;
	else if(col>=430 & col < 490 & row >= 480 & row < 540 ) block_index <= 60;
	else if(col>=490 & col < 550 & row >= 480 & row < 540 ) block_index <= 61;
	else if(col>=550 & col < 610 & row >= 480 & row < 540 ) block_index <= 62;
    
	else if(col>=190 & col < 250 & row >= 540 & row < 600 ) block_index <= 63;
	else if(col>=250 & col < 310 & row >= 540 & row < 600 ) block_index <= 64;
	else if(col>=310 & col < 370 & row >= 540 & row < 600 ) block_index <= 65;
	else if(col>=370 & col < 430 & row >= 540 & row < 600 ) block_index <= 66;
	else if(col>=430 & col < 490 & row >= 540 & row < 600 ) block_index <= 67;
	else if(col>=490 & col < 550 & row >= 540 & row < 600 ) block_index <= 68;
	else if(col>=550 & col < 610 & row >= 540 & row < 600 ) block_index <= 69;
	else block_index <= 70;
end


assign row_delete[0] = block[0] & block[1] & block[2] & block[3] & block[4] & block[5] & block[6];
assign row_delete[1] = block[7] & block[8] & block[9] & block[10] & block[11] & block[12] & block[13];
assign row_delete[2] = block[14] & block[15] & block[16] & block[17] & block[18] & block[19] & block[20];
assign row_delete[3] = block[21] & block[22] & block[23] & block[24] & block[25] & block[26] & block[27];
assign row_delete[4] = block[28] & block[29] & block[30] & block[31] & block[32] & block[33] & block[34];
assign row_delete[5] = block[35] & block[36] & block[37] & block[38] & block[39] & block[40] & block[41];
assign row_delete[6] = block[42] & block[43] & block[44] & block[45] & block[46] & block[47] & block[48];
assign row_delete[7] = block[49] & block[50] & block[51] & block[52] & block[53] & block[54] & block[55];
assign row_delete[8] = block[56] & block[57] & block[58] & block[59] & block[60] & block[61] & block[62];
assign row_delete[9] = block[63] & block[64] & block[65] & block[66] & block[67] & block[68] & block[69];

assign score=(row_delete[0]||row_delete[1]||row_delete[2]||row_delete[3]||row_delete[4]||row_delete[5]||row_delete[6]||row_delete[7]||row_delete[8]||row_delete[9])?1:0;

always@(posedge clk or posedge reset)begin
    if(reset)score_cnt<=0;
    else if(score)score_cnt<=score_cnt+1;
    else if(score_cnt>=8)score_cnt<=9;
    else score_cnt<=score_cnt;
end
always@(posedge clk or posedge reset)begin
    for (i=0;i<=70;i=i+1)begin
        if(reset)begin
            block[i] <= 0;
            color [i] <= 3;
            //score <=0;
        end
        else if(start)begin
            if((row[0]||row[1]||row[2]||row[3]||row[4]||row[5]||row[6]||row[7]||row[8]||row[9]) & i <7)begin	
                block[i] <= 0;
                color [i] <= 3;
            end
            else if(row_delete[1] & i <14 & i >=7)begin
                block[i] <= block[i-7];
                color [i] <= color [i-7];
            end
            else if(row_delete[2] & i< 21 & i >=7 )begin
                block[i] <= block[i-7];
                color [i] <= color [i-7];
            end
            else if(row_delete[3] & i< 28 & i >=7)begin
                block[i] <= block[i-7];
                color [i] <= color [i-7];
            end
            else if(row_delete[4] & i< 35 & i >=7)begin
                block[i] <= block[i-7];
                color [i] <= color [i-7];
            end
            else if(row_delete[5] & i< 42 & i >=7)begin
                block[i] <= block[i-7];
                color [i] <= color [i-7];
            end
            else if(row_delete[6] & i< 49 & i >=7)begin
                block[i] <= block[i-7];
                color [i] <= color [i-7];
            end
            else if(row_delete[7] & i< 56 & i >=7)begin
                block[i] <= block[i-7];
                color [i] <= color [i-7];
            end
            else if(row_delete[8] & i< 63 & i >=7)begin
                block[i] <= block[i-7];
                color [i] <= color [i-7];
            end
            else if(row_delete[9] & i< 70 & i >=7)begin
                block[i] <= block[i-7];
                color [i] <= color [i-7];
            end
            
            
            else if(pink_start==1& (block[next_pos1]==1 || buttom_pink)&(i==next_pos1-7) )begin
                block [i] <= 1;
                color [i] <= 2;
            end
            else if(cyan_start==1 & (block[next_pos1]==1 || block[next_pos2]==1 || buttom_cyan)  & (i==next_pos1-7 || i==next_pos2-7 ) )begin
                block [i] <= 1;
                color [i] <= 1;
            end
            
			else if(yellow_start==1 & (block[next_pos1]==1 || block[next_pos2]==1 || block[next_pos3]==1 || block[next_pos4]==1  ||buttom_yellow )  & (i==next_pos1-7 || i==next_pos2-7 || i==next_pos3-7 || i==next_pos4-7) )begin
                block [i] <= 1;
                color [i] <= 0;
            end
			else if(blue_start==1 & (block[next_pos1]==1 || block[next_pos2]==1 || block[next_pos3]==1 || buttom_blue )  & (i==next_pos1-7 || i==next_pos2-7 || i==next_pos3-7) )begin
                block [i] <= 1;
                color [i] <= 3;
            end
            else begin
                block[i] <= block[i];
                color [i] <= color [i];
            end
        end
    end   
end

        
///////////////////////////////////////////////////////////////

assign bound1[0] =  (next_pos1==0||next_pos1==7||next_pos1==14||next_pos1==21||next_pos1==28||next_pos1==35||next_pos1==42||next_pos1==49||next_pos1==56||next_pos1==63); 
assign bound1[1] =  (next_pos1==6||next_pos1==13||next_pos1==20||next_pos1==27||next_pos1==34||next_pos1==41||next_pos1==48||next_pos1==55||next_pos1==62||next_pos1==69);
assign bound2[0] =  (next_pos2==0||next_pos2==7||next_pos2==14||next_pos2==21||next_pos2==28||next_pos2==35||next_pos2==42||next_pos2==49||next_pos2==56||next_pos2==63);
assign bound2[1] =  (next_pos2==6||next_pos2==13||next_pos2==20||next_pos2==27||next_pos2==34||next_pos2==41||next_pos2==48||next_pos2==55||next_pos2==62||next_pos2==69);
assign bound3[0] =  (next_pos3==0||next_pos3==7||next_pos3==14||next_pos3==21||next_pos3==28||next_pos3==35||next_pos3==42||next_pos3==49||next_pos3==56||next_pos3==63);
assign bound3[1] =  (next_pos3==6||next_pos3==13||next_pos3==20||next_pos3==27||next_pos3==34||next_pos3==41||next_pos3==48||next_pos3==55||next_pos3==62||next_pos3==69);
assign bound4[0] =  (next_pos4==0||next_pos4==7||next_pos4==14||next_pos4==21||next_pos4==28||next_pos4==35||next_pos4==42||next_pos4==49||next_pos4==56||next_pos4==63);
assign bound4[1] =  (next_pos4==6||next_pos4==13||next_pos4==20||next_pos4==27||next_pos4==34||next_pos4==41||next_pos4==48||next_pos4==55||next_pos4==62||next_pos4==69);

assign rele=(key_reg[8:1]==8'hF0)?1:0;
///////////////////////////////////////////////////////////////


always@(posedge clk or posedge reset)begin
	if(reset)brick_select <= 0;
	else if(over) brick_select <= 4;
	
	else if(brick_select==0 & (block[next_pos1]==1 || block[next_pos2]==1 || block[next_pos3] == 1 || block[next_pos4] ||buttom_yellow) )brick_select <= 1 ;//cyan
	else if(brick_select==1 & (block[next_pos1]==1 || block[next_pos2]==1 || buttom_cyan) )brick_select <= 2 ;//pink
	else if(brick_select==2 & (block[next_pos1]==1 || buttom_pink) )brick_select <= 3 ;	//yellow //3
	else if(brick_select==3 & (block[next_pos1]==1 || block[next_pos2]==1 || block[next_pos3]==1 || buttom_blue) )brick_select <= 0 ; 	
	else brick_select <= brick_select;
end
///////////////////////////////////////////////////////////////



always@(posedge clk or posedge reset)begin  
	if(reset)begin
		blue_start<=0;
        pink_start<=0;
        cyan_start<=0;
        yellow_start<=0;
    end
    else begin
        case(brick_select)
			0:begin
				if(block[next_pos1]==1 || block[next_pos2]==1 || block[next_pos3]==1 || block[next_pos4]==1 || buttom_yellow)yellow_start<=0;
				else if (brick_select==0) yellow_start<=1;	
				else yellow_start <= 0;   
			end
			1:begin
				if(block[next_pos1]==1 || block[next_pos2]==1 || buttom_cyan)cyan_start<=0;
				else if (brick_select==1) cyan_start<=1;	
				else cyan_start <= 0;
			end
			2:begin
				if(block[next_pos1]==1 || buttom_pink)pink_start<=0;
				else if (brick_select==2) pink_start<=1;	
				else pink_start <= 0;
			end
			3:
			if(block[next_pos1]==1 || block[next_pos2]==1 || block[next_pos3]==1 || buttom_blue)blue_start<=0;
			else if (brick_select==3) blue_start<=1;	
			else blue_start <= 0;
			
			
		endcase
    end
	
end


always@(posedge clk or posedge reset)begin  
	if(reset) begin
		next_pos1 <=  10;
        next_pos2 <=  9;
        next_pos3 <=  3;
        next_pos4 <=  16;
	end
    else if(start)begin
        if(pink_start)begin//////////////////////////////////////////////////
            if(block[next_pos1]==1|| buttom_pink )begin
                next_pos1 <=  10;
				next_pos2 <=  3;
				next_pos3 <=  4;
				next_pos4 <=  16;
            end
            else if(down==1 & down_cnt == 1250000)begin
                next_pos1 <= next_pos1 + 7;
            end
            else if(rele &(direction==1||direction==2) & cnt)begin
                case(direction)		
                    1: begin
                        if(bound1[0]==0 & block[next_pos1+7-1]==0 & next_pos1<63)begin
                            next_pos1 <=  next_pos1 + 7 - 1;
                        end
                        else begin
                            next_pos1 <=  next_pos1 + 7;
                        end
                    end
                    2: begin
                        if(bound1[1]==0 & block[next_pos1+7+1]==0 & next_pos1<63)begin
                            next_pos1 <=  next_pos1 + 7 + 1;
                        end
                        else begin
                            next_pos1 <= next_pos1 + 7;
                        end
                    end
                    default: begin
                        next_pos1 <=  next_pos1 + 7;
                    end
                endcase
            end
            else if(rele &(direction==1||direction==2))begin
                case(direction)		
                    1: begin
                        if(bound1[0]==0 & block[next_pos1-1]==0)begin
                            next_pos1 <=  next_pos1 - 1;
                        end
                        else begin
                            next_pos1 <=  next_pos1 ;
                        end
                    end
                    2: begin
                        if(bound1[1]==0 & block[next_pos1+1]==0)begin
                            next_pos1 <=  next_pos1 + 1;
                        end
                        else begin
                            next_pos1 <= next_pos1;
                        end
                    end
                    default: begin
                        next_pos1 <=  next_pos1 ;
                    end
                endcase
            end
            else if(cnt)begin
                next_pos1 <= next_pos1+7;
            end
            else  begin
                next_pos1 <= next_pos1;
            end        
        end 
        else if(cyan_start)begin////////////////////////////////////////
            if( block[next_pos1]==1 || block[next_pos2]==1|| buttom_cyan  )begin
                next_pos1 <=  3;
                next_pos2 <=  4;
            end
            else if(down==1 & down_cnt == 1250000)begin
                next_pos1 <=  next_pos1 + 7;
                next_pos2 <=  next_pos2 + 7;
            end
            else if(rele & (direction==1||direction==2) & cnt)begin
                case(direction)
                    0: begin
                        next_pos1 <= next_pos1 + 7;
                        next_pos2 <= next_pos2 + 7;
                    end
                    1: begin
                        if(bound1[0]==0 & bound2[0]==0 & block[next_pos1+7-1] ==0 & block[next_pos2+7-1]==0 & next_pos1<63 & next_pos2<63)begin
                            next_pos1 <=  next_pos1 + 7 - 1;
                            next_pos2 <=  next_pos2 + 7 - 1;
                        end
                        else begin
                            next_pos1 <=  next_pos1 + 7;
                            next_pos2 <=  next_pos2 + 7;
                        end
                    end
                    2: begin
                        if(bound1[1]==0 & bound2[1]==0 & block[next_pos1+7+1] ==0 & block[next_pos2+7+1]==0 & next_pos1<63 & next_pos2<63)begin
                            next_pos1 <=  next_pos1 + 7 + 1;
                            next_pos2 <=  next_pos2 + 7 + 1;
                        end
                        else begin
                            next_pos1 <=  next_pos1 + 7;
                            next_pos2 <=  next_pos2 + 7;
                        end
                    end
                    default: begin
                        next_pos1 <=  next_pos1 + 7;
                        next_pos2 <=  next_pos2 + 7;
                    end
                endcase
            end
            else if(rele & (direction==1||direction==2))begin
                case(direction)
                    0: begin
                        next_pos1 <= next_pos1;
                        next_pos2 <= next_pos2;
                    end
                    1: begin
                        if(bound1[0]==0 & bound2[0]==0 & block[next_pos1-1] ==0 & block[next_pos2-1] ==0)begin
                            next_pos1 <=  next_pos1 - 1;
                            next_pos2 <=  next_pos2 - 1;
                        end
                        else begin
                            next_pos1 <=  next_pos1 ;
                            next_pos2 <=  next_pos2 ;
                        end
                    end
                    2: begin
                        if(bound1[1]==0 & bound2[1]==0 & block[next_pos1+1] ==0 & block[next_pos2+1] ==0)begin
                            next_pos1 <=  next_pos1 + 1;
                            next_pos2 <=  next_pos2 + 1;
                        end
                        else begin
                            next_pos1 <=  next_pos1 ;
                            next_pos2 <=  next_pos2 ;
                        end
                    end
                    default: begin
                        next_pos1 <=  next_pos1 ;
                        next_pos2 <=  next_pos2 ;
                    end
                endcase
            end
            else if(rotation == 1 & rele == 1&cnt)begin//================================
                case(cyan_type)
                    0: begin
                        if(block[next_pos1+7+1]==0 & bound1[1]==0)begin
                            next_pos1 <=  next_pos1 + 7;
                            next_pos2 <=  next_pos1 + 7 + 1;
                        end
                    end
                    1: begin
                        if(block[next_pos1+7+7]==0 & next_pos1<63)begin
                            next_pos1 <=  next_pos1 + 7;
                            next_pos2 <=  next_pos1 + 7 + 7;
                        end
                    end
                    2: begin
                        if(block[next_pos1+7-1]==0 & bound1[0]==0)begin
                            next_pos1 <=  next_pos1 + 7;
                            next_pos2 <=  next_pos1 + 7 - 1;
                        end
                    end
                    3: begin
                        if(block[next_pos1+7-7]==0 & next_pos1>6/*bound2[0]==0 & bound1[0]==0*/)begin
                            next_pos1 <=  next_pos1 + 7;
                            next_pos2 <=  next_pos1 + 7 - 7;
                        end
                    end
                endcase
            end
            else if(rotation == 1 & rele == 1)begin
                case(cyan_type)
                    0: begin
                        if(block[next_pos1+1]==0 & bound1[1]==0)begin
                            next_pos1 <=  next_pos1 ;
                            next_pos2 <=  next_pos1 + 1;
                        end
                    end
                    1: begin
                        if(block[next_pos1+7]==0 & next_pos1<63)begin
                            next_pos1 <=  next_pos1;
                            next_pos2 <=  next_pos1 + 7;
                        end
                    end
                    2: begin
                        if(block[next_pos1-1]==0 & bound1[0]==0)begin
                            next_pos1 <=  next_pos1 ;
                            next_pos2 <=  next_pos1 - 1;
                        end
                    end
                    3: begin
                        if(block[next_pos1-7]==0 & next_pos1>6/*bound2[0]==0 & bound1[0]==0*/)begin
                            next_pos1 <=  next_pos1;
                            next_pos2 <=  next_pos1 - 7;
                        end
                    end
                endcase
            end
            else if(cnt)begin		 
                next_pos1 <=  next_pos1 + 7;
                next_pos2 <=  next_pos2 + 7;		
            end
            else  begin
                next_pos1 <=  next_pos1 ;
                next_pos2 <=  next_pos2 ;
            end        
        end
        else if(yellow_start==1)begin////////////////////////////////////////////////////////////
            if(block[next_pos1]==1 || block[next_pos2]==1 || block[next_pos3]==1 || block[next_pos4]==1 || buttom_yellow  )begin
                next_pos1 <=  3;
                next_pos2 <=  4;
                next_pos3 <=  3;
                next_pos4 <=  16;
            end
            else if(down==1 & down_cnt == 1250000)begin
                next_pos1 <=  next_pos1 + 7;
                next_pos2 <=  next_pos2 + 7;
                next_pos3 <=  next_pos3 + 7;
                next_pos4 <=  next_pos4 + 7;
            end
            else if(rele & (direction==1||direction==2)& cnt)begin
                case(direction)
                    0: begin
                        next_pos1 <=  next_pos1 + 7;
                        next_pos2 <=  next_pos2 + 7;
                        next_pos3 <=  next_pos3 + 7;
                        next_pos3 <=  next_pos4 + 7;
                    end
                    1: begin
                        if(bound1[0]==0 & bound2[0]==0 &  bound3[0]==0 &  bound4[0]==0 & block[next_pos1+7-1]==0 &block[next_pos2+7-1]==0&block[next_pos3+7-1]==0 &block[next_pos4+7-1]==0 & next_pos1<63 &next_pos2<63 &next_pos3<63&next_pos4<63)begin
                            next_pos1 <=  next_pos1 + 7 - 1;
                            next_pos2 <=  next_pos2 + 7 - 1;
                            next_pos3 <=  next_pos3 + 7 - 1;
                            next_pos4 <=  next_pos4 + 7 - 1;
                        end
                        else begin
                            next_pos1 <=  next_pos1 + 7;
                            next_pos2 <=  next_pos2 + 7;
                            next_pos3 <=  next_pos3 + 7;
                            next_pos4 <=  next_pos4 + 7;
                        end
                    end
                    2: begin
                        if(bound1[1]==0 & bound2[1]==0 &  bound3[1]==0&&  bound4[1]==0& block[next_pos1+7+1]==0 &block[next_pos2+7+1]==0&block[next_pos3+7+1]==0&block[next_pos4+7+1]==0& next_pos1<63 &next_pos2<63 &next_pos3<63&next_pos4<63)begin
                            next_pos1 <=  next_pos1 + 7 + 1;
                            next_pos2 <=  next_pos2 + 7 + 1;
                            next_pos3 <=  next_pos3 + 7 + 1;
                            next_pos4 <=  next_pos4 + 7 + 1;
                        end
                        else begin
                            next_pos1 <=  next_pos1 + 7;
                            next_pos2 <=  next_pos2 + 7;
                            next_pos3 <=  next_pos3 + 7;
                            next_pos4 <=  next_pos4 + 7;
                        end
                    end
                    default: begin
                        next_pos1 <=  next_pos1 + 7;
                        next_pos2 <=  next_pos2 + 7;
                        next_pos3 <=  next_pos3 + 7;
                        next_pos4 <=  next_pos4 + 7;
                    end
                endcase
            end
            else if(rele & (direction==1||direction==2))begin
                case(direction)
                    0: begin
                        next_pos1 <=  next_pos1 ;
                        next_pos2 <=  next_pos2 ;
                        next_pos3 <=  next_pos3 ;
                        next_pos4 <=  next_pos4 ;
                    end
                    1: begin
                        if(bound1[0]==0 & bound2[0]==0 &  bound3[0]==0 &   bound4[0]==0 &block[next_pos1-1]==0 &block[next_pos2-1]==0&block[next_pos3-1]==0&block[next_pos4-1]==0)begin
                            next_pos1 <=  next_pos1 - 1;
                            next_pos2 <=  next_pos2 - 1;
                            next_pos3 <=  next_pos3 - 1;
                            next_pos4 <=  next_pos4 - 1;
                        end
                        else begin
                            next_pos1 <=  next_pos1 ;
                            next_pos2 <=  next_pos2 ;
                            next_pos3 <=  next_pos3 ;
                            next_pos4 <=  next_pos4 ;
                        end
                    end
                    2: begin
                        if(bound1[1]==0 & bound2[1]==0 &  bound3[1]==0 &  bound4[1]==0 &block[next_pos1+1]==0 &block[next_pos2+1]==0&block[next_pos3+1]==0&block[next_pos4+1]==0)begin
                            next_pos1 <=  next_pos1 + 1;
                            next_pos2 <=  next_pos2 + 1;
                            next_pos3 <=  next_pos3 + 1;
                            next_pos4 <=  next_pos4 + 1;
                        end
                        else begin
                            next_pos1 <=  next_pos1 ;
                            next_pos2 <=  next_pos2 ;
                            next_pos3 <=  next_pos3 ;
                            next_pos4 <=  next_pos4 ;
                        end
                    end
                    default: begin
                        next_pos1 <=  next_pos1 ;
                        next_pos2 <=  next_pos2 ;
                        next_pos3 <=  next_pos3 ;
                        next_pos4 <=  next_pos4 ;
                    end
                endcase
            end  
            
            else if(rotation==1 & rele==1 & cnt)begin//================================
                case(yellow_type)
                0: begin
                        if(block[next_pos1+7-1]==0 & block[next_pos1+7-1+7]==0 &bound1[0]==0&bound1[1]==0&next_pos1>6& next_pos1<63/*&bound1[1]==0 */)begin
                            next_pos1 <=  next_pos1 + 7;
                            next_pos2 <=  next_pos1 + 7 - 1;
                            next_pos3 <=  next_pos1 + 7 - 7;
                            next_pos4 <=  next_pos1 + 7 - 1 + 7;
                        end                          
                    end
                    1: begin
                        if(block[next_pos1+7-7]==0 & block[next_pos1+7-1-7]==0 &bound1[0]==0&bound1[1]==0)begin
                            next_pos1 <=  next_pos1 + 7;
                            next_pos2 <=  next_pos1 + 7  - 7;
                            next_pos3 <=  next_pos1 + 7  + 1;
                            next_pos4 <=  next_pos1 + 7  - 7 -1;
                        end
                    end
                    2: begin
                        if(block[next_pos1+7+1]==0 & block[next_pos1+7+1-7]==0 & bound1[0]==0&bound1[1]==0 &next_pos1>6& next_pos1<63)begin
                            next_pos1 <=  next_pos1+7;
                            next_pos2 <=  next_pos1+7 + 1;
                            next_pos3 <=  next_pos1+7 + 7;
                            next_pos4 <=  next_pos1+7 + 1 - 7;
                        end
                    end
                    3: begin
                    if(block[next_pos1+7]==0 & block[next_pos1+1 + 7]==0 &bound1[0]==0&bound1[1]==0)begin
                            next_pos1 <=  next_pos1+7;
                            next_pos2 <=  next_pos1+7 + 7;
                            next_pos3 <=  next_pos1+7 - 1;
                            next_pos4 <=  next_pos1+7 + 7 + 1;
                        end
                    end
                endcase
            end
            else if(rotation==1 & rele==1)begin
                case(yellow_type)
                    0: begin
                        if(block[next_pos1-1]==0 & block[next_pos1-1 + 7]==0 & bound1[0]==0&bound1[1]==0&next_pos1>6& next_pos1<63/*&bound1[1]==0 */)begin
                            next_pos1 <=  next_pos1;
                            next_pos2 <=  next_pos1 - 1;
                            next_pos3 <=  next_pos1 - 7;
                            next_pos4 <=  next_pos1 - 1 + 7;
                        end
                    end
                    1: begin
                        if(block[next_pos1-7]==0 & block[next_pos1-1-7]==0 &bound1[0]==0&bound1[1]==0)begin
                            next_pos1 <=  next_pos1;
                            next_pos2 <=  next_pos1 - 7;
                            next_pos3 <=  next_pos1 + 1;
                            next_pos4 <=  next_pos1 - 7 -1;
                        end
                    end
                    2: begin
                        if(block[next_pos1+1]==0 & block[next_pos1+1-7]==0 & bound1[0]==0&bound1[1]==0&next_pos1>6& next_pos1<63)begin
                            next_pos1 <=  next_pos1;
                            next_pos2 <=  next_pos1 + 1;
                            next_pos3 <=  next_pos1 + 7;
                            next_pos4 <=  next_pos1 + 1 - 7;
                        end
                    end
                    3: begin
                    if(block[next_pos1+7]==0 & block[next_pos1+1 + 7]==0 &bound1[0]==0&bound1[1]==0)begin
                            next_pos1 <=  next_pos1;
                            next_pos2 <=  next_pos1 + 7;
                            next_pos3 <=  next_pos1 - 1;
                            next_pos4 <=  next_pos1 + 7 + 1;
                        end
                    end
                endcase
            end   
            else if(cnt)begin	
                next_pos1 <=  next_pos1 + 7;
                next_pos2 <=  next_pos2 + 7;
                next_pos3 <=  next_pos3 + 7;
                next_pos4 <=  next_pos4 + 7;
                    
            end
            else  begin
                next_pos1 <=  next_pos1 ;
                next_pos2 <=  next_pos2 ;
                next_pos3 <=  next_pos3 ;
                next_pos4 <=  next_pos4 ;
            end       
        end
        else if(blue_start==1)begin/////////////////////////////////////////////////////////
			if(block[next_pos1]==1 || block[next_pos2]==1 || block[next_pos3]==1 || buttom_blue )begin
				next_pos1 <=  10;
				next_pos2 <=  9;
				next_pos3 <=  3;
				next_pos4 <=  16;
			end
			else if(down==1 & down_cnt == 1250000)begin
				next_pos1 <=  next_pos1 + 7;
				next_pos2 <=  next_pos2 + 7;
				next_pos3 <=  next_pos3 + 7;
			end
			else if(rele & (direction==1||direction==2)& cnt)begin
				case(direction)
					0: begin
						next_pos1 <=  next_pos1 + 7;
						next_pos2 <=  next_pos2 + 7;
						next_pos3 <=  next_pos3 + 7;
					end
					1: begin
						if(bound1[0]==0 & bound2[0]==0 &  bound3[0]==0 & block[next_pos1+7-1]==0 &block[next_pos2+7-1]==0&block[next_pos3+7-1]==0 & next_pos1<63 &next_pos2<63 &next_pos3<63)begin
							next_pos1 <=  next_pos1 + 7 - 1;
							next_pos2 <=  next_pos2 + 7 - 1;
							next_pos3 <=  next_pos3 + 7 - 1;
						end
						else begin
							next_pos1 <=  next_pos1 + 7;
							next_pos2 <=  next_pos2 + 7;
							next_pos3 <=  next_pos3 + 7;
						end
					end
					2: begin
						if(bound1[1]==0 & bound2[1]==0 &  bound3[1]==0& block[next_pos1+7+1]==0 &block[next_pos2+7+1]==0&block[next_pos3+7+1]==0& next_pos1<63 &next_pos2<63 &next_pos3<63)begin
							next_pos1 <=  next_pos1 + 7 + 1;
							next_pos2 <=  next_pos2 + 7 + 1;
							next_pos3 <=  next_pos3 + 7 + 1;
						end
						else begin
							next_pos1 <=  next_pos1 + 7;
							next_pos2 <=  next_pos2 + 7;
							next_pos3 <=  next_pos3 + 7;
						end
					end
					default: begin
						next_pos1 <=  next_pos1 + 7;
						next_pos2 <=  next_pos2 + 7;
						next_pos3 <=  next_pos3 + 7;
					end
				endcase
			end
			else if(rele & (direction==1||direction==2))begin
				case(direction)
					0: begin
						next_pos1 <=  next_pos1 ;
						next_pos2 <=  next_pos2 ;
						next_pos3 <=  next_pos3 ;
					end
					1: begin
						if(bound1[0]==0 & bound2[0]==0 &  bound3[0]==0 & block[next_pos1-1]==0 &block[next_pos2-1]==0&block[next_pos3-1]==0)begin
							next_pos1 <=  next_pos1 - 1;
							next_pos2 <=  next_pos2 - 1;
							next_pos3 <=  next_pos3 - 1;
						end
						else begin
							next_pos1 <=  next_pos1 ;
							next_pos2 <=  next_pos2 ;
							next_pos3 <=  next_pos3 ;
						end
					end
					2: begin
						if(bound1[1]==0 & bound2[1]==0 &  bound3[1]==0 & block[next_pos1+1]==0 &block[next_pos2+1]==0&block[next_pos3+1]==0)begin
							next_pos1 <=  next_pos1 + 1;
							next_pos2 <=  next_pos2 + 1;
							next_pos3 <=  next_pos3 + 1;
						end
						else begin
							next_pos1 <=  next_pos1 ;
							next_pos2 <=  next_pos2 ;
							next_pos3 <=  next_pos3 ;
						end
					end
					default: begin
						next_pos1 <=  next_pos1 ;
						next_pos2 <=  next_pos2 ;
						next_pos3 <=  next_pos3 ;
					end
				endcase
			end
						
			else if(rotation==1 & rele==1 & cnt)begin//===========================
				case(blue_type)
					0: begin
						if(block[next_pos1+7+1]==0 & bound1[1]==0 )begin
							next_pos1 <=  next_pos1 +7;
							next_pos2 <=  next_pos1 +7 + 1;
							next_pos3 <=  next_pos1 +7 + 7;
						end
					end
					1: begin
					if(block[next_pos1+7+7]==0 & next_pos1<63)begin
							next_pos1 <=  next_pos1 +7;
							next_pos2 <=  next_pos1 +7 - 1;
							next_pos3 <=  next_pos1 +7 + 7;
						end
					end
					2: begin
						if(block[next_pos1+7-1]==0 & bound1[0]==0 )begin
							next_pos1 <=  next_pos1 +7;
							next_pos2 <=  next_pos1 +7 - 7;
							next_pos3 <=  next_pos1 +7 - 1;
						end
						
					end
					3: begin
						if(block[next_pos1+7-7]==0 & next_pos1>6)begin
							next_pos1 <=  next_pos1 +7;
							next_pos2 <=  next_pos1 +7 + 1;
							next_pos3 <=  next_pos1 +7 - 7;
						end
					end
				endcase
			end
			else if(rotation==1 & rele==1)begin
				case(blue_type)
					0: begin
						if(block[next_pos1+1]==0 & bound1[1]==0 )begin
							next_pos1 <=  next_pos1;
							next_pos2 <=  next_pos1 + 1;
							next_pos3 <=  next_pos1 + 7;
						end
					end
					1: begin
						if(block[next_pos1+7]==0 & next_pos1<63)begin
							next_pos1 <=  next_pos1;
							next_pos2 <=  next_pos1 - 1;
							next_pos3 <=  next_pos1 + 7;
						end
					end
					2: begin
						if(block[next_pos1-1]==0 & bound1[0]==0 )begin
							next_pos1 <=  next_pos1;
							next_pos2 <=  next_pos1 - 7;
							next_pos3 <=  next_pos1 - 1;
						end
					end
					3: begin
						if(block[next_pos1-7]==0 & next_pos1>6)begin
							next_pos1 <=  next_pos1;
							next_pos2 <=  next_pos1 + 1;
							next_pos3 <=  next_pos1 - 7;
						end
					end
				endcase
			end
			
			else if(cnt)begin	
				next_pos1 <=  next_pos1 + 7;
				next_pos2 <=  next_pos2 + 7;
				next_pos3 <=  next_pos3 + 7;
				
					
			end
			else  begin
				next_pos1 <=  next_pos1 ;
				next_pos2 <=  next_pos2 ;
				next_pos3 <=  next_pos3 ;
			end
		end
		else  begin
				next_pos1 <=  next_pos1 ;
				next_pos2 <=  next_pos2 ;
				next_pos3 <=  next_pos3 ;
		end
   end  
end
//////////////////////////////////////////////////////////////
assign buttom_pink = (pink_start==1 & next_pos1>69);
//////////////////////////////////////////////////////////////


assign buttom_cyan =  (cyan_start==1& (next_pos1 > 69 || next_pos2 > 69)) ;


always@(posedge clk or posedge reset)begin  
	if(reset)  cyan_type <= 0;
    else if(start&cyan_start)begin
        if (block[next_pos1]==1 || block[next_pos2]==1 || buttom_cyan) cyan_type <=0;
        else if(rele)begin
            case(rotation)
                0: cyan_type <= cyan_type;
                1:begin
                    case(cyan_type)
                        0 : cyan_type <= 3;
                        1 : begin
                            if(bound1[1]||bound2[1]) cyan_type <= 1;
                            else cyan_type <= 0;
                        end
                        2 : cyan_type <= 1;
                        3 : begin
                            if(bound1[0]||bound2[0]) cyan_type <= 3;
                            else cyan_type <= 2;
                        end
                        default : cyan_type <= cyan_type;
                    endcase
                end
                
                default:cyan_type <= cyan_type;
            endcase
        end
		else cyan_type <= cyan_type;
    end   
end
//////////////////////////////////////////////////////////////

assign buttom_yellow =  (yellow_start & (next_pos1 > 69 || next_pos2 > 69 || next_pos3 > 69|| next_pos4 > 69));

always@(posedge clk or posedge reset)begin  
	if(reset)  yellow_type <= 0;
    else if(start&yellow_start)begin
        if (block[next_pos1]==1 || block[next_pos2]==1 || block[next_pos3]==1 || block[next_pos4]==1 || buttom_yellow) yellow_type <=0;
        else if(rele)begin
            case(rotation)
                0: yellow_type <= yellow_type;
                1:begin
                    if((yellow_type== 0 & (bound1[0]==1||bound1[1]==1) )|| (yellow_type==2  & (bound1[0]==1||bound1[1]==1)))yellow_type <= yellow_type;
                    else begin
                        if(yellow_type == 0) yellow_type <= 3;
                        else yellow_type <= yellow_type - 1;
                    end
                end
                default:yellow_type <= yellow_type;
            endcase
        end
        else yellow_type <= yellow_type;
    end
end

//////////////////////////////////////////////////////////////


assign buttom_blue = (blue_start&(next_pos1 > 69 || next_pos2 > 69 || next_pos3 > 69));


always@(posedge clk or posedge reset)begin  
	if(reset)  blue_type <= 0;
    else if(start&blue_start)begin
        if (block[next_pos1]==1 || block[next_pos2]==1 || block[next_pos3]==1 || buttom_blue) blue_type <=0;
        else if(rele)begin
            case(rotation)
                0: blue_type <= blue_type;
                1:begin
                    if((blue_type== 1 & bound1[1]==1 )||(blue_type==3 & bound1[0]==1))blue_type <= blue_type;
                    else begin
                        if(blue_type == 0) blue_type <= 3;
                        else blue_type <= blue_type - 1;
                    end
                end
                default:blue_type <= blue_type;
            endcase
        end
        else blue_type <= blue_type;
    end
end



//////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////

GAMEOVER M1(clk,col,row,overgame);
WIN M3(clk,col,row,wingame);
//HAHA M4 (clk,row,col,haha);
HA M5 (clk,row,col,score_cnt,ha);
HA5 M9 (clk,row,col,score_cnt-4,ha1);
FINAL M12 (clk,row,col,final);




always@(posedge clk or posedge reset)begin
	if(reset)over<=0;
	else if(block[10]==1 ||(block[10]==0&&block[3]==1))over<=1;
	else over <= over;
end


always@(posedge clk or posedge reset)begin
	if(reset) {VGA_RED,VGA_GREEN,VGA_BLUE} <= 3'b111;
	else if(visible)begin
    
        //if(over & row>=0&& row<400 &&col >=0 &&col<800) {VGA_RED,VGA_GREEN,VGA_BLUE} <= lose;
        if (over & row>=0&& row<600 &&col >=0 &&col<800) {VGA_RED,VGA_GREEN,VGA_BLUE} <= overgame;
		else if(score_cnt ==9 &(row>=0 && row<600 &&col>=0 &&col <=800)) {VGA_RED,VGA_GREEN,VGA_BLUE}<=wingame;
		else if ( (col >= 160 & col < 190) || (col >=610 & col <640 )){VGA_RED,VGA_GREEN,VGA_BLUE} <= 3'b000;
		else if (block[block_index])begin
			case(color[block_index])
				0:{VGA_RED,VGA_GREEN,VGA_BLUE} <= 3'b110;
				1:{VGA_RED,VGA_GREEN,VGA_BLUE} <= 3'b011;
				2:{VGA_RED,VGA_GREEN,VGA_BLUE} <= 3'b101;
				3:{VGA_RED,VGA_GREEN,VGA_BLUE} <= 3'b001;
				default:{VGA_RED,VGA_GREEN,VGA_BLUE} <= 3'b001;
			endcase
		end
		else if (brick_select==0 & (block_index==next_pos1 || block_index==next_pos2 || block_index==next_pos3 || block_index==next_pos4)){VGA_RED,VGA_GREEN,VGA_BLUE}<= 3'b010;
		else if (brick_select==1 & (block_index==next_pos1 || block_index==next_pos2 )){VGA_RED,VGA_GREEN,VGA_BLUE}<= 3'b001;
		else if (brick_select==2 & block_index==next_pos1){VGA_RED,VGA_GREEN,VGA_BLUE}<= 3'b011;
		else if (brick_select==3 & (block_index==next_pos1 || block_index==next_pos2 || block_index==next_pos3 )){VGA_RED,VGA_GREEN,VGA_BLUE}<= 3'b110;
        else if(score_cnt ==1 & row>=0 && row<600 &&col>=0 &&col <=189) {VGA_RED,VGA_GREEN,VGA_BLUE}<=ha;
        else if(score_cnt ==2 & row>=0 && row<600 &&col>=0 &&col <=189) {VGA_RED,VGA_GREEN,VGA_BLUE}<=ha;
        else if(score_cnt ==3 & row>=0 && row<600 &&col>=0 &&col <=189) {VGA_RED,VGA_GREEN,VGA_BLUE}<=ha;
        else if(score_cnt ==4 & row>=0 && row<600 &&col>=0 &&col <=189) {VGA_RED,VGA_GREEN,VGA_BLUE}<=ha;
        else if(score_cnt ==5 & row>=150 && row<600 &&col>=650 &&col <=800) {VGA_RED,VGA_GREEN,VGA_BLUE}<=ha1;
        else if(score_cnt ==6 & row>=150 && row<600 &&col>=650 &&col <=800) {VGA_RED,VGA_GREEN,VGA_BLUE}<=ha1;
        else if(score_cnt ==7 & row>=150 && row<600 &&col>=650 &&col <=800) {VGA_RED,VGA_GREEN,VGA_BLUE}<=ha1;
        else if(score_cnt ==8 & row>=150 && row<600 &&col>=650 &&col <=800) {VGA_RED,VGA_GREEN,VGA_BLUE}<={VGA_RED,VGA_GREEN,VGA_BLUE};
        //else if(row>=0 && row<600 &&col>=0 &&col <=610)  {VGA_RED,VGA_GREEN,VGA_BLUE}<=haha;
        else if(row>=0 && row<150 &&col>=650 &&col <=800)  {VGA_RED,VGA_GREEN,VGA_BLUE}<=final;
		else {VGA_RED,VGA_GREEN,VGA_BLUE} <= 3'b111;
	end
	else {VGA_RED,VGA_GREEN,VGA_BLUE} <= 3'b000;
end



endmodule
