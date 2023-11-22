Return-Path: <bpf+bounces-15605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 863F37F3A94
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 01:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0942828AA
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 00:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601037FF;
	Wed, 22 Nov 2023 00:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="HgFDFjIK"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11B5D51;
	Tue, 21 Nov 2023 16:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=AB+5a3p3v7s+YdJYgGKnLHiTAsNsj19lHaxbFzlUoZw=; b=HgFDFjIKDmpq9eff7ZHQaSI2Ys
	3z0LOOTj6hBYiZ5XlBsykqUb+b8DuKHPaUAeyNmItvy1F0OKXP9BQ9nn1vTqQuDtENP9zEVyXOTnD
	oNv1bq10eIIiwnNv6KN0JsKSR5UMw4g6Q13CccuIL9MkpT21sW37jnW6oo66QvXtNcJ6ZbeMwFQ6B
	NeDlDkUO8vSCOEDiarkOHyEmqva0eGalT8VXIbcm+vR4gCiWSyIgs1/v+PEkvMZ1JnNXs0WCXGZ5N
	IM4FSlmvHGl1Xw2oj4CF4g8JJj32PIubaLV3OBjJUJnopxqqokSdmvaJfIRfRoy6ZNB+dk7z/zY2o
	yVZ6Id8g==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r5ajl-000O8W-6E; Wed, 22 Nov 2023 01:05:01 +0100
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
Subject: pull-request: bpf-next 2023-11-21
Date: Wed, 22 Nov 2023 01:05:00 +0100
Message-Id: <20231122000500.28126-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27100/Tue Nov 21 09:39:58 2023)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 85 non-merge commits during the last 12 day(s) which contain
a total of 63 files changed, 4464 insertions(+), 1484 deletions(-).

The main changes are:

1) Huge batch of verifier changes to improve BPF register bounds logic and range
   support along with a large test suite, and verifier log improvements, all from
   Andrii Nakryiko.

2) Add a new kfunc which acquires the associated cgroup of a task within a specific
   cgroup v1 hierarchy where the latter is identified by its id, from Yafang Shao.

3) Extend verifier to allow bpf_refcount_acquire() of a map value field obtained
   via direct load which is a use-case needed in sched_ext, from Dave Marchevsky.

4) Fix bpf_get_task_stack() helper to add the correct crosstask check for the
   get_perf_callchain(), from Jordan Rome.

5) Fix BPF task_iter internals where lockless usage of next_thread() was wrong.
   The rework also simplifies the code, from Oleg Nesterov.

6) Fix uninitialized tail padding via LIBBPF_OPTS_RESET, and another fix for
   certain BPF UAPI structs to fix verifier failures seen in bpf_dynptr usage,
   from Yonghong Song.

7) Add BPF selftest fixes for map_percpu_stats flakes due to per-CPU BPF memory
   allocator not being able to allocate per-CPU pointer successfully, from Hou Tao.

8) Add prep work around dynptr and string handling for kfuncs which is later going
   to be used by file verification via BPF LSM and fsverity, from Song Liu.

9) Improve BPF selftests to update multiple prog_tests to use ASSERT_* macros,
   from Yuran Pereira.

10) Optimize LPM trie lookup to check prefixlen before walking the trie, from
    Florian Lehner.

11) Consolidate virtio/9p configs from BPF selftests in config.vm file given they
    are needed consistently across archs, from Manu Bretelle.

12) Small BPF verifier refactor to remove register_is_const(), from Shung-Hsi Yu.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Alan Maguire, Andrii Nakryiko, Arnd Bergmann, Eduard Zingerman, Jerry 
Snitselaar, kernel test robot, Kui-Feng Lee, Martin KaFai Lau, Quentin 
Monnet, Shung-Hsi Yu, Stanislav Fomichev, Tejun Heo, Vadim Fedorenko, 
Yonghong Song

----------------------------------------------------------------

