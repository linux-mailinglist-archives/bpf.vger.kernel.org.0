Return-Path: <bpf+bounces-68124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3302B52FB5
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 13:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D83D169350
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 11:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E6331E100;
	Thu, 11 Sep 2025 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gxezcZe9"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368F63164DC;
	Thu, 11 Sep 2025 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589010; cv=none; b=HjAw2AFzFRvkWsqg5DE31gne+e1K57VHAswsKlVGOTDl52k6ny28abofw+plyR2ONc3SGXDG76oL+FlMYzs0SSnc+FkwkiY7NYyl8PDWPyqrCxxSK3SVpHLy8IilH8kb2v3EjCXDPAF29uDq5wWZOtSXCIYPaq22tBn0s/Qz7hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589010; c=relaxed/simple;
	bh=Putgk0qzrFHVluuAd2dPTdI6LXiA0YtV9hZlaZqtWM0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=vDQE29la62vKdT76HjmULTBD+xJy2rMC+mjM8p2modPyW2RngLPnTadGzbWpHyU6YxeQMAhQmBLNVSJPqJl/UqeFmu+/lcXbQ021QOJlx5mPMHRE9EleWncC++VSJNErLjQIzQBXBvT2LDCb/WFzmjoh0W4U6l0sePYul3Xe+30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gxezcZe9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mmtrcC40xcucgl7bIClgEBWb0BLF4GjZTQYLQ094U8w=; b=gxezcZe93o6e7CP4CWel5iOmkb
	p+I5cnEb9rxaKzlU4Puw5zO83SzwDj8f0ompGc+Uwt+uAFaQtMiIjS6RVGk8XTvknS3ouMhVLDPIr
	nsXp9jq/WcPC+1hD4nwvSKvrpejgqs9JWUPOypvlE12p6vuVvWnSBly3yut3sPlwQEEz23UGbzOk5
	ztGYxY5hYVlxngmZqcdLd305FO4p/qNPDMf+WIsCWP5y1fmm2kyXhG3Rg7Uq8GO/5+vUZ7VChYYFW
	+7/LYY937FqrzgYFyCXU4ROkM8PK37zjYCTVEcdm9+Ruma1E+m62Fwg4D9UPDX6fmCghPPlIRV6cV
	yOhvXESg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42836 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uwfBk-000000002tM-1WZX;
	Thu, 11 Sep 2025 12:10:04 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uwfBi-00000004j8v-3HcH;
	Thu, 11 Sep 2025 12:10:02 +0100
In-Reply-To: <aMKtV6O0WqlmJFN4@shell.armlinux.org.uk>
References: <aMKtV6O0WqlmJFN4@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gatien CHEVALLIER <gatien.chevallier@foss.st.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v2 06/11] net: stmmac: add __stmmac_release() to
 complement __stmmac_open()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uwfBi-00000004j8v-3HcH@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 11 Sep 2025 12:10:02 +0100

Rename stmmac_release() to __stmmac_release(), providing a new
stmmac_release() method. Update stmmac_change_mtu() to use
__stmmac_release(). Move the runtime PM handling into stmmac_open()
and stmmac_release().

This avoids stmmac_change_mtu() needlessly fiddling with the runtime
PM state, and will allow future changes to remove code from
__stmmac_open() and __stmmac_release() that should only happen when
the net device is administratively brought up or down.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 41 +++++++++++--------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index efce7b37f704..cb058e4c6ea9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3965,10 +3965,6 @@ static int __stmmac_open(struct net_device *dev,
 	if (!priv->tx_lpi_timer)
 		priv->tx_lpi_timer = eee_timer * 1000;
 
-	ret = pm_runtime_resume_and_get(priv->device);
-	if (ret < 0)
-		return ret;
-
 	if ((!priv->hw->xpcs ||
 	     xpcs_get_an_mode(priv->hw->xpcs, mode) != DW_AN_C73)) {
 		ret = stmmac_init_phy(dev);
@@ -3976,7 +3972,7 @@ static int __stmmac_open(struct net_device *dev,
 			netdev_err(priv->dev,
 				   "%s: Cannot attach to PHY (error: %d)\n",
 				   __func__, ret);
-			goto init_phy_error;
+			return ret;
 		}
 	}
 
@@ -4028,8 +4024,6 @@ static int __stmmac_open(struct net_device *dev,
 	stmmac_release_ptp(priv);
 init_error:
 	phylink_disconnect_phy(priv->phylink);
-init_phy_error:
-	pm_runtime_put(priv->device);
 	return ret;
 }
 
@@ -4043,21 +4037,23 @@ static int stmmac_open(struct net_device *dev)
 	if (IS_ERR(dma_conf))
 		return PTR_ERR(dma_conf);
 
+	ret = pm_runtime_resume_and_get(priv->device);
+	if (ret < 0)
+		goto err;
+
 	ret = __stmmac_open(dev, dma_conf);
-	if (ret)
+	if (ret) {
+		pm_runtime_put(priv->device);
+err:
 		free_dma_desc_resources(priv, dma_conf);
+	}
 
 	kfree(dma_conf);
+
 	return ret;
 }
 
-/**
- *  stmmac_release - close entry point of the driver
- *  @dev : device pointer.
- *  Description:
- *  This is the stop entry point of the driver.
- */
-static int stmmac_release(struct net_device *dev)
+static void __stmmac_release(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 	u32 chan;
@@ -4097,6 +4093,19 @@ static int stmmac_release(struct net_device *dev)
 
 	if (stmmac_fpe_supported(priv))
 		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
+}
+
+/**
+ *  stmmac_release - close entry point of the driver
+ *  @dev : device pointer.
+ *  Description:
+ *  This is the stop entry point of the driver.
+ */
+static int stmmac_release(struct net_device *dev)
+{
+	struct stmmac_priv *priv = netdev_priv(dev);
+
+	__stmmac_release(dev);
 
 	pm_runtime_put(priv->device);
 
@@ -5895,7 +5904,7 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 			return PTR_ERR(dma_conf);
 		}
 
-		stmmac_release(dev);
+		__stmmac_release(dev);
 
 		ret = __stmmac_open(dev, dma_conf);
 		if (ret) {
-- 
2.47.3


