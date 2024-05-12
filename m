Return-Path: <bpf+bounces-29603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCB98C3785
	for <lists+bpf@lfdr.de>; Sun, 12 May 2024 18:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A0428151E
	for <lists+bpf@lfdr.de>; Sun, 12 May 2024 16:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAD4482DA;
	Sun, 12 May 2024 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="J20xUMoj"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308944776A;
	Sun, 12 May 2024 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715531356; cv=none; b=AmR6312X1LINypy3E0b3iaDn4Rzd6swFXx6SfWrtXtGIdfphZ420PD/r5xE7jfZ8UQ4BBQspGq+X5AeJCapDrUdRrTX7P78CFZJdXa/MMJZ4u9FbyI3M0ORu/9rNb6LKf9LVHCOKFZJLf2Amg3T9+SZ84pz9ZnA+ArnuXZxsnco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715531356; c=relaxed/simple;
	bh=mhFQ9uIAMaMFIki+i2SdR7Cpj1ayGUxq6TmGQmQHSYU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=aW/m00Z750fYOWynoLhjCm22MdjVYTdYOCkN2xetQv4QLNWmGt18FZ+fJU/uypkN0DqWgcbzixpoIFCR858jgfjIIaZxEMeAmllruINw6m/m6+aUElyXWhSynZOsokY9IQOx0scQKgQ19yQCBn+TAkoUWGZotszHQXtdHJV9Xc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=J20xUMoj; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EJPRiTPAH27pCBtWORpW7TMF0dojCJCFzEFVgnBP0qc=; b=J20xUMojG9+nSdQLYYCLLWJOM1
	V96+r70VB4e7FW7VQ+FBhKrwI2AR6BoYyJFKlbL/u/HMkBAkxrAIYt0do2qosjOoHzeqCrFfD5jaB
	hmG/mLPl/CjfjpelII6FxYj5pxxeH5ndTHyIRJ3gEOKG1BVdQVQsdlptR2tMhvyjprS8XmEL5oSZI
	B+ILLdAJv0qDQRVzgtnJOhd3aWqPxCjz8ipHdmA9wRspmP5UaXZDTkA3iKjsR+BbJUHRTiK74eyZl
	Zg/GyW+1Xm6vYhccDMJQfK87hlZibOUhXWLLzOLtj5vlKjq2TYFbkzVuDQCutdb136Xx1Yhpj9yI0
	hhzxRk7Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43504 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1s6C4H-0000t4-0q;
	Sun, 12 May 2024 17:28:57 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1s6C4J-00Ck6I-4Y; Sun, 12 May 2024 17:28:59 +0100
In-Reply-To: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
References: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [PATCH RFC net-next 1/6] net: stmmac: convert sgmii/rgmii "pcs" to
 phylink
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1s6C4J-00Ck6I-4Y@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 12 May 2024 17:28:59 +0100

Convert the sgmii/rgmii "pcs" implementation in stmmac to use a
phylink_pcs so we can get rid of exceptional paths.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/Makefile  |  2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h  |  9 +-
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  | 77 ++++++++++++++++-
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 82 ++++++++++++++++++-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    | 16 +++-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  7 ++
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.c  | 57 +++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.h  |  9 ++
 8 files changed, 252 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c

diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index 26cad4344701..e6e985cf7bec 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -6,7 +6,7 @@ stmmac-objs:= stmmac_main.o stmmac_ethtool.o stmmac_mdio.o ring_mode.o	\
 	      mmc_core.o stmmac_hwtstamp.o stmmac_ptp.o dwmac4_descs.o	\
 	      dwmac4_dma.o dwmac4_lib.o dwmac4_core.o dwmac5.o hwif.o \
 	      stmmac_tc.o dwxgmac2_core.o dwxgmac2_dma.o dwxgmac2_descs.o \
-	      stmmac_xdp.o stmmac_est.o \
+	      stmmac_xdp.o stmmac_est.o stmmac_pcs.o \
 	      $(stmmac-y)
 
 stmmac-$(CONFIG_STMMAC_SELFTESTS) += stmmac_selftests.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 9cd62b2110a1..82d0d897019c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -14,7 +14,7 @@
 #include <linux/etherdevice.h>
 #include <linux/netdevice.h>
 #include <linux/stmmac.h>
