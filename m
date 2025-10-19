Return-Path: <bpf+bounces-71315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A51BEEBF7
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 22:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988033A2BD7
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 20:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D695A1EF38E;
	Sun, 19 Oct 2025 20:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqNkiLLd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EE915D1
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 20:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760904928; cv=none; b=c+C9rC0ZaGdd1FOWoGWEgLZnzbQ760UwJKh5WbhS0amMjx+TMQ1xSybnMyd7ReizCyY8cTTALZWJT1DeU+jWlo3IUcXqFdNy/yX39GlYmjLaBpZXxC6gk0d+BvgvmKiT7E2riUHrgkyRd59QdIjmKB5YhEhqIVHm+x6Yyx54AOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760904928; c=relaxed/simple;
	bh=HNOUvs+S7DiA3AfMtgaKlhhh7Vx/TGjAl2swPbS7WKs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rAq/siYRxrLJCciHzWXPgwwGxRuK/ukzOQHILYg4xBa3rBNIl7VbBSwapq6O4UrE2PydUfyFw73mXzb1xVkbKErPnTx2E87pJtrdzUksSbZS6I2WowHGAov7wZ+R7my50IJqDOuOAdXea1612d6ruwntDlggv05WSLSSCDcDM/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqNkiLLd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47112a73785so27398995e9.3
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 13:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760904924; x=1761509724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a7qSHqAwwaoadRcXzKOYZAdhklV4kzHwm8pLa+8gTTs=;
        b=dqNkiLLdYPNB4iPZH2PCCIplA17KCXARg0+9/ofSa4sc1390DpKfVVR39GfUeY5pVr
         DtDOW9+IOj6Z80ZlMLGFysaxdLRKAxtqGCl2UOeLMSeUWSe+mO3G1R51Zdpc+1gXQvWo
         URy1cJ4ukOPRp+sBKzMkmZJayDdLNiOSS5LXIKGu00cIrPK7SJxGgnwpULvaf1r+cA9b
         8qWxIV1SSJbPkW9Fj8RXoCZvm/xsJwxEKKKr01+068tsxtYpora/mNmkQ0jDT2bKz9VJ
         sppxx1s5TeM8AMkOk7YfnzG4vmSY9OrFlyzAagiDz+vhfnz1ul+c7rxhzenCTWOfeLl4
         +gtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760904924; x=1761509724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7qSHqAwwaoadRcXzKOYZAdhklV4kzHwm8pLa+8gTTs=;
        b=CgcOAxCJnHDAIDwb9RKvKFRAiGO26HQxq95026+Rc+v1UwEvJmJ2BXmNEntjoXC72x
         UkAOtcTI53mGy2PgYNXmo3ZP0R5MvdXYIos6N04nrMSmW+zDL0n2VeDehJ/ePh8mRHZr
         3St4WT3Z3L4ClRaG+2V8l6fKmjXjY83HC3pQ6Dh5FKE4LXR83yzlINjRtmUqHGlKuTMh
         U6WgLxKuyEpoZ/OZ8iTqG+0EbspufQtCrru3R/dsztuHnhXmrVPmEYsGDdo/JKUGFSXz
         QsiIE6HTKC+LKLAYo/CssV4wX9ibhO5ESLujQgCc2KX7JV+IuNvlBAt+HMJQvVTsseio
         Amew==
X-Gm-Message-State: AOJu0YwR0B8IYp56gUNW1XGDOdTjVpko95Uc4Wh8iQCzpwa+3tTXPWEP
	yTuWow+ubXm41i1HEIszQMFJDxm0YDesHJllYt/Z6lyYryL/SJ6mBHvnBuHrwQ==
X-Gm-Gg: ASbGncvsfk8mssA6FOcaiZ6Stpb92PbN+c4uipABB76PcQJI1sONHDTWSXAMPEMqfLa
	3mniyCk02rtkdKCKEbIKcQeBOdj8+unflJT9IEHphYJy9ISFkm7XSxU5eD6BgctIVm+pm4oyulw
	slcA9yx4AYWhAM32vysE3V8stnlgi+Yx9MiH4VcWMHGkx5a/SU+7gAtBEtLd2vWQ+umREZPJ7k+
	7ATThIzWcZTdOF8ctgCSdz7QzVv6xrjmN1jhXPqUbidVqXwZzu9knBPi+hGyDGjfG8NKySUaC/X
	KI/oKF8RpiWHSD1bSNpI++dwClWdIEYQ1i9QZnETkvqfddIadAD4ncIKqaRgOTEbNoX2vGLp3NR
	XYXKuyja9BorRd0JG1hZIJObEP92IUgwYLgMJpMvOjml65/XewjXLIGv0k96CrLWBp1VE+gPhPN
	yX1fpyC6gdNI3Q9LXixWxKH6xiejNg4Q==
