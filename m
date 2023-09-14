Return-Path: <bpf+bounces-9997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FE47A01DF
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 12:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 083581C20ED8
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 10:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155D3CA67;
	Thu, 14 Sep 2023 10:42:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E3C208A9;
	Thu, 14 Sep 2023 10:42:27 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA07E1BF0;
	Thu, 14 Sep 2023 03:42:26 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-502e7d66c1eso926686e87.1;
        Thu, 14 Sep 2023 03:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694688145; x=1695292945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ITCKmNSgnlKU8ryO32ZWr7oE65pMrNKWroKmW3MO18=;
        b=sfyHYYPoNNH1fXgSsf+jq7mWCTHnnR4PC2KPXM7r5HpajUkNeGf2bDTmW3Jfxt94L3
         3Js5dBOtH6KY4RQ+n6loFlyX2e+/o260qxOxWMtbUUzYR1LG6UQIREss498zwWfBIXDE
         OUyKx31Zxh++eWW7WXBiKTX6J25+VJLuqj9WM14F/IUByv3X64fp9boNId1vf9cCU0xb
         5vB5+RwKv5c8FxQRA73+rcLxdnEMfHjQnTeEK5WDHTEiyKZa5xC6lreL3J9fR7HAuyh+
         JfZVSX+SNwg4i+w7+gQMJOCIrZRv/2I5Eu8XddUioem5QHsEeoEcqmpf4/3Z6mPsu3Ue
         Qm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694688145; x=1695292945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ITCKmNSgnlKU8ryO32ZWr7oE65pMrNKWroKmW3MO18=;
        b=KQUSiD8N+DpH3v0+Pc8L87WGxp/NB7FgcZYjFTovrJf7anmz7lHOjYSA25xnrI+Ee1
         Z+T91fvFYerrL5lGdcNFd4a8MxVeFwjmKUL8Tkt2ik0F995KNiuyg09Inhrhc55Oti+Y
         0/MNNiGNA/jm2U2zaAvIf77N+AAn8Y2vc1MSmet3cEid25Yc6fGCfqlIoehhrN8WWel7
         btUxJXlq2RfFkbeuPkLTjQb3H1GJ1upVTpG8XQ3ta0BA2afehduAAV9V5a5up1c3fg1U
         vb9trbO6XJ3Pro58I/xl1wt3TaKZ82PTPMe1GEShA2ubL2HG3fJeIDBG6PDQEJ1P6pfu
         +5uA==
X-Gm-Message-State: AOJu0YydBmBo8Q+iOPC9QUeNbOUnicWoZOLZ7fueavibLKyO1ccp2ENU
	hPt4AfVDntgjqLyN4xXYMMU=
X-Google-Smtp-Source: AGHT+IHg/+sCQeoJjEDHCBmloSZO6+xlCNL2zw0Hekm7iUGgLmI7GGT9hhLH3z7kOhMfwaa9vZPqiQ==
X-Received: by 2002:a19:790d:0:b0:4ff:a25b:bca1 with SMTP id u13-20020a19790d000000b004ffa25bbca1mr3542285lfc.33.1694688144490;
        Thu, 14 Sep 2023 03:42:24 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id n12-20020a19550c000000b004fe432108absm226196lfe.182.2023.09.14.03.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 03:42:24 -0700 (PDT)
Date: Thu, 14 Sep 2023 13:42:19 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jose Abreu <Jose.Abreu@synopsys.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Emil Renner Berthing <kernel@esmil.dk>, 
	Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>, 
	Paolo Abeni <pabeni@redhat.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Samin Guo <samin.guo@starfivetech.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH net-next 1/6] net: stmmac: add platform library
