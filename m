Return-Path: <bpf+bounces-68128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD5EB52FC0
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 13:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751DAA836F7
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 11:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0BD3203BB;
	Thu, 11 Sep 2025 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TDrtjxR8"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0003164AA;
	Thu, 11 Sep 2025 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589034; cv=none; b=PHNiaR7apRvW/AU81kM7G8/ceRX67yThVKvCaK4aRlkAIQ7e6ppi2tDz4MQoqBU3CgM+6t6L2h+4QopBrx9lQ8y9gQELo4fzEYLedacQdFoeq2q7UabYuregTxo9AaWFrx0zBWSK2kFNi3LkuGYyJCYRdoHOjMnZnhLDISU2VsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589034; c=relaxed/simple;
	bh=DteCJqbbmTWOUozC7AHlq3DtX4GrYqemIaauLOjyP+0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=MslFftvIOysoMsQwuNseNjRzhJ444GoC190H90R86R9p4sZxHgbcc8dt3yyrCtqI33yoE4Koo7RtVJUnrI1tdUkLWEfcrPg01iH1nboc8CxjXkZhg/1HhYpRwn/uVOR3jia7rTVSWCdUarTYGJbf/zz4LGvUfZYQpMbo5kqnKEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TDrtjxR8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UaUF+1oxIqM7igBk06+HqVf5uJg2gaKGvEQOVxo6dq4=; b=TDrtjxR8cr4gIanNuib9opbkK1
	A1ITI+7FoIy6Nzqjr2TtFDwMWRn6g5PwvLolGtTUBxuiI/8cq7GD6i1w7o2j0moHYHR40vZTNj18j
	v9xK4nGXUCi0O+6hZ0eRS6CpvJu51nxgkAqIwO2d2TIFx3JboLBo6pVrpQzlgrTgjO8FraDcjGbck
	2ufXz2LEn69TctjNjdHFBEQ0xTdHlKsWrX16AsomlDY9x4fhLm6KxSUGouCx5PC8jPNUghoRrUNHA
	6pahBKiFozMJ+UpWBGGqxsrNxssMqqdzKB2s3mjQjzFaRuz4gHyg/uw+xckbWUL2yrLGoclop80T0
	HUCn2IEQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53532 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uwfC5-000000002uq-1aUP;
	Thu, 11 Sep 2025 12:10:25 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uwfC3-00000004j9K-1HjH;
	Thu, 11 Sep 2025 12:10:23 +0100
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
Subject: [PATCH net-next v2 10/11] net: stmmac: move PTP support check into
 stmmac_init_timestamping()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uwfC3-00000004j9K-1HjH@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 11 Sep 2025 12:10:23 +0100

Move the PTP support check from stmmac_init_tstamp_counter() into
stmmac_init_timestamping() as it makes more sense to be there.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ea2d3e555fe8..ff12c4b34eb6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -734,9 +734,6 @@ static int stmmac_init_tstamp_counter(struct stmmac_priv *priv,
 	u32 sec_inc = 0;
 	u64 temp = 0;
 
-	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp))
-		return -EOPNOTSUPP;
-
 	if (!priv->plat->clk_ptp_rate) {
 		netdev_err(priv->dev, "Invalid PTP clock rate");
 		return -EINVAL;
@@ -787,12 +784,14 @@ static int stmmac_init_timestamping(struct stmmac_priv *priv)
 	if (priv->plat->ptp_clk_freq_config)
 		priv->plat->ptp_clk_freq_config(priv);
 
+	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp)) {
+		netdev_info(priv->dev, "PTP not supported by HW\n");
+		return -EOPNOTSUPP;
+	}
+
 	ret = stmmac_init_tstamp_counter(priv, STMMAC_HWTS_ACTIVE);
 	if (ret) {
-		if (ret == -EOPNOTSUPP)
-			netdev_info(priv->dev, "PTP not supported by HW\n");
-		else
-			netdev_warn(priv->dev, "PTP init failed\n");
+		netdev_warn(priv->dev, "PTP init failed\n");
 		return ret;
 	}
 
-- 
2.47.3


