Return-Path: <bpf+bounces-9852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5459179DD4A
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 02:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36BF282128
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 00:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3DD390;
	Wed, 13 Sep 2023 00:56:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266D3384;
	Wed, 13 Sep 2023 00:56:12 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6ED010CC;
	Tue, 12 Sep 2023 17:56:11 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bcda0aaf47so4815651fa.1;
        Tue, 12 Sep 2023 17:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694566570; x=1695171370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TKovJZqebXJbOFUyHFPe+N2WMCwxRV8QMx9N79j3g7c=;
        b=IoAgAz0kTx4fdYw7nBOQZpigEfY92bAvK6g5rX7JgczIafPa8L5dl/QiEmdHxFyaRR
         oKAG8BZTixWDh4mmMjklDb+22YQsBGxNQeJRWZQOBTO8jR891dh+AKb5hFSqCGzxe8NY
         ikoPmsOVMimqyHdfjnXPjfFKKiozrmu8SC64Nb58mwAcWhw+9vc2ZomGA2c2dAmcTMCq
         cInjlB1Cn54KRYxMjEM5kSs+fs3JauCSka37T8KDc2YmcfzS847OLCZY5QOgTPnpAPva
         YPWwYWlR5LlQhL9devQIAPbJzvKeVS54sRueRgxBMWdCWgCnLt2ISw8nitQoTBQaoker
         947Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694566570; x=1695171370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKovJZqebXJbOFUyHFPe+N2WMCwxRV8QMx9N79j3g7c=;
        b=Yrh5QNNRgPp8R/jieDpye85SVMoGieb2qxPv3Nq9aL+/27Mi0Bo8pkKGnRB7m3O0Xz
         Ziz2YHbIXULPENWZmZH78dwf30JiMOLcgt9oPWDANAj+5QwKfum0SZb/YFPuH15rBGK+
         RhJU0/v+cbyOgOKZ6w/iUYFWIuobkBuitCg2GHG6lA9RlAc2TtmAnHLgrZNuKQq+jYYW
         RbS2Y8whyychJySrpGa5vYyfoaST7e7/Dqtkje9jTNbmW56+nPDTpMjuZynu+Ru9o4lt
         jCaKdXusGgDw0XPeRZJShWQdWwDMc3d7h1gSLoUM1igqy0Mq8bSDVE4QOubRY0TP2mon
         YeSg==
X-Gm-Message-State: AOJu0YwQYjUS3JldRBlSkfj3Tw+zFVzQrxMhkEEWlDcgsToMtn1oio60
	FADMuWh5utQR4RWVe3cW/AY=
X-Google-Smtp-Source: AGHT+IHUrxU60J1tom9TqtgSJejIbp2hGaIwb6cddhpFYE26qISZmBLljXKw2AjEbpsbuPyzWyUTEg==
X-Received: by 2002:a2e:6812:0:b0:2bc:ff6c:3018 with SMTP id c18-20020a2e6812000000b002bcff6c3018mr370809lja.21.1694566569782;
        Tue, 12 Sep 2023 17:56:09 -0700 (PDT)
Received: from mobilestation ([95.79.219.206])
        by smtp.gmail.com with ESMTPSA id s10-20020a2e2c0a000000b002b836d8c839sm2151252ljs.40.2023.09.12.17.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 17:56:09 -0700 (PDT)
Date: Wed, 13 Sep 2023 03:56:07 +0300
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
Message-ID: <okbvyvjjww5mvwj2ogrphfsy66gx2bjn4fl27vywbl52gdgwe5@aps4umive6lk>
References: <E1qfiq8-007TOe-9F@rmk-PC.armlinux.org.uk>
 <DM4PR12MB5088F83CE829184956147E6BD3F1A@DM4PR12MB5088.namprd12.prod.outlook.com>
 <u7sabfdqk7i6wlv2j4cxuyb6psjwqs2kukdkafhcpq2zc766m3@m6iqexqjrvkv>
 <ZQCbB3qZlTvIM7rf@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQCbB3qZlTvIM7rf@shell.armlinux.org.uk>

On Tue, Sep 12, 2023 at 06:08:23PM +0100, Russell King (Oracle) wrote:
> On Tue, Sep 12, 2023 at 12:32:40PM +0300, Serge Semin wrote:
> > On Tue, Sep 12, 2023 at 07:59:49AM +0000, Jose Abreu wrote:
> > > From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > Date: Mon, Sep 11, 2023 at 16:28:40
> > > 
> > > > Add a platform library of helper functions for common traits in the
> > > > platform drivers. Currently, this is setting the tx clock.
> > > > 
> > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > > ---
> > 
> > > >  drivers/net/ethernet/stmicro/stmmac/Makefile  |  2 +-
> > > >  .../ethernet/stmicro/stmmac/stmmac_plat_lib.c | 29 +++++++++++++++++++
> > > >  .../ethernet/stmicro/stmmac/stmmac_plat_lib.h |  8 +++++
> > > 
> > > Wouldn't it be better to just call it "stmmac_lib{.c,.h}" in case we need to add
> > > more helpers on the future that are not only for platform-based drivers?
> > 
> > What is the difference between stmmac_platform.{c,h} and
> > stmmac_plat_lib.{c,h} files? It isn't clear really. In perspective it
> > may cause confusions like mixed definitions in both of these files.
> > 
> > Why not to use the stmmac_platform.{c,h} instead of adding one more
> > file?
> 

> Is stmmac_platform.{c,h} used by all the drivers that are making use of
> this? I'm not entirely sure.
> 
> If it is, then yes, it can go in stmmac_platform.[ch]. If not, then I
> don't think we'd want the bloat of forcing all of stmmac_platform.[ch]
> onto drivers that only want to use this one function.

With a few exceptions almost all the STMMAC/DW*MAC glue drivers use
the methods from the stmmac_platform.c module including the bits
touched by your patchset. AFAICS semantically both stmmac_platform.c
and stmmac_plat_lib.c look the same. They don't do anything on its own
but provide some common methods utilized by the glue drivers for some
platform-specific setups. So basically stmmac_platform.[ch] is already
a library of the common platform methods. There is no need in creating
another one.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

