Return-Path: <bpf+bounces-52632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D33A45CC7
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 12:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CFF57A7ACB
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 11:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F1C2147EA;
	Wed, 26 Feb 2025 11:11:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4383212FB0;
	Wed, 26 Feb 2025 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740568276; cv=none; b=Yin2tmv1mqFle7788E2WAARQ6B4WTFicsJIeAx0SDdKXDnNfVqDstZnJhN7Ty0okPHV2GuV/mKK6j32lYGxkPNh+9WRjEhiYUO/Ag/FOs3Ku+TYZe6R/TB8t/g1F1Xr4KyHN2wrA/tDtJl5xiTt+KmTVFO8lWhDVU/cj+z5tDm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740568276; c=relaxed/simple;
	bh=vCCXp7drT+iyILPAgywvLO6Qqn6oPSfLHRdtK9H1v5Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qIOiYUK04PoqsYCXj8zAv91m7reaxjBiAsY8FC1cTGF1GjqamVoTzsUDEqmOV6Vl1YAhYn4esBxJtX0RKM/KEAwVnfrMExRdrel66g4dR9+Foxw7pezRo/OS5ladyo0sX3HzDF92EThbGjO3eDpyJCRahinGzzYanRJIS/DOys4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z2sB217hyz1ltb1;
	Wed, 26 Feb 2025 19:07:06 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id B3B3118001B;
	Wed, 26 Feb 2025 19:11:09 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 26 Feb 2025 19:11:09 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <zhangkun09@huawei.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Wei Fang
	<wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet
	<edumazet@google.com>, Jeroen de Borst <jeroendb@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen
	<shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Johannes Berg
	<johannes@sipsolutions.net>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Simon
 Horman <horms@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	<imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<bpf@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-wireless@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH net-next v10 1/4] page_pool: introduce page_pool_get_pp() API
Date: Wed, 26 Feb 2025 19:03:36 +0800
Message-ID: <20250226110340.2671366-2-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250226110340.2671366-1-linyunsheng@huawei.com>
References: <20250226110340.2671366-1-linyunsheng@huawei.com>
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

Introduce page_pool_get_pp() API to avoid caller accessing
page->pp directly, in order to make the following patch more
reviewable as the following patch will change page->pp to
page->pp_item to fix the DMA API misuse problem.

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
 10 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index a86cfebedaa8..4ade1553557a 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1038,7 +1038,8 @@ static void fec_enet_bd_init(struct net_device *dev)
 				struct page *page = txq->tx_buf[i].buf_p;
 
 				if (page)
-					page_pool_put_page(page->pp, page, 0, false);
+					page_pool_put_page(page_pool_get_pp(page),
+							   page, 0, false);
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
@@ -1576,7 +1577,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			xdp_return_frame_rx_napi(xdpf);
 		} else { /* recycle pages of XDP_TX frames */
 			/* The dma_sync_size = 0 as XDP_TX has already synced DMA for_device */
-			page_pool_put_page(page->pp, page, 0, true);
+			page_pool_put_page(page_pool_get_pp(page), page, 0, true);
 		}
 
 		txq->tx_buf[index].buf_p = NULL;
