Return-Path: <bpf+bounces-9648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D5279A9A0
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 17:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A271C20854
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 15:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC1311739;
	Mon, 11 Sep 2023 15:28:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7653211728;
	Mon, 11 Sep 2023 15:28:36 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913F4E4;
	Mon, 11 Sep 2023 08:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=L3aWAk1k0F3xbo0PvehavMWBi8SSBtH1rAKg3ce9DIM=; b=ty7Ypls+BHIWlRgl2wrP6P562d
	bKwZytfMDIWEq0e/K6fz5pSdCicwgf+cJmbBsSj/WJ1875CYuX3zbVDxuJJEtgtQiie413huwdi4I
	ignBXctM0Gofrr8PcOcPw7hIintSS/3Btb3q/PL1GrLSDUqIZOLLcMS2yAoSw4N2vTkuIslrJhI5v
	sN1adAX3lnSC1UOtWY4vqRv0350qh7E9zzoPKH3gLaYwiWWuqiMKMqFpDXe2vo3U+AgPtYeyn9OGz
	9MwLNkCTS3CSaKj1GAS9Bgat9ACvjkeQJltC7ae7avK7b0fRnUBf3zb0OuX3riHKYLYu2NqX2w1Ip
	gEhfeuvQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53518)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qfipq-0008BR-2W;
	Mon, 11 Sep 2023 16:28:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qfipk-0001m7-Vh; Mon, 11 Sep 2023 16:28:16 +0100
Date: Mon, 11 Sep 2023 16:28:16 +0100
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
Subject: [PATCH net-next 0/6] net: stmmac: add and use library for setting
 clock
Message-ID: <ZP8yEFWn0Ml3ALWq@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

There is a common theme throughout several "bsps" in the stmmac driver
which all code up the same thing: for 10M, 100M and 1G, select the
appropriate 2.5MHz, 25MHz, or 125MHz clock.

Rather than having every BSP implement the same thing but slightly
differently, let's provide a single implementation which is passed
the struct clk and the speed, and have that do the speed to clock
rate decode.

Note: only build tested.

 drivers/net/ethernet/stmicro/stmmac/Makefile       |  2 +-
 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    | 37 ++++---------
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    | 27 +++-------
 .../net/ethernet/stmicro/stmmac/dwmac-intel-plat.c | 35 ++++---------
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     | 61 ++++++----------------
 .../net/ethernet/stmicro/stmmac/dwmac-starfive.c   | 29 +++-------
 .../net/ethernet/stmicro/stmmac/stmmac_plat_lib.c  | 29 ++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_plat_lib.h  |  8 +++
 8 files changed, 91 insertions(+), 137 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_plat_lib.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_plat_lib.h

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

