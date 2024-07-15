Return-Path: <bpf+bounces-34852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E93931D65
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 01:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73101F22720
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 23:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C567214037D;
	Mon, 15 Jul 2024 23:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bb00u6Bc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B662620DF4
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 23:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721084549; cv=none; b=eKMhqHZzYieVa16r/XcWpOMxdO5zM0/KuCohcoezEEOVrPikGYHID7V6hqmpyFmbnQ4hw4W55vuc8fCI3hE/fqIkRqViFwLN27IFOAlX2Wh2J3kE/8TYtWnI1klhCstdwohe7TeBgCNH6Us4vetUwgIEr1PDZy1ax2kzDebZmWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721084549; c=relaxed/simple;
	bh=FsitFh7t3WHI9kTT/KH9wbIWVT/kX4aCDneyR5FTgpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hGDkEQ89OW/ZTe1dYJRsJHmOfbFNE1W6hwC/KGUoxd/RanlouYCZirp1iR2//j5tGFwLlPLKsq3Df5ZiheTaNKKfclbMo1KxyMCcQzbGug5FE6E9AEc1Qt0RXbiaUsyRfiFxK0QkUZsuDr6ePIJgKyO11ypuy4Pf85E9Sf0xnTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bb00u6Bc; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70af3d9169bso3371918b3a.1
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 16:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721084547; x=1721689347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bKK5GboDDWbPM9MBZvqoULROeRD5JHjw97fmlerH14I=;
        b=Bb00u6BcA9k1NyFFu/TZ5sHQvlyGIy/lTkiDdatNqvn2vtrAiXYD837NXn+M+7FdnG
         J2jkn18wE1ZGPDKM+/60TQpjFI0psAXDCU8me1p+bTMmdJ95e8r9XWKGy70rXgJ11eYy
         eBcgYmQmXqJcYmtl1XYSRlB7TMhEQPkaP7pmN8XCpZSXRbqRjCWu/QLL7g7DmtTgW9VZ
         SgcOu3d4yQPXdiWaRAFqiYUfmmAZ4uIGLu/zK/Tv8Wrosn4JhAv7JFepPVol3lzG+XDV
         DWZ7KQknu3oAMLBXUyc4wI/kCJBeMyBSTz+metMClxJHBI0ItSmYDdLFrnys5HYSg+cG
         KCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721084547; x=1721689347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKK5GboDDWbPM9MBZvqoULROeRD5JHjw97fmlerH14I=;
        b=r1qvqZueLBda7ybAhW1pcznlf+JLejEIDnVqb5CtITHA8zZ7Op1UpB1luWSkJ4GIvq
         bgNz9lQWbN2vZ5nfIb4AdU3sqdLQ2uy2gVOj2qLVkq18TnEkD+4ynsJXx8eoa3SYithb
         k4r4+4GQKPVjevG1ScuRZRLkVxe5RDUct37P5K33uGxwNV7ET6VrttSoKGQUuhvRtBkJ
         a84MfskqYq4635EMWGxukLUA/v84F7LXagEOgz9HwErXaHxERlZ5ZNW9Y9cMOA2GigiK
         bHEhIG4H8IW+0B2uuO9c16hi18px0FItoXQOq+m4WDlRDVysjCXBlA+8DVSxR4dGrcu3
         tPNw==
X-Gm-Message-State: AOJu0Yy6KwKwghK1IlMYmbUp1mnSY2UeevLakh0T76GQYJpN8okKR2jH
	kVLxid7YXVSrK+f2WF3ZPrZ4MLD/eXjhq3T/+eI1Skr++qZl4krES4mkvw==
X-Google-Smtp-Source: AGHT+IFaKmZQUlxGvchS68MusY572Ujs5SqnUW6k8auyM9rLKRXkRlpbrRyJzoHS6VDnGftK5qQGNQ==
X-Received: by 2002:a05:6a00:23c7:b0:70a:fe2d:473a with SMTP id d2e1a72fcca58-70c1fb71a02mr606589b3a.2.1721084546536;
        Mon, 15 Jul 2024 16:02:26 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecc9d36sm4915344b3a.205.2024.07.15.16.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 16:02:26 -0700 (PDT)
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
Subject: [bpf-next v3 00/12] no_caller_saved_registers attribute for helper calls
Date: Mon, 15 Jul 2024 16:01:49 -0700
Message-ID: <20240715230201.3901423-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch-set seeks to allow using no_caller_saved_registers gcc/clang
attribute with some BPF helper functions (and kfuncs in the future).

As documented in [1], this attribute means that function scratches
only some of the caller saved registers defined by ABI.
For BPF the set of such registers could be defined as follows:
- R0 is scratched only if function is non-void;
- R1-R5 are scratched only if corresponding parameter type is defined
  in the function prototype.

