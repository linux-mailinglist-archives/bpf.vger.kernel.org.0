Return-Path: <bpf+bounces-17329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C20D480B896
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 04:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E211F2105E
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 03:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C3515C4;
	Sun, 10 Dec 2023 03:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WY/DgtL8"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [IPv6:2001:41d0:203:375::b3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507B2FE
	for <bpf@vger.kernel.org>; Sat,  9 Dec 2023 19:43:40 -0800 (PST)
Message-ID: <0ff5f011-7524-4550-89eb-bb2c89f699d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702179818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A+pEJewun3eaUD1eHSwUfjR5OhWjcvrMKUclK7yanaY=;
	b=WY/DgtL8vmD697gQLqqv1eZEAVn31SDP3lGURwm28ei1ivln/7SdsHCL1xSzGEw1gaaVyo
	xZWHRAaJlJ5o+x8WWfIhn7YjLqdJXdqanscbtysYmFFv8qFE8xsq6FS5nednsmt1VwcJCs
	S1Lvf0wHXHNy1JfOItWe0jFFCwKMf7Q=
Date: Sat, 9 Dec 2023 19:43:19 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: bpf <bpf@vger.kernel.org>, Eddy Z <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
Subject: bpf selftest iters/iter_arr_with_actual_elem_count failure with
 latest llvm cpu=v4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

I just found that with latest bpf-next, selftest iters/iter_arr_with_actual_elem_count
failed with latest llvm when running './test_progs-cpuv4 -j'.

The failure looks like below:

...
libbpf: prog 'iter_arr_with_actual_elem_count': BPF program load failed: Invalid argument
libbpf: prog 'iter_arr_with_actual_elem_count': failed to load: -22
libbpf: failed to load object 'iters'
run_subtest:FAIL:unexpected_load_failure unexpected error: -22 (errno 22)
VERIFIER LOG:
=============
reg type unsupported for arg#0 function iter_arr_with_actual_elem_count#112
0: R1=ctx() R10=fp0
; int iter_arr_with_actual_elem_count(const void *ctx)
0: (b4) w7 = 0                        ; R7_w=0
; int i, n = loop_data.n, sum = 0;
1: (18) r1 = 0xffffc90000162478       ; R1_w=map_value(map=iters.bss,ks=4,vs=1280,off=1144)
3: (61) r6 = *(u32 *)(r1 +128)        ; R1_w=map_value(map=iters.bss,ks=4,vs=1280,off=1144) R6_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
; if (n > ARRAY_SIZE(loop_data.data))
4: (26) if w6 > 0x20 goto pc+27       ; R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=32,var_off=(0x0; 0x3f))
5: (bf) r8 = r10                      ; R8_w=fp0 R10=fp0
; bpf_for(i, 0, n) {
6: (07) r8 += -8                      ; R8_w=fp-8
7: (bf) r1 = r8                       ; R1_w=fp-8 R8_w=fp-8
8: (b4) w2 = 0                        ; R2_w=0
9: (bc) w3 = w6                       ; R3_w=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=32,var_off=(0x0; 0x3f)) R6_w=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax)
10: (85) call bpf_iter_num_new#91189          ; R0=scalar() fp-8=iter_num(ref_id=2,state=active,depth=0) refs=2
; bpf_for(i, 0, n) {
11: (bf) r1 = r8                      ; R1=fp-8 R8=fp-8 refs=2
12: (85) call bpf_iter_num_next#91191 13: R0=rdonly_mem(id=3,ref_obj_id=2) R6=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=32,var_off=(0x0; 0x3f)) R7=0 R8=fp-8 R10=fp2
; bpf_for(i, 0, n) {
13: (15) if r0 == 0x0 goto pc+2       ; R0=rdonly_mem(id=3,ref_obj_id=2) refs=2
14: (81) r1 = *(s32 *)(r0 +0)         ; R0=rdonly_mem(id=3,ref_obj_id=2) R1_w=scalar(smin=0xffffffff80000000,smax=0x7fffffff) refs=2
; bpf_for(i, 0, n) {
15: (ae) if w1 < w6 goto pc+4 20: R0=rdonly_mem(id=3,ref_obj_id=2) R1=scalar(smin=0xffffffff80000000,smax=smax32=umax32=31,umax=0xffffffff0000001f,smin32=0,var_off=(0x0; 02
; sum += loop_data.data[i];
20: (67) r1 <<= 2                     ; R1_w=scalar(smax=0x7ffffffc0000007c,umax=0xfffffffc0000007c,smin32=0,smax32=umax32=124,var_off=(0x0; 0xfffffffc0000007c)) refs=2
21: (18) r2 = 0xffffc90000162478      ; R2_w=map_value(map=iters.bss,ks=4,vs=1280,off=1144) refs=2
23: (0f) r2 += r1
math between map_value pointer and register with unbounded min value is not allowed
processed 31 insns (limit 1000000) max_states_per_insn 0 total_states 4 peak_states 4 mark_read 3
=============
#106/51  iters/iter_arr_with_actual_elem_count:FAIL
...


At insn #14, a signed load is read into r1.
At insn #15, a condition 'w1 < w6' try to refine the range of w1. Considering w6 range [0, 32],
   w1 also having range [0, 32].
But unfortunately, the w1 range [0, 32] is not helpful to refine r1 as sign extension
   information (w1 -> r1) is not available to insn #15.
At insn #20, r1 initial range keeps
   R1=scalar(smin=0xffffffff80000000,smax=smax32=umax32=31,umax=0xffffffff0000001f,smin32=0,var_off=(0x0
, ...)
and this caused verification failure.

The following llvm patch is responsible for the regression:
   https://github.com/llvm/llvm-project/commit/d77067d08a3f56dc2d0e6c95bd2852c943df743a

We will do further debugging to see how much we can do in llvm side to resolve this case.

Yonghong


