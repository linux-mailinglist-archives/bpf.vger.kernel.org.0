Return-Path: <bpf+bounces-53206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9D4A4E6DC
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 17:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF06C7AAB2C
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 16:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7E0299B2D;
	Tue,  4 Mar 2025 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hoPyxXzr"
X-Original-To: bpf@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CA4294EE6
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105709; cv=fail; b=Pj03wUjI1CLQ5+yFcqHhRnpPxNXucQ8OywGTDZFggfybugqUsRdHjy9ZXyC7MvxyLvTxy3e/6cuGB9x7fIB9dQ2M9Pq0EHOL4x3n92BuW0Zs8EyzrNpr761lbDIdYGFQ6ojNQLiDgMd5iJFi5gXLYkyGnFYI5uqwULnI/XRS2Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105709; c=relaxed/simple;
	bh=H2thA976Tc+PQgL3bOmw5QzvJNevMB8OLdbyZHCj17E=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GnX6Na1HlYAmkip3G4XF2TASvhbRukvr8mKuRHyvEf1T4feLVoU7Re98DQ+85mXCv+KGbjctSEs6XBqmcGlDUpT3sZNGLJUrHj3sXU/X6anIrHuqOPZdEMrwsn292QWDrr5FTVFa0fVgy+nCQe9rn0XJDaYKht7RxH81CRicsEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hoPyxXzr reason="signature verification failed"; arc=none smtp.client-ip=198.175.65.9; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 0586A408B659
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 19:28:24 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6h012RGfzG3KX
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 19:26:41 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id EA08C42722; Tue,  4 Mar 2025 19:26:39 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hoPyxXzr
X-Envelope-From: <linux-kernel+bounces-541367-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hoPyxXzr
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id D26FD43556
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:28:42 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 69D022DCE0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:28:42 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D080D16CEAF
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263191F3BB2;
	Mon,  3 Mar 2025 10:27:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D9BA94A;
	Mon,  3 Mar 2025 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997662; cv=none; b=ILxWng6eN3B0FziMcHzEJIQ3QA3HAMZKfud+EOQzwHgYdJOyHYPsVzPd4qTJACOkUbYJdUqkTDAdJYCyf9A7SxQZ444Kk5OuXzJIrg7M7SEoWvHLPucCTw5wt5wQ4UZoNtLez2p9JVJZ3ogch+OYowxKMGLK+uTZeJ7LfPf92DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997662; c=relaxed/simple;
	bh=zqdHhFjj5+k7uI0KA3AtQEAxOad+rBp0eb0gLY4j5TQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i6VQo2OqTu2TmE5QhTyzZFHEfBbvMQYsK9j7vEf2qnceR+QQ3edT1iY5dhymsrtC3pZrQK0zKaddGxAX1RQOzCbRCl7RDLOBwFueLsCEMzoVe4KkvRxxjPweWT2wW/N+gvOseSzhdwlXhHyXoflnrzhJCQyRIFOcRM/XYtMOisU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hoPyxXzr; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740997660; x=1772533660;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=zqdHhFjj5+k7uI0KA3AtQEAxOad+rBp0eb0gLY4j5TQ=;
  b=hoPyxXzr4wqNOmLSvqVLGr9FpYD8b+o9trLtIJRbcwmfEBk5OdyxXWcg
   XfW1i6cL+MBoiqKmNOiaJTIS09mvvT29QTT3P+cGlw6Ctvsd0KPpeXbsX
   58x6xCuFpXkWfWdODkzuVcgFDwHxLozp4ULGRKZl33OD3hKWqzdHpOjjK
   trR1H6HzOhPmNMSBDIQkI1QWT2qgg8mJeGiw2g6qbhFPV0Kv1FwiB2s5+
   u1CFJm50qLa4aRkaEG+vIjUtJOclhiwWPztd1GvFnubloLO6az1Hfs8J3
   FUfXgK1+tJ9IQRXy+TzyZkzhUUiZJOihXrgXWdNuHMdPMWHWgM63KMCU2
   g==;
