Return-Path: <bpf+bounces-18247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E90A2817E61
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 01:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338491F23835
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 00:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F23620;
	Tue, 19 Dec 2023 00:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngcHz6R7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38657F;
	Tue, 19 Dec 2023 00:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3c1a0d91eso8154635ad.2;
        Mon, 18 Dec 2023 16:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702944325; x=1703549125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+lUxS7zAALTlc03e62Mfb/42QjWQ2k+r0lTCk1SlGOo=;
        b=ngcHz6R70aquBGJGYKIEfbcygA1gZZUIlGaFDu4Ro56+3LQoT/D/j16MlWCzvXqD9g
         5dWea2wTKLJY2J1S7sIB4P+KEzYMG3r7oVRJUHE2udd1v3V/n4Kp993u/1iJI1M8de3H
         th3HaO+xIpkZRRaHp6pOvEq1c/BVNePhUmkrpPVpvpyGNuIcONNilYVe0/wJy0BXT8A6
         YYe3ZQCBeCeqHSoq3Tk4A16shNEG+DUL/c8FI4u0Wg0cOgU2hlQmuMHVvYIlUPQvuCWH
         Q9Qazga08CncWPBTef6KJ6ANmBeUmhpVy33mzYY5yJR7zlsJwQQ0g7J7VYGSLsNhmGd/
         15Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702944325; x=1703549125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+lUxS7zAALTlc03e62Mfb/42QjWQ2k+r0lTCk1SlGOo=;
        b=luvkUqqNybrIWkuAR/6VC6IS2Jjb0GIVTlxdTinbv1EBzLBIt/cJ0BWUkOAvhMWb6I
         ndVCrDvKaPKldT3/KtOm5ox8VIHmRewSmt2u07rN64ayzgTvofOHnWEE4MlAHyT6tFj6
         Qg83S+ZDFJIUM79Hnhe9kUKUaitw18F24KVWlct2C/A0EE7YC10fBEN0+/UpcWuPdEdF
         eWfFoiNJG6UEA64WYGjXvEPoBaDzfq7PFgn7zqV/5L6EqKJoyAIp1Ns6Fz/BfaZ6uq9I
         zi7LaIdJQuTYvRwbrwghcsCA0ZjpCrljYuUYMviPUfmgW2AB5GbieLTjO9LafX+q4H1L
         ioMQ==
X-Gm-Message-State: AOJu0YyxV3oLc1bq2IK0I26uw3qQLNBnU1TVYXQPp9mYsmRxk12Mn6cc
	GbIcxqZ5kJPo1PrABK4g1cQ=
X-Google-Smtp-Source: AGHT+IGGxi0GCyBZxaFkMWVNaNFfBQDtEnaYT/asDsHChyhX5zoVw3uQfVH/8rZvwYM+GKgkGTQM5g==
X-Received: by 2002:a17:902:c449:b0:1d3:bf28:1e9f with SMTP id m9-20020a170902c44900b001d3bf281e9fmr1368182plm.79.1702944324748;
        Mon, 18 Dec 2023 16:05:24 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::4:5bf2])
        by smtp.gmail.com with ESMTPSA id 11-20020a170902c14b00b001d3bfd30886sm2177694plj.37.2023.12.18.16.05.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 18 Dec 2023 16:05:24 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	andrii@kernel.org,
	torvalds@linuxfoundation.org,
	peterz@infradead.org,
	brauner@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: pull-request: bpf-next 2023-12-18
Date: Mon, 18 Dec 2023 16:05:20 -0800
Message-Id: <20231219000520.34178-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

This PR is larger than usual and contains changes in various parts of the kernel.

The main changes are:

1) Fix kCFI bugs in BPF, from Peter Zijlstra.
End result: all forms of indirect calls from BPF into kernel and from kernel into BPF
work with CFI enabled. This allows BPF to work with CONFIG_FINEIBT=y.

