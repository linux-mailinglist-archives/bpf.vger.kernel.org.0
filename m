Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4559A43E046
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 13:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhJ1Lzx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 07:55:53 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:37101 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230188AbhJ1Lzx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Oct 2021 07:55:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=chengshuyi@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Uu.SoDK_1635422004;
Received: from B-39YZML7H-2200.local(mailfrom:chengshuyi@linux.alibaba.com fp:SMTPD_---0Uu.SoDK_1635422004)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 Oct 2021 19:53:24 +0800
To:     bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
From:   Shuyi Cheng <chengshuyi@linux.alibaba.com>
Subject: err: math between fp pointer and register with unbounded min value is
 not allowed
Message-ID: <be2520e1-527e-92ca-95fe-62e895519e02@linux.alibaba.com>
Date:   Thu, 28 Oct 2021 19:53:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi everyone, I encountered a very strange problem. If my bpf program is 
as follows, it can run normally.

     buff.in = sizeof(struct pid_info);
     data = &buff.buff[buff.in];
     set_pid_info((struct pid_info *)data);
     buff.in = sizeof(struct pid_info);
     data = &buff.buff[buff.in];
     set_pid_info((struct pid_info *)data);

but if I add a plus sign, an error is reported. error message is 'math 
between fp pointer and register with unbounded min value is not allowed'.

     buff.in = sizeof(struct pid_info);
     data = &buff.buff[buff.in];
     set_pid_info((struct pid_info *)data);
     buff.in += sizeof(struct pid_info);
     data = &buff.buff[buff.in];
     set_pid_info((struct pid_info *)data);


The error log printed by libbpf is as follows:

libbpf: -- BEGIN DUMP LOG ---
libbpf:
0: (79) r3 = *(u64 *)(r1 +112)
1: (b7) r2 = 0
2: (85) call pc+2
caller:
  R10=fp0,call_-1
callee:
  frame1: R1=ctx(id=0,off=0,imm=0) R2=inv0 R3=inv(id=0) R10=fp0,call_2
5: (bf) r7 = r3
6: (bf) r6 = r1
7: (7b) *(u64 *)(r10 -72) = r2
8: (b7) r8 = 0
9: (7b) *(u64 *)(r10 -96) = r8
10: (7b) *(u64 *)(r10 -104) = r8
11: (7b) *(u64 *)(r10 -112) = r8
12: (7b) *(u64 *)(r10 -120) = r8
13: (7b) *(u64 *)(r10 -128) = r8
14: (7b) *(u64 *)(r10 -136) = r8
15: (7b) *(u64 *)(r10 -144) = r8
16: (7b) *(u64 *)(r10 -152) = r8
17: (7b) *(u64 *)(r10 -160) = r8
18: (7b) *(u64 *)(r10 -168) = r8
19: (7b) *(u64 *)(r10 -176) = r8
20: (7b) *(u64 *)(r10 -184) = r8
21: (7b) *(u64 *)(r10 -192) = r8
22: (7b) *(u64 *)(r10 -200) = r8
23: (7b) *(u64 *)(r10 -208) = r8
24: (7b) *(u64 *)(r10 -216) = r8
25: (7b) *(u64 *)(r10 -224) = r8
26: (7b) *(u64 *)(r10 -232) = r8
27: (7b) *(u64 *)(r10 -240) = r8
28: (7b) *(u64 *)(r10 -248) = r8
29: (7b) *(u64 *)(r10 -256) = r8
30: (7b) *(u64 *)(r10 -264) = r8
31: (7b) *(u64 *)(r10 -272) = r8
32: (7b) *(u64 *)(r10 -280) = r8
33: (7b) *(u64 *)(r10 -288) = r8
34: (7b) *(u64 *)(r10 -296) = r8
35: (7b) *(u64 *)(r10 -304) = r8
36: (7b) *(u64 *)(r10 -312) = r8
37: (7b) *(u64 *)(r10 -320) = r8
38: (7b) *(u64 *)(r10 -328) = r8
39: (7b) *(u64 *)(r10 -336) = r8
40: (7b) *(u64 *)(r10 -344) = r8
41: (63) *(u32 *)(r10 -352) = r8
42: (7b) *(u64 *)(r10 -360) = r8
43: (7b) *(u64 *)(r10 -88) = r8
44: (7b) *(u64 *)(r10 -80) = r8
45: (63) *(u32 *)(r10 -368) = r8
46: (7b) *(u64 *)(r10 -376) = r8
47: (55) if r2 != 0x0 goto pc+7
48: (b7) r1 = 24
49: (bf) r3 = r7
50: (0f) r3 += r1
51: (bf) r1 = r10
52: (07) r1 += -72
53: (b7) r2 = 8
54: (85) call bpf_probe_read#4
55: (63) *(u32 *)(r10 -8) = r8
56: (7b) *(u64 *)(r10 -16) = r8
57: (7b) *(u64 *)(r10 -24) = r8
58: (63) *(u32 *)(r10 -32) = r8
59: (7b) *(u64 *)(r10 -40) = r8
60: (7b) *(u64 *)(r10 -48) = r8
61: (b7) r1 = 194
62: (bf) r3 = r7
63: (0f) r3 += r1
64: (bf) r1 = r10
65: (07) r1 += -62
66: (b7) r2 = 2
67: (85) call bpf_probe_read#4
68: (b7) r1 = 232
69: (bf) r3 = r7
70: (0f) r3 += r1
71: (bf) r1 = r10
72: (07) r1 += -56
73: (b7) r2 = 8
74: (85) call bpf_probe_read#4
75: (69) r1 = *(u16 *)(r10 -62)
76: (55) if r1 != 0xffff goto pc+40
  frame1: R0=inv(id=0) R1=inv65535 R6=ctx(id=0,off=0,imm=0) R7=inv(id=0) 
