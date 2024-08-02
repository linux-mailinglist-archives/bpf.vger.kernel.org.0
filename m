Return-Path: <bpf+bounces-36283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A71945CA7
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 12:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9D71F225AA
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 10:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AA81DF66A;
	Fri,  2 Aug 2024 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xv81wunM"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FFA1DE86C;
	Fri,  2 Aug 2024 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722596222; cv=none; b=Qq9Y0VII8h9BjowIJJiuVAC7NO4LvtFXq+4kg2NoE62vrX/Ntd2nQHPTifLfeWJ4ixPOYPnvKlNaveSxrindBH81Gk5Idu2tBBTHY7+/7KFyMlJs3uRKrTFssR2BFJZ1jTXLheGiMQXVZl8S+uG4lb+B1JWe6mrAIkKH3ku1rzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722596222; c=relaxed/simple;
	bh=vzCNUXoNtacdQW4Zedy8uOwee3G33a+qrTsLl59q8LY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=IaP1VQrnpfeojbNitehfhlXWDMa+ijtGaENb1fIjzWMYIBOm6wY1jxNjOeWyoVDsbPivVGpoVicoGUiPLMc+J57B7NBOJmWNFyArqnjVgKA6L7BMSPJWKMrH0okQOfx8O/MfTt/9YSoEN3L+kkVZL//BuZPqNzkXMxMlJxwlmd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xv81wunM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uQGMZ5XIRT1DXXPthPdl6hu8lVDGel4TJqDFGYE469k=; b=xv81wunMVkAZrvkXAQKllU4HCR
	mytnXa4aLSkhFKRJSWLvty1MKb0K6CipZ6r+/GigReiQu/USZTPT+ySJoutvzlJ7rwI13yuB+35SZ
	1lmaLUv7KleBxjeMXY3T4rbzi+aXX1xDDQL/dOkWVQb9ECcGCkTc0f70jQ9l6AWz32rL77reXR7yo
	HMAykra+gLXE9VWOSafmHnv5tIwEUbBpD5m5iSTkS2SnNo3IYd1CT86WieEzp7B56b/fCymbMGc9m
	57fD59ttmbxsxCQPktc4KnMTtEMTn8NglwRsKpZ8ZYTeXz/7RZYcFxRXfImNWApJ58Dh3qJh4RIOe
	7PD4r6TQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57288 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sZpon-0006Fl-1q;
	Fri, 02 Aug 2024 11:47:30 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sZpol-000eHs-Cn; Fri, 02 Aug 2024 11:47:27 +0100
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
Subject: [PATCH net-next 12/14] net: stmmac: rename PCS registers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sZpol-000eHs-Cn@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 02 Aug 2024 11:47:27 +0100

Rename the PCS registers from GMAC_xxx to STMMAC_PCS_xxx to make it
clear that they are for the PCS. Avoid using PCS_ as this is too
generic and may (eventually) clash with definitions elsewhere in the
kernel.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.c  | 16 +++---
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.h  | 52 +++++++++----------
 2 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
