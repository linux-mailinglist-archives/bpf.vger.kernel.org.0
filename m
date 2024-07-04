Return-Path: <bpf+bounces-33875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A19EF9273EF
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 12:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B23A1F228AB
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 10:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9721AB909;
	Thu,  4 Jul 2024 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ3kPaeX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B8D13C8FF
	for <bpf@vger.kernel.org>; Thu,  4 Jul 2024 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088661; cv=none; b=TrqBfmj/OLYzWOIp4q/uIDhFWZ+YV232VDo6PPipBjxHVF3FeM3+kaJWg/5a1efLpHEiIu7F3LnojhzVYqtkv8NYlMPveMK6r3pzwfKLbdbT9NcC9YYqg1qNls66DEydTGW7GCHqDLoc1iKSSn+g9Szg9IYKBfxWskjsSC/j8C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088661; c=relaxed/simple;
	bh=sxCA/1JQ3fJEjf345Y2oxy0vuiuiraCtAyGVULH3l6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BlNiJF1r+6oZUIqWRkVav1YTd0zzk0Vt4aOO/J8L9ttoBLUJu09q9NJhzN97KdZnAaVZaIdBJCgoxXpOtDWdUZx56G0e5shNZP8SlEYKNPZjy9DCHE786+DNkzc5gzAdwaUDozDM2tX4ZnKOAe8prG7/TebQThsP3fmv9fXOhm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZ3kPaeX; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c8c6cc53c7so346339a91.0
        for <bpf@vger.kernel.org>; Thu, 04 Jul 2024 03:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720088659; x=1720693459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ogKpuAHZFj7y8W8hoHR3NOhxTopR7I0hO0ex6MnbCTY=;
        b=TZ3kPaeXpld35AJpzjq6uaSBx0YbcH1Zdmpdgkgo6W+7PTPvWk3ozyy7festcc+6Bm
         GIYUATghn2RQHD7ORF5zeWLbbvqcI7x3E4ihPoKfZ3J6lX+SY2SnGDvbAOzHKbyVEvAF
         YMliId08+rQvWZezN1RWeEJBWGWjfWXl8knbeAutdG7hjbfDvHqRZLs14m0XC5ajmAhs
         SGqgCG5Co7Uy7xZbHstMgH/ZhbSBnbKU2Wp9eakybn0uaOkHQHWMosr8s/o5f42GGHW1
         KJiBVAtZYHnI3OSj69to44G7Mv91Y3n84MqVQCkuc+YtyVt8qNdAtwH/RJ+IgWJo4d15
         7R4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720088659; x=1720693459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogKpuAHZFj7y8W8hoHR3NOhxTopR7I0hO0ex6MnbCTY=;
        b=uokJRp7yfOHVRmN8C3Szu5dkOFDFWKMXrDGGoNgHrKioWC5g4QXbzBhcnfRtR2s/+x
         IMeFoO/bpZpkLOZHcJ6eDYQ9v9lKPsVWklcVkhMDZUp5t53VyrBO1jwMIsYa74flZGK1
         4QD7BzGSmDKbvhQR2d5maUi9G+ozxmc8F1MYS5qtT7n+Jnw26l6SgMSekHm+TXFquvBW
         Z43l6HHSDt+jJzF3g1bAe1/6x19esTBAwLaSQ1defGHKm1MPROc946RlStYqvn8tbGrR
         4dbHQedAydgn1ENW5nEAGLNbb2HZAOd1VuIpI+TqugK2jtMSUPGx3/FlQtia9GGGKxWM
         jhzQ==
X-Gm-Message-State: AOJu0Ywc746nNz3STUD9TyQj7zIwYXJehDQdP2o5n/cJx21oabSyx445
	IzUbt2KasuEWA88P7XVGgCwmqg93N2FjMzHhq38g6SaJVTzlItvV+tFbXg==
X-Google-Smtp-Source: AGHT+IFEG+kf0tfRlRJgsLf9cDPm/S4aUqytEHxgTIFe+YsTwffIhsTsru0KvHhgNuSfr55V+4zAlw==
X-Received: by 2002:a17:90a:d604:b0:2c9:7aea:2188 with SMTP id 98e67ed59e1d1-2c99c50fcd4mr926107a91.2.1720088658716;
        Thu, 04 Jul 2024 03:24:18 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c9a4c0fe8dsm216693a91.0.2024.07.04.03.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 03:24:18 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next v2 0/9] no_caller_saved_registers attribute for helper calls
Date: Thu,  4 Jul 2024 03:23:52 -0700
Message-ID: <20240704102402.1644916-1-eddyz87@gmail.com>
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

Change list:
- v1 -> v2:
  - assume that functions inlined by either jit or verifier
    conform to no_caller_saved_registers contract (Andrii, Puranjay);
  - allow nocsr rewrite for bpf_get_smp_processor_id()
    on arm64 and riscv64 architectures (Puranjay);
  - __arch_{x86_64,arm64,riscv64} macro for test_loader;
  - moved remove_nocsr_spills_fills() inside do_misc_fixups() (Andrii);
  - moved nocsr pattern detection from check_cfg() to a separate pass
    (Andrii);
  - various stylistic/correctness changes according to Andrii's
    comments.

Revisions:
- v1 https://lore.kernel.org/bpf/20240629094733.3863850-1-eddyz87@gmail.com/

Eduard Zingerman (9):
  bpf: add a get_helper_proto() utility function
  bpf: no_caller_saved_registers attribute for helper calls
  bpf, x86, riscv, arm: no_caller_saved_registers for
    bpf_get_smp_processor_id()
  selftests/bpf: extract utility function for BPF disassembly
  selftests/bpf: no need to track next_match_pos in struct test_loader
  selftests/bpf: extract test_loader->expect_msgs as a data structure
  selftests/bpf: allow checking xlated programs in verifier_* tests
  selftests/bpf: __arch_* macro to limit test cases to specific archs
  selftests/bpf: test no_caller_saved_registers spill/fill removal

 include/linux/bpf.h                           |   6 +
 include/linux/bpf_verifier.h                  |  14 +
 kernel/bpf/helpers.c                          |   1 +
 kernel/bpf/verifier.c                         | 339 +++++++++++-
 tools/testing/selftests/bpf/Makefile          |   1 +
 tools/testing/selftests/bpf/disasm_helpers.c  |  51 ++
 tools/testing/selftests/bpf/disasm_helpers.h  |  12 +
 .../selftests/bpf/prog_tests/ctx_rewrite.c    |  74 +--
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  13 +
 .../selftests/bpf/progs/verifier_nocsr.c      | 521 ++++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     | 217 ++++++--
 tools/testing/selftests/bpf/test_progs.h      |   1 -
 tools/testing/selftests/bpf/testing_helpers.c |   1 +
 14 files changed, 1124 insertions(+), 129 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/disasm_helpers.c
 create mode 100644 tools/testing/selftests/bpf/disasm_helpers.h
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_nocsr.c

-- 
2.45.2


