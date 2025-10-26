Return-Path: <bpf+bounces-72257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CF1C0B10C
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4ECE189E46E
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 19:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434EB2FD69D;
	Sun, 26 Oct 2025 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQf1gePn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC0F2877E7
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 19:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761506442; cv=none; b=pZyp8A87oQ+LrdkFoNsJPhmn7MBpttQDnRfGJvtEjy0lHcvB30QtTr9LR0ef+d9sPzBuKA8EnbGT8QP26/DSV8xLcfn8VZ2m3CRkcTPuOYBTeFZfQcIYTk9LawAEG1XFzo84dZR1MJ4/L0hSfwviVQzsf9HWdPGig/i+5qgh6WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761506442; c=relaxed/simple;
	bh=AVymzC1td7a3AfPVMnWSLrdlq8uF+dbKKH1dgD6wSTE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AeTMKlXFMqI6MR2YQaNVe2mzp0ShFRDzZvErq5ZjvR1NoxNbHOVoqf0rYx1qYC3gzS9JyDTlLVRW56pP1uFFkjlSvj/f2QMNA8rDnSLXv4/a9WG2KQxXzH5l6UnMhnPsEL5l88s9vS9A033p7UabOqfoxgUm/3Iqs8u/s0GGnXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQf1gePn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-475d9de970eso15173325e9.1
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 12:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761506438; x=1762111238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UVwKPYVpDDXkyL1kOYDh0ZnKEt3041jZQMHFlCL7MkI=;
        b=IQf1gePnRiKlxOcVnXh2W2Wy7d4PedEYDgBiYAurpca8b0B/0mofO+jFD6T2sqQvtm
         EzR6Rr7I8SpLEWEhPYqF95oteypGMKMYy8Prsg2NRC6VdUokPBj8TUqLXdufp2YN2DIW
         OTopzR/qinEO9JQf995qs4aJIO/jsWJU5z9wu5dWYmaS98HAfid98mrEZ2xPx+EPnpAN
         VMx89Iwei21XR/3lETupirqWOEKIn3sL5asoQJRuvoNi2Ub189CJwmNvNjeTkyXtgSWV
         YBHP3qgfd+2GLPlld6hqihdhNtMduwa1KNz/BJ3McI3j96FX8lWoe7fkq1lIy6XGMbko
         oR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761506438; x=1762111238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVwKPYVpDDXkyL1kOYDh0ZnKEt3041jZQMHFlCL7MkI=;
        b=OZxLfeE/Fb5ccSbFpbrqsEOfRLf5gO8gRxEGsYCrN8SZVpXgL3DdB8Lpb5GQWg6aUr
         XM+mAn+BM2RK0xdiZ/Oj3i4s2gbJEP+9HU/LU13u9Mrf3E+Q6/yg0JqWugzZxeqlj6H/
         H35EW1OsQM3X3vcrNgNb3Vk0mGkRWZqOfGZQPBmDdbBbRHRiKu5HzVFf53O8lq3j8QDD
         PQHhDeM30j/D+Agbud5HCcJUUGoJ9jPOGzy6VDFMJ1opGJ9FFZ401ACsJehXK5EIdgMy
         8dgX8z/UhcuKrXUMZWHV2W8FqtfAN2+njj9MIGpZwWSpoOfuJJAOhEM3e/2YBIECGtMo
         xsew==
X-Gm-Message-State: AOJu0YyYKhuTWU3EUxtaLn3ZRzyCBg1gyS4nNBFw9dKWpzKlh9CHI9fy
	cUT8r3ZTSmhtqN1WU1ET8EPC7tT9wXyMrMMeR08D1gKONgfigg7nd9/oO+ftRA==
X-Gm-Gg: ASbGncuGm3CEXAS2csNbZM7mhkQLD9F8Ne+0cupywQgNtjpAxTBft+j89Y23BMN/oqa
	LCix/f9J0fbbDTmDHgwlqN8uMboARAmbNjqeHk13y0k9glBhx0wsSbBuHtyXxB5ac06syUau8FY
	GmjilgLOIqr7hZ8frY3JanzD/gChsXmRvjVKaELybtesbT+v9CTR97a/8SXRzbwuQuHcPOEU+os
	sx12W3Q+mfwsMRL6pE2a/QQgmpsIrrZa191I9Gi93hxSrSeH022lr7KLCCyWiynlWfjhpKs7b9k
	tqQSKgHDN3pQblX/C9LdJZkqu/n5xxVSOX9YRPKUwWygIxziuFnCy1Vbfkcj22RIOMke6R27+Xp
	EAyPmPiXjEZu6xvN1e92Tm209raTjDece6wJZbg//3owt/1uj3cM4tZiFU4odyMcRnfyhiOTHLF
	KBfGqgZv6iOj/VCKwPrnA=
