Return-Path: <bpf+bounces-34157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B938592ABE4
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 00:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB52D1C21AB8
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 22:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350A2150986;
	Mon,  8 Jul 2024 22:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="UhHLob9/"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9867914F13A;
	Mon,  8 Jul 2024 22:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720476887; cv=none; b=Caf1y/LM5emKbziBZlR6gQlPx1kZQi41qVcXR/0Q7Sb0OSyVvRe306X/Z7jxlQN9/axNNRzeeyvD1HCC47wkUSnC1i1Y5K3ufw1QCmhqIN3MxvrKSyuqcERxnMKqfV4c1GdS7tfGyC5/DLWE/adc0loZkZu1gy1PDH1ztzG5DZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720476887; c=relaxed/simple;
	bh=6U89lkkTS3+0g2w9LZ/kMwSstzhV4ul4Li9IKWai3tk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WJ194038xHrVb2LCGRexTQEKR/2NwfrEE9JjFm0m8Rr/9SEn8Ig9IPVfDPRTSwlgSuG4VVjD60WGl2NU5e/EiU9n65bGMtcZf6v+azUOEnVt4oF9/S3pFgrsmaj9JA5WsSJOsP98BZHx82ZkuQmnxY9mL/EV6/T8O9YpMrRy6Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=UhHLob9/; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=8T0fz/ZKEufLuyuF5AkaVUraBqRWjZIXrVODIRJk0kk=; b=UhHLob9/PlszBPTMVnvtA34vnx
	MMZdonvU5HtOwTSM+G/5KY3Ym+i4aCfIc1UhZXzhczfUL23uWcDh6SkJA+nWKlp5WrV2ML6oTKE1I
	NedfFaVhbwxnyMTv+UKQhR96vHR3Oj+Kca0NdMOOUS6cV6Ij2QeIV/gGEs+8lKBNmKcAICeHmdVtL
	dUXQtF747Q47Ed8Ew9V8UHvKRlq1WsbFka0KbOnFEJKDHtpUzL+QApaI4A9aiKkOBiZhAAISw1/ej
	JDbRrQNWHTenrdZ9M3IJWDdI8XpJo2j1JJrroPH76L7W3w0zPkO0yW/qBmNxADNIHCKe28tEo4pz9
	WVz2Y21A==;
Received: from 35.248.197.178.dynamic.cust.swisscom.net ([178.197.248.35] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sQwd5-0007Yb-Rd; Tue, 09 Jul 2024 00:14:39 +0200
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
Subject: pull-request: bpf-next 2024-07-08
Date: Tue,  9 Jul 2024 00:14:38 +0200
Message-Id: <20240708221438.10974-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 0.103.10/27330/Mon Jul  8 10:36:43 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 102 non-merge commits during the last 28 day(s) which contain
a total of 127 files changed, 4606 insertions(+), 980 deletions(-).

The main changes are:

1) Support resilient split BTF which cuts down on duplication and makes BTF
   as compact as possible wrt BTF from modules, from Alan Maguire & Eduard Zingerman.

2) Add support for dumping kfunc prototypes from BTF which enables both detecting
   as well as dumping compilable prototypes for kfuncs, from Daniel Xu.

3) Batch of s390x BPF JIT improvements to add support for BPF arena and to implement
   support for BPF exceptions, from Ilya Leoshkevich.

4) Batch of riscv64 BPF JIT improvements in particular to add 12-argument support
   for BPF trampolines and to utilize bpf_prog_pack for the latter, from Pu Lehui.

5) Extend BPF test infrastructure to add a CHECKSUM_COMPLETE validation option
   for skbs and add coverage along with it, from Vadim Fedorenko.

6) Inline bpf_get_current_task/_btf() helpers in the arm64 BPF JIT which gives
   a small 1% performance improvement in micro-benchmarks, from Puranjay Mohan.

7) Extend the BPF verifier to track the delta between linked registers in order
   to better deal with recent LLVM code optimizations, from Alexei Starovoitov.