@@ -3343,7 +3344,8 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 			} else {
 				struct page *page = txq->tx_buf[i].buf_p;
 
-				page_pool_put_page(page->pp, page, 0, false);
+				page_pool_put_page(page_pool_get_pp(page),
+						   page, 0, false);
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
index 403f0f335ba6..87422b8828ff 100644
--- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
@@ -210,7 +210,7 @@ void gve_free_to_page_pool(struct gve_rx_ring *rx,
 	if (!page)
 		return;
 
-	page_pool_put_full_page(page->pp, page, allow_direct);
+	page_pool_put_full_page(page_pool_get_pp(page), page, allow_direct);
 	buf_state->page_info.page = NULL;
 }
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 422312b8b54a..72f17eaac277 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1197,7 +1197,8 @@ static void iavf_add_rx_frag(struct sk_buff *skb,
 			     const struct libeth_fqe *rx_buffer,
 			     unsigned int size)
 {
-	u32 hr = rx_buffer->page->pp->p.offset;
+	struct page_pool *pool = page_pool_get_pp(rx_buffer->page);
+	u32 hr = pool->p.offset;
 
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
 			rx_buffer->offset + hr, size, rx_buffer->truesize);
@@ -1214,7 +1215,8 @@ static void iavf_add_rx_frag(struct sk_buff *skb,
 static struct sk_buff *iavf_build_skb(const struct libeth_fqe *rx_buffer,
 				      unsigned int size)
 {
-	u32 hr = rx_buffer->page->pp->p.offset;
+	struct page_pool *pool = page_pool_get_pp(rx_buffer->page);
+	u32 hr = pool->p.offset;
 	struct sk_buff *skb;
 	void *va;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 2747dc69999a..248495f587d0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -385,7 +385,8 @@ static void idpf_rx_page_rel(struct libeth_fqe *rx_buf)
 	if (unlikely(!rx_buf->page))
 		return;
 
-	page_pool_put_full_page(rx_buf->page->pp, rx_buf->page, false);
+	page_pool_put_full_page(page_pool_get_pp(rx_buf->page), rx_buf->page,
+				false);
 
 	rx_buf->page = NULL;
 	rx_buf->offset = 0;
@@ -3095,7 +3096,8 @@ idpf_rx_process_skb_fields(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 void idpf_rx_add_frag(struct idpf_rx_buf *rx_buf, struct sk_buff *skb,
 		      unsigned int size)
 {
-	u32 hr = rx_buf->page->pp->p.offset;
+	struct page_pool *pool = page_pool_get_pp(rx_buf->page);
+	u32 hr = pool->p.offset;
 
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buf->page,
 			rx_buf->offset + hr, size, rx_buf->truesize);
@@ -3127,8 +3129,10 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
 	if (!libeth_rx_sync_for_cpu(buf, copy))
 		return 0;
 
-	dst = page_address(hdr->page) + hdr->offset + hdr->page->pp->p.offset;
-	src = page_address(buf->page) + buf->offset + buf->page->pp->p.offset;
+	dst = page_address(hdr->page) + hdr->offset +
+		page_pool_get_pp(hdr->page)->p.offset;
+	src = page_address(buf->page) + buf->offset +
+		page_pool_get_pp(buf->page)->p.offset;
 	memcpy(dst, src, LARGEST_ALIGN(copy));
 
 	buf->offset += copy;
@@ -3146,7 +3150,7 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
  */
 struct sk_buff *idpf_rx_build_skb(const struct libeth_fqe *buf, u32 size)
 {
-	u32 hr = buf->page->pp->p.offset;
+	u32 hr = page_pool_get_pp(buf->page)->p.offset;
 	struct sk_buff *skb;
 	void *va;
 
diff --git a/drivers/net/ethernet/intel/libeth/rx.c b/drivers/net/ethernet/intel/libeth/rx.c
index 66d1d23b8ad2..8de0c3a3b146 100644
--- a/drivers/net/ethernet/intel/libeth/rx.c
+++ b/drivers/net/ethernet/intel/libeth/rx.c
@@ -207,7 +207,7 @@ EXPORT_SYMBOL_NS_GPL(libeth_rx_fq_destroy, "LIBETH");
  */
 void libeth_rx_recycle_slow(struct page *page)
 {
-	page_pool_recycle_direct(page->pp, page);
+	page_pool_recycle_direct(page_pool_get_pp(page), page);
 }
 EXPORT_SYMBOL_NS_GPL(libeth_rx_recycle_slow, "LIBETH");
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 6f3094a479e1..b6bee95db994 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -709,7 +709,8 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 				/* No need to check ((page->pp_magic & ~0x3UL) == PP_SIGNATURE)
 				 * as we know this is a page_pool page.
 				 */
-				page_pool_recycle_direct(page->pp, page);
+				page_pool_recycle_direct(page_pool_get_pp(page),
+							 page);
 			} while (++n < num);
 
 			break;
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index a41dc79e9c2e..ffb7bcc67eba 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -836,7 +836,8 @@ nsim_pp_hold_write(struct file *file, const char __user *data,
 		if (!ns->page)
 			ret = -ENOMEM;
 	} else {
-		page_pool_put_full_page(ns->page->pp, ns->page, false);
+		page_pool_put_full_page(page_pool_get_pp(ns->page), ns->page,
+					false);
 		ns->page = NULL;
 	}
 
@@ -1048,7 +1049,8 @@ void nsim_destroy(struct netdevsim *ns)
 
 	/* Put this intentionally late to exercise the orphaning path */
 	if (ns->page) {
-		page_pool_put_full_page(ns->page->pp, ns->page, false);
+		page_pool_put_full_page(page_pool_get_pp(ns->page), ns->page,
+					false);
 		ns->page = NULL;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 132148f7b107..11a88ecf8533 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1777,7 +1777,7 @@ static inline void mt76_put_page_pool_buf(void *buf, bool allow_direct)
 {
 	struct page *page = virt_to_head_page(buf);
 
-	page_pool_put_full_page(page->pp, page, allow_direct);
+	page_pool_put_full_page(page_pool_get_pp(page), page, allow_direct);
 }
 
 static inline void *
diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index ab05024be518..2a3991d5b7c0 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -137,7 +137,8 @@ static inline bool libeth_rx_sync_for_cpu(const struct libeth_fqe *fqe,
 		return false;
 	}
 
-	page_pool_dma_sync_for_cpu(page->pp, page, fqe->offset, len);
+	page_pool_dma_sync_for_cpu(page_pool_get_pp(page), page, fqe->offset,
+				   len);
 
 	return true;
 }
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 582a3d00cbe2..ab91911af215 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -83,6 +83,11 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
 }
 #endif
 
+static inline struct page_pool *page_pool_get_pp(struct page *page)
+{
+	return page->pp;
+}
+
 /**
  * page_pool_dev_alloc_pages() - allocate a page.
  * @pool:	pool from which to allocate
-- 
2.33.0


