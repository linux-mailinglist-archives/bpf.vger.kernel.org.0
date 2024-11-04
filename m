Return-Path: <bpf+bounces-43909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CFA9BBC44
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 18:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F471C21C42
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 17:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746ED1BD01D;
	Mon,  4 Nov 2024 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OKXlHfBZ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B01E1C9ED6
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742395; cv=none; b=nuo7Ipko+3KdhK2HLJIQiXP2HKSqmrqCPNk64XW4Oz6zwIJcqc8ubcxPJRPhaH22WUKlUzL0joCOQXbTlSit4SrtlvQzwlOqlgAqQkXozHsQnQiVO6L7gGjGEpyLzKZWOt8hF7kM/PHHm9Oso+fwGyIuqV1xW9s14NvBSOz+MZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742395; c=relaxed/simple;
	bh=ZcqEkptKZ3czW1QrRrNhes9Noqr5r+0FbqzF/ezj8XE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sG/uXWmxp8wpKsTGZz8UUdQvR3q6PHsWILqGA671vd7e9uvfaw2ZkSEWM+z2h4iXiiGMu7UEorFM/m3GzW8LODqVMqMpBpSc7GkWUz/cHST0vJbXbisatjoPt7t3kn2KTax1qzsqyJzcw7iqVh8ZEIJSmtm4ZzPuH5X0W68s8sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OKXlHfBZ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730742393; x=1762278393;
  h=date:from:to:subject:message-id:mime-version;
  bh=ZcqEkptKZ3czW1QrRrNhes9Noqr5r+0FbqzF/ezj8XE=;
  b=OKXlHfBZxBmkBNz+gQPS9zULNisU14zyvqQIBYvAHhEGfY85opUQmFSv
   ogbaAGWGUPcYDQFhElQs4670S8q0+2eYwZiqI7lNSzNpufmWBeX2+xi4V
   6gNQAU6yIHlw6UMSzpZZ6GvIbxfkhFaMZNsg1UWsFxGUoXJFrPYcaRufd
   qVCLj7hKHNgbIbCq54W1TkZhxiRZY7kVyDPbAEND/panPzWmX8zFdpghE
   1uHfsqGuqXoiXsBgTFQmUNhsE0Rwed6xlPHzYlimNYLf9bksAo4FzlPEi
   KlE46K/jZaTdsEVpkXVD3Q8JMsmEKs9AulwMwipk0SbnzQ4V5K89d8AKl
   w==;
X-CSE-ConnectionGUID: yfB7wsydRWio9256FoxO2g==
X-CSE-MsgGUID: K00qMRYnS/yDfBDgGc0zug==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="30568264"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="30568264"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 09:46:32 -0800
X-CSE-ConnectionGUID: 11wN2kY2QXSnCvpUpe7ajw==
X-CSE-MsgGUID: Q9lbjQRBRG2DGOxunDLl8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="83608827"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO himmelriiki) ([10.245.245.39])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 09:46:31 -0800
Date: Mon, 4 Nov 2024 19:46:17 +0200
From: Mikko Ylinen <mikko.ylinen@linux.intel.com>
To: bpf@vger.kernel.org
Subject: program of this type cannot use helper xyz with bpf_struct_ops
Message-ID: <ZykIaV1yyTUOI8yF@himmelriiki>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I was experimenting with struct_ops for my use-case but the programs
would not load because of "program of this type cannot use helper
xyz" error. However, [1] suggests that the ones I tried *are* supported.
Is the doc outdated or my steps are simply wrong here?

Andrii suggested to report the case here with reproduce steps so here
it goes.

with:

diff --git a/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c b/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c
index ec0c595d47af..c3ca873957f0 100644
--- a/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c
+++ b/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c
@@ -39,6 +39,7 @@ int BPF_PROG(test_2, struct bpf_dummy_ops_state *state, int a1, unsigned short a
        test_2_args[2] = a2;
        test_2_args[3] = a3;
        test_2_args[4] = a4;
+       bpf_printk("struct_ops/test_2");
        return 0;
 }

and:
tools/testing/selftests/bpf/vmtest.sh -- ./test_progs -t dummy_st_ops/dummy_st_ops_attach

I get:

[build + VM boot cut out]
./test_progs -t dummy_st_ops/dummy_st_ops_attach
[    1.068102] bpf_testmod: loading out-of-tree module taints kernel.
[    1.068733] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
tester_init:PASS:tester_log_buf 0 nsec
process_subtest:PASS:obj_open_mem 0 nsec
process_subtest:PASS:specs_alloc 0 nsec
libbpf: prog 'test_2': BPF program load failed: Invalid argument
libbpf: prog 'test_2': -- BEGIN PROG LOAD LOG --
0: R1=ctx() R10=fp0
; int BPF_PROG(test_2, struct bpf_dummy_ops_state *state, int a1, unsigned short a2, @ dummy_st_ops_success.c:40
0: (79) r2 = *(u64 *)(r1 +0)
func 'test_2' arg0 has btf_id 83075 type STRUCT 'bpf_dummy_ops_state'
1: R1=ctx() R2_w=trusted_ptr_bpf_dummy_ops_state()
; test_2_args[0] = state->val; @ dummy_st_ops_success.c:43
1: (61) r2 = *(u32 *)(r2 +0)          ; R2_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
; int BPF_PROG(test_2, struct bpf_dummy_ops_state *state, int a1, unsigned short a2, @ dummy_st_ops_success.c:40
2: (79) r3 = *(u64 *)(r1 +8)          ; R1=ctx() R3_w=scalar()
3: (79) r4 = *(u64 *)(r1 +16)         ; R1=ctx() R4_w=scalar()
4: (79) r5 = *(u64 *)(r1 +24)         ; R1=ctx() R5_w=scalar()
5: (79) r1 = *(u64 *)(r1 +32)         ; R1_w=scalar()
; test_2_args[0] = state->val; @ dummy_st_ops_success.c:43
6: (18) r0 = 0xffffb456400f6000       ; R0_w=map_value(map=dummy_st.bss,ks=4,vs=40)
; test_2_args[4] = a4; @ dummy_st_ops_success.c:47
8: (7b) *(u64 *)(r0 +32) = r1         ; R0_w=map_value(map=dummy_st.bss,ks=4,vs=40) R1_w=scalar()
; test_2_args[3] = a3; @ dummy_st_ops_success.c:46
9: (67) r5 <<= 56                     ; R5_w=scalar(smax=0x7f00000000000000,umax=0xff00000000000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xff00000000000000))
10: (c7) r5 s>>= 56                   ; R5_w=scalar(smin=smin32=-128,smax=smax32=127)
11: (7b) *(u64 *)(r0 +24) = r5        ; R0_w=map_value(map=dummy_st.bss,ks=4,vs=40) R5_w=scalar(smin=smin32=-128,smax=smax32=127)
; int BPF_PROG(test_2, struct bpf_dummy_ops_state *state, int a1, unsigned short a2, @ dummy_st_ops_success.c:40
12: (57) r4 &= 65535                  ; R4_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff))
; test_2_args[2] = a2; @ dummy_st_ops_success.c:45
13: (7b) *(u64 *)(r0 +16) = r4        ; R0_w=map_value(map=dummy_st.bss,ks=4,vs=40) R4_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff))
; test_2_args[1] = a1; @ dummy_st_ops_success.c:44
14: (67) r3 <<= 32                    ; R3_w=scalar(smax=0x7fffffff00000000,umax=0xffffffff00000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xffffffff00000000))
15: (c7) r3 s>>= 32                   ; R3_w=scalar(smin=0xffffffff80000000,smax=0x7fffffff)
16: (7b) *(u64 *)(r0 +8) = r3         ; R0_w=map_value(map=dummy_st.bss,ks=4,vs=40) R3_w=scalar(smin=0xffffffff80000000,smax=0x7fffffff)
; test_2_args[0] = state->val; @ dummy_st_ops_success.c:43
17: (67) r2 <<= 32                    ; R2_w=scalar(smax=0x7fffffff00000000,umax=0xffffffff00000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xffffffff00000000))
18: (c7) r2 s>>= 32                   ; R2_w=scalar(smin=0xffffffff80000000,smax=0x7fffffff)
19: (7b) *(u64 *)(r0 +0) = r2         ; R0_w=map_value(map=dummy_st.bss,ks=4,vs=40) R2_w=scalar(smin=0xffffffff80000000,smax=0x7fffffff)
; bpf_printk("struct_ops/test_2"); @ dummy_st_ops_success.c:48
20: (18) r1 = 0xffff9481c114e5d8      ; R1_w=map_value(map=dummy_st.rodata,ks=4,vs=18)
22: (b4) w2 = 18                      ; R2_w=18
23: (85) call bpf_trace_printk#6
program of this type cannot use helper bpf_trace_printk#6
processed 22 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
-- END PROG LOAD LOG --
libbpf: prog 'test_2': failed to load: -22
libbpf: failed to load object 'dummy_st_ops_success'
libbpf: failed to load BPF skeleton 'dummy_st_ops_success': -22
test_dummy_st_ops_attach:FAIL:dummy_st_ops_load unexpected error: -22
#84/1    dummy_st_ops/dummy_st_ops_attach:FAIL
#84      dummy_st_ops:FAIL


I can reproduce this with 6.12-rc6 and 6.11.6 source (6.11 I needed to
patch with 424ebaa3678 to get test_loader.c to compile, though).

FWIW, adding the same change to progs/bpf_dctcp.c and running
bpf_tcp_ca tests passed OK for some reason.

Mikko

[1] https://docs.ebpf.io/linux/program-type/BPF_PROG_TYPE_STRUCT_OPS/#helper-functions 

