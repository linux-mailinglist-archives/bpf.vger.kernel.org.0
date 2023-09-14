Return-Path: <bpf+bounces-10020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2BE7A066B
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 15:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1071D1C20A00
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 13:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E072721A10;
	Thu, 14 Sep 2023 13:50:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6236524209;
	Thu, 14 Sep 2023 13:50:40 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6924A10C7;
	Thu, 14 Sep 2023 06:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RPqNFZg2BovBFcxN8fL9WiXVlKTruIYUJDcYs8EBwH8=; b=pyQ/acaFg1vj/25frlNPsNNWxH
	MH7Gq1UHz16ehdwMtql7TzZ0BhwXVUdntVztYotbpqn9+tOhvBu9Xp+uZBaNUmIhnNuvsVbG594C9
	MKBAtEvPiDPXlrQle/x30NCif0jor4iW2BrxBQInHmby8aNx/tXWShdJVeuKordTPfPcbLsEJuIVP
	dpBzTJr9TbKr+s+EAc2Dc/l9OqRvyIfrjQVaVuAqhOEEzsXl+a9t7TdhMErwVQp2RFxtpVgnEHQ4R
	AHqRu5oh5lBJBuJtOnU/EZwdxHeNCD2Uv/XwJFsqhCwH4pcUhKpRpWl5+yF1kDGfI2bulfjhb3Xap
	UqIIrm9A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56204)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qgmjk-0004F7-2B;
	Thu, 14 Sep 2023 14:50:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qgmjf-0004oZ-BT; Thu, 14 Sep 2023 14:50:23 +0100
Date: Thu, 14 Sep 2023 14:50:23 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP Linux Team <linux-imx@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Samin Guo <samin.guo@starfivetech.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH net-next v2 0/6] net: stmmac: add and use library for setting
 clock
Message-ID: <ZQMPnyutz6T23E8T@shell.armlinux.org.uk>
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

There is a common theme throughout several "bsps" in the stmmac driver
which all code up the same thing: for 10M, 100M and 1G, select the
appropriate 2.5MHz, 25MHz, or 125MHz clock.

Rather than having every BSP implement the same thing but slightly
differently, let's provide a single implementation which is passed
the struct clk and the speed, and have that do the speed to clock
rate decode.

Note: only build tested.

v2:
- move dwmac_set_tx_clk_gmii() to stmmac_platform, and rename to have
   stmmac_ prefix.
- add comment body to conversion patches
- use %u for printing speed

 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    | 36 ++++---------
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    | 26 +++-------
 .../net/ethernet/stmicro/stmmac/dwmac-intel-plat.c | 34 +++---------
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     | 60 ++++++----------------
 .../net/ethernet/stmicro/stmmac/dwmac-starfive.c   | 28 +++-------
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 25 +++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_platform.h  |  1 +
 7 files changed, 74 insertions(+), 136 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

