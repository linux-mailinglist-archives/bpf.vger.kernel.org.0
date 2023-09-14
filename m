Return-Path: <bpf+bounces-10059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E787A0B3A
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 19:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713EA1C20B64
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 17:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4390326288;
	Thu, 14 Sep 2023 17:05:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFE121355;
	Thu, 14 Sep 2023 17:05:16 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165061BD9;
	Thu, 14 Sep 2023 10:05:16 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bf8b9c5ca0so19167801fa.0;
        Thu, 14 Sep 2023 10:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694711114; x=1695315914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7PUq4z7Yde3HhHsl15RcXAi8VXTsK+aq00VAgDqTaQ=;
        b=juxuceEZVakhZ4Tlm9OHTl0RMMui/jyYHySHTfp4Jr4uL6F/14Vjg8bYJhY1qzLbg0
         u4aTJOHoLDT4lFvWHSqOBCezNbwZ8OTEL7BRc82Mwr5ckYa30o6S7NC/DxbssULFxRT/
         4mkeS0bRJ5xts8v9Q6r6dgo+KwaZR4H/k225rkWvWwrd+SahyzS62s+axgt/hLfVD0rP
         aQxnEh3ugvCI4iER4EvGurMjgyiODEI9dMl6W2K52Zg+44GHfTxuvGIHOqKwiN9jOYd4
         Ha4RL8HksIAHP7Ml8EEot8WPeIRIduj99sE/GeLTzi/XvZLDyDRQ20TBDI+MHPrPbFoA
         Zljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694711114; x=1695315914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7PUq4z7Yde3HhHsl15RcXAi8VXTsK+aq00VAgDqTaQ=;
        b=RDDa2qlN0xfp5JnrXmkNNTAVl59fTkTpyrL38Zedvft/lpTciYj7FsV9npDtXh+f2A
         dy+mrps72Kf+ixtC6jpq3Y2yT1TwzRwUF7DnFpK3TsIou33QMHRREXeqt732h9B3WWiK
         FpBa5DcqEjkOwI0I2BaaE0KWPodnbQuETBmxPLPv1H1Hh9FpJ/PHNfSzvQln1zBx0NcD
         mdDBa7SUvi1CwYzmucoZSEjPh90ofIheBxnjmbj7AAGjxtYgx6/9aG8eSJA++U3Crpw1
         jHTrCUYsvehqajlkZ7kNjOZ22we3wLzHRfIKEkwFZJny503r+etrP0h6pDJzbS98a55T
         FraQ==
X-Gm-Message-State: AOJu0YzJCJfl3L2PfA1da4+3V7yf4GYkiiJ+BppPwApXMRvyuOz4Xhbe
	+chS3/W51jItLDcTd8EGQO4=
X-Google-Smtp-Source: AGHT+IEFFuiQcDwb16erYvK+paHa9WvWcimYHEOp/iMQZzEm5VGA0IKKzOIzxyflILVljh8SHNikrg==
X-Received: by 2002:a2e:9bcc:0:b0:2bc:b6ce:eab with SMTP id w12-20020a2e9bcc000000b002bcb6ce0eabmr5094658ljj.51.1694711113788;
        Thu, 14 Sep 2023 10:05:13 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id o10-20020a2e0c4a000000b002b962ee0c14sm354310ljd.23.2023.09.14.10.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 10:05:13 -0700 (PDT)
Date: Thu, 14 Sep 2023 20:05:09 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Jose Abreu <Jose.Abreu@synopsys.com>, 
	Russell King <linux@armlinux.org.uk>, Serge Semin <fancer.lancer@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Emil Renner Berthing <kernel@esmil.dk>, 
	Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>, 
	Paolo Abeni <pabeni@redhat.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Samin Guo <samin.guo@starfivetech.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH net-next 4/6] net: stmmac: rk: use
 stmmac_set_tx_clk_gmii()
Message-ID: <uzvjph54kg2jkfbmwrvmunqv64ig7j6szr6pxxbiesnz5lletg@zq57w7jj2up4>
References: <ZQMPnyutz6T23E8T@shell.armlinux.org.uk>
 <E1qgmkp-007Z4s-GL@rmk-PC.armlinux.org.uk>
 <7vhtvd25qswsju34lgqi4em5v3utsxlvi3lltyt5yqqecddpyh@c5yvk7t5k5zz>
 <ZQMgtXSTsNoZohnx@shell.armlinux.org.uk>
 <rene2x562lqsknmwpaxpu337mhl4bgynct6vcyryebvem2umso@2pjocnxluxgg>
 <ZQMmV2pSCAX8AJzz@shell.armlinux.org.uk>
 <ZQMnA1PgPDDQzDrC@shell.armlinux.org.uk>
 <DM4PR12MB50888CA414C76F5C59C27E50D3F7A@DM4PR12MB5088.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB50888CA414C76F5C59C27E50D3F7A@DM4PR12MB5088.namprd12.prod.outlook.com>

Russel, Jose

On Thu, Sep 14, 2023 at 04:01:41PM +0000, Jose Abreu wrote:
> From: Russell King (Oracle) <linux@armlinux.org.uk>
> Date: Thu, Sep 14, 2023 at 16:30:11
> 
> > On Thu, Sep 14, 2023 at 04:27:19PM +0100, Russell King (Oracle) wrote:

> > > I won't be doing that, sorry. If that's not acceptable, then I'm
> > > junking this series.
> > 
> > In fact, no, I'm making that decision now. I have 42 patches. I'm
> > deleting them all because I just can't be bothered with the hassle
> > of trying to improve this crappy driver.

I am sorry to read that. In no means I intended to cause such
reaction, but merely to improve the suggested changes as I see it.

Speaking about the stmmac driver. I've got over _200_ cleanup, fix and
feature patches in my local repo waiting for me having a free time to
be properly prepared and finally submitted for review. So I totally
understand your initial desire to improve the driver code.

> 
> Hi Russell, Serge, Jakub,
> 
> My apologies for not being that active on the review. I totally understand
> there's a lot of revamps needed on "stmmac", somethings may even
> need to be totally re-written.
> 
> I'm also aware that Russell has contributed significantly for this process
> and was of great help when we first switched "stmmac" to phylink.
> 
> So, my 5-cents here is that, on this stage, any contribution on
> "stmmac" is welcomed and we shouldn't try to ask for more
> but focus instead on small steps.

I actually thought the driver has been long abandoned seeing how many
questionable changes have been accepted. That's why I decided to step
in with more detailed reviews for now. Anyway It's up to you to
decide. You are the driver maintainer after all.

-Serge(y)

> 
> Thanks,
> Jose

