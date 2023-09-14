Return-Path: <bpf+bounces-10001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C28DE7A033C
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 14:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21F3FB209A0
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 12:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705D0219E2;
	Thu, 14 Sep 2023 12:01:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA61CA4C;
	Thu, 14 Sep 2023 12:01:46 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F1E1FCE;
	Thu, 14 Sep 2023 05:01:45 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50079d148aeso1513390e87.3;
        Thu, 14 Sep 2023 05:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694692903; x=1695297703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=emkGVKouUJrBtnPp5Nr9/BB1K2zb2xXmCpPUHH1F+wU=;
        b=AWqN5hZSvYHObSZTqW3I365xUgwehjX7zFh5yrOivL1/pCHSaDOkkHKk+ImBjXLk3Y
         FWim7nExnk+HRo3JXqeFVdhTcyxx4wXOoiz8wiEcEx2fLNnmIsNyvuoPxwfOASThH02u
         y2Qlb1RvA4cKpPRrajotSbaZg3kl9A7ufURe9DauRJdxM7af12W92ekyEzYhjMaQbetp
         XvTS5zjgbpVU5v8B1R3IlpqjFR8CesuVfr2su4RBPA9pLzjsHP8+kfzFBa3mxoUMXV2C
         a2kvmkQbLnezgHvxAdf+xmjPwUFzJF/0HKHRu5CZDOBxpa3d0s5Bd5GmPS8YT5jmnZjy
         MRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694692903; x=1695297703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emkGVKouUJrBtnPp5Nr9/BB1K2zb2xXmCpPUHH1F+wU=;
        b=dGBvzUoWuGy7bIRzunWlP3i4812oSFlqGNflmC4tvx2/ewxboeUvnuoLoeOgXh8woc
         DpAWp+Dft4JTpXWWiEB0sJNVv9TahyzNjAAuOF/wtZ2KUCM7nCkhQV4+KFkbmWKGC5zP
         fr8jRiQ965mCTTAv3U0pzUSZZOeNYIbvPidoDQmTe27byG8KHCP8pcU7qc6E+H0mlMr9
         LraSjNRsW6a06xe2nKIe0/weC6b2HmqLYQyT6NSCLeJ28f5IyJlfgcIATnOfQvkEkWUE
         mlkFDTQxFh1Y+skS/bui/wDP3K94OaLM9nz2i8n8XvAK2zB+WGenf1yH0bmhB/0SndCU
         M9Kw==
X-Gm-Message-State: AOJu0YwQkaLInT+E0gU3FxDNr38+UWOAHtYpTrefUbY2LTgmQOgZ4EPK
	JPC2lSZwbiXIdu70N9cgzig=
X-Google-Smtp-Source: AGHT+IENInv5YwFRnvWNyYiTgsMpCzu2H4RJvhDItKFH9oeUIKP1yOl2JHQZNyXplyYJzDxN8iZ0Jg==
X-Received: by 2002:ac2:4e03:0:b0:502:d862:cc36 with SMTP id e3-20020ac24e03000000b00502d862cc36mr5091511lfr.53.1694692902396;
        Thu, 14 Sep 2023 05:01:42 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id r13-20020ac25a4d000000b004ff9bfda9d6sm250304lfn.212.2023.09.14.05.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 05:01:41 -0700 (PDT)
Date: Thu, 14 Sep 2023 15:01:39 +0300
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
Message-ID: <eqnbmp7zzu7hya5mqpf7oyhbbf4itx2z7x3xuiaibadb23l5cd@dixfkwnvqrah>
References: <E1qfiq8-007TOe-9F@rmk-PC.armlinux.org.uk>
 <DM4PR12MB5088F83CE829184956147E6BD3F1A@DM4PR12MB5088.namprd12.prod.outlook.com>
 <u7sabfdqk7i6wlv2j4cxuyb6psjwqs2kukdkafhcpq2zc766m3@m6iqexqjrvkv>
 <ZQCbB3qZlTvIM7rf@shell.armlinux.org.uk>
 <okbvyvjjww5mvwj2ogrphfsy66gx2bjn4fl27vywbl52gdgwe5@aps4umive6lk>
 <ZQHD16KIF4Z++w0I@shell.armlinux.org.uk>
 <ZQHFVmWPkamDGBAW@shell.armlinux.org.uk>
 <a2nsiguc6d64twnlbi3qlnsb35e3dyeahf366wora7rjwkl6cm@tnpgman6y23d>
 <ZQLk6kvggzlDUyS2@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQLk6kvggzlDUyS2@shell.armlinux.org.uk>