R8=inv0 R10=fp0,call_2 fp-16=0 fp-24=0 fp-40=0 fp-48=0 fp-80=0 fp-88=0 
fp-96=0 fp-104=0 fp-112=0 fp-120=0 fp-128=0 fp-136=0 fp-144=0 fp-152=0 
fp-160=0 fp-168=0 fp-176=0 fp-184=0 fp-192=0 fp-200=0 fp-208=0 fp-216=0 
fp-224=0 fp-232=0 fp-240=0 fp-248=0 fp-256=0 fp-264=0 fp-272=0 fp-280=0 
fp-288=0 fp-296=0 fp-304=0 fp-312=0 fp-320=0 fp-328=0 fp-336=0 fp-344=0 
fp-360=0 fp-376=0
77: (b7) r1 = 196
78: (bf) r3 = r7
79: (0f) r3 += r1
80: (bf) r1 = r10
81: (07) r1 += -60
82: (b7) r2 = 2
83: (85) call bpf_probe_read#4
84: (69) r1 = *(u16 *)(r10 -60)
85: (55) if r1 != 0x0 goto pc+10
  frame1: R0=inv(id=0) R1=inv0 R6=ctx(id=0,off=0,imm=0) R7=inv(id=0) 
R8=inv0 R10=fp0,call_2 fp-16=0 fp-24=0 fp-40=0 fp-48=0 fp-80=0 fp-88=0 
fp-96=0 fp-104=0 fp-112=0 fp-120=0 fp-128=0 fp-136=0 fp-144=0 fp-152=0 
fp-160=0 fp-168=0 fp-176=0 fp-184=0 fp-192=0 fp-200=0 fp-208=0 fp-216=0 
fp-224=0 fp-232=0 fp-240=0 fp-248=0 fp-256=0 fp-264=0 fp-272=0 fp-280=0 
fp-288=0 fp-296=0 fp-304=0 fp-312=0 fp-320=0 fp-328=0 fp-336=0 fp-344=0 
fp-360=0 fp-376=0
86: (b7) r1 = 198
87: (0f) r7 += r1
88: (bf) r1 = r10
89: (07) r1 += -58
90: (b7) r2 = 2
91: (bf) r3 = r7
92: (85) call bpf_probe_read#4
93: (69) r1 = *(u16 *)(r10 -58)
94: (07) r1 += 14
95: (6b) *(u16 *)(r10 -60) = r1
96: (57) r1 &= 65535
97: (79) r7 = *(u64 *)(r10 -56)
98: (0f) r7 += r1
99: (bf) r8 = r10
100: (07) r8 += -24
101: (bf) r1 = r8
102: (b7) r2 = 20
103: (bf) r3 = r7
104: (85) call bpf_probe_read#4
105: (b7) r1 = 0
106: (71) r5 = *(u8 *)(r8 +9)
107: (b7) r3 = 0
108: (b7) r4 = 0
109: (b7) r2 = 0
110: (55) if r5 != 0x6 goto pc+26
  frame1: R0=inv(id=0) R1=inv0 R2=inv0 R3=inv0 R4=inv0 R5=inv6 