-#include <linux/phy.h>
+#include <linux/phylink.h>
 #include <linux/pcs/pcs-xpcs.h>
 #include <linux/module.h>
 #if IS_ENABLED(CONFIG_VLAN_8021Q)
@@ -593,6 +593,7 @@ struct mac_device_info {
 	const struct stmmac_tc_ops *tc;
 	const struct stmmac_mmc_ops *mmc;
 	const struct stmmac_est_ops *est;
+	struct phylink_pcs mac_pcs;	/* The MAC's RGMII/SGMII "PCS" */
 	struct dw_xpcs *xpcs;
 	struct phylink_pcs *phylink_pcs;
 	struct mii_regs mii;	/* MII register Addresses */
@@ -613,6 +614,12 @@ struct mac_device_info {
 	bool hw_vlan_en;
 };
 
+static inline struct mac_device_info *
+phylink_pcs_to_mac_dev_info(struct phylink_pcs *pcs)
+{
+	return container_of(pcs, struct mac_device_info, mac_pcs);
+}
+
 struct stmmac_rx_routing {
 	u32 reg_mask;
 	u32 reg_shift;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 8555299443f4..4ead61886fe5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -15,7 +15,8 @@
 #include <linux/crc32.h>
 #include <linux/slab.h>
 #include <linux/ethtool.h>
-#include <asm/io.h>
+#include <linux/io.h>
+#include <linux/phylink.h>
 #include "stmmac.h"
 #include "stmmac_pcs.h"
 #include "dwmac1000.h"
@@ -335,8 +336,10 @@ static int dwmac1000_irq_status(struct mac_device_info *hw,
 
 	dwmac_pcs_isr(ioaddr, GMAC_PCS_BASE, intr_status, x);
 
-	if (intr_status & PCS_RGSMIIIS_IRQ)
+	if (intr_status & PCS_RGSMIIIS_IRQ) {
+		phylink_pcs_change(&hw->mac_pcs, false);
 		dwmac1000_rgsmii(ioaddr, x);
+	}
 
 	return ret;
 }
@@ -414,6 +417,72 @@ static void dwmac1000_get_adv_lp(void __iomem *ioaddr, struct rgmii_adv *adv)
 	dwmac_get_adv_lp(ioaddr, GMAC_PCS_BASE, adv);
 }
 
+static int dwmac1000_mii_pcs_validate(struct phylink_pcs *pcs,
+				      unsigned long *supported,
+				      const struct phylink_link_state *state)
+{
+	/* Only support in-band */
+	if (!test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, state->advertising))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int dwmac1000_mii_pcs_config(struct phylink_pcs *pcs,
+				    unsigned int neg_mode,
+				    phy_interface_t interface,
+				    const unsigned long *advertising,
+				    bool permit_pause_to_mac)
+{
+	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
+
+	return dwmac_pcs_config(hw, advertising, GMAC_PCS_BASE);
+}
+
+static void dwmac1000_mii_pcs_get_state(struct phylink_pcs *pcs,
+					struct phylink_link_state *state)
+{
+	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
+	unsigned int spd_clk;
+	u32 status;
+
+	status = readl(hw->pcsr + GMAC_RGSMIIIS);
+
+	state->link = status & GMAC_RGSMIIIS_LNKSTS;
+	if (!state->link)
+		return;
+
+	spd_clk = FIELD_GET(GMAC_RGSMIIIS_SPEED, status);
+	if (spd_clk == GMAC_RGSMIIIS_SPEED_125)
+		state->speed = SPEED_1000;
+	else if (spd_clk == GMAC_RGSMIIIS_SPEED_25)
+		state->speed = SPEED_100;
+	else if (spd_clk == GMAC_RGSMIIIS_SPEED_2_5)
+		state->speed = SPEED_10;
+
+	state->duplex = status & GMAC_RGSMIIIS_LNKMOD_MASK ?
+			DUPLEX_FULL : DUPLEX_HALF;
+
+	dwmac_pcs_get_state(hw, state, GMAC_PCS_BASE);
+}
+
+static const struct phylink_pcs_ops dwmac1000_mii_pcs_ops = {
+	.pcs_validate = dwmac1000_mii_pcs_validate,
+	.pcs_config = dwmac1000_mii_pcs_config,
+	.pcs_get_state = dwmac1000_mii_pcs_get_state,
+};
+
+static struct phylink_pcs *
+dwmac1000_phylink_select_pcs(struct stmmac_priv *priv,
+			     phy_interface_t interface)
+{
+	if (priv->hw->pcs & STMMAC_PCS_RGMII ||
+	    priv->hw->pcs & STMMAC_PCS_SGMII)
+		return &priv->hw->mac_pcs;
+
+	return NULL;
+}
+
 static void dwmac1000_debug(struct stmmac_priv *priv, void __iomem *ioaddr,
 			    struct stmmac_extra_stats *x,
 			    u32 rx_queues, u32 tx_queues)
@@ -504,6 +573,7 @@ static void dwmac1000_set_mac_loopback(void __iomem *ioaddr, bool enable)
 
 const struct stmmac_ops dwmac1000_ops = {
 	.core_init = dwmac1000_core_init,
+	.phylink_select_pcs = dwmac1000_phylink_select_pcs,
 	.set_mac = stmmac_set_mac,
 	.rx_ipc = dwmac1000_rx_ipc_enable,
 	.dump_regs = dwmac1000_dump_regs,
@@ -555,5 +625,8 @@ int dwmac1000_setup(struct stmmac_priv *priv)
 	mac->mii.clk_csr_shift = 2;
 	mac->mii.clk_csr_mask = GENMASK(5, 2);
 
+	mac->mac_pcs.ops = &dwmac1000_mii_pcs_ops;
+	mac->mac_pcs.neg_mode = true;
+
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index b25774d69195..3c1181b1933f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/ethtool.h>
 #include <linux/io.h>
+#include <linux/phylink.h>
 #include "stmmac.h"
 #include "stmmac_pcs.h"
 #include "dwmac4.h"
@@ -801,6 +802,77 @@ static void dwmac4_phystatus(void __iomem *ioaddr, struct stmmac_extra_stats *x)
 	}
 }
 
