Return-Path: <bpf+bounces-29073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEC18BFED2
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 15:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411101C224EE
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 13:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279657C6C1;
	Wed,  8 May 2024 13:36:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938FF182CC;
	Wed,  8 May 2024 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175401; cv=none; b=EMFkc94F9o5a8YdhrS3EXYhqSKWIQtckcC7aq79MszXd5AD2L+WUgUx98Ld7JlobZP+D7SnLVztj/Htxn3x7wjiDXdHwYhZNylXHULLf+7zUqJJG/cTawOnNmVMk6i+lWCyRFwvoiH2/AMpq1Zrb36P51u0VrqhA7lLAGvxFXVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175401; c=relaxed/simple;
	bh=cUhMhwCGkwKQuoCVgliZGgyA6q+XvXbjp6SmiV+ZHZo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dXUYSz9fEoHeq6OsISxbbptXJxhs0DcKHuj5YxB7O1xEGdha8ks6PUUoseEdd9Cmo6ekSmaYHJIZ0LHGHPQP4EzKTnVcdu4keb6u2IwvqpWPy66mbpGeXrQ53Avj0+NhWkXGy41INEPoi9hyx/SdyPIZQL/5Csv6ParO3quIVOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VZGLM3sXnz1RCcJ;
	Wed,  8 May 2024 21:33:15 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 787D41800B8;
	Wed,  8 May 2024 21:36:35 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 21:36:35 +0800
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
Subject: [PATCH net-next v3 00/13] First try to replace page_frag with page_frag_cache
Date: Wed, 8 May 2024 21:33:55 +0800
Message-ID: <20240508133408.54708-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
   is no notiable performance degradation. Instead we have some minor
   performance boot for both aligned and non-aligned API after this
   patchset as below.

2. Use the below netcat test case, we also have some minor
   performance boot for repalcing 'page_frag' with 'page_frag_cache'
   after this patchset.
   server: nc -l -k 1234 > /dev/null
   client: perf stat -r 30 -- head -c 51200000000 /dev/zero | nc -N 127.0.0.1 1234


In order to avoid performance noise as much as possible, the testing
is done in system without any other laod and have enough iterations to
prove the data is stable enogh, complete log for testing is below:

*After* this patchset:
Performance counter stats for 'insmod ./page_frag_test.ko' (200 runs):

         17.959047      task-clock (msec)         #    0.001 CPUs utilized            ( +-  0.16% )
                 7      context-switches          #    0.371 K/sec                    ( +-  0.52% )
                 1      cpu-migrations            #    0.037 K/sec                    ( +-  5.25% )
                84      page-faults               #    0.005 M/sec                    ( +-  0.10% )
          46630340      cycles                    #    2.596 GHz                      ( +-  0.16% )
          60991298      instructions              #    1.31  insn per cycle           ( +-  0.03% )
          14778609      branches                  #  822.906 M/sec                    ( +-  0.03% )
             21461      branch-misses             #    0.15% of all branches          ( +-  0.35% )

      25.071309168 seconds time elapsed                                          ( +-  0.42% )

Performance counter stats for 'insmod ./page_frag_test.ko test_align=1' (200 runs):

         17.518324      task-clock (msec)         #    0.001 CPUs utilized            ( +-  0.22% )
                 7      context-switches          #    0.397 K/sec                    ( +-  0.22% )
                 0      cpu-migrations            #    0.014 K/sec                    ( +- 12.78% )
                84      page-faults               #    0.005 M/sec                    ( +-  0.10% )
          45494458      cycles                    #    2.597 GHz                      ( +-  0.22% )
          61059177      instructions              #    1.34  insn per cycle           ( +-  0.02% )
          14792330      branches                  #  844.392 M/sec                    ( +-  0.02% )
             21132      branch-misses             #    0.14% of all branches          ( +-  0.17% )

      26.156288028 seconds time elapsed                                          ( +-  0.41% )

 perf stat -r 30 -- head -c 51200000000 /dev/zero | nc -N 127.0.0.1 1234
 Performance counter stats for 'head -c 51200000000 /dev/zero' (30 runs):

         107793.53 msec task-clock                       #    0.881 CPUs utilized               ( +-  0.36% )
            380421      context-switches                 #    3.529 K/sec                       ( +-  0.32% )
               374      cpu-migrations                   #    3.470 /sec                        ( +-  1.31% )
                74      page-faults                      #    0.686 /sec                        ( +-  0.28% )
       92758718093      cycles                           #    0.861 GHz                         ( +-  0.48% )  (69.47%)
        7035559641      stalled-cycles-frontend          #    7.58% frontend cycles idle        ( +-  1.19% )  (69.65%)
       33668082825      stalled-cycles-backend           #   36.30% backend cycles idle         ( +-  0.84% )  (70.18%)
       52424770535      instructions                     #    0.57  insn per cycle
                                                  #    0.64  stalled cycles per insn     ( +-  0.26% )  (61.93%)
       13240874953      branches                         #  122.836 M/sec                       ( +-  0.40% )  (60.36%)
         208178019      branch-misses                    #    1.57% of all branches             ( +-  0.65% )  (68.42%)

           122.294 +- 0.402 seconds time elapsed  ( +-  0.33% )


