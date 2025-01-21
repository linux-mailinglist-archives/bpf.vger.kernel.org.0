Return-Path: <bpf+bounces-49310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5BCA17543
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 01:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FCB3A7F4D
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 00:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A2DC8FF;
	Tue, 21 Jan 2025 00:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeEOx9nX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039C4D2FB;
	Tue, 21 Jan 2025 00:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737419885; cv=none; b=hEqN4nVtnuphk2ovK5fIWf+7byUaF4lUE1Jm/RL6QC1lJ8DCEHHTRx65Gxh2YsSZ9gyBz80uLXOPxPL2nh+ZGjenZgQdgz+jcyJdomYL02cFYqiF8e43tQo+NFbYJQbfDS/91eLLYi4MGS3IYrWBz2aWlfhIqB/4+NAUk+8k+zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737419885; c=relaxed/simple;
	bh=83t7rJAn6knfBKa5QDLMDu6671mJQhYxpE/enj/wJ1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NSKB0Pokt7LF0CVO7bNUlZ8ioviRQtD8W4oxn1gKX7GX1weR9flBOO4ED8j+VPCt4XFFHK7+UQ4dQjpXvUiLk8CuATjwxCFB6crAn5eFpUBamq8DDsknFGt22WWHqXExrQjlntvZp0ycz+BQLenTpgeNGQQefEsI3EKK+4r+0kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeEOx9nX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2161eb95317so90256355ad.1;
        Mon, 20 Jan 2025 16:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737419882; x=1738024682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fGDaB7SQq1nF0sHjYdUobh9qrZqT4fQaCTXTh6azn+0=;
        b=DeEOx9nXu2zeoC4kjTW3uSO9+bI4V83fKMl8T0hetJYuSY2nymIhps+PYu+H6YzA55
         UjQJAmPj3DzFw9yl6zIAvZv3mU2nAwGzZGSELyS3+f4X8aBNQ5rwG4O2Vd3V9LRy4b2V
         lzkbA6ntBZtd2gNLUSvGM6EpAggoYXuX84tZ8DT5Hc+FdZ8jngNN5JXCExDM3o/fV9WY
         cP3rGQZisHSQSNL0vMfccjtrd8h7pKuRsMVjWqbdETIc2ggjStU+NO25gxWJ+l4sXlKd
         24GVseENcxT2dS5CbDTf+rog3RW6ILth8WpIVAC7lAucWlPX1DXaIgYsboTIl1xNhFpR
         7Ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737419882; x=1738024682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fGDaB7SQq1nF0sHjYdUobh9qrZqT4fQaCTXTh6azn+0=;
        b=k//i/En/HVLrfi5/YA+X+YCZjLkMGJdXqAbAbVFXVQ3DftpR/qY7sCdZLPgziKPH6h
         0POrDeRJKO0p+FXKP7a0FLgoemNJgvKC2CTT/n0v80kbwJEYYvFHG2uEJSqtU5C0D9GW
         KwbkHtfL7QIqyIkcV9negeRhnVgpF3gnuo0OX1fhdzaJSOa0u3gP+RQgNxA1uvHVVZGF
         jjXNq30+g3RgPLNDACxqJfIharOVGIKFXKp1BadWCcBfqmoIIaCIx8iP1qPn4Y7a9ka8
         3Dmwh2+oCWVXpnXx+Sq/M61shgpCYwkHZRRN7PnvL+dPwQaQbkMef9GdkyDfNDh+66qK
         x5Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVAejpHujfbJmtYymdQMDfHDc89qfC8vJOapc1ZhGY4rHpLnEWr2SZ3nLTwp0I77ir0DlBxh1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIpiPJi+QYivnPJ+QNti6axTVhcSyQ47yjFAXEYvPX7PcMOt9D
	L/YzUN+XDYoUi+YQwY+zfF7W0r+39IqUhXIkZ/fjuzo1C3zYPP2OTdhB3g==
