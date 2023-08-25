Return-Path: <bpf+bounces-8683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7F9788F4C
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 21:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9541C1C20BF7
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 19:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A27818C3F;
	Fri, 25 Aug 2023 19:43:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3D8322B;
	Fri, 25 Aug 2023 19:43:26 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3152684;
	Fri, 25 Aug 2023 12:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=2yeZvWrPXuOx5+odzuqcbm1Y9YI1/4FQbjAdVVSMiSc=; b=fSV56oqvZO9N/8mE1AoLGUUJyZ
	ZBjnYwX5g8fpaVpYlx11/6f3ybGtXzQp87jsUjzaNY4GNr8YtBORv+Tp6L3uAEgrOrx4X8URyHMCN
	afk52YCZneVDVBpA0intMs4m9JiekaiA8ItpFKiIQAMw6eESqlVQ4b6dUlXJNHimJyNp+dtMYOl7v
	2ubMPteTRgzI18P/8ZimmaOiQ22WJt46zG6DDysM6PBz6J0+mV5ayoM3bOQfsqvSbI/s1Zmhs8P/O
	hX2VvPN/S7wOH4FpYlO9AkZVj9yDEKycHHEvrjkDd/zr4aICZZ+Li52H+Y9rondJrNlMKffR6JcBT
	iWEcW82w==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qZciF-00034P-Ia; Fri, 25 Aug 2023 21:43:19 +0200
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
Subject: pull-request: bpf-next 2023-08-25
Date: Fri, 25 Aug 2023 21:43:19 +0200
Message-Id: <20230825194319.12727-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 0.103.8/27011/Fri Aug 25 09:40:47 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 87 non-merge commits during the last 8 day(s) which contain
a total of 104 files changed, 3719 insertions(+), 4212 deletions(-).

The main changes are:

1) Add multi uprobe BPF links for attaching multiple uprobes and usdt probes,
   which is significantly faster and saves extra fds, from Jiri Olsa.

2) Add support BPF cpu v4 instructions for arm64 JIT compiler, from Xu Kuohai.

3) Add support BPF cpu v4 instructions for riscv64 JIT compiler, from Pu Lehui.

4) Fix LWT BPF xmit hooks wrt their return values where propagating the result
   from skb_do_redirect() would trigger a use-after-free, from Yan Zhai.

5) Fix a BPF verifier issue related to bpf_kptr_xchg() with local kptr where the
   map's value kptr type and locally allocated obj type mismatch, from Yonghong Song.

6) Fix BPF verifier's check_func_arg_reg_off() function wrt graph root/node
   which bypassed reg->off == 0 enforcement, from Kumar Kartikeya Dwivedi.

7) Lift BPF verifier restriction in networking BPF programs to treat comparison
   of packet pointers not as a pointer leak, from Yafang Shao.

8) Remove unmaintained XDP BPF samples as they are maintained in xdp-tools
   repository out of tree, from Toke Høiland-Jørgensen.

9) Batch of fixes for the tracing programs from BPF samples in order to make
   them more libbpf-aware, from Daniel T. Lee.

10) Fix a libbpf signedness determination bug in the CO-RE relocation handling
    logic, from Andrii Nakryiko.

11) Extend libbpf to support CO-RE kfunc relocations. Also follow-up fixes
    for bpf_refcount shared ownership implementation, both from Dave Marchevsky.

12) Add a new bpf_object__unpin() API function to libbpf, from Daniel Xu.

13) Fix a memory leak in libbpf to also free btf_vmlinux when the bpf_object
    gets closed, from Hao Luo.

14) Small error output improvements to test_bpf module, from Helge Deller.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Alexei Starovoitov, Andrii Nakryiko, Björn Töpel, Dave Marchevsky, David 
Vernet, Eduard Zingerman, Florent Revest, Jiri Olsa, Jordan Griege, 
Kumar Kartikeya Dwivedi, Lorenz Bauer, Oleg Nesterov, Song Liu, Toke 
Høiland-Jørgensen, Yafang Shao, Yonghong Song

----------------------------------------------------------------

