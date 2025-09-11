Return-Path: <bpf+bounces-68120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BF4B52FB6
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 13:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA82418855D7
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 11:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F313D315D5A;
	Thu, 11 Sep 2025 11:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sJjRuT1L"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150CD313E24;
	Thu, 11 Sep 2025 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588988; cv=none; b=Wgd2TGJlhn0Qd10DU8bxR78p5lxqEU9Mqw1OuaaaX5YjgVaRB4+bMvwCdvXtJnD1L281w27+nw1i55xkW9h9GQxVFNbJgAlGJ/ko5H3AZh71CBQcDuRc87IGFvobRqf/jv8iGBJt1QCl9oLk10PXNVfk+T81FHgXa+GWIny0Vn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588988; c=relaxed/simple;
	bh=N5viMDQy19vwDSoWQyr0LaNoQfkLi/JY5N7ezyuoiAA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=MrSGGIBLtoqBAaRcf9kVf0jTWXC0ezGbEASwGVHIbKLsyUKhSfBixb+cQZkQb/D6VrRqBFzbaxvMjw6kqOOmgznmfRZRajktunlsPphXicdMcjsqZ6UtDrOR8D8oQsKO/TECeGvRg5vK/AX6aoqn7BB3xPREwl89larYZkPqsFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sJjRuT1L; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vg1aq5qDSmaUSi9KMu/jv/ZYN99u81NnP+NdqomBbrI=; b=sJjRuT1LFgJrt6h55wL5MfoaYi
	pQ+oFyv/p6C8QhybknAcn6AYciI3W903mF8xDIJmumwtZ003CDGR0domkCjyUbZx14iYQN19mSJ/u
	Aoa/bKsJxNOsKEMlTY1lSLn4xIWCVJSBDEtoq+6JS1dG6Rhzyf+1KzrXsJbGK5npYqgZQpbfSnrT6
	EGRi0gD3DjknEsxiDZyAYJ1LCV97/om6YlA+KrZZzD3RdTZ92E4JYLxDpG90QWwuvygLeBqBKtkJi
	QPqXnJeXP17/tkZOQczvkiy4WhndZvWHKEWRJXSXGO5O37REQHxSJaRm7bMP+edHwOMX0AOmKcxEp
	f3iK+81A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55874 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uwfBP-000000002rx-0N8a;
	Thu, 11 Sep 2025 12:09:43 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uwfBO-00000004j8S-1MWr;
	Thu, 11 Sep 2025 12:09:42 +0100
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
Subject: [PATCH net-next v2 02/11] net: stmmac: disable PTP clock after
 unregistering PTP
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uwfBO-00000004j8S-1MWr@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 11 Sep 2025 12:09:42 +0100

Follow the principle of unpublish from userspace and then teardown
resources.

Disable the PTP clock only after unregistering with the PTP subsystem,
which ensures that we only stop the clock that ticks the timesource
after we have removed the PTP device.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 419cb49ee5a2..5d76cf7957ab 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -817,8 +817,8 @@ static int stmmac_init_ptp(struct stmmac_priv *priv)
 
 static void stmmac_release_ptp(struct stmmac_priv *priv)
 {
-	clk_disable_unprepare(priv->plat->clk_ptp_ref);
 	stmmac_ptp_unregister(priv);
+	clk_disable_unprepare(priv->plat->clk_ptp_ref);
 }
 
 /**
-- 
2.47.3


