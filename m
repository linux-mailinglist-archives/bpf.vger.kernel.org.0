Return-Path: <bpf+bounces-33049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC53A916987
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 15:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7238F282BEA
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 13:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9395416729D;
	Tue, 25 Jun 2024 13:55:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8891717C98;
	Tue, 25 Jun 2024 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323726; cv=none; b=VqGLWL00OqobJ9L+wUpPR5YnwmX6aRov7mclAli9vVem9M5n6HK5faaI078pfu/nwPUuDCmV7UMZcOut9OQIqhnfYFkp9dmHQAk41K3JreJ0KaJM6xqt1nyniJrhD+qNZ9YPhOhpMoEJ/w99CV5Holi/t1EngruuirpsNjI4JDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323726; c=relaxed/simple;
	bh=PJB1GXQ3sdnmuWUq3gmLr6Wc3qdwCrB5OOrER7VMSt4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hoz+se6PyaM1brOgMVbk/5Lc7HHiv/6mJ0N6OKTaVB7lF9xt79iucuIPz0vvGo/AMpy5R4EOu5cWIHiDwLPO42fr80mg0mmuUV2PYb7/dQraPpdHjF49ot5860QOdc+8CL6V/UvbjOjP8o44NRxEHPQcvRHF7uS+A2csakHjbj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W7mSY6P4rzZcHS;
	Tue, 25 Jun 2024 21:50:53 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0CAEF18006E;
	Tue, 25 Jun 2024 21:55:17 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Jun 2024 21:55:16 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH net-next v9 00/13] First try to replace page_frag with page_frag_cache
Date: Tue, 25 Jun 2024 21:52:03 +0800
Message-ID: <20240625135216.47007-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

After [1], there are still two implementations for page frag:

1. mm/page_alloc.c: net stack seems to be using it in the
   rx part with 'struct page_frag_cache' and the main API
   being page_frag_alloc_align().
2. net/core/sock.c: net stack seems to be using it in the
   tx part with 'struct page_frag' and the main API being
   skb_page_frag_refill().

