Return-Path: <bpf+bounces-68126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AE5B52FBB
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 13:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750C5A836B7
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 11:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5C4320396;
	Thu, 11 Sep 2025 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OnJM/tr7"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A4A314B9E;
	Thu, 11 Sep 2025 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589023; cv=none; b=dp37f8/G05cGkqi7zj7oec6PveNS9Jwn9rE03Vbf2P7XKJny5S5tDQcsLTzINjHYmMq/Un/j/4jEjX1+wB25NEc92guS5UfV350gHztXD0UUyivd6rcCh5Zp0FGoFNYesJcbOtczUkASDrKzVLFt1csWFoNnZsF+I9+EUd46vLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589023; c=relaxed/simple;
	bh=9jXsqAuu00Qxjt0sJTKwkwON/xPjeBJ7xZSMEumjQ0s=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=hycQsZMnqafaOoCMl1wiwz56zL2FyV0CUYSum+YoEFAr/Bx599mN+MQ+8QYzjvVhfLxt4FRbFRkW0zRMPPUdR9EmnGGAWasMDMH+wwz1vgmr2fh7LznYbMQPDAozF9DUGVrfOHFJga/FMsqNj/873F4VXMgAOXNGKVpiZJBGovo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OnJM/tr7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9b3//ARVpkHYjlQHOj5QLrD/YhlzfhZeBDi+nhBNlxA=; b=OnJM/tr7uvOtI8LIoe96orHO/U
	ZHhXIlzSuI28gUdueBPnlhiAJJ0waR4da+huO965Tzn0L9k2Fu9WWba86DxgnRNZKDr1GBYTjKqR4
	RreCb3YPGxCAhQZZwQSHbvua/a3SK9kk7BmiQggGBbWJNFzHk1nu0zjVnlHONvCoYrmssoyOfqs6o
	dle3njvggjxgNpP8UTpXPMONR1CfyDeghjLotnrJJx3u/+joehXUbi37Uac8Cj2pjNiRGxwIzpq9q
	fSGVAsoy9On7c0/DfKJWAxyFtV0nR0IiZxESccwohLVoYA6P5YOGqDs4TWKwaMYrMXWIL5OUtOyss
	j5mdSCnw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51882 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uwfBu-000000002uB-1zMM;
	Thu, 11 Sep 2025 12:10:14 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uwfBt-00000004j98-0Tio;
	Thu, 11 Sep 2025 12:10:13 +0100
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
Subject: [PATCH net-next v2 08/11] net: stmmac: rename stmmac_init_ptp()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uwfBt-00000004j98-0Tio@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 11 Sep 2025 12:10:13 +0100

Changes to the stmmac driver to fix various issues with PTP have made
stmmac_init_ptp() less about initialising the entire PTP block, and
now primarily deals with the packet timestamping support. The exception
to this is ptp_clk_freq_config(), which is an odditiy. It remains
as stmmac_init_ptp() is used both at .ndo_open() time and in the
resume paths.

However, restructuring this code to make it more easily readable makes
the continued use of "init_ptp" confusing.

In preparation to cleaning up the (re-)initialisation of timestamping,
rename the existing stmmac_init_ptp() to stmmac_init_timestamping()
which better reflects its functionality.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 716c7e21baf1..7cbac3ac2a9d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -773,13 +773,13 @@ static int stmmac_init_tstamp_counter(struct stmmac_priv *priv,
 }
 
 /**
- * stmmac_init_ptp - init PTP
+ * stmmac_init_timestamping - initialise timestamping
  * @priv: driver private structure
  * Description: this is to verify if the HW supports the PTPv1 or PTPv2.
  * This is done by looking at the HW cap. register.
  * This function also registers the ptp driver.
  */
-static int stmmac_init_ptp(struct stmmac_priv *priv)
+static int stmmac_init_timestamping(struct stmmac_priv *priv)
 {
 	bool xmac = priv->plat->has_gmac4 || priv->plat->has_xgmac;
 	int ret;
@@ -3502,7 +3502,7 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 				    ERR_PTR(ret));
 	}
 
-	if (stmmac_init_ptp(priv) == 0 && ptp_register)
+	if (stmmac_init_timestamping(priv) == 0 && ptp_register)
 		stmmac_ptp_register(priv);
 
 	if (priv->use_riwt) {
-- 
2.47.3


