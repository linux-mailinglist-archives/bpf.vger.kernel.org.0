Return-Path: <bpf+bounces-10032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B43B07A08CB
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 17:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7507CB20D67
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 15:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C67262B9;
	Thu, 14 Sep 2023 15:00:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A78539C;
	Thu, 14 Sep 2023 15:00:18 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC741FC4;
	Thu, 14 Sep 2023 08:00:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-501bef6e0d3so1788183e87.1;
        Thu, 14 Sep 2023 08:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694703615; x=1695308415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ost934mXsFAdMAZL0F6K6qliA7AblkstZWyU0HrIN0s=;
        b=U0Ucn2dr2NcrRdXiCBQ8vtODENVLNfrd/4La3iLgeVQTPlIK+E5Wh6siCNaUZShYNi
         +mBM+rJDKH5tsLfTJlBKyNRAJBRLdJpGup6iOaNSMvfzXE2vu4z9tKL9ySA5pf2HuJRL
         T9QhQLrfkrmvjo9zXtw181xbeOz5luszhAICW/wMVB/Q81FH/MhDFTYZqbJZxTflunj2
         fph08PPYpmJxjkvh3IlDPfFc3mVUd9YzDORLqx0oYNZBly8HHQvdhJF4v6Hf4sdx5XjY
         FMnjqZKXC1wnjpCr6D3Ljs0408cUlRqFlzFeaahl2n0gSr9V99vl7PJU8noAuCJvN0H5
         kqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694703615; x=1695308415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ost934mXsFAdMAZL0F6K6qliA7AblkstZWyU0HrIN0s=;
        b=rgYVR6hxFZ2ZzIwpqd0DMC02UQOE3UW6l1QJowqOxHSljleazW1xt2ITjCPCBxOJ50
         PdNlaX9TynU27BY+vy0lwp6gJVHx9m41t89yOmT0FOFpDJnp+0v2Zk8OsBmdc99CRWEb
         XL7Pgoa1N9gh06cwjll1lsnn4u+UrzJZQrPiRBYBpr7xWLMzwFLL6MdiABEtILZHMQDl
         02HfvM65Jc7lBuHU9KjEVxL0d9y2T5bwbWq0gMVVba/VJvxQ2hlPQ51FDx3ouN1giNq9
         HMvEucI1FgLYqW9MxfeAxmIfLltfWH3NaYhrX+Oj4SAsg5L2m1SedXA0Tk8V1zsKtiJu
         0AKA==
X-Gm-Message-State: AOJu0YxOMJEOUuv92ljeFDjBFhmb6mgLqhkWPtK/RRR3AbbfzhsH0k9w
	AwBmZDjjOco9HQwtIjphAtA=
X-Google-Smtp-Source: AGHT+IEyuQasdt2T0VDWeN/DaQrMM3CCucu0MV6lzspojZuxz3D9lCseE6UrznxpRfcOfZwYMqK2hw==
X-Received: by 2002:a19:6918:0:b0:4fb:9f93:365f with SMTP id e24-20020a196918000000b004fb9f93365fmr4161961lfc.38.1694703615403;
        Thu, 14 Sep 2023 08:00:15 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id a13-20020a056512020d00b005008b5191aesm302321lfo.284.2023.09.14.08.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 08:00:15 -0700 (PDT)
Date: Thu, 14 Sep 2023 18:00:12 +0300
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
 stmmac_set_tx_clk_gmii()
Message-ID: <vbljmrosykldu3jutfqyxtp22ivbcfyn2luu3cg55saeyi2uqp@tayl2qsbmovg>
References: <ZQMPnyutz6T23E8T@shell.armlinux.org.uk>
 <E1qgmkk-007Z4l-BK@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qgmkk-007Z4l-BK@rmk-PC.armlinux.org.uk>

On Thu, Sep 14, 2023 at 02:51:30PM +0100, Russell King (Oracle) wrote:
> Use stmmac_set_tx_clk_gmii().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  .../stmicro/stmmac/dwmac-intel-plat.c         | 34 +++++--------------
>  1 file changed, 8 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
> index d352a14f9d48..c6ebd1d91f38 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
> @@ -31,32 +31,14 @@ struct intel_dwmac_data {
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
> +	err = stmmac_set_tx_clk_gmii(dwmac->tx_clk, speed);
> +	if (err == -ENOTSUPP)
> +		dev_err(dwmac->dev, "invalid speed %uMbps\n", speed);
> +	else if (err)
> +		dev_err(dwmac->dev, "failed to set tx rate for speed %uMbps: %pe\n",
> +			speed, ERR_PTR(err));
>  }
>  
>  static const struct intel_dwmac_data kmb_data = {
> -- 
> 2.30.2
> 
> 