+static int dwmac4_mii_pcs_validate(struct phylink_pcs *pcs,
+				   unsigned long *supported,
+				   const struct phylink_link_state *state)
+{
+	/* Only support in-band */
+	if (!test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, state->advertising))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int dwmac4_mii_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
+				 phy_interface_t interface,
+				 const unsigned long *advertising,
+				 bool permit_pause_to_mac)
+{
+	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
+
+	return dwmac_pcs_config(hw, advertising, GMAC_PCS_BASE);
+}
+
+static void dwmac4_mii_pcs_get_state(struct phylink_pcs *pcs,
+				     struct phylink_link_state *state)
+{
+	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
+	unsigned int clk_spd;
+	u32 status;
+
+	status = readl(hw->pcsr + GMAC_PHYIF_CONTROL_STATUS);
+
+	state->link = !!(status & GMAC_PHYIF_CTRLSTATUS_LNKSTS);
+	if (!state->link)
+		return;
+
+	clk_spd = FIELD_GET(GMAC_PHYIF_CTRLSTATUS_SPEED, status);
+	if (clk_spd == GMAC_PHYIF_CTRLSTATUS_SPEED_125)
+		state->speed = SPEED_1000;
+	else if (clk_spd == GMAC_PHYIF_CTRLSTATUS_SPEED_25)
+		state->speed = SPEED_100;
+	else if (clk_spd == GMAC_PHYIF_CTRLSTATUS_SPEED_2_5)
+		state->speed = SPEED_10;
+
+	/* FIXME: Is this even correct?
+	 * GMAC_PHYIF_CTRLSTATUS_TC = BIT(0)
+	 * GMAC_PHYIF_CTRLSTATUS_LNKMOD = BIT(16)
+	 * GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK = 1
+	 *
+	 * The result is, we test bit 0 for the duplex setting.
+	 */
+	state->duplex = status & GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK ?
+			DUPLEX_FULL : DUPLEX_HALF;
+
+	dwmac_pcs_get_state(hw, state, GMAC_PCS_BASE);
+}
+
+static const struct phylink_pcs_ops dwmac4_mii_pcs_ops = {
+	.pcs_validate = dwmac4_mii_pcs_validate,
+	.pcs_config = dwmac4_mii_pcs_config,
+	.pcs_get_state = dwmac4_mii_pcs_get_state,
+};
+
+static struct phylink_pcs *
+dwmac4_phylink_select_pcs(struct stmmac_priv *priv, phy_interface_t interface)
+{
+	if (priv->hw->pcs & STMMAC_PCS_RGMII ||
+	    priv->hw->pcs & STMMAC_PCS_SGMII)
+		return &priv->hw->mac_pcs;
+
+	return NULL;
+}
+
 static int dwmac4_irq_mtl_status(struct stmmac_priv *priv,
 				 struct mac_device_info *hw, u32 chan)
 {
@@ -872,8 +944,10 @@ static int dwmac4_irq_status(struct mac_device_info *hw,
 	}
 
 	dwmac_pcs_isr(ioaddr, GMAC_PCS_BASE, intr_status, x);
-	if (intr_status & PCS_RGSMIIIS_IRQ)
+	if (intr_status & PCS_RGSMIIIS_IRQ) {
+		phylink_pcs_change(&hw->mac_pcs, false);
 		dwmac4_phystatus(ioaddr, x);
+	}
 
 	return ret;
 }
