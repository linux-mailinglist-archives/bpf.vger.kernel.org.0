Return-Path: <bpf+bounces-68125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 399D2B52FB8
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 13:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87C23A8EDD
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 11:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573EC31B13A;
	Thu, 11 Sep 2025 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sje16V5F"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2563164DC;
	Thu, 11 Sep 2025 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589017; cv=none; b=gYP4h1F2aSr19Kbni01HBH3kJr1wRvMoBHeTz0MlZmga42HJo5KhjNF7a0/mqFbzGWnzf8+2Lu7HPjfdXAKSsJFNBhge+YMIU7dYLQZM6s9RmIAE6W58Tw4r+WEO4Vd0cPL085IiEaH3Xf7qYF9kHjgaDZ+1JO1SQhWiyeK4uYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589017; c=relaxed/simple;
	bh=3qkI+As7kffDfYiHM6aKEXAr9lRsqb+/JBrKG4SnQXw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=NU8EflgifAI6USyAbnG3NtCMoeibuJQPZ+aq0ozA6txJSXBh+c5vHHCkuouq2kA0GU+lkYyiC5ZAG60ARTyG6AEjTB88iNA5ud5VkzGbYmfybJinF4f8K27llq5Ohll1xlWVQRxPRH2KstY/RV900LezUTRSErAyh0VkZ2qVJVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sje16V5F; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=B9mlUuiZUBrX7aQtqBT3TxfiZmcQldNbBylxYkZ/v1U=; b=sje16V5F0iMZanbBcmAqQrsS+H
	LTbYvk0irpitUgvghLte94X0OH3TP2Y5bsTe/UIo0gCKmSv0XOXenx7QINhtl5Xeppact3h2hAAwn
	NtWL9vgnOGzBirX2k8nDpp499kJPT3PstKyRxinO0f6ngXDYSeZflQS/WVnsFXu3FJurOmPrTE2Ri
	3YZ+oZ7Gh1zN7N5ov/ZHJ+TLoCgqBeQIG4JV0tlF1bRjIRyrFRvfvfAXxhGxRasA1gWTb2esYSKjZ
	szcJpZcwiwG3zJC3diRrLtNw1v8LWpBKxV6063GXeG8eLaQ41esjYsKYVAXRLsLHj8WoPM+/jkH3u
	3BocF60g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42850 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uwfBp-000000002tp-1aHi;
	Thu, 11 Sep 2025 12:10:09 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uwfBn-00000004j92-3nj1;
	Thu, 11 Sep 2025 12:10:08 +0100
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
Subject: [PATCH net-next v2 07/11] net: stmmac: move stmmac_init_ptp()
 messages into function
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uwfBn-00000004j92-3nj1@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 11 Sep 2025 12:10:07 +0100

Move the stmmac_init_ptp() messages from stmmac_hw_setup() to
stmmac_init_ptp(), which will allow further cleanups.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index cb058e4c6ea9..716c7e21baf1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -788,8 +788,13 @@ static int stmmac_init_ptp(struct stmmac_priv *priv)
 		priv->plat->ptp_clk_freq_config(priv);
 
 	ret = stmmac_init_tstamp_counter(priv, STMMAC_HWTS_ACTIVE);
-	if (ret)
+	if (ret) {
+		if (ret == -EOPNOTSUPP)
+			netdev_info(priv->dev, "PTP not supported by HW\n");
+		else
+			netdev_warn(priv->dev, "PTP init failed\n");
 		return ret;
+	}
 
 	priv->adv_ts = 0;
 	/* Check if adv_ts can be enabled for dwmac 4.x / xgmac core */
@@ -3497,12 +3502,7 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 				    ERR_PTR(ret));
 	}
 
-	ret = stmmac_init_ptp(priv);
-	if (ret == -EOPNOTSUPP)
-		netdev_info(priv->dev, "PTP not supported by HW\n");
-	else if (ret)
-		netdev_warn(priv->dev, "PTP init failed\n");
-	else if (ptp_register)
+	if (stmmac_init_ptp(priv) == 0 && ptp_register)
 		stmmac_ptp_register(priv);
 
 	if (priv->use_riwt) {
-- 
2.47.3


