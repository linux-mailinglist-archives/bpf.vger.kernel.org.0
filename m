Return-Path: <bpf+bounces-36380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D01D9479BA
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 12:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C3E1F2279D
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 10:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170C0158211;
	Mon,  5 Aug 2024 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1k9SB/g0"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C68E14B947;
	Mon,  5 Aug 2024 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853522; cv=none; b=RwDosqfPZyUjBRzDdsYD75rv7FSTKK9PgzuHblF2jWf9EGIA00/FfltnQRNy+E9rLvdSL6EkNVgVCIXAt+/vc4F4Du6qa/iAdLxLXkjnogxM4x6STtnupd78pxRXxNvoQQp+MEdxLHO0eKt50h9rqAw9/VlHaTlpc5hBzW58HLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853522; c=relaxed/simple;
	bh=p+8IHXl8x1uF882H1bqSTl/7tVK7/Q9FJEvNoLTHLWc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=SJJ4WuqIo19ND7Fkc9zgsPkEmYWIgfjFbXv4EuGwxrFoMpkjJcsbXrK+wGKQPW3Z9Vq1ZGgOSjfJRKIymICVpxWRcITHC7M+EyH/4RHwwQn49q4zRHULEOy3G2DMZ9aL0X9wkgxtF2gtaxM3ve/T2zbXSo9GrDVaBydxpUMVKY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1k9SB/g0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PBu+kBwVrpwu0aLOAbJWnE+yeChvJS6HtcbuvsSx73w=; b=1k9SB/g08mKcs+326Avs5jgMo0
	duoEAAJrYib4P/kQaFZmcOYuL/MB+pZGtDth9ln03rVA9LebCUIr7Vosrpa4xKF3OcL9qSTvDn1sK
	N5bUZ26nJIhYRMw5DWFcp2dcPI+vkLl5pFAD9x6tbUG0ATr8MrtgyC2nVyjK/fw58npoaav8kGSxb
	POEMmJGyRdmup/5rP4qfjyg73XVMkq8Wr/JMGFgODGNb/LOhV+wCRNucbohptYBv3/ag52r7rewKM
	7Fm2IyXER6a4moKlWEboeBoGrpvejo7yJALXhp9rKIvxQp3AcbtGgXIMnBcPs4a/OCfXRgv1SILG6
	VKCRWj1w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38492 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sautn-0002ck-1G;
	Mon, 05 Aug 2024 11:25:07 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sauts-000tvI-BB; Mon, 05 Aug 2024 11:25:12 +0100
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
Subject: [PATCH RFC net-next v4 07/14] net: stmmac: dwmac1000: move PCS
 interrupt control
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sauts-000tvI-BB@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 05 Aug 2024 11:25:12 +0100

Control the PCS interrupt mask from phylink's pcs_enable() and
pcs_disable() methods rather than relying on driver variables.

This assumes that GMAC_INT_DISABLE_RGMII, GMAC_INT_DISABLE_PCSLINK
and GMAC_INT_DISABLE_PCSAN are all relevant to the PCS.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  | 33 +++++++++++++++----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 66c17be79dec..05b2df08cb0f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -56,12 +56,7 @@ static void dwmac1000_core_init(struct mac_device_info *hw,
 	writel(value, ioaddr + GMAC_CONTROL);
 
 	/* Mask GMAC interrupts */
-	value = GMAC_INT_DEFAULT_MASK;
-
-	if (hw->pcs)
-		value &= ~GMAC_INT_DISABLE_PCS;
-
-	writel(value, ioaddr + GMAC_INT_MASK);
+	writel(GMAC_INT_DEFAULT_MASK, ioaddr + GMAC_INT_MASK);
 
 #ifdef STMMAC_VLAN_TAG_USED
 	/* Tag detection without filtering */
@@ -376,6 +371,30 @@ static void dwmac1000_ctrl_ane(struct stmmac_priv *priv, bool ane,
 	dwmac_ctrl_ane(priv->ioaddr, GMAC_PCS_BASE, ane, srgmi_ral, loopback);
 }
 
+static int dwmac1000_mii_pcs_enable(struct phylink_pcs *pcs)
+{
+	struct stmmac_pcs *spcs = phylink_pcs_to_stmmac_pcs(pcs);
+	void __iomem *ioaddr = spcs->priv->hw->pcsr;
+	u32 intr_mask;
+
+	intr_mask = readl(ioaddr + GMAC_INT_MASK);
+	intr_mask &= ~GMAC_INT_DISABLE_PCS;
+	writel(intr_mask, ioaddr + GMAC_INT_MASK);
+
+	return 0;
+}
+
+static void dwmac1000_mii_pcs_disable(struct phylink_pcs *pcs)
+{
+	struct stmmac_pcs *spcs = phylink_pcs_to_stmmac_pcs(pcs);
+	void __iomem *ioaddr = spcs->priv->hw->pcsr;
+	u32 intr_mask;
+
+	intr_mask = readl(ioaddr + GMAC_INT_MASK);
+	intr_mask |= GMAC_INT_DISABLE_PCS;
+	writel(intr_mask, ioaddr + GMAC_INT_MASK);
+}
+
 static void dwmac1000_mii_pcs_get_state(struct phylink_pcs *pcs,
 					struct phylink_link_state *state)
 {
@@ -386,6 +405,8 @@ static void dwmac1000_mii_pcs_get_state(struct phylink_pcs *pcs,
 }
 
 static const struct phylink_pcs_ops dwmac1000_mii_pcs_ops = {
+	.pcs_enable = dwmac1000_mii_pcs_enable,
+	.pcs_disable = dwmac1000_mii_pcs_disable,
 	.pcs_config = dwmac_pcs_config,
 	.pcs_get_state = dwmac1000_mii_pcs_get_state,
 };
-- 
2.30.2


