Return-Path: <bpf+bounces-29639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 542C48C4227
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 15:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2BB9B214E4
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 13:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF89153507;
	Mon, 13 May 2024 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="orMPQuCI"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503C4152192;
	Mon, 13 May 2024 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607687; cv=none; b=K/P3GQelXEdsMGdq8+Gz65LJR8B8M1vcqiMmDIwBsHIxLlzB2O3iIjCBQgARw6iyeMj13n9oANYKN7Cduzshx04QEh816Qpxiy+0cd/QfoTUFvyJEu3FGol9y05OtqXWG5qbXdl9KbsalMmrEgm9eqd9h5jfhadwiutZX+ykPQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607687; c=relaxed/simple;
	bh=kOtmQucOjdTVQ4C4CCGVBpAud+gWItSwdt+VC1ta+HE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=g5QrRDgR2Mmp7QnqMCql4NE9Nk6r9MIRh9bSafjmIsUhqPeZlO4MjXzIhKrrpXjZW44W72JvCYfCtuo6PzZvR/CEickF9kVJkEGllhLMkvURTrICwSFx4PP+pRIbR23aWHYBdgmhD9uPJ8ZCgFfmwtSHV+swiOG2rAt3Zqo7hz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=orMPQuCI; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=M8D91Jgd2OMdgh40j58EK2k+j4VPLZ6VACEDz24PHFg=; b=orMPQuCIzT/oDszvt9qfR5R0zU
	TNL5qoag8Gz9nE93PlbQP3fgxIExnPQtT+6S3xh0WiO8oTFykK899wGwyTEuMPN7RdCWrj2n6IL6X
	87NCAwEBfzxlFhTdPQZDKTOV3dzc5V2Ic6Ii5ZkNgkCYZovrzzY/ljotz110chulxmkkxLAmtbPkk
	V+5UAw1jrsXD8LqXlOwx8wbYLwLf9HmeEVcanNXsosGxb2HQ3Pe+udvwzmYOBjzIE0Cr+g65QzCDN
	tSt1NswtX7pHCTdGNGUsq+DnVWTmppFgXYcq/QriGGRiphZcALoNG8vlTX4m8x6d3wlt9S6ygbh8Q
	BQ05UFdw==;
Received: from mob-194-230-158-151.cgn.sunrise.net ([194.230.158.151] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1s6Vva-000DBd-I4; Mon, 13 May 2024 15:41:19 +0200
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
Subject: pull-request: bpf-next 2024-05-13
Date: Mon, 13 May 2024 15:41:14 +0200
Message-Id: <20240513134114.17575-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 0.103.10/27274/Mon May 13 10:25:26 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 119 non-merge commits during the last 14 day(s) which contain
a total of 134 files changed, 9462 insertions(+), 4742 deletions(-).

The main changes are:

1) Add BPF JIT support for 32-bit ARCv2 processors, from Shahab Vahedi.

2) Add BPF range computation improvements to the verifier in particular around XOR and OR
   operators, refactoring of checks for range computation and relaxing MUL range computation
   so that src_reg can also be an unknown scalar, from Cupertino Miranda.

3) Add support to attach kprobe BPF programs through kprobe_multi link in a session mode, meaning,
   a BPF program is attached to both function entry and return, the entry program can decide if
   the return program gets executed and the entry program can share u64 cookie value with return
   program. Session mode is a common use-case for tetragon and bpftrace, from Jiri Olsa.

4) Fix a potential overflow in libbpf's ring__consume_n() and improve libbpf as well as
   BPF selftest's struct_ops handling, from Andrii Nakryiko.

5) Improvements to BPF selftests in context of BPF gcc backend, from Jose E. Marchesi & David Faust.

6) Migrate remaining BPF selftest tests from test_sock_addr.c to prog_test-style in order to
   retire the old test, run it in BPF CI and additionally expand test coverage, from Jordan Rife.

7) Big batch for BPF selftest refactoring in order to remove duplicate code around common network
   helpers, from Geliang Tang.

8) Another batch of improvements to BPF selftests to retire obsolete bpf_tcp_helpers.h as
   everything is available vmlinux.h, from Martin KaFai Lau.

9) Fix BPF map tear-down to not walk the map twice on free when both timer and wq is
   used, from Benjamin Tissoires.

10) Fix BPF verifier assumptions about socket->sk that it can be non-NULL, from Alexei Starovoitov.

