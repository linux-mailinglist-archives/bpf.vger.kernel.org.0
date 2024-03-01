Return-Path: <bpf+bounces-23102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B745486D844
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 01:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C91328466C
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 00:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB49637;
	Fri,  1 Mar 2024 00:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="QYZ/q6+T"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F87365;
	Fri,  1 Mar 2024 00:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709252199; cv=none; b=PGRP2IWM5hjCCKbp5jX7FzVS4yvLZPpIwME/C8ddCbYXcp0appE3JZvd0oAI397pgtRFv2Myna2Iap60mFy21+kKFHG5tkGxCvRky52tid4r41cRynG3q9VsxP/ryxsFGX26F0WFtwSwiNAITiZ2fNrRlyjFBfSn1SWPqDjXLvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709252199; c=relaxed/simple;
	bh=2bgZMV1PxUraTsjLd/SN2EA8TDrU4zGowVKnupCpz+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XqjEFJnDc3DuIjgSL20NfuJyXn0zoH/khJbV7uE74bDRiiU0KH9WSxnpkRjz0en3RcYVeZluUYQ7LsuHQFJy2qJbvSdzF/uRmOI+GzSp7b77W2viu/zCu+eSr3fM/X1Lmeq8a88FVNFZYft0m7Dqo5Q9ZB9gAT5nOL0FAJPKLwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=QYZ/q6+T; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=GZB8LyMaguCdl5FTxaeXCFpp8Y9N3LjlknfVbwWdgck=; b=QYZ/q6+TwmEPPGqpLQUBVrB8V0
	osivTT9DrSSkhLs9b6vBtaLjnrYm3F3eQOf/TFCF3iwU7caayGW2WniaRh+3OhMj3t1qoDIC25Ah7
	AaOu3PIJ3MLPPlcYJNSPZoixBJjCXrT/of3E5ydu+WekMc1XF/2u3cDo/gcVUliXG2mKb5XtDXkUr
	8REGK59V/r4lI/QU0K2/VgEbLCi1Yt4pxy6Q/wZ0FOwZXJ4gDZh6BJ+FZ8KGo7b0hIGXSLe62rorM
	mxjzBNn05RGYcgX+PVujmHrEB+e39YfC7cmF6nfjLdbAqH+dzUzyGGWOZtyVz5hC4A2cOd7bvMeUX
	vWQCIh1A==;
Received: from 31.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.31] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rfqZd-0005Ej-Ud; Fri, 01 Mar 2024 01:16:26 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf-next 2024-02-29
Date: Fri,  1 Mar 2024 01:16:25 +0100
Message-Id: <20240301001625.8800-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27200/Thu Feb 29 10:24:57 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 119 non-merge commits during the last 32 day(s) which contain
a total of 150 files changed, 3589 insertions(+), 995 deletions(-).

The main changes are:

1) Extend the BPF verifier to enable static subprog calls in spin lock critical
   sections, from Kumar Kartikeya Dwivedi.

2) Fix confusing and incorrect inference of PTR_TO_CTX argument type in BPF
   global subprogs, from Andrii Nakryiko.

3) Larger batch of riscv BPF JIT improvements and enabling inlining of the
   bpf_kptr_xchg() for RV64, from Pu Lehui.

4) Allow skeleton users to change the values of the fields in struct_ops maps at
   runtime, from Kui-Feng Lee.

5) Extend the verifier's capabilities of tracking scalars when they are spilled to
   stack, especially when the spill or fill is narrowing, from Maxim Mikityanskiy &
   Eduard Zingerman.

6) Various BPF selftest improvements to fix errors under gcc BPF backend,
   from Jose E. Marchesi.

7) Avoid module loading failure when the module trying to register a struct_ops
   has its BTF section stripped, from Geliang Tang.

8) Annotate all kfuncs in .BTF_ids section which eventually allows for automatic
   kfunc prototype generation from bpftool, from Daniel Xu.

