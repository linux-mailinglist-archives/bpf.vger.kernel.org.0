Return-Path: <bpf+bounces-67905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BC6B5032F
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 18:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58FE03AC2FA
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 16:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA65A35AAB9;
	Tue,  9 Sep 2025 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Z+yN1BcF"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E272C35A28E;
	Tue,  9 Sep 2025 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436503; cv=none; b=OFzARYi98vUwjQp6w9mZM5Wrt75wwViTUOTx4Wun/3xcg7ODUw8Dqf+bC/VSZwK/zD00sXkBVbXw8s4B4c2Wic4+NLAtmMoNszEaFPqu8zPzSpeaRP1Dsq0TfzURjvRPDliOun/xQkAaO+UleB6ybLTBLJoOmV5Y4SSSWtkRrhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436503; c=relaxed/simple;
	bh=iKIK/IWih+KO1ekBBxD/BDCXJWMqsoLuysGxaogkOsI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=jQkkKEMfDnyEMK83W6cAedCbt4xKeQYy2FfWkdf3ol3hZWdL7REZwJEfaBv+ahBvjxYpU/SAkcOtihJ/K4ad1DjqnzHv+qnV1yBBpwW+Y9F05fQaDwf+PnyKHZDmPNOHtytLN6eeT3mMezLu1PcnrHHkPwNNz5EagqT+1lMedXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Z+yN1BcF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=P6pOrzXSnREVsUpXI8UJFOiH+uik773tcHNfNYJrtr4=; b=Z+yN1BcFZIWMFmnBEU0ra4C/ve
	8tjeaxBpzUE343F5vRVJti+U0C1zOQUNJVSjmc0cvhLvjPmHUK4OrUL7lPCJqnZwFnj4B6z6DDJwo
	a1pMNVTc8oMNUeWPPNIHwnUa9nLoBKLpcFgQoEM8iqHcxKAAwi4m7s5W+iRmdw4AhKDUkYXTlOMh4
	y4jv9k60TNulSBCRrBEVuQJZG1YyKElHRKu8Q3/PZchamTlNAFsrB8MovwdCQW6pmfB9ntG71/m0Y
	NE9ZTTW88zjumtRYzGU3CxElTbDK6NsHYukE9yRktWBEK72zmtbS2iZS4zjSjWzXsNk1zGzwt14Lq
	wXGwspFQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43460 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uw1Vs-0000000005h-3qkr;
	Tue, 09 Sep 2025 17:48:13 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uw1Vp-00000004MCd-3bUh;
	Tue, 09 Sep 2025 17:48:09 +0100
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
Subject: [PATCH net-next 09/11] net: stmmac: add stmmac_setup_ptp()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uw1Vp-00000004MCd-3bUh@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 09 Sep 2025 17:48:09 +0100

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


