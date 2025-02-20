Return-Path: <bpf+bounces-52032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E3DA3CF92
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 03:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD95617B769
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 02:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442621DE3CA;
	Thu, 20 Feb 2025 02:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P6nxsPK0"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EB31CD1E0;
	Thu, 20 Feb 2025 02:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020062; cv=none; b=pFIi3cm53RiSPuTr0XN6GstihnIElIISWRnf7p3c40IkzCr06TqjoOC0LZr1DHk3NbB4eyIO9nH5E4KC+9yQJlJcOiwxQXcRu3jGg6ZFnzPKYbb2lkEDHbeOA6/FCeFBVCjHqm1IRfokuuqdvePv/1Rm/eugoCLxyy7+Pxt0XY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020062; c=relaxed/simple;
	bh=yw1Fhv1AXiWC1sZbIDIvnAgTLXBzvmPj0ud47+mirYg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ctbqzBvkUAKcc64eETTVIxfwzFFsa6AFQ4q5eElfp0Crjl8cMZknK+8nJk29jY0zqXUmtoL9mAmX5UUuQrXr1VtwFZ2Ati/6PHC7y4bdlwnQo1SWTT3KVWLlX7xBX1jURJSQBJGFLVp9UP9DPqVuUp7Awr1JjR3fP1FGxzdl2LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P6nxsPK0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740020060; x=1771556060;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=yw1Fhv1AXiWC1sZbIDIvnAgTLXBzvmPj0ud47+mirYg=;
  b=P6nxsPK0ZvFusij4CkkXCjfdrC2gtwlpEp5tnwXyPL0v7c8bL2Xs2vn+
   15bOyMBNojfiSau+drrcIKjgNonpwXYaV4hSf3FJF1AyaG8Zqu66Wvk1n
   0HDIb5ikVUCOVvBLWbgVeJKUSo9s9m3an3HAytuYmyzXBb8tYct5G1ZEF
   Wn3VF1tiYuurw0MCl+nTVe4Vu88qtQugJ/lMM5lbO1L8vlc+5BRnKDjyn
   i/SQp1LL0bmooDIBqV2Tf/68SFfefGBuip6SlmQuzbg5eszfUNyNRWxUS
   vhosDMF9dx2sl8E9XKaF0hbpnbr9IOafVXuJfB4QLmiLK60h6taV4hJRA
   Q==;
X-CSE-ConnectionGUID: bPXCo5gEReGa104FM+j3kw==
X-CSE-MsgGUID: /Ae+YhKxSOiLXov58odQDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="41041888"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="41041888"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 18:54:19 -0800
X-CSE-ConnectionGUID: qLq6jOKNRGeRA1LQlndv3A==
X-CSE-MsgGUID: WbGCX15JQVa5k4xlKKqLbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="115104261"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by fmviesa008.fm.intel.com with ESMTP; 19 Feb 2025 18:54:11 -0800
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next v5 1/9] net: ethtool: mm: extract stmmac verification logic into common library
Date: Wed, 19 Feb 2025 21:53:41 -0500
Message-Id: <20250220025349.3007793-2-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220025349.3007793-1-faizal.abdul.rahim@linux.intel.com>
References: <20250220025349.3007793-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vladimir Oltean <vladimir.oltean@nxp.com>

It appears that stmmac is not the only hardware which requires a
software-driven verification state machine for the MAC Merge layer.

While on the one hand it's good to encourage hardware implementations,
on the other hand it's quite difficult to tolerate multiple drivers
implementing independently fairly non-trivial logic.

Extract the hardware-independent logic from stmmac into library code and
put it in ethtool. Name the state structure "mmsv" for MAC Merge
Software Verification. Let this expose an operations structure for
executing the hardware stuff: sync hardware with the tx_active boolean
(result of verification process), enable/disable the pMAC, send mPackets,
notify library of external events (reception of mPackets), as well as
link state changes.

Note that it is assumed that the external events are received in hardirq
context. If they are not, it is probably a good idea to disable hardirqs
when calling ethtool_mmsv_event_handle(), because the library does not
do so.

