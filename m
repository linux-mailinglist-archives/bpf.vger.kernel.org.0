Return-Path: <bpf+bounces-10028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 067AF7A077C
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 16:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97665B20A08
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 14:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA99410A39;
	Thu, 14 Sep 2023 14:37:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC59847D;
	Thu, 14 Sep 2023 14:37:19 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98131AD;
	Thu, 14 Sep 2023 07:37:18 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-502e0b7875dso1825277e87.0;
        Thu, 14 Sep 2023 07:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694702237; x=1695307037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0kK+0I3XIPPrGhkB0om7mc8r7QRJGhz7r+ekae91Iis=;
        b=KNSWbIkxFMJ7uLu528Qwy2OD/ApryIBkwRMdbwuvrrVsScns3Cv5XgQm+sbC76mkWj
         CyNRf54a3ywJpn/LIKcptPDiFvjSFRpUz8zYGo5DLWC1sgTseZOCj75K+zx3Bl9kd480
         D3p2WPfnRIuY9PJVT+fB5n+7SOTNLGs97m3nKfhexhfTpv9hFNUsRL1LMzserUddSSox
         ZI34LKpD9XsX09bMD3w4iXr3p8mq7waGyJ0kQqM5rAWsC6uWau0CRZCl23h53tztl/Pk
         cdjFmiPulLEfzQ9mFkvFrjKw58lHP8C/vXajLa9LFOsywSItDO3cBU2rs+Wr6HlE2Tz3
         +rcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694702237; x=1695307037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kK+0I3XIPPrGhkB0om7mc8r7QRJGhz7r+ekae91Iis=;
        b=HhmFtkKwAPkjo8t4GJE9vTaSQti5dH7AdqBlOk2Hd/nuPJbS8eGfRSL76wMNksryCq
         aj9NodDHYUgRk8ZjYeoblLozDZRTo0nYBWQB0L4ZM/l+erXT/9vUg4e2BG1HYh7hu5cc
         jsgtNgHqYJYd/qAH5k+KQ5TxfuWOTnBGLC5U6ekEvPxGGaD+8tRn8ksOnQ+G1aAgT8YX
         snEyyG4s6xjJJ/bt/BuEI5S7+KTd2Yd0TSOF99osGyqcaRRnm29yx9ZihWA2CzgFFgEo
         Nghz6OFbrzK4OFRtsLEe7ZRa02lLtd5EXVnyJ/RMiDYtROfntggU8/1X+R9qf423/NBJ
         FWOw==
X-Gm-Message-State: AOJu0YyOk++oOGnm1Ton1ph1hWt+95ZWyRjCRsbIsq/RuRuCGp22C8tM
	nYi+Se76wCLh2W15dXWxxDY=
X-Google-Smtp-Source: AGHT+IHTmVRi837uQB0y/sPX3uJQ+hm834yJYSetnbihr9kUbQUqybyp46P9VrQu9i5XR2Nx0h4Cgw==
X-Received: by 2002:a19:2d54:0:b0:4fe:d0f:1f1e with SMTP id t20-20020a192d54000000b004fe0d0f1f1emr3971532lft.25.1694702236523;
        Thu, 14 Sep 2023 07:37:16 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id er20-20020a05651248d400b004fe2503e31bsm295007lfb.157.2023.09.14.07.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 07:37:16 -0700 (PDT)
Date: Thu, 14 Sep 2023 17:37:13 +0300
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
Subject: Re: [PATCH net-next 4/6] net: stmmac: rk: use
 stmmac_set_tx_clk_gmii()
Message-ID: <7vhtvd25qswsju34lgqi4em5v3utsxlvi3lltyt5yqqecddpyh@c5yvk7t5k5zz>
References: <ZQMPnyutz6T23E8T@shell.armlinux.org.uk>
 <E1qgmkp-007Z4s-GL@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qgmkp-007Z4s-GL@rmk-PC.armlinux.org.uk>

On Thu, Sep 14, 2023 at 02:51:35PM +0100, Russell King (Oracle) wrote:
> Use stmmac_set_tx_clk_gmii().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 60 +++++--------------
>  1 file changed, 16 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index d920a50dd16c..5731a73466eb 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -1081,28 +1081,14 @@ static void rk3568_set_gmac_speed(struct rk_priv_data *bsp_priv, int speed)
>  {
>  	struct clk *clk_mac_speed = bsp_priv->clks[RK_CLK_MAC_SPEED].clk;
>  	struct device *dev = &bsp_priv->pdev->dev;
> -	unsigned long rate;
> -	int ret;
> -
> -	switch (speed) {
> -	case 10:
> -		rate = 2500000;
> -		break;
> -	case 100:
> -		rate = 25000000;
> -		break;
> -	case 1000:
> -		rate = 125000000;
> -		break;
> -	default:
> -		dev_err(dev, "unknown speed value for GMAC speed=%d", speed);
> -		return;
> -	}
> -
> -	ret = clk_set_rate(clk_mac_speed, rate);
> -	if (ret)
> -		dev_err(dev, "%s: set clk_mac_speed rate %ld failed %d\n",
> -			__func__, rate, ret);
> +	int err;
> +
> +	err = stmmac_set_tx_clk_gmii(clk_mac_speed, speed);
> +	if (err == -ENOTSUPP)

> +		dev_err(dev, "invalid speed %uMbps\n", speed);
> +	else if (err)
> +		dev_err(dev, "failed to set tx rate for speed %uMbps: %pe\n",

These type specifiers should have been '%d' since the speed variable
is of the signed integer type here.

-Serge(y)

> +			speed, ERR_PTR(err));
>  }
>  
>  static const struct rk_gmac_ops rk3568_ops = {
> @@ -1387,28 +1373,14 @@ static void rv1126_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
>  {
>  	struct clk *clk_mac_speed = bsp_priv->clks[RK_CLK_MAC_SPEED].clk;
>  	struct device *dev = &bsp_priv->pdev->dev;
> -	unsigned long rate;
> -	int ret;
> -
> -	switch (speed) {
> -	case 10:
> -		rate = 2500000;
> -		break;
> -	case 100:
> -		rate = 25000000;
> -		break;
> -	case 1000:
> -		rate = 125000000;
> -		break;
> -	default:
> -		dev_err(dev, "unknown speed value for RGMII speed=%d", speed);
> -		return;
> -	}
> -
> -	ret = clk_set_rate(clk_mac_speed, rate);
> -	if (ret)
> -		dev_err(dev, "%s: set clk_mac_speed rate %ld failed %d\n",
> -			__func__, rate, ret);
> +	int err;
> +
> +	err = stmmac_set_tx_clk_gmii(clk_mac_speed, speed);
> +	if (err == -ENOTSUPP)
> +		dev_err(dev, "invalid speed %dMbps\n", speed);
> +	else if (err)
> +		dev_err(dev, "failed to set tx rate for speed %dMbps: %pe\n",
> +			speed, ERR_PTR(err));
>  }
>  
>  static void rv1126_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
> -- 
> 2.30.2
> 
> 

