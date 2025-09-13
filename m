Return-Path: <bpf+bounces-68293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7907B562C1
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 21:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B4B5638D6
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 19:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7122924BBEB;
	Sat, 13 Sep 2025 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8P0mJ+b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A67C211C
	for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 19:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757792021; cv=none; b=XO+uWBps76bCO7UHRgWc9HARWc2/E5fxnnxQBBCyPzJFm941WDWSY3RHtd4xGxovt6ra0oKXe0b7hzsHXoTF47gmja5yBcwe+TrAZmJrVUxRI02oO+EWLjFzcKaHqEvxx2WuoZ/5hZqGVxLyME8Sk6VYwMy72OonqTsQyzg2UAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757792021; c=relaxed/simple;
	bh=ycDXdRh19YPXpBoS0Kb00r8hFPUIM6O28y/YhC/a0uM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qNDpIn1BL/l1U3nAGdNYTqHiU/4lIP7/gYBs3GLSqxGbQL3F236n3hizl/ju4xT043eLYKuQdXhoa2JOAgmlYdae3o/FWYxcoGEGTvN3sj5B8ETCjgJNlFvvjUI+hot/4ppodk2B9mCOdQNo0XY5iOSl+YdO2x+BLAS4YuT9ep0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8P0mJ+b; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3e7636aa65fso2331878f8f.1
        for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 12:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757792017; x=1758396817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hLUqu04jRKnCRzJm2g0KfV4vGr7rntBxxctIfau5nUQ=;
        b=A8P0mJ+btKuNyJv99Om4iMMZtf4gYsZsaj243d8/urCquqPwGWKvlWm9obOiuQbGf5
         J5YIyIvoTfx92Rx9xVqZEo9lRbG0JSNl2UWaKrjqnPYDIRTRqa3+BswksBvFwXg9pk1Q
         wMtnv+1SsGSZHZMvFoWv1rY1kJRxl16nlnn2Y4L8GhrdDYwryWpSj3JBtvAZ81EngDTG
         hZOVjJKRLDSKsGWDTo9sSIp1liNdl2n2jIqhGpJNKclOGA++vPLr5LleKhjlVTs6XOv6
         +0Gmmxj57Y/2u33i7t/dRe+u9DtyhH9g0Q6Ym4AyuuSjQxAylewkzGTSdxsXXgMAnmIS
         iLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757792017; x=1758396817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLUqu04jRKnCRzJm2g0KfV4vGr7rntBxxctIfau5nUQ=;
        b=O62kYL/D/x+HLB5XTHPVSJCFkMQtOIt/mMDxveADMTpb+7vQ2x92Ytr3qSHPVqJVsE
         OmxL8fGEkCKTes/wcWN5RRuQV6mySc6uYaxumjhZ8ERnAGRQJGj0jn7gL8l20Tpa82wX
         ZUAhEqJbND/vEKrDCQCIExwhds1FJx08+or0tl7wCc+p7HBkYJr/omfkX1p27rsPyZ6i
         5M6PCeFA3R9OJutCzDnGnVUl/CpYVKpuaLaYh+jfUP6Q7WRh/ZaPOconD4p5PEszKtcK
         UTuwTxfVXDUmlox1S+HtAMhILreHWSHW41gODoPSYSUHAORMZk3WyLTFbh6SbaR3nzVm
         sscg==
X-Gm-Message-State: AOJu0YyN5ZwEpVYUanCSZtTcxgoLMqMeb4L67EQMxoH+ju4bBRDtit+A
	ut/5d8BAeuJIIwjSru5kbBYrjNjkH4ZhZ+h4q7qOfWZcIO/xRnoTlnwkbylexg==
X-Gm-Gg: ASbGncuwVwU9vAgqkLCsBZMTx/JThmNGLqM+fvAC2Nq5SIziuzf1PDXMTIBLLffKkAX
	SrcqNaCXTU5b+d74r8K5kj+oZUqJb1YJCzKmQElzE59AgOhJJOWQH4YPmx9LMMEu+PjV2Ft6b+o
	W27dG66Q0mWihuygiwDz29nNPydXFhUU1rlSoBV5QDXuHauvGf+JEPXVpPtQYGP6qvHamPcNqj3
	lGN55tXgvyJ3FqUMMqHIumUYum7FUnJWlOw0WM8hYvmY32IlGz/2lIMz52S48RS24oAL6uwYdrn
	5LlYHU3BMFOHG1qjRrQF2yLJ3GGPzetUnrGx6kCLfSSZrfcN5qh74KHgGEONnLaovxCFie04Am1
	vJOq8aj8OIbr9JM9naARDFLRG+DGOUnbxUdIfzLzaK7NBvy5fw0Nv