9) Several updates to the instruction-set.rst IETF standardization document,
   from Dave Thaler.

10) Shrink the size of struct bpf_map resp. bpf_array, from Alexei Starovoitov.

11) Initial small subset of BPF verifier prepwork for sleepable bpf_timer,
    from Benjamin Tissoires.

12) Fix bpftool to be more portable to musl libc by using POSIX's basename(),
    from Arnaldo Carvalho de Melo.

13) Add libbpf support to gcc in CORE macro definitions, from Cupertino Miranda.

14) Remove a duplicate type check in perf_event_bpf_event, from Florian Lehner.

15) Fix bpf_spin_{un,}lock BPF helpers to actually annotate them with notrace
    correctly, from Yonghong Song.

16) Replace the deprecated bpf_lpm_trie_key 0-length array with flexible array
    to fix build warnings, from Kees Cook.

17) Fix resolve_btfids cross-compilation to non host-native endianness, from
    Viktor Malik.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Andrii Nakryiko, Benjamin Tissoires, Björn Töpel, Catalin Marinas, 
Daniel Borkmann, Daniel Xu, Dave Thaler, David Vernet, Eduard Zingerman, 
Gustavo A. R. Silva, Jiri Olsa, kernel test robot, Mark Rutland, Quentin 
Monnet, Song Liu, Stanislav Fomichev, Willem de Bruijn, Yafang Shao, 
Yonghong Song

----------------------------------------------------------------

