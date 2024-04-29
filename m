Return-Path: <bpf+bounces-28095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5435D8B59A8
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 15:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AEC428C44B
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 13:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91246F083;
	Mon, 29 Apr 2024 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="BSZe0s/n"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A6D3C482;
	Mon, 29 Apr 2024 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396625; cv=none; b=iU9yqXWh36W0GIC0xHmVX+zwwTnpnWAZs+cywZxvvL82QwV31/gSQxKopukHa3odo9GGuXZIS4aeAqp5m5yHRxB08kqh70YOE1gdpzIsic5+rowEjWYmiwIKSvSBNzkyW1CnUhQRNeqLEjzpwOUjxibUKHTouhOZl5BHqqI1suk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396625; c=relaxed/simple;
	bh=Rc0n4H+Qkh4lz3KBDRRTbGDaf8RodV06vy0ZwMersGc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=A70mYFyaRRT/D9d58b8ewiflbsa23UraEeiLyNN5l2rOiMY0mls+SecHHlqD0H4ky8dFipFAC5r1FtBx6w4s65UNyFL6mpazbIu83WSCDuhZWSM4dfaQ3KhdKYB+dByqF8KhszksJqJtT3iW6tu3u3veLtRjJEvvrAAaY0OvGMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=BSZe0s/n; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=8gQnMxhofyfXkvZgbt3nOjohSR2iUiQO/5fqZ2H0zak=; b=BSZe0s/nDeiDXmTDZnn99++5AC
	7iRvBkQgijpHube7XIQPo1EJW5aZodLCRfigraKo49V+aQdzPOcln3pLii2bENfsaBcycr52MeZGF
	6Vhf6LNy3ANpF4AJmRFoHLRQQWbCj7I8iFRFBs049TCFhVrNWkbvQUeGjXdBMZ45oxt5nPkSHv7TF
	ywndNxqwuLfQAsXxreaWIshORk0LvufbcGbrOMyb3pe04Ny4J7RSvjYDScJ1oNEY1mtd/O6BDnOU4
	pS2Cg1GZZRwDtO/G0O/haj8E7shPsCLAjnSfEz9dUp6dAtJ3UyfUmkF7ALJ386KiR9P3IQwzAHTSk
	Lnhp6lJA==;
Received: from 41.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.41] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1s1QsL-0008qf-U6; Mon, 29 Apr 2024 15:16:58 +0200
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
Subject: pull-request: bpf-next 2024-04-29
Date: Mon, 29 Apr 2024 15:16:57 +0200
Message-Id: <20240429131657.19423-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 0.103.10/27260/Mon Apr 29 10:23:47 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 147 non-merge commits during the last 32 day(s) which contain
a total of 158 files changed, 9400 insertions(+), 2213 deletions(-).

Note, the merge is conflict-free. There is a small conflict once net lands
in net-next, see also:

  https://lore.kernel.org/bpf/20240429114939.210328b0@canb.auug.org.au

The main changes are:

1) Add an internal-only BPF per-CPU instruction for resolving per-CPU memory addresses and
   implement support in x86 BPF JIT. This allows inlining per-CPU array and hashmap lookups
   and the bpf_get_smp_processor_id() helper, from Andrii Nakryiko.

2) Add BPF link support for sk_msg and sk_skb programs, from Yonghong Song.

3) Optimize x86 BPF JIT's emit_mov_imm64, and add support for various atomics in bpf_arena
   which can be JITed as a single x86 instruction, from Alexei Starovoitov.

4) Add support for passing mark with bpf_fib_lookup helper, from Anton Protopopov.

5) Add a new bpf_wq API for deferring events and refactor sleepable bpf_timer code to keep
   common code where possible, from Benjamin Tissoires.

6) Fix BPF_PROG_TEST_RUN infra with regards to bpf_dummy_struct_ops programs to check
   when NULL is passed for non-NULLable parameters, from Eduard Zingerman.