Also, the MM software verification process has no business with the
tx_min_frag_size, that is all the driver's to handle.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Co-developed-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Co-developed-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Tested-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  16 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  41 +---
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 174 +++-----------
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  |   5 -
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   8 +-
 include/linux/ethtool.h                       | 131 ++++++++++
 net/ethtool/mm.c                              | 225 +++++++++++++++++-
 7 files changed, 399 insertions(+), 201 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index f05cae103d83..c9cc41af258a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -147,21 +147,9 @@ struct stmmac_channel {
 };
 
 struct stmmac_fpe_cfg {
-	/* Serialize access to MAC Merge state between ethtool requests
-	 * and link state updates.
-	 */
-	spinlock_t lock;
-
+	struct ethtool_mmsv mmsv;
 	const struct stmmac_fpe_reg *reg;
-	u32 fpe_csr;				/* MAC_FPE_CTRL_STS reg cache */
-
-	enum ethtool_mm_verify_status status;
-	struct timer_list verify_timer;
-	bool verify_enabled;
-	int verify_retries;
-	bool pmac_enabled;
-	u32 verify_time;
-	bool tx_enabled;
+	u32 fpe_csr;	/* MAC_FPE_CTRL_STS reg cache */
 };
 
 struct stmmac_tc_entry {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 918a32f8fda8..8e6b052e00d6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -1210,37 +1210,17 @@ static int stmmac_get_mm(struct net_device *ndev,
 			 struct ethtool_mm_state *state)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
-	unsigned long flags;
 	u32 frag_size;
 
 	if (!stmmac_fpe_supported(priv))
 		return -EOPNOTSUPP;
 
-	spin_lock_irqsave(&priv->fpe_cfg.lock, flags);
+	ethtool_mmsv_get_mm(&priv->fpe_cfg.mmsv, state);
 
-	state->max_verify_time = STMMAC_FPE_MM_MAX_VERIFY_TIME_MS;
-	state->verify_enabled = priv->fpe_cfg.verify_enabled;
-	state->pmac_enabled = priv->fpe_cfg.pmac_enabled;
-	state->verify_time = priv->fpe_cfg.verify_time;
-	state->tx_enabled = priv->fpe_cfg.tx_enabled;
-	state->verify_status = priv->fpe_cfg.status;
 	state->rx_min_frag_size = ETH_ZLEN;
-
-	/* FPE active if common tx_enabled and
-	 * (verification success or disabled(forced))
-	 */
-	if (state->tx_enabled &&
-	    (state->verify_status == ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
-	     state->verify_status == ETHTOOL_MM_VERIFY_STATUS_DISABLED))
-		state->tx_active = true;
-	else
-		state->tx_active = false;
-
 	frag_size = stmmac_fpe_get_add_frag_size(priv);
 	state->tx_min_frag_size = ethtool_mm_frag_size_add_to_min(frag_size);
 
-	spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
-
 	return 0;
 }
 
@@ -1248,8 +1228,6 @@ static int stmmac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
 			 struct netlink_ext_ack *extack)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
-	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
-	unsigned long flags;
 	u32 frag_size;
 	int err;
 
@@ -1258,23 +1236,8 @@ static int stmmac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
 	if (err)
 		return err;
 
-	/* Wait for the verification that's currently in progress to finish */
-	timer_shutdown_sync(&fpe_cfg->verify_timer);
-
-	spin_lock_irqsave(&fpe_cfg->lock, flags);
-
-	fpe_cfg->verify_enabled = cfg->verify_enabled;
-	fpe_cfg->pmac_enabled = cfg->pmac_enabled;
-	fpe_cfg->verify_time = cfg->verify_time;
-	fpe_cfg->tx_enabled = cfg->tx_enabled;
-
-	if (!cfg->verify_enabled)
-		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
-
+	ethtool_mmsv_set_mm(&priv->fpe_cfg.mmsv, cfg);
 	stmmac_fpe_set_add_frag_size(priv, frag_size);
-	stmmac_fpe_apply(priv);
-
-	spin_unlock_irqrestore(&fpe_cfg->lock, flags);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index 3a4bee029c7f..75b470ee621a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -27,12 +27,6 @@
 #define STMMAC_MAC_FPE_CTRL_STS_SVER	BIT(1)
 #define STMMAC_MAC_FPE_CTRL_STS_EFPE	BIT(0)
 
-/* FPE link-partner hand-shaking mPacket type */
-enum stmmac_mpacket_type {
-	MPACKET_VERIFY = 0,
-	MPACKET_RESPONSE = 1,
-};
-
 struct stmmac_fpe_reg {
 	const u32 mac_fpe_reg;		/* offset of MAC_FPE_CTRL_STS */
 	const u32 mtl_fpe_reg;		/* offset of MTL_FPE_CTRL_STS */
@@ -48,10 +42,10 @@ bool stmmac_fpe_supported(struct stmmac_priv *priv)
 		priv->hw->mac->fpe_map_preemption_class;
 }
 
