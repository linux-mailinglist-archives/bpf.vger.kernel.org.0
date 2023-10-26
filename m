Return-Path: <bpf+bounces-13328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3947D7D857F
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 17:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44E74B20E8F
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 15:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9602F507;
	Thu, 26 Oct 2023 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="TElU8y0O"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCA92EB12;
	Thu, 26 Oct 2023 15:05:15 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B70718F;
	Thu, 26 Oct 2023 08:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=kWKrxEGv66JIOK1EuIMdyh2Dm/xG6DW2++QgfIIgit0=; b=TElU8y0OcvlSpq/JU3XlNzw0AZ
	O8w4FDgol+V43AzGp/C/PfHFHikcYANeZ/ZFo6o+FfhnBd0YG/0ssX64YBznJDsQbAR0wVhDvLp3Y
	R9BX6k0GlzL8XOTS0H7iepCWt7sB5Hpli/6ppxBFcGrKI2Q8W+kAAX34VxL2wTO21KMuZX8e88EfZ
	8Ro56RyzMXgDjLxFT2mAj+CC2+snwXCdqpaDADhMo4t8sRa5Gpvb/R9eDpH8GLDFzvWlMfcvDOCNm
	ppYh58kahDyxL9W7sK0N/cn9mjfB69lcY3mvWE1Mr/k52Rd57d+V5DqLGQoITo7d4n1Hy24e1ORzN
	HHnWbRkw==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qw1v3-000KIB-Uz; Thu, 26 Oct 2023 17:05:10 +0200
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
Subject: pull-request: bpf-next 2023-10-26
Date: Thu, 26 Oct 2023 17:05:09 +0200
Message-Id: <20231026150509.2824-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 0.103.10/27073/Thu Oct 26 09:47:53 2023)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 51 non-merge commits during the last 10 day(s) which contain
a total of 75 files changed, 5037 insertions(+), 200 deletions(-).

The main changes are:

1) Add open-coded task, css_task and css iterator support. One of the use cases is
   customizable OOM victim selection via BPF, from Chuyi Zhou.

2) Fix BPF verifier's iterator convergence logic to use exact states comparison for
   convergence checks, from Eduard Zingerman, Andrii Nakryiko and Alexei Starovoitov.

3) Add BPF programmable net device where bpf_mprog defines the logic of its xmit
   routine. It can operate in L3 and L2 mode, from Daniel Borkmann and Nikolay Aleksandrov.

4) Batch of fixes for BPF per-CPU kptr and re-enable unit_size checking for
   global per-CPU allocator, from Hou Tao.

5) Fix libbpf which eagerly assumed that SHT_GNU_verdef ELF section was going to
   be present whenever a binary has SHT_GNU_versym section, from Andrii Nakryiko.

6) Fix BPF ringbuf correctness to fold smp_mb__before_atomic() into
   atomic_set_release(), from Paul E. McKenney.

7) Add a warning if NAPI callback missed xdp_do_flush() under CONFIG_DEBUG_NET which
   helps checking if drivers were missing the former, from Sebastian Andrzej Siewior.

8) Fix missed RCU read-lock in bpf_task_under_cgroup() which was throwing a
   warning under sleepable programs, from Yafang Shao.

9) Avoid unnecessary -EBUSY from htab_lock_bucket by disabling IRQ before
   checking map_locked, from Song Liu.

10) Make BPF CI linked_list failure test more robust, from Kumar Kartikeya Dwivedi.

11) Enable samples/bpf to be built as PIE in Fedora, from Viktor Malik.

12) Fix xsk starving when multiple xsk sockets were associated with a single
    xsk_buff_pool, from Albert Huang.

13) Clarify the signed modulo implementation for the BPF ISA standardization
    document that it uses truncated division, from Dave Thaler.

14) Improve BPF verifier's JEQ/JNE branch taken logic to also consider signed
    bounds knowledge, from Andrii Nakryiko.

15) Add an option to XDP selftests to use multi-buffer AF_XDP xdp_hw_metadata
    and mark used XDP programs as capable to use frags, from Larysa Zaremba.

16) Fix bpftool's BTF dumper wrt printing a pointer value and another one
    to fix struct_ops dump in an array, from Manu Bretelle.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Alan Maguire, Alexei Starovoitov, Andrii Nakryiko, Daniel Borkmann, 
David Vernet, Dennis Zhou, Eduard Zingerman, Fangrui Song, Hengqi Chen, 
Jakub Kicinski, Jiri Pirko, John Fastabend, Liam Wisehart, Magnus 
Karlsson, Manu Bretelle, Martin KaFai Lau, Quentin Monnet, Shung-Hsi Yu, 
Stanislav Fomichev, Tejun Heo, Toke Høiland-Jørgensen, Yonghong Song

----------------------------------------------------------------