X-CSE-ConnectionGUID: H0lh7GqyRlKqHzIMG1ScNw==
X-CSE-MsgGUID: zc3ezK6LRb6DhvQ4WdYv+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="64310064"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="64310064"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 02:27:38 -0800
X-CSE-ConnectionGUID: mHMRyzQPQWOUMOws8mqpEA==
X-CSE-MsgGUID: DnuPBVS7T16Z7A32tLrKlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="122569862"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by fmviesa005.fm.intel.com with ESMTP; 03 Mar 2025 02:27:31 -0800
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
Subject: [PATCH iwl-next v7 1/9] net: ethtool: mm: extract stmmac verification logic into common library
Date: Mon,  3 Mar 2025 05:26:50 -0500
Message-Id: <20250303102658.3580232-2-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303102658.3580232-1-faizal.abdul.rahim@linux.intel.com>
References: <20250303102658.3580232-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6h012RGfzG3KX
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741710411.74403@NUvHhqEctwEgMZGOC71tIA
X-ITU-MailScanner-SpamCheck: not spam

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
Tested-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  16 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  41 +--
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 174 +++--------
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  |   5 -
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   8 +-
 include/linux/ethtool.h                       |  73 +++++
 net/ethtool/mm.c                              | 279 +++++++++++++++++-
 7 files changed, 395 insertions(+), 201 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/e=
thernet/stmicro/stmmac/stmmac.h
index f05cae103d83..c9cc41af258a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -147,21 +147,9 @@ struct stmmac_channel {
 };
