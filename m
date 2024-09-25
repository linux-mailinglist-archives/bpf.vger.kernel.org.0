Return-Path: <bpf+bounces-40282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A329854FD
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 10:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B8F1F23E64
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 08:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0C715B113;
	Wed, 25 Sep 2024 08:03:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE95158862;
	Wed, 25 Sep 2024 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251420; cv=none; b=ZHSGcJJyaV7kD4V+rBGFx4jvjgs1Ak1fXy0wr9AgIBEoRwnodHH8QtNCORQSYPPkCJU8mOPiYejYScll3umJIXPnogqdR1ySn7Jb1b49JVYcgNRH0C8vdKW8Lzv/oXx9oMMxo7IsbNtRrkPyCIRa573RYm6nrJL3a8gY18ZQqrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251420; c=relaxed/simple;
	bh=E8s3WpnU/tv93HT4xlgs1BW20waozTbHHOTy/Q6WnRE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXDMZX648bHMHmXQDD8eHeshTY5DEByuAIRISU49nSejL65h5TLUo/xnizaMoG1en5voHxyXLPwsnELMRWJxY6vCgfO34oDs9StLKmOuo0yGCRzTlJyD3ETfKB+3whqd0VFtE1OgV5NOWAcd6WhQ0zX11hm++R+JEDFYx0bgUVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XD8NK39lYz2QTwG;
	Wed, 25 Sep 2024 16:02:41 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 710FD1A016C;
	Wed, 25 Sep 2024 16:03:28 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Sep 2024 16:03:28 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>,
	<zhangkun09@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Robin Murphy
	<robin.murphy@arm.com>, Alexander Duyck <alexander.duyck@gmail.com>, IOMMU
	<iommu@lists.linux.dev>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Eric Dumazet
	<edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen
	<shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Kalle Valo
	<kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Andrew
 Morton <akpm@linux-foundation.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, <imx@lists.linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <bpf@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-mm@kvack.org>
Subject: [PATCH net v2 2/2] page_pool: fix IOMMU crash when driver has already unbound
Date: Wed, 25 Sep 2024 15:57:07 +0800
Message-ID: <20240925075707.3970187-3-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240925075707.3970187-1-linyunsheng@huawei.com>
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

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

Currently it seems there are at least two cases that the page
is not released fast enough causing dma unmmapping done after
driver has already unbound:
1. ipv4 packet defragmentation timeout: this seems to cause
   delay up to 30 secs.
2. skb_defer_free_flush(): this may cause infinite delay if
   there is no triggering for net_rx_action().

In order not to do the dma unmmapping after driver has already
unbound and stall the unloading of the networking driver, add
the pool->items array to record all the pages including the ones
which are handed over to network stack, so the page_pool can
do the dma unmmapping for those pages when page_pool_destroy()
is called. As the pool->items need to be large enough to avoid
performance degradation, add a 'item_full' stat to indicate the
allocation failure due to unavailability of pool->items.

Note, the devmem patchset seems to make the bug harder to fix,
and may make backporting harder too. As there is no actual user
for the devmem and the fixing for devmem is unclear for now,
this patch does not consider fixing the case for devmem yet.

1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/

Fixes: f71fec47c2df ("page_pool: make sure struct device is stable")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
CC: Robin Murphy <robin.murphy@arm.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: IOMMU <iommu@lists.linux.dev>
---
 drivers/net/ethernet/freescale/fec_main.c     |   8 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |   6 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  14 +-
 drivers/net/ethernet/intel/libeth/rx.c        |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |   3 +-
 drivers/net/netdevsim/netdev.c                |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |   2 +-
 include/linux/mm_types.h                      |   2 +-
 include/linux/skbuff.h                        |   1 +
 include/net/libeth/rx.h                       |   3 +-
 include/net/netmem.h                          |  10 +-
 include/net/page_pool/helpers.h               |   7 +
 include/net/page_pool/types.h                 |  17 +-
 net/core/devmem.c                             |   4 +-
 net/core/netmem_priv.h                        |   5 +-
 net/core/page_pool.c                          | 163 +++++++++++++++---
 net/core/page_pool_priv.h                     |  10 +-
 net/core/skbuff.c                             |   3 +-
 net/core/xdp.c                                |   3 +-
 19 files changed, 212 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index acbb627d51bf..c00f8c460759 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1009,7 +1009,8 @@ static void fec_enet_bd_init(struct net_device *dev)
 				struct page *page = txq->tx_buf[i].buf_p;
 
 				if (page)
