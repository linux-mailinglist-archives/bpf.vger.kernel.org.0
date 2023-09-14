Return-Path: <bpf+bounces-10006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4237A0372
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 14:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB021C20E54
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 12:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9592B219FB;
	Thu, 14 Sep 2023 12:10:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473B2208A0;
	Thu, 14 Sep 2023 12:10:57 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8696B1BE8;
	Thu, 14 Sep 2023 05:10:56 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bcd7a207f7so13395601fa.3;
        Thu, 14 Sep 2023 05:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694693455; x=1695298255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7aKtSNYkSgQY2J6i547Jd7QXH1uxzB1IpES5c19CajI=;
        b=UcaHHzAtfXHQR1029e7hzgOat2QpgJ2lBIq9FfzXiM+veRm1FdzySJptHMz9E97R+5
         aPvA/FPycXYInX34PYcWJWKG3ToDVd3Bf2PYl0LRONAJLx2IrXL17B5u3sjeismdBeQk
         Q3QlC2EB5MeJDIlzGvArePvrAzSYdarCh85WroXlC7QHw1aERgcfzCsjUxqYOpM+ikuU
         D4nB13+bM0xhJNiu4wJnEjVbZtZ1Ro30faZTsRcGLA/AmwFS7brpgWXJfOQvvB3rEcPa
         aFYu43isObXt3MbyLxPJJkglmzuS8bzRjJT5j0jw2TK+E9Uyg7Cy0B45umZHhSXfnAeb
         zMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694693455; x=1695298255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aKtSNYkSgQY2J6i547Jd7QXH1uxzB1IpES5c19CajI=;
        b=obLD7+5tBrVuslgNVCdWCFnvRubVi6H77Bfv4R4+IByMPTAusNKxbFJdvG0uiOSdWD
         wkk9J4/wTfV4wgjjE+8hitByi6fQED8w8AsFoe+ieOM4keBLzYCbZh5JAQhjlPBNzOXc
         20rKJznmsx/Pzff1RRNCbVB9CCdA8UZ0uzs22vxA53vMSpdlnZ5MDOOSOczR/NroV+fI
         MC4es0V21EHJILbfnhzWld4fz5cl7QHNuMqEEPHNpaEqSdU3PJN+rlG39z+lcwdQuPHc
         R0BpPzSDxI1K3vglOl+cPCVfH0tw417lx+WsB99CFsEsMDy4UkNdUHiAeeKiPbRWhVJ6
         1o7A==
X-Gm-Message-State: AOJu0YyXIC8nyt4+ZG76Owbm3kg5F5yMViI2GjZvJLwv9V0NuAy3TYBh
	lh1wgQcD5udEP5BJ0zKoT1o=
X-Google-Smtp-Source: AGHT+IGihqamIC850c7IDzep4Y7BNXFBsVsUMYyKlHuV9pJ93oyclkxhqDUhCoOKgKB8oHTAh18lTg==
X-Received: by 2002:a2e:9992:0:b0:2bf:a0d1:b112 with SMTP id w18-20020a2e9992000000b002bfa0d1b112mr5100013lji.39.1694693454513;
        Thu, 14 Sep 2023 05:10:54 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id w12-20020a2e998c000000b002b9e346a152sm259058lji.96.2023.09.14.05.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 05:10:54 -0700 (PDT)
Date: Thu, 14 Sep 2023 15:10:51 +0300
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
 dwmac_set_tx_clk_gmii()
Message-ID: <c5hcpyvk75oaqp7xmrx2ql7m4aa3xgk6oifx6y5c33slkeujmh@leiy6uvhft5k>
References: <ZP8yEFWn0Ml3ALWq@shell.armlinux.org.uk>
 <E1qfiqx-007TPm-QD@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qfiqx-007TPm-QD@rmk-PC.armlinux.org.uk>

On Mon, Sep 11, 2023 at 04:29:31PM +0100, Russell King (Oracle) wrote:
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 29 +++++--------------
>  1 file changed, 8 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> index 9289bb87c3e3..3dc04017e3d3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> @@ -14,6 +14,7 @@
>  #include <linux/regmap.h>
>  
>  #include "stmmac_platform.h"
> +#include "stmmac_plat_lib.h"
>  
>  #define STARFIVE_DWMAC_PHY_INFT_RGMII	0x1
>  #define STARFIVE_DWMAC_PHY_INFT_RMII	0x4
> @@ -27,29 +28,15 @@ struct starfive_dwmac {
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
> +	err = dwmac_set_tx_clk_gmii(dwmac->clk_tx, speed);
> +	if (err == -ENOTSUPP)

> +		dev_err(dwmac->dev, "invalid speed %dMbps\n", speed);

%u?

> +	else if (err)
> +		dev_err(dwmac->dev,

> +			"failed to set tx rate for speed %dMbps: %pe\n",

ditto

-Serge(y)

> +			speed, ERR_PTR(err));
>  }
>  
>  static int starfive_dwmac_set_mode(struct plat_stmmacenet_data *plat_dat)
> -- 
> 2.30.2
> 
> 