This patchset tries to unfiy the page frag implementation
by replacing page_frag with page_frag_cache for sk_page_frag()
first. net_high_order_alloc_disable_key for the implementation
in net/core/sock.c doesn't seems matter that much now have
have pcp support for high-order pages in commit 44042b449872
("mm/page_alloc: allow high-order pages to be stored on the
per-cpu lists").

As the related change is mostly related to networking, so
targeting the net-next. And will try to replace the rest
of page_frag in the follow patchset.

After this patchset:
1. Unify the page frag implementation by taking the best out of
   two the existing implementations: we are able to save some space
   for the 'page_frag_cache' API user, and avoid 'get_page()' for
   the old 'page_frag' API user.
2. Future bugfix and performance can be done in one place, hence
   improving maintainability of page_frag's implementation.

Kernel Image changing:
    Linux Kernel   total |      text      data        bss
    ------------------------------------------------------
    after     45250307 |   27274279   17209996     766032
    before    45254134 |   27278118   17209984     766032
    delta        -3827 |      -3839        +12         +0

Performance validation:
1. Using micro-benchmark ko added in patch 1 to test aligned and
   non-aligned API performance impact for the existing users, there
   is no notiable performance degradation. Instead we seems to some
   minor performance boot for both aligned and non-aligned API after
   this patchset as below.

2. Use the below netcat test case, we also have some minor
   performance boot for repalcing 'page_frag' with 'page_frag_cache'
   after this patchset.
   server: taskset -c 32 nc -l -k 1234 > /dev/null
   client: perf stat -r 200 -- taskset -c 0 head -c 20G /dev/zero | taskset -c 1 nc 127.0.0.1 1234


In order to avoid performance noise as much as possible, the testing
is done in system without any other laod and have enough iterations to
prove the data is stable enogh, complete log for testing is below:

taskset -c 32 nc -l -k 1234 > /dev/null
perf stat -r 200 -- insmod ./page_frag_test.ko test_push_cpu=16 test_pop_cpu=17
perf stat -r 200 -- insmod ./page_frag_test.ko test_push_cpu=16 test_pop_cpu=17 test_align=1
perf stat -r 200 -- taskset -c 0 head -c 20G /dev/zero | taskset -c 1 nc 127.0.0.1 1234

*After* this patchset:

 Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=16 test_pop_cpu=17' (200 runs):

         17.829030      task-clock (msec)         #    0.001 CPUs utilized            ( +-  0.30% )
                 7      context-switches          #    0.386 K/sec                    ( +-  0.35% )
                 0      cpu-migrations            #    0.003 K/sec                    ( +- 28.06% )
                83      page-faults               #    0.005 M/sec                    ( +-  0.10% )
          46303585      cycles                    #    2.597 GHz                      ( +-  0.30% )
          61119216      instructions              #    1.32  insn per cycle           ( +-  0.01% )
          14811318      branches                  #  830.742 M/sec                    ( +-  0.01% )
             21046      branch-misses             #    0.14% of all branches          ( +-  0.09% )

      23.856064365 seconds time elapsed                                          ( +-  0.08% )


 Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=16 test_pop_cpu=17 test_align=1' (200 runs):

         17.628569      task-clock (msec)         #    0.001 CPUs utilized            ( +-  0.01% )
                 7      context-switches          #    0.397 K/sec                    ( +-  0.12% )
                 0      cpu-migrations            #    0.000 K/sec
                83      page-faults               #    0.005 M/sec                    ( +-  0.10% )
          45785943      cycles                    #    2.597 GHz                      ( +-  0.01% )
          60043610      instructions              #    1.31  insn per cycle           ( +-  0.01% )
          14550182      branches                  #  825.375 M/sec                    ( +-  0.01% )
             21492      branch-misses             #    0.15% of all branches          ( +-  0.08% )

      23.443927103 seconds time elapsed                                          ( +-  0.05% )

 Performance counter stats for 'taskset -c 0 head -c 20G /dev/zero' (200 runs):

      16626.042731      task-clock (msec)         #    0.607 CPUs utilized            ( +-  0.03% )
           3291020      context-switches          #    0.198 M/sec                    ( +-  0.05% )
                 1      cpu-migrations            #    0.000 K/sec                    ( +-  0.50% )
                85      page-faults               #    0.005 K/sec                    ( +-  0.16% )
       30581044838      cycles                    #    1.839 GHz                      ( +-  0.05% )
       34962744631      instructions              #    1.14  insn per cycle           ( +-  0.01% )
        6483883671      branches                  #  389.984 M/sec                    ( +-  0.02% )
          99624551      branch-misses             #    1.54% of all branches          ( +-  0.17% )

      27.370305077 seconds time elapsed                                          ( +-  0.01% )


*Before* this patchset:

Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=16 test_pop_cpu=17' (200 runs):

         18.143552      task-clock (msec)         #    0.001 CPUs utilized            ( +-  0.28% )
                 7      context-switches          #    0.382 K/sec                    ( +-  0.28% )
                 1      cpu-migrations            #    0.056 K/sec                    ( +-  0.97% )
                83      page-faults               #    0.005 M/sec                    ( +-  0.10% )
          47105569      cycles                    #    2.596 GHz                      ( +-  0.28% )
          60628757      instructions              #    1.29  insn per cycle           ( +-  0.04% )
          14686743      branches                  #  809.475 M/sec                    ( +-  0.04% )
             21826      branch-misses             #    0.15% of all branches          ( +-  0.12% )

      23.918006193 seconds time elapsed                                          ( +-  0.10% )

 Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=16 test_pop_cpu=17 test_align=1' (200 runs):

         21.726393      task-clock (msec)         #    0.001 CPUs utilized            ( +-  0.72% )
                 7      context-switches          #    0.321 K/sec                    ( +-  0.24% )
                 1      cpu-migrations            #    0.047 K/sec                    ( +-  0.85% )
                83      page-faults               #    0.004 M/sec                    ( +-  0.10% )
          56422898      cycles                    #    2.597 GHz                      ( +-  0.72% )
          61271860      instructions              #    1.09  insn per cycle           ( +-  0.05% )
          14837500      branches                  #  682.925 M/sec                    ( +-  0.05% )
             21484      branch-misses             #    0.14% of all branches          ( +-  0.10% )

      23.876306259 seconds time elapsed                                          ( +-  0.13% )

 Performance counter stats for 'taskset -c 0 head -c 20G /dev/zero' (200 runs):

      17364.040855      task-clock (msec)         #    0.624 CPUs utilized            ( +-  0.02% )
           3340375      context-switches          #    0.192 M/sec                    ( +-  0.06% )
                 1      cpu-migrations            #    0.000 K/sec
                85      page-faults               #    0.005 K/sec                    ( +-  0.15% )
       32077623335      cycles                    #    1.847 GHz                      ( +-  0.03% )
       35121047596      instructions              #    1.09  insn per cycle           ( +-  0.01% )
        6519872824      branches                  #  375.481 M/sec                    ( +-  0.02% )
         101877022      branch-misses             #    1.56% of all branches          ( +-  0.14% )

      27.842745343 seconds time elapsed                                          ( +-  0.02% )


Note, ipv4-udp, ipv6-tcp and ipv6-udp is also tested with the below script:
nc -u -l -k 1234 > /dev/null
perf stat -r 4 -- head -c 51200000000 /dev/zero | nc -N -u 127.0.0.1 1234

nc -l6 -k 1234 > /dev/null
perf stat -r 4 -- head -c 51200000000 /dev/zero | nc -N ::1 1234

nc -l6 -k -u 1234 > /dev/null
perf stat -r 4 -- head -c 51200000000 /dev/zero | nc -u -N ::1 1234

CC: Alexander Duyck <alexander.duyck@gmail.com>

1. https://lore.kernel.org/all/20240228093013.8263-1-linyunsheng@huawei.com/

Change log:
V9:
   1. Add check for test_alloc_len and change perm of module_param()
      to 0 as Wang Wei' comment.
   2. Rebased on latest net-next.

V8: Remove patch 2 & 3 in V7, as free_unref_page() is changed to call
    pcp_allowed_order() and used in page_frag API recently in:
    commit 5b8d75913a0e ("mm: combine free_the_page() and free_unref_page()")

V7: Fix doc build warning and error.

V6:
   1. Fix some typo and compiler error for x86 pointed out by Jakub and
      Simon.
   2. Add two refactoring and optimization patches.

V5:
   1. Add page_frag_alloc_pg() API for tls_device.c case and refactor
      some implementation, update kernel bin size changing as bin size
      is increased after that.
   2. Add ack from Mat.

RFC v4:
   1. Update doc according to Randy and Mat's suggestion.
   2. Change probe API to "probe" for a specific amount  of available space,
      rather than "nonzero" space according to Mat's suggestion.
   3. Retest and update the test result.

v3:
   1. Use new layout for 'struct page_frag_cache' as the discussion
      with Alexander and other sugeestions from Alexander.
   2. Add probe API to address Mat' comment about mptcp use case.
   3. Some doc updating according to Bagas' suggestion.

v2:
   1. reorder test module to patch 1.
   2. split doc and maintainer updating to two patches.
   3. refactor the page_frag before moving.
   4. fix a type and 'static' warning in test module.
   5. add a patch for xtensa arch to enable using get_order() in
      BUILD_BUG_ON().
   6. Add test case and performance data for the socket code.

Yunsheng Lin (13):
  mm: page_frag: add a test module for page_frag
  mm: move the page fragment allocator from page_alloc into its own file
  mm: page_frag: use initial zero offset for page_frag_alloc_align()
  mm: page_frag: add '_va' suffix to page_frag API
  mm: page_frag: avoid caller accessing 'page_frag_cache' directly
  mm: page_frag: reuse existing space for 'size' and 'pfmemalloc'
  mm: page_frag: some minor refactoring before adding new API
  mm: page_frag: use __alloc_pages() to replace alloc_pages_node()
  net: introduce the skb_copy_to_va_nocache() helper
  mm: page_frag: introduce prepare/probe/commit API
  net: replace page_frag with page_frag_cache
  mm: page_frag: update documentation for page_frag
  mm: page_frag: add a entry in MAINTAINERS for page_frag

 Documentation/mm/page_frags.rst               | 163 +++++++-
 MAINTAINERS                                   |  11 +
 .../chelsio/inline_crypto/chtls/chtls.h       |   3 -
 .../chelsio/inline_crypto/chtls/chtls_io.c    | 100 ++---
 .../chelsio/inline_crypto/chtls/chtls_main.c  |   3 -
 drivers/net/ethernet/google/gve/gve_rx.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |   2 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |   2 +-
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |   4 +-
 .../marvell/octeontx2/nic/otx2_common.c       |   2 +-
 drivers/net/ethernet/mediatek/mtk_wed_wo.c    |   4 +-
 drivers/net/tun.c                             |  44 +-
 drivers/nvme/host/tcp.c                       |   8 +-
 drivers/nvme/target/tcp.c                     |  22 +-
 drivers/vhost/net.c                           |   8 +-
 include/linux/gfp.h                           |  22 -
 include/linux/mm_types.h                      |  18 -
 include/linux/page_frag_cache.h               | 299 +++++++++++++
 include/linux/sched.h                         |   3 +-
 include/linux/skbuff.h                        |   7 +-
 include/net/sock.h                            |  29 +-
 kernel/bpf/cpumap.c                           |   2 +-
 kernel/exit.c                                 |   3 +-
 kernel/fork.c                                 |   3 +-
 mm/Kconfig.debug                              |   8 +
 mm/Makefile                                   |   2 +
 mm/page_alloc.c                               | 136 ------
 mm/page_frag_cache.c                          | 346 +++++++++++++++
 mm/page_frag_test.c                           | 393 ++++++++++++++++++
 net/core/skbuff.c                             |  79 ++--
 net/core/skmsg.c                              |  22 +-
 net/core/sock.c                               |  46 +-
 net/core/xdp.c                                |   2 +-
 net/ipv4/ip_output.c                          |  33 +-
 net/ipv4/tcp.c                                |  35 +-
 net/ipv4/tcp_output.c                         |  28 +-
 net/ipv6/ip6_output.c                         |  33 +-
 net/kcm/kcmsock.c                             |  30 +-
 net/mptcp/protocol.c                          |  67 +--
 net/rxrpc/conn_object.c                       |   4 +-
 net/rxrpc/local_object.c                      |   4 +-
 net/rxrpc/txbuf.c                             |  15 +-
 net/sched/em_meta.c                           |   2 +-
 net/sunrpc/svcsock.c                          |  12 +-
 net/tls/tls_device.c                          | 137 +++---
 46 files changed, 1642 insertions(+), 560 deletions(-)
 create mode 100644 include/linux/page_frag_cache.h
 create mode 100644 mm/page_frag_cache.c
 create mode 100644 mm/page_frag_test.c

-- 
2.33.0


