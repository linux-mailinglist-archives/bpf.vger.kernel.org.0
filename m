Return-Path: <bpf+bounces-57228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9492AA73EE
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 15:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49785189BE47
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 13:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B01255F37;
	Fri,  2 May 2025 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cSFc2TcE"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13F925524D;
	Fri,  2 May 2025 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746192994; cv=none; b=XqcOoAsONbB7YazoEbDbBiJpauJGjewVFjBHt4utjtDwl9v5DIb7oELee1sp00gpFAEPDPkFMLIha+u2MpEOR7YPSXCUN5DJIKA7KEIz5vEu7h2ibNU1hnXlruZELgmbt+In+4rHatfXT0tKhvgXs7aEbopmoHZgJmIkzkgevTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746192994; c=relaxed/simple;
	bh=PQhoe9XRy2OTczxvGO62foemCM6nltYXx9AWJcoyddg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Q/CNgzM6cBnTeCU5oDjTkIXIv6toWqFTVC8VEZxhTlxPa0qz5qDSJEuSKqetvinpNgphvzS4cHTdNeA+thRHWHYROc77qnPGVfp52uZebf/tO+4nuX6W68a9deqDrTafBRpkmHHevpVLJ4CJyl7jIkkUiq77caux2xAvycKN/FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cSFc2TcE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tMsYaN25z76lktbBdIck2Jfs8+Pu7kcg9oa4M4iajcs=; b=cSFc2TcE8QON1lJEl1vxBmZ+PB
	er39jf7VRDi85a7WRoCkv2VH9aGObtmVv3sbRs3G3Cq/+Efvvf+8HTsfJc65h+YjFClnKvc9zqBrt
	PM07APXmvBWjXXt6dkdSJ1/sG0kCPH/fqicLT3JqUpnOHomK541IZELqMJh56ZRjKpNQTyL8YrB4n
	uHb2PzZOwtOXmJ6daWvzkXmc22gubNo3Uze9xIQmdEVND1tHfjG78gQzrjJBcyuhb+2vKsLFwTj/v
	PXp4vfBXVzwHhvIL0JVkLaJKVE2+OIaRVHf8OAMaSq00hiDDVb29Zhw1FnH//+clAdVC7oQhYWpMV
	2dg53/qA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58384 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uAqYz-0001PF-3D;
	Fri, 02 May 2025 14:36:26 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uAqYN-002D41-53; Fri, 02 May 2025 14:35:47 +0100
In-Reply-To: <aBTKOBKnhoz3rrlQ@shell.armlinux.org.uk>
References: <aBTKOBKnhoz3rrlQ@shell.armlinux.org.uk>
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
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH net-next v2 4/4] net: stmmac: leave enabling _RE and _TE to
 stmmac_mac_link_up()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uAqYN-002D41-53@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 02 May 2025 14:35:47 +0100

We only need to enable the MAC receiver and transmiter only when the
link has come up.

With commit "net: stmmac: move phylink_resume() after resume setup
is complete" we move the race between stmmac_mac_link_up() and
stmmac_hw_setup(), ensuring that stmmac_mac_link_up() happens
afterwards. This patch is a pre-requisit of this change.

Remove the unnecessary call to stmmac_mac_set(, true) in
stmmac_hw_setup().

Tested-by: Furong Xu <0x1207@gmail.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ac27ea679b23..ef2a08342b25 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3533,9 +3533,6 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 		priv->hw->rx_csum = 0;
 	}
 
-	/* Enable the MAC Rx/Tx */
-	stmmac_mac_set(priv, priv->ioaddr, true);
-
 	/* Set the HW DMA mode and the COE */
 	stmmac_dma_operation_mode(priv);
 
-- 
2.30.2


