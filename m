Return-Path: <bpf+bounces-33415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B31C91CBED
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 11:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A8F1F224DD
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 09:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFCF3BBCF;
	Sat, 29 Jun 2024 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE+F/T3w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F17A39FF2
	for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719654488; cv=none; b=NQURMPELBTleJSzDK89Nevhyi8Ti0V0I0VixfDUWPatQwI/DihapY6DLLNnKNNQb67tB6yQDW8hs4PWpE//r9KhNaBRxtS3qNNBdnkBVqvHjMJJDNeoi4pxcknf0Myehx2iF7t8EmlE9KYBI3+OZGV5H3dtUBib84fUcyDRkD8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719654488; c=relaxed/simple;
	bh=4c8XsOMf9z0SNbQnJCLqCuNeEAVxdXKfxtHwJSSGTLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GI4VMQ2Er5qHQ5In0vqGCz6eS5+5EqMzaKPeUBwcG+FivBaryLPgyDTWDChn1Xuloxz5CED/ziD+CtlNvfqgVJyUw9ihYS5vrjCqwJ+w8Dy7rOH3GM9Ajnn3hmTXOIRam08Ytep4ifjsnslj+L/7S/bSW+c3+A0t1qXA3MwqT0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iE+F/T3w; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d5611cdcb7so569081b6e.3
        for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 02:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719654486; x=1720259286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OGEIngohChJXlIa+4Vz8K43OkdR9sE+XJaDIvmmflCQ=;
        b=iE+F/T3wVhSNqwuVnoxQAokXNh9+R2SVO2xLLvxskIOlBtpyf4JjPI3QBSX3RLiGLK
         wcmHwJ1MRCYmVVc0uQwIxpuC1Zs2KfQGxsoufNdd6wDFQzejNkGa07GmhajZH90DCA56
         FVfwDb0B/ojYWIHAuHAgYAiEbZGud3XcaaIusQYgJVHKreCT/E5MgFLza/Z6oSavW/RO
         A2ZMS/Y/1CwN2OyJADy9l6N44e3JaF6hZPMhVYb3XS/uLvwGKIl4stY15VPdHrHQ8Wrm
         5rFu8kW03yQzvF7fy5Sj3b/8/V1Ii/zytASVIFb/sG2mXEbMPEkzdOdQI13B8hI44GAj
         jO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719654486; x=1720259286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGEIngohChJXlIa+4Vz8K43OkdR9sE+XJaDIvmmflCQ=;
        b=aro9LyMFVmaREaXFBZo6AbunZWO5pLjhhITjsVZ835uGLNj3pS+C+jBXktYca5Od4V
         TvOj/K58C507QCRhs/uGZnM9uK6UiseqJHQ/c8nRT+6VRMVfBR2jYQGNLOgOtihb2G69
         ywc3W2sJlPs+i6XEZ1vMQEQnWxS7XwDPTK4wjOd4ZBTiuoodYfaVvsxl5pZ9LmKpw2df
         ImUZfZEJFJ3av5yjgoru7zDujlOUJGtBtnunYYW/K+GuFCfB6xn4gyeYBi205eyr/UJ0
         cPSkbRHYSoPhDQMH3IpW/EbXKR61+7qEwxo3HjWdddFDbkGAxAEvlAFQhcPWejFdOf6k
         jLng==
X-Gm-Message-State: AOJu0YxI7lzCjI8TVqqQBikf9Wzb23kXhepTfF86EP5Re55hk04pXdCm
	2VZ3SsUtmCNEbLPICiN2DeFVmL1eOacxFneK4fgxT3229m86s4uIH8p2tA==
X-Google-Smtp-Source: AGHT+IGL4UWjlArv6+N4d7yq2HVjm49exrRPovCXhSGU4SxrnYiYbUJFxPwC8M0zwlT4S97XbJFnBg==
X-Received: by 2002:a05:6808:1493:b0:3d2:275b:15a with SMTP id 5614622812f47-3d6b2b2570emr577184b6e.10.1719654485871;
        Sat, 29 Jun 2024 02:48:05 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804989f5asm2948932b3a.195.2024.06.29.02.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 02:48:05 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next v1 0/8] no_caller_saved_registers attribute for helper calls
Date: Sat, 29 Jun 2024 02:47:25 -0700
Message-ID: <20240629094733.3863850-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC seeks to allow using no_caller_saved_registers gcc/clang
attribute with some BPF helper functions (and kfuncs in the future).

As documented in [1], this attribute means that function scratches
only some of the caller saved registers defined by ABI.
For BPF the set of such registers could be defined as follows:
- R0 is scratched only if function is non-void;
- R1-R5 are scratched only if corresponding parameter type is defined
  in the function prototype.

The goal of the RFC is to implement no_caller_saved_registers
(nocsr for short) in a backwards compatible manner:
- for kernels that support the feature, gain some performance boost
  from better register allocation;
- for kernels that don't support the feature, allow programs execution
  with minor performance losses.

To achieve this, use a scheme suggested by Alexei Starovoitov:
- for nocsr calls clang allocates registers as-if relevant r0-r5
  registers are not scratched by the call;
- as a post-processing step, clang visits each nocsr call and adds
  spill/fill for every live r0-r5;
