Return-Path: <bpf+bounces-3318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A3473C235
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 23:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B4F1C20EBF
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 21:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064BB134DA;
	Fri, 23 Jun 2023 21:13:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95420134A0;
	Fri, 23 Jun 2023 21:13:02 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361C483;
	Fri, 23 Jun 2023 14:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=iM6XiYzcOvYvmJY1x36fh/FcKP0wY71gqcBtL3f0WTI=; b=jaTled3nUisRZQ7NLYEC62IV21
	7Wr0puaAB7QlUmAh/bP3h4gl8qqfvJouQ/oL0eQd/vBnNlu645gMB7XmnLS+81x6835L4FFeubo6E
	a3hD0Fd3mN5+gvzaGsuzaUK696RYWu3H4bgdqJMhP3ik/p1bYOebrEve+ZeKCp+yI88EgvalCoLAd
	XqLRC6uixlLiKTThIwrAuuA5wQ7qhhUHMj95JwuSlZeWkXF+Ge4VmdFYji76I5jSe5/PVvIMQWUe2
	uYeS43nAn1O7wm3B1QZ97CpD5KiImca9ZFXdGgpylkOmMv71SKD3ZVk8+xXWBcRb02b4xy5AASOu9
	Ddk1wJZg==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qCo5R-0002ef-6C; Fri, 23 Jun 2023 23:12:57 +0200
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
Subject: pull-request: bpf-next 2023-06-23
Date: Fri, 23 Jun 2023 23:12:56 +0200
Message-Id: <20230623211256.8409-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 0.103.8/26948/Fri Jun 23 09:28:15 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 49 non-merge commits during the last 24 day(s) which contain
a total of 70 files changed, 1935 insertions(+), 442 deletions(-).

The main changes are:

1) Extend bpf_fib_lookup helper to allow passing the route table ID, from Louis DeLosSantos.

2) Fix regsafe() in verifier to call check_ids() for scalar registers, from Eduard Zingerman.

3) Extend the set of cpumask kfuncs with bpf_cpumask_first_and() and a rework of
   bpf_cpumask_any*() kfuncs. Additionally, add selftests, from David Vernet.

4) Fix socket lookup BPF helpers for tc/XDP to respect VRF bindings, from Gilad Sever.

5) Change bpf_link_put() to use workqueue unconditionally to fix it under PREEMPT_RT,
   from Sebastian Andrzej Siewior.

6) Follow-ups to address issues in the bpf_refcount shared ownership implementation,
   from Dave Marchevsky.

7) A few general refactorings to BPF map and program creation permissions checks which
   were part of the BPF token series, from Andrii Nakryiko.

8) Various fixes for benchmark framework and add a new benchmark for BPF memory
   allocator to BPF selftests, from Hou Tao.

9) Documentation improvements around iterators and trusted pointers, from Anton Protopopov.

10) Small cleanup in verifier to improve allocated object check, from Daniel T. Lee.

11) Improve performance of bpf_xdp_pointer() by avoiding access to shared_info when
    XDP packet does not have frags, from Jesper Dangaard Brouer.

12) Silence a harmless syzbot-reported warning in btf_type_id_size(), from Yonghong Song.

13) Remove duplicate bpfilter_umh_cleanup in favor of umd_cleanup_helper, from Jarkko Sakkinen.

14) Fix BPF selftests build for resolve_btfids under custom HOSTCFLAGS, from Viktor Malik.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Andrii Nakryiko, Dan Carpenter, Eyal Birger, Jiri Olsa, Kees Cook, 
kernel test robot, Kumar Kartikeya Dwivedi, Lorenzo Bianconi, Maciej 
Fijalkowski, Shmulik Ladkani, Simon Horman, Stanislav Fomichev, Tariq 
Toukan, Toke Høiland-Jørgensen, Yonghong Song

----------------------------------------------------------------