The following changes since commit c2e5f4fd1148727801a63d938cec210f16b48864:

  Merge branch 'netconsole-enable-compile-time-configuration' (2023-08-17 19:25:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to ec0ded2e02822ee6a7acb655d186af91854112cb:

  Merge branch 'bpf-refcount-followups-3-bpf_mem_free_rcu-refcounted-nodes' (2023-08-25 09:23:23 -0700)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Alexei Starovoitov (8):
      Merge branch 'remove-unnecessary-synchronizations-in-cpumap'
      Merge branch 'samples-bpf-make-bpf-programs-more-libbpf-aware'
      Merge branch 'bpf-add-multi-uprobe-link'
      Merge branch 'fix-for-check_func_arg_reg_off'
      Merge branch 'bpf-fix-an-issue-in-verifing-allow_ptr_leaks'
      Merge branch 'samples-bpf-remove-unmaintained-xdp-sample-utilities'
      Merge branch 'add-support-cpu-v4-insns-for-rv64'
      Merge branch 'bpf-refcount-followups-3-bpf_mem_free_rcu-refcounted-nodes'

Andrii Nakryiko (2):
      selftests/bpf: add uprobe_multi test binary to .gitignore
      libbpf: fix signedness determination in CO-RE relo handling logic

Daniel T. Lee (9):
      samples/bpf: fix warning with ignored-attributes
      samples/bpf: convert to vmlinux.h with tracing programs
      samples/bpf: unify bpf program suffix to .bpf with tracing programs
      samples/bpf: fix symbol mismatch by compiler optimization
      samples/bpf: make tracing programs to be more CO-RE centric
      samples/bpf: fix bio latency check with tracepoint
      samples/bpf: fix broken map lookup probe
      samples/bpf: refactor syscall tracing programs using BPF_KSYSCALL macro
      samples/bpf: simplify spintest with kprobe.multi

Daniel Xu (1):
      libbpf: Add bpf_object__unpin()

Dave Marchevsky (9):
      libbpf: Support triple-underscore flavors for kfunc relocation
      selftests/bpf: Add CO-RE relocs kfunc flavors tests
      bpf: Ensure kptr_struct_meta is non-NULL for collection insert and refcount_acquire
      bpf: Consider non-owning refs trusted
      bpf: Use bpf_mem_free_rcu when bpf_obj_dropping refcounted nodes
      bpf: Reenable bpf_refcount_acquire
      bpf: Consider non-owning refs to refcounted nodes RCU protected
      bpf: Allow bpf_spin_{lock,unlock} in sleepable progs
      selftests/bpf: Add tests for rbtree API interaction in sleepable progs

Hao Luo (1):
      libbpf: Free btf_vmlinux when closing bpf_object

Helge Deller (1):
      bpf/tests: Enhance output on error and fix typos

Hou Tao (2):
      bpf, cpumap: Use queue_rcu_work() to remove unnecessary rcu_barrier()
      bpf, cpumask: Clean up bpf_cpu_map_entry directly in cpu_map_free

Jiri Olsa (28):
      bpf: Switch BPF_F_KPROBE_MULTI_RETURN macro to enum
      bpf: Add attach_type checks under bpf_prog_attach_check_attach_type
      bpf: Add multi uprobe link
      bpf: Add cookies support for uprobe_multi link
      bpf: Add pid filter support for uprobe_multi link
      bpf: Add bpf_get_func_ip helper support for uprobe link
      libbpf: Add uprobe_multi attach type and link names
      libbpf: Move elf_find_func_offset* functions to elf object
      libbpf: Add elf_open/elf_close functions
      libbpf: Add elf symbol iterator
      libbpf: Add elf_resolve_syms_offsets function
      libbpf: Add elf_resolve_pattern_offsets function
      libbpf: Add bpf_link_create support for multi uprobes
      libbpf: Add bpf_program__attach_uprobe_multi function
      libbpf: Add support for u[ret]probe.multi[.s] program sections
      libbpf: Add uprobe multi link detection
      libbpf: Add uprobe multi link support to bpf_program__attach_usdt
      selftests/bpf: Move get_time_ns to testing_helpers.h
      selftests/bpf: Add uprobe_multi skel test
      selftests/bpf: Add uprobe_multi api test
      selftests/bpf: Add uprobe_multi link test
      selftests/bpf: Add uprobe_multi test program
      selftests/bpf: Add uprobe_multi bench test
      selftests/bpf: Add uprobe_multi usdt test code
      selftests/bpf: Add uprobe_multi usdt bench test
      selftests/bpf: Add uprobe_multi cookie test
      selftests/bpf: Add uprobe_multi pid filter tests
      selftests/bpf: Add extra link to uprobe_multi tests

Kumar Kartikeya Dwivedi (2):
      bpf: Fix check_func_arg_reg_off bug for graph root/node
      selftests/bpf: Add test for bpf_obj_drop with bad reg->off

Pu Lehui (7):
      riscv, bpf: Fix missing exception handling and redundant zext for LDX_B/H/W
      riscv, bpf: Support sign-extension load insns
      riscv, bpf: Support sign-extension mov insns
      riscv, bpf: Support 32-bit offset jmp insn
      riscv, bpf: Support signed div/mod insns
      riscv, bpf: Support unconditional bswap insn
      selftests/bpf: Enable cpu v4 tests for RV64

Toke Høiland-Jørgensen (7):
      samples/bpf: Remove the xdp_monitor utility
      samples/bpf: Remove the xdp_redirect* utilities
      samples/bpf: Remove the xdp_rxq_info utility
      samples/bpf: Remove the xdp1 and xdp2 utilities
      samples/bpf: Remove the xdp_sample_pkts utility
      samples/bpf: Cleanup .gitignore
      samples/bpf: Add note to README about the XDP utilities moved to xdp-tools

Xu Kuohai (7):
      arm64: insn: Add encoders for LDRSB/LDRSH/LDRSW
      bpf, arm64: Support sign-extension load instructions
      bpf, arm64: Support sign-extension mov instructions
      bpf, arm64: Support unconditional bswap
      bpf, arm64: Support 32-bit offset jmp instruction
      bpf, arm64: Support signed div/mod instructions
      selftests/bpf: Enable cpu v4 tests for arm64

Yafang Shao (2):
      bpf: Fix issue in verifying allow_ptr_leaks
      selftests/bpf: Add selftest for allow_ptr_leaks

Yan Zhai (4):
      lwt: Fix return values of BPF xmit ops
      lwt: Check LWTUNNEL_XMIT_CONTINUE strictly
      selftests/bpf: Add lwt_xmit tests for BPF_REDIRECT
      selftests/bpf: Add lwt_xmit tests for BPF_REROUTE

Yonghong Song (5):
      selftests/bpf: Fix a selftest compilation error
      bpf: Fix a bpf_kptr_xchg() issue with local kptr
      selftests/bpf: Add a failure test for bpf_kptr_xchg() with local kptr
      bpf: Remove a WARN_ON_ONCE warning related to local kptr
      selftests/bpf: Add a local kptr test with no special fields

 arch/arm64/include/asm/insn.h                      |   4 +
 arch/arm64/lib/insn.c                              |   6 +
 arch/arm64/net/bpf_jit.h                           |  12 +
 arch/arm64/net/bpf_jit_comp.c                      |  91 ++-
 arch/riscv/net/bpf_jit.h                           |  30 +
 arch/riscv/net/bpf_jit_comp64.c                    | 102 +++-
 include/linux/bpf.h                                |   3 +-
 include/linux/bpf_verifier.h                       |   2 +-
 include/linux/trace_events.h                       |   6 +
 include/net/lwtunnel.h                             |   5 +-
 include/uapi/linux/bpf.h                           |  22 +-
 kernel/bpf/cpumap.c                                | 113 ++--
 kernel/bpf/helpers.c                               |   8 +-
 kernel/bpf/syscall.c                               | 135 +++--
 kernel/bpf/verifier.c                              |  94 ++--
 kernel/trace/bpf_trace.c                           | 342 +++++++++++-
 lib/test_bpf.c                                     |  12 +-
 net/core/lwt_bpf.c                                 |   7 +-
 net/ipv4/ip_output.c                               |   2 +-
 net/ipv6/ip6_output.c                              |   2 +-
 samples/bpf/.gitignore                             |  12 -
 samples/bpf/Makefile                               |  68 +--
 samples/bpf/README.rst                             |   6 +
 samples/bpf/net_shared.h                           |   2 +
 .../bpf/{offwaketime_kern.c => offwaketime.bpf.c}  |  39 +-
 samples/bpf/offwaketime_user.c                     |   2 +-
 samples/bpf/{spintest_kern.c => spintest.bpf.c}    |  27 +-
 samples/bpf/spintest_user.c                        |  24 +-
 samples/bpf/test_map_in_map.bpf.c                  |  10 +-
 samples/bpf/test_overhead_kprobe.bpf.c             |  20 +-
 samples/bpf/test_overhead_tp.bpf.c                 |  29 +-
 samples/bpf/{tracex1_kern.c => tracex1.bpf.c}      |  25 +-
 samples/bpf/tracex1_user.c                         |   2 +-
 samples/bpf/{tracex3_kern.c => tracex3.bpf.c}      |  40 +-
 samples/bpf/tracex3_user.c                         |   2 +-
 samples/bpf/{tracex4_kern.c => tracex4.bpf.c}      |   3 +-
 samples/bpf/tracex4_user.c                         |   2 +-
 samples/bpf/{tracex5_kern.c => tracex5.bpf.c}      |  12 +-
 samples/bpf/tracex5_user.c                         |   2 +-
 samples/bpf/{tracex6_kern.c => tracex6.bpf.c}      |  20 +-
 samples/bpf/tracex6_user.c                         |   2 +-
 samples/bpf/{tracex7_kern.c => tracex7.bpf.c}      |   3 +-
 samples/bpf/tracex7_user.c                         |   2 +-
 samples/bpf/xdp1_kern.c                            | 100 ----
 samples/bpf/xdp1_user.c                            | 166 ------
 samples/bpf/xdp2_kern.c                            | 125 -----
 samples/bpf/xdp_monitor.bpf.c                      |   8 -
 samples/bpf/xdp_monitor_user.c                     | 118 ----
 samples/bpf/xdp_redirect.bpf.c                     |  49 --
 samples/bpf/xdp_redirect_cpu.bpf.c                 | 539 ------------------
 samples/bpf/xdp_redirect_cpu_user.c                | 559 -------------------
 samples/bpf/xdp_redirect_map.bpf.c                 |  97 ----
 samples/bpf/xdp_redirect_map_multi.bpf.c           |  77 ---
 samples/bpf/xdp_redirect_map_multi_user.c          | 232 --------
 samples/bpf/xdp_redirect_map_user.c                | 228 --------
 samples/bpf/xdp_redirect_user.c                    | 172 ------
 samples/bpf/xdp_rxq_info_kern.c                    | 140 -----
 samples/bpf/xdp_rxq_info_user.c                    | 614 ---------------------
 samples/bpf/xdp_sample_pkts_kern.c                 |  57 --
 samples/bpf/xdp_sample_pkts_user.c                 | 196 -------
 tools/include/uapi/linux/bpf.h                     |  22 +-
 tools/lib/bpf/Build                                |   2 +-
 tools/lib/bpf/bpf.c                                |  11 +
 tools/lib/bpf/bpf.h                                |  11 +-
 tools/lib/bpf/elf.c                                | 440 +++++++++++++++
 tools/lib/bpf/libbpf.c                             | 424 +++++++-------
 tools/lib/bpf/libbpf.h                             |  52 ++
 tools/lib/bpf/libbpf.map                           |   2 +
 tools/lib/bpf/libbpf_internal.h                    |  21 +
 tools/lib/bpf/relo_core.c                          |   2 +-
 tools/lib/bpf/usdt.c                               | 116 ++--
 tools/testing/selftests/bpf/.gitignore             |   1 +
 tools/testing/selftests/bpf/Makefile               |   5 +
 tools/testing/selftests/bpf/bench.h                |   9 -
 tools/testing/selftests/bpf/config                 |   2 +
 .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |  78 +++
 .../selftests/bpf/prog_tests/kprobe_multi_test.c   |   8 -
 .../selftests/bpf/prog_tests/local_kptr_stash.c    |  33 +-
 .../testing/selftests/bpf/prog_tests/lwt_helpers.h | 139 +++++
 .../selftests/bpf/prog_tests/lwt_redirect.c        | 330 +++++++++++
 .../testing/selftests/bpf/prog_tests/lwt_reroute.c | 262 +++++++++
 .../selftests/bpf/prog_tests/refcounted_kptr.c     |  26 +
 .../testing/selftests/bpf/prog_tests/task_kfunc.c  |   2 +
 tools/testing/selftests/bpf/prog_tests/tc_bpf.c    |  36 +-
 .../selftests/bpf/prog_tests/uprobe_multi_test.c   | 415 ++++++++++++++
 .../testing/selftests/bpf/progs/local_kptr_stash.c |  28 +
 .../selftests/bpf/progs/local_kptr_stash_fail.c    |  85 +++
 .../testing/selftests/bpf/progs/refcounted_kptr.c  |  71 +++
 .../selftests/bpf/progs/refcounted_kptr_fail.c     |  28 +
 .../selftests/bpf/progs/task_kfunc_success.c       |  51 ++
 tools/testing/selftests/bpf/progs/test_ldsx_insn.c |   3 +-
 .../selftests/bpf/progs/test_lwt_redirect.c        |  90 +++
 .../testing/selftests/bpf/progs/test_lwt_reroute.c |  36 ++
 tools/testing/selftests/bpf/progs/test_tc_bpf.c    |  13 +
 tools/testing/selftests/bpf/progs/uprobe_multi.c   | 101 ++++
 .../selftests/bpf/progs/uprobe_multi_bench.c       |  15 +
 .../selftests/bpf/progs/uprobe_multi_usdt.c        |  16 +
 tools/testing/selftests/bpf/progs/verifier_bswap.c |   3 +-
 tools/testing/selftests/bpf/progs/verifier_gotol.c |   3 +-
 tools/testing/selftests/bpf/progs/verifier_ldsx.c  |   3 +-
 tools/testing/selftests/bpf/progs/verifier_movsx.c |   3 +-
 tools/testing/selftests/bpf/progs/verifier_sdiv.c  |   3 +-
 tools/testing/selftests/bpf/testing_helpers.h      |  10 +
 tools/testing/selftests/bpf/uprobe_multi.c         |  91 +++
 104 files changed, 3719 insertions(+), 4212 deletions(-)
 rename samples/bpf/{offwaketime_kern.c => offwaketime.bpf.c} (76%)
 rename samples/bpf/{spintest_kern.c => spintest.bpf.c} (67%)
 rename samples/bpf/{tracex1_kern.c => tracex1.bpf.c} (60%)
 rename samples/bpf/{tracex3_kern.c => tracex3.bpf.c} (70%)
 rename samples/bpf/{tracex4_kern.c => tracex4.bpf.c} (95%)
 rename samples/bpf/{tracex5_kern.c => tracex5.bpf.c} (90%)
 rename samples/bpf/{tracex6_kern.c => tracex6.bpf.c} (71%)
 rename samples/bpf/{tracex7_kern.c => tracex7.bpf.c} (82%)
 delete mode 100644 samples/bpf/xdp1_kern.c
 delete mode 100644 samples/bpf/xdp1_user.c
 delete mode 100644 samples/bpf/xdp2_kern.c
 delete mode 100644 samples/bpf/xdp_monitor.bpf.c
 delete mode 100644 samples/bpf/xdp_monitor_user.c
 delete mode 100644 samples/bpf/xdp_redirect.bpf.c
 delete mode 100644 samples/bpf/xdp_redirect_cpu.bpf.c
 delete mode 100644 samples/bpf/xdp_redirect_cpu_user.c
 delete mode 100644 samples/bpf/xdp_redirect_map.bpf.c
 delete mode 100644 samples/bpf/xdp_redirect_map_multi.bpf.c
 delete mode 100644 samples/bpf/xdp_redirect_map_multi_user.c
 delete mode 100644 samples/bpf/xdp_redirect_map_user.c
 delete mode 100644 samples/bpf/xdp_redirect_user.c
 delete mode 100644 samples/bpf/xdp_rxq_info_kern.c
 delete mode 100644 samples/bpf/xdp_rxq_info_user.c
 delete mode 100644 samples/bpf/xdp_sample_pkts_kern.c
 delete mode 100644 samples/bpf/xdp_sample_pkts_user.c
 create mode 100644 tools/lib/bpf/elf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_lwt_redirect.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_lwt_reroute.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c
 create mode 100644 tools/testing/selftests/bpf/uprobe_multi.c