The following changes since commit 723de3ebef03bc14bd72531f00f9094337654009:

  net: free altname using an RCU callback (2024-01-29 14:40:38 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 0270d69121ba7fbc449a386f989b9b7b5eaebde3:

  Merge branch 'create-shadow-types-for-struct_ops-maps-in-skeletons' (2024-02-29 14:24:07 -0800)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Alexei Starovoitov (12):
      Merge branch 'trusted-ptr_to_btf_id-arg-support-in-global-subprogs'
      Merge branch 'annotate-kfuncs-in-btf_ids-section'
      Merge branch 'two-small-fixes-for-global-subprog-tagging'
      Merge branch 'enable-static-subprog-calls-in-spin-lock-critical-sections'
      Merge branch 'transfer-rcu-lock-state-across-subprog-calls'
      Merge branch 'xsk-support-redirect-to-any-socket-bound-to-the-same-umem'
      Merge branch 'fix-global-subprog-ptr_to_ctx-arg-handling'
      selftests/bpf: Remove intermediate test files.
      bpf: Shrink size of struct bpf_map/bpf_array.
      Merge branch 'selftests-bpf-reduce-tcp_custom_syncookie-verification-complexity'
      Merge branch 'bpf-arm64-support-exceptions'
      Merge branch 'bpf-arm64-use-bpf-prog-pack-allocator-in-bpf-jit'

Andrii Nakryiko (30):
      libbpf: Fix faccessat() usage on Android
      libbpf: integrate __arg_ctx feature detector into kernel_supports()
      libbpf: fix __arg_ctx type enforcement for perf_event programs
      bpf: move arg:ctx type enforcement check inside the main logic loop
      bpf: add __arg_trusted global func arg tag
      bpf: add arg:nullable tag to be combined with trusted pointers
      libbpf: add __arg_trusted and __arg_nullable tag macros
      selftests/bpf: add trusted global subprog arg tests
      libbpf: add bpf_core_cast() macro
      selftests/bpf: convert bpf_rdonly_cast() uses to bpf_core_cast() macro
      libbpf: Call memfd_create() syscall directly
      libbpf: Add missing LIBBPF_API annotation to libbpf_set_memlock_rlim API
      libbpf: Add btf__new_split() API that was declared but not implemented
      libbpf: Add missed btf_ext__raw_data() API
      selftests/bpf: Fix bench runner SIGSEGV
      Merge branch 'improvements-for-tracking-scalars-in-the-bpf-verifier'
      bpf: handle trusted PTR_TO_BTF_ID_OR_NULL in argument check logic
      selftests/bpf: add more cases for __arg_trusted __arg_nullable args
      bpf: don't emit warnings intended for global subprogs for static subprogs
      libbpf: fix return value for PERF_EVENT __arg_ctx type fix up check
      selftests/bpf: mark dynptr kfuncs __weak to make them optional on old kernels
      Merge branch 'tools-resolve_btfids-fix-cross-compilation-to-non-host-endianness'
      bpf: simplify btf_get_prog_ctx_type() into btf_is_prog_ctx_type()
      bpf: handle bpf_user_pt_regs_t typedef explicitly for PTR_TO_CTX global arg
      bpf: don't infer PTR_TO_CTX for programs with unnamed context type
      selftests/bpf: add anonymous user struct as global subprog arg test
      bpf: emit source code file name and line number in verifier log
      bpf: Use O(log(N)) binary search to find line info record
      bpf: improve duplicate source code line detection
      Merge branch 'create-shadow-types-for-struct_ops-maps-in-skeletons'

Arnaldo Carvalho de Melo (1):
      bpftool: Be more portable by using POSIX's basename()

Benjamin Tissoires (3):
      bpf: allow more maps in sleepable bpf programs
      bpf: introduce in_sleepable() helper
      bpf: add is_async_callback_calling_insn() helper

Cupertino Miranda (1):
      libbpf: Add support to GCC in CORE macro definitions

Daniel Xu (4):
      bpf: btf: Support flags for BTF_SET8 sets
      bpf: btf: Add BTF_KFUNCS_START/END macro pair
      bpf: treewide: Annotate BPF kfuncs in BTF
      bpf: Have bpf_rdonly_cast() take a const pointer

Dave Thaler (6):
      bpf, docs: Clarify which legacy packet instructions existed
      bpf, docs: Expand set of initial conformance groups
      bpf, docs: Fix typos in instructions-set.rst
      bpf, docs: Update ISA document title
      bpf, docs: Fix typos in instruction-set.rst
      bpf, docs: specify which BPF_ABS and BPF_IND fields were zero

Eduard Zingerman (4):
      libbpf: Remove unnecessary null check in kernel_supports()
      bpf: Handle scalar spill vs all MISC in stacksafe()
      selftests/bpf: States pruning checks for scalar vs STACK_MISC
      selftests/bpf: update tcp_custom_syncookie to use scalar packet offset

Florian Lehner (1):
      perf/bpf: Fix duplicate type check

Geliang Tang (4):
      selftests/bpf: Drop return in bpf_testmod_exit
      bpf, btf: Fix return value of register_btf_id_dtor_kfuncs
      bpf, btf: Add check_btf_kconfigs helper
      bpf, btf: Check btf for register_bpf_struct_ops

Haiyue Wang (1):
      bpf,token: Use BIT_ULL() to convert the bit mask

Ian Rogers (1):
      libbpf: Add some details for BTF parsing failures

Jose E. Marchesi (6):
      bpf: Use -Wno-error in certain tests when building with GCC
      bpf: Generate const static pointers for kernel helpers
      bpf: Build type-punning BPF selftests with -fno-strict-aliasing
      bpf: Move -Wno-compare-distinct-pointer-types to BPF_CFLAGS
      bpf: Use -Wno-address-of-packed-member in some selftests
      bpf: Abstract loop unrolling pragmas in BPF selftests

Kees Cook (1):
      bpf: Replace bpf_lpm_trie_key 0-length array with flexible array

Kui-Feng Lee (13):
      bpf: Remove an unnecessary check.
      selftests/bpf: Suppress warning message of an unused variable.
      bpf: add btf pointer to struct bpf_ctx_arg_aux.
      bpf: Move __kfunc_param_match_suffix() to btf.c.
      bpf: Create argument information for nullable arguments.
      selftests/bpf: Test PTR_MAYBE_NULL arguments of struct_ops operators.
      bpf: Check cfi_stubs before registering a struct_ops type.
      selftests/bpf: Test case for lacking CFI stub functions.
      libbpf: Set btf_value_type_id of struct bpf_map for struct_ops.
      libbpf: Convert st_ops->data to shadow type.
      bpftool: Generated shadow variables for struct_ops maps.
      bpftool: Add an example for struct_ops map and shadow type.
      selftests/bpf: Test if shadow types work correctly.

Kumar Kartikeya Dwivedi (4):
      bpf: Allow calling static subprogs while holding a bpf_spin_lock
      selftests/bpf: Add test for static subprog call in lock cs
      bpf: Transfer RCU lock state between subprog calls
      selftests/bpf: Add tests for RCU lock transfer between subprogs

Magnus Karlsson (2):
      xsk: support redirect to any socket bound to the same umem
      xsk: document ability to redirect to any socket bound to the same umem

Manu Bretelle (1):
      selftests/bpf: Disable IPv6 for lwt_redirect test

Marco Elver (1):
      bpf: Allow compiler to inline most of bpf_local_storage_lookup()

Marcos Paulo de Souza (1):
      selftests/bpf: Remove empty TEST_CUSTOM_PROGS

Martin KaFai Lau (5):
      selftests/bpf: Remove "&>" usage in the selftests
      Merge branch 'libbpf: add bpf_core_cast() helper'
      Merge branch 'bpf, btf: Add DEBUG_INFO_BTF checks for __register_bpf_struct_ops'
      Merge branch 'Support PTR_MAYBE_NULL for struct_ops arguments.'
      Merge branch 'Check cfi_stubs before registering a struct_ops type.'

Martin Kelly (1):
      bpf: Clarify batch lookup/lookup_and_delete semantics

Masahiro Yamada (1):
      bpf: Merge two CONFIG_BPF entries

Matt Bobrowski (2):
      bpf: Minor clean-up to sleepable_lsm_hooks BTF set
      libbpf: Make remark about zero-initializing bpf_*_info structs

Maxim Mikityanskiy (4):
      bpf: Track spilled unbounded scalars
      selftests/bpf: Test tracking spilled unbounded scalars
      bpf: Preserve boundaries and track scalars on narrowing fill
      selftests/bpf: Add test cases for narrowing fill

Menglong Dong (1):
      bpf: Remove unused field "mod" in struct bpf_trampoline

Oliver Crumrine (1):
      bpf: remove check in __cgroup_bpf_run_filter_skb

Pu Lehui (8):
      riscv, bpf: Unify 32-bit sign-extension to emit_sextw
      riscv, bpf: Unify 32-bit zero-extension to emit_zextw
      riscv, bpf: Simplify sext and zext logics in branch instructions
      riscv, bpf: Add necessary Zbb instructions
      riscv, bpf: Optimize sign-extention mov insns with Zbb support
      riscv, bpf: Optimize bswap insns with Zbb support
      riscv, bpf: Enable inline bpf_kptr_xchg() for RV64
      selftests/bpf: Enable inline bpf_kptr_xchg() test for RV64

Puranjay Mohan (4):
      arm64: stacktrace: Implement arch_bpf_stack_walk() for the BPF JIT
      bpf, arm64: support exceptions
      arm64: patching: implement text_poke API
      bpf, arm64: use bpf_prog_pack for memory management

Shung-Hsi Yu (1):
      selftests/bpf: trace_helpers.c: do not use poisoned type

Toke Høiland-Jørgensen (1):
      libbpf: Use OPTS_SET() macro in bpf_xdp_query()

Viktor Malik (2):
      tools/resolve_btfids: Refactor set sorting with types from btf_ids.h
      tools/resolve_btfids: Fix cross-compilation to non-host endianness

Yafang Shao (2):
      selftests/bpf: Fix error checking for cpumask_success__load()
      selftests/bpf: Mark cpumask kfunc declarations as __weak

Yonghong Song (6):
      docs/bpf: Improve documentation of 64-bit immediate instructions
      selftests/bpf: Fix flaky test ptr_untrusted
      selftests/bpf: Fix flaky selftest lwt_redirect/lwt_reroute
      bpf: Mark bpf_spin_{lock,unlock}() helpers with notrace correctly
      selftests/bpf: Ensure fentry prog cannot attach to bpf_spin_{lock,unlcok}()
      bpf: Fix test verif_scale_strobemeta_subprogs failure due to llvm19

 Documentation/bpf/kfuncs.rst                       |   8 +-
 Documentation/bpf/map_lpm_trie.rst                 |   2 +-
 .../bpf/standardization/instruction-set.rst        | 155 +++++-----
 Documentation/networking/af_xdp.rst                |  33 ++-
 arch/arm64/include/asm/patching.h                  |   2 +
 arch/arm64/kernel/patching.c                       |  75 +++++
 arch/arm64/kernel/stacktrace.c                     |  26 ++
 arch/arm64/net/bpf_jit_comp.c                      | 226 +++++++++++---
 arch/riscv/net/bpf_jit.h                           | 134 +++++++++
 arch/riscv/net/bpf_jit_comp64.c                    | 215 +++++---------
 drivers/hid/bpf/hid_bpf_dispatch.c                 |   8 +-
 fs/verity/measure.c                                |   4 +-
 include/linux/bpf-cgroup.h                         |   3 +-
 include/linux/bpf.h                                |  35 ++-
 include/linux/bpf_local_storage.h                  |  30 +-
 include/linux/bpf_verifier.h                       |  10 +
 include/linux/btf.h                                |  23 +-
 include/linux/btf_ids.h                            |  21 +-
 include/linux/filter.h                             |  21 +-
 include/uapi/linux/bpf.h                           |  25 +-
 init/Kconfig                                       |   5 -
 kernel/bpf/Kconfig                                 |   1 +
 kernel/bpf/bpf_local_storage.c                     |  52 +---
 kernel/bpf/bpf_lsm.c                               |   6 +-
 kernel/bpf/bpf_struct_ops.c                        | 227 +++++++++++++--
 kernel/bpf/btf.c                                   | 275 ++++++++++++-----
 kernel/bpf/cgroup.c                                |   3 -
 kernel/bpf/cpumask.c                               |   4 +-
 kernel/bpf/helpers.c                               |  16 +-
 kernel/bpf/log.c                                   |  62 +++-
 kernel/bpf/lpm_trie.c                              |  20 +-
 kernel/bpf/map_iter.c                              |   4 +-
 kernel/bpf/token.c                                 |  16 +-
 kernel/bpf/verifier.c                              | 236 ++++++++++-----
 kernel/cgroup/rstat.c                              |   4 +-
 kernel/events/core.c                               |   6 +-
 kernel/trace/bpf_trace.c                           |   8 +-
 net/bpf/test_run.c                                 |   8 +-
 net/core/filter.c                                  |  20 +-
 net/core/xdp.c                                     |   4 +-
 net/ipv4/bpf_tcp_ca.c                              |   4 +-
 net/ipv4/fou_bpf.c                                 |   4 +-
 net/ipv4/tcp_bbr.c                                 |   4 +-
 net/ipv4/tcp_cubic.c                               |   4 +-
 net/ipv4/tcp_dctcp.c                               |   4 +-
 net/netfilter/nf_conntrack_bpf.c                   |   4 +-
 net/netfilter/nf_nat_bpf.c                         |   4 +-
 net/xdp/xsk.c                                      |   5 +-
 net/xfrm/xfrm_interface_bpf.c                      |   4 +-
 net/xfrm/xfrm_state_bpf.c                          |   4 +-
 samples/bpf/map_perf_test_user.c                   |   2 +-
 samples/bpf/xdp_router_ipv4_user.c                 |   2 +-
 scripts/bpf_doc.py                                 |   2 +-
 tools/bpf/bpftool/Documentation/bpftool-gen.rst    |  58 +++-
 tools/bpf/bpftool/gen.c                            | 246 +++++++++++++++-
 tools/bpf/resolve_btfids/main.c                    |  70 ++++-
 tools/include/linux/btf_ids.h                      |   9 +
 tools/include/uapi/linux/bpf.h                     |  25 +-
 tools/lib/bpf/bpf.h                                |  41 ++-
 tools/lib/bpf/bpf_core_read.h                      |  58 +++-
 tools/lib/bpf/bpf_helpers.h                        |   2 +
 tools/lib/bpf/btf.c                                |  33 ++-
 tools/lib/bpf/features.c                           |  58 ++++
 tools/lib/bpf/libbpf.c                             | 144 ++++-----
 tools/lib/bpf/libbpf.map                           |   5 +-
 tools/lib/bpf/libbpf_internal.h                    |  16 +
 tools/lib/bpf/linker.c                             |   2 +-
 tools/lib/bpf/netlink.c                            |   4 +-
 tools/testing/selftests/bpf/DENYLIST.aarch64       |   1 -
 tools/testing/selftests/bpf/Makefile               |  49 +++-
 tools/testing/selftests/bpf/bench.c                |  12 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h           |  20 +-
 .../testing/selftests/bpf/bpf_test_no_cfi/Makefile |  19 ++
 .../bpf/bpf_test_no_cfi/bpf_test_no_cfi.c          |  84 ++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |  34 ++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h        |  14 +-
 tools/testing/selftests/bpf/prog_tests/cpumask.c   |   6 +-
 .../selftests/bpf/prog_tests/decap_sanity.c        |   2 +-
 .../testing/selftests/bpf/prog_tests/fib_lookup.c  |   2 +-
 .../selftests/bpf/prog_tests/ip_check_defrag.c     |   4 +-
 .../selftests/bpf/prog_tests/kptr_xchg_inline.c    |   3 +-
 tools/testing/selftests/bpf/prog_tests/log_fixup.c |   4 +-
 .../testing/selftests/bpf/prog_tests/lwt_helpers.h |   2 -
 .../selftests/bpf/prog_tests/lwt_redirect.c        |   4 +-
 .../testing/selftests/bpf/prog_tests/lwt_reroute.c |   3 +-
 tools/testing/selftests/bpf/prog_tests/mptcp.c     |   2 +-
 .../selftests/bpf/prog_tests/rcu_read_lock.c       |   6 +
 .../selftests/bpf/prog_tests/sock_destroy.c        |   2 +-
 .../selftests/bpf/prog_tests/sock_iter_batch.c     |   4 +-
 tools/testing/selftests/bpf/prog_tests/spin_lock.c |   2 +
 .../selftests/bpf/prog_tests/task_local_storage.c  |   6 -
 .../bpf/prog_tests/test_struct_ops_maybe_null.c    |  46 +++
 .../bpf/prog_tests/test_struct_ops_module.c        |  19 +-
 .../bpf/prog_tests/test_struct_ops_no_cfi.c        |  35 +++
 .../testing/selftests/bpf/prog_tests/test_tunnel.c |  18 +-
 .../selftests/bpf/prog_tests/tracing_failure.c     |  37 +++
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/progs/async_stack_depth.c        |   4 +-
 tools/testing/selftests/bpf/progs/bpf_compiler.h   |  33 +++
 .../selftests/bpf/progs/cgrp_ls_recursion.c        |  26 --
 .../selftests/bpf/progs/connect_unix_prog.c        |   3 +-
 tools/testing/selftests/bpf/progs/cpumask_common.h |  57 ++--
 .../selftests/bpf/progs/getpeername_unix_prog.c    |   3 +-
 .../selftests/bpf/progs/getsockname_unix_prog.c    |   3 +-
 tools/testing/selftests/bpf/progs/iters.c          |   5 +-
 tools/testing/selftests/bpf/progs/loop4.c          |   4 +-
 tools/testing/selftests/bpf/progs/map_ptr_kern.c   |   2 +-
 tools/testing/selftests/bpf/progs/profiler.inc.h   |  17 +-
 tools/testing/selftests/bpf/progs/pyperf.h         |   7 +-
 tools/testing/selftests/bpf/progs/rcu_read_lock.c  | 120 ++++++++
 .../selftests/bpf/progs/recvmsg_unix_prog.c        |   3 +-
 .../selftests/bpf/progs/sendmsg_unix_prog.c        |   3 +-
 .../selftests/bpf/progs/sk_storage_omem_uncharge.c |   4 +-
 .../testing/selftests/bpf/progs/sock_iter_batch.c  |   4 +-
 tools/testing/selftests/bpf/progs/strobemeta.h     |  18 +-
 .../selftests/bpf/progs/struct_ops_maybe_null.c    |  29 ++
 .../bpf/progs/struct_ops_maybe_null_fail.c         |  24 ++
 .../selftests/bpf/progs/struct_ops_module.c        |  11 +-
 .../selftests/bpf/progs/task_ls_recursion.c        |  17 --
 .../selftests/bpf/progs/test_cls_redirect.c        |   7 +-
 .../selftests/bpf/progs/test_cls_redirect_dynptr.c |   2 +
 .../selftests/bpf/progs/test_global_func1.c        |   8 +-
 .../bpf/progs/test_global_func_ctx_args.c          |  19 ++
 .../selftests/bpf/progs/test_lwt_seg6local.c       |   6 +-
 .../selftests/bpf/progs/test_ptr_untrusted.c       |   6 +-
 tools/testing/selftests/bpf/progs/test_seg6_loop.c |   4 +-
 tools/testing/selftests/bpf/progs/test_skb_ctx.c   |   4 +-
 tools/testing/selftests/bpf/progs/test_spin_lock.c |  65 +++++
 .../selftests/bpf/progs/test_spin_lock_fail.c      |  44 +++
 .../selftests/bpf/progs/test_sysctl_loop1.c        |   6 +-
 .../selftests/bpf/progs/test_sysctl_loop2.c        |   6 +-
 .../testing/selftests/bpf/progs/test_sysctl_prog.c |   6 +-
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c |   5 +-
 .../bpf/progs/test_tcp_custom_syncookie.c          |  83 ++++--
 tools/testing/selftests/bpf/progs/test_xdp.c       |   3 +-
 tools/testing/selftests/bpf/progs/test_xdp_loop.c  |   3 +-
 .../selftests/bpf/progs/test_xdp_noinline.c        |   5 +-
 .../testing/selftests/bpf/progs/tracing_failure.c  |  20 ++
 tools/testing/selftests/bpf/progs/type_cast.c      |  13 +-
 .../selftests/bpf/progs/verifier_global_ptr_args.c | 182 ++++++++++++
 .../selftests/bpf/progs/verifier_global_subprogs.c |  29 ++
 .../selftests/bpf/progs/verifier_spill_fill.c      | 324 ++++++++++++++++++++-
 .../selftests/bpf/progs/verifier_spin_lock.c       |   2 +-
 .../selftests/bpf/progs/xdp_synproxy_kern.c        |   6 +-
 tools/testing/selftests/bpf/progs/xdping_kern.c    |   3 +-
 tools/testing/selftests/bpf/test_lpm_map.c         |  18 +-
 tools/testing/selftests/bpf/test_progs.h           |   7 +-
 tools/testing/selftests/bpf/testing_helpers.c      |   4 +-
 tools/testing/selftests/bpf/testing_helpers.h      |   2 +
 tools/testing/selftests/bpf/trace_helpers.c        |   2 +-
 150 files changed, 3589 insertions(+), 995 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_test_no_cfi/Makefile
 create mode 100644 tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_no_cfi.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_compiler.h
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c

