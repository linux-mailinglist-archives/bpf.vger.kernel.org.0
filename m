Return-Path: <bpf+bounces-26117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2C989B0FA
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 15:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC851F218A0
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 13:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4AB38DE9;
	Sun,  7 Apr 2024 13:11:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223BE37700;
	Sun,  7 Apr 2024 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495460; cv=none; b=Y49DTpdpqWj+iaD/X1c5Y9oQd+Bcl89u77G5gnC86CkqyBZ+yG3qLsJWE0GJL1oyb5F/3+W2/h38Okz4b7+pKb5k70ar/hWQkXz0Xv5ynBTA2grZs1j/9JsBg8AxxqlDswAZRvQiaiQp9JG+8XoTylHUP9uYceKntIYzt/2RaVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495460; c=relaxed/simple;
	bh=pYYv09HgrZO8dDeNfrFDpFe3TGrfSXjtQZHpPFKc/BU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=McrzPtQ0T1q5HKfrkPmRjHfRmJvu2wFKLT1qHkxWEClSvwXujGTSFlxY113M6KO+9Da31IxhCCDl8b4dyjIew63eTJ4YlIIVAiIdK+SaPZcjVySGKyv85VX5PnN9ugT10JVTnC9bqGyl4PLkc7JTyxPIP/Q4k3d0xKTh7R7GRIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VCCJ30Xjdz1GCqF;
	Sun,  7 Apr 2024 21:10:11 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 05B0E1A0172;
	Sun,  7 Apr 2024 21:10:54 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 21:10:53 +0800
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
Subject: [PATCH net-next v1 00/12] First try to replace page_frag with page_frag_cache
Date: Sun, 7 Apr 2024 21:08:37 +0800
Message-ID: <20240407130850.19625-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)

After [1], Only there are two implementations for page frag:

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

After this patchset, we are not only able to unify the page
frag implementation a little, but seems able to have about
0.5+% performance boost testing by using the vhost_net_test
introduced in [1] and page_frag_test.ko introduced in this
patch.

Before this patchset:
Performance counter stats for './vhost_net_test' (10 runs):

         603027.29 msec task-clock                       #    1.756 CPUs utilized               ( +-  0.04% )
           2097713      context-switches                 #    3.479 K/sec                       ( +-  0.00% )
               212      cpu-migrations                   #    0.352 /sec                        ( +-  4.72% )
                40      page-faults                      #    0.066 /sec                        ( +-  1.18% )
      467215266413      cycles                           #    0.775 GHz                         ( +-  0.12% )  (66.02%)
      131736729037      stalled-cycles-frontend          #   28.20% frontend cycles idle        ( +-  2.38% )  (64.34%)
       77728393294      stalled-cycles-backend           #   16.64% backend cycles idle         ( +-  3.98% )  (65.42%)
      345874254764      instructions                     #    0.74  insn per cycle
                                                  #    0.38  stalled cycles per insn     ( +-  0.75% )  (70.28%)
      105166217892      branches                         #  174.397 M/sec                       ( +-  0.65% )  (68.56%)
        9649321070      branch-misses                    #    9.18% of all branches             ( +-  0.69% )  (65.38%)

           343.376 +- 0.147 seconds time elapsed  ( +-  0.04% )


 Performance counter stats for 'insmod ./page_frag_test.ko nr_test=99999999' (30 runs):

             39.12 msec task-clock                       #    0.001 CPUs utilized               ( +-  4.51% )
                 5      context-switches                 #  127.805 /sec                        ( +-  3.76% )
                 1      cpu-migrations                   #   25.561 /sec                        ( +- 15.52% )
               197      page-faults                      #    5.035 K/sec                       ( +-  0.10% )
          10689913      cycles                           #    0.273 GHz                         ( +-  9.46% )  (72.72%)
           2821237      stalled-cycles-frontend          #   26.39% frontend cycles idle        ( +- 12.04% )  (76.23%)
           5035549      stalled-cycles-backend           #   47.11% backend cycles idle         ( +-  9.69% )  (49.40%)
           5439395      instructions                     #    0.51  insn per cycle
                                                  #    0.93  stalled cycles per insn     ( +- 11.58% )  (51.45%)
           1274419      branches                         #   32.575 M/sec                       ( +- 12.69% )  (77.88%)
             49562      branch-misses                    #    3.89% of all branches             ( +-  9.91% )  (72.32%)

            30.309 +- 0.305 seconds time elapsed  ( +-  1.01% )