7) Harden the BPF verifier's and/or/xor value tracking, from Harishankar Vishwanathan.

8) Introduce crypto kfuncs to make BPF programs able to utilize the kernel crypto subsystem,
   from Vadim Fedorenko.

9) Various improvements to the BPF instruction set standardization doc, from Dave Thaler.

10) Extend libbpf APIs to partially consume items from the BPF ringbuffer, from Andrea Righi.

11) Bigger batch of BPF selftests refactoring to use common network helpers and to drop
    duplicate code, from Geliang Tang.

12) Support bpf_tail_call_static() helper for BPF programs with GCC 13, from Jose E. Marchesi.

13) Add bpf_preempt_{disable,enable}() kfuncs in order to allow a BPF program to have code
    sections where preemption is disabled, from Kumar Kartikeya Dwivedi.

14) Allow invoking BPF kfuncs from BPF_PROG_TYPE_SYSCALL programs, from David Vernet.

15) Extend the BPF verifier to allow different input maps for a given bpf_for_each_map_elem()
    helper call in a BPF program, from Philo Lu.

16) Add support for PROBE_MEM32 and bpf_addr_space_cast instructions for riscv64 and arm64
    JITs to enable BPF Arena, from Puranjay Mohan.

17) Shut up a false-positive KMSAN splat in interpreter mode by unpoison the stack
    memory, from Martin KaFai Lau.

18) Improve xsk selftest coverage with new tests on maximum and minimum hardware ring
    size configurations, from Tushar Vyavahare.

19) Various rST man pages fixes as well as documentation and bash completion improvements
    for bpftool, from Rameez Rehman & Quentin Monnet.

20) Fix libbpf with regards to dumping subsequent char arrays, from Quentin Deslandes.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Alexander Lobakin, Andrii Nakryiko, Arnd Bergmann, Björn Töpel, Daniel 
Borkmann, David Ahern, David Vernet, Eduard Zingerman, Herbert Xu, Jiri 
Olsa, John Fastabend, Jose E. Marchesi, kernel test robot, Kui-Feng Lee, 
Kumar Kartikeya Dwivedi, Magnus Karlsson, Naresh Kamboju, Pu Lehui, 
Quentin Monnet, Yonghong Song

----------------------------------------------------------------

