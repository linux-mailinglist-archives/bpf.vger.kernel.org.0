Return-Path: <bpf+bounces-10009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B600F7A03A0
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 14:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0701F23520
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 12:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AC921A01;
	Thu, 14 Sep 2023 12:19:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB344208A8;
	Thu, 14 Sep 2023 12:19:16 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEE31FCA;
	Thu, 14 Sep 2023 05:19:16 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso13590741fa.1;
        Thu, 14 Sep 2023 05:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694693954; x=1695298754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MIai8kEfSJbbe1MQb/EaG0qclNnxV1ZUNxpY+1c/fgg=;
        b=qmV0jNYFzd4yu8PKwd04qfL+mI9xgGFkLb87lchMQFEXPZjOob/HGUMSKKdUgWg/I+
         C6VidDWz2FKfwMrkZdmllMdU+xiMIdDR49HCoMp4DKaK93gPI4DcJtsNhhISdWBU4G+y
         Ewdz/Wy0ssW1Y5B3ImBpB028OUp3QiXnBGW0HaFNCyy0fCHu/S/xYscQEkZunQ4VLVJ6
         iJhrem8IrNKZbjhiZ6+eOSQ6fSCwLRAt0R4qrCPhBTqEWTpJ8QgRe5sOC5CXcDeNTz44
         H1dGoafP9gpbXEBeay4zMl0WlnEml/63d1yqpd58GaEMmZ9Fx4Gk68biaHRH8NnXu0Ue
         Djrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694693954; x=1695298754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIai8kEfSJbbe1MQb/EaG0qclNnxV1ZUNxpY+1c/fgg=;
        b=ogFSAXMYXDv+zglZfeTboxf6zxmc2AKymO8UnQ+nxj3KbUvX8bri9MxXV4olVO7qCa
         3B7aFyAUHYylRHwlzLfacR8WMqxWj0Ms1NworiOh9tw25YOqTgN9NwaFC3338is+R9ij
         qDUuOxqziEoDvUurX61KHqROwB+Vbk2DqEX06+tbiIdZ9bJ5b+mSWsBENigSGLeZOe04
         A4e4V2lKAYtUrK/bYYKUVN4vAVKPlR0vv2+LvEINlpwZvWKFhtfw9EQSxj/wsBts/VzF
         n7HQcaTVwFcCxok6ErPvSpGJtzqmDMgkOO7EhhurvatsoF/RpDYYQwtcpfckVP1xn8go
         I2WA==
X-Gm-Message-State: AOJu0Yyacvp8VNFN299huZ10kQPCDVV0giVRIzaWReqrbKLpfzTGY3OB
	8V3w8ksYxYLdhqhH+WoijlE=
X-Google-Smtp-Source: AGHT+IE9J7DJwE8nML/CCXVSNOTksA6PiQP2wqKee1UuUlkr5qnQ39Oe2QWwbbOyrqnQ31oguUUuxw==
X-Received: by 2002:a2e:808d:0:b0:2bd:a5e:2255 with SMTP id i13-20020a2e808d000000b002bd0a5e2255mr4898056ljg.28.1694693954191;
        Thu, 14 Sep 2023 05:19:14 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id w24-20020a2e9bd8000000b002bce5e379a3sm261435ljj.7.2023.09.14.05.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 05:19:13 -0700 (PDT)
Date: Thu, 14 Sep 2023 15:19:10 +0300
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
Message-ID: <hsov2bii5wenzexplq2fbgzsls2y5yssdobqjeil2nd2haqilm@jammanegu4vd>
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

BTW I don't know whether it's ok to have an empty description in the
patches for the networking subsystem, but the kernel maintainers
mainly request to add at least some text with the change justification
especially seeing the submitting-patches.rst doc says the description
is mandatory.

-Serge(y)

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
> +	else if (err)
> +		dev_err(dwmac->dev,
> +			"failed to set tx rate for speed %dMbps: %pe\n",
> +			speed, ERR_PTR(err));
>  }
>  
>  static void imx93_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mode)
> -- 
> 2.30.2
> 
> 

