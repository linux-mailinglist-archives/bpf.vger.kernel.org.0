Return-Path: <bpf+bounces-20453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F81B83EAE1
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 05:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50B228B5A6
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 04:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16E814A8E;
	Sat, 27 Jan 2024 04:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GqCH2bqz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAF91428A;
	Sat, 27 Jan 2024 04:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706328302; cv=none; b=CLRDDkdwoXIqtBG68EKO41Af18qkAFyE0hp+qRs43rXR0xLajWQ37IPE8joWaMHLLskBYKTBz1OjcCbw8GPkoWQk0PicnV1hoChcEgKwnPSzvJujI8DG9ViiB8JDv+9obTsh2pYwSWkS19cislesRHsLu7KfVnHsENHZKN1aMtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706328302; c=relaxed/simple;
	bh=tmaDAZOOoco/B/Do5lARVSsuFNiunl83/qadTSQAa+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K+LPsSo+aVtqodf5xT9OBu61XYueuiowKAimWCjgRV8QBxRrBNyRnpInTiC3ZouWGIfW+QSASQD3MULun/a7y+f5jADDhqHpwAPhPkQtQo+g7u7T4no9mTLEYBDkbNrCB5/dmSaAbLFX3eAbcne/S2HaZeNlv7QOW5B0PGkbd48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GqCH2bqz; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706328300; x=1737864300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tmaDAZOOoco/B/Do5lARVSsuFNiunl83/qadTSQAa+E=;
  b=GqCH2bqzCr3mB6grVnJ6i+2NIvtILX3NI7KiPSKjg4uRMuAPtkHIL85v
   4lX/ywxYxXmxU/KOvywMRQCqaGN1uQbWZpiGEXtTR9IsYgvXu9d7ocSvC
   7uFgx8dev7hOsWluF7zuFXXRCs1R/H//2NDgUVzMQaliwM8CXV0Btclm6
   VgK3nkPPQ+yeaIdy/QxvpYx1gL5vhlEck8wfAzJpbPwSWja45bTNZXP26
   Yr9QHSC7rUDMc6ksV8TrTIBZTaalbYDqaLCErfK46Xi8J6ltALZy/auFW
   9voLSeEYZDXCbtJKTqf295NRVwOJAd0Dtai7wG+mMig1WV7hRbwRInUJB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="402289632"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="402289632"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 20:04:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="787309789"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="787309789"
Received: from ppglcf2090.png.intel.com ([10.126.160.96])
  by orsmga002.jf.intel.com with ESMTP; 26 Jan 2024 20:04:54 -0800
From: Rohan G Thomas <rohan.g.thomas@intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: [PATCH net-next 1/3] net: stmmac: Offload queueMaxSDU from tc-taprio
Date: Sat, 27 Jan 2024 12:04:41 +0800
Message-Id: <20240127040443.24835-2-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240127040443.24835-1-rohan.g.thomas@intel.com>
References: <20240127040443.24835-1-rohan.g.thomas@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for configuring queueMaxSDU. As DWMAC IPs doesn't support
queueMaxSDU table handle this in the SW. The maximum 802.3 frame size
that is allowed to be transmitted by any queue is queueMaxSDU +
16 bytes (i.e. 6 bytes SA + 6 bytes DA + 4 bytes FCS).

Inspired from intel i225 driver.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 22 ++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 25 +++++++++++++++++++
 include/linux/stmmac.h                        |  1 +
 4 files changed, 49 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 721c1f8e892f..d8d2a90fd228 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -202,6 +202,7 @@ struct stmmac_extra_stats {
 	unsigned long mtl_est_hlbf;
 	unsigned long mtl_est_btre;
 	unsigned long mtl_est_btrlm;
+	unsigned long max_sdu_txq_drop[MTL_MAX_TX_QUEUES];
 	/* per queue statistics */
 	struct stmmac_txq_stats txq_stats[MTL_MAX_TX_QUEUES];
 	struct stmmac_rxq_stats rxq_stats[MTL_MAX_RX_QUEUES];
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b334eb16da23..33509237fe60 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2507,6 +2507,13 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		if (!xsk_tx_peek_desc(pool, &xdp_desc))
 			break;
 
+		if (priv->plat->est && priv->plat->est->enable &&
+		    priv->plat->est->max_sdu[queue] &&
+		    xdp_desc.len > priv->plat->est->max_sdu[queue]) {
+			priv->xstats.max_sdu_txq_drop[queue]++;
+			continue;
+		}
+
 		if (likely(priv->extend_desc))
 			tx_desc = (struct dma_desc *)(tx_q->dma_etx + entry);
 		else if (tx_q->tbs & STMMAC_TBS_AVAIL)
@@ -4498,6 +4505,13 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 			return stmmac_tso_xmit(skb, dev);
 	}
 
