Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F8F350C51
	for <lists+bpf@lfdr.de>; Thu,  1 Apr 2021 04:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbhDACIB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 22:08:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:12618 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232994AbhDACHw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 22:07:52 -0400
IronPort-SDR: LGbWlgLKDWw4Hqw6pDgm/nsTrzSnO9tJ2pGgAKnZ/PeNPemSrwz/K2v9SD1Abwmbl2qpN9AALk
 He6/Ew99UyAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="179664031"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="179664031"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 19:07:52 -0700
IronPort-SDR: PvCDMZ9NQ+z+wHv91b6TMXnArKvUx95GfkH3AZtNyR8jA2abhgospZRbbnWHgpChrFr8SEYuSG
 I2DVvL45C1oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="528004231"
Received: from glass.png.intel.com ([10.158.65.59])
  by orsmga004.jf.intel.com with ESMTP; 31 Mar 2021 19:07:46 -0700
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
Subject: [PATCH net-next v4 3/6] net: stmmac: arrange Tx tail pointer update to stmmac_flush_tx_descriptors
Date:   Thu,  1 Apr 2021 10:11:14 +0800
Message-Id: <20210401021117.13360-4-boon.leong.ong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401021117.13360-1-boon.leong.ong@intel.com>
References: <20210401021117.13360-1-boon.leong.ong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch organizes TX tail pointer update into a new function called
stmmac_flush_tx_descriptors() so that we can reuse it in stmmac_xmit(),
stmmac_tso_xmit() and up-coming XDP implementation.

Changes to v2:
 - Fix for warning: unused variable ‘desc_size’
   https://patchwork.hopto.org/static/nipa/457321/12170149/build_32bit/stderr

Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 56 +++++++++----------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 18e34a1e2367..cb1b2a180429 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3518,6 +3518,28 @@ static void stmmac_tso_allocator(struct stmmac_priv *priv, dma_addr_t des,
 	}
 }
 
+static void stmmac_flush_tx_descriptors(struct stmmac_priv *priv, int queue)
+{
+	struct stmmac_tx_queue *tx_q = &priv->tx_queue[queue];
+	int desc_size;
+
+	if (likely(priv->extend_desc))
+		desc_size = sizeof(struct dma_extended_desc);
+	else if (tx_q->tbs & STMMAC_TBS_AVAIL)
+		desc_size = sizeof(struct dma_edesc);
+	else
+		desc_size = sizeof(struct dma_desc);
+
+	/* The own bit must be the latest setting done when prepare the
+	 * descriptor and then barrier is needed to make sure that
+	 * all is coherent before granting the DMA engine.
+	 */
+	wmb();
+
+	tx_q->tx_tail_addr = tx_q->dma_tx_phy + (tx_q->cur_tx * desc_size);
+	stmmac_set_tx_tail_ptr(priv, priv->ioaddr, tx_q->tx_tail_addr, queue);
+}
+
 /**
  *  stmmac_tso_xmit - Tx entry point of the driver for oversized frames (TSO)
  *  @skb : the socket buffer
@@ -3549,10 +3571,10 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct dma_desc *desc, *first, *mss_desc = NULL;
 	struct stmmac_priv *priv = netdev_priv(dev);
-	int desc_size, tmp_pay_len = 0, first_tx;
 	int nfrags = skb_shinfo(skb)->nr_frags;
 	u32 queue = skb_get_queue_mapping(skb);
 	unsigned int first_entry, tx_packets;
+	int tmp_pay_len = 0, first_tx;
 	struct stmmac_tx_queue *tx_q;
 	bool has_vlan, set_ic;
 	u8 proto_hdr_len, hdr;
@@ -3750,12 +3772,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 		stmmac_set_tx_owner(priv, mss_desc);
 	}
 
-	/* The own bit must be the latest setting done when prepare the
-	 * descriptor and then barrier is needed to make sure that
-	 * all is coherent before granting the DMA engine.
-	 */
-	wmb();
-
 	if (netif_msg_pktdata(priv)) {
 		pr_info("%s: curr=%d dirty=%d f=%d, e=%d, f_p=%p, nfrags %d\n",
 			__func__, tx_q->cur_tx, tx_q->dirty_tx, first_entry,
@@ -3766,13 +3782,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
 
-	if (tx_q->tbs & STMMAC_TBS_AVAIL)
-		desc_size = sizeof(struct dma_edesc);
-	else
-		desc_size = sizeof(struct dma_desc);
-
-	tx_q->tx_tail_addr = tx_q->dma_tx_phy + (tx_q->cur_tx * desc_size);
-	stmmac_set_tx_tail_ptr(priv, priv->ioaddr, tx_q->tx_tail_addr, queue);
+	stmmac_flush_tx_descriptors(priv, queue);
 	stmmac_tx_timer_arm(priv, queue);
 
 	return NETDEV_TX_OK;
@@ -3802,10 +3812,10 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	int nfrags = skb_shinfo(skb)->nr_frags;
 	int gso = skb_shinfo(skb)->gso_type;
 	struct dma_edesc *tbs_desc = NULL;
-	int entry, desc_size, first_tx;
 	struct dma_desc *desc, *first;
 	struct stmmac_tx_queue *tx_q;
 	bool has_vlan, set_ic;
+	int entry, first_tx;
 	dma_addr_t des;
 
 	tx_q = &priv->tx_queue[queue];
@@ -4007,25 +4017,11 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	stmmac_set_tx_owner(priv, first);
 
-	/* The own bit must be the latest setting done when prepare the
-	 * descriptor and then barrier is needed to make sure that
-	 * all is coherent before granting the DMA engine.
-	 */
-	wmb();
-
 	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
 
 	stmmac_enable_dma_transmission(priv, priv->ioaddr);
 
-	if (likely(priv->extend_desc))
-		desc_size = sizeof(struct dma_extended_desc);
-	else if (tx_q->tbs & STMMAC_TBS_AVAIL)
-		desc_size = sizeof(struct dma_edesc);
-	else
-		desc_size = sizeof(struct dma_desc);
-
-	tx_q->tx_tail_addr = tx_q->dma_tx_phy + (tx_q->cur_tx * desc_size);
-	stmmac_set_tx_tail_ptr(priv, priv->ioaddr, tx_q->tx_tail_addr, queue);
+	stmmac_flush_tx_descriptors(priv, queue);
 	stmmac_tx_timer_arm(priv, queue);
 
 	return NETDEV_TX_OK;
-- 
2.25.1