On Thu, Sep 14, 2023 at 11:48:10AM +0100, Russell King (Oracle) wrote:
> On Thu, Sep 14, 2023 at 01:42:19PM +0300, Serge Semin wrote:
> > On Wed, Sep 13, 2023 at 03:21:10PM +0100, Russell King (Oracle) wrote:
> > > On Wed, Sep 13, 2023 at 03:14:47PM +0100, Russell King (Oracle) wrote:
> > > > On Wed, Sep 13, 2023 at 03:56:07AM +0300, Serge Semin wrote:
> > > > > On Tue, Sep 12, 2023 at 06:08:23PM +0100, Russell King (Oracle) wrote:
> > > > > > On Tue, Sep 12, 2023 at 12:32:40PM +0300, Serge Semin wrote:
> > > > > > > On Tue, Sep 12, 2023 at 07:59:49AM +0000, Jose Abreu wrote:
> > > > > > > > From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > > > > > > Date: Mon, Sep 11, 2023 at 16:28:40
> > > > > > > > 
> > > > > > > > > Add a platform library of helper functions for common traits in the
> > > > > > > > > platform drivers. Currently, this is setting the tx clock.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > > > > > > > ---
> > > > > > > 
> > > > > > > > >  drivers/net/ethernet/stmicro/stmmac/Makefile  |  2 +-
> > > > > > > > >  .../ethernet/stmicro/stmmac/stmmac_plat_lib.c | 29 +++++++++++++++++++
> > > > > > > > >  .../ethernet/stmicro/stmmac/stmmac_plat_lib.h |  8 +++++
> > > > > > > > 
> > > > > > > > Wouldn't it be better to just call it "stmmac_lib{.c,.h}" in case we need to add
> > > > > > > > more helpers on the future that are not only for platform-based drivers?
> > > > > > > 
> > > > > > > What is the difference between stmmac_platform.{c,h} and
> > > > > > > stmmac_plat_lib.{c,h} files? It isn't clear really. In perspective it
> > > > > > > may cause confusions like mixed definitions in both of these files.
> > > > > > > 
> > > > > > > Why not to use the stmmac_platform.{c,h} instead of adding one more
> > > > > > > file?
> > > > > > 
> > > > > 
> > > > > > Is stmmac_platform.{c,h} used by all the drivers that are making use of
> > > > > > this? I'm not entirely sure.
> > > > > > 
> > > > > > If it is, then yes, it can go in stmmac_platform.[ch]. If not, then I
> > > > > > don't think we'd want the bloat of forcing all of stmmac_platform.[ch]
> > > > > > onto drivers that only want to use this one function.
> > > > > 
> > > > > With a few exceptions almost all the STMMAC/DW*MAC glue drivers use
> > > > > the methods from the stmmac_platform.c module including the bits
> > > > > touched by your patchset. AFAICS semantically both stmmac_platform.c
> > > > > and stmmac_plat_lib.c look the same. They don't do anything on its own
> > > > > but provide some common methods utilized by the glue drivers for some
> > > > > platform-specific setups. So basically stmmac_platform.[ch] is already
> > > > > a library of the common platform methods. There is no need in creating
> > > > > another one.
> > > > 
> > > > I'm not questioning whether it should be merged, I'm questioning whether
> > > > all drivers that I'm touching make use of stmmac_platform.c, so your
> > > > long winded answer was entirely unnecessary. All you needed to do was
> > > > answer the question I asked, rather than teach me how to suck eggs.
> > > 
> > 
> > > So what about the name of the function? Are you happy that it's called
> > > "dwmac_set_tx_clk_gmii" rather than "stmmac_set_tx_clk_gmii" ?
> > 
> > Not really. I would suggest to preserve the local naming convention:
> > 1. Generic names have stmmac_ prefix.
> > 2. DW *MAC IP-core-specific names have dw(xg|xlg)?mac(100|1000|2|4|5)?_ prefixes.
> > Alas it was violated in some places (like norm_desc and enh_desc.c
> > files) but is still mainly preserved in the driver especially in the
> > stmmac_platform.c which is concerned in this case.
> 

> Thanks... so now I have you down as a single-issue reviewer - you spot
> something, you comment on it, and that's as far as you go. You don't
> seem to bother continuing the review and raising other points - which
> leads to lots of wasted time, and lots of patch set iterations, lots
> of email on mailing lists, etc.
> 
> Do you think you could review the other patches before I go to the
> trouble of spinning a v2 please?

Ok. One more note about this patch:

> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_plat_lib.c
> @@ -0,0 +1,29 @@
> +#include <linux/stmmac.h>
> +#include <linux/clk.h>
> +
> +#include "stmmac_plat_lib.h"
> +
> +int dwmac_set_tx_clk_gmii(struct clk *tx_clk, int speed)
> +{
> +       unsigned long rate;
> +
> +       switch (speed) {
> +       case SPEED_1000:
> +               rate = 125000000;
> +               break;

> +

It's not described in the kernel coding style, but normally the
switch-case operations are defined with no additional line separating
the cases (I guess it gets to be redundant due to the indentations
visually separating the parts anyway). I would have dropped the empty
lines here too especially seeing the stmmac core driver mainly follow
that implicit convention.

> +       case SPEED_100:
> +               rate = 25000000;
> +               break;

> +

ditto

> +       case SPEED_10:
> +               rate = 2500000;
> +               break;

> +

ditto

-Serge(y)

> +       default:
> +               return -ENOTSUPP;
> +       }
> +
> +       return clk_set_rate(tx_clk, rate);
> +}
> +EXPORT_SYMBOL_GPL(dwmac_set_tx_clk_gmii);

...

> 
> Thanks.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