-static void stmmac_fpe_configure(struct stmmac_priv *priv, bool tx_enable,
-				 bool pmac_enable)
+static void stmmac_fpe_configure_tx(struct ethtool_mmsv *mmsv, bool tx_enable)
 {
-	struct stmmac_fpe_cfg *cfg = &priv->fpe_cfg;
+	struct stmmac_fpe_cfg *cfg = container_of(mmsv, struct stmmac_fpe_cfg, mmsv);
+	struct stmmac_priv *priv = container_of(cfg, struct stmmac_priv, fpe_cfg);
 	const struct stmmac_fpe_reg *reg = cfg->reg;
 	u32 num_rxq = priv->plat->rx_queues_to_use;
 	void __iomem *ioaddr = priv->ioaddr;
@@ -68,6 +62,15 @@ static void stmmac_fpe_configure(struct stmmac_priv *priv, bool tx_enable,
 		cfg->fpe_csr = 0;
 	}
 	writel(cfg->fpe_csr, ioaddr + reg->mac_fpe_reg);
+}
+
+static void stmmac_fpe_configure_pmac(struct ethtool_mmsv *mmsv, bool pmac_enable)
+{
+	struct stmmac_fpe_cfg *cfg = container_of(mmsv, struct stmmac_fpe_cfg, mmsv);
+	struct stmmac_priv *priv = container_of(cfg, struct stmmac_priv, fpe_cfg);
+	const struct stmmac_fpe_reg *reg = cfg->reg;
+	void __iomem *ioaddr = priv->ioaddr;
+	u32 value;
 
 	value = readl(ioaddr + reg->int_en_reg);
 
@@ -85,47 +88,45 @@ static void stmmac_fpe_configure(struct stmmac_priv *priv, bool tx_enable,
 	writel(value, ioaddr + reg->int_en_reg);
 }
 
-static void stmmac_fpe_send_mpacket(struct stmmac_priv *priv,
-				    enum stmmac_mpacket_type type)
+static void stmmac_fpe_send_mpacket(struct ethtool_mmsv *mmsv,
+				    enum ethtool_mpacket type)
 {
-	const struct stmmac_fpe_reg *reg = priv->fpe_cfg.reg;
+	struct stmmac_fpe_cfg *cfg = container_of(mmsv, struct stmmac_fpe_cfg, mmsv);
+	struct stmmac_priv *priv = container_of(cfg, struct stmmac_priv, fpe_cfg);
+	const struct stmmac_fpe_reg *reg = cfg->reg;
 	void __iomem *ioaddr = priv->ioaddr;
-	u32 value = priv->fpe_cfg.fpe_csr;
+	u32 value = cfg->fpe_csr;
 
-	if (type == MPACKET_VERIFY)
+	if (type == ETHTOOL_MPACKET_VERIFY)
 		value |= STMMAC_MAC_FPE_CTRL_STS_SVER;
-	else if (type == MPACKET_RESPONSE)
+	else if (type == ETHTOOL_MPACKET_RESPONSE)
 		value |= STMMAC_MAC_FPE_CTRL_STS_SRSP;
 
 	writel(value, ioaddr + reg->mac_fpe_reg);
 }
 
+static const struct ethtool_mmsv_ops stmmac_mmsv_ops = {
+	.configure_tx = stmmac_fpe_configure_tx,
+	.configure_pmac = stmmac_fpe_configure_pmac,
+	.send_mpacket = stmmac_fpe_send_mpacket,
+};
+
 static void stmmac_fpe_event_status(struct stmmac_priv *priv, int status)
 {
 	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
+	struct ethtool_mmsv *mmsv = &fpe_cfg->mmsv;
 
-	/* This is interrupt context, just spin_lock() */
-	spin_lock(&fpe_cfg->lock);
-
-	if (!fpe_cfg->pmac_enabled || status == FPE_EVENT_UNKNOWN)
-		goto unlock_out;
+	if (status == FPE_EVENT_UNKNOWN)
+		return;
 
-	/* LP has sent verify mPacket */
 	if ((status & FPE_EVENT_RVER) == FPE_EVENT_RVER)
-		stmmac_fpe_send_mpacket(priv, MPACKET_RESPONSE);
+		ethtool_mmsv_event_handle(mmsv, ETHTOOL_MMSV_LP_SENT_VERIFY_MPACKET);
 
-	/* Local has sent verify mPacket */
-	if ((status & FPE_EVENT_TVER) == FPE_EVENT_TVER &&
-	    fpe_cfg->status != ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED)
-		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_VERIFYING;
+	if ((status & FPE_EVENT_TVER) == FPE_EVENT_TVER)
+		ethtool_mmsv_event_handle(mmsv, ETHTOOL_MMSV_LD_SENT_VERIFY_MPACKET);
 
-	/* LP has sent response mPacket */
-	if ((status & FPE_EVENT_RRSP) == FPE_EVENT_RRSP &&
-	    fpe_cfg->status == ETHTOOL_MM_VERIFY_STATUS_VERIFYING)
-		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
-
-unlock_out:
-	spin_unlock(&fpe_cfg->lock);
+	if ((status & FPE_EVENT_RRSP) == FPE_EVENT_RRSP)
+		ethtool_mmsv_event_handle(mmsv, ETHTOOL_MMSV_LP_SENT_RESPONSE_MPACKET);
 }
 
 void stmmac_fpe_irq_status(struct stmmac_priv *priv)
@@ -164,119 +165,16 @@ void stmmac_fpe_irq_status(struct stmmac_priv *priv)
 	stmmac_fpe_event_status(priv, status);
 }
 
