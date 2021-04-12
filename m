Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6A035CA25
	for <lists+bpf@lfdr.de>; Mon, 12 Apr 2021 17:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243081AbhDLPiG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 11:38:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:10980 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243097AbhDLPiG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Apr 2021 11:38:06 -0400
IronPort-SDR: sQxa225enKf6FD2s3D0xIIv34wCt9TB+pbo6+/RQF2t12OfPrtXzIXmSqcrMR8I9vw3x3lafWc
 SKjnMAnULANA==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="174318628"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="174318628"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 08:37:47 -0700
IronPort-SDR: r1WChGCqZ2w+BfJmT8sizC9rEdXp3/Qs5+aDTnkijGjCQ8sbYpn8cuNTTPS7VaQzl+qw3d2amM
 PgIogp+UAMWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="614609669"
Received: from glass.png.intel.com ([10.158.65.59])
  by fmsmga005.fm.intel.com with ESMTP; 12 Apr 2021 08:37:42 -0700
From:   Ong Boon Leong <boon.leong.ong@intel.com>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Ong Boon Leong <boon.leong.ong@intel.com>
Subject: [PATCH net-next 7/7] net: stmmac: Add TX via XDP zero-copy socket
Date:   Mon, 12 Apr 2021 23:41:30 +0800
Message-Id: <20210412154130.20742-8-boon.leong.ong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412154130.20742-1-boon.leong.ong@intel.com>
References: <20210412154130.20742-1-boon.leong.ong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We add the support of XDP ZC TX submission and cleaning into
stmmac_tx_clean(). The function is made to clean as many TX complete
frames as possible, i.e. limit by priv->dma_tx_size instead of NAPI
budget. For TX ring that is associated with XSK pool, the function
stmmac_xdp_xmit_zc() is introduced to TX frame buffers from XSK pool by
using xsk_tx_peek_desc(). To make stmmac_tx_clean() support the cleaning
of XSK TX frames, STMMAC_TXBUF_T_XSK_TX TX buffer type is introduced.

As stmmac_tx_clean() uses the return value to cue whether NAPI function
should continue to poll, we augment the caller of stmmac_tx_clean() to
pass NAPI budget instead of priv->dma_tx_size through 'budget' input and
made stmmac_tx_clean() to always clean up-to the TX ring size instead.
This allows us to use the return boolean status of stmmac_xdp_xmit_zc()
to decide if XSK TX work is done or not: If true, set 'xmits' to return
'budget - 1' so that NAPI poll may exit. Else, set 'xmits' to return
'budget' to make NAPI poll continue to poll since XSK TX work is not
done. Finally, at the end of stmmac_tx_clean(), the function now take
a maximum value between 'count' and 'xmits' so that status from both
TX cleaning and XSK TX (only for XDP ZC) is considered.

