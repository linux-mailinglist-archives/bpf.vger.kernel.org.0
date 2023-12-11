Return-Path: <bpf+bounces-17416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF91B80CF93
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 16:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E07281AAA
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 15:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CBE4B5C5;
	Mon, 11 Dec 2023 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZ2vTxdk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8580BE8;
	Mon, 11 Dec 2023 07:31:28 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-db8892a5f96so4299088276.2;
        Mon, 11 Dec 2023 07:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702308688; x=1702913488; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CEhWuihaJ1mm2Ofkvr3IMNsaBmNLx1/iTtyp+xC8zlg=;
        b=DZ2vTxdkRUi7QYVqAh2d5mlNQs22GIxOWwynTxxH4HpKgvmgWjQHgzt/z/m6Gz2PZM
         YVWPqe7xKL/SM8Eqsdiqen7L4QYBlx0R7+BnEkTBuaTmpaUrHtxb4SMg2h1W9obOiTjJ
         EoVMp4M/Bj0T7ZSKANjdCGDYCGsbgxyV1KQNv6XdjTMvZem6I2c6dVBLYjr7bCM5v06Y
         XXErDpHxRbMIYyBQw3tl4FdtoKzGpcHth+Ap7TTAfg5Ip7jAyjqgb6Gg379+GiGTZh5V
         uTPONbZVGl93Tkw5nUjDd9ZuzWCBXJ15+5qIRz2He5U66NdymldU9WFKnZCU5xsJg8DV
         G0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308688; x=1702913488;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CEhWuihaJ1mm2Ofkvr3IMNsaBmNLx1/iTtyp+xC8zlg=;
        b=NlKr+MLAwO6fwBaSYPN/2Y5CFuZmlqvfZ7UO7HR4ANxmQGLFt06yV6zm7sKr1/hGer
         dZ4KWoEfsXruLPv2triWHol1cxubxHBjRYnnDdot5LUeyAQyg+ZHSnnHi3mIq7yObwoz
         cK+yi7vCra9RzkQ1/7QlrqGYWTvsFH5QjzHmvhG09mOn1o/anS5I+xsg28r7PYmV+9b7
         /QMMCCe99ERGSPH/axmY1xfic9pFqjtZwwqssEfXoIHOrRuUspdvVhjTvY58TZ6g799H
         deqV5oE7r8AXd6IqEkto6P8seOksEKyRAwnP95sgD3ky+/BLADswhCqdd7uQzH5QzbSE
         CnPw==
X-Gm-Message-State: AOJu0YzBPScknGBZMtwLMOAi8bqiunMNjJ/H0eahlgY3eQYV/vV7onVX
	S8aYB7WS8ouMuXABTn+eNS4ov0Y7rD+aMBfrMWeUTcD5rQ==
X-Google-Smtp-Source: AGHT+IFUOI0znCcfv80KSUJ9i/zGSe3JbVSfhldQt3kesmcBJACiFkxN/65aWKU3jjlmAER04eZsmoZ8UVypvgzRYY8=
X-Received: by 2002:a25:a481:0:b0:db7:dacf:620a with SMTP id
 g1-20020a25a481000000b00db7dacf620amr2269476ybi.92.1702308687517; Mon, 11 Dec
 2023 07:31:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hao Sun <sunhao.th@gmail.com>
Date: Mon, 11 Dec 2023 16:31:16 +0100
Message-ID: <CACkBjsbj4y4EhqpV-ZVt645UtERJRTxfEab21jXD1ahPyzH4_g@mail.gmail.com>
Subject: [Bug Report] bpf: incorrectly pruning runtime execution path
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

The verifier incorrectly prunes a path expected to be executed at
runtime. In the following program, the execution path is:
    from 6 to 8 (taken) -> from 11 to 15 (taken) -> from 18 to 22
