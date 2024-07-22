Return-Path: <bpf+bounces-35278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A86939707
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8CF21F22310
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 23:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EC449655;
	Mon, 22 Jul 2024 23:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKmRVH9l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68318F5E
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721691548; cv=none; b=QROuSOwVcSygrKIXYKe0YD+A7xxNTEDw0v/nMJ+ixtawpCnXMNxnOLZZkRBHWfHqOa8vGO/BWPBNV26ei87ZByoEpt+2BGhOUisI4LlDks6bzi1kICu3oNhZOfpCTMZKW24U/popn0P8gV+XuITwOuPCvQ51Joazr6Izn86OuyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721691548; c=relaxed/simple;
	bh=nEgPUjagpnDZCRaz+cS8irHNtmddeYVrZ2oyGnQigwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uNAZ51qm8xZFTNL3wJCcScJAPrwk0i9LGCvrS11agnGKScGikI/lwnQ0q7vYagd6+zjlUopubYWR23UIVFx7Bi+6zwLabPd4/SU9PsECruH6IE5CtwO9Sp3XwhT4zSVhv+QudBcjUFtN9JqtY84wIAAOavd0bbv6XMYuqsg/ZSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKmRVH9l; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d333d57cdso724758b3a.3
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 16:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721691546; x=1722296346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D3S1+TjLqY9Qntriq/sTeEdAqElGBUng0t79zbQJdrA=;
        b=iKmRVH9lYTz0Y7XbnCOdZIHjPmzYeAlue6UZIY5JQI7nAN7PjafWwnBhY6C06iDMWa
         F1jJFSu2ti2tuVkN9lnv1NcwRpS5/0Q77kSA2wxw96zRLNPWW1Erm6wJ7xRmDN8oOgTa
         h4ncuKkA1AaR8gMQ3Gk16HTE7kkEf6aU38WyuQ+ctKgQ4A+947UBT17yKoK4sOCP9hfj
         SKZrvsCpB5Uu1IxdLWcjnwCUwi+JdJbbvk6Qqxn8ISI51kVQVN+LPxWuYa7PzbQgdpFF
         ZABDD3QMQNRCUn9TP9Wa/oIiAXGlTnNF3OMmW6w7QjoBdYAz5tvv1LZtDZhh/431r0kz
         G01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721691546; x=1722296346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3S1+TjLqY9Qntriq/sTeEdAqElGBUng0t79zbQJdrA=;
        b=huupV5651GfpEwKex1S0Tpq8MjCETPXXPWIzmMaazbSeNe1InTqaU8rMHrlWUGiL6t
         CrxzXyt3rgKH0xJCzFlrge05IodGaTCQ4oLdtjgopMwhbB2GSc3X0XtaHMeIw6G1o1J/
         jzHYcvzT2EULxAxpC1Zw33rb/OTLP+HKA/LOlelv+itZ0UwcR8ENFcRKjyuqiSuzen2G
         B36C+Yj76KNkJwK6W0hnhcrpBAZQx7awHpHqbI3nVLFKybvyuahm63/2jlJmSfk3cC+p
         e2q7ckhQ7CbyF2sJVUMu8WkzTjN/zppiNNpE2bVGs5SfjeFq7D3+rm76m1E3a4AEeqGW
         hUlw==
X-Gm-Message-State: AOJu0YxhnvWuXrGuVEsEetGwSpdtw50EUfvGW5zdx8mZW1BLS6/pjNVY
	I2NLW5k9QIwqUUbM1W4rQNFO+RDAyh1oY7gGf2eAM288xnthxCuCwcGh4zc7Xsc=
X-Google-Smtp-Source: AGHT+IEKL8zro43hsI+r3lnuKjlth1NdkKuyT3D9dJ6x9vY01XxP2jyi0LjHcfbjPnTVg6H+M0gDFQ==
X-Received: by 2002:a05:6a00:a0d:b0:705:9ddb:db6b with SMTP id d2e1a72fcca58-70d084f1e60mr7841752b3a.13.1721691545656;
        Mon, 22 Jul 2024 16:39:05 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d2707fe14sm2479500b3a.163.2024.07.22.16.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 16:39:05 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 00/10] no_caller_saved_registers attribute for helper calls
Date: Mon, 22 Jul 2024 16:38:34 -0700
Message-ID: <20240722233844.1406874-1-eddyz87@gmail.com>
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
- v3 -> v4:
  - When nocsr spills/fills are removed in the subprogram, allow these
    spills/fills to reside in [-MAX_BPF_STACK-48..MAX_BPF_STACK) range
    (suggested by Alexei);
  - Dropped patches with special handling for bpf_probe_read_kernel()
    (requested by Alexei);
  - Reset aux .nocsr_pattern and .nocsr_spills_num fields in
    check_nocsr_stack_contract() (requested by Andrii).
    Andrii, I have not added an additional flag to
    struct bpf_subprog_info, it currently does not have holes
    and I really don't like adding a bool field there just as an
    alternative indicator that nocsr is disabled.
    Indicator at the moment:
    - nocsr_stack_off >= S16_MIN means that nocsr rewrite is enabled;
    - nocsr_stack_off == S16_MIN means that nocsr rewrite is disabled.
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
- v3 https://lore.kernel.org/bpf/20240715230201.3901423-1-eddyz87@gmail.com/

Eduard Zingerman (10):
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

 include/linux/bpf.h                           |   6 +
 include/linux/bpf_verifier.h                  |  14 +
 kernel/bpf/helpers.c                          |   1 +
 kernel/bpf/verifier.c                         | 351 +++++++-
 tools/testing/selftests/bpf/Makefile          |   1 +
 tools/testing/selftests/bpf/disasm_helpers.c  |  69 ++
 tools/testing/selftests/bpf/disasm_helpers.h  |  12 +
 .../selftests/bpf/prog_tests/ctx_rewrite.c    |  74 +-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  13 +
 .../selftests/bpf/progs/verifier_nocsr.c      | 796 ++++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     | 217 +++--
 tools/testing/selftests/bpf/test_progs.h      |   1 -
 tools/testing/selftests/bpf/testing_helpers.c |   1 +
 14 files changed, 1432 insertions(+), 126 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/disasm_helpers.c
 create mode 100644 tools/testing/selftests/bpf/disasm_helpers.h
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_nocsr.c

-- 
2.45.2