After this patchset:
Performance counter stats for './vhost_net_test' (10 runs):

         598081.02 msec task-clock                       #    1.752 CPUs utilized               ( +-  0.11% )
           2097738      context-switches                 #    3.507 K/sec                       ( +-  0.00% )
               220      cpu-migrations                   #    0.368 /sec                        ( +-  6.58% )
                40      page-faults                      #    0.067 /sec                        ( +-  0.92% )
      469788205101      cycles                           #    0.785 GHz                         ( +-  0.27% )  (64.86%)
      137108509582      stalled-cycles-frontend          #   29.19% frontend cycles idle        ( +-  0.96% )  (63.62%)
       75499065401      stalled-cycles-backend           #   16.07% backend cycles idle         ( +-  1.04% )  (65.86%)
      345469451681      instructions                     #    0.74  insn per cycle
                                                  #    0.40  stalled cycles per insn     ( +-  0.37% )  (70.16%)
      102782224964      branches                         #  171.853 M/sec                       ( +-  0.62% )  (69.28%)
        9295357532      branch-misses                    #    9.04% of all branches             ( +-  1.08% )  (66.21%)

           341.466 +- 0.305 seconds time elapsed  ( +-  0.09% )


 Performance counter stats for 'insmod ./page_frag_test.ko nr_test=99999999' (30 runs):

             40.09 msec task-clock                       #    0.001 CPUs utilized               ( +-  4.60% )
                 5      context-switches                 #  124.722 /sec                        ( +-  3.45% )
                 1      cpu-migrations                   #   24.944 /sec                        ( +- 12.62% )
               197      page-faults                      #    4.914 K/sec                       ( +-  0.11% )
          10221721      cycles                           #    0.255 GHz                         ( +-  9.05% )  (27.73%)
           2459009      stalled-cycles-frontend          #   24.06% frontend cycles idle        ( +- 10.80% )  (29.05%)
           5148423      stalled-cycles-backend           #   50.37% backend cycles idle         ( +-  7.30% )  (82.47%)
           5889929      instructions                     #    0.58  insn per cycle
                                                  #    0.87  stalled cycles per insn     ( +- 11.85% )  (87.75%)
           1276667      branches                         #   31.846 M/sec                       ( +- 11.48% )  (89.80%)
             50631      branch-misses                    #    3.97% of all branches             ( +-  8.72% )  (83.20%)

            29.341 +- 0.300 seconds time elapsed  ( +-  1.02% )

CC: Alexander Duyck <alexander.duyck@gmail.com>

1. https://lore.kernel.org/all/20240228093013.8263-1-linyunsheng@huawei.com/

Yunsheng Lin (12):
  mm: Move the page fragment allocator from page_alloc into its own file
  mm: page_frag: use initial zero offset for page_frag_alloc_align()
  mm: page_frag: change page_frag_alloc_* API to accept align param
  mm: page_frag: add '_va' suffix to page_frag API
  mm: page_frag: add two inline helper for page_frag API
  mm: page_frag: reuse MSB of 'size' field for pfmemalloc
  mm: page_frag: reuse existing bit field of 'va' for pagecnt_bias
  net: introduce the skb_copy_to_va_nocache() helper
  mm: page_frag: introduce prepare/commit API for page_frag
  net: replace page_frag with page_frag_cache
  mm: page_frag: add a test module for page_frag
  mm: page_frag: update documentation and maintainer for page_frag

 Documentation/mm/page_frags.rst               | 115 ++++--
 MAINTAINERS                                   |  10 +
 .../chelsio/inline_crypto/chtls/chtls.h       |   3 -
 .../chelsio/inline_crypto/chtls/chtls_io.c    | 101 ++---
 .../chelsio/inline_crypto/chtls/chtls_main.c  |   3 -
 drivers/net/ethernet/google/gve/gve_rx.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |   2 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |   2 +-
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |   4 +-
 .../marvell/octeontx2/nic/otx2_common.c       |   2 +-
 drivers/net/ethernet/mediatek/mtk_wed_wo.c    |   4 +-
 drivers/net/tun.c                             |  34 +-
 drivers/nvme/host/tcp.c                       |   8 +-
 drivers/nvme/target/tcp.c                     |  22 +-
 drivers/vhost/net.c                           |   6 +-
 include/linux/gfp.h                           |  22 --
 include/linux/mm_types.h                      |  18 -
 include/linux/page_frag_cache.h               | 339 ++++++++++++++++
 include/linux/sched.h                         |   4 +-
 include/linux/skbuff.h                        |  15 +-
 include/net/sock.h                            |  29 +-
 kernel/bpf/cpumap.c                           |   2 +-
 kernel/exit.c                                 |   3 +-
 kernel/fork.c                                 |   2 +-
 mm/Kconfig.debug                              |   8 +
 mm/Makefile                                   |   2 +
 mm/page_alloc.c                               | 136 -------
 mm/page_frag_cache.c                          | 185 +++++++++
 mm/page_frag_test.c                           | 366 ++++++++++++++++++
 net/core/skbuff.c                             |  57 +--
 net/core/skmsg.c                              |  22 +-
 net/core/sock.c                               |  46 ++-
 net/core/xdp.c                                |   2 +-
 net/ipv4/ip_output.c                          |  35 +-
 net/ipv4/tcp.c                                |  35 +-
 net/ipv4/tcp_output.c                         |  28 +-
 net/ipv6/ip6_output.c                         |  35 +-
 net/kcm/kcmsock.c                             |  30 +-
 net/mptcp/protocol.c                          |  74 ++--
 net/rxrpc/txbuf.c                             |  16 +-
 net/sunrpc/svcsock.c                          |   4 +-
 net/tls/tls_device.c                          | 139 ++++---
 43 files changed, 1404 insertions(+), 572 deletions(-)
 create mode 100644 include/linux/page_frag_cache.h
 create mode 100644 mm/page_frag_cache.c
 create mode 100644 mm/page_frag_test.c

-- 
2.33.0


