Return-Path: <bpf+bounces-68119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC99B52FA6
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 13:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B493171FFC
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 11:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A21314A9B;
	Thu, 11 Sep 2025 11:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="seux19PH"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17E6313E24;
	Thu, 11 Sep 2025 11:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588984; cv=none; b=s8/s8W+K2d5BNyEOu+RS+u091jtaY2bHoeEZnijZRBz06isNTezVlxmRbfXObFHkdTEA2DszMgFKA6VmOzBluixLC857X0r1350sMj3fRR83Teic5zxgQblgWxeD/g7IGAukphapDAeCwD8jLMj3rZqzxR5JNRMjjTAHn63vATg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588984; c=relaxed/simple;
	bh=xubizKhTwdwiqMs69yUH/bwC7AIRRVock0FKRLGEyAY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=qbHz6XT5bX+eKkAY9Wm30tETs3C7BcCNH6NLb8ETOvXzEiYGg1FOoTQs/BJrX+RHPsNPYvCPTINQCFI0MDwrjeiPqxlDcnvMO7EComsScbVbQrIL/+BbvjZnw4XclkVlYJglazWGnjnfIi57ngZcHXS9Rmg+vqf8Y7WfigduwCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=seux19PH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=028dhRsQ8GM4B2fby7ztoYmOKZAqFSwbDbKA0jLGDMw=; b=seux19PHqPPKT5VRYLDruDtTob
	KqBMiC/sMjpYTeR1OT/bvTTa/wvEiKK8ig4+gwdXdH7aC81gsvltLSzUCUDCVQYH+UCKuIgnCYQ4T
	6jgwvKonNWm/tZZ6aKxXqafXHzcKiCiUxp9Gg7/8lIjc6Esdti/ZVQdBGtzCT/4qsgCiR6M5FZZ3X
	hwwE/DFVrBLoBU/X+mo/K70b8zhI2dceqE29RUlu18UmrAt4HK2v0olBtXZm94mT38ulgzqLru7uy
	6K8hlFZeLBbdkCllkktHkk5HiN8FlyYPsRIe7wZhn04kEhyhkspI7ascKvxQ8uT0uJvFG+aeEBvtj
	75dGgrWg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43394 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uwfBJ-000000002rm-466u;
	Thu, 11 Sep 2025 12:09:38 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uwfBJ-00000004j8M-0wT8;
	Thu, 11 Sep 2025 12:09:37 +0100
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
Subject: [PATCH net-next v2 01/11] net: stmmac: ptp: improve handling of
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
Message-Id: <E1uwfBJ-00000004j8M-0wT8@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 11 Sep 2025 12:09:37 +0100

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