X-Google-Smtp-Source: AGHT+IGXBiC+ewZA3rAyvv2Ke6hJI+tnwzkx3Up6zV7Wq1NWEiWboc3F8qKz1bUh4D4yk1/M3aYqxQ==
X-Received: by 2002:a05:6000:2889:b0:3b7:9929:871c with SMTP id ffacd0b85a97d-3e765a2dd74mr5862462f8f.37.1757792016757;
        Sat, 13 Sep 2025 12:33:36 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7ff9f77c4sm4948753f8f.27.2025.09.13.12.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 12:33:36 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v2 bpf-next 00/13] BPF indirect jumps
Date: Sat, 13 Sep 2025 19:39:09 +0000
Message-Id: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset implements a new type of map, instruction set, and uses
it to build support for indirect branches in BPF (on x86). (The same
map will be later used to provide support for indirect calls and static
keys.) See [1], [2] for more context.

Short table of contents:

  * Patches 1-6 implement the new map of type
    BPF_MAP_TYPE_INSN_SET and corresponding selftests. This map can
    be used to track the "original -> xlated -> jitted mapping" for
    a given program. Patches 5,6 add support for "blinded" variant.

  * Patches 7,8,9 implement the support for indirect jumps

  * Patches 10--13 add support for LLVM-compiled programs containing
    indirect jumps.

A special LLVM should be used for that, see [3] for the details and
some related discussions. Due to this fact, selftests for indirect
jumps which directly use `goto *rX` are commented out (such that
CI can run). Due to this fact, I've run test_progs compiled with
indirect jumps as described in [4] (in brief, all tests which
normally pass on my setup, pass with indirect jumps).

There is a list of TBDs (mostly, more selftests), but the list of
changes looks big enough to send the v2.

See individual patches for more details on the implementation details.

v1 -> v2:

  * push_stack changes:
    * sanitize_speculative_path should just return int (Eduard)
    * return code from sanitize_speculative_path, not EFAULT (Eduard)
    * when BPF_COMPLEXITY_LIMIT_JMP_SEQ is reached, return E2BIG (Eduard)

  * indirect jumps:
    * omit support for .imm=fd in gotox, as we're not using it for now (Eduard)
    * struct jt -> struct bpf_iarray (Eduard)
    * insn_successors: rewrite the interface to just return a pointer (Eduard)
    * remove min_index/max_index, use umin_value/umax_value instead (Alexei, Eduard)
    * move emit_indirect_jump args change to the previous patch (Eduard)
    * add a comment to map_mem_size() (Eduard)
    * use verifier_bug for some error cases in check_indirect_jump (Eduard)
    * clear_insn_aux_data: use start,len instead of start,end (Eduard)
    * make regs[insn->dst_reg].type = PTR_TO_INSN part of check_mem_access (Eduard)

  * constant blinding changes:
    * make subprog_start adjustment better readable (Eduard)
    * do not set subprog len, it is already set (Eduard)

  * libbpf:
    * remove check that relocations from .rodata are ok (Anton)
    * do not freeze the map, it is not necessary anymore (Anton)
    * rename the goto_x -> gotox everywhere (Anton)
    * use u64 when parsing LLVM jump tables (Eduard)
    * split patch in two due to spaces->tabs change (Eduard)
    * split bpftool changes to bpftool patch (Andrii)
    * make sym_size it a union with ext_idx (Andrii)
    * properly copy/free the jumptables_data section from elf (Andrii)
    * a few cosmetic changes around create_jt_map (Andrii)
    * fix some comments + rewrite patch description (Andrii)
    * inline bpf_prog__append_subprog_offsets (Andrii)
    * subprog_sec_offst -> subprog_sec_off (Andrii)
    * !strcmp -> strcmp() == 0 (Andrii)
    * make some function names more readable (Andrii)
    * allocate table of subfunc offsets via libbpf_reallocarray (Andrii)

  * selftests:
    * squash insn_array* tests together (Anton)

  * fixed build warnings (kernel test robot)

