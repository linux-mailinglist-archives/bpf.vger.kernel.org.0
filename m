Return-Path: <bpf+bounces-46835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 279339F0C59
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 13:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BEF51883BE7
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 12:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77E51DFE34;
	Fri, 13 Dec 2024 12:34:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D471C4A36;
	Fri, 13 Dec 2024 12:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093276; cv=none; b=hXEBsqfcTRfL7K6zQ4tUWdSye6x5DLuBfZ31ycFqiq89xOjdfUNGbsZE5eVm/zK6Ot31YSmaKe0Um+YLRjSQbFtOuHJ1noA+4JYECBHJDwhRdgL/f/1vCgon2Msgu58Okfsb6Nfbcp0+nsgFV2pzLVM+IpRQEb/zwgJSAM+jt8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093276; c=relaxed/simple;
	bh=TvJU08hFdOE2ZEtmXsyNzjuehz2M5G7lPkNFHFYSb3I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7HTDO9SHJl7X0I+M0d4qREEzV4upnLjRG/izdER/7pcaEg4R6/mjlFRIngLFwdC+AudMZz8ERDIWk/cmL4oDKT02076tUUBQNRx0KLGtuHzyYr6KjDlaWlAUcPE/A9Hf/Mti17oW3XIVQRw6v7ZzeclZP4DnvWVpDE5HmBy3j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y8pg81S0Sz1JFFR;
	Fri, 13 Dec 2024 20:34:12 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 90437180042;
	Fri, 13 Dec 2024 20:34:29 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Dec 2024 20:34:29 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <somnath.kotur@broadcom.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, <zhangkun09@huawei.com>, Yunsheng Lin
	<linyunsheng@huawei.com>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Jeroen de Borst
	<jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen
	<shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Kalle Valo
	<kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Simon
 Horman <horms@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	<imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<bpf@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-wireless@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH RFCv5 1/8] page_pool: introduce page_pool_to_pp() API
Date: Fri, 13 Dec 2024 20:27:32 +0800
Message-ID: <20241213122739.4050137-2-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241213122739.4050137-1-linyunsheng@huawei.com>
References: <20241213122739.4050137-1-linyunsheng@huawei.com>
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

introduce page_pool_to_pp() API to avoid caller accessing
page->pp directly.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 drivers/net/ethernet/freescale/fec_main.c          |  8 +++++---
 .../net/ethernet/google/gve/gve_buffer_mgmt_dqo.c  |  2 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c        |  6 ++++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        | 14 +++++++++-----
 drivers/net/ethernet/intel/libeth/rx.c             |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |  3 ++-
 drivers/net/netdevsim/netdev.c                     |  6 ++++--
 drivers/net/wireless/mediatek/mt76/mt76.h          |  2 +-
 include/net/libeth/rx.h                            |  3 ++-
 include/net/page_pool/helpers.h                    |  5 +++++
 net/core/skbuff.c                                  |  3 ++-
 net/core/xdp.c                                     |  3 ++-
 12 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 1b55047c0237..98fce41d088c 100644
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
@@ -1549,7 +1550,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			xdp_return_frame_rx_napi(xdpf);
 		} else { /* recycle pages of XDP_TX frames */
 			/* The dma_sync_size = 0 as XDP_TX has already synced DMA for_device */
-			page_pool_put_page(page->pp, page, 0, true);
+			page_pool_put_page(page_pool_to_pp(page), page, 0, true);
 		}
 
 		txq->tx_buf[index].buf_p = NULL;
@@ -3311,7 +3312,8 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 			} else {
 				struct page *page = txq->tx_buf[i].buf_p;
 
-				page_pool_put_page(page->pp, page, 0, false);
+				page_pool_put_page(page_pool_to_pp(page),
+						   page, 0, false);
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
index 403f0f335ba6..db5926152c72 100644
--- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
@@ -210,7 +210,7 @@ void gve_free_to_page_pool(struct gve_rx_ring *rx,
 	if (!page)
 		return;
 
-	page_pool_put_full_page(page->pp, page, allow_direct);
+	page_pool_put_full_page(page_pool_to_pp(page), page, allow_direct);
 	buf_state->page_info.page = NULL;
 }
 
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
index da2a5becf62f..38ad32678bcc 100644
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
index 94b291662087..78866b5473da 100644
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
index 0be47fed4efc..088f4836a0e2 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -632,7 +632,8 @@ nsim_pp_hold_write(struct file *file, const char __user *data,
 		if (!ns->page)
 			ret = -ENOMEM;
 	} else {
-		page_pool_put_full_page(ns->page->pp, ns->page, false);
+		page_pool_put_full_page(page_pool_to_pp(ns->page), ns->page,
+					false);
 		ns->page = NULL;
 	}
 	rtnl_unlock();
@@ -831,7 +832,8 @@ void nsim_destroy(struct netdevsim *ns)
 
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
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 793e6fd78bc5..1659f1995985 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -83,6 +83,11 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
 }
 #endif
 
+static inline struct page_pool *page_pool_to_pp(struct page *page)
+{
+	return page->pp;
+}
+
 /**
  * page_pool_dev_alloc_pages() - allocate a page.
  * @pool:	pool from which to allocate
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6841e61a6bd0..54e8e7cf2bc9 100644
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