X-Google-Smtp-Source: AGHT+IG6QUZMhvYc5E5Kkia5zf8xtIuWNwmcuvzYcnbNnGPvpghSBkw4ebuss5cjU+Nzb8DnVnLbcg==
X-Received: by 2002:a05:600c:548a:b0:46f:b42e:edce with SMTP id 5b1f17b1804b1-47117925db7mr72964655e9.39.1760904923976;
        Sun, 19 Oct 2025 13:15:23 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c831asm190460105e9.13.2025.10.19.13.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 13:15:23 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 00/17] BPF indirect jumps
Date: Sun, 19 Oct 2025 20:21:28 +0000
Message-Id: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
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

  * Patches 1-7 implement the new map of type
    BPF_MAP_TYPE_INSN_SET and corresponding selftests. This map can
    be used to track the "original -> xlated -> jitted mapping" for
    a given program. Patches 6,7 add support for "blinded" variant.

  * Patches 8-12 implement the support for indirect jumps

  * Patches 13-17 add support for LLVM-compiled programs
    containing indirect jumps and selftests.

Since the v3 the jump table support was merged to LLVM and now can be
enabled with -mcpu=v4. See [3] for the PR which added the support.
The selftests, however, don't use LLVM for now: the verifier_gotox
is implemented in asm, and bpf_gotox is actually turned off, as
CI only runs with LLVM 20, and the indirect jumps are supported
starting from 22.

See individual patches for more details on the implementation details.

v5 -> v6 (this series):

  * instruction arrays:
    * better document `struct bpf_insn_array_value` (Eduard)
    * remove a condition in `bpf_insn_array_adjust_after_remove` (Eduard)
    * make userspace see original, xlated, and jitted indexes (+original) (Eduard)

  * indirect jumps, kernel:
    * reject writes to the map
    * reject unaligned ops
    * add a check what `w` is not outside the program in check_config for `gotox` (Eduard)
    * do not introduce unneeded `bpf_find_containing_subprog_idx`
    * simplify error processing for `bpf_find_containing_subprog` (Eduard)
    * add `insn_state |= DISCOVERED` when it's discovered (Eduard)
    * support SUB operations on PTR_TO_INSN (Eduard)
    * make `gotox_tmp_buf` a bpf_iarray and use helper to relocate it (Eduard)
    * rename fields of `bpf_iarray` to more generic (Eduard)
    * re-implement `visit_gotox_insn` in a loop (Eduard)
    * some minor cleanups (Eduard)

  * libbpf:
    * `struct reloc_desc`: add a comment about `union` (Eduard)
    * rename parameters of (and one other place in code) `{create,add}_jt_map` to `sym_off` (Eduard)
    * `create_jt_map`: check that size/off are 8-byte aligned (Eduard)

  * Selftests:
    * instruction array selftests:
      * only run tests on x86_64
      * write a more generic function to test things to reduce code (Eduard)
      * errno wasn't used in checks, so don't reset it (Eduard)
      * print `i`, `xlated_off` and `map_out[i]` here (Eduard)
    * added `verifier_gotox` selftests which do not depend on LLVM:
    * disabled `bpf_gotox` tests by default

  * other changes:
    * remove an extra function in bpf disasm (Eduard)
    * some minor cleanups in the insn_successors patch (Eduard)
    * update documentation in `Documentation/bpf/linux-notes.html` about jumps, now it is supported :)

