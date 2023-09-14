Return-Path: <bpf+bounces-10034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D857A08F1
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 17:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1CEE281B9C
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 15:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117D4266BA;
	Thu, 14 Sep 2023 15:04:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFCA28E08;
	Thu, 14 Sep 2023 15:04:14 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1426C1FC2;
	Thu, 14 Sep 2023 08:04:14 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b703a0453fso17533051fa.3;
        Thu, 14 Sep 2023 08:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694703852; x=1695308652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QhtIFD2lNPWWdkb9OegF+hUPlFQpOn+UoE47HAzxS60=;
        b=KKCbUHODcR4sz8pqMt7Zdh6nzLxi///puDQ1pOVlAr2wJU4CYtfJ2IJjoRW6NHU7rM
         GEiEiEJAHRf2qbKzXLMnTK+2QsKv5Lr0fW9rheTQrEcO/iCpY9fdWLtS3IWz1q29yEK+
         yziytdBliCb+cxjf4m5Amf3ddAEXSrMQBD/nPWzJ+KPJ31L20r/Lunj04ja9yMHc60zL
         GASKen40ONh1TZTVszGfaSfSJvbbz5XcP7Pt/dbwz5Vmgt9640z8cfBs4RWlvNPs6Qw4
         0EQZcUW83IEAsrjoXbiKtA17SIHtU3xCNIj7fSjeEKr5mulGrvavYbyMfWxw1hrV6faK
         Rv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694703852; x=1695308652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhtIFD2lNPWWdkb9OegF+hUPlFQpOn+UoE47HAzxS60=;
        b=Zbzxia5uNrr1MDd/QYKFPetoL17TDv/5pi1YhRGd7PhUh1SaemIwYxYx4pZpFrjzin
         8srTk/JoYsfw7o6FpWsMh4O9V8LGNdFNKSghKECeSKw8qxolS4Kr3kCVvMn8antoLxrf
         fMFb5r5gRRzd+qrz+XGMccQtv5awPTRraKCYUgA+T2IfA6gGuiZJNTwuQjUJhEExpw75
         DUNvNMhvDdKz3Dh9OH76gkG23rOfXX25IKCd3Zn+J1YRQ65rWJbzfXZzuxkzezElnpzV
         lt+mnhaP2Q7INbY1nADw+3mTbJpYKm01VwQwgXv4Q+MeKNj9K9dkDcyvkQABZNhYuFMF
         bcEQ==
X-Gm-Message-State: AOJu0YxWCI086bottsfcyV6bcJFzjH3CbyVfLKVgbDGgoGxSYZrtjMql
	fyviuO5lKyRw5foHeIEKi1Q=
X-Google-Smtp-Source: AGHT+IGAFYLg8GoHiSXscjrTPJtTnwzSs2lMPv68Q4agvyRTpiU+bnlotU7NkkXmS3OhDnarpKxEcA==
X-Received: by 2002:a2e:84ce:0:b0:2b9:4413:864e with SMTP id q14-20020a2e84ce000000b002b94413864emr4463875ljh.53.1694703851940;
        Thu, 14 Sep 2023 08:04:11 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id a2-20020a2e9802000000b002bfb71c076asm319397ljj.43.2023.09.14.08.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 08:04:11 -0700 (PDT)
Date: Thu, 14 Sep 2023 18:04:09 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
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
Subject: Re: [PATCH net-next 5/6] net: stmmac: starfive: use
 stmmac_set_tx_clk_gmii()
Message-ID: <ad2oatdtyjr3d65daxl3haciywxjl4s57i6lnnzgqpwpwkcgc2@c4inrmr55uca>
References: <ZQMPnyutz6T23E8T@shell.armlinux.org.uk>
 <E1qgmku-007Z4y-KM@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qgmku-007Z4y-KM@rmk-PC.armlinux.org.uk>

On Thu, Sep 14, 2023 at 02:51:40PM +0100, Russell King (Oracle) wrote:
> Use stmmac_set_tx_clk_gmii().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 28 +++++--------------
>  1 file changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> index 9289bb87c3e3..c2931464e977 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> @@ -27,29 +27,15 @@ struct starfive_dwmac {
>  static void starfive_dwmac_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
>  {
>  	struct starfive_dwmac *dwmac = priv;
> -	unsigned long rate;
>  	int err;
>  
> -	rate = clk_get_rate(dwmac->clk_tx);
> -
> -	switch (speed) {
> -	case SPEED_1000:
> -		rate = 125000000;
> -		break;
> -	case SPEED_100:
> -		rate = 25000000;
> -		break;
> -	case SPEED_10:
> -		rate = 2500000;
> -		break;
> -	default:
> -		dev_err(dwmac->dev, "invalid speed %u\n", speed);
> -		break;
> -	}
> -
> -	err = clk_set_rate(dwmac->clk_tx, rate);
> -	if (err)
> -		dev_err(dwmac->dev, "failed to set tx rate %lu\n", rate);
> +	err = stmmac_set_tx_clk_gmii(dwmac->clk_tx, speed);
> +	if (err == -ENOTSUPP)
> +		dev_err(dwmac->dev, "invalid speed %uMbps\n", speed);
> +	else if (err)
> +		dev_err(dwmac->dev,
> +			"failed to set tx rate for speed %uMbps: %pe\n",
> +			speed, ERR_PTR(err));
>  }
>  
>  static int starfive_dwmac_set_mode(struct plat_stmmacenet_data *plat_dat)
> -- 
> 2.30.2
> 
> 

