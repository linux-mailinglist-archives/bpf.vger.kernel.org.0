Return-Path: <bpf+bounces-36281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7EF945C9D
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 12:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1BE11F22021
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 10:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9421DF69A;
	Fri,  2 Aug 2024 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tYky5PA1"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B413F1DF681;
	Fri,  2 Aug 2024 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722596185; cv=none; b=Tafs8ikq55qZd3+xBxMxsD2IwYhDAka6lW4vflhQuX5bFtWAx+M8dZoQbU+Cffvz7JAF58e139WYvSh3xIA8NJDtrfpRjXuJcCDQSJlyleFfQEPHy8YNnn5Oaiziz2IVDkRIhiLvlYh7Wd60mAHoJxLZkPLlegBCPNJl4Bo0SP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722596185; c=relaxed/simple;
	bh=mWgr8fefn5pLf9hdOEjndOAnTNZwVgR6zHw45RvbWek=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=CeUFU5TNG2c0mNbWykBBljcJdLX6cmDsJfmVIlwS3a0EqyuPeNqS/hTvrZb99MvJezZFkAjBAAOKgPJBUpAxbHo9V473mioDhwm5Pe6knJBGzdeZNPOg/rk941zNMybc6Mhuc4azYt392NmGC2t/E4S6jrEiTphk4PvadeZqDtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tYky5PA1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fPCM+FUmWtfT/a/xJLEhtPgnqWcJcdaOoc4ivCX+/S0=; b=tYky5PA18t33CscmHoO/Ekl1oh
	NiTiAun3mT7tfZ47r8asCc2IhOQONj9l5MfAfHh0Zi+9p6VsLiq1Ttk0E/FJBtuLK5W2vJabWsnjk
	9GEKUkWPjv792/d63e6PBa3qRW/vzmvw4msHMWal7DeRtJ5Yqk4/DxwgdCqHZCbUzBygpLOlb8HsR
	xCZlPhz0CDPvH2nXk6MnJKjcdVCMdhMtoVSiDvN48IWOBHV0eusokW7ak6luaf/Nj8YeaULg5tpK8
	xCAqdL6TjKr93fyutpwCNMgRppEmVuBYXpT3SdniVUV0JXFmi++N1j5tmElh7buHJzfAvVY6GAuAw
	LmMoxTyg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48636 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sZpoi-0006FG-1U;
	Fri, 02 Aug 2024 11:47:25 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sZpob-000eHh-4p; Fri, 02 Aug 2024 11:47:17 +0100
In-Reply-To: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
References: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Halaney <ahalaney@redhat.com>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH net-next 10/14] net: stmmac: move dwmac_ctrl_ane() into
 stmmac_pcs.c
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sZpob-000eHh-4p@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 02 Aug 2024 11:47:17 +0100

Move dwmac_ctrl_ane() into stmmac_pcs.c, changing its arguments to take
the stmmac_priv structure. Update it to use the previously provided
__dwmac_ctrl_ane() function, which makes use of the stmmac_pcs struct
and thus does not require passing the PCS base address offset.

This removes the core-specific functions, instead pointing the method
at the generic method in stmmac_pcs.c.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  |  8 +---
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 12 ++----
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.c  | 16 ++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.h  | 37 ++-----------------
 4 files changed, 23 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 05b2df08cb0f..d2defa2e4996 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -365,12 +365,6 @@ static void dwmac1000_set_eee_timer(struct mac_device_info *hw, int ls, int tw)
 	writel(value, ioaddr + LPI_TIMER_CTRL);
 }
 
-static void dwmac1000_ctrl_ane(struct stmmac_priv *priv, bool ane,
-			       bool srgmi_ral, bool loopback)
-{
-	dwmac_ctrl_ane(priv->ioaddr, GMAC_PCS_BASE, ane, srgmi_ral, loopback);
-}
-
 static int dwmac1000_mii_pcs_enable(struct phylink_pcs *pcs)
 {
 	struct stmmac_pcs *spcs = phylink_pcs_to_stmmac_pcs(pcs);
@@ -527,7 +521,7 @@ const struct stmmac_ops dwmac1000_ops = {
 	.set_eee_timer = dwmac1000_set_eee_timer,
 	.set_eee_pls = dwmac1000_set_eee_pls,
 	.debug = dwmac1000_debug,
-	.pcs_ctrl_ane = dwmac1000_ctrl_ane,
+	.pcs_ctrl_ane = dwmac_ctrl_ane,
 	.set_mac_loopback = dwmac1000_set_mac_loopback,
 };
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 0d261709bee6..2f02bb47c952 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -750,12 +750,6 @@ static void dwmac4_flow_ctrl(struct mac_device_info *hw, unsigned int duplex,
 	}
 }
 