(taken) -> from 26 to 27 (fall-through) -> from 29 to 30
(fall-through)
The verifier prunes the checking path at #26, skipping the actual
execution path.

   0: (18) r2 = 0x1a000000be
   2: (bf) r5 = r1
   3: (bf) r8 = r2
   4: (bc) w4 = w5
   5: (85) call bpf_get_current_cgroup_id#680112
   6: (36) if w8 >= 0x69 goto pc+1
   7: (95) exit
   8: (18) r4 = 0x52
  10: (84) w4 = -w4
  11: (45) if r0 & 0xfffffffe goto pc+3
  12: (1f) r8 -= r4
  13: (0f) r0 += r0
  14: (2f) r4 *= r4
  15: (18) r3 = 0x1f00000034
  17: (c4) w4 s>>= 29
  18: (56) if w8 != 0xf goto pc+3
  19: r3 = bswap32 r3
  20: (18) r2 = 0x1c
  22: (67) r4 <<= 2
  23: (bf) r5 = r8
  24: (18) r2 = 0x4
  26: (7e) if w8 s>= w0 goto pc+5
  27: (4f) r8 |= r8
  28: (0f) r8 += r8
  29: (d6) if w5 s<= 0x1d goto pc+2
  30: (18) r0 = 0x4 ; incorrectly pruned here
  32: (95) exit

