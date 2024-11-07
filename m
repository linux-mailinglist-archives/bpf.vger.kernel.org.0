Return-Path: <bpf+bounces-44274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 701DB9C0D41
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 18:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFF31C21301
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F799216DE6;
	Thu,  7 Nov 2024 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRJaB6Ob"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33657192B88
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001874; cv=none; b=WoOPuPT8ClhGmvTz8r1gIxcDDH9RRgNdWYju3Z5XpebSE/NUl52bEhVeWEFb05R82M7e1CMkHQcbkvaDW9zQdkVGKSkHGQ8hC+mfl7cOcte4NCZxAHLjr4JCWdOCDpBeT7TxObuAnUmhowflho3o6svN7H+QXOjvgBmEhGtF1+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001874; c=relaxed/simple;
	bh=u6WupeLJWXlWDu+j9ueGY1c82sPLTNoNOWit90cMLek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WzJZahXQ6AzTIsLl8NsxKuelPTljcTXYPyFbd3A9UuP/VXElrgbpH4K2yqj5O5P/kRwXQ4qp90Wxxf9cyjCifL/cUoi0GUJRciPdmficYkey5n8QpQsqBEFB5gpHz2Frnznsun5wRHsoShw8IHrL31pZzskmponNCrn2vZYCM6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRJaB6Ob; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e3010478e6so1000585a91.1
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 09:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731001872; x=1731606672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2pMMO9wNWFK4UiQRNwjfPlj1zd9JX0nYe0yPSgDVxTE=;
        b=mRJaB6ObEmep1MaW8pSm8gQl/BJPFzt7GVhepjL8NIjDHmAAV3vdwe2WpUHgz0WntR
         r42OzvkGdbc47x2FAke2iFh+wkKXKeFEqLlqzQX224EaNECMnnOdD2lbJsuuF2vcEvax
         sFn4YEYCY7x6GW5Fbd1Ku2tM0PLnlPZaqBGAoGclU3wcrkBPMgMQVsNh3wh86yEpvua7
         sc/vqd0Ytt86XdZYZJrqp7SEBp47JFszChx6RM/ybm+HdFkTQ9FoJa4FpgNhN+dN3f28
         7oMjQyF1klKJPsU1LE3S9La1Y1Vk32fqMpV05OStnBWfw8su5PxiMeN5q111RMqCEghX
         4GSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731001872; x=1731606672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pMMO9wNWFK4UiQRNwjfPlj1zd9JX0nYe0yPSgDVxTE=;
        b=cdl3UI45DNDp5L/DUpLyeD4Ud+rfTPRiJzLgTD57ZTDyCjrKeTB+vRUp4+KrOlurgn
         lFYuL2JOJICIJECB0TgtJNldL6KNEBRQjeQKLbKMcqxm/k71EUNcBSY+7fV81hEJ1CZj
         ayd2HEvFScVSQRKbJLxZnoXq2NAP2Gv7aUNg+GljuKvsgheNsOhXUQ4B9fYd4qQImJG3
         nonx157CHpF/y1c4ZuNS+M6uYwYGcnfVwlwro/7hApMfeuwL2YeownSsZaZFMI5ogLuy
         KUqInlvB9wIJ3/LozZB8lDyOnnpfjP5Kpjpym+VwF4ayfI1PWQrSm2+XBM6zJ7D26VV3
         znZg==
X-Gm-Message-State: AOJu0YzzzBrFk+/i+JvqiJQ4bCSwTPr8RNs+o9g/3A5fP9n1Zs47Cl9S
	qVzaVGE6/4i0LoGfRqtTOG4b9Trke9kqtzBOCk0zVoFzCszpSivpGfXZQPM8
X-Google-Smtp-Source: AGHT+IHAO0RdpsiIGEU1WH7w3Xq2/WgPIh8kLtuS54+UXH2XfmkmWRj/bv3xcw6wC2N4aclqKBqzqw==
X-Received: by 2002:a17:90b:17c5:b0:2e2:e8a9:a1f with SMTP id 98e67ed59e1d1-2e9b170c2d6mr45243a91.13.1731001872071;
        Thu, 07 Nov 2024 09:51:12 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f52b32sm1730686a91.5.2024.11.07.09.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 09:51:11 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 00/11] bpf: inlinable kfuncs for BPF
