Return-Path: <bpf+bounces-70009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DB0BAC8CC
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 12:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E082A189D8C0
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 10:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFD22F7ACE;
	Tue, 30 Sep 2025 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTWrTkYT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31C71F5820
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759229388; cv=none; b=LEfwLKF+ASRKda5Bj3x+veyNND1sv4KfnR4SZ3gcSAQJ4y/8ucSxMfuySJapNTVFRrMLTE+K6tQZOZJmqeXTh9hAovVLaNYCmyuoKWdZCpeOG3qo1OZmrIbTGJJg78nrX1nAgiZge8He7vCs0CaOFiRYbd5T+qG6uBpLwoLi02g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759229388; c=relaxed/simple;
	bh=sgywMiKXLH2D9fgSBYZJpcNxegOBPaaPUYsMCesvCqE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=neNRhBxQZjdcZfDcoTMj5lYJE7vxydKkLXbjHB+g+1HKkiSqLGE7LotImZJwfeN37Wzpppjkx/WH5vX3cZA4wrdTqXHE7z1lNTO4ZjyPxXPF5txVBrNgMfkBJZsYj1RmeimK+InCJABsR6tFZQ+8QqK4o2MJ1VCmDNZkYB0uk9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTWrTkYT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e2826d5c6so43966265e9.1
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 03:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759229385; x=1759834185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rndqic6w25eSXszKVUtmgI8XuyrchFYVRZXfsoOhzV4=;
        b=hTWrTkYT5eNzQbEk6ViefWLugYnvcjeApZ8BnMB3AFu4xb/USucGSy3ILdghT4nzpm
         KOf96c8eex3J6f5MPXFKbDYDNZt0VXQSsDT+UMhhScMIVU7umETp818v/N3jgNl1+5BP
         K6RsfKDdgDEbDjzd0Nhdrt/PVMzQlz98EAF+/mh8RjUvzCwQ2Q+j81XS7xMt7Wv+eiF2
         bJg0VuEA2ym1k/5+nABKUpH4OcKa1QYzYeqWbQ2ob48P3+x5ZsRSQ+bCdQtDnjTAG1FH
         2Yvw6gE/wD2HsrwplsJbGvn7sCSyKcKWvhcJdZ6jOrCLjhBRLmzT3oc3k4s19sw5zvc3
         OCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759229385; x=1759834185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rndqic6w25eSXszKVUtmgI8XuyrchFYVRZXfsoOhzV4=;
        b=mE+lQziChO1si18xrlxtOr13tl7tWAGS5FFOpXxATITivRsTftExircF127JDzhE5r
         d23HjUN7SjwNrF/Y5+ZSHSrHxHcAoV2tt14uJdiKb7e5vC758onjLPq8AIbuWkO9/dN0
         BDXUOKVnNk3lyM/p620anZLbTpIjWEEHzduhli8ZyHztW8+S0aKg2i4lSZC6ghdg+iqu
         t2M//lSEB34AXSxtDoX6sSMEOy6DcOE8c3ssuCG1iniDSbUaZast1gzHMFx9h0jgd+GP
         TVIV/MxjzCw9yVOl65tj51LQWK7jwdnrYMwpUrZloRJRr+hbNYt9WNMDk8XOjY/jXldU
         p1Lg==
X-Gm-Message-State: AOJu0YxecdJlmSbTSNOJnqild+nGVbVxOWJkj9Ta1h2bHKHX07mKLFzU
	Ks88JA1RqkoPLxCNd1c8NdCheECfD2xAAOMlX0f+h7y25cF9scpR8uHMit3S7Q==
X-Gm-Gg: ASbGncv+hxZyudTsJQg4CiphKoS90u82iWkbYyMPed9JuOi9S8ArMlWgZfo93fAJE0J
	EB8zl23lGjkUwx/nelA9Hnb7nQ5PxqJhE17MuB7uUN79poNU+CsSNv3dP9nWFsKwN+XYYZdvLpI
	+vMIURNGyB76C4v+2JxM0ZOobVg9IuMjtYs7AkkY5HNcMAJw8V8qYdov+6wQAcDzz32faDPADN5
	3JZyizq13k/fM7ajwB4HMe89ZVhHb+S120gLe4wBxncbjXn7vYtiZdRhsxWJkxtSiSikD+C43jH
	4WOoUJ8tnPad8D+VxhB5MROVgqjVzIxUd/VHm43jeILgB2wBfuun1argwTCqh0LpwLueJ0r1LSf
	2wlNzy3S//zx+0DvR/9B0oWiT/OMWvuwHU0z3WCR7EFdcOaOEru5zWx+rqKTzgD5l3Q==
X-Google-Smtp-Source: AGHT+IHzsCKP/+EcD3XGQw3RUIFCyDjpxfY/wsiCXUnoDErQPMp1H4bkbORUhTgGz+Jb0cspZEuEhQ==
X-Received: by 2002:a05:600c:4743:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-46e33b2ca06mr161420415e9.32.1759229384374;
        Tue, 30 Sep 2025 03:49:44 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602dfdsm21982161f8f.33.2025.09.30.03.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 03:49:43 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 00/15] BPF indirect jumps
Date: Tue, 30 Sep 2025 10:55:08 +0000
Message-Id: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
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

  * Patches 8,9,10,11 implement the support for indirect jumps

  * Patches 12,13,14,15 add support for LLVM-compiled programs
    containing indirect jumps.

Since the v3 the jump table support was merged to LLVM and now can be
enabled with v4. See [3] for the PR which added the support.

There is still a list of TBDs for selftests, mainly, to test all the error
conditions introduce by the patch "bpf, x86: add support for indirect jumps"
in a new "verifier_indirect_jumps" style, but I wanted to see the kernel side
calming down before doing this.

See individual patches for more details on the implementation details.

v3 -> v4 (this series):

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

Anton Protopopov (15):
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
  libbpf: fix formatting of bpf_object__append_subprog_code
  libbpf: support llvm-generated indirect jumps
  bpftool: Recognize insn_array map type
  selftests/bpf: add selftests for indirect jumps

 arch/x86/net/bpf_jit_comp.c                   |  39 +-
 include/linux/bpf.h                           |  46 ++
 include/linux/bpf_types.h                     |   1 +
 include/linux/bpf_verifier.h                  |  27 +-
 include/uapi/linux/bpf.h                      |  11 +
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/arraymap.c                         |  19 +-
 kernel/bpf/bpf_insn_array.c                   | 300 +++++++++
 kernel/bpf/core.c                             |  21 +
 kernel/bpf/disasm.c                           |   9 +
 kernel/bpf/liveness.c                         |  39 +-
 kernel/bpf/log.c                              |   1 +
 kernel/bpf/syscall.c                          |  22 +
 kernel/bpf/verifier.c                         | 596 ++++++++++++++++--
 .../bpf/bpftool/Documentation/bpftool-map.rst |   3 +-
 tools/bpf/bpftool/map.c                       |   3 +-
 tools/include/uapi/linux/bpf.h                |  11 +
 tools/lib/bpf/libbpf.c                        | 263 +++++++-
 tools/lib/bpf/libbpf_probes.c                 |   4 +
 tools/lib/bpf/linker.c                        |  10 +-
 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../selftests/bpf/prog_tests/bpf_gotox.c      | 177 ++++++
 .../selftests/bpf/prog_tests/bpf_insn_array.c | 574 +++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_gotox.c | 411 ++++++++++++
 24 files changed, 2466 insertions(+), 127 deletions(-)
 create mode 100644 kernel/bpf/bpf_insn_array.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_gotox.c

-- 
2.34.1


