Return-Path: <bpf+bounces-12352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 578237CB4E4
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 22:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1FC11F228BA
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 20:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2137137173;
	Mon, 16 Oct 2023 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="aLMRe0+v"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B6430D02;
	Mon, 16 Oct 2023 20:48:09 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333F695;
	Mon, 16 Oct 2023 13:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=oy7r0h3FEGqQ1h6JNx7hvdvtwb65LC9++ZioDBXR1HI=; b=aLMRe0+vzlgPMo2TsX7mv5wbGE
	VHdk6gbq3GWjCOpvPNYQMCLKrX8oEPQAGFv0PNSLhyDZrf9HLOT0rwqc9ntx+Nh2cwlbrPomQD9lK
	KnP1PnXPbwNn6djCp/k2nQu3nbxjvbzirVP1QJie13SN+YpQLtRaaQG8LPrKcS5cH5uTvDDM0ntPh
	muEH95n9eLP4I+Vm2MrDQulKeM09MBNPvsYFXUOEVZdR5PtO+rMtZs0VV6wBELc3jtI+4VfZiMw5/
	yuyPUT8iI67MalLO22OnIuSgl6BHfsXOzJuPO1tDjH8Vx8Ctw3NdzrHBPijQIQ4nWElhe8B/mR2ae
	0VJT7sQw==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qsUVQ-000IcD-3M; Mon, 16 Oct 2023 22:48:04 +0200
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
Subject: pull-request: bpf-next 2023-10-16
Date: Mon, 16 Oct 2023 22:48:03 +0200
Message-Id: <20231016204803.30153-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 0.103.10/27063/Mon Oct 16 10:02:17 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 90 non-merge commits during the last 25 day(s) which contain
a total of 120 files changed, 3519 insertions(+), 895 deletions(-).

The main changes are:

1) Add missed stats for kprobes to retrieve the number of missed kprobe executions
   and subsequent executions of BPF programs, from Jiri Olsa.

2) Add cgroup BPF sockaddr hooks for unix sockets. The use case is for systemd to
   reimplement the LogNamespace feature which allows running multiple instances of
   systemd-journald to process the logs of different services, from Daan De Meyer.

3) Implement BPF CPUv4 support for s390x BPF JIT, from Ilya Leoshkevich.

4) Improve BPF verifier log output for scalar registers to better disambiguate their
   internal state wrt defaults vs min/max values matching, from Andrii Nakryiko.

5) Extend the BPF fib lookup helpers for IPv4/IPv6 to support retrieving the
   source IP address with a new BPF_FIB_LOOKUP_SRC flag, from Martynas Pumputis.

6) Add support for open-coded task_vma iterator to help with symbolization for
   BPF-collected user stacks, from Dave Marchevsky.

7) Add libbpf getters for accessing individual BPF ring buffers which is useful for
   polling them individually, for example, from Martin Kelly.

8) Extend AF_XDP selftests to validate the SHARED_UMEM feature, from Tushar Vyavahare.

9) Improve BPF selftests cross-building support for riscv arch, from Björn Töpel.

10) Add the ability to pin a BPF timer to the same calling CPU, from David Vernet.

11) Fix libbpf's bpf_tracing.h macros for riscv to use the generic implementation
    of PT_REGS_SYSCALL_REGS() to access syscall arguments, from Alexandre Ghiti.

12) Extend libbpf to support symbol versioning for uprobes, from Hengqi Chen.

13) Fix bpftool's skeleton code generation to guarantee that ELF data is 8 byte
    aligned, from Ian Rogers.

14) Inherit system-wide cpu_mitigations_off() setting for Spectre v1/v4 security
    mitigations in BPF verifier, from Yafang Shao.

15) Annotate struct bpf_stack_map with __counted_by attribute to prepare BPF side
    for upcoming __counted_by compiler support, from Kees Cook.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Alan Maguire, Andrii Nakryiko, Eduard Zingerman, Hou Tao, Jiri Olsa, 
John Fastabend, KP Singh, Kuniyuki Iwashima, Magnus Karlsson, Puranjay 
Mohan, Quentin Monnet, Sami Tolvanen, Song Liu, Stanislav Fomichev, 
Stephen Rothwell, Steven Rostedt (Google), Yonghong Song

----------------------------------------------------------------

