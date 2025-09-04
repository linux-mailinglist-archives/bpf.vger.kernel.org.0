Return-Path: <bpf+bounces-67504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 802C8B4489E
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 23:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30506560360
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 21:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD642C1580;
	Thu,  4 Sep 2025 21:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMWwovI4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357C628468D;
	Thu,  4 Sep 2025 21:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021677; cv=none; b=RCrunrxgJ9sSWuzte0WBukPU1vb7iafoIydELUj5yuI8vSmNiwpIXEWKdZFs0hDIpWNUPZqglfnLi3Oh9PSkosAY5gSTb9WJF0IakMeA5gtaW94hDAKO4AEDiFlthJdpfdXsxIu+/7DCQ7qnJv5/u0ThNU5rl51Eho1BMB+d6ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021677; c=relaxed/simple;
	bh=XiQrGSF6SyBObJx++EVY4eibfmQBo6UNQpyZ88apUPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfStVMQQ0R8zwVfwrLCbxeclNMXpL2T0kxiOdfXKhiXLarpD3nKmB/zubPulrazO7ntEVmRBxDSN/AcRDRk+AJENmjXMi+eJ5O4l4IeXitA8Bis21/gXtOIO3C9n01X18qXyf2bFNv0loulm8Sqt+l2YYAuMnio+1kRMf2gY1o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMWwovI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CEAC4CEF0;
	Thu,  4 Sep 2025 21:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757021676;
	bh=XiQrGSF6SyBObJx++EVY4eibfmQBo6UNQpyZ88apUPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QMWwovI4/HINrHDethhxn1q9Ev2uZ4ZNZGEsT0NseGyHVx4g+xLesMJaBfD6O5+X5
	 7DB0kQ5nG+R6/Yd4oab5nNF/+sBocF21ufYtP0Ii5SGTXhmgYEjRTgJ9YCbP2eErua
	 C3tKeuteAzzn+CCcGoDzaDtrYK4gnaC6imw/5v0BDVZd26Km5wHRVxcO1PsmyBeILh
	 WBC985vLFccGEQy67UTh6G80b+cP8sD2uMSiErX17ZQCAzwyaylUBlWB6djr70ws2P
	 TIXIpLowAbkByXsmOFvU+H6fsyYV1WYfZ+z2XnHSkrLEbNNrcpfiv4kH/bghjd56V/
	 mEjRmbvBD8x4g==
Date: Thu, 4 Sep 2025 18:34:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	Song Liu <song@kernel.org>, Howard Chu <howardchu95@gmail.com>,
	Jakub Brnak <jbrnak@redhat.com>
Subject: Re: [PATCH 1/5] perf trace: use standard syscall tracepoint structs
 for augmentation
Message-ID: <aLoF6TMuzWCOku1Q@x1>
References: <20250814071754.193265-1-namhyung@kernel.org>
 <20250814071754.193265-2-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814071754.193265-2-namhyung@kernel.org>

On Thu, Aug 14, 2025 at 12:17:50AM -0700, Namhyung Kim wrote:
> From: Jakub Brnak <jbrnak@redhat.com>
> 
> Replace custom syscall structs with the standard trace_event_raw_sys_enter
> and trace_event_raw_sys_exit from vmlinux.h.
> This fixes a data structure misalignment issue discovered on RHEL-9, which
> prevented BPF programs from correctly accessing syscall arguments.
> This change also aims to improve compatibility between different version
> of the perf tool and kernel by using CO-RE so BPF code can correclty
> adjust field offsets.

Before this patch:

root@number:~# perf trace -e clock_nanosleep sleep 1
     0.000 (1000.053 ms): sleep/1137353 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7fffa088d160) = 0
root@number:~#

After:

root@number:~# perf trace -e clock_nanosleep sleep 1
libbpf: prog 'sys_enter': BPF program load failed: -E2BIG
libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
0: R1=ctx() R10=fp0
; int sys_enter(struct trace_event_raw_sys_enter *args) @ augmented_raw_syscalls.bpf.c:515
0: (bf) r7 = r1                       ; R1=ctx() R7_w=ctx()
; return bpf_get_current_pid_tgid(); @ augmented_raw_syscalls.bpf.c:412
1: (85) call bpf_get_current_pid_tgid#14      ; R0_w=scalar()
2: (63) *(u32 *)(r10 -4) = r0         ; R0_w=scalar() R10=fp0 fp-8=mmmm????
3: (bf) r2 = r10                      ; R2_w=fp0 R10=fp0
4: (07) r2 += -4                      ; R2_w=fp-4
; return bpf_map_lookup_elem(pids, &pid) != NULL; @ augmented_raw_syscalls.bpf.c:417
5: (18) r1 = 0xffff8a0857596400       ; R1_w=map_ptr(map=pids_filtered,ks=4,vs=1)
7: (85) call bpf_map_lookup_elem#1    ; R0=map_value_or_null(id=1,map=pids_filtered,ks=4,vs=1)
8: (bf) r1 = r0                       ; R0=map_value_or_null(id=1,map=pids_filtered,ks=4,vs=1) R1_w=map_value_or_null(id=1,map=pids_filtered,ks=4,vs=1)
9: (b4) w0 = 0                        ; R0_w=0
; if (pid_filter__has(&pids_filtered, getpid())) @ augmented_raw_syscalls.bpf.c:528
10: (55) if r1 != 0x0 goto pc+153     ; R1_w=0
11: (b4) w6 = 0                       ; R6_w=0
; int key = 0; @ augmented_raw_syscalls.bpf.c:139
12: (63) *(u32 *)(r10 -4) = r6        ; R6_w=0 R10=fp0 fp-8=0000????
13: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0
14: (07) r2 += -4                     ; R2_w=fp-4
; return bpf_map_lookup_elem(&augmented_args_tmp, &key); @ augmented_raw_syscalls.bpf.c:140
15: (18) r1 = 0xffff8a0854afae00      ; R1_w=map_ptr(map=augmented_args_,ks=4,vs=8272)
17: (85) call bpf_map_lookup_elem#1   ; R0=map_value(map=augmented_args_,ks=4,vs=8272)
18: (bf) r8 = r0                      ; R0=map_value(map=augmented_args_,ks=4,vs=8272) R8_w=map_value(map=augmented_args_,ks=4,vs=8272)
19: (b4) w0 = 1                       ; R0_w=1
; if (augmented_args == NULL) @ augmented_raw_syscalls.bpf.c:532
20: (15) if r8 == 0x0 goto pc+143     ; R8_w=map_value(map=augmented_args_,ks=4,vs=8272)
; bpf_probe_read_kernel(&augmented_args->args, sizeof(augmented_args->args), args); @ augmented_raw_syscalls.bpf.c:535
21: (bf) r1 = r8                      ; R1_w=map_value(map=augmented_args_,ks=4,vs=8272) R8_w=map_value(map=augmented_args_,ks=4,vs=8272)
22: (b4) w2 = 64                      ; R2_w=64
23: (bf) r3 = r7                      ; R3_w=ctx() R7=ctx()
24: (85) call bpf_probe_read_kernel#113       ; R0_w=scalar()
; int zero = 0, index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value); @ augmented_raw_syscalls.bpf.c:423
25: (63) *(u32 *)(r10 -4) = r6        ; R6=0 R10=fp0 fp-8=0000????
26: (7b) *(u64 *)(r10 -24) = r8       ; R8_w=map_value(map=augmented_args_,ks=4,vs=8272) R10=fp0 fp-24_w=map_value(map=augmented_args_,ks=4,vs=8272)
; nr             = (__u32)args->id; @ augmented_raw_syscalls.bpf.c:435
27: (79) r1 = *(u64 *)(r8 +8)         ; R1_w=scalar() R8_w=map_value(map=augmented_args_,ks=4,vs=8272)
28: (63) *(u32 *)(r10 -8) = r1        ; R1_w=scalar() R10=fp0 fp-8=0000scalar()
29: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0
30: (07) r2 += -8                     ; R2_w=fp-8
; beauty_map     = bpf_map_lookup_elem(&beauty_map_enter, &nr); @ augmented_raw_syscalls.bpf.c:436
31: (18) r1 = 0xffff8a0857592000      ; R1_w=map_ptr(map=beauty_map_ente,ks=4,vs=24)
33: (85) call bpf_map_lookup_elem#1   ; R0=map_value_or_null(id=2,map=beauty_map_ente,ks=4,vs=24)
34: (bf) r6 = r0                      ; R0=map_value_or_null(id=2,map=beauty_map_ente,ks=4,vs=24) R6_w=map_value_or_null(id=2,map=beauty_map_ente,ks=4,vs=24)
35: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0
36: (07) r2 += -4                     ; R2_w=fp-4
; payload        = bpf_map_lookup_elem(&beauty_payload_enter_map, &zero); @ augmented_raw_syscalls.bpf.c:439
37: (18) r1 = 0xffff8a0854afb400      ; R1_w=map_ptr(map=beauty_payload_,ks=4,vs=24688)
39: (85) call bpf_map_lookup_elem#1   ; R0_w=map_value(map=beauty_payload_,ks=4,vs=24688)
; if (beauty_map == NULL || payload == NULL) @ augmented_raw_syscalls.bpf.c:442
40: (15) if r6 == 0x0 goto pc+103     ; R6_w=map_value(map=beauty_map_ente,ks=4,vs=24)
41: (15) if r0 == 0x0 goto pc+102     ; R0_w=map_value(map=beauty_payload_,ks=4,vs=24688)
42: (79) r2 = *(u64 *)(r10 -24)       ; R2_w=map_value(map=augmented_args_,ks=4,vs=8272) R10=fp0 fp-24=map_value(map=augmented_args_,ks=4,vs=8272)
; __builtin_memcpy(&payload->args, args, sizeof(*args)); @ augmented_raw_syscalls.bpf.c:446
43: (79) r1 = *(u64 *)(r2 +56)        ; R1_w=scalar() R2_w=map_value(map=augmented_args_,ks=4,vs=8272)
44: (7b) *(u64 *)(r0 +56) = r1        ; R0_w=map_value(map=beauty_payload_,ks=4,vs=24688) R1_w=scalar()
45: (79) r1 = *(u64 *)(r2 +48)        ; R1_w=scalar() R2_w=map_value(map=augmented_args_,ks=4,vs=8272)
46: (7b) *(u64 *)(r0 +48) = r1        ; R0_w=map_value(map=beauty_payload_,ks=4,vs=24688) R1_w=scalar()
47: (79) r1 = *(u64 *)(r2 +40)        ; R1_w=scalar() R2_w=map_value(map=augmented_args_,ks=4,vs=8272)
48: (7b) *(u64 *)(r0 +40) = r1        ; R0_w=map_value(map=beauty_payload_,ks=4,vs=24688) R1_w=scalar()
49: (79) r1 = *(u64 *)(r2 +32)        ; R1_w=scalar() R2_w=map_value(map=augmented_args_,ks=4,vs=8272)
50: (7b) *(u64 *)(r0 +32) = r1        ; R0_w=map_value(map=beauty_payload_,ks=4,vs=24688) R1_w=scalar()
51: (79) r1 = *(u64 *)(r2 +24)        ; R1_w=scalar() R2_w=map_value(map=augmented_args_,ks=4,vs=8272)
52: (7b) *(u64 *)(r0 +24) = r1        ; R0_w=map_value(map=beauty_payload_,ks=4,vs=24688) R1_w=scalar()
53: (79) r1 = *(u64 *)(r2 +16)        ; R1_w=scalar() R2_w=map_value(map=augmented_args_,ks=4,vs=8272)
54: (7b) *(u64 *)(r0 +16) = r1        ; R0_w=map_value(map=beauty_payload_,ks=4,vs=24688) R1_w=scalar()
55: (79) r1 = *(u64 *)(r2 +8)         ; R1_w=scalar() R2_w=map_value(map=augmented_args_,ks=4,vs=8272)
56: (7b) *(u64 *)(r0 +8) = r1         ; R0_w=map_value(map=beauty_payload_,ks=4,vs=24688) R1_w=scalar()
57: (79) r1 = *(u64 *)(r2 +0)         ; R1_w=scalar() R2_w=map_value(map=augmented_args_,ks=4,vs=8272)
58: (7b) *(u64 *)(r0 +0) = r1         ; R0_w=map_value(map=beauty_payload_,ks=4,vs=24688) R1_w=scalar()
59: (b4) w1 = 0                       ; R1_w=0
60: (63) *(u32 *)(r10 -64) = r1       ; R1_w=0 R10=fp0 fp-64=????0
61: (b7) r8 = 0                       ; R8_w=0
; payload_offset = (void *)&payload->aug_args; @ augmented_raw_syscalls.bpf.c:440
62: (bf) r3 = r0                      ; R0_w=map_value(map=beauty_payload_,ks=4,vs=24688) R3_w=map_value(map=beauty_payload_,ks=4,vs=24688)
63: (07) r3 += 64                     ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=64)
64: (b7) r1 = 16                      ; R1_w=16
65: (0f) r2 += r1                     ; R1_w=16 R2_w=map_value(map=augmented_args_,ks=4,vs=8272,off=16)
66: (7b) *(u64 *)(r10 -32) = r2       ; R2_w=map_value(map=augmented_args_,ks=4,vs=8272,off=16) R10=fp0 fp-32_w=map_value(map=augmented_args_,ks=4,vs=8272,off=16)
67: (b7) r9 = 0                       ; R9_w=0
68: (7b) *(u64 *)(r10 -48) = r7       ; R7=ctx() R10=fp0 fp-48_w=ctx()
69: (7b) *(u64 *)(r10 -56) = r0       ; R0_w=map_value(map=beauty_payload_,ks=4,vs=24688) R10=fp0 fp-56_w=map_value(map=beauty_payload_,ks=4,vs=24688)
70: (7b) *(u64 *)(r10 -80) = r6       ; R6=map_value(map=beauty_map_ente,ks=4,vs=24) R10=fp0 fp-80=map_value(map=beauty_map_ente,ks=4,vs=24)
71: (7b) *(u64 *)(r10 -40) = r9       ; R9=0 R10=fp0 fp-40_w=0
; for (int i = 0; i < 6; i++) { @ augmented_raw_syscalls.bpf.c:457
72: (bf) r1 = r8                      ; R1_w=0 R8=0
73: (67) r1 <<= 3                     ; R1_w=0
74: (79) r7 = *(u64 *)(r10 -24)       ; R7_w=map_value(map=augmented_args_,ks=4,vs=8272) R10=fp0 fp-24=map_value(map=augmented_args_,ks=4,vs=8272)
75: (0f) r7 += r1                     ; R1_w=0 R7_w=map_value(map=augmented_args_,ks=4,vs=8272)
76: (bf) r1 = r8                      ; R1_w=0 R8=0
77: (67) r1 <<= 2                     ; R1_w=0
78: (0f) r6 += r1                     ; R1_w=0 R6_w=map_value(map=beauty_map_ente,ks=4,vs=24)
79: (07) r8 += 1                      ; R8_w=1
80: (7b) *(u64 *)(r10 -72) = r3       ; R3=map_value(map=beauty_payload_,ks=4,vs=24688,off=64) R10=fp0 fp-72_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=64)
81: (07) r3 += 8                      ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=72)
82: (7b) *(u64 *)(r10 -16) = r3       ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=72) R10=fp0 fp-16_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=72)
83: (05) goto pc+8
; arg = (void *)args->args[i]; @ augmented_raw_syscalls.bpf.c:458
92: (79) r3 = *(u64 *)(r7 +16)        ; R3_w=scalar() R7_w=map_value(map=augmented_args_,ks=4,vs=8272)
; size = beauty_map[i]; @ augmented_raw_syscalls.bpf.c:460
93: (61) r9 = *(u32 *)(r6 +0)         ; R6_w=map_value(map=beauty_map_ente,ks=4,vs=24) R9_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
; if (size == 0 || arg == NULL) @ augmented_raw_syscalls.bpf.c:463
94: (16) if w9 == 0x0 goto pc-7       ; R9_w=scalar(smin=umin=umin32=1,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
95: (15) if r3 == 0x0 goto pc-8       ; R3=scalar(umin=1)
; if (size == 1) { /* string */ @ augmented_raw_syscalls.bpf.c:466
96: (56) if w9 != 0x1 goto pc+7 104: R0=map_value(map=beauty_payload_,ks=4,vs=24688) R1=0 R2=map_value(map=augmented_args_,ks=4,vs=8272,off=16) R3=scalar(umin=1) R6=map_value(map=beauty_map_ente,ks=4,vs=24) R7=map_value(map=augmented_args_,ks=4,vs=8272) R8=1 R9=scalar(smin=umin=umin32=2,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R10=fp0 fp-8=0000scalar() fp-16=map_value(map=beauty_payload_,ks=4,vs=24688,off=72) fp-24=map_value(map=augmented_args_,ks=4,vs=8272) fp-32=map_value(map=augmented_args_,ks=4,vs=8272,off=16) fp-40=0 fp-48=ctx() fp-56=map_value(map=beauty_payload_,ks=4,vs=24688) fp-64=????0 fp-72=map_value(map=beauty_payload_,ks=4,vs=24688,off=64) fp-80=map_value(map=beauty_map_ente,ks=4,vs=24)
; } else if (size > 0 && size <= value_size) { /* struct */ @ augmented_raw_syscalls.bpf.c:473
104: (26) if w9 > 0x1000 goto pc+5 110: R0=map_value(map=beauty_payload_,ks=4,vs=24688) R1=0 R2=map_value(map=augmented_args_,ks=4,vs=8272,off=16) R3=scalar(umin=1) R6=map_value(map=beauty_map_ente,ks=4,vs=24) R7=map_value(map=augmented_args_,ks=4,vs=8272) R8=1 R9=scalar(smin=umin=umin32=4097,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R10=fp0 fp-8=0000scalar() fp-16=map_value(map=beauty_payload_,ks=4,vs=24688,off=72) fp-24=map_value(map=augmented_args_,ks=4,vs=8272) fp-32=map_value(map=augmented_args_,ks=4,vs=8272,off=16) fp-40=0 fp-48=ctx() fp-56=map_value(map=beauty_payload_,ks=4,vs=24688) fp-64=????0 fp-72=map_value(map=beauty_payload_,ks=4,vs=24688,off=64) fp-80=map_value(map=beauty_map_ente,ks=4,vs=24)
; } else if ((int)size < 0 && size >= -6) { /* buffer */ @ augmented_raw_syscalls.bpf.c:476
110: (66) if w9 s> 0xffffffff goto pc-23      ; R9=scalar(smin=umin=umin32=0x80000000,smax=umax=0xffffffff,smax32=-1,var_off=(0x80000000; 0x7fffffff))
; index = -(size + 1); @ augmented_raw_syscalls.bpf.c:477
111: (a4) w9 ^= -1                    ; R9_w=scalar(smin=smin32=0,smax=umax=umax32=0x7fffffff,var_off=(0x0; 0x7fffffff))
; index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels. @ augmented_raw_syscalls.bpf.c:479
112: (54) w9 &= 7                     ; R9_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=7,var_off=(0x0; 0x7))
; aug_size = args->args[index]; @ augmented_raw_syscalls.bpf.c:480
113: (67) r9 <<= 3                    ; R9_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=56,var_off=(0x0; 0x38))
114: (79) r1 = *(u64 *)(r10 -32)      ; R1_w=map_value(map=augmented_args_,ks=4,vs=8272,off=16) R10=fp0 fp-32=map_value(map=augmented_args_,ks=4,vs=8272,off=16)
115: (0f) r1 += r9                    ; R1_w=map_value(map=augmented_args_,ks=4,vs=8272,off=16,smin=smin32=0,smax=umax=smax32=umax32=56,var_off=(0x0; 0x38)) R9_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=56,var_off=(0x0; 0x38))
116: (79) r9 = *(u64 *)(r1 +0)        ; R1_w=map_value(map=augmented_args_,ks=4,vs=8272,off=16,smin=smin32=0,smax=umax=smax32=umax32=56,var_off=(0x0; 0x38)) R9_w=scalar()
; if (aug_size > 0) { @ augmented_raw_syscalls.bpf.c:482
117: (c5) if r9 s< 0x1 goto pc-30     ; R9_w=scalar(smin=umin=1,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))
; if (aug_size > TRACE_AUG_MAX_BUF) @ augmented_raw_syscalls.bpf.c:483
118: (a5) if r9 < 0x20 goto pc-35     ; R9=scalar(smin=umin=32,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))
119: (b7) r9 = 32                     ; R9_w=32
120: (05) goto pc-37
; if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg)) @ augmented_raw_syscalls.bpf.c:485
84: (79) r1 = *(u64 *)(r10 -16)       ; R1_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=72) R10=fp0 fp-16=map_value(map=beauty_payload_,ks=4,vs=24688,off=72)
85: (bc) w2 = w9                      ; R2_w=32 R9_w=32
86: (85) call bpf_probe_read_user#112         ; R0_w=scalar()
87: (15) if r0 == 0x0 goto pc+33 121: R0=0 R6=map_value(map=beauty_map_ente,ks=4,vs=24) R7=map_value(map=augmented_args_,ks=4,vs=8272) R8=1 R9=32 R10=fp0 fp-8=0000scalar() fp-16=map_value(map=beauty_payload_,ks=4,vs=24688,off=72) fp-24=map_value(map=augmented_args_,ks=4,vs=8272) fp-32=map_value(map=augmented_args_,ks=4,vs=8272,off=16) fp-40=0 fp-48=ctx() fp-56=map_value(map=beauty_payload_,ks=4,vs=24688) fp-64=????0 fp-72=map_value(map=beauty_payload_,ks=4,vs=24688,off=64) fp-80=map_value(map=beauty_map_ente,ks=4,vs=24)
; if (aug_size > value_size) @ augmented_raw_syscalls.bpf.c:491
121: (a5) if r9 < 0x1000 goto pc+1    ; R9=32
123: (79) r3 = *(u64 *)(r10 -72)      ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=64) R10=fp0 fp-72=map_value(map=beauty_payload_,ks=4,vs=24688,off=64)
; ((struct augmented_arg *)payload_offset)->size = aug_size; @ augmented_raw_syscalls.bpf.c:501
124: (63) *(u32 *)(r3 +0) = r9        ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=64) R9=32
; int written = offsetof(struct augmented_arg, value) + aug_size; @ augmented_raw_syscalls.bpf.c:496
125: (07) r9 += 8                     ; R9_w=40
; payload_offset += written; @ augmented_raw_syscalls.bpf.c:503
126: (0f) r3 += r9                    ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=104) R9_w=40
; output += written; @ augmented_raw_syscalls.bpf.c:502
127: (79) r1 = *(u64 *)(r10 -40)      ; R1_w=0 R10=fp0 fp-40=0
128: (0f) r9 += r1                    ; R1_w=0 R9_w=40
129: (b4) w1 = 1                      ; R1_w=1
130: (63) *(u32 *)(r10 -64) = r1      ; R1_w=1 R10=fp0 fp-64=????1
131: (79) r7 = *(u64 *)(r10 -48)      ; R7_w=ctx() R10=fp0 fp-48=ctx()
132: (79) r0 = *(u64 *)(r10 -56)      ; R0_w=map_value(map=beauty_payload_,ks=4,vs=24688) R10=fp0 fp-56=map_value(map=beauty_payload_,ks=4,vs=24688)
133: (79) r6 = *(u64 *)(r10 -80)      ; R6_w=map_value(map=beauty_map_ente,ks=4,vs=24) R10=fp0 fp-80=map_value(map=beauty_map_ente,ks=4,vs=24)
; for (int i = 0; i < 6; i++) { @ augmented_raw_syscalls.bpf.c:457
134: (15) if r8 == 0x6 goto pc+7      ; R8=1
135: (05) goto pc-65
; payload_offset = (void *)&payload->aug_args; @ augmented_raw_syscalls.bpf.c:440
71: (7b) *(u64 *)(r10 -40) = r9       ; R9=40 R10=fp0 fp-40_w=40
; for (int i = 0; i < 6; i++) { @ augmented_raw_syscalls.bpf.c:457
72: (bf) r1 = r8                      ; R1_w=1 R8=1
73: (67) r1 <<= 3                     ; R1_w=8
74: (79) r7 = *(u64 *)(r10 -24)       ; R7_w=map_value(map=augmented_args_,ks=4,vs=8272) R10=fp0 fp-24=map_value(map=augmented_args_,ks=4,vs=8272)
75: (0f) r7 += r1                     ; R1_w=8 R7_w=map_value(map=augmented_args_,ks=4,vs=8272,off=8)
76: (bf) r1 = r8                      ; R1_w=1 R8=1
77: (67) r1 <<= 2                     ; R1_w=4
78: (0f) r6 += r1                     ; R1_w=4 R6_w=map_value(map=beauty_map_ente,ks=4,vs=24,off=4)
79: (07) r8 += 1                      ; R8_w=2
80: (7b) *(u64 *)(r10 -72) = r3       ; R3=map_value(map=beauty_payload_,ks=4,vs=24688,off=104) R10=fp0 fp-72_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=104)
81: (07) r3 += 8                      ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=112)
82: (7b) *(u64 *)(r10 -16) = r3       ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=112) R10=fp0 fp-16_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=112)
83: (05) goto pc+8
; arg = (void *)args->args[i]; @ augmented_raw_syscalls.bpf.c:458
92: (79) r3 = *(u64 *)(r7 +16)        ; R3_w=scalar() R7_w=map_value(map=augmented_args_,ks=4,vs=8272,off=8)
; size = beauty_map[i]; @ augmented_raw_syscalls.bpf.c:460
93: (61) r9 = *(u32 *)(r6 +0)         ; R6_w=map_value(map=beauty_map_ente,ks=4,vs=24,off=4) R9_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
; if (size == 0 || arg == NULL) @ augmented_raw_syscalls.bpf.c:463
94: (16) if w9 == 0x0 goto pc-7       ; R9_w=scalar(smin=umin=umin32=1,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
95: (15) if r3 == 0x0 goto pc-8       ; R3_w=scalar(umin=1)
; if (size == 1) { /* string */ @ augmented_raw_syscalls.bpf.c:466
96: (56) if w9 != 0x1 goto pc+7       ; R9=1
; aug_size = bpf_probe_read_user_str(((struct augmented_arg *)payload_offset)->value, value_size, arg); @ augmented_raw_syscalls.bpf.c:467
97: (79) r1 = *(u64 *)(r10 -16)       ; R1_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=112) R10=fp0 fp-16=map_value(map=beauty_payload_,ks=4,vs=24688,off=112)
98: (b4) w2 = 4096                    ; R2_w=4096
99: (85) call bpf_probe_read_user_str#114     ; R0_w=scalar(smin=smin32=-4095,smax=smax32=4096)
100: (bf) r9 = r0                     ; R0_w=scalar(id=28510,smin=smin32=-4095,smax=smax32=4096) R9_w=scalar(id=28510,smin=smin32=-4095,smax=smax32=4096)
; if (aug_size < 0) @ augmented_raw_syscalls.bpf.c:469
101: (65) if r9 s> 0x0 goto pc+19     ; R9_w=scalar(id=28510,smin=smin32=-4095,smax=smax32=0)
102: (b7) r9 = 0                      ; R9_w=0
103: (05) goto pc+17
; if (aug_size > value_size) @ augmented_raw_syscalls.bpf.c:491
121: (a5) if r9 < 0x1000 goto pc+1    ; R9_w=0
123: (79) r3 = *(u64 *)(r10 -72)      ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=104) R10=fp0 fp-72=map_value(map=beauty_payload_,ks=4,vs=24688,off=104)
; ((struct augmented_arg *)payload_offset)->size = aug_size; @ augmented_raw_syscalls.bpf.c:501
124: (63) *(u32 *)(r3 +0) = r9        ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=104) R9=0
; int written = offsetof(struct augmented_arg, value) + aug_size; @ augmented_raw_syscalls.bpf.c:496
125: (07) r9 += 8                     ; R9_w=8
; payload_offset += written; @ augmented_raw_syscalls.bpf.c:503
126: (0f) r3 += r9                    ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=112) R9_w=8
; output += written; @ augmented_raw_syscalls.bpf.c:502
127: (79) r1 = *(u64 *)(r10 -40)      ; R1_w=40 R10=fp0 fp-40=40
128: (0f) r9 += r1                    ; R1_w=40 R9_w=48
129: (b4) w1 = 1                      ; R1_w=1
130: (63) *(u32 *)(r10 -64) = r1      ; R1_w=1 R10=fp0 fp-64=????1
131: (79) r7 = *(u64 *)(r10 -48)      ; R7_w=ctx() R10=fp0 fp-48=ctx()
132: (79) r0 = *(u64 *)(r10 -56)      ; R0_w=map_value(map=beauty_payload_,ks=4,vs=24688) R10=fp0 fp-56=map_value(map=beauty_payload_,ks=4,vs=24688)
133: (79) r6 = *(u64 *)(r10 -80)      ; R6_w=map_value(map=beauty_map_ente,ks=4,vs=24) R10=fp0 fp-80=map_value(map=beauty_map_ente,ks=4,vs=24)
; for (int i = 0; i < 6; i++) { @ augmented_raw_syscalls.bpf.c:457
134: (15) if r8 == 0x6 goto pc+7      ; R8=2
135: (05) goto pc-65
; payload_offset = (void *)&payload->aug_args; @ augmented_raw_syscalls.bpf.c:440
71: (7b) *(u64 *)(r10 -40) = r9       ; R9_w=48 R10=fp0 fp-40_w=48
; for (int i = 0; i < 6; i++) { @ augmented_raw_syscalls.bpf.c:457
72: (bf) r1 = r8                      ; R1_w=2 R8=2
73: (67) r1 <<= 3                     ; R1_w=16
74: (79) r7 = *(u64 *)(r10 -24)       ; R7_w=map_value(map=augmented_args_,ks=4,vs=8272) R10=fp0 fp-24=map_value(map=augmented_args_,ks=4,vs=8272)
75: (0f) r7 += r1                     ; R1_w=16 R7_w=map_value(map=augmented_args_,ks=4,vs=8272,off=16)
76: (bf) r1 = r8                      ; R1_w=2 R8=2
77: (67) r1 <<= 2                     ; R1_w=8
78: (0f) r6 += r1                     ; R1_w=8 R6_w=map_value(map=beauty_map_ente,ks=4,vs=24,off=8)
79: (07) r8 += 1                      ; R8_w=3
80: (7b) *(u64 *)(r10 -72) = r3       ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=112) R10=fp0 fp-72_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=112)
81: (07) r3 += 8                      ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=120)
82: (7b) *(u64 *)(r10 -16) = r3       ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=120) R10=fp0 fp-16_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=120)
83: (05) goto pc+8
; arg = (void *)args->args[i]; @ augmented_raw_syscalls.bpf.c:458
92: (79) r3 = *(u64 *)(r7 +16)        ; R3_w=scalar() R7=map_value(map=augmented_args_,ks=4,vs=8272,off=16)
; size = beauty_map[i]; @ augmented_raw_syscalls.bpf.c:460
93: (61) r9 = *(u32 *)(r6 +0)         ; R6=map_value(map=beauty_map_ente,ks=4,vs=24,off=8) R9_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
; if (size == 0 || arg == NULL) @ augmented_raw_syscalls.bpf.c:463
94: (16) if w9 == 0x0 goto pc-7       ; R9_w=scalar(smin=umin=umin32=1,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
95: (15) if r3 == 0x0 goto pc-8       ; R3_w=scalar(umin=1)
; if (size == 1) { /* string */ @ augmented_raw_syscalls.bpf.c:466
96: (56) if w9 != 0x1 goto pc+7       ; R9_w=1
; aug_size = bpf_probe_read_user_str(((struct augmented_arg *)payload_offset)->value, value_size, arg); @ augmented_raw_syscalls.bpf.c:467
97: (79) r1 = *(u64 *)(r10 -16)       ; R1_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=120) R10=fp0 fp-16=map_value(map=beauty_payload_,ks=4,vs=24688,off=120)
98: (b4) w2 = 4096                    ; R2_w=4096
99: (85) call bpf_probe_read_user_str#114     ; R0=scalar(smin=smin32=-4095,smax=smax32=4096)
100: (bf) r9 = r0                     ; R0=scalar(id=28511,smin=smin32=-4095,smax=smax32=4096) R9_w=scalar(id=28511,smin=smin32=-4095,smax=smax32=4096)
; if (aug_size < 0) @ augmented_raw_syscalls.bpf.c:469
101: (65) if r9 s> 0x0 goto pc+19 121: R0=scalar(id=28511,smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=4096,var_off=(0x0; 0x1fff)) R6=map_value(map=beauty_map_ente,ks=4,vs=24,off=8) R7=map_value(map=augmented_args_,ks=4,vs=8272,off=16) R8=3 R9_w=scalar(id=28511,smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=4096,var_off=(0x0; 0x1fff)) R10=fp0 fp-8=0000scalar() fp-16=map_value(map=beauty_payload_,ks=4,vs=24688,off=120) fp-24=map_value(map=augmented_args_,ks=4,vs=8272) fp-32=map_value(map=augmented_args_,ks=4,vs=8272,off=16) fp-40=48 fp-48=ctx() fp-56=map_value(map=beauty_payload_,ks=4,vs=24688) fp-64=????1 fp-72=map_value(map=beauty_payload_,ks=4,vs=24688,off=112) fp-80=map_value(map=beauty_map_ente,ks=4,vs=24)
; if (aug_size > value_size) @ augmented_raw_syscalls.bpf.c:491
121: (a5) if r9 < 0x1000 goto pc+1 123: R0=scalar(id=28511,smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=4095,var_off=(0x0; 0xfff)) R6=map_value(map=beauty_map_ente,ks=4,vs=24,off=8) R7=map_value(map=augmented_args_,ks=4,vs=8272,off=16) R8=3 R9_w=scalar(id=28511,smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=4095,var_off=(0x0; 0xfff)) R10=fp0 fp-8=0000scalar() fp-16=map_value(map=beauty_payload_,ks=4,vs=24688,off=120) fp-24=map_value(map=augmented_args_,ks=4,vs=8272) fp-32=map_value(map=augmented_args_,ks=4,vs=8272,off=16) fp-40=48 fp-48=ctx() fp-56=map_value(map=beauty_payload_,ks=4,vs=24688) fp-64=????1 fp-72=map_value(map=beauty_payload_,ks=4,vs=24688,off=112) fp-80=map_value(map=beauty_map_ente,ks=4,vs=24)
; if (aug_size > value_size) @ augmented_raw_syscalls.bpf.c:491
123: (79) r3 = *(u64 *)(r10 -72)      ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=112) R10=fp0 fp-72=map_value(map=beauty_payload_,ks=4,vs=24688,off=112)
; ((struct augmented_arg *)payload_offset)->size = aug_size; @ augmented_raw_syscalls.bpf.c:501
124: (63) *(u32 *)(r3 +0) = r9        ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=112) R9_w=scalar(id=28511,smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=4095,var_off=(0x0; 0xfff))
; int written = offsetof(struct augmented_arg, value) + aug_size; @ augmented_raw_syscalls.bpf.c:496
125: (07) r9 += 8                     ; R9_w=scalar(id=28511+8,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff))
; payload_offset += written; @ augmented_raw_syscalls.bpf.c:503
126: (0f) r3 += r9                    ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=112,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff)) R9_w=scalar(id=28511+8,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff))
; output += written; @ augmented_raw_syscalls.bpf.c:502
127: (79) r1 = *(u64 *)(r10 -40)      ; R1_w=48 R10=fp0 fp-40=48
128: (0f) r9 += r1                    ; R1_w=48 R9_w=scalar(smin=umin=smin32=umin32=57,smax=umax=smax32=umax32=4151,var_off=(0x0; 0x1fff))
129: (b4) w1 = 1                      ; R1_w=1
130: (63) *(u32 *)(r10 -64) = r1      ; R1_w=1 R10=fp0 fp-64=????1
131: (79) r7 = *(u64 *)(r10 -48)      ; R7_w=ctx() R10=fp0 fp-48=ctx()
132: (79) r0 = *(u64 *)(r10 -56)      ; R0_w=map_value(map=beauty_payload_,ks=4,vs=24688) R10=fp0 fp-56=map_value(map=beauty_payload_,ks=4,vs=24688)
133: (79) r6 = *(u64 *)(r10 -80)      ; R6=map_value(map=beauty_map_ente,ks=4,vs=24) R10=fp0 fp-80=map_value(map=beauty_map_ente,ks=4,vs=24)
; for (int i = 0; i < 6; i++) { @ augmented_raw_syscalls.bpf.c:457
134: (15) if r8 == 0x6 goto pc+7      ; R8=3
135: (05) goto pc-65
; payload_offset = (void *)&payload->aug_args; @ augmented_raw_syscalls.bpf.c:440
71: (7b) *(u64 *)(r10 -40) = r9       ; R9=scalar(id=28869,smin=umin=smin32=umin32=57,smax=umax=smax32=umax32=4151,var_off=(0x0; 0x1fff)) R10=fp0 fp-40_w=scalar(id=28869,smin=umin=smin32=umin32=57,smax=umax=smax32=umax32=4151,var_off=(0x0; 0x1fff))
; for (int i = 0; i < 6; i++) { @ augmented_raw_syscalls.bpf.c:457
72: (bf) r1 = r8                      ; R1_w=3 R8=3
73: (67) r1 <<= 3                     ; R1_w=24
74: (79) r7 = *(u64 *)(r10 -24)       ; R7_w=map_value(map=augmented_args_,ks=4,vs=8272) R10=fp0 fp-24=map_value(map=augmented_args_,ks=4,vs=8272)
75: (0f) r7 += r1                     ; R1_w=24 R7_w=map_value(map=augmented_args_,ks=4,vs=8272,off=24)
76: (bf) r1 = r8                      ; R1_w=3 R8=3
77: (67) r1 <<= 2                     ; R1_w=12
78: (0f) r6 += r1                     ; R1_w=12 R6_w=map_value(map=beauty_map_ente,ks=4,vs=24,off=12)
79: (07) r8 += 1                      ; R8_w=4
80: (7b) *(u64 *)(r10 -72) = r3       ; R3=map_value(map=beauty_payload_,ks=4,vs=24688,off=112,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff)) R10=fp0 fp-72_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=112,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff))
81: (07) r3 += 8                      ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=120,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff))
82: (7b) *(u64 *)(r10 -16) = r3       ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=120,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff)) R10=fp0 fp-16_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=120,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff))
83: (05) goto pc+8
; arg = (void *)args->args[i]; @ augmented_raw_syscalls.bpf.c:458
92: (79) r3 = *(u64 *)(r7 +16)        ; R3_w=scalar() R7_w=map_value(map=augmented_args_,ks=4,vs=8272,off=24)
; size = beauty_map[i]; @ augmented_raw_syscalls.bpf.c:460
93: (61) r9 = *(u32 *)(r6 +0)         ; R6=map_value(map=beauty_map_ente,ks=4,vs=24,off=12) R9=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
; if (size == 0 || arg == NULL) @ augmented_raw_syscalls.bpf.c:463
94: (16) if w9 == 0x0 goto pc-7       ; R9=scalar(smin=umin=umin32=1,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
95: (15) if r3 == 0x0 goto pc-8       ; R3=scalar(umin=1)
; if (size == 1) { /* string */ @ augmented_raw_syscalls.bpf.c:466
96: (56) if w9 != 0x1 goto pc+7       ; R9=1
; aug_size = bpf_probe_read_user_str(((struct augmented_arg *)payload_offset)->value, value_size, arg); @ augmented_raw_syscalls.bpf.c:467
97: (79) r1 = *(u64 *)(r10 -16)       ; R1_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=120,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff)) R10=fp0 fp-16=map_value(map=beauty_payload_,ks=4,vs=24688,off=120,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff))
98: (b4) w2 = 4096                    ; R2_w=4096
99: (85) call bpf_probe_read_user_str#114     ; R0_w=scalar(smin=smin32=-4095,smax=smax32=4096)
100: (bf) r9 = r0                     ; R0_w=scalar(id=28870,smin=smin32=-4095,smax=smax32=4096) R9_w=scalar(id=28870,smin=smin32=-4095,smax=smax32=4096)
; if (aug_size < 0) @ augmented_raw_syscalls.bpf.c:469
101: (65) if r9 s> 0x0 goto pc+19     ; R9_w=scalar(id=28870,smin=smin32=-4095,smax=smax32=0)
102: (b7) r9 = 0                      ; R9_w=0
103: (05) goto pc+17
; if (aug_size > value_size) @ augmented_raw_syscalls.bpf.c:491
121: (a5) if r9 < 0x1000 goto pc+1    ; R9_w=0
123: (79) r3 = *(u64 *)(r10 -72)      ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=112,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff)) R10=fp0 fp-72=map_value(map=beauty_payload_,ks=4,vs=24688,off=112,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff))
; ((struct augmented_arg *)payload_offset)->size = aug_size; @ augmented_raw_syscalls.bpf.c:501
124: (63) *(u32 *)(r3 +0) = r9        ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=112,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff)) R9_w=0
; int written = offsetof(struct augmented_arg, value) + aug_size; @ augmented_raw_syscalls.bpf.c:496
125: (07) r9 += 8                     ; R9_w=8
; payload_offset += written; @ augmented_raw_syscalls.bpf.c:503
126: (0f) r3 += r9                    ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=120,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff)) R9_w=8
; output += written; @ augmented_raw_syscalls.bpf.c:502
127: (79) r1 = *(u64 *)(r10 -40)      ; R1_w=scalar(id=28869,smin=umin=smin32=umin32=57,smax=umax=smax32=umax32=4151,var_off=(0x0; 0x1fff)) R10=fp0 fp-40=scalar(id=28869,smin=umin=smin32=umin32=57,smax=umax=smax32=umax32=4151,var_off=(0x0; 0x1fff))
128: (0f) r9 += r1                    ; R1_w=scalar(id=28869,smin=umin=smin32=umin32=57,smax=umax=smax32=umax32=4151,var_off=(0x0; 0x1fff)) R9_w=scalar(smin=umin=smin32=umin32=65,smax=umax=smax32=umax32=4159,var_off=(0x0; 0x1fff))
129: (b4) w1 = 1                      ; R1_w=1
130: (63) *(u32 *)(r10 -64) = r1      ; R1_w=1 R10=fp0 fp-64=????1
131: (79) r7 = *(u64 *)(r10 -48)      ; R7_w=ctx() R10=fp0 fp-48=ctx()
132: (79) r0 = *(u64 *)(r10 -56)      ; R0_w=map_value(map=beauty_payload_,ks=4,vs=24688) R10=fp0 fp-56=map_value(map=beauty_payload_,ks=4,vs=24688)
133: (79) r6 = *(u64 *)(r10 -80)      ; R6_w=map_value(map=beauty_map_ente,ks=4,vs=24) R10=fp0 fp-80=map_value(map=beauty_map_ente,ks=4,vs=24)
; for (int i = 0; i < 6; i++) { @ augmented_raw_syscalls.bpf.c:457
134: (15) if r8 == 0x6 goto pc+7      ; R8=4
135: (05) goto pc-65
; payload_offset = (void *)&payload->aug_args; @ augmented_raw_syscalls.bpf.c:440
71: (7b) *(u64 *)(r10 -40) = r9       ; R9_w=scalar(id=28871,smin=umin=smin32=umin32=65,smax=umax=smax32=umax32=4159,var_off=(0x0; 0x1fff)) R10=fp0 fp-40_w=scalar(id=28871,smin=umin=smin32=umin32=65,smax=umax=smax32=umax32=4159,var_off=(0x0; 0x1fff))
; for (int i = 0; i < 6; i++) { @ augmented_raw_syscalls.bpf.c:457
72: (bf) r1 = r8                      ; R1_w=4 R8=4
73: (67) r1 <<= 3                     ; R1_w=32
74: (79) r7 = *(u64 *)(r10 -24)       ; R7_w=map_value(map=augmented_args_,ks=4,vs=8272) R10=fp0 fp-24=map_value(map=augmented_args_,ks=4,vs=8272)
75: (0f) r7 += r1                     ; R1_w=32 R7_w=map_value(map=augmented_args_,ks=4,vs=8272,off=32)
76: (bf) r1 = r8                      ; R1_w=4 R8=4
77: (67) r1 <<= 2                     ; R1_w=16
78: (0f) r6 += r1                     ; R1_w=16 R6_w=map_value(map=beauty_map_ente,ks=4,vs=24,off=16)
79: (07) r8 += 1                      ; R8_w=5
80: (7b) *(u64 *)(r10 -72) = r3       ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=120,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff)) R10=fp0 fp-72_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=120,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff))
81: (07) r3 += 8                      ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=128,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff))
82: (7b) *(u64 *)(r10 -16) = r3       ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=128,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff)) R10=fp0 fp-16_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=128,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff))
83: (05) goto pc+8
; arg = (void *)args->args[i]; @ augmented_raw_syscalls.bpf.c:458
92: (79) r3 = *(u64 *)(r7 +16)        ; R3_w=scalar() R7_w=map_value(map=augmented_args_,ks=4,vs=8272,off=32)
; size = beauty_map[i]; @ augmented_raw_syscalls.bpf.c:460
93: (61) r9 = *(u32 *)(r6 +0)         ; R6_w=map_value(map=beauty_map_ente,ks=4,vs=24,off=16) R9_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
; if (size == 0 || arg == NULL) @ augmented_raw_syscalls.bpf.c:463
94: (16) if w9 == 0x0 goto pc-7       ; R9_w=scalar(smin=umin=umin32=1,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
95: (15) if r3 == 0x0 goto pc-8       ; R3_w=scalar(umin=1)
; if (size == 1) { /* string */ @ augmented_raw_syscalls.bpf.c:466
96: (56) if w9 != 0x1 goto pc+7 104: R0_w=map_value(map=beauty_payload_,ks=4,vs=24688) R1_w=16 R3_w=scalar(umin=1) R6_w=map_value(map=beauty_map_ente,ks=4,vs=24,off=16) R7_w=map_value(map=augmented_args_,ks=4,vs=8272,off=32) R8_w=5 R9_w=scalar(smin=umin=umin32=2,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R10=fp0 fp-8=0000scalar() fp-16_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=128,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff)) fp-24=map_value(map=augmented_args_,ks=4,vs=8272) fp-32=map_value(map=augmented_args_,ks=4,vs=8272,off=16) fp-40_w=scalar(id=28871,smin=umin=smin32=umin32=65,smax=umax=smax32=umax32=4159,var_off=(0x0; 0x1fff)) fp-48=ctx() fp-56=map_value(map=beauty_payload_,ks=4,vs=24688) fp-64=????1 fp-72_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=120,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff)) fp-80=map_value(map=beauty_map_ente,ks=4,vs=24)
; } else if (size > 0 && size <= value_size) { /* struct */ @ augmented_raw_syscalls.bpf.c:473
104: (26) if w9 > 0x1000 goto pc+5    ; R9_w=scalar(smin=umin=smin32=umin32=2,smax=umax=smax32=umax32=4096,var_off=(0x0; 0x1fff))
; if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg)) @ augmented_raw_syscalls.bpf.c:474
105: (79) r1 = *(u64 *)(r10 -16)      ; R1_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=128,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff)) R10=fp0 fp-16_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=128,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff))
106: (bc) w2 = w9                     ; R2_w=scalar(id=28880,smin=umin=smin32=umin32=2,smax=umax=smax32=umax32=4096,var_off=(0x0; 0x1fff)) R9_w=scalar(id=28880,smin=umin=smin32=umin32=2,smax=umax=smax32=umax32=4096,var_off=(0x0; 0x1fff))
107: (85) call bpf_probe_read_user#112        ; R0=scalar()
108: (15) if r0 == 0x0 goto pc+12 121: R0=0 R6=map_value(map=beauty_map_ente,ks=4,vs=24,off=16) R7=map_value(map=augmented_args_,ks=4,vs=8272,off=32) R8=5 R9=scalar(id=28880,smin=umin=smin32=umin32=2,smax=umax=smax32=umax32=4096,var_off=(0x0; 0x1fff)) R10=fp0 fp-8=0000scalar() fp-16=map_value(map=beauty_payload_,ks=4,vs=24688,off=128,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff)) fp-24=map_value(map=augmented_args_,ks=4,vs=8272) fp-32=map_value(map=augmented_args_,ks=4,vs=8272,off=16) fp-40=scalar(id=28871,smin=umin=smin32=umin32=65,smax=umax=smax32=umax32=4159,var_off=(0x0; 0x1fff)) fp-48=ctx() fp-56=map_value(map=beauty_payload_,ks=4,vs=24688) fp-64=????1 fp-72=map_value(map=beauty_payload_,ks=4,vs=24688,off=120,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff)) fp-80=map_value(map=beauty_map_ente,ks=4,vs=24)
; if (aug_size > value_size) @ augmented_raw_syscalls.bpf.c:491
121: (a5) if r9 < 0x1000 goto pc+1    ; R9=4096
122: (b7) r9 = 4096                   ; R9_w=4096
123: (79) r3 = *(u64 *)(r10 -72)      ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=120,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff)) R10=fp0 fp-72=map_value(map=beauty_payload_,ks=4,vs=24688,off=120,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff))
; ((struct augmented_arg *)payload_offset)->size = aug_size; @ augmented_raw_syscalls.bpf.c:501
124: (63) *(u32 *)(r3 +0) = r9        ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=120,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff)) R9_w=4096
; int written = offsetof(struct augmented_arg, value) + aug_size; @ augmented_raw_syscalls.bpf.c:496
125: (07) r9 += 8                     ; R9_w=4104
; payload_offset += written; @ augmented_raw_syscalls.bpf.c:503
126: (0f) r3 += r9                    ; R3_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=4224,smin=umin=smin32=umin32=9,smax=umax=smax32=umax32=4103,var_off=(0x0; 0x1fff)) R9_w=4104
; output += written; @ augmented_raw_syscalls.bpf.c:502
127: (79) r1 = *(u64 *)(r10 -40)      ; R1_w=scalar(id=28871,smin=umin=smin32=umin32=65,smax=umax=smax32=umax32=4159,var_off=(0x0; 0x1fff)) R10=fp0 fp-40=scalar(id=28871,smin=umin=smin32=umin32=65,smax=umax=smax32=umax32=4159,var_off=(0x0; 0x1fff))
128: (0f) r9 += r1
BPF program is too large. Processed 1000001 insn
processed 1000001 insns (limit 1000000) max_states_per_insn 32 total_states 34758 peak_states 202 mark_read 14
-- END PROG LOAD LOG --
libbpf: prog 'sys_enter': failed to load: -E2BIG
libbpf: failed to load object 'augmented_raw_syscalls_bpf'
libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -E2BIG
Error: failed to get syscall or beauty map fd
     0.000 (1000.055 ms): sleep/1139114 clock_nanosleep(rqtp: 0x7fff2269d5d0, rmtp: 0x7fff2269d5c0)           = 0
 
> Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
> [ coding style updates and fix a BPF verifier issue ]
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 62 ++++++++-----------
>  tools/perf/util/bpf_skel/vmlinux/vmlinux.h    | 14 +++++
>  2 files changed, 40 insertions(+), 36 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index cb86e261b4de0685..2c9bcc6b8cb0c06c 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -60,18 +60,6 @@ struct syscalls_sys_exit {
>  	__uint(max_entries, 512);
>  } syscalls_sys_exit SEC(".maps");
>  
> -struct syscall_enter_args {
> -	unsigned long long common_tp_fields;
> -	long		   syscall_nr;
> -	unsigned long	   args[6];
> -};
> -
> -struct syscall_exit_args {
> -	unsigned long long common_tp_fields;
> -	long		   syscall_nr;
> -	long		   ret;
> -};
> -
>  /*
>   * Desired design of maximum size and alignment (see RFC2553)
>   */
> @@ -115,7 +103,7 @@ struct pids_filtered {
>  } pids_filtered SEC(".maps");
>  
>  struct augmented_args_payload {
> -	struct syscall_enter_args args;
> +	struct trace_event_raw_sys_enter args;
>  	struct augmented_arg arg, arg2; // We have to reserve space for two arguments (rename, etc)
>  };
>  
> @@ -135,7 +123,7 @@ struct beauty_map_enter {
>  } beauty_map_enter SEC(".maps");
>  
>  struct beauty_payload_enter {
> -	struct syscall_enter_args args;
> +	struct trace_event_raw_sys_enter args;
>  	struct augmented_arg aug_args[6];
>  };
>  
> @@ -192,7 +180,7 @@ unsigned int augmented_arg__read_str(struct augmented_arg *augmented_arg, const
>  }
>  
>  SEC("tp/raw_syscalls/sys_enter")
> -int syscall_unaugmented(struct syscall_enter_args *args)
> +int syscall_unaugmented(struct trace_event_raw_sys_enter *args)
>  {
>  	return 1;
>  }
> @@ -204,7 +192,7 @@ int syscall_unaugmented(struct syscall_enter_args *args)
>   * filename.
>   */
>  SEC("tp/syscalls/sys_enter_connect")
> -int sys_enter_connect(struct syscall_enter_args *args)
> +int sys_enter_connect(struct trace_event_raw_sys_enter *args)
>  {
>  	struct augmented_args_payload *augmented_args = augmented_args_payload();
>  	const void *sockaddr_arg = (const void *)args->args[1];
> @@ -225,7 +213,7 @@ int sys_enter_connect(struct syscall_enter_args *args)
>  }
>  
>  SEC("tp/syscalls/sys_enter_sendto")
> -int sys_enter_sendto(struct syscall_enter_args *args)
> +int sys_enter_sendto(struct trace_event_raw_sys_enter *args)
>  {
>  	struct augmented_args_payload *augmented_args = augmented_args_payload();
>  	const void *sockaddr_arg = (const void *)args->args[4];
> @@ -243,7 +231,7 @@ int sys_enter_sendto(struct syscall_enter_args *args)
>  }
>  
>  SEC("tp/syscalls/sys_enter_open")
> -int sys_enter_open(struct syscall_enter_args *args)
> +int sys_enter_open(struct trace_event_raw_sys_enter *args)
>  {
>  	struct augmented_args_payload *augmented_args = augmented_args_payload();
>  	const void *filename_arg = (const void *)args->args[0];
> @@ -258,7 +246,7 @@ int sys_enter_open(struct syscall_enter_args *args)
>  }
>  
>  SEC("tp/syscalls/sys_enter_openat")
> -int sys_enter_openat(struct syscall_enter_args *args)
> +int sys_enter_openat(struct trace_event_raw_sys_enter *args)
>  {
>  	struct augmented_args_payload *augmented_args = augmented_args_payload();
>  	const void *filename_arg = (const void *)args->args[1];
> @@ -273,7 +261,7 @@ int sys_enter_openat(struct syscall_enter_args *args)
>  }
>  
>  SEC("tp/syscalls/sys_enter_rename")
> -int sys_enter_rename(struct syscall_enter_args *args)
> +int sys_enter_rename(struct trace_event_raw_sys_enter *args)
>  {
>  	struct augmented_args_payload *augmented_args = augmented_args_payload();
>  	const void *oldpath_arg = (const void *)args->args[0],
> @@ -304,7 +292,7 @@ int sys_enter_rename(struct syscall_enter_args *args)
>  }
>  
>  SEC("tp/syscalls/sys_enter_renameat2")
> -int sys_enter_renameat2(struct syscall_enter_args *args)
> +int sys_enter_renameat2(struct trace_event_raw_sys_enter *args)
>  {
>  	struct augmented_args_payload *augmented_args = augmented_args_payload();
>  	const void *oldpath_arg = (const void *)args->args[1],
> @@ -346,7 +334,7 @@ struct perf_event_attr_size {
>  };
>  
>  SEC("tp/syscalls/sys_enter_perf_event_open")
> -int sys_enter_perf_event_open(struct syscall_enter_args *args)
> +int sys_enter_perf_event_open(struct trace_event_raw_sys_enter *args)
>  {
>  	struct augmented_args_payload *augmented_args = augmented_args_payload();
>  	const struct perf_event_attr_size *attr = (const struct perf_event_attr_size *)args->args[0], *attr_read;
> @@ -378,7 +366,7 @@ int sys_enter_perf_event_open(struct syscall_enter_args *args)
>  }
>  
>  SEC("tp/syscalls/sys_enter_clock_nanosleep")
> -int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
> +int sys_enter_clock_nanosleep(struct trace_event_raw_sys_enter *args)
>  {
>  	struct augmented_args_payload *augmented_args = augmented_args_payload();
>  	const void *rqtp_arg = (const void *)args->args[2];
> @@ -399,7 +387,7 @@ int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
>  }
>  
>  SEC("tp/syscalls/sys_enter_nanosleep")
> -int sys_enter_nanosleep(struct syscall_enter_args *args)
> +int sys_enter_nanosleep(struct trace_event_raw_sys_enter *args)
>  {
>  	struct augmented_args_payload *augmented_args = augmented_args_payload();
>  	const void *req_arg = (const void *)args->args[0];
> @@ -429,7 +417,7 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
>  	return bpf_map_lookup_elem(pids, &pid) != NULL;
>  }
>  
> -static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
> +static int augment_sys_enter(void *ctx, struct trace_event_raw_sys_enter *args)
>  {
>  	bool augmented, do_output = false;
>  	int zero = 0, index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
> @@ -444,7 +432,7 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>  		return 1;
>  
>  	/* use syscall number to get beauty_map entry */
> -	nr             = (__u32)args->syscall_nr;
> +	nr             = (__u32)args->id;
>  	beauty_map     = bpf_map_lookup_elem(&beauty_map_enter, &nr);
>  
>  	/* set up payload for output */
> @@ -454,8 +442,8 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>  	if (beauty_map == NULL || payload == NULL)
>  		return 1;
>  
> -	/* copy the sys_enter header, which has the syscall_nr */
> -	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
> +	/* copy the sys_enter header, which has the id */
> +	__builtin_memcpy(&payload->args, args, sizeof(*args));
>  
>  	/*
>  	 * Determine what type of argument and how many bytes to read from user space, using the
> @@ -489,9 +477,11 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>  			index = -(size + 1);
>  			barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
>  			index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
> -			aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];
> +			aug_size = args->args[index];
>  
>  			if (aug_size > 0) {
> +				if (aug_size > TRACE_AUG_MAX_BUF)
> +					aug_size = TRACE_AUG_MAX_BUF;
>  				if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
>  					augmented = true;
>  			}
> @@ -515,14 +505,14 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>  		}
>  	}
>  
> -	if (!do_output || (sizeof(struct syscall_enter_args) + output) > sizeof(struct beauty_payload_enter))
> +	if (!do_output || (sizeof(*args) + output) > sizeof(*payload))
>  		return 1;
>  
> -	return augmented__beauty_output(ctx, payload, sizeof(struct syscall_enter_args) + output);
> +	return augmented__beauty_output(ctx, payload, sizeof(*args) + output);
>  }
>  
>  SEC("tp/raw_syscalls/sys_enter")
> -int sys_enter(struct syscall_enter_args *args)
> +int sys_enter(struct trace_event_raw_sys_enter *args)
>  {
>  	struct augmented_args_payload *augmented_args;
>  	/*
> @@ -550,16 +540,16 @@ int sys_enter(struct syscall_enter_args *args)
>  	 * unaugmented tracepoint payload.
>  	 */
>  	if (augment_sys_enter(args, &augmented_args->args))
> -		bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
> +		bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.id);
>  
>  	// If not found on the PROG_ARRAY syscalls map, then we're filtering it:
>  	return 0;
>  }
>  
>  SEC("tp/raw_syscalls/sys_exit")
> -int sys_exit(struct syscall_exit_args *args)
> +int sys_exit(struct trace_event_raw_sys_exit *args)
>  {
> -	struct syscall_exit_args exit_args;
> +	struct trace_event_raw_sys_exit exit_args;
>  
>  	if (pid_filter__has(&pids_filtered, getpid()))
>  		return 0;
> @@ -570,7 +560,7 @@ int sys_exit(struct syscall_exit_args *args)
>  	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
>  	 * unaugmented tracepoint payload.
>  	 */
> -	bpf_tail_call(args, &syscalls_sys_exit, exit_args.syscall_nr);
> +	bpf_tail_call(args, &syscalls_sys_exit, exit_args.id);
>  	/*
>  	 * If not found on the PROG_ARRAY syscalls map, then we're filtering it:
>  	 */
> diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> index a59ce912be18cd0f..b8b2347268633cdf 100644
> --- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> +++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> @@ -212,4 +212,18 @@ struct pglist_data {
>  	int nr_zones;
>  } __attribute__((preserve_access_index));
>  
> +struct trace_event_raw_sys_enter {
> +	struct trace_entry ent;
> +	long int id;
> +	long unsigned int args[6];
> +	char __data[0];
> +} __attribute__((preserve_access_index));
> +
> +struct trace_event_raw_sys_exit {
> +	struct trace_entry ent;
> +	long int id;
> +	long int ret;
> +	char __data[0];
> +} __attribute__((preserve_access_index));
> +
>  #endif // __VMLINUX_H
> -- 
> 2.51.0.rc1.167.g924127e9c0-goog

