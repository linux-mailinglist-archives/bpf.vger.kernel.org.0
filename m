Return-Path: <bpf+bounces-10040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0427A0A63
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 18:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE342823B2
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 16:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7268521365;
	Thu, 14 Sep 2023 16:06:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C56215E96;
	Thu, 14 Sep 2023 16:06:36 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA031BF8;
	Thu, 14 Sep 2023 09:06:35 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-502934c88b7so2009719e87.2;
        Thu, 14 Sep 2023 09:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694707593; x=1695312393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N2RmVCxa+sY1O1smqmxSFhSqD8dLKrMsO0o7RVWwTR8=;
        b=llLjuX2Klw6EF+aoHwYyQXJrYpvzqSyBl9hTdEoqDTxAh/H8fIuNqTouwjutVwd8ii
         +ikKTj6C/oByCKWZEqkyUhg9OWGeWxu/7AFG7uypSaKm+DueCH2hwU6X4uGyyFyd4vuM
         ydlZ9YB+Fw3a+ZqBq8ibJ6Pkkxj9zYoA6vrK4n/ka2PZDuiEM4ILkqsTkuLG+ymw/yUe
         JBWmqrDKP/lGKoodjfE7iWJpMSjquBFfDZRICO4bP9sQxdhDZVdQxCA2vG8bc3cAU/JP
         QeZCadJLlh795AdD230nTP5nXkAXzmzkKDQZSXti2jTVH4NZ2Tk9q4oZswNdY9IDQNYG
         2Ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694707593; x=1695312393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2RmVCxa+sY1O1smqmxSFhSqD8dLKrMsO0o7RVWwTR8=;
        b=oci7xkIFQry2E/BKkbXDB7CR73LvCoX48bP7i4Rif1CEcUhMA+lBXS/u4Ah/aOyGob
         3I/bRgXiKMBdws3ztkcRWWWwvePZMSeu3QmCl6W2/dClJzVV5dScycG3pCuxU5jvWxOY
         Zbu00yFTUJwq/Ey1Gqwf9CAsBdL3OqToY2X3WQxksk90y/tVrHz6Gd+O3Ikho0C/UaYK
         axBoljETCcCA5M/+f6Qgab5YdhhUP28MUk3O1EspML/yBPJ5ACd/ADgW2YYA/DK7WR9I
         jY0ap9kqJUjevjHLKos52lGZgPqvZ2GtcfSU99+dIHqZjYhr48Ar2zritlh5aVuwtPm8
         2RNw==
X-Gm-Message-State: AOJu0YzIG8VxGjKLI8XblXTLAJtyuohogHq8UoqpfyD7zO3mXK9X2v+w
	3IXmquZqAMHsMyxM3Psoj9E=
X-Google-Smtp-Source: AGHT+IHY85sbLIHKHvdLPwdF844Gzsdokk3pkOJ3DB92vd+npIoH6cwuF3DF7ecUJOhFUcipLEBr6g==
X-Received: by 2002:a19:ca1a:0:b0:4fd:f84f:83c1 with SMTP id a26-20020a19ca1a000000b004fdf84f83c1mr4054712lfg.64.1694707593142;
        Thu, 14 Sep 2023 09:06:33 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id n23-20020a195517000000b0050096712dc8sm318873lfe.277.2023.09.14.09.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 09:06:32 -0700 (PDT)
Date: Thu, 14 Sep 2023 19:06:29 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Emil Renner Berthing <kernel@esmil.dk>, Eric Dumazet <edumazet@google.com>, 
	Fabio Estevam <festevam@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>, 
	Paolo Abeni <pabeni@redhat.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Samin Guo <samin.guo@starfivetech.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH net-next 1/6] net: stmmac: add stmmac_set_tx_clk_gmii()
Message-ID: <pyizjtvvzc4hwklj3nrjb2f6uqvwzskpdinb3agdhelclxouoa@s7bjgexnspnv>
References: <ZQMPnyutz6T23E8T@shell.armlinux.org.uk>
 <E1qgmka-007Z4Z-1E@rmk-PC.armlinux.org.uk>
 <j64xmkplk2kkb4esteaic3hsofex3eishxxr3z6hppnm6heoz5@5fyj4x5qouc3>
 <ZQMizWbkAEyTh4M7@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQMizWbkAEyTh4M7@shell.armlinux.org.uk>