The following changes since commit e9cbc89067cce78211c8629c78e931c0fe64e29d:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-09-21 21:49:45 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 99c9991f4e5d77328187187d0c921a3b62bfa998:

  Merge branch 'bpf-log-improvements' (2023-10-16 13:49:41 +0200)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Akihiko Odaki (1):
      bpf: Fix the comment for bpf_restore_data_end()

Alexandre Ghiti (1):
      libbpf: Fix syscall access arguments on riscv

Alexei Starovoitov (1):
      Merge branch 'implement-cpuv4-support-for-s390x'

Andrii Nakryiko (14):
      Merge branch 'libbpf: Support symbol versioning for uprobe'
      Merge branch 'add libbpf getters for individual ringbuffers'
      Merge branch 'bpf: Add missed stats for kprobes'
      Merge branch 'libbpf/selftests syscall wrapper fixes for RISC-V'
      Merge branch 'selftest/bpf, riscv: Improved cross-building support'
      selftests/bpf: Fix compiler warnings reported in -O2 mode
      selftests/bpf: Support building selftests in optimized -O2 mode
      selftests/bpf: Don't truncate #test/subtest field
      Merge branch 'Open-coded task_vma iter'
      selftests/bpf: Improve percpu_alloc test robustness
      selftests/bpf: Improve missed_kprobe_recursion test robustness
      selftests/bpf: Make align selftests more robust
      bpf: Disambiguate SCALAR register state output in verifier logs
      bpf: Ensure proper register state printing for cond jumps

Artem Savkov (1):
      bpf: Change syscall_nr type to int in struct syscall_tp_t

Björn Töpel (5):
      selftests/bpf: Define SYS_PREFIX for riscv
      selftests/bpf: Define SYS_NANOSLEEP_KPROBE_NAME for riscv
      selftests/bpf: Add cross-build support for urandom_read et al
      selftests/bpf: Enable lld usage for RISC-V
      selftests/bpf: Add uprobe_multi to gen_tar target

Daan De Meyer (9):
      selftests/bpf: Add missing section name tests for getpeername/getsockname
      bpf: Propagate modified uaddrlen from cgroup sockaddr programs
      bpf: Add bpf_sock_addr_set_sun_path() to allow writing unix sockaddr from bpf
      bpf: Implement cgroup sockaddr hooks for unix sockets
      libbpf: Add support for cgroup unix socket address hooks
      bpftool: Add support for cgroup unix socket address hooks
      documentation/bpf: Document cgroup unix socket address hooks
      selftests/bpf: Make sure mount directory exists
      selftests/bpf: Add tests for cgroup unix socket address hooks

Daniel Borkmann (2):
      Merge branch 'bpf-xsk-sh-umem'
      Merge branch 'bpf-log-improvements'

Dave Marchevsky (4):
      bpf: Don't explicitly emit BTF for struct btf_iter_num
      selftests/bpf: Rename bpf_iter_task_vma.c to bpf_iter_task_vmas.c
      bpf: Introduce task_vma open-coded iterator kfuncs
      selftests/bpf: Add tests for open-coded task_vma iter

David Vernet (2):
      bpf: Add ability to pin bpf timer to calling CPU
      selftests/bpf: Test pinning bpf timer to a core

Geliang Tang (2):
      selftests/bpf: Enable CONFIG_VSOCKETS in config
      selftests/bpf: Add pairs_redir_to_connected helper

Hengqi Chen (4):
      libbpf: Resolve symbol conflicts at the same offset for uprobe
      libbpf: Support symbol versioning for uprobe
      selftests/bpf: Add tests for symbol versioning for uprobe
      libbpf: Allow Golang symbols in uprobe secdef

Ian Rogers (2):
      bpftool: Align output skeleton ELF code
      bpftool: Align bpf_load_and_run_opts insns and data

Ilya Leoshkevich (10):
      bpf: Disable zero-extension for BPF_MEMSX
      selftests/bpf: Unmount the cgroup2 work directory
      selftests/bpf: Add big-endian support to the ldsx test
      s390/bpf: Implement BPF_MOV | BPF_X with sign-extension
      s390/bpf: Implement BPF_MEMSX
      s390/bpf: Implement unconditional byte swap
      s390/bpf: Implement unconditional jump with 32-bit offset
      s390/bpf: Implement signed division
      selftests/bpf: Enable the cpuv4 tests for s390x
      selftests/bpf: Trim DENYLIST.s390x

