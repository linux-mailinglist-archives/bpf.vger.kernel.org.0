Return-Path: <bpf+bounces-51227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ABBA32237
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 10:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2531655E9
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 09:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338DB2063D2;
	Wed, 12 Feb 2025 09:33:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FBD1F0E56;
	Wed, 12 Feb 2025 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352799; cv=none; b=Q1JudiKATVQOhIxsbF2VHg01gSNhPi6pSdEuJdlZRK6Ik+fJ4CHRM/wPvzfUyXRhY7rlx/ZoxD0vjDK6vBH7IsiTLSvbGj3QlwxpbmCsoOQrTWWTtCdwKUP1Ec3GtgnlDQnOdBvcKgSMypwlNPUrqkTBDXFM9Y1H+9hHrUK5IZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352799; c=relaxed/simple;
	bh=715Z4OdSCHh6MXtC19TgD3L3sLnavMWEJw8JmA8boCo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dX1VIMZOrKxvE5RKJxpfy1c13V6LWGpIuebMzK58rCxP63v72TXuiHmX2rExoD/iLc2LuELo2mTTPDU88k5wxJ1d69Mod3NidODbnf6LklYQOlbHDAfFrljsQBpP4iBBTvnQVTUGI6FFZWKFcNFji3ZRm6YRtpK/L5y/kZreohU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YtCgq66YKz1V6dV;
	Wed, 12 Feb 2025 17:29:27 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 428F7180069;
	Wed, 12 Feb 2025 17:33:14 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Feb 2025 17:33:13 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <zhangkun09@huawei.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Robin Murphy <robin.murphy@arm.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, Andrew Morton
	<akpm@linux-foundation.org>, IOMMU <iommu@lists.linux.dev>, MM
	<linux-mm@kvack.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH net-next v9 0/4] fix the DMA API misuse problem for page_pool
Date: Wed, 12 Feb 2025 17:25:47 +0800
Message-ID: <20250212092552.1779679-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

This patchset fix the dma API misuse problem as mentioned in [1].

From the below performance data, the overhead is not so obvious
due to performance variations in arm64 server and less than 1 ns in
x86 server for time_bench_page_pool01_fast_path() and
time_bench_page_pool02_ptr_ring, and there is about 10~20ns overhead
for time_bench_page_pool03_slow(), see more detail in [2].

arm64 server:
Before this patchset:
              fast_path              ptr_ring            slow
1.         31.171 ns               60.980 ns          164.917 ns
2.         28.824 ns               60.891 ns          170.241 ns
3.         14.236 ns               60.583 ns          164.355 ns

With patchset:
6.         26.163 ns               53.781 ns          189.450 ns
7.         26.189 ns               53.798 ns          189.466 ns

X86 server:
| Test name  |Cycles |   1-5 |    | Nanosec |    1-5 |        |      % |
| (tasklet_*)|Before | After |diff|  Before |  After |   diff | change |
|------------+-------+-------+----+---------+--------+--------+--------|
| fast_path  |    19 |    19 |   0|   5.399 |  5.492 |  0.093 |    1.7 |
| ptr_ring   |    54 |    57 |   3|  15.090 | 15.849 |  0.759 |    5.0 |
| slow       |   238 |   284 |  46|  66.134 | 78.909 | 12.775 |   19.3 |

And about 16 bytes of memory is also needed for each page_pool owned
page to fix the dma API misuse problem 

1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/
2. https://lore.kernel.org/all/f558df7a-d983-4fc5-8358-faf251994d23@kernel.org/

CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Robin Murphy <robin.murphy@arm.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: IOMMU <iommu@lists.linux.dev>
CC: MM <linux-mm@kvack.org>

Change log:
V9.
  1. Drop the fix of a possible time window problem for NPAI recycling.
  2. Add design description for the fix in patch 2.

V8:
  1. Drop last 3 patch as it causes observable performance degradation
     for x86 system.
  2. Remove rcu read lock in page_pool_napi_local().
  3. Renaming item function more consistently.

V7:
  1. Fix a used-after-free bug reported by KASAN as mentioned by Jakub.
  2. Fix the 'netmem' variable not setting up correctly bug as mentioned
     by Simon.

V6:
  1. Repost based on latest net-next.
  2. Rename page_pool_to_pp() to page_pool_get_pp().

V5:
  1. Support unlimit inflight pages.
  2. Add some optimization to avoid the overhead of fixing bug.

V4:
  1. use scanning to do the unmapping
  2. spilt dma sync skipping into separate patch

V3:
  1. Target net-next tree instead of net tree.
  2. Narrow the rcu lock as the discussion in v2.
  3. Check the ummapping cnt against the inflight cnt.

V2:
  1. Add a item_full stat.
  2. Use container_of() for page_pool_to_pp().

Yunsheng Lin (4):
  page_pool: introduce page_pool_get_pp() API
  page_pool: fix IOMMU crash when driver has already unbound
  page_pool: support unlimited number of inflight pages
  page_pool: skip dma sync operation for inflight pages

 drivers/net/ethernet/freescale/fec_main.c     |   8 +-
 .../ethernet/google/gve/gve_buffer_mgmt_dqo.c |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |   6 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  14 +-
 drivers/net/ethernet/intel/libeth/rx.c        |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |   3 +-
 drivers/net/netdevsim/netdev.c                |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |   2 +-
 include/linux/mm_types.h                      |   2 +-
 include/linux/skbuff.h                        |   1 +
 include/net/libeth/rx.h                       |   3 +-
 include/net/netmem.h                          |  31 +-
 include/net/page_pool/helpers.h               |  15 +
 include/net/page_pool/memory_provider.h       |   2 +-
 include/net/page_pool/types.h                 |  46 +-
 net/core/devmem.c                             |   6 +-
 net/core/netmem_priv.h                        |   5 +-
 net/core/page_pool.c                          | 423 ++++++++++++++++--
 net/core/page_pool_priv.h                     |  10 +-
 19 files changed, 504 insertions(+), 83 deletions(-)

-- 
2.33.0