The following changes since commit 89cdf9d556016a54ff6ddd62324aa5ec790c05cc:

  Merge tag 'net-6.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-11-09 17:09:35 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 3cbbf9192abdc9183eb215b5e8b06c778e5c2214:

  Merge branch 'selftests-bpf-update-multiple-prog_tests-to-use-assert_-macros' (2023-11-21 10:45:26 -0800)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Alexei Starovoitov (7):
      Merge branch 'bpf-register-bounds-logic-and-testing-improvements'
      Merge branch 'allow-bpf_refcount_acquire-of-mapval-obtained-via-direct-ld'
      Merge branch 'for-6.8-bpf' of https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup into bpf-next
      Merge branch 'bpf-add-support-for-cgroup1-bpf-part'
      Merge branch 'bpf-register-bounds-range-vs-range-support'
      Merge branch 'bpf-verifier-log-improvements'
      Merge branch 'bpf-kernel-bpf-task_iter-c-don-t-abuse-next_thread'

Anders Roxell (1):
      selftests/bpf: Disable CONFIG_DEBUG_INFO_REDUCED in config.aarch64

Andrii Nakryiko (44):
      selftests/bpf: fix RELEASE=1 build for tc_opts
      selftests/bpf: satisfy compiler by having explicit return in btf test
      bpf: derive smin/smax from umin/max bounds
      bpf: derive smin32/smax32 from umin32/umax32 bounds
      bpf: derive subreg bounds from full bounds when upper 32 bits are constant
      bpf: add special smin32/smax32 derivation from 64-bit bounds
      bpf: improve deduction of 64-bit bounds from 32-bit bounds
      bpf: try harder to deduce register bounds from different numeric domains
      bpf: drop knowledge-losing __reg_combine_{32,64}_into_{64,32} logic
      bpf: rename is_branch_taken reg arguments to prepare for the second one
      bpf: generalize is_branch_taken() to work with two registers
      bpf: move is_branch_taken() down
      bpf: generalize is_branch_taken to handle all conditional jumps in one place
      bpf: unify 32-bit and 64-bit is_branch_taken logic
      bpf: prepare reg_set_min_max for second set of registers
      bpf: generalize reg_set_min_max() to handle two sets of two registers
      Merge branch 'selftests/bpf: Fixes for map_percpu_stats test'
      Merge branch 'bpf: __bpf_dynptr_data* and __str annotation'
      veristat: add ability to sort by stat's absolute value
      veristat: add ability to filter top N results
      bpf: generalize reg_set_min_max() to handle non-const register comparisons
      bpf: generalize is_scalar_branch_taken() logic
      bpf: enhance BPF_JEQ/BPF_JNE is_branch_taken logic
      bpf: add register bounds sanity checks and sanitization
      bpf: remove redundant s{32,64} -> u{32,64} deduction logic
      bpf: make __reg{32,64}_deduce_bounds logic more robust
      selftests/bpf: BPF register range bounds tester
      selftests/bpf: adjust OP_EQ/OP_NE handling to use subranges for branch taken
      selftests/bpf: add range x range test to reg_bounds
      selftests/bpf: add randomized reg_bounds tests
      selftests/bpf: set BPF_F_TEST_SANITY_SCRIPT by default
      veristat: add ability to set BPF_F_TEST_SANITY_STRICT flag with -r flag
      selftests/bpf: add iter test requiring range x range logic
      bpf: rename BPF_F_TEST_SANITY_STRICT to BPF_F_TEST_REG_INVARIANTS
      bpf: move verbose_linfo() into kernel/bpf/log.c
      bpf: move verifier state printing code to kernel/bpf/log.c
      bpf: extract register state printing
      bpf: print spilled register state in stack slot
      bpf: emit map name in register state if applicable and available
      bpf: omit default off=0 and imm=0 in register state log
      bpf: smarter verifier log number printing logic
      bpf: emit frameno for PTR_TO_STACK regs if it differs from current one
      selftests/bpf: reduce verboseness of reg_bounds selftest logs
      Merge branch 'selftests-bpf-update-multiple-prog_tests-to-use-assert_-macros'

