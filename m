Return-Path: <bpf+bounces-68122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D41EB52FAD
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 13:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C25481552
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 11:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D37431A57E;
	Thu, 11 Sep 2025 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="B83D32Pm"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACF73101D2;
	Thu, 11 Sep 2025 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588999; cv=none; b=BmnTYTxoXhCAM16b36fBBUaSlEsFCfLSO4p0Dm7lobbeTmwz4fIuFt/71AX1LFSMbNuaBH26YfpSNdx5QjcTGG69CgrtpzSGJVpxLOOBcNKWDQ3NfUS+tqLWPNwycbxyM/kljp65i6GtfpMSUKYbV4E8mexnTAIb243lFS4UvQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588999; c=relaxed/simple;
	bh=3Adjdx1ulOnW9chAeaorK34ak2lptv77tl++awocAqM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=q/qJPnrdOvREtW1kqsvouypFkFBGlDQrzoQDnUBUlW0Mpj6NZbVkrpbsUdHWZvH/1NVN5AtSVeorjftdxwt1aApAWI6MPj7FHhnHeSbRvZMa4Vs2onlyE9BLsIKg43ZlvmkP/5w4z4R44CgCo4rQYWkgLCDTxM5O7060VRzs9d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=B83D32Pm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eM6nhXTaXN2xjQ81ddeyk5Wyn11ya+RpHkNOP56tyvY=; b=B83D32PmuvNPb1F1iVO+0cb+8D
	c41ijOgzXjjWb7B8IuJnc18G/Z7xbXIF/g6WkW5YhGIm6VebZT8ZwxoElE34ky00ndapp21rPUEgp
	bTI8XP32Z91RGQ31EIlzB0ZnVDqGxBxlkmrRAli5oumumMeDnFSuzBOJI+dlSVSI5YlA3KFvoTB7p
	jfcTLYFixIn1Ik/Fgw83Z/e/C5U+PLB0DuXSubcZCX4DI+FLm9NXPCBGt/2rEim9ZS7rZfH7vlLh7
	Q7hw8ZsUpwvVlS7/AfIe2cSYjbyZurZTttu3PP8A3b951SlJrAveJ8R4/E3cupTUqU8qK8FMk3Dho
	qV9H+yXQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40152 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uwfBZ-000000002sZ-24qj;
	Thu, 11 Sep 2025 12:09:53 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uwfBY-00000004j8j-2FtN;
	Thu, 11 Sep 2025 12:09:52 +0100
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
Subject: [PATCH net-next v2 04/11] net: stmmac: fix stmmac_xdp_open()
 clk_ptp_ref error cleanup
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uwfBY-00000004j8j-2FtN@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 11 Sep 2025 12:09:52 +0100

Neither stmmac_xdp_release() nor the normal paths of stmmac_xdp_open()
touch clk_ptp_ref, so stmmac_xdp_open() should not be doing anything
with this clock. However, in its error path, it calls
stmmac_hw_teardown() which disables and unprepares this clock, which
can lead to the clock state becoming unbalanced when the netdev is
taken administratively down.

Remove this call to stmmac_hw_teardown(), and as this is the last user
of this function, remove the function as well.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 167405aac5b8..8cb1a97e18af 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3568,13 +3568,6 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 	return 0;
 }
 
-static void stmmac_hw_teardown(struct net_device *dev)
-{
-	struct stmmac_priv *priv = netdev_priv(dev);
-
-	clk_disable_unprepare(priv->plat->clk_ptp_ref);
-}
-
 static void stmmac_free_irq(struct net_device *dev,
 			    enum request_irq_err irq_err, int irq_idx)
 {
@@ -6992,7 +6985,6 @@ int stmmac_xdp_open(struct net_device *dev)
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
 
-	stmmac_hw_teardown(dev);
 init_error:
 	free_dma_desc_resources(priv, &priv->dma_conf);
 dma_desc_error:
-- 
2.47.3