RFC -> v1:

  * I've tried to address all the comments provided by Alexei and
    Eduard in RFC. Will try to list the most important of them below.
  * One big change: move from older LLVM version [5] to newer [4].
    Now LLVM generates jump tables as symbols in the new special
    section ".jumptables". Another part of this change is that
    libbpf now doesn't try to link map load and goto *rX, as
    1) this is absolutely not reliable 2) for some use cases this
    is impossible (namely, when more than one jump table can be used
    in the same gotox instruction).
  * Added insn_successors() support (Alexei, Eduard). This includes
    getting rid of the ugly bpf_insn_set_iter_xlated_offset()
    interface (Eduard).
  * Removed hack for the unreachable instruction, as new LLVM thank to
    Eduard doesn't generate it.
  * Set mem_size for direct map access properly instead of hacking.
    Remove off>0 check. (Alexei)
  * Do not allocate new memory for min_index/max_index (Alexei, Eduard)
  * Information required during check_cfg is now cached to be reused
    later (Alexei + general logic for supporting multiple JT per jump)
  * Properly compare registers in regsafe (Alexei, Eduard)
  * Remove support for JMP32 (Eduard)
  * Better checks in adjust_ptr_min_max_vals (Eduard)
  * More selftests were added (but still there's room for more) which
    directly use gotox (Alexei)
  * More checks and verbose messages added
  * "unique pointers" are no more in the map

Links:
  1. https://lpc.events/event/18/contributions/1941/
  2. https://lwn.net/Articles/1017439/
  3. https://github.com/llvm/llvm-project/pull/149715
  4. https://github.com/llvm/llvm-project/pull/149715#issuecomment-3274833753
  5. v1: https://lore.kernel.org/bpf/20250816180631.952085-1-a.s.protopopov@gmail.com/
  6. rfc: https://lore.kernel.org/bpf/20250615085943.3871208-1-a.s.protopopov@gmail.com/

Anton Protopopov (13):
  bpf: fix the return value of push_stack
  bpf: save the start of functions in bpf_prog_aux
  bpf, x86: add new map type: instructions array
  selftests/bpf: add selftests for new insn_array map
  bpf: support instructions arrays with constants blinding
  selftests/bpf: test instructions arrays with blinding
  bpf, x86: allow indirect jumps to r8...r15
  bpf, x86: add support for indirect jumps
  bpf: disasm: add support for BPF_JMP|BPF_JA|BPF_X
  libbpf: fix formatting of bpf_object__append_subprog_code
  libbpf: support llvm-generated indirect jumps
  bpftool: Recognize insn_array map type
  selftests/bpf: add selftests for indirect jumps

 arch/x86/net/bpf_jit_comp.c                   |  39 +-
 include/linux/bpf.h                           |  30 +
 include/linux/bpf_types.h                     |   1 +
 include/linux/bpf_verifier.h                  |  17 +
 include/uapi/linux/bpf.h                      |  11 +
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/bpf_insn_array.c                   | 350 ++++++++++
 kernel/bpf/core.c                             |  21 +
 kernel/bpf/disasm.c                           |   9 +
 kernel/bpf/log.c                              |   1 +
 kernel/bpf/syscall.c                          |  22 +
 kernel/bpf/verifier.c                         | 646 ++++++++++++++++--
 .../bpf/bpftool/Documentation/bpftool-map.rst |   2 +-
 tools/bpf/bpftool/map.c                       |   2 +-
 tools/include/uapi/linux/bpf.h                |  11 +
 tools/lib/bpf/libbpf.c                        | 192 +++++-
 tools/lib/bpf/libbpf_probes.c                 |   4 +
 tools/lib/bpf/linker.c                        |  10 +-
 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../selftests/bpf/prog_tests/bpf_gotox.c      | 132 ++++
 .../selftests/bpf/prog_tests/bpf_insn_array.c | 497 ++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_gotox.c | 384 +++++++++++
 22 files changed, 2277 insertions(+), 110 deletions(-)
 create mode 100644 kernel/bpf/bpf_insn_array.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_gotox.c

-- 
2.34.1


