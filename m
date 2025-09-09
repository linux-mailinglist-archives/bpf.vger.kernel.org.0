Return-Path: <bpf+bounces-67907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D34B50331
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 18:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8D51C63247
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 16:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0B5248F5E;
	Tue,  9 Sep 2025 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fOGqQAiH"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88BD334734;
	Tue,  9 Sep 2025 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436510; cv=none; b=cz1zJNdcPHKFA12bAvCeHCHtGNwuwJV52YK3uCgUkSB1zu21yKV/A//k3q54H1IH50b/iQ7riUyXVF+ZJ0jb6G0pjvs2q9dHsA2GN4Sz36G963wyY56Mysi7D8GHcptOKCpDWSZLl+qt9aqa9Y6wMtiohaF5oN95o4BSRcve9YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436510; c=relaxed/simple;
	bh=P6ziM++D7EGjvykroQP/8gShFk9KhYnpWo7xbEc2R64=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Np1TFZKEysiZO8g3uifAZjNiIFFoQs6ZxjuGk5sj1wRiuNYoNlQSyH+3VCLovHLaKQN5Wb0ZtnXNyvi7JgXHPScpxOclUOCacuyCKU4gicDVirxSzY2bb8FBvr5jw8vSBbPNTBUm2Keg2Zt74j8n6kEZkDuFUMfy4LfDgWiFXho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fOGqQAiH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rz0hbAq7fEga5zRohMAv5O8tOvXUWgvThRUc5VepeC8=; b=fOGqQAiHccsvB7ENctq9tyL9Hy
	vGSFLvDRw+4U/XUQETE04K0cyRdoCpe8ELqAeyOth0cDv6pfiS9+aYDk1BVw2mqdapKuMTTUkbaEs
	8gR0XMZjLqCzNwxLiSnBbkAT0I6+uowSOJExq5lko/5u8TKQIqqjQed0GLyx/PFYAqDk9kWbIclBn
	s5MR6orvBn8GuW+h1Xm4OkmTbJlF4YLyIoiQvPJK7VRLs7oqXDs53W0l4jKUNnsBwHUMKoykQu0Ic
	SyQBLba2QqPsCkdGDq54mhgnvk+KKOWys9n3XeDVBnbwE2fmboR1puh4NJBNI/9ZpSQGsi6LZLXBJ
	r375amDg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55444 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uw1W2-0000000006H-0lfA;
	Tue, 09 Sep 2025 17:48:22 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uw1W0-00000004MCp-0Iuc;
	Tue, 09 Sep 2025 17:48:20 +0100
In-Reply-To: <aMBaCga5UAXT03Bi@shell.armlinux.org.uk>
References: <aMBaCga5UAXT03Bi@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 11/11] net: stmmac: move timestamping/ptp init to
 stmmac_hw_setup() caller
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uw1W0-00000004MCp-0Iuc@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 09 Sep 2025 17:48:20 +0100

Move the call to stmmac_init_timestamping() or stmmac_setup_ptp() out
of stmmac_hw_setup() to its caller after stmmac_hw_setup() has
successfully completed. This slightly changes the ordering during
setup, but should be safe to do.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ff12c4b34eb6..8c8ca5999bd8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3436,7 +3436,7 @@ static void stmmac_safety_feat_configuration(struct stmmac_priv *priv)
  *  0 on success and an appropriate (-)ve integer as defined in errno.h
  *  file on failure.
  */
-static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
+static int stmmac_hw_setup(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 	u32 rx_cnt = priv->plat->rx_queues_to_use;
@@ -3507,11 +3507,6 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 
 	stmmac_mmc_setup(priv);
 
-	if (ptp_register)
-		stmmac_setup_ptp(priv);
-	else
-		stmmac_init_timestamping(priv);
-
 	if (priv->use_riwt) {
 		u32 queue;
 
@@ -4000,12 +3995,14 @@ static int __stmmac_open(struct net_device *dev,
 		}
 	}
 
-	ret = stmmac_hw_setup(dev, true);
+	ret = stmmac_hw_setup(dev);
 	if (ret < 0) {
 		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
 		goto init_error;
 	}
 
+	stmmac_setup_ptp(priv);
+
 	stmmac_init_coalesce(priv);
 
 	phylink_start(priv->phylink);
@@ -7917,7 +7914,7 @@ int stmmac_resume(struct device *dev)
 	stmmac_free_tx_skbufs(priv);
 	stmmac_clear_descriptors(priv, &priv->dma_conf);
 
-	ret = stmmac_hw_setup(ndev, false);
+	ret = stmmac_hw_setup(ndev);
 	if (ret < 0) {
 		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
 		mutex_unlock(&priv->lock);
@@ -7925,6 +7922,8 @@ int stmmac_resume(struct device *dev)
 		return ret;
 	}
 
+	stmmac_init_timestamping(priv);
+
 	stmmac_init_coalesce(priv);
 	phylink_rx_clk_stop_block(priv->phylink);
 	stmmac_set_rx_mode(ndev);
-- 
2.47.3


