Return-Path: <bpf+bounces-68121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ABBB52FBA
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 13:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67292188764D
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 11:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9DE31A056;
	Thu, 11 Sep 2025 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vEOTvr2d"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2701B315785;
	Thu, 11 Sep 2025 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588994; cv=none; b=SlmyCpoZbfzEMm4gvOgTwv5glnMr8U2/BTuEdpI/8tSVzka9H7jK0ZfoHuZbZmmoGPtjCUfuHNDNF2F4ECW4GA2vl+K6fONJt/mhEjV2MmX/+J5/UHkyg8Pk1bvREIMaf/VV/fgS6xzlejvLpN3gHOB3X8w1sHSMwfGdMHZL34g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588994; c=relaxed/simple;
	bh=KcvdoC6jVUpVv3abUbls4XAV7QMqxjIwjlIFFMFPn20=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=NA+TyIlf/zTm39jVFE9B702gppoOf7HxkqYUi7rZg9Kb1wTTnConWHMSIVmi4AWe2DGnHuxqys/8c5vrT/g+rXuR1tXPaGKSa9zfCwLaSudHu0caX1i3pLGcgDMVuJIWN9lYlD5h7tKyjtWivT1MfJYjZbHtWOL21YkE3lmEKC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vEOTvr2d; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=H6AnH3ZiNZdIwEzjDnVXXMlVVCHVQyHriF9TItbs3yY=; b=vEOTvr2d/rAQf/QH6RJh2SGpvI
	0i3LnZiCiIHrigfXkN/f018lD+ONx6gW4kyPO1XMS8OJmltujh2RBzvr5CCY8+WkY69Gt914gKlTY
	47W9V29y+LLkOsp4wvQD5Ce44qPNZMs/2gJN1bsGcJfqHBlYundTer+a/3F5p8bxG7wHT5K6AQcoo
	TjZBiDsTNL8VaTx6KFu0bnWYIYOTJrO/DlPZbCsP66ldg7JSdgOnN16scmvucVwudYK6biEHDzQSF
	TXCtPhv6kYSDXlX19eLKQR+PhqUr7s+LKvwXeraoCt9XRi449IYPlQ3gT/pe3JjXt4IyfIvYzXnFs
	Is+j3rZg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55890 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uwfBU-000000002sE-1LG8;
	Thu, 11 Sep 2025 12:09:48 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uwfBT-00000004j8Y-1k4H;
	Thu, 11 Sep 2025 12:09:47 +0100
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
Subject: [PATCH net-next v2 03/11] net: stmmac: fix PTP error cleanup in
 __stmmac_open()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uwfBT-00000004j8Y-1k4H@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 11 Sep 2025 12:09:47 +0100

The cleanup function for stmmac_setup_ptp() is stmmac_release_ptp()
which entirely undoes the effects of stmmac_setup_ptp() by
unregistering the PTP device and then stopping the PTP clock,
whereas stmmac_hw_teardown() will only stop the PTP clock while
leaving the PTP device registered.

This can lead to a kernel oops - if __stmmac_open() fails after
registering the PTP clock, the PTP device will remain registered,
and if the module is removed, subsequent PTP device accesses will
lead to a kernel oops.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 5d76cf7957ab..167405aac5b8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4032,7 +4032,7 @@ static int __stmmac_open(struct net_device *dev,
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
 
-	stmmac_hw_teardown(dev);
+	stmmac_release_ptp(priv);
 init_error:
 	phylink_disconnect_phy(priv->phylink);
 init_phy_error:
-- 
2.47.3