The following changes since commit c602f4ca13a529b45692de4fdec96b4cdec866da:

  Merge branch 'ravb-support-describing-the-mdio-bus' (2024-03-28 18:17:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 07801a24e2f18624cd2400ce15f14569eb416c9a:

  bpf, docs: Clarify PC use in instruction-set.rst (2024-04-29 11:54:42 +0200)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Alexei Starovoitov (18):
      Merge branch 'bench-fast-in-kernel-triggering-benchmarks'
      Merge branch 'bpf-fix-a-couple-of-test-failures-with-lto-kernel'
      bpf: Avoid kfree_rcu() under lock in bpf_lpm_trie.
      Merge branch 'bpf-arm64-add-support-for-bpf-arena'
      Merge branch 'add-internal-only-bpf-per-cpu-instruction'
      bpf: Optimize emit_mov_imm64().
      Merge branch 'inline-bpf_get_branch_snapshot-bpf-helper'
      Merge branch 'bpf-allow-bpf_for_each_map_elem-helper-with-different-input-maps'
      bpf: Add support for certain atomics in bpf_arena to x86 JIT
      selftests/bpf: Add tests for atomics in bpf_arena.
      Merge branch 'bpf-add-bpf_link-support-for-sk_msg-and-sk_skb-progs'
      bpf: Fix JIT of is_mov_percpu_addr instruction.
      Merge branch 'introduce-bpf_wq'
      bpf: Don't check for recursion in bpf_wq_work.
      Merge branch 'introduce-bpf_preempt_-disable-enable'
      selftests/bpf: Fix wq test.
      bpf: Add bpf_guard_preempt() convenience macro
      Merge branch 'check-bpf_dummy_struct_ops-program-params-for-test-runs'

Andrea Righi (4):
      libbpf: Start v1.5 development cycle
      libbpf: ringbuf: Allow to consume up to a certain amount of items
      libbpf: Add ring__consume_n / ring_buffer__consume_n
      selftests/bpf: Add ring_buffer__consume_n test.

Andrii Nakryiko (19):
      selftests/bpf: rename and clean up userspace-triggered benchmarks
      selftests/bpf: add batched, mostly in-kernel BPF triggering benchmarks
      selftests/bpf: remove syscall-driven benchs, keep syscall-count only
      selftests/bpf: lazy-load trigger bench BPF programs
      bpf: add bpf_modify_return_test_tp() kfunc triggering tracepoint
      selftests/bpf: add batched tp/raw_tp/fmodret tests
      selftests/bpf: make multi-uprobe tests work in RELEASE=1 mode
      bpftool: Use __typeof__() instead of typeof() in BPF skeleton
      bpf: add special internal-only MOV instruction to resolve per-CPU addrs
      bpf: inline bpf_get_smp_processor_id() helper
      bpf: inline bpf_map_lookup_elem() for PERCPU_ARRAY maps
      bpf: inline bpf_map_lookup_elem() helper for PERCPU_HASH map
      bpf: handle CONFIG_SMP=n configuration in x86 BPF JIT
      bpf: make bpf_get_branch_snapshot() architecture-agnostic
      bpf: inline bpf_get_branch_snapshot() helper
      bpf: prevent r10 register from being marked as precise
      selftests/bpf: add fp-leaking precise subprog result tests
      Merge branch 'bpf-allow-invoking-kfuncs-from-bpf_prog_type_syscall-progs'
      Merge branch 'libbpf-api-to-partially-consume-items-from-ringbuffer'

Anton Protopopov (5):
      bpf: Add support for passing mark with bpf_fib_lookup
      selftests/bpf: Add BPF_FIB_LOOKUP_MARK tests
      bpf: Add a check for struct bpf_fib_lookup size
      bpf: Add a verbose message if map limit is reached
      bpf: Pack struct bpf_fib_lookup

Ard Biesheuvel (1):
      btf: Avoid weak external references

Arnd Bergmann (1):
      bpf: fix perf_snapshot_branch_stack link failure

Benjamin Tissoires (16):
      bpf: make timer data struct more generic
      bpf: replace bpf_timer_init with a generic helper
      bpf: replace bpf_timer_set_callback with a generic helper
      bpf: replace bpf_timer_cancel_and_free with a generic helper
      bpf: add support for bpf_wq user type
      tools: sync include/uapi/linux/bpf.h
      bpf: verifier: bail out if the argument is not a map
      bpf: add support for KF_ARG_PTR_TO_WORKQUEUE
      bpf: allow struct bpf_wq to be embedded in arraymaps and hashmaps
      selftests/bpf: add bpf_wq tests
      bpf: wq: add bpf_wq_init
      selftests/bpf: wq: add bpf_wq_init() checks
      bpf: wq: add bpf_wq_set_callback_impl
      selftests/bpf: add checks for bpf_wq_set_callback()
      bpf: add bpf_wq_start
      selftests/bpf: wq: add bpf_wq_start() checks

Chen Pei (1):
      bpf, tests: Fix typos in comments

Dave Thaler (5):
      bpf, docs: Editorial nits in instruction-set.rst
      bpf, docs: Clarify helper ID and pointer terms in instruction-set.rst
      bpf, docs: Fix formatting nit in instruction-set.rst
      bpf, docs: Add introduction for use in the ISA Internet Draft
      bpf, docs: Clarify PC use in instruction-set.rst

David Lechner (1):
      bpf: Fix typo in uapi doc comments

David Vernet (2):
      bpf: Allow invoking kfuncs from BPF_PROG_TYPE_SYSCALL progs
      selftests/bpf: Verify calling core kfuncs from BPF_PROG_TYPE_SYCALL

Eduard Zingerman (5):
      bpf: mark bpf_dummy_struct_ops.test_1 parameter as nullable
      selftests/bpf: adjust dummy_st_ops_success to detect additional error
      selftests/bpf: do not pass NULL for non-nullable params in dummy_st_ops
      bpf: check bpf_dummy_struct_ops program params for test runs
      selftests/bpf: dummy_st_ops should reject 0 for non-nullable params

Geliang Tang (17):
      selftests/bpf: Use connect_fd_to_fd in bpf_tcp_ca
      selftests/bpf: Drop settimeo in do_test
      selftests/bpf: Add pid limit for mptcpify prog
      selftests/bpf: Fix umount cgroup2 error in test_sockmap
      selftests/bpf: Add struct send_recv_arg
      selftests/bpf: Export send_recv_data helper
      selftests/bpf: Add start_server_addr helper
      selftests/bpf: Use start_server_addr in cls_redirect
      selftests/bpf: Use start_server_addr in sk_assign
      selftests/bpf: Update arguments of connect_to_addr
      selftests/bpf: Use connect_to_addr in cls_redirect
      selftests/bpf: Use connect_to_addr in sk_assign
      selftests/bpf: Fix a fd leak in error paths in open_netns
      selftests/bpf: Use log_err in open_netns/close_netns
      selftests/bpf: Use start_server_addr in test_sock_addr
      selftests/bpf: Use connect_to_addr in test_sock_addr
      selftests/bpf: Use make_sockaddr in test_sock_addr

Haiyue Wang (2):
      bpf,arena: Use helper sizeof_field in struct accessors
      bpf: update the comment for BTF_FIELDS_MAX

Harishankar Vishwanathan (1):
      bpf: Harden and/or/xor value tracking in verifier

Jason Xing (1):
      selftests/bpf: eliminate warning of get_cgroup_id_from_path()

Jiri Olsa (1):
      selftests/bpf: Add read_trace_pipe_iter function

Jose E. Marchesi (1):
      bpf_helpers.h: Define bpf_tail_call_static when building with GCC

Jose Fernandez (1):
      bpf: Improve program stats run-time calculation

Justin Stitt (1):
      bpf: Replace deprecated strncpy with strscpy

Kui-Feng Lee (1):
      selftests/bpf: Make sure libbpf doesn't enforce the signature of a func pointer.

Kumar Kartikeya Dwivedi (2):
      bpf: Introduce bpf_preempt_[disable,enable] kfuncs
      selftests/bpf: Add tests for preempt kfuncs

Martin KaFai Lau (9):
      bpf: Remove CONFIG_X86 and CONFIG_DYNAMIC_FTRACE guard from the tcp-cc kfuncs
      selftests/bpf: Test loading bpf-tcp-cc prog calling the kernel tcp-cc kfuncs
      bpf: Mark bpf prog stack with kmsan_unposion_memory in interpreter mode
      Merge branch 'Use start_server and connect_fd_to_fd'
      Merge branch 'export send_recv_data'
      Merge branch 'use network helpers, part 1'
      Merge branch 'use network helpers, part 2'
      Merge branch 'BPF crypto API framework'
      Merge branch 'bpf: add mrtt and srtt as ctx->args for BPF_SOCK_OPS_RTT_CB'

Mykyta Yatsenko (1):
      bpf: improve error message for unsupported helper

Philo Lu (5):
      bpf: store both map ptr and state in bpf_insn_aux_data
      bpf: allow invoking bpf_for_each_map_elem with different maps
      selftests/bpf: add test for bpf_for_each_map_elem() with different maps
      bpf: add mrtt and srtt as BPF_SOCK_OPS_RTT_CB args
      selftests/bpf: extend BPF_SOCK_OPS_RTT_CB test for srtt and mrtt_us

Pu Lehui (1):
      selftests/bpf: Skip test when perf_event_open returns EOPNOTSUPP

Puranjay Mohan (4):
      bpf: Add arm64 JIT support for PROBE_MEM32 pseudo instructions.
      bpf: Add arm64 JIT support for bpf_addr_space_cast instruction.
      bpf, riscv: Implement PROBE_MEM32 pseudo instructions
      bpf, riscv: Implement bpf_addr_space_cast instruction

Quentin Deslandes (2):
      libbpf: Fix misaligned array closing bracket
      libbpf: Fix dump of subsequent char arrays

Quentin Monnet (2):
      bpftool: Update documentation where progs/maps can be passed by name
      bpftool: Address minor issues in bash completion

Rafael Passos (2):
      bpf: Fix typo in function save_aux_ptr_type
      bpf: Fix typos in comments

Rameez Rehman (3):
      bpftool: Use simpler indentation in source rST for documentation
      bpftool: Remove useless emphasis on command description in man pages
      bpftool: Clean-up typos, punctuation, list formatting in docs

Sahil Siddiq (1):
      bpftool: Mount bpffs on provided dir instead of parent dir

Thorsten Blum (1):
      bpftool: Fix typo in error message

Tobias Böhm (1):
      libbpf: Use local bpf_helpers.h include

Tushar Vyavahare (7):
      tools: Add ethtool.h header to tooling infra
      selftests/xsk: Make batch size variable
      selftests/bpf: Implement get_hw_ring_size function to retrieve current and max interface size
      selftests/bpf: Implement set_hw_ring_size function to configure interface ring size
      selftests/xsk: Introduce set_ring_size function with a retry mechanism for handling AF_XDP socket closures
      selftests/xsk: Test AF_XDP functionality under minimal ring configurations
      selftests/xsk: Add new test case for AF_XDP under max ring sizes

Vadim Fedorenko (4):
      bpf: make common crypto API for TC/XDP programs
      bpf: crypto: add skcipher to bpf crypto
      selftests: bpf: crypto skcipher algo selftests
      selftests: bpf: crypto: add benchmark for crypto functions

Yafang Shao (1):
      bpf: Mitigate latency spikes associated with freeing non-preallocated htab

Yonghong Song (15):
      selftests/bpf: Replace CHECK with ASSERT macros for ksyms test
      libbpf: Mark libbpf_kallsyms_parse static function
      libbpf: Handle <orig_name>.llvm.<hash> symbol properly
      selftests/bpf: Refactor some functions for kprobe_multi_test
      selftests/bpf: Refactor trace helper func load_kallsyms_local()
      selftests/bpf: Add {load,search}_kallsyms_custom_local()
      selftests/bpf: Fix kprobe_multi_bench_attach test failure with LTO kernel
      selftests/bpf: Add a kprobe_multi subtest to use addrs instead of syms
      selftests/bpf: Using llvm may_goto inline asm for cond_break macro
      bpf: Add bpf_link support for sk_msg and sk_skb progs
      libbpf: Add bpf_link support for BPF_PROG_TYPE_SOCKMAP
      bpftool: Add link dump support for BPF_LINK_TYPE_SOCKMAP
      selftests/bpf: Refactor out helper functions for a few tests
      selftests/bpf: Add some tests with new bpf_program__attach_sockmap() APIs
      selftests/bpf: Enable tests for atomics with cpuv4

 .../bpf/standardization/instruction-set.rst        |  109 +-
 MAINTAINERS                                        |    8 +
 arch/arm64/net/bpf_jit_comp.c                      |   86 +-
 arch/riscv/net/bpf_jit.h                           |    2 +
 arch/riscv/net/bpf_jit_comp64.c                    |  203 +-
 arch/riscv/net/bpf_jit_core.c                      |    2 +
 arch/x86/net/bpf_jit_comp.c                        |   92 +-
 crypto/Makefile                                    |    3 +
 crypto/bpf_crypto_skcipher.c                       |   82 +
 include/linux/bpf.h                                |   22 +-
 include/linux/bpf_crypto.h                         |   24 +
 include/linux/bpf_verifier.h                       |   11 +-
 include/linux/filter.h                             |   30 +-
 include/linux/skmsg.h                              |    4 +
 include/net/tcp.h                                  |    4 +-
 include/trace/events/bpf_test_run.h                |   17 +
 include/uapi/linux/bpf.h                           |   37 +-
 kernel/bpf/Makefile                                |    3 +
 kernel/bpf/arena.c                                 |    2 +-
 kernel/bpf/arraymap.c                              |   51 +-
 kernel/bpf/bpf_local_storage.c                     |    2 +-
 kernel/bpf/btf.c                                   |   24 +-
 kernel/bpf/core.c                                  |   18 +-
 kernel/bpf/cpumask.c                               |    1 +
 kernel/bpf/crypto.c                                |  385 ++++
 kernel/bpf/disasm.c                                |   14 +
 kernel/bpf/hashtab.c                               |   79 +-
 kernel/bpf/helpers.c                               |  358 +++-
 kernel/bpf/log.c                                   |    4 +-
 kernel/bpf/lpm_trie.c                              |   13 +-
 kernel/bpf/syscall.c                               |   19 +-
 kernel/bpf/sysfs_btf.c                             |    6 +-
 kernel/bpf/trampoline.c                            |    3 +-
 kernel/bpf/verifier.c                              |  485 ++++-
 kernel/trace/bpf_trace.c                           |    4 -
 lib/test_bpf.c                                     |    2 +-
 net/bpf/bpf_dummy_struct_ops.c                     |   55 +-
 net/bpf/test_run.c                                 |    8 +
 net/core/filter.c                                  |   15 +-
 net/core/sock_map.c                                |  263 ++-
 net/ipv4/tcp_bbr.c                                 |    4 -
 net/ipv4/tcp_cubic.c                               |    4 -
 net/ipv4/tcp_dctcp.c                               |    4 -
 net/ipv4/tcp_input.c                               |    4 +-
 tools/bpf/bpftool/Documentation/Makefile           |    6 +-
 tools/bpf/bpftool/Documentation/bpftool-btf.rst    |  104 +-
 tools/bpf/bpftool/Documentation/bpftool-cgroup.rst |  219 +-
 .../bpf/bpftool/Documentation/bpftool-feature.rst  |  115 +-
 tools/bpf/bpftool/Documentation/bpftool-gen.rst    |  338 ++-
 tools/bpf/bpftool/Documentation/bpftool-iter.rst   |   60 +-
 tools/bpf/bpftool/Documentation/bpftool-link.rst   |   73 +-
 tools/bpf/bpftool/Documentation/bpftool-map.rst    |  232 +-
 tools/bpf/bpftool/Documentation/bpftool-net.rst    |  112 +-
 tools/bpf/bpftool/Documentation/bpftool-perf.rst   |   34 +-
 tools/bpf/bpftool/Documentation/bpftool-prog.rst   |  436 ++--
 .../bpftool/Documentation/bpftool-struct_ops.rst   |   81 +-
 tools/bpf/bpftool/Documentation/bpftool.rst        |   60 +-
 tools/bpf/bpftool/Documentation/common_options.rst |   26 +-
 tools/bpf/bpftool/bash-completion/bpftool          |   61 +-
 tools/bpf/bpftool/common.c                         |   96 +-
 tools/bpf/bpftool/feature.c                        |    3 +-
 tools/bpf/bpftool/gen.c                            |    4 +-
 tools/bpf/bpftool/iter.c                           |    2 +-
 tools/bpf/bpftool/link.c                           |    9 +
 tools/bpf/bpftool/main.h                           |    3 +-
 tools/bpf/bpftool/prog.c                           |    7 +-
 tools/bpf/bpftool/struct_ops.c                     |    2 +-
 tools/include/linux/filter.h                       |   18 +
 tools/include/uapi/linux/bpf.h                     |   37 +-
 tools/include/uapi/linux/ethtool.h                 | 2229 +++++++++++++++++++-
 tools/lib/bpf/bpf_core_read.h                      |    2 +-
 tools/lib/bpf/bpf_helpers.h                        |    4 +-
 tools/lib/bpf/btf_dump.c                           |    5 +
 tools/lib/bpf/libbpf.c                             |   33 +-
 tools/lib/bpf/libbpf.h                             |   14 +
 tools/lib/bpf/libbpf.map                           |    7 +
 tools/lib/bpf/libbpf_internal.h                    |    5 -
 tools/lib/bpf/libbpf_probes.c                      |    6 +-
 tools/lib/bpf/libbpf_version.h                     |    2 +-
 tools/lib/bpf/ringbuf.c                            |   55 +-
 tools/testing/selftests/bpf/DENYLIST.aarch64       |    3 +-
 tools/testing/selftests/bpf/DENYLIST.s390x         |    1 +
 tools/testing/selftests/bpf/Makefile               |   13 +-
 tools/testing/selftests/bpf/bench.c                |   39 +-
 .../selftests/bpf/benchs/bench_bpf_crypto.c        |  185 ++
 tools/testing/selftests/bpf/benchs/bench_trigger.c |  391 ++--
 .../selftests/bpf/benchs/run_bench_trigger.sh      |   22 +-
 .../selftests/bpf/benchs/run_bench_uprobes.sh      |    2 +-
 tools/testing/selftests/bpf/bpf_experimental.h     |   40 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |    5 +
 .../selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h  |    1 +
 tools/testing/selftests/bpf/cgroup_helpers.c       |    2 +-
 tools/testing/selftests/bpf/config                 |    7 +
 tools/testing/selftests/bpf/network_helpers.c      |  198 +-
 tools/testing/selftests/bpf/network_helpers.h      |   12 +-
 .../selftests/bpf/prog_tests/arena_atomics.c       |  186 ++
 .../testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  |   96 +-
 .../selftests/bpf/prog_tests/cls_redirect.c        |   38 +-
 .../selftests/bpf/prog_tests/crypto_sanity.c       |  197 ++
 .../selftests/bpf/prog_tests/dummy_st_ops.c        |   34 +-
 tools/testing/selftests/bpf/prog_tests/empty_skb.c |    2 +
 .../testing/selftests/bpf/prog_tests/fib_lookup.c  |  132 +-
 .../selftests/bpf/prog_tests/flow_dissector.c      |    1 -
 tools/testing/selftests/bpf/prog_tests/for_each.c  |   62 +
 .../selftests/bpf/prog_tests/ip_check_defrag.c     |    2 +
 .../selftests/bpf/prog_tests/kprobe_multi_test.c   |  248 ++-
 tools/testing/selftests/bpf/prog_tests/ksyms.c     |   30 +-
 tools/testing/selftests/bpf/prog_tests/mptcp.c     |    2 +
 .../selftests/bpf/prog_tests/preempt_lock.c        |    9 +
 tools/testing/selftests/bpf/prog_tests/ringbuf.c   |   65 +
 .../testing/selftests/bpf/prog_tests/send_signal.c |    2 +-
 tools/testing/selftests/bpf/prog_tests/sk_assign.c |   55 +-
 tools/testing/selftests/bpf/prog_tests/sock_addr.c |    6 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c       |  171 +-
 .../selftests/bpf/prog_tests/sockmap_listen.c      |   38 +
 .../bpf/prog_tests/stacktrace_build_id_nmi.c       |    2 +-
 .../testing/selftests/bpf/prog_tests/tc_redirect.c |    2 +-
 tools/testing/selftests/bpf/prog_tests/tcp_rtt.c   |   14 +
 .../bpf/prog_tests/test_struct_ops_module.c        |   24 +
 .../testing/selftests/bpf/prog_tests/test_tunnel.c |    4 +
 .../selftests/bpf/prog_tests/trace_printk.c        |   36 +-
 .../selftests/bpf/prog_tests/trace_vprintk.c       |   36 +-
 .../bpf/prog_tests/verifier_kfunc_prog_types.c     |   11 +
 tools/testing/selftests/bpf/prog_tests/wq.c        |   42 +
 .../selftests/bpf/prog_tests/xdp_metadata.c        |   16 +
 tools/testing/selftests/bpf/progs/arena_atomics.c  |  178 ++
 .../selftests/bpf/progs/cgrp_kfunc_common.h        |    2 +-
 tools/testing/selftests/bpf/progs/crypto_basic.c   |   68 +
 tools/testing/selftests/bpf/progs/crypto_bench.c   |  109 +
 tools/testing/selftests/bpf/progs/crypto_common.h  |   66 +
 tools/testing/selftests/bpf/progs/crypto_sanity.c  |  169 ++
 .../selftests/bpf/progs/dummy_st_ops_success.c     |   15 +-
 .../selftests/bpf/progs/for_each_multi_maps.c      |   49 +
 tools/testing/selftests/bpf/progs/mptcpify.c       |    4 +
 tools/testing/selftests/bpf/progs/preempt_lock.c   |  132 ++
 .../selftests/bpf/progs/struct_ops_module.c        |   13 +
 .../selftests/bpf/progs/task_kfunc_common.h        |    2 +-
 tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c   |  121 ++
 tools/testing/selftests/bpf/progs/tcp_rtt.c        |    6 +
 tools/testing/selftests/bpf/progs/test_ringbuf_n.c |   47 +
 .../selftests/bpf/progs/test_skmsg_load_helpers.c  |   27 +-
 .../selftests/bpf/progs/test_sockmap_pass_prog.c   |   17 +-
 .../bpf/progs/test_sockmap_skb_verdict_attach.c    |    2 +-
 tools/testing/selftests/bpf/progs/trigger_bench.c  |   68 +-
 .../bpf/progs/verifier_helper_restricted.c         |    8 +-
 .../bpf/progs/verifier_kfunc_prog_types.c          |  122 ++
 .../bpf/progs/verifier_subprog_precision.c         |   89 +
 tools/testing/selftests/bpf/progs/wq.c             |  180 ++
 tools/testing/selftests/bpf/progs/wq_failures.c    |  144 ++
 tools/testing/selftests/bpf/test_sock_addr.c       |  138 +-
 tools/testing/selftests/bpf/test_sockmap.c         |    2 +-
 tools/testing/selftests/bpf/testing_helpers.c      |   16 +-
 tools/testing/selftests/bpf/trace_helpers.c        |  109 +-
 tools/testing/selftests/bpf/trace_helpers.h        |    9 +
 tools/testing/selftests/bpf/uprobe_multi.c         |    2 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |   14 -
 tools/testing/selftests/bpf/xskxceiver.c           |  123 +-
 tools/testing/selftests/bpf/xskxceiver.h           |   12 +-
 158 files changed, 9400 insertions(+), 2213 deletions(-)
 create mode 100644 crypto/bpf_crypto_skcipher.c
 create mode 100644 include/linux/bpf_crypto.h
 create mode 100644 kernel/bpf/crypto.c
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_crypto.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_atomics.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/preempt_lock.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/verifier_kfunc_prog_types.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/wq.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_atomics.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_basic.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_sanity.c
 create mode 100644 tools/testing/selftests/bpf/progs/for_each_multi_maps.c
 create mode 100644 tools/testing/selftests/bpf/progs/preempt_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_n.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c
 create mode 100644 tools/testing/selftests/bpf/progs/wq.c
 create mode 100644 tools/testing/selftests/bpf/progs/wq_failures.c

