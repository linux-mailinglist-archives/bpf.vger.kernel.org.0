Return-Path: <bpf+bounces-10030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1757A08AE
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 17:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35211C20D14
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 15:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C86921370;
	Thu, 14 Sep 2023 14:54:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFBB28E11;
	Thu, 14 Sep 2023 14:54:15 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5015BF9;
	Thu, 14 Sep 2023 07:54:15 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bce552508fso15829041fa.1;
        Thu, 14 Sep 2023 07:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694703253; x=1695308053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8KTW3qG5uMAq5a27jOc33bCa0EC6zq+9SgJ+IzzJyF0=;
        b=P/pp6vprwidEvsPcxnSyNHXAojCw0aKX6tiosQUNhuzQaVRu1+KxcSMLJGnztSUkrd
         lt6SLxPQqzu+IUFnFsLUMN5TKf4o5Kh8ttF8cQGDVOXDaaPLV1KU/Mu6WsRJ+AATcQNV
         JdiGBbdgf/2aWtvlz7FPNwbmZ7ho4fOCtTNbKxGsMj6r8OPEU2tsvSfWmH2pvSaQ5rZN
         7K5D9mwjTuC0/RR2v1DDaiwJPPcnE01Tu+WqKKLvQOqqkbj70Kj8aOvrtaYYVqZq4kTK
         M91eP0/GVuzyXWjPtoCZWom9LPGlOdweVDs7EUGohy7geUBHKGVoOmZq7FxzX3E+8k4S
         RrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694703253; x=1695308053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KTW3qG5uMAq5a27jOc33bCa0EC6zq+9SgJ+IzzJyF0=;
        b=Gm1wj2ZD7I77zxDK0NtA4wk6655XtMH3coeUzx/odpSH0cS27itPY80LvRYoChDKk3
         jyPK/gM4RHrJ64Pe0OsTPSzeIDgW9JeOlcjhIsAZ7++ESvw8Z3iMeNqVvDNoeykEVmA3
         IkIcNuv8Fn8LBaEyiDOMbykcB6EZ2SSO1b2OaLiyudOfyjGIuL6ZMnN2+hWJ9VQMk5o7
         Lb5nP1ondSWnkvoIWJOeus89PgN+WFbo/m1zewpBbHvrRcTaq4/z6Ob7xztr99U4bmXK
         Na3BmddxVI/gelT+uLEePxk4wirQy/DwHlRotlV9pY2mC5jrGDcze9o9gQoFEG9dgVAi
         Rs5A==
X-Gm-Message-State: AOJu0YzSfpGTj3nfaMa7JeppK0A2qKjBuYF2aqHLnMvj+JeOHxXyGQYM
	+5i/wLE5YQhGldB4o3fo4e8=
X-Google-Smtp-Source: AGHT+IH/W+BphXlgk/7h4VHNwpD9/Gdfw/rWl8MzEiQi8KqUD2Y75L+nBqyZJdPZn+YPUEUtBT5+MA==
X-Received: by 2002:a2e:83d0:0:b0:2b9:d7b7:36d4 with SMTP id s16-20020a2e83d0000000b002b9d7b736d4mr4703670ljh.16.1694703252936;
        Thu, 14 Sep 2023 07:54:12 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id x18-20020a2e9c92000000b002b6cb25e3f1sm295903lji.108.2023.09.14.07.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 07:54:12 -0700 (PDT)
Date: Thu, 14 Sep 2023 17:54:09 +0300
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
Subject: Re: [PATCH net-next 1/6] net: stmmac: add stmmac_set_tx_clk_gmii()
Message-ID: <j64xmkplk2kkb4esteaic3hsofex3eishxxr3z6hppnm6heoz5@5fyj4x5qouc3>
References: <ZQMPnyutz6T23E8T@shell.armlinux.org.uk>
 <E1qgmka-007Z4Z-1E@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qgmka-007Z4Z-1E@rmk-PC.armlinux.org.uk>

On Thu, Sep 14, 2023 at 02:51:20PM +0100, Russell King (Oracle) wrote:
> Add a helper function for setting the transmit clock for GMII
> interfaces. This handles 1G, 100M and 10M using the standard clock
> rates of 125MHz, 25MHz and 2.5MHz.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../ethernet/stmicro/stmmac/stmmac_platform.c | 25 +++++++++++++++++++
>  .../ethernet/stmicro/stmmac/stmmac_platform.h |  1 +
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 0f28795e581c..f7635ed2b255 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -700,6 +700,31 @@ EXPORT_SYMBOL_GPL(stmmac_probe_config_dt);
>  EXPORT_SYMBOL_GPL(devm_stmmac_probe_config_dt);
>  EXPORT_SYMBOL_GPL(stmmac_remove_config_dt);
>  

> +int stmmac_set_tx_clk_gmii(struct clk *tx_clk, unsigned int speed)
> +{
> +	unsigned long rate;
> +
> +	switch (speed) {
> +	case SPEED_1000:
> +		rate = 125000000;
> +		break;
> +
> +	case SPEED_100:
> +		rate = 25000000;
> +		break;
> +
> +	case SPEED_10:
> +		rate = 2500000;
> +		break;
> +
> +	default:
> +		return -ENOTSUPP;
> +	}
> +
> +	return clk_set_rate(tx_clk, rate);
> +}
> +EXPORT_SYMBOL_GPL(stmmac_set_tx_clk_gmii);

As I already noted in v1 normally the switch-case operations are
defined with no additional line separating the cases. I would have
dropped them here too especially seeing the stmmac core driver mainly
follow that implicit convention.

Additionally I suggest to move the method to being defined at the head
of the file. Thus a more natural order normally utilized in the kernel
drivers would be preserved: all functional implementations go first,
the platform-specific things are placed below like probe()/remove()
and their sub-functions, suspend()/resume() and PM descriptors,
(device IDs table, driver descriptor, etc). stmmac_set_tx_clk_gmii()
looks as a functional helper which is normally utilized on the network
device open() stage in the framework of the fix_mac_speed() callback.
Moreover my suggestion gets to be even more justified seeing you
placed the method prototype at the head of the prototypes list in the
stmmac_platform.h file.

Irrespective to the nitpicks above the change looks good:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> +
>  int stmmac_get_platform_resources(struct platform_device *pdev,
>  				  struct stmmac_resources *stmmac_res)
>  {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
> index c5565b2a70ac..8dc2287c6724 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
> @@ -11,6 +11,7 @@
>  
>  #include "stmmac.h"
>  
> +int stmmac_set_tx_clk_gmii(struct clk *tx_clk, unsigned int speed);
>  struct plat_stmmacenet_data *
>  stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac);
>  struct plat_stmmacenet_data *
> -- 
> 2.30.2
> 
> 