This patch adds a new NAPI poll called stmmac_napi_poll_rxtx() that is
meant to be enabled/disabled for RX and TX ring that are bound to XSK
pool. This NAPI poll function starts with cleaning TX ring, then submits
XSK TX frames to TX ring before proceed to perform RX operations, i.e.
, receiving RX frames and replenishing RX ring with RX free buffers
obtained from XSK pool. Therefore, during XSK RX and TX setup, the driver
enables stmmac_napi_poll_rxtx() for RX and TX operations, then during
XSK RX and TX pool tear-down, the driver reenables the exisiting
independent NAPI poll functions accordingly: stmmac_napi_poll_rx() and
stmmac_napi_poll_tx().

Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   6 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 317 ++++++++++++++++--
 .../net/ethernet/stmicro/stmmac/stmmac_xdp.c  |  16 +-
 3 files changed, 310 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index aa0db622ee69..3d9ceb6234eb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -40,6 +40,7 @@ enum stmmac_txbuf_type {
 	STMMAC_TXBUF_T_SKB,
 	STMMAC_TXBUF_T_XDP_TX,
 	STMMAC_TXBUF_T_XDP_NDO,
+	STMMAC_TXBUF_T_XSK_TX,
 };
 
 struct stmmac_tx_info {
@@ -69,6 +70,8 @@ struct stmmac_tx_queue {
 		struct xdp_frame **xdpf;
 	};
 	struct stmmac_tx_info *tx_skbuff_dma;
+	struct xsk_buff_pool *xsk_pool;
+	u32 xsk_frames_done;
 	unsigned int cur_tx;
 	unsigned int dirty_tx;
 	dma_addr_t dma_tx_phy;
@@ -116,6 +119,7 @@ struct stmmac_rx_queue {
 struct stmmac_channel {
 	struct napi_struct rx_napi ____cacheline_aligned_in_smp;
 	struct napi_struct tx_napi ____cacheline_aligned_in_smp;
+	struct napi_struct rxtx_napi ____cacheline_aligned_in_smp;
 	struct stmmac_priv *priv_data;
 	spinlock_t lock;
 	u32 index;
@@ -338,6 +342,8 @@ static inline unsigned int stmmac_rx_offset(struct stmmac_priv *priv)
 
 void stmmac_disable_rx_queue(struct stmmac_priv *priv, u32 queue);
 void stmmac_enable_rx_queue(struct stmmac_priv *priv, u32 queue);
+void stmmac_disable_tx_queue(struct stmmac_priv *priv, u32 queue);
+void stmmac_enable_tx_queue(struct stmmac_priv *priv, u32 queue);
 int stmmac_xsk_wakeup(struct net_device *dev, u32 queue, u32 flags);
 
 #if IS_ENABLED(CONFIG_STMMAC_SELFTESTS)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index dace043de13c..8e085647a02e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -70,6 +70,9 @@ MODULE_PARM_DESC(phyaddr, "Physical device address");
 #define STMMAC_TX_THRESH(x)	((x)->dma_tx_size / 4)
 #define STMMAC_RX_THRESH(x)	((x)->dma_rx_size / 4)
 
+/* Limit to make sure XDP TX and slow path can coexist */
+#define STMMAC_XSK_TX_BUDGET_MAX	256
+#define STMMAC_TX_XSK_AVAIL		16
 #define STMMAC_RX_FILL_BATCH		16
 
 #define STMMAC_XDP_PASS		0
@@ -120,6 +123,8 @@ static irqreturn_t stmmac_mac_interrupt(int irq, void *dev_id);
 static irqreturn_t stmmac_safety_interrupt(int irq, void *dev_id);
 static irqreturn_t stmmac_msi_intr_tx(int irq, void *data);
 static irqreturn_t stmmac_msi_intr_rx(int irq, void *data);
+static void stmmac_tx_timer_arm(struct stmmac_priv *priv, u32 queue);
+static void stmmac_flush_tx_descriptors(struct stmmac_priv *priv, int queue);
 
 #ifdef CONFIG_DEBUG_FS
 static const struct net_device_ops stmmac_netdev_ops;
@@ -206,6 +211,12 @@ static void stmmac_disable_all_queues(struct stmmac_priv *priv)
 	for (queue = 0; queue < maxq; queue++) {
 		struct stmmac_channel *ch = &priv->channel[queue];
 
+		if (stmmac_xdp_is_enabled(priv) &&
+		    test_bit(queue, priv->af_xdp_zc_qps)) {
+			napi_disable(&ch->rxtx_napi);
+			continue;
+		}
+
 		if (queue < rx_queues_cnt)
 			napi_disable(&ch->rx_napi);
 		if (queue < tx_queues_cnt)
@@ -227,6 +238,12 @@ static void stmmac_enable_all_queues(struct stmmac_priv *priv)
 	for (queue = 0; queue < maxq; queue++) {
 		struct stmmac_channel *ch = &priv->channel[queue];
 
+		if (stmmac_xdp_is_enabled(priv) &&
+		    test_bit(queue, priv->af_xdp_zc_qps)) {
+			napi_enable(&ch->rxtx_napi);
+			continue;
+		}
+
 		if (queue < rx_queues_cnt)
 			napi_enable(&ch->rx_napi);
 		if (queue < tx_queues_cnt)
@@ -1480,6 +1497,9 @@ static void stmmac_free_tx_buffer(struct stmmac_priv *priv, u32 queue, int i)
 		tx_q->xdpf[i] = NULL;
 	}
 
+	if (tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_XSK_TX)
+		tx_q->xsk_frames_done++;
+
 	if (tx_q->tx_skbuff[i] &&
 	    tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_SKB) {
 		dev_kfree_skb_any(tx_q->tx_skbuff[i]);
@@ -1802,6 +1822,8 @@ static int __init_dma_tx_desc_rings(struct stmmac_priv *priv, u32 queue)
 					 priv->dma_tx_size, 0);
 	}
 
+	tx_q->xsk_pool = stmmac_get_xsk_pool(priv, queue);
+
 	for (i = 0; i < priv->dma_tx_size; i++) {
 		struct dma_desc *p;
 
@@ -1878,10 +1900,19 @@ static int init_dma_desc_rings(struct net_device *dev, gfp_t flags)
  */
 static void dma_free_tx_skbufs(struct stmmac_priv *priv, u32 queue)
 {
+	struct stmmac_tx_queue *tx_q = &priv->tx_queue[queue];
 	int i;
 
+	tx_q->xsk_frames_done = 0;
+
 	for (i = 0; i < priv->dma_tx_size; i++)
 		stmmac_free_tx_buffer(priv, queue, i);
+
+	if (tx_q->xsk_pool && tx_q->xsk_frames_done) {
+		xsk_tx_completed(tx_q->xsk_pool, tx_q->xsk_frames_done);
+		tx_q->xsk_frames_done = 0;
+		tx_q->xsk_pool = NULL;
+	}
 }
 
 /**
@@ -2002,6 +2033,7 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv, u32 queue)
 	bool xdp_prog = stmmac_xdp_is_enabled(priv);
 	struct page_pool_params pp_params = { 0 };
 	unsigned int num_pages;
+	unsigned int napi_id;
 	int ret;
 
 	rx_q->queue_index = queue;
@@ -2049,9 +2081,15 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv, u32 queue)
 			return -ENOMEM;
 	}
 
+	if (stmmac_xdp_is_enabled(priv) &&
+	    test_bit(queue, priv->af_xdp_zc_qps))
+		napi_id = ch->rxtx_napi.napi_id;
+	else
+		napi_id = ch->rx_napi.napi_id;
+
 	ret = xdp_rxq_info_reg(&rx_q->xdp_rxq, priv->dev,
 			       rx_q->queue_index,
-			       ch->rx_napi.napi_id);
+			       napi_id);
 	if (ret) {
 		netdev_err(priv->dev, "Failed to register xdp rxq info\n");
 		return -EINVAL;
@@ -2373,6 +2411,101 @@ static void stmmac_dma_operation_mode(struct stmmac_priv *priv)
 	}
 }
 
+static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
+{
+	struct netdev_queue *nq = netdev_get_tx_queue(priv->dev, queue);
+	struct stmmac_tx_queue *tx_q = &priv->tx_queue[queue];
+	struct xsk_buff_pool *pool = tx_q->xsk_pool;
+	unsigned int entry = tx_q->cur_tx;
+	struct dma_desc *tx_desc = NULL;
+	struct xdp_desc xdp_desc;
+	bool work_done = true;
+
+	/* Avoids TX time-out as we are sharing with slow path */
+	nq->trans_start = jiffies;
+
+	budget = min(budget, stmmac_tx_avail(priv, queue));
+
+	while (budget-- > 0) {
+		dma_addr_t dma_addr;
+		bool set_ic;
+
+		/* We are sharing with slow path and stop XSK TX desc submission when
+		 * available TX ring is less than threshold.
+		 */
+		if (unlikely(stmmac_tx_avail(priv, queue) < STMMAC_TX_XSK_AVAIL) ||
+		    !netif_carrier_ok(priv->dev)) {
+			work_done = false;
+			break;
+		}
+
+		if (!xsk_tx_peek_desc(pool, &xdp_desc))
+			break;
+
+		if (likely(priv->extend_desc))
+			tx_desc = (struct dma_desc *)(tx_q->dma_etx + entry);
+		else if (tx_q->tbs & STMMAC_TBS_AVAIL)
+			tx_desc = &tx_q->dma_entx[entry].basic;
+		else
+			tx_desc = tx_q->dma_tx + entry;
+
+		dma_addr = xsk_buff_raw_get_dma(pool, xdp_desc.addr);
+		xsk_buff_raw_dma_sync_for_device(pool, dma_addr, xdp_desc.len);
+
+		tx_q->tx_skbuff_dma[entry].buf_type = STMMAC_TXBUF_T_XSK_TX;
+
+		/* To return XDP buffer to XSK pool, we simple call
+		 * xsk_tx_completed(), so we don't need to fill up
+		 * 'buf' and 'xdpf'.
+		 */
+		tx_q->tx_skbuff_dma[entry].buf = 0;
+		tx_q->xdpf[entry] = NULL;
+
+		tx_q->tx_skbuff_dma[entry].map_as_page = false;
+		tx_q->tx_skbuff_dma[entry].len = xdp_desc.len;
+		tx_q->tx_skbuff_dma[entry].last_segment = true;
+		tx_q->tx_skbuff_dma[entry].is_jumbo = false;
+
+		stmmac_set_desc_addr(priv, tx_desc, dma_addr);
+
+		tx_q->tx_count_frames++;
+
+		if (!priv->tx_coal_frames[queue])
+			set_ic = false;
+		else if (tx_q->tx_count_frames % priv->tx_coal_frames[queue] == 0)
+			set_ic = true;
+		else
+			set_ic = false;
+
+		if (set_ic) {
+			tx_q->tx_count_frames = 0;
+			stmmac_set_tx_ic(priv, tx_desc);
+			priv->xstats.tx_set_ic_bit++;
+		}
+
+		stmmac_prepare_tx_desc(priv, tx_desc, 1, xdp_desc.len,
+				       true, priv->mode, true, true,
+				       xdp_desc.len);
+
+		stmmac_enable_dma_transmission(priv, priv->ioaddr);
+
+		tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx, priv->dma_tx_size);
+		entry = tx_q->cur_tx;
+	}
+
+	if (tx_desc) {
+		stmmac_flush_tx_descriptors(priv, queue);
+		xsk_tx_release(pool);
+	}
+
+	/* Return true if all of the 3 conditions are met
+	 *  a) TX Budget is still available
+	 *  b) work_done = true when XSK TX desc peek is empty (no more
+	 *     pending XSK TX for transmission)
+	 */
+	return !!budget && work_done;
+}
+
 /**
  * stmmac_tx_clean - to manage the transmission completion
  * @priv: driver private structure
@@ -2384,14 +2517,18 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
 {
 	struct stmmac_tx_queue *tx_q = &priv->tx_queue[queue];
 	unsigned int bytes_compl = 0, pkts_compl = 0;
-	unsigned int entry, count = 0;
+	unsigned int entry, xmits = 0, count = 0;
 
 	__netif_tx_lock_bh(netdev_get_tx_queue(priv->dev, queue));
 
 	priv->xstats.tx_clean++;
 
+	tx_q->xsk_frames_done = 0;
+
 	entry = tx_q->dirty_tx;
-	while ((entry != tx_q->cur_tx) && (count < budget)) {
+
+	/* Try to clean all TX complete frame in 1 shot */
+	while ((entry != tx_q->cur_tx) && count < priv->dma_tx_size) {
 		struct xdp_frame *xdpf;
 		struct sk_buff *skb;
 		struct dma_desc *p;
@@ -2476,6 +2613,9 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
 			tx_q->xdpf[entry] = NULL;
 		}
 
+		if (tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_XSK_TX)
+			tx_q->xsk_frames_done++;
+
 		if (tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_SKB) {
 			if (likely(skb)) {
 				pkts_compl++;
@@ -2503,6 +2643,28 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
 		netif_tx_wake_queue(netdev_get_tx_queue(priv->dev, queue));
 	}
 
+	if (tx_q->xsk_pool) {
+		bool work_done;
+
+		if (tx_q->xsk_frames_done)
+			xsk_tx_completed(tx_q->xsk_pool, tx_q->xsk_frames_done);
+
+		if (xsk_uses_need_wakeup(tx_q->xsk_pool))
+			xsk_set_tx_need_wakeup(tx_q->xsk_pool);
+
+		/* For XSK TX, we try to send as many as possible.
+		 * If XSK work done (XSK TX desc empty and budget still
+		 * available), return "budget - 1" to reenable TX IRQ.
+		 * Else, return "budget" to make NAPI continue polling.
+		 */
+		work_done = stmmac_xdp_xmit_zc(priv, queue,
+					       STMMAC_XSK_TX_BUDGET_MAX);
+		if (work_done)
+			xmits = budget - 1;
+		else
+			xmits = budget;
+	}
+
 	if (priv->eee_enabled && !priv->tx_path_in_lpi_mode &&
 	    priv->eee_sw_timer_en) {
 		stmmac_enable_eee_mode(priv);
@@ -2517,7 +2679,8 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
 
 	__netif_tx_unlock_bh(netdev_get_tx_queue(priv->dev, queue));
 
-	return count;
+	/* Combine decisions from TX clean and XSK TX */
+	return max(count, xmits);
 }
 
 /**
@@ -2599,24 +2762,31 @@ static int stmmac_napi_check(struct stmmac_priv *priv, u32 chan, u32 dir)
 {
 	int status = stmmac_dma_interrupt_status(priv, priv->ioaddr,
 						 &priv->xstats, chan, dir);
+	struct stmmac_rx_queue *rx_q = &priv->rx_queue[chan];
+	struct stmmac_tx_queue *tx_q = &priv->tx_queue[chan];
 	struct stmmac_channel *ch = &priv->channel[chan];
+	struct napi_struct *rx_napi;
+	struct napi_struct *tx_napi;
 	unsigned long flags;
 
+	rx_napi = rx_q->xsk_pool ? &ch->rxtx_napi : &ch->rx_napi;
+	tx_napi = tx_q->xsk_pool ? &ch->rxtx_napi : &ch->tx_napi;
+
 	if ((status & handle_rx) && (chan < priv->plat->rx_queues_to_use)) {
-		if (napi_schedule_prep(&ch->rx_napi)) {
+		if (napi_schedule_prep(rx_napi)) {
 			spin_lock_irqsave(&ch->lock, flags);
 			stmmac_disable_dma_irq(priv, priv->ioaddr, chan, 1, 0);
 			spin_unlock_irqrestore(&ch->lock, flags);
-			__napi_schedule(&ch->rx_napi);
+			__napi_schedule(rx_napi);
 		}
 	}
 
 	if ((status & handle_tx) && (chan < priv->plat->tx_queues_to_use)) {
-		if (napi_schedule_prep(&ch->tx_napi)) {
+		if (napi_schedule_prep(tx_napi)) {
 			spin_lock_irqsave(&ch->lock, flags);
 			stmmac_disable_dma_irq(priv, priv->ioaddr, chan, 0, 1);
 			spin_unlock_irqrestore(&ch->lock, flags);
-			__napi_schedule(&ch->tx_napi);
+			__napi_schedule(tx_napi);
 		}
 	}
 
@@ -2814,16 +2984,18 @@ static enum hrtimer_restart stmmac_tx_timer(struct hrtimer *t)
 	struct stmmac_tx_queue *tx_q = container_of(t, struct stmmac_tx_queue, txtimer);
 	struct stmmac_priv *priv = tx_q->priv_data;
 	struct stmmac_channel *ch;
+	struct napi_struct *napi;
 
 	ch = &priv->channel[tx_q->queue_index];
+	napi = tx_q->xsk_pool ? &ch->rxtx_napi : &ch->tx_napi;
 
-	if (likely(napi_schedule_prep(&ch->tx_napi))) {
+	if (likely(napi_schedule_prep(napi))) {
 		unsigned long flags;
 
 		spin_lock_irqsave(&ch->lock, flags);
 		stmmac_disable_dma_irq(priv, priv->ioaddr, ch->index, 0, 1);
 		spin_unlock_irqrestore(&ch->lock, flags);
-		__napi_schedule(&ch->tx_napi);
+		__napi_schedule(napi);
 	}
 
 	return HRTIMER_NORESTART;
@@ -4621,7 +4793,7 @@ static struct sk_buff *stmmac_construct_skb_zc(struct stmmac_channel *ch,
 	unsigned int datasize = xdp->data_end - xdp->data;
 	struct sk_buff *skb;
 
-	skb = __napi_alloc_skb(&ch->rx_napi,
+	skb = __napi_alloc_skb(&ch->rxtx_napi,
 			       xdp->data_end - xdp->data_hard_start,
 			       GFP_ATOMIC | __GFP_NOWARN);
 	if (unlikely(!skb))
@@ -4665,7 +4837,7 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 		skb_set_hash(skb, hash, hash_type);
 
 	skb_record_rx_queue(skb, queue);
-	napi_gro_receive(&ch->rx_napi, skb);
+	napi_gro_receive(&ch->rxtx_napi, skb);
 
 	priv->dev->stats.rx_packets++;
 	priv->dev->stats.rx_bytes += len;
@@ -5197,17 +5369,12 @@ static int stmmac_napi_poll_rx(struct napi_struct *napi, int budget)
 	struct stmmac_channel *ch =
 		container_of(napi, struct stmmac_channel, rx_napi);
 	struct stmmac_priv *priv = ch->priv_data;
-	struct stmmac_rx_queue *rx_q;
 	u32 chan = ch->index;
 	int work_done;
 
 	priv->xstats.napi_poll++;
 
-	rx_q = &priv->rx_queue[chan];
-
-	work_done = rx_q->xsk_pool ?
-		    stmmac_rx_zc(priv, budget, chan) :
-		    stmmac_rx(priv, budget, chan);
+	work_done = stmmac_rx(priv, budget, chan);
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
 		unsigned long flags;
 
@@ -5229,7 +5396,7 @@ static int stmmac_napi_poll_tx(struct napi_struct *napi, int budget)
 
 	priv->xstats.napi_poll++;
 
-	work_done = stmmac_tx_clean(priv, priv->dma_tx_size, chan);
+	work_done = stmmac_tx_clean(priv, budget, chan);
 	work_done = min(work_done, budget);
 
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
@@ -5243,6 +5410,42 @@ static int stmmac_napi_poll_tx(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
+static int stmmac_napi_poll_rxtx(struct napi_struct *napi, int budget)
+{
+	struct stmmac_channel *ch =
+		container_of(napi, struct stmmac_channel, rxtx_napi);
+	struct stmmac_priv *priv = ch->priv_data;
+	int rx_done, tx_done;
+	u32 chan = ch->index;
+
+	priv->xstats.napi_poll++;
+
+	tx_done = stmmac_tx_clean(priv, budget, chan);
+	tx_done = min(tx_done, budget);
+
+	rx_done = stmmac_rx_zc(priv, budget, chan);
+
+	/* If either TX or RX work is not complete, return budget
+	 * and keep pooling
+	 */
+	if (tx_done >= budget || rx_done >= budget)
+		return budget;
+
+	/* all work done, exit the polling mode */
+	if (napi_complete_done(napi, rx_done)) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&ch->lock, flags);
+		/* Both RX and TX work done are compelte,
+		 * so enable both RX & TX IRQs.
+		 */
+		stmmac_enable_dma_irq(priv, priv->ioaddr, chan, 1, 1);
+		spin_unlock_irqrestore(&ch->lock, flags);
+	}
+
+	return min(rx_done, budget - 1);
+}
+
 /**
  *  stmmac_tx_timeout
  *  @dev : Pointer to net device structure
@@ -6223,10 +6426,63 @@ void stmmac_enable_rx_queue(struct stmmac_priv *priv, u32 queue)
 	spin_unlock_irqrestore(&ch->lock, flags);
 }
 
+void stmmac_disable_tx_queue(struct stmmac_priv *priv, u32 queue)
+{
+	struct stmmac_channel *ch = &priv->channel[queue];
+	unsigned long flags;
+
+	spin_lock_irqsave(&ch->lock, flags);
+	stmmac_disable_dma_irq(priv, priv->ioaddr, queue, 0, 1);
+	spin_unlock_irqrestore(&ch->lock, flags);
+
+	stmmac_stop_tx_dma(priv, queue);
+	__free_dma_tx_desc_resources(priv, queue);
+}
+
+void stmmac_enable_tx_queue(struct stmmac_priv *priv, u32 queue)
+{
+	struct stmmac_tx_queue *tx_q = &priv->tx_queue[queue];
+	struct stmmac_channel *ch = &priv->channel[queue];
+	unsigned long flags;
+	int ret;
+
+	ret = __alloc_dma_tx_desc_resources(priv, queue);
+	if (ret) {
+		netdev_err(priv->dev, "Failed to alloc TX desc.\n");
+		return;
+	}
+
+	ret = __init_dma_tx_desc_rings(priv, queue);
+	if (ret) {
+		__free_dma_tx_desc_resources(priv, queue);
+		netdev_err(priv->dev, "Failed to init TX desc.\n");
+		return;
+	}
+
+	stmmac_clear_tx_descriptors(priv, queue);
+
+	stmmac_init_tx_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
+			    tx_q->dma_tx_phy, tx_q->queue_index);
+
+	if (tx_q->tbs & STMMAC_TBS_AVAIL)
+		stmmac_enable_tbs(priv, priv->ioaddr, 1, tx_q->queue_index);
+
+	tx_q->tx_tail_addr = tx_q->dma_tx_phy;
+	stmmac_set_tx_tail_ptr(priv, priv->ioaddr,
+			       tx_q->tx_tail_addr, tx_q->queue_index);
+
+	stmmac_start_tx_dma(priv, queue);
+
+	spin_lock_irqsave(&ch->lock, flags);
+	stmmac_enable_dma_irq(priv, priv->ioaddr, queue, 0, 1);
+	spin_unlock_irqrestore(&ch->lock, flags);
+}
+
 int stmmac_xsk_wakeup(struct net_device *dev, u32 queue, u32 flags)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 	struct stmmac_rx_queue *rx_q;
+	struct stmmac_tx_queue *tx_q;
 	struct stmmac_channel *ch;
 
 	if (test_bit(STMMAC_DOWN, &priv->state) ||
@@ -6236,22 +6492,23 @@ int stmmac_xsk_wakeup(struct net_device *dev, u32 queue, u32 flags)
 	if (!stmmac_xdp_is_enabled(priv))
 		return -ENXIO;
 
-	if (queue >= priv->plat->rx_queues_to_use)
+	if (queue >= priv->plat->rx_queues_to_use ||
+	    queue >= priv->plat->tx_queues_to_use)
 		return -EINVAL;
 
 	rx_q = &priv->rx_queue[queue];
+	tx_q = &priv->tx_queue[queue];
 	ch = &priv->channel[queue];
 
-	if (!rx_q->xsk_pool)
+	if (!rx_q->xsk_pool && !tx_q->xsk_pool)
 		return -ENXIO;
 
-	if (flags & XDP_WAKEUP_RX &&
-	    !napi_if_scheduled_mark_missed(&ch->rx_napi)) {
+	if (!napi_if_scheduled_mark_missed(&ch->rxtx_napi)) {
 		/* EQoS does not have per-DMA channel SW interrupt,
 		 * so we schedule RX Napi straight-away.
 		 */
