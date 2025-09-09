Return-Path: <bpf+bounces-67899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CDAB5031A
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 18:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FEE3A5900
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 16:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1643568E2;
	Tue,  9 Sep 2025 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xF1FnEBv"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F34833473B;
	Tue,  9 Sep 2025 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436469; cv=none; b=cOlfkahfqjVErwPRUtj0ZFCfKPb7xHb8Sccp4i1zxwEkcn91wEkrlNuyBTO6aWaeypMinmXSqgy4a6diG8Pr4e2RGBNvs92pYJwatLKg4N4xq5S8BBCeEk6F1waB5rqLP1Od5nMfL7QMtbcVwmbUIiCWwe7MFyQL53hbwBOEVb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436469; c=relaxed/simple;
	bh=KcvdoC6jVUpVv3abUbls4XAV7QMqxjIwjlIFFMFPn20=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ETo6FLn6YduPGfuT4TxVTpVcpOD8miqvEeYqjfp0WNqs0+tesnPQGecwXI2ErSL0kUy3G4rDdy34u8/cBMAG8zo11RF8pkdruaSyMDee0YTOTeaY+Mr0yCbqDqNs0BHDaTmcWzzBpf92KRKr9NAU69I0sFj2EoLw7xSMItVeM2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xF1FnEBv; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=H6AnH3ZiNZdIwEzjDnVXXMlVVCHVQyHriF9TItbs3yY=; b=xF1FnEBv1M24a/eJX/Mdy+JQT6
	rV4Q4ZfSZwn+F7++7xxvmepM3ruF5h4k5VN1RTtjFHI5aeJQZLCQNMX5DVe0Q/AAyVU3SdXlPxsLK
	uafKG+q07+0PRLDrTAO4dx6A11Fp0G0mYwpWp7RHZQ2w6MN6laTQrD0o/cJR48GGPZSBBlRMzVeBh
	UaYSu6IsPc7bXwleHuYrf1Zgl4KabWmtuo/VGMOVrFD8XmPlFu3F3VM6gukjuQ1k3o4Sl8As35GiK
	Fe8KL/Bfr+VJIZBBkeOimv5/0YmYiJGaI/xWdjSCNmeB1GFs1gC0F04b2MpYF+zN/fcMhsj/JTaO4
	1g1d61ew==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58968 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uw1VM-000000008Vf-2P8O;
	Tue, 09 Sep 2025 17:47:40 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uw1VL-00000004MC3-0fqq;
	Tue, 09 Sep 2025 17:47:39 +0100
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
Subject: [PATCH net-next 03/11] net: stmmac: fix PTP error cleanup in
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
Message-Id: <E1uw1VL-00000004MC3-0fqq@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 09 Sep 2025 17:47:39 +0100

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


