Return-Path: <bpf+bounces-39908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2A19791EA
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 17:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1DD62847BF
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 15:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D333A1D094A;
	Sat, 14 Sep 2024 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqX5dZHU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0DC1CEEA4;
	Sat, 14 Sep 2024 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726329498; cv=none; b=DEyljngPud1gIf7WawsttZLX0Te5shyYvr0cI9zFG4nUve9ZmqQVHuyJxAYMp04BcXy3BvpYjauSxfWpQGDF2dPVltqmiDhDKEz7DCIzQA+YPiGwn+vCLRWUd9FRY3ikkgO6C1TWH/24rLP9Pw2Vzs5dJuc1diUfc8j+UVkiPzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726329498; c=relaxed/simple;
	bh=4hzwaSiiUZd5vD+cuKq16LbI2pY/RAtWNFbPYcYsnlk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XuVyR8ysQ0aiIBkENrOgttxTFVLJIlntonFV3hbVvQHslJ5Tq5NOuD85DEoJ37lw9QsuMP+N0cfv33Z7dEkRQU3xIQ7ZkLgaFVqc+otmYOzvK91WmDoXEoRR7tQAWXHDRWmRr8GftoD/PEOkGnYdMJww8h+DZJeo5U6PwkzTmJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqX5dZHU; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d88c5d76eeso1383475a91.2;
        Sat, 14 Sep 2024 08:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726329495; x=1726934295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lXl+5x8SIibGTe+cInjwrjtvYtSwFjZUlNJ6dVv05cE=;
        b=mqX5dZHUtX858GqRnmemqNurQ4QTi/qMz8qADbAs/5mR2pjdQlFeLDaG5z2pmp82/0
         cfbNaatmsjwJ+LH5hylmclGScIdGJjQWwCmz7AZ3yzTyhAlgfthgtmWBot6pI2a49MXj
         rL2Rk1RVQcbwYqExektUAXrFLxactbnmewORrXRk4VE7MyhfSD/51eAC11C7tiwkoZ77
         15BiD804mn880AkWMEUCQuPjQkmFLPsqmtPDj0QbMRnHod4FFxXJG5GywOTV/alfWNdq
         oJl5IAVnE39r78nsKBDyk8e318Aih9Qxo3Kyt1im9WyvkTOkatNslEfqbVz8qfIwRg6S
         2r8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726329495; x=1726934295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lXl+5x8SIibGTe+cInjwrjtvYtSwFjZUlNJ6dVv05cE=;
        b=RjifSN+QXQ7NAPlnF6UOw7mC9kJ5upENFbPB234J8iq4xx2eKBkW3QWJ3eLZI/rz7C
         /ojKvJdwyEDj4n4ehFDfEU6tAKcebbWGR31G0W+BCcNeOQNwXtw4R/izdD8JhNAm82wx
         eMswksig+p0dfM/K/fA440lpj8tvwLWY2Gl34cF/a81IVm7E/gkqkd/bc4IuMxiNFetE
         J/oVvCeI0oyG5zE6oYPWGHF9+jVsZ/OwcOXd9vrM/haVidZfffr5CMtJDFF8UMnzIv7M
         4co+omeWmWZC4egya+q3ofRQUUKSpJelQ0WrPCIwLpbVeXRKObONt+t180Q+ilxRRDqn
         PmwA==
X-Forwarded-Encrypted: i=1; AJvYcCXeA5/Orz5jTxfdBNXL0PN74G+RCMHIO1OZ5z8Fu+TloD0bZCHiVSCUA9elUz4NeAHfG07rI2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUYGBld8D9ZU18KPPcMZlcBdS1Lb+qymxYMWNOacvlMEJhblgH
	q9HQiun7AvtaQBh7Aq81m50QKDSaP54BHvrIhVYVJWi9lmWW9LGJ
X-Google-Smtp-Source: AGHT+IFbznR5P6rHn4PRHAOibY2ixSiU4wVGFBkpPVRTR67Av1UfHb4QFHbAQnqO0hCWXJwaa2fawQ==
X-Received: by 2002:a17:90b:3ec1:b0:2d8:ebef:547 with SMTP id 98e67ed59e1d1-2dbb9f08b33mr8297493a91.35.1726329494481;
        Sat, 14 Sep 2024 08:58:14 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:3945])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9c7c7b4sm3860098a91.17.2024.09.14.08.58.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Sep 2024 08:58:14 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] BPF changes for v6.12