11) Change BTF build scripts to using --btf_features for pahole v1.26+, from Alan Maguire.

12) Small improvements to BPF reusing struct_size() and krealloc_array(), from Andy Shevchenko.

13) Fix s390 JIT to emit a barrier for BPF_FETCH instructions, from Ilya Leoshkevich.

14) Extend TCP ->cong_control() callback in order to feed in ack and flag parameters and
    allow write-access to tp->snd_cwnd_stamp from BPF program, from Miao Xu.

15) Add support for internal-only per-CPU instructions to inline bpf_get_smp_processor_id()
    helper call for arm64 and riscv64 BPF JITs, from Puranjay Mohan.

16) Follow-up to remove the redundant ethtool.h from tooling infrastructure,
    from Tushar Vyavahare.

17) Extend libbpf to support "module:<function>" syntax for tracing programs,
    from Viktor Malik.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Andrii Nakryiko, Björn Töpel, Eduard Zingerman, Eric Dumazet, Jakub 
Kicinski, John Fastabend, kernel test robot, Kumar Kartikeya Dwivedi, 
Liam Wisehart, Pu Lehui, Puranjay Mohan, Quentin Monnet, Toke 
Høiland-Jørgensen, Yonghong Song

----------------------------------------------------------------

The following changes since commit 89de2db19317fb89a6e9163f33c3a7b23ee75a18:

  Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next (2024-04-29 13:12:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to ba39486d2c43ba7c103c438540aa56c8bde3b6c7:

  bpf: make list_for_each_entry portable (2024-05-12 17:41:44 -0700)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Alan Maguire (1):
      kbuild,bpf: Switch to using --btf_features for pahole v1.26 and later

Alexei Starovoitov (5):
      bpf: Fix verifier assumptions about socket->sk
      Merge branch 'bpf-verifier-range-computation-improvements'
      Merge branch 'selftests-bpf-retire-bpf_tcp_helpers-h'
      Merge branch 'bpf-inline-helpers-in-arm64-and-riscv-jits'
      Merge branch 'retire-progs-test_sock_addr'

Andrii Nakryiko (17):
      Merge branch 'free-strdup-memory-in-selftests'
      libbpf: handle nulled-out program in struct_ops correctly
      selftests/bpf: validate nulled-out struct_ops program is handled properly
      Merge branch 'bpf-introduce-kprobe_multi-session-attach'
      Merge branch 'libbpf-support-module-function-syntax-for-tracing-programs'
      libbpf: better fix for handling nulled-out struct_ops program
      libbpf: fix potential overflow in ring__consume_n()
      libbpf: fix ring_buffer__consume_n() return result logic
      Merge branch 'bpf-avoid-attribute-ignored-warnings-in-gcc'
      Merge branch 'fix-number-of-arguments-in-test'
      libbpf: remove unnecessary struct_ops prog validity check
      libbpf: handle yet another corner case of nulling out struct_ops program
      selftests/bpf: add another struct_ops callback use case test
      libbpf: fix libbpf_strerror_r() handling unknown errors
      libbpf: improve early detection of doomed-to-fail BPF program loading
      selftests/bpf: validate struct_ops early failure detection logic
      selftests/bpf: shorten subtest names for struct_ops_module test

Andy Shevchenko (2):
      bpf: Use struct_size()
      bpf: Switch to krealloc_array()

Benjamin Tissoires (3):
      bpf: Do not walk twice the map on free
      bpf: Do not walk twice the hash map on free
      selftests/bpf: Drop an unused local variable

Cupertino Miranda (9):
      bpf/verifier: replace calls to mark_reg_unknown.
      bpf/verifier: refactor checks for range computation
      bpf/verifier: improve XOR and OR range computation
      selftests/bpf: XOR and OR range computation tests.
      bpf/verifier: relax MUL range computation check
      selftests/bpf: MUL range computation tests.
      selftests/bpf: Add CFLAGS per source file and runner
      selftests/bpf: Change functions definitions to support GCC
      selftests/bpf: Fix a few tests for GCC related warnings.

David Faust (1):
      bpf: avoid gcc overflow warning in test_xdp_vlan.c

Dmitrii Bundin (1):
      bpf: Include linux/types.h for u32

Geliang Tang (12):
      selftests/bpf: Free strdup memory in test_sockmap
      selftests/bpf: Free strdup memory in veristat
      selftests/bpf: Add opts argument for __start_server
      selftests/bpf: Make start_mptcp_server static
      selftests/bpf: Drop start_server_proto helper
      selftests/bpf: Add post_socket_cb for network_helper_opts
      selftests/bpf: Use start_server_addr in sockopt_inherit
      selftests/bpf: Use start_server_addr in test_tcp_check_syncookie
      selftests/bpf: Use connect_to_fd in sockopt_inherit
      selftests/bpf: Use connect_to_fd in test_tcp_check_syncookie
      selftests/bpf: Drop get_port in test_tcp_check_syncookie
      selftests/bpf: Free strdup memory in xdp_hw_metadata

Haiyue Wang (1):
      bpf: Remove redundant page mask of vmf->address

Ilya Leoshkevich (1):
      s390/bpf: Emit a barrier for BPF_FETCH instructions

Jiri Olsa (9):
      bpf: Add support for kprobe session attach
      bpf: Add support for kprobe session context
      bpf: Add support for kprobe session cookie
      libbpf: Add support for kprobe session attach
      libbpf: Add kprobe session attach type name to attach_type_name
      selftests/bpf: Add kprobe session test
      selftests/bpf: Add kprobe session cookie test
      libbpf: Fix error message in attach_kprobe_session
      libbpf: Fix error message in attach_kprobe_multi

John Hubbard (1):
      bpftool, selftests/hid/bpf: Fix 29 clang warnings

Jordan Rife (23):
      selftests/bpf: Fix bind program for big endian systems
      selftests/bpf: Implement socket kfuncs for bpf_testmod
      selftests/bpf: Implement BPF programs for kernel socket operations
      selftests/bpf: Move IPv4 and IPv6 sockaddr test cases
      selftests/bpf: Make sock configurable for each test case
      selftests/bpf: Add kernel socket operation tests
      selftests/bpf: Migrate recvmsg* return code tests to verifier_sock_addr.c
      selftests/bpf: Use program name for skel load/destroy functions
      selftests/bpf: Handle LOAD_REJECT test cases
      selftests/bpf: Handle ATTACH_REJECT test cases
      selftests/bpf: Handle SYSCALL_EPERM and SYSCALL_ENOTSUPP test cases
      selftests/bpf: Migrate WILDCARD_IP test
      selftests/bpf: Migrate sendmsg deny test cases
      selftests/bpf: Migrate sendmsg6 v4 mapped address tests
      selftests/bpf: Migrate wildcard destination rewrite test
      selftests/bpf: Migrate expected_attach_type tests
      selftests/bpf: Migrate ATTACH_REJECT test cases
      selftests/bpf: Remove redundant sendmsg test cases
      selftests/bpf: Retire test_sock_addr.(c|sh)
      selftests/bpf: Expand sockaddr program return value tests
      sefltests/bpf: Expand sockaddr hook deny tests
      selftests/bpf: Expand getsockname and getpeername tests
      selftests/bpf: Expand ATTACH_REJECT tests

Jose E. Marchesi (13):
      bpf: Missing trailing slash in tools/testing/selftests/bpf/Makefile
      libbpf: Fix bpf_ksym_exists() in GCC
      libbpf: Avoid casts from pointers to enums in bpf_tracing.h
      bpf: Avoid __hidden__ attribute in static object
      bpf: Disable some `attribute ignored' warnings in GCC
      bpf: Temporarily define BPF_NO_PRESEVE_ACCESS_INDEX for GCC
      bpf: avoid uninitialized warnings in verifier_global_subprogs.c
      bpf: avoid UB in usages of the __imm_insn macro
      bpf: guard BPF_NO_PRESERVE_ACCESS_INDEX in skb_pkt_end.c
      bpf: Avoid uninitialized value in BPF_CORE_READ_BITFIELD
      bpf: disable strict aliasing in test_global_func9.c
      bpf: ignore expected GCC warning in test_global_func10.c
      bpf: make list_for_each_entry portable

Martin KaFai Lau (16):
      Merge branch 'use network helpers, part 3'
      Merge branch 'selftests/bpf: Add sockaddr tests for kernel networking'
      Merge branch 'Add new args into tcp_congestion_ops' cong_control'
      selftests/bpf: Use bpf_tracing.h instead of bpf_tcp_helpers.h
      Merge branch 'libbpf: further struct_ops fixes and improvements'
      selftests/bpf: Remove bpf_tracing_net.h usages from two networking tests
      selftests/bpf: Add a few tcp helper functions and macros to bpf_tracing_net.h
      selftests/bpf: Reuse the tcp_sk() from the bpf_tracing_net.h
      selftests/bpf: Sanitize the SEC and inline usages in the bpf-tcp-cc tests
      selftests/bpf: Rename tcp-cc private struct in bpf_cubic and bpf_dctcp
      selftests/bpf: Use bpf_tracing_net.h in bpf_cubic
      selftests/bpf: Use bpf_tracing_net.h in bpf_dctcp
      selftests/bpf: Remove bpf_tcp_helpers.h usages from other misc bpf tcp-cc tests
      selftests/bpf: Remove the bpf_tcp_helpers.h usages from other non tcp-cc tests
      selftests/bpf: Retire bpf_tcp_helpers.h
      Merge branch 'use network helpers, part 4'

Miao Xu (3):
      tcp: Add new args for cong_control in tcp_congestion_ops
      bpf: tcp: Allow to write tp->snd_cwnd_stamp in bpf_tcp_ca
      selftests/bpf: Add test for the use of new args in cong_control

Michal Schmidt (1):
      selftests/bpf: Fix pointer arithmetic in test_xdp_do_redirect

Puranjay Mohan (6):
      bpf, arm64: Add support for lse atomics in bpf_arena
      riscv, bpf: add internal-only MOV instruction to resolve per-CPU addrs
      riscv, bpf: inline bpf_get_smp_processor_id()
      arm64, bpf: add internal-only MOV instruction to resolve per-CPU addrs
      bpf, arm64: inline bpf_get_smp_processor_id() helper
      riscv, bpf: make some atomic operations fully ordered

Shahab Vahedi (1):
      ARC: Add eBPF JIT support

Tao Chen (1):
      samples/bpf: Add valid info for VMLINUX_BTF

Tushar Vyavahare (1):
      tools: remove redundant ethtool.h from tooling infra

Vadim Fedorenko (1):
      bpf: crypto: fix build when CONFIG_CRYPTO=m

Viktor Malik (3):
      selftests/bpf: Run cgroup1_hierarchy test in own mount namespace
      libbpf: support "module: Function" syntax for tracing programs
      selftests/bpf: add tests for the "module: Function" syntax

Xiao Wang (1):
      riscv, bpf: Fix typo in comment

 Documentation/admin-guide/sysctl/net.rst           |    1 +
 Documentation/networking/filter.rst                |    4 +-
 MAINTAINERS                                        |    6 +
 arch/arc/Kbuild                                    |    1 +
 arch/arc/Kconfig                                   |    1 +
 arch/arc/net/Makefile                              |    6 +
 arch/arc/net/bpf_jit.h                             |  164 ++
 arch/arc/net/bpf_jit_arcv2.c                       | 3005 ++++++++++++++++++++
 arch/arc/net/bpf_jit_core.c                        | 1425 ++++++++++
 arch/arm64/include/asm/insn.h                      |    8 +
 arch/arm64/lib/insn.c                              |   11 +
 arch/arm64/net/bpf_jit.h                           |    8 +
 arch/arm64/net/bpf_jit_comp.c                      |   87 +-
 arch/riscv/net/bpf_jit.h                           |    4 +-
 arch/riscv/net/bpf_jit_comp64.c                    |   70 +-
 arch/s390/net/bpf_jit_comp.c                       |    8 +-
 include/linux/btf_ids.h                            |    2 +
 include/linux/filter.h                             |    1 +
 include/net/tcp.h                                  |    2 +-
 include/uapi/linux/bpf.h                           |    1 +
 kernel/bpf/Makefile                                |    2 +-
 kernel/bpf/arena.c                                 |    2 +-
 kernel/bpf/arraymap.c                              |   15 +-
 kernel/bpf/btf.c                                   |    3 +
 kernel/bpf/core.c                                  |   25 +-
 kernel/bpf/hashtab.c                               |   49 +-
 kernel/bpf/syscall.c                               |    7 +-
 kernel/bpf/verifier.c                              |  140 +-
 kernel/trace/bpf_trace.c                           |  106 +-
 net/ipv4/bpf_tcp_ca.c                              |    6 +-
 net/ipv4/tcp_bbr.c                                 |    2 +-
 net/ipv4/tcp_input.c                               |    2 +-
 samples/bpf/Makefile                               |    2 +-
 scripts/Makefile.btf                               |   15 +-
 tools/bpf/bpftool/Makefile                         |    2 +-
 tools/include/uapi/linux/bpf.h                     |    1 +
 tools/include/uapi/linux/ethtool.h                 | 2271 ---------------
 tools/lib/bpf/bpf.c                                |    1 +
 tools/lib/bpf/bpf_core_read.h                      |    1 +
 tools/lib/bpf/bpf_helpers.h                        |   17 +-
 tools/lib/bpf/bpf_tracing.h                        |   70 +-
 tools/lib/bpf/libbpf.c                             |  129 +-
 tools/lib/bpf/libbpf.h                             |    4 +-
 tools/lib/bpf/ringbuf.c                            |    4 +-
 tools/lib/bpf/str_error.c                          |   16 +-
 tools/lib/bpf/usdt.bpf.h                           |   24 +-
 tools/testing/selftests/bpf/.gitignore             |    1 -
 tools/testing/selftests/bpf/DENYLIST.aarch64       |    1 -
 tools/testing/selftests/bpf/Makefile               |   40 +-
 tools/testing/selftests/bpf/bpf_arena_list.h       |    4 +-
 tools/testing/selftests/bpf/bpf_experimental.h     |   33 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h           |    3 +
 tools/testing/selftests/bpf/bpf_tcp_helpers.h      |  241 --
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |  255 ++
 .../selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h  |   27 +
 tools/testing/selftests/bpf/cgroup_helpers.c       |    3 +
 tools/testing/selftests/bpf/network_helpers.c      |   49 +-
 tools/testing/selftests/bpf/network_helpers.h      |    5 +-
 .../testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  |   24 +
 .../selftests/bpf/prog_tests/cgroup1_hierarchy.c   |    7 +-
 .../selftests/bpf/prog_tests/kprobe_multi_test.c   |   74 +
 .../selftests/bpf/prog_tests/module_attach.c       |    6 +
 tools/testing/selftests/bpf/prog_tests/mptcp.c     |   16 +
 tools/testing/selftests/bpf/prog_tests/sock_addr.c | 2359 ++++++++++++++-
 .../selftests/bpf/prog_tests/sockopt_inherit.c     |   64 +-
 .../bpf/prog_tests/test_struct_ops_module.c        |   96 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |    2 +
 tools/testing/selftests/bpf/prog_tests/wq.c        |    2 -
 .../selftests/bpf/prog_tests/xdp_do_redirect.c     |    4 +-
 tools/testing/selftests/bpf/progs/arena_list.c     |    2 +-
 .../bpf/progs/bench_local_storage_create.c         |    5 +-
 tools/testing/selftests/bpf/progs/bind4_prog.c     |   24 +-
 tools/testing/selftests/bpf/progs/bind6_prog.c     |   24 +-
 tools/testing/selftests/bpf/progs/bind_prog.h      |   19 +
 tools/testing/selftests/bpf/progs/bpf_cc_cubic.c   |  189 ++
 tools/testing/selftests/bpf/progs/bpf_cubic.c      |   74 +-
 tools/testing/selftests/bpf/progs/bpf_dctcp.c      |   62 +-
 .../selftests/bpf/progs/bpf_dctcp_release.c        |   10 +-
 tools/testing/selftests/bpf/progs/bpf_tcp_nogpl.c  |    8 +-
 .../testing/selftests/bpf/progs/bpf_tracing_net.h  |   52 +
 tools/testing/selftests/bpf/progs/connect4_prog.c  |   12 +-
 tools/testing/selftests/bpf/progs/connect6_prog.c  |    6 +
 .../selftests/bpf/progs/connect_unix_prog.c        |    6 +
 tools/testing/selftests/bpf/progs/cpumask_common.h |    2 +-
 .../testing/selftests/bpf/progs/cpumask_failure.c  |    3 -
 tools/testing/selftests/bpf/progs/dynptr_fail.c    |   12 +-
 tools/testing/selftests/bpf/progs/fib_lookup.c     |    2 +-
 .../selftests/bpf/progs/getpeername4_prog.c        |   24 +
 .../selftests/bpf/progs/getpeername6_prog.c        |   31 +
 .../selftests/bpf/progs/getsockname4_prog.c        |   24 +
 .../selftests/bpf/progs/getsockname6_prog.c        |   31 +
 .../selftests/bpf/progs/jeq_infer_not_null_fail.c  |    4 +
 .../selftests/bpf/progs/kprobe_multi_session.c     |   79 +
 .../bpf/progs/kprobe_multi_session_cookie.c        |   58 +
 tools/testing/selftests/bpf/progs/local_storage.c  |   20 +-
 tools/testing/selftests/bpf/progs/lsm_cgroup.c     |    8 +-
 tools/testing/selftests/bpf/progs/mptcp_sock.c     |    4 +-
 tools/testing/selftests/bpf/progs/sendmsg4_prog.c  |    6 +
 tools/testing/selftests/bpf/progs/sendmsg6_prog.c  |   57 +
 .../selftests/bpf/progs/sendmsg_unix_prog.c        |    6 +
 tools/testing/selftests/bpf/progs/skb_pkt_end.c    |    2 +
 tools/testing/selftests/bpf/progs/sock_addr_kern.c |   65 +
 .../selftests/bpf/progs/sockopt_qos_to_cc.c        |   16 +-
 .../selftests/bpf/progs/struct_ops_forgotten_cb.c  |   19 +
 .../selftests/bpf/progs/struct_ops_module.c        |    7 +
 .../selftests/bpf/progs/struct_ops_nulled_out_cb.c |   22 +
 .../selftests/bpf/progs/tcp_ca_incompl_cong_ops.c  |   12 +-
 tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c   |   28 +-
 .../selftests/bpf/progs/tcp_ca_unsupp_cong_op.c    |    2 +-
 tools/testing/selftests/bpf/progs/tcp_ca_update.c  |   18 +-
 .../selftests/bpf/progs/tcp_ca_write_sk_pacing.c   |   20 +-
 .../selftests/bpf/progs/test_btf_skc_cls_ingress.c |   16 +-
 .../selftests/bpf/progs/test_global_func10.c       |    4 +
 .../selftests/bpf/progs/test_lwt_redirect.c        |    2 +-
 .../selftests/bpf/progs/test_module_attach.c       |   23 +
 .../testing/selftests/bpf/progs/test_sock_fields.c |    5 +-
 .../testing/selftests/bpf/progs/test_tcpbpf_kern.c |   13 +-
 .../testing/selftests/bpf/progs/test_tunnel_kern.c |   47 +-
 .../selftests/bpf/progs/test_xdp_noinline.c        |   27 +-
 tools/testing/selftests/bpf/progs/test_xdp_vlan.c  |    2 +-
 tools/testing/selftests/bpf/progs/timer.c          |    3 +-
 tools/testing/selftests/bpf/progs/timer_failure.c  |    2 +-
 tools/testing/selftests/bpf/progs/timer_mim.c      |    2 +-
 .../testing/selftests/bpf/progs/timer_mim_reject.c |    2 +-
 .../testing/selftests/bpf/progs/verifier_bounds.c  |   63 +
 .../selftests/bpf/progs/verifier_global_subprogs.c |    7 +
 .../bpf/progs/verifier_iterating_callbacks.c       |    9 +-
 .../selftests/bpf/progs/verifier_sock_addr.c       |  331 +++
 tools/testing/selftests/bpf/test_sock_addr.c       | 1332 ---------
 tools/testing/selftests/bpf/test_sock_addr.sh      |   58 -
 tools/testing/selftests/bpf/test_sockmap.c         |   10 +-
 .../selftests/bpf/test_tcp_check_syncookie_user.c  |  117 +-
 tools/testing/selftests/bpf/veristat.c             |    5 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |    2 +
 134 files changed, 9462 insertions(+), 4742 deletions(-)
 create mode 100644 arch/arc/net/Makefile
 create mode 100644 arch/arc/net/bpf_jit.h
 create mode 100644 arch/arc/net/bpf_jit_arcv2.c
 create mode 100644 arch/arc/net/bpf_jit_core.c
 delete mode 100644 tools/include/uapi/linux/ethtool.h
 delete mode 100644 tools/testing/selftests/bpf/bpf_tcp_helpers.h
 create mode 100644 tools/testing/selftests/bpf/progs/bind_prog.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
 create mode 100644 tools/testing/selftests/bpf/progs/getpeername4_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/getpeername6_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/getsockname4_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/getsockname6_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_session.c
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_addr_kern.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_forgotten_cb.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nulled_out_cb.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_sock_addr.c
 delete mode 100644 tools/testing/selftests/bpf/test_sock_addr.c
 delete mode 100755 tools/testing/selftests/bpf/test_sock_addr.sh

