Return-Path: <bpf+bounces-68123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A9CB52FB4
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 13:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21484A8362D
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 11:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E44331B126;
	Thu, 11 Sep 2025 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="d6Z1uDhH"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEBE31DDBC;
	Thu, 11 Sep 2025 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589006; cv=none; b=f4AB9cSGozfLv0kiSKtgDtAiX+Jdd/gGzckYAK3A+Y+NYrhgZ7AK1aaVANjfoKw2IWCpRRK2jpFqRtzvOE1j1aY5e87EbPwRz30JN5a0vLAtfMQzLLeJInH8i64+coBy2iR6sNfjBEun/XFAmKaMv2D0gECod9WUT6Fh9qJjeTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589006; c=relaxed/simple;
	bh=HH63LRUJPJgmRkKnSYlgDQfdXgcPxqVVPBrRyudQHpU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=RPjkerY7pJHsf5oQgYk7AdeJCeIBs18j14+B6eYYpFrQN0CXyqWHU0I+wD3S+W+K+ThctAzx2pAl5Rgd2fLq3dvxnWHYpC8e7bSPqZENlKr3f/cf0gchwnQR7XUYHWDo+L3u3L5qh0Eb3I34/V0IzyTtqZYzeRjSmhHm5kIkvYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=d6Z1uDhH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Yh6AFhinNITQqNLY1hSWIvQH3NkLkA7t+Dx3cTizntA=; b=d6Z1uDhHOvu5nZrz/WgkmSA3AU
	SDosRHgjqTqT3Icp6Xe1/dHHw0k6QFTIE5XImnfLDb3FAG+ZxX+p9iAP0gSHlOJXosT1NJqdGBRls
	SApiVDL/c2G1KbSZvAmYgKfjZnDTWemUABPLwGBqHXHcLFjJN1f3cQw9JqvB4xhr1lWFzuBn2okSK
	wzMFb/Uxj4SPJQR3D1zXg6+nbQV4V/2r+aOQho1hbhCwSQ3zLJWJ3BEkALWSZgFSVGGWJ2YJeeQvd
	Cqc2c1WDBFy5NyRhycC4On5xeAEV+jfnsn3FPf6I8ynBE60/9Wm4JMLOujbgeAHUVlxTRPd5wr8tg
	mcLzY5zw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40158 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uwfBe-000000002sv-2oNZ;
	Thu, 11 Sep 2025 12:09:58 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uwfBd-00000004j8p-2lDi;
	Thu, 11 Sep 2025 12:09:57 +0100
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
Subject: [PATCH net-next v2 05/11] net: stmmac: unexport
 stmmac_init_tstamp_counter()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uwfBd-00000004j8p-2lDi@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 11 Sep 2025 12:09:57 +0100

Nothing outside of stmmac_main.c makes use of
stmmac_init_tstamp_counter(), so there's no point exporting it for
modules, or even having it non-static. Remove the export and make
it static.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      | 1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index ec6bccb13710..151f08e5e85d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -392,7 +392,6 @@ int stmmac_pcs_setup(struct net_device *ndev);
 void stmmac_pcs_clean(struct net_device *ndev);
 void stmmac_set_ethtool_ops(struct net_device *netdev);
 
-int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags);
 void stmmac_ptp_register(struct stmmac_priv *priv);
 void stmmac_ptp_unregister(struct stmmac_priv *priv);
 int stmmac_xdp_open(struct net_device *dev);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 8cb1a97e18af..efce7b37f704 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -726,7 +726,8 @@ static int stmmac_hwtstamp_get(struct net_device *dev,
  * Will be rerun after resuming from suspend, case in which the timestamping
  * flags updated by stmmac_hwtstamp_set() also need to be restored.
  */
-int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
+static int stmmac_init_tstamp_counter(struct stmmac_priv *priv,
+				      u32 systime_flags)
 {
 	bool xmac = priv->plat->has_gmac4 || priv->plat->has_xgmac;
 	struct timespec64 now;
@@ -770,7 +771,6 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(stmmac_init_tstamp_counter);
 
 /**
  * stmmac_init_ptp - init PTP
-- 
2.47.3