-------- Verifier Log --------
func#0 @0
0: R1=ctx() R10=fp0
0: (18) r2 = 0x1a000000be             ; R2_w=0x1a000000be
2: (bf) r5 = r1                       ; R1=ctx() R5_w=ctx()
3: (bf) r8 = r2                       ; R2_w=0x1a000000be R8_w=0x1a000000be
4: (bc) w4 = w5                       ;
R4_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
R5_w=ctx()
5: (85) call bpf_get_current_cgroup_id#80     ; R0_w=scalar()
6: (36) if w8 >= 0x69 goto pc+1
mark_precise: frame0: last_idx 6 first_idx 0 subseq_idx -1
mark_precise: frame0: regs=r8 stack= before 5: (85) call
bpf_get_current_cgroup_id#80
mark_precise: frame0: regs=r8 stack= before 4: (bc) w4 = w5
mark_precise: frame0: regs=r8 stack= before 3: (bf) r8 = r2
mark_precise: frame0: regs=r2 stack= before 2: (bf) r5 = r1
mark_precise: frame0: regs=r2 stack= before 0: (18) r2 = 0x1a000000be
6: R8_w=0x1a000000be
8: (18) r4 = 0x52                     ; R4_w=82
10: (84) w4 = -w4                     ; R4=scalar()
11: (45) if r0 & 0xfffffffe goto pc+3         ;
R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
12: (1f) r8 -= r4                     ; R4=scalar() R8_w=scalar()
13: (0f) r0 += r0                     ;
R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,var_off=(0x0;
0x3))
14: (2f) r4 *= r4                     ; R4_w=scalar()
15: (18) r3 = 0x1f00000034            ; R3_w=0x1f00000034
17: (c4) w4 s>>= 29                   ;
R4_w=scalar(smin=0,smax=umax=0xffffffff,smin32=-4,smax32=3,var_off=(0x0;
0xffffffff))
18: (56) if w8 != 0xf goto pc+3       ;
R8_w=scalar(smin=0x800000000000000f,smax=0x7fffffff0000000f,umin=smin32=umin32=15,umax=0xffffffff0000000f,smax32=umax32=15,var_off=(0xf;
0xffffffff00000000))
19: (d7) r3 = bswap32 r3              ; R3_w=scalar()
20: (18) r2 = 0x1c                    ; R2=28
22: (67) r4 <<= 2                     ;
R4_w=scalar(smin=0,smax=umax=0x3fffffffc,smax32=0x7ffffffc,umax32=0xfffffffc,var_off=(0x0;
0x3fffffffc))
23: (bf) r5 = r8                      ;
R5_w=scalar(id=1,smin=0x800000000000000f,smax=0x7fffffff0000000f,umin=smin32=umin32=15,umax=0xffffffff0000000f,smax32=umax32=15,var_off=(0xf;
0xffffffff00000000))
R8=scalar(id=1,smin=0x800000000000000f,smax=0x7fffffff0000000f,umin=smin32=umin32=15,umax=0xffffffff0000000f,smax32=umax32=15,var_off=(0xf;
0xffffffff00000000))
24: (18) r2 = 0x4                     ; R2_w=4
26: (7e) if w8 s>= w0 goto pc+5
mark_precise: frame0: last_idx 26 first_idx 22 subseq_idx -1
mark_precise: frame0: regs=r5,r8 stack= before 24: (18) r2 = 0x4
mark_precise: frame0: regs=r5,r8 stack= before 23: (bf) r5 = r8
mark_precise: frame0: regs=r8 stack= before 22: (67) r4 <<= 2
mark_precise: frame0: parent state regs=r8 stack=:
R0_rw=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,var_off=(0x0;
0x3)) R2_w=28 R3_w=scalar()
R4_rw=scalar(smin=0,smax=umax=0xffffffff,smin32=-4,smax32=3,var_off=(0x0;
0xffffffff)) R8_rw=Pscalar(smin=0x800000000000000f,smax=0x7fffffff0000000f,umin=smin32=umin32=15,umax=0xffffffff0000000f,smax32=umax32=15,var_off=(0xf;
0xffffffff00000000)) R10=fp0
mark_precise: frame0: last_idx 20 first_idx 11 subseq_idx 22
mark_precise: frame0: regs=r8 stack= before 20: (18) r2 = 0x1c
mark_precise: frame0: regs=r8 stack= before 19: (d7) r3 = bswap32 r3
mark_precise: frame0: regs=r8 stack= before 18: (56) if w8 != 0xf goto pc+3
mark_precise: frame0: regs=r8 stack= before 17: (c4) w4 s>>= 29
mark_precise: frame0: regs=r8 stack= before 15: (18) r3 = 0x1f00000034
mark_precise: frame0: regs=r8 stack= before 14: (2f) r4 *= r4
mark_precise: frame0: regs=r8 stack= before 13: (0f) r0 += r0
mark_precise: frame0: regs=r8 stack= before 12: (1f) r8 -= r4
mark_precise: frame0: regs=r4,r8 stack= before 11: (45) if r0 &
0xfffffffe goto pc+3
mark_precise: frame0: parent state regs=r4,r8 stack=:  R0_rw=scalar()
R4_rw=Pscalar() R8_rw=P0x1a000000be R10=fp0
mark_precise: frame0: last_idx 10 first_idx 0 subseq_idx 11
mark_precise: frame0: regs=r4,r8 stack= before 10: (84) w4 = -w4
mark_precise: frame0: regs=r4,r8 stack= before 8: (18) r4 = 0x52
mark_precise: frame0: regs=r8 stack= before 6: (36) if w8 >= 0x69 goto pc+1
mark_precise: frame0: regs=r8 stack= before 5: (85) call
bpf_get_current_cgroup_id#80
mark_precise: frame0: regs=r8 stack= before 4: (bc) w4 = w5
mark_precise: frame0: regs=r8 stack= before 3: (bf) r8 = r2
mark_precise: frame0: regs=r2 stack= before 2: (bf) r5 = r1
mark_precise: frame0: regs=r2 stack= before 0: (18) r2 = 0x1a000000be
mark_precise: frame0: last_idx 26 first_idx 22 subseq_idx -1
mark_precise: frame0: regs=r0 stack= before 24: (18) r2 = 0x4
mark_precise: frame0: regs=r0 stack= before 23: (bf) r5 = r8
mark_precise: frame0: regs=r0 stack= before 22: (67) r4 <<= 2
mark_precise: frame0: parent state regs=r0 stack=:
R0_rw=Pscalar(smin=smin32=0,smax=umax=smax32=umax32=2,var_off=(0x0;
0x3)) R2_w=28 R3_w=scalar()
R4_rw=scalar(smin=0,smax=umax=0xffffffff,smin32=-4,smax32=3,var_off=(0x0;
0xffffffff)) R8_rw=Pscalar(smin=0x800000000000000f,smax=0x7fffffff0000000f,umin=smin32=umin32=15,umax=0xffffffff0000000f,smax32=umax32=15,var_off=(0xf;
0xffffffff00000000)) R10=fp0
mark_precise: frame0: last_idx 20 first_idx 11 subseq_idx 22
mark_precise: frame0: regs=r0 stack= before 20: (18) r2 = 0x1c
mark_precise: frame0: regs=r0 stack= before 19: (d7) r3 = bswap32 r3
mark_precise: frame0: regs=r0 stack= before 18: (56) if w8 != 0xf goto pc+3
mark_precise: frame0: regs=r0 stack= before 17: (c4) w4 s>>= 29
mark_precise: frame0: regs=r0 stack= before 15: (18) r3 = 0x1f00000034
mark_precise: frame0: regs=r0 stack= before 14: (2f) r4 *= r4
mark_precise: frame0: regs=r0 stack= before 13: (0f) r0 += r0
mark_precise: frame0: regs=r0 stack= before 12: (1f) r8 -= r4
mark_precise: frame0: regs=r0 stack= before 11: (45) if r0 &
0xfffffffe goto pc+3
mark_precise: frame0: parent state regs=r0 stack=:  R0_rw=Pscalar()
R4_rw=Pscalar() R8_rw=P0x1a000000be R10=fp0
mark_precise: frame0: last_idx 10 first_idx 0 subseq_idx 11
mark_precise: frame0: regs=r0 stack= before 10: (84) w4 = -w4
mark_precise: frame0: regs=r0 stack= before 8: (18) r4 = 0x52
mark_precise: frame0: regs=r0 stack= before 6: (36) if w8 >= 0x69 goto pc+1
mark_precise: frame0: regs=r0 stack= before 5: (85) call
bpf_get_current_cgroup_id#80
26: R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,var_off=(0x0;
0x3)) R8=scalar(id=1,smin=0x800000000000000f,smax=0x7fffffff0000000f,umin=smin32=umin32=15,umax=0xffffffff0000000f,smax32=umax32=15,var_off=(0xf;
0xffffffff00000000))
32: (95) exit