The following changes since commit bc590b47549225a03c6b36bbc1aede75c917767b:

  r8169: check for PCI read error in probe (2023-05-30 13:14:53 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to fbc5669de62a452fb3a26a4560668637d5c9e7b5:

  bpf, docs: Document existing macros instead of deprecated (2023-06-22 19:47:32 +0200)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Andrii Nakryiko (5):
      Merge branch 'verify scalar ids mapping in regsafe()'
      bpf: Move unprivileged checks into map_create() and bpf_prog_load()
      bpf: Inline map creation logic in map_create() function
      bpf: Centralize permissions checks for all BPF map types
      bpf: Keep BPF_PROG_LOAD permission checks clear of validations

Anton Protopopov (2):
      bpf, docs: BPF Iterator Document
      bpf, docs: Document existing macros instead of deprecated

Arnd Bergmann (1):
      bpf: Hide unused bpf_patch_call_args

Azeem Shaikh (1):
      bpf: Replace all non-returning strlcpy with strscpy

Daniel T. Lee (1):
      bpf: Replace open code with for allocated object check

Dave Marchevsky (3):
      bpf: Set kptr_struct_meta for node param to list and rbtree insert funcs
      bpf: Fix __bpf_{list,rbtree}_add's beginning-of-node calculation
      bpf: Make bpf_refcount_acquire fallible for non-owning refs

David Vernet (8):
      bpf: Teach verifier that trusted PTR_TO_BTF_ID pointers are non-NULL
      selftests/bpf: Add test for non-NULLable PTR_TO_BTF_IDs
      selftests/bpf: Add missing selftests kconfig options
      bpf: Add bpf_cpumask_first_and() kfunc
      selftests/bpf: Add test for new bpf_cpumask_first_and() kfunc
      bpf: Replace bpf_cpumask_any* with bpf_cpumask_any_distribute*
      selftests/bpf: Update bpf_cpumask_any* tests to use bpf_cpumask_any_distribute*
      bpf/docs: Update documentation for new cpumask kfuncs

Eduard Zingerman (5):
      selftests/bpf: Fix invalid pointer check in get_xlated_program()
      bpf: Use scalar ids in mark_chain_precision()
      selftests/bpf: Check if mark_chain_precision() follows scalar ids
      bpf: Verify scalar ids mapping in regsafe() using check_ids()
      selftests/bpf: Verify that check_ids() is used for scalars in regsafe()

Gilad Sever (4):
      bpf: Factor out socket lookup functions for the TC hookpoint.
      bpf: Call __bpf_sk_lookup()/__bpf_skc_lookup() directly via TC hookpoint
      bpf: Fix bpf socket lookup from tc/xdp to respect socket VRF bindings
      selftests/bpf: Add vrf_socket_lookup tests

Hou Tao (5):
      bpf: Factor out a common helper free_all()
      selftests/bpf: Use producer_cnt to allocate local counter array
      selftests/bpf: Output the correct error code for pthread APIs
      selftests/bpf: Ensure that next_cpu() returns a valid CPU number
      selftests/bpf: Set the default value of consumer_cnt as 0

Jarkko Sakkinen (1):
      net: Use umd_cleanup_helper()

Jesper Dangaard Brouer (3):
      samples/bpf: xdp1 and xdp2 reduce XDPBUFSIZE to 60
      bpf/xdp: optimize bpf_xdp_pointer to avoid reading sinfo
      selftests/bpf: Fix check_mtu using wrong variable type

Jiri Olsa (1):
      selftests/bpf: Add missing prototypes for several test kfuncs

Louis DeLosSantos (2):
      bpf: Add table ID to bpf_fib_lookup BPF helper
      selftests/bpf: Test table ID fib lookup BPF helper

Ruiqi Gong (1):
      bpf: Cleanup unused function declaration

Sebastian Andrzej Siewior (1):
      bpf: Remove in_atomic() from bpf_link_put().

Su Hui (1):
      bpf/tests: Use struct_size()

Viktor Malik (1):
      tools/resolve_btfids: Fix setting HOSTCFLAGS

Yonghong Song (3):
      bpf: Silence a warning in btf_type_id_size()
      selftests/bpf: Add a test where map key_type_id with decl_tag type
      selftests/bpf: Fix compilation failure for prog vrf_socket_lookup

YueHaibing (1):
      xsk: Remove unused inline function xsk_buff_discard()

 Documentation/bpf/bpf_iterators.rst                |   7 +-
 Documentation/bpf/cpumasks.rst                     |   5 +-
 Documentation/bpf/kfuncs.rst                       |  38 +-
 include/linux/bpf_verifier.h                       |  25 +-
 include/linux/bpfilter.h                           |   1 -
 include/linux/filter.h                             |   1 -
 include/linux/netdevice.h                          |   9 +
 include/net/xdp_sock_drv.h                         |   4 -
 include/uapi/linux/bpf.h                           |  21 +-
 kernel/bpf/bloom_filter.c                          |   3 -
 kernel/bpf/bpf_local_storage.c                     |   3 -
 kernel/bpf/bpf_struct_ops.c                        |   3 -
 kernel/bpf/btf.c                                   |  19 +-
 kernel/bpf/core.c                                  |   8 +-
 kernel/bpf/cpumap.c                                |   4 -
 kernel/bpf/cpumask.c                               |  38 +-
 kernel/bpf/devmap.c                                |   3 -
 kernel/bpf/hashtab.c                               |   6 -
 kernel/bpf/helpers.c                               |  12 +-
 kernel/bpf/lpm_trie.c                              |   3 -
 kernel/bpf/memalloc.c                              |  31 +-
 kernel/bpf/preload/bpf_preload_kern.c              |   4 +-
 kernel/bpf/queue_stack_maps.c                      |   4 -
 kernel/bpf/reuseport_array.c                       |   3 -
 kernel/bpf/stackmap.c                              |   3 -
 kernel/bpf/syscall.c                               | 184 +++---
 kernel/bpf/verifier.c                              | 248 ++++++--
 lib/test_bpf.c                                     |   3 +-
 net/bpfilter/bpfilter_kern.c                       |   2 +-
 net/core/filter.c                                  | 147 ++++-
 net/core/sock_map.c                                |   4 -
 net/ipv4/bpfilter/sockopt.c                        |  11 +-
 net/xdp/xskmap.c                                   |   4 -
 samples/bpf/xdp1_kern.c                            |   2 +-
 samples/bpf/xdp2_kern.c                            |   2 +-
 tools/bpf/resolve_btfids/Makefile                  |   4 +-
 tools/include/uapi/linux/bpf.h                     |  21 +-
 tools/testing/selftests/bpf/bench.c                |  15 +-
 tools/testing/selftests/bpf/bench.h                |   1 +
 .../selftests/bpf/benchs/bench_bloom_filter_map.c  |  14 +-
 .../bpf/benchs/bench_bpf_hashmap_full_update.c     |  10 +-
 .../bpf/benchs/bench_bpf_hashmap_lookup.c          |  10 +-
 .../testing/selftests/bpf/benchs/bench_bpf_loop.c  |  10 +-
 tools/testing/selftests/bpf/benchs/bench_count.c   |  14 +-
 .../selftests/bpf/benchs/bench_local_storage.c     |  12 +-
 .../bpf/benchs/bench_local_storage_create.c        |   8 +-
 .../benchs/bench_local_storage_rcu_tasks_trace.c   |  10 +-
 tools/testing/selftests/bpf/benchs/bench_rename.c  |  15 +-
 .../testing/selftests/bpf/benchs/bench_ringbufs.c  |   2 +-
 tools/testing/selftests/bpf/benchs/bench_strncmp.c |  11 +-
 tools/testing/selftests/bpf/benchs/bench_trigger.c |  21 +-
 .../selftests/bpf/benchs/run_bench_ringbufs.sh     |  26 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |  16 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h  |   7 +
 tools/testing/selftests/bpf/config                 |   4 +
 tools/testing/selftests/bpf/prog_tests/btf.c       |  40 ++
 tools/testing/selftests/bpf/prog_tests/check_mtu.c |   2 +-
 tools/testing/selftests/bpf/prog_tests/cpumask.c   |   2 +
 .../testing/selftests/bpf/prog_tests/fib_lookup.c  |  61 +-
 .../selftests/bpf/prog_tests/unpriv_bpf_disabled.c |   6 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/prog_tests/vrf_socket_lookup.c   | 312 ++++++++++
 tools/testing/selftests/bpf/progs/cpumask_common.h |   6 +-
 .../testing/selftests/bpf/progs/cpumask_success.c  |  64 +-
 .../testing/selftests/bpf/progs/refcounted_kptr.c  |   2 +
 .../selftests/bpf/progs/refcounted_kptr_fail.c     |   4 +-
 .../selftests/bpf/progs/verifier_scalar_ids.c      | 659 +++++++++++++++++++++
 .../selftests/bpf/progs/vrf_socket_lookup.c        |  89 +++
 tools/testing/selftests/bpf/test_verifier.c        |  24 +-
 tools/testing/selftests/bpf/verifier/precise.c     |   8 +-
 70 files changed, 1935 insertions(+), 442 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/vrf_socket_lookup.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
 create mode 100644 tools/testing/selftests/bpf/progs/vrf_socket_lookup.c

