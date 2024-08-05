Return-Path: <bpf+bounces-36383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11BC9479C3
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 12:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C861B21E72
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 10:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4D6158D75;
	Mon,  5 Aug 2024 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lxxJhFld"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61970158A12;
	Mon,  5 Aug 2024 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853538; cv=none; b=JO7WXPZAHmXWKRbQYVbqVgd85/Ahbzk7Rlg97YeLYXAdMlR9I/cKHekwGIDJ/mpG2ywXjTGtp/cXw6jEqgrgxWUiwWLoAW0IXatfSrlP35BJ2kSKWXQa8hVmoQoAAo+ecfMY8mCyFYvLBfe9j6RuWsH40Vza7TiNt9F4U8JbU2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853538; c=relaxed/simple;
	bh=UHTd5A/aTvVDfRwUXepOMsa1aG5UkSLokJV7ia+plpg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=hHneowDxyuyGM0EZ5Q/7diS1bVwS75aQnPVuyLikMvHphO7EYQCJIClApCDacCjuQkvXw0YPfhP0d5S7K7l+jyVR9XuB1O60KzsAxL7JkLWIGiq09lFgG+qowUp5v+NL3XyIVzIMWlhQz+VcMB2DO4Pb82vcIwjU+fas7zgPYjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lxxJhFld; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ldegGhyH398a5LToFGWUu8u+63Wh+yZiitEXtG3A7zI=; b=lxxJhFldn9vH5B5dnncGd4CZCJ
	JfN7sYq1MXSmDSXlcJ9ukA7e5/rZl4OQ9GuEZXCTp425uu3VMtLlM8vHVSGdnGT0a4OihUpFsiPQO
	GjTmysJ0HZTQxiIvcgoiq5vbMBtrV41+KGvoe9Fg6BloTattMoVhSXouRbTnYE2arh80v6aj25mK0
	K8L3jG8oRWwQ3BjrDiQ6/3ODYcrZJdL8OMhJfQkPwXP16Fq8MgfiQ0fXQfR9oJJi7qkIBcQF4wLqL
	ZL+3GZIr7ZGkqlrbj/LuNnGnkS0efH+2XTtMvwQZTLUu03+QYrobTbvesyH8frSL915B5HK3BGIR3
	kUqu8hiA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44314 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sauu3-0002dz-1K;
	Mon, 05 Aug 2024 11:25:23 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sauu7-000tva-N1; Mon, 05 Aug 2024 11:25:27 +0100
In-Reply-To: <ZrCoQZKo74zvKMhT@shell.armlinux.org.uk>
References: <ZrCoQZKo74zvKMhT@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Halaney <ahalaney@redhat.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
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
	Sneh Shah <quic_snehshah@quicinc.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH RFC net-next v4 10/14] net: stmmac: move dwmac_ctrl_ane() into
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
Message-Id: <E1sauu7-000tva-N1@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 05 Aug 2024 11:25:27 +0100

Move dwmac_ctrl_ane() into stmmac_pcs.c, changing its arguments to take
the stmmac_priv structure. Update it to use the previously provided
__dwmac_ctrl_ane() function, which makes use of the stmmac_pcs struct
and thus does not require passing the PCS base address offset.

This removes the core-specific functions, instead pointing the method
at the generic method in stmmac_pcs.c.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
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