8) Fix bpf_wq_set_callback_impl() kfunc signature where the third argument should
   have been a pointer to the map value, from Benjamin Tissoires.

9) Extend BPF selftests to add regular expression support for test output matching
   and adjust some of the selftest when compiled under gcc, from Cupertino Miranda.

10) Simplify task_file_seq_get_next() and remove an unnecessary loop which always
    iterates exactly once anyway, from Dan Carpenter.

11) Add the capability to offload the netfilter flowtable in XDP layer through
    kfuncs, from Florian Westphal & Lorenzo Bianconi.

12) Various cleanups in networking helpers in BPF selftests to shave off a few
    lines of open-coded functions on client/server handling, from Geliang Tang.

13) Properly propagate prog->aux->tail_call_reachable out of BPF verifier, so
    that x86 JIT does not need to implement detection, from Leon Hwang.

14) Fix BPF verifier to add a missing check_func_arg_reg_off() to prevent an
    out-of-bounds memory access for dynpointers, from Matt Bobrowski.

15) Fix bpf_session_cookie() kfunc to return __u64 instead of long pointer as
    it might lead to problems on 32-bit archs, from Jiri Olsa.

16) Enhance traffic validation and dynamic batch size support in xsk selftests,
    from Tushar Vyavahare.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Alan Maguire, Andrii Nakryiko, Björn Töpel, Christian Brauner, Daniel 
Borkmann, David Vernet, Eduard Zingerman, Jakub Kicinski, Jiri Olsa, 
kernel test robot, Kumar Kartikeya Dwivedi, Luis Chamberlain, Maciej 
Fijalkowski, Pablo Neira Ayuso, Pu Lehui, Puranjay Mohan, Quentin 
Monnet, Song Liu, Xu Kuohai, Yonghong Song

----------------------------------------------------------------