*Before* this patchset:
 Performance counter stats for 'insmod ./page_frag_test_frag_page_v3_org.ko' (200 runs):

         17.878013      task-clock (msec)         #    0.001 CPUs utilized            ( +-  0.02% )
                 7      context-switches          #    0.384 K/sec                    ( +-  0.37% )
                 0      cpu-migrations            #    0.002 K/sec                    ( +- 34.73% )
                83      page-faults               #    0.005 M/sec                    ( +-  0.11% )
          46428731      cycles                    #    2.597 GHz                      ( +-  0.02% )
          61080812      instructions              #    1.32  insn per cycle           ( +-  0.01% )
          14802110      branches                  #  827.951 M/sec                    ( +-  0.01% )
             33011      branch-misses             #    0.22% of all branches          ( +-  0.10% )

      26.923903379 seconds time elapsed                                          ( +-  0.32% )


 Performance counter stats for 'insmod ./page_frag_test_frag_page_v3_org.ko test_align=1' (200 runs):

         17.579978      task-clock (msec)         #    0.001 CPUs utilized            ( +-  0.05% )
                 7      context-switches          #    0.393 K/sec                    ( +-  0.31% )
                 0      cpu-migrations            #    0.014 K/sec                    ( +- 12.96% )
                83      page-faults               #    0.005 M/sec                    ( +-  0.10% )
          45649145      cycles                    #    2.597 GHz                      ( +-  0.05% )
          60999424      instructions              #    1.34  insn per cycle           ( +-  0.03% )
          14778647      branches                  #  840.652 M/sec                    ( +-  0.03% )
             33148      branch-misses             #    0.22% of all branches          ( +-  0.11% )

      27.454413570 seconds time elapsed                                          ( +-  0.48% )

 perf stat -r 30 -- head -c 51200000000 /dev/zero | nc -N 127.0.0.1 1234
 Performance counter stats for 'head -c 51200000000 /dev/zero' (30 runs):

         110198.93 msec task-clock                       #    0.884 CPUs utilized               ( +-  0.83% )
            387680      context-switches                 #    3.518 K/sec                       ( +-  0.85% )
               366      cpu-migrations                   #    3.321 /sec                        ( +- 11.38% )
                74      page-faults                      #    0.672 /sec                        ( +-  0.27% )
       92978008685      cycles                           #    0.844 GHz                         ( +-  0.49% )  (64.93%)
        7339938950      stalled-cycles-frontend          #    7.89% frontend cycles idle        ( +-  1.48% )  (67.15%)
       34783792329      stalled-cycles-backend           #   37.41% backend cycles idle         ( +-  1.52% )  (68.96%)
       51704527141      instructions                     #    0.56  insn per cycle
                                                  #    0.67  stalled cycles per insn     ( +-  0.37% )  (68.28%)
       12865503633      branches                         #  116.748 M/sec                       ( +-  0.88% )  (66.11%)
         212414695      branch-misses                    #    1.65% of all branches             ( +-  0.45% )  (64.57%)

           124.664 +- 0.990 seconds time elapsed  ( +-  0.79% )


Note, ipv4-udp, ipv6-tcp and ipv6-udp is also tested with the below script:
nc -u -l -k 1234 > /dev/null
perf stat -r 4 -- head -c 51200000000 /dev/zero | nc -N -u 127.0.0.1 1234

nc -l6 -k 1234 > /dev/null
perf stat -r 4 -- head -c 51200000000 /dev/zero | nc -N ::1 1234

nc -l6 -k -u 1234 > /dev/null
perf stat -r 4 -- head -c 51200000000 /dev/zero | nc -u -N ::1 1234

CC: Alexander Duyck <alexander.duyck@gmail.com>

Change log:
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

 Documentation/mm/page_frags.rst               | 156 ++++++-
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
 drivers/net/tun.c                             |  28 +-
 drivers/nvme/host/tcp.c                       |   8 +-
 drivers/nvme/target/tcp.c                     |  22 +-
 drivers/vhost/net.c                           |   8 +-
 include/linux/gfp.h                           |  22 -
 include/linux/mm_types.h                      |  18 -
 include/linux/page_frag_cache.h               | 278 +++++++++++++
 include/linux/sched.h                         |   4 +-
 include/linux/skbuff.h                        |   3 +-
 include/net/sock.h                            |  29 +-
 kernel/bpf/cpumap.c                           |   2 +-
 kernel/exit.c                                 |   3 +-
 kernel/fork.c                                 |   3 +-
 mm/Kconfig.debug                              |   8 +
 mm/Makefile                                   |   2 +
 mm/page_alloc.c                               | 136 -------
 mm/page_frag_cache.c                          | 337 ++++++++++++++++
 mm/page_frag_test.c                           | 379 ++++++++++++++++++
 net/core/skbuff.c                             |  56 +--
 net/core/skmsg.c                              |  22 +-
 net/core/sock.c                               |  46 ++-
 net/core/xdp.c                                |   2 +-
 net/ipv4/ip_output.c                          |  33 +-
 net/ipv4/tcp.c                                |  35 +-
 net/ipv4/tcp_output.c                         |  28 +-
 net/ipv6/ip6_output.c                         |  33 +-
 net/kcm/kcmsock.c                             |  30 +-
 net/mptcp/protocol.c                          |  70 ++--
 net/rxrpc/conn_object.c                       |   4 +-
 net/rxrpc/local_object.c                      |   4 +-
 net/rxrpc/txbuf.c                             |  15 +-
 net/sched/em_meta.c                           |   2 +-
 net/sunrpc/svcsock.c                          |  12 +-
 net/tls/tls_device.c                          | 139 ++++---
 47 files changed, 1576 insertions(+), 556 deletions(-)
 create mode 100644 include/linux/page_frag_cache.h
 create mode 100644 mm/page_frag_cache.c
 create mode 100644 mm/page_frag_test.c

-- 
2.33.0


