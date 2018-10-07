`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:32:25 01/09/2017 
// Design Name: 
// Module Name:    HA7 
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

module FINAL(clk,row,col,final
    );

input clk;
reg flag;
input [10:0]row,col;
output reg [2:0] final;

wire [10:0]sr;
wire [299:0] r_1, r_2,r_3,r_4,r_5,r_6,r_7,r_8,r_9,r_10,r_11,r_12,r_13,r_14,r_15,r_16,r_17,r_18,r_19,r_20;
wire [299:0] r_21,r_22,r_23,r_24,r_25,r_26,r_27,r_28,r_29,r_30,r_31,r_32,r_33,r_34,r_35,r_36,r_37,r_38,r_39,r_40;
wire [299:0] r_41,r_42,r_43,r_44,r_45,r_46,r_47,r_48,r_49,r_50,r_51,r_52,r_53,r_54,r_55,r_56,r_57,r_58,r_59,r_60;
wire [299:0] r_61,r_62,r_63,r_64,r_65,r_66,r_67,r_68,r_69,r_70,r_71,r_72,r_73,r_74,r_75,r_76,r_77,r_78,r_79,r_80;
wire [299:0] r_81,r_82,r_83,r_84,r_85,r_86,r_87,r_88,r_89,r_90,r_91,r_92,r_93,r_94,r_95,r_96,r_97,r_98,r_99,r_100;
wire [299:0] r_101,r_102,r_103,r_104,r_105,r_106;


assign sr = row-60;


assign r_1   = 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_2   = 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_3   = 100'b0000000000000000000000000000000000110000000000000000000000000000000000000000000000000000000000000000 ;
assign r_4   = 100'b0000000000000000000000000000000000110000000000000000000000000000000000000000000000000000000000000000 ;
assign r_5   = 100'b0000000000000000000000000011111111111111111000000000000000000000000000000000000000000000000000000000 ;
assign r_6   = 100'b0000000000000000000000000011111111111111111000000000000000000000000000000000000000000000000000000000 ;
assign r_7   = 100'b0000000000000000000000011111111111111111111111000000000000000000000000000000000000000000000000000000 ;
assign r_8   = 100'b0000000000000000000000011111111111111111111111000000000000000000000000000000000000000000000000000000 ;
assign r_9   = 100'b0000000000000000000011111111111111111111111111110000000000000000000000000000000000000000000000000000 ;
assign r_10  = 100'b0000000000000000000011111111111111111111111111110000000000000000000000000000000000000000000000000000 ;
assign r_11  = 100'b0000000000000000000011111111111111111111111111111111000000000000000000000011111100000000000000000000 ;
assign r_12  = 100'b0000000000000000000011111111111111111111111111111111000000000000000000000011111100000000000000000000 ;
assign r_13  = 100'b0000000000000000000011111111111111111111111111111111111111100000011111111111111100000000000000000000 ;
assign r_14  = 100'b0000000000000000000011111111111111111111111111111111111111100000011111111111111100000000000000000000 ;
assign r_15  = 100'b0000000000000000000011111111111111111111111111111111111111100000011111111111111100000000000000000000 ;
assign r_16  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_17  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_18  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_19  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_20  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_21  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_22  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_23  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_24  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_25  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_26  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_27  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_28  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_29  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_30  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_31  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_32  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_33  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_34  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_35  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_36  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_37  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_38  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_39  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_40  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_41  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_42  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_43  = 100'b0000000000000000000011111111111111111111111111111111111111111111111111111111111100000000000000000000 ;
assign r_44  = 100'b0000000000000000000011111111100000000000111111111111111111111111111111111111111100000000000000000000 ;
assign r_45  = 100'b0000000000000000000011111111100000000000111111111111111111111111111111111111111100000000000000000000 ;
assign r_46  = 100'b0000000000000000000011111000000000000000000011111111111111111111111111111111111100000000000000000000 ;
assign r_47  = 100'b0000000000000000000011111000000000000000000011111111111111111111111111111111111100000000000000000000 ;
assign r_48  = 100'b0000000000000000000011111000000000000000000011111111111111111111111111111111111100000000000000000000 ;
assign r_49  = 100'b0000000000000000000011110000000000000000000000111111111111111111111111111111111100000000000000000000 ;
assign r_50  = 100'b0000000000000000000011110000000000000000000000111111111111111111111111111111111100000000000000000000 ;
assign r_51  = 100'b0000000000000000000011110000000000000000000000000111111111111111111111111111100000000000000000000000 ;
assign r_52  = 100'b0000000000000000000011110000000000000000000000000111111111111111111111111111100000000000000000000000 ;
assign r_53  = 100'b0000000000000000000011110000000000000000000000000000000111111111111111000000000000000000000000000000 ;
assign r_54  = 100'b0000000000000000000011110000000000000000000000000000000111111111111111000000000000000000000000000000 ;
assign r_55  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_56  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_57  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_58  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_59  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_60  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_61  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_62  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_63  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_64  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_65  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_66  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_67  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_68  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_69  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_70  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_71  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_72  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_73  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_74  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_75  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_76  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_77  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_78  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_79  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_80  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_81  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_82  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_83  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_84  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_85  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_86  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_87  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_88  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_89  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_90  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_91  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_92  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_93  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_94  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_95  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_96  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_97  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_98  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_99  = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_100 = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_101 = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_102 = 100'b0000000000000000000011110000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_103 = 100'b0000000000000000000001100000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_104 = 100'b0000000000000000000001100000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_105 = 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 ;
assign r_106 = 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 ;

always@(*)begin
	case(sr)
		0   : flag = r_1  [775-col];
		1   : flag = r_2  [775-col];
		2   : flag = r_3  [775-col];
        3   : flag = r_4  [775-col];
        4   : flag = r_5  [775-col];
        5   : flag = r_6  [775-col];
        6   : flag = r_7  [775-col];
        7   : flag = r_8  [775-col];
        8   : flag = r_9  [775-col];
        9   : flag = r_10 [775-col];
        10  : flag = r_11 [775-col];
        11  : flag = r_12 [775-col];
        12  : flag = r_13 [775-col];
        13  : flag = r_14 [775-col];
        14  : flag = r_15 [775-col];
        15  : flag = r_16 [775-col];
        16  : flag = r_17 [775-col];
        17  : flag = r_18 [775-col];
        18  : flag = r_19 [775-col];
        19  : flag = r_20 [775-col];
        20  : flag = r_21 [775-col];
        21  : flag = r_22 [775-col];
        22  : flag = r_23 [775-col];
        23  : flag = r_24 [775-col];
        24  : flag = r_25 [775-col];
        25  : flag = r_26 [775-col];
        26  : flag = r_27 [775-col];
        27  : flag = r_28 [775-col];
        28  : flag = r_29 [775-col];
        29  : flag = r_30 [775-col];
        30  : flag = r_31 [775-col];
        31  : flag = r_32 [775-col];
        32  : flag = r_33 [775-col];
        33  : flag = r_34 [775-col];
        34  : flag = r_35 [775-col];
        35  : flag = r_36 [775-col];
        36  : flag = r_37 [775-col];
        37  : flag = r_38 [775-col];
        38  : flag = r_39 [775-col];
        39  : flag = r_40 [775-col];
        40  : flag = r_41 [775-col];
        41  : flag = r_42 [775-col];
        42  : flag = r_43 [775-col];
        43  : flag = r_44 [775-col];
        44  : flag = r_45 [775-col];
        45  : flag = r_46 [775-col];
        46  : flag = r_47 [775-col];
        47  : flag = r_48 [775-col];
        48  : flag = r_49 [775-col];
        49  : flag = r_50 [775-col];
        50  : flag = r_51 [775-col];
        51  : flag = r_52 [775-col];
        52  : flag = r_53 [775-col];
        53  : flag = r_54 [775-col];
        54  : flag = r_55 [775-col];
        55  : flag = r_56 [775-col];
        56  : flag = r_57 [775-col];
        57  : flag = r_58 [775-col];
        58  : flag = r_59 [775-col];
        59  : flag = r_60 [775-col];
        60  : flag = r_61 [775-col];
        61  : flag = r_62 [775-col];
        62  : flag = r_63 [775-col];
        63  : flag = r_64 [775-col];
        64  : flag = r_65 [775-col];
        65  : flag = r_66 [775-col];
        66  : flag = r_67 [775-col];
        67  : flag = r_68 [775-col];
        68  : flag = r_69 [775-col];
        69  : flag = r_70 [775-col];
        70  : flag = r_71 [775-col];
        71  : flag = r_72 [775-col];
        72  : flag = r_73 [775-col];
        73  : flag = r_74 [775-col];
        74  : flag = r_75 [775-col];
        75  : flag = r_76 [775-col];
        76  : flag = r_77 [775-col];
        77  : flag = r_78 [775-col];
        78  : flag = r_79 [775-col];
        79  : flag = r_80 [775-col];
        80  : flag = r_81 [775-col];
        81  : flag = r_82 [775-col];
        82  : flag = r_83 [775-col];
        83  : flag = r_84 [775-col];
        84  : flag = r_85 [775-col];
        85  : flag = r_86 [775-col];
        86  : flag = r_87 [775-col];
        87  : flag = r_88 [775-col];
        88  : flag = r_89 [775-col];
        89  : flag = r_90 [775-col];
        90  : flag = r_91 [775-col];
        91  : flag = r_92 [775-col];
        92  : flag = r_93 [775-col];
        93  : flag = r_94 [775-col];
        94  : flag = r_95 [775-col];
        95  : flag = r_96 [775-col];
        96  : flag = r_97 [775-col];
        97  : flag = r_98 [775-col];
        98  : flag = r_99 [775-col];
        99  : flag = r_100[775-col];
        100 : flag = r_101[775-col];
        101 : flag = r_102[775-col];
        102 : flag = r_103[775-col];
        103 : flag = r_104[775-col];
        104 : flag = r_105[775-col];
        105 : flag = r_106[775-col];

	endcase
end

always@(posedge clk)begin
	if(flag)begin
		final <=3'b100;
	end
	else final <= 3'b111;
end
endmodule
                                                                                                    