/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06
// Date      : Mon Sep 29 20:45:40 2025
/////////////////////////////////////////////////////////////


module FSM_1 ( DATA_VALID, ser_done, CLK, RST, PAR_EN, ser_en, BUSY, mux_sel
 );
  output [1:0] mux_sel;
  input DATA_VALID, ser_done, CLK, RST, PAR_EN;
  output ser_en, BUSY;
  wire   BUSY_C, n4, n5, n6, n7, n8, n1, n3, n9;
  wire   [2:0] current_state;
  wire   [2:0] next_state;

  DFFRQX2M \current_state_reg[0]  ( .D(next_state[0]), .CK(CLK), .RN(n1), .Q(
        current_state[0]) );
  DFFRQX2M BUSY_reg ( .D(BUSY_C), .CK(CLK), .RN(n1), .Q(BUSY) );
  DFFRQX2M \current_state_reg[1]  ( .D(next_state[1]), .CK(CLK), .RN(n1), .Q(
        current_state[1]) );
  DFFRQX2M \current_state_reg[2]  ( .D(next_state[2]), .CK(CLK), .RN(n1), .Q(
        current_state[2]) );
  NOR2X4M U3 ( .A(n9), .B(current_state[2]), .Y(mux_sel[1]) );
  NOR2X2M U4 ( .A(n3), .B(current_state[2]), .Y(n8) );
  BUFX2M U5 ( .A(RST), .Y(n1) );
  NAND2X2M U6 ( .A(mux_sel[1]), .B(n6), .Y(n4) );
  NOR2X2M U7 ( .A(ser_done), .B(n4), .Y(ser_en) );
  INVX2M U8 ( .A(n8), .Y(mux_sel[0]) );
  INVX2M U9 ( .A(current_state[1]), .Y(n9) );
  XNOR2X4M U10 ( .A(current_state[0]), .B(current_state[1]), .Y(n6) );
  OAI22X1M U11 ( .A0(ser_done), .A1(mux_sel[0]), .B0(current_state[1]), .B1(n7), .Y(next_state[0]) );
  AOI2B1X1M U12 ( .A1N(current_state[2]), .A0(DATA_VALID), .B0(n8), .Y(n7) );
  OAI21X2M U13 ( .A0(current_state[2]), .A1(n6), .B0(n4), .Y(next_state[1]) );
  OAI21X2M U14 ( .A0(current_state[0]), .A1(n9), .B0(mux_sel[0]), .Y(BUSY_C)
         );
  INVX2M U15 ( .A(current_state[0]), .Y(n3) );
  NOR2BX2M U16 ( .AN(mux_sel[1]), .B(n5), .Y(next_state[2]) );
  AOI2B1X1M U17 ( .A1N(PAR_EN), .A0(ser_done), .B0(n3), .Y(n5) );
endmodule


module SERIALIZER_1 ( CLK, RST, BUSY, DATA_VALID, P_DATA, ser_en, ser_data, 
        ser_done );
  input [7:0] P_DATA;
  input CLK, RST, BUSY, DATA_VALID, ser_en;
  output ser_data, ser_done;
  wire   N23, N24, N25, N27, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14,
         n15, n16, n17, n18, n19, n20, n21, n22, n23, n1, n2, n3, n24, n25,
         n26;
  wire   [7:1] shift_reg;
  wire   [2:0] bit_count;
  assign ser_done = N27;

  NOR2X12M U19 ( .A(n24), .B(n1), .Y(n6) );
  DFFRQX1M \shift_reg_reg[6]  ( .D(n18), .CK(CLK), .RN(n2), .Q(shift_reg[6])
         );
  DFFRQX1M \shift_reg_reg[5]  ( .D(n19), .CK(CLK), .RN(n2), .Q(shift_reg[5])
         );
  DFFRQX1M \shift_reg_reg[4]  ( .D(n20), .CK(CLK), .RN(n2), .Q(shift_reg[4])
         );
  DFFRQX1M \shift_reg_reg[3]  ( .D(n21), .CK(CLK), .RN(n2), .Q(shift_reg[3])
         );
  DFFRQX1M \shift_reg_reg[2]  ( .D(n22), .CK(CLK), .RN(n2), .Q(shift_reg[2])
         );
  DFFRQX1M \shift_reg_reg[1]  ( .D(n23), .CK(CLK), .RN(n2), .Q(shift_reg[1])
         );
  DFFRQX1M \shift_reg_reg[7]  ( .D(n17), .CK(CLK), .RN(n2), .Q(shift_reg[7])
         );
  DFFRQX1M \shift_reg_reg[0]  ( .D(n16), .CK(CLK), .RN(n2), .Q(ser_data) );
  DFFRQX2M \bit_count_reg[1]  ( .D(N24), .CK(CLK), .RN(n2), .Q(bit_count[1])
         );
  DFFRQX2M \bit_count_reg[2]  ( .D(N25), .CK(CLK), .RN(n2), .Q(bit_count[2])
         );
  DFFRQX2M \bit_count_reg[0]  ( .D(N23), .CK(CLK), .RN(n2), .Q(bit_count[0])
         );
  INVX6M U3 ( .A(n3), .Y(n2) );
  INVX2M U4 ( .A(RST), .Y(n3) );
  NOR2X8M U5 ( .A(n1), .B(n6), .Y(n4) );
  INVX2M U6 ( .A(ser_en), .Y(n24) );
  CLKBUFX6M U7 ( .A(n7), .Y(n1) );
  NOR2BX2M U8 ( .AN(DATA_VALID), .B(BUSY), .Y(n7) );
  OAI2BB1X2M U9 ( .A0N(ser_data), .A1N(n4), .B0(n5), .Y(n16) );
  AOI22X1M U10 ( .A0(shift_reg[1]), .A1(n6), .B0(P_DATA[0]), .B1(n1), .Y(n5)
         );
  OAI2BB1X2M U11 ( .A0N(shift_reg[1]), .A1N(n4), .B0(n13), .Y(n23) );
  AOI22X1M U12 ( .A0(shift_reg[2]), .A1(n6), .B0(P_DATA[1]), .B1(n1), .Y(n13)
         );
  OAI2BB1X2M U13 ( .A0N(n4), .A1N(shift_reg[2]), .B0(n12), .Y(n22) );
  AOI22X1M U14 ( .A0(shift_reg[3]), .A1(n6), .B0(P_DATA[2]), .B1(n1), .Y(n12)
         );
  OAI2BB1X2M U15 ( .A0N(n4), .A1N(shift_reg[3]), .B0(n11), .Y(n21) );
  AOI22X1M U16 ( .A0(shift_reg[4]), .A1(n6), .B0(P_DATA[3]), .B1(n1), .Y(n11)
         );
  OAI2BB1X2M U17 ( .A0N(n4), .A1N(shift_reg[4]), .B0(n10), .Y(n20) );
  AOI22X1M U18 ( .A0(shift_reg[5]), .A1(n6), .B0(P_DATA[4]), .B1(n1), .Y(n10)
         );
  OAI2BB1X2M U20 ( .A0N(n4), .A1N(shift_reg[5]), .B0(n9), .Y(n19) );
  AOI22X1M U21 ( .A0(shift_reg[6]), .A1(n6), .B0(P_DATA[5]), .B1(n1), .Y(n9)
         );
  OAI2BB1X2M U22 ( .A0N(n4), .A1N(shift_reg[6]), .B0(n8), .Y(n18) );
  AOI22X1M U23 ( .A0(shift_reg[7]), .A1(n6), .B0(P_DATA[6]), .B1(n1), .Y(n8)
         );
  AO22X1M U24 ( .A0(n4), .A1(shift_reg[7]), .B0(P_DATA[7]), .B1(n1), .Y(n17)
         );
  AND3X2M U25 ( .A(bit_count[0]), .B(bit_count[2]), .C(bit_count[1]), .Y(N27)
         );
  NOR2X2M U26 ( .A(n24), .B(bit_count[0]), .Y(N23) );
  OAI2BB2X1M U27 ( .B0(n14), .B1(n24), .A0N(bit_count[2]), .A1N(N23), .Y(N25)
         );
  AOI32X1M U28 ( .A0(bit_count[0]), .A1(n26), .A2(bit_count[1]), .B0(
        bit_count[2]), .B1(n25), .Y(n14) );
  INVX2M U29 ( .A(bit_count[2]), .Y(n26) );
  NOR2X2M U30 ( .A(n15), .B(n24), .Y(N24) );
  CLKXOR2X2M U31 ( .A(bit_count[0]), .B(n25), .Y(n15) );
  INVX2M U32 ( .A(bit_count[1]), .Y(n25) );
endmodule


module PARITY_CALC_1 ( CLK, RST, P_DATA, DATA_VALID, PAR_TYP, PAR_EN, BUSY, 
        par_bit );
  input [7:0] P_DATA;
  input CLK, RST, DATA_VALID, PAR_TYP, PAR_EN, BUSY;
  output par_bit;
  wire   n1, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n2,
         n17, n18, n19;
  wire   [7:0] DATA;

  DFFRQX1M par_bit_reg ( .D(n8), .CK(CLK), .RN(n17), .Q(par_bit) );
  DFFRQX1M \DATA_reg[5]  ( .D(n14), .CK(CLK), .RN(n17), .Q(DATA[5]) );
  DFFRQX1M \DATA_reg[1]  ( .D(n10), .CK(CLK), .RN(n17), .Q(DATA[1]) );
  DFFRQX1M \DATA_reg[4]  ( .D(n13), .CK(CLK), .RN(n17), .Q(DATA[4]) );
  DFFRQX1M \DATA_reg[0]  ( .D(n9), .CK(CLK), .RN(n17), .Q(DATA[0]) );
  DFFRQX1M \DATA_reg[2]  ( .D(n11), .CK(CLK), .RN(n17), .Q(DATA[2]) );
  DFFRQX1M \DATA_reg[7]  ( .D(n16), .CK(CLK), .RN(n17), .Q(DATA[7]) );
  DFFRQX1M \DATA_reg[3]  ( .D(n12), .CK(CLK), .RN(n17), .Q(DATA[3]) );
  DFFRQX1M \DATA_reg[6]  ( .D(n15), .CK(CLK), .RN(n17), .Q(DATA[6]) );
  INVX6M U2 ( .A(n18), .Y(n17) );
  INVX2M U3 ( .A(RST), .Y(n18) );
  CLKBUFX8M U4 ( .A(n7), .Y(n2) );
  NOR2BX2M U5 ( .AN(DATA_VALID), .B(BUSY), .Y(n7) );
  AO2B2X2M U6 ( .B0(P_DATA[0]), .B1(n2), .A0(DATA[0]), .A1N(n2), .Y(n9) );
  AO2B2X2M U7 ( .B0(P_DATA[1]), .B1(n2), .A0(DATA[1]), .A1N(n2), .Y(n10) );
  AO2B2X2M U8 ( .B0(P_DATA[2]), .B1(n2), .A0(DATA[2]), .A1N(n2), .Y(n11) );
  AO2B2X2M U9 ( .B0(P_DATA[3]), .B1(n2), .A0(DATA[3]), .A1N(n2), .Y(n12) );
  AO2B2X2M U10 ( .B0(P_DATA[4]), .B1(n2), .A0(DATA[4]), .A1N(n2), .Y(n13) );
  AO2B2X2M U11 ( .B0(P_DATA[5]), .B1(n2), .A0(DATA[5]), .A1N(n2), .Y(n14) );
  AO2B2X2M U12 ( .B0(P_DATA[6]), .B1(n2), .A0(DATA[6]), .A1N(n2), .Y(n15) );
  AO2B2X2M U13 ( .B0(P_DATA[7]), .B1(n2), .A0(DATA[7]), .A1N(n2), .Y(n16) );
  XNOR2X2M U14 ( .A(DATA[2]), .B(DATA[3]), .Y(n5) );
  OAI2BB2X1M U15 ( .B0(n1), .B1(n19), .A0N(par_bit), .A1N(n19), .Y(n8) );
  INVX2M U16 ( .A(PAR_EN), .Y(n19) );
  XOR3XLM U17 ( .A(n3), .B(PAR_TYP), .C(n4), .Y(n1) );
  XOR3XLM U18 ( .A(DATA[1]), .B(DATA[0]), .C(n5), .Y(n4) );
  XOR3XLM U19 ( .A(DATA[5]), .B(DATA[4]), .C(n6), .Y(n3) );
  CLKXOR2X2M U20 ( .A(DATA[7]), .B(DATA[6]), .Y(n6) );
endmodule


module MUX_1 ( mux_sel, ser_data, CLK, RST, par_bit, TX_OUT );
  input [1:0] mux_sel;
  input ser_data, CLK, RST, par_bit;
  output TX_OUT;
  wire   N13, n2, n3, n1;

  DFFSQX2M TX_OUT_reg ( .D(N13), .CK(CLK), .SN(RST), .Q(TX_OUT) );
  OAI21X2M U3 ( .A0(n2), .A1(n1), .B0(n3), .Y(N13) );
  NAND3X2M U4 ( .A(mux_sel[1]), .B(n1), .C(ser_data), .Y(n3) );
  NOR2BX2M U5 ( .AN(mux_sel[1]), .B(par_bit), .Y(n2) );
  INVX2M U6 ( .A(mux_sel[0]), .Y(n1) );
endmodule


module UART_TX_1 ( CLK_tb, RST_tb, P_DATA_tb, DATA_VALID_tb, PAR_EN_tb, 
        PAR_TYP_tb, TX_OUT_tb, BUSY_tb );
  input [7:0] P_DATA_tb;
  input CLK_tb, RST_tb, DATA_VALID_tb, PAR_EN_tb, PAR_TYP_tb;
  output TX_OUT_tb, BUSY_tb;
  wire   ser_done_tb, ser_en_tb, ser_data_tb, par_bit_tb, n1, n2;
  wire   [1:0] mux_sel_tb;

  FSM_1 FSM_1_tb ( .DATA_VALID(DATA_VALID_tb), .ser_done(ser_done_tb), .CLK(
        CLK_tb), .RST(n1), .PAR_EN(PAR_EN_tb), .ser_en(ser_en_tb), .BUSY(
        BUSY_tb), .mux_sel(mux_sel_tb) );
  SERIALIZER_1 SERIALIZER_1_tb ( .CLK(CLK_tb), .RST(n1), .BUSY(BUSY_tb), 
        .DATA_VALID(DATA_VALID_tb), .P_DATA(P_DATA_tb), .ser_en(ser_en_tb), 
        .ser_data(ser_data_tb), .ser_done(ser_done_tb) );
  PARITY_CALC_1 PARITY_CALC_1_tb ( .CLK(CLK_tb), .RST(n1), .P_DATA(P_DATA_tb), 
        .DATA_VALID(DATA_VALID_tb), .PAR_TYP(PAR_TYP_tb), .PAR_EN(PAR_EN_tb), 
        .BUSY(BUSY_tb), .par_bit(par_bit_tb) );
  MUX_1 MUX_1_tb ( .mux_sel(mux_sel_tb), .ser_data(ser_data_tb), .CLK(CLK_tb), 
        .RST(n1), .par_bit(par_bit_tb), .TX_OUT(TX_OUT_tb) );
  INVX2M U1 ( .A(n2), .Y(n1) );
  INVX2M U2 ( .A(RST_tb), .Y(n2) );
endmodule


module uart_rx_fsm ( CLK, RST, S_DATA, Prescale, parity_enable, bit_count, 
        edge_count, par_err, stp_err, strt_glitch, strt_chk_en, edge_bit_en, 
        deser_en, par_chk_en, stp_chk_en, dat_samp_en, data_valid );
  input [5:0] Prescale;
  input [3:0] bit_count;
  input [5:0] edge_count;
  input CLK, RST, S_DATA, parity_enable, par_err, stp_err, strt_glitch;
  output strt_chk_en, edge_bit_en, deser_en, par_chk_en, stp_chk_en,
         dat_samp_en, data_valid;
  wire   n47, \sub_40/carry[5] , \sub_40/carry[4] , \sub_40/carry[3] , n2, n3,
         n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18,
         n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32,
         n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46;
  wire   [5:0] check_edge;
  wire   [5:0] error_check_edge;
  wire   [2:0] current_state;
  wire   [2:0] next_state;
  assign error_check_edge[0] = Prescale[0];

  DFFRX4M \current_state_reg[0]  ( .D(next_state[0]), .CK(CLK), .RN(RST), .Q(
        current_state[0]) );
  DFFRX4M \current_state_reg[1]  ( .D(next_state[1]), .CK(CLK), .RN(RST), .Q(
        current_state[1]), .QN(n36) );
  DFFRX4M \current_state_reg[2]  ( .D(next_state[2]), .CK(CLK), .RN(RST), .Q(
        current_state[2]), .QN(n30) );
  AOI31X2M U3 ( .A0(current_state[0]), .A1(n13), .A2(n16), .B0(
        current_state[1]), .Y(n15) );
  OAI21X4M U4 ( .A0(current_state[0]), .A1(n37), .B0(n30), .Y(n7) );
  NOR3X2M U5 ( .A(n21), .B(stp_err), .C(par_err), .Y(data_valid) );
  NOR3X2M U6 ( .A(bit_count[0]), .B(strt_glitch), .C(bit_count[3]), .Y(n16) );
  NOR2X2M U7 ( .A(bit_count[2]), .B(bit_count[1]), .Y(n41) );
  NOR3BX2M U8 ( .AN(current_state[0]), .B(n36), .C(current_state[2]), .Y(n47)
         );
  NOR2X2M U9 ( .A(n36), .B(current_state[0]), .Y(n14) );
  NAND2X3M U10 ( .A(n36), .B(n7), .Y(dat_samp_en) );
  NAND2XLM U11 ( .A(n36), .B(n30), .Y(n18) );
  NOR2X4M U12 ( .A(n2), .B(Prescale[2]), .Y(n3) );
  NOR2X4M U13 ( .A(n30), .B(n8), .Y(stp_chk_en) );
  NOR2X2M U14 ( .A(current_state[1]), .B(n7), .Y(strt_chk_en) );
  BUFX2M U15 ( .A(n47), .Y(deser_en) );
  AOI2BB2X1M U16 ( .B0(deser_en), .B1(n11), .A0N(n21), .A1N(S_DATA), .Y(n20)
         );
  INVX2M U17 ( .A(bit_count[0]), .Y(n22) );
  NAND2X2M U18 ( .A(n7), .B(n8), .Y(edge_bit_en) );
  CLKINVX2M U19 ( .A(n14), .Y(n8) );
  NOR3X2M U20 ( .A(n27), .B(n28), .C(n29), .Y(n26) );
  NAND3BXLM U21 ( .AN(bit_count[2]), .B(bit_count[3]), .C(stp_chk_en), .Y(n27)
         );
  NAND3BXLM U22 ( .AN(stp_chk_en), .B(n9), .C(n10), .Y(next_state[2]) );
  NAND3BXLM U23 ( .AN(n11), .B(deser_en), .C(n12), .Y(n10) );
  AND4X2M U24 ( .A(n39), .B(n40), .C(n41), .D(n42), .Y(n13) );
  NAND2XLM U25 ( .A(bit_count[1]), .B(n22), .Y(n35) );
  NOR3X2M U26 ( .A(n31), .B(n32), .C(n33), .Y(n25) );
  NAND2BX2M U27 ( .AN(Prescale[1]), .B(check_edge[0]), .Y(n2) );
  INVX2M U28 ( .A(error_check_edge[0]), .Y(check_edge[0]) );
  INVX2M U29 ( .A(Prescale[3]), .Y(n6) );
  INVX2M U30 ( .A(Prescale[1]), .Y(error_check_edge[1]) );
  XNOR2X1M U31 ( .A(Prescale[5]), .B(\sub_40/carry[5] ), .Y(
        error_check_edge[5]) );
  OR2X1M U32 ( .A(Prescale[4]), .B(\sub_40/carry[4] ), .Y(\sub_40/carry[5] )
         );
  XNOR2X1M U33 ( .A(\sub_40/carry[4] ), .B(Prescale[4]), .Y(
        error_check_edge[4]) );
  OR2X1M U34 ( .A(Prescale[3]), .B(\sub_40/carry[3] ), .Y(\sub_40/carry[4] )
         );
  XNOR2X1M U35 ( .A(\sub_40/carry[3] ), .B(Prescale[3]), .Y(
        error_check_edge[3]) );
  OR2X1M U36 ( .A(Prescale[2]), .B(Prescale[1]), .Y(\sub_40/carry[3] ) );
  XNOR2X1M U37 ( .A(Prescale[1]), .B(Prescale[2]), .Y(error_check_edge[2]) );
  OAI2BB1X1M U38 ( .A0N(error_check_edge[0]), .A1N(Prescale[1]), .B0(n2), .Y(
        check_edge[1]) );
  AO21XLM U39 ( .A0(n2), .A1(Prescale[2]), .B0(n3), .Y(check_edge[2]) );
  CLKNAND2X2M U40 ( .A(n3), .B(n6), .Y(n4) );
  OAI21X1M U41 ( .A0(n3), .A1(n6), .B0(n4), .Y(check_edge[3]) );
  XNOR2X1M U42 ( .A(Prescale[4]), .B(n4), .Y(check_edge[4]) );
  NOR2X1M U43 ( .A(Prescale[4]), .B(n4), .Y(n5) );
  CLKXOR2X2M U44 ( .A(Prescale[5]), .B(n5), .Y(check_edge[5]) );
  NOR2X1M U45 ( .A(current_state[2]), .B(n8), .Y(par_chk_en) );
  CLKINVX1M U46 ( .A(parity_enable), .Y(n12) );
  NAND4X1M U47 ( .A(bit_count[3]), .B(bit_count[0]), .C(n13), .D(n14), .Y(n9)
         );
  OAI21X1M U48 ( .A0(current_state[2]), .A1(n15), .B0(n8), .Y(next_state[1])
         );
  OAI211X1M U49 ( .A0(n17), .A1(n18), .B0(n19), .C0(n20), .Y(next_state[0]) );
  NAND3X1M U50 ( .A(n13), .B(n22), .C(bit_count[3]), .Y(n11) );
  NAND4X1M U51 ( .A(n23), .B(n24), .C(n25), .D(n26), .Y(n19) );
  CLKXOR2X2M U52 ( .A(error_check_edge[5]), .B(edge_count[5]), .Y(n29) );
  CLKXOR2X2M U53 ( .A(error_check_edge[4]), .B(edge_count[4]), .Y(n28) );
  CLKXOR2X2M U54 ( .A(error_check_edge[1]), .B(edge_count[1]), .Y(n33) );
  CLKXOR2X2M U55 ( .A(error_check_edge[0]), .B(edge_count[0]), .Y(n32) );
  CLKXOR2X2M U56 ( .A(error_check_edge[2]), .B(edge_count[2]), .Y(n31) );
  XNOR2X1M U57 ( .A(edge_count[3]), .B(error_check_edge[3]), .Y(n24) );
  MXI2X1M U58 ( .A(n34), .B(n35), .S0(parity_enable), .Y(n23) );
  OR2X1M U59 ( .A(bit_count[1]), .B(n22), .Y(n34) );
  MXI2X1M U60 ( .A(n37), .B(n38), .S0(current_state[0]), .Y(n17) );
  NAND4BX1M U61 ( .AN(bit_count[3]), .B(strt_glitch), .C(n13), .D(n22), .Y(n38) );
  NOR4X1M U62 ( .A(n43), .B(n44), .C(n45), .D(n46), .Y(n42) );
  CLKXOR2X2M U63 ( .A(edge_count[3]), .B(check_edge[3]), .Y(n46) );
  CLKXOR2X2M U64 ( .A(edge_count[2]), .B(check_edge[2]), .Y(n45) );
  CLKXOR2X2M U65 ( .A(edge_count[5]), .B(check_edge[5]), .Y(n44) );
  CLKXOR2X2M U66 ( .A(edge_count[1]), .B(check_edge[1]), .Y(n43) );
  XNOR2X1M U67 ( .A(edge_count[4]), .B(check_edge[4]), .Y(n40) );
  XNOR2X1M U68 ( .A(edge_count[0]), .B(check_edge[0]), .Y(n39) );
  NAND3X1M U69 ( .A(current_state[2]), .B(current_state[1]), .C(
        current_state[0]), .Y(n21) );
  CLKINVX1M U70 ( .A(S_DATA), .Y(n37) );
endmodule


module edge_bit_counter ( CLK, RST, Enable, Prescale, bit_count, edge_count );
  input [5:0] Prescale;
  output [3:0] bit_count;
  output [5:0] edge_count;
  input CLK, RST, Enable;
  wire   n40, n41, N8, N9, N10, N11, N19, N20, N21, N22, N23, N24, N25, N26,
         N27, N28, N29, N30, N31, n4, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, \add_31/carry[5] , \add_31/carry[4] ,
         \add_31/carry[3] , \add_31/carry[2] , n1, n3, n6, n7, n8, n21, n22,
         n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36,
         n37, n38, n39;

  DFFRX4M \bit_count_reg[3]  ( .D(n17), .CK(CLK), .RN(n7), .Q(bit_count[3]), 
        .QN(n4) );
  DFFRQX1M \edge_count_reg[0]  ( .D(N19), .CK(CLK), .RN(n7), .Q(n41) );
  DFFRQX1M \edge_count_reg[1]  ( .D(N20), .CK(CLK), .RN(n7), .Q(n40) );
  DFFRX4M \edge_count_reg[5]  ( .D(N24), .CK(CLK), .RN(n7), .Q(edge_count[5])
         );
  DFFRX4M \edge_count_reg[2]  ( .D(N21), .CK(CLK), .RN(n7), .Q(edge_count[2])
         );
  DFFRX4M \edge_count_reg[3]  ( .D(N22), .CK(CLK), .RN(n7), .Q(edge_count[3])
         );
  DFFRX4M \edge_count_reg[4]  ( .D(N23), .CK(CLK), .RN(n7), .Q(edge_count[4])
         );
  DFFRX4M \bit_count_reg[0]  ( .D(n20), .CK(CLK), .RN(n7), .Q(bit_count[0]), 
        .QN(n36) );
  DFFRX4M \bit_count_reg[1]  ( .D(n19), .CK(CLK), .RN(n7), .Q(bit_count[1]), 
        .QN(n37) );
  DFFRX4M \bit_count_reg[2]  ( .D(n18), .CK(CLK), .RN(n7), .Q(bit_count[2]), 
        .QN(n38) );
  NAND2X1M U3 ( .A(bit_count[1]), .B(bit_count[0]), .Y(n10) );
  INVXLM U4 ( .A(n40), .Y(n1) );
  INVX6M U5 ( .A(n1), .Y(edge_count[1]) );
  INVXLM U6 ( .A(n41), .Y(n3) );
  INVX6M U7 ( .A(n3), .Y(edge_count[0]) );
  NOR2X4M U8 ( .A(n21), .B(Prescale[2]), .Y(n22) );
  NOR4X4M U9 ( .A(n34), .B(n33), .C(n32), .D(n31), .Y(N31) );
  NOR2BX2M U10 ( .AN(N25), .B(edge_count[0]), .Y(n27) );
  NOR2BX2M U11 ( .AN(edge_count[0]), .B(N25), .Y(n26) );
  NAND3X1M U12 ( .A(bit_count[0]), .B(n35), .C(Enable), .Y(n14) );
  NAND2BX2M U13 ( .AN(Prescale[1]), .B(N25), .Y(n21) );
  INVX6M U14 ( .A(n8), .Y(n7) );
  INVX2M U15 ( .A(RST), .Y(n8) );
  INVX4M U16 ( .A(n13), .Y(n35) );
  CLKINVX2M U17 ( .A(Enable), .Y(n39) );
  NOR2X4M U18 ( .A(n39), .B(N31), .Y(n13) );
  AOI21X2M U19 ( .A0(n36), .A1(Enable), .B0(n13), .Y(n16) );
  NOR2BX2M U20 ( .AN(N8), .B(n35), .Y(N20) );
  NOR2BX2M U21 ( .AN(N9), .B(n35), .Y(N21) );
  NOR2BX2M U22 ( .AN(N10), .B(n35), .Y(N22) );
  NOR2BX2M U23 ( .AN(N11), .B(n35), .Y(N23) );
  OAI32X2M U24 ( .A0(n39), .A1(bit_count[0]), .A2(n13), .B0(n36), .B1(n35), 
        .Y(n20) );
  OAI32X2M U25 ( .A0(n14), .A1(bit_count[2]), .A2(n37), .B0(n15), .B1(n38), 
        .Y(n18) );
  AOI21BX2M U26 ( .A0(Enable), .A1(n37), .B0N(n16), .Y(n15) );
  OAI22X1M U27 ( .A0(n16), .A1(n37), .B0(bit_count[1]), .B1(n14), .Y(n19) );
  NOR2X2M U28 ( .A(n6), .B(n35), .Y(N24) );
  XNOR2X2M U29 ( .A(\add_31/carry[5] ), .B(edge_count[5]), .Y(n6) );
  NOR2X2M U30 ( .A(edge_count[0]), .B(n35), .Y(N19) );
  OAI32X2M U31 ( .A0(n9), .A1(n10), .A2(n39), .B0(n11), .B1(n4), .Y(n17) );
  NAND3XLM U32 ( .A(N31), .B(n4), .C(bit_count[2]), .Y(n9) );
  NOR2X2M U33 ( .A(n12), .B(n13), .Y(n11) );
  AOI2BB1X2M U34 ( .A0N(n10), .A1N(n38), .B0(n39), .Y(n12) );
  ADDHX1M U35 ( .A(edge_count[1]), .B(edge_count[0]), .CO(\add_31/carry[2] ), 
        .S(N8) );
  ADDHX1M U36 ( .A(edge_count[2]), .B(\add_31/carry[2] ), .CO(
        \add_31/carry[3] ), .S(N9) );
  ADDHX1M U37 ( .A(edge_count[3]), .B(\add_31/carry[3] ), .CO(
        \add_31/carry[4] ), .S(N10) );
  ADDHX1M U38 ( .A(edge_count[4]), .B(\add_31/carry[4] ), .CO(
        \add_31/carry[5] ), .S(N11) );
  INVX2M U39 ( .A(Prescale[0]), .Y(N25) );
  INVX2M U40 ( .A(Prescale[3]), .Y(n25) );
  OAI2BB1X1M U41 ( .A0N(Prescale[0]), .A1N(Prescale[1]), .B0(n21), .Y(N26) );
  AO21XLM U42 ( .A0(n21), .A1(Prescale[2]), .B0(n22), .Y(N27) );
  CLKNAND2X2M U43 ( .A(n22), .B(n25), .Y(n23) );
  OAI21X1M U44 ( .A0(n22), .A1(n25), .B0(n23), .Y(N28) );
  XNOR2X1M U45 ( .A(Prescale[4]), .B(n23), .Y(N29) );
  NOR2X1M U46 ( .A(Prescale[4]), .B(n23), .Y(n24) );
  CLKXOR2X2M U47 ( .A(Prescale[5]), .B(n24), .Y(N30) );
  OAI2B2X1M U48 ( .A1N(N26), .A0(n26), .B0(edge_count[1]), .B1(n26), .Y(n30)
         );
  OAI2B2X1M U49 ( .A1N(edge_count[1]), .A0(n27), .B0(N26), .B1(n27), .Y(n29)
         );
  XNOR2X1M U50 ( .A(N30), .B(edge_count[5]), .Y(n28) );
  NAND3X1M U51 ( .A(n30), .B(n29), .C(n28), .Y(n34) );
  CLKXOR2X2M U52 ( .A(N29), .B(edge_count[4]), .Y(n33) );
  CLKXOR2X2M U53 ( .A(N27), .B(edge_count[2]), .Y(n32) );
  CLKXOR2X2M U54 ( .A(N28), .B(edge_count[3]), .Y(n31) );
endmodule


module data_sampling ( CLK, RST, S_DATA, Prescale, edge_count, Enable, 
        sampled_bit );
  input [5:0] Prescale;
  input [5:0] edge_count;
  input CLK, RST, S_DATA, Enable;
  output sampled_bit;
  wire   N58, n19, n20, n21, \add_21/carry[4] , \add_21/carry[3] ,
         \add_21/carry[2] , n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n22, n23, n24, n25, n26, n27, n28, n29,
         n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41;
  wire   [4:0] half_edges;
  wire   [4:0] half_edges_p1;
  wire   [4:0] half_edges_n1;
  wire   [2:0] Samples;

  DFFRX1M \Samples_reg[2]  ( .D(n21), .CK(CLK), .RN(n1), .Q(Samples[2]) );
  DFFRX4M sampled_bit_reg ( .D(N58), .CK(CLK), .RN(n1), .Q(sampled_bit) );
  DFFRX4M \Samples_reg[0]  ( .D(n19), .CK(CLK), .RN(n1), .Q(Samples[0]) );
  DFFRX4M \Samples_reg[1]  ( .D(n20), .CK(CLK), .RN(n1), .Q(Samples[1]) );
  INVX2M U3 ( .A(Prescale[1]), .Y(half_edges[0]) );
  OAI21X2M U4 ( .A0(Samples[0]), .A1(Samples[1]), .B0(Samples[2]), .Y(n41) );
  NAND2XLM U5 ( .A(Samples[0]), .B(Samples[1]), .Y(n40) );
  AND4X2M U6 ( .A(n34), .B(n35), .C(n36), .D(n37), .Y(n17) );
  NOR4X2M U7 ( .A(n13), .B(n14), .C(n15), .D(n16), .Y(n12) );
  NOR2X4M U8 ( .A(half_edges[1]), .B(half_edges[0]), .Y(n6) );
  AO21X2M U9 ( .A0(Prescale[1]), .A1(Prescale[2]), .B0(n2), .Y(half_edges[1])
         );
  OAI21X4M U10 ( .A0(n2), .A1(n5), .B0(n3), .Y(half_edges[2]) );
  NOR2X4M U11 ( .A(Prescale[2]), .B(Prescale[1]), .Y(n2) );
  XNOR2X8M U12 ( .A(Prescale[4]), .B(n3), .Y(half_edges[3]) );
  NAND2X2M U13 ( .A(n2), .B(n5), .Y(n3) );
  NAND2XLM U14 ( .A(Samples[0]), .B(Enable), .Y(n33) );
  NAND2XLM U15 ( .A(Samples[1]), .B(Enable), .Y(n26) );
  XOR2X1M U16 ( .A(half_edges[1]), .B(edge_count[1]), .Y(n32) );
  NAND2XLM U17 ( .A(Samples[2]), .B(Enable), .Y(n10) );
  NOR3X2M U18 ( .A(n38), .B(edge_count[5]), .C(n39), .Y(n37) );
  BUFX2M U19 ( .A(RST), .Y(n1) );
  CLKINVX1M U20 ( .A(half_edges[2]), .Y(n9) );
  ADDHX1M U21 ( .A(half_edges[2]), .B(\add_21/carry[2] ), .CO(
        \add_21/carry[3] ), .S(half_edges_p1[2]) );
  ADDHX1M U22 ( .A(half_edges[3]), .B(\add_21/carry[3] ), .CO(
        \add_21/carry[4] ), .S(half_edges_p1[3]) );
  ADDHX1M U23 ( .A(half_edges[1]), .B(half_edges[0]), .CO(\add_21/carry[2] ), 
        .S(half_edges_p1[1]) );
  INVX2M U24 ( .A(Prescale[3]), .Y(n5) );
  NOR2X1M U25 ( .A(Prescale[4]), .B(n3), .Y(n4) );
  CLKXOR2X2M U26 ( .A(Prescale[5]), .B(n4), .Y(half_edges[4]) );
  CLKXOR2X2M U27 ( .A(\add_21/carry[4] ), .B(half_edges[4]), .Y(
        half_edges_p1[4]) );
  AO21XLM U28 ( .A0(half_edges[0]), .A1(half_edges[1]), .B0(n6), .Y(
        half_edges_n1[1]) );
  CLKNAND2X2M U29 ( .A(n6), .B(n9), .Y(n7) );
  OAI21X1M U30 ( .A0(n6), .A1(n9), .B0(n7), .Y(half_edges_n1[2]) );
  XNOR2X1M U31 ( .A(half_edges[3]), .B(n7), .Y(half_edges_n1[3]) );
  NOR2X1M U32 ( .A(half_edges[3]), .B(n7), .Y(n8) );
  CLKXOR2X2M U33 ( .A(half_edges[4]), .B(n8), .Y(half_edges_n1[4]) );
  MXI2X1M U34 ( .A(n10), .B(n11), .S0(n12), .Y(n21) );
  CLKXOR2X2M U35 ( .A(Prescale[1]), .B(edge_count[0]), .Y(n16) );
  OR2X1M U36 ( .A(edge_count[5]), .B(n17), .Y(n14) );
  NAND4X1M U37 ( .A(n18), .B(n22), .C(n23), .D(n24), .Y(n13) );
  XNOR2X1M U38 ( .A(edge_count[1]), .B(half_edges_p1[1]), .Y(n24) );
  XNOR2X1M U39 ( .A(edge_count[2]), .B(half_edges_p1[2]), .Y(n23) );
  XNOR2X1M U40 ( .A(edge_count[3]), .B(half_edges_p1[3]), .Y(n22) );
  CLKXOR2X2M U41 ( .A(n25), .B(half_edges_p1[4]), .Y(n18) );
  MXI2X1M U42 ( .A(n26), .B(n11), .S0(n15), .Y(n20) );
  AND4X1M U43 ( .A(n27), .B(n28), .C(n29), .D(n30), .Y(n15) );
  NOR4X1M U44 ( .A(edge_count[5]), .B(n17), .C(n31), .D(n32), .Y(n30) );
  CLKXOR2X2M U45 ( .A(half_edges[0]), .B(edge_count[0]), .Y(n31) );
  XNOR2X1M U46 ( .A(edge_count[3]), .B(half_edges[3]), .Y(n29) );
  CLKXOR2X2M U47 ( .A(n25), .B(half_edges[4]), .Y(n28) );
  CLKINVX1M U48 ( .A(edge_count[4]), .Y(n25) );
  XNOR2X1M U49 ( .A(edge_count[2]), .B(half_edges[2]), .Y(n27) );
  MXI2X1M U50 ( .A(n33), .B(n11), .S0(n17), .Y(n19) );
  CLKXOR2X2M U51 ( .A(Prescale[1]), .B(edge_count[0]), .Y(n39) );
  CLKXOR2X2M U52 ( .A(half_edges_n1[4]), .B(edge_count[4]), .Y(n38) );
  XNOR2X1M U53 ( .A(edge_count[2]), .B(half_edges_n1[2]), .Y(n36) );
  XNOR2X1M U54 ( .A(edge_count[3]), .B(half_edges_n1[3]), .Y(n35) );
  XNOR2X1M U55 ( .A(edge_count[1]), .B(half_edges_n1[1]), .Y(n34) );
  CLKNAND2X2M U56 ( .A(S_DATA), .B(Enable), .Y(n11) );
  AOI21BX1M U57 ( .A0(n40), .A1(n41), .B0N(Enable), .Y(N58) );
endmodule


module deserializer ( CLK, RST, sampled_bit, Enable, edge_count, Prescale, 
        P_DATA );
  input [5:0] edge_count;
  input [5:0] Prescale;
  output [7:0] P_DATA;
  input CLK, RST, sampled_bit, Enable;
  wire   N1, N2, N3, N4, N5, N6, N7, n1, n10, n11, n12, n13, n14, n15, n16,
         n17, n2, n3, n4, n5, n6, n7, n8, n9, n18, n19, n20, n21, n22, n23,
         n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34;

  DFFRX1M \P_DATA_reg[6]  ( .D(n16), .CK(CLK), .RN(n3), .Q(P_DATA[6]), .QN(n28) );
  DFFRX1M \P_DATA_reg[5]  ( .D(n15), .CK(CLK), .RN(n3), .Q(P_DATA[5]), .QN(n29) );
  DFFRX1M \P_DATA_reg[4]  ( .D(n14), .CK(CLK), .RN(n3), .Q(P_DATA[4]), .QN(n30) );
  DFFRX1M \P_DATA_reg[3]  ( .D(n13), .CK(CLK), .RN(n3), .Q(P_DATA[3]), .QN(n31) );
  DFFRX1M \P_DATA_reg[2]  ( .D(n12), .CK(CLK), .RN(n3), .Q(P_DATA[2]), .QN(n32) );
  DFFRX1M \P_DATA_reg[1]  ( .D(n11), .CK(CLK), .RN(n3), .Q(P_DATA[1]), .QN(n33) );
  DFFRX1M \P_DATA_reg[7]  ( .D(n17), .CK(CLK), .RN(n3), .Q(P_DATA[7]), .QN(n27) );
  DFFRX4M \P_DATA_reg[0]  ( .D(n10), .CK(CLK), .RN(n3), .Q(P_DATA[0]) );
  NOR2X4M U3 ( .A(n5), .B(Prescale[2]), .Y(n6) );
  NOR2BX2M U4 ( .AN(edge_count[0]), .B(N1), .Y(n18) );
  NOR2BX2M U5 ( .AN(N1), .B(edge_count[0]), .Y(n19) );
  NAND2BX2M U6 ( .AN(Prescale[1]), .B(N1), .Y(n5) );
  INVX4M U7 ( .A(n4), .Y(n3) );
  INVX2M U8 ( .A(RST), .Y(n4) );
  INVX4M U9 ( .A(n2), .Y(n34) );
  OAI22X1M U10 ( .A0(n34), .A1(n33), .B0(n2), .B1(n32), .Y(n11) );
  OAI22X1M U11 ( .A0(n34), .A1(n32), .B0(n2), .B1(n31), .Y(n12) );
  OAI22X1M U12 ( .A0(n34), .A1(n31), .B0(n2), .B1(n30), .Y(n13) );
  OAI22X1M U13 ( .A0(n34), .A1(n30), .B0(n2), .B1(n29), .Y(n14) );
  OAI22X1M U14 ( .A0(n34), .A1(n29), .B0(n2), .B1(n28), .Y(n15) );
  OAI22X1M U15 ( .A0(n34), .A1(n28), .B0(n2), .B1(n27), .Y(n16) );
  OAI2BB2X1M U16 ( .B0(n34), .B1(n27), .A0N(sampled_bit), .A1N(n34), .Y(n17)
         );
  OAI2BB2X1M U17 ( .B0(n2), .B1(n33), .A0N(P_DATA[0]), .A1N(n2), .Y(n10) );
  CLKBUFX6M U18 ( .A(n1), .Y(n2) );
  NAND2XLM U19 ( .A(N7), .B(Enable), .Y(n1) );
  INVX2M U20 ( .A(Prescale[0]), .Y(N1) );
  INVX2M U21 ( .A(Prescale[3]), .Y(n9) );
  OAI2BB1X1M U22 ( .A0N(Prescale[0]), .A1N(Prescale[1]), .B0(n5), .Y(N2) );
  AO21XLM U23 ( .A0(n5), .A1(Prescale[2]), .B0(n6), .Y(N3) );
  CLKNAND2X2M U24 ( .A(n6), .B(n9), .Y(n7) );
  OAI21X1M U25 ( .A0(n6), .A1(n9), .B0(n7), .Y(N4) );
  XNOR2X1M U26 ( .A(Prescale[4]), .B(n7), .Y(N5) );
  NOR2X1M U27 ( .A(Prescale[4]), .B(n7), .Y(n8) );
  CLKXOR2X2M U28 ( .A(Prescale[5]), .B(n8), .Y(N6) );
  OAI2B2X1M U29 ( .A1N(N2), .A0(n18), .B0(edge_count[1]), .B1(n18), .Y(n22) );
  OAI2B2X1M U30 ( .A1N(edge_count[1]), .A0(n19), .B0(N2), .B1(n19), .Y(n21) );
  XNOR2X1M U31 ( .A(N6), .B(edge_count[5]), .Y(n20) );
  NAND3X1M U32 ( .A(n22), .B(n21), .C(n20), .Y(n26) );
  CLKXOR2X2M U33 ( .A(N5), .B(edge_count[4]), .Y(n25) );
  CLKXOR2X2M U34 ( .A(N3), .B(edge_count[2]), .Y(n24) );
  CLKXOR2X2M U35 ( .A(N4), .B(edge_count[3]), .Y(n23) );
  NOR4X1M U36 ( .A(n26), .B(n25), .C(n24), .D(n23), .Y(N7) );
endmodule


module strt_chk ( CLK, RST, sampled_bit, Enable, strt_glitch );
  input CLK, RST, sampled_bit, Enable;
  output strt_glitch;
  wire   n1;

  DFFRX4M strt_glitch_reg ( .D(n1), .CK(CLK), .RN(RST), .Q(strt_glitch) );
  AO2B2XLM U2 ( .B0(sampled_bit), .B1(Enable), .A0(strt_glitch), .A1N(Enable), 
        .Y(n1) );
endmodule


module par_chk ( CLK, RST, parity_type, sampled_bit, Enable, P_DATA, par_err
 );
  input [7:0] P_DATA;
  input CLK, RST, parity_type, sampled_bit, Enable;
  output par_err;
  wire   n1, n3, n4, n5, n6, n7, n8, n2;

  DFFRX4M par_err_reg ( .D(n8), .CK(CLK), .RN(RST), .Q(par_err) );
  OAI2BB2X1M U2 ( .B0(n1), .B1(n2), .A0N(par_err), .A1N(n2), .Y(n8) );
  XOR3XLM U3 ( .A(n3), .B(n4), .C(n5), .Y(n1) );
  INVX2M U4 ( .A(Enable), .Y(n2) );
  XNOR2X2M U5 ( .A(sampled_bit), .B(parity_type), .Y(n5) );
  XOR3XLM U6 ( .A(P_DATA[5]), .B(P_DATA[4]), .C(n6), .Y(n4) );
  XNOR2X2M U7 ( .A(P_DATA[7]), .B(P_DATA[6]), .Y(n6) );
  XOR3XLM U8 ( .A(P_DATA[1]), .B(P_DATA[0]), .C(n7), .Y(n3) );
  XNOR2X2M U9 ( .A(P_DATA[3]), .B(P_DATA[2]), .Y(n7) );
endmodule


module stp_chk ( CLK, RST, sampled_bit, Enable, stp_err );
  input CLK, RST, sampled_bit, Enable;
  output stp_err;
  wire   n2, n1;

  DFFRX4M stp_err_reg ( .D(n2), .CK(CLK), .RN(RST), .Q(stp_err) );
  OAI2BB2X1M U2 ( .B0(sampled_bit), .B1(n1), .A0N(stp_err), .A1N(n1), .Y(n2)
         );
  CLKINVX1M U3 ( .A(Enable), .Y(n1) );
endmodule


module UART_RX ( CLK, RST, RX_IN, parity_enable, parity_type, Prescale, P_DATA, 
        data_valid, parity_error, framing_error );
  input [5:0] Prescale;
  output [7:0] P_DATA;
  input CLK, RST, RX_IN, parity_enable, parity_type;
  output data_valid, parity_error, framing_error;
  wire   strt_glitch, strt_chk_en, edge_bit_en, deser_en, par_chk_en,
         stp_chk_en, dat_samp_en, sampled_bit, n1, n2;
  wire   [3:0] bit_count;
  wire   [5:0] edge_count;

  uart_rx_fsm U0_uart_fsm ( .CLK(CLK), .RST(n1), .S_DATA(RX_IN), .Prescale(
        Prescale), .parity_enable(parity_enable), .bit_count(bit_count), 
        .edge_count(edge_count), .par_err(parity_error), .stp_err(
        framing_error), .strt_glitch(strt_glitch), .strt_chk_en(strt_chk_en), 
        .edge_bit_en(edge_bit_en), .deser_en(deser_en), .par_chk_en(par_chk_en), .stp_chk_en(stp_chk_en), .dat_samp_en(dat_samp_en), .data_valid(data_valid)
         );
  edge_bit_counter U0_edge_bit_counter ( .CLK(CLK), .RST(n1), .Enable(
        edge_bit_en), .Prescale(Prescale), .bit_count(bit_count), .edge_count(
        edge_count) );
  data_sampling U0_data_sampling ( .CLK(CLK), .RST(n1), .S_DATA(RX_IN), 
        .Prescale(Prescale), .edge_count(edge_count), .Enable(dat_samp_en), 
        .sampled_bit(sampled_bit) );
  deserializer U0_deserializer ( .CLK(CLK), .RST(n1), .sampled_bit(sampled_bit), .Enable(deser_en), .edge_count(edge_count), .Prescale(Prescale), .P_DATA(
        P_DATA) );
  strt_chk U0_strt_chk ( .CLK(CLK), .RST(n1), .sampled_bit(sampled_bit), 
        .Enable(strt_chk_en), .strt_glitch(strt_glitch) );
  par_chk U0_par_chk ( .CLK(CLK), .RST(n1), .parity_type(parity_type), 
        .sampled_bit(sampled_bit), .Enable(par_chk_en), .P_DATA(P_DATA), 
        .par_err(parity_error) );
  stp_chk U0_stp_chk ( .CLK(CLK), .RST(n1), .sampled_bit(sampled_bit), 
        .Enable(stp_chk_en), .stp_err(framing_error) );
  INVX4M U1 ( .A(n2), .Y(n1) );
  INVX2M U2 ( .A(RST), .Y(n2) );
endmodule


module UART ( CLK_tb_top, RST_tb_top, P_DATA_tb_top, DATA_VALID_tb_top, 
        PAR_EN_tb_top, PAR_TYP_tb_top, TX_OUT_tb_top, BUSY_tb_top, rx_in_top, 
        prescale_top, par_en_top, par_typ_top, clk_top, data_valid_top, 
        stop_error, par_error, p_data_top );
  input [7:0] P_DATA_tb_top;
  input [5:0] prescale_top;
  output [7:0] p_data_top;
  input CLK_tb_top, RST_tb_top, DATA_VALID_tb_top, PAR_EN_tb_top,
         PAR_TYP_tb_top, rx_in_top, par_en_top, par_typ_top, clk_top;
  output TX_OUT_tb_top, BUSY_tb_top, data_valid_top, stop_error, par_error;


  UART_TX_1 TX ( .CLK_tb(CLK_tb_top), .RST_tb(RST_tb_top), .P_DATA_tb(
        P_DATA_tb_top), .DATA_VALID_tb(DATA_VALID_tb_top), .PAR_EN_tb(
        PAR_EN_tb_top), .PAR_TYP_tb(PAR_TYP_tb_top), .TX_OUT_tb(TX_OUT_tb_top), 
        .BUSY_tb(BUSY_tb_top) );
  UART_RX RX ( .CLK(clk_top), .RST(RST_tb_top), .RX_IN(rx_in_top), 
        .parity_enable(par_en_top), .parity_type(par_typ_top), .Prescale(
        prescale_top), .P_DATA(p_data_top), .data_valid(data_valid_top), 
        .parity_error(par_error), .framing_error(stop_error) );
endmodule


module DATA_SYNC ( clk, rst, bus_enable, unsync_bus, enable_pulse, sync_bus );
  input [7:0] unsync_bus;
  output [7:0] sync_bus;
  input clk, rst, bus_enable;
  output enable_pulse;
  wire   pulse_flop, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12;
  wire   [1:0] chain;

  DFFRQX1M pulse_flop_reg ( .D(chain[1]), .CK(clk), .RN(n11), .Q(pulse_flop)
         );
  DFFRQX1M \chain_reg[1]  ( .D(chain[0]), .CK(clk), .RN(n11), .Q(chain[1]) );
  DFFRQX2M \sync_bus_reg[4]  ( .D(n6), .CK(clk), .RN(n11), .Q(sync_bus[4]) );
  DFFRQX1M \sync_bus_reg[6]  ( .D(n8), .CK(clk), .RN(n11), .Q(sync_bus[6]) );
  DFFRQX2M \sync_bus_reg[7]  ( .D(n9), .CK(clk), .RN(n11), .Q(sync_bus[7]) );
  DFFRQX2M \sync_bus_reg[3]  ( .D(n5), .CK(clk), .RN(n11), .Q(sync_bus[3]) );
  DFFRQX1M \sync_bus_reg[2]  ( .D(n4), .CK(clk), .RN(n11), .Q(sync_bus[2]) );
  DFFRQX2M \sync_bus_reg[0]  ( .D(n2), .CK(clk), .RN(n11), .Q(sync_bus[0]) );
  DFFRQX2M \sync_bus_reg[1]  ( .D(n3), .CK(clk), .RN(n11), .Q(sync_bus[1]) );
  DFFRQX2M \sync_bus_reg[5]  ( .D(n7), .CK(clk), .RN(n11), .Q(sync_bus[5]) );
  DFFRQX1M \chain_reg[0]  ( .D(bus_enable), .CK(clk), .RN(n11), .Q(chain[0])
         );
  INVX6M U3 ( .A(n1), .Y(enable_pulse) );
  BUFX4M U4 ( .A(n1), .Y(n10) );
  INVX6M U5 ( .A(n12), .Y(n11) );
  INVX2M U6 ( .A(rst), .Y(n12) );
  NAND2BX2M U7 ( .AN(pulse_flop), .B(chain[1]), .Y(n1) );
  AO22X1M U8 ( .A0(unsync_bus[5]), .A1(enable_pulse), .B0(sync_bus[5]), .B1(
        n10), .Y(n7) );
  AO22X1M U9 ( .A0(unsync_bus[3]), .A1(enable_pulse), .B0(sync_bus[3]), .B1(
        n10), .Y(n5) );
  AO22X1M U10 ( .A0(unsync_bus[7]), .A1(enable_pulse), .B0(sync_bus[7]), .B1(
        n10), .Y(n9) );
  AO22X1M U11 ( .A0(unsync_bus[1]), .A1(enable_pulse), .B0(sync_bus[1]), .B1(
        n10), .Y(n3) );
  AO22X1M U12 ( .A0(unsync_bus[0]), .A1(enable_pulse), .B0(sync_bus[0]), .B1(
        n10), .Y(n2) );
  AO22X1M U13 ( .A0(unsync_bus[4]), .A1(enable_pulse), .B0(sync_bus[4]), .B1(
        n10), .Y(n6) );
  AO22X1M U14 ( .A0(unsync_bus[2]), .A1(enable_pulse), .B0(sync_bus[2]), .B1(
        n10), .Y(n4) );
  AO22X1M U15 ( .A0(unsync_bus[6]), .A1(enable_pulse), .B0(sync_bus[6]), .B1(
        n10), .Y(n8) );
endmodule


module controller ( clk, rst, data, data_valid, rd_d, rd_d_valid, alu_out, 
        alu_valid, fifo_full, wr_inc, wr_data, wren, rden, addr, wr_d, fun_alu, 
        en_alu, gate_en );
  input [7:0] data;
  input [7:0] rd_d;
  input [7:0] alu_out;
  output [7:0] wr_data;
  output [3:0] addr;
  output [7:0] wr_d;
  output [3:0] fun_alu;
  input clk, rst, data_valid, rd_d_valid, alu_valid, fifo_full;
  output wr_inc, wren, rden, en_alu, gate_en;
  wire   n80, n81, n82, data_valid_cntrl, n1, n2, n3, n4, n21, n22, n23, n24,
         n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38,
         n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52,
         n53, n54, n55, n56, n57, n59, n60, n61, n62, n63, n64, n65, n5, n6,
         n7, n8, n9, n11, n12, n14, n15, n16, n18, n19, n20, n58, n66, n67,
         n68, n69, n70, n72, n73, n74, n75, n76, n77, n78, n79;
  wire   [3:0] current_state;
  wire   [3:0] next_state;

  NOR3BX4M U28 ( .AN(n38), .B(n79), .C(n75), .Y(n30) );
  NOR4BX4M U45 ( .AN(n55), .B(data[1]), .C(data[5]), .D(n74), .Y(n38) );
  OAI21X8M U58 ( .A0(n78), .A1(n14), .B0(n5), .Y(fun_alu[1]) );
  NOR4X8M U63 ( .A(current_state[0]), .B(current_state[1]), .C(n9), .D(
        current_state[3]), .Y(n31) );
  NOR3BX4M U74 ( .AN(n49), .B(current_state[1]), .C(current_state[3]), .Y(n43)
         );
  DFFRX1M \addr_hold_reg[0]  ( .D(n65), .CK(clk), .RN(n18), .QN(n4) );
  DFFRX1M \addr_hold_reg[2]  ( .D(n63), .CK(clk), .RN(n18), .QN(n2) );
  DFFRX1M \addr_hold_reg[1]  ( .D(n64), .CK(clk), .RN(n18), .QN(n3) );
  DFFRX1M \addr_hold_reg[3]  ( .D(n62), .CK(clk), .RN(n18), .QN(n1) );
  DFFRQX4M data_valid_cntrl_reg ( .D(data_valid), .CK(clk), .RN(n18), .Q(
        data_valid_cntrl) );
  DFFRQX4M \current_state_reg[3]  ( .D(next_state[3]), .CK(clk), .RN(n18), .Q(
        current_state[3]) );
  DFFRQX4M \current_state_reg[0]  ( .D(next_state[0]), .CK(clk), .RN(n18), .Q(
        current_state[0]) );
  DFFRQX4M \current_state_reg[1]  ( .D(next_state[1]), .CK(clk), .RN(n18), .Q(
        current_state[1]) );
  DFFRQX1M \current_state_reg[2]  ( .D(next_state[2]), .CK(clk), .RN(n18), .Q(
        current_state[2]) );
  NOR2BX4M U3 ( .AN(n42), .B(rden), .Y(n61) );
  NOR2X8M U4 ( .A(n14), .B(n58), .Y(en_alu) );
  OR2X4M U5 ( .A(n11), .B(n12), .Y(n5) );
  OR2X1M U6 ( .A(current_state[1]), .B(n31), .Y(n6) );
  OR2X2M U7 ( .A(n70), .B(n31), .Y(n7) );
  INVXLM U8 ( .A(current_state[2]), .Y(n8) );
  INVX4M U9 ( .A(n8), .Y(n9) );
  CLKBUFX6M U10 ( .A(n80), .Y(addr[3]) );
  OAI22X1M U11 ( .A0(n57), .A1(n76), .B0(n61), .B1(n1), .Y(n80) );
  NOR2X1M U12 ( .A(n59), .B(n6), .Y(n11) );
  NOR2X1M U13 ( .A(n59), .B(n7), .Y(n12) );
  OAI21X6M U14 ( .A0(n77), .A1(n14), .B0(n5), .Y(fun_alu[2]) );
  OAI21X6M U15 ( .A0(n79), .A1(n14), .B0(n5), .Y(fun_alu[0]) );
  OAI2BB2X2M U16 ( .B0(n14), .B1(data_valid_cntrl), .A0N(n9), .A1N(n60), .Y(
        n59) );
  BUFX6M U17 ( .A(n81), .Y(addr[2]) );
  OAI22X1M U18 ( .A0(n57), .A1(n77), .B0(n61), .B1(n2), .Y(n81) );
  INVX2M U19 ( .A(n23), .Y(rden) );
  BUFX4M U20 ( .A(n21), .Y(n16) );
  BUFX4M U21 ( .A(n22), .Y(n15) );
  NAND3X2M U22 ( .A(n50), .B(n70), .C(n9), .Y(n24) );
  NAND3X2M U23 ( .A(n50), .B(current_state[0]), .C(n9), .Y(n23) );
  INVX2M U24 ( .A(data[3]), .Y(n76) );
  NOR2X4M U25 ( .A(alu_valid), .B(n24), .Y(n33) );
  INVX2M U26 ( .A(data[4]), .Y(n75) );
  INVX4M U27 ( .A(wren), .Y(n67) );
  NAND2BX2M U29 ( .AN(n25), .B(n26), .Y(wren) );
  INVX2M U30 ( .A(n57), .Y(n68) );
  OR2X2M U31 ( .A(n16), .B(n15), .Y(wr_inc) );
  INVX2M U32 ( .A(n27), .Y(n69) );
  CLKBUFX6M U33 ( .A(n34), .Y(n14) );
  NAND2X2M U34 ( .A(n39), .B(n70), .Y(n34) );
  NAND2X2M U35 ( .A(n14), .B(n24), .Y(gate_en) );
  OAI21X1M U36 ( .A0(n76), .A1(n14), .B0(n5), .Y(fun_alu[3]) );
  NOR2X6M U37 ( .A(n43), .B(n72), .Y(n57) );
  NAND2X2M U38 ( .A(n49), .B(n39), .Y(n26) );
  INVX2M U39 ( .A(n45), .Y(n72) );
  NOR2X2M U40 ( .A(n67), .B(n79), .Y(wr_d[0]) );
  NOR2X2M U41 ( .A(n67), .B(n78), .Y(wr_d[1]) );
  NOR2X2M U42 ( .A(n67), .B(n77), .Y(wr_d[2]) );
  NOR2X2M U43 ( .A(n67), .B(n76), .Y(wr_d[3]) );
  NOR2X2M U44 ( .A(n67), .B(n75), .Y(wr_d[4]) );
  NOR2X2M U46 ( .A(n67), .B(n74), .Y(wr_d[6]) );
  NAND2X2M U47 ( .A(n50), .B(n49), .Y(n27) );
  INVX2M U48 ( .A(n56), .Y(n66) );
  NOR3X2M U49 ( .A(n23), .B(fifo_full), .C(n20), .Y(n21) );
  NOR2X2M U50 ( .A(n24), .B(fifo_full), .Y(n22) );
  NAND2X2M U51 ( .A(n42), .B(n27), .Y(n25) );
  OAI2B1X4M U52 ( .A1N(n31), .A0(n44), .B0(n45), .Y(n37) );
  OR3X2M U53 ( .A(n51), .B(n79), .C(n75), .Y(n44) );
  INVX4M U54 ( .A(n19), .Y(n18) );
  INVX2M U55 ( .A(rst), .Y(n19) );
  NOR2X4M U56 ( .A(n73), .B(current_state[1]), .Y(n39) );
  INVX4M U57 ( .A(current_state[0]), .Y(n70) );
  INVX2M U59 ( .A(current_state[3]), .Y(n73) );
  AND2X2M U60 ( .A(current_state[1]), .B(current_state[3]), .Y(n50) );
  OAI22X1M U61 ( .A0(current_state[1]), .A1(n70), .B0(current_state[3]), .B1(
        current_state[0]), .Y(n60) );
  NOR2X6M U62 ( .A(n70), .B(n9), .Y(n49) );
  BUFX2M U64 ( .A(n82), .Y(addr[0]) );
  OAI221X1M U65 ( .A0(n61), .A1(n4), .B0(n57), .B1(n79), .C0(n26), .Y(n82) );
  INVX4M U66 ( .A(data[0]), .Y(n79) );
  INVX4M U67 ( .A(data[2]), .Y(n77) );
  INVX4M U68 ( .A(data[1]), .Y(n78) );
  NAND4X2M U69 ( .A(n9), .B(current_state[1]), .C(current_state[0]), .D(n73), 
        .Y(n45) );
  INVX2M U70 ( .A(data_valid_cntrl), .Y(n58) );
  NAND3X2M U71 ( .A(n49), .B(n73), .C(current_state[1]), .Y(n42) );
  OAI22X1M U72 ( .A0(n57), .A1(n78), .B0(n61), .B1(n3), .Y(addr[1]) );
  NOR2BX2M U73 ( .AN(data[5]), .B(n67), .Y(wr_d[5]) );
  NOR2BX2M U75 ( .AN(data[7]), .B(n67), .Y(wr_d[7]) );
  NAND2X4M U76 ( .A(data_valid_cntrl), .B(n68), .Y(n56) );
  OAI22X1M U77 ( .A0(n78), .A1(n56), .B0(n66), .B1(n3), .Y(n64) );
  OAI22X1M U78 ( .A0(n77), .A1(n56), .B0(n66), .B1(n2), .Y(n63) );
  OAI22X1M U79 ( .A0(n76), .A1(n56), .B0(n66), .B1(n1), .Y(n62) );
  OAI22X1M U80 ( .A0(n79), .A1(n56), .B0(n66), .B1(n4), .Y(n65) );
  NOR2X2M U81 ( .A(n77), .B(n53), .Y(n55) );
  OAI21X4M U82 ( .A0(rd_d_valid), .A1(n23), .B0(n54), .Y(n32) );
  NAND4X2M U83 ( .A(n31), .B(n38), .C(n79), .D(n75), .Y(n54) );
  AO22X1M U84 ( .A0(n15), .A1(alu_out[0]), .B0(rd_d[0]), .B1(n16), .Y(
        wr_data[0]) );
  AO22X1M U85 ( .A0(n15), .A1(alu_out[1]), .B0(rd_d[1]), .B1(n16), .Y(
        wr_data[1]) );
  AO22X1M U86 ( .A0(n15), .A1(alu_out[2]), .B0(rd_d[2]), .B1(n16), .Y(
        wr_data[2]) );
  AO22X1M U87 ( .A0(n15), .A1(alu_out[3]), .B0(rd_d[3]), .B1(n16), .Y(
        wr_data[3]) );
  AO22X1M U88 ( .A0(alu_out[4]), .A1(n15), .B0(rd_d[4]), .B1(n16), .Y(
        wr_data[4]) );
  AO22X1M U89 ( .A0(alu_out[5]), .A1(n15), .B0(rd_d[5]), .B1(n16), .Y(
        wr_data[5]) );
  AO22X1M U90 ( .A0(alu_out[6]), .A1(n15), .B0(rd_d[6]), .B1(n16), .Y(
        wr_data[6]) );
  AO22X1M U91 ( .A0(alu_out[7]), .A1(n15), .B0(rd_d[7]), .B1(n16), .Y(
        wr_data[7]) );
  OAI211X2M U92 ( .A0(n58), .A1(n14), .B0(n35), .C0(n36), .Y(next_state[2]) );
  AOI32X1M U93 ( .A0(n39), .A1(n70), .A2(n9), .B0(n33), .B1(alu_out[2]), .Y(
        n35) );
  AOI221X2M U94 ( .A0(n30), .A1(n31), .B0(rden), .B1(n20), .C0(n37), .Y(n36)
         );
  NAND3X2M U95 ( .A(data[3]), .B(data[7]), .C(data_valid_cntrl), .Y(n53) );
  INVX2M U96 ( .A(data[6]), .Y(n74) );
  NAND2X2M U97 ( .A(n46), .B(n47), .Y(next_state[0]) );
  AOI221X2M U98 ( .A0(n31), .A1(n48), .B0(n49), .B1(n58), .C0(n69), .Y(n47) );
  AOI211X2M U99 ( .A0(n33), .A1(alu_out[0]), .B0(n68), .C0(n32), .Y(n46) );
  OAI31X2M U100 ( .A0(n51), .A1(data[4]), .A2(data[0]), .B0(n44), .Y(n48) );
  NAND2X2M U101 ( .A(n40), .B(n41), .Y(next_state[1]) );
  AOI221X2M U102 ( .A0(n25), .A1(n58), .B0(n33), .B1(alu_out[1]), .C0(en_alu), 
        .Y(n41) );
  AOI211X2M U103 ( .A0(n43), .A1(data_valid_cntrl), .B0(n37), .C0(n32), .Y(n40) );
  NAND4X2M U104 ( .A(n27), .B(n26), .C(n28), .D(n29), .Y(next_state[3]) );
  AOI21BX2M U105 ( .A0(n33), .A1(alu_out[3]), .B0N(n14), .Y(n28) );
  AOI221X2M U106 ( .A0(data_valid), .A1(n72), .B0(n30), .B1(n31), .C0(n32), 
        .Y(n29) );
  INVX2M U107 ( .A(rd_d_valid), .Y(n20) );
  NAND4X2M U108 ( .A(n77), .B(n74), .C(data[5]), .D(n52), .Y(n51) );
  NOR2X2M U109 ( .A(n78), .B(n53), .Y(n52) );
endmodule


module ALU_16B_DW_div_uns_0 ( a, b, quotient, remainder, divide_by_0 );
  input [7:0] a;
  input [7:0] b;
  output [7:0] quotient;
  output [7:0] remainder;
  output divide_by_0;
  wire   \u_div/SumTmp[1][0] , \u_div/SumTmp[1][1] , \u_div/SumTmp[1][2] ,
         \u_div/SumTmp[1][3] , \u_div/SumTmp[1][4] , \u_div/SumTmp[1][5] ,
         \u_div/SumTmp[1][6] , \u_div/SumTmp[2][0] , \u_div/SumTmp[2][1] ,
         \u_div/SumTmp[2][2] , \u_div/SumTmp[2][3] , \u_div/SumTmp[2][4] ,
         \u_div/SumTmp[2][5] , \u_div/SumTmp[3][0] , \u_div/SumTmp[3][1] ,
         \u_div/SumTmp[3][2] , \u_div/SumTmp[3][3] , \u_div/SumTmp[3][4] ,
         \u_div/SumTmp[4][0] , \u_div/SumTmp[4][1] , \u_div/SumTmp[4][2] ,
         \u_div/SumTmp[4][3] , \u_div/SumTmp[5][0] , \u_div/SumTmp[5][1] ,
         \u_div/SumTmp[5][2] , \u_div/SumTmp[6][0] , \u_div/SumTmp[6][1] ,
         \u_div/SumTmp[7][0] , \u_div/CryTmp[0][1] , \u_div/CryTmp[0][2] ,
         \u_div/CryTmp[0][3] , \u_div/CryTmp[0][4] , \u_div/CryTmp[0][5] ,
         \u_div/CryTmp[0][6] , \u_div/CryTmp[0][7] , \u_div/CryTmp[1][1] ,
         \u_div/CryTmp[1][2] , \u_div/CryTmp[1][3] , \u_div/CryTmp[1][4] ,
         \u_div/CryTmp[1][5] , \u_div/CryTmp[1][6] , \u_div/CryTmp[1][7] ,
         \u_div/CryTmp[2][1] , \u_div/CryTmp[2][2] , \u_div/CryTmp[2][3] ,
         \u_div/CryTmp[2][4] , \u_div/CryTmp[2][5] , \u_div/CryTmp[2][6] ,
         \u_div/CryTmp[3][1] , \u_div/CryTmp[3][2] , \u_div/CryTmp[3][3] ,
         \u_div/CryTmp[3][4] , \u_div/CryTmp[3][5] , \u_div/CryTmp[4][1] ,
         \u_div/CryTmp[4][2] , \u_div/CryTmp[4][3] , \u_div/CryTmp[4][4] ,
         \u_div/CryTmp[5][1] , \u_div/CryTmp[5][2] , \u_div/CryTmp[5][3] ,
         \u_div/CryTmp[6][1] , \u_div/CryTmp[6][2] , \u_div/CryTmp[7][1] ,
         \u_div/PartRem[1][1] , \u_div/PartRem[1][2] , \u_div/PartRem[1][3] ,
         \u_div/PartRem[1][4] , \u_div/PartRem[1][5] , \u_div/PartRem[1][6] ,
         \u_div/PartRem[1][7] , \u_div/PartRem[2][1] , \u_div/PartRem[2][2] ,
         \u_div/PartRem[2][3] , \u_div/PartRem[2][4] , \u_div/PartRem[2][5] ,
         \u_div/PartRem[2][6] , \u_div/PartRem[3][1] , \u_div/PartRem[3][2] ,
         \u_div/PartRem[3][3] , \u_div/PartRem[3][4] , \u_div/PartRem[3][5] ,
         \u_div/PartRem[4][1] , \u_div/PartRem[4][2] , \u_div/PartRem[4][3] ,
         \u_div/PartRem[4][4] , \u_div/PartRem[5][1] , \u_div/PartRem[5][2] ,
         \u_div/PartRem[5][3] , \u_div/PartRem[6][1] , \u_div/PartRem[6][2] ,
         \u_div/PartRem[7][1] , n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11;

  ADDFX2M \u_div/u_fa_PartRem_0_0_7  ( .A(\u_div/PartRem[1][7] ), .B(n1), .CI(
        \u_div/CryTmp[0][7] ), .CO(quotient[0]) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_5  ( .A(\u_div/PartRem[3][5] ), .B(n3), .CI(
        \u_div/CryTmp[2][5] ), .CO(\u_div/CryTmp[2][6] ), .S(
        \u_div/SumTmp[2][5] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_4_3  ( .A(\u_div/PartRem[5][3] ), .B(n5), .CI(
        \u_div/CryTmp[4][3] ), .CO(\u_div/CryTmp[4][4] ), .S(
        \u_div/SumTmp[4][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_3_4  ( .A(\u_div/PartRem[4][4] ), .B(n4), .CI(
        \u_div/CryTmp[3][4] ), .CO(\u_div/CryTmp[3][5] ), .S(
        \u_div/SumTmp[3][4] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_5_2  ( .A(\u_div/PartRem[6][2] ), .B(n6), .CI(
        \u_div/CryTmp[5][2] ), .CO(\u_div/CryTmp[5][3] ), .S(
        \u_div/SumTmp[5][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_6_1  ( .A(\u_div/PartRem[7][1] ), .B(n7), .CI(
        \u_div/CryTmp[6][1] ), .CO(\u_div/CryTmp[6][2] ), .S(
        \u_div/SumTmp[6][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_5  ( .A(\u_div/PartRem[1][5] ), .B(n3), .CI(
        \u_div/CryTmp[0][5] ), .CO(\u_div/CryTmp[0][6] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_6  ( .A(\u_div/PartRem[1][6] ), .B(n2), .CI(
        \u_div/CryTmp[0][6] ), .CO(\u_div/CryTmp[0][7] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_3  ( .A(\u_div/PartRem[1][3] ), .B(n5), .CI(
        \u_div/CryTmp[0][3] ), .CO(\u_div/CryTmp[0][4] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_4  ( .A(\u_div/PartRem[1][4] ), .B(n4), .CI(
        \u_div/CryTmp[0][4] ), .CO(\u_div/CryTmp[0][5] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_4  ( .A(\u_div/PartRem[2][4] ), .B(n4), .CI(
        \u_div/CryTmp[1][4] ), .CO(\u_div/CryTmp[1][5] ), .S(
        \u_div/SumTmp[1][4] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_5  ( .A(\u_div/PartRem[2][5] ), .B(n3), .CI(
        \u_div/CryTmp[1][5] ), .CO(\u_div/CryTmp[1][6] ), .S(
        \u_div/SumTmp[1][5] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_4  ( .A(\u_div/PartRem[3][4] ), .B(n4), .CI(
        \u_div/CryTmp[2][4] ), .CO(\u_div/CryTmp[2][5] ), .S(
        \u_div/SumTmp[2][4] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_3  ( .A(\u_div/PartRem[2][3] ), .B(n5), .CI(
        \u_div/CryTmp[1][3] ), .CO(\u_div/CryTmp[1][4] ), .S(
        \u_div/SumTmp[1][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_3  ( .A(\u_div/PartRem[3][3] ), .B(n5), .CI(
        \u_div/CryTmp[2][3] ), .CO(\u_div/CryTmp[2][4] ), .S(
        \u_div/SumTmp[2][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_3_3  ( .A(\u_div/PartRem[4][3] ), .B(n5), .CI(
        \u_div/CryTmp[3][3] ), .CO(\u_div/CryTmp[3][4] ), .S(
        \u_div/SumTmp[3][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_1  ( .A(\u_div/PartRem[1][1] ), .B(n7), .CI(
        \u_div/CryTmp[0][1] ), .CO(\u_div/CryTmp[0][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_2  ( .A(\u_div/PartRem[1][2] ), .B(n6), .CI(
        \u_div/CryTmp[0][2] ), .CO(\u_div/CryTmp[0][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_2  ( .A(\u_div/PartRem[2][2] ), .B(n6), .CI(
        \u_div/CryTmp[1][2] ), .CO(\u_div/CryTmp[1][3] ), .S(
        \u_div/SumTmp[1][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_2  ( .A(\u_div/PartRem[3][2] ), .B(n6), .CI(
        \u_div/CryTmp[2][2] ), .CO(\u_div/CryTmp[2][3] ), .S(
        \u_div/SumTmp[2][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_3_2  ( .A(\u_div/PartRem[4][2] ), .B(n6), .CI(
        \u_div/CryTmp[3][2] ), .CO(\u_div/CryTmp[3][3] ), .S(
        \u_div/SumTmp[3][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_4_2  ( .A(\u_div/PartRem[5][2] ), .B(n6), .CI(
        \u_div/CryTmp[4][2] ), .CO(\u_div/CryTmp[4][3] ), .S(
        \u_div/SumTmp[4][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_1  ( .A(\u_div/PartRem[2][1] ), .B(n7), .CI(
        \u_div/CryTmp[1][1] ), .CO(\u_div/CryTmp[1][2] ), .S(
        \u_div/SumTmp[1][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_1  ( .A(\u_div/PartRem[3][1] ), .B(n7), .CI(
        \u_div/CryTmp[2][1] ), .CO(\u_div/CryTmp[2][2] ), .S(
        \u_div/SumTmp[2][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_3_1  ( .A(\u_div/PartRem[4][1] ), .B(n7), .CI(
        \u_div/CryTmp[3][1] ), .CO(\u_div/CryTmp[3][2] ), .S(
        \u_div/SumTmp[3][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_4_1  ( .A(\u_div/PartRem[5][1] ), .B(n7), .CI(
        \u_div/CryTmp[4][1] ), .CO(\u_div/CryTmp[4][2] ), .S(
        \u_div/SumTmp[4][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_5_1  ( .A(\u_div/PartRem[6][1] ), .B(n7), .CI(
        \u_div/CryTmp[5][1] ), .CO(\u_div/CryTmp[5][2] ), .S(
        \u_div/SumTmp[5][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_6  ( .A(\u_div/PartRem[2][6] ), .B(n2), .CI(
        \u_div/CryTmp[1][6] ), .CO(\u_div/CryTmp[1][7] ), .S(
        \u_div/SumTmp[1][6] ) );
  INVX8M U1 ( .A(b[0]), .Y(n8) );
  CLKINVX4M U2 ( .A(b[2]), .Y(n6) );
  NOR2X4M U3 ( .A(b[6]), .B(b[7]), .Y(n11) );
  AND3X4M U4 ( .A(n11), .B(n3), .C(\u_div/CryTmp[3][5] ), .Y(quotient[3]) );
  CLKAND2X4M U5 ( .A(\u_div/CryTmp[4][4] ), .B(n10), .Y(quotient[4]) );
  CLKAND2X4M U6 ( .A(\u_div/CryTmp[2][6] ), .B(n11), .Y(quotient[2]) );
  CLKAND2X4M U7 ( .A(\u_div/CryTmp[1][7] ), .B(n1), .Y(quotient[1]) );
  AND2X2M U8 ( .A(\u_div/CryTmp[5][3] ), .B(n9), .Y(quotient[5]) );
  MX2X1M U9 ( .A(\u_div/PartRem[3][1] ), .B(\u_div/SumTmp[2][1] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][2] ) );
  MX2X1M U10 ( .A(\u_div/PartRem[4][1] ), .B(\u_div/SumTmp[3][1] ), .S0(
        quotient[3]), .Y(\u_div/PartRem[3][2] ) );
  MX2X1M U11 ( .A(\u_div/PartRem[5][1] ), .B(\u_div/SumTmp[4][1] ), .S0(
        quotient[4]), .Y(\u_div/PartRem[4][2] ) );
  MX2X1M U12 ( .A(\u_div/PartRem[6][1] ), .B(\u_div/SumTmp[5][1] ), .S0(
        quotient[5]), .Y(\u_div/PartRem[5][2] ) );
  MX2X1M U13 ( .A(\u_div/PartRem[3][2] ), .B(\u_div/SumTmp[2][2] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][3] ) );
  MX2X1M U14 ( .A(\u_div/PartRem[3][3] ), .B(\u_div/SumTmp[2][3] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][4] ) );
  MX2X1M U15 ( .A(\u_div/PartRem[4][3] ), .B(\u_div/SumTmp[3][3] ), .S0(
        quotient[3]), .Y(\u_div/PartRem[3][4] ) );
  MX2X1M U16 ( .A(\u_div/PartRem[4][2] ), .B(\u_div/SumTmp[3][2] ), .S0(
        quotient[3]), .Y(\u_div/PartRem[3][3] ) );
  MX2X1M U17 ( .A(\u_div/PartRem[5][3] ), .B(\u_div/SumTmp[4][3] ), .S0(
        quotient[4]), .Y(\u_div/PartRem[4][4] ) );
  MX2X1M U18 ( .A(\u_div/PartRem[5][2] ), .B(\u_div/SumTmp[4][2] ), .S0(
        quotient[4]), .Y(\u_div/PartRem[4][3] ) );
  MX2X1M U19 ( .A(\u_div/PartRem[6][2] ), .B(\u_div/SumTmp[5][2] ), .S0(
        quotient[5]), .Y(\u_div/PartRem[5][3] ) );
  MX2X1M U20 ( .A(\u_div/PartRem[3][4] ), .B(\u_div/SumTmp[2][4] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][5] ) );
  MX2X1M U21 ( .A(\u_div/PartRem[3][5] ), .B(\u_div/SumTmp[2][5] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][6] ) );
  MX2X1M U22 ( .A(\u_div/PartRem[4][4] ), .B(\u_div/SumTmp[3][4] ), .S0(
        quotient[3]), .Y(\u_div/PartRem[3][5] ) );
  MX2XLM U23 ( .A(\u_div/PartRem[2][6] ), .B(\u_div/SumTmp[1][6] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][7] ) );
  AND3X2M U24 ( .A(n9), .B(n6), .C(\u_div/CryTmp[6][2] ), .Y(quotient[6]) );
  AND2X2M U25 ( .A(n10), .B(n5), .Y(n9) );
  INVX4M U26 ( .A(b[1]), .Y(n7) );
  OR2X2M U27 ( .A(a[7]), .B(n8), .Y(\u_div/CryTmp[7][1] ) );
  XNOR2X2M U28 ( .A(n8), .B(a[2]), .Y(\u_div/SumTmp[2][0] ) );
  XNOR2X2M U29 ( .A(n8), .B(a[3]), .Y(\u_div/SumTmp[3][0] ) );
  XNOR2X2M U30 ( .A(n8), .B(a[4]), .Y(\u_div/SumTmp[4][0] ) );
  XNOR2X2M U31 ( .A(n8), .B(a[5]), .Y(\u_div/SumTmp[5][0] ) );
  XNOR2X2M U32 ( .A(n8), .B(a[6]), .Y(\u_div/SumTmp[6][0] ) );
  XNOR2X2M U33 ( .A(n8), .B(a[7]), .Y(\u_div/SumTmp[7][0] ) );
  XNOR2X2M U34 ( .A(n8), .B(a[1]), .Y(\u_div/SumTmp[1][0] ) );
  OR2X2M U35 ( .A(a[5]), .B(n8), .Y(\u_div/CryTmp[5][1] ) );
  OR2X2M U36 ( .A(a[4]), .B(n8), .Y(\u_div/CryTmp[4][1] ) );
  OR2X2M U37 ( .A(a[3]), .B(n8), .Y(\u_div/CryTmp[3][1] ) );
  OR2X2M U38 ( .A(a[2]), .B(n8), .Y(\u_div/CryTmp[2][1] ) );
  OR2X2M U39 ( .A(a[1]), .B(n8), .Y(\u_div/CryTmp[1][1] ) );
  NAND2BX2M U40 ( .AN(a[0]), .B(b[0]), .Y(\u_div/CryTmp[0][1] ) );
  OR2X2M U41 ( .A(a[6]), .B(n8), .Y(\u_div/CryTmp[6][1] ) );
  INVX2M U42 ( .A(b[6]), .Y(n2) );
  INVX4M U43 ( .A(b[3]), .Y(n5) );
  INVX4M U44 ( .A(b[4]), .Y(n4) );
  INVX4M U45 ( .A(b[5]), .Y(n3) );
  INVX2M U46 ( .A(b[7]), .Y(n1) );
  CLKMX2X2M U47 ( .A(\u_div/PartRem[7][1] ), .B(\u_div/SumTmp[6][1] ), .S0(
        quotient[6]), .Y(\u_div/PartRem[6][2] ) );
  CLKMX2X2M U48 ( .A(a[7]), .B(\u_div/SumTmp[7][0] ), .S0(quotient[7]), .Y(
        \u_div/PartRem[7][1] ) );
  CLKMX2X2M U49 ( .A(\u_div/PartRem[2][5] ), .B(\u_div/SumTmp[1][5] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][6] ) );
  CLKMX2X2M U50 ( .A(a[6]), .B(\u_div/SumTmp[6][0] ), .S0(quotient[6]), .Y(
        \u_div/PartRem[6][1] ) );
  CLKMX2X2M U51 ( .A(\u_div/PartRem[2][4] ), .B(\u_div/SumTmp[1][4] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][5] ) );
  CLKMX2X2M U52 ( .A(a[5]), .B(\u_div/SumTmp[5][0] ), .S0(quotient[5]), .Y(
        \u_div/PartRem[5][1] ) );
  CLKMX2X2M U53 ( .A(\u_div/PartRem[2][3] ), .B(\u_div/SumTmp[1][3] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][4] ) );
  CLKMX2X2M U54 ( .A(a[4]), .B(\u_div/SumTmp[4][0] ), .S0(quotient[4]), .Y(
        \u_div/PartRem[4][1] ) );
  CLKMX2X2M U55 ( .A(\u_div/PartRem[2][2] ), .B(\u_div/SumTmp[1][2] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][3] ) );
  CLKMX2X2M U56 ( .A(a[3]), .B(\u_div/SumTmp[3][0] ), .S0(quotient[3]), .Y(
        \u_div/PartRem[3][1] ) );
  CLKMX2X2M U57 ( .A(\u_div/PartRem[2][1] ), .B(\u_div/SumTmp[1][1] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][2] ) );
  CLKMX2X2M U58 ( .A(a[2]), .B(\u_div/SumTmp[2][0] ), .S0(quotient[2]), .Y(
        \u_div/PartRem[2][1] ) );
  CLKMX2X2M U59 ( .A(a[1]), .B(\u_div/SumTmp[1][0] ), .S0(quotient[1]), .Y(
        \u_div/PartRem[1][1] ) );
  AND4X1M U60 ( .A(\u_div/CryTmp[7][1] ), .B(n9), .C(n7), .D(n6), .Y(
        quotient[7]) );
  AND3X1M U61 ( .A(n11), .B(n4), .C(n3), .Y(n10) );
endmodule


module ALU_16B_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [7:0] A;
  input [7:0] B;
  output [7:0] DIFF;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8;
  wire   [8:0] carry;

  ADDFX2M U2_5 ( .A(A[5]), .B(n3), .CI(carry[5]), .CO(carry[6]), .S(DIFF[5])
         );
  ADDFX2M U2_4 ( .A(A[4]), .B(n4), .CI(carry[4]), .CO(carry[5]), .S(DIFF[4])
         );
  ADDFX2M U2_3 ( .A(A[3]), .B(n5), .CI(carry[3]), .CO(carry[4]), .S(DIFF[3])
         );
  ADDFX2M U2_2 ( .A(A[2]), .B(n6), .CI(carry[2]), .CO(carry[3]), .S(DIFF[2])
         );
  XOR3XLM U2_7 ( .A(A[7]), .B(n1), .C(carry[7]), .Y(DIFF[7]) );
  ADDFX2M U2_6 ( .A(A[6]), .B(n2), .CI(carry[6]), .CO(carry[7]), .S(DIFF[6])
         );
  ADDFX2M U2_1 ( .A(A[1]), .B(n7), .CI(carry[1]), .CO(carry[2]), .S(DIFF[1])
         );
  INVXLM U1 ( .A(B[2]), .Y(n6) );
  INVX2M U2 ( .A(B[1]), .Y(n7) );
  OR2X2M U3 ( .A(A[0]), .B(n8), .Y(carry[1]) );
  INVX2M U4 ( .A(B[6]), .Y(n2) );
  XNOR2X2M U5 ( .A(n8), .B(A[0]), .Y(DIFF[0]) );
  INVX2M U6 ( .A(B[0]), .Y(n8) );
  INVX2M U7 ( .A(B[7]), .Y(n1) );
  INVX2M U8 ( .A(B[3]), .Y(n5) );
  INVX2M U9 ( .A(B[4]), .Y(n4) );
  INVX2M U10 ( .A(B[5]), .Y(n3) );
endmodule


module ALU_16B_DW01_add_0 ( A, B, CI, SUM, CO );
  input [7:0] A;
  input [7:0] B;
  output [7:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [7:1] carry;

  ADDFX2M U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  ADDFX2M U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFX2M U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFX2M U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  ADDFX2M U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  XOR3XLM U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .Y(SUM[7]) );
  ADDFX2M U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  AND2X2M U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  CLKXOR2X2M U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module ALU_16B_DW02_mult_0 ( A, B, TC, PRODUCT );
  input [7:0] A;
  input [7:0] B;
  output [15:0] PRODUCT;
  input TC;
  wire   \ab[7][0] , \ab[6][1] , \ab[6][0] , \ab[5][2] , \ab[5][1] ,
         \ab[5][0] , \ab[4][3] , \ab[4][2] , \ab[4][1] , \ab[4][0] ,
         \ab[3][4] , \ab[3][3] , \ab[3][2] , \ab[3][1] , \ab[3][0] ,
         \ab[2][5] , \ab[2][4] , \ab[2][3] , \ab[2][2] , \ab[2][1] ,
         \ab[2][0] , \ab[1][6] , \ab[1][5] , \ab[1][4] , \ab[1][3] ,
         \ab[1][2] , \ab[1][1] , \ab[1][0] , \ab[0][7] , \ab[0][6] ,
         \ab[0][5] , \ab[0][4] , \ab[0][3] , \ab[0][2] , \ab[0][1] ,
         \CARRYB[6][0] , \CARRYB[5][1] , \CARRYB[5][0] , \CARRYB[4][2] ,
         \CARRYB[4][1] , \CARRYB[4][0] , \CARRYB[3][3] , \CARRYB[3][2] ,
         \CARRYB[3][1] , \CARRYB[3][0] , \CARRYB[2][4] , \CARRYB[2][3] ,
         \CARRYB[2][2] , \CARRYB[2][1] , \CARRYB[2][0] , \SUMB[6][1] ,
         \SUMB[5][2] , \SUMB[5][1] , \SUMB[4][3] , \SUMB[4][2] , \SUMB[4][1] ,
         \SUMB[3][4] , \SUMB[3][3] , \SUMB[3][2] , \SUMB[3][1] , \SUMB[2][5] ,
         \SUMB[2][4] , \SUMB[2][3] , \SUMB[2][2] , \SUMB[2][1] , \SUMB[1][6] ,
         \SUMB[1][5] , \SUMB[1][4] , \SUMB[1][3] , \SUMB[1][2] , \SUMB[1][1] ,
         n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17,
         n18, n19, n20, n21, n22, n23;

  ADDFX2M S1_6_0 ( .A(\ab[6][0] ), .B(\CARRYB[5][0] ), .CI(\SUMB[5][1] ), .CO(
        \CARRYB[6][0] ), .S(PRODUCT[6]) );
  ADDFX2M S1_5_0 ( .A(\ab[5][0] ), .B(\CARRYB[4][0] ), .CI(\SUMB[4][1] ), .CO(
        \CARRYB[5][0] ), .S(PRODUCT[5]) );
  ADDFX2M S1_4_0 ( .A(\ab[4][0] ), .B(\CARRYB[3][0] ), .CI(\SUMB[3][1] ), .CO(
        \CARRYB[4][0] ), .S(PRODUCT[4]) );
  ADDFX2M S1_3_0 ( .A(\ab[3][0] ), .B(\CARRYB[2][0] ), .CI(\SUMB[2][1] ), .CO(
        \CARRYB[3][0] ), .S(PRODUCT[3]) );
  ADDFX2M S2_4_2 ( .A(\ab[4][2] ), .B(\CARRYB[3][2] ), .CI(\SUMB[3][3] ), .CO(
        \CARRYB[4][2] ), .S(\SUMB[4][2] ) );
  ADDFX2M S1_2_0 ( .A(\ab[2][0] ), .B(n6), .CI(\SUMB[1][1] ), .CO(
        \CARRYB[2][0] ), .S(PRODUCT[2]) );
  XOR3XLM S2_6_1 ( .A(\ab[6][1] ), .B(\CARRYB[5][1] ), .C(\SUMB[5][2] ), .Y(
        \SUMB[6][1] ) );
  XOR3XLM S4_0 ( .A(\ab[7][0] ), .B(\CARRYB[6][0] ), .C(\SUMB[6][1] ), .Y(
        PRODUCT[7]) );
  XOR3XLM S2_4_3 ( .A(\ab[4][3] ), .B(\CARRYB[3][3] ), .C(\SUMB[3][4] ), .Y(
        \SUMB[4][3] ) );
  XOR3XLM S2_5_2 ( .A(\ab[5][2] ), .B(\CARRYB[4][2] ), .C(\SUMB[4][3] ), .Y(
        \SUMB[5][2] ) );
  ADDFX2M S2_3_3 ( .A(\ab[3][3] ), .B(\CARRYB[2][3] ), .CI(\SUMB[2][4] ), .CO(
        \CARRYB[3][3] ), .S(\SUMB[3][3] ) );
  XOR3XLM S2_2_5 ( .A(\ab[2][5] ), .B(n8), .C(\SUMB[1][6] ), .Y(\SUMB[2][5] )
         );
  XOR3XLM S2_3_4 ( .A(\ab[3][4] ), .B(\CARRYB[2][4] ), .C(\SUMB[2][5] ), .Y(
        \SUMB[3][4] ) );
  ADDFX2M S2_3_2 ( .A(\ab[3][2] ), .B(\CARRYB[2][2] ), .CI(\SUMB[2][3] ), .CO(
        \CARRYB[3][2] ), .S(\SUMB[3][2] ) );
  ADDFX2M S2_2_3 ( .A(\ab[2][3] ), .B(n5), .CI(\SUMB[1][4] ), .CO(
        \CARRYB[2][3] ), .S(\SUMB[2][3] ) );
  ADDFX2M S2_2_4 ( .A(\ab[2][4] ), .B(n7), .CI(\SUMB[1][5] ), .CO(
        \CARRYB[2][4] ), .S(\SUMB[2][4] ) );
  ADDFX2M S2_2_2 ( .A(\ab[2][2] ), .B(n4), .CI(\SUMB[1][3] ), .CO(
        \CARRYB[2][2] ), .S(\SUMB[2][2] ) );
  ADDFX2M S2_5_1 ( .A(\ab[5][1] ), .B(\CARRYB[4][1] ), .CI(\SUMB[4][2] ), .CO(
        \CARRYB[5][1] ), .S(\SUMB[5][1] ) );
  ADDFX2M S2_4_1 ( .A(\ab[4][1] ), .B(\CARRYB[3][1] ), .CI(\SUMB[3][2] ), .CO(
        \CARRYB[4][1] ), .S(\SUMB[4][1] ) );
  ADDFX2M S2_3_1 ( .A(\ab[3][1] ), .B(\CARRYB[2][1] ), .CI(\SUMB[2][2] ), .CO(
        \CARRYB[3][1] ), .S(\SUMB[3][1] ) );
  ADDFX2M S2_2_1 ( .A(\ab[2][1] ), .B(n3), .CI(\SUMB[1][2] ), .CO(
        \CARRYB[2][1] ), .S(\SUMB[2][1] ) );
  AND2X2M U2 ( .A(\ab[0][2] ), .B(\ab[1][1] ), .Y(n3) );
  AND2X2M U3 ( .A(\ab[0][3] ), .B(\ab[1][2] ), .Y(n4) );
  AND2X2M U4 ( .A(\ab[0][4] ), .B(\ab[1][3] ), .Y(n5) );
  AND2X2M U5 ( .A(\ab[0][1] ), .B(\ab[1][0] ), .Y(n6) );
  AND2X2M U6 ( .A(\ab[0][5] ), .B(\ab[1][4] ), .Y(n7) );
  CLKINVX3M U7 ( .A(B[2]), .Y(n13) );
  NOR2X2M U8 ( .A(n14), .B(n23), .Y(\ab[0][1] ) );
  NOR2X2M U9 ( .A(n14), .B(n22), .Y(\ab[1][1] ) );
  NOR2X2M U10 ( .A(n9), .B(n23), .Y(\ab[0][6] ) );
  CLKXOR2X2M U11 ( .A(\ab[1][0] ), .B(\ab[0][1] ), .Y(PRODUCT[1]) );
  NOR2X2M U12 ( .A(n12), .B(n23), .Y(\ab[0][3] ) );
  NOR2X2M U13 ( .A(n13), .B(n23), .Y(\ab[0][2] ) );
  NOR2X2M U14 ( .A(n11), .B(n23), .Y(\ab[0][4] ) );
  NOR2X2M U15 ( .A(n10), .B(n23), .Y(\ab[0][5] ) );
  NOR2X2M U16 ( .A(n12), .B(n22), .Y(\ab[1][3] ) );
  NOR2X2M U17 ( .A(n15), .B(n22), .Y(\ab[1][0] ) );
  NOR2X2M U18 ( .A(n11), .B(n22), .Y(\ab[1][4] ) );
  NOR2X2M U19 ( .A(n13), .B(n22), .Y(\ab[1][2] ) );
  CLKXOR2X2M U20 ( .A(\ab[1][5] ), .B(\ab[0][6] ), .Y(\SUMB[1][5] ) );
  NOR2X2M U21 ( .A(n10), .B(n22), .Y(\ab[1][5] ) );
  INVX4M U22 ( .A(A[1]), .Y(n22) );
  XOR2X1M U23 ( .A(\ab[1][2] ), .B(\ab[0][3] ), .Y(\SUMB[1][2] ) );
  AND2X2M U24 ( .A(\ab[0][6] ), .B(\ab[1][5] ), .Y(n8) );
  INVX4M U25 ( .A(A[2]), .Y(n21) );
  INVX4M U26 ( .A(A[3]), .Y(n20) );
  INVX2M U27 ( .A(A[4]), .Y(n19) );
  INVX2M U28 ( .A(A[5]), .Y(n18) );
  INVX2M U29 ( .A(A[6]), .Y(n17) );
  INVX4M U30 ( .A(A[0]), .Y(n23) );
  INVX4M U31 ( .A(B[1]), .Y(n14) );
  XOR2X1M U32 ( .A(\ab[1][3] ), .B(\ab[0][4] ), .Y(\SUMB[1][3] ) );
  XOR2X1M U33 ( .A(\ab[1][4] ), .B(\ab[0][5] ), .Y(\SUMB[1][4] ) );
  CLKXOR2X2M U34 ( .A(\ab[1][6] ), .B(\ab[0][7] ), .Y(\SUMB[1][6] ) );
  INVX2M U35 ( .A(A[7]), .Y(n16) );
  XOR2X1M U36 ( .A(\ab[1][1] ), .B(\ab[0][2] ), .Y(\SUMB[1][1] ) );
  INVX2M U37 ( .A(B[6]), .Y(n9) );
  INVX4M U38 ( .A(B[0]), .Y(n15) );
  INVX4M U39 ( .A(B[3]), .Y(n12) );
  INVX2M U40 ( .A(B[4]), .Y(n11) );
  INVX2M U41 ( .A(B[5]), .Y(n10) );
  NOR2BX2M U42 ( .AN(B[7]), .B(n23), .Y(\ab[0][7] ) );
  NOR2X1M U43 ( .A(n16), .B(n15), .Y(\ab[7][0] ) );
  NOR2X1M U44 ( .A(n14), .B(n17), .Y(\ab[6][1] ) );
  NOR2X1M U45 ( .A(n15), .B(n17), .Y(\ab[6][0] ) );
  NOR2X1M U46 ( .A(n13), .B(n18), .Y(\ab[5][2] ) );
  NOR2X1M U47 ( .A(n14), .B(n18), .Y(\ab[5][1] ) );
  NOR2X1M U48 ( .A(n15), .B(n18), .Y(\ab[5][0] ) );
  NOR2X1M U49 ( .A(n12), .B(n19), .Y(\ab[4][3] ) );
  NOR2X1M U50 ( .A(n13), .B(n19), .Y(\ab[4][2] ) );
  NOR2X1M U51 ( .A(n14), .B(n19), .Y(\ab[4][1] ) );
  NOR2X1M U52 ( .A(n15), .B(n19), .Y(\ab[4][0] ) );
  NOR2X1M U53 ( .A(n11), .B(n20), .Y(\ab[3][4] ) );
  NOR2X1M U54 ( .A(n12), .B(n20), .Y(\ab[3][3] ) );
  NOR2X1M U55 ( .A(n13), .B(n20), .Y(\ab[3][2] ) );
  NOR2X1M U56 ( .A(n14), .B(n20), .Y(\ab[3][1] ) );
  NOR2X1M U57 ( .A(n15), .B(n20), .Y(\ab[3][0] ) );
  NOR2X1M U58 ( .A(n10), .B(n21), .Y(\ab[2][5] ) );
  NOR2X1M U59 ( .A(n11), .B(n21), .Y(\ab[2][4] ) );
  NOR2X1M U60 ( .A(n12), .B(n21), .Y(\ab[2][3] ) );
  NOR2X1M U61 ( .A(n13), .B(n21), .Y(\ab[2][2] ) );
  NOR2X1M U62 ( .A(n14), .B(n21), .Y(\ab[2][1] ) );
  NOR2X1M U63 ( .A(n15), .B(n21), .Y(\ab[2][0] ) );
  NOR2X1M U64 ( .A(n9), .B(n22), .Y(\ab[1][6] ) );
  NOR2X1M U65 ( .A(n15), .B(n23), .Y(PRODUCT[0]) );
endmodule


module ALU_16B ( A, B, ALU_FUN, CLK, enable, rst, ALU_OUT, OUT_VALID );
  input [7:0] A;
  input [7:0] B;
  input [3:0] ALU_FUN;
  output [7:0] ALU_OUT;
  input CLK, enable, rst;
  output OUT_VALID;
  wire   N89, N90, N91, N92, N93, N94, N95, N96, N97, N98, N99, N100, N101,
         N102, N103, N104, N105, N106, N107, N108, N109, N110, N111, N112,
         N113, N114, N115, N116, N117, N118, N119, N120, N145, N146, N147, n10,
         n11, n12, n13, n14, n15, n18, n19, n22, n23, n24, n25, n26, n27, n28,
         n30, n31, n32, n34, n35, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         n48, n51, n52, n54, n56, n57, n58, n59, n60, n63, n64, n66, n67, n68,
         n69, n70, n71, n73, n74, n76, n77, n78, n79, n81, n82, n84, n85, n86,
         n87, n89, n90, n92, n93, n94, n95, n97, n98, n100, n101, n102, n103,
         n104, n106, n109, n110, n111, n112, n113, n115, n116, n117, n118,
         n119, n120, n121, n122, n123, n124, n3, n4, n5, n6, n7, n8, n9, n16,
         n17, n20, n21, n29, n33, n36, n37, n38, n49, n50, n53, n55, n61, n62,
         n65, n72, n75, n80, n83, n88, n91, n96, n99, n105, n107, n108, n114,
         n125, n126, n127, n128, n129, n130, n131, n132, n133, n134, n135,
         n136, n137, n138, n139, n140, n141, n142, n143, n144, n145, n146,
         n147, n148, n149, n150, n151, n152, n153, n154, n155, n156, n157,
         n158, n159, n160, n161, n162, n163, n164, n165, n166, n167, n168,
         n169, n170, n171, n172, n173;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7;

  NAND3BX4M U85 ( .AN(n106), .B(n48), .C(n170), .Y(n51) );
  ALU_16B_DW_div_uns_0 div_39 ( .a({n72, n61, n50, n37, n29, n17, n8, n6}), 
        .b({B[7], n5, B[5:2], n4, B[0]}), .quotient({N120, N119, N118, N117, 
        N116, N115, N114, N113}) );
  ALU_16B_DW01_sub_0 sub_31 ( .A({n72, n61, n50, n37, n29, n17, n8, n6}), .B({
        B[7], n5, B[5:2], n4, B[0]}), .CI(1'b0), .DIFF({N104, N103, N102, N101, 
        N100, N99, N98, N97}) );
  ALU_16B_DW01_add_0 add_27 ( .A({n72, n61, n50, n37, n29, n17, n8, n6}), .B({
        B[7], n5, B[5:2], n4, B[0]}), .CI(1'b0), .SUM({N96, N95, N94, N93, N92, 
        N91, N90, N89}) );
  ALU_16B_DW02_mult_0 mult_35 ( .A({n72, n61, n50, n37, n29, n17, n8, n6}), 
        .B({B[7], n5, B[5:2], n4, B[0]}), .TC(1'b0), .PRODUCT({
        SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7, N112, N111, N110, 
        N109, N108, N107, N106, N105}) );
  DFFRQX2M OUT_VALID_reg ( .D(enable), .CK(CLK), .RN(n80), .Q(OUT_VALID) );
  DFFRQX2M \ALU_OUT_reg[7]  ( .D(n124), .CK(CLK), .RN(n80), .Q(ALU_OUT[7]) );
  DFFRQX2M \ALU_OUT_reg[6]  ( .D(n123), .CK(CLK), .RN(n80), .Q(ALU_OUT[6]) );
  DFFRQX2M \ALU_OUT_reg[5]  ( .D(n122), .CK(CLK), .RN(n80), .Q(ALU_OUT[5]) );
  DFFRQX2M \ALU_OUT_reg[4]  ( .D(n121), .CK(CLK), .RN(n80), .Q(ALU_OUT[4]) );
  DFFRQX2M \ALU_OUT_reg[3]  ( .D(n120), .CK(CLK), .RN(n80), .Q(ALU_OUT[3]) );
  DFFRQX2M \ALU_OUT_reg[2]  ( .D(n119), .CK(CLK), .RN(n80), .Q(ALU_OUT[2]) );
  DFFRQX2M \ALU_OUT_reg[0]  ( .D(n117), .CK(CLK), .RN(n80), .Q(ALU_OUT[0]) );
  DFFRQX2M \ALU_OUT_reg[1]  ( .D(n118), .CK(CLK), .RN(n80), .Q(ALU_OUT[1]) );
  INVX6M U3 ( .A(enable), .Y(n166) );
  INVX2M U4 ( .A(B[2]), .Y(n148) );
  XNOR2X4M U7 ( .A(n62), .B(n5), .Y(n136) );
  OAI31X2M U8 ( .A0(n129), .A1(n99), .A2(n96), .B0(n130), .Y(n107) );
  AOI211X2M U9 ( .A0(n9), .A1(n147), .B0(n126), .C0(n91), .Y(n96) );
  AOI222X2M U10 ( .A0(N106), .A1(n27), .B0(N90), .B1(n25), .C0(N114), .C1(n23), 
        .Y(n42) );
  OAI21X2M U11 ( .A0(n139), .A1(n114), .B0(n140), .Y(N147) );
  NOR2X2M U12 ( .A(n148), .B(n20), .Y(n99) );
  NOR2X2M U13 ( .A(n146), .B(n6), .Y(n88) );
  AOI211X2M U14 ( .A0(n127), .A1(n143), .B0(n126), .C0(n125), .Y(n128) );
  NOR2X2M U15 ( .A(n150), .B(n33), .Y(n129) );
  NOR2X2M U16 ( .A(n145), .B(B[7]), .Y(n139) );
  NAND2X4M U17 ( .A(n111), .B(n47), .Y(n22) );
  NOR2X2M U18 ( .A(n115), .B(n166), .Y(n111) );
  NOR3X6M U19 ( .A(n106), .B(n166), .C(n109), .Y(n26) );
  INVX2M U20 ( .A(ALU_FUN[1]), .Y(n172) );
  CLKBUFX8M U21 ( .A(n19), .Y(n3) );
  NOR2BX4M U22 ( .AN(ALU_FUN[2]), .B(ALU_FUN[1]), .Y(n47) );
  NOR2BX2M U23 ( .AN(n111), .B(ALU_FUN[2]), .Y(n113) );
  NAND3X4M U24 ( .A(n47), .B(n48), .C(ALU_FUN[0]), .Y(n39) );
  INVX2M U25 ( .A(ALU_FUN[3]), .Y(n173) );
  INVX4M U26 ( .A(n7), .Y(n8) );
  CLKBUFX6M U27 ( .A(B[6]), .Y(n5) );
  BUFX6M U28 ( .A(A[0]), .Y(n6) );
  INVX8M U29 ( .A(n26), .Y(n165) );
  INVX2M U30 ( .A(n51), .Y(n162) );
  INVX4M U31 ( .A(n22), .Y(n164) );
  INVX2M U32 ( .A(n18), .Y(n152) );
  OAI2B1X4M U33 ( .A1N(n47), .A0(n109), .B0(n110), .Y(n35) );
  NOR2BX8M U34 ( .AN(n113), .B(n172), .Y(n23) );
  NOR2BX8M U35 ( .AN(n112), .B(n172), .Y(n27) );
  OAI21X4M U36 ( .A0(n106), .A1(n115), .B0(n110), .Y(n31) );
  INVX2M U37 ( .A(n3), .Y(n168) );
  INVX2M U38 ( .A(n39), .Y(n163) );
  NAND4X2M U39 ( .A(N147), .B(n47), .C(n48), .D(n170), .Y(n18) );
  INVX2M U40 ( .A(n8), .Y(n143) );
  NAND2X4M U41 ( .A(enable), .B(n35), .Y(n67) );
  INVX4M U42 ( .A(ALU_FUN[0]), .Y(n170) );
  NAND2X2M U43 ( .A(n170), .B(n173), .Y(n109) );
  NOR2BX8M U44 ( .AN(n113), .B(ALU_FUN[1]), .Y(n24) );
  NOR2BX8M U45 ( .AN(n112), .B(ALU_FUN[1]), .Y(n25) );
  OAI222X1M U46 ( .A0(n39), .A1(n157), .B0(n38), .B1(n165), .C0(n51), .C1(n159), .Y(n79) );
  OAI222X1M U47 ( .A0(n39), .A1(n144), .B0(n53), .B1(n165), .C0(n51), .C1(n158), .Y(n87) );
  OAI222X1M U48 ( .A0(n39), .A1(n145), .B0(n62), .B1(n165), .C0(n51), .C1(n157), .Y(n95) );
  NOR2X4M U49 ( .A(n173), .B(ALU_FUN[2]), .Y(n34) );
  OAI222X1M U50 ( .A0(n39), .A1(n159), .B0(n20), .B1(n165), .C0(n143), .C1(n51), .Y(n60) );
  OAI222X1M U51 ( .A0(n39), .A1(n158), .B0(n33), .B1(n165), .C0(n160), .C1(n51), .Y(n71) );
  NOR3X4M U52 ( .A(n166), .B(ALU_FUN[2]), .C(n109), .Y(n112) );
  OAI221X1M U53 ( .A0(n75), .A1(n66), .B0(n3), .B1(n65), .C0(n165), .Y(n116)
         );
  OAI221X1M U54 ( .A0(n20), .A1(n66), .B0(n3), .B1(n160), .C0(n165), .Y(n64)
         );
  OAI221X1M U55 ( .A0(n33), .A1(n66), .B0(n3), .B1(n159), .C0(n165), .Y(n74)
         );
  OAI221X1M U56 ( .A0(n38), .A1(n66), .B0(n3), .B1(n158), .C0(n165), .Y(n82)
         );
  OAI221X1M U57 ( .A0(n53), .A1(n66), .B0(n3), .B1(n157), .C0(n165), .Y(n90)
         );
  OAI221X1M U58 ( .A0(n62), .A1(n66), .B0(n3), .B1(n144), .C0(n165), .Y(n98)
         );
  OAI221X1M U59 ( .A0(n160), .A1(n67), .B0(n20), .B1(n3), .C0(n22), .Y(n63) );
  OAI221X1M U60 ( .A0(n67), .A1(n159), .B0(n33), .B1(n3), .C0(n22), .Y(n73) );
  OAI221X1M U61 ( .A0(n67), .A1(n158), .B0(n38), .B1(n3), .C0(n22), .Y(n81) );
  OAI221X1M U62 ( .A0(n67), .A1(n157), .B0(n53), .B1(n3), .C0(n22), .Y(n89) );
  OAI221X1M U63 ( .A0(n67), .A1(n144), .B0(n62), .B1(n3), .C0(n22), .Y(n97) );
  NAND2X4M U64 ( .A(enable), .B(n31), .Y(n66) );
  NAND2X2M U65 ( .A(ALU_FUN[1]), .B(ALU_FUN[2]), .Y(n106) );
  NOR2X4M U66 ( .A(n166), .B(n173), .Y(n48) );
  NAND2X2M U67 ( .A(ALU_FUN[0]), .B(n173), .Y(n115) );
  NAND4X2M U68 ( .A(n34), .B(enable), .C(n170), .D(n172), .Y(n19) );
  NAND3X2M U69 ( .A(n34), .B(n172), .C(ALU_FUN[0]), .Y(n110) );
  OAI21X2M U70 ( .A0(n9), .A1(n3), .B0(n22), .Y(n44) );
  OAI21X2M U71 ( .A0(n3), .A1(n161), .B0(n165), .Y(n15) );
  INVX2M U72 ( .A(n75), .Y(n145) );
  INVX2M U73 ( .A(n20), .Y(n160) );
  INVX2M U74 ( .A(n33), .Y(n159) );
  INVX2M U75 ( .A(n38), .Y(n158) );
  INVX2M U76 ( .A(n53), .Y(n157) );
  INVX4M U77 ( .A(n65), .Y(n72) );
  INVX4M U78 ( .A(n55), .Y(n61) );
  INVX4M U79 ( .A(n49), .Y(n50) );
  INVX4M U80 ( .A(n36), .Y(n37) );
  INVX4M U81 ( .A(n21), .Y(n29) );
  INVX4M U82 ( .A(n16), .Y(n17) );
  INVX2M U83 ( .A(n61), .Y(n144) );
  INVXLM U84 ( .A(n88), .Y(n147) );
  OAI31X2M U86 ( .A0(n156), .A1(n169), .A2(n161), .B0(n30), .Y(n28) );
  INVX2M U87 ( .A(n35), .Y(n169) );
  AOI31X2M U88 ( .A0(n161), .A1(n156), .A2(n31), .B0(n32), .Y(n30) );
  AND4XLM U89 ( .A(N145), .B(n170), .C(n34), .D(ALU_FUN[1]), .Y(n32) );
  INVXLM U90 ( .A(n128), .Y(n149) );
  INVX2M U91 ( .A(n142), .Y(N146) );
  INVX2M U92 ( .A(n5), .Y(n151) );
  INVX4M U93 ( .A(n16), .Y(n20) );
  AOI31X2M U94 ( .A0(n9), .A1(n35), .A2(n4), .B0(n54), .Y(n52) );
  OAI31X2M U95 ( .A0(n171), .A1(n4), .A2(n9), .B0(n56), .Y(n54) );
  INVX2M U96 ( .A(n31), .Y(n171) );
  NAND4X1M U97 ( .A(N146), .B(ALU_FUN[0]), .C(ALU_FUN[1]), .D(n34), .Y(n56) );
  OAI21X2M U98 ( .A0(n4), .A1(n46), .B0(n18), .Y(n45) );
  AOI21X2M U99 ( .A0(n9), .A1(n168), .B0(n26), .Y(n46) );
  OAI222X1M U100 ( .A0(n75), .A1(n165), .B0(n104), .B1(n153), .C0(n51), .C1(
        n55), .Y(n103) );
  AOI221X2M U101 ( .A0(n168), .A1(n145), .B0(n75), .B1(n167), .C0(n164), .Y(
        n104) );
  INVX2M U102 ( .A(n67), .Y(n167) );
  INVX4M U103 ( .A(n7), .Y(n9) );
  INVX4M U104 ( .A(n21), .Y(n33) );
  INVX4M U105 ( .A(n36), .Y(n38) );
  OAI21X2M U106 ( .A0(n6), .A1(n3), .B0(n22), .Y(n14) );
  INVX4M U107 ( .A(n55), .Y(n62) );
  INVX4M U108 ( .A(n49), .Y(n53) );
  INVX4M U109 ( .A(n65), .Y(n75) );
  INVX2M U110 ( .A(n6), .Y(n161) );
  INVX6M U111 ( .A(n83), .Y(n80) );
  INVX2M U112 ( .A(rst), .Y(n83) );
  AOI222X2M U113 ( .A0(N113), .A1(n23), .B0(N97), .B1(n24), .C0(N89), .C1(n25), 
        .Y(n12) );
  NAND4X2M U114 ( .A(n10), .B(n11), .C(n12), .D(n13), .Y(n117) );
  AOI222X2M U115 ( .A0(ALU_OUT[0]), .A1(n166), .B0(n9), .B1(n163), .C0(n164), 
        .C1(n6), .Y(n10) );
  AOI221X2M U116 ( .A0(B[0]), .A1(n14), .B0(n15), .B1(n156), .C0(n152), .Y(n13) );
  AOI222X2M U117 ( .A0(n26), .A1(n161), .B0(N105), .B1(n27), .C0(enable), .C1(
        n28), .Y(n11) );
  NAND4BX1M U118 ( .AN(n40), .B(n41), .C(n42), .D(n43), .Y(n118) );
  AOI222X2M U119 ( .A0(ALU_OUT[1]), .A1(n166), .B0(n162), .B1(n6), .C0(n164), 
        .C1(n9), .Y(n41) );
  OAI222X1M U120 ( .A0(n9), .A1(n165), .B0(n52), .B1(n166), .C0(n39), .C1(n160), .Y(n40) );
  AOI221X2M U121 ( .A0(n4), .A1(n44), .B0(N98), .B1(n24), .C0(n45), .Y(n43) );
  CLKBUFX6M U122 ( .A(B[1]), .Y(n4) );
  INVX2M U123 ( .A(A[7]), .Y(n65) );
  INVX2M U124 ( .A(A[6]), .Y(n55) );
  NAND3X2M U125 ( .A(n57), .B(n58), .C(n59), .Y(n119) );
  AOI221X2M U126 ( .A0(n20), .A1(n164), .B0(ALU_OUT[2]), .B1(n166), .C0(n60), 
        .Y(n59) );
  AOI222X2M U127 ( .A0(B[2]), .A1(n63), .B0(N107), .B1(n27), .C0(n64), .C1(
        n148), .Y(n57) );
  AOI222X2M U128 ( .A0(N115), .A1(n23), .B0(N99), .B1(n24), .C0(N91), .C1(n25), 
        .Y(n58) );
  INVX2M U129 ( .A(A[5]), .Y(n49) );
  INVX2M U130 ( .A(A[4]), .Y(n36) );
  NAND3X2M U131 ( .A(n68), .B(n69), .C(n70), .Y(n120) );
  AOI221X2M U132 ( .A0(n33), .A1(n164), .B0(ALU_OUT[3]), .B1(n166), .C0(n71), 
        .Y(n70) );
  AOI222X2M U133 ( .A0(B[3]), .A1(n73), .B0(N108), .B1(n27), .C0(n74), .C1(
        n150), .Y(n68) );
  AOI222X2M U134 ( .A0(N116), .A1(n23), .B0(N100), .B1(n24), .C0(N92), .C1(n25), .Y(n69) );
  INVX2M U135 ( .A(A[3]), .Y(n21) );
  NAND3X2M U136 ( .A(n76), .B(n77), .C(n78), .Y(n121) );
  AOI221X2M U137 ( .A0(n38), .A1(n164), .B0(ALU_OUT[4]), .B1(n166), .C0(n79), 
        .Y(n78) );
  AOI222X2M U138 ( .A0(B[4]), .A1(n81), .B0(N109), .B1(n27), .C0(n82), .C1(
        n155), .Y(n76) );
  AOI222X2M U139 ( .A0(N117), .A1(n23), .B0(N101), .B1(n24), .C0(N93), .C1(n25), .Y(n77) );
  INVX2M U140 ( .A(A[2]), .Y(n16) );
  NAND3X2M U141 ( .A(n84), .B(n85), .C(n86), .Y(n122) );
  AOI221X2M U142 ( .A0(n53), .A1(n164), .B0(ALU_OUT[5]), .B1(n166), .C0(n87), 
        .Y(n86) );
  AOI222X2M U143 ( .A0(B[5]), .A1(n89), .B0(N110), .B1(n27), .C0(n90), .C1(
        n154), .Y(n84) );
  AOI222X2M U144 ( .A0(N118), .A1(n23), .B0(N102), .B1(n24), .C0(N94), .C1(n25), .Y(n85) );
  INVX2M U145 ( .A(B[0]), .Y(n146) );
  INVX2M U146 ( .A(B[3]), .Y(n150) );
  INVX2M U147 ( .A(A[1]), .Y(n7) );
  NAND3X2M U148 ( .A(n92), .B(n93), .C(n94), .Y(n123) );
  AOI221X2M U149 ( .A0(n62), .A1(n164), .B0(ALU_OUT[6]), .B1(n166), .C0(n95), 
        .Y(n94) );
  AOI222X2M U150 ( .A0(n5), .A1(n97), .B0(N111), .B1(n27), .C0(n98), .C1(n151), 
        .Y(n92) );
  AOI222X2M U151 ( .A0(N119), .A1(n23), .B0(N103), .B1(n24), .C0(N95), .C1(n25), .Y(n93) );
  NAND3X2M U152 ( .A(n100), .B(n101), .C(n102), .Y(n124) );
  AOI22X1M U153 ( .A0(N112), .A1(n27), .B0(n116), .B1(n153), .Y(n100) );
  AOI222X2M U154 ( .A0(N120), .A1(n23), .B0(N104), .B1(n24), .C0(N96), .C1(n25), .Y(n101) );
  AOI221X2M U155 ( .A0(n75), .A1(n164), .B0(ALU_OUT[7]), .B1(n166), .C0(n103), 
        .Y(n102) );
  INVX2M U156 ( .A(B[0]), .Y(n156) );
  INVX2M U157 ( .A(B[7]), .Y(n153) );
  INVX2M U158 ( .A(B[4]), .Y(n155) );
  INVX2M U159 ( .A(B[5]), .Y(n154) );
  NAND2BX1M U160 ( .AN(B[4]), .B(n38), .Y(n132) );
  NAND2BX1M U161 ( .AN(n38), .B(B[4]), .Y(n105) );
  CLKNAND2X2M U162 ( .A(n132), .B(n105), .Y(n134) );
  CLKNAND2X2M U163 ( .A(n20), .B(n148), .Y(n131) );
  NAND2BX1M U164 ( .AN(n99), .B(n131), .Y(n126) );
  AOI21X1M U165 ( .A0(n88), .A1(n143), .B0(n4), .Y(n91) );
  CLKNAND2X2M U166 ( .A(n33), .B(n150), .Y(n130) );
  NAND2BX1M U167 ( .AN(n53), .B(B[5]), .Y(n137) );
  OAI211X1M U168 ( .A0(n134), .A1(n107), .B0(n105), .C0(n137), .Y(n108) );
  NAND2BX1M U169 ( .AN(B[5]), .B(n53), .Y(n133) );
  AOI32X1M U170 ( .A0(n108), .A1(n133), .A2(n136), .B0(n5), .B1(n144), .Y(n114) );
  CLKNAND2X2M U171 ( .A(B[7]), .B(n145), .Y(n140) );
  CLKNAND2X2M U172 ( .A(n6), .B(n146), .Y(n127) );
  OA21X1M U173 ( .A0(n127), .A1(n143), .B0(n4), .Y(n125) );
  AOI31X1M U174 ( .A0(n149), .A1(n131), .A2(n130), .B0(n129), .Y(n135) );
  OAI2B11X1M U175 ( .A1N(n135), .A0(n134), .B0(n133), .C0(n132), .Y(n138) );
  AOI32X1M U176 ( .A0(n138), .A1(n137), .A2(n136), .B0(n62), .B1(n151), .Y(
        n141) );
  AOI2B1X1M U177 ( .A1N(n141), .A0(n140), .B0(n139), .Y(n142) );
  NOR2X1M U178 ( .A(N147), .B(N146), .Y(N145) );
endmodule


module REGISTER_FILE ( WrData, Address, RdEn, WrEn, CLK, RST, RdData, d_valid, 
        r0, r1, r2, r3 );
  input [7:0] WrData;
  input [3:0] Address;
  output [7:0] RdData;
  output [7:0] r0;
  output [7:0] r1;
  output [7:0] r2;
  output [7:0] r3;
  input RdEn, WrEn, CLK, RST;
  output d_valid;
  wire   N11, N12, N13, N14, n284, n285, n286, n287, n288, n289, n290, n291,
         n292, n293, \Reg_File[15][7] , \Reg_File[15][6] , \Reg_File[15][5] ,
         \Reg_File[15][4] , \Reg_File[15][3] , \Reg_File[15][2] ,
         \Reg_File[15][1] , \Reg_File[15][0] , \Reg_File[14][7] ,
         \Reg_File[14][6] , \Reg_File[14][5] , \Reg_File[14][4] ,
         \Reg_File[14][3] , \Reg_File[14][2] , \Reg_File[14][1] ,
         \Reg_File[14][0] , \Reg_File[13][7] , \Reg_File[13][6] ,
         \Reg_File[13][5] , \Reg_File[13][4] , \Reg_File[13][3] ,
         \Reg_File[13][2] , \Reg_File[13][1] , \Reg_File[13][0] ,
         \Reg_File[12][7] , \Reg_File[12][6] , \Reg_File[12][5] ,
         \Reg_File[12][4] , \Reg_File[12][3] , \Reg_File[12][2] ,
         \Reg_File[12][1] , \Reg_File[12][0] , \Reg_File[11][7] ,
         \Reg_File[11][6] , \Reg_File[11][5] , \Reg_File[11][4] ,
         \Reg_File[11][3] , \Reg_File[11][2] , \Reg_File[11][1] ,
         \Reg_File[11][0] , \Reg_File[10][7] , \Reg_File[10][6] ,
         \Reg_File[10][5] , \Reg_File[10][4] , \Reg_File[10][3] ,
         \Reg_File[10][2] , \Reg_File[10][1] , \Reg_File[10][0] ,
         \Reg_File[9][7] , \Reg_File[9][6] , \Reg_File[9][5] ,
         \Reg_File[9][4] , \Reg_File[9][3] , \Reg_File[9][2] ,
         \Reg_File[9][1] , \Reg_File[9][0] , \Reg_File[8][7] ,
         \Reg_File[8][6] , \Reg_File[8][5] , \Reg_File[8][4] ,
         \Reg_File[8][3] , \Reg_File[8][2] , \Reg_File[8][1] ,
         \Reg_File[8][0] , \Reg_File[7][7] , \Reg_File[7][6] ,
         \Reg_File[7][5] , \Reg_File[7][4] , \Reg_File[7][3] ,
         \Reg_File[7][2] , \Reg_File[7][1] , \Reg_File[7][0] ,
         \Reg_File[6][7] , \Reg_File[6][6] , \Reg_File[6][5] ,
         \Reg_File[6][4] , \Reg_File[6][3] , \Reg_File[6][2] ,
         \Reg_File[6][1] , \Reg_File[6][0] , \Reg_File[5][7] ,
         \Reg_File[5][6] , \Reg_File[5][5] , \Reg_File[5][4] ,
         \Reg_File[5][3] , \Reg_File[5][2] , \Reg_File[5][1] ,
         \Reg_File[5][0] , \Reg_File[4][7] , \Reg_File[4][6] ,
         \Reg_File[4][5] , \Reg_File[4][4] , \Reg_File[4][3] ,
         \Reg_File[4][2] , \Reg_File[4][1] , \Reg_File[4][0] , N36, N37, N38,
         N39, N40, N41, N42, N43, n13, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n24, n27, n28, n30, n31, n32, n33, n34, n35, n39, n41, n42, n43,
         n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57,
         n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71,
         n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85,
         n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99,
         n100, n101, n102, n103, n104, n105, n106, n107, n108, n109, n110,
         n111, n112, n113, n114, n115, n116, n117, n118, n119, n120, n121,
         n122, n123, n124, n125, n126, n127, n128, n129, n130, n131, n132,
         n133, n134, n135, n136, n137, n138, n139, n140, n141, n142, n143,
         n144, n145, n146, n147, n148, n149, n150, n151, n152, n153, n154,
         n155, n156, n157, n158, n159, n160, n161, n162, n163, n164, n165,
         n166, n167, n168, n169, n170, n171, n172, n173, n174, n175, n176,
         n177, n1, n3, n5, n7, n9, n11, n23, n26, n36, n38, n178, n179, n180,
         n181, n182, n183, n184, n185, n186, n187, n188, n189, n190, n191,
         n192, n193, n194, n195, n196, n197, n198, n199, n200, n201, n202,
         n203, n204, n205, n206, n207, n208, n209, n210, n211, n212, n213,
         n214, n215, n216, n217, n218, n219, n220, n221, n222, n223, n224,
         n225, n226, n227, n228, n229, n230, n231, n232, n233, n234, n235,
         n236, n237, n238, n239, n240, n241, n242, n243, n244, n245, n246,
         n247, n248, n249, n250, n251, n252, n253, n254, n255, n256, n257,
         n258, n259, n260, n261, n262, n263, n264, n265, n266, n267, n268,
         n269, n270, n271, n272, n273, n274, n275, n276, n277, n278, n279,
         n280, n281, n282, n283;
  assign N11 = Address[0];
  assign N12 = Address[1];
  assign N13 = Address[2];
  assign N14 = Address[3];

  DFFRQX1M \Reg_File_reg[13][7]  ( .D(n161), .CK(CLK), .RN(n265), .Q(
        \Reg_File[13][7] ) );
  DFFRQX1M \Reg_File_reg[13][6]  ( .D(n160), .CK(CLK), .RN(n267), .Q(
        \Reg_File[13][6] ) );
  DFFRQX1M \Reg_File_reg[13][5]  ( .D(n159), .CK(CLK), .RN(n270), .Q(
        \Reg_File[13][5] ) );
  DFFRQX1M \Reg_File_reg[13][4]  ( .D(n158), .CK(CLK), .RN(n266), .Q(
        \Reg_File[13][4] ) );
  DFFRQX1M \Reg_File_reg[13][3]  ( .D(n157), .CK(CLK), .RN(n261), .Q(
        \Reg_File[13][3] ) );
  DFFRQX1M \Reg_File_reg[13][2]  ( .D(n156), .CK(CLK), .RN(n269), .Q(
        \Reg_File[13][2] ) );
  DFFRQX1M \Reg_File_reg[13][1]  ( .D(n155), .CK(CLK), .RN(n269), .Q(
        \Reg_File[13][1] ) );
  DFFRQX1M \Reg_File_reg[13][0]  ( .D(n154), .CK(CLK), .RN(n269), .Q(
        \Reg_File[13][0] ) );
  DFFRQX1M \Reg_File_reg[9][7]  ( .D(n129), .CK(CLK), .RN(n267), .Q(
        \Reg_File[9][7] ) );
  DFFRQX1M \Reg_File_reg[9][6]  ( .D(n128), .CK(CLK), .RN(n267), .Q(
        \Reg_File[9][6] ) );
  DFFRQX1M \Reg_File_reg[9][5]  ( .D(n127), .CK(CLK), .RN(n267), .Q(
        \Reg_File[9][5] ) );
  DFFRQX1M \Reg_File_reg[9][4]  ( .D(n126), .CK(CLK), .RN(n267), .Q(
        \Reg_File[9][4] ) );
  DFFRQX1M \Reg_File_reg[9][3]  ( .D(n125), .CK(CLK), .RN(n267), .Q(
        \Reg_File[9][3] ) );
  DFFRQX1M \Reg_File_reg[9][2]  ( .D(n124), .CK(CLK), .RN(n267), .Q(
        \Reg_File[9][2] ) );
  DFFRQX1M \Reg_File_reg[9][1]  ( .D(n123), .CK(CLK), .RN(n267), .Q(
        \Reg_File[9][1] ) );
  DFFRQX1M \Reg_File_reg[9][0]  ( .D(n122), .CK(CLK), .RN(n267), .Q(
        \Reg_File[9][0] ) );
  DFFRQX1M \Reg_File_reg[5][7]  ( .D(n97), .CK(CLK), .RN(n265), .Q(
        \Reg_File[5][7] ) );
  DFFRQX1M \Reg_File_reg[5][6]  ( .D(n96), .CK(CLK), .RN(n265), .Q(
        \Reg_File[5][6] ) );
  DFFRQX1M \Reg_File_reg[5][5]  ( .D(n95), .CK(CLK), .RN(n265), .Q(
        \Reg_File[5][5] ) );
  DFFRQX1M \Reg_File_reg[5][4]  ( .D(n94), .CK(CLK), .RN(n265), .Q(
        \Reg_File[5][4] ) );
  DFFRQX1M \Reg_File_reg[5][3]  ( .D(n93), .CK(CLK), .RN(n265), .Q(
        \Reg_File[5][3] ) );
  DFFRQX1M \Reg_File_reg[5][2]  ( .D(n92), .CK(CLK), .RN(n264), .Q(
        \Reg_File[5][2] ) );
  DFFRQX1M \Reg_File_reg[5][1]  ( .D(n91), .CK(CLK), .RN(n264), .Q(
        \Reg_File[5][1] ) );
  DFFRQX1M \Reg_File_reg[5][0]  ( .D(n90), .CK(CLK), .RN(n264), .Q(
        \Reg_File[5][0] ) );
  DFFRQX1M \Reg_File_reg[15][7]  ( .D(n177), .CK(CLK), .RN(n261), .Q(
        \Reg_File[15][7] ) );
  DFFRQX1M \Reg_File_reg[15][6]  ( .D(n176), .CK(CLK), .RN(n270), .Q(
        \Reg_File[15][6] ) );
  DFFRQX1M \Reg_File_reg[15][5]  ( .D(n175), .CK(CLK), .RN(n270), .Q(
        \Reg_File[15][5] ) );
  DFFRQX1M \Reg_File_reg[15][4]  ( .D(n174), .CK(CLK), .RN(n270), .Q(
        \Reg_File[15][4] ) );
  DFFRQX1M \Reg_File_reg[15][3]  ( .D(n173), .CK(CLK), .RN(n270), .Q(
        \Reg_File[15][3] ) );
  DFFRQX1M \Reg_File_reg[15][2]  ( .D(n172), .CK(CLK), .RN(n270), .Q(
        \Reg_File[15][2] ) );
  DFFRQX1M \Reg_File_reg[15][1]  ( .D(n171), .CK(CLK), .RN(n270), .Q(
        \Reg_File[15][1] ) );
  DFFRQX1M \Reg_File_reg[15][0]  ( .D(n170), .CK(CLK), .RN(n270), .Q(
        \Reg_File[15][0] ) );
  DFFRQX1M \Reg_File_reg[11][7]  ( .D(n145), .CK(CLK), .RN(n269), .Q(
        \Reg_File[11][7] ) );
  DFFRQX1M \Reg_File_reg[11][6]  ( .D(n144), .CK(CLK), .RN(n269), .Q(
        \Reg_File[11][6] ) );
  DFFRQX1M \Reg_File_reg[11][5]  ( .D(n143), .CK(CLK), .RN(n268), .Q(
        \Reg_File[11][5] ) );
  DFFRQX1M \Reg_File_reg[11][4]  ( .D(n142), .CK(CLK), .RN(n268), .Q(
        \Reg_File[11][4] ) );
  DFFRQX1M \Reg_File_reg[11][3]  ( .D(n141), .CK(CLK), .RN(n268), .Q(
        \Reg_File[11][3] ) );
  DFFRQX1M \Reg_File_reg[11][2]  ( .D(n140), .CK(CLK), .RN(n268), .Q(
        \Reg_File[11][2] ) );
  DFFRQX1M \Reg_File_reg[11][1]  ( .D(n139), .CK(CLK), .RN(n268), .Q(
        \Reg_File[11][1] ) );
  DFFRQX1M \Reg_File_reg[11][0]  ( .D(n138), .CK(CLK), .RN(n268), .Q(
        \Reg_File[11][0] ) );
  DFFRQX1M \Reg_File_reg[7][7]  ( .D(n113), .CK(CLK), .RN(n266), .Q(
        \Reg_File[7][7] ) );
  DFFRQX1M \Reg_File_reg[7][6]  ( .D(n112), .CK(CLK), .RN(n266), .Q(
        \Reg_File[7][6] ) );
  DFFRQX1M \Reg_File_reg[7][5]  ( .D(n111), .CK(CLK), .RN(n266), .Q(
        \Reg_File[7][5] ) );
  DFFRQX1M \Reg_File_reg[7][4]  ( .D(n110), .CK(CLK), .RN(n266), .Q(
        \Reg_File[7][4] ) );
  DFFRQX1M \Reg_File_reg[7][3]  ( .D(n109), .CK(CLK), .RN(n266), .Q(
        \Reg_File[7][3] ) );
  DFFRQX1M \Reg_File_reg[7][2]  ( .D(n108), .CK(CLK), .RN(n266), .Q(
        \Reg_File[7][2] ) );
  DFFRQX1M \Reg_File_reg[7][1]  ( .D(n107), .CK(CLK), .RN(n266), .Q(
        \Reg_File[7][1] ) );
  DFFRQX1M \Reg_File_reg[7][0]  ( .D(n106), .CK(CLK), .RN(n266), .Q(
        \Reg_File[7][0] ) );
  DFFRQX1M \Reg_File_reg[14][7]  ( .D(n169), .CK(CLK), .RN(n266), .Q(
        \Reg_File[14][7] ) );
  DFFRQX1M \Reg_File_reg[14][6]  ( .D(n168), .CK(CLK), .RN(n261), .Q(
        \Reg_File[14][6] ) );
  DFFRQX1M \Reg_File_reg[14][5]  ( .D(n167), .CK(CLK), .RN(n266), .Q(
        \Reg_File[14][5] ) );
  DFFRQX1M \Reg_File_reg[14][4]  ( .D(n166), .CK(CLK), .RN(n261), .Q(
        \Reg_File[14][4] ) );
  DFFRQX1M \Reg_File_reg[14][3]  ( .D(n165), .CK(CLK), .RN(n271), .Q(
        \Reg_File[14][3] ) );
  DFFRQX1M \Reg_File_reg[14][2]  ( .D(n164), .CK(CLK), .RN(n268), .Q(
        \Reg_File[14][2] ) );
  DFFRQX1M \Reg_File_reg[14][1]  ( .D(n163), .CK(CLK), .RN(n268), .Q(
        \Reg_File[14][1] ) );
  DFFRQX1M \Reg_File_reg[14][0]  ( .D(n162), .CK(CLK), .RN(n268), .Q(
        \Reg_File[14][0] ) );
  DFFRQX1M \Reg_File_reg[10][7]  ( .D(n137), .CK(CLK), .RN(n268), .Q(
        \Reg_File[10][7] ) );
  DFFRQX1M \Reg_File_reg[10][6]  ( .D(n136), .CK(CLK), .RN(n268), .Q(
        \Reg_File[10][6] ) );
  DFFRQX1M \Reg_File_reg[10][5]  ( .D(n135), .CK(CLK), .RN(n268), .Q(
        \Reg_File[10][5] ) );
  DFFRQX1M \Reg_File_reg[10][4]  ( .D(n134), .CK(CLK), .RN(n268), .Q(
        \Reg_File[10][4] ) );
  DFFRQX1M \Reg_File_reg[10][3]  ( .D(n133), .CK(CLK), .RN(n268), .Q(
        \Reg_File[10][3] ) );
  DFFRQX1M \Reg_File_reg[10][2]  ( .D(n132), .CK(CLK), .RN(n268), .Q(
        \Reg_File[10][2] ) );
  DFFRQX1M \Reg_File_reg[10][1]  ( .D(n131), .CK(CLK), .RN(n268), .Q(
        \Reg_File[10][1] ) );
  DFFRQX1M \Reg_File_reg[10][0]  ( .D(n130), .CK(CLK), .RN(n267), .Q(
        \Reg_File[10][0] ) );
  DFFRQX1M \Reg_File_reg[6][7]  ( .D(n105), .CK(CLK), .RN(n265), .Q(
        \Reg_File[6][7] ) );
  DFFRQX1M \Reg_File_reg[6][6]  ( .D(n104), .CK(CLK), .RN(n265), .Q(
        \Reg_File[6][6] ) );
  DFFRQX1M \Reg_File_reg[6][5]  ( .D(n103), .CK(CLK), .RN(n265), .Q(
        \Reg_File[6][5] ) );
  DFFRQX1M \Reg_File_reg[6][4]  ( .D(n102), .CK(CLK), .RN(n265), .Q(
        \Reg_File[6][4] ) );
  DFFRQX1M \Reg_File_reg[6][3]  ( .D(n101), .CK(CLK), .RN(n265), .Q(
        \Reg_File[6][3] ) );
  DFFRQX1M \Reg_File_reg[6][2]  ( .D(n100), .CK(CLK), .RN(n265), .Q(
        \Reg_File[6][2] ) );
  DFFRQX1M \Reg_File_reg[6][1]  ( .D(n99), .CK(CLK), .RN(n265), .Q(
        \Reg_File[6][1] ) );
  DFFRQX1M \Reg_File_reg[6][0]  ( .D(n98), .CK(CLK), .RN(n265), .Q(
        \Reg_File[6][0] ) );
  DFFRQX1M \Reg_File_reg[12][7]  ( .D(n153), .CK(CLK), .RN(n269), .Q(
        \Reg_File[12][7] ) );
  DFFRQX1M \Reg_File_reg[12][6]  ( .D(n152), .CK(CLK), .RN(n269), .Q(
        \Reg_File[12][6] ) );
  DFFRQX1M \Reg_File_reg[12][5]  ( .D(n151), .CK(CLK), .RN(n269), .Q(
        \Reg_File[12][5] ) );
  DFFRQX1M \Reg_File_reg[12][4]  ( .D(n150), .CK(CLK), .RN(n269), .Q(
        \Reg_File[12][4] ) );
  DFFRQX1M \Reg_File_reg[12][3]  ( .D(n149), .CK(CLK), .RN(n269), .Q(
        \Reg_File[12][3] ) );
  DFFRQX1M \Reg_File_reg[12][2]  ( .D(n148), .CK(CLK), .RN(n269), .Q(
        \Reg_File[12][2] ) );
  DFFRQX1M \Reg_File_reg[12][1]  ( .D(n147), .CK(CLK), .RN(n269), .Q(
        \Reg_File[12][1] ) );
  DFFRQX1M \Reg_File_reg[12][0]  ( .D(n146), .CK(CLK), .RN(n269), .Q(
        \Reg_File[12][0] ) );
  DFFRQX1M \Reg_File_reg[8][7]  ( .D(n121), .CK(CLK), .RN(n267), .Q(
        \Reg_File[8][7] ) );
  DFFRQX1M \Reg_File_reg[8][6]  ( .D(n120), .CK(CLK), .RN(n267), .Q(
        \Reg_File[8][6] ) );
  DFFRQX1M \Reg_File_reg[8][5]  ( .D(n119), .CK(CLK), .RN(n267), .Q(
        \Reg_File[8][5] ) );
  DFFRQX1M \Reg_File_reg[8][4]  ( .D(n118), .CK(CLK), .RN(n267), .Q(
        \Reg_File[8][4] ) );
  DFFRQX1M \Reg_File_reg[8][3]  ( .D(n117), .CK(CLK), .RN(n266), .Q(
        \Reg_File[8][3] ) );
  DFFRQX1M \Reg_File_reg[8][2]  ( .D(n116), .CK(CLK), .RN(n266), .Q(
        \Reg_File[8][2] ) );
  DFFRQX1M \Reg_File_reg[8][1]  ( .D(n115), .CK(CLK), .RN(n266), .Q(
        \Reg_File[8][1] ) );
  DFFRQX1M \Reg_File_reg[8][0]  ( .D(n114), .CK(CLK), .RN(n266), .Q(
        \Reg_File[8][0] ) );
  DFFRQX1M \Reg_File_reg[4][7]  ( .D(n89), .CK(CLK), .RN(n264), .Q(
        \Reg_File[4][7] ) );
  DFFRQX1M \Reg_File_reg[4][6]  ( .D(n88), .CK(CLK), .RN(n264), .Q(
        \Reg_File[4][6] ) );
  DFFRQX1M \Reg_File_reg[4][5]  ( .D(n87), .CK(CLK), .RN(n264), .Q(
        \Reg_File[4][5] ) );
  DFFRQX1M \Reg_File_reg[4][4]  ( .D(n86), .CK(CLK), .RN(n264), .Q(
        \Reg_File[4][4] ) );
  DFFRQX1M \Reg_File_reg[4][3]  ( .D(n85), .CK(CLK), .RN(n264), .Q(
        \Reg_File[4][3] ) );
  DFFRQX1M \Reg_File_reg[4][2]  ( .D(n84), .CK(CLK), .RN(n264), .Q(
        \Reg_File[4][2] ) );
  DFFRQX1M \Reg_File_reg[4][1]  ( .D(n83), .CK(CLK), .RN(n264), .Q(
        \Reg_File[4][1] ) );
  DFFRQX1M \Reg_File_reg[4][0]  ( .D(n82), .CK(CLK), .RN(n264), .Q(
        \Reg_File[4][0] ) );
  DFFRQX1M \RdData_reg[7]  ( .D(n49), .CK(CLK), .RN(n261), .Q(RdData[7]) );
  DFFRQX1M \RdData_reg[6]  ( .D(n48), .CK(CLK), .RN(n262), .Q(RdData[6]) );
  DFFRQX1M \RdData_reg[5]  ( .D(n47), .CK(CLK), .RN(n261), .Q(RdData[5]) );
  DFFRQX1M \RdData_reg[4]  ( .D(n46), .CK(CLK), .RN(n261), .Q(RdData[4]) );
  DFFRQX1M \RdData_reg[3]  ( .D(n45), .CK(CLK), .RN(n261), .Q(RdData[3]) );
  DFFRQX1M \RdData_reg[2]  ( .D(n44), .CK(CLK), .RN(n261), .Q(RdData[2]) );
  DFFRQX1M \RdData_reg[1]  ( .D(n43), .CK(CLK), .RN(n261), .Q(RdData[1]) );
  DFFRQX1M \RdData_reg[0]  ( .D(n42), .CK(CLK), .RN(n261), .Q(RdData[0]) );
  DFFRQX2M \Reg_File_reg[3][0]  ( .D(n74), .CK(CLK), .RN(n263), .Q(r3[0]) );
  DFFRQX2M \Reg_File_reg[2][1]  ( .D(n67), .CK(CLK), .RN(n263), .Q(r2[1]) );
  DFFSQX4M \Reg_File_reg[3][5]  ( .D(n79), .CK(CLK), .SN(n261), .Q(r3[5]) );
  DFFRQX4M \Reg_File_reg[3][7]  ( .D(n81), .CK(CLK), .RN(n264), .Q(r3[7]) );
  DFFRQX4M \Reg_File_reg[3][4]  ( .D(n78), .CK(CLK), .RN(n263), .Q(r3[4]) );
  DFFRQX4M \Reg_File_reg[3][2]  ( .D(n76), .CK(CLK), .RN(n263), .Q(r3[2]) );
  DFFRQX4M \Reg_File_reg[3][3]  ( .D(n77), .CK(CLK), .RN(n263), .Q(r3[3]) );
  DFFRQX4M \Reg_File_reg[3][6]  ( .D(n80), .CK(CLK), .RN(n264), .Q(r3[6]) );
  DFFRQX4M \Reg_File_reg[3][1]  ( .D(n75), .CK(CLK), .RN(n263), .Q(r3[1]) );
  DFFSQX4M \Reg_File_reg[2][7]  ( .D(n73), .CK(CLK), .SN(n261), .Q(r2[7]) );
  DFFSQX4M \Reg_File_reg[2][0]  ( .D(n66), .CK(CLK), .SN(n261), .Q(r2[0]) );
  DFFRQX2M d_valid_reg ( .D(n41), .CK(CLK), .RN(n266), .Q(d_valid) );
  DFFRQX2M \Reg_File_reg[0][1]  ( .D(n51), .CK(CLK), .RN(n261), .Q(r0[1]) );
  DFFRQX2M \Reg_File_reg[0][0]  ( .D(n50), .CK(CLK), .RN(n261), .Q(r0[0]) );
  DFFRQX2M \Reg_File_reg[0][2]  ( .D(n52), .CK(CLK), .RN(n262), .Q(r0[2]) );
  DFFRQX2M \Reg_File_reg[0][3]  ( .D(n53), .CK(CLK), .RN(n262), .Q(r0[3]) );
  DFFRQX2M \Reg_File_reg[0][4]  ( .D(n54), .CK(CLK), .RN(n262), .Q(r0[4]) );
  DFFRQX2M \Reg_File_reg[0][5]  ( .D(n55), .CK(CLK), .RN(n262), .Q(r0[5]) );
  DFFRQX2M \Reg_File_reg[0][6]  ( .D(n56), .CK(CLK), .RN(n262), .Q(r0[6]) );
  DFFRQX2M \Reg_File_reg[0][7]  ( .D(n57), .CK(CLK), .RN(n262), .Q(r0[7]) );
  DFFRQX2M \Reg_File_reg[1][1]  ( .D(n59), .CK(CLK), .RN(n262), .Q(r1[1]) );
  DFFRQX2M \Reg_File_reg[1][6]  ( .D(n64), .CK(CLK), .RN(n263), .Q(r1[6]) );
  DFFRQX1M \Reg_File_reg[2][3]  ( .D(n69), .CK(CLK), .RN(n263), .Q(n292) );
  DFFRQX1M \Reg_File_reg[2][4]  ( .D(n70), .CK(CLK), .RN(n263), .Q(n291) );
  DFFRQX1M \Reg_File_reg[2][6]  ( .D(n72), .CK(CLK), .RN(n263), .Q(n289) );
  DFFRQX1M \Reg_File_reg[1][0]  ( .D(n58), .CK(CLK), .RN(n262), .Q(n288) );
  DFFRQX1M \Reg_File_reg[1][7]  ( .D(n65), .CK(CLK), .RN(n262), .Q(n284) );
  DFFRQX1M \Reg_File_reg[1][5]  ( .D(n63), .CK(CLK), .RN(n263), .Q(n285) );
  DFFRQX1M \Reg_File_reg[1][4]  ( .D(n62), .CK(CLK), .RN(n262), .Q(n286) );
  DFFRQX1M \Reg_File_reg[1][3]  ( .D(n61), .CK(CLK), .RN(n262), .Q(n287) );
  DFFRQX4M \Reg_File_reg[1][2]  ( .D(n60), .CK(CLK), .RN(n262), .Q(r1[2]) );
  DFFRQX1M \Reg_File_reg[2][2]  ( .D(n68), .CK(CLK), .RN(n263), .Q(n293) );
  DFFRQX1M \Reg_File_reg[2][5]  ( .D(n71), .CK(CLK), .RN(n263), .Q(n290) );
  INVX4M U3 ( .A(n5), .Y(r1[3]) );
  INVXLM U4 ( .A(n290), .Y(n1) );
  INVX4M U5 ( .A(n1), .Y(r2[5]) );
  INVXLM U6 ( .A(n293), .Y(n3) );
  INVX4M U7 ( .A(n3), .Y(r2[2]) );
  MX4XLM U8 ( .A(r0[2]), .B(r1[2]), .C(r2[2]), .D(r3[2]), .S0(n222), .S1(n218), 
        .Y(n197) );
  INVXLM U9 ( .A(n287), .Y(n5) );
  INVXLM U10 ( .A(n286), .Y(n7) );
  INVX6M U11 ( .A(n7), .Y(r1[4]) );
  INVXLM U12 ( .A(n285), .Y(n9) );
  INVX6M U13 ( .A(n9), .Y(r1[5]) );
  INVXLM U14 ( .A(n284), .Y(n11) );
  INVX6M U15 ( .A(n11), .Y(r1[7]) );
  INVXLM U16 ( .A(n288), .Y(n23) );
  INVX6M U17 ( .A(n23), .Y(r1[0]) );
  INVXLM U18 ( .A(n289), .Y(n26) );
  INVX6M U19 ( .A(n26), .Y(r2[6]) );
  INVXLM U20 ( .A(n291), .Y(n36) );
  INVX6M U21 ( .A(n36), .Y(r2[4]) );
  INVXLM U22 ( .A(n292), .Y(n38) );
  INVX8M U23 ( .A(n38), .Y(r2[3]) );
  BUFX4M U24 ( .A(n14), .Y(n256) );
  AND2X2M U25 ( .A(n39), .B(n258), .Y(n31) );
  AND2X2M U26 ( .A(n28), .B(n258), .Y(n17) );
  NOR2X4M U27 ( .A(n260), .B(N13), .Y(n21) );
  NOR2X4M U28 ( .A(n259), .B(N13), .Y(n16) );
  CLKAND2X2M U29 ( .A(N13), .B(n260), .Y(n24) );
  CLKAND2X2M U30 ( .A(N13), .B(n259), .Y(n27) );
  INVX2M U31 ( .A(N12), .Y(n260) );
  INVX8M U32 ( .A(WrData[5]), .Y(n278) );
  INVX8M U33 ( .A(WrData[7]), .Y(n276) );
  CLKBUFX8M U34 ( .A(n221), .Y(n222) );
  CLKBUFX8M U35 ( .A(n259), .Y(n218) );
  CLKBUFX8M U36 ( .A(n273), .Y(n261) );
  CLKBUFX8M U37 ( .A(n272), .Y(n263) );
  CLKBUFX8M U38 ( .A(n272), .Y(n264) );
  CLKBUFX8M U39 ( .A(n272), .Y(n265) );
  CLKBUFX8M U40 ( .A(n273), .Y(n266) );
  CLKBUFX8M U41 ( .A(n272), .Y(n267) );
  CLKBUFX8M U42 ( .A(RST), .Y(n268) );
  CLKBUFX8M U43 ( .A(n271), .Y(n269) );
  CLKBUFX8M U44 ( .A(n271), .Y(n262) );
  BUFX4M U45 ( .A(n271), .Y(n270) );
  CLKBUFX8M U46 ( .A(n220), .Y(n223) );
  BUFX2M U47 ( .A(n257), .Y(n220) );
  BUFX4M U48 ( .A(n18), .Y(n253) );
  BUFX4M U49 ( .A(n30), .Y(n239) );
  BUFX4M U50 ( .A(n32), .Y(n237) );
  BUFX4M U51 ( .A(n34), .Y(n235) );
  BUFX4M U52 ( .A(n35), .Y(n233) );
  BUFX4M U53 ( .A(n20), .Y(n251) );
  BUFX4M U54 ( .A(n22), .Y(n249) );
  BUFX4M U55 ( .A(n15), .Y(n255) );
  BUFX4M U56 ( .A(n18), .Y(n252) );
  BUFX4M U57 ( .A(n30), .Y(n238) );
  BUFX4M U58 ( .A(n32), .Y(n236) );
  BUFX4M U59 ( .A(n34), .Y(n234) );
  BUFX4M U60 ( .A(n35), .Y(n232) );
  BUFX4M U61 ( .A(n20), .Y(n250) );
  BUFX4M U62 ( .A(n22), .Y(n248) );
  BUFX4M U63 ( .A(n15), .Y(n254) );
  INVX4M U64 ( .A(n178), .Y(n247) );
  INVX4M U65 ( .A(n178), .Y(n246) );
  INVX4M U66 ( .A(n179), .Y(n245) );
  INVX4M U67 ( .A(n179), .Y(n244) );
  INVX4M U68 ( .A(n180), .Y(n243) );
  INVX4M U69 ( .A(n180), .Y(n242) );
  INVX4M U70 ( .A(n181), .Y(n241) );
  INVX4M U71 ( .A(n181), .Y(n240) );
  INVX4M U72 ( .A(n182), .Y(n231) );
  INVX4M U73 ( .A(n182), .Y(n230) );
  INVX4M U74 ( .A(n183), .Y(n229) );
  INVX4M U75 ( .A(n183), .Y(n228) );
  INVX4M U76 ( .A(n184), .Y(n227) );
  INVX4M U77 ( .A(n184), .Y(n226) );
  INVX4M U78 ( .A(n185), .Y(n225) );
  INVX4M U79 ( .A(n185), .Y(n224) );
  BUFX2M U80 ( .A(n257), .Y(n221) );
  CLKBUFX8M U81 ( .A(n259), .Y(n219) );
  INVX2M U82 ( .A(WrEn), .Y(n275) );
  INVX4M U83 ( .A(n256), .Y(n274) );
  BUFX2M U84 ( .A(n273), .Y(n272) );
  BUFX2M U85 ( .A(n273), .Y(n271) );
  AND2X2M U86 ( .A(n28), .B(n257), .Y(n19) );
  AND2X2M U87 ( .A(n39), .B(n257), .Y(n33) );
  NAND2X2M U88 ( .A(n19), .B(n16), .Y(n18) );
  NAND2X2M U89 ( .A(n31), .B(n16), .Y(n30) );
  NAND2X2M U90 ( .A(n33), .B(n16), .Y(n32) );
  NAND2X2M U91 ( .A(n31), .B(n21), .Y(n34) );
  NAND2X2M U92 ( .A(n33), .B(n21), .Y(n35) );
  NAND2X2M U93 ( .A(n16), .B(n17), .Y(n15) );
  NAND2X2M U94 ( .A(n21), .B(n17), .Y(n20) );
  NAND2X2M U95 ( .A(n21), .B(n19), .Y(n22) );
  AND2X2M U96 ( .A(n24), .B(n17), .Y(n178) );
  AND2X2M U97 ( .A(n24), .B(n19), .Y(n179) );
  AND2X2M U98 ( .A(n27), .B(n17), .Y(n180) );
  AND2X2M U99 ( .A(n27), .B(n19), .Y(n181) );
  AND2X2M U100 ( .A(n31), .B(n24), .Y(n182) );
  AND2X2M U101 ( .A(n33), .B(n24), .Y(n183) );
  AND2X2M U102 ( .A(n31), .B(n27), .Y(n184) );
  AND2X2M U103 ( .A(n33), .B(n27), .Y(n185) );
  NOR2X4M U104 ( .A(n275), .B(RdEn), .Y(n13) );
  NAND2X2M U105 ( .A(RdEn), .B(n275), .Y(n14) );
  NOR2BX2M U106 ( .AN(n13), .B(N14), .Y(n28) );
  AND2X1M U107 ( .A(N14), .B(n13), .Y(n39) );
  INVX2M U108 ( .A(n258), .Y(n257) );
  INVX2M U109 ( .A(n260), .Y(n259) );
  INVX8M U110 ( .A(WrData[0]), .Y(n283) );
  INVX8M U111 ( .A(WrData[1]), .Y(n282) );
  INVX8M U112 ( .A(WrData[2]), .Y(n281) );
  INVX8M U113 ( .A(WrData[3]), .Y(n280) );
  INVX8M U114 ( .A(WrData[4]), .Y(n279) );
  INVX8M U115 ( .A(WrData[6]), .Y(n277) );
  BUFX2M U116 ( .A(RST), .Y(n273) );
  OAI2BB2X1M U117 ( .B0(n255), .B1(n283), .A0N(r0[0]), .A1N(n255), .Y(n50) );
  OAI2BB2X1M U118 ( .B0(n254), .B1(n282), .A0N(r0[1]), .A1N(n255), .Y(n51) );
  OAI2BB2X1M U119 ( .B0(n254), .B1(n281), .A0N(r0[2]), .A1N(n255), .Y(n52) );
  OAI2BB2X1M U120 ( .B0(n254), .B1(n280), .A0N(r0[3]), .A1N(n255), .Y(n53) );
  OAI2BB2X1M U121 ( .B0(n254), .B1(n279), .A0N(r0[4]), .A1N(n255), .Y(n54) );
  OAI2BB2X1M U122 ( .B0(n254), .B1(n277), .A0N(r0[6]), .A1N(n255), .Y(n56) );
  OAI2BB2X1M U123 ( .B0(n283), .B1(n253), .A0N(r1[0]), .A1N(n253), .Y(n58) );
  OAI2BB2X1M U124 ( .B0(n282), .B1(n252), .A0N(r1[1]), .A1N(n253), .Y(n59) );
  OAI2BB2X1M U125 ( .B0(n281), .B1(n252), .A0N(r1[2]), .A1N(n253), .Y(n60) );
  OAI2BB2X1M U126 ( .B0(n280), .B1(n252), .A0N(r1[3]), .A1N(n253), .Y(n61) );
  OAI2BB2X1M U127 ( .B0(n279), .B1(n252), .A0N(r1[4]), .A1N(n253), .Y(n62) );
  OAI2BB2X1M U128 ( .B0(n277), .B1(n252), .A0N(r1[6]), .A1N(n253), .Y(n64) );
  OAI2BB2X1M U129 ( .B0(n282), .B1(n250), .A0N(r2[1]), .A1N(n251), .Y(n67) );
  OAI2BB2X1M U130 ( .B0(n281), .B1(n250), .A0N(r2[2]), .A1N(n251), .Y(n68) );
  OAI2BB2X1M U131 ( .B0(n280), .B1(n250), .A0N(r2[3]), .A1N(n251), .Y(n69) );
  OAI2BB2X1M U132 ( .B0(n279), .B1(n250), .A0N(r2[4]), .A1N(n251), .Y(n70) );
  OAI2BB2X1M U133 ( .B0(n277), .B1(n250), .A0N(r2[6]), .A1N(n251), .Y(n72) );
  OAI2BB2X1M U134 ( .B0(n283), .B1(n249), .A0N(r3[0]), .A1N(n249), .Y(n74) );
  OAI2BB2X1M U135 ( .B0(n282), .B1(n248), .A0N(r3[1]), .A1N(n249), .Y(n75) );
  OAI2BB2X1M U136 ( .B0(n281), .B1(n248), .A0N(r3[2]), .A1N(n249), .Y(n76) );
  OAI2BB2X1M U137 ( .B0(n280), .B1(n248), .A0N(r3[3]), .A1N(n249), .Y(n77) );
  OAI2BB2X1M U138 ( .B0(n279), .B1(n248), .A0N(r3[4]), .A1N(n249), .Y(n78) );
  OAI2BB2X1M U139 ( .B0(n277), .B1(n248), .A0N(r3[6]), .A1N(n249), .Y(n80) );
  OAI2BB2X1M U140 ( .B0(n283), .B1(n247), .A0N(\Reg_File[4][0] ), .A1N(n247), 
        .Y(n82) );
  OAI2BB2X1M U141 ( .B0(n282), .B1(n246), .A0N(\Reg_File[4][1] ), .A1N(n246), 
        .Y(n83) );
  OAI2BB2X1M U142 ( .B0(n281), .B1(n247), .A0N(\Reg_File[4][2] ), .A1N(n247), 
        .Y(n84) );
  OAI2BB2X1M U143 ( .B0(n280), .B1(n246), .A0N(\Reg_File[4][3] ), .A1N(n246), 
        .Y(n85) );
  OAI2BB2X1M U144 ( .B0(n279), .B1(n247), .A0N(\Reg_File[4][4] ), .A1N(n247), 
        .Y(n86) );
  OAI2BB2X1M U145 ( .B0(n277), .B1(n247), .A0N(\Reg_File[4][6] ), .A1N(n247), 
        .Y(n88) );
  OAI2BB2X1M U146 ( .B0(n283), .B1(n245), .A0N(\Reg_File[5][0] ), .A1N(n245), 
        .Y(n90) );
  OAI2BB2X1M U147 ( .B0(n282), .B1(n244), .A0N(\Reg_File[5][1] ), .A1N(n244), 
        .Y(n91) );
  OAI2BB2X1M U148 ( .B0(n281), .B1(n245), .A0N(\Reg_File[5][2] ), .A1N(n245), 
        .Y(n92) );
  OAI2BB2X1M U149 ( .B0(n280), .B1(n244), .A0N(\Reg_File[5][3] ), .A1N(n244), 
        .Y(n93) );
  OAI2BB2X1M U150 ( .B0(n279), .B1(n245), .A0N(\Reg_File[5][4] ), .A1N(n245), 
        .Y(n94) );
  OAI2BB2X1M U151 ( .B0(n277), .B1(n245), .A0N(\Reg_File[5][6] ), .A1N(n245), 
        .Y(n96) );
  OAI2BB2X1M U152 ( .B0(n283), .B1(n243), .A0N(\Reg_File[6][0] ), .A1N(n243), 
        .Y(n98) );
  OAI2BB2X1M U153 ( .B0(n282), .B1(n242), .A0N(\Reg_File[6][1] ), .A1N(n242), 
        .Y(n99) );
  OAI2BB2X1M U154 ( .B0(n281), .B1(n243), .A0N(\Reg_File[6][2] ), .A1N(n243), 
        .Y(n100) );
  OAI2BB2X1M U155 ( .B0(n280), .B1(n242), .A0N(\Reg_File[6][3] ), .A1N(n242), 
        .Y(n101) );
  OAI2BB2X1M U156 ( .B0(n279), .B1(n243), .A0N(\Reg_File[6][4] ), .A1N(n243), 
        .Y(n102) );
  OAI2BB2X1M U157 ( .B0(n277), .B1(n243), .A0N(\Reg_File[6][6] ), .A1N(n243), 
        .Y(n104) );
  OAI2BB2X1M U158 ( .B0(n283), .B1(n241), .A0N(\Reg_File[7][0] ), .A1N(n241), 
        .Y(n106) );
  OAI2BB2X1M U159 ( .B0(n282), .B1(n240), .A0N(\Reg_File[7][1] ), .A1N(n240), 
        .Y(n107) );
  OAI2BB2X1M U160 ( .B0(n281), .B1(n241), .A0N(\Reg_File[7][2] ), .A1N(n241), 
        .Y(n108) );
  OAI2BB2X1M U161 ( .B0(n280), .B1(n240), .A0N(\Reg_File[7][3] ), .A1N(n240), 
        .Y(n109) );
  OAI2BB2X1M U162 ( .B0(n279), .B1(n241), .A0N(\Reg_File[7][4] ), .A1N(n241), 
        .Y(n110) );
  OAI2BB2X1M U163 ( .B0(n277), .B1(n241), .A0N(\Reg_File[7][6] ), .A1N(n241), 
        .Y(n112) );
  OAI2BB2X1M U164 ( .B0(n283), .B1(n239), .A0N(\Reg_File[8][0] ), .A1N(n239), 
        .Y(n114) );
  OAI2BB2X1M U165 ( .B0(n282), .B1(n238), .A0N(\Reg_File[8][1] ), .A1N(n239), 
        .Y(n115) );
  OAI2BB2X1M U166 ( .B0(n281), .B1(n238), .A0N(\Reg_File[8][2] ), .A1N(n239), 
        .Y(n116) );
  OAI2BB2X1M U167 ( .B0(n280), .B1(n238), .A0N(\Reg_File[8][3] ), .A1N(n239), 
        .Y(n117) );
  OAI2BB2X1M U168 ( .B0(n279), .B1(n238), .A0N(\Reg_File[8][4] ), .A1N(n239), 
        .Y(n118) );
  OAI2BB2X1M U169 ( .B0(n277), .B1(n238), .A0N(\Reg_File[8][6] ), .A1N(n239), 
        .Y(n120) );
  OAI2BB2X1M U170 ( .B0(n283), .B1(n237), .A0N(\Reg_File[9][0] ), .A1N(n237), 
        .Y(n122) );
  OAI2BB2X1M U171 ( .B0(n282), .B1(n236), .A0N(\Reg_File[9][1] ), .A1N(n237), 
        .Y(n123) );
  OAI2BB2X1M U172 ( .B0(n281), .B1(n236), .A0N(\Reg_File[9][2] ), .A1N(n237), 
        .Y(n124) );
  OAI2BB2X1M U173 ( .B0(n280), .B1(n236), .A0N(\Reg_File[9][3] ), .A1N(n237), 
        .Y(n125) );
  OAI2BB2X1M U174 ( .B0(n279), .B1(n236), .A0N(\Reg_File[9][4] ), .A1N(n237), 
        .Y(n126) );
  OAI2BB2X1M U175 ( .B0(n277), .B1(n236), .A0N(\Reg_File[9][6] ), .A1N(n237), 
        .Y(n128) );
  OAI2BB2X1M U176 ( .B0(n283), .B1(n235), .A0N(\Reg_File[10][0] ), .A1N(n235), 
        .Y(n130) );
  OAI2BB2X1M U177 ( .B0(n282), .B1(n234), .A0N(\Reg_File[10][1] ), .A1N(n235), 
        .Y(n131) );
  OAI2BB2X1M U178 ( .B0(n281), .B1(n234), .A0N(\Reg_File[10][2] ), .A1N(n235), 
        .Y(n132) );
  OAI2BB2X1M U179 ( .B0(n280), .B1(n234), .A0N(\Reg_File[10][3] ), .A1N(n235), 
        .Y(n133) );
  OAI2BB2X1M U180 ( .B0(n279), .B1(n234), .A0N(\Reg_File[10][4] ), .A1N(n235), 
        .Y(n134) );
  OAI2BB2X1M U181 ( .B0(n277), .B1(n234), .A0N(\Reg_File[10][6] ), .A1N(n235), 
        .Y(n136) );
  OAI2BB2X1M U182 ( .B0(n283), .B1(n233), .A0N(\Reg_File[11][0] ), .A1N(n233), 
        .Y(n138) );
  OAI2BB2X1M U183 ( .B0(n282), .B1(n232), .A0N(\Reg_File[11][1] ), .A1N(n233), 
        .Y(n139) );
  OAI2BB2X1M U184 ( .B0(n281), .B1(n232), .A0N(\Reg_File[11][2] ), .A1N(n233), 
        .Y(n140) );
  OAI2BB2X1M U185 ( .B0(n280), .B1(n232), .A0N(\Reg_File[11][3] ), .A1N(n233), 
        .Y(n141) );
  OAI2BB2X1M U186 ( .B0(n279), .B1(n232), .A0N(\Reg_File[11][4] ), .A1N(n233), 
        .Y(n142) );
  OAI2BB2X1M U187 ( .B0(n277), .B1(n232), .A0N(\Reg_File[11][6] ), .A1N(n233), 
        .Y(n144) );
  OAI2BB2X1M U188 ( .B0(n283), .B1(n231), .A0N(\Reg_File[12][0] ), .A1N(n231), 
        .Y(n146) );
  OAI2BB2X1M U189 ( .B0(n282), .B1(n230), .A0N(\Reg_File[12][1] ), .A1N(n230), 
        .Y(n147) );
  OAI2BB2X1M U190 ( .B0(n281), .B1(n231), .A0N(\Reg_File[12][2] ), .A1N(n231), 
        .Y(n148) );
  OAI2BB2X1M U191 ( .B0(n280), .B1(n230), .A0N(\Reg_File[12][3] ), .A1N(n230), 
        .Y(n149) );
  OAI2BB2X1M U192 ( .B0(n279), .B1(n231), .A0N(\Reg_File[12][4] ), .A1N(n231), 
        .Y(n150) );
  OAI2BB2X1M U193 ( .B0(n277), .B1(n231), .A0N(\Reg_File[12][6] ), .A1N(n231), 
        .Y(n152) );
  OAI2BB2X1M U194 ( .B0(n283), .B1(n229), .A0N(\Reg_File[13][0] ), .A1N(n229), 
        .Y(n154) );
  OAI2BB2X1M U195 ( .B0(n282), .B1(n228), .A0N(\Reg_File[13][1] ), .A1N(n228), 
        .Y(n155) );
  OAI2BB2X1M U196 ( .B0(n281), .B1(n229), .A0N(\Reg_File[13][2] ), .A1N(n229), 
        .Y(n156) );
  OAI2BB2X1M U197 ( .B0(n280), .B1(n228), .A0N(\Reg_File[13][3] ), .A1N(n228), 
        .Y(n157) );
  OAI2BB2X1M U198 ( .B0(n279), .B1(n229), .A0N(\Reg_File[13][4] ), .A1N(n229), 
        .Y(n158) );
  OAI2BB2X1M U199 ( .B0(n277), .B1(n229), .A0N(\Reg_File[13][6] ), .A1N(n229), 
        .Y(n160) );
  OAI2BB2X1M U200 ( .B0(n283), .B1(n227), .A0N(\Reg_File[14][0] ), .A1N(n227), 
        .Y(n162) );
  OAI2BB2X1M U201 ( .B0(n282), .B1(n226), .A0N(\Reg_File[14][1] ), .A1N(n226), 
        .Y(n163) );
  OAI2BB2X1M U202 ( .B0(n281), .B1(n227), .A0N(\Reg_File[14][2] ), .A1N(n227), 
        .Y(n164) );
  OAI2BB2X1M U203 ( .B0(n280), .B1(n226), .A0N(\Reg_File[14][3] ), .A1N(n226), 
        .Y(n165) );
  OAI2BB2X1M U204 ( .B0(n279), .B1(n227), .A0N(\Reg_File[14][4] ), .A1N(n227), 
        .Y(n166) );
  OAI2BB2X1M U205 ( .B0(n277), .B1(n227), .A0N(\Reg_File[14][6] ), .A1N(n227), 
        .Y(n168) );
  OAI2BB2X1M U206 ( .B0(n283), .B1(n225), .A0N(\Reg_File[15][0] ), .A1N(n225), 
        .Y(n170) );
  OAI2BB2X1M U207 ( .B0(n282), .B1(n224), .A0N(\Reg_File[15][1] ), .A1N(n224), 
        .Y(n171) );
  OAI2BB2X1M U208 ( .B0(n281), .B1(n225), .A0N(\Reg_File[15][2] ), .A1N(n225), 
        .Y(n172) );
  OAI2BB2X1M U209 ( .B0(n280), .B1(n224), .A0N(\Reg_File[15][3] ), .A1N(n224), 
        .Y(n173) );
  OAI2BB2X1M U210 ( .B0(n279), .B1(n225), .A0N(\Reg_File[15][4] ), .A1N(n225), 
        .Y(n174) );
  OAI2BB2X1M U211 ( .B0(n277), .B1(n225), .A0N(\Reg_File[15][6] ), .A1N(n225), 
        .Y(n176) );
  OAI2BB2X1M U212 ( .B0(n254), .B1(n278), .A0N(r0[5]), .A1N(n255), .Y(n55) );
  OAI2BB2X1M U213 ( .B0(n254), .B1(n276), .A0N(r0[7]), .A1N(n255), .Y(n57) );
  OAI2BB2X1M U214 ( .B0(n278), .B1(n252), .A0N(r1[5]), .A1N(n253), .Y(n63) );
  OAI2BB2X1M U215 ( .B0(n276), .B1(n252), .A0N(r1[7]), .A1N(n253), .Y(n65) );
  OAI2BB2X1M U216 ( .B0(n278), .B1(n250), .A0N(r2[5]), .A1N(n251), .Y(n71) );
  OAI2BB2X1M U217 ( .B0(n276), .B1(n248), .A0N(r3[7]), .A1N(n249), .Y(n81) );
  OAI2BB2X1M U218 ( .B0(n278), .B1(n246), .A0N(\Reg_File[4][5] ), .A1N(n246), 
        .Y(n87) );
  OAI2BB2X1M U219 ( .B0(n276), .B1(n246), .A0N(\Reg_File[4][7] ), .A1N(n246), 
        .Y(n89) );
  OAI2BB2X1M U220 ( .B0(n278), .B1(n244), .A0N(\Reg_File[5][5] ), .A1N(n244), 
        .Y(n95) );
  OAI2BB2X1M U221 ( .B0(n276), .B1(n244), .A0N(\Reg_File[5][7] ), .A1N(n244), 
        .Y(n97) );
  OAI2BB2X1M U222 ( .B0(n278), .B1(n242), .A0N(\Reg_File[6][5] ), .A1N(n242), 
        .Y(n103) );
  OAI2BB2X1M U223 ( .B0(n276), .B1(n242), .A0N(\Reg_File[6][7] ), .A1N(n242), 
        .Y(n105) );
  OAI2BB2X1M U224 ( .B0(n278), .B1(n240), .A0N(\Reg_File[7][5] ), .A1N(n240), 
        .Y(n111) );
  OAI2BB2X1M U225 ( .B0(n276), .B1(n240), .A0N(\Reg_File[7][7] ), .A1N(n240), 
        .Y(n113) );
  OAI2BB2X1M U226 ( .B0(n278), .B1(n238), .A0N(\Reg_File[8][5] ), .A1N(n239), 
        .Y(n119) );
  OAI2BB2X1M U227 ( .B0(n276), .B1(n238), .A0N(\Reg_File[8][7] ), .A1N(n239), 
        .Y(n121) );
  OAI2BB2X1M U228 ( .B0(n278), .B1(n236), .A0N(\Reg_File[9][5] ), .A1N(n237), 
        .Y(n127) );
  OAI2BB2X1M U229 ( .B0(n276), .B1(n236), .A0N(\Reg_File[9][7] ), .A1N(n237), 
        .Y(n129) );
  OAI2BB2X1M U230 ( .B0(n278), .B1(n234), .A0N(\Reg_File[10][5] ), .A1N(n235), 
        .Y(n135) );
  OAI2BB2X1M U231 ( .B0(n276), .B1(n234), .A0N(\Reg_File[10][7] ), .A1N(n235), 
        .Y(n137) );
  OAI2BB2X1M U232 ( .B0(n278), .B1(n232), .A0N(\Reg_File[11][5] ), .A1N(n233), 
        .Y(n143) );
  OAI2BB2X1M U233 ( .B0(n276), .B1(n232), .A0N(\Reg_File[11][7] ), .A1N(n233), 
        .Y(n145) );
  OAI2BB2X1M U234 ( .B0(n278), .B1(n230), .A0N(\Reg_File[12][5] ), .A1N(n230), 
        .Y(n151) );
  OAI2BB2X1M U235 ( .B0(n276), .B1(n230), .A0N(\Reg_File[12][7] ), .A1N(n230), 
        .Y(n153) );
  OAI2BB2X1M U236 ( .B0(n278), .B1(n228), .A0N(\Reg_File[13][5] ), .A1N(n228), 
        .Y(n159) );
  OAI2BB2X1M U237 ( .B0(n276), .B1(n228), .A0N(\Reg_File[13][7] ), .A1N(n228), 
        .Y(n161) );
  OAI2BB2X1M U238 ( .B0(n278), .B1(n226), .A0N(\Reg_File[14][5] ), .A1N(n226), 
        .Y(n167) );
  OAI2BB2X1M U239 ( .B0(n276), .B1(n226), .A0N(\Reg_File[14][7] ), .A1N(n226), 
        .Y(n169) );
  OAI2BB2X1M U240 ( .B0(n278), .B1(n224), .A0N(\Reg_File[15][5] ), .A1N(n224), 
        .Y(n175) );
  OAI2BB2X1M U241 ( .B0(n276), .B1(n224), .A0N(\Reg_File[15][7] ), .A1N(n224), 
        .Y(n177) );
  OAI2BB2X1M U242 ( .B0(n283), .B1(n251), .A0N(r2[0]), .A1N(n251), .Y(n66) );
  OAI2BB2X1M U243 ( .B0(n276), .B1(n250), .A0N(r2[7]), .A1N(n251), .Y(n73) );
  OAI2BB2X1M U244 ( .B0(n278), .B1(n248), .A0N(r3[5]), .A1N(n249), .Y(n79) );
  MX4X1M U245 ( .A(\Reg_File[4][2] ), .B(\Reg_File[5][2] ), .C(
        \Reg_File[6][2] ), .D(\Reg_File[7][2] ), .S0(n222), .S1(n218), .Y(n196) );
  MX4X1M U246 ( .A(\Reg_File[4][3] ), .B(\Reg_File[5][3] ), .C(
        \Reg_File[6][3] ), .D(\Reg_File[7][3] ), .S0(n222), .S1(n218), .Y(n200) );
  MX4X1M U247 ( .A(\Reg_File[4][4] ), .B(\Reg_File[5][4] ), .C(
        \Reg_File[6][4] ), .D(\Reg_File[7][4] ), .S0(n222), .S1(n218), .Y(n204) );
  MX4X1M U248 ( .A(\Reg_File[4][5] ), .B(\Reg_File[5][5] ), .C(
        \Reg_File[6][5] ), .D(\Reg_File[7][5] ), .S0(n223), .S1(n219), .Y(n208) );
  MX4X1M U249 ( .A(\Reg_File[4][6] ), .B(\Reg_File[5][6] ), .C(
        \Reg_File[6][6] ), .D(\Reg_File[7][6] ), .S0(n223), .S1(n219), .Y(n212) );
  MX4X1M U250 ( .A(\Reg_File[4][7] ), .B(\Reg_File[5][7] ), .C(
        \Reg_File[6][7] ), .D(\Reg_File[7][7] ), .S0(n223), .S1(n219), .Y(n216) );
  MX4X1M U251 ( .A(\Reg_File[12][2] ), .B(\Reg_File[13][2] ), .C(
        \Reg_File[14][2] ), .D(\Reg_File[15][2] ), .S0(n222), .S1(n218), .Y(
        n194) );
  MX4X1M U252 ( .A(\Reg_File[12][3] ), .B(\Reg_File[13][3] ), .C(
        \Reg_File[14][3] ), .D(\Reg_File[15][3] ), .S0(n222), .S1(n218), .Y(
        n198) );
  MX4X1M U253 ( .A(\Reg_File[12][4] ), .B(\Reg_File[13][4] ), .C(
        \Reg_File[14][4] ), .D(\Reg_File[15][4] ), .S0(n222), .S1(n218), .Y(
        n202) );
  MX4X1M U254 ( .A(\Reg_File[12][5] ), .B(\Reg_File[13][5] ), .C(
        \Reg_File[14][5] ), .D(\Reg_File[15][5] ), .S0(n223), .S1(n219), .Y(
        n206) );
  MX4X1M U255 ( .A(\Reg_File[12][6] ), .B(\Reg_File[13][6] ), .C(
        \Reg_File[14][6] ), .D(\Reg_File[15][6] ), .S0(n223), .S1(n219), .Y(
        n210) );
  MX4X1M U256 ( .A(\Reg_File[12][7] ), .B(\Reg_File[13][7] ), .C(
        \Reg_File[14][7] ), .D(\Reg_File[15][7] ), .S0(n223), .S1(n219), .Y(
        n214) );
  MX4X1M U257 ( .A(\Reg_File[4][0] ), .B(\Reg_File[5][0] ), .C(
        \Reg_File[6][0] ), .D(\Reg_File[7][0] ), .S0(n222), .S1(n218), .Y(n188) );
  MX4X1M U258 ( .A(\Reg_File[4][1] ), .B(\Reg_File[5][1] ), .C(
        \Reg_File[6][1] ), .D(\Reg_File[7][1] ), .S0(n221), .S1(n218), .Y(n192) );
  MX4X1M U259 ( .A(\Reg_File[12][0] ), .B(\Reg_File[13][0] ), .C(
        \Reg_File[14][0] ), .D(\Reg_File[15][0] ), .S0(n223), .S1(n219), .Y(
        n186) );
  MX4X1M U260 ( .A(\Reg_File[12][1] ), .B(\Reg_File[13][1] ), .C(
        \Reg_File[14][1] ), .D(\Reg_File[15][1] ), .S0(n220), .S1(n219), .Y(
        n190) );
  AO22X1M U261 ( .A0(N43), .A1(n274), .B0(RdData[0]), .B1(n256), .Y(n42) );
  MX4XLM U262 ( .A(n189), .B(n187), .C(n188), .D(n186), .S0(N14), .S1(N13), 
        .Y(N43) );
  MX4X1M U263 ( .A(r0[0]), .B(r1[0]), .C(r2[0]), .D(r3[0]), .S0(N11), .S1(N12), 
        .Y(n189) );
  MX4X1M U264 ( .A(\Reg_File[8][0] ), .B(\Reg_File[9][0] ), .C(
        \Reg_File[10][0] ), .D(\Reg_File[11][0] ), .S0(n220), .S1(n218), .Y(
        n187) );
  AO22X1M U265 ( .A0(N42), .A1(n274), .B0(RdData[1]), .B1(n256), .Y(n43) );
  MX4XLM U266 ( .A(n193), .B(n191), .C(n192), .D(n190), .S0(N14), .S1(N13), 
        .Y(N42) );
  MX4X1M U267 ( .A(r0[1]), .B(r1[1]), .C(r2[1]), .D(r3[1]), .S0(N11), .S1(n218), .Y(n193) );
  MX4X1M U268 ( .A(\Reg_File[8][1] ), .B(\Reg_File[9][1] ), .C(
        \Reg_File[10][1] ), .D(\Reg_File[11][1] ), .S0(n221), .S1(N12), .Y(
        n191) );
  AO22X1M U269 ( .A0(N41), .A1(n274), .B0(RdData[2]), .B1(n256), .Y(n44) );
  MX4XLM U270 ( .A(n197), .B(n195), .C(n196), .D(n194), .S0(N14), .S1(N13), 
        .Y(N41) );
  MX4X1M U271 ( .A(\Reg_File[8][2] ), .B(\Reg_File[9][2] ), .C(
        \Reg_File[10][2] ), .D(\Reg_File[11][2] ), .S0(n222), .S1(n218), .Y(
        n195) );
  AO22X1M U272 ( .A0(N40), .A1(n274), .B0(RdData[3]), .B1(n256), .Y(n45) );
  MX4XLM U273 ( .A(n201), .B(n199), .C(n200), .D(n198), .S0(N14), .S1(N13), 
        .Y(N40) );
  MX4X1M U274 ( .A(r0[3]), .B(r1[3]), .C(r2[3]), .D(r3[3]), .S0(n222), .S1(
        n218), .Y(n201) );
  MX4X1M U275 ( .A(\Reg_File[8][3] ), .B(\Reg_File[9][3] ), .C(
        \Reg_File[10][3] ), .D(\Reg_File[11][3] ), .S0(n222), .S1(n218), .Y(
        n199) );
  AO22X1M U276 ( .A0(N39), .A1(n274), .B0(RdData[4]), .B1(n256), .Y(n46) );
  MX4XLM U277 ( .A(n205), .B(n203), .C(n204), .D(n202), .S0(N14), .S1(N13), 
        .Y(N39) );
  MX4X1M U278 ( .A(r0[4]), .B(r1[4]), .C(r2[4]), .D(r3[4]), .S0(n222), .S1(
        n219), .Y(n205) );
  MX4X1M U279 ( .A(\Reg_File[8][4] ), .B(\Reg_File[9][4] ), .C(
        \Reg_File[10][4] ), .D(\Reg_File[11][4] ), .S0(n222), .S1(n218), .Y(
        n203) );
  AO22X1M U280 ( .A0(N38), .A1(n274), .B0(RdData[5]), .B1(n256), .Y(n47) );
  MX4XLM U281 ( .A(n209), .B(n207), .C(n208), .D(n206), .S0(N14), .S1(N13), 
        .Y(N38) );
  MX4X1M U282 ( .A(r0[5]), .B(r1[5]), .C(r2[5]), .D(r3[5]), .S0(n223), .S1(
        n219), .Y(n209) );
  MX4X1M U283 ( .A(\Reg_File[8][5] ), .B(\Reg_File[9][5] ), .C(
        \Reg_File[10][5] ), .D(\Reg_File[11][5] ), .S0(n223), .S1(n219), .Y(
        n207) );
  AO22X1M U284 ( .A0(N37), .A1(n274), .B0(RdData[6]), .B1(n256), .Y(n48) );
  MX4XLM U285 ( .A(n213), .B(n211), .C(n212), .D(n210), .S0(N14), .S1(N13), 
        .Y(N37) );
  MX4X1M U286 ( .A(r0[6]), .B(r1[6]), .C(r2[6]), .D(r3[6]), .S0(n223), .S1(
        n219), .Y(n213) );
  MX4X1M U287 ( .A(\Reg_File[8][6] ), .B(\Reg_File[9][6] ), .C(
        \Reg_File[10][6] ), .D(\Reg_File[11][6] ), .S0(n223), .S1(n219), .Y(
        n211) );
  AO22X1M U288 ( .A0(N36), .A1(n274), .B0(RdData[7]), .B1(n256), .Y(n49) );
  MX4XLM U289 ( .A(n217), .B(n215), .C(n216), .D(n214), .S0(N14), .S1(N13), 
        .Y(N36) );
  MX4X1M U290 ( .A(r0[7]), .B(r1[7]), .C(r2[7]), .D(r3[7]), .S0(n223), .S1(
        n219), .Y(n217) );
  MX4X1M U291 ( .A(\Reg_File[8][7] ), .B(\Reg_File[9][7] ), .C(
        \Reg_File[10][7] ), .D(\Reg_File[11][7] ), .S0(n223), .S1(n219), .Y(
        n215) );
  INVX2M U292 ( .A(N11), .Y(n258) );
  AO21XLM U293 ( .A0(d_valid), .A1(n13), .B0(n274), .Y(n41) );
endmodule


module RST_SYNC_0 ( clk, rst, sync_rst );
  input clk, rst;
  output sync_rst;
  wire   \stages[0] ;

  DFFRQX1M \stages_reg[1]  ( .D(\stages[0] ), .CK(clk), .RN(rst), .Q(sync_rst)
         );
  DFFRQX1M \stages_reg[0]  ( .D(1'b1), .CK(clk), .RN(rst), .Q(\stages[0] ) );
endmodule


module RST_SYNC_1 ( clk, rst, sync_rst );
  input clk, rst;
  output sync_rst;
  wire   \stages[0] ;

  DFFRQX1M \stages_reg[1]  ( .D(\stages[0] ), .CK(clk), .RN(rst), .Q(sync_rst)
         );
  DFFRQX1M \stages_reg[0]  ( .D(1'b1), .CK(clk), .RN(rst), .Q(\stages[0] ) );
endmodule


module CLK_GATE ( CLK_EN, CLK, GATED_CLK );
  input CLK_EN, CLK;
  output GATED_CLK;
  wire   Latch_Out;

  TLATNX1M Latch_Out_reg ( .D(CLK_EN), .GN(CLK), .Q(Latch_Out) );
  AND2X1M U2 ( .A(Latch_Out), .B(CLK), .Y(GATED_CLK) );
endmodule


module CLK_DIV_0_DW01_inc_0 ( A, SUM );
  input [6:0] A;
  output [6:0] SUM;

  wire   [6:2] carry;

  ADDHX1M U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHX1M U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHX1M U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHX1M U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHX1M U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  INVX2M U1 ( .A(A[0]), .Y(SUM[0]) );
  CLKXOR2X2M U2 ( .A(carry[6]), .B(A[6]), .Y(SUM[6]) );
endmodule


module CLK_DIV_0 ( i_ref_clk, i_rst, i_clk_en, i_div_ratio, o_div_clk );
  input [7:0] i_div_ratio;
  input i_ref_clk, i_rst, i_clk_en;
  output o_div_clk;
  wire   div_clk, odd_edge_tog, N16, N17, N18, N19, N20, N21, N22, n17, n18,
         n19, n20, n21, n22, n23, n24, n25, n1, n2, n3, n4, n5, n6, n7, n8, n9,
         n10, n11, n12, n13, n14, n15, n16, n26, n27, n28, n29, n30, n31, n32,
         n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46;
  wire   [6:0] count;
  wire   [6:0] edge_flip_half;

  CLK_DIV_0_DW01_inc_0 add_49 ( .A(count), .SUM({N22, N21, N20, N19, N18, N17, 
        N16}) );
  DFFRQX1M div_clk_reg ( .D(n18), .CK(i_ref_clk), .RN(n2), .Q(div_clk) );
  DFFSQX2M odd_edge_tog_reg ( .D(n17), .CK(i_ref_clk), .SN(n2), .Q(
        odd_edge_tog) );
  DFFRQX2M \count_reg[6]  ( .D(n19), .CK(i_ref_clk), .RN(n2), .Q(count[6]) );
  DFFRQX4M \count_reg[0]  ( .D(n25), .CK(i_ref_clk), .RN(n2), .Q(count[0]) );
  DFFRQX2M \count_reg[5]  ( .D(n20), .CK(i_ref_clk), .RN(n2), .Q(count[5]) );
  DFFRQX2M \count_reg[4]  ( .D(n21), .CK(i_ref_clk), .RN(n2), .Q(count[4]) );
  DFFRQX2M \count_reg[3]  ( .D(n22), .CK(i_ref_clk), .RN(n2), .Q(count[3]) );
  DFFRQX2M \count_reg[2]  ( .D(n23), .CK(i_ref_clk), .RN(n2), .Q(count[2]) );
  DFFRQX2M \count_reg[1]  ( .D(n24), .CK(i_ref_clk), .RN(n2), .Q(count[1]) );
  NOR4X2M U3 ( .A(n34), .B(n35), .C(n36), .D(n37), .Y(n33) );
  NOR2X4M U4 ( .A(n5), .B(i_div_ratio[4]), .Y(n6) );
  AND3X4M U5 ( .A(n12), .B(n13), .C(n46), .Y(n11) );
  NAND4X2M U6 ( .A(n30), .B(n31), .C(n32), .D(n33), .Y(n15) );
  AO22XLM U7 ( .A0(n1), .A1(count[6]), .B0(N22), .B1(n11), .Y(n19) );
  AO22XLM U8 ( .A0(n1), .A1(count[1]), .B0(N17), .B1(n11), .Y(n24) );
  AO22XLM U9 ( .A0(n1), .A1(count[2]), .B0(N18), .B1(n11), .Y(n23) );
  AO22XLM U10 ( .A0(n1), .A1(count[3]), .B0(N19), .B1(n11), .Y(n22) );
  AO22XLM U11 ( .A0(n1), .A1(count[4]), .B0(N20), .B1(n11), .Y(n21) );
  AO22XLM U12 ( .A0(n1), .A1(count[5]), .B0(N21), .B1(n11), .Y(n20) );
  NAND2BX2M U13 ( .AN(i_div_ratio[2]), .B(edge_flip_half[0]), .Y(n4) );
  OR2X2M U14 ( .A(n4), .B(i_div_ratio[3]), .Y(n5) );
  OAI2BB1XLM U15 ( .A0N(i_div_ratio[1]), .A1N(i_div_ratio[2]), .B0(n4), .Y(
        edge_flip_half[1]) );
  INVX4M U16 ( .A(n3), .Y(n2) );
  INVX2M U17 ( .A(i_rst), .Y(n3) );
  CLKBUFX6M U18 ( .A(n10), .Y(n1) );
  OAI21X2M U19 ( .A0(n26), .A1(n27), .B0(i_clk_en), .Y(n10) );
  INVX2M U20 ( .A(i_div_ratio[1]), .Y(edge_flip_half[0]) );
  INVX2M U21 ( .A(i_div_ratio[5]), .Y(n9) );
  MX2XLM U22 ( .A(i_ref_clk), .B(div_clk), .S0(n46), .Y(o_div_clk) );
  OAI2BB1X1M U23 ( .A0N(n4), .A1N(i_div_ratio[3]), .B0(n5), .Y(
        edge_flip_half[2]) );
  AO21XLM U24 ( .A0(n5), .A1(i_div_ratio[4]), .B0(n6), .Y(edge_flip_half[3])
         );
  CLKNAND2X2M U25 ( .A(n6), .B(n9), .Y(n7) );
  OAI21X1M U26 ( .A0(n6), .A1(n9), .B0(n7), .Y(edge_flip_half[4]) );
  XNOR2X1M U27 ( .A(i_div_ratio[6]), .B(n7), .Y(edge_flip_half[5]) );
  NOR2X1M U28 ( .A(i_div_ratio[6]), .B(n7), .Y(n8) );
  CLKXOR2X2M U29 ( .A(i_div_ratio[7]), .B(n8), .Y(edge_flip_half[6]) );
  AO22X1M U30 ( .A0(n1), .A1(count[0]), .B0(N16), .B1(n11), .Y(n25) );
  CLKINVX1M U31 ( .A(n1), .Y(n46) );
  CLKXOR2X2M U32 ( .A(div_clk), .B(n14), .Y(n18) );
  AOI21X1M U33 ( .A0(n13), .A1(n12), .B0(n1), .Y(n14) );
  OR2X1M U34 ( .A(n15), .B(i_div_ratio[0]), .Y(n12) );
  XNOR2X1M U35 ( .A(odd_edge_tog), .B(n16), .Y(n17) );
  OR2X1M U36 ( .A(n13), .B(n1), .Y(n16) );
  OR3X1M U37 ( .A(i_div_ratio[2]), .B(i_div_ratio[3]), .C(i_div_ratio[1]), .Y(
        n27) );
  OR4X1M U38 ( .A(i_div_ratio[4]), .B(i_div_ratio[5]), .C(i_div_ratio[6]), .D(
        i_div_ratio[7]), .Y(n26) );
  CLKNAND2X2M U39 ( .A(n28), .B(i_div_ratio[0]), .Y(n13) );
  MXI2X1M U40 ( .A(n29), .B(n15), .S0(odd_edge_tog), .Y(n28) );
  CLKXOR2X2M U41 ( .A(edge_flip_half[2]), .B(count[2]), .Y(n37) );
  CLKXOR2X2M U42 ( .A(edge_flip_half[1]), .B(count[1]), .Y(n36) );
  CLKXOR2X2M U43 ( .A(edge_flip_half[0]), .B(count[0]), .Y(n35) );
  CLKXOR2X2M U44 ( .A(edge_flip_half[6]), .B(count[6]), .Y(n34) );
  XNOR2X1M U45 ( .A(count[4]), .B(edge_flip_half[4]), .Y(n32) );
  XNOR2X1M U46 ( .A(count[5]), .B(edge_flip_half[5]), .Y(n31) );
  XNOR2X1M U47 ( .A(count[3]), .B(edge_flip_half[3]), .Y(n30) );
  NAND4X1M U48 ( .A(n38), .B(n39), .C(n40), .D(n41), .Y(n29) );
  NOR4X1M U49 ( .A(n42), .B(n43), .C(n44), .D(n45), .Y(n41) );
  CLKXOR2X2M U50 ( .A(i_div_ratio[3]), .B(count[2]), .Y(n45) );
  CLKXOR2X2M U51 ( .A(i_div_ratio[2]), .B(count[1]), .Y(n44) );
  CLKXOR2X2M U52 ( .A(i_div_ratio[1]), .B(count[0]), .Y(n43) );
  CLKXOR2X2M U53 ( .A(i_div_ratio[7]), .B(count[6]), .Y(n42) );
  XNOR2X1M U54 ( .A(count[4]), .B(i_div_ratio[5]), .Y(n40) );
  XNOR2X1M U55 ( .A(count[5]), .B(i_div_ratio[6]), .Y(n39) );
  XNOR2X1M U56 ( .A(count[3]), .B(i_div_ratio[4]), .Y(n38) );
endmodule


module CLK_DIV_1_DW01_inc_0 ( A, SUM );
  input [6:0] A;
  output [6:0] SUM;

  wire   [6:2] carry;

  ADDHX1M U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHX1M U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHX1M U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHX1M U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHX1M U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  INVX2M U1 ( .A(A[0]), .Y(SUM[0]) );
  CLKXOR2X2M U2 ( .A(carry[6]), .B(A[6]), .Y(SUM[6]) );
endmodule


module CLK_DIV_1 ( i_ref_clk, i_rst, i_clk_en, i_div_ratio, o_div_clk );
  input [7:0] i_div_ratio;
  input i_ref_clk, i_rst, i_clk_en;
  output o_div_clk;
  wire   div_clk, odd_edge_tog, N16, N17, N18, N19, N20, N21, N22, n1, n2, n3,
         n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n26, n27,
         n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41,
         n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55;
  wire   [6:0] count;
  wire   [6:0] edge_flip_half;

  CLK_DIV_1_DW01_inc_0 add_49 ( .A(count), .SUM({N22, N21, N20, N19, N18, N17, 
        N16}) );
  DFFRQX1M div_clk_reg ( .D(n54), .CK(i_ref_clk), .RN(n2), .Q(div_clk) );
  DFFSQX2M odd_edge_tog_reg ( .D(n55), .CK(i_ref_clk), .SN(n2), .Q(
        odd_edge_tog) );
  DFFRQX2M \count_reg[6]  ( .D(n53), .CK(i_ref_clk), .RN(n2), .Q(count[6]) );
  DFFRQX4M \count_reg[0]  ( .D(n47), .CK(i_ref_clk), .RN(n2), .Q(count[0]) );
  DFFRQX2M \count_reg[5]  ( .D(n52), .CK(i_ref_clk), .RN(n2), .Q(count[5]) );
  DFFRQX2M \count_reg[4]  ( .D(n51), .CK(i_ref_clk), .RN(n2), .Q(count[4]) );
  DFFRQX2M \count_reg[3]  ( .D(n50), .CK(i_ref_clk), .RN(n2), .Q(count[3]) );
  DFFRQX2M \count_reg[2]  ( .D(n49), .CK(i_ref_clk), .RN(n2), .Q(count[2]) );
  DFFRQX2M \count_reg[1]  ( .D(n48), .CK(i_ref_clk), .RN(n2), .Q(count[1]) );
  NOR4X2M U3 ( .A(n34), .B(n35), .C(n36), .D(n37), .Y(n33) );
  NOR2X4M U4 ( .A(n5), .B(i_div_ratio[4]), .Y(n6) );
  AND3X4M U5 ( .A(n12), .B(n13), .C(n46), .Y(n11) );
  AO22XLM U6 ( .A0(n1), .A1(count[1]), .B0(N17), .B1(n11), .Y(n48) );
  AO22XLM U7 ( .A0(n1), .A1(count[2]), .B0(N18), .B1(n11), .Y(n49) );
  AO22XLM U8 ( .A0(n1), .A1(count[3]), .B0(N19), .B1(n11), .Y(n50) );
  AO22XLM U9 ( .A0(n1), .A1(count[4]), .B0(N20), .B1(n11), .Y(n51) );
  AO22XLM U10 ( .A0(n1), .A1(count[5]), .B0(N21), .B1(n11), .Y(n52) );
  AO22XLM U11 ( .A0(n1), .A1(count[6]), .B0(N22), .B1(n11), .Y(n53) );
  NAND4X2M U12 ( .A(n30), .B(n31), .C(n32), .D(n33), .Y(n15) );
  OR2X2M U13 ( .A(n4), .B(i_div_ratio[3]), .Y(n5) );
  OAI2BB1XLM U14 ( .A0N(n4), .A1N(i_div_ratio[3]), .B0(n5), .Y(
        edge_flip_half[2]) );
  NAND2BX2M U15 ( .AN(i_div_ratio[2]), .B(edge_flip_half[0]), .Y(n4) );
  INVX4M U16 ( .A(n3), .Y(n2) );
  INVX2M U17 ( .A(i_rst), .Y(n3) );
  CLKBUFX6M U18 ( .A(n10), .Y(n1) );
  OAI21X2M U19 ( .A0(n26), .A1(n27), .B0(i_clk_en), .Y(n10) );
  INVX2M U20 ( .A(i_div_ratio[1]), .Y(edge_flip_half[0]) );
  INVX2M U21 ( .A(i_div_ratio[5]), .Y(n9) );
  MX2XLM U22 ( .A(i_ref_clk), .B(div_clk), .S0(n46), .Y(o_div_clk) );
  OAI2BB1X1M U23 ( .A0N(i_div_ratio[1]), .A1N(i_div_ratio[2]), .B0(n4), .Y(
        edge_flip_half[1]) );
  AO21XLM U24 ( .A0(n5), .A1(i_div_ratio[4]), .B0(n6), .Y(edge_flip_half[3])
         );
  CLKNAND2X2M U25 ( .A(n6), .B(n9), .Y(n7) );
  OAI21X1M U26 ( .A0(n6), .A1(n9), .B0(n7), .Y(edge_flip_half[4]) );
  XNOR2X1M U27 ( .A(i_div_ratio[6]), .B(n7), .Y(edge_flip_half[5]) );
  NOR2X1M U28 ( .A(i_div_ratio[6]), .B(n7), .Y(n8) );
  CLKXOR2X2M U29 ( .A(i_div_ratio[7]), .B(n8), .Y(edge_flip_half[6]) );
  AO22X1M U30 ( .A0(n1), .A1(count[0]), .B0(N16), .B1(n11), .Y(n47) );
  CLKINVX1M U31 ( .A(n1), .Y(n46) );
  CLKXOR2X2M U32 ( .A(div_clk), .B(n14), .Y(n54) );
  AOI21X1M U33 ( .A0(n13), .A1(n12), .B0(n1), .Y(n14) );
  OR2X1M U34 ( .A(n15), .B(i_div_ratio[0]), .Y(n12) );
  XNOR2X1M U35 ( .A(odd_edge_tog), .B(n16), .Y(n55) );
  OR2X1M U36 ( .A(n13), .B(n1), .Y(n16) );
  OR3X1M U37 ( .A(i_div_ratio[2]), .B(i_div_ratio[3]), .C(i_div_ratio[1]), .Y(
        n27) );
  OR4X1M U38 ( .A(i_div_ratio[4]), .B(i_div_ratio[5]), .C(i_div_ratio[6]), .D(
        i_div_ratio[7]), .Y(n26) );
  CLKNAND2X2M U39 ( .A(n28), .B(i_div_ratio[0]), .Y(n13) );
  MXI2X1M U40 ( .A(n29), .B(n15), .S0(odd_edge_tog), .Y(n28) );
  CLKXOR2X2M U41 ( .A(edge_flip_half[2]), .B(count[2]), .Y(n37) );
  CLKXOR2X2M U42 ( .A(edge_flip_half[1]), .B(count[1]), .Y(n36) );
  CLKXOR2X2M U43 ( .A(edge_flip_half[0]), .B(count[0]), .Y(n35) );
  CLKXOR2X2M U44 ( .A(edge_flip_half[6]), .B(count[6]), .Y(n34) );
  XNOR2X1M U45 ( .A(count[4]), .B(edge_flip_half[4]), .Y(n32) );
  XNOR2X1M U46 ( .A(count[5]), .B(edge_flip_half[5]), .Y(n31) );
  XNOR2X1M U47 ( .A(count[3]), .B(edge_flip_half[3]), .Y(n30) );
  NAND4X1M U48 ( .A(n38), .B(n39), .C(n40), .D(n41), .Y(n29) );
  NOR4X1M U49 ( .A(n42), .B(n43), .C(n44), .D(n45), .Y(n41) );
  CLKXOR2X2M U50 ( .A(i_div_ratio[3]), .B(count[2]), .Y(n45) );
  CLKXOR2X2M U51 ( .A(i_div_ratio[2]), .B(count[1]), .Y(n44) );
  CLKXOR2X2M U52 ( .A(i_div_ratio[1]), .B(count[0]), .Y(n43) );
  CLKXOR2X2M U53 ( .A(i_div_ratio[7]), .B(count[6]), .Y(n42) );
  XNOR2X1M U54 ( .A(count[4]), .B(i_div_ratio[5]), .Y(n40) );
  XNOR2X1M U55 ( .A(count[5]), .B(i_div_ratio[6]), .Y(n39) );
  XNOR2X1M U56 ( .A(count[3]), .B(i_div_ratio[4]), .Y(n38) );
endmodule


module PULSE_GEN ( clk, rst, lvl_sig, pulse_sig );
  input clk, rst, lvl_sig;
  output pulse_sig;
  wire   pls_flop, rcv_flop;

  DFFRQX1M pls_flop_reg ( .D(rcv_flop), .CK(clk), .RN(rst), .Q(pls_flop) );
  DFFRQX1M rcv_flop_reg ( .D(lvl_sig), .CK(clk), .RN(rst), .Q(rcv_flop) );
  NOR2BX2M U3 ( .AN(rcv_flop), .B(pls_flop), .Y(pulse_sig) );
endmodule


module fifo_mem ( w_clk, w_rstn, w_full, w_inc, w_addr, r_addr, w_data, r_data
 );
  input [2:0] w_addr;
  input [2:0] r_addr;
  input [7:0] w_data;
  output [7:0] r_data;
  input w_clk, w_rstn, w_full, w_inc;
  wire   N9, N10, N11, \FIFO_MEM[7][7] , \FIFO_MEM[7][6] , \FIFO_MEM[7][5] ,
         \FIFO_MEM[7][4] , \FIFO_MEM[7][3] , \FIFO_MEM[7][2] ,
         \FIFO_MEM[7][1] , \FIFO_MEM[7][0] , \FIFO_MEM[6][7] ,
         \FIFO_MEM[6][6] , \FIFO_MEM[6][5] , \FIFO_MEM[6][4] ,
         \FIFO_MEM[6][3] , \FIFO_MEM[6][2] , \FIFO_MEM[6][1] ,
         \FIFO_MEM[6][0] , \FIFO_MEM[5][7] , \FIFO_MEM[5][6] ,
         \FIFO_MEM[5][5] , \FIFO_MEM[5][4] , \FIFO_MEM[5][3] ,
         \FIFO_MEM[5][2] , \FIFO_MEM[5][1] , \FIFO_MEM[5][0] ,
         \FIFO_MEM[4][7] , \FIFO_MEM[4][6] , \FIFO_MEM[4][5] ,
         \FIFO_MEM[4][4] , \FIFO_MEM[4][3] , \FIFO_MEM[4][2] ,
         \FIFO_MEM[4][1] , \FIFO_MEM[4][0] , \FIFO_MEM[3][7] ,
         \FIFO_MEM[3][6] , \FIFO_MEM[3][5] , \FIFO_MEM[3][4] ,
         \FIFO_MEM[3][3] , \FIFO_MEM[3][2] , \FIFO_MEM[3][1] ,
         \FIFO_MEM[3][0] , \FIFO_MEM[2][7] , \FIFO_MEM[2][6] ,
         \FIFO_MEM[2][5] , \FIFO_MEM[2][4] , \FIFO_MEM[2][3] ,
         \FIFO_MEM[2][2] , \FIFO_MEM[2][1] , \FIFO_MEM[2][0] ,
         \FIFO_MEM[1][7] , \FIFO_MEM[1][6] , \FIFO_MEM[1][5] ,
         \FIFO_MEM[1][4] , \FIFO_MEM[1][3] , \FIFO_MEM[1][2] ,
         \FIFO_MEM[1][1] , \FIFO_MEM[1][0] , \FIFO_MEM[0][7] ,
         \FIFO_MEM[0][6] , \FIFO_MEM[0][5] , \FIFO_MEM[0][4] ,
         \FIFO_MEM[0][3] , \FIFO_MEM[0][2] , \FIFO_MEM[0][1] ,
         \FIFO_MEM[0][0] , n12, n15, n16, n18, n19, n22, n23, n24, n25, n26,
         n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40,
         n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54,
         n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68,
         n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82,
         n83, n84, n85, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n13, n14,
         n17, n20, n21, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96,
         n97, n98, n99, n100, n101, n102, n103, n104, n105, n106, n107, n108,
         n109, n110, n111, n112, n113, n114, n115, n116, n117, n118, n119,
         n120, n121, n122, n123, n124, n125, n126, n127;
  assign N9 = r_addr[0];
  assign N10 = r_addr[1];
  assign N11 = r_addr[2];

  DFFRQX1M \FIFO_MEM_reg[5][7]  ( .D(n69), .CK(w_clk), .RN(n111), .Q(
        \FIFO_MEM[5][7] ) );
  DFFRQX1M \FIFO_MEM_reg[5][6]  ( .D(n68), .CK(w_clk), .RN(n111), .Q(
        \FIFO_MEM[5][6] ) );
  DFFRQX1M \FIFO_MEM_reg[5][5]  ( .D(n67), .CK(w_clk), .RN(n111), .Q(
        \FIFO_MEM[5][5] ) );
  DFFRQX1M \FIFO_MEM_reg[5][4]  ( .D(n66), .CK(w_clk), .RN(n111), .Q(
        \FIFO_MEM[5][4] ) );
  DFFRQX1M \FIFO_MEM_reg[5][3]  ( .D(n65), .CK(w_clk), .RN(n111), .Q(
        \FIFO_MEM[5][3] ) );
  DFFRQX1M \FIFO_MEM_reg[5][2]  ( .D(n64), .CK(w_clk), .RN(n111), .Q(
        \FIFO_MEM[5][2] ) );
  DFFRQX1M \FIFO_MEM_reg[5][1]  ( .D(n63), .CK(w_clk), .RN(n111), .Q(
        \FIFO_MEM[5][1] ) );
  DFFRQX1M \FIFO_MEM_reg[5][0]  ( .D(n62), .CK(w_clk), .RN(n111), .Q(
        \FIFO_MEM[5][0] ) );
  DFFRQX1M \FIFO_MEM_reg[1][7]  ( .D(n37), .CK(w_clk), .RN(n114), .Q(
        \FIFO_MEM[1][7] ) );
  DFFRQX1M \FIFO_MEM_reg[1][6]  ( .D(n36), .CK(w_clk), .RN(n114), .Q(
        \FIFO_MEM[1][6] ) );
  DFFRQX1M \FIFO_MEM_reg[1][5]  ( .D(n35), .CK(w_clk), .RN(n114), .Q(
        \FIFO_MEM[1][5] ) );
  DFFRQX1M \FIFO_MEM_reg[1][4]  ( .D(n34), .CK(w_clk), .RN(n114), .Q(
        \FIFO_MEM[1][4] ) );
  DFFRQX1M \FIFO_MEM_reg[1][3]  ( .D(n33), .CK(w_clk), .RN(n114), .Q(
        \FIFO_MEM[1][3] ) );
  DFFRQX1M \FIFO_MEM_reg[1][2]  ( .D(n32), .CK(w_clk), .RN(n114), .Q(
        \FIFO_MEM[1][2] ) );
  DFFRQX1M \FIFO_MEM_reg[1][1]  ( .D(n31), .CK(w_clk), .RN(n114), .Q(
        \FIFO_MEM[1][1] ) );
  DFFRQX1M \FIFO_MEM_reg[1][0]  ( .D(n30), .CK(w_clk), .RN(n114), .Q(
        \FIFO_MEM[1][0] ) );
  DFFRQX1M \FIFO_MEM_reg[7][7]  ( .D(n85), .CK(w_clk), .RN(n110), .Q(
        \FIFO_MEM[7][7] ) );
  DFFRQX1M \FIFO_MEM_reg[7][6]  ( .D(n84), .CK(w_clk), .RN(n110), .Q(
        \FIFO_MEM[7][6] ) );
  DFFRQX1M \FIFO_MEM_reg[7][5]  ( .D(n83), .CK(w_clk), .RN(n110), .Q(
        \FIFO_MEM[7][5] ) );
  DFFRQX1M \FIFO_MEM_reg[7][4]  ( .D(n82), .CK(w_clk), .RN(n110), .Q(
        \FIFO_MEM[7][4] ) );
  DFFRQX1M \FIFO_MEM_reg[7][3]  ( .D(n81), .CK(w_clk), .RN(n110), .Q(
        \FIFO_MEM[7][3] ) );
  DFFRQX1M \FIFO_MEM_reg[7][2]  ( .D(n80), .CK(w_clk), .RN(n110), .Q(
        \FIFO_MEM[7][2] ) );
  DFFRQX1M \FIFO_MEM_reg[7][1]  ( .D(n79), .CK(w_clk), .RN(n110), .Q(
        \FIFO_MEM[7][1] ) );
  DFFRQX1M \FIFO_MEM_reg[7][0]  ( .D(n78), .CK(w_clk), .RN(n110), .Q(
        \FIFO_MEM[7][0] ) );
  DFFRQX1M \FIFO_MEM_reg[3][7]  ( .D(n53), .CK(w_clk), .RN(n112), .Q(
        \FIFO_MEM[3][7] ) );
  DFFRQX1M \FIFO_MEM_reg[3][6]  ( .D(n52), .CK(w_clk), .RN(n112), .Q(
        \FIFO_MEM[3][6] ) );
  DFFRQX1M \FIFO_MEM_reg[3][5]  ( .D(n51), .CK(w_clk), .RN(n112), .Q(
        \FIFO_MEM[3][5] ) );
  DFFRQX1M \FIFO_MEM_reg[3][4]  ( .D(n50), .CK(w_clk), .RN(n112), .Q(
        \FIFO_MEM[3][4] ) );
  DFFRQX1M \FIFO_MEM_reg[3][3]  ( .D(n49), .CK(w_clk), .RN(n113), .Q(
        \FIFO_MEM[3][3] ) );
  DFFRQX1M \FIFO_MEM_reg[3][2]  ( .D(n48), .CK(w_clk), .RN(n113), .Q(
        \FIFO_MEM[3][2] ) );
  DFFRQX1M \FIFO_MEM_reg[3][1]  ( .D(n47), .CK(w_clk), .RN(n113), .Q(
        \FIFO_MEM[3][1] ) );
  DFFRQX1M \FIFO_MEM_reg[3][0]  ( .D(n46), .CK(w_clk), .RN(n113), .Q(
        \FIFO_MEM[3][0] ) );
  DFFRQX1M \FIFO_MEM_reg[6][7]  ( .D(n77), .CK(w_clk), .RN(n110), .Q(
        \FIFO_MEM[6][7] ) );
  DFFRQX1M \FIFO_MEM_reg[6][6]  ( .D(n76), .CK(w_clk), .RN(n110), .Q(
        \FIFO_MEM[6][6] ) );
  DFFRQX1M \FIFO_MEM_reg[6][5]  ( .D(n75), .CK(w_clk), .RN(n110), .Q(
        \FIFO_MEM[6][5] ) );
  DFFRQX1M \FIFO_MEM_reg[6][4]  ( .D(n74), .CK(w_clk), .RN(n110), .Q(
        \FIFO_MEM[6][4] ) );
  DFFRQX1M \FIFO_MEM_reg[6][3]  ( .D(n73), .CK(w_clk), .RN(n111), .Q(
        \FIFO_MEM[6][3] ) );
  DFFRQX1M \FIFO_MEM_reg[6][2]  ( .D(n72), .CK(w_clk), .RN(n111), .Q(
        \FIFO_MEM[6][2] ) );
  DFFRQX1M \FIFO_MEM_reg[6][1]  ( .D(n71), .CK(w_clk), .RN(n111), .Q(
        \FIFO_MEM[6][1] ) );
  DFFRQX1M \FIFO_MEM_reg[6][0]  ( .D(n70), .CK(w_clk), .RN(n111), .Q(
        \FIFO_MEM[6][0] ) );
  DFFRQX1M \FIFO_MEM_reg[2][7]  ( .D(n45), .CK(w_clk), .RN(n113), .Q(
        \FIFO_MEM[2][7] ) );
  DFFRQX1M \FIFO_MEM_reg[2][6]  ( .D(n44), .CK(w_clk), .RN(n113), .Q(
        \FIFO_MEM[2][6] ) );
  DFFRQX1M \FIFO_MEM_reg[2][5]  ( .D(n43), .CK(w_clk), .RN(n113), .Q(
        \FIFO_MEM[2][5] ) );
  DFFRQX1M \FIFO_MEM_reg[2][4]  ( .D(n42), .CK(w_clk), .RN(n113), .Q(
        \FIFO_MEM[2][4] ) );
  DFFRQX1M \FIFO_MEM_reg[2][3]  ( .D(n41), .CK(w_clk), .RN(n113), .Q(
        \FIFO_MEM[2][3] ) );
  DFFRQX1M \FIFO_MEM_reg[2][2]  ( .D(n40), .CK(w_clk), .RN(n113), .Q(
        \FIFO_MEM[2][2] ) );
  DFFRQX1M \FIFO_MEM_reg[2][1]  ( .D(n39), .CK(w_clk), .RN(n113), .Q(
        \FIFO_MEM[2][1] ) );
  DFFRQX1M \FIFO_MEM_reg[2][0]  ( .D(n38), .CK(w_clk), .RN(n113), .Q(
        \FIFO_MEM[2][0] ) );
  DFFRQX1M \FIFO_MEM_reg[4][7]  ( .D(n61), .CK(w_clk), .RN(n112), .Q(
        \FIFO_MEM[4][7] ) );
  DFFRQX1M \FIFO_MEM_reg[4][6]  ( .D(n60), .CK(w_clk), .RN(n112), .Q(
        \FIFO_MEM[4][6] ) );
  DFFRQX1M \FIFO_MEM_reg[4][5]  ( .D(n59), .CK(w_clk), .RN(n112), .Q(
        \FIFO_MEM[4][5] ) );
  DFFRQX1M \FIFO_MEM_reg[4][4]  ( .D(n58), .CK(w_clk), .RN(n112), .Q(
        \FIFO_MEM[4][4] ) );
  DFFRQX1M \FIFO_MEM_reg[4][3]  ( .D(n57), .CK(w_clk), .RN(n112), .Q(
        \FIFO_MEM[4][3] ) );
  DFFRQX1M \FIFO_MEM_reg[4][2]  ( .D(n56), .CK(w_clk), .RN(n112), .Q(
        \FIFO_MEM[4][2] ) );
  DFFRQX1M \FIFO_MEM_reg[4][1]  ( .D(n55), .CK(w_clk), .RN(n112), .Q(
        \FIFO_MEM[4][1] ) );
  DFFRQX1M \FIFO_MEM_reg[4][0]  ( .D(n54), .CK(w_clk), .RN(n112), .Q(
        \FIFO_MEM[4][0] ) );
  DFFRQX1M \FIFO_MEM_reg[0][7]  ( .D(n29), .CK(w_clk), .RN(n114), .Q(
        \FIFO_MEM[0][7] ) );
  DFFRQX1M \FIFO_MEM_reg[0][6]  ( .D(n28), .CK(w_clk), .RN(n114), .Q(
        \FIFO_MEM[0][6] ) );
  DFFRQX1M \FIFO_MEM_reg[0][5]  ( .D(n27), .CK(w_clk), .RN(n114), .Q(
        \FIFO_MEM[0][5] ) );
  DFFRQX1M \FIFO_MEM_reg[0][4]  ( .D(n26), .CK(w_clk), .RN(n114), .Q(
        \FIFO_MEM[0][4] ) );
  DFFRQX1M \FIFO_MEM_reg[0][3]  ( .D(n25), .CK(w_clk), .RN(n115), .Q(
        \FIFO_MEM[0][3] ) );
  DFFRQX1M \FIFO_MEM_reg[0][2]  ( .D(n24), .CK(w_clk), .RN(n115), .Q(
        \FIFO_MEM[0][2] ) );
  DFFRQX1M \FIFO_MEM_reg[0][1]  ( .D(n23), .CK(w_clk), .RN(n115), .Q(
        \FIFO_MEM[0][1] ) );
  DFFRQX1M \FIFO_MEM_reg[0][0]  ( .D(n22), .CK(w_clk), .RN(n115), .Q(
        \FIFO_MEM[0][0] ) );
  CLKBUFX8M U2 ( .A(n19), .Y(n100) );
  NOR2BX4M U3 ( .AN(n16), .B(w_addr[2]), .Y(n12) );
  AND2X2M U4 ( .A(w_addr[2]), .B(n16), .Y(n18) );
  INVX4M U5 ( .A(w_data[0]), .Y(n118) );
  INVX4M U6 ( .A(w_data[1]), .Y(n119) );
  INVX4M U7 ( .A(w_data[2]), .Y(n120) );
  INVX4M U8 ( .A(w_data[3]), .Y(n121) );
  INVX4M U9 ( .A(w_data[4]), .Y(n122) );
  INVX4M U10 ( .A(w_data[5]), .Y(n123) );
  INVX4M U11 ( .A(w_data[6]), .Y(n124) );
  INVX4M U12 ( .A(w_data[7]), .Y(n125) );
  INVX2M U13 ( .A(w_addr[1]), .Y(n127) );
  INVX2M U14 ( .A(w_addr[0]), .Y(n126) );
  BUFX6M U15 ( .A(n117), .Y(n114) );
  BUFX6M U16 ( .A(n116), .Y(n113) );
  BUFX6M U17 ( .A(n116), .Y(n112) );
  BUFX6M U18 ( .A(n117), .Y(n111) );
  BUFX6M U19 ( .A(w_rstn), .Y(n110) );
  BUFX2M U20 ( .A(n116), .Y(n115) );
  BUFX2M U21 ( .A(n117), .Y(n116) );
  NOR2BX2M U22 ( .AN(w_inc), .B(w_full), .Y(n16) );
  INVX4M U23 ( .A(n2), .Y(n102) );
  INVX4M U24 ( .A(n2), .Y(n101) );
  INVX4M U25 ( .A(n1), .Y(n109) );
  INVX4M U26 ( .A(n1), .Y(n108) );
  BUFX2M U27 ( .A(w_rstn), .Y(n117) );
  INVX4M U28 ( .A(n3), .Y(n107) );
  INVX4M U29 ( .A(n3), .Y(n106) );
  INVX4M U30 ( .A(n5), .Y(n97) );
  INVX4M U31 ( .A(n5), .Y(n96) );
  INVX4M U32 ( .A(n6), .Y(n105) );
  INVX4M U33 ( .A(n6), .Y(n104) );
  INVX4M U34 ( .A(n4), .Y(n99) );
  INVX4M U35 ( .A(n4), .Y(n98) );
  AND3X2M U36 ( .A(n126), .B(n127), .C(n12), .Y(n1) );
  AND3X2M U37 ( .A(n126), .B(n127), .C(n18), .Y(n2) );
  INVX4M U38 ( .A(n95), .Y(n94) );
  INVX4M U39 ( .A(n95), .Y(n93) );
  CLKBUFX8M U40 ( .A(n15), .Y(n103) );
  NAND3X2M U41 ( .A(w_addr[0]), .B(n12), .C(w_addr[1]), .Y(n15) );
  OAI2BB2X1M U42 ( .B0(n118), .B1(n107), .A0N(\FIFO_MEM[1][0] ), .A1N(n107), 
        .Y(n30) );
  OAI2BB2X1M U43 ( .B0(n119), .B1(n106), .A0N(\FIFO_MEM[1][1] ), .A1N(n106), 
        .Y(n31) );
  OAI2BB2X1M U44 ( .B0(n120), .B1(n107), .A0N(\FIFO_MEM[1][2] ), .A1N(n107), 
        .Y(n32) );
  OAI2BB2X1M U45 ( .B0(n121), .B1(n106), .A0N(\FIFO_MEM[1][3] ), .A1N(n106), 
        .Y(n33) );
  OAI2BB2X1M U46 ( .B0(n122), .B1(n107), .A0N(\FIFO_MEM[1][4] ), .A1N(n107), 
        .Y(n34) );
  OAI2BB2X1M U47 ( .B0(n123), .B1(n106), .A0N(\FIFO_MEM[1][5] ), .A1N(n106), 
        .Y(n35) );
  OAI2BB2X1M U48 ( .B0(n124), .B1(n107), .A0N(\FIFO_MEM[1][6] ), .A1N(n107), 
        .Y(n36) );
  OAI2BB2X1M U49 ( .B0(n125), .B1(n106), .A0N(\FIFO_MEM[1][7] ), .A1N(n106), 
        .Y(n37) );
  OAI2BB2X1M U50 ( .B0(n118), .B1(n105), .A0N(\FIFO_MEM[2][0] ), .A1N(n105), 
        .Y(n38) );
  OAI2BB2X1M U51 ( .B0(n119), .B1(n104), .A0N(\FIFO_MEM[2][1] ), .A1N(n104), 
        .Y(n39) );
  OAI2BB2X1M U52 ( .B0(n120), .B1(n105), .A0N(\FIFO_MEM[2][2] ), .A1N(n105), 
        .Y(n40) );
  OAI2BB2X1M U53 ( .B0(n121), .B1(n104), .A0N(\FIFO_MEM[2][3] ), .A1N(n104), 
        .Y(n41) );
  OAI2BB2X1M U54 ( .B0(n122), .B1(n105), .A0N(\FIFO_MEM[2][4] ), .A1N(n105), 
        .Y(n42) );
  OAI2BB2X1M U55 ( .B0(n123), .B1(n104), .A0N(\FIFO_MEM[2][5] ), .A1N(n104), 
        .Y(n43) );
  OAI2BB2X1M U56 ( .B0(n124), .B1(n105), .A0N(\FIFO_MEM[2][6] ), .A1N(n105), 
        .Y(n44) );
  OAI2BB2X1M U57 ( .B0(n125), .B1(n104), .A0N(\FIFO_MEM[2][7] ), .A1N(n104), 
        .Y(n45) );
  OAI2BB2X1M U58 ( .B0(n118), .B1(n103), .A0N(\FIFO_MEM[3][0] ), .A1N(n103), 
        .Y(n46) );
  OAI2BB2X1M U59 ( .B0(n119), .B1(n103), .A0N(\FIFO_MEM[3][1] ), .A1N(n103), 
        .Y(n47) );
  OAI2BB2X1M U60 ( .B0(n120), .B1(n103), .A0N(\FIFO_MEM[3][2] ), .A1N(n103), 
        .Y(n48) );
  OAI2BB2X1M U61 ( .B0(n121), .B1(n103), .A0N(\FIFO_MEM[3][3] ), .A1N(n103), 
        .Y(n49) );
  OAI2BB2X1M U62 ( .B0(n122), .B1(n103), .A0N(\FIFO_MEM[3][4] ), .A1N(n103), 
        .Y(n50) );
  OAI2BB2X1M U63 ( .B0(n123), .B1(n103), .A0N(\FIFO_MEM[3][5] ), .A1N(n103), 
        .Y(n51) );
  OAI2BB2X1M U64 ( .B0(n124), .B1(n103), .A0N(\FIFO_MEM[3][6] ), .A1N(n103), 
        .Y(n52) );
  OAI2BB2X1M U65 ( .B0(n125), .B1(n103), .A0N(\FIFO_MEM[3][7] ), .A1N(n103), 
        .Y(n53) );
  OAI2BB2X1M U66 ( .B0(n118), .B1(n102), .A0N(\FIFO_MEM[4][0] ), .A1N(n102), 
        .Y(n54) );
  OAI2BB2X1M U67 ( .B0(n119), .B1(n101), .A0N(\FIFO_MEM[4][1] ), .A1N(n101), 
        .Y(n55) );
  OAI2BB2X1M U68 ( .B0(n120), .B1(n102), .A0N(\FIFO_MEM[4][2] ), .A1N(n102), 
        .Y(n56) );
  OAI2BB2X1M U69 ( .B0(n121), .B1(n101), .A0N(\FIFO_MEM[4][3] ), .A1N(n101), 
        .Y(n57) );
  OAI2BB2X1M U70 ( .B0(n122), .B1(n102), .A0N(\FIFO_MEM[4][4] ), .A1N(n102), 
        .Y(n58) );
  OAI2BB2X1M U71 ( .B0(n123), .B1(n101), .A0N(\FIFO_MEM[4][5] ), .A1N(n101), 
        .Y(n59) );
  OAI2BB2X1M U72 ( .B0(n124), .B1(n102), .A0N(\FIFO_MEM[4][6] ), .A1N(n102), 
        .Y(n60) );
  OAI2BB2X1M U73 ( .B0(n125), .B1(n101), .A0N(\FIFO_MEM[4][7] ), .A1N(n101), 
        .Y(n61) );
  OAI2BB2X1M U74 ( .B0(n118), .B1(n100), .A0N(\FIFO_MEM[5][0] ), .A1N(n100), 
        .Y(n62) );
  OAI2BB2X1M U75 ( .B0(n119), .B1(n100), .A0N(\FIFO_MEM[5][1] ), .A1N(n100), 
        .Y(n63) );
  OAI2BB2X1M U76 ( .B0(n120), .B1(n100), .A0N(\FIFO_MEM[5][2] ), .A1N(n100), 
        .Y(n64) );
  OAI2BB2X1M U77 ( .B0(n121), .B1(n100), .A0N(\FIFO_MEM[5][3] ), .A1N(n100), 
        .Y(n65) );
  OAI2BB2X1M U78 ( .B0(n122), .B1(n100), .A0N(\FIFO_MEM[5][4] ), .A1N(n100), 
        .Y(n66) );
  OAI2BB2X1M U79 ( .B0(n123), .B1(n100), .A0N(\FIFO_MEM[5][5] ), .A1N(n100), 
        .Y(n67) );
  OAI2BB2X1M U80 ( .B0(n124), .B1(n100), .A0N(\FIFO_MEM[5][6] ), .A1N(n100), 
        .Y(n68) );
  OAI2BB2X1M U81 ( .B0(n125), .B1(n100), .A0N(\FIFO_MEM[5][7] ), .A1N(n100), 
        .Y(n69) );
  OAI2BB2X1M U82 ( .B0(n118), .B1(n99), .A0N(\FIFO_MEM[6][0] ), .A1N(n99), .Y(
        n70) );
  OAI2BB2X1M U83 ( .B0(n119), .B1(n98), .A0N(\FIFO_MEM[6][1] ), .A1N(n98), .Y(
        n71) );
  OAI2BB2X1M U84 ( .B0(n120), .B1(n99), .A0N(\FIFO_MEM[6][2] ), .A1N(n99), .Y(
        n72) );
  OAI2BB2X1M U85 ( .B0(n121), .B1(n98), .A0N(\FIFO_MEM[6][3] ), .A1N(n98), .Y(
        n73) );
  OAI2BB2X1M U86 ( .B0(n122), .B1(n99), .A0N(\FIFO_MEM[6][4] ), .A1N(n99), .Y(
        n74) );
  OAI2BB2X1M U87 ( .B0(n123), .B1(n98), .A0N(\FIFO_MEM[6][5] ), .A1N(n98), .Y(
        n75) );
  OAI2BB2X1M U88 ( .B0(n124), .B1(n99), .A0N(\FIFO_MEM[6][6] ), .A1N(n99), .Y(
        n76) );
  OAI2BB2X1M U89 ( .B0(n125), .B1(n98), .A0N(\FIFO_MEM[6][7] ), .A1N(n98), .Y(
        n77) );
  OAI2BB2X1M U90 ( .B0(n118), .B1(n97), .A0N(\FIFO_MEM[7][0] ), .A1N(n97), .Y(
        n78) );
  OAI2BB2X1M U91 ( .B0(n119), .B1(n96), .A0N(\FIFO_MEM[7][1] ), .A1N(n96), .Y(
        n79) );
  OAI2BB2X1M U92 ( .B0(n120), .B1(n97), .A0N(\FIFO_MEM[7][2] ), .A1N(n97), .Y(
        n80) );
  OAI2BB2X1M U93 ( .B0(n121), .B1(n96), .A0N(\FIFO_MEM[7][3] ), .A1N(n96), .Y(
        n81) );
  OAI2BB2X1M U94 ( .B0(n122), .B1(n97), .A0N(\FIFO_MEM[7][4] ), .A1N(n97), .Y(
        n82) );
  OAI2BB2X1M U95 ( .B0(n123), .B1(n96), .A0N(\FIFO_MEM[7][5] ), .A1N(n96), .Y(
        n83) );
  OAI2BB2X1M U96 ( .B0(n124), .B1(n97), .A0N(\FIFO_MEM[7][6] ), .A1N(n97), .Y(
        n84) );
  OAI2BB2X1M U97 ( .B0(n125), .B1(n96), .A0N(\FIFO_MEM[7][7] ), .A1N(n96), .Y(
        n85) );
  OAI2BB2X1M U98 ( .B0(n109), .B1(n118), .A0N(\FIFO_MEM[0][0] ), .A1N(n109), 
        .Y(n22) );
  OAI2BB2X1M U99 ( .B0(n108), .B1(n119), .A0N(\FIFO_MEM[0][1] ), .A1N(n108), 
        .Y(n23) );
  OAI2BB2X1M U100 ( .B0(n109), .B1(n120), .A0N(\FIFO_MEM[0][2] ), .A1N(n109), 
        .Y(n24) );
  OAI2BB2X1M U101 ( .B0(n108), .B1(n121), .A0N(\FIFO_MEM[0][3] ), .A1N(n108), 
        .Y(n25) );
  OAI2BB2X1M U102 ( .B0(n109), .B1(n122), .A0N(\FIFO_MEM[0][4] ), .A1N(n109), 
        .Y(n26) );
  OAI2BB2X1M U103 ( .B0(n108), .B1(n123), .A0N(\FIFO_MEM[0][5] ), .A1N(n108), 
        .Y(n27) );
  OAI2BB2X1M U104 ( .B0(n109), .B1(n124), .A0N(\FIFO_MEM[0][6] ), .A1N(n109), 
        .Y(n28) );
  OAI2BB2X1M U105 ( .B0(n108), .B1(n125), .A0N(\FIFO_MEM[0][7] ), .A1N(n108), 
        .Y(n29) );
  AND3X2M U106 ( .A(n12), .B(n127), .C(w_addr[0]), .Y(n3) );
  NAND3X2M U107 ( .A(w_addr[0]), .B(n127), .C(n18), .Y(n19) );
  AND3X2M U108 ( .A(w_addr[1]), .B(n126), .C(n18), .Y(n4) );
  AND3X2M U109 ( .A(w_addr[1]), .B(w_addr[0]), .C(n18), .Y(n5) );
  AND3X2M U110 ( .A(n12), .B(n126), .C(w_addr[1]), .Y(n6) );
  BUFX10M U111 ( .A(N9), .Y(n92) );
  MX2X2M U112 ( .A(n8), .B(n7), .S0(N11), .Y(r_data[0]) );
  MX4X1M U113 ( .A(\FIFO_MEM[4][0] ), .B(\FIFO_MEM[5][0] ), .C(
        \FIFO_MEM[6][0] ), .D(\FIFO_MEM[7][0] ), .S0(n92), .S1(n93), .Y(n7) );
  MX4X1M U114 ( .A(\FIFO_MEM[0][0] ), .B(\FIFO_MEM[1][0] ), .C(
        \FIFO_MEM[2][0] ), .D(\FIFO_MEM[3][0] ), .S0(n92), .S1(n94), .Y(n8) );
  MX2X2M U115 ( .A(n10), .B(n9), .S0(N11), .Y(r_data[1]) );
  MX4X1M U116 ( .A(\FIFO_MEM[4][1] ), .B(\FIFO_MEM[5][1] ), .C(
        \FIFO_MEM[6][1] ), .D(\FIFO_MEM[7][1] ), .S0(n92), .S1(n93), .Y(n9) );
  MX4X1M U117 ( .A(\FIFO_MEM[0][1] ), .B(\FIFO_MEM[1][1] ), .C(
        \FIFO_MEM[2][1] ), .D(\FIFO_MEM[3][1] ), .S0(n92), .S1(n94), .Y(n10)
         );
  MX2X2M U118 ( .A(n13), .B(n11), .S0(N11), .Y(r_data[2]) );
  MX4X1M U119 ( .A(\FIFO_MEM[4][2] ), .B(\FIFO_MEM[5][2] ), .C(
        \FIFO_MEM[6][2] ), .D(\FIFO_MEM[7][2] ), .S0(n92), .S1(n93), .Y(n11)
         );
  MX4X1M U120 ( .A(\FIFO_MEM[0][2] ), .B(\FIFO_MEM[1][2] ), .C(
        \FIFO_MEM[2][2] ), .D(\FIFO_MEM[3][2] ), .S0(n92), .S1(n94), .Y(n13)
         );
  MX2X2M U121 ( .A(n17), .B(n14), .S0(N11), .Y(r_data[3]) );
  MX4X1M U122 ( .A(\FIFO_MEM[4][3] ), .B(\FIFO_MEM[5][3] ), .C(
        \FIFO_MEM[6][3] ), .D(\FIFO_MEM[7][3] ), .S0(n92), .S1(n93), .Y(n14)
         );
  MX4X1M U123 ( .A(\FIFO_MEM[0][3] ), .B(\FIFO_MEM[1][3] ), .C(
        \FIFO_MEM[2][3] ), .D(\FIFO_MEM[3][3] ), .S0(n92), .S1(n94), .Y(n17)
         );
  MX2X2M U124 ( .A(n21), .B(n20), .S0(N11), .Y(r_data[4]) );
  MX4X1M U125 ( .A(\FIFO_MEM[4][4] ), .B(\FIFO_MEM[5][4] ), .C(
        \FIFO_MEM[6][4] ), .D(\FIFO_MEM[7][4] ), .S0(n92), .S1(n93), .Y(n20)
         );
  MX4X1M U126 ( .A(\FIFO_MEM[0][4] ), .B(\FIFO_MEM[1][4] ), .C(
        \FIFO_MEM[2][4] ), .D(\FIFO_MEM[3][4] ), .S0(n92), .S1(n94), .Y(n21)
         );
  MX2X2M U127 ( .A(n87), .B(n86), .S0(N11), .Y(r_data[5]) );
  MX4X1M U128 ( .A(\FIFO_MEM[4][5] ), .B(\FIFO_MEM[5][5] ), .C(
        \FIFO_MEM[6][5] ), .D(\FIFO_MEM[7][5] ), .S0(n92), .S1(n93), .Y(n86)
         );
  MX4X1M U129 ( .A(\FIFO_MEM[0][5] ), .B(\FIFO_MEM[1][5] ), .C(
        \FIFO_MEM[2][5] ), .D(\FIFO_MEM[3][5] ), .S0(n92), .S1(n94), .Y(n87)
         );
  MX2X2M U130 ( .A(n89), .B(n88), .S0(N11), .Y(r_data[6]) );
  MX4X1M U131 ( .A(\FIFO_MEM[4][6] ), .B(\FIFO_MEM[5][6] ), .C(
        \FIFO_MEM[6][6] ), .D(\FIFO_MEM[7][6] ), .S0(n92), .S1(n93), .Y(n88)
         );
  MX4X1M U132 ( .A(\FIFO_MEM[0][6] ), .B(\FIFO_MEM[1][6] ), .C(
        \FIFO_MEM[2][6] ), .D(\FIFO_MEM[3][6] ), .S0(n92), .S1(n94), .Y(n89)
         );
  MX2X2M U133 ( .A(n91), .B(n90), .S0(N11), .Y(r_data[7]) );
  MX4X1M U134 ( .A(\FIFO_MEM[4][7] ), .B(\FIFO_MEM[5][7] ), .C(
        \FIFO_MEM[6][7] ), .D(\FIFO_MEM[7][7] ), .S0(n92), .S1(n93), .Y(n90)
         );
  MX4X1M U135 ( .A(\FIFO_MEM[0][7] ), .B(\FIFO_MEM[1][7] ), .C(
        \FIFO_MEM[2][7] ), .D(\FIFO_MEM[3][7] ), .S0(n92), .S1(n94), .Y(n91)
         );
  INVX2M U136 ( .A(N10), .Y(n95) );
endmodule


module DF_Sync_0 ( sync_clk, sync_rstn, unsync_ip, sync_op );
  input [3:0] unsync_ip;
  output [3:0] sync_op;
  input sync_clk, sync_rstn;
  wire   n1, n2;
  wire   [3:0] meta_flop;

  DFFRQX1M \sync_op_reg[3]  ( .D(meta_flop[3]), .CK(sync_clk), .RN(n1), .Q(
        sync_op[3]) );
  DFFRQX1M \sync_op_reg[2]  ( .D(meta_flop[2]), .CK(sync_clk), .RN(n1), .Q(
        sync_op[2]) );
  DFFRQX1M \sync_op_reg[1]  ( .D(meta_flop[1]), .CK(sync_clk), .RN(n1), .Q(
        sync_op[1]) );
  DFFRQX1M \sync_op_reg[0]  ( .D(meta_flop[0]), .CK(sync_clk), .RN(n1), .Q(
        sync_op[0]) );
  DFFRQX1M \meta_flop_reg[3]  ( .D(unsync_ip[3]), .CK(sync_clk), .RN(n1), .Q(
        meta_flop[3]) );
  DFFRQX1M \meta_flop_reg[2]  ( .D(unsync_ip[2]), .CK(sync_clk), .RN(n1), .Q(
        meta_flop[2]) );
  DFFRQX1M \meta_flop_reg[1]  ( .D(unsync_ip[1]), .CK(sync_clk), .RN(n1), .Q(
        meta_flop[1]) );
  DFFRQX1M \meta_flop_reg[0]  ( .D(unsync_ip[0]), .CK(sync_clk), .RN(n1), .Q(
        meta_flop[0]) );
  INVX4M U3 ( .A(n2), .Y(n1) );
  INVX2M U4 ( .A(sync_rstn), .Y(n2) );
endmodule


module fifo_wr ( w_clk, w_rstn, w_inc, sync_rd_ptr, w_addr, gray_w_ptr, full
 );
  input [3:0] sync_rd_ptr;
  output [2:0] w_addr;
  output [3:0] gray_w_ptr;
  input w_clk, w_rstn, w_inc;
  output full;
  wire   n20, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n1,
         n17, n18;
  wire   [3:0] comb_gray_w_ptr;

  DFFRX4M \w_ptr_reg[0]  ( .D(n15), .CK(w_clk), .RN(n17), .Q(w_addr[0]), .QN(
        n2) );
  DFFRQX4M \w_ptr_reg[2]  ( .D(n13), .CK(w_clk), .RN(n17), .Q(w_addr[2]) );
  DFFRQX1M \gray_w_ptr_reg[3]  ( .D(comb_gray_w_ptr[3]), .CK(w_clk), .RN(n17), 
        .Q(gray_w_ptr[3]) );
  DFFRQX1M \gray_w_ptr_reg[2]  ( .D(comb_gray_w_ptr[2]), .CK(w_clk), .RN(n17), 
        .Q(gray_w_ptr[2]) );
  DFFRQX1M \gray_w_ptr_reg[1]  ( .D(comb_gray_w_ptr[1]), .CK(w_clk), .RN(n17), 
        .Q(gray_w_ptr[1]) );
  DFFRQX1M \gray_w_ptr_reg[0]  ( .D(comb_gray_w_ptr[0]), .CK(w_clk), .RN(n17), 
        .Q(gray_w_ptr[0]) );
  DFFRQX2M \w_ptr_reg[3]  ( .D(n12), .CK(w_clk), .RN(n17), .Q(
        comb_gray_w_ptr[3]) );
  DFFRQX1M \w_ptr_reg[1]  ( .D(n14), .CK(w_clk), .RN(n17), .Q(n20) );
  INVX4M U3 ( .A(n1), .Y(w_addr[1]) );
  INVXLM U4 ( .A(n20), .Y(n1) );
  INVX4M U5 ( .A(n18), .Y(n17) );
  INVX2M U6 ( .A(w_rstn), .Y(n18) );
  INVX2M U7 ( .A(n7), .Y(full) );
  NAND2X2M U8 ( .A(w_inc), .B(n7), .Y(n6) );
  CLKXOR2X2M U9 ( .A(comb_gray_w_ptr[3]), .B(w_addr[2]), .Y(comb_gray_w_ptr[2]) );
  CLKXOR2X2M U10 ( .A(w_addr[1]), .B(w_addr[2]), .Y(comb_gray_w_ptr[1]) );
  XNOR2X4M U11 ( .A(n2), .B(w_addr[1]), .Y(comb_gray_w_ptr[0]) );
  NOR2X2M U12 ( .A(n6), .B(n2), .Y(n5) );
  XNOR2X2M U13 ( .A(comb_gray_w_ptr[1]), .B(sync_rd_ptr[1]), .Y(n8) );
  XNOR2X2M U14 ( .A(w_addr[2]), .B(n4), .Y(n13) );
  XNOR2X2M U15 ( .A(comb_gray_w_ptr[3]), .B(n3), .Y(n12) );
  NAND2BX2M U16 ( .AN(n4), .B(w_addr[2]), .Y(n3) );
  NAND4X2M U17 ( .A(n8), .B(n9), .C(n10), .D(n11), .Y(n7) );
  CLKXOR2X2M U18 ( .A(sync_rd_ptr[3]), .B(comb_gray_w_ptr[3]), .Y(n11) );
  CLKXOR2X2M U19 ( .A(sync_rd_ptr[2]), .B(comb_gray_w_ptr[2]), .Y(n10) );
  XNOR2X2M U20 ( .A(comb_gray_w_ptr[0]), .B(sync_rd_ptr[0]), .Y(n9) );
  NAND2X2M U21 ( .A(n5), .B(w_addr[1]), .Y(n4) );
  CLKXOR2X2M U22 ( .A(w_addr[1]), .B(n5), .Y(n14) );
  CLKXOR2X2M U23 ( .A(n2), .B(n6), .Y(n15) );
endmodule


module fifo_rd ( r_clk, r_rstn, r_inc, sync_wr_ptr, rd_addr, empty, 
        gray_rd_ptr );
  input [3:0] sync_wr_ptr;
  output [2:0] rd_addr;
  output [3:0] gray_rd_ptr;
  input r_clk, r_rstn, r_inc;
  output empty;
  wire   n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n1, n16
;
  wire   [3:0] comb_gray_rd_ptr;

  DFFRX4M \rd_ptr_reg[0]  ( .D(n15), .CK(r_clk), .RN(n1), .Q(rd_addr[0]), .QN(
        n2) );
  DFFRHQX8M \rd_ptr_reg[2]  ( .D(n13), .CK(r_clk), .RN(n1), .Q(rd_addr[2]) );
  DFFRQX2M \rd_ptr_reg[3]  ( .D(n12), .CK(r_clk), .RN(n1), .Q(
        comb_gray_rd_ptr[3]) );
  DFFRQX4M \rd_ptr_reg[1]  ( .D(n14), .CK(r_clk), .RN(n1), .Q(rd_addr[1]) );
  DFFRQX1M \gray_rd_ptr_reg[3]  ( .D(comb_gray_rd_ptr[3]), .CK(r_clk), .RN(n1), 
        .Q(gray_rd_ptr[3]) );
  DFFRQX1M \gray_rd_ptr_reg[2]  ( .D(comb_gray_rd_ptr[2]), .CK(r_clk), .RN(n1), 
        .Q(gray_rd_ptr[2]) );
  DFFRQX1M \gray_rd_ptr_reg[1]  ( .D(comb_gray_rd_ptr[1]), .CK(r_clk), .RN(n1), 
        .Q(gray_rd_ptr[1]) );
  DFFRQX1M \gray_rd_ptr_reg[0]  ( .D(comb_gray_rd_ptr[0]), .CK(r_clk), .RN(n1), 
        .Q(gray_rd_ptr[0]) );
  INVX4M U3 ( .A(n16), .Y(n1) );
  INVX2M U4 ( .A(r_rstn), .Y(n16) );
  INVX2M U5 ( .A(n7), .Y(empty) );
  CLKXOR2X2M U6 ( .A(rd_addr[1]), .B(rd_addr[2]), .Y(comb_gray_rd_ptr[1]) );
  CLKXOR2X2M U7 ( .A(comb_gray_rd_ptr[3]), .B(rd_addr[2]), .Y(
        comb_gray_rd_ptr[2]) );
  XNOR2X4M U8 ( .A(n2), .B(rd_addr[1]), .Y(comb_gray_rd_ptr[0]) );
  XNOR2X2M U9 ( .A(comb_gray_rd_ptr[1]), .B(sync_wr_ptr[1]), .Y(n8) );
  NAND4X2M U10 ( .A(n8), .B(n9), .C(n10), .D(n11), .Y(n7) );
  XNOR2X2M U11 ( .A(comb_gray_rd_ptr[3]), .B(sync_wr_ptr[3]), .Y(n10) );
  XNOR2X2M U12 ( .A(comb_gray_rd_ptr[0]), .B(sync_wr_ptr[0]), .Y(n9) );
  XNOR2X2M U13 ( .A(comb_gray_rd_ptr[2]), .B(sync_wr_ptr[2]), .Y(n11) );
  NOR2X2M U14 ( .A(n6), .B(n2), .Y(n5) );
  CLKXOR2X2M U15 ( .A(rd_addr[1]), .B(n5), .Y(n14) );
  CLKXOR2X2M U16 ( .A(n2), .B(n6), .Y(n15) );
  XNOR2X2M U17 ( .A(comb_gray_rd_ptr[3]), .B(n3), .Y(n12) );
  NAND2BX2M U18 ( .AN(n4), .B(rd_addr[2]), .Y(n3) );
  XNOR2X2M U19 ( .A(rd_addr[2]), .B(n4), .Y(n13) );
  NAND2X2M U20 ( .A(n5), .B(rd_addr[1]), .Y(n4) );
  NAND2X2M U21 ( .A(r_inc), .B(n7), .Y(n6) );
endmodule


module DF_Sync_1 ( sync_clk, sync_rstn, unsync_ip, sync_op );
  input [3:0] unsync_ip;
  output [3:0] sync_op;
  input sync_clk, sync_rstn;
  wire   n1, n2;
  wire   [3:0] meta_flop;

  DFFRQX1M \sync_op_reg[3]  ( .D(meta_flop[3]), .CK(sync_clk), .RN(n1), .Q(
        sync_op[3]) );
  DFFRQX1M \sync_op_reg[2]  ( .D(meta_flop[2]), .CK(sync_clk), .RN(n1), .Q(
        sync_op[2]) );
  DFFRQX1M \sync_op_reg[1]  ( .D(meta_flop[1]), .CK(sync_clk), .RN(n1), .Q(
        sync_op[1]) );
  DFFRQX1M \sync_op_reg[0]  ( .D(meta_flop[0]), .CK(sync_clk), .RN(n1), .Q(
        sync_op[0]) );
  DFFRQX1M \meta_flop_reg[3]  ( .D(unsync_ip[3]), .CK(sync_clk), .RN(n1), .Q(
        meta_flop[3]) );
  DFFRQX1M \meta_flop_reg[2]  ( .D(unsync_ip[2]), .CK(sync_clk), .RN(n1), .Q(
        meta_flop[2]) );
  DFFRQX1M \meta_flop_reg[1]  ( .D(unsync_ip[1]), .CK(sync_clk), .RN(n1), .Q(
        meta_flop[1]) );
  DFFRQX1M \meta_flop_reg[0]  ( .D(unsync_ip[0]), .CK(sync_clk), .RN(n1), .Q(
        meta_flop[0]) );
  INVX4M U3 ( .A(n2), .Y(n1) );
  INVX2M U4 ( .A(sync_rstn), .Y(n2) );
endmodule


module Async_fifo ( i_w_clk, i_w_rstn, i_w_inc, i_r_clk, i_r_rstn, i_r_inc, 
        i_w_data, o_r_data, o_full, o_empty );
  input [7:0] i_w_data;
  output [7:0] o_r_data;
  input i_w_clk, i_w_rstn, i_w_inc, i_r_clk, i_r_rstn, i_r_inc;
  output o_full, o_empty;
  wire   n1, n2;
  wire   [2:0] w_addr;
  wire   [2:0] r_addr;
  wire   [3:0] gray_w_ptr;
  wire   [3:0] w2r_ptr;
  wire   [3:0] r2w_ptr;
  wire   [3:0] gray_rd_ptr;

  fifo_mem u_fifo_mem ( .w_clk(i_w_clk), .w_rstn(n1), .w_full(o_full), .w_inc(
        i_w_inc), .w_addr(w_addr), .r_addr(r_addr), .w_data(i_w_data), 
        .r_data(o_r_data) );
  DF_Sync_0 u_w2r_sync ( .sync_clk(i_r_clk), .sync_rstn(i_r_rstn), .unsync_ip(
        gray_w_ptr), .sync_op(w2r_ptr) );
  fifo_wr u_fifo_wr ( .w_clk(i_w_clk), .w_rstn(n1), .w_inc(i_w_inc), 
        .sync_rd_ptr(r2w_ptr), .w_addr(w_addr), .gray_w_ptr(gray_w_ptr), 
        .full(o_full) );
  fifo_rd u_fifo_rd ( .r_clk(i_r_clk), .r_rstn(i_r_rstn), .r_inc(i_r_inc), 
        .sync_wr_ptr(w2r_ptr), .rd_addr(r_addr), .empty(o_empty), 
        .gray_rd_ptr(gray_rd_ptr) );
  DF_Sync_1 u_r2w_sync ( .sync_clk(i_w_clk), .sync_rstn(n1), .unsync_ip(
        gray_rd_ptr), .sync_op(r2w_ptr) );
  INVX2M U1 ( .A(n2), .Y(n1) );
  INVX2M U2 ( .A(i_w_rstn), .Y(n2) );
endmodule


module SYS_TOP ( scan_clk, scan_rst, REF_CLK, UART_CLK, RST_N, UART_RX_IN, 
        UART_TX_O, parritty_error, framing_error, SE, SI, test_mode, SO );
  input [2:0] SI;
  output [2:0] SO;
  input scan_clk, scan_rst, REF_CLK, UART_CLK, RST_N, UART_RX_IN, SE,
         test_mode;
  output UART_TX_O, parritty_error, framing_error;
  wire   N0, CLK_M, CLK_N, CLK_T, tx_clk, CLK_R, rx_clk, CLK_A, alu_clk, RST_M,
         RST_1, rst_1, RST_2, rst_2, busy, valid_rx, fifo_empty,
         valid_data_sync, rd_register_valid, alu_valid_sys, fifo_full_sys,
         wr_inc_fifo, wr_register_en, rd_register_en, en_alu_sys, gate_en_sys,
         rd_inc_fifo, n2, n3, n4, n5, n6, n7;
  wire   [7:0] out_fifo;
  wire   [7:0] register_2;
  wire   [7:0] out_rx;
  wire   [7:0] out_data_sync;
  wire   [7:0] rd_register_data;
  wire   [7:0] alu_out_sys;
  wire   [7:0] in_fifo;
  wire   [3:0] address_register;
  wire   [7:0] wr_register_data;
  wire   [3:0] func_alu;
  wire   [7:0] op_a;
  wire   [7:0] op_b;
  wire   [7:0] register_3;
  assign N0 = test_mode;

  AO2B2X4M U3 ( .B0(N0), .B1(scan_clk), .A0(REF_CLK), .A1N(N0), .Y(CLK_M) );
  UART uart_dut ( .CLK_tb_top(CLK_T), .RST_tb_top(n5), .P_DATA_tb_top(out_fifo), .DATA_VALID_tb_top(n7), .PAR_EN_tb_top(register_2[0]), .PAR_TYP_tb_top(
        register_2[1]), .TX_OUT_tb_top(UART_TX_O), .BUSY_tb_top(busy), 
        .rx_in_top(UART_RX_IN), .prescale_top(register_2[7:2]), .par_en_top(
        register_2[0]), .par_typ_top(register_2[1]), .clk_top(CLK_R), 
        .data_valid_top(valid_rx), .stop_error(framing_error), .par_error(
        parritty_error), .p_data_top(out_rx) );
  DATA_SYNC DATA_SYNC_dut ( .clk(CLK_M), .rst(n3), .bus_enable(valid_rx), 
        .unsync_bus(out_rx), .enable_pulse(valid_data_sync), .sync_bus(
        out_data_sync) );
  controller controller_dut ( .clk(CLK_M), .rst(n3), .data(out_data_sync), 
        .data_valid(valid_data_sync), .rd_d(rd_register_data), .rd_d_valid(
        rd_register_valid), .alu_out(alu_out_sys), .alu_valid(alu_valid_sys), 
        .fifo_full(fifo_full_sys), .wr_inc(wr_inc_fifo), .wr_data(in_fifo), 
        .wren(wr_register_en), .rden(rd_register_en), .addr(address_register), 
        .wr_d(wr_register_data), .fun_alu(func_alu), .en_alu(en_alu_sys), 
        .gate_en(gate_en_sys) );
  ALU_16B ALU_dut ( .A(op_a), .B(op_b), .ALU_FUN(func_alu), .CLK(CLK_A), 
        .enable(en_alu_sys), .rst(n3), .ALU_OUT(alu_out_sys), .OUT_VALID(
        alu_valid_sys) );
  REGISTER_FILE regfile_dut ( .WrData(wr_register_data), .Address({
        address_register[3:2], n2, address_register[0]}), .RdEn(rd_register_en), .WrEn(wr_register_en), .CLK(CLK_M), .RST(n3), .RdData(rd_register_data), 
        .d_valid(rd_register_valid), .r0(op_a), .r1(op_b), .r2(register_2), 
        .r3(register_3) );
  RST_SYNC_0 rst_1_dut ( .clk(CLK_N), .rst(RST_M), .sync_rst(rst_1) );
  RST_SYNC_1 rst_2_dut ( .clk(CLK_M), .rst(RST_M), .sync_rst(rst_2) );
  CLK_GATE clk_gate_dut ( .CLK_EN(gate_en_sys), .CLK(CLK_M), .GATED_CLK(
        alu_clk) );
  CLK_DIV_0 clk_div_tx_dut ( .i_ref_clk(CLK_N), .i_rst(n5), .i_clk_en(
        register_2[0]), .i_div_ratio(register_3), .o_div_clk(tx_clk) );
  CLK_DIV_1 clk_div_rx_dut ( .i_ref_clk(CLK_N), .i_rst(n5), .i_clk_en(
        register_2[0]), .i_div_ratio({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b1}), .o_div_clk(rx_clk) );
  PULSE_GEN pulse_gen_dut ( .clk(CLK_T), .rst(n5), .lvl_sig(busy), .pulse_sig(
        rd_inc_fifo) );
  Async_fifo async_fifo_fifo ( .i_w_clk(CLK_M), .i_w_rstn(n3), .i_w_inc(
        wr_inc_fifo), .i_r_clk(CLK_T), .i_r_rstn(n5), .i_r_inc(rd_inc_fifo), 
        .i_w_data(in_fifo), .o_r_data(out_fifo), .o_full(fifo_full_sys), 
        .o_empty(fifo_empty) );
  INVX4M U5 ( .A(n4), .Y(n3) );
  INVX4M U6 ( .A(n6), .Y(n5) );
  INVX2M U7 ( .A(fifo_empty), .Y(n7) );
  BUFX2M U8 ( .A(address_register[1]), .Y(n2) );
  MX2X2M U9 ( .A(RST_N), .B(scan_rst), .S0(N0), .Y(RST_M) );
  INVX2M U10 ( .A(RST_2), .Y(n4) );
  MX2X2M U11 ( .A(rst_2), .B(scan_rst), .S0(N0), .Y(RST_2) );
  INVX2M U12 ( .A(RST_1), .Y(n6) );
  MX2X2M U13 ( .A(rst_1), .B(scan_rst), .S0(N0), .Y(RST_1) );
  CLKMX2X4M U14 ( .A(alu_clk), .B(scan_clk), .S0(N0), .Y(CLK_A) );
  MX2X6M U15 ( .A(rx_clk), .B(scan_clk), .S0(N0), .Y(CLK_R) );
  MX2X6M U16 ( .A(tx_clk), .B(scan_clk), .S0(N0), .Y(CLK_T) );
  MX2X6M U17 ( .A(UART_CLK), .B(scan_clk), .S0(N0), .Y(CLK_N) );
endmodule

