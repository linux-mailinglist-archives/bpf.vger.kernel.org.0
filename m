Return-Path: <bpf+bounces-10036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26F57A094D
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 17:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BC12821E1
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 15:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A813E20B2A;
	Thu, 14 Sep 2023 15:22:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7CB39C;
	Thu, 14 Sep 2023 15:22:39 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCFD1FD5;
	Thu, 14 Sep 2023 08:22:38 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-502a4f33440so1844016e87.1;
        Thu, 14 Sep 2023 08:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694704957; x=1695309757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZolQK8oCNrfB9vVowtad2lF1eXOCwg06eiy5N3psADU=;
        b=ag/FLOtW0YKMsIocT2ScyvWORNuhaf4WXxIwlDLoA0R03ztdiYHW2+RIffUh1bh2cu
         RnWF03kmnl5wPuv13nK90ISKw7h9GP8EnSwZxJg5/RmLVWx1Mx16yPHAaOuqY0H1VjAW
         xFyTsh8N2jkHB+chW2UU2F+VqhuGm0PpETA8uYJkv1hb46/CLSa3/lFb6l5gk5foCIxd
         9u1bDIrpIFsnzWk2j2QAnq2FPaQjdaazuApdZQCB9J1DeOnyLK9GMwliQMnKbmpcyhYu
         H655bwCJI2qxVtoJUvk1DSC4/I4+zprDM85VaSdZEysOIEul4UPn8GvqVpyNjZBff9Sp
         ruPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694704957; x=1695309757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZolQK8oCNrfB9vVowtad2lF1eXOCwg06eiy5N3psADU=;
        b=vL97zisrI1V0SGoJOW2kMCeHXOR3Eit5uuGqAk3jjjyYgOl1/DzQfP6P7byL7HVVWt
         p5pKTj3MfeG+VbPoAe7McE/9jtmh4WNu8q94eIrOTrBpaB6D2SLLrFmSCaKl6nEt/S9X
         Yhrt2RGR+cEygIgvDHIreLVj0bD4CV0ZFGDYecmwT7SGivMPvuNqJIUxGOfSucx3PDB7
         JQz4UQdRkHxoQW30vYXk6PqDLU2gaqfNH/C1FWnlYtsSWnusbr8sMFAFv6Sv19qS5gsM
         nD0OX6KH8rlgqvf0sY+EmrfrbvM+rReAPHy+VigvddSH3MWvzgyc0mbLLVjs/KAF+x+S
         GmQQ==
X-Gm-Message-State: AOJu0YzWfYOBgOKNNXOOdaEsxADBU/8dwPTU8M3rcSAhGrZLE88iHiKd
	Tzvn/26t5FL+lggRMi6bo/8=
X-Google-Smtp-Source: AGHT+IH2T55CTAfzzSY4ltsyt2+mktK2jHAm6ps38mM5m1iDZpZbkRH7vJhwzgNOJjDUr8vyiyeJxg==
X-Received: by 2002:a19:6749:0:b0:500:b964:37e0 with SMTP id e9-20020a196749000000b00500b96437e0mr4487501lfj.6.1694704956668;
        Thu, 14 Sep 2023 08:22:36 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id q13-20020ac2514d000000b00502e2e0fa4csm315377lfd.71.2023.09.14.08.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 08:22:36 -0700 (PDT)
Date: Thu, 14 Sep 2023 18:22:33 +0300
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
Subject: Re: [PATCH net-next 4/6] net: stmmac: rk: use
 stmmac_set_tx_clk_gmii()
Message-ID: <rene2x562lqsknmwpaxpu337mhl4bgynct6vcyryebvem2umso@2pjocnxluxgg>
References: <ZQMPnyutz6T23E8T@shell.armlinux.org.uk>
 <E1qgmkp-007Z4s-GL@rmk-PC.armlinux.org.uk>
 <7vhtvd25qswsju34lgqi4em5v3utsxlvi3lltyt5yqqecddpyh@c5yvk7t5k5zz>
 <ZQMgtXSTsNoZohnx@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQMgtXSTsNoZohnx@shell.armlinux.org.uk>

On Thu, Sep 14, 2023 at 04:03:17PM +0100, Russell King (Oracle) wrote:
> On Thu, Sep 14, 2023 at 05:37:13PM +0300, Serge Semin wrote:
> > On Thu, Sep 14, 2023 at 02:51:35PM +0100, Russell King (Oracle) wrote:
> > > Use stmmac_set_tx_clk_gmii().
> > > 
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > ---
> > >  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 60 +++++--------------
> > >  1 file changed, 16 insertions(+), 44 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > index d920a50dd16c..5731a73466eb 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > @@ -1081,28 +1081,14 @@ static void rk3568_set_gmac_speed(struct rk_priv_data *bsp_priv, int speed)
> > >  {
> > >  	struct clk *clk_mac_speed = bsp_priv->clks[RK_CLK_MAC_SPEED].clk;
> > >  	struct device *dev = &bsp_priv->pdev->dev;
> > > -	unsigned long rate;
> > > -	int ret;
> > > -
> > > -	switch (speed) {
> > > -	case 10:
> > > -		rate = 2500000;
> > > -		break;
> > > -	case 100:
> > > -		rate = 25000000;
> > > -		break;
> > > -	case 1000:
> > > -		rate = 125000000;
> > > -		break;
> > > -	default:
> > > -		dev_err(dev, "unknown speed value for GMAC speed=%d", speed);
> > > -		return;
> > > -	}
> > > -
> > > -	ret = clk_set_rate(clk_mac_speed, rate);
> > > -	if (ret)
> > > -		dev_err(dev, "%s: set clk_mac_speed rate %ld failed %d\n",
> > > -			__func__, rate, ret);
> > > +	int err;
> > > +
> > > +	err = stmmac_set_tx_clk_gmii(clk_mac_speed, speed);
> > > +	if (err == -ENOTSUPP)
> > 
> > > +		dev_err(dev, "invalid speed %uMbps\n", speed);
> > > +	else if (err)
> > > +		dev_err(dev, "failed to set tx rate for speed %uMbps: %pe\n",
> > 
> > These type specifiers should have been '%d' since the speed variable
> > is of the signed integer type here.
> 

> Okay, having re-reviewed the changes, I'm changing them _all_ back to
> be %d, because that is the _right_ thing. It is *not* unsigned, even
> if fix_mac_speed() thinks that it is. It isn't. It's signed, and it's
> stmmac bollocks implicitly casting it to unsigned - and that is
> _wrong_.

Yes, stmmac is wrong in casting it to the unsigned type, but even
seeing the original type is intended to be signed doesn't mean the
qualifier should be fixed separately from the variables type and
function prototypes. It will cause even more confusion. IMO the best
way would be to fix the plat_stmmacenet_data->fix_mac_speed()
prototype and the respective methods in the glue drivers. But it would
be too bulky and most likely out of your interest to be done. So I
would still have the variables type and the format qualifier type
matching here and in the rest of the drivers especially seeing the
original code in the imx, starfive, rk, QoS Eth LLDDs sticks to the
convention described by me.

-Serge(y)

> 
> So, on that point, my original submission was more correct than this
> one, and you led me astray.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

