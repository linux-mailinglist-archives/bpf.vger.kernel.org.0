Return-Path: <bpf+bounces-10005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D24D7A035E
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 14:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98FB41C20C9F
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 12:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A4F219F0;
	Thu, 14 Sep 2023 12:07:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09178208A0;
	Thu, 14 Sep 2023 12:07:04 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D483BD;
	Thu, 14 Sep 2023 05:07:04 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bf8b9c5ca0so13513451fa.0;
        Thu, 14 Sep 2023 05:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694693222; x=1695298022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2NXzSAm5YSMRzqDeFqPNEy2xH7BTeCdCrqM2TbPOLBA=;
        b=fpLQEfcNpvbMk/xo7aPUUjz6Qw2mibnEEBrrrYCQ0XtGpD/Nb/XQUKfPbzs5QS4C6s
         xgl7GcTYMxtBtxPS/em9QEvVpWDqnahqmSjbG8hj0hp31iH3zrqf4phYL7GpPXvDFoCl
         ZkIcbZ0FdWeiWdvb5P5cwPCTm+1oSI9aku1TSgVp6gYngiR7GoiTeObThjbSVZTGWydR
         niZ+Oi/DSzfA1Pt0660hLr6IzRvrSvHgmEVr6LvL0EUteKlg7AEU2t68uQ9aJaPcBPXH
         pAIA4P5hEV/1S9TqqdWdsSqhMy8HN1n5QQbJPUX++m1GuaJ6ANlFQ62nBncODoPi6boZ
         aYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694693222; x=1695298022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NXzSAm5YSMRzqDeFqPNEy2xH7BTeCdCrqM2TbPOLBA=;
        b=JA+jV2vTOBEVcSaAY/McJpeVAUmkgXN58E8kUZQjZiyAPaYGiAoUGTZ3LXGkqMTdNb
         IfM+MsPbOkD9f/vR1qktPaf0euhqD0BwEeV6gN+d0DMW7ApCXRXLzTuM3zsFBHxmJQCB
         wc05bGZoyhpSnPbwx5TModheC/IYs75nRTn3NzRqnmPG3Ne4zH+hKKeG3x7D3XiZ81Dy
         yiTBVRl4suuKqgKlqmn7uvjGrCEmOijop0XVw8p+UrxYxfew8dZYZ8P5T3AomyEoytJW
         ghdHW0zAC8pY/sD5mEuahFlQcjVjCNMnDSlHzQY6jhsWCED42L7m9Ruv5FWxSuKS/vKS
         IhGQ==
X-Gm-Message-State: AOJu0YxFyNoByQKnC4/a6OrwHSnTq9scSk1M0hbmYJRwYsCdpWVPRuQ1
	X1jf2ZS8ElM8C1Aspdci1Qo=
X-Google-Smtp-Source: AGHT+IGFgKEpqUy/YZpBSgsqGeCUXiZOo5fp3bjEscrEJII75vSUKVI4btweIypwZx5yEnXluRY73g==
X-Received: by 2002:a2e:99cf:0:b0:2be:54b4:ff90 with SMTP id l15-20020a2e99cf000000b002be54b4ff90mr4504691ljj.53.1694693222127;
        Thu, 14 Sep 2023 05:07:02 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id e16-20020a2e8190000000b002bfbd489019sm247523ljg.62.2023.09.14.05.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 05:07:01 -0700 (PDT)
Date: Thu, 14 Sep 2023 15:06:59 +0300
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
Subject: Re: [PATCH net-next 3/6] net: stmmac: intel-plat: use
 dwmac_set_tx_clk_gmii()
Message-ID: <7bg6suzboq6jocyf6ozrfcjpbehm3j3ttkag3few5hgeziliu6@abyv2qpucy2w>
References: <ZP8yEFWn0Ml3ALWq@shell.armlinux.org.uk>
 <E1qfiqn-007TPY-Gn@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qfiqn-007TPY-Gn@rmk-PC.armlinux.org.uk>

On Mon, Sep 11, 2023 at 04:29:21PM +0100, Russell King (Oracle) wrote:
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../stmicro/stmmac/dwmac-intel-plat.c         | 35 +++++--------------
>  1 file changed, 9 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
> index d352a14f9d48..8cc22f11072e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
> @@ -14,6 +14,7 @@
>  #include "dwmac4.h"
>  #include "stmmac.h"
>  #include "stmmac_platform.h"
> +#include "stmmac_plat_lib.h"
>  
>  struct intel_dwmac {
>  	struct device *dev;
> @@ -31,32 +32,14 @@ struct intel_dwmac_data {
>  static void kmb_eth_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
>  {
>  	struct intel_dwmac *dwmac = priv;
> -	unsigned long rate;
> -	int ret;
> -
> -	rate = clk_get_rate(dwmac->tx_clk);
> -
> -	switch (speed) {
> -	case SPEED_1000:
> -		rate = 125000000;
> -		break;
> -
> -	case SPEED_100:
> -		rate = 25000000;
> -		break;
> -
> -	case SPEED_10:
> -		rate = 2500000;
> -		break;
> -
> -	default:
> -		dev_err(dwmac->dev, "Invalid speed\n");
> -		break;
> -	}
> -
> -	ret = clk_set_rate(dwmac->tx_clk, rate);
> -	if (ret)
> -		dev_err(dwmac->dev, "Failed to configure tx clock rate\n");
> +	int err;
> +
> +	err = dwmac_set_tx_clk_gmii(dwmac->tx_clk, speed);
> +	if (err == -ENOTSUPP)

> +		dev_err(dwmac->dev, "invalid speed %dMbps\n", speed);

'%u'?

> +	else if (err)

> +		dev_err(dwmac->dev, "failed to set tx rate for speed %dMbps: %pe\n",

ditto

-Serge(y)

> +			speed, ERR_PTR(err));
>  }
>  
>  static const struct intel_dwmac_data kmb_data = {
> -- 
> 2.30.2
> 
> 

