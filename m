Return-Path: <bpf+bounces-10031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9A47A08C4
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 17:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FA1281BA9
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 15:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F19262AE;
	Thu, 14 Sep 2023 14:59:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B46D28E11;
	Thu, 14 Sep 2023 14:59:27 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5411FC4;
	Thu, 14 Sep 2023 07:59:26 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-500cfb168c6so1775667e87.2;
        Thu, 14 Sep 2023 07:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694703565; x=1695308365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P04WG88Wo2c56ytR9EOBbiCvX5TYufst4cyL+X2QRd0=;
        b=KNPRNHF4834yu8ix9mMVW7qFIsXUf6KgJ+vgA8Sx8N83oCcgkbWUMkj6ZJ6LCfzwmM
         9wc85YAA/SXaZc4znQMjNX9gY9HN7ynnvZiKJEXS5zWUzok6ZV9YkXKjFyICcU/ilIfm
         g1+uzNvuBqh4lJbEqQnbJeL+mq6kInG9L/Tr3SQ7WLqqJm2ucycO5TVcE/XEhXjbyi/m
         M6Q3Yqu6V955zdfIioqkQPVX6KqjGmKDTpqYHDSjCaRzptYzPyzOA6YH9Leebv6exTJZ
         TlWph9FHnYOBqAq9q1FmtGr7XOBDqcG7XT7+jx/M9PjUaiD4pXZD/Z2piQxmbb64rTWO
         CHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694703565; x=1695308365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P04WG88Wo2c56ytR9EOBbiCvX5TYufst4cyL+X2QRd0=;
        b=Q5P6xFp0LV6EnUmZEBCv1yLiN5Ti7k9lvlHBEvVm2TK9WA1UT+eyREEVBUDaLY5Wuq
         tXTTutlKsCbz1RuCtbWv4JGfyB6lJ5Af7v6oYsGsdwU815OSvi5pKbVSqpPTkS5QNyR4
         CaUygN6BbNaALJvxLoofI4zbed85RVj8KjoDc2HPstbuJmUbM/WEuc3sVNDPdtFwcHmQ
         eMQf/u2xNZWvIPkKdWB9MOO2jT6k3iyY5QP4o/IHqO6cd7ujtxB1Z0uAyqiJfNp8gqpM
         HR4L5l+CI1jMG9DdEb77ae2t4t/hj7/FVZUJWDMELfARejPT0HfbYhGsw2aGpvUt4CVP
         5k6g==
X-Gm-Message-State: AOJu0Ywiq5QU7AWmDU+6c5GACbXBo/5LuRO7cAfAU77UKcphBy0P3KGF
	kqqv8y4NeBuDp+YHqwVnzXY=
X-Google-Smtp-Source: AGHT+IGNNdFQMH/+tzgStqRvc1g1A12yjXACKfBcU/EzQoqxviIszf08YeT78xSUiI8hQqNSlEEJaA==
X-Received: by 2002:a05:6512:559:b0:500:a00e:1415 with SMTP id h25-20020a056512055900b00500a00e1415mr4057629lfl.35.1694703564544;
        Thu, 14 Sep 2023 07:59:24 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id n22-20020ac242d6000000b004fbc6a8ad08sm304185lfl.306.2023.09.14.07.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 07:59:24 -0700 (PDT)
Date: Thu, 14 Sep 2023 17:59:21 +0300
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
Subject: Re: [PATCH net-next 2/6] net: stmmac: imx: use
 stmmac_set_tx_clk_gmii()
Message-ID: <dzkuxule24yqekmor73rmmhtsg2vlqsupt7xtag4t3mzazksl7@dqpe5qmccsre>
References: <ZQMPnyutz6T23E8T@shell.armlinux.org.uk>
 <E1qgmkf-007Z4f-6i@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qgmkf-007Z4f-6i@rmk-PC.armlinux.org.uk>

On Thu, Sep 14, 2023 at 02:51:25PM +0100, Russell King (Oracle) wrote:
> Use stmmac_set_tx_clk_gmii().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 26 +++++--------------
>  1 file changed, 7 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> index df34e34cc14f..cb56f9523acc 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> @@ -186,7 +186,6 @@ static void imx_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mod
>  {
>  	struct plat_stmmacenet_data *plat_dat;
>  	struct imx_priv_data *dwmac = priv;
> -	unsigned long rate;
>  	int err;
>  
>  	plat_dat = dwmac->plat_dat;
> @@ -196,24 +195,13 @@ static void imx_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mod
>  	    (plat_dat->mac_interface == PHY_INTERFACE_MODE_MII))
>  		return;
>  
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
> -		return;
> -	}
> -
> -	err = clk_set_rate(dwmac->clk_tx, rate);
> -	if (err < 0)
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
>  static void imx93_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mode)
> -- 
> 2.30.2
> 
> 

