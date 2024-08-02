Return-Path: <bpf+bounces-36282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E69D6945CA3
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 12:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2CF1F2223F
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 10:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE401E211B;
	Fri,  2 Aug 2024 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DtmHklPd"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD581DF681;
	Fri,  2 Aug 2024 10:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722596188; cv=none; b=NMgttN2Jg0phEv8BGo67dL4UgRU1jI1lm6n0q91ZOqeTFL5rxI0FEJM/lBfBIXdbrUvBCK0ByEkzuIUOKLZS5MjLKwe1Ahojm1WuxWXkuESAj27GEMMmu0hfZcYPGM0KyKtYOIhg3pPC9wwSzcigsmYhknerONq9XSehlFuhvxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722596188; c=relaxed/simple;
	bh=p0uIwvhdMslJ15HiYSN+8dwJcmTVSEEqrRqA5I6sMKM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=UGONY+rdR+JZuN8kdUxihU19KeLukjmxHl52XIv/Z6+3PR0czyZn2E25fpYhF0F9gcvVmRE4odB8ipzRXtYXgvVwJ8j7bSMEkCB5SfphBMouhdtASm4u3Fh7teFg9KEyMeH2ZXYvjx3VqSPfmRypP/jEqBmn4CfiryUbinzIXUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DtmHklPd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2bZWIDKO7QK63SdQEWdaWdYkEx8EK7NXAOA4z7KnCes=; b=DtmHklPdtrhWJGHoRM2rYpDpWc
	o3pZhqXOfXPwc2mgQ+g9tNH28IcRUfukvqDbvc3JG8OPxrXQ4uAusoGLDNRNuF2xzhzn46mWlkT9v
	vzAO4K8JRfo2xQ3YEQjakvFUUTSTkgFbq+OgdXsPyg/gn/RB8Oof2ZeD4RrQ+ST4mb6GeETnK+8I+
	3V0GpKr0t2MxgXEwhpX7Z2JFcztqbJtWeZokbG5d70Z7PM/Klovy6dFpOJjVnCjgbiJF39AEXOfsJ
	7c7PGXbR+2a9GLerSZJq+ho6X2nqWnQps9M0o1ig9lEIGhEYiSgUNX/OPwhrAgV4uXcoJJTQvP5bc
	gdUlgoQQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57304 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sZpox-0006GF-2y;
	Fri, 02 Aug 2024 11:47:41 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sZpov-000eI5-KP; Fri, 02 Aug 2024 11:47:37 +0100
In-Reply-To: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
References: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
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
Subject: [PATCH net-next 14/14] net: stmmac: Activate Inband/PCS flag based on
 the selected iface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sZpov-000eI5-KP@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 02 Aug 2024 11:47:37 +0100

From: Serge Semin <fancer.lancer@gmail.com>

The HWFEATURE.PCSSEL flag is set if the PCS block has been synthesized
into the DW GMAC controller. It's always done if the controller supports
at least one of the SGMII, TBI, RTBI PHY interfaces. If none of these
interfaces support was activated during the IP-core synthesize the PCS
block won't be activated either and the HWFEATURE.PCSSEL flag won't be
set. Based on that the RGMII in-band status detection procedure
implemented in the driver hasn't been working for the devices with the
RGMII interface support and with none of the SGMII, TBI, RTBI PHY
interfaces available in the device.

Fix that just by dropping the dma_cap.pcs flag check from the conditional
statement responsible for the In-band/PCS functionality activation. If the
RGMII interface is supported by the device then the in-band link status
detection will be also supported automatically (it's always embedded into
the RGMII RTL code). If the SGMII interface is supported by the device
then the PCS block will be supported too (it's unconditionally synthesized
into the controller). The later is also correct for the TBI/RTBI PHY
interfaces.

Note while at it drop the netdev_dbg() calls since at the moment of the
stmmac_check_pcs_mode() invocation the network device isn't registered. So
the debug prints will be for the unknown/NULL device.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
[rmk: fix build errors, only use PCS for SGMII if priv->dma_cap.pcs is set]
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c    | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3e43f2d6d49f..a9b5e2a34b10 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1133,18 +1133,10 @@ static void stmmac_check_pcs_mode(struct stmmac_priv *priv)
 {
 	int interface = priv->plat->mac_interface;
 
-	if (priv->dma_cap.pcs) {
-		if ((interface == PHY_INTERFACE_MODE_RGMII) ||
-		    (interface == PHY_INTERFACE_MODE_RGMII_ID) ||
-		    (interface == PHY_INTERFACE_MODE_RGMII_RXID) ||
-		    (interface == PHY_INTERFACE_MODE_RGMII_TXID)) {
-			netdev_dbg(priv->dev, "PCS RGMII support enabled\n");
-			priv->hw->pcs = STMMAC_PCS_RGMII;
-		} else if (interface == PHY_INTERFACE_MODE_SGMII) {
-			netdev_dbg(priv->dev, "PCS SGMII support enabled\n");
-			priv->hw->pcs = STMMAC_PCS_SGMII;
-		}
-	}
+	if (phy_interface_mode_is_rgmii(interface))
+		priv->hw->pcs = STMMAC_PCS_RGMII;
+	else if (priv->dma_cap.pcs && interface == PHY_INTERFACE_MODE_SGMII)
+		priv->hw->pcs = STMMAC_PCS_SGMII;
 }
 
 /**
-- 
2.30.2