=20
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
=20
 struct stmmac_tc_entry {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drive=
rs/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 918a32f8fda8..25533d6a3175 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -1210,37 +1210,17 @@ static int stmmac_get_mm(struct net_device *ndev,
 			 struct ethtool_mm_state *state)
 {
 	struct stmmac_priv *priv =3D netdev_priv(ndev);
-	unsigned long flags;
 	u32 frag_size;
=20
 	if (!stmmac_fpe_supported(priv))
 		return -EOPNOTSUPP;
=20
-	spin_lock_irqsave(&priv->fpe_cfg.lock, flags);
+	ethtool_mmsv_get_mm(&priv->fpe_cfg.mmsv, state);
=20
-	state->max_verify_time =3D STMMAC_FPE_MM_MAX_VERIFY_TIME_MS;
-	state->verify_enabled =3D priv->fpe_cfg.verify_enabled;
-	state->pmac_enabled =3D priv->fpe_cfg.pmac_enabled;
-	state->verify_time =3D priv->fpe_cfg.verify_time;
-	state->tx_enabled =3D priv->fpe_cfg.tx_enabled;
-	state->verify_status =3D priv->fpe_cfg.status;
 	state->rx_min_frag_size =3D ETH_ZLEN;
-
-	/* FPE active if common tx_enabled and
-	 * (verification success or disabled(forced))
-	 */
-	if (state->tx_enabled &&
-	    (state->verify_status =3D=3D ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
-	     state->verify_status =3D=3D ETHTOOL_MM_VERIFY_STATUS_DISABLED))
-		state->tx_active =3D true;
-	else
-		state->tx_active =3D false;
-
 	frag_size =3D stmmac_fpe_get_add_frag_size(priv);
 	state->tx_min_frag_size =3D ethtool_mm_frag_size_add_to_min(frag_size);
=20
-	spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
-
 	return 0;
 }
=20
@@ -1248,8 +1228,6 @@ static int stmmac_set_mm(struct net_device *ndev, s=
truct ethtool_mm_cfg *cfg,
 			 struct netlink_ext_ack *extack)
 {
 	struct stmmac_priv *priv =3D netdev_priv(ndev);
-	struct stmmac_fpe_cfg *fpe_cfg =3D &priv->fpe_cfg;
-	unsigned long flags;
 	u32 frag_size;
 	int err;
=20
@@ -1258,23 +1236,8 @@ static int stmmac_set_mm(struct net_device *ndev, =
struct ethtool_mm_cfg *cfg,
 	if (err)
 		return err;
=20
-	/* Wait for the verification that's currently in progress to finish */
-	timer_shutdown_sync(&fpe_cfg->verify_timer);
-
-	spin_lock_irqsave(&fpe_cfg->lock, flags);
-
-	fpe_cfg->verify_enabled =3D cfg->verify_enabled;
-	fpe_cfg->pmac_enabled =3D cfg->pmac_enabled;
-	fpe_cfg->verify_time =3D cfg->verify_time;
-	fpe_cfg->tx_enabled =3D cfg->tx_enabled;
-
-	if (!cfg->verify_enabled)
-		fpe_cfg->status =3D ETHTOOL_MM_VERIFY_STATUS_DISABLED;
-
 	stmmac_fpe_set_add_frag_size(priv, frag_size);
-	stmmac_fpe_apply(priv);
-
-	spin_unlock_irqrestore(&fpe_cfg->lock, flags);
+	ethtool_mmsv_set_mm(&priv->fpe_cfg.mmsv, cfg);
=20
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/n=
et/ethernet/stmicro/stmmac/stmmac_fpe.c
index 3a4bee029c7f..75b470ee621a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -27,12 +27,6 @@
 #define STMMAC_MAC_FPE_CTRL_STS_SVER	BIT(1)
 #define STMMAC_MAC_FPE_CTRL_STS_EFPE	BIT(0)
=20
-/* FPE link-partner hand-shaking mPacket type */
-enum stmmac_mpacket_type {
-	MPACKET_VERIFY =3D 0,
-	MPACKET_RESPONSE =3D 1,
-};
-
 struct stmmac_fpe_reg {
 	const u32 mac_fpe_reg;		/* offset of MAC_FPE_CTRL_STS */
 	const u32 mtl_fpe_reg;		/* offset of MTL_FPE_CTRL_STS */
@@ -48,10 +42,10 @@ bool stmmac_fpe_supported(struct stmmac_priv *priv)
 		priv->hw->mac->fpe_map_preemption_class;
 }
=20
-static void stmmac_fpe_configure(struct stmmac_priv *priv, bool tx_enabl=
e,
-				 bool pmac_enable)
+static void stmmac_fpe_configure_tx(struct ethtool_mmsv *mmsv, bool tx_e=
nable)
 {
-	struct stmmac_fpe_cfg *cfg =3D &priv->fpe_cfg;
+	struct stmmac_fpe_cfg *cfg =3D container_of(mmsv, struct stmmac_fpe_cfg=
, mmsv);
+	struct stmmac_priv *priv =3D container_of(cfg, struct stmmac_priv, fpe_=
cfg);
 	const struct stmmac_fpe_reg *reg =3D cfg->reg;
 	u32 num_rxq =3D priv->plat->rx_queues_to_use;
 	void __iomem *ioaddr =3D priv->ioaddr;
@@ -68,6 +62,15 @@ static void stmmac_fpe_configure(struct stmmac_priv *p=
riv, bool tx_enable,
 		cfg->fpe_csr =3D 0;
 	}
 	writel(cfg->fpe_csr, ioaddr + reg->mac_fpe_reg);
+}
+
+static void stmmac_fpe_configure_pmac(struct ethtool_mmsv *mmsv, bool pm=
ac_enable)
+{
+	struct stmmac_fpe_cfg *cfg =3D container_of(mmsv, struct stmmac_fpe_cfg=
, mmsv);
+	struct stmmac_priv *priv =3D container_of(cfg, struct stmmac_priv, fpe_=
cfg);
+	const struct stmmac_fpe_reg *reg =3D cfg->reg;
+	void __iomem *ioaddr =3D priv->ioaddr;
+	u32 value;
=20
 	value =3D readl(ioaddr + reg->int_en_reg);
=20
@@ -85,47 +88,45 @@ static void stmmac_fpe_configure(struct stmmac_priv *=
priv, bool tx_enable,
 	writel(value, ioaddr + reg->int_en_reg);
 }
=20
-static void stmmac_fpe_send_mpacket(struct stmmac_priv *priv,
-				    enum stmmac_mpacket_type type)
+static void stmmac_fpe_send_mpacket(struct ethtool_mmsv *mmsv,
+				    enum ethtool_mpacket type)
 {
-	const struct stmmac_fpe_reg *reg =3D priv->fpe_cfg.reg;
+	struct stmmac_fpe_cfg *cfg =3D container_of(mmsv, struct stmmac_fpe_cfg=
, mmsv);
+	struct stmmac_priv *priv =3D container_of(cfg, struct stmmac_priv, fpe_=
cfg);
+	const struct stmmac_fpe_reg *reg =3D cfg->reg;
 	void __iomem *ioaddr =3D priv->ioaddr;
-	u32 value =3D priv->fpe_cfg.fpe_csr;
+	u32 value =3D cfg->fpe_csr;
=20
-	if (type =3D=3D MPACKET_VERIFY)
+	if (type =3D=3D ETHTOOL_MPACKET_VERIFY)
 		value |=3D STMMAC_MAC_FPE_CTRL_STS_SVER;
-	else if (type =3D=3D MPACKET_RESPONSE)
+	else if (type =3D=3D ETHTOOL_MPACKET_RESPONSE)
 		value |=3D STMMAC_MAC_FPE_CTRL_STS_SRSP;
=20
 	writel(value, ioaddr + reg->mac_fpe_reg);
 }
=20
+static const struct ethtool_mmsv_ops stmmac_mmsv_ops =3D {
+	.configure_tx =3D stmmac_fpe_configure_tx,
+	.configure_pmac =3D stmmac_fpe_configure_pmac,
+	.send_mpacket =3D stmmac_fpe_send_mpacket,
+};
+
 static void stmmac_fpe_event_status(struct stmmac_priv *priv, int status=
)
 {
 	struct stmmac_fpe_cfg *fpe_cfg =3D &priv->fpe_cfg;
+	struct ethtool_mmsv *mmsv =3D &fpe_cfg->mmsv;
=20
-	/* This is interrupt context, just spin_lock() */
-	spin_lock(&fpe_cfg->lock);
-
-	if (!fpe_cfg->pmac_enabled || status =3D=3D FPE_EVENT_UNKNOWN)
-		goto unlock_out;
+	if (status =3D=3D FPE_EVENT_UNKNOWN)
+		return;
=20
-	/* LP has sent verify mPacket */
 	if ((status & FPE_EVENT_RVER) =3D=3D FPE_EVENT_RVER)
-		stmmac_fpe_send_mpacket(priv, MPACKET_RESPONSE);
+		ethtool_mmsv_event_handle(mmsv, ETHTOOL_MMSV_LP_SENT_VERIFY_MPACKET);
=20
-	/* Local has sent verify mPacket */
-	if ((status & FPE_EVENT_TVER) =3D=3D FPE_EVENT_TVER &&
-	    fpe_cfg->status !=3D ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED)
-		fpe_cfg->status =3D ETHTOOL_MM_VERIFY_STATUS_VERIFYING;
+	if ((status & FPE_EVENT_TVER) =3D=3D FPE_EVENT_TVER)
+		ethtool_mmsv_event_handle(mmsv, ETHTOOL_MMSV_LD_SENT_VERIFY_MPACKET);
=20
-	/* LP has sent response mPacket */
-	if ((status & FPE_EVENT_RRSP) =3D=3D FPE_EVENT_RRSP &&
-	    fpe_cfg->status =3D=3D ETHTOOL_MM_VERIFY_STATUS_VERIFYING)
-		fpe_cfg->status =3D ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
-
-unlock_out:
-	spin_unlock(&fpe_cfg->lock);
+	if ((status & FPE_EVENT_RRSP) =3D=3D FPE_EVENT_RRSP)
+		ethtool_mmsv_event_handle(mmsv, ETHTOOL_MMSV_LP_SENT_RESPONSE_MPACKET)=
;
 }
=20
 void stmmac_fpe_irq_status(struct stmmac_priv *priv)
@@ -164,119 +165,16 @@ void stmmac_fpe_irq_status(struct stmmac_priv *pri=
v)
 	stmmac_fpe_event_status(priv, status);
 }
=20
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
-	struct stmmac_fpe_cfg *fpe_cfg =3D from_timer(fpe_cfg, t, verify_timer)=
;
-	struct stmmac_priv *priv =3D container_of(fpe_cfg, struct stmmac_priv,
-						fpe_cfg);
-	unsigned long flags;
-	bool rearm =3D false;
-
-	spin_lock_irqsave(&fpe_cfg->lock, flags);
-
-	switch (fpe_cfg->status) {
-	case ETHTOOL_MM_VERIFY_STATUS_INITIAL:
-	case ETHTOOL_MM_VERIFY_STATUS_VERIFYING:
-		if (fpe_cfg->verify_retries !=3D 0) {
-			stmmac_fpe_send_mpacket(priv, MPACKET_VERIFY);
-			rearm =3D true;
-		} else {
-			fpe_cfg->status =3D ETHTOOL_MM_VERIFY_STATUS_FAILED;
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
-	    fpe_cfg->status !=3D ETHTOOL_MM_VERIFY_STATUS_FAILED &&
-	    fpe_cfg->status !=3D ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED) {
-		timer_setup(&fpe_cfg->verify_timer, stmmac_fpe_verify_timer, 0);
-		mod_timer(&fpe_cfg->verify_timer, jiffies);
-	}
-}
-
 void stmmac_fpe_init(struct stmmac_priv *priv)
 {
-	priv->fpe_cfg.verify_retries =3D STMMAC_FPE_MM_MAX_VERIFY_RETRIES;
-	priv->fpe_cfg.verify_time =3D STMMAC_FPE_MM_MAX_VERIFY_TIME_MS;
-	priv->fpe_cfg.status =3D ETHTOOL_MM_VERIFY_STATUS_DISABLED;
-	timer_setup(&priv->fpe_cfg.verify_timer, stmmac_fpe_verify_timer, 0);
-	spin_lock_init(&priv->fpe_cfg.lock);
+	ethtool_mmsv_init(&priv->fpe_cfg.mmsv, priv->dev,
+			  &stmmac_mmsv_ops);
=20
 	if ((!priv->fpe_cfg.reg || !priv->hw->mac->fpe_map_preemption_class) &&
 	    priv->dma_cap.fpesel)
 		dev_info(priv->device, "FPE is not supported by driver.\n");
 }
=20
-void stmmac_fpe_apply(struct stmmac_priv *priv)
-{
-	struct stmmac_fpe_cfg *fpe_cfg =3D &priv->fpe_cfg;
-
-	/* If verification is disabled, configure FPE right away.
-	 * Otherwise let the timer code do it.
-	 */
-	if (!fpe_cfg->verify_enabled) {
-		stmmac_fpe_configure(priv, fpe_cfg->tx_enabled,
-				     fpe_cfg->pmac_enabled);
-	} else {
-		fpe_cfg->status =3D ETHTOOL_MM_VERIFY_STATUS_INITIAL;
-		fpe_cfg->verify_retries =3D STMMAC_FPE_MM_MAX_VERIFY_RETRIES;
-
-		if (netif_running(priv->dev))
-			stmmac_fpe_verify_timer_arm(fpe_cfg);
-	}
-}
-
-void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
-{
-	struct stmmac_fpe_cfg *fpe_cfg =3D &priv->fpe_cfg;
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
-		/* New link =3D> maybe new partner =3D> new verification process */
-		stmmac_fpe_apply(priv);
-	} else {
-		/* No link =3D> turn off EFPE */
-		stmmac_fpe_configure(priv, false, false);
-	}
-
-	spin_unlock_irqrestore(&fpe_cfg->lock, flags);
-}
-
 int stmmac_fpe_get_add_frag_size(struct stmmac_priv *priv)
 {
 	const struct stmmac_fpe_reg *reg =3D priv->fpe_cfg.reg;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h b/drivers/n=
et/ethernet/stmicro/stmmac/stmmac_fpe.h
index b884eac7142d..3fc46acf7001 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
@@ -9,15 +9,10 @@
 #include <linux/types.h>
 #include <linux/netdevice.h>
=20
-#define STMMAC_FPE_MM_MAX_VERIFY_RETRIES	3
-#define STMMAC_FPE_MM_MAX_VERIFY_TIME_MS	128
-
 struct stmmac_priv;
=20
-void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up);
 bool stmmac_fpe_supported(struct stmmac_priv *priv);
 void stmmac_fpe_init(struct stmmac_priv *priv);
-void stmmac_fpe_apply(struct stmmac_priv *priv);
 void stmmac_fpe_irq_status(struct stmmac_priv *priv);
 int stmmac_fpe_get_add_frag_size(struct stmmac_priv *priv);
 void stmmac_fpe_set_add_frag_size(struct stmmac_priv *priv, u32 add_frag=
_size);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
index d04543e5697b..8f723f9e84ba 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -992,7 +992,7 @@ static void stmmac_mac_link_down(struct phylink_confi=
g *config,
 		stmmac_set_eee_pls(priv, priv->hw, false);
=20
 	if (stmmac_fpe_supported(priv))
-		stmmac_fpe_link_state_handle(priv, false);
+		ethtool_mmsv_link_state_handle(&priv->fpe_cfg.mmsv, false);
 }
=20
 static void stmmac_mac_link_up(struct phylink_config *config,
@@ -1100,7 +1100,7 @@ static void stmmac_mac_link_up(struct phylink_confi=
g *config,
 		stmmac_set_eee_pls(priv, priv->hw, true);
=20
 	if (stmmac_fpe_supported(priv))
-		stmmac_fpe_link_state_handle(priv, true);
+		ethtool_mmsv_link_state_handle(&priv->fpe_cfg.mmsv, true);
=20
 	if (priv->plat->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
 		stmmac_hwtstamp_correct_latency(priv, priv);
@@ -4097,7 +4097,7 @@ static int stmmac_release(struct net_device *dev)
 	stmmac_release_ptp(priv);
=20
 	if (stmmac_fpe_supported(priv))
-		timer_shutdown_sync(&priv->fpe_cfg.verify_timer);
+		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
=20
 	pm_runtime_put(priv->device);
=20
@@ -7822,7 +7822,7 @@ int stmmac_suspend(struct device *dev)
 	rtnl_unlock();
=20
 	if (stmmac_fpe_supported(priv))
-		timer_shutdown_sync(&priv->fpe_cfg.verify_timer);
+		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
=20
 	priv->speed =3D SPEED_UNKNOWN;
 	return 0;
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 870994cc3ef7..b4b8eaf1f256 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -17,9 +17,13 @@
 #include <linux/compat.h>
 #include <linux/if_ether.h>
 #include <linux/netlink.h>
+#include <linux/timer_types.h>
 #include <uapi/linux/ethtool.h>
 #include <uapi/linux/net_tstamp.h>
=20
+#define ETHTOOL_MM_MAX_VERIFY_TIME_MS		128
+#define ETHTOOL_MM_MAX_VERIFY_RETRIES		3
+
 struct compat_ethtool_rx_flow_spec {
 	u32		flow_type;
 	union ethtool_flow_union h_u;
@@ -710,6 +714,75 @@ struct ethtool_mm_stats {
 	u64 MACMergeHoldCount;
 };
=20
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
+ * struct ethtool_mmsv_ops - Operations for MAC Merge Software Verificat=
ion
+ * @configure_tx: Driver callback for the event where the preemptible TX
+ *		  becomes active or inactive. Preemptible traffic
+ *		  classes must be committed to hardware only while
+ *		  preemptible TX is active.
+ * @configure_pmac: Driver callback for the event where the pMAC state
+ *		    changes as result of an administrative setting
+ *		    (ethtool) or a call to ethtool_mmsv_link_state_handle().
+ * @send_mpacket: Driver-provided method for sending a Verify or a Respo=
nse
+ *		  mPacket.
+ */
+struct ethtool_mmsv_ops {
+	void (*configure_tx)(struct ethtool_mmsv *mmsv, bool tx_active);
+	void (*configure_pmac)(struct ethtool_mmsv *mmsv, bool pmac_enabled);
+	void (*send_mpacket)(struct ethtool_mmsv *mmsv, enum ethtool_mpacket mp=
acket);
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
+void ethtool_mmsv_stop(struct ethtool_mmsv *mmsv);
+void ethtool_mmsv_link_state_handle(struct ethtool_mmsv *mmsv, bool up);
+void ethtool_mmsv_event_handle(struct ethtool_mmsv *mmsv,
+			       enum ethtool_mmsv_event event);
+void ethtool_mmsv_get_mm(struct ethtool_mmsv *mmsv,
+			 struct ethtool_mm_state *state);
+void ethtool_mmsv_set_mm(struct ethtool_mmsv *mmsv, struct ethtool_mm_cf=
g *cfg);
+void ethtool_mmsv_init(struct ethtool_mmsv *mmsv, struct net_device *dev=
,
+		       const struct ethtool_mmsv_ops *ops);
+
 /**
  * struct ethtool_rxfh_param - RXFH (RSS) parameters
  * @hfunc: Defines the current RSS hash function used by HW (or to be se=
t to).
diff --git a/net/ethtool/mm.c b/net/ethtool/mm.c
index 2816bb23c3ad..ad9b40034003 100644
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
@@ -282,3 +283,279 @@ bool ethtool_dev_mm_supported(struct net_device *de=
v)
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
+	struct ethtool_mmsv *mmsv =3D from_timer(mmsv, t, verify_timer);
+	unsigned long flags;
+	bool rearm =3D false;
+
+	spin_lock_irqsave(&mmsv->lock, flags);
+
+	switch (mmsv->status) {
+	case ETHTOOL_MM_VERIFY_STATUS_INITIAL:
+	case ETHTOOL_MM_VERIFY_STATUS_VERIFYING:
+		if (mmsv->verify_retries !=3D 0) {
+			ethtool_mmsv_send_mpacket(mmsv, ETHTOOL_MPACKET_VERIFY);
+			rearm =3D true;
+		} else {
+			mmsv->status =3D ETHTOOL_MM_VERIFY_STATUS_FAILED;
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
+	    mmsv->status !=3D ETHTOOL_MM_VERIFY_STATUS_FAILED &&
+	    mmsv->status !=3D ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED) {
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
+		mmsv->status =3D ETHTOOL_MM_VERIFY_STATUS_INITIAL;
+		mmsv->verify_retries =3D ETHTOOL_MM_MAX_VERIFY_RETRIES;
+
+		if (netif_running(mmsv->dev))
+			ethtool_mmsv_verify_timer_arm(mmsv);
+	}
+}
+
+/**
+ * ethtool_mmsv_stop() - Stop MAC Merge Software Verification
+ * @mmsv: MAC Merge Software Verification state
+ *
+ * Drivers should call this method in a state where the hardware is
+ * about to lose state, like ndo_stop() or suspend(), and turning off
+ * MAC Merge features would be superfluous. Otherwise, prefer
+ * ethtool_mmsv_link_state_handle() with up=3Dfalse.
+ */
+void ethtool_mmsv_stop(struct ethtool_mmsv *mmsv)
+{
+	timer_shutdown_sync(&mmsv->verify_timer);
+}
+EXPORT_SYMBOL_GPL(ethtool_mmsv_stop);
+
+/**
+ * ethtool_mmsv_link_state_handle() - Inform MAC Merge Software Verifica=
tion
+ *				      of link state changes
+ * @mmsv: MAC Merge Software Verification state
+ * @up: True if device carrier is up and able to pass verification packe=
ts
+ *
+ * Calling context is expected to be from a task, interrupts enabled.
+ */
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
+		/* New link =3D> maybe new partner =3D> new verification process */
+		ethtool_mmsv_apply(mmsv);
+	} else {
+		/* Reset the reported verification state while the link is down */
+		if (mmsv->verify_enabled)
+			mmsv->status =3D ETHTOOL_MM_VERIFY_STATUS_INITIAL;
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
+/**
+ * ethtool_mmsv_event_handle() - Inform MAC Merge Software Verification
+ *				 of interrupt-based events
+ * @mmsv: MAC Merge Software Verification state
+ * @event: Event which took place (packet transmission or reception)
+ *
+ * Calling context expects to have interrupts disabled.
+ */
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
+		if (mmsv->status !=3D ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED)
+			mmsv->status =3D ETHTOOL_MM_VERIFY_STATUS_VERIFYING;
+		break;
+	case ETHTOOL_MMSV_LP_SENT_RESPONSE_MPACKET:
+		/* Link partner has sent response mPacket */
+		if (mmsv->status =3D=3D ETHTOOL_MM_VERIFY_STATUS_VERIFYING)
+			mmsv->status =3D ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
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
+	       (mmsv->status =3D=3D ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
+	       mmsv->status =3D=3D ETHTOOL_MM_VERIFY_STATUS_DISABLED);
+}
+
+/**
+ * ethtool_mmsv_get_mm() - get_mm() hook for MAC Merge Software Verifica=
tion
+ * @mmsv: MAC Merge Software Verification state
+ * @state: see struct ethtool_mm_state
+ *
+ * Drivers are expected to call this from their ethtool_ops :: get_mm()
+ * method.
+ */
+void ethtool_mmsv_get_mm(struct ethtool_mmsv *mmsv,
+			 struct ethtool_mm_state *state)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&mmsv->lock, flags);
+
+	state->max_verify_time =3D ETHTOOL_MM_MAX_VERIFY_TIME_MS;
+	state->verify_enabled =3D mmsv->verify_enabled;
+	state->pmac_enabled =3D mmsv->pmac_enabled;
+	state->verify_time =3D mmsv->verify_time;
+	state->tx_enabled =3D mmsv->tx_enabled;
+	state->verify_status =3D mmsv->status;
+	state->tx_active =3D ethtool_mmsv_is_tx_active(mmsv);
+
+	spin_unlock_irqrestore(&mmsv->lock, flags);
+}
+EXPORT_SYMBOL_GPL(ethtool_mmsv_get_mm);
+
+/**
+ * ethtool_mmsv_set_mm() - set_mm() hook for MAC Merge Software Verifica=
tion
+ * @mmsv: MAC Merge Software Verification state
+ * @cfg: see struct ethtool_mm_cfg
+ *
+ * Drivers are expected to call this from their ethtool_ops :: set_mm()
+ * method.
+ */
+void ethtool_mmsv_set_mm(struct ethtool_mmsv *mmsv, struct ethtool_mm_cf=
g *cfg)
+{
+	unsigned long flags;
+
+	/* Wait for the verification that's currently in progress to finish */
+	ethtool_mmsv_stop(mmsv);
+
+	spin_lock_irqsave(&mmsv->lock, flags);
+
+	mmsv->verify_enabled =3D cfg->verify_enabled;
+	mmsv->pmac_enabled =3D cfg->pmac_enabled;
+	mmsv->verify_time =3D cfg->verify_time;
+	mmsv->tx_enabled =3D cfg->tx_enabled;
+
+	if (!cfg->verify_enabled)
+		mmsv->status =3D ETHTOOL_MM_VERIFY_STATUS_DISABLED;
+
+	ethtool_mmsv_apply(mmsv);
+
+	spin_unlock_irqrestore(&mmsv->lock, flags);
+}
+EXPORT_SYMBOL_GPL(ethtool_mmsv_set_mm);
+
+/**
+ * ethtool_mmsv_init() - Initialize MAC Merge Software Verification stat=
e
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
+void ethtool_mmsv_init(struct ethtool_mmsv *mmsv, struct net_device *dev=
,
+		       const struct ethtool_mmsv_ops *ops)
+{
+	mmsv->ops =3D ops;
+	mmsv->dev =3D dev;
+	mmsv->verify_retries =3D ETHTOOL_MM_MAX_VERIFY_RETRIES;
+	mmsv->verify_time =3D ETHTOOL_MM_MAX_VERIFY_TIME_MS;
+	mmsv->status =3D ETHTOOL_MM_VERIFY_STATUS_DISABLED;
+	timer_setup(&mmsv->verify_timer, ethtool_mmsv_verify_timer, 0);
+	spin_lock_init(&mmsv->lock);
+}
+EXPORT_SYMBOL_GPL(ethtool_mmsv_init);
--=20
2.34.1