- stack offsets used for spills/fills are allocated as minimal
  stack offsets in whole function and are not used for any other
  purposes;
- when kernel loads a program, it looks for such patterns
  (nocsr function surrounded by spills/fills) and checks if
  spill/fill stack offsets are used exclusively in nocsr patterns;
- if so, and if current JIT inlines the call to the nocsr function
  (e.g. a helper call), kernel removes unnecessary spill/fill pairs;
- when old kernel loads a program, presence of spill/fill pairs
  keeps BPF program valid, albeit slightly less efficient.

Corresponding clang/llvm changes are available in [2].

The patch-set uses bpf_get_smp_processor_id() function as a canary,
making it the first helper with nocsr attribute.

For example, consider the following program:

  #define __no_csr __attribute__((no_caller_saved_registers))
  #define SEC(name) __attribute__((section(name), used))
  #define bpf_printk(fmt, ...) bpf_trace_printk((fmt), sizeof(fmt), __VA_ARGS__)

  typedef unsigned int __u32;

  static long (* const bpf_trace_printk)(const char *fmt, __u32 fmt_size, ...) = (void *) 6;
  static __u32 (*const bpf_get_smp_processor_id)(void) __no_csr = (void *)8;

  SEC("raw_tp")
  int test(void *ctx)
  {
          __u32 task = bpf_get_smp_processor_id();
  	bpf_printk("ctx=%p, smp=%d", ctx, task);
  	return 0;
  }

  char _license[] SEC("license") = "GPL";

Compiled (using [2]) as follows:

  $ clang --target=bpf -O2 -g -c -o nocsr.bpf.o nocsr.bpf.c
  $ llvm-objdump --no-show-raw-insn -Sd nocsr.bpf.o
    ...
  3rd parameter for printk call     removable spill/fill pair
  .--- 0:       r3 = r1                             |
; |       __u32 task = bpf_get_smp_processor_id();  |
  |    1:       *(u64 *)(r10 - 0x8) = r3 <----------|
  |    2:       call 0x8                            |
  |    3:       r3 = *(u64 *)(r10 - 0x8) <----------'
; |     bpf_printk("ctx=%p, smp=%d", ctx, task);
  |    4:       r1 = 0x0 ll
  |    6:       r2 = 0xf
  |    7:       r4 = r0
  '--> 8:       call 0x6
;       return 0;
       9:       r0 = 0x0
      10:       exit

Here is how the program looks after verifier processing:

  # bpftool prog load ./nocsr.bpf.o /sys/fs/bpf/nocsr-test
  # bpftool prog dump xlated pinned /sys/fs/bpf/nocsr-test
  int test(void * ctx):
  ; int test(void *ctx)
     0: (bf) r3 = r1               <--------- 3rd printk parameter
  ; __u32 task = bpf_get_smp_processor_id();
     1: (b4) w0 = 197132           <--------- inlined helper call,
     2: (bf) r0 = r0               <--------- spill/fill pair removed
     3: (61) r0 = *(u32 *)(r0 +0)  <---------
  ; bpf_printk("ctx=%p, smp=%d", ctx, task);
     4: (18) r1 = map[id:13][0]+0
     6: (b7) r2 = 15
     7: (bf) r4 = r0
     8: (85) call bpf_trace_printk#-125920
  ; return 0;
     9: (b7) r0 = 0
    10: (95) exit

[1] https://clang.llvm.org/docs/AttributeReference.html#no-caller-saved-registers
[2] https://github.com/eddyz87/llvm-project/tree/bpf-no-caller-saved-registers

Eduard Zingerman (8):
  bpf: add a get_helper_proto() utility function
  bpf: no_caller_saved_registers attribute for helper calls
  bpf, x86: no_caller_saved_registers for bpf_get_smp_processor_id()
  selftests/bpf: extract utility function for BPF disassembly
  selftests/bpf: no need to track next_match_pos in struct test_loader
  selftests/bpf: extract test_loader->expect_msgs as a data structure
  selftests/bpf: allow checking xlated programs in verifier_* tests
  selftests/bpf: test no_caller_saved_registers spill/fill removal

 include/linux/bpf.h                           |   6 +
 include/linux/bpf_verifier.h                  |   9 +
 kernel/bpf/helpers.c                          |   1 +
 kernel/bpf/verifier.c                         | 346 +++++++++++++-
 tools/testing/selftests/bpf/Makefile          |   1 +
 tools/testing/selftests/bpf/disasm_helpers.c  |  50 ++
 tools/testing/selftests/bpf/disasm_helpers.h  |  12 +
 .../selftests/bpf/prog_tests/ctx_rewrite.c    |  71 +--
 .../selftests/bpf/prog_tests/verifier.c       |   7 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   6 +
 .../selftests/bpf/progs/verifier_nocsr.c      | 437 ++++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     | 170 +++++--
 tools/testing/selftests/bpf/test_progs.h      |   1 -
 tools/testing/selftests/bpf/testing_helpers.c |   1 +
 14 files changed, 986 insertions(+), 132 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/disasm_helpers.c
 create mode 100644 tools/testing/selftests/bpf/disasm_helpers.h
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_nocsr.c

-- 
2.45.2