Artem Savkov (1):
      bpftool: Fix prog object type in manpage

Dave Marchevsky (6):
      bpf: Add KF_RCU flag to bpf_refcount_acquire_impl
      selftests/bpf: Add test passing MAYBE_NULL reg to bpf_refcount_acquire
      bpf: Use bpf_mem_free_rcu when bpf_obj_dropping non-refcounted nodes
      bpf: Move GRAPH_{ROOT,NODE}_MASK macros into btf_field_type enum
      bpf: Mark direct ld of stashed bpf_{rb,list}_node as non-owning ref
      selftests/bpf: Test bpf_refcount_acquire of node obtained via direct ld

Florian Lehner (1):
      bpf, lpm: Fix check prefixlen before walking trie

Hou Tao (3):
      selftests/bpf: Use value with enough-size when updating per-cpu map
      selftests/bpf: Export map_update_retriable()
      selftsets/bpf: Retry map update for non-preallocated per-cpu map

Jordan Rome (2):
      bpf: Add crosstask check to __bpf_get_stack
      selftests/bpf: Add assert for user stacks in test_task_stack

Manu Bretelle (1):
      selftests/bpf: Consolidate VIRTIO/9P configs in config.vm file

Oleg Nesterov (3):
      bpf: task_group_seq_get_next: use __next_thread() rather than next_thread()
      bpf: bpf_iter_task_next: use __next_thread() rather than next_thread()
      bpf: bpf_iter_task_next: use next_task(kit->task) rather than next_task(kit->pos)

Puranjay Mohan (1):
      bpf: Remove test for MOVSX32 with offset=32

Shung-Hsi Yu (1):
      bpf: replace register_is_const() with is_reg_const()

Song Liu (3):
      bpf: Add __bpf_dynptr_data* for in kernel use
      bpf: Factor out helper check_reg_const_str()
      bpf: Introduce KF_ARG_PTR_TO_CONST_STR

Yafang Shao (12):
      cgroup: Remove unnecessary list_empty()
      cgroup: Make operations on the cgroup root_list RCU safe
      cgroup: Eliminate the need for cgroup_mutex in proc_cgroup_show()
      cgroup: Add annotation for holding namespace_sem in current_cgns_cgroup_from_root()
      cgroup: Add a new helper for cgroup1 hierarchy
      compiler-gcc: Suppress -Wmissing-prototypes warning for all supported GCC
      bpf: Add a new kfunc for cgroup1 hierarchy
      selftests/bpf: Fix issues in setup_classid_environment()
      selftests/bpf: Add parallel support for classid
      selftests/bpf: Add a new cgroup helper get_classid_cgroup_id()
      selftests/bpf: Add a new cgroup helper get_cgroup_hierarchy_id()
      selftests/bpf: Add selftests for cgroup1 hierarchy

Yonghong Song (3):
      libbpf: Fix potential uninitialized tail padding with LIBBPF_OPTS_RESET
      bpf: Use named fields for certain bpf uapi structs
      selftests/bpf: Fix pyperf180 compilation failure with clang18