Date: Thu,  7 Nov 2024 09:50:29 -0800
Message-ID: <20241107175040.1659341-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some time ago, in an off-list discussion, Alexei Starovoitov suggested
compiling certain kfuncs to BPF to allow inlining calls to such kfuncs
during verification. This RFC explores the idea.

This RFC introduces a notion of inlinable BPF kfuncs.
Inlinable kfuncs are compiled to BPF and are inlined by verifier after
program verification. Inlined kfunc bodies are subject to dead code
removal and removal of conditional jumps, if such jumps are proved to
always follow a single branch.

Motivation
----------

The patch set uses bpf_dynptr_slice() as guinea pig, as this function
is relatively complex and has a few conditionals that could be
removed most of the times. The function has the following structure:

    void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset,
                           void *buffer__opt, u32 buffer__szk)
    {
        ...
        type = bpf_dynptr_get_type(ptr);

        switch (type) {
        ...
        case BPF_DYNPTR_TYPE_SKB:
                if (buffer__opt)
                        return skb_header_pointer(...);
                else
                        return skb_pointer_if_linear(...);
        ...
    }

Parameters 'type' and 'buffer__opt' are most likely to be known at
callsite, and thus the function could be inlined w/o 'switch' and 'if'
checks above.

This has a measurable speedup on microbenchmark, e.g. a simple test
measuring number of bpf_dynptr_slice() executions per second shows
~1.5 speedup compared to master (see last patch in the series).
Granted, real world programs do some other work beside slice calls.

Mechanism
---------

Implementation pursues three main goals:
- avoid differences in program verification whether or not certain
  kfunc is inlinable;
- predict branches in inlined kfuncs bodies;
- allow inlined kfunc bodies to do arbitrary computations.

The goals are achieved in the following steps:
- Inlinable kfuncs are defined in kernel/bpf/inlinable_kfuncs.c.
- In order to include kernel headers as-is the C file is compiled to
  llvm bitcode targeting native architecture and then to BPF elf
  object using llc utility.
- BPF elf object is embedded in kernel data section.
- At kernel initialization time the elf object is parsed and functions
  defined in the object are deemed to be inlinable kfuncs.
- Before main verification pass, for each inlinable kfunc callsite,
  inlinable kfunc is cloned as a hidden subprogram. Such subprograms
  are called kfunc instances.
- A new KERNEL_VALUE register type is added:
  - ALU operations on any type and KERNEL_VALUE return KERNEL_VALUE;
  - load / store operations with base register having type
    KERNEL_VALUE return KERNEL_VALUE.
- During main verification pass:
  - inlinable kfunc calls are verified as regular kfunc calls;
  - the bodies of the corresponding kfunc instances are visited
    in a "distilled" context:
    - no caller stack frame;
    - scalar or null pointer r1-r5 from caller stack frame are copied
      to instance call frame verbatim;
    - pointer to dynptr r1-r5 from caller stack frame are represented
      in the instance call frame as pointers to a fake stack frame.
      For each dynptr this fake stack frame contains two register spills:
      - one scalar for 'size' field, which also encodes type;
      - one KERNEL_VALUE for 'data' field;
    - r1-r5 of all other types are represented in the instance call
      frame as KERNEL_VALUEs;
  - when 'exit' instruction within kfunc instance body is processed,
    verification for the current path is assumed complete.
- After main verification pass:
  - rely on existing passes opt_hard_wire_dead_code_branches() and
    opt_remove_dead_code() to simplify kfunc instance bodies;
  - calls to inlinable kfuncs are replaced with corresponding kfunc
    instance bodies, instance subprograms are removed.

Patch-set structure
-------------------

Implementation of the above mechanics is split in several patches to
simplify the review. The following patches are most interesting:

- "bpf: shared BPF/native kfuncs":
  Build system integration and kfuncs inlining after verification.

- "bpf: KERNEL_VALUE register type"
  Adds an opaque type for registers that could be used for ALU
  and memory access.

- "bpf: allow specifying inlinable kfuncs in modules"
  This is mostly for tests: for testing purposes
  it is necessary to control exact assembly code for
  both test case calling kfunc and kfunc itself.

- "bpf: instantiate inlinable kfuncs before verification"
  Adds a pass that clones inlinable kfunc bodies as hidden
  subprograms, one subprogram per callsite.

- "bpf: special rules for kernel function calls inside inlinable kfuncs"
  Allows to call arbitrary kernel functions from kfunc instances.

Limitations
-----------

Some existing verifier restrictions are not lifted for inlinable kfuncs:
- stack is limited to 512 bytes;
- max 8 call frames (7 with the fake call frame);
- loops are still verified in a "brute force" way;
- instructions processed for kfunc instances are counted in 1M
  instructions budget.

The list is probably not exhaustive.

TODO items
----------

The following items are currently on the TODO list:
- consider getting rid of bpftool linking phase for BPF elf object;
- consider getting rid of clang->bitcode->llc->elf dance;
- make bpf_dynptr_from_skb() inlinable and allow passing objects state
  between kfunc instances, thus avoiding special case for dynptr;
- determine the set of kfuncs for which inlining makes sense.

Alternatives
------------

Imo, this RFC is worth following through only if number of kfuncs
benefiting from inlining is big. If the set is limited to dynptr
family of functions, it is simpler to add a number of hard-coded
inlining templates for such functions (similarly to what is currently
done for some helpers).

Eduard Zingerman (11):
  bpf: use branch predictions in opt_hard_wire_dead_code_branches()
  selftests/bpf: tests for opt_hard_wire_dead_code_branches()
  bpf: shared BPF/native kfuncs
  bpf: allow specifying inlinable kfuncs in modules
  bpf: dynamic allocation for bpf_verifier_env->subprog_info
  bpf: KERNEL_VALUE register type
  bpf: instantiate inlinable kfuncs before verification
  bpf: special rules for kernel function calls inside inlinable kfuncs
  bpf: move selected dynptr kfuncs to inlinable_kfuncs.c
  selftests/bpf: tests to verify handling of inlined kfuncs
  selftests/bpf: dynptr_slice benchmark

 Makefile                                      |   22 +-
 include/linux/bpf.h                           |   40 +-
 include/linux/bpf_verifier.h                  |   12 +-
 include/linux/btf.h                           |    7 +
 kernel/bpf/Makefile                           |   25 +-
 kernel/bpf/btf.c                              |    2 +-
 kernel/bpf/helpers.c                          |  130 +-
 kernel/bpf/inlinable_kfuncs.c                 |  113 ++
 kernel/bpf/log.c                              |    1 +
 kernel/bpf/verifier.c                         | 1187 ++++++++++++++++-
 tools/testing/selftests/bpf/Makefile          |    2 +
 tools/testing/selftests/bpf/bench.c           |    2 +
 .../selftests/bpf/benchs/bench_dynptr_slice.c |   76 ++
 .../selftests/bpf/bpf_testmod/Makefile        |   24 +-
 .../{bpf_testmod.c => bpf_testmod_core.c}     |   25 +
 .../bpf/bpf_testmod/test_inlinable_kfuncs.c   |  132 ++
 .../selftests/bpf/prog_tests/verifier.c       |    9 +
 .../selftests/bpf/progs/dynptr_slice_bench.c  |   29 +
 .../selftests/bpf/progs/verifier_dead_code.c  |   63 +
 .../bpf/progs/verifier_inlinable_kfuncs.c     |  253 ++++
 20 files changed, 1970 insertions(+), 184 deletions(-)
 create mode 100644 kernel/bpf/inlinable_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_dynptr_slice.c
 rename tools/testing/selftests/bpf/bpf_testmod/{bpf_testmod.c => bpf_testmod_core.c} (97%)
 create mode 100644 tools/testing/selftests/bpf/bpf_testmod/test_inlinable_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/dynptr_slice_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_dead_code.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_inlinable_kfuncs.c

-- 
2.47.0