R6=ctx(id=0,off=0,imm=0) R7=inv(id=0) R8=fp-24,call_2 R10=fp0,call_2 
fp-40=0 fp-48=0 fp-80=0 fp-88=0 fp-96=0 fp-104=0 fp-112=0 fp-120=0 
fp-128=0 fp-136=0 fp-144=0 fp-152=0 fp-160=0 fp-168=0 fp-176=0 fp-184=0 
fp-192=0 fp-200=0 fp-208=0 fp-216=0 fp-224=0 fp-232=0 fp-240=0 fp-248=0 
fp-256=0 fp-264=0 fp-272=0 fp-280=0 fp-288=0 fp-296=0 fp-304=0 fp-312=0 
fp-320=0 fp-328=0 fp-336=0 fp-344=0 fp-360=0 fp-376=0
111: (bf) r1 = r10
112: (07) r1 += -24
113: (71) r1 = *(u8 *)(r1 +0)
114: (67) r1 <<= 2
115: (57) r1 &= 60
116: (05) goto pc+1
118: (0f) r7 += r1
119: (b7) r1 = 0
120: (b7) r3 = 0
121: (b7) r4 = 0
122: (b7) r2 = 0
123: (15) if r7 == 0x0 goto pc+13
  frame1: R0=inv(id=0) R1=inv0 R2=inv0 R3=inv0 R4=inv0 R5=inv6 
R6=ctx(id=0,off=0,imm=0) R7=inv(id=0) R8=fp-24,call_2 R10=fp0,call_2 
fp-40=0 fp-48=0 fp-80=0 fp-88=0 fp-96=0 fp-104=0 fp-112=0 fp-120=0 
fp-128=0 fp-136=0 fp-144=0 fp-152=0 fp-160=0 fp-168=0 fp-176=0 fp-184=0 
fp-192=0 fp-200=0 fp-208=0 fp-216=0 fp-224=0 fp-232=0 fp-240=0 fp-248=0 
fp-256=0 fp-264=0 fp-272=0 fp-280=0 fp-288=0 fp-296=0 fp-304=0 fp-312=0 
fp-320=0 fp-328=0 fp-336=0 fp-344=0 fp-360=0 fp-376=0
124: (bf) r8 = r10
125: (07) r8 += -48
126: (bf) r1 = r8
127: (b7) r2 = 20
128: (bf) r3 = r7
129: (85) call bpf_probe_read#4
130: (bf) r1 = r10
131: (07) r1 += -24
132: (69) r2 = *(u16 *)(r8 +2)
133: (61) r3 = *(u32 *)(r1 +16)
134: (61) r1 = *(u32 *)(r1 +12)
135: (69) r4 = *(u16 *)(r8 +0)
136: (dc) r4 = be16 r4
137: (63) *(u32 *)(r10 -372) = r1
138: (63) *(u32 *)(r10 -376) = r3
139: (dc) r4 = be16 r4
140: (6b) *(u16 *)(r10 -366) = r4
141: (dc) r2 = be16 r2
142: (6b) *(u16 *)(r10 -368) = r2
143: (79) r7 = *(u64 *)(r10 -72)
144: (55) if r7 != 0x0 goto pc+15
  frame1: R0=inv(id=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 
0xffffffff)) R2=inv(id=0) 
R3=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) 
R4=inv(id=0) R6=ctx(id=0,off=0,imm=0) R7=inv0 R8=fp-48,call_2 
R10=fp0,call_2 fp-80=0 fp-88=0 fp-96=0 fp-104=0 fp-112=0 fp-120=0 
fp-128=0 fp-136=0 fp-144=0 fp-152=0 fp-160=0 fp-168=0 fp-176=0 fp-184=0 
fp-192=0 fp-200=0 fp-208=0 fp-216=0 fp-224=0 fp-232=0 fp-240=0 fp-248=0 
fp-256=0 fp-264=0 fp-272=0 fp-280=0 fp-288=0 fp-296=0 fp-304=0 fp-312=0 
fp-320=0 fp-328=0 fp-336=0 fp-344=0 fp-360=0
145: (bf) r2 = r10
146: (07) r2 += -376
147: (18) r1 = 0xffff97062f35e000
149: (85) call bpf_map_lookup_elem#1
150: (15) if r0 == 0x0 goto pc+131
  frame1: R0=map_value(id=0,off=0,ks=12,vs=8,imm=0) 
R6=ctx(id=0,off=0,imm=0) R7=inv0 R8=fp-48,call_2 R10=fp0,call_2 fp-80=0 
fp-88=0 fp-96=0 fp-104=0 fp-112=0 fp-120=0 fp-128=0 fp-136=0 fp-144=0 
fp-152=0 fp-160=0 fp-168=0 fp-176=0 fp-184=0 fp-192=0 fp-200=0 fp-208=0 
fp-216=0 fp-224=0 fp-232=0 fp-240=0 fp-248=0 fp-256=0 fp-264=0 fp-272=0 
fp-280=0 fp-288=0 fp-296=0 fp-304=0 fp-312=0 fp-320=0 fp-328=0 fp-336=0 
fp-344=0 fp-360=0
151: (79) r1 = *(u64 *)(r0 +0)
  frame1: R0=map_value(id=0,off=0,ks=12,vs=8,imm=0) 