The following changes since commit bb678f01804ccaa861b012b2b9426d69673d8a84:

  Merge branch 'intel-wired-lan-driver-updates-2024-06-03' (2024-06-10 19:52:50 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 90dc946059b7d346f077b870a8d8aaf03b4d0772:

  selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep (2024-07-08 22:24:54 +0200)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Alan Maguire (14):
      libbpf: Add btf__distill_base() creating split BTF with distilled base BTF
      selftests/bpf: Test distilled base, split BTF generation
      libbpf: Split BTF relocation
      selftests/bpf: Extend distilled BTF tests to cover BTF relocation
      resolve_btfids: Handle presence of .BTF.base section
      libbpf: BTF relocation followup fixing naming, loop logic
      module, bpf: Store BTF base pointer in struct module
      libbpf: Split field iter code into its own file kernel
      libbpf,bpf: Share BTF relocate-related code with kernel
      kbuild,bpf: Add module-specific pahole flags for distilled base BTF
      selftests/bpf: Add kfunc_call test for simple dtor in bpf_testmod
      bpf: fix build when CONFIG_DEBUG_INFO_BTF[_MODULES] is undefined
      libbpf: Fix clang compilation error in btf_relocate.c
      libbpf: Fix error handling in btf__distill_base()

Alexei Starovoitov (11):
      Merge branch 'bpf-support-dumping-kfunc-prototypes-from-btf'
      Merge branch 'fixes-for-kfunc-prototype-generation'
      Merge branch 'bpf-make-trusted-args-nullable'
      bpf: Relax tuple len requirement for sk helpers.
      bpf: Track delta between "linked" registers.
      bpf: Support can_loop/cond_break on big endian
      selftests/bpf: Add tests for add_const
      Merge branch 'bpf-verifier-correct-tail_call_reachable-for-bpf-prog'
      Merge branch 'fix-compiler-warnings-looking-for-suggestions'
      Merge branch 'use-network-helpers-part-7'
      Merge branch 'small-api-fix-for-bpf_wq'

Andreas Ziegler (1):
      libbpf: Add NULL checks to bpf_object__{prev_map,next_map}

Andrii Nakryiko (4):
      Merge branch 'bpf-support-resilient-split-btf'
      bpftool: Allow compile-time checks of BPF map auto-attach support in skeleton
      Merge branch 'regular-expression-support-for-test-output-matching'
      Merge branch 'bpf-resilient-split-btf-followups'

Antoine Tenart (1):
      libbpf: Skip base btf sanity checks

Benjamin Tissoires (2):
      bpf: helpers: fix bpf_wq_set_callback_impl signature
      selftests/bpf: amend for wrong bpf_wq_set_callback_impl signature

Cupertino Miranda (2):
      selftests/bpf: Support checks against a regular expression
      selftests/bpf: Match tests against regular expression

Dan Carpenter (1):
      bpf: Remove unnecessary loop in task_file_seq_get_next()

Daniel Xu (14):
      kbuild: bpf: Tell pahole to DECL_TAG kfuncs
      bpf: selftests: Fix bpf_iter_task_vma_new() prototype
      bpf: selftests: Fix fentry test kfunc prototypes
      bpf: selftests: Fix bpf_cpumask_first_zero() kfunc prototype
      bpf: selftests: Fix bpf_map_sum_elem_count() kfunc prototype
      bpf: Make bpf_session_cookie() kfunc return long *
      bpf: selftests: Namespace struct_opt callbacks in bpf_dctcp
      bpf: verifier: Relax caller requirements for kfunc projection type args
      bpf: treewide: Align kfunc signatures to prog point-of-view
      bpf: selftests: nf: Opt out of using generated kfunc prototypes
      bpf: selftests: xfrm: Opt out of using generated kfunc prototypes
      bpftool: Support dumping kfunc prototypes from BTF
      bpf: Fix bpf_dynptr documentation comments
      bpf: selftests: Do not use generated kfunc prototypes for arena progs

Dave Thaler (1):
      bpf, docs: Address comments from IETF Area Directors

Donglin Peng (1):
      libbpf: Checking the btf_type kind when fixing variable offsets

Eduard Zingerman (1):
      libbpf: Make btf_parse_elf process .BTF.base transparently

Florian Lehner (1):
      bpf, devmap: Add .map_alloc_check

Florian Westphal (1):
      netfilter: nf_tables: Add flowtable map for xdp offload

Geliang Tang (6):
      selftests/bpf: Drop type from network_helper_opts
      selftests/bpf: Use connect_to_addr in connect_to_fd_opt
      selftests/bpf: Add client_socket helper
      selftests/bpf: Drop noconnect from network_helper_opts
      selftests/bpf: Use start_server_str in mptcp
      selftests/bpf: Use start_server_str in test_tcp_check_syncookie_user

Ilya Leoshkevich (15):
      bpf: Fix atomic probe zero-extension
      s390/bpf: Factor out emitting probe nops
      s390/bpf: Get rid of get_probe_mem_regno()
      s390/bpf: Introduce pre- and post- probe functions
      s390/bpf: Land on the next JITed instruction after exception
      s390/bpf: Support BPF_PROBE_MEM32
      s390/bpf: Support address space cast instruction
      s390/bpf: Enable arena
      s390/bpf: Support arena atomics
      selftests/bpf: Introduce __arena_global
      selftests/bpf: Add UAF tests for arena atomics
      selftests/bpf: Remove arena tests from DENYLIST.s390x
      s390/bpf: Change seen_reg to a mask
      s390/bpf: Implement exceptions
      selftests/bpf: Remove exceptions tests from DENYLIST.s390x

Jiri Olsa (2):
      bpf: Change bpf_session_cookie return value to __u64 *
      selftests/bpf: Move ARRAY_SIZE to bpf_misc.h

Kenta Tada (1):
      bpftool: Query only cgroup-related attach types

Leon Hwang (3):
      bpf, verifier: Correct tail_call_reachable for bpf prog
      bpf, x64: Remove tail call detection
      bpf: Fix tailcall cases in test_bpf

Lorenzo Bianconi (2):
      netfilter: Add bpf_xdp_flow_lookup kfunc
      selftests/bpf: Add selftest for bpf_xdp_flow_lookup kfunc

Ma Ke (1):
      selftests/bpf: Don't close(-1) in serial_test_fexit_stress()

Matt Bobrowski (3):
      bpf: Add security_file_post_open() LSM hook to sleepable_lsm_hooks
      bpf: add missing check_func_arg_reg_off() to prevent out-of-bounds memory accesses
      bpf: add new negative selftests to cover missing check_func_arg_reg_off() and reg->type check

Mykyta Yatsenko (1):
      selftests/bpf: Test struct_ops bpf map auto-attach

Pu Lehui (6):
      bpf: Use precise image size for struct_ops trampoline
      riscv, bpf: Fix out-of-bounds issue when preparing trampoline image
      riscv, bpf: Use bpf_prog_pack for RV64 bpf trampoline
      riscv, bpf: Add 12-argument support for RV64 bpf trampoline
      selftests/bpf: Factor out many args tests from tracing_struct
      selftests/bpf: Add testcase where 7th argment is struct

Puranjay Mohan (3):
      bpf, arm64: Inline bpf_get_current_task/_btf() helpers
      riscv, bpf: Optimize stack usage of trampoline
      selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep

Rafael Passos (3):
      bpf: remove unused parameter in bpf_jit_binary_pack_finalize
      bpf: remove unused parameter in __bpf_free_used_btfs
      bpf: remove redeclaration of new_n in bpf_verifier_vlog

Tao Chen (1):
      bpftool: Mount bpffs when pinmaps path not under the bpffs

Tushar Vyavahare (2):
      selftests/xsk: Ensure traffic validation proceeds after ring size adjustment in xskxceiver
      selftests/xsk: Enhance batch size support with dynamic configurations

Vadim Fedorenko (7):
      bpf: Add CHECKSUM_COMPLETE to bpf test progs
      selftests/bpf: Validate CHECKSUM_COMPLETE option
      bpf: verifier: make kfuncs args nullalble
      bpf: crypto: make state and IV dynptr nullable
      selftests: bpf: crypto: use NULL instead of 0-sized dynptr
      selftests: bpf: crypto: adjust bench to use nullable IV
      selftests: bpf: add testmod kfunc for nullable params

Zhu Jun (1):
      selftests/bpf: Delete extra blank lines in test_sockmap

 .../bpf/standardization/instruction-set.rst        |  80 +--
 arch/arm64/net/bpf_jit_comp.c                      |  12 +-
 arch/powerpc/net/bpf_jit_comp.c                    |   4 +-
 arch/riscv/net/bpf_jit_comp64.c                    | 123 ++--
 arch/riscv/net/bpf_jit_core.c                      |   5 +-
 arch/s390/net/bpf_jit_comp.c                       | 489 +++++++++++----
 arch/x86/net/bpf_jit_comp.c                        |  15 +-
 fs/verity/measure.c                                |   5 +-
 include/linux/bpf.h                                |  11 +-
 include/linux/bpf_verifier.h                       |  12 +-
 include/linux/btf.h                                |  65 ++
 include/linux/filter.h                             |   3 +-
 include/linux/module.h                             |   2 +
 include/net/netfilter/nf_flow_table.h              |  15 +
 include/uapi/linux/bpf.h                           |   2 +
 kernel/bpf/Makefile                                |   8 +-
 kernel/bpf/bpf_lsm.c                               |   1 +
 kernel/bpf/bpf_struct_ops.c                        |   2 +-
 kernel/bpf/btf.c                                   | 189 ++++--
 kernel/bpf/core.c                                  |   8 +-
 kernel/bpf/crypto.c                                |  42 +-
 kernel/bpf/devmap.c                                |  27 +-
 kernel/bpf/helpers.c                               |  45 +-
 kernel/bpf/log.c                                   |   6 +-
 kernel/bpf/task_iter.c                             |   9 +-
 kernel/bpf/verifier.c                              | 140 ++++-
 kernel/module/main.c                               |   5 +-
 kernel/trace/bpf_trace.c                           |  15 +-
 lib/test_bpf.c                                     |  10 +
 net/bpf/test_run.c                                 |  28 +-
 net/core/filter.c                                  |  56 +-
 net/netfilter/Makefile                             |   7 +-
 net/netfilter/nf_flow_table_bpf.c                  | 121 ++++
 net/netfilter/nf_flow_table_inet.c                 |   2 +-
 net/netfilter/nf_flow_table_offload.c              |   2 +-
 net/netfilter/nf_flow_table_xdp.c                  | 147 +++++
 scripts/Makefile.btf                               |   7 +-
 scripts/Makefile.modfinal                          |   2 +-
 tools/bpf/bpftool/btf.c                            |  55 ++
 tools/bpf/bpftool/cgroup.c                         |  40 +-
 tools/bpf/bpftool/gen.c                            |   2 +
 tools/bpf/bpftool/prog.c                           |   4 +
 tools/bpf/resolve_btfids/main.c                    |   8 +
 tools/include/uapi/linux/bpf.h                     |   2 +
 tools/lib/bpf/Build                                |   2 +-
 tools/lib/bpf/btf.c                                | 662 ++++++++++++++-------
 tools/lib/bpf/btf.h                                |  36 ++
 tools/lib/bpf/btf_iter.c                           | 177 ++++++
 tools/lib/bpf/btf_relocate.c                       | 519 ++++++++++++++++
 tools/lib/bpf/libbpf.c                             |   4 +-
 tools/lib/bpf/libbpf.map                           |   2 +
 tools/lib/bpf/libbpf_internal.h                    |   3 +
 tools/lib/bpf/linker.c                             |  11 +-
 tools/testing/selftests/bpf/DENYLIST.aarch64       |   2 +-
 tools/testing/selftests/bpf/DENYLIST.s390x         |   4 -
 tools/testing/selftests/bpf/bpf_arena_common.h     |   2 +
 tools/testing/selftests/bpf/bpf_experimental.h     |  32 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h           |   2 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |  71 +++
 .../selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h  |  10 +
 tools/testing/selftests/bpf/config                 |  13 +
 tools/testing/selftests/bpf/network_helpers.c      | 100 ++--
 tools/testing/selftests/bpf/network_helpers.h      |   6 +-
 .../selftests/bpf/prog_tests/arena_atomics.c       |  18 +
 .../testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  |  37 +-
 .../testing/selftests/bpf/prog_tests/btf_distill.c | 552 +++++++++++++++++
 .../testing/selftests/bpf/prog_tests/cgroup_v1v2.c |   4 +-
 .../selftests/bpf/prog_tests/fexit_stress.c        |   4 +-
 .../selftests/bpf/prog_tests/ip_check_defrag.c     |  14 +-
 .../testing/selftests/bpf/prog_tests/kfunc_call.c  |   1 +
 .../bpf/prog_tests/kfunc_param_nullable.c          |  11 +
 tools/testing/selftests/bpf/prog_tests/mptcp.c     |   7 +-
 .../selftests/bpf/prog_tests/test_skb_pkt_end.c    |   1 +
 .../selftests/bpf/prog_tests/tracing_struct.c      |  44 +-
 .../selftests/bpf/prog_tests/xdp_flowtable.c       | 168 ++++++
 tools/testing/selftests/bpf/progs/arena_atomics.c  | 143 +++--
 tools/testing/selftests/bpf/progs/arena_htab.c     |  17 +-
 tools/testing/selftests/bpf/progs/arena_list.c     |   1 +
 tools/testing/selftests/bpf/progs/bpf_dctcp.c      |  36 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h       |  15 +-
 tools/testing/selftests/bpf/progs/crypto_bench.c   |  10 +-
 tools/testing/selftests/bpf/progs/crypto_sanity.c  |  16 +-
 tools/testing/selftests/bpf/progs/dynptr_fail.c    |  30 +-
 .../testing/selftests/bpf/progs/get_func_ip_test.c |   7 +-
 .../testing/selftests/bpf/progs/ip_check_defrag.c  |  10 +-
 tools/testing/selftests/bpf/progs/iters.c          |   2 -
 .../testing/selftests/bpf/progs/kfunc_call_test.c  |  37 ++
 .../selftests/bpf/progs/kprobe_multi_session.c     |   3 +-
 .../bpf/progs/kprobe_multi_session_cookie.c        |   2 +-
 tools/testing/selftests/bpf/progs/linked_list.c    |   5 +-
 .../testing/selftests/bpf/progs/map_percpu_stats.c |   2 +-
 .../selftests/bpf/progs/nested_trust_common.h      |   2 +-
 .../selftests/bpf/progs/netif_receive_skb.c        |   5 +-
 tools/testing/selftests/bpf/progs/profiler.inc.h   |   5 +-
 tools/testing/selftests/bpf/progs/rbtree_fail.c    |   2 +-
 .../selftests/bpf/progs/refcounted_kptr_fail.c     |   4 +-
 tools/testing/selftests/bpf/progs/setget_sockopt.c |   5 +-
 tools/testing/selftests/bpf/progs/skb_pkt_end.c    |  11 +-
 tools/testing/selftests/bpf/progs/test_bpf_ma.c    |   4 -
 tools/testing/selftests/bpf/progs/test_bpf_nf.c    |   1 +
 .../testing/selftests/bpf/progs/test_bpf_nf_fail.c |   1 +
 .../selftests/bpf/progs/test_kfunc_dynptr_param.c  |   2 +-
 .../bpf/progs/test_kfunc_param_nullable.c          |  43 ++
 .../selftests/bpf/progs/test_sysctl_loop1.c        |   5 +-
 .../selftests/bpf/progs/test_sysctl_loop2.c        |   5 +-
 .../testing/selftests/bpf/progs/test_sysctl_prog.c |   5 +-
 .../bpf/progs/test_tcp_custom_syncookie.c          |   1 +
 .../bpf/progs/test_tcp_custom_syncookie.h          |   2 -
 tools/testing/selftests/bpf/progs/tracing_struct.c |  54 --
 .../selftests/bpf/progs/tracing_struct_many_args.c |  95 +++
 .../selftests/bpf/progs/user_ringbuf_fail.c        |  22 +
 tools/testing/selftests/bpf/progs/verifier_arena.c |   1 +
 .../selftests/bpf/progs/verifier_arena_large.c     |   1 +
 .../bpf/progs/verifier_iterating_callbacks.c       | 236 ++++++++
 .../selftests/bpf/progs/verifier_netfilter_ctx.c   |   6 +-
 .../bpf/progs/verifier_subprog_precision.c         |   2 -
 tools/testing/selftests/bpf/progs/wq.c             |  19 +-
 tools/testing/selftests/bpf/progs/wq_failures.c    |   4 +-
 tools/testing/selftests/bpf/progs/xdp_flowtable.c  | 144 +++++
 .../selftests/bpf/progs/xdp_synproxy_kern.c        |   1 +
 tools/testing/selftests/bpf/progs/xfrm_info.c      |   1 +
 tools/testing/selftests/bpf/test_loader.c          | 115 +++-
 tools/testing/selftests/bpf/test_sockmap.c         |   1 -
 .../selftests/bpf/test_tcp_check_syncookie_user.c  |  29 +-
 tools/testing/selftests/bpf/verifier/precise.c     |  22 +-
 tools/testing/selftests/bpf/xskxceiver.c           |  40 +-
 tools/testing/selftests/bpf/xskxceiver.h           |   2 +
 127 files changed, 4606 insertions(+), 980 deletions(-)
 create mode 100644 net/netfilter/nf_flow_table_bpf.c
 create mode 100644 net/netfilter/nf_flow_table_xdp.c
 create mode 100644 tools/lib/bpf/btf_iter.c
 create mode 100644 tools/lib/bpf/btf_relocate.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_distill.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kfunc_param_nullable.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct_many_args.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_flowtable.c