2) Introduce BPF token object, from Andrii Nakryiko.
It adds an ability to delegate a subset of BPF features from privileged daemon
(e.g., systemd) through special mount options for userns-bound BPF FS to a
trusted unprivileged application. The design accommodates suggestions from
Christian Brauner and Paul Moore.
Example:
$ sudo mkdir -p /sys/fs/bpf/token
$ sudo mount -t bpf bpffs /sys/fs/bpf/token \
             -o delegate_cmds=prog_load:MAP_CREATE \
             -o delegate_progs=kprobe \
             -o delegate_attachs=xdp

3) Various verifier improvements and fixes, from Andrii Nakryiko, Andrei Matei.
 - Complete precision tracking support for register spills
 - Fix verification of possibly-zero-sized stack accesses
 - Fix access to uninit stack slots
 - Track aligned STACK_ZERO cases as imprecise spilled registers.
   It improves the verifier "instructions processed" metric from single digit
   to 50-60% for some programs.
 - Fix verifier retval logic

4) Support for VLAN tag in XDP hints, from Larysa Zaremba.

5) Allocate BPF trampoline via bpf_prog_pack mechanism, from Song Liu.
End result: better memory utilization and lower I$ miss for calls to BPF
via BPF trampoline.

6) Fix race between BPF prog accessing inner map and parallel delete, from Hou Tao.

7) Add bpf_xdp_get_xfrm_state() kfunc, from Daniel Xu.
It allows BPF interact with IPSEC infra. The intent is to support software RSS
(via XDP) for the upcoming ipsec pcpu work. Experiments on AWS demonstrate
single tunnel pcpu ipsec reaching line rate on 100G ENA nics.

8) Expand bpf_cgrp_storage to support cgroup1 non-attach, from Yafang Shao.

9) BPF file verification via fsverity, from Song Liu.
It allows BPF progs get fsverity digest.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Abaci Robot, Alan Maguire, Andrii Nakryiko, Björn Töpel, Christian 
Brauner, Daniel Borkmann, Eduard Zingerman, Eric Biggers, Hao Sun, Ilya 
Leoshkevich, Jesper Dangaard Brouer, Jiri Olsa, John Fastabend, KP 
Singh, Maciej Fijalkowski, Magnus Karlsson, Maxim Mikityanskiy, Mike 
Frysinger, Minh Le Hoang, Paul Moore, Peter Zijlstra, Sami Tolvanen, 
Shung-Hsi Yu, Song Liu, Stanislav Fomichev, Steffen Klassert, Tao Lyu, 
Tariq Toukan, Tejun Heo, Xingwei Lee, Yafang Shao, Yonghong Song

----------------------------------------------------------------