R6=ctx(id=0,off=0,imm=0) R7=inv0 R8=fp-48,call_2 R10=fp0,call_2 fp-80=0 
fp-88=0 fp-96=0 fp-104=0 fp-112=0 fp-120=0 fp-128=0 fp-136=0 fp-144=0 
fp-152=0 fp-160=0 fp-168=0 fp-176=0 fp-184=0 fp-192=0 fp-200=0 fp-208=0 
fp-216=0 fp-224=0 fp-232=0 fp-240=0 fp-248=0 fp-256=0 fp-264=0 fp-272=0 
fp-280=0 fp-288=0 fp-296=0 fp-304=0 fp-312=0 fp-320=0 fp-328=0 fp-336=0 
fp-344=0 fp-360=0
152: (79) r7 = *(u64 *)(r10 -72)
153: (55) if r7 != 0x0 goto pc+58
  frame1: R0=map_value(id=0,off=0,ks=12,vs=8,imm=0) R1=inv(id=0) 
R6=ctx(id=0,off=0,imm=0) R7=inv0 R8=fp-48,call_2 R10=fp0,call_2 fp-80=0 
fp-88=0 fp-96=0 fp-104=0 fp-112=0 fp-120=0 fp-128=0 fp-136=0 fp-144=0 
fp-152=0 fp-160=0 fp-168=0 fp-176=0 fp-184=0 fp-192=0 fp-200=0 fp-208=0 
fp-216=0 fp-224=0 fp-232=0 fp-240=0 fp-248=0 fp-256=0 fp-264=0 fp-272=0 
fp-280=0 fp-288=0 fp-296=0 fp-304=0 fp-312=0 fp-320=0 fp-328=0 fp-336=0 
fp-344=0 fp-360=0
154: (18) r2 = 0x123456776543210
156: (1d) if r1 == r2 goto pc+125
  frame1: R0=map_value(id=0,off=0,ks=12,vs=8,imm=0) R1=inv(id=0) 
R2=inv81985528891978256 R6=ctx(id=0,off=0,imm=0) R7=inv0 R8=fp-48,call_2 
R10=fp0,call_2 fp-80=0 fp-88=0 fp-96=0 fp-104=0 fp-112=0 fp-120=0 
fp-128=0 fp-136=0 fp-144=0 fp-152=0 fp-160=0 fp-168=0 fp-176=0 fp-184=0 
fp-192=0 fp-200=0 fp-208=0 fp-216=0 fp-224=0 fp-232=0 fp-240=0 fp-248=0 
fp-256=0 fp-264=0 fp-272=0 fp-280=0 fp-288=0 fp-296=0 fp-304=0 fp-312=0 
fp-320=0 fp-328=0 fp-336=0 fp-344=0 fp-360=0
157: (7b) *(u64 *)(r10 -72) = r1
158: (bf) r7 = r1
159: (05) goto pc+62
222: (b7) r1 = 0
223: (bf) r3 = r7
224: (0f) r3 += r1
225: (bf) r1 = r10
226: (07) r1 += -356
227: (b7) r2 = 4
228: (85) call bpf_probe_read#4
229: (b7) r1 = 12
230: (bf) r3 = r7
231: (0f) r3 += r1
232: (bf) r1 = r10
233: (07) r1 += -350
234: (b7) r2 = 2
235: (85) call bpf_probe_read#4
236: (b7) r1 = 4
237: (bf) r3 = r7
238: (0f) r3 += r1
239: (bf) r1 = r10
240: (07) r1 += -360
241: (b7) r2 = 4
242: (85) call bpf_probe_read#4
243: (b7) r1 = 14
244: (0f) r7 += r1
245: (bf) r1 = r10
246: (07) r1 += -352
247: (b7) r2 = 2
248: (bf) r3 = r7
249: (85) call bpf_probe_read#4
250: (b7) r1 = 20
251: (7b) *(u64 *)(r10 -80) = r1
252: (85) call bpf_get_current_pid_tgid#14
253: (77) r0 >>= 32
254: (63) *(u32 *)(r10 -324) = r0
255: (bf) r1 = r10
256: (07) r1 += -320
257: (b7) r2 = 16
258: (85) call bpf_get_current_comm#16
259: (79) r1 = *(u64 *)(r10 -80)
260: (07) r1 += 20
261: (7b) *(u64 *)(r10 -80) = r1
262: (bf) r7 = r10
263: (07) r7 += -344
264: (0f) r7 += r1
math between fp pointer and register with unbounded min value is not allowed


Thank you very much!