Yuran Pereira (6):
      selftests/bpf: Convert CHECK macros to ASSERT_* macros in bpf_iter
      selftests/bpf: Add malloc failure checks in bpf_iter
      selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in bpf_tcp_ca
      selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in bind_perm
      selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in bpf_obj_id
      selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in vmlinux

 Documentation/bpf/kfuncs.rst                       |   24 +
 include/linux/bpf.h                                |    6 +-
 include/linux/bpf_verifier.h                       |   77 +
 include/linux/cgroup-defs.h                        |    1 +
 include/linux/cgroup.h                             |    4 +-
 include/linux/compiler-gcc.h                       |    2 +-
 include/linux/tnum.h                               |    4 +
 include/uapi/linux/bpf.h                           |   29 +-
 kernel/bpf/btf.c                                   |   11 +-
 kernel/bpf/helpers.c                               |   46 +-
 kernel/bpf/log.c                                   |  480 +++++
 kernel/bpf/lpm_trie.c                              |    3 +
 kernel/bpf/stackmap.c                              |   11 +-
 kernel/bpf/syscall.c                               |    3 +-
 kernel/bpf/task_iter.c                             |   29 +-
 kernel/bpf/tnum.c                                  |    7 +-
 kernel/bpf/verifier.c                              | 1690 +++++++---------
 kernel/cgroup/cgroup-internal.h                    |    4 +-
 kernel/cgroup/cgroup-v1.c                          |   34 +
 kernel/cgroup/cgroup.c                             |   45 +-
 kernel/trace/bpf_trace.c                           |   12 +-
 lib/test_bpf.c                                     |   16 -
 tools/bpf/bpftool/Documentation/bpftool.rst        |    2 +-
 tools/include/uapi/linux/bpf.h                     |   29 +-
 tools/lib/bpf/libbpf_common.h                      |   13 +-
 tools/testing/selftests/bpf/cgroup_helpers.c       |  116 +-
 tools/testing/selftests/bpf/cgroup_helpers.h       |    4 +-
 tools/testing/selftests/bpf/config.aarch64         |   17 +-
 tools/testing/selftests/bpf/config.s390x           |    9 -
 tools/testing/selftests/bpf/config.vm              |   12 +
 tools/testing/selftests/bpf/config.x86_64          |   12 -
 .../selftests/bpf/map_tests/map_percpu_stats.c     |   39 +-
 tools/testing/selftests/bpf/prog_tests/align.c     |   42 +-
 tools/testing/selftests/bpf/prog_tests/bind_perm.c |    6 +-
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c  |   87 +-
 .../testing/selftests/bpf/prog_tests/bpf_obj_id.c  |  204 +-
 .../testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  |   48 +-
 .../selftests/bpf/prog_tests/bpf_verif_scale.c     |    2 +-
 tools/testing/selftests/bpf/prog_tests/btf.c       |    1 +
 .../selftests/bpf/prog_tests/cgroup1_hierarchy.c   |  158 ++
 .../testing/selftests/bpf/prog_tests/cgroup_v1v2.c |    2 +-
 .../selftests/bpf/prog_tests/local_kptr_stash.c    |   33 +
 tools/testing/selftests/bpf/prog_tests/log_buf.c   |    4 +-
 .../testing/selftests/bpf/prog_tests/reg_bounds.c  | 2124 ++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/spin_lock.c |   14 +-
 tools/testing/selftests/bpf/prog_tests/tc_opts.c   |    6 +-
 tools/testing/selftests/bpf/prog_tests/vmlinux.c   |   16 +-
 .../selftests/bpf/progs/bpf_iter_task_stack.c      |    5 +
 .../selftests/bpf/progs/exceptions_assert.c        |   40 +-
 tools/testing/selftests/bpf/progs/iters.c          |   22 +
 .../testing/selftests/bpf/progs/local_kptr_stash.c |   71 +
 tools/testing/selftests/bpf/progs/pyperf180.c      |   22 +
 .../selftests/bpf/progs/refcounted_kptr_fail.c     |   19 +
 .../selftests/bpf/progs/test_cgroup1_hierarchy.c   |   71 +
 .../testing/selftests/bpf/progs/verifier_bounds.c  |    2 +
 tools/testing/selftests/bpf/test_loader.c          |   35 +-
 tools/testing/selftests/bpf/test_maps.c            |   17 +-
 tools/testing/selftests/bpf/test_maps.h            |    5 +
 tools/testing/selftests/bpf/test_sock_addr.c       |    2 +-
 tools/testing/selftests/bpf/test_verifier.c        |    2 +-
 tools/testing/selftests/bpf/testing_helpers.c      |    4 +-
 tools/testing/selftests/bpf/veristat.c             |   89 +-
 tools/testing/selftests/bpf/vmtest.sh              |    4 +-
 63 files changed, 4464 insertions(+), 1484 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/config.vm
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/reg_bounds.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c