-/**
- * stmmac_fpe_verify_timer - Timer for MAC Merge verification
- * @t:  timer_list struct containing private info
- *
- * Verify the MAC Merge capability in the local TX direction, by
- * transmitting Verify mPackets up to 3 times. Wait until link
- * partner responds with a Response mPacket, otherwise fail.
- */
-static void stmmac_fpe_verify_timer(struct timer_list *t)
-{
-	struct stmmac_fpe_cfg *fpe_cfg = from_timer(fpe_cfg, t, verify_timer);
-	struct stmmac_priv *priv = container_of(fpe_cfg, struct stmmac_priv,
-						fpe_cfg);
-	unsigned long flags;
-	bool rearm = false;
-
-	spin_lock_irqsave(&fpe_cfg->lock, flags);
-
-	switch (fpe_cfg->status) {
-	case ETHTOOL_MM_VERIFY_STATUS_INITIAL:
-	case ETHTOOL_MM_VERIFY_STATUS_VERIFYING:
-		if (fpe_cfg->verify_retries != 0) {
-			stmmac_fpe_send_mpacket(priv, MPACKET_VERIFY);
-			rearm = true;
-		} else {
-			fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
-		}
-
-		fpe_cfg->verify_retries--;
-		break;
-
-	case ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED:
-		stmmac_fpe_configure(priv, true, true);
-		break;
-
-	default:
-		break;
-	}
-
-	if (rearm) {
-		mod_timer(&fpe_cfg->verify_timer,
-			  jiffies + msecs_to_jiffies(fpe_cfg->verify_time));
-	}
-
-	spin_unlock_irqrestore(&fpe_cfg->lock, flags);
-}
-
-static void stmmac_fpe_verify_timer_arm(struct stmmac_fpe_cfg *fpe_cfg)
-{
-	if (fpe_cfg->pmac_enabled && fpe_cfg->tx_enabled &&
-	    fpe_cfg->verify_enabled &&
-	    fpe_cfg->status != ETHTOOL_MM_VERIFY_STATUS_FAILED &&
-	    fpe_cfg->status != ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED) {
-		timer_setup(&fpe_cfg->verify_timer, stmmac_fpe_verify_timer, 0);
-		mod_timer(&fpe_cfg->verify_timer, jiffies);
-	}
-}
-
 void stmmac_fpe_init(struct stmmac_priv *priv)
 {
-	priv->fpe_cfg.verify_retries = STMMAC_FPE_MM_MAX_VERIFY_RETRIES;
-	priv->fpe_cfg.verify_time = STMMAC_FPE_MM_MAX_VERIFY_TIME_MS;
-	priv->fpe_cfg.status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
-	timer_setup(&priv->fpe_cfg.verify_timer, stmmac_fpe_verify_timer, 0);
-	spin_lock_init(&priv->fpe_cfg.lock);
+	ethtool_mmsv_init(&priv->fpe_cfg.mmsv, priv->dev,
+			  &stmmac_mmsv_ops);
 
 	if ((!priv->fpe_cfg.reg || !priv->hw->mac->fpe_map_preemption_class) &&
 	    priv->dma_cap.fpesel)
 		dev_info(priv->device, "FPE is not supported by driver.\n");
 }
 
-void stmmac_fpe_apply(struct stmmac_priv *priv)
-{
-	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
-
-	/* If verification is disabled, configure FPE right away.
-	 * Otherwise let the timer code do it.
-	 */
-	if (!fpe_cfg->verify_enabled) {
-		stmmac_fpe_configure(priv, fpe_cfg->tx_enabled,
-				     fpe_cfg->pmac_enabled);
-	} else {
-		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
-		fpe_cfg->verify_retries = STMMAC_FPE_MM_MAX_VERIFY_RETRIES;
-
-		if (netif_running(priv->dev))
-			stmmac_fpe_verify_timer_arm(fpe_cfg);
-	}
-}
-
-void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
-{
-	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
-	unsigned long flags;
-
-	timer_shutdown_sync(&fpe_cfg->verify_timer);
-
-	spin_lock_irqsave(&fpe_cfg->lock, flags);
-
-	if (is_up && fpe_cfg->pmac_enabled) {
-		/* VERIFY process requires pmac enabled when NIC comes up */
-		stmmac_fpe_configure(priv, false, true);
-
-		/* New link => maybe new partner => new verification process */
-		stmmac_fpe_apply(priv);
-	} else {
-		/* No link => turn off EFPE */
-		stmmac_fpe_configure(priv, false, false);
-	}
-
-	spin_unlock_irqrestore(&fpe_cfg->lock, flags);
-}
-
 int stmmac_fpe_get_add_frag_size(struct stmmac_priv *priv)
 {
 	const struct stmmac_fpe_reg *reg = priv->fpe_cfg.reg;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
index b884eac7142d..3fc46acf7001 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
@@ -9,15 +9,10 @@
 #include <linux/types.h>
 #include <linux/netdevice.h>
 
-#define STMMAC_FPE_MM_MAX_VERIFY_RETRIES	3
-#define STMMAC_FPE_MM_MAX_VERIFY_TIME_MS	128
-
 struct stmmac_priv;
 
-void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up);
 bool stmmac_fpe_supported(struct stmmac_priv *priv);
 void stmmac_fpe_init(struct stmmac_priv *priv);