X-Google-Smtp-Source: AGHT+IGn6FQH8pxj5r1nYenDQq95gEq9oiBb4nju/WpCKI1A1driS+FAgHxmNnOTiL4OZBP+hd7JuQ==
X-Received: by 2002:a05:600c:6290:b0:471:9b5:6fd3 with SMTP id 5b1f17b1804b1-471177b1291mr265141475e9.0.1761506436818;
        Sun, 26 Oct 2025 12:20:36 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4894c9sm92434375e9.5.2025.10.26.12.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 12:20:36 -0700 (PDT)
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
Subject: [PATCH v7 bpf-next 00/12] BPF indirect jumps
Date: Sun, 26 Oct 2025 19:26:57 +0000
Message-Id: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
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

  * Patches 1-4 implement the new map of type
    BPF_MAP_TYPE_INSN_SET and corresponding selftests. This map can
    be used to track the "original -> xlated -> jitted mapping" for
    a given program. Patches 1,2 implement the main functionality,
    patches 3,4 add support for the "blinded" variant.

  * Patches 5-8 implement the support for indirect jumps on x86

  * Patches 9-12 add libbpf support for LLVM-compiled programs
    containing indirect jumps, and selftests.

Since the v3 the jump table support was merged to LLVM and now can be
enabled with -mcpu=v4. See [3] for the PR which added the support.
The selftests, however, don't use LLVM for now: the verifier_gotox
is implemented in asm, and bpf_gotox is actually turned off, as
CI only runs with LLVM 21, and the indirect jumps are supported
starting from 22.

See individual patches for more details on the implementation details.

v6 -> v7 (this series):

  * rebased and dropped already merged commits

  * instruction arrays
    * use jit_data to find mappings from insn to jit (Alexei)
    * alloc `ips` as part of the main allocation (Eduard)
    * the `jitted_ip` member wasn't actually used (Eduard)
    * remove the bpf_insn_ptr structure, which is not needed for this patch

  * indirect jumps, kernel:
    * fix a memory leak in `create_jt` (AI)
    * use proper reg+8*ereg in `its_static_thunk` (AI)
    * some minor cleanups (Eduard)

  * indirect jumps, libbpf:
    * refactor the `jt_adjust_off()` piece (Edurad)
    * move "JUMPTABLES_SEC" into libbpf_internal.h (Eduard)
    * remove an unnecessary if (Eduard)

  * verifier_gotox: add tests to verify that `gotox rX` works with all registers

v5 -> v6 (https://lore.kernel.org/bpf/20251019202145.3944697-1-a.s.protopopov@gmail.com/T/#u):

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

Anton Protopopov (12):
  bpf, x86: add new map type: instructions array
  selftests/bpf: add selftests for new insn_array map
  bpf: support instructions arrays with constants blinding
  selftests/bpf: test instructions arrays with blinding
  bpf, x86: allow indirect jumps to r8...r15
  bpf, x86: add support for indirect jumps
  bpf: disasm: add support for BPF_JMP|BPF_JA|BPF_X
  bpf, docs: do not state that indirect jumps are not supported
  libbpf: support llvm-generated indirect jumps
  bpftool: Recognize insn_array map type
  selftests/bpf: add new verifier_gotox test
  selftests/bpf: add C-level selftests for indirect jumps

 Documentation/bpf/linux-notes.rst             |   8 -
 arch/x86/net/bpf_jit_comp.c                   |  56 +-
 include/linux/bpf.h                           |  20 +
 include/linux/bpf_types.h                     |   1 +
 include/linux/bpf_verifier.h                  |  11 +
 include/uapi/linux/bpf.h                      |  21 +
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/bpf_insn_array.c                   | 299 +++++++++++
 kernel/bpf/core.c                             |  21 +
 kernel/bpf/disasm.c                           |   3 +
 kernel/bpf/liveness.c                         |   3 +
 kernel/bpf/log.c                              |   1 +
 kernel/bpf/syscall.c                          |  22 +
 kernel/bpf/verifier.c                         | 418 ++++++++++++++-
 .../bpf/bpftool/Documentation/bpftool-map.rst |   3 +-
 tools/bpf/bpftool/map.c                       |   3 +-
 tools/include/uapi/linux/bpf.h                |  21 +
 tools/lib/bpf/libbpf.c                        | 249 ++++++++-
 tools/lib/bpf/libbpf_internal.h               |   4 +
 tools/lib/bpf/libbpf_probes.c                 |   4 +
 tools/lib/bpf/linker.c                        |   9 +-
 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../selftests/bpf/prog_tests/bpf_gotox.c      | 185 +++++++
 .../selftests/bpf/prog_tests/bpf_insn_array.c | 499 ++++++++++++++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/bpf_gotox.c | 402 ++++++++++++++
 .../selftests/bpf/progs/verifier_gotox.c      | 317 +++++++++++
 27 files changed, 2558 insertions(+), 30 deletions(-)
 create mode 100644 kernel/bpf/bpf_insn_array.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_gotox.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_gotox.c

-- 
2.34.1


