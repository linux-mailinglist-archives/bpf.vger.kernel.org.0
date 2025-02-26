Return-Path: <bpf+bounces-52633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20289A45CC6
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 12:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 513CE175D7E
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 11:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E512153D3;
	Wed, 26 Feb 2025 11:11:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA15420E31F;
	Wed, 26 Feb 2025 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740568279; cv=none; b=pLS6gTZMcSIFMWSBIgdUrlwW2KdxlYkNQlD/IsXV3mXbv5ZMCi1Di+ZRHsUNDtg0+gQwsesjO4t9vCphLadcF4hjapVtKl3BuRMGwuJR6a0bsaMrqYzNmbjomXMOzOnuBoM8U5EN8e/V6nSOtHloMH5lFlRFb+8FE+czQfEaPZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740568279; c=relaxed/simple;
	bh=wWD2tZa/klVgH2MM/wWGbtZUpbPR49qn1Dj9rD0e90A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mX0axvOuRp16npmmQAjpENozuDAlM7peD7vkq4c2H9NV4N5deOkKntv8TQ/1+ZGWUyVer6qTzA5DURVstyPlLYavwjmHJL0MS2gmbO/FultRg9KLXxlu6s+kEM2jxeA8JEG8bMdS/SzYJyStWai14dz528rk9q2nJSvZPGlJS5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Z2s9y354mzJ1Fl;
	Wed, 26 Feb 2025 19:07:02 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id BEBBB18001B;
	Wed, 26 Feb 2025 19:11:06 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 26 Feb 2025 19:11:06 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <zhangkun09@huawei.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Robin Murphy <robin.murphy@arm.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, Andrew Morton
	<akpm@linux-foundation.org>, Gaurav Batra <gbatra@linux.ibm.com>, Matthew
 Rosato <mjrosato@linux.ibm.com>, IOMMU <iommu@lists.linux.dev>, MM
	<linux-mm@kvack.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH net-next v10 0/4] fix the DMA API misuse problem for page_pool
Date: Wed, 26 Feb 2025 19:03:35 +0800
Message-ID: <20250226110340.2671366-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

This patchset fix the dma API misuse problem as below:
Networking driver with page_pool support may hand over page
still with dma mapping to network stack and try to reuse that
page after network stack is done with it and passes it back
to page_pool to avoid the penalty of dma mapping/unmapping.
With all the caching in the network stack, some pages may be
held in the network stack without returning to the page_pool
soon enough, and with VF disable causing the driver unbound,
the page_pool does not stop the driver from doing it's
unbounding work, instead page_pool uses workqueue to check
if there is some pages coming back from the network stack
periodically, if there is any, it will do the dma unmmapping
related cleanup work.

As mentioned in [1], attempting DMA unmaps after the driver
has already unbound may leak resources or at worst corrupt
memory. Fundamentally, the page pool code cannot allow DMA
mappings to outlive the driver they belong to.

By using the 'struct page_pool_item' referenced by page->pp_item,
page_pool is not only able to keep track of the inflight page to
do dma unmmaping if some pages are still handled in networking
stack when page_pool_destroy() is called, and networking stack is
also able to find the page_pool owning the page when returning
pages back into page_pool:
1. When a page is added to the page_pool, an item is deleted from
   pool->hold_items and set the 'pp_netmem' pointing to that page
   and set item->state and item->pp_netmem accordingly in order to
   keep track of that page, refill from pool->release_items when
   pool->hold_items is empty or use the item from pool->slow_items
   when fast items run out.
2. When a page is released from the page_pool, it is able to tell
   which page_pool this page belongs to by masking off the lower
   bits of the pointer to page_pool_item *item, as the 'struct
   page_pool_item_block' is stored in the top of a struct page.
   And after clearing the pp_item->state', the item for the
   released page is added back to pool->release_items so that it
   can be reused for new pages or just free it when it is from the
   pool->slow_items.
3. When page_pool_destroy() is called, item->state is used to tell
   if a specific item is being used/dma mapped or not by scanning
   all the item blocks in pool->item_blocks, then item->netmem can
   be used to do the dma unmmaping if the corresponding inflight
   page is dma mapped.

From the below performance data, the overhead is not so obvious
due to performance variations in arm64 server and less than 1
ns in x86 server for time_bench_page_pool01_fast_path() and
time_bench_page_pool02_ptr_ring, and there is about 10~20ns
overhead for time_bench_page_pool03_slow(), see more detail in
[2].

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
CC: Gaurav Batra <gbatra@linux.ibm.com>
CC: Matthew Rosato <mjrosato@linux.ibm.com>
CC: IOMMU <iommu@lists.linux.dev>
CC: MM <linux-mm@kvack.org>

Change log:
V10:
  1. Add nl API to dump item memory usage.
  2. Use __acquires() and __releases() to avoid 'context imbalance'
     warning.

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

 Documentation/netlink/specs/netdev.yaml       |  16 +
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
 include/uapi/linux/netdev.h                   |   2 +
 net/core/devmem.c                             |   6 +-
 net/core/netmem_priv.h                        |   5 +-
 net/core/page_pool.c                          | 423 ++++++++++++++++--
 net/core/page_pool_priv.h                     |  12 +-
 net/core/page_pool_user.c                     |  39 +-
 tools/net/ynl/samples/page-pool.c             |  11 +
 23 files changed, 570 insertions(+), 87 deletions(-)

-- 
2.33.0