index e435facc9849..7960bfd83b74 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
@@ -8,26 +8,26 @@ static void __dwmac_ctrl_ane(struct stmmac_pcs *spcs, bool ane, bool srgmi_ral,
 {
 	u32 val;
 
-	val = readl(spcs->pcs_base + GMAC_AN_CTRL(0));
+	val = readl(spcs->pcs_base + STMMAC_PCS_AN_CTRL);
 
 	/* Enable and restart the Auto-Negotiation */
 	if (ane)
-		val |= GMAC_AN_CTRL_ANE | GMAC_AN_CTRL_RAN;
+		val |= STMMAC_PCS_AN_CTRL_ANE | STMMAC_PCS_AN_CTRL_RAN;
 	else
-		val &= ~GMAC_AN_CTRL_ANE;
+		val &= ~STMMAC_PCS_AN_CTRL_ANE;
 
 	/* In case of MAC-2-MAC connection, block is configured to operate
 	 * according to MAC conf register.
 	 */
 	if (srgmi_ral)
-		val |= GMAC_AN_CTRL_SGMRAL;
+		val |= STMMAC_PCS_AN_CTRL_SGMRAL;
 
 	if (loopback)
-		val |= GMAC_AN_CTRL_ELE;
+		val |= STMMAC_PCS_AN_CTRL_ELE;
 	else
-		val &= ~GMAC_AN_CTRL_ELE;
+		val &= ~STMMAC_PCS_AN_CTRL_ELE;
 
-	writel(val, spcs->pcs_base + GMAC_AN_CTRL(0));
+	writel(val, spcs->pcs_base + STMMAC_PCS_AN_CTRL);
 }
 
 /**
@@ -53,7 +53,7 @@ int dwmac_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 {
 	struct stmmac_pcs *spcs = phylink_pcs_to_stmmac_pcs(pcs);
 
-	/* The RGMII interface does not have the GMAC_AN_CTRL register */
+	/* The RGMII interface does not have the STMMAC_PCS_AN_CTRL register */
 	if (phy_interface_mode_is_rgmii(spcs->priv->plat->mac_interface))
 		return 0;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
index c73a08dab7b2..1827c7e64dba 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
@@ -14,37 +14,37 @@
 #include "common.h"
 
 /* PCS registers (AN/TBI/SGMII/RGMII) offsets */
-#define GMAC_AN_CTRL(x)		(x)		/* AN control */
-#define GMAC_AN_STATUS(x)	(x + 0x4)	/* AN status */
+#define STMMAC_PCS_AN_CTRL	0x00		/* AN control */
+#define STMMAC_PCS_AN_STATUS	0x04		/* AN status */
 
 /* ADV, LPA and EXP are only available for the TBI and RTBI interfaces */
-#define GMAC_ANE_ADV(x)		(x + 0x8)	/* ANE Advertisement */
-#define GMAC_ANE_LPA(x)		(x + 0xc)	/* ANE link partener ability */
-#define GMAC_ANE_EXP(x)		(x + 0x10)	/* ANE expansion */
-#define GMAC_TBI(x)		(x + 0x14)	/* TBI extend status */
+#define STMMAC_PCS_ANE_ADV	0x08		/* ANE Advertisement */
+#define STMMAC_PCS_ANE_LPA	0x0c		/* ANE link partener ability */
+#define STMMAC_PCS_ANE_EXP	0x10		/* ANE expansion */
+#define STMMAC_PCS_TBI		0x14		/* TBI extend status */
 
 /* AN Configuration defines */
-#define GMAC_AN_CTRL_RAN	BIT(9)	/* Restart Auto-Negotiation */
-#define GMAC_AN_CTRL_ANE	BIT(12)	/* Auto-Negotiation Enable */
-#define GMAC_AN_CTRL_ELE	BIT(14)	/* External Loopback Enable */
-#define GMAC_AN_CTRL_ECD	BIT(16)	/* Enable Comma Detect */
-#define GMAC_AN_CTRL_LR		BIT(17)	/* Lock to Reference */
-#define GMAC_AN_CTRL_SGMRAL	BIT(18)	/* SGMII RAL Control */
+#define STMMAC_PCS_AN_CTRL_RAN		BIT(9)	/* Restart Auto-Negotiation */
+#define STMMAC_PCS_AN_CTRL_ANE		BIT(12)	/* Auto-Negotiation Enable */
+#define STMMAC_PCS_AN_CTRL_ELE		BIT(14)	/* External Loopback Enable */
+#define STMMAC_PCS_AN_CTRL_ECD		BIT(16)	/* Enable Comma Detect */
+#define STMMAC_PCS_AN_CTRL_LR		BIT(17)	/* Lock to Reference */
+#define STMMAC_PCS_AN_CTRL_SGMRAL	BIT(18)	/* SGMII RAL Control */
 
 /* AN Status defines */
-#define GMAC_AN_STATUS_LS	BIT(2)	/* Link Status 0:down 1:up */
-#define GMAC_AN_STATUS_ANA	BIT(3)	/* Auto-Negotiation Ability */
-#define GMAC_AN_STATUS_ANC	BIT(5)	/* Auto-Negotiation Complete */
-#define GMAC_AN_STATUS_ES	BIT(8)	/* Extended Status */
+#define STMMAC_PCS_AN_STATUS_LS		BIT(2)	/* Link Status 0:down 1:up */
+#define STMMAC_PCS_AN_STATUS_ANA	BIT(3)	/* Auto-Negotiation Ability */
+#define STMMAC_PCS_AN_STATUS_ANC	BIT(5)	/* Auto-Negotiation Complete */
+#define STMMAC_PCS_AN_STATUS_ES		BIT(8)	/* Extended Status */
 
 /* ADV and LPA defines */
-#define GMAC_ANE_FD		BIT(5)
-#define GMAC_ANE_HD		BIT(6)
-#define GMAC_ANE_PSE		GENMASK(8, 7)
-#define GMAC_ANE_PSE_SHIFT	7
-#define GMAC_ANE_RFE		GENMASK(13, 12)
-#define GMAC_ANE_RFE_SHIFT	12
-#define GMAC_ANE_ACK		BIT(14)
+#define STMMAC_PCS_ANE_FD		BIT(5)
+#define STMMAC_PCS_ANE_HD		BIT(6)
+#define STMMAC_PCS_ANE_PSE		GENMASK(8, 7)
+#define STMMAC_PCS_ANE_PSE_SHIFT	7
+#define STMMAC_PCS_ANE_RFE		GENMASK(13, 12)
+#define STMMAC_PCS_ANE_RFE_SHIFT	12
+#define STMMAC_PCS_ANE_ACK		BIT(14)
 
 /* MAC specific status - for RGMII and SGMII. These appear as
  * GMAC_RGSMIIIS[15:0] and GMAC_PHYIF_CONTROL_STATUS[31:16]
@@ -72,17 +72,17 @@ static inline void dwmac_pcs_isr(struct stmmac_pcs *spcs,
 				 unsigned int intr_status,
 				 struct stmmac_extra_stats *x)
 {
-	u32 val = readl(spcs->pcs_base + GMAC_AN_STATUS(0));
+	u32 val = readl(spcs->pcs_base + STMMAC_PCS_AN_STATUS);
 
 	if (intr_status & PCS_ANE_IRQ) {
 		x->irq_pcs_ane_n++;
-		if (val & GMAC_AN_STATUS_ANC)
+		if (val & STMMAC_PCS_AN_STATUS_ANC)
 			pr_info("stmmac_pcs: ANE process completed\n");
 	}
 
 	if (intr_status & PCS_LINK_IRQ) {
 		x->irq_pcs_link_n++;
-		if (val & GMAC_AN_STATUS_LS)
+		if (val & STMMAC_PCS_AN_STATUS_LS)
 			pr_info("stmmac_pcs: Link Up\n");
 		else
 			pr_info("stmmac_pcs: Link Down\n");
-- 
2.30.2


