Return-Path: <bpf+bounces-67900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0B8B5031D
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 18:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A3217C3F0
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 16:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0684A3570C0;
	Tue,  9 Sep 2025 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YhL7AxTO"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF6E33A03E;
	Tue,  9 Sep 2025 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436474; cv=none; b=rv7CTnlRJwlmpW5zs19smR4MipIvd7iLNfIsmnCG0gr22JVhTId2YGoG/80JO1FmbyV3VVkd+BT/5Dar14UMsr0KSN7Fu+VejHMitM+FENmcU0kvBWHUvyTTww83MD6IwXtFI6dUKpfNurIiVl1gwxM97gVryAJO55Ki3pLWT+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436474; c=relaxed/simple;
	bh=3Adjdx1ulOnW9chAeaorK34ak2lptv77tl++awocAqM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=TBrQLpxYwK2//Ow9Mqo/ymYq6BTlS2XFLC+ooAAScy4O5yH/a1bx4UpzE98j+Mif7/Smiyw/dOIR7by66eRvMNH9e2w6eNB35JfFbzgW5+e/PB3Uxbn5RJwFRkCvZ3/tK6Ae7Jqba9adAClegDKbn15JfTWEoM3CnadoKaoencA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YhL7AxTO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eM6nhXTaXN2xjQ81ddeyk5Wyn11ya+RpHkNOP56tyvY=; b=YhL7AxTOW23xzCB3mIp0ErSYy0
	Ajw18I4Qk1HsPyFNVqPNm/9ErCPNDtM9e2qhi5n5QuO+GZgGJexS31FxPrBmQtyvUFYEZ1knXcpgs
	MA7FDRjBA/ZaWNyAZVFR3dA0EUcUvR4IoFWUGU56BrfvAfYi7pRtKNJKwXLtAsjQia9pXkm5weV3W
	WY/e8DC5ChgNAL18QALEEt2egADf0biFLEjCNHQctk/LUxYtXldj0wOaNlyw6d5QohBU7GyiV6/wk
	6yeSHozsUb5MexQHJ9E5t3wNjmSGEOyboWOJ0r8u1TI6fxXbM8n0v+RDWea1Sh+fj5NE6sl1BRgRy
	9urGCwCA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58984 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uw1VS-000000008Vw-06qw;
	Tue, 09 Sep 2025 17:47:46 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uw1VQ-00000004MC9-1ANJ;
	Tue, 09 Sep 2025 17:47:44 +0100
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
Subject: [PATCH net-next 04/11] net: stmmac: fix stmmac_xdp_open() clk_ptp_ref
 error cleanup
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uw1VQ-00000004MC9-1ANJ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 09 Sep 2025 17:47:44 +0100

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