v3 -> v4 -> v5 (https://lore.kernel.org/bpf/20250930125111.1269861-1-a.s.protopopov@gmail.com/):

  * [v4 -> v5] rebased on top of the last bpf-next/master

  * instruction arrays:
    * add copyright (Alexei)
    * remove mutexes, add frozen back (Alexei)
    * setup 1:1 prog-map correspondence using atomic_xchg
    * do not copy/paste array_map_get_next_key, add a common helper (Alexei)
    * misc minor code cleanups (Alexei)

  * indirect jumps, kernel side:
    * remove jt_allocated, just check if insn is gotox (Eduard)
    * use copy_register_state instead of individual copies (Eduard)
    * in push_stack is_speculative should be inherited (Eduard)
    * a few cleanups for insn_successors, including omitting error path (Eduard)
    * check if reserved fields are used when considering `gotox` instruction (Eduard)
    * read size and alignment of read from insn_array should be 8 (Eduard)
    * put buffer for sorting in subfun info and realloc to grow as needed (Eduard)
    * properly do `jump_point` / `prune_point` from `push_gotox_edge` (Eduard)
    * use range_within to check states (Eduard)
    * some minor cleanups and fix commit message (Eduard)

  * indirect jumps, libbpf side:
    * close map_fd in some error paths in create_jt_map (Andrii)
    * maps for jump tables are actually not closed at all, fix this (Andrii)
    * rename map from `jt` to `.jumptables` (Andrii)
    * use `errstr` in an error message (Andrii)
    * rephrase error message to look more standard (Andrii)
    * misc other minor renames and cleanups (Andrii)

  * selftests:
    * add the frozen selftest back
    * add a selftest for two jumps loading same table

  * some other changes:
    * rebase and split insn_successor changes into separate patch
    * use PTR_ERR_OR_ZERO in the push stack patch (Eduard)
    * indirect jumps on x86: properly re-read *pprog (Eduard)

v2 -> v3 (https://lore.kernel.org/bpf/20250918093850.455051-1-a.s.protopopov@gmail.com/):

  * fix build failure when CONFIG_BPF_SYSCALL is not set (kbuild-bot)
  * reformat bpftool help messages (Quentin)

v1 -> v2 (https://lore.kernel.org/bpf/20250913193922.1910480-1-a.s.protopopov@gmail.com/):

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

RFC -> v1 (https://lore.kernel.org/bpf/20250816180631.952085-1-a.s.protopopov@gmail.com/):

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
  6. rfc: https://lore.kernel.org/bpf/20250615085943.3871208-1-a.s.protopopov@gmail.com/

Anton Protopopov (17):
  bpf: fix the return value of push_stack
  bpf: save the start of functions in bpf_prog_aux
  bpf: generalize and export map_get_next_key for arrays
  bpf, x86: add new map type: instructions array
  selftests/bpf: add selftests for new insn_array map
  bpf: support instructions arrays with constants blinding
  selftests/bpf: test instructions arrays with blinding
  bpf, x86: allow indirect jumps to r8...r15
  bpf: make bpf_insn_successors to return a pointer
  bpf, x86: add support for indirect jumps
  bpf: disasm: add support for BPF_JMP|BPF_JA|BPF_X
  bpf, docs: do not state that indirect jumps are not supported
  libbpf: fix formatting of bpf_object__append_subprog_code
  libbpf: support llvm-generated indirect jumps
  bpftool: Recognize insn_array map type
  selftests/bpf: add new verifier_gotox test
  selftests/bpf: add C-level selftests for indirect jumps

 Documentation/bpf/linux-notes.rst             |   8 -
 arch/x86/net/bpf_jit_comp.c                   |  39 +-
 include/linux/bpf.h                           |  44 ++
 include/linux/bpf_types.h                     |   1 +
 include/linux/bpf_verifier.h                  |  23 +-
 include/uapi/linux/bpf.h                      |  21 +
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/arraymap.c                         |  19 +-
 kernel/bpf/bpf_insn_array.c                   | 303 ++++++++++
 kernel/bpf/core.c                             |  21 +
 kernel/bpf/disasm.c                           |   3 +
 kernel/bpf/liveness.c                         |  39 +-
 kernel/bpf/log.c                              |   1 +
 kernel/bpf/syscall.c                          |  22 +
 kernel/bpf/verifier.c                         | 556 +++++++++++++++---
 .../bpf/bpftool/Documentation/bpftool-map.rst |   3 +-
 tools/bpf/bpftool/map.c                       |   3 +-
 tools/include/uapi/linux/bpf.h                |  21 +
 tools/lib/bpf/libbpf.c                        | 282 ++++++++-
 tools/lib/bpf/libbpf_probes.c                 |   4 +
 tools/lib/bpf/linker.c                        |  10 +-
 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../selftests/bpf/prog_tests/bpf_gotox.c      | 185 ++++++
 .../selftests/bpf/prog_tests/bpf_insn_array.c | 492 ++++++++++++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/bpf_gotox.c | 414 +++++++++++++
 .../selftests/bpf/progs/verifier_gotox.c      | 277 +++++++++
 27 files changed, 2667 insertions(+), 132 deletions(-)
 create mode 100644 kernel/bpf/bpf_insn_array.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_gotox.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_gotox.c

-- 
2.34.1


