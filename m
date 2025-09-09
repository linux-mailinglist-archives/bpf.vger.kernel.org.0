Return-Path: <bpf+bounces-67906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBE3B5032E
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 18:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499731C63887
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 16:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984C41E25F2;
	Tue,  9 Sep 2025 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nUtHSeUf"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0B5334734;
	Tue,  9 Sep 2025 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436507; cv=none; b=D7oIocG2pfTJXzLt4QocGPTc9ZD8TTi/01q45dbXt+kfo2D4YzY2SlWR0ZfonSdXVCbyJRIfbgO7PeQxNpKof5NEPW9U+mATFf2fWCLyW3rmpUNsg5O3kB7dedydREqh7E1AzpGtkd2dGjE3wWaJ6i0AqLJsoY/X/0fGX1KKxMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436507; c=relaxed/simple;
	bh=DteCJqbbmTWOUozC7AHlq3DtX4GrYqemIaauLOjyP+0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=lZZTeZXzgJ4gVTojgJ9VFyGm0el/nR+ft0C04EBuYohmid1SO19AkJj491pShsOwcFqBi5PqHv4URmK5AF9MvxQ4S2BfdaCPReBfpIL9Fopf5wP4cssDMsHXL1Bo1bLOaJKnpiQ6gl83ddqtnPoTnkvyLb/KxAp+jeHIn0sz2us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nUtHSeUf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UaUF+1oxIqM7igBk06+HqVf5uJg2gaKGvEQOVxo6dq4=; b=nUtHSeUf7l4sG4SOGmy8VoEo2f
	hRQc/Ad7ym+SmzceejGM2JeV4U4zNQXktMvI70CwGMVoLRrQ43hJQlHDeLtlBrcPUNw8nxQAW846G
	dpUt4qZiUc534f98ndmRdogzHd6vo0v9WNUqSwAInqXUxlrNbhrEuJa1elaT/0wHZx8m1aYfcszT7
	gDnsWfcwezLn3LMhA6wN6bmFSXPNNtXP8DysI6Z1PICrDrLE8t3xsae1l91njO77Jzj/JRREzqrdF
	OMezn41+fseRYqjA9d9VhI09+ughH6OHH45X4ldWjE/LNG4a56eGZ503HS9CCb+/rbcEE+5z+FYDP
	ZHHVtWBA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43476 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uw1Vx-0000000005x-39NK;
	Tue, 09 Sep 2025 17:48:18 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uw1Vu-00000004MCj-44TY;
	Tue, 09 Sep 2025 17:48:14 +0100
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
Subject: [PATCH net-next 10/11] net: stmmac: move PTP support check into
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
Message-Id: <E1uw1Vu-00000004MCj-44TY@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 09 Sep 2025 17:48:14 +0100

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