-void stmmac_fpe_apply(struct stmmac_priv *priv);
 void stmmac_fpe_irq_status(struct stmmac_priv *priv);
 int stmmac_fpe_get_add_frag_size(struct stmmac_priv *priv);
 void stmmac_fpe_set_add_frag_size(struct stmmac_priv *priv, u32 add_frag_size);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d04543e5697b..8f723f9e84ba 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -992,7 +992,7 @@ static void stmmac_mac_link_down(struct phylink_config *config,
 		stmmac_set_eee_pls(priv, priv->hw, false);
 
 	if (stmmac_fpe_supported(priv))
-		stmmac_fpe_link_state_handle(priv, false);
+		ethtool_mmsv_link_state_handle(&priv->fpe_cfg.mmsv, false);
 }
 
 static void stmmac_mac_link_up(struct phylink_config *config,
@@ -1100,7 +1100,7 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 		stmmac_set_eee_pls(priv, priv->hw, true);
 
 	if (stmmac_fpe_supported(priv))
-		stmmac_fpe_link_state_handle(priv, true);
+		ethtool_mmsv_link_state_handle(&priv->fpe_cfg.mmsv, true);
 
 	if (priv->plat->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
 		stmmac_hwtstamp_correct_latency(priv, priv);
@@ -4097,7 +4097,7 @@ static int stmmac_release(struct net_device *dev)
 	stmmac_release_ptp(priv);
 
 	if (stmmac_fpe_supported(priv))
-		timer_shutdown_sync(&priv->fpe_cfg.verify_timer);
+		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
 
 	pm_runtime_put(priv->device);
 
@@ -7822,7 +7822,7 @@ int stmmac_suspend(struct device *dev)
 	rtnl_unlock();
 
 	if (stmmac_fpe_supported(priv))
-		timer_shutdown_sync(&priv->fpe_cfg.verify_timer);
+		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
 
 	priv->speed = SPEED_UNKNOWN;
 	return 0;
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 870994cc3ef7..8023fb18dd91 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -17,9 +17,13 @@
 #include <linux/compat.h>
 #include <linux/if_ether.h>
 #include <linux/netlink.h>
+#include <linux/timer_types.h>
 #include <uapi/linux/ethtool.h>
 #include <uapi/linux/net_tstamp.h>
 
+#define ETHTOOL_MM_MAX_VERIFY_TIME_MS		128
+#define ETHTOOL_MM_MAX_VERIFY_RETRIES		3
+
 struct compat_ethtool_rx_flow_spec {
 	u32		flow_type;
 	union ethtool_flow_union h_u;
@@ -710,6 +714,133 @@ struct ethtool_mm_stats {
 	u64 MACMergeHoldCount;
 };
 
+enum ethtool_mmsv_event {
+	ETHTOOL_MMSV_LP_SENT_VERIFY_MPACKET,
+	ETHTOOL_MMSV_LD_SENT_VERIFY_MPACKET,
+	ETHTOOL_MMSV_LP_SENT_RESPONSE_MPACKET,
+};
+
+/* MAC Merge verification mPacket type */
+enum ethtool_mpacket {
+	ETHTOOL_MPACKET_VERIFY,
+	ETHTOOL_MPACKET_RESPONSE,
+};
+
+struct ethtool_mmsv;
+
+/**
+ * struct ethtool_mmsv_ops - Operations for MAC Merge Software Verification
+ * @configure_tx: Driver callback for the event where the preemptible TX
+ *		  becomes active or inactive. Preemptible traffic
+ *		  classes must be committed to hardware only while
+ *		  preemptible TX is active.
+ * @configure_pmac: Driver callback for the event where the pMAC state
+ *		    changes as result of an administrative setting
+ *		    (ethtool) or a call to ethtool_mmsv_link_state_handle().
+ * @send_mpacket: Driver-provided method for sending a Verify or a Response
+ *		  mPacket.
+ */
+struct ethtool_mmsv_ops {
+	void (*configure_tx)(struct ethtool_mmsv *mmsv, bool tx_active);
+	void (*configure_pmac)(struct ethtool_mmsv *mmsv, bool pmac_enabled);
+	void (*send_mpacket)(struct ethtool_mmsv *mmsv, enum ethtool_mpacket mpacket);
+};
+
+/**
+ * struct ethtool_mmsv - MAC Merge Software Verification
+ * @ops: operations for MAC Merge Software Verification
+ * @dev: pointer to net_device structure
+ * @lock: serialize access to MAC Merge state between
+ *	  ethtool requests and link state updates.
+ * @status: current verification FSM state
+ * @verify_timer: timer for verification in local TX direction
+ * @verify_enabled: indicates if verification is enabled
+ * @verify_retries: number of retries for verification
+ * @pmac_enabled: indicates if the preemptible MAC is enabled
+ * @verify_time: time for verification in milliseconds
+ * @tx_enabled: indicates if transmission is enabled
+ */
+struct ethtool_mmsv {
+	const struct ethtool_mmsv_ops *ops;
+	struct net_device *dev;
+	spinlock_t lock;
+	enum ethtool_mm_verify_status status;
+	struct timer_list verify_timer;
+	bool verify_enabled;
+	int verify_retries;
+	bool pmac_enabled;
+	u32 verify_time;
+	bool tx_enabled;
+};
+
+/**
+ * ethtool_mmsv_stop() - Stop MAC Merge Software Verification
+ * @mmsv: MAC Merge Software Verification state
+ *
+ * Drivers should call this method in a state where the hardware is
+ * about to lose state, like ndo_stop() or suspend(), and turning off
+ * MAC Merge features would be superfluous. Otherwise, prefer
+ * ethtool_mmsv_link_state_handle() with up=false.
+ */
+void ethtool_mmsv_stop(struct ethtool_mmsv *mmsv);
+
+/**
+ * ethtool_mmsv_link_state_handle() - Inform MAC Merge Software Verification
+ *				      of link state changes
+ * @mmsv: MAC Merge Software Verification state
+ * @up: True if device carrier is up and able to pass verification packets
+ *
+ * Calling context is expected to be from a thread, interrupts enabled.
+ */
+void ethtool_mmsv_link_state_handle(struct ethtool_mmsv *mmsv, bool up);
+
+/**
+ * ethtool_mmsv_event_handle() - Inform MAC Merge Software Verification
+ *				 of interrupt-based events
+ * @mmsv: MAC Merge Software Verification state
+ * @event: Event which took place (packet transmission or reception)
+ *
+ * Calling context expects to have interrupts disabled.
+ */
+void ethtool_mmsv_event_handle(struct ethtool_mmsv *mmsv,
+			       enum ethtool_mmsv_event event);
+
+/**
+ * ethtool_mmsv_get_mm() - get_mm() hook for MAC Merge Software Verification
+ * @mmsv: MAC Merge Software Verification state
+ * @state: see struct ethtool_mm_state
+ *
+ * Drivers are expected to call this from their ethtool_ops :: get_mm()
+ * method.
+ */
+void ethtool_mmsv_get_mm(struct ethtool_mmsv *mmsv,
+			 struct ethtool_mm_state *state);
+
+/**
+ * ethtool_mmsv_set_mm() - set_mm() hook for MAC Merge Software Verification
+ * @mmsv: MAC Merge Software Verification state
+ * @cfg: see struct ethtool_mm_cfg
+ *
+ * Drivers are expected to call this from their ethtool_ops :: set_mm()
+ * method.
+ */
+void ethtool_mmsv_set_mm(struct ethtool_mmsv *mmsv, struct ethtool_mm_cfg *cfg);
+
+/**
+ * ethtool_mmsv_init() - Initialize MAC Merge Software Verification state
+ * @mmsv: MAC Merge Software Verification state
+ * @dev: Pointer to network interface
+ * @ops: Methods for implementing the generic functionality
+ *
+ * The MAC Merge Software Verification is a timer- and event-based state
+ * machine intended for network interfaces which lack a hardware-based
+ * TX verification process (as per IEEE 802.3 clause 99.4.3). The timer
+ * is managed by the core code, whereas events are supplied by the
+ * driver explicitly calling one of the other API functions.
+ */
+void ethtool_mmsv_init(struct ethtool_mmsv *mmsv, struct net_device *dev,
+		       const struct ethtool_mmsv_ops *ops);
+
 /**
  * struct ethtool_rxfh_param - RXFH (RSS) parameters
  * @hfunc: Defines the current RSS hash function used by HW (or to be set to).
diff --git a/net/ethtool/mm.c b/net/ethtool/mm.c
index 2816bb23c3ad..7b2a75f94800 100644
--- a/net/ethtool/mm.c
+++ b/net/ethtool/mm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright 2022-2023 NXP
+ * Copyright 2022-2025 NXP
+ * Copyright 2024 Furong Xu <0x1207@gmail.com>
  */
 #include "common.h"
 #include "netlink.h"
@@ -282,3 +283,225 @@ bool ethtool_dev_mm_supported(struct net_device *dev)
 	return supported;
 }
 EXPORT_SYMBOL_GPL(ethtool_dev_mm_supported);
+
+static void ethtool_mmsv_configure_tx(struct ethtool_mmsv *mmsv,
+				      bool tx_active)
+{
+	if (mmsv->ops->configure_tx)
+		mmsv->ops->configure_tx(mmsv, tx_active);
+}
+
+static void ethtool_mmsv_configure_pmac(struct ethtool_mmsv *mmsv,
+					bool pmac_enabled)
+{
+	if (mmsv->ops->configure_pmac)
+		mmsv->ops->configure_pmac(mmsv, pmac_enabled);
+}
+
+static void ethtool_mmsv_send_mpacket(struct ethtool_mmsv *mmsv,
+				      enum ethtool_mpacket mpacket)
+{
+	if (mmsv->ops->send_mpacket)
+		mmsv->ops->send_mpacket(mmsv, mpacket);
+}
+
+/**
+ * ethtool_mmsv_verify_timer - Timer for MAC Merge verification
+ * @t: timer_list struct containing private info
+ *
+ * Verify the MAC Merge capability in the local TX direction, by
+ * transmitting Verify mPackets up to 3 times. Wait until link
+ * partner responds with a Response mPacket, otherwise fail.
+ */
+static void ethtool_mmsv_verify_timer(struct timer_list *t)
+{
+	struct ethtool_mmsv *mmsv = from_timer(mmsv, t, verify_timer);
+	unsigned long flags;
+	bool rearm = false;
+
+	spin_lock_irqsave(&mmsv->lock, flags);
+
+	switch (mmsv->status) {
+	case ETHTOOL_MM_VERIFY_STATUS_INITIAL:
+	case ETHTOOL_MM_VERIFY_STATUS_VERIFYING:
+		if (mmsv->verify_retries != 0) {
+			ethtool_mmsv_send_mpacket(mmsv, ETHTOOL_MPACKET_VERIFY);
+			rearm = true;
+		} else {
+			mmsv->status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
+		}
+
+		mmsv->verify_retries--;
+		break;
+
+	case ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED:
+		ethtool_mmsv_configure_tx(mmsv, true);
+		break;
+
+	default:
+		break;
+	}
+
+	if (rearm) {
+		mod_timer(&mmsv->verify_timer,
+			  jiffies + msecs_to_jiffies(mmsv->verify_time));
+	}
+
+	spin_unlock_irqrestore(&mmsv->lock, flags);
+}
+
+static void ethtool_mmsv_verify_timer_arm(struct ethtool_mmsv *mmsv)
+{
+	if (mmsv->pmac_enabled && mmsv->tx_enabled && mmsv->verify_enabled &&
+	    mmsv->status != ETHTOOL_MM_VERIFY_STATUS_FAILED &&
+	    mmsv->status != ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED) {
+		timer_setup(&mmsv->verify_timer, ethtool_mmsv_verify_timer, 0);
+		mod_timer(&mmsv->verify_timer, jiffies);
+	}
+}
+
+static void ethtool_mmsv_apply(struct ethtool_mmsv *mmsv)
+{
+	/* If verification is disabled, configure FPE right away.
+	 * Otherwise let the timer code do it.
+	 */
+	if (!mmsv->verify_enabled) {
+		ethtool_mmsv_configure_pmac(mmsv, mmsv->pmac_enabled);
+		ethtool_mmsv_configure_tx(mmsv, mmsv->tx_enabled);
+	} else {
+		mmsv->status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
+		mmsv->verify_retries = ETHTOOL_MM_MAX_VERIFY_RETRIES;
+
+		if (netif_running(mmsv->dev))
+			ethtool_mmsv_verify_timer_arm(mmsv);
+	}
+}
+
+void ethtool_mmsv_stop(struct ethtool_mmsv *mmsv)
+{
+	timer_shutdown_sync(&mmsv->verify_timer);
+}
+EXPORT_SYMBOL_GPL(ethtool_mmsv_stop);
+
+void ethtool_mmsv_link_state_handle(struct ethtool_mmsv *mmsv, bool up)
+{
+	unsigned long flags;
+
+	ethtool_mmsv_stop(mmsv);
+
+	spin_lock_irqsave(&mmsv->lock, flags);
+
+	if (up && mmsv->pmac_enabled) {
+		/* VERIFY process requires pMAC enabled when NIC comes up */
+		ethtool_mmsv_configure_pmac(mmsv, true);
+
+		/* New link => maybe new partner => new verification process */
+		ethtool_mmsv_apply(mmsv);
+	} else {
+		mmsv->status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
+		mmsv->verify_retries = ETHTOOL_MM_MAX_VERIFY_RETRIES;
+
+		/* No link or pMAC not enabled */
+		ethtool_mmsv_configure_pmac(mmsv, false);
+		ethtool_mmsv_configure_tx(mmsv, false);
+	}
+
+	spin_unlock_irqrestore(&mmsv->lock, flags);
+}
+EXPORT_SYMBOL_GPL(ethtool_mmsv_link_state_handle);
+
+void ethtool_mmsv_event_handle(struct ethtool_mmsv *mmsv,
+			       enum ethtool_mmsv_event event)
+{
+	/* This is interrupt context, just spin_lock() */
+	spin_lock(&mmsv->lock);
+
+	if (!mmsv->pmac_enabled)
+		goto unlock;
+
+	switch (event) {
+	case ETHTOOL_MMSV_LP_SENT_VERIFY_MPACKET:
+		/* Link partner has sent verify mPacket */
+		ethtool_mmsv_send_mpacket(mmsv, ETHTOOL_MPACKET_RESPONSE);
+		break;
+	case ETHTOOL_MMSV_LD_SENT_VERIFY_MPACKET:
+		/* Local device has sent verify mPacket */
+		if (mmsv->status != ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED)
+			mmsv->status = ETHTOOL_MM_VERIFY_STATUS_VERIFYING;
+		break;
+	case ETHTOOL_MMSV_LP_SENT_RESPONSE_MPACKET:
+		/* Link partner has sent response mPacket */
+		if (mmsv->status == ETHTOOL_MM_VERIFY_STATUS_VERIFYING)
+			mmsv->status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
+		break;
+	}
+
+unlock:
+	spin_unlock(&mmsv->lock);
+}
+EXPORT_SYMBOL_GPL(ethtool_mmsv_event_handle);
+
+static bool ethtool_mmsv_is_tx_active(struct ethtool_mmsv *mmsv)
+{
+	/* TX is active if administratively enabled, and verification either
+	 * succeeded, or was administratively disabled.
+	 */
+	return mmsv->tx_enabled &&
+	       (mmsv->status == ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
+	       mmsv->status == ETHTOOL_MM_VERIFY_STATUS_DISABLED);
+}
+
+void ethtool_mmsv_get_mm(struct ethtool_mmsv *mmsv,
+			 struct ethtool_mm_state *state)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&mmsv->lock, flags);
+
+	state->max_verify_time = ETHTOOL_MM_MAX_VERIFY_TIME_MS;
+	state->verify_enabled = mmsv->verify_enabled;
+	state->pmac_enabled = mmsv->pmac_enabled;
+	state->verify_time = mmsv->verify_time;
+	state->tx_enabled = mmsv->tx_enabled;
+	state->verify_status = mmsv->status;
+	state->tx_active = ethtool_mmsv_is_tx_active(mmsv);
+
+	spin_unlock_irqrestore(&mmsv->lock, flags);
+}
+EXPORT_SYMBOL_GPL(ethtool_mmsv_get_mm);
+
+void ethtool_mmsv_set_mm(struct ethtool_mmsv *mmsv, struct ethtool_mm_cfg *cfg)
+{
+	unsigned long flags;
+
+	/* Wait for the verification that's currently in progress to finish */
+	ethtool_mmsv_stop(mmsv);
+
+	spin_lock_irqsave(&mmsv->lock, flags);
+
+	mmsv->verify_enabled = cfg->verify_enabled;
+	mmsv->pmac_enabled = cfg->pmac_enabled;
+	mmsv->verify_time = cfg->verify_time;
+	mmsv->tx_enabled = cfg->tx_enabled;
+
+	if (!cfg->verify_enabled)
+		mmsv->status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
+
+	ethtool_mmsv_apply(mmsv);
+
+	spin_unlock_irqrestore(&mmsv->lock, flags);
+}
+EXPORT_SYMBOL_GPL(ethtool_mmsv_set_mm);
+
+void ethtool_mmsv_init(struct ethtool_mmsv *mmsv, struct net_device *dev,
+		       const struct ethtool_mmsv_ops *ops)
+{
+	mmsv->ops = ops;
+	mmsv->dev = dev;
+	mmsv->verify_retries = ETHTOOL_MM_MAX_VERIFY_RETRIES;
+	mmsv->verify_time = ETHTOOL_MM_MAX_VERIFY_TIME_MS;
+	mmsv->status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
+	timer_setup(&mmsv->verify_timer, ethtool_mmsv_verify_timer, 0);
+	spin_lock_init(&mmsv->lock);
+}
+EXPORT_SYMBOL_GPL(ethtool_mmsv_init);
-- 
2.34.1