Message-ID: <a2nsiguc6d64twnlbi3qlnsb35e3dyeahf366wora7rjwkl6cm@tnpgman6y23d>
References: <E1qfiq8-007TOe-9F@rmk-PC.armlinux.org.uk>
 <DM4PR12MB5088F83CE829184956147E6BD3F1A@DM4PR12MB5088.namprd12.prod.outlook.com>
 <u7sabfdqk7i6wlv2j4cxuyb6psjwqs2kukdkafhcpq2zc766m3@m6iqexqjrvkv>
 <ZQCbB3qZlTvIM7rf@shell.armlinux.org.uk>
 <okbvyvjjww5mvwj2ogrphfsy66gx2bjn4fl27vywbl52gdgwe5@aps4umive6lk>
 <ZQHD16KIF4Z++w0I@shell.armlinux.org.uk>
 <ZQHFVmWPkamDGBAW@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQHFVmWPkamDGBAW@shell.armlinux.org.uk>

On Wed, Sep 13, 2023 at 03:21:10PM +0100, Russell King (Oracle) wrote:
> On Wed, Sep 13, 2023 at 03:14:47PM +0100, Russell King (Oracle) wrote:
> > On Wed, Sep 13, 2023 at 03:56:07AM +0300, Serge Semin wrote:
> > > On Tue, Sep 12, 2023 at 06:08:23PM +0100, Russell King (Oracle) wrote:
> > > > On Tue, Sep 12, 2023 at 12:32:40PM +0300, Serge Semin wrote:
> > > > > On Tue, Sep 12, 2023 at 07:59:49AM +0000, Jose Abreu wrote:
> > > > > > From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > > > > Date: Mon, Sep 11, 2023 at 16:28:40
> > > > > > 
> > > > > > > Add a platform library of helper functions for common traits in the
> > > > > > > platform drivers. Currently, this is setting the tx clock.
> > > > > > > 
> > > > > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > > > > > ---
> > > > > 
> > > > > > >  drivers/net/ethernet/stmicro/stmmac/Makefile  |  2 +-
> > > > > > >  .../ethernet/stmicro/stmmac/stmmac_plat_lib.c | 29 +++++++++++++++++++
> > > > > > >  .../ethernet/stmicro/stmmac/stmmac_plat_lib.h |  8 +++++
> > > > > > 
> > > > > > Wouldn't it be better to just call it "stmmac_lib{.c,.h}" in case we need to add
> > > > > > more helpers on the future that are not only for platform-based drivers?
> > > > > 
> > > > > What is the difference between stmmac_platform.{c,h} and
> > > > > stmmac_plat_lib.{c,h} files? It isn't clear really. In perspective it
> > > > > may cause confusions like mixed definitions in both of these files.
> > > > > 
> > > > > Why not to use the stmmac_platform.{c,h} instead of adding one more
> > > > > file?
> > > > 
> > > 
> > > > Is stmmac_platform.{c,h} used by all the drivers that are making use of
> > > > this? I'm not entirely sure.
> > > > 
> > > > If it is, then yes, it can go in stmmac_platform.[ch]. If not, then I
> > > > don't think we'd want the bloat of forcing all of stmmac_platform.[ch]
> > > > onto drivers that only want to use this one function.
> > > 
> > > With a few exceptions almost all the STMMAC/DW*MAC glue drivers use
> > > the methods from the stmmac_platform.c module including the bits
> > > touched by your patchset. AFAICS semantically both stmmac_platform.c
> > > and stmmac_plat_lib.c look the same. They don't do anything on its own
> > > but provide some common methods utilized by the glue drivers for some
> > > platform-specific setups. So basically stmmac_platform.[ch] is already
> > > a library of the common platform methods. There is no need in creating
> > > another one.
> > 
> > I'm not questioning whether it should be merged, I'm questioning whether
> > all drivers that I'm touching make use of stmmac_platform.c, so your
> > long winded answer was entirely unnecessary. All you needed to do was
> > answer the question I asked, rather than teach me how to suck eggs.
> 

> So what about the name of the function? Are you happy that it's called
> "dwmac_set_tx_clk_gmii" rather than "stmmac_set_tx_clk_gmii" ?

Not really. I would suggest to preserve the local naming convention:
1. Generic names have stmmac_ prefix.
2. DW *MAC IP-core-specific names have dw(xg|xlg)?mac(100|1000|2|4|5)?_ prefixes.
Alas it was violated in some places (like norm_desc and enh_desc.c
files) but is still mainly preserved in the driver especially in the
stmmac_platform.c which is concerned in this case.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

