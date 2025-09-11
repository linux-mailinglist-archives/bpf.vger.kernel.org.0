Return-Path: <bpf+bounces-68127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FE4B52FC8
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 13:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF168188AB51
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 11:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F89631CA4A;
	Thu, 11 Sep 2025 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PO4bmsa0"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F69431C57B;
	Thu, 11 Sep 2025 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589030; cv=none; b=e2qbddmOo84Pc35umL6yvGvAF0fovfbjKM2KTYH8TOUbTsQPiP2c2jHVkOGF/hovCXrblAWTZvzXDqr3RgoMnn2HZ0HeHO8HuqN0owlY2rtHlldsmJbSbF37DglhbHUIy/Zjtw5lTGu/c9BJr+xngq92pIJmgA3S/GaK87sI5m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589030; c=relaxed/simple;
	bh=iKIK/IWih+KO1ekBBxD/BDCXJWMqsoLuysGxaogkOsI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=j3Gqbi9NcqFy/3bt4aiUoQTnzTEefW3o2+ciWX2H8vUAPQH0XHctyV+1gdAyNYkTMBYb6kPw+qcHdyWareAmqdW5I/mWLh9ilW2Vyhw1QCyF1bjqSlM8LFCUR7jAF8JPQmPkrmLpr3JzdpgxGhCpRwpCUtLE1GNO7QxrLpuqEss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PO4bmsa0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=P6pOrzXSnREVsUpXI8UJFOiH+uik773tcHNfNYJrtr4=; b=PO4bmsa03IihYSNqN4WAaVRlkW
	IOXv/lMflRTTBRkYB8QVVkRQ1AUqAH8noX2Zj69aTTStxnixmh07lLefzblyPMLUPZIOAYoEFL+Hw
	rkflXoXrTunM/j+mhDx597K/9d9Y2opjWDGJABnKlUCK4vIiMHGhHqylyFVVuO4a3Sz/epRTotGkX
	AWq1khpYleBKFFWljFfWqFAAdIcBiN6hCQ9zge4vpNTQBZIOhlZpD//V0uIu4YsvgQoX7R7zJOwWI
	cJJe2JjEvGUex4aCfO3s25upzJ2jgAUs7SIxHcncrBbB1Xkz4h6tjL0u1Cu+JCIhkKg5dYo20Ypwj
	O8I7lnaA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53522 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uwfC1-000000002uZ-2Pm5;
	Thu, 11 Sep 2025 12:10:21 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uwfBy-00000004j9E-0uDh;
	Thu, 11 Sep 2025 12:10:18 +0100
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
Subject: [PATCH net-next v2 09/11] net: stmmac: add stmmac_setup_ptp()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uwfBy-00000004j9E-0uDh@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 11 Sep 2025 12:10:18 +0100

Add a function to setup PTP, which will enable the clock, initialise
the timestamping, and register with the PTP clock subsystem. Call this
when we want to register the PTP clock in stmmac_hw_setup(), otherwise
just call the

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 28 ++++++++++++-------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7cbac3ac2a9d..ea2d3e555fe8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -820,6 +820,20 @@ static int stmmac_init_timestamping(struct stmmac_priv *priv)
 	return 0;
 }
 
+static void stmmac_setup_ptp(struct stmmac_priv *priv)
+{
+	int ret;
+
+	ret = clk_prepare_enable(priv->plat->clk_ptp_ref);
+	if (ret < 0)
+		netdev_warn(priv->dev,
+			    "failed to enable PTP reference clock: %pe\n",
+			    ERR_PTR(ret));
+
+	if (stmmac_init_timestamping(priv) == 0)
+		stmmac_ptp_register(priv);
+}
+
 static void stmmac_release_ptp(struct stmmac_priv *priv)
 {
 	stmmac_ptp_unregister(priv);
@@ -3494,16 +3508,10 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 
 	stmmac_mmc_setup(priv);
 
-	if (ptp_register) {
-		ret = clk_prepare_enable(priv->plat->clk_ptp_ref);
-		if (ret < 0)
-			netdev_warn(priv->dev,
-				    "failed to enable PTP reference clock: %pe\n",
-				    ERR_PTR(ret));
-	}
-
-	if (stmmac_init_timestamping(priv) == 0 && ptp_register)
-		stmmac_ptp_register(priv);
+	if (ptp_register)
+		stmmac_setup_ptp(priv);
+	else
+		stmmac_init_timestamping(priv);
 
 	if (priv->use_riwt) {
 		u32 queue;
-- 
2.47.3