On Thu, Sep 14, 2023 at 04:12:13PM +0100, Russell King (Oracle) wrote:
> On Thu, Sep 14, 2023 at 05:54:09PM +0300, Serge Semin wrote:
> > On Thu, Sep 14, 2023 at 02:51:20PM +0100, Russell King (Oracle) wrote:
> > > Add a helper function for setting the transmit clock for GMII
> > > interfaces. This handles 1G, 100M and 10M using the standard clock
> > > rates of 125MHz, 25MHz and 2.5MHz.
> > > 
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > ---
> > >  .../ethernet/stmicro/stmmac/stmmac_platform.c | 25 +++++++++++++++++++
> > >  .../ethernet/stmicro/stmmac/stmmac_platform.h |  1 +
> > >  2 files changed, 26 insertions(+)
> > > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > > index 0f28795e581c..f7635ed2b255 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > > @@ -700,6 +700,31 @@ EXPORT_SYMBOL_GPL(stmmac_probe_config_dt);
> > >  EXPORT_SYMBOL_GPL(devm_stmmac_probe_config_dt);
> > >  EXPORT_SYMBOL_GPL(stmmac_remove_config_dt);
> > >  
> > 
> > > +int stmmac_set_tx_clk_gmii(struct clk *tx_clk, unsigned int speed)
> > > +{
> > > +	unsigned long rate;
> > > +
> > > +	switch (speed) {
> > > +	case SPEED_1000:
> > > +		rate = 125000000;
> > > +		break;
> > > +
> > > +	case SPEED_100:
> > > +		rate = 25000000;
> > > +		break;
> > > +
> > > +	case SPEED_10:
> > > +		rate = 2500000;
> > > +		break;
> > > +
> > > +	default:
> > > +		return -ENOTSUPP;
> > > +	}
> > > +
> > > +	return clk_set_rate(tx_clk, rate);
> > > +}
> > > +EXPORT_SYMBOL_GPL(stmmac_set_tx_clk_gmii);
> > 
> > As I already noted in v1 normally the switch-case operations are
> > defined with no additional line separating the cases. I would have
> > dropped them here too especially seeing the stmmac core driver mainly
> > follow that implicit convention.
> 
> It's rather haphazard whether there are blank lines or not between
> case statements.

Is it haphazard in the STMMAC core driver too? The only exception is
the HWtstamp switch-case statements which just a bit bulky. So having
additional empty lines there rather weakly but is still justified by
that.

In anyway my comment is just a nitpick inferred from the implicit
local convention. It's totally IMO and isn't implied to be considered
as a strong request to be implemented. I repeated my comment just
because you didn't respond to it in v1. It looked as if you just
missed it.

> 
> > Additionally I suggest to move the method to being defined at the head
> > of the file. Thus a more natural order normally utilized in the kernel
> > drivers would be preserved: all functional implementations go first,
> > the platform-specific things are placed below like probe()/remove()
> > and their sub-functions, suspend()/resume() and PM descriptors,
> > (device IDs table, driver descriptor, etc). stmmac_set_tx_clk_gmii()
> > looks as a functional helper which is normally utilized on the network
> > device open() stage in the framework of the fix_mac_speed() callback.
> > Moreover my suggestion gets to be even more justified seeing you
> > placed the method prototype at the head of the prototypes list in the
> > stmmac_platform.h file.
> 

> How is one supposed to know about this? I did my best trying to work
> out where they should've gone...

Well, from my experience submitting the patches to various kernel
subsystems and drivers there are many implicit conventions which
aren't described anywhere, but could be inferred from the code itself.
This one is one of such implicit conventions which isn't mandatory but
a nice-to-have feature for better readability and maintainability (for
instance in order to determine where to put new methods and features
to the already available drivers). In anyway this comment is also a
nitpick, which from my point of view would improve the code
readability. It's normally up to the driver/subsystem maintainers to
define such conventions required.

Regarding the implicit conventions. Some of the subsystem and driver
maintainers imply that such conventions would be preserved (just
recently met that in the PCIe subsystem). When it happens it's so
irritating especially if it concerns a big series.

> 
> If it's that important, maybe add some /* Comments */ to state that
> there are separate sections to the file?

Would be nice to have them indeed. Though I normally just stick to
that convention by default if there is no another one could be
inferred from the code itself.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