-					page_pool_put_page(page->pp, page, 0, false);
+					page_pool_put_page(page_pool_to_pp(page),
+							   page, 0, false);
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
@@ -1538,7 +1539,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			xdp_return_frame_rx_napi(xdpf);
 		} else { /* recycle pages of XDP_TX frames */
 			/* The dma_sync_size = 0 as XDP_TX has already synced DMA for_device */
-			page_pool_put_page(page->pp, page, 0, true);
+			page_pool_put_page(page_pool_to_pp(page), page, 0, true);
 		}
 
 		txq->tx_buf[index].buf_p = NULL;
@@ -3300,7 +3301,8 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 			} else {
 				struct page *page = txq->tx_buf[i].buf_p;
 
-				page_pool_put_page(page->pp, page, 0, false);
+				page_pool_put_page(page_pool_to_pp(page),
+						   page, 0, false);
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 26b424fd6718..658d8f9a6abb 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1050,7 +1050,8 @@ static void iavf_add_rx_frag(struct sk_buff *skb,
 			     const struct libeth_fqe *rx_buffer,
 			     unsigned int size)
 {
-	u32 hr = rx_buffer->page->pp->p.offset;
+	struct page_pool *pool = page_pool_to_pp(rx_buffer->page);
+	u32 hr = pool->p.offset;
 
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
 			rx_buffer->offset + hr, size, rx_buffer->truesize);
@@ -1067,7 +1068,8 @@ static void iavf_add_rx_frag(struct sk_buff *skb,
 static struct sk_buff *iavf_build_skb(const struct libeth_fqe *rx_buffer,
 				      unsigned int size)
 {
-	u32 hr = rx_buffer->page->pp->p.offset;
+	struct page_pool *pool = page_pool_to_pp(rx_buffer->page);
+	u32 hr = pool->p.offset;
 	struct sk_buff *skb;
 	void *va;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index d4e6f0e10487..e3389f1a215f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -385,7 +385,8 @@ static void idpf_rx_page_rel(struct libeth_fqe *rx_buf)
 	if (unlikely(!rx_buf->page))
 		return;
 
-	page_pool_put_full_page(rx_buf->page->pp, rx_buf->page, false);
+	page_pool_put_full_page(page_pool_to_pp(rx_buf->page), rx_buf->page,
+				false);
 
 	rx_buf->page = NULL;
 	rx_buf->offset = 0;
@@ -3097,7 +3098,8 @@ idpf_rx_process_skb_fields(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 void idpf_rx_add_frag(struct idpf_rx_buf *rx_buf, struct sk_buff *skb,
 		      unsigned int size)
 {
-	u32 hr = rx_buf->page->pp->p.offset;
+	struct page_pool *pool = page_pool_to_pp(rx_buf->page);
+	u32 hr = pool->p.offset;
 
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buf->page,
 			rx_buf->offset + hr, size, rx_buf->truesize);
@@ -3129,8 +3131,10 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
 	if (!libeth_rx_sync_for_cpu(buf, copy))
 		return 0;
 
-	dst = page_address(hdr->page) + hdr->offset + hdr->page->pp->p.offset;
-	src = page_address(buf->page) + buf->offset + buf->page->pp->p.offset;
+	dst = page_address(hdr->page) + hdr->offset +
+		page_pool_to_pp(hdr->page)->p.offset;
+	src = page_address(buf->page) + buf->offset +
+		page_pool_to_pp(buf->page)->p.offset;
 	memcpy(dst, src, LARGEST_ALIGN(copy));
 
 	buf->offset += copy;
@@ -3148,7 +3152,7 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
  */
 struct sk_buff *idpf_rx_build_skb(const struct libeth_fqe *buf, u32 size)
 {
-	u32 hr = buf->page->pp->p.offset;
+	u32 hr = page_pool_to_pp(buf->page)->p.offset;
 	struct sk_buff *skb;
 	void *va;
 
diff --git a/drivers/net/ethernet/intel/libeth/rx.c b/drivers/net/ethernet/intel/libeth/rx.c
index f20926669318..385afca0e61d 100644
--- a/drivers/net/ethernet/intel/libeth/rx.c
+++ b/drivers/net/ethernet/intel/libeth/rx.c
@@ -207,7 +207,7 @@ EXPORT_SYMBOL_NS_GPL(libeth_rx_fq_destroy, LIBETH);
  */
 void libeth_rx_recycle_slow(struct page *page)
 {
-	page_pool_recycle_direct(page->pp, page);
+	page_pool_recycle_direct(page_pool_to_pp(page), page);
 }
 EXPORT_SYMBOL_NS_GPL(libeth_rx_recycle_slow, LIBETH);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 4610621a340e..83511a45a6dc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -716,7 +716,8 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 				/* No need to check ((page->pp_magic & ~0x3UL) == PP_SIGNATURE)
 				 * as we know this is a page_pool page.
 				 */
-				page_pool_recycle_direct(page->pp, page);
+				page_pool_recycle_direct(page_pool_to_pp(page),
+							 page);
 			} while (++n < num);
 
 			break;
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 017a6102be0a..9bfa593cd5dd 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -593,7 +593,8 @@ nsim_pp_hold_write(struct file *file, const char __user *data,
 		if (!ns->page)
 			ret = -ENOMEM;
 	} else {
-		page_pool_put_full_page(ns->page->pp, ns->page, false);
+		page_pool_put_full_page(page_pool_to_pp(ns->page), ns->page,
+					false);
 		ns->page = NULL;
 	}
 	rtnl_unlock();
@@ -788,7 +789,8 @@ void nsim_destroy(struct netdevsim *ns)
 
 	/* Put this intentionally late to exercise the orphaning path */
 	if (ns->page) {
-		page_pool_put_full_page(ns->page->pp, ns->page, false);
+		page_pool_put_full_page(page_pool_to_pp(ns->page), ns->page,
+					false);
 		ns->page = NULL;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 0b75a45ad2e8..94a277290909 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1688,7 +1688,7 @@ static inline void mt76_put_page_pool_buf(void *buf, bool allow_direct)
 {
 	struct page *page = virt_to_head_page(buf);
 
-	page_pool_put_full_page(page->pp, page, allow_direct);
+	page_pool_put_full_page(page_pool_to_pp(page), page, allow_direct);
 }
 
 static inline void *
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 485424979254..410187133d27 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -120,7 +120,7 @@ struct page {
 			 * page_pool allocated pages.
 			 */
 			unsigned long pp_magic;
-			struct page_pool *pp;
+			struct page_pool_item *pp_item;
 			unsigned long _pp_mapping_pad;
 			unsigned long dma_addr;
 			atomic_long_t pp_ref_count;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 39f1d16f3628..64d1ecb7a7fc 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -38,6 +38,7 @@
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
 #include <net/netmem.h>
+#include <net/page_pool/types.h>
 
 /**
  * DOC: skb checksums
diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index 43574bd6612f..beee7ddd77a5 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -137,7 +137,8 @@ static inline bool libeth_rx_sync_for_cpu(const struct libeth_fqe *fqe,
 		return false;
 	}
 
-	page_pool_dma_sync_for_cpu(page->pp, page, fqe->offset, len);
+	page_pool_dma_sync_for_cpu(page_pool_to_pp(page), page, fqe->offset,
+				   len);
 
 	return true;
 }
diff --git a/include/net/netmem.h b/include/net/netmem.h
index 8a6e20be4b9d..5e7b4d1c1c44 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -23,7 +23,7 @@ DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
 struct net_iov {
 	unsigned long __unused_padding;
 	unsigned long pp_magic;
-	struct page_pool *pp;
+	struct page_pool_item *pp_item;
 	struct dmabuf_genpool_chunk_owner *owner;
 	unsigned long dma_addr;
 	atomic_long_t pp_ref_count;
@@ -33,7 +33,7 @@ struct net_iov {
  *
  *        struct {
  *                unsigned long pp_magic;
- *                struct page_pool *pp;
+ *                struct page_pool_item *pp_item;
  *                unsigned long _pp_mapping_pad;
  *                unsigned long dma_addr;
  *                atomic_long_t pp_ref_count;
@@ -49,7 +49,7 @@ struct net_iov {
 	static_assert(offsetof(struct page, pg) == \
 		      offsetof(struct net_iov, iov))
 NET_IOV_ASSERT_OFFSET(pp_magic, pp_magic);
-NET_IOV_ASSERT_OFFSET(pp, pp);
+NET_IOV_ASSERT_OFFSET(pp_item, pp_item);
 NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
 NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
 #undef NET_IOV_ASSERT_OFFSET
@@ -127,9 +127,9 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
 	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
 }
 
-static inline struct page_pool *netmem_get_pp(netmem_ref netmem)
+static inline struct page_pool_item *netmem_get_pp_item(netmem_ref netmem)
 {
-	return __netmem_clear_lsb(netmem)->pp;
+	return __netmem_clear_lsb(netmem)->pp_item;
 }
 
 static inline atomic_long_t *netmem_get_pp_ref_count_ref(netmem_ref netmem)
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 793e6fd78bc5..f781c81f8aa9 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -83,6 +83,13 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
 }
 #endif
 
+static inline struct page_pool *page_pool_to_pp(struct page *page)
+{
+	struct page_pool_item *item = page->pp_item;
+
+	return container_of(item, struct page_pool, items[item->pp_idx]);
+}
+
 /**
  * page_pool_dev_alloc_pages() - allocate a page.
  * @pool:	pool from which to allocate
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index c022c410abe3..194006d2930f 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -102,6 +102,7 @@ struct page_pool_params {
  * @refill:	an allocation which triggered a refill of the cache
  * @waive:	pages obtained from the ptr ring that cannot be added to
  *		the cache due to a NUMA mismatch
+ * @item_full	items array is full
  */
 struct page_pool_alloc_stats {
 	u64 fast;
@@ -110,6 +111,7 @@ struct page_pool_alloc_stats {
 	u64 empty;
 	u64 refill;
 	u64 waive;
+	u64 item_full;
 };
 
 /**
@@ -142,6 +144,11 @@ struct page_pool_stats {
 };
 #endif
 
+struct page_pool_item {
+	netmem_ref pp_netmem;
+	unsigned int pp_idx;
+};
+
 /* The whole frag API block must stay within one cacheline. On 32-bit systems,
  * sizeof(long) == sizeof(int), so that the block size is ``3 * sizeof(long)``.
  * On 64-bit systems, the actual size is ``2 * sizeof(long) + sizeof(int)``.
@@ -161,6 +168,8 @@ struct page_pool {
 
 	int cpuid;
 	u32 pages_state_hold_cnt;
+	unsigned int item_mask;
+	unsigned int item_idx;
 
 	bool has_init_callback:1;	/* slow::init_callback is set */
 	bool dma_map:1;			/* Perform DMA mapping */
@@ -228,7 +237,11 @@ struct page_pool {
 	 */
 	refcount_t user_cnt;
 
-	u64 destroy_cnt;
+	/* Lock to avoid doing dma unmapping concurrently when
+	 * destroy_cnt > 0.
+	 */
+	spinlock_t destroy_lock;
+	unsigned int destroy_cnt;
 
 	/* Slow/Control-path information follows */
 	struct page_pool_params_slow slow;
@@ -239,6 +252,8 @@ struct page_pool {
 		u32 napi_id;
 		u32 id;
 	} user;
+
+	struct page_pool_item items[] ____cacheline_aligned_in_smp;
 };
 
 struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 11b91c12ee11..09c5aa83f12a 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -85,7 +85,7 @@ net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
 	niov = &owner->niovs[index];
 
 	niov->pp_magic = 0;
-	niov->pp = NULL;
+	niov->pp_item = NULL;
 	atomic_long_set(&niov->pp_ref_count, 0);
 
 	return niov;
@@ -380,7 +380,7 @@ bool mp_dmabuf_devmem_release_page(struct page_pool *pool, netmem_ref netmem)
 	if (WARN_ON_ONCE(refcount != 1))
 		return false;
 
-	page_pool_clear_pp_info(netmem);
+	page_pool_clear_pp_info(pool, netmem);
 
 	net_devmem_free_dmabuf(netmem_to_net_iov(netmem));
 
diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
index 7eadb8393e00..3173f6070cf7 100644
--- a/net/core/netmem_priv.h
+++ b/net/core/netmem_priv.h
@@ -18,9 +18,10 @@ static inline void netmem_clear_pp_magic(netmem_ref netmem)
 	__netmem_clear_lsb(netmem)->pp_magic = 0;
 }
 
-static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
+static inline void netmem_set_pp_item(netmem_ref netmem,
+				      struct page_pool_item *item)
 {
-	__netmem_clear_lsb(netmem)->pp = pool;
+	__netmem_clear_lsb(netmem)->pp_item = item;
 }
 
 static inline void netmem_set_dma_addr(netmem_ref netmem,
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index bec6e717cd22..3e041b80f62d 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -61,6 +61,7 @@ static const char pp_stats[][ETH_GSTRING_LEN] = {
 	"rx_pp_alloc_empty",
 	"rx_pp_alloc_refill",
 	"rx_pp_alloc_waive",
+	"rx_pp_alloc_item_full",
 	"rx_pp_recycle_cached",
 	"rx_pp_recycle_cache_full",
 	"rx_pp_recycle_ring",
@@ -94,6 +95,7 @@ bool page_pool_get_stats(const struct page_pool *pool,
 	stats->alloc_stats.empty += pool->alloc_stats.empty;
 	stats->alloc_stats.refill += pool->alloc_stats.refill;
 	stats->alloc_stats.waive += pool->alloc_stats.waive;
+	stats->alloc_stats.item_full += pool->alloc_stats.item_full;
 
 	for_each_possible_cpu(cpu) {
 		const struct page_pool_recycle_stats *pcpu =
@@ -139,6 +141,7 @@ u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
 	*data++ = pool_stats->alloc_stats.empty;
 	*data++ = pool_stats->alloc_stats.refill;
 	*data++ = pool_stats->alloc_stats.waive;
+	*data++ = pool_stats->alloc_stats.item_full;
 	*data++ = pool_stats->recycle_stats.cached;
 	*data++ = pool_stats->recycle_stats.cache_full;
 	*data++ = pool_stats->recycle_stats.ring;
@@ -267,14 +270,12 @@ static int page_pool_init(struct page_pool *pool,
 		return -ENOMEM;
 	}
 
+	spin_lock_init(&pool->destroy_lock);
 	atomic_set(&pool->pages_state_release_cnt, 0);
 
 	/* Driver calling page_pool_create() also call page_pool_destroy() */
 	refcount_set(&pool->user_cnt, 1);
 
-	if (pool->dma_map)
-		get_device(pool->p.dev);
-
 	if (pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
 		/* We rely on rtnl_lock()ing to make sure netdev_rx_queue
 		 * configuration doesn't change while we're initializing
@@ -312,15 +313,91 @@ static void page_pool_uninit(struct page_pool *pool)
 {
 	ptr_ring_cleanup(&pool->ring, NULL);
 
-	if (pool->dma_map)
-		put_device(pool->p.dev);
-
 #ifdef CONFIG_PAGE_POOL_STATS
 	if (!pool->system)
 		free_percpu(pool->recycle_stats);
 #endif
 }
 
+static void page_pool_item_init(struct page_pool *pool, unsigned int item_cnt)
+{
+	struct page_pool_item *items = pool->items;
+	unsigned int i;
+
+	WARN_ON_ONCE(!is_power_of_2(item_cnt));
+
+	for (i = 0; i < item_cnt; i++)
+		items[i].pp_idx = i;
+
+	pool->item_mask = item_cnt - 1;
+}
+
+static void page_pool_item_uninit(struct page_pool *pool)
+{
+	struct page_pool_item *items = pool->items;
+	unsigned int mask = pool->item_mask;
+	unsigned int i;
+
+	if (!pool->dma_map || pool->mp_priv)
+		return;
+
+	spin_lock_bh(&pool->destroy_lock);
+
+	for (i = 0; i <= mask; i++) {
+		struct page *page;
+
+		page = netmem_to_page(READ_ONCE(items[i].pp_netmem));
+		if (!page)
+			continue;
+
+		WARN_ONCE(1, "page_pool(%u) has inflight page: %p\n",
+			  pool->user.id, page);
+
+		dma_unmap_page_attrs(pool->p.dev, page_pool_get_dma_addr(page),
+				     PAGE_SIZE << pool->p.order,
+				     pool->p.dma_dir, DMA_ATTR_SKIP_CPU_SYNC |
+				     DMA_ATTR_WEAK_ORDERING);
+		page_pool_set_dma_addr(page, 0);
+	}
+
+	pool->dma_map = false;
+	spin_unlock_bh(&pool->destroy_lock);
+}
+
+static bool page_pool_item_add(struct page_pool *pool, netmem_ref netmem)
+{
+	struct page_pool_item *items = pool->items;
+	unsigned int mask = pool->item_mask;
+	unsigned int idx = pool->item_idx;
+	unsigned int i;
+
+	for (i = 0; i <= mask; i++) {
+		unsigned int mask_idx = idx++ & mask;
+
+		if (!READ_ONCE(items[mask_idx].pp_netmem)) {
+			WRITE_ONCE(items[mask_idx].pp_netmem, netmem);
+			netmem_set_pp_item(netmem, &items[mask_idx]);
+			pool->item_idx = idx;
+			return true;
+		}
+	}
+
+	pool->item_idx = idx;
+	alloc_stat_inc(pool, item_full);
+	return false;
+}
+
+static void page_pool_item_del(struct page_pool *pool, netmem_ref netmem)
+{
+	struct page_pool_item *item = netmem_to_page(netmem)->pp_item;
+	struct page_pool_item *items = pool->items;
+	unsigned int idx = item->pp_idx;
+
+	DEBUG_NET_WARN_ON_ONCE(items[idx].pp_netmem != netmem);
+	WRITE_ONCE(items[idx].pp_netmem, (netmem_ref)NULL);
+	netmem_set_pp_item(netmem, NULL);
+}
+
 /**
  * page_pool_create_percpu() - create a page pool for a given cpu.
  * @params: parameters, see struct page_pool_params
@@ -329,10 +406,15 @@ static void page_pool_uninit(struct page_pool *pool)
 struct page_pool *
 page_pool_create_percpu(const struct page_pool_params *params, int cpuid)
 {
+#define PAGE_POOL_MIN_INFLIGHT_ITEMS		512
+	unsigned int item_cnt = (params->pool_size ? : 1024) +
+				PP_ALLOC_CACHE_SIZE + PAGE_POOL_MIN_INFLIGHT_ITEMS;
 	struct page_pool *pool;
 	int err;
 
-	pool = kzalloc_node(sizeof(*pool), GFP_KERNEL, params->nid);
+	item_cnt = roundup_pow_of_two(item_cnt);
+	pool = kvzalloc_node(struct_size(pool, items, item_cnt), GFP_KERNEL,
+			     params->nid);
 	if (!pool)
 		return ERR_PTR(-ENOMEM);
 
@@ -340,6 +422,8 @@ page_pool_create_percpu(const struct page_pool_params *params, int cpuid)
 	if (err < 0)
 		goto err_free;
 
+	page_pool_item_init(pool, item_cnt);
+
 	err = page_pool_list(pool);
 	if (err)
 		goto err_uninit;
@@ -350,7 +434,7 @@ page_pool_create_percpu(const struct page_pool_params *params, int cpuid)
 	page_pool_uninit(pool);
 err_free:
 	pr_warn("%s() gave up with errno %d\n", __func__, err);
-	kfree(pool);
+	kvfree(pool);
 	return ERR_PTR(err);
 }
 EXPORT_SYMBOL(page_pool_create_percpu);
@@ -499,19 +583,24 @@ static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
 	if (unlikely(!page))
 		return NULL;
 
-	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page_to_netmem(page)))) {
-		put_page(page);
-		return NULL;
-	}
+	if (unlikely(!page_pool_set_pp_info(pool, page_to_netmem(page))))
+		goto err_alloc;
+
+	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page_to_netmem(page))))
+		goto err_set_info;
 
 	alloc_stat_inc(pool, slow_high_order);
-	page_pool_set_pp_info(pool, page_to_netmem(page));
 
 	/* Track how many pages are held 'in-flight' */
 	pool->pages_state_hold_cnt++;
 	trace_page_pool_state_hold(pool, page_to_netmem(page),
 				   pool->pages_state_hold_cnt);
 	return page;
+err_set_info:
+	page_pool_clear_pp_info(pool, page_to_netmem(page));
+err_alloc:
+	put_page(page);
+	return NULL;
 }
 
 /* slow path */
@@ -546,12 +635,18 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 	 */
 	for (i = 0; i < nr_pages; i++) {
 		netmem = pool->alloc.cache[i];
+
+		if (unlikely(!page_pool_set_pp_info(pool, netmem))) {
+			put_page(netmem_to_page(netmem));
+			continue;
+		}
+
 		if (dma_map && unlikely(!page_pool_dma_map(pool, netmem))) {
+			page_pool_clear_pp_info(pool, netmem);
 			put_page(netmem_to_page(netmem));
 			continue;
 		}
 
-		page_pool_set_pp_info(pool, netmem);
 		pool->alloc.cache[pool->alloc.count++] = netmem;
 		/* Track how many pages are held 'in-flight' */
 		pool->pages_state_hold_cnt++;
@@ -623,9 +718,13 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
 	return inflight;
 }
 
-void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
+bool page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 {
-	netmem_set_pp(netmem, pool);
+	if (unlikely(!page_pool_item_add(pool, netmem)))
+		return false;
+
+	DEBUG_NET_WARN_ON_ONCE(page_pool_to_pp(netmem_to_page(netmem)) != pool);
+
 	netmem_or_pp_magic(netmem, PP_SIGNATURE);
 
 	/* Ensuring all pages have been split into one fragment initially:
@@ -637,12 +736,14 @@ void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 	page_pool_fragment_netmem(netmem, 1);
 	if (pool->has_init_callback)
 		pool->slow.init_callback(netmem, pool->slow.init_arg);
+
+	return true;
 }
 
-void page_pool_clear_pp_info(netmem_ref netmem)
+void page_pool_clear_pp_info(struct page_pool *pool, netmem_ref netmem)
 {
 	netmem_clear_pp_magic(netmem);
-	netmem_set_pp(netmem, NULL);
+	page_pool_item_del(pool, netmem);
 }
 
 static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
@@ -672,9 +773,13 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
  */
 void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
 {
+	unsigned int destroy_cnt = READ_ONCE(pool->destroy_cnt);
 	int count;
 	bool put;
 
+	if (unlikely(destroy_cnt))
+		spin_lock_bh(&pool->destroy_lock);
+
 	put = true;
 	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_priv)
 		put = mp_dmabuf_devmem_release_page(pool, netmem);
@@ -688,9 +793,13 @@ void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
 	trace_page_pool_state_release(pool, netmem, count);
 
 	if (put) {
-		page_pool_clear_pp_info(netmem);
+		page_pool_clear_pp_info(pool, netmem);
 		put_page(netmem_to_page(netmem));
 	}
+
+	if (unlikely(destroy_cnt))
+		spin_unlock_bh(&pool->destroy_lock);
+
 	/* An optimization would be to call __free_pages(page, pool->p.order)
 	 * knowing page is not part of page-cache (thus avoiding a
 	 * __page_cache_release() call).
@@ -1034,14 +1143,14 @@ static void __page_pool_destroy(struct page_pool *pool)
 		static_branch_dec(&page_pool_mem_providers);
 	}
 
-	kfree(pool);
+	kvfree(pool);
 }
 
 static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
 {
 	netmem_ref netmem;
 
-	if (pool->destroy_cnt)
+	if (pool->destroy_cnt > 1)
 		return;
 
 	/* Empty alloc cache, assume caller made sure this is
@@ -1057,7 +1166,7 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
 static void page_pool_scrub(struct page_pool *pool)
 {
 	page_pool_empty_alloc_cache_once(pool);
-	pool->destroy_cnt++;
+	WRITE_ONCE(pool->destroy_cnt, pool->destroy_cnt + 1);
 
 	/* No more consumers should exist, but producers could still
 	 * be in-flight.
@@ -1139,10 +1248,14 @@ void page_pool_destroy(struct page_pool *pool)
 	if (!page_pool_put(pool))
 		return;
 
+	/* disable dma_sync_for_device */
+	pool->dma_sync = false;
+
 	page_pool_disable_direct_recycling(pool);
+	WRITE_ONCE(pool->destroy_cnt, 1);
 
-	/* Wait for the freeing side see the disabling direct recycling setting
-	 * to avoid the concurrent access to the pool->alloc cache.
+	/* Wait for the freeing side to see the new pool->dma_sync,
+	 * disable_direct and pool->destroy_cnt in page_pool_put_page.
 	 */
 	synchronize_rcu();
 
@@ -1151,6 +1264,8 @@ void page_pool_destroy(struct page_pool *pool)
 	if (!page_pool_release(pool))
 		return;
 
+	page_pool_item_uninit(pool);
+
 	page_pool_detached(pool);
 	pool->defer_start = jiffies;
 	pool->defer_warn  = jiffies + DEFER_WARN_INTERVAL;
diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
index 57439787b9c2..5d85f862a30a 100644
--- a/net/core/page_pool_priv.h
+++ b/net/core/page_pool_priv.h
@@ -36,16 +36,18 @@ static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
 }
 
 #if defined(CONFIG_PAGE_POOL)
-void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem);
-void page_pool_clear_pp_info(netmem_ref netmem);
+bool page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem);
+void page_pool_clear_pp_info(struct page_pool *pool, netmem_ref netmem);
 int page_pool_check_memory_provider(struct net_device *dev,
 				    struct netdev_rx_queue *rxq);
 #else
-static inline void page_pool_set_pp_info(struct page_pool *pool,
+static inline bool page_pool_set_pp_info(struct page_pool *pool,
 					 netmem_ref netmem)
 {
+	return true;
 }
-static inline void page_pool_clear_pp_info(netmem_ref netmem)
+static inline void page_pool_clear_pp_info(struct page_pool *pool,
+					   netmem_ref netmem)
 {
 }
 static inline int page_pool_check_memory_provider(struct net_device *dev,
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 74149dc4ee31..d4295353ca6e 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1033,7 +1033,8 @@ bool napi_pp_put_page(netmem_ref netmem)
 	if (unlikely(!is_pp_netmem(netmem)))
 		return false;
 
-	page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, false);
+	page_pool_put_full_netmem(page_pool_to_pp(netmem_to_page(netmem)),
+				  netmem, false);
 
 	return true;
 }
diff --git a/net/core/xdp.c b/net/core/xdp.c
index bcc5551c6424..e8582036b411 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -384,7 +384,8 @@ void __xdp_return(void *data, struct xdp_mem_info *mem, bool napi_direct,
 		/* No need to check ((page->pp_magic & ~0x3UL) == PP_SIGNATURE)
 		 * as mem->type knows this a page_pool page
 		 */
-		page_pool_put_full_page(page->pp, page, napi_direct);
+		page_pool_put_full_page(page_pool_to_pp(page), page,
+					napi_direct);
 		break;
 	case MEM_TYPE_PAGE_SHARED:
 		page_frag_free(data);
-- 
2.33.0