@@ -1191,6 +1265,7 @@ static void dwmac4_set_hw_vlan_mode(struct mac_device_info *hw)
 const struct stmmac_ops dwmac4_ops = {
 	.core_init = dwmac4_core_init,
 	.update_caps = dwmac4_update_caps,
+	.phylink_select_pcs = dwmac4_phylink_select_pcs,
 	.set_mac = stmmac_set_mac,
 	.rx_ipc = dwmac4_rx_ipc_enable,
 	.rx_queue_enable = dwmac4_rx_queue_enable,
@@ -1236,6 +1311,7 @@ const struct stmmac_ops dwmac4_ops = {
 const struct stmmac_ops dwmac410_ops = {
 	.core_init = dwmac4_core_init,
 	.update_caps = dwmac4_update_caps,
+	.phylink_select_pcs = dwmac4_phylink_select_pcs,
 	.set_mac = stmmac_dwmac4_set_mac,
 	.rx_ipc = dwmac4_rx_ipc_enable,
 	.rx_queue_enable = dwmac4_rx_queue_enable,
@@ -1285,6 +1361,7 @@ const struct stmmac_ops dwmac410_ops = {
 const struct stmmac_ops dwmac510_ops = {
 	.core_init = dwmac4_core_init,
 	.update_caps = dwmac4_update_caps,
+	.phylink_select_pcs = dwmac4_phylink_select_pcs,
 	.set_mac = stmmac_dwmac4_set_mac,
 	.rx_ipc = dwmac4_rx_ipc_enable,
 	.rx_queue_enable = dwmac4_rx_queue_enable,
@@ -1399,5 +1476,8 @@ int dwmac4_setup(struct stmmac_priv *priv)
 	mac->mii.clk_csr_mask = GENMASK(11, 8);
 	mac->num_vlan = dwmac4_get_num_vlan(priv->ioaddr);
 
+	mac->mac_pcs.ops = &dwmac4_mii_pcs_ops;
+	mac->mac_pcs.neg_mode = true;
+
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 90384db228b5..e106f57b8b66 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -5,6 +5,7 @@
 #ifndef __STMMAC_HWIF_H__
 #define __STMMAC_HWIF_H__
 
+#include <linux/err.h>
 #include <linux/netdevice.h>
 #include <linux/stmmac.h>
 
@@ -17,13 +18,17 @@
 	} \
 	__result; \
 })
-#define stmmac_do_callback(__priv, __module, __cname,  __arg0, __args...) \
+#define stmmac_do_typed_callback(__type, __fail_ret, __priv, __module, \
+				 __cname,  __arg0, __args...) \
 ({ \
-	int __result = -EINVAL; \
+	__type __result = __fail_ret; \
 	if ((__priv)->hw->__module && (__priv)->hw->__module->__cname) \
 		__result = (__priv)->hw->__module->__cname((__arg0), ##__args); \
 	__result; \
 })
+#define stmmac_do_callback(__priv, __module, __cname,  __arg0, __args...) \
+	stmmac_do_typed_callback(int, -EINVAL, __priv, __module, __cname, \
+				 __arg0, ##__args)
 
 struct stmmac_extra_stats;
 struct stmmac_priv;
@@ -310,6 +315,9 @@ struct stmmac_ops {
 	void (*core_init)(struct mac_device_info *hw, struct net_device *dev);
 	/* Update MAC capabilities */
 	void (*update_caps)(struct stmmac_priv *priv);
+	/* Get phylink PCS (for MAC */
+	struct phylink_pcs *(*phylink_select_pcs)(struct stmmac_priv *priv,
+						  phy_interface_t interface);
 	/* Enable the MAC RX/TX */
 	void (*set_mac)(void __iomem *ioaddr, bool enable);
 	/* Enable and verify that the IPC module is supported */
@@ -432,6 +440,10 @@ struct stmmac_ops {
 	stmmac_do_void_callback(__priv, mac, core_init, __args)
 #define stmmac_mac_update_caps(__priv) \
 	stmmac_do_void_callback(__priv, mac, update_caps, __priv)
+#define stmmac_mac_phylink_select_pcs(__priv, __interface) \
+	stmmac_do_typed_callback(struct phylink_pcs *, ERR_PTR(-EOPNOTSUPP), \
+				 __priv, mac, phylink_select_pcs, __priv,\
+				 __interface)
 #define stmmac_mac_set(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, set_mac, __args)
 #define stmmac_rx_ipc(__priv, __args...) \
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 142a7c598efe..79364b60ac6b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -956,6 +956,13 @@ static struct phylink_pcs *stmmac_mac_select_pcs(struct phylink_config *config,
 						 phy_interface_t interface)
 {
 	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
+	struct phylink_pcs *pcs;
+
+	if (!(priv->plat->flags & STMMAC_FLAG_HAS_INTEGRATED_PCS)) {
+		pcs = stmmac_mac_phylink_select_pcs(priv, interface);
+		if (!IS_ERR(pcs))
+			return pcs;
+	}
 
 	if (priv->hw->xpcs)
 		return &priv->hw->xpcs->pcs;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
new file mode 100644
index 000000000000..a16c5636ad05
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
@@ -0,0 +1,57 @@
+#include "common.h"
+#include "stmmac_pcs.h"
+
+int dwmac_pcs_config(struct mac_device_info *hw,
+		     const unsigned long *advertising,
+		     unsigned int reg_base)
+{
+	u32 val;
+
+	val = readl(hw->pcsr + GMAC_AN_CTRL(reg_base));
+
+	val |= GMAC_AN_CTRL_ANE | GMAC_AN_CTRL_RAN;
+
+	if (hw->ps)
+		val |= GMAC_AN_CTRL_SGMRAL;
+
+	writel(val, hw->pcsr + GMAC_AN_CTRL(reg_base));
+
+	return 0;
+}
+
+void dwmac_pcs_get_state(struct mac_device_info *hw,
+			 struct phylink_link_state *state,
+			 unsigned int reg_base)
+{
+	u32 val;
+
+	val = readl(hw->pcsr + GMAC_ANE_LPA(reg_base));
+
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+			 state->lp_advertising);
+
+	if (val & GMAC_ANE_FD) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+				 state->lp_advertising);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+				 state->lp_advertising);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
+				 state->lp_advertising);
+	}
+
+	if (val & GMAC_ANE_HD) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
+				 state->lp_advertising);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
+				 state->lp_advertising);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
+				 state->lp_advertising);
+	}
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT,
+			 state->lp_advertising,
+			 FIELD_GET(GMAC_ANE_PSE, val) & STMMAC_PCS_PAUSE);
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+			 state->lp_advertising,
+			 FIELD_GET(GMAC_ANE_PSE, val) & STMMAC_PCS_ASYM_PAUSE);
+}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
index 13a30e6df4c1..c3ff12a6859b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
@@ -154,4 +154,13 @@ static inline void dwmac_get_adv_lp(void __iomem *ioaddr, u32 reg,
 
 	adv_lp->lp_pause = (value & GMAC_ANE_PSE) >> GMAC_ANE_PSE_SHIFT;
 }
+
+int dwmac_pcs_config(struct mac_device_info *hw,
+		     const unsigned long *advertising,
+		     unsigned int reg_base);
+
+void dwmac_pcs_get_state(struct mac_device_info *hw,
+			 struct phylink_link_state *state,
+			 unsigned int reg_base);
+
 #endif /* __STMMAC_PCS_H__ */
-- 
2.30.2