-		if (likely(napi_schedule_prep(&ch->rx_napi)))
-			__napi_schedule(&ch->rx_napi);
+		if (likely(napi_schedule_prep(&ch->rxtx_napi)))
+			__napi_schedule(&ch->rxtx_napi);
 	}
 
 	return 0;
@@ -6436,6 +6693,12 @@ static void stmmac_napi_add(struct net_device *dev)
 					  stmmac_napi_poll_tx,
 					  NAPI_POLL_WEIGHT);
 		}
+		if (queue < priv->plat->rx_queues_to_use &&
+		    queue < priv->plat->tx_queues_to_use) {
+			netif_napi_add(dev, &ch->rxtx_napi,
+				       stmmac_napi_poll_rxtx,
+				       NAPI_POLL_WEIGHT);
+		}
 	}
 }
 
@@ -6453,6 +6716,10 @@ static void stmmac_napi_del(struct net_device *dev)
 			netif_napi_del(&ch->rx_napi);
 		if (queue < priv->plat->tx_queues_to_use)
 			netif_napi_del(&ch->tx_napi);
+		if (queue < priv->plat->rx_queues_to_use &&
+		    queue < priv->plat->tx_queues_to_use) {
+			netif_napi_del(&ch->rxtx_napi);
+		}
 	}
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
index b1f6362484f0..34613324795d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
@@ -14,7 +14,8 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
 	u32 frame_size;
 	int err;
 
