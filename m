Return-Path: <bpf+bounces-9774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D2F79D73C
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 19:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8001C210A2
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 17:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0AA8F53;
	Tue, 12 Sep 2023 17:08:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FA68488;
	Tue, 12 Sep 2023 17:08:39 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16967E7A;
	Tue, 12 Sep 2023 10:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=okqCnYbVQy91IAARHaNw8z0HLkZIzOCxSpKxVhlRnDE=; b=ikwUZiOidDIBI0VTVnEZezBfPj
	X2vSR01jJ6MEKD9FSvtk2tVycPlBwXdDNVb8nMyFbVlW+GCQ9cKJqzuXDyQ1SEvStlISB3iY4zFyO
	nArg86HQoEAOCulQDUCN3Tzn+Nt9su/nwR37Su4OI3k7TlPHeeRkAanZSJyzurAF28GVg+yrgHSsd
	5WQcUXmyZDRGF0k6FRVDgJowMJzgah+XOVdj+UjeeEsMcWqT0e8Bn8L2TcefZVHYz5nwhmRxf9Qbw
	Rcwqp1/FwfrBkyDVBKLW5Gvm1TSGdGiPNm1K/Lcec55E8JPSfbuzOyD2YN+x4ZsYXMhCH1TKrAapn
	JyeT2wGQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50484)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qg6sG-0001Ud-27;
	Tue, 12 Sep 2023 18:08:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qg6sB-0002sJ-PK; Tue, 12 Sep 2023 18:08:23 +0100
Date: Tue, 12 Sep 2023 18:08:23 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Jose Abreu <Jose.Abreu@synopsys.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	NXP Linux Team <linux-imx@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Samin Guo <samin.guo@starfivetech.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH net-next 1/6] net: stmmac: add platform library
Message-ID: <ZQCbB3qZlTvIM7rf@shell.armlinux.org.uk>
References: <E1qfiq8-007TOe-9F@rmk-PC.armlinux.org.uk>
 <DM4PR12MB5088F83CE829184956147E6BD3F1A@DM4PR12MB5088.namprd12.prod.outlook.com>
 <u7sabfdqk7i6wlv2j4cxuyb6psjwqs2kukdkafhcpq2zc766m3@m6iqexqjrvkv>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u7sabfdqk7i6wlv2j4cxuyb6psjwqs2kukdkafhcpq2zc766m3@m6iqexqjrvkv>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 12, 2023 at 12:32:40PM +0300, Serge Semin wrote:
> On Tue, Sep 12, 2023 at 07:59:49AM +0000, Jose Abreu wrote:
> > From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > Date: Mon, Sep 11, 2023 at 16:28:40
> > 
> > > Add a platform library of helper functions for common traits in the
> > > platform drivers. Currently, this is setting the tx clock.
> > > 
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > ---
> 
> > >  drivers/net/ethernet/stmicro/stmmac/Makefile  |  2 +-
> > >  .../ethernet/stmicro/stmmac/stmmac_plat_lib.c | 29 +++++++++++++++++++
> > >  .../ethernet/stmicro/stmmac/stmmac_plat_lib.h |  8 +++++
> > 
> > Wouldn't it be better to just call it "stmmac_lib{.c,.h}" in case we need to add
> > more helpers on the future that are not only for platform-based drivers?
> 
> What is the difference between stmmac_platform.{c,h} and
> stmmac_plat_lib.{c,h} files? It isn't clear really. In perspective it
> may cause confusions like mixed definitions in both of these files.
> 
> Why not to use the stmmac_platform.{c,h} instead of adding one more
> file?

Is stmmac_platform.{c,h} used by all the drivers that are making use of
this? I'm not entirely sure.

If it is, then yes, it can go in stmmac_platform.[ch]. If not, then I
don't think we'd want the bloat of forcing all of stmmac_platform.[ch]
onto drivers that only want to use this one function.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