-static void dwmac4_ctrl_ane(struct stmmac_priv *priv, bool ane, bool srgmi_ral,
-			    bool loopback)
-{
-	dwmac_ctrl_ane(priv->ioaddr, GMAC_PCS_BASE, ane, srgmi_ral, loopback);
-}
-
 static int dwmac4_mii_pcs_enable(struct phylink_pcs *pcs)
 {
 	struct stmmac_pcs *spcs = phylink_pcs_to_stmmac_pcs(pcs);
@@ -1227,7 +1221,7 @@ const struct stmmac_ops dwmac4_ops = {
 	.set_eee_lpi_entry_timer = dwmac4_set_eee_lpi_entry_timer,
 	.set_eee_timer = dwmac4_set_eee_timer,
 	.set_eee_pls = dwmac4_set_eee_pls,
-	.pcs_ctrl_ane = dwmac4_ctrl_ane,
+	.pcs_ctrl_ane = dwmac_ctrl_ane,
 	.debug = dwmac4_debug,
 	.set_filter = dwmac4_set_filter,
 	.set_mac_loopback = dwmac4_set_mac_loopback,
@@ -1271,7 +1265,7 @@ const struct stmmac_ops dwmac410_ops = {
 	.set_eee_lpi_entry_timer = dwmac4_set_eee_lpi_entry_timer,
 	.set_eee_timer = dwmac4_set_eee_timer,
 	.set_eee_pls = dwmac4_set_eee_pls,
-	.pcs_ctrl_ane = dwmac4_ctrl_ane,
+	.pcs_ctrl_ane = dwmac_ctrl_ane,
 	.debug = dwmac4_debug,
 	.set_filter = dwmac4_set_filter,
 	.flex_pps_config = dwmac5_flex_pps_config,
@@ -1319,7 +1313,7 @@ const struct stmmac_ops dwmac510_ops = {
 	.set_eee_lpi_entry_timer = dwmac4_set_eee_lpi_entry_timer,
 	.set_eee_timer = dwmac4_set_eee_timer,
 	.set_eee_pls = dwmac4_set_eee_pls,
-	.pcs_ctrl_ane = dwmac4_ctrl_ane,
+	.pcs_ctrl_ane = dwmac_ctrl_ane,
 	.debug = dwmac4_debug,
 	.set_filter = dwmac4_set_filter,
 	.safety_feat_config = dwmac5_safety_feat_config,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
index 292c039c9778..e435facc9849 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
@@ -30,6 +30,22 @@ static void __dwmac_ctrl_ane(struct stmmac_pcs *spcs, bool ane, bool srgmi_ral,
 	writel(val, spcs->pcs_base + GMAC_AN_CTRL(0));
 }
 
+/**
+ * dwmac_ctrl_ane - To program the AN Control Register.
+ * @priv: pointer to &struct stmmac_priv
+ * @ane: to enable the auto-negotiation
+ * @srgmi_ral: to manage MAC-2-MAC SGMII connections.
+ * @loopback: to cause the PHY to loopback tx data into rx path.
+ * Description: this is the main function to configure the AN control register
+ * and init the ANE, select loopback (usually for debugging purpose) and
+ * configure SGMII RAL.
+ */
+void dwmac_ctrl_ane(struct stmmac_priv *priv, bool ane, bool srgmi_ral,
+		    bool loopback)
+{
+	__dwmac_ctrl_ane(&priv->hw->mac_pcs, ane, srgmi_ral, loopback);
+}
+
 int dwmac_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 		     phy_interface_t interface,
 		     const unsigned long *advertising,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
index f0d6442711ff..083128e0013c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
@@ -89,40 +89,6 @@ static inline void dwmac_pcs_isr(void __iomem *ioaddr, u32 reg,
 	}
 }
 
-/**
- * dwmac_ctrl_ane - To program the AN Control Register.
- * @ioaddr: IO registers pointer
- * @reg: Base address of the AN Control Register.
- * @ane: to enable the auto-negotiation
- * @srgmi_ral: to manage MAC-2-MAC SGMII connections.
- * @loopback: to cause the PHY to loopback tx data into rx path.
- * Description: this is the main function to configure the AN control register
- * and init the ANE, select loopback (usually for debugging purpose) and
- * configure SGMII RAL.
- */
-static inline void dwmac_ctrl_ane(void __iomem *ioaddr, u32 reg, bool ane,
-				  bool srgmi_ral, bool loopback)
-{
-	u32 value = readl(ioaddr + GMAC_AN_CTRL(reg));
-
-	/* Enable and restart the Auto-Negotiation */
-	if (ane)
-		value |= GMAC_AN_CTRL_ANE | GMAC_AN_CTRL_RAN;
-	else
-		value &= ~GMAC_AN_CTRL_ANE;
-
-	/* In case of MAC-2-MAC connection, block is configured to operate
-	 * according to MAC conf register.
-	 */
-	if (srgmi_ral)
-		value |= GMAC_AN_CTRL_SGMRAL;
-
-	if (loopback)
-		value |= GMAC_AN_CTRL_ELE;
-
-	writel(value, ioaddr + GMAC_AN_CTRL(reg));
-}
-
 static inline bool dwmac_rs_decode_stat(struct phylink_link_state *state,
 					uint16_t rs_stat)
 {
@@ -154,6 +120,9 @@ static inline bool dwmac_rs_decode_stat(struct phylink_link_state *state,
 	return true;
 }
 
+void dwmac_ctrl_ane(struct stmmac_priv *priv, bool ane, bool srgmi_ral,
+		    bool loopback);
+
 int dwmac_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 		     phy_interface_t interface,
 		     const unsigned long *advertising,
-- 
2.30.2


