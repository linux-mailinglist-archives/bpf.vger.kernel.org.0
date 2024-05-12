Return-Path: <bpf+bounces-29602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBC18C377D
	for <lists+bpf@lfdr.de>; Sun, 12 May 2024 18:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC5B7B20BEF
	for <lists+bpf@lfdr.de>; Sun, 12 May 2024 16:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEF047A7C;
	Sun, 12 May 2024 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cIiKsjuo"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010FF4776A;
	Sun, 12 May 2024 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715531316; cv=none; b=rSrDGYYlT5VQN47jdVG1OD4mj1YiZeHbomoUV4WBQjeRN6PMwQbe7MlQqSoLxtPalDdWc6wIhreAwoOlovPSkFcJcVDLjK0LgYpI7RqzTGyA1DoV/X878PzCPqXJxgoBXnt/LoRtq6zAxhc1Ey4wvIHR3ZneQHh1Eon2dHvHrMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715531316; c=relaxed/simple;
	bh=k10JU34PCsvIgk353jT+uvbWPB/Khr6VTqgo+yzl2H8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Wky1uV6zOoXtPv9gWPvwSX/0Hq9v8W/pzaoVmmcPWvMgwsRsccUDxjDQKgx2z8PKmW/xEm1BrxVAkEGuCQpV4qOvQOGaFHrYNcCZjw/f4v/uySa1J2ap7wzt+5FYLmcPV55syWNmhmyAe8vm0Iyg8wBf1RvucfKdoH22DhXNlJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cIiKsjuo; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JKu2ehxGzSJF+b0EShKM7Ynw448P/EHxxma336CQaYQ=; b=cIiKsjuodW7EUMju3m8OYjr8ra
	6yTuggYzPYm8RrAB7+gtAxmK4diC+T3yMRYkBbG994+VSvtmVTsig2oUgbursPgX6CXwprFzBflFt
	j4AxQEgY1F0Z02+rOD+V/R26M5x5x5bWsJ4TQbxnBGQdC/PTrXekihbeaOE9rDDPGkJ2OQFwvaUmR
	mwZS7NEHsJPk575FT8xMwthwK9hljGsKK4WYjZuskmnYLaoyimzw0KHoa0RskZxWm+C2PLMa3Khog
	QTBiwD6ZsdmSt2TlOoKCAOynmWWQOqurxEltwVYvFKc0u91apsIfY9cJM3nXRu0PPqxv+94FRM/MD
	WU4ItFwA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40658)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s6C3i-0000sh-0y;
	Sun, 12 May 2024 17:28:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s6C3g-0005JR-9p; Sun, 12 May 2024 17:28:20 +0100
Date: Sun, 12 May 2024 17:28:20 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC 0/6] net: stmmac: convert stmmac "pcs" to phylink
Message-ID: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

As I noted recently in a thread (and was ignored) stmmac sucks. (I
won't hide my distain for drivers that make my life as phylink
maintainer more difficult!)

One of the contract conditions for using phylink is that the driver
will _not_ mess with the netif carrier. stmmac developers/maintainers
clearly didn't read that, because stmmac messes with the netif
carrier, which destroys phylink's guarantee that it'll make certain
calls in a particular order (e.g. it won't call mac_link_up() twice
in a row without an intervening mac_link_down().) This is clearly
stated in the phylink documentation.

Thus, this patch set attempts to fix this. Why does it mess with the
netif carrier? It has its own independent PCS implementation that
completely bypasses phylink _while_ phylink is still being used.
This is not acceptable. Either the driver uses phylink, or it doesn't
use phylink. There is no half-way house about this. Therefore, this
driver needs to either be fixed, or needs to stop using phylink.

Since I was ignored when I brought this up, I've hacked together the
following patch set - and it is hacky at the moment. It's also broken
because of recentl changes involving dwmac-qcom-ethqos.c - but there
isn't sufficient information in the driver for me to fix this. The
driver appears to use SGMII at 2500Mbps, which simply does not exist.
What interface mode (and neg_mode) does phylink pass to pcs_config()
in each of the speeds that dwmac-qcom-ethqos.c is interested in.
Without this information, I can't do that conversion. So for the
purposes of this, I've just ignored dwmac-qcom-ethqos.c (which means
it will fail to build.)

The patch splitup is not ideal, but that's not what I'm interested in
here. What I want to hear is the results of testing - does this switch
of the RGMII/SGMII "pcs" stuff to a phylink_pcs work for this driver?

Please don't review the patches, but you are welcome to send fixes to
them. Once we know that the overall implementation works, then I'll
look at how best to split the patches. In the mean time, the present
form is more convenient for making changes and fixing things.

There is still more improvement that's needed here.

Thanks.

 drivers/net/ethernet/stmicro/stmmac/Makefile       |   2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h       |  12 ++-
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   | 113 ++++++++++++---------
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  | 108 ++++++++++++--------
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |   6 --
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |  27 ++---
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   | 111 +-------------------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  19 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c   |  57 +++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h   |  84 ++-------------
 10 files changed, 227 insertions(+), 312 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