The goal of the patch-set is to implement no_caller_saved_registers
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
- stack offsets used for spills/fills are allocated as lowest
  stack offsets in whole function and are not used for any other
  purpose;
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
     0: (bf) r3 = r1                         <--- 3rd printk parameter
  ; __u32 task = bpf_get_smp_processor_id();
     1: (b4) w0 = 197324                     <--. inlined helper call,
     2: (bf) r0 = &(void __percpu *)(r0)     <--- spill/fill
     3: (61) r0 = *(u32 *)(r0 +0)            <--' pair removed
  ; bpf_printk("ctx=%p, smp=%d", ctx, task);
     4: (18) r1 = map[id:5][0]+0
     6: (b7) r2 = 15
     7: (bf) r4 = r0
     8: (85) call bpf_trace_printk#-125920
  ; return 0;
     9: (b7) r0 = 0
    10: (95) exit

[1] https://clang.llvm.org/docs/AttributeReference.html#no-caller-saved-registers
[2] https://github.com/eddyz87/llvm-project/tree/bpf-no-caller-saved-registers

Change list:
- v2 -> v3:
  - As suggested by Andrii, 'nocsr_stack_off' is no longer checked at
    rewrite time, instead mark_nocsr_patterns() now does two passes
    over BPF program:
    - on a first pass it computes the lowest stack spill offset for
      the subprogram;
    - on a second pass this offset is used to recognize nocsr pattern.
  - As suggested by Alexei, a new mechanic is added to work around a
    situation mentioned by Andrii, when more helper functions are
    marked as nocsr at compile time than current kernel supports:
    - all {spill*,helper call,fill*} patterns are now marked as
      insn_aux_data[*].nocsr_pattern, thus relaxing failure condition
      for check_nocsr_stack_contract();
    - spill/fill pairs are not removed for patterns where helper can't
      be inlined;
    - see mark_nocsr_pattern_for_call() for details an example.
  - As suggested by Alexei, subprogram stack depth is now adjusted
    if all spill/fill pairs could be removed. This adjustment has
    to take place before optimize_bpf_loop(), hence the rewrite
    is moved from do_misc_fixups() to remove_nocsr_spills_fills()
    (again).
  - As suggested by Andrii, special measures are taken to work around
    bpf_probe_read_kernel() access to BPF stack, see patches 11, 12.
    Patch #11 is very simplistic, a more comprehensive solution would
    be to change the type of the third parameter of the
    bpf_probe_read_kernel() from ARG_ANYTHING to something else and
    not only check nocsr contract, but also propagate stack slot
    liveness information. However, such change would require update in
    struct bpf_call_arg_meta processing, which currently implies that
    every memory parameter is followed by a size parameter.
    I can work on these changes, please comment.
  - Stylistic changes suggested by Andrii.
  - Added acks from Andrii.
  - Dropped RFC tag.
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
- v2 https://lore.kernel.org/bpf/20240704102402.1644916-1-eddyz87@gmail.com/

Eduard Zingerman (12):
  bpf: add a get_helper_proto() utility function
  bpf: no_caller_saved_registers attribute for helper calls
  bpf, x86, riscv, arm: no_caller_saved_registers for
    bpf_get_smp_processor_id()
  selftests/bpf: extract utility function for BPF disassembly
  selftests/bpf: print correct offset for pseudo calls in disasm_insn()
  selftests/bpf: no need to track next_match_pos in struct test_loader
  selftests/bpf: extract test_loader->expect_msgs as a data structure
  selftests/bpf: allow checking xlated programs in verifier_* tests
  selftests/bpf: __arch_* macro to limit test cases to specific archs
  selftests/bpf: test no_caller_saved_registers spill/fill removal
  bpf: do check_nocsr_stack_contract() for ARG_ANYTHING helper params
  selftests/bpf: check nocsr contract for bpf_probe_read_kernel()

 include/linux/bpf.h                           |   6 +
 include/linux/bpf_verifier.h                  |  14 +
 kernel/bpf/helpers.c                          |   1 +
 kernel/bpf/verifier.c                         | 333 +++++++-
 tools/testing/selftests/bpf/Makefile          |   1 +
 tools/testing/selftests/bpf/disasm_helpers.c  |  69 ++
 tools/testing/selftests/bpf/disasm_helpers.h  |  12 +
 .../selftests/bpf/prog_tests/ctx_rewrite.c    |  74 +-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  13 +
 .../selftests/bpf/progs/verifier_nocsr.c      | 794 ++++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     | 217 +++--
 tools/testing/selftests/bpf/test_progs.h      |   1 -
 tools/testing/selftests/bpf/testing_helpers.c |   1 +
 14 files changed, 1414 insertions(+), 124 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/disasm_helpers.c
 create mode 100644 tools/testing/selftests/bpf/disasm_helpers.h
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_nocsr.c

-- 
2.45.2


