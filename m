Return-Path: <bpf+bounces-29760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCBF8C66F1
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 15:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4EFB284A1E
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 13:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9002886258;
	Wed, 15 May 2024 13:12:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC6A84A3E;
	Wed, 15 May 2024 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715778753; cv=none; b=oQ0d1QnxzdalUsWmWKAz9Q61hQEH0ipB1uBPbxRsWyLhspcpcDBy7XI+gW0TvVCAcc70l/cjQKjwn3zsAoeI63mG7pSCS/y1VuwbPpLDfDa+m98yvahAxIdRh9f/TBnYTFW5tj0uBWRAG8zu0zw+dEAQPEC2Yj7Ey/wtETuhqsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715778753; c=relaxed/simple;
	bh=M9xUU0Yre0YSJdQIdjpNEpQm1pDk9BuXZTmbI8DXbss=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=puQ+dY+pwaZkX3x9zt61d8mSZ9BlOvIMmNrAUAO9mu5n7XGqi7dnl9YZinbCsh6b4lF6H8oRqwi/9n2dMiBQo6M7RiZLOl0Vx1y0UaGVo4gzVLPA3EqsoBqlvUqsmojQmZS51iw3D86eD9tNVrSuPc9YRuv0IjAgcIbzXWohFU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VfYWf2kzhzCrvv;
	Wed, 15 May 2024 21:11:10 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id BBDBA180080;
	Wed, 15 May 2024 21:12:24 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 21:12:24 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<bpf@vger.kernel.org>
Subject: [RFC v4 00/13] First try to replace page_frag with page_frag_cache
Date: Wed, 15 May 2024 21:09:19 +0800
Message-ID: <20240515130932.18842-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)

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
    after     44893035 |  27084547   17042328     766160
    before    44896899 |  27088459   17042280     766160
    delta        -3864 |     -3912        +48         +0

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

Change log:
RFC v4:
   1. updating doc according to Randy and Mat's suggestion.
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
  xtensa: remove the get_order() implementation
  mm: page_frag: use free_unref_page() to free page fragment
  mm: move the page fragment allocator from page_alloc into its own file
  mm: page_frag: use initial zero offset for page_frag_alloc_align()
  mm: page_frag: add '_va' suffix to page_frag API
  mm: page_frag: avoid caller accessing 'page_frag_cache' directly
  mm: page_frag: reuse existing space for 'size' and 'pfmemalloc'
  net: introduce the skb_copy_to_va_nocache() helper
  mm: page_frag: introduce prepare/probe/commit API
  net: replace page_frag with page_frag_cache
  mm: page_frag: update documentation for page_frag
  mm: page_frag: add a entry in MAINTAINERS for page_frag

 Documentation/mm/page_frags.rst               | 165 +++++++-
 MAINTAINERS                                   |  11 +
 arch/xtensa/include/asm/page.h                |  18 -
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
 include/linux/page_frag_cache.h               | 297 ++++++++++++++
 include/linux/sched.h                         |   4 +-
 include/linux/skbuff.h                        |   3 +-
 include/net/sock.h                            |  29 +-
 kernel/bpf/cpumap.c                           |   2 +-
 kernel/exit.c                                 |   3 +-
 kernel/fork.c                                 |   3 +-
 mm/Kconfig.debug                              |   8 +
 mm/Makefile                                   |   2 +
 mm/page_alloc.c                               | 136 ------
 mm/page_frag_cache.c                          | 334 +++++++++++++++
 mm/page_frag_test.c                           | 386 ++++++++++++++++++
 net/core/skbuff.c                             |  83 ++--
 net/core/skmsg.c                              |  22 +-
 net/core/sock.c                               |  46 ++-
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
 net/tls/tls_device.c                          | 139 ++++---
 47 files changed, 1626 insertions(+), 578 deletions(-)
 create mode 100644 include/linux/page_frag_cache.h
 create mode 100644 mm/page_frag_cache.c
 create mode 100644 mm/page_frag_test.c

-- 
2.33.0