Jinghao Jia (2):
      samples/bpf: syscall_tp_user: Rename num_progs into nr_tests
      samples/bpf: syscall_tp_user: Fix array out-of-bound access

Jiri Olsa (9):
      bpf: Count stats for kprobe_multi programs
      bpf: Add missed value to kprobe_multi link info
      bpf: Add missed value to kprobe perf link info
      bpf: Count missed stats in trace_call_bpf
      bpftool: Display missed count for kprobe_multi link
      bpftool: Display missed count for kprobe perf link
      selftests/bpf: Add test for missed counts of perf event link kprobe
      selftests/bpf: Add test for recursion counts of perf event link kprobe
      selftests/bpf: Add test for recursion counts of perf event link tracepoint

Kees Cook (1):
      bpf: Annotate struct bpf_stack_map with __counted_by

Martin KaFai Lau (3):
      Merge branch 'bpf: Fix src IP addr related limitation in bpf_*_fib_lookup()'
      Merge branch 'Add cgroup sockaddr hooks for unix sockets'
      net/bpf: Avoid unused "sin_addr_len" warning when CONFIG_CGROUP_BPF is not set

Martin Kelly (14):
      libbpf: Refactor cleanup in ring_buffer__add
      libbpf: Switch rings to array of pointers
      libbpf: Add ring_buffer__ring
      selftests/bpf: Add tests for ring_buffer__ring
      libbpf: Add ring__producer_pos, ring__consumer_pos
      selftests/bpf: Add tests for ring__*_pos
      libbpf: Add ring__avail_data_size
      selftests/bpf: Add tests for ring__avail_data_size
      libbpf: Add ring__size
      selftests/bpf: Add tests for ring__size
      libbpf: Add ring__map_fd
      selftests/bpf: Add tests for ring__map_fd
      libbpf: Add ring__consume
      selftests/bpf: Add tests for ring__consume

Martynas Pumputis (2):
      bpf: Derive source IP addr via bpf_*_fib_lookup()
      selftests/bpf: Add BPF_FIB_LOOKUP_SRC tests

Ruowen Qin (1):
      samples/bpf: Add -fsanitize=bounds to userspace programs

Tiezhu Yang (1):
      bpf, docs: Add loongarch64 as arch supporting BPF JIT

Tushar Vyavahare (8):
      selftests/xsk: Move pkt_stream to the xsk_socket_info
      selftests/xsk: Rename xsk_xdp_metadata.h to xsk_xdp_common.h
      selftests/xsk: Move src_mac and dst_mac to the xsk_socket_info
      selftests/xsk: Iterate over all the sockets in the receive pkts function
      selftests/xsk: Remove unnecessary parameter from pkt_set() function call
      selftests/xsk: Iterate over all the sockets in the send pkts function
      selftests/xsk: Modify xsk_update_xskmap() to accept the index as an argument
      selftests/xsk: Add a test for shared umem feature

