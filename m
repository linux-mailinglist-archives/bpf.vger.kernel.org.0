Return-Path: <bpf+bounces-10007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 011EC7A0383
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 14:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2DB1C20EBC
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 12:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2F3219F3;
	Thu, 14 Sep 2023 12:13:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B93208A8;
	Thu, 14 Sep 2023 12:13:17 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4971FD3;
	Thu, 14 Sep 2023 05:13:16 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-500913779f5so1481199e87.2;
        Thu, 14 Sep 2023 05:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694693595; x=1695298395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vAsYiYV8tZEJujkaxJ088mOxaTtmj4YYmIGTa7ifbAU=;
        b=AyTgXhCnnq/N51HHp/lHGThCb8VeGutBlJnwEURdLFD/28GvBNISVe/iilfbPDlZOQ
         hOlvQ7XCkpTHUOHTewC7CzEC/NkN3w/tcvm/P/ZbXonwwaj5jelP9E6b2gmH07pnZS0Q
         GPW0n3pH4Rhlhb2tDK6MLdUpks1+g32Y5cT2X8eE0mEFxXVGyW1uXzGuHs279oxTBSx3
         7YNYMoK8EDYSfJ86bnn/F6/JMRic+60L6PhNhDeJTPmzEbjUDP0kuAyRqbO8nVV/Qzuj
         TnqznHjnWalGTN/MOnSYU8SxAs12eczT/lSsagFi3KXlc15ll5Sk7vNEVCibjDGjXjMS
         0uMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694693595; x=1695298395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAsYiYV8tZEJujkaxJ088mOxaTtmj4YYmIGTa7ifbAU=;
        b=XAPaUG0sFIc5urBJAGjQ4qnPuQzK1tqmiJalS+rz1xRLDBTT7JXhKbQUU90BbMOlQb
         hdIDC3q0g47+V3JjTLv0grPsGndnq8e8tgJ78n6xftihBb7ZES7Yw5Pds+d2qHeR31T+
         /kut2eKKGVNfpD5awvSE0W5WT6ra7FnHy80QSb6dfsue4O02ArIbEHLBAYK81iSl3QhR
         GisOCCZmqP1N2y4PS8xSaMAKdJLSWnHNcYkvrByrlB/jm9QohW+8r/TtuDkP0Eyueu1M
         yOlwLjFlu+iPdHkZcrNNTVKBDOyUjnPoXSTboEGFFMxJr0HKX7K9HpnCFNs/WUWP/e+a
         Eqjg==
X-Gm-Message-State: AOJu0Yw/d1oxHJcEddptmFlhPP6DwsLZ1nnv96XcImR6zCz/udwkVgyb
	Xi0p74K9xg5y567FIqJMDcc=
X-Google-Smtp-Source: AGHT+IHJQlpkWJPHB3PuWrwV6GkiZ4fG9hPIJaNch03+5NJJ1+qqAh4Z3XjEdSE2rPlt0z+Nw8Lv4Q==
X-Received: by 2002:a05:6512:1048:b0:500:a0a3:80ff with SMTP id c8-20020a056512104800b00500a0a380ffmr5741069lfb.58.1694693594533;
        Thu, 14 Sep 2023 05:13:14 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id w30-20020a05651204de00b00502a770394dsm254986lfq.100.2023.09.14.05.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 05:13:14 -0700 (PDT)
Date: Thu, 14 Sep 2023 15:13:10 +0300
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
Subject: Re: [PATCH net-next 6/6] net: stmmac: qos-eth: use
 dwmac_set_tx_clk_gmii()
Message-ID: <tgurnug3ftp53gui6wwz25lo77b52clgmoqvgq5dcps2fi2xv5@uzzqvtoogy3i>
References: <ZP8yEFWn0Ml3ALWq@shell.armlinux.org.uk>
 <E1qfir2-007TPt-Uw@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qfir2-007TPt-Uw@rmk-PC.armlinux.org.uk>

On Mon, Sep 11, 2023 at 04:29:36PM +0100, Russell King (Oracle) wrote:
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 37 ++++++-------------
>  1 file changed, 11 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> index 61ebf36da13d..a8fae37b9858 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> @@ -22,6 +22,7 @@
>  #include <linux/stmmac.h>
>  
>  #include "stmmac_platform.h"
> +#include "stmmac_plat_lib.h"
>  #include "dwmac4.h"
>  
>  struct tegra_eqos {
> @@ -181,32 +182,10 @@ static void dwc_qos_remove(struct platform_device *pdev)
>  static void tegra_eqos_fix_speed(void *priv, unsigned int speed, unsigned int mode)
>  {
>  	struct tegra_eqos *eqos = priv;
> -	unsigned long rate = 125000000;
> -	bool needs_calibration = false;
>  	u32 value;
>  	int err;
>  
> -	switch (speed) {
> -	case SPEED_1000:
> -		needs_calibration = true;
> -		rate = 125000000;
> -		break;
> -
> -	case SPEED_100:
> -		needs_calibration = true;
> -		rate = 25000000;
> -		break;
> -
> -	case SPEED_10:
> -		rate = 2500000;
> -		break;
> -
> -	default:
> -		dev_err(eqos->dev, "invalid speed %u\n", speed);
> -		break;
> -	}
> -
> -	if (needs_calibration) {
> +	if (speed == SPEED_1000 || speed == SPEED_100) {
>  		/* calibrate */
>  		value = readl(eqos->regs + SDMEMCOMPPADCTRL);
>  		value |= SDMEMCOMPPADCTRL_PAD_E_INPUT_OR_E_PWRD;
> @@ -246,9 +225,15 @@ static void tegra_eqos_fix_speed(void *priv, unsigned int speed, unsigned int mo
>  		writel(value, eqos->regs + AUTO_CAL_CONFIG);
>  	}
>  
> -	err = clk_set_rate(eqos->clk_tx, rate);
> -	if (err < 0)
> -		dev_err(eqos->dev, "failed to set TX rate: %d\n", err);
> +	err = dwmac_set_tx_clk_gmii(eqos->clk_tx, speed);
> +	if (err == -ENOTSUPP) {

> +		dev_err(eqos->dev, "invalid speed %dMbps\n", speed);

%u?

> +		err = dwmac_set_tx_clk_gmii(eqos->clk_tx, SPEED_1000);
> +	} else if (err) {
> +		dev_err(eqos->dev,

> +			"failed to set tx rate for speed %dMbps: %pe\n",

ditto

-Serge(y)

> +			speed, ERR_PTR(err));
> +	}
>  }
>  
>  static int tegra_eqos_init(struct platform_device *pdev, void *priv)
> -- 
> 2.30.2
> 
> 

