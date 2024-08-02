Return-Path: <bpf+bounces-36275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B39945C56
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 12:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B014C1F215C7
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 10:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2647C1DF672;
	Fri,  2 Aug 2024 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DcJMFv5D"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAC31D1F4B;
	Fri,  2 Aug 2024 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722595663; cv=none; b=ah0ucnX6qigSHaFObu5NEIOrOu2ODwD9a+ASWh2ImqCcEs0gGqbsEtiwsXZDGN+xS8e+REjwNmk+pupNiDKzMf9Kg0hptaKxBXrOljequcCJwBo7K9zYLeDVP+Uc1SX6qByDylh634KQzf2njTrwx/dMuzhurmoi4dhDg0bhtYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722595663; c=relaxed/simple;
	bh=p1mKDn2jk7rxfYSG81m6boKJ9PG9+PAuUcxhATBuP5A=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=jLiz2eUoIqV+Bp1OcQ1Fv/aHpQNIEoOFbPtyuUJzchTtLVJHVqECrtIlwtjNdPxX3mrqXlcZIQ6DZZg4Cw/XmskjKPXHOfebuLlxNdB7rWHKjww3P4PUl7zx7c8CyYH4iFhLgS2lah0hktDkYqGa8Ew/HYIEb4JX+6M163WPKoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DcJMFv5D; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4++u+M2gUsWJ0uVVvTAggA9qzMZa6bmuLtZOnE5wpxw=; b=DcJMFv5DuAQmmU/DBxlbCFzpyN
	LzF/ThYcFNtdSVoSbs51EBxlBt3SUPSYarYUmuXoRCz8jz3wzN1l0GyF+qC7Zdtx0XbdbR/pDj7Zm
	vNUWaDuw+tdqFsk2wH2pah2CU33nE/XcR0OPpd/S/AtCNIueOjtvXUrzYIXJhaCzFbN5G/PStMHFw
	TM49wXLBD2JlpOkGgZS00tgcGkYeo+L/6H8JsyFXr5/7EedHJ/FI0mz0N3jsitkMf6czIuQ0eKPtl
	X3DsU9bsRvaB6cbaPn29jzxUvC2EVA3dfG0AGnJSHEQ28qrHFseg4BiOvbzJLE+mnHerJg0P/+Tij
	Y4TFJmGg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36368 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sZpoP-0006El-0l;
	Fri, 02 Aug 2024 11:47:05 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sZpoQ-000eHS-TH; Fri, 02 Aug 2024 11:47:06 +0100
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
Subject: [PATCH net-next 08/14] net: stmmac: dwmac4: convert sgmii/rgmii "pcs"
 to phylink
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sZpoQ-000eHS-TH@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 02 Aug 2024 11:47:06 +0100

Convert dwmac4 sgmii/rgmii "pcs" implementation to use a phylink_pcs
so we can eventually get rid of the exceptional paths that conflict
with phylink.