Yafang Shao (2):
      bpf: Inherit system settings for CPU security mitigations
      bpf: Avoid unnecessary audit log for CPU security mitigations

 Documentation/admin-guide/sysctl/net.rst           |   1 +
 Documentation/bpf/libbpf/program_types.rst         |  10 +
 Documentation/networking/filter.rst                |   4 +-
 arch/s390/net/bpf_jit_comp.c                       | 265 ++++++---
 include/linux/bpf-cgroup-defs.h                    |   5 +
 include/linux/bpf-cgroup.h                         |  90 +--
 include/linux/bpf.h                                |  20 +-
 include/linux/filter.h                             |   3 +-
 include/linux/trace_events.h                       |   6 +-
 include/net/ipv6_stubs.h                           |   5 +
 include/uapi/linux/bpf.h                           |  29 +-
 kernel/bpf/bpf_iter.c                              |   2 -
 kernel/bpf/btf.c                                   |   1 +
 kernel/bpf/cgroup.c                                |  28 +-
 kernel/bpf/helpers.c                               |   8 +-
 kernel/bpf/stackmap.c                              |   2 +-
 kernel/bpf/syscall.c                               |  29 +-
 kernel/bpf/task_iter.c                             |  91 +++
 kernel/bpf/verifier.c                              |  81 ++-
 kernel/trace/bpf_trace.c                           |  10 +-
 kernel/trace/trace_kprobe.c                        |  14 +-
 kernel/trace/trace_syscalls.c                      |   4 +-
 net/core/filter.c                                  |  67 ++-
 net/ipv4/af_inet.c                                 |   9 +-
 net/ipv4/ping.c                                    |   2 +-
 net/ipv4/tcp_ipv4.c                                |   2 +-
 net/ipv4/udp.c                                     |   9 +-
 net/ipv6/af_inet6.c                                |  10 +-
 net/ipv6/ping.c                                    |   2 +-
 net/ipv6/tcp_ipv6.c                                |   2 +-
 net/ipv6/udp.c                                     |   6 +-
 net/unix/af_unix.c                                 |  35 +-
 samples/bpf/Makefile                               |   3 +
 samples/bpf/syscall_tp_user.c                      |  45 +-
 tools/bpf/bpftool/Documentation/bpftool-cgroup.rst |  16 +-
 tools/bpf/bpftool/Documentation/bpftool-prog.rst   |   8 +-
 tools/bpf/bpftool/bash-completion/bpftool          |  14 +-
 tools/bpf/bpftool/cgroup.c                         |  16 +-
 tools/bpf/bpftool/gen.c                            |  58 +-
 tools/bpf/bpftool/link.c                           |   6 +
 tools/bpf/bpftool/prog.c                           |   7 +-
 tools/include/uapi/linux/bpf.h                     |  29 +-
 tools/lib/bpf/bpf_tracing.h                        |   2 -
 tools/lib/bpf/elf.c                                | 139 ++++-
 tools/lib/bpf/libbpf.c                             |  32 +-
 tools/lib/bpf/libbpf.h                             |  73 +++
 tools/lib/bpf/libbpf.map                           |   7 +
 tools/lib/bpf/ringbuf.c                            |  85 ++-
 tools/testing/selftests/bpf/DENYLIST.aarch64       |   1 +
 tools/testing/selftests/bpf/DENYLIST.s390x         |  25 -
 tools/testing/selftests/bpf/Makefile               |  37 +-
 tools/testing/selftests/bpf/bpf_experimental.h     |   8 +
 tools/testing/selftests/bpf/bpf_kfuncs.h           |  14 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |   5 +
 .../selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h  |   2 +
 tools/testing/selftests/bpf/cgroup_helpers.c       |  38 +-
 tools/testing/selftests/bpf/config                 |   1 +
 tools/testing/selftests/bpf/liburandom_read.map    |  15 +
 .../selftests/bpf/map_tests/map_in_map_batch_ops.c |   4 +-
 tools/testing/selftests/bpf/network_helpers.c      |  34 ++
 tools/testing/selftests/bpf/network_helpers.h      |   1 +
 tools/testing/selftests/bpf/prog_tests/align.c     | 241 ++++----
 .../selftests/bpf/prog_tests/bloom_filter_map.c    |   4 +-
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c  |  26 +-
 .../selftests/bpf/prog_tests/connect_ping.c        |   4 +-
 .../testing/selftests/bpf/prog_tests/fib_lookup.c  |  83 ++-
 tools/testing/selftests/bpf/prog_tests/iters.c     |  58 ++
 .../testing/selftests/bpf/prog_tests/linked_list.c |   2 +-
 .../testing/selftests/bpf/prog_tests/lwt_helpers.h |   3 +-
 tools/testing/selftests/bpf/prog_tests/missed.c    | 138 +++++
 .../selftests/bpf/prog_tests/percpu_alloc.c        |   3 +
 .../selftests/bpf/prog_tests/queue_stack_map.c     |   2 +-
 tools/testing/selftests/bpf/prog_tests/ringbuf.c   |  26 +
 .../selftests/bpf/prog_tests/ringbuf_multi.c       |  15 +
 .../selftests/bpf/prog_tests/section_names.c       |  45 ++
 tools/testing/selftests/bpf/prog_tests/sock_addr.c | 612 +++++++++++++++++++++
 .../selftests/bpf/prog_tests/sockmap_basic.c       |   8 +-
 .../selftests/bpf/prog_tests/sockmap_helpers.h     |   2 +-
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 150 ++---
 tools/testing/selftests/bpf/prog_tests/timer.c     |   4 +
 tools/testing/selftests/bpf/prog_tests/uprobe.c    |  95 ++++
 .../selftests/bpf/prog_tests/xdp_metadata.c        |   2 +-
 .../{bpf_iter_task_vma.c => bpf_iter_task_vmas.c}  |   0
 tools/testing/selftests/bpf/progs/bpf_misc.h       |   3 +
 .../selftests/bpf/progs/connect_unix_prog.c        |  40 ++
 .../selftests/bpf/progs/exceptions_assert.c        |  18 +-
 .../selftests/bpf/progs/getpeername_unix_prog.c    |  39 ++
 .../selftests/bpf/progs/getsockname_unix_prog.c    |  39 ++
 tools/testing/selftests/bpf/progs/iters_task_vma.c |  43 ++
 tools/testing/selftests/bpf/progs/missed_kprobe.c  |  30 +
 .../selftests/bpf/progs/missed_kprobe_recursion.c  |  48 ++
 .../selftests/bpf/progs/missed_tp_recursion.c      |  41 ++
 .../selftests/bpf/progs/percpu_alloc_array.c       |   7 +
 .../bpf/progs/percpu_alloc_cgrp_local_storage.c    |   4 +
 tools/testing/selftests/bpf/progs/profiler.inc.h   |   2 +-
 .../selftests/bpf/progs/recvmsg_unix_prog.c        |  39 ++
 .../selftests/bpf/progs/sendmsg_unix_prog.c        |  40 ++
 tools/testing/selftests/bpf/progs/test_ldsx_insn.c |   9 +-
 tools/testing/selftests/bpf/progs/test_uprobe.c    |  61 ++
 tools/testing/selftests/bpf/progs/test_vmlinux.c   |   4 +-
 tools/testing/selftests/bpf/progs/timer.c          |  63 ++-
 tools/testing/selftests/bpf/progs/verifier_bswap.c |   3 +-
 tools/testing/selftests/bpf/progs/verifier_gotol.c |   3 +-
 tools/testing/selftests/bpf/progs/verifier_ldsx.c  | 151 ++---
 tools/testing/selftests/bpf/progs/verifier_movsx.c |   3 +-
 tools/testing/selftests/bpf/progs/verifier_sdiv.c  |   3 +-
 tools/testing/selftests/bpf/progs/xsk_xdp_progs.c  |  22 +-
 tools/testing/selftests/bpf/test_loader.c          |   4 +-
 tools/testing/selftests/bpf/test_progs.c           |   2 +-
 tools/testing/selftests/bpf/test_progs.h           |   2 +
 tools/testing/selftests/bpf/urandom_read.c         |  15 +-
 tools/testing/selftests/bpf/urandom_read_lib1.c    |  22 +
 tools/testing/selftests/bpf/xdp_features.c         |   4 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |   2 +-
 tools/testing/selftests/bpf/xsk.c                  |   3 +-
 tools/testing/selftests/bpf/xsk.h                  |   2 +-
 tools/testing/selftests/bpf/xsk_xdp_common.h       |  12 +
 tools/testing/selftests/bpf/xsk_xdp_metadata.h     |   5 -
 tools/testing/selftests/bpf/xskxceiver.c           | 513 ++++++++++-------
 tools/testing/selftests/bpf/xskxceiver.h           |  13 +-
 120 files changed, 3519 insertions(+), 895 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/liburandom_read.map
 create mode 100644 tools/testing/selftests/bpf/prog_tests/missed.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_addr.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe.c
 rename tools/testing/selftests/bpf/progs/{bpf_iter_task_vma.c => bpf_iter_task_vmas.c} (100%)
 create mode 100644 tools/testing/selftests/bpf/progs/connect_unix_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/getpeername_unix_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/getsockname_unix_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_vma.c
 create mode 100644 tools/testing/selftests/bpf/progs/missed_kprobe.c
 create mode 100644 tools/testing/selftests/bpf/progs/missed_kprobe_recursion.c
 create mode 100644 tools/testing/selftests/bpf/progs/missed_tp_recursion.c
 create mode 100644 tools/testing/selftests/bpf/progs/recvmsg_unix_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/sendmsg_unix_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_uprobe.c
 create mode 100644 tools/testing/selftests/bpf/xsk_xdp_common.h
 delete mode 100644 tools/testing/selftests/bpf/xsk_xdp_metadata.h