The following changes since commit a3c2dd96487f1dd734c9443a3472c8dafa689813:

  Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next (2023-10-16 21:05:33 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to ea41b880cc85f0a992571f66e4554a69f7806246:

  netkit: Remove explicit active/peer ptr initialization (2023-10-26 15:58:39 +0200)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Albert Huang (1):
      xsk: Avoid starving the xsk further down the list

Alexei Starovoitov (3):
      Merge branch 'add-open-coded-task-css_task-and-css-iters'
      Merge branch 'bpf-fixes-for-per-cpu-kptr'
      Merge branch 'exact-states-comparison-for-iterator-convergence-checks'

Andrii Nakryiko (2):
      libbpf: Don't assume SHT_GNU_verdef presence for SHT_GNU_versym section
      bpf: Improve JEQ/JNE branch taken logic

Chuyi Zhou (8):
      cgroup: Prepare for using css_task_iter_*() in BPF
      bpf: Introduce css_task open-coded iterator kfuncs
      bpf: Introduce task open coded iterator kfuncs
      bpf: Introduce css open-coded iterator kfuncs
      bpf: teach the verifier to enforce css_iter and task_iter in RCU CS
      bpf: Let bpf_iter_task_new accept null task ptr
      selftests/bpf: rename bpf_iter_task.c to bpf_iter_tasks.c
      selftests/bpf: Add tests for open-coded task and css iter

Daniel Borkmann (9):
      selftests/bpf: Add additional mprog query test coverage
      bpf, tcx: Get rid of tcx_link_const
      netkit, bpf: Add bpf programmable net device
      tools: Sync if_link uapi header
      libbpf: Add link-based API for netkit
      bpftool: Implement link show support for netkit
      bpftool: Extend net dump with netkit progs
      selftests/bpf: Add netlink helper library
      selftests/bpf: Add selftests for netkit

Dave Thaler (1):
      bpf, docs: Define signed modulo as using truncated division

Denys Zagorui (1):
      samples: bpf: Fix syscall_tp openat argument

Eduard Zingerman (7):
      bpf: move explored_state() closer to the beginning of verifier.c
      bpf: extract same_callsites() as utility function
      bpf: exact states comparison for iterator convergence checks
      selftests/bpf: tests with delayed read/precision makrs in loop body
      bpf: correct loop detection for iterators convergence
      selftests/bpf: test if state loops are detected in a tricky case
      bpf: print full verifier states on infinite loop detection

Hou Tao (8):
      mm/percpu.c: don't acquire pcpu_lock for pcpu_chunk_addr_search()
      mm/percpu.c: introduce pcpu_alloc_size()
      bpf: Re-enable unit_size checking for global per-cpu allocator
      bpf: Use pcpu_alloc_size() in bpf_mem_free{_rcu}()
      bpf: Move the declaration of __bpf_obj_drop_impl() to bpf.h
      bpf: Use bpf_global_percpu_ma for per-cpu kptr in __bpf_obj_drop_impl()
      selftests/bpf: Add more test cases for bpf memory allocator
      bpf: Add more WARN_ON_ONCE checks for mismatched alloc and free

Kumar Kartikeya Dwivedi (1):
      selftests/bpf: Make linked_list failure test more robust

Larysa Zaremba (1):
      selftests/bpf: Add options and frags to xdp_hw_metadata

Manu Bretelle (2):
      bpftool: Fix printing of pointer value
      bpftool: Wrap struct_ops dump in an array

Martin KaFai Lau (1):
      Merge branch 'Add bpf programmable net device'

Nikolay Aleksandrov (1):
      netkit: Remove explicit active/peer ptr initialization

Paul E. McKenney (1):
      bpf: Fold smp_mb__before_atomic() into atomic_set_release()

Sebastian Andrzej Siewior (1):
      net, bpf: Add a warning if NAPI cb missed xdp_do_flush().

Song Liu (1):
      bpf: Fix unnecessary -EBUSY from htab_lock_bucket

Viktor Malik (3):
      samples/bpf: Allow building with custom CFLAGS/LDFLAGS
      samples/bpf: Fix passing LDFLAGS to libbpf
      samples/bpf: Allow building with custom bpftool

Yafang Shao (3):
      bpf: Fix missed rcu read lock in bpf_task_under_cgroup()
      selftests/bpf: Add selftest for bpf_task_under_cgroup() in sleepable prog
      selftests/bpf: Fix selftests broken by mitigations=off

 .../bpf/standardization/instruction-set.rst        |   8 +
 MAINTAINERS                                        |   9 +
 drivers/net/Kconfig                                |   9 +
 drivers/net/Makefile                               |   1 +
 drivers/net/netkit.c                               | 936 +++++++++++++++++++++
 include/linux/bpf.h                                |   4 +
 include/linux/bpf_mem_alloc.h                      |   1 +
 include/linux/bpf_verifier.h                       |  35 +-
 include/linux/btf.h                                |   1 +
 include/linux/cgroup.h                             |  12 +-
 include/linux/percpu.h                             |   1 +
 include/net/netkit.h                               |  38 +
 include/net/tcx.h                                  |   7 +-
 include/net/xdp_sock.h                             |  16 +
 include/uapi/linux/bpf.h                           |  14 +
 include/uapi/linux/if_link.h                       |  24 +
 kernel/bpf/cgroup_iter.c                           |  65 ++
 kernel/bpf/cpumap.c                                |  10 +
 kernel/bpf/devmap.c                                |  10 +
 kernel/bpf/hashtab.c                               |   7 +-
 kernel/bpf/helpers.c                               |  40 +-
 kernel/bpf/memalloc.c                              |  42 +-
 kernel/bpf/ringbuf.c                               |   3 +-
 kernel/bpf/syscall.c                               |  36 +-
 kernel/bpf/task_iter.c                             | 151 ++++
 kernel/bpf/tcx.c                                   |   4 +-
 kernel/bpf/verifier.c                              | 569 +++++++++++--
 kernel/cgroup/cgroup.c                             |  18 +-
 mm/percpu.c                                        |  35 +-
 net/core/dev.c                                     |   2 +
 net/core/dev.h                                     |   6 +
 net/core/filter.c                                  |  16 +
 net/xdp/xsk.c                                      |  28 +
 samples/bpf/Makefile                               |  12 +-
 samples/bpf/syscall_tp_kern.c                      |  15 +-
 tools/bpf/bpftool/Documentation/bpftool-net.rst    |   8 +-
 tools/bpf/bpftool/btf_dumper.c                     |   2 +-
 tools/bpf/bpftool/link.c                           |   9 +
 tools/bpf/bpftool/net.c                            |   7 +-
 tools/bpf/bpftool/struct_ops.c                     |   6 +
 tools/include/uapi/linux/bpf.h                     |  14 +
 tools/include/uapi/linux/if_link.h                 | 141 ++++
 tools/lib/bpf/bpf.c                                |  16 +
 tools/lib/bpf/bpf.h                                |   5 +
 tools/lib/bpf/elf.c                                |  16 +-
 tools/lib/bpf/libbpf.c                             |  39 +
 tools/lib/bpf/libbpf.h                             |  15 +
 tools/lib/bpf/libbpf.map                           |   1 +
 tools/testing/selftests/bpf/Makefile               |  19 +-
 tools/testing/selftests/bpf/bpf_experimental.h     |  19 +
 tools/testing/selftests/bpf/config                 |   1 +
 tools/testing/selftests/bpf/netlink_helpers.c      | 358 ++++++++
 tools/testing/selftests/bpf/netlink_helpers.h      |  46 +
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c  |  18 +-
 tools/testing/selftests/bpf/prog_tests/iters.c     | 150 ++++
 .../testing/selftests/bpf/prog_tests/linked_list.c |  10 +-
 .../selftests/bpf/prog_tests/task_under_cgroup.c   |  11 +-
 .../testing/selftests/bpf/prog_tests/tc_helpers.h  |   4 +
 tools/testing/selftests/bpf/prog_tests/tc_netkit.c | 687 +++++++++++++++
 tools/testing/selftests/bpf/prog_tests/tc_opts.c   | 131 ++-
 .../testing/selftests/bpf/prog_tests/test_bpf_ma.c |  20 +-
 .../progs/{bpf_iter_task.c => bpf_iter_tasks.c}    |   0
 tools/testing/selftests/bpf/progs/iters.c          | 695 +++++++++++++++
 tools/testing/selftests/bpf/progs/iters_css.c      |  72 ++
 tools/testing/selftests/bpf/progs/iters_css_task.c |  47 ++
 tools/testing/selftests/bpf/progs/iters_task.c     |  41 +
 .../selftests/bpf/progs/iters_task_failure.c       | 105 +++
 tools/testing/selftests/bpf/progs/iters_task_vma.c |   1 +
 .../testing/selftests/bpf/progs/linked_list_fail.c |   4 +-
 tools/testing/selftests/bpf/progs/test_bpf_ma.c    | 180 +++-
 .../selftests/bpf/progs/test_task_under_cgroup.c   |  28 +-
 tools/testing/selftests/bpf/progs/test_tc_link.c   |  13 +
 .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |   2 +-
 tools/testing/selftests/bpf/unpriv_helpers.c       |  33 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |  78 +-
 75 files changed, 5037 insertions(+), 200 deletions(-)
 create mode 100644 drivers/net/netkit.c
 create mode 100644 include/net/netkit.h
 create mode 100644 tools/testing/selftests/bpf/netlink_helpers.c
 create mode 100644 tools/testing/selftests/bpf/netlink_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_netkit.c
 rename tools/testing/selftests/bpf/progs/{bpf_iter_task.c => bpf_iter_tasks.c} (100%)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_css.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_css_task.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_failure.c