+	if (priv->plat->est && priv->plat->est->enable &&
+	    priv->plat->est->max_sdu[queue] &&
+	    skb->len > priv->plat->est->max_sdu[queue]){
+		priv->xstats.max_sdu_txq_drop[queue]++;
+		goto max_sdu_err;
+	}
+
 	if (unlikely(stmmac_tx_avail(priv, queue) < nfrags + 1)) {
 		if (!netif_tx_queue_stopped(netdev_get_tx_queue(dev, queue))) {
 			netif_tx_stop_queue(netdev_get_tx_queue(priv->dev,
@@ -4715,6 +4729,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 
 dma_map_err:
 	netdev_err(priv->dev, "Tx DMA map failed\n");
+max_sdu_err:
 	dev_kfree_skb(skb);
 	priv->xstats.tx_dropped++;
 	return NETDEV_TX_OK;
@@ -4871,6 +4886,13 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 	if (stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv))
 		return STMMAC_XDP_CONSUMED;
 
+	if (priv->plat->est && priv->plat->est->enable &&
+	    priv->plat->est->max_sdu[queue] &&
+	    xdpf->len > priv->plat->est->max_sdu[queue]) {
+		priv->xstats.max_sdu_txq_drop[queue]++;
+		return STMMAC_XDP_CONSUMED;
+	}
+
 	if (likely(priv->extend_desc))
 		tx_desc = (struct dma_desc *)(tx_q->dma_etx + entry);
 	else if (tx_q->tbs & STMMAC_TBS_AVAIL)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 26fa33e5ec34..07aa3a3089dc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -915,6 +915,28 @@ struct timespec64 stmmac_calc_tas_basetime(ktime_t old_base_time,
 	return time;
 }
 
+static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
+				     struct tc_taprio_qopt_offload *qopt)
+{
+	struct plat_stmmacenet_data *plat = priv->plat;
+	u32 num_tc = qopt->mqprio.qopt.num_tc;
+	u32 offset, count, i, j;
+
+	/* QueueMaxSDU received from the driver corresponds to the Linux traffic
+	 * class. Map queueMaxSDU per Linux traffic class to DWMAC Tx queues.
+	 */
+	for (i = 0; i < num_tc; i++) {
+		if (!qopt->max_sdu[i])
+			continue;
+
+		offset = qopt->mqprio.qopt.offset[i];
+		count = qopt->mqprio.qopt.count[i];
+
+		for (j = offset; j < offset + count; j++)
+			plat->est->max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
+	}
+}
+
 static int tc_setup_taprio(struct stmmac_priv *priv,
 			   struct tc_taprio_qopt_offload *qopt)
 {
@@ -1045,6 +1067,8 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 
 	priv->plat->est->ter = qopt->cycle_time_extension;
 
+	tc_taprio_map_maxsdu_txq(priv, qopt);
+
 	if (fpe && !priv->dma_cap.fpesel) {
 		mutex_unlock(&priv->plat->est->lock);
 		return -EOPNOTSUPP;
@@ -1126,6 +1150,7 @@ static int tc_query_caps(struct stmmac_priv *priv,
 			return -EOPNOTSUPP;
 
 		caps->gate_mask_per_txq = true;
+		caps->supports_queue_max_sdu = true;
 
 		return 0;
 	}
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index dee5ad6e48c5..dfa1828cd756 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -127,6 +127,7 @@ struct stmmac_est {
 	u32 gcl_unaligned[EST_GCL];
 	u32 gcl[EST_GCL];
 	u32 gcl_size;
+	u32 max_sdu[MTL_MAX_TX_QUEUES];
 };
 
 struct stmmac_rxq_cfg {
-- 
2.26.2