X-Gm-Gg: ASbGnctJ5yYa1KOHPTHzehKdd1rtJSbOIASM/hJImJ+6FxqExdvR/0vCpfyL4zyuDyG
	COvHO5WmrOzoYxM4gpsi+BiScauBaoo1todGh07GXnGfydrC5ggmwoegCQvgKnx6oamcabvCjKe
	Oe3kc+NSgw9ywOu1STuftMMSdPTkwj8f0pkbhRx77ZQeZ3DDQs4w626KyXNR9ds26UNBmrm0v32
	scsVlPHjVnlsQVYgCT68HRoYA+0HMdbxviAHIOHSUYTQxBAe0lX0EoaE4B3pv+LklaS/Iu+yUjZ
	Y9hm/h7oTiXvNFnXuo8AZQ==
X-Google-Smtp-Source: AGHT+IHqmqz5ViEl6ctQkiRyqTTm1TfGoRSXJOkczr1uETwH/kr3lJTrBkoB7cNjP++xzapCLJsCbg==
X-Received: by 2002:a17:902:d2d2:b0:216:2e6d:baac with SMTP id d9443c01a7336-21c3554b4d7mr253336305ad.29.1737419881844;
        Mon, 20 Jan 2025 16:38:01 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:b850])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3a87e4sm67344325ad.111.2025.01.20.16.38.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jan 2025 16:38:01 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] BPF changes for v6.14