from 18 to 22: R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,var_off=(0x0;
0x3)) R3_w=0x1f00000034
R4_w=scalar(smin=0,smax=umax=0xffffffff,smin32=-4,smax32=3,var_off=(0x0;
0xffffffff)) R8_w=scalar() R10=fp0
22: R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,var_off=(0x0;
0x3)) R3_w=0x1f00000034
R4_w=scalar(smin=0,smax=umax=0xffffffff,smin32=-4,smax32=3,var_off=(0x0;
0xffffffff)) R8_w=scalar() R10=fp0
22: (67) r4 <<= 2                     ;
R4_w=scalar(smin=0,smax=umax=0x3fffffffc,smax32=0x7ffffffc,umax32=0xfffffffc,var_off=(0x0;
0x3fffffffc))
23: (bf) r5 = r8                      ; R5_w=scalar(id=2) R8_w=scalar(id=2)
24: (18) r2 = 0x4                     ; R2=4
26: (7e) if w8 s>= w0 goto pc+5       ;
R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,var_off=(0x0; 0x3))
R8=scalar(id=2,smax32=1)
27: (4f) r8 |= r8                     ; R8_w=scalar()
28: (0f) r8 += r8                     ; R8_w=scalar()
29: (d6) if w5 s<= 0x1d goto pc+2
mark_precise: frame0: last_idx 29 first_idx 26 subseq_idx -1
mark_precise: frame0: regs=r5 stack= before 28: (0f) r8 += r8
mark_precise: frame0: regs=r5 stack= before 27: (4f) r8 |= r8
mark_precise: frame0: regs=r5 stack= before 26: (7e) if w8 s>= w0 goto pc+5
mark_precise: frame0: parent state regs=r5 stack=:
R0_rw=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,var_off=(0x0;
0x3)) R2_w=4 R3_w=0x1f00000034
R4_w=scalar(smin=0,smax=umax=0x3fffffffc,smax32=0x7ffffffc,umax32=0xfffffffc,var_off=(0x0;
0x3fffffffc)) R5_rw=Pscalar(id=2) R8_rw=scalar(id=2) R10=fp0
mark_precise: frame0: last_idx 24 first_idx 11 subseq_idx 26
mark_precise: frame0: regs=r5,r8 stack= before 24: (18) r2 = 0x4
mark_precise: frame0: regs=r5,r8 stack= before 23: (bf) r5 = r8
mark_precise: frame0: regs=r8 stack= before 22: (67) r4 <<= 2
mark_precise: frame0: regs=r8 stack= before 18: (56) if w8 != 0xf goto pc+3
mark_precise: frame0: regs=r8 stack= before 17: (c4) w4 s>>= 29
mark_precise: frame0: regs=r8 stack= before 15: (18) r3 = 0x1f00000034
mark_precise: frame0: regs=r8 stack= before 14: (2f) r4 *= r4
mark_precise: frame0: regs=r8 stack= before 13: (0f) r0 += r0
mark_precise: frame0: regs=r8 stack= before 12: (1f) r8 -= r4
mark_precise: frame0: regs=r4,r8 stack= before 11: (45) if r0 &
0xfffffffe goto pc+3
mark_precise: frame0: parent state regs= stack=:  R0_rw=Pscalar()
R4_rw=Pscalar() R8_rw=P0x1a000000be R10=fp0
29: R5=scalar(id=2,smax32=1)
32: (95) exit