The following changes since commit 15bc81212f593fbd7bda787598418b931842dc14:

  octeon_ep: set backpressure watermark for RX queues (2023-12-01 12:14:32 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 8e432e6197cef6250dfd6fdffd41c06613c874ca:

  bpf: Ensure precise is reset to false in __mark_reg_const_zero() (2023-12-18 23:54:21 +0100)

----------------------------------------------------------------
netdev

----------------------------------------------------------------
Aleksander Lobakin (1):
      net, xdp: Allow metadata > 32

Alexei Starovoitov (17):
      Merge branch 'bpf-file-verification-with-lsm-and-fsverity'
      Merge branch 'bpf-verifier-retval-logic-fixes'
      Merge branch 'bpf-fix-the-release-of-inner-map'
      Merge branch 'complete-bpf-verifier-precision-tracking-support-for-register-spills'
      Merge branch 'bpf-token-and-bpf-fs-based-delegation'
      Merge branch 'allocate-bpf-trampoline-on-bpf_prog_pack'
      Merge branch 'bpf-fixes-for-maybe_wait_bpf_programs'
      Merge branch 'add-new-bpf_cpumask_weight-kfunc'
      Merge branch 'bpf-token-support-in-libbpf-s-bpf-object'
      Merge branch 'xdp-metadata-via-kfuncs-for-ice-vlan-hint'
      Merge branch 'bpf-use-gfp_kernel-in-bpf_event_entry_gen'
      Merge branch 'add-bpf_xdp_get_xfrm_state-kfunc'
      Merge branch 'bpf-fs-mount-options-parsing-follow-ups'
      x86/cfi,bpf: Fix bpf_exception_cb() signature
      Merge branch 'x86-cfi-bpf-fix-cfi-vs-ebpf'
      selftests/bpf: Temporarily disable dummy_struct_ops test on s390
      s390/bpf: Fix indirect trampoline generation

Andrei Matei (8):
      bpf: Minor logging improvement
      bpf: Fix verification of indirect var-off stack access
      bpf: Add verifier regression test for previous patch
      bpf: Guard stack limits against 32bit overflow
      bpf: Add some comments to stack representation
      bpf: Fix accesses to uninit stack slots
      bpf: Minor cleanup around stack bounds
      bpf: Comment on check_mem_size_reg

Andrii Nakryiko (63):
      bpf: rearrange bpf_func_state fields to save a bit of memory
      bpf: provide correct register name for exception callback retval check
      bpf: enforce precision of R0 on callback return
      bpf: enforce exact retval range on subprog/callback exit
      selftests/bpf: add selftest validating callback result is enforced
      bpf: enforce precise retval range on program exit
      bpf: unify async callback and program retval checks
      bpf: enforce precision of R0 on program/async callback return
      selftests/bpf: validate async callback return value check correctness
      selftests/bpf: adjust global_func15 test to validate prog exit precision
      bpf: simplify tnum output if a fully known constant
      bpf: support non-r10 register spill/fill to/from stack in precision tracking
      selftests/bpf: add stack access precision test
      bpf: fix check for attempt to corrupt spilled pointer
      bpf: preserve STACK_ZERO slots on partial reg spills
      selftests/bpf: validate STACK_ZERO is preserved on subreg spill
      bpf: preserve constant zero when doing partial register restore
      selftests/bpf: validate zero preservation for sub-slot loads
      bpf: track aligned STACK_ZERO cases as imprecise spilled registers
      selftests/bpf: validate precision logic in partial_stack_load_preserves_zeros
      bpf: align CAP_NET_ADMIN checks with bpf_capable() approach
      bpf: add BPF token delegation mount options to BPF FS
      bpf: introduce BPF token object
      bpf: add BPF token support to BPF_MAP_CREATE command
      bpf: add BPF token support to BPF_BTF_LOAD command
      bpf: add BPF token support to BPF_PROG_LOAD command
      bpf: take into account BPF token when fetching helper protos
      bpf: consistently use BPF token throughout BPF verifier logic
      bpf,lsm: refactor bpf_prog_alloc/bpf_prog_free LSM hooks
      bpf,lsm: refactor bpf_map_alloc/bpf_map_free LSM hooks
      bpf,lsm: add BPF token LSM hooks
      libbpf: add bpf_token_create() API
      libbpf: add BPF token support to bpf_map_create() API
      libbpf: add BPF token support to bpf_btf_load() API
      libbpf: add BPF token support to bpf_prog_load() API
      selftests/bpf: add BPF token-enabled tests
      bpf,selinux: allocate bpf_security_struct per BPF token
      bpf: rename MAX_BPF_LINK_TYPE into __MAX_BPF_LINK_TYPE for consistency
      Merge branch 'bpf-fix-verification-of-indirect-var-off-stack-access'
      Merge branch 'bpf-fix-accesses-to-uninit-stack-slots'
      selftests/bpf: fix timer/test_bad_ret subtest on test_progs-cpuv4 flavor
      bpf: handle fake register spill to stack with BPF_ST_MEM instruction
      selftests/bpf: validate fake register spill/fill precision backtracking logic
      selftests/bpf: validate eliminated global subprog is not freplaceable
      bpf: log PTR_TO_MEM memory size in verifier log
      bpf: emit more dynptr information in verifier log
      bpf: tidy up exception callback management a bit
      bpf: use bitfields for simple per-subprog bool flags
      selftests/bpf: fix compiler warnings in RELEASE=1 mode
      bpf: fail BPF_TOKEN_CREATE if no delegation option was set on BPF FS
      libbpf: split feature detectors definitions from cached results
      libbpf: further decouple feature checking logic from bpf_object
      libbpf: move feature detection code into its own file
      libbpf: wire up token_fd into feature probing logic
      libbpf: wire up BPF token support at BPF object level
      selftests/bpf: add BPF object loading tests with explicit token passing
      selftests/bpf: add tests for BPF object load with implicit token
      libbpf: support BPF token path setting through LIBBPF_BPF_TOKEN_PATH envvar
      selftests/bpf: add tests for LIBBPF_BPF_TOKEN_PATH envvar
      bpf: support symbolic BPF FS delegation mount options
      selftests/bpf: utilize string values for delegate_xxx mount options
      Merge branch 'bpf-add-check-for-negative-uprobe-multi-offset'
      bpf: Ensure precise is reset to false in __mark_reg_const_zero()

Colin Ian King (1):
      selftests/bpf: Fix spelling mistake "get_signaure_size" -> "get_signature_size"

Daniel Xu (9):
      libbpf: Add BPF_CORE_WRITE_BITFIELD() macro
      bpf: selftests: test_loader: Support __btf_path() annotation
      bpf: selftests: Add verifier tests for CO-RE bitfield writes
      bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
      bpf: selftests: test_tunnel: Setup fresh topology for each subtest
      bpf: selftests: test_tunnel: Use vmlinux.h declarations
      bpf: selftests: Move xfrm tunnel test to test_progs
      bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()
      bpf: xdp: Register generic_kfunc_set with XDP programs

Dave Marchevsky (1):
      selftests/bpf: Test bpf_kptr_xchg stashing of bpf_rb_root

David Vernet (3):
      bpf: Load vmlinux btf for any struct_ops map
      bpf: Add bpf_cpumask_weight() kfunc
      selftests/bpf: Add test for bpf_cpumask_weight() kfunc

Hou Tao (21):
      bpf: Check rcu_read_lock_trace_held() before calling bpf map helpers
      bpf: Add map and need_defer parameters to .map_fd_put_ptr()
      bpf: Set need_defer as false when clearing fd array during map free
      bpf: Defer the free of inner map when necessary
      bpf: Optimize the free of inner map
      selftests/bpf: Add test cases for inner map
      selftests/bpf: Test outer map update operations in syscall program
      bpf: Remove unnecessary wait from bpf_map_copy_value()
      bpf: Call maybe_wait_bpf_programs() only once for generic_map_update_batch()
      bpf: Add missed maybe_wait_bpf_programs() for htab of maps
      bpf: Only call maybe_wait_bpf_programs() when map operation succeeds
      bpf: Set uattr->batch.count as zero before batched update or deletion
      bpf: Update the comments in maybe_wait_bpf_programs()
      bpf: Reduce the scope of rcu_read_lock when updating fd map
      bpf: Use GFP_KERNEL in bpf_event_entry_gen()
      bpf: Limit the number of uprobes when attaching program to multiple uprobes
      bpf: Limit the number of kprobes when attaching program to multiple kprobes
      selftests/bpf: Add test for abnormal cnt during multi-uprobe attachment
      selftests/bpf: Don't use libbpf_get_error() in kprobe_multi_test
      selftests/bpf: Add test for abnormal cnt during multi-kprobe attachment
      selftests/bpf: Test the release of map btf

Jeroen van Ingen Schenau (1):
      selftests/bpf: Fix erroneous bitmask operation

Jie Jiang (1):
      bpf: Support uid and gid when mounting bpffs

Jiri Olsa (2):
      bpf: Fail uprobe multi link with negative offset
      selftests/bpf: Add more uprobe multi fail tests

Larysa Zaremba (18):
      selftests/bpf: Increase invalid metadata size
      ice: make RX hash reading code more reusable
      ice: make RX HW timestamp reading code more reusable
      ice: Make ptype internal to descriptor info processing
      ice: Introduce ice_xdp_buff
      ice: Support HW timestamp hint
      ice: Support RX hash XDP hint
      ice: Support XDP hints in AF_XDP ZC mode
      xdp: Add VLAN tag hint
      ice: Implement VLAN tag hint
      ice: use VLAN proto from ring packet context in skb path
      veth: Implement VLAN tag XDP hint
      net: make vlan_get_tag() return -ENODATA instead of -EINVAL
      mlx5: implement VLAN tag XDP hint
      selftests/bpf: Allow VLAN packets in xdp_hw_metadata
      selftests/bpf: Add flags and VLAN hint to xdp_hw_metadata
      selftests/bpf: Add AF_INET packet generation to xdp_metadata
      selftests/bpf: Check VLAN tag and proto in xdp_metadata

Maciej Fijalkowski (1):
      xsk: add functions to fill control buffer

Manu Bretelle (1):
      selftests/bpf: Fixes tests for filesystem kfuncs

Martin KaFai Lau (1):
      Merge branch 'bpf: Expand bpf_cgrp_storage to support cgroup1 non-attach case'

Matt Bobrowski (1):
      bpf: add small subset of SECURITY_PATH hooks to BPF sleepable_lsm_hooks list

Peter Zijlstra (6):
      cfi: Flip headers
      x86/cfi,bpf: Fix BPF JIT call
      x86/cfi,bpf: Fix bpf_callback_t CFI
      x86/cfi,bpf: Fix bpf_struct_ops CFI
      cfi: Add CFI_NOSEAL()
      bpf: Fix dtor CFI

Randy Dunlap (1):
      net, xdp: Correct grammar

Sergei Trofimovich (1):
      libbpf: Add pr_warn() for EINVAL cases in linker_sanity_check_elf

Song Liu (13):
      bpf: Add kfunc bpf_get_file_xattr
      bpf, fsverity: Add kfunc bpf_get_fsverity_digest
      Documentation/bpf: Add documentation for filesystem kfuncs
      selftests/bpf: Sort config in alphabetic order
      selftests/bpf: Add tests for filesystem kfuncs
      selftests/bpf: Add test that uses fsverity and xattr to sign a file
      bpf: Let bpf_prog_pack_free handle any pointer
      bpf: Adjust argument names of arch_prepare_bpf_trampoline()
      bpf: Add helpers for trampoline image management
      bpf, x86: Adjust arch_prepare_bpf_trampoline return value
      bpf: Add arch_bpf_trampoline_size()
      bpf: Use arch_bpf_trampoline_size
      x86, bpf: Use bpf_prog_pack for bpf trampoline

Stanislav Fomichev (2):
      xsk: Add missing SPDX to AF_XDP TX metadata documentation
      selftests/bpf: Make sure we trigger metadata kfuncs for dst 8080

Tiezhu Yang (1):
      test_bpf: Rename second ALU64_SMOD_X to ALU64_SMOD_K

Tushar Vyavahare (1):
      selftests/xsk: Fix for SEND_RECEIVE_UNALIGNED test

Yafang Shao (3):
      bpf: Enable bpf_cgrp_storage for cgroup1 non-attach case
      selftests/bpf: Add a new cgroup helper open_classid()
      selftests/bpf: Add selftests for cgroup1 local storage

Yang Li (1):
      bpf: Remove unused backtrack_state helper functions

YiFei Zhu (1):
      selftests/bpf: Relax time_tai test for equal timestamps in tai_forward

Yonghong Song (2):
      bpf: Fix a race condition between btf_put() and map_free()
      selftests/bpf: Remove flaky test_btf_id test

 Documentation/bpf/cpumasks.rst                     |    2 +-
 Documentation/bpf/fs_kfuncs.rst                    |   21 +
 Documentation/bpf/index.rst                        |    1 +
 Documentation/netlink/specs/netdev.yaml            |    4 +
 Documentation/networking/xdp-rx-metadata.rst       |    8 +-
 Documentation/networking/xsk-tx-metadata.rst       |    2 +
 arch/arm64/net/bpf_jit_comp.c                      |   55 +-
 arch/riscv/include/asm/cfi.h                       |    3 +-
 arch/riscv/kernel/cfi.c                            |    2 +-
 arch/riscv/net/bpf_jit_comp64.c                    |   25 +-
 arch/s390/net/bpf_jit_comp.c                       |   59 +-
 arch/x86/include/asm/cfi.h                         |  126 ++-
 arch/x86/kernel/alternative.c                      |   87 +-
 arch/x86/kernel/cfi.c                              |    4 +-
 arch/x86/net/bpf_jit_comp.c                        |  264 ++++-
 drivers/media/rc/bpf-lirc.c                        |    2 +-
 drivers/net/ethernet/intel/ice/ice.h               |    2 +
 drivers/net/ethernet/intel/ice/ice_base.c          |   15 +
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h     |  412 ++++----
 drivers/net/ethernet/intel/ice/ice_main.c          |   21 +
 drivers/net/ethernet/intel/ice/ice_ptp.c           |   22 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h           |   16 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |   19 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h          |   32 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c      |  207 +++-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h      |   18 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c           |   17 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |   15 +
 drivers/net/veth.c                                 |   19 +
 fs/verity/fsverity_private.h                       |   10 +
 fs/verity/init.c                                   |    1 +
 fs/verity/measure.c                                |   84 ++
 include/asm-generic/Kbuild                         |    1 +
 include/asm-generic/cfi.h                          |    5 +
 include/linux/bpf.h                                |  143 ++-
 include/linux/bpf_verifier.h                       |   66 +-
 include/linux/cfi.h                                |   12 +
 include/linux/filter.h                             |    4 +-
 include/linux/if_vlan.h                            |    4 +-
 include/linux/lsm_hook_defs.h                      |   15 +-
 include/linux/mlx5/device.h                        |    2 +-
 include/linux/security.h                           |   43 +-
 include/linux/skbuff.h                             |   13 +-
 include/net/xdp.h                                  |   20 +-
 include/net/xdp_sock_drv.h                         |   17 +
 include/net/xfrm.h                                 |    9 +
 include/net/xsk_buff_pool.h                        |    2 +
 include/uapi/linux/bpf.h                           |   46 +-
 include/uapi/linux/netdev.h                        |    3 +
 kernel/bpf/Makefile                                |    2 +-
 kernel/bpf/arraymap.c                              |   37 +-
 kernel/bpf/bpf_cgrp_storage.c                      |    6 +-
 kernel/bpf/bpf_lsm.c                               |   27 +-
 kernel/bpf/bpf_struct_ops.c                        |   35 +-
 kernel/bpf/btf.c                                   |   11 +-
 kernel/bpf/cgroup.c                                |    6 +-
 kernel/bpf/core.c                                  |   53 +-
 kernel/bpf/cpumask.c                               |   20 +-
 kernel/bpf/dispatcher.c                            |    7 +-
 kernel/bpf/hashtab.c                               |   12 +-
 kernel/bpf/helpers.c                               |   38 +-
 kernel/bpf/inode.c                                 |  326 ++++++-
 kernel/bpf/log.c                                   |   42 +-
 kernel/bpf/map_in_map.c                            |   17 +-
 kernel/bpf/map_in_map.h                            |    2 +-
 kernel/bpf/syscall.c                               |  294 ++++--
 kernel/bpf/tnum.c                                  |    6 -
 kernel/bpf/token.c                                 |  271 +++++
 kernel/bpf/trampoline.c                            |  101 +-
 kernel/bpf/verifier.c                              |  558 ++++++-----
 kernel/trace/bpf_trace.c                           |   84 +-
 lib/test_bpf.c                                     |    2 +-
 net/bpf/bpf_dummy_struct_ops.c                     |   38 +-
 net/bpf/test_run.c                                 |   15 +-
 net/core/filter.c                                  |   36 +-
 net/core/xdp.c                                     |   33 +
 net/ipv4/bpf_tcp_ca.c                              |   71 +-
 net/netfilter/nf_bpf_link.c                        |    2 +-
 net/xdp/xsk_buff_pool.c                            |   12 +
 net/xfrm/Makefile                                  |    1 +
 net/xfrm/xfrm_policy.c                             |    2 +
 net/xfrm/xfrm_state_bpf.c                          |  134 +++
 security/security.c                                |  101 +-
 security/selinux/hooks.c                           |   47 +-
 tools/include/uapi/linux/bpf.h                     |   46 +-
 tools/include/uapi/linux/netdev.h                  |    3 +
 tools/lib/bpf/Build                                |    2 +-
 tools/lib/bpf/bpf.c                                |   37 +-
 tools/lib/bpf/bpf.h                                |   35 +-
 tools/lib/bpf/bpf_core_read.h                      |   32 +
 tools/lib/bpf/btf.c                                |    7 +-
 tools/lib/bpf/elf.c                                |    2 -
 tools/lib/bpf/features.c                           |  478 +++++++++
 tools/lib/bpf/libbpf.c                             |  584 +++--------
 tools/lib/bpf/libbpf.h                             |   37 +-
 tools/lib/bpf/libbpf.map                           |    1 +
 tools/lib/bpf/libbpf_internal.h                    |   36 +-
 tools/lib/bpf/libbpf_probes.c                      |    8 +-
 tools/lib/bpf/linker.c                             |   24 +-
 tools/lib/bpf/str_error.h                          |    3 +
 tools/net/ynl/generated/netdev-user.c              |    1 +
 tools/testing/selftests/bpf/bpf_kfuncs.h           |   10 +
 tools/testing/selftests/bpf/cgroup_helpers.c       |   16 +
 tools/testing/selftests/bpf/cgroup_helpers.h       |    1 +
 tools/testing/selftests/bpf/config                 |    3 +-
 tools/testing/selftests/bpf/prog_tests/btf.c       |    5 -
 .../selftests/bpf/prog_tests/cgrp_local_storage.c  |   98 +-
 tools/testing/selftests/bpf/prog_tests/cpumask.c   |    1 +
 tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c |  142 +++
 .../bpf/prog_tests/global_func_dead_code.c         |   60 ++
 .../selftests/bpf/prog_tests/kprobe_multi_test.c   |   31 +-
 .../selftests/bpf/prog_tests/libbpf_probes.c       |    4 +
 .../testing/selftests/bpf/prog_tests/libbpf_str.c  |    8 +-
 .../selftests/bpf/prog_tests/local_kptr_stash.c    |   23 +
 tools/testing/selftests/bpf/prog_tests/map_btf.c   |   98 ++
 .../testing/selftests/bpf/prog_tests/map_in_map.c  |  141 +++
 tools/testing/selftests/bpf/prog_tests/syscall.c   |   30 +-
 .../testing/selftests/bpf/prog_tests/test_tunnel.c |  162 ++-
 tools/testing/selftests/bpf/prog_tests/time_tai.c  |    2 +-
 tools/testing/selftests/bpf/prog_tests/token.c     | 1031 ++++++++++++++++++++
 .../selftests/bpf/prog_tests/uprobe_multi_test.c   |  175 +++-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |    2 +
 .../selftests/bpf/prog_tests/verify_pkcs7_sig.c    |  165 +++-
 .../bpf/prog_tests/xdp_context_test_run.c          |    4 +-
 .../selftests/bpf/prog_tests/xdp_metadata.c        |  132 ++-
 .../selftests/bpf/progs/access_map_in_map.c        |   93 ++
 tools/testing/selftests/bpf/progs/bpf_misc.h       |    1 +
 .../testing/selftests/bpf/progs/bpf_tracing_net.h  |    1 +
 .../selftests/bpf/progs/cgrp_ls_recursion.c        |   84 +-
 .../selftests/bpf/progs/cgrp_ls_sleepable.c        |   61 +-
 tools/testing/selftests/bpf/progs/cgrp_ls_tp_btf.c |   82 +-
 tools/testing/selftests/bpf/progs/cpumask_common.h |    1 +
 .../testing/selftests/bpf/progs/cpumask_success.c  |   43 +
 .../selftests/bpf/progs/exceptions_assert.c        |    2 +-
 .../testing/selftests/bpf/progs/exceptions_fail.c  |    2 +-
 .../bpf/progs/freplace_dead_global_func.c          |   11 +
 tools/testing/selftests/bpf/progs/iters.c          |    2 +-
 .../testing/selftests/bpf/progs/local_kptr_stash.c |   53 +
 tools/testing/selftests/bpf/progs/map_in_map_btf.c |   73 ++
 tools/testing/selftests/bpf/progs/normal_map_btf.c |   56 ++
 tools/testing/selftests/bpf/progs/priv_map.c       |   13 +
 tools/testing/selftests/bpf/progs/priv_prog.c      |   13 +
 tools/testing/selftests/bpf/progs/syscall.c        |   96 +-
 tools/testing/selftests/bpf/progs/test_fsverity.c  |   48 +
 tools/testing/selftests/bpf/progs/test_get_xattr.c |   37 +
 .../selftests/bpf/progs/test_global_func15.c       |   34 +-
 .../selftests/bpf/progs/test_global_func16.c       |    2 +-
 .../selftests/bpf/progs/test_sig_in_xattr.c        |   83 ++
 .../testing/selftests/bpf/progs/test_tunnel_kern.c |  138 +--
 .../selftests/bpf/progs/test_verify_pkcs7_sig.c    |    8 +-
 tools/testing/selftests/bpf/progs/timer_failure.c  |   37 +-
 .../selftests/bpf/progs/user_ringbuf_fail.c        |    2 +-
 .../selftests/bpf/progs/verifier_basic_stack.c     |    8 +-
 .../selftests/bpf/progs/verifier_bitfield_write.c  |  100 ++
 .../bpf/progs/verifier_cgroup_inv_retcode.c        |    8 +-
 .../bpf/progs/verifier_direct_packet_access.c      |    2 +-
 .../selftests/bpf/progs/verifier_global_subprogs.c |   15 +-
 .../testing/selftests/bpf/progs/verifier_int_ptr.c |    7 +-
 .../bpf/progs/verifier_netfilter_retcode.c         |    2 +-
 .../selftests/bpf/progs/verifier_raw_stack.c       |    5 +-
 .../selftests/bpf/progs/verifier_spill_fill.c      |  287 ++++++
 .../selftests/bpf/progs/verifier_stack_ptr.c       |    4 +-
 .../bpf/progs/verifier_subprog_precision.c         |  137 ++-
 .../testing/selftests/bpf/progs/verifier_var_off.c |   91 +-
 .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |   38 +-
 tools/testing/selftests/bpf/progs/xdp_metadata.c   |   36 +-
 .../selftests/bpf/progs/xdp_synproxy_kern.c        |    4 +-
 tools/testing/selftests/bpf/test_loader.c          |    7 +
 tools/testing/selftests/bpf/test_tunnel.sh         |   92 --
 tools/testing/selftests/bpf/testing_helpers.h      |    3 +
 .../selftests/bpf/verifier/atomic_cmpxchg.c        |   11 -
 tools/testing/selftests/bpf/verifier/calls.c       |    4 +-
 tools/testing/selftests/bpf/verifier/precise.c     |   38 +-
 tools/testing/selftests/bpf/verify_sig_setup.sh    |   25 +
 tools/testing/selftests/bpf/veristat.c             |    2 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |   36 +-
 tools/testing/selftests/bpf/xdp_metadata.h         |   34 +-
 tools/testing/selftests/bpf/xskxceiver.c           |   25 +-
 178 files changed, 8408 insertions(+), 1798 deletions(-)
 create mode 100644 Documentation/bpf/fs_kfuncs.rst
 create mode 100644 include/asm-generic/cfi.h
 create mode 100644 kernel/bpf/token.c
 create mode 100644 net/xfrm/xfrm_state_bpf.c
 create mode 100644 tools/lib/bpf/features.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/global_func_dead_code.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_btf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_in_map.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c
 create mode 100644 tools/testing/selftests/bpf/progs/access_map_in_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_dead_global_func.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_in_map_btf.c
 create mode 100644 tools/testing/selftests/bpf/progs/normal_map_btf.c
 create mode 100644 tools/testing/selftests/bpf/progs/priv_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/priv_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_fsverity.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_get_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sig_in_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bitfield_write.c

