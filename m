Return-Path: <bpf+bounces-10004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D187A035B
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 14:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7981F21409
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 12:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7286E21A01;
	Thu, 14 Sep 2023 12:05:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FA3208A0;
	Thu, 14 Sep 2023 12:05:27 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4671BEC;
	Thu, 14 Sep 2023 05:05:27 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bce552508fso12677081fa.1;
        Thu, 14 Sep 2023 05:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694693125; x=1695297925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VIhmQ15T3b/u053vTxiBdsl4QAns5+D876ddW2tjWDI=;
        b=aJnR7jMXASneIhIIilabKGw2AHFfSzIVq0ydg8a139SA7D9O1YbkOUmQQ3X1Ayusqq
         l1cnv1KqBGQ9uA+7bE6bb69MDeRjOFeFs5K9mHWFKbjZ82V/HVjlgqFAwJAvZOlBum2Z
         NnEaQEn1qQzifuJHFrIM9tBVSmxy3vFgUQYfxjnYRtX2jtVPnTlxzdAQ6HhoEkg9tsxg
         XJbqiU8ktmF7fvVYrGVB8Mz/pzYq2SbCw4gKaNeQn9pMRNcFfq/s7JAPKG3cD91vWsy+
         WvNIggcG7+nDmTpK9fhbHRDXUY19XQJutx3pX//C3jB9MymgaF+LMga9+oHo5fXN29vk
         rmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694693125; x=1695297925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIhmQ15T3b/u053vTxiBdsl4QAns5+D876ddW2tjWDI=;
        b=HAs1tTQ8gVxQV/G8k7m2siwIYqnd+fo9Vm3ZWmMsMKAaqicIPvzwsk2TTW495xDkM3
         t0UmBgKL/OMn2S8eGI1gQauC5+MgMDT1sr0DVI2fDxbZLD7K/xk6EbkiydDv6fMdeuEz
         ROGCdXAaADBdzVOCL1bvf+zPoTI/0ZstXIcirQY3xwHnRZPNV6SoZD2qGctTN9XuvwkK
         X1VHuEU3WCS/qog5c5N3tKlYHDCiS0XEzEwCNTUEaYTfITHD3wp8O0wJck9ghc35j1Zb
         Qkb0M6OfPRso7vbdAp+P2hn7TWVW1I2xUvS/3K8DcQK3ZUY7TmfzSpeMtM9VavQIrG1K
         LrBg==
X-Gm-Message-State: AOJu0Yxs/cSYzaGIoOfwVpyaRLuJxv+/3kaGRmVvNW9Z5cB9R8SHvUfU
	YweDVmYpKDc/MKc0Qrmy0Vk=
X-Google-Smtp-Source: AGHT+IGDbk38rbC2y+cC0mEf9VcbOdWV/oMrh4l2frVj1YvUOFWx4En/oNi1hX7qnStPR5GI0m4sQQ==
X-Received: by 2002:a2e:9c48:0:b0:2bc:c846:aa17 with SMTP id t8-20020a2e9c48000000b002bcc846aa17mr4248097ljj.41.1694693125137;
        Thu, 14 Sep 2023 05:05:25 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id b6-20020a2e9886000000b002bcc4d64758sm246090ljj.103.2023.09.14.05.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 05:05:24 -0700 (PDT)
Date: Thu, 14 Sep 2023 15:05:22 +0300
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
 dwmac_set_tx_clk_gmii()
Message-ID: <fidihp5peqnwzse6jb7i56jlqbnam4z3gdpinnf3gpenmrm5dy@gpay6xwztt2v>
References: <ZP8yEFWn0Ml3ALWq@shell.armlinux.org.uk>
 <E1qfiqi-007TPS-BZ@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qfiqi-007TPS-BZ@rmk-PC.armlinux.org.uk>

On Mon, Sep 11, 2023 at 04:29:16PM +0100, Russell King (Oracle) wrote:
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 27 ++++++-------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> index df34e34cc14f..d2569faf7cc3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> @@ -21,6 +21,7 @@
>  #include <linux/stmmac.h>
>  
>  #include "stmmac_platform.h"
> +#include "stmmac_plat_lib.h"
>  
>  #define GPR_ENET_QOS_INTF_MODE_MASK	GENMASK(21, 16)
>  #define GPR_ENET_QOS_INTF_SEL_MII	(0x0 << 16)
> @@ -186,7 +187,6 @@ static void imx_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mod
>  {
>  	struct plat_stmmacenet_data *plat_dat;
>  	struct imx_priv_data *dwmac = priv;
> -	unsigned long rate;
>  	int err;
>  
>  	plat_dat = dwmac->plat_dat;
> @@ -196,24 +196,13 @@ static void imx_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mod
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
> +	err = dwmac_set_tx_clk_gmii(dwmac->clk_tx, speed);
> +	if (err == -ENOTSUPP)

> +		dev_err(dwmac->dev, "invalid speed %dMbps\n", speed);

The 'speed' variable is of the unsigned int type so the type qualifier is
supposed to be "%u" here.

> +	else if (err)
> +		dev_err(dwmac->dev,

> +			"failed to set tx rate for speed %dMbps: %pe\n",

ditto

-Serge(y)

> +			speed, ERR_PTR(err));
>  }
>  
>  static void imx93_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mode)
> -- 
> 2.30.2
> 
> 