Date: Mon, 20 Jan 2025 16:37:55 -0800
Message-Id: <20250121003755.71163-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8:

  Linux 6.13-rc3 (2024-12-15 15:58:23 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.14

for you to fetch changes up to 3f3c2f0cf669ff28b995b3d6b820ab870c2aa9d9:

  Merge branch 'bpf-allow-may_goto-0-instruction' (2025-01-20 09:47:17 -0800)

----------------------------------------------------------------
= Smaller than usual release cycle. The main changes are:
  (there should be no conflicts)

- Prepare selftest to run with GCC-BPF backend (Ihor Solodrai)
  In addition to LLVM-BPF runs the BPF CI now runs GCC-BPF in
  compile only mode. Half of the tests are failing, since
  support for btf_decl_tag is still WIP, but this is a great
  milestone.

- Convert various samples/bpf to selftests/bpf/test_progs format
  (Alexis Lothoré and Bastien Curutchet)

- Teach verifier to recognize that array lookup with constant
  in-range index will always succeed (Daniel Xu)

- Cleanup migrate disable scope in BPF maps (Hou Tao)

- Fix bpf_timer destroy path in PREEMPT_RT (Hou Tao)

- Always use bpf_mem_alloc in bpf_local_storage in PREEMPT_RT
  (Martin KaFai Lau)

- Refactor verifier lock support (Kumar Kartikeya Dwivedi)
  This is a prerequisite for upcoming resilient spin lock.

- Remove excessive 'may_goto +0' instructions in the verifier
  that LLVM leaves when unrolls the loops (Yonghong Song)

- Remove unhelpful bpf_probe_write_user() warning message
  (Marco Elver)

- Add fd_array_cnt attribute for prog_load command
  (Anton Protopopov)
  This is a prerequisite for upcoming support for static_branch.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alastair Robertson (2):
      libbpf: Pull file-opening logic up to top-level functions
      libbpf: Extend linker API to support in-memory ELF files

Alexei Starovoitov (10):
      Merge branch 'selftests-bpf-migrate-test_flow_dissector-sh-to-test_progs'
      Merge branch 'irq-save-restore'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge branch 'bpf-verifier-improve-precision-of-bpf_mul'
      Merge branch 'bpf-allow-bpf_for-bpf_repeat-while-holding-spin'
      Merge branch 'bpf-reduce-the-use-of-migrate_-disable-enable'
      Merge branch 'support-eliding-map-lookup-nullness'
      Merge branch 'free-htab-element-out-of-bucket-lock'
      Merge branch 'bpf-allow-may_goto-0-instruction'

Alexis Lothoré (eBPF Foundation) (15):
      selftests/bpf: add a macro to compare raw memory
      selftests/bpf: use ASSERT_MEMEQ to compare bpf flow keys
      selftests/bpf: replace CHECK calls with ASSERT macros in flow_dissector test
      selftests/bpf: re-split main function into dedicated tests
      selftests/bpf: expose all subtests from flow_dissector
      selftests/bpf: add gre packets testing to flow_dissector
      selftests/bpf: migrate flow_dissector namespace exclusivity test
      selftests/bpf: Enable generic tc actions in selftests config
      selftests/bpf: move ip checksum helper to network helpers
      selftests/bpf: document pseudo-header checksum helpers
      selftests/bpf: use the same udp and tcp headers in tests under test_progs
      selftests/bpf: add network helpers to generate udp checksums
      selftests/bpf: migrate bpf flow dissectors tests to test_progs
      selftests/bpf: remove test_flow_dissector.sh
      selftests/bpf: ensure proper root namespace cleanup when test fail

Andrii Nakryiko (5):
      libbpf: don't adjust USDT semaphore address if .stapsdt.base addr is missing
      Merge branch 'libbpf-extend-linker-api-to-support-in-memory-elf-files'
      Merge branch 'bpftool-btf-support-dumping-a-single-type-from-file'
      Merge branch 'add-fd_array_cnt-attribute-for-bpf_prog_load'
      libbpf: Work around kernel inconsistently stripping '.llvm.' suffix

Anton Protopopov (7):
      bpf: Add a __btf_get_by_fd helper
      bpf: Move map/prog compatibility checks
      bpf: Refactor check_pseudo_btf_id
      bpf: Add fd_array_cnt attribute for prog_load
      libbpf: prog load: Allow to use fd_array_cnt
      selftests/bpf: Add tests for fd_array_cnt
      selftest/bpf: Replace magic constants by macros

Ariel Otilibili (1):
      selftests/bpf: Clear out Python syntax warnings

Bastien Curutchet (eBPF Foundation) (3):
      selftests/bpf: test_xdp_redirect: Rename BPF sections
      selftests/bpf: Migrate test_xdp_redirect.sh to xdp_do_redirect.c
      selftests/bpf: Migrate test_xdp_redirect.c to test_xdp_do_redirect.c

Ben Olson (1):
      libbpf: Improve debug message when the base BTF cannot be found

Christoph Werle (1):
      bpftool: Fix control flow graph segfault during edge creation

Christophe Leroy (1):
      bpf/tests: Add 32 bits only long conditional jump tests

Daniel Xu (11):
      bpftool: man: Add missing format argument to command description
      bpftool: btf: Validate root_type_ids early
      bpftool: btf: Support dumping a specific types from file
      bpftool: bash: Add bash completion for root_id argument
      libbpf: Set MFD_NOEXEC_SEAL when creating memfd
      veristat: Document verifier log dumping capability
      bpf: verifier: Add missing newline on verbose() call
      bpf: tcp: Mark bpf_load_hdr_opt() arg2 as read-write
      bpf: verifier: Refactor helper access type tracking
      bpf: verifier: Support eliding map lookup nullness
      bpf: selftests: verifier: Add nullness elision tests

Eduard Zingerman (3):
      samples/bpf: Pass TPROGS_USER_CFLAGS to libbpf makefile
      selftests/bpf: make BPF_TARGET_ENDIAN non-recursive to speed up *.bpf.o build
      veristat: Load struct_ops programs only once

Emil Tsalapatis (2):
      bpf: Allow bpf_for/bpf_repeat calls while holding a spinlock
      selftests/bpf: test bpf_for within spin lock section

Hou Tao (21):
      bpf: Remove migrate_{disable|enable} from LPM trie
      bpf: Remove migrate_{disable|enable} in ->map_for_each_callback
      bpf: Remove migrate_{disable|enable} in htab_elem_free
      bpf: Remove migrate_{disable|enable} from bpf_cgrp_storage_lock helpers
      bpf: Remove migrate_{disable|enable} from bpf_task_storage_lock helpers
      bpf: Disable migration when destroying inode storage
      bpf: Disable migration when destroying sock storage
      bpf: Disable migration when cloning sock storage
      bpf: Disable migration in bpf_selem_free_rcu
      bpf: Disable migration before calling ops->map_free()
      bpf: Remove migrate_{disable|enable} in bpf_obj_free_fields()
      bpf: Remove migrate_{disable,enable} in bpf_cpumask_release()
      bpf: Remove migrate_{disable|enable} from bpf_selem_alloc()
      bpf: Remove migrate_{disable|enable} from bpf_local_storage_alloc()
      bpf: Remove migrate_{disable|enable} from bpf_local_storage_free()
      bpf: Remove migrate_{disable|enable} from bpf_selem_free()
      bpf: Free special fields after unlock in htab_lru_map_delete_node()
      bpf: Bail out early in __htab_map_lookup_and_delete_elem()
      bpf: Free element after unlock in __htab_map_lookup_and_delete_elem()
      bpf: Cancel the running bpf_timer through kworker for PREEMPT_RT
      selftests/bpf: Add test case for the freeing of bpf_timer

Ihor Solodrai (2):
      selftests/bpf: add -fno-strict-aliasing to BPF_CFLAGS
      selftests/bpf: add -std=gnu11 to BPF_CFLAGS and CFLAGS

Jiayuan Chen (1):
      selftests/bpf: Avoid generating untracked files when running bpf selftests

Jiri Olsa (2):
      bpf: Return error for missed kprobe multi bpf program execution
      selftests/bpf: Add kprobe session recursion check test

Kumar Kartikeya Dwivedi (7):
      bpf: Consolidate locks and reference state in verifier state
      bpf: Refactor {acquire,release}_reference_state
      bpf: Refactor mark_{dynptr,iter}_read
      bpf: Introduce support for bpf_local_irq_{save,restore}
      bpf: Improve verifier log for resource leak on exit
      selftests/bpf: Expand coverage of preempt tests to sleepable kfunc
      selftests/bpf: Add IRQ save/restore tests

Lorenzo Pieralisi (1):
      bpf: Remove unused MT_ENTRY define

Mahe Tardy (3):
      bpf: fix cgroup_skb prog test run direct packet access
      selftests/bpf: add cgroup skb direct packet access test
      selftests/bpf: fix veristat comp mode with new stats

Marco Elver (2):
      bpf: Remove bpf_probe_write_user() warning message
      bpf: Refactor bpf_tracing_func_proto() and remove bpf_get_probe_write_proto()

Marco Leogrande (1):
      tools/testing/selftests/bpf/test_tc_tunnel.sh: Fix wait for server bind

Martin KaFai Lau (3):
      bpf: bpf_local_storage: Always use bpf_mem_alloc in PREEMPT_RT
      bpf: Reject struct_ops registration that uses module ptr and the module btf_id is missing
      Merge branch 'selftests-bpf-migrate-test_xdp_redirect-sh-to-test_progs'

Matan Shachnai (2):
      bpf, verifier: Improve precision of BPF_MUL
      selftests/bpf: Add testcases for BPF_MUL

Mykyta Yatsenko (3):
      selftests/bpf: Add more stats into veristat
      veristat: Fix top source line stat collection
      selftests/bpf: Handle prog/attach type comparison in veristat

Pei Xiao (1):
      bpf: Use refcount_t instead of atomic_t for mmap_count

Peilin Ye (3):
      bpf, arm64: Simplify if logic in emit_lse_atomic()
      bpf, arm64: Factor out emit_a64_add_i()
      bpf, arm64: Emit A64_{ADD,SUB}_I when possible in emit_{lse,ll_sc}_atomic()

Pu Lehui (5):
      bpf: Move out synchronize_rcu_tasks_trace from mutex CS
      selftests/bpf: Fix btf leak on new btf alloc failure in btf_distill test
      libbpf: Fix return zero when elf_begin failed
      libbpf: Fix incorrect traversal end type ID when marking BTF_IS_EMBEDDED
      selftests/bpf: Add distilled BTF test about marking BTF_IS_EMBEDDED

Puranjay Mohan (1):
      bpf: Send signals asynchronously if !preemptible

Quentin Monnet (1):
      libbpf: Fix segfault due to libelf functions not setting errno

Saket Kumar Bhaskar (2):
      selftests/bpf: Fix fill_link_info selftest on powerpc
      selftests/bpf: Fix test_xdp_adjust_tail_grow2 selftest on powerpc

Simone Magnani (1):
      bpftool: Probe for ISA v4 instruction set extension

Soma Nakata (1):
      bpf: Fix range_tree_set() error handling

Song Liu (1):
      bpf: lsm: Remove hook to bpf_task_storage_free

Thomas Weißschuh (4):
      tools/resolve_btfids: Add --fatal_warnings option
      kbuild/btf: Propagate CONFIG_WERROR to resolve_btfids
      bpf: Fix configuration-dependent BTF function references
      bpf: Fix holes in special_kfunc_list if !CONFIG_NET

Toke Høiland-Jørgensen (1):
      selftests/bpf: Consolidate kernel modules into common directory

Tony Ambardar (1):
      selftests/bpf: Fix undefined UINT_MAX in veristat.c

Vishal Chourasia (1):
      tools: Sync if_xdp.h uapi tooling header

Yonghong Song (5):
      libbpf: Add unique_match option for multi kprobe
      selftests/bpf: Add a test for kprobe multi with unique_match
      bpf: Allow 'may_goto 0' instruction in verifier
      bpf: Remove 'may_goto 0' instruction in opt_remove_nops()
      selftests/bpf: Add some tests related to 'may_goto 0' insns

Zhu Jun (1):
      samples/bpf: Remove unused variable

 arch/arm64/net/bpf_jit_comp.c                      |   48 +-
 include/linux/bpf.h                                |   17 +
 include/linux/bpf_verifier.h                       |   26 +-
 include/linux/btf.h                                |    5 +
 include/uapi/linux/bpf.h                           |   10 +
 kernel/bpf/arena.c                                 |   16 +-
 kernel/bpf/arraymap.c                              |    6 +-
 kernel/bpf/bpf_cgrp_storage.c                      |   15 +-
 kernel/bpf/bpf_inode_storage.c                     |    9 +-
 kernel/bpf/bpf_local_storage.c                     |   38 +-
 kernel/bpf/bpf_struct_ops.c                        |   21 +
 kernel/bpf/bpf_task_storage.c                      |   15 +-
 kernel/bpf/btf.c                                   |   16 +-
 kernel/bpf/cpumask.c                               |    2 -
 kernel/bpf/hashtab.c                               |   79 +-
 kernel/bpf/helpers.c                               |   43 +-
 kernel/bpf/log.c                                   |   21 +-
 kernel/bpf/lpm_trie.c                              |   20 +-
 kernel/bpf/range_tree.c                            |    2 -
 kernel/bpf/syscall.c                               |   12 +-
 kernel/bpf/verifier.c                              | 1178 ++++++++++++++------
 kernel/trace/bpf_trace.c                           |   58 +-
 lib/test_bpf.c                                     |   64 +-
 net/bpf/test_run.c                                 |    1 +
 net/core/bpf_sk_storage.c                          |   11 +-
 net/core/filter.c                                  |    2 +-
 samples/bpf/Makefile                               |    2 +-
 samples/bpf/xdp2skb_meta_kern.c                    |    1 -
 scripts/link-vmlinux.sh                            |    6 +-
 security/bpf/hooks.c                               |    1 -
 tools/bpf/bpftool/Documentation/bpftool-btf.rst    |    9 +-
 tools/bpf/bpftool/bash-completion/bpftool          |    7 +-
 tools/bpf/bpftool/btf.c                            |   51 +-
 tools/bpf/bpftool/cfg.c                            |    1 +
 tools/bpf/bpftool/feature.c                        |   23 +
 tools/bpf/resolve_btfids/main.c                    |   12 +-
 tools/include/linux/filter.h                       |   10 +
 tools/include/uapi/linux/bpf.h                     |   10 +
 tools/include/uapi/linux/if_xdp.h                  |    4 +-
 tools/lib/bpf/bpf.c                                |    3 +-
 tools/lib/bpf/bpf.h                                |    5 +-
 tools/lib/bpf/btf.c                                |    3 +-
 tools/lib/bpf/btf_relocate.c                       |    2 +-
 tools/lib/bpf/libbpf.c                             |   53 +-
 tools/lib/bpf/libbpf.h                             |    9 +-
 tools/lib/bpf/libbpf.map                           |    4 +
 tools/lib/bpf/linker.c                             |  248 +++--
 tools/lib/bpf/usdt.c                               |    2 +-
 tools/testing/selftests/bpf/.gitignore             |    1 -
 tools/testing/selftests/bpf/Makefile               |  113 +-
 .../selftests/bpf/bpf_test_modorder_x/Makefile     |   19 -
 .../selftests/bpf/bpf_test_modorder_y/Makefile     |   19 -
 .../testing/selftests/bpf/bpf_test_no_cfi/Makefile |   19 -
 tools/testing/selftests/bpf/bpf_testmod/Makefile   |   20 -
 tools/testing/selftests/bpf/config                 |    1 +
 tools/testing/selftests/bpf/network_helpers.c      |    2 +-
 tools/testing/selftests/bpf/network_helpers.h      |   96 ++
 .../testing/selftests/bpf/prog_tests/btf_distill.c |   76 +-
 .../prog_tests/cgroup_skb_direct_packet_access.c   |   28 +
 .../testing/selftests/bpf/prog_tests/core_reloc.c  |    2 +-
 tools/testing/selftests/bpf/prog_tests/fd_array.c  |  441 ++++++++
 .../selftests/bpf/prog_tests/fill_link_info.c      |    4 +
 .../selftests/bpf/prog_tests/flow_dissector.c      |  329 ++++--
 .../bpf/prog_tests/flow_dissector_classification.c |  792 +++++++++++++
 .../testing/selftests/bpf/prog_tests/free_timer.c  |  165 +++
 .../selftests/bpf/prog_tests/kprobe_multi_test.c   |   27 +
 tools/testing/selftests/bpf/prog_tests/missed.c    |    1 +
 .../testing/selftests/bpf/prog_tests/sockopt_sk.c  |    2 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |    6 +
 .../selftests/bpf/prog_tests/xdp_adjust_tail.c     |    2 +
 .../testing/selftests/bpf/prog_tests/xdp_bonding.c |    2 +-
 .../selftests/bpf/prog_tests/xdp_do_redirect.c     |  166 ++-
 .../selftests/bpf/prog_tests/xdp_flowtable.c       |    2 +-
 .../selftests/bpf/prog_tests/xdp_metadata.c        |   21 +-
 tools/testing/selftests/bpf/progs/bad_struct_ops.c |    2 +-
 tools/testing/selftests/bpf/progs/cb_refs.c        |    2 +-
 .../bpf/progs/cgroup_skb_direct_packet_access.c    |   15 +
 tools/testing/selftests/bpf/progs/dynptr_fail.c    |    6 +-
 tools/testing/selftests/bpf/progs/epilogue_exit.c  |    4 +-
 .../selftests/bpf/progs/epilogue_tailcall.c        |    4 +-
 .../testing/selftests/bpf/progs/exceptions_fail.c  |    4 +-
 tools/testing/selftests/bpf/progs/free_timer.c     |   71 ++
 tools/testing/selftests/bpf/progs/irq.c            |  444 ++++++++
 tools/testing/selftests/bpf/progs/iters.c          |   14 +-
 tools/testing/selftests/bpf/progs/iters_testmod.c  |    2 +-
 tools/testing/selftests/bpf/progs/jit_probe_mem.c  |    2 +-
 .../selftests/bpf/progs/kfunc_call_destructive.c   |    2 +-
 .../testing/selftests/bpf/progs/kfunc_call_fail.c  |    2 +-
 .../testing/selftests/bpf/progs/kfunc_call_race.c  |    2 +-
 .../testing/selftests/bpf/progs/kfunc_call_test.c  |    2 +-
 .../selftests/bpf/progs/kfunc_call_test_subprog.c  |    2 +-
 .../testing/selftests/bpf/progs/local_kptr_stash.c |    2 +-
 tools/testing/selftests/bpf/progs/map_kptr.c       |    2 +-
 tools/testing/selftests/bpf/progs/map_kptr_fail.c  |    4 +-
 tools/testing/selftests/bpf/progs/missed_kprobe.c  |    2 +-
 .../selftests/bpf/progs/missed_kprobe_recursion.c  |    8 +-
 tools/testing/selftests/bpf/progs/nested_acquire.c |    2 +-
 tools/testing/selftests/bpf/progs/preempt_lock.c   |   28 +-
 tools/testing/selftests/bpf/progs/pro_epilogue.c   |    4 +-
 .../selftests/bpf/progs/pro_epilogue_goto_start.c  |    4 +-
 tools/testing/selftests/bpf/progs/sock_addr_kern.c |    2 +-
 .../selftests/bpf/progs/struct_ops_detach.c        |    2 +-
 .../selftests/bpf/progs/struct_ops_forgotten_cb.c  |    2 +-
 .../selftests/bpf/progs/struct_ops_maybe_null.c    |    2 +-
 .../bpf/progs/struct_ops_maybe_null_fail.c         |    2 +-
 .../selftests/bpf/progs/struct_ops_module.c        |    2 +-
 .../selftests/bpf/progs/struct_ops_multi_pages.c   |    2 +-
 .../selftests/bpf/progs/struct_ops_nulled_out_cb.c |    2 +-
 .../selftests/bpf/progs/struct_ops_private_stack.c |    2 +-
 .../bpf/progs/struct_ops_private_stack_fail.c      |    2 +-
 .../bpf/progs/struct_ops_private_stack_recur.c     |    2 +-
 tools/testing/selftests/bpf/progs/syscall.c        |    6 +-
 .../selftests/bpf/progs/test_cls_redirect.c        |    2 +-
 .../selftests/bpf/progs/test_cls_redirect.h        |    2 +-
 .../selftests/bpf/progs/test_cls_redirect_dynptr.c |    2 +-
 .../selftests/bpf/progs/test_fill_link_info.c      |   13 +-
 .../selftests/bpf/progs/test_global_func10.c       |    2 +-
 .../bpf/progs/test_kfunc_param_nullable.c          |    2 +-
 .../selftests/bpf/progs/test_module_attach.c       |    2 +-
 .../selftests/bpf/progs/test_tp_btf_nullable.c     |    2 +-
 .../bpf/progs/test_xdp_adjust_tail_grow.c          |    2 +
 .../selftests/bpf/progs/test_xdp_do_redirect.c     |   12 +
 .../selftests/bpf/progs/test_xdp_redirect.c        |   26 -
 tools/testing/selftests/bpf/progs/uninit_stack.c   |    5 +-
 .../testing/selftests/bpf/progs/unsupported_ops.c  |    2 +-
 .../selftests/bpf/progs/verifier_array_access.c    |  188 ++++
 .../selftests/bpf/progs/verifier_basic_stack.c     |    2 +-
 .../testing/selftests/bpf/progs/verifier_bounds.c  |  134 +++
 .../selftests/bpf/progs/verifier_const_or.c        |    4 +-
 .../bpf/progs/verifier_helper_access_var_len.c     |   12 +-
 .../testing/selftests/bpf/progs/verifier_int_ptr.c |    2 +-
 .../selftests/bpf/progs/verifier_map_in_map.c      |    2 +-
 .../selftests/bpf/progs/verifier_may_goto_1.c      |   97 ++
 .../selftests/bpf/progs/verifier_may_goto_2.c      |   28 +
 tools/testing/selftests/bpf/progs/verifier_mtu.c   |    2 +-
 .../selftests/bpf/progs/verifier_raw_stack.c       |    4 +-
 .../selftests/bpf/progs/verifier_spin_lock.c       |   28 +-
 .../testing/selftests/bpf/progs/verifier_unpriv.c  |    2 +-
 .../testing/selftests/bpf/progs/verifier_var_off.c |    8 +-
 tools/testing/selftests/bpf/progs/wq.c             |    2 +-
 tools/testing/selftests/bpf/progs/wq_failures.c    |    2 +-
 .../selftests/bpf/test_bpftool_synctypes.py        |   28 +-
 tools/testing/selftests/bpf/test_flow_dissector.c  |  780 -------------
 tools/testing/selftests/bpf/test_flow_dissector.sh |  178 ---
 .../bpf/{bpf_testmod => test_kmods}/.gitignore     |    0
 tools/testing/selftests/bpf/test_kmods/Makefile    |   21 +
 .../bpf_test_modorder_x.c                          |    0
 .../bpf_test_modorder_y.c                          |    0
 .../bpf_test_no_cfi.c                              |    0
 .../bpf_testmod-events.h                           |    0
 .../bpf/{bpf_testmod => test_kmods}/bpf_testmod.c  |    0
 .../bpf/{bpf_testmod => test_kmods}/bpf_testmod.h  |    0
 .../bpf_testmod_kfunc.h                            |    0
 tools/testing/selftests/bpf/test_progs.c           |   15 +
 tools/testing/selftests/bpf/test_progs.h           |   15 +
 tools/testing/selftests/bpf/test_tc_tunnel.sh      |    1 +
 tools/testing/selftests/bpf/test_xdp_redirect.sh   |   79 --
 tools/testing/selftests/bpf/verifier/calls.c       |    2 +-
 tools/testing/selftests/bpf/verifier/map_kptr.c    |    2 +-
 tools/testing/selftests/bpf/veristat.c             |  159 ++-
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |    2 +-
 161 files changed, 4995 insertions(+), 2099 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/bpf_test_modorder_x/Makefile
 delete mode 100644 tools/testing/selftests/bpf/bpf_test_modorder_y/Makefile
 delete mode 100644 tools/testing/selftests/bpf/bpf_test_no_cfi/Makefile
 delete mode 100644 tools/testing/selftests/bpf/bpf_testmod/Makefile
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_skb_direct_packet_access.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fd_array.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/flow_dissector_classification.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/free_timer.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_skb_direct_packet_access.c
 create mode 100644 tools/testing/selftests/bpf/progs/free_timer.c
 create mode 100644 tools/testing/selftests/bpf/progs/irq.c
 delete mode 100644 tools/testing/selftests/bpf/progs/test_xdp_redirect.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_may_goto_2.c
 delete mode 100644 tools/testing/selftests/bpf/test_flow_dissector.c
 delete mode 100755 tools/testing/selftests/bpf/test_flow_dissector.sh
 rename tools/testing/selftests/bpf/{bpf_testmod => test_kmods}/.gitignore (100%)
 create mode 100644 tools/testing/selftests/bpf/test_kmods/Makefile
 rename tools/testing/selftests/bpf/{bpf_test_modorder_x => test_kmods}/bpf_test_modorder_x.c (100%)
 rename tools/testing/selftests/bpf/{bpf_test_modorder_y => test_kmods}/bpf_test_modorder_y.c (100%)
 rename tools/testing/selftests/bpf/{bpf_test_no_cfi => test_kmods}/bpf_test_no_cfi.c (100%)
 rename tools/testing/selftests/bpf/{bpf_testmod => test_kmods}/bpf_testmod-events.h (100%)
 rename tools/testing/selftests/bpf/{bpf_testmod => test_kmods}/bpf_testmod.c (100%)
 rename tools/testing/selftests/bpf/{bpf_testmod => test_kmods}/bpf_testmod.h (100%)
 rename tools/testing/selftests/bpf/{bpf_testmod => test_kmods}/bpf_testmod_kfunc.h (100%)
 delete mode 100755 tools/testing/selftests/bpf/test_xdp_redirect.sh