Date: Sat, 14 Sep 2024 08:58:10 -0700
Message-Id: <20240914155810.15758-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 872cf28b8df9c5c3a1e71a88ee750df7c2513971:

  Merge tag 'platform-drivers-x86-v6.11-4' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86 (2024-08-22 06:34:27 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.12

for you to fetch changes up to 5277d130947ba8c0d54c16eed89eb97f0b6d2e5a:

  btf: require pahole 1.21+ for DEBUG_INFO_BTF with default DWARF version (2024-09-13 20:03:29 -0700)

----------------------------------------------------------------
= BPF networking changes will come via net-next pull-req as discussed

= In addition, Al's struct-fd bpf related changes and Andrii's fd
  cleanups will be sent as a separate pull-req. Currently
  waiting in bpf-next/struct_fd branch.

= The following are the main BPF changes (there should be no conflicts):

- Introduce __attribute__((bpf_fastcall) for helpers and kfuncs
  with corresponding support in LLVM. It is similar to existing
  no_caller_saved_registers attribute in GCC/LLVM with a provision
  for backward compatibility. It allows compilers generate more
  efficient BPF code assuming the verifier or JITs will inline
  or partially inline a helper/kfunc with such attribute.
  bpf_cast_to_kern_ctx, bpf_rdonly_cast, bpf_get_smp_processor_id
  are the first set of such helpers.

- Harden and extend ELF build ID parsing logic. When called from
  sleepable context the relevants parts of ELF file will be read
  to find and fetch .note.gnu.build-id information. Also harden
  the logic to avoid TOCTOU, overflow, out-of-bounds problems.

- Improvements and fixes for sched-ext
  . Allow passing BPF iterators as kfunc arguments
  . Make the pointer returned from iter_next method trusted
  . Fix x86 JIT convergence issue due to growing/shrinking
    conditional jumps in variable length encoding

- BPF_LSM related
  . Introduce few VFS kfuncs and consolidate them in
    fs/bpf_fs_kfuncs.c
  . Enforce correct range of return values from certain LSM hooks
  . Disallow attaching to other LSM hooks 

- Prerequisite work for upcoming Qdisc in BPF
  . Allow kptrs in program provided structs
  . Support for gen_epilogue in verifier_ops

- Important fixes
  . Fix uprobe multi pid filter check
  . Fix bpf_strtol and bpf_strtoul helpers
  . Track equal scalars history on per-instruction level
  . Fix tailcall hierarchy on x86 and arm64
  . Fix signed division overflow to prevent INT_MIN/-1 trap on x86
  . Fix get kernel stack in BPF progs attached to tracepoint:syscall

- Selftests related
  . Add uprobe bench/stress tool
  . Generate file dependencies to drastically improve re-build time
  . Match JIT-ed and BPF asm with __xlated/__jited keywords
  . Convert older tests to test_progs framework
  . Add support for RISC-V
  . Few fixes when BPF programs are compiled with GCC-BPF backend
    (support for GCC-BPF in BPF CI is ongoing in parallel)
  . Add traffic monitor
  . Enable cross compile and musl libc

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alan Maguire (1):
      libbpf: Fix license for btf_relocate.c

Alexei Starovoitov (21):
      Merge branch 'bpf-fix-tailcall-hierarchy'
      Merge branch 'bpf-retire-the-unsupported_ops-usage-in-struct_ops'
      Merge branch 'add-bpf-lsm-return-value-range-check-bpf-part'
      selftests/bpf: Workaround strict bpf_lsm return value check.
      Merge branch 'no_caller_saved_registers-attribute-for-helper-calls'
      Merge branch 'bpf-introduce-new-vfs-based-bpf-kfuncs'
      Merge branch 'add-bpf_get_dentry_xattr'
      Merge branch 'support-passing-bpf-iterator-to-kfuncs'
      Merge branch '__jited-test-tag-to-check-disassembly-after-jit'
      Merge branch 'bpf-fix-null-pointer-access-for-malformed-bpf_core_type_id_local-relos'
      Merge branch 'support-bpf_fastcall-patterns-for-calls-to-kfuncs'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge branch 'follow-up-for-__jited-test-tag'
      Merge branch 'support-bpf_kptr_xchg-into-local-kptr'
      Merge branch 'bpf-arm64-simplify-jited-prologue-epilogue'
      Merge branch 'bpf-add-gen_epilogue-to-bpf_verifier_ops'
      Merge branch 'bpf-follow-up-on-gen_epilogue'
      Merge branch 'local-vmtest-enhancement-and-rv64-enabled'
      Merge branch 'allow-kfuncs-in-tracepoint-and-perf-event'
      Merge branch 'harden-and-extend-elf-build-id-parsing-logic'
      Merge branch 'two-tiny-fixes-for-btf-record'

Alexey Gladkov (1):
      bpf: Remove custom build rule

Alexis Lothoré (eBPF Foundation) (9):
      selftests/bpf: Update xdp_redirect_map prog sections for libbpf
      selftests/bpf: Integrate test_xdp_veth into test_progs
      selftests/bpf: do not disable /dev/null device access in cgroup dev test
      selftests/bpf: convert test_dev_cgroup to test_progs
      selftests/bpf: add wrong type test to cgroup dev
      selftests/bpf: convert get_current_cgroup_id_user to test_progs
      selftests/bpf: convert test_cgroup_storage to test_progs
      selftests/bpf: add proper section name to bpf prog and rename it
      selftests/bpf: convert test_skb_cgroup_id_user to test_progs

Amery Hung (2):
      bpf: Let callers of btf_parse_kptr() track life cycle of prog btf
      selftests/bpf: Make sure stashed kptr in local kptr is freed recursively

Andrew Kreimer (1):
      bpftool: Fix typos

Andrii Nakryiko (27):
      Merge branch 'bpf-track-find_equal_scalars-history-on-per-instruction-level'
      Merge branch 'selftests-bpf-add-more-uprobe-multi-tests'
      Merge branch 'selftests-bpf-improve-libc-portability-musl-support-part-1'
      selftests/bpf: fix RELEASE=1 compilation for sock_addr.c
      Merge branch 'bpf-enable-some-functions-in-cgroup-programs'
      Merge branch 'correct-recent-gcc-incompatible-changes'
      bpf: extract iterator argument type and name validation logic
      bpf: allow passing struct bpf_iter_<type> as kfunc arguments
      selftests/bpf: test passing iterator to a kfunc
      selftests/bpf: make use of PROCMAP_QUERY ioctl if available
      selftests/bpf: add multi-uprobe benchmarks
      libbpf: Fix bpf_object__open_skeleton()'s mishandling of options
      Merge branch 'fix-accessing-first-syscall-argument-on-rv64'
      Merge branch 'selftests-bpf-add-uprobe-multi-pid-filter-test'
      bpf: change int cmd argument in __sys_bpf into typed enum bpf_cmd
      MAINTAINERS: record lib/buildid.c as owned by BPF subsystem
      lib/buildid: harden build ID parsing logic
      lib/buildid: add single folio-based file reader abstraction
      lib/buildid: take into account e_phoff when fetching program headers
      lib/buildid: remove single-page limit for PHDR search
      lib/buildid: rename build_id_parse() into build_id_parse_nofault()
      lib/buildid: implement sleepable build_id_parse() API
      lib/buildid: don't limit .note.gnu.build-id to the first page in ELF
      bpf: decouple stack_map_get_build_id_offset() from perf_callchain_entry
      bpf: wire up sleepable bpf_get_stack() and bpf_get_task_stack() helpers
      selftests/bpf: add build ID tests
      Merge branch 'bpf-add-percpu-map-value-size-check'

Artem Savkov (1):
      selftests/bpf: Fix compilation failure when CONFIG_NET_FOU!=y

Cupertino Miranda (2):
      selftests/bpf: Disable strict aliasing for verifier_nocsr.c
      selftest/bpf: Adapt inline asm operand constraint for GCC support

Daniel Borkmann (9):
      bpf: Fix bpf_strtol and bpf_strtoul helpers for 32bit
      bpf: Remove truncation test in bpf_strtol and bpf_strtoul helpers
      bpf: Fix helper writes to read-only maps
      bpf: Improve check_raw_mode_ok test for MEM_UNINIT-tagged types
      bpf: Zero former ARG_PTR_TO_{LONG,INT} args in case of error
      selftests/bpf: Fix ARG_PTR_TO_LONG {half-,}uninitialized test
      selftests/bpf: Rename ARG_PTR_TO_LONG test description
      selftests/bpf: Add a test case to write strtol result into .rodata
      selftests/bpf: Add a test case to write mtu result into .rodata

Dave Marchevsky (4):
      bpf: Search for kptrs in prog BTF structs
      bpf: Rename ARG_PTR_TO_KPTR -> ARG_KPTR_XCHG_DEST
      bpf: Support bpf_kptr_xchg into local kptr
      selftests/bpf: Test bpf_kptr_xchg stashing into local kptr

David Vernet (2):
      libbpf: Don't take direct pointers into BTF data from st_ops
      selftests/bpf: Load struct_ops map in global_maps_resize test

Donald Hunter (1):
      docs/bpf: Add missing BPF program types to docs

Eduard Zingerman (37):
      bpf: Track equal scalars history on per-instruction level
      bpf: Remove mark_precise_scalar_ids()
      selftests/bpf: Tests for per-insn sync_linked_regs() precision tracking
      selftests/bpf: Update comments find_equal_scalars->sync_linked_regs
      bpf: add a get_helper_proto() utility function
      bpf: no_caller_saved_registers attribute for helper calls
      bpf, x86, riscv, arm: no_caller_saved_registers for bpf_get_smp_processor_id()
      selftests/bpf: extract utility function for BPF disassembly
      selftests/bpf: print correct offset for pseudo calls in disasm_insn()
      selftests/bpf: no need to track next_match_pos in struct test_loader
      selftests/bpf: extract test_loader->expect_msgs as a data structure
      selftests/bpf: allow checking xlated programs in verifier_* tests
      selftests/bpf: __arch_* macro to limit test cases to specific archs
      selftests/bpf: test no_caller_saved_registers spill/fill removal
      selftests/bpf: less spam in the log for message matching
      selftests/bpf: correctly move 'log' upon successful match
      selftests/bpf: fix to avoid __msg tag de-duplication by clang
      selftests/bpf: replace __regex macro with "{{...}}" patterns
      selftests/bpf: utility function to get program disassembly after jit
      selftests/bpf: __jited test tag to check disassembly after jit
      selftests/bpf: validate jit behaviour for tail calls
      selftests/bpf: validate __xlated same way as __jited
      bpf: correctly handle malformed BPF_CORE_TYPE_ID_LOCAL relos
      selftests/bpf: test for malformed BPF_CORE_TYPE_ID_LOCAL relocation
      bpf: rename nocsr -> bpf_fastcall in verifier
      selftests/bpf: rename nocsr -> bpf_fastcall in selftests
      bpf: support bpf_fastcall patterns for kfuncs
      bpf: allow bpf_fastcall for bpf_cast_to_kern_ctx and bpf_rdonly_cast
      selftests/bpf: by default use arch mask allowing all archs
      selftests/bpf: check if bpf_fastcall is recognized for kfuncs
      selftests/bpf: test_loader.c:get_current_arch() should not return 0
      selftests/bpf: match both retq/rethunk in verifier_tailcall_jit
      selftests/bpf: #define LOCAL_LABEL_LEN for jit_disasm_helpers.c
      selftests/bpf: use simply-expanded variables for libpcap flags
      selftests/bpf: attach struct_ops maps before test prog runs
      selftests/bpf: Check if distilled base inherits source endianness
      selftests/bpf: Prefer static linking for LLVM libraries

Feng Yang (1):
      selftests: bpf: Replace sizeof(arr)/sizeof(arr[0]) with ARRAY_SIZE

Geliang Tang (7):
      selftests/bpf: Drop type of connect_to_fd_opts
      selftests/bpf: Drop must_fail from network_helper_opts
      selftests/bpf: Add connect_to_addr_str helper
      selftests/bpf: Drop make_client in sk_lookup
      selftests/bpf: Drop make_socket in sk_lookup
      selftests/bpf: Drop inetaddr_len in sk_lookup
      selftests/bpf: Drop __start_server in network_helpers

Hao Ge (1):
      selftests/bpf: Fix incorrect parameters in NULL pointer checking

Hongbo Li (1):
      bpf: Use kvmemdup to simplify the code

Hou Tao (2):
      bpf: Call the missed btf_record_free() when map creation fails
      bpf: Call the missed kfree() when there is no special field in btf

Ihor Solodrai (6):
      selftests/bpf: Use auto-dependencies for test objects
      selftests/bpf: Don't include .d files on make clean
      selftests/bpf: Make %.test.d prerequisite order only
      selftests/bpf: Specify libbpf headers required for %.bpf.o progs
      selftests/bpf: Do not update vmlinux.h unnecessarily
      libbpf: Add bpf_object__token_fd accessor

JP Kobryn (2):
      bpf: allow kfuncs within tracepoint and perf event programs
      bpf/selftests: coverage for tp and perf event progs using kfuncs

Jeongjun Park (1):
      bpf: Remove __btf_name_valid() and change to btf_name_valid_identifier()

Jiangshan Yi (1):
      samples/bpf: Fix compilation errors with cf-protection option

Jinjie Ruan (1):
      bpf: Use sockfd_put() helper

Jiri Olsa (7):
      selftests/bpf: Add uprobe fail tests for uprobe multi
      selftests/bpf: Add uprobe multi consumers test
      bpf: Fix uprobe multi pid filter check
      selftests/bpf: Add child argument to spawn_child function
      selftests/bpf: Add uprobe multi pid filter test for fork-ed processes
      selftests/bpf: Add uprobe multi pid filter test for clone-ed processes
      libbpf: Fix uretprobe.multi.s programs auto attachment

Jordan Rome (2):
      bpf: Add bpf_copy_from_user_str kfunc
      selftests/bpf: Add tests for bpf_copy_from_user_str kfunc.

Juntong Deng (4):
      bpf: Relax KF_ACQUIRE kfuncs strict type matching constraint
      selftests/bpf: Add test for zero offset or non-zero offset pointers as KF_ACQUIRE kfuncs argument
      bpf: Make the pointer returned by iter next method valid
      selftests/bpf: Add tests for iter next method returning valid pointer

Kuan-Wei Chiu (2):
      bpftool: Fix undefined behavior caused by shifting into the sign bit
      bpftool: Fix undefined behavior in qsort(NULL, 0, ...)

Kui-Feng Lee (6):
      selftests/bpf: Add traffic monitor functions.
      selftests/bpf: Add the traffic monitor option to test_progs.
      selftests/bpf: netns_new() and netns_free() helpers.
      selftests/bpf: Monitor traffic for tc_redirect.
      selftests/bpf: Monitor traffic for sockmap_listen.
      selftests/bpf: Monitor traffic for select_reuseport.

Leon Hwang (4):
      bpf, x64: Fix tailcall hierarchy
      bpf, arm64: Fix tailcall hierarchy
      selftests/bpf: Add testcases for tailcall hierarchy fixing
      selftests/bpf: Add testcase for updating attached freplace prog to prog_array map

Lin Yikai (3):
      selftests/bpf: fix some typos in selftests
      bpftool: fix some typos in bpftool
      libbpf: fix some typos in libbpf

Markus Elfring (2):
      bpf: Replace 8 seq_puts() calls by seq_putc() calls
      bpf: Simplify character output in seq_print_delegate_opts()

Martin KaFai Lau (18):
      Merge branch 'use network helpers, part 9'
      bpf: Check unsupported ops from the bpf_struct_ops's cfi_stubs
      selftests/bpf: Fix the missing tramp_1 to tramp_40 ops in cfi_stubs
      selftests/bpf: Ensure the unsupported struct_ops prog cannot be loaded
      Merge branch 'use network helpers, part 10'
      Merge branch 'selftests/bpf: convert test_dev_cgroup to test_progs'
      Merge branch 'selftests/bpf: convert three other cgroup tests to test_progs'
      Merge branch 'monitor network traffic for flaky test cases'
      bpf: Move insn_buf[16] to bpf_verifier_env
      bpf: Adjust BPF_JMP that jumps to the 1st insn of the prologue
      bpf: Add gen_epilogue to bpf_verifier_ops
      bpf: Export bpf_base_func_proto
      selftests/bpf: Test gen_prologue and gen_epilogue
      selftests/bpf: Add tailcall epilogue test
      selftests/bpf: A pro/epilogue test when the main prog jumps back to the 1st insn
      selftests/bpf: Test epilogue patching when the main prog has multiple BPF_EXIT
      bpf: Remove the insn_buf array stack usage from the inline_bpf_loop()
      bpf: Fix indentation issue in epilogue_idx

Masahiro Yamada (3):
      btf: remove redundant CONFIG_BPF test in scripts/link-vmlinux.sh
      btf: move pahole check in scripts/link-vmlinux.sh to lib/Kconfig.debug
      btf: require pahole 1.21+ for DEBUG_INFO_BTF with default DWARF version

Matt Bobrowski (3):
      bpf: introduce new VFS based BPF kfuncs
      selftests/bpf: add negative tests for new VFS based BPF kfuncs
      selftests/bpf: add positive tests for new VFS based BPF kfuncs

Matteo Croce (2):
      bpf: Enable generic kfuncs for BPF_CGROUP_* programs
      bpf: Allow bpf_current_task_under_cgroup() with BPF_CGROUP_*

Maxim Mikityanskiy (1):
      bpf: Fix error message on kfunc arg type mismatch

Menglong Dong (1):
      bpf: kprobe: Remove unused declaring of bpf_kprobe_override

Mykyta Yatsenko (2):
      bpftool: Fix handling enum64 in btf dump sorting
      bpftool: Improve btf c dump sorting stability

Pu Lehui (13):
      libbpf: Access first syscall argument with CO-RE direct read on s390
      libbpf: Access first syscall argument with CO-RE direct read on arm64
      selftests/bpf: Enable test_bpf_syscall_macro: Syscall_arg1 on s390 and arm64
      libbpf: Fix accessing first syscall argument on RV64
      selftests/bpf: Adapt OUTPUT appending logic to lower versions of Make
      selftests/bpf: Rename fallback in bpf_dctcp to avoid naming conflict
      selftests/bpf: Limit URLS parsing logic to actual scope in vmtest
      selftests/bpf: Support local rootfs image for vmtest
      selftests/bpf: Enable cross platform testing for vmtest
      selftests/bpf: Add config.riscv64
      selftests/bpf: Add DENYLIST.riscv64
      selftests/bpf: Add riscv64 configurations to local vmtest
      selftests/bpf: Add description for running vmtest on RV64

Quentin Monnet (1):
      bpftool: Add missing blank lines in bpftool-net doc example

Rong Tao (2):
      samples/bpf: tracex4: Fix failed to create kretprobe 'kmem_cache_alloc_node+0x0'
      samples/bpf: Remove sample tracex2

Sam James (2):
      libbpf: Workaround -Wmaybe-uninitialized false positive
      libbpf: Workaround (another) -Wmaybe-uninitialized false positive

Shahab Vahedi (1):
      MAINTAINERS: BPF ARC JIT: Update my e-mail address

Shung-Hsi Yu (1):
      bpf: use type_may_be_null() helper for nullable-param check

Shuyi Cheng (1):
      libbpf: Fixed getting wrong return address on arm64 architecture

Song Liu (5):
      selftests/bpf: Add a test for mmap-able map in map
      bpf: Move bpf_get_file_xattr to fs/bpf_fs_kfuncs.c
      bpf: Add kfunc bpf_get_dentry_xattr() to read xattr from dentry
      selftests/bpf: Add tests for bpf_get_dentry_xattr
      bpf: lsm: Set bpf_lsm_blob_sizes.lbs_task to 0

Stanislav Fomichev (1):
      xsk: Try to make xdp_umem_reg extension a bit more future-proof

Tao Chen (6):
      bpftool: Refactor xdp attach/detach type judgment
      bpftool: Add net attach/detach command to tcx prog
      bpftool: Add bash-completion for tcx subcommand
      bpftool: Add document for net attach/detach on tcx subcommand
      bpf: Check percpu map value size first
      bpf/selftests: Check errno when percpu map value size exceeds

Tony Ambardar (30):
      selftests/bpf: Add missing system defines for mips
      selftests/bpf: Fix error linking uprobe_multi on mips
      selftests/bpf: Fix wrong binary in Makefile log output
      tools/runqslower: Fix LDFLAGS and add LDLIBS support
      selftests/bpf: Use pid_t consistently in test_progs.c
      selftests/bpf: Fix compile error from rlim_t in sk_storage_map.c
      selftests/bpf: Fix error compiling bpf_iter_setsockopt.c with musl libc
      selftests/bpf: Drop unneeded error.h includes
      selftests/bpf: Fix missing ARRAY_SIZE() definition in bench.c
      selftests/bpf: Fix missing UINT_MAX definitions in benchmarks
      selftests/bpf: Fix missing BUILD_BUG_ON() declaration
      selftests/bpf: Fix include of <sys/fcntl.h>
      selftests/bpf: Fix compiling parse_tcp_hdr_opt.c with musl-libc
      selftests/bpf: Fix compiling kfree_skb.c with musl-libc
      selftests/bpf: Fix compiling flow_dissector.c with musl-libc
      selftests/bpf: Fix compiling tcp_rtt.c with musl-libc
      selftests/bpf: Fix compiling core_reloc.c with musl-libc
      selftests/bpf: Fix errors compiling lwt_redirect.c with musl libc
      selftests/bpf: Fix errors compiling decap_sanity.c with musl libc
      selftests/bpf: Fix errors compiling crypto_sanity.c with musl libc
      selftests/bpf: Fix errors compiling cg_storage_multi.h with musl libc
      selftests/bpf: Use portable POSIX basename()
      selftests/bpf: Fix arg parsing in veristat, test_progs
      selftests/bpf: Fix error compiling test_lru_map.c
      selftests/bpf: Fix C++ compile error from missing _Bool type
      selftests/bpf: Fix redefinition errors compiling lwt_reroute.c
      selftests/bpf: Fix compile if backtrace support missing in libc
      selftests/bpf: Fix using stdout, stderr as struct field names
      selftests/bpf: Fix error compiling tc_redirect.c with musl libc
      libbpf: Ensure new BTF objects inherit input endianness

Uros Bizjak (1):
      bpf: Fix percpu address space issues

Will Hawkins (1):
      docs/bpf: Add constant values for linkages

Xu Kuohai (11):
      bpf, lsm: Add disabled BPF LSM hook list
      bpf, lsm: Add check for BPF LSM return value
      bpf: Prevent tail call between progs attached to different hooks
      bpf: Fix compare error in function retval_range_within
      selftests/bpf: Avoid load failure for token_lsm.c
      selftests/bpf: Add return value checks for failed tests
      selftests/bpf: Add test for lsm tail call
      selftests/bpf: Add verifier tests for bpf lsm
      bpf, arm64: Get rid of fpb
      bpf, arm64: Avoid blindly saving/restoring all callee-saved registers
      bpf, arm64: Jit BPF_CALL to direct call when possible

Yiming Xiang (1):
      docs/bpf: Fix a typo in verifier.rst

Yonghong Song (11):
      bpf: Fail verification for sign-extension of packet data/data_end/data_meta
      selftests/bpf: Add tests for ldsx of pkt data/data_end/data_meta accesses
      bpf: Get better reg range with ldsx and 32bit compare
      selftests/bpf: Add reg_bounds tests for ldsx and subreg compare
      selftests/bpf: Fix a btf_dump selftest failure
      bpf, x64: Fix a jit convergence issue
      selftests/bpf: Add a selftest for x86 jit convergence issues
      selftests/bpf: Fix arena_atomics failure due to llvm change
      bpf: Use fake pt_regs when doing bpf syscall tracepoint tracing
      bpf: Fix a sdiv overflow issue
      selftests/bpf: Add tests for sdiv/smod overflow cases

Yu Jiaoliang (1):
      bpf: Use kmemdup_array instead of kmemdup for multiple allocation

Yuan Chen (1):
      selftests/bpf: Fix procmap_query()'s params mismatch and compilation warning

Yusheng Zheng (1):
      libbpf: Fix some typos in comments

Zhu Jun (1):
      tools/bpf: Fix the wrong format specifier

 Documentation/bpf/btf.rst                          |   39 +-
 Documentation/bpf/libbpf/program_types.rst         |   30 +-
 Documentation/bpf/verifier.rst                     |    2 +-
 MAINTAINERS                                        |    4 +-
 arch/arm64/net/bpf_jit_comp.c                      |  508 ++++----
 arch/x86/net/bpf_jit_comp.c                        |  161 ++-
 fs/Makefile                                        |    1 +
 fs/bpf_fs_kfuncs.c                                 |  185 +++
 include/linux/bpf.h                                |   28 +-
 include/linux/bpf_lsm.h                            |    8 +
 include/linux/bpf_verifier.h                       |   27 +
 include/linux/btf.h                                |    5 +
 include/linux/buildid.h                            |    4 +-
 include/linux/filter.h                             |   10 +
 include/uapi/linux/bpf.h                           |   18 +-
 kernel/bpf/Makefile                                |    6 -
 kernel/bpf/arraymap.c                              |   17 +-
 kernel/bpf/bpf_lsm.c                               |   65 +-
 kernel/bpf/bpf_struct_ops.c                        |    9 +-
 kernel/bpf/btf.c                                   |  159 ++-
 kernel/bpf/btf_iter.c                              |    2 +
 kernel/bpf/btf_relocate.c                          |    2 +
 kernel/bpf/cgroup.c                                |    2 +
 kernel/bpf/core.c                                  |   21 +-
 kernel/bpf/hashtab.c                               |   16 +-
 kernel/bpf/helpers.c                               |   94 +-
 kernel/bpf/inode.c                                 |    4 +-
 kernel/bpf/local_storage.c                         |    4 +-
 kernel/bpf/memalloc.c                              |   12 +-
 kernel/bpf/relo_core.c                             |    2 +
 kernel/bpf/reuseport_array.c                       |    2 +-
 kernel/bpf/stackmap.c                              |  131 +-
 kernel/bpf/syscall.c                               |   31 +-
 kernel/bpf/verifier.c                              | 1291 +++++++++++++++-----
 kernel/events/core.c                               |    2 +-
 kernel/trace/bpf_trace.c                           |  108 +-
 kernel/trace/trace_syscalls.c                      |   12 +-
 lib/Kconfig.debug                                  |    8 +-
 lib/buildid.c                                      |  397 ++++--
 net/bpf/bpf_dummy_struct_ops.c                     |    2 +-
 net/core/filter.c                                  |   75 +-
 net/ipv4/bpf_tcp_ca.c                              |   26 -
 net/xdp/xsk.c                                      |   23 +-
 samples/bpf/Makefile                               |    9 +-
 samples/bpf/tracex2.bpf.c                          |   99 --
 samples/bpf/tracex2_user.c                         |  187 ---
 samples/bpf/tracex4.bpf.c                          |    4 +-
 scripts/link-vmlinux.sh                            |   14 +-
 security/bpf/hooks.c                               |    1 -
 tools/bpf/bpftool/Documentation/bpftool-gen.rst    |    4 +-
 tools/bpf/bpftool/Documentation/bpftool-net.rst    |   24 +-
 tools/bpf/bpftool/bash-completion/bpftool          |    2 +-
 tools/bpf/bpftool/btf.c                            |   87 +-
 tools/bpf/bpftool/feature.c                        |   10 +-
 tools/bpf/bpftool/net.c                            |   80 +-
 tools/bpf/bpftool/xlated_dumper.c                  |    4 +-
 tools/bpf/runqslower/Makefile                      |    3 +-
 tools/include/uapi/linux/bpf.h                     |    9 +
 tools/lib/bpf/bpf.h                                |    4 +-
 tools/lib/bpf/bpf_helpers.h                        |    2 +-
 tools/lib/bpf/bpf_tracing.h                        |   25 +-
 tools/lib/bpf/btf.c                                |    8 +-
 tools/lib/bpf/btf.h                                |    2 +-
 tools/lib/bpf/btf_dump.c                           |    2 +-
 tools/lib/bpf/btf_relocate.c                       |    2 +-
 tools/lib/bpf/elf.c                                |    3 +
 tools/lib/bpf/libbpf.c                             |   88 +-
 tools/lib/bpf/libbpf.h                             |   18 +-
 tools/lib/bpf/libbpf.map                           |    1 +
 tools/lib/bpf/libbpf_legacy.h                      |    4 +-
 tools/lib/bpf/linker.c                             |    4 +-
 tools/lib/bpf/skel_internal.h                      |    2 +-
 tools/lib/bpf/usdt.bpf.h                           |    2 +-
 tools/testing/selftests/bpf/.gitignore             |    6 +-
 tools/testing/selftests/bpf/DENYLIST.riscv64       |    3 +
 tools/testing/selftests/bpf/Makefile               |  151 ++-
 tools/testing/selftests/bpf/README.rst             |   32 +-
 tools/testing/selftests/bpf/bench.c                |   13 +
 tools/testing/selftests/bpf/bench.h                |    1 +
 tools/testing/selftests/bpf/benchs/bench_trigger.c |   83 +-
 tools/testing/selftests/bpf/bpf_experimental.h     |   26 +
 tools/testing/selftests/bpf/bpf_kfuncs.h           |   11 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |  257 +++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h        |   12 +
 .../selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h  |   15 +
 tools/testing/selftests/bpf/cgroup_helpers.c       |    2 +-
 tools/testing/selftests/bpf/config.riscv64         |   84 ++
 tools/testing/selftests/bpf/disasm_helpers.c       |   69 ++
 tools/testing/selftests/bpf/disasm_helpers.h       |   12 +
 tools/testing/selftests/bpf/get_cgroup_id_user.c   |  151 ---
 tools/testing/selftests/bpf/jit_disasm_helpers.c   |  245 ++++
 tools/testing/selftests/bpf/jit_disasm_helpers.h   |   10 +
 .../selftests/bpf/map_tests/htab_map_batch_ops.c   |    2 +-
 .../bpf/map_tests/lpm_trie_map_batch_ops.c         |    2 +-
 .../selftests/bpf/map_tests/map_percpu_stats.c     |   18 +
 .../selftests/bpf/map_tests/sk_storage_map.c       |    2 +-
 tools/testing/selftests/bpf/network_helpers.c      |  602 ++++++++-
 tools/testing/selftests/bpf/network_helpers.h      |   25 +-
 .../selftests/bpf/prog_tests/attach_probe.c        |    8 +-
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c  |    4 +-
 .../selftests/bpf/prog_tests/bpf_iter_setsockopt.c |    2 +-
 .../testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  |    4 +-
 tools/testing/selftests/bpf/prog_tests/btf.c       |    6 +-
 .../testing/selftests/bpf/prog_tests/btf_distill.c |   68 ++
 tools/testing/selftests/bpf/prog_tests/btf_dump.c  |    4 +-
 tools/testing/selftests/bpf/prog_tests/build_id.c  |  118 ++
 .../selftests/bpf/prog_tests/cg_storage_multi.c    |    2 +-
 .../selftests/bpf/prog_tests/cgroup_ancestor.c     |  141 +++
 .../testing/selftests/bpf/prog_tests/cgroup_dev.c  |  125 ++
 .../bpf/prog_tests/cgroup_get_current_cgroup_id.c  |   46 +
 .../selftests/bpf/prog_tests/cgroup_storage.c      |   96 ++
 .../testing/selftests/bpf/prog_tests/cgroup_v1v2.c |   16 +-
 .../testing/selftests/bpf/prog_tests/core_reloc.c  |    1 +
 .../selftests/bpf/prog_tests/core_reloc_raw.c      |  125 ++
 .../selftests/bpf/prog_tests/crypto_sanity.c       |    1 -
 .../testing/selftests/bpf/prog_tests/ctx_rewrite.c |   74 +-
 .../selftests/bpf/prog_tests/decap_sanity.c        |    1 -
 .../selftests/bpf/prog_tests/fexit_stress.c        |    3 +-
 .../selftests/bpf/prog_tests/flow_dissector.c      |    2 +-
 tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c |    9 +-
 tools/testing/selftests/bpf/prog_tests/iters.c     |    5 +-
 tools/testing/selftests/bpf/prog_tests/kfree_skb.c |    1 +
 .../testing/selftests/bpf/prog_tests/kfunc_call.c  |    1 +
 tools/testing/selftests/bpf/prog_tests/log_buf.c   |    9 +-
 .../selftests/bpf/prog_tests/lwt_redirect.c        |    1 -
 .../testing/selftests/bpf/prog_tests/lwt_reroute.c |    1 +
 .../bpf/prog_tests/module_fentry_shadow.c          |    3 +-
 .../selftests/bpf/prog_tests/nested_trust.c        |    4 +
 .../selftests/bpf/prog_tests/ns_current_pid_tgid.c |    2 +-
 .../selftests/bpf/prog_tests/parse_tcp_hdr_opt.c   |    1 +
 .../selftests/bpf/prog_tests/pro_epilogue.c        |   60 +
 .../raw_tp_writable_reject_nbd_invalid.c           |    3 +-
 .../bpf/prog_tests/raw_tp_writable_test_run.c      |    5 +-
 .../selftests/bpf/prog_tests/read_vsyscall.c       |    1 +
 .../testing/selftests/bpf/prog_tests/reg_bounds.c  |   32 +-
 .../selftests/bpf/prog_tests/resolve_btfids.c      |    2 +-
 .../selftests/bpf/prog_tests/select_reuseport.c    |   37 +-
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c |  111 +-
 tools/testing/selftests/bpf/prog_tests/sock_addr.c |    1 +
 .../selftests/bpf/prog_tests/sockmap_listen.c      |    8 +
 tools/testing/selftests/bpf/prog_tests/tailcalls.c |  385 +++++-
 tools/testing/selftests/bpf/prog_tests/tc_opts.c   |    2 +-
 .../testing/selftests/bpf/prog_tests/tc_redirect.c |   43 +-
 tools/testing/selftests/bpf/prog_tests/tcp_rtt.c   |    1 +
 .../bpf/prog_tests/test_bpf_syscall_macro.c        |    4 -
 .../selftests/bpf/prog_tests/test_bprm_opts.c      |    2 +-
 tools/testing/selftests/bpf/prog_tests/test_lsm.c  |   46 +-
 .../bpf/prog_tests/test_mmap_inner_array.c         |   57 +
 .../selftests/bpf/prog_tests/test_strncmp.c        |    2 +-
 .../bpf/prog_tests/test_struct_ops_module.c        |    2 +
 .../selftests/bpf/prog_tests/test_xdp_veth.c       |  213 ++++
 tools/testing/selftests/bpf/prog_tests/token.c     |    4 +-
 .../selftests/bpf/prog_tests/unpriv_bpf_disabled.c |    3 +-
 .../selftests/bpf/prog_tests/uprobe_multi_test.c   |  529 +++++++-
 .../selftests/bpf/prog_tests/user_ringbuf.c        |    3 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   14 +
 tools/testing/selftests/bpf/progs/arena_atomics.c  |   32 +-
 tools/testing/selftests/bpf/progs/bpf_cubic.c      |    6 +-
 tools/testing/selftests/bpf/progs/bpf_dctcp.c      |    8 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h       |   64 +-
 .../selftests/bpf/progs/bpf_syscall_macro.c        |    2 -
 .../testing/selftests/bpf/progs/cg_storage_multi.h |    2 -
 .../testing/selftests/bpf/progs/cgroup_ancestor.c  |   40 +
 tools/testing/selftests/bpf/progs/cgroup_storage.c |   24 +
 tools/testing/selftests/bpf/progs/dev_cgroup.c     |    4 +-
 tools/testing/selftests/bpf/progs/dynptr_fail.c    |    6 +-
 tools/testing/selftests/bpf/progs/epilogue_exit.c  |   82 ++
 .../selftests/bpf/progs/epilogue_tailcall.c        |   58 +
 tools/testing/selftests/bpf/progs/err.h            |   10 +
 .../selftests/bpf/progs/get_cgroup_id_kern.c       |   26 +-
 tools/testing/selftests/bpf/progs/iters_testmod.c  |  125 ++
 .../selftests/bpf/progs/iters_testmod_seq.c        |   50 +
 .../testing/selftests/bpf/progs/kfunc_call_fail.c  |    7 +
 .../testing/selftests/bpf/progs/local_kptr_stash.c |   30 +-
 tools/testing/selftests/bpf/progs/lsm_tailcall.c   |   34 +
 .../testing/selftests/bpf/progs/mmap_inner_array.c |   57 +
 tools/testing/selftests/bpf/progs/nested_acquire.c |   33 +
 tools/testing/selftests/bpf/progs/pro_epilogue.c   |  154 +++
 .../selftests/bpf/progs/pro_epilogue_goto_start.c  |  149 +++
 tools/testing/selftests/bpf/progs/rbtree_fail.c    |    2 +-
 tools/testing/selftests/bpf/progs/read_vsyscall.c  |    9 +-
 .../selftests/bpf/progs/refcounted_kptr_fail.c     |    4 +-
 tools/testing/selftests/bpf/progs/strobemeta.h     |    4 +-
 tools/testing/selftests/bpf/progs/syscall.c        |    3 +-
 .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c        |   34 +
 .../bpf/progs/tailcall_bpf2bpf_hierarchy2.c        |   70 ++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy3.c        |   62 +
 .../bpf/progs/tailcall_bpf2bpf_hierarchy_fentry.c  |   35 +
 .../selftests/bpf/progs/tailcall_freplace.c        |   23 +
 .../selftests/bpf/progs/task_kfunc_success.c       |   56 +-
 tools/testing/selftests/bpf/progs/tc_bpf2bpf.c     |   22 +
 tools/testing/selftests/bpf/progs/tc_dummy.c       |   12 +
 .../selftests/bpf/progs/test_attach_probe.c        |   64 +-
 tools/testing/selftests/bpf/progs/test_build_id.c  |   31 +
 .../selftests/bpf/progs/test_cls_redirect_dynptr.c |    2 +-
 .../selftests/bpf/progs/test_core_read_macros.c    |    2 +-
 tools/testing/selftests/bpf/progs/test_get_xattr.c |   37 +-
 .../selftests/bpf/progs/test_global_func15.c       |    2 +-
 .../selftests/bpf/progs/test_global_map_resize.c   |   18 +-
 .../bpf/progs/test_libbpf_get_fd_by_id_opts.c      |    1 +
 .../testing/selftests/bpf/progs/test_rdonly_maps.c |    3 +-
 .../selftests/bpf/progs/test_sig_in_xattr.c        |    4 +
 .../selftests/bpf/progs/test_skb_cgroup_id_kern.c  |   45 -
 .../testing/selftests/bpf/progs/test_tunnel_kern.c |   27 +-
 .../selftests/bpf/progs/test_verify_pkcs7_sig.c    |    8 +-
 tools/testing/selftests/bpf/progs/token_lsm.c      |    4 +-
 tools/testing/selftests/bpf/progs/trigger_bench.c  |    7 +
 .../testing/selftests/bpf/progs/unsupported_ops.c  |   22 +
 .../selftests/bpf/progs/uprobe_multi_consumers.c   |   39 +
 .../selftests/bpf/progs/uprobe_multi_pid_filter.c  |   40 +
 .../selftests/bpf/progs/verifier_bits_iter.c       |    2 +-
 .../selftests/bpf/progs/verifier_bpf_fastcall.c    |  900 ++++++++++++++
 tools/testing/selftests/bpf/progs/verifier_const.c |   69 ++
 .../selftests/bpf/progs/verifier_global_subprogs.c |    7 +-
 .../testing/selftests/bpf/progs/verifier_int_ptr.c |   15 +-
 .../selftests/bpf/progs/verifier_jit_convergence.c |  114 ++
 .../bpf/progs/verifier_kfunc_prog_types.c          |   48 +
 tools/testing/selftests/bpf/progs/verifier_ldsx.c  |  112 ++
 tools/testing/selftests/bpf/progs/verifier_lsm.c   |  162 +++
 .../selftests/bpf/progs/verifier_scalar_ids.c      |  256 ++--
 tools/testing/selftests/bpf/progs/verifier_sdiv.c  |  439 +++++++
 .../selftests/bpf/progs/verifier_spill_fill.c      |   24 +-
 .../bpf/progs/verifier_subprog_precision.c         |    2 +-
 .../selftests/bpf/progs/verifier_tailcall_jit.c    |  105 ++
 .../selftests/bpf/progs/verifier_vfs_accept.c      |   85 ++
 .../selftests/bpf/progs/verifier_vfs_reject.c      |  161 +++
 .../testing/selftests/bpf/progs/xdp_redirect_map.c |    6 +-
 tools/testing/selftests/bpf/test_cgroup_storage.c  |  174 ---
 tools/testing/selftests/bpf/test_cpp.cpp           |    4 +
 tools/testing/selftests/bpf/test_dev_cgroup.c      |   85 --
 tools/testing/selftests/bpf/test_loader.c          |  496 ++++++--
 tools/testing/selftests/bpf/test_lru_map.c         |    3 +-
 tools/testing/selftests/bpf/test_maps.c            |    2 +-
 tools/testing/selftests/bpf/test_progs.c           |  263 +++-
 tools/testing/selftests/bpf/test_progs.h           |   17 +-
 tools/testing/selftests/bpf/test_skb_cgroup_id.sh  |   63 -
 .../selftests/bpf/test_skb_cgroup_id_user.c        |  183 ---
 tools/testing/selftests/bpf/test_xdp_veth.sh       |  121 --
 tools/testing/selftests/bpf/testing_helpers.c      |    7 +-
 tools/testing/selftests/bpf/trace_helpers.c        |  104 +-
 tools/testing/selftests/bpf/unpriv_helpers.c       |    1 -
 tools/testing/selftests/bpf/uprobe_multi.c         |   41 +
 tools/testing/selftests/bpf/uprobe_multi.ld        |   11 +
 tools/testing/selftests/bpf/verifier/calls.c       |    2 +-
 tools/testing/selftests/bpf/verifier/map_kptr.c    |    2 +-
 tools/testing/selftests/bpf/verifier/precise.c     |   28 +-
 tools/testing/selftests/bpf/veristat.c             |   16 +-
 tools/testing/selftests/bpf/vmtest.sh              |  107 +-
 tools/testing/selftests/bpf/xskxceiver.c           |    1 +
 249 files changed, 11430 insertions(+), 3048 deletions(-)
 create mode 100644 fs/bpf_fs_kfuncs.c
 create mode 100644 kernel/bpf/btf_iter.c
 create mode 100644 kernel/bpf/btf_relocate.c
 create mode 100644 kernel/bpf/relo_core.c
 delete mode 100644 samples/bpf/tracex2.bpf.c
 delete mode 100644 samples/bpf/tracex2_user.c
 create mode 100644 tools/testing/selftests/bpf/DENYLIST.riscv64
 create mode 100644 tools/testing/selftests/bpf/config.riscv64
 create mode 100644 tools/testing/selftests/bpf/disasm_helpers.c
 create mode 100644 tools/testing/selftests/bpf/disasm_helpers.h
 delete mode 100644 tools/testing/selftests/bpf/get_cgroup_id_user.c
 create mode 100644 tools/testing/selftests/bpf/jit_disasm_helpers.c
 create mode 100644 tools/testing/selftests/bpf/jit_disasm_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/build_id.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_ancestor.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_get_current_cgroup_id.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_storage.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_mmap_inner_array.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_ancestor.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/epilogue_exit.c
 create mode 100644 tools/testing/selftests/bpf/progs/epilogue_tailcall.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_testmod.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_tailcall.c
 create mode 100644 tools/testing/selftests/bpf/progs/mmap_inner_array.c
 create mode 100644 tools/testing/selftests/bpf/progs/nested_acquire.c
 create mode 100644 tools/testing/selftests/bpf/progs/pro_epilogue.c
 create mode 100644 tools/testing/selftests/bpf/progs/pro_epilogue_goto_start.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_fentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_freplace.c
 create mode 100644 tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
 create mode 100644 tools/testing/selftests/bpf/progs/tc_dummy.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_build_id.c
 delete mode 100644 tools/testing/selftests/bpf/progs/test_skb_cgroup_id_kern.c
 create mode 100644 tools/testing/selftests/bpf/progs/unsupported_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_pid_filter.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_const.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_jit_convergence.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_lsm.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
 delete mode 100644 tools/testing/selftests/bpf/test_cgroup_storage.c
 delete mode 100644 tools/testing/selftests/bpf/test_dev_cgroup.c
 delete mode 100755 tools/testing/selftests/bpf/test_skb_cgroup_id.sh
 delete mode 100644 tools/testing/selftests/bpf/test_skb_cgroup_id_user.c
 delete mode 100755 tools/testing/selftests/bpf/test_xdp_veth.sh
 create mode 100644 tools/testing/selftests/bpf/uprobe_multi.ld