We do not provide a validate method to enforce auto-negotiation,
because the ethtool autonegotiation is a property of the media facing
link, not of the internal network device links.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h  | 13 +----
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 58 +++++++++++--------
 2 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index d3c5306f1c41..c6a254ecfbb8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -567,18 +567,7 @@ static inline u32 mtl_low_credx_base_addr(const struct dwmac4_addrs *addrs,
 #define GMAC_PHYIF_CTRLSTATUS_TC		BIT(0)
 #define GMAC_PHYIF_CTRLSTATUS_LUD		BIT(1)
 #define GMAC_PHYIF_CTRLSTATUS_SMIDRXS		BIT(4)
-#define GMAC_PHYIF_CTRLSTATUS_LNKMOD		BIT(16)
-#define GMAC_PHYIF_CTRLSTATUS_SPEED		GENMASK(18, 17)
-#define GMAC_PHYIF_CTRLSTATUS_SPEED_SHIFT	17
-#define GMAC_PHYIF_CTRLSTATUS_LNKSTS		BIT(19)
-#define GMAC_PHYIF_CTRLSTATUS_JABTO		BIT(20)
-#define GMAC_PHYIF_CTRLSTATUS_FALSECARDET	BIT(21)
-/* LNKMOD */
-#define GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK	0x1
-/* LNKSPEED */
-#define GMAC_PHYIF_CTRLSTATUS_SPEED_125		0x2
-#define GMAC_PHYIF_CTRLSTATUS_SPEED_25		0x1
-#define GMAC_PHYIF_CTRLSTATUS_SPEED_2_5		0x0
+#define GMAC_PHYIF_CTRLSTATUS_RS_STAT		GENMASK(31, 16)
 
 extern const struct stmmac_dma_ops dwmac4_dma_ops;
 extern const struct stmmac_dma_ops dwmac410_dma_ops;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index d919fc07c8f1..ec8e94ddf948 100644
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
@@ -758,37 +759,32 @@ static void dwmac4_ctrl_ane(struct stmmac_priv *priv, bool ane, bool srgmi_ral,
 	dwmac_ctrl_ane(priv->ioaddr, GMAC_PCS_BASE, ane, srgmi_ral, loopback);
 }
 
-/* RGMII or SMII interface */
-static void dwmac4_phystatus(void __iomem *ioaddr, struct stmmac_extra_stats *x)
+static void dwmac4_mii_pcs_get_state(struct phylink_pcs *pcs,
+				     struct phylink_link_state *state)
 {
+	struct stmmac_pcs *spcs = phylink_pcs_to_stmmac_pcs(pcs);
 	u32 status;
 
-	status = readl(ioaddr + GMAC_PHYIF_CONTROL_STATUS);
-	x->irq_rgmii_n++;
+	status = readl(spcs->priv->ioaddr + GMAC_PHYIF_CONTROL_STATUS);
 
-	/* Check the link status */
-	if (status & GMAC_PHYIF_CTRLSTATUS_LNKSTS) {
-		int speed_value;
+	dwmac_rs_decode_stat(state, FIELD_GET(GMAC_PHYIF_CTRLSTATUS_RS_STAT,
+					      status));
+}
 
-		x->pcs_link = 1;
+static const struct phylink_pcs_ops dwmac4_mii_pcs_ops = {
+	.pcs_config = dwmac_pcs_config,
+	.pcs_get_state = dwmac4_mii_pcs_get_state,
+};
 
-		speed_value = ((status & GMAC_PHYIF_CTRLSTATUS_SPEED) >>
-			       GMAC_PHYIF_CTRLSTATUS_SPEED_SHIFT);
-		if (speed_value == GMAC_PHYIF_CTRLSTATUS_SPEED_125)
-			x->pcs_speed = SPEED_1000;
-		else if (speed_value == GMAC_PHYIF_CTRLSTATUS_SPEED_25)
-			x->pcs_speed = SPEED_100;
-		else
-			x->pcs_speed = SPEED_10;
 
-		x->pcs_duplex = (status & GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK);
+static struct phylink_pcs *
+dwmac4_phylink_select_pcs(struct stmmac_priv *priv, phy_interface_t interface)
+{
+	if (priv->hw->pcs & STMMAC_PCS_RGMII ||
+	    priv->hw->pcs & STMMAC_PCS_SGMII)
+		return &priv->hw->mac_pcs.pcs;
 
-		pr_info("Link is Up - %d/%s\n", (int)x->pcs_speed,
-			x->pcs_duplex ? "Full" : "Half");
-	} else {
-		x->pcs_link = 0;
-		pr_info("Link is Down\n");
-	}
+	return NULL;
 }
 
 static int dwmac4_irq_mtl_status(struct stmmac_priv *priv,
@@ -862,8 +858,12 @@ static int dwmac4_irq_status(struct mac_device_info *hw,
 	}
 
 	dwmac_pcs_isr(ioaddr, GMAC_PCS_BASE, intr_status, x);
-	if (intr_status & PCS_RGSMIIIS_IRQ)
-		dwmac4_phystatus(ioaddr, x);
+	if (intr_status & PCS_RGSMIIIS_IRQ) {
+		/* TODO Dummy-read to clear the IRQ status */
+		readl(ioaddr + GMAC_PHYIF_CONTROL_STATUS);
+		phylink_pcs_change(&hw->mac_pcs.pcs, false);
+		x->irq_rgmii_n++;
+	}
 
 	return ret;
 }
@@ -1181,6 +1181,7 @@ static void dwmac4_set_hw_vlan_mode(struct mac_device_info *hw)
 const struct stmmac_ops dwmac4_ops = {
 	.core_init = dwmac4_core_init,
 	.update_caps = dwmac4_update_caps,
+	.phylink_select_pcs = dwmac4_phylink_select_pcs,
 	.set_mac = stmmac_set_mac,
 	.rx_ipc = dwmac4_rx_ipc_enable,
 	.rx_queue_enable = dwmac4_rx_queue_enable,
@@ -1224,6 +1225,7 @@ const struct stmmac_ops dwmac4_ops = {
 const struct stmmac_ops dwmac410_ops = {
 	.core_init = dwmac4_core_init,
 	.update_caps = dwmac4_update_caps,
+	.phylink_select_pcs = dwmac4_phylink_select_pcs,
 	.set_mac = stmmac_dwmac4_set_mac,
 	.rx_ipc = dwmac4_rx_ipc_enable,
 	.rx_queue_enable = dwmac4_rx_queue_enable,
@@ -1271,6 +1273,7 @@ const struct stmmac_ops dwmac410_ops = {
 const struct stmmac_ops dwmac510_ops = {
 	.core_init = dwmac4_core_init,
 	.update_caps = dwmac4_update_caps,
+	.phylink_select_pcs = dwmac4_phylink_select_pcs,
 	.set_mac = stmmac_dwmac4_set_mac,
 	.rx_ipc = dwmac4_rx_ipc_enable,
 	.rx_queue_enable = dwmac4_rx_queue_enable,
@@ -1383,5 +1386,10 @@ int dwmac4_setup(struct stmmac_priv *priv)
 	mac->mii.clk_csr_mask = GENMASK(11, 8);
 	mac->num_vlan = dwmac4_get_num_vlan(priv->ioaddr);
 
+	mac->mac_pcs.priv = priv;
+	mac->mac_pcs.pcs_base = priv->ioaddr + GMAC_PCS_BASE;
+	mac->mac_pcs.pcs.ops = &dwmac4_mii_pcs_ops;
+	mac->mac_pcs.pcs.neg_mode = true;
+
 	return 0;
 }
-- 
2.30.2