from 26 to 32: R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,var_off=(0x0;
0x3)) R2=4 R3=0x1f00000034
R4=scalar(smin=0,smax=umax=0x3fffffffc,smax32=0x7ffffffc,umax32=0xfffffffc,var_off=(0x0;
0x3fffffffc)) R5=scalar(id=2,smax=0x7fffffff7fffffff,umax=0xffffffff7fffffff,smin32=0,umax32=0x7fffffff,var_off=(0x0;
0xffffffff7fffffff))
R8=scalar(id=2,smax=0x7fffffff7fffffff,umax=0xffffffff7fffffff,smin32=0,umax32=0x7fffffff,var_off=(0x0;
0xffffffff7fffffff)) R10=fp0
32: R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,var_off=(0x0;
0x3)) R2=4 R3=0x1f00000034
R4=scalar(smin=0,smax=umax=0x3fffffffc,smax32=0x7ffffffc,umax32=0xfffffffc,var_off=(0x0;
0x3fffffffc)) R5=scalar(id=2,smax=0x7fffffff7fffffff,umax=0xffffffff7fffffff,smin32=0,umax32=0x7fffffff,var_off=(0x0;
0xffffffff7fffffff))
R8=scalar(id=2,smax=0x7fffffff7fffffff,umax=0xffffffff7fffffff,smin32=0,umax32=0x7fffffff,var_off=(0x0;
0xffffffff7fffffff)) R10=fp0
32: (95) exit

from 11 to 15: R0=scalar() R4=scalar() R8=0x1a000000be R10=fp0
15: R0=scalar() R4=scalar() R8=0x1a000000be R10=fp0
15: (18) r3 = 0x1f00000034            ; R3_w=0x1f00000034
17: (c4) w4 s>>= 29                   ;
R4=scalar(smin=0,smax=umax=0xffffffff,smin32=-4,smax32=3,var_off=(0x0;
0xffffffff))
18: (56) if w8 != 0xf goto pc+3
mark_precise: frame0: last_idx 18 first_idx 18 subseq_idx -1
mark_precise: frame0: parent state regs=r8 stack=:  R0=scalar()
R3_w=0x1f00000034
R4_w=scalar(smin=0,smax=umax=0xffffffff,smin32=-4,smax32=3,var_off=(0x0;
0xffffffff)) R8_r=P0x1a000000be R10=fp0
mark_precise: frame0: last_idx 17 first_idx 11 subseq_idx 18
mark_precise: frame0: regs=r8 stack= before 17: (c4) w4 s>>= 29
mark_precise: frame0: regs=r8 stack= before 15: (18) r3 = 0x1f00000034
mark_precise: frame0: regs=r8 stack= before 11: (45) if r0 &
0xfffffffe goto pc+3
mark_precise: frame0: parent state regs= stack=:  R0_rw=Pscalar()
R4_rw=Pscalar() R8_rw=P0x1a000000be R10=fp0
18: R8=0x1a000000be
22: (67) r4 <<= 2                     ;
R4_w=scalar(smin=0,smax=umax=0x3fffffffc,smax32=0x7ffffffc,umax32=0xfffffffc,var_off=(0x0;
0x3fffffffc))
23: (bf) r5 = r8                      ; R5_w=0x1a000000be R8=0x1a000000be
24: (18) r2 = 0x4
frame 0: propagating r5
mark_precise: frame0: last_idx 26 first_idx 18 subseq_idx -1
mark_precise: frame0: regs=r5 stack= before 24: (18) r2 = 0x4
mark_precise: frame0: regs=r5 stack= before 23: (bf) r5 = r8
mark_precise: frame0: regs=r8 stack= before 22: (67) r4 <<= 2
mark_precise: frame0: regs=r8 stack= before 18: (56) if w8 != 0xf goto pc+3
mark_precise: frame0: parent state regs= stack=:  R0_r=scalar()
R3_w=0x1f00000034
R4_rw=scalar(smin=0,smax=umax=0xffffffff,smin32=-4,smax32=3,var_off=(0x0;
0xffffffff)) R8_r=P0x1a000000be R10=fp0
26: safe
processed 38 insns (limit 1000000) max_states_per_insn 1 total_states
4 peak_states 4 mark_read 2