-	if (queue >= priv->plat->rx_queues_to_use)
+	if (queue >= priv->plat->rx_queues_to_use ||
+	    queue >= priv->plat->tx_queues_to_use)
 		return -EINVAL;
 
 	frame_size = xsk_pool_get_rx_frame_size(pool);
@@ -34,14 +35,17 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
 
 	if (need_update) {
 		stmmac_disable_rx_queue(priv, queue);
+		stmmac_disable_tx_queue(priv, queue);
 		napi_disable(&ch->rx_napi);
+		napi_disable(&ch->tx_napi);
 	}
 
 	set_bit(queue, priv->af_xdp_zc_qps);
 
 	if (need_update) {
-		napi_enable(&ch->rx_napi);
+		napi_enable(&ch->rxtx_napi);
 		stmmac_enable_rx_queue(priv, queue);
+		stmmac_enable_tx_queue(priv, queue);
 
 		err = stmmac_xsk_wakeup(priv->dev, queue, XDP_WAKEUP_RX);
 		if (err)
@@ -57,7 +61,8 @@ static int stmmac_xdp_disable_pool(struct stmmac_priv *priv, u16 queue)
 	struct xsk_buff_pool *pool;
 	bool need_update;
 
-	if (queue >= priv->plat->rx_queues_to_use)
+	if (queue >= priv->plat->rx_queues_to_use ||
+	    queue >= priv->plat->tx_queues_to_use)
 		return -EINVAL;
 
 	pool = xsk_get_pool_from_qid(priv->dev, queue);
@@ -68,7 +73,8 @@ static int stmmac_xdp_disable_pool(struct stmmac_priv *priv, u16 queue)
 
 	if (need_update) {
 		stmmac_disable_rx_queue(priv, queue);
-		napi_disable(&ch->rx_napi);
+		stmmac_disable_tx_queue(priv, queue);
+		napi_disable(&ch->rxtx_napi);
 	}
 
 	xsk_pool_dma_unmap(pool, STMMAC_RX_DMA_ATTR);
@@ -77,7 +83,9 @@ static int stmmac_xdp_disable_pool(struct stmmac_priv *priv, u16 queue)
 
 	if (need_update) {
 		napi_enable(&ch->rx_napi);
+		napi_enable(&ch->tx_napi);
 		stmmac_enable_rx_queue(priv, queue);
+		stmmac_enable_tx_queue(priv, queue);
 	}
 
 	return 0;
-- 
2.25.1

