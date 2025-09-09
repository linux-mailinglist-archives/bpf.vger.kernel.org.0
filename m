Return-Path: <bpf+bounces-67897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F85FB50313
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 18:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3CC17497B
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 16:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED18235336D;
	Tue,  9 Sep 2025 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FXC5hnDG"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D47314B8C;
	Tue,  9 Sep 2025 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436456; cv=none; b=GoNDRs5IOsJTzRlq1bZh9jp1BvEO1FxfisWLCOSQfNC/dpUaCdpahKJ3wN5Ikcqipi7Ftv9TCRzLjKNi1YJhzMV4+ay+DIWnTFtZQnSepsDIRM6VQz+qRJSEVxtGVGyq8z3Tsx5Drp2ruE9TZBGxiUxYrmhSaUZiqHaGvQzzOfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436456; c=relaxed/simple;
	bh=xubizKhTwdwiqMs69yUH/bwC7AIRRVock0FKRLGEyAY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=BjCmmPeCZQSgAKg2HFIhs8vHoNDkOzgD10US8kBZWDWQdWn5Iz6IuyrTYlM3QrpXlPj3rgoY7IlT/0m11MOJw/g5l3sYHI6RlsmOxjCI4oE5McJnfXQW7GuyQi5QlMil4af9N9JQbnyGdS+rZJyFTCxIbfXpm+S5MYhtP/9kfyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FXC5hnDG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=028dhRsQ8GM4B2fby7ztoYmOKZAqFSwbDbKA0jLGDMw=; b=FXC5hnDG2s9hgqpprduIxdl6uJ
	UKmEngI7IXYrM8IoDabkmg/pj7Dozqw4/yn0LQ1Kdgp994MDLadIRBf4b74JrguHch75+cjEe70zJ
	DSeH0rLCpI29pnVvnU57TySnyu30TnY4gUZ88Bph3LWLU80on5KV7EoQ3GgXmIDASn9TQya8Nenoo
	pku6JMb8Ekt5lYXV5KxKGW0GSkvoLD94sN29tILwS79HTRjGdtGGJE9c6UGZqHKphhYpHiyGRYQda
	hU0zntD0x7y14dUX956w6JpV1xMdJ7QidlLz/PtpTG/0q9/QZo1E8UM65AkJVhh8E6VTBYaW4HfLI
	uRZMMEMw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44316 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uw1VB-000000008VE-3qvb;
	Tue, 09 Sep 2025 17:47:29 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uw1VA-00000004MBq-3nnn;
	Tue, 09 Sep 2025 17:47:28 +0100
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
Subject: [PATCH net-next 01/11] net: stmmac: ptp: improve handling of
 aux_ts_lock lifetime
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uw1VA-00000004MBq-3nnn@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 09 Sep 2025 17:47:28 +0100

The aux_ts_lock mutex is only required while the PTP clock has been
successfully registered.

stmmac_ptp_register() does not return any errors (as we don't wish to
prevent the netdev being opened if PTP fails), stmmac_ptp_unregister()
was coded to allow it to be called irrespective of whether PTP was
successfully registered or not.

Arrange for the aux_ts_lock mutex to be destroyed if the PTP clock
is not functional during stmmac_ptp_register(), and only destroy it
in stmmac_ptp_unregister() if we had a PTP clock registered.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 69bd8ace139c..993ff4e87e55 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -370,8 +370,12 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
 	if (IS_ERR(priv->ptp_clock)) {
 		netdev_err(priv->dev, "ptp_clock_register failed\n");
 		priv->ptp_clock = NULL;
-	} else if (priv->ptp_clock)
+	}
+
+	if (priv->ptp_clock)
 		netdev_info(priv->dev, "registered PTP clock\n");
+	else
+		mutex_destroy(&priv->aux_ts_lock);
 }
 
 /**
@@ -387,7 +391,7 @@ void stmmac_ptp_unregister(struct stmmac_priv *priv)
 		priv->ptp_clock = NULL;
 		pr_debug("Removed PTP HW clock successfully on %s\n",
 			 priv->dev->name);
-	}
 
-	mutex_destroy(&priv->aux_ts_lock);
+		mutex_destroy(&priv->aux_ts_lock);
+	}
 }
-- 
2.47.3