-------- End of Verifier Log --------

When the verifier backtracks from #29, I expected w0 at #26 (if w8 s>=
w0 goto pc+5) to be marked as precise since R8 and R5 share the same
id:

29: (d6) if w5 s<= 0x1d goto pc+2
mark_precise: frame0: last_idx 29 first_idx 26 subseq_idx -1
mark_precise: frame0: regs=r5 stack= before 28: (0f) r8 += r8
mark_precise: frame0: regs=r5 stack= before 27: (4f) r8 |= r8
mark_precise: frame0: regs=r5 stack= before 26: (7e) if w8 s>= w0 goto pc+5
mark_precise: frame0: parent state regs=r5 stack=:
R0_rw=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,var_off=(0x0;
0x3)) R2_w=4 R3_w=0x1f00000034
R4_w=scalar(smin=0,smax=umax=0x3fffffffc,smax32=0x7ffffffc,umax32=0xfffffffc,var_off=(0x0;
0x3fffffffc)) R5_rw=Pscalar(id=2) R8_rw=scalar(id=2) R10=fp0
mark_precise: frame0: last_idx 24 first_idx 11 subseq_idx 26
mark_precise: frame0: regs=r5,r8 stack= before 24: (18) r2 = 0x4
mark_precise: frame0: regs=r5,r8 stack= before 23: (bf) r5 = r8
mark_precise: frame0: regs=r8 stack= before 22: (67) r4 <<= 2
mark_precise: frame0: regs=r8 stack= before 18: (56) if w8 != 0xf goto pc+3
mark_precise: frame0: regs=r8 stack= before 17: (c4) w4 s>>= 29
mark_precise: frame0: regs=r8 stack= before 15: (18) r3 = 0x1f00000034
mark_precise: frame0: regs=r8 stack= before 14: (2f) r4 *= r4
mark_precise: frame0: regs=r8 stack= before 13: (0f) r0 += r0
mark_precise: frame0: regs=r8 stack= before 12: (1f) r8 -= r4
mark_precise: frame0: regs=r4,r8 stack= before 11: (45) if r0 &
0xfffffffe goto pc+3
mark_precise: frame0: parent state regs= stack=:  R0_rw=Pscalar()
R4_rw=Pscalar() R8_rw=P0x1a000000be R10=fp0
29: R5=scalar(id=2,smax32=1)

However, seems it's not, so the next time when the verifier checks
#26, R0 is incorrectly ignored.
We have mark_precise_scalar_ids(), but it's called before calculating
the mask once.
I investigated for quite a while, but mark_chain_pricision() is really
hard to follow.

Here is a reduced C repro, maybe someone else can shed some light on this.
C repro: https://pastebin.com/raw/chrshhGQ

Thanks
Hao

