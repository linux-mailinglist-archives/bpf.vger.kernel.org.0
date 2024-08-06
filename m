Return-Path: <bpf+bounces-36516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA1F949B2B
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 00:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0BA91F24CC9
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 22:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E452C1741E8;
	Tue,  6 Aug 2024 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuzCxNvx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9322C171E5A;
	Tue,  6 Aug 2024 22:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982502; cv=none; b=qmy5cPRzoIXTbHZ4rueFHI9PrjUL5KDO2udbDic6qt7uUgOB+SJ1HzwKi35QqKSu4wxozQS4TdaCY0ApP1Wyw72gxKyLrxaQEync2QbtFL+qSZniTuqjCcbtKejHOUq4aM1pY7uU9SxzCzW3ZDruOJVZAKoSBECbJays2cfcuTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982502; c=relaxed/simple;
	bh=m5BjGQn0ztYT3NKsuxQ229IfQyV8rqnP0MJCBdsv/DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Va/0sVbBput+MIxCUXRCO81sxwZf4UtAl3C+v7wU28iFytSGw8FLPO3+zDhJUuH5aYSGJtO0mvrixXx80OzS5xiYAJr3f+eJXEsubHsAsM9daq7BfKr+7yp0kJwXRm8laZZQ221YPVL6Yb5Le0n+W5vgUuO7OwZhM65LB8yTpMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuzCxNvx; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52f04b4abdcso1691126e87.2;
        Tue, 06 Aug 2024 15:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722982499; x=1723587299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yXjtb86nnXZiK+81bTmuvRngQoj2Z9OAz1cGyJKoh3A=;
        b=NuzCxNvxHGPPsuNlQjMj1Dwg03s3RXkAl4sEcRZOsjeh40b6vg1/7r57ae6Bk0Q9NM
         NoH7T5WjwDC4ys5733nwz8244eKZ7vxp5QlICXMtB0nC4tRA3dTZeQLNqIY12BYrqIxI
         JKB04vkA66S3n3ALdsw5t5Vkp4YaHfRal4LFwhyI38Tn8BrREqnXzXjJ1KT7YCgTRe3n
         mHpnWA9fi9AONRf/cs3Kc/4Z2M+PjYxRWeBeUUaCC40aCocLG97w9mksG9h127R3lyQf
         UZ3JWgBVDA3yWVKUC9xAeH1XX3XJbe5Lzl+MKX++YA6Wpc3SFOvldsDX5zklghKLgtE1
         yREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722982499; x=1723587299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXjtb86nnXZiK+81bTmuvRngQoj2Z9OAz1cGyJKoh3A=;
        b=siZiHvUo5WsTfVxv9sQbCDixKPAKzzVs8pBfvOxV5bAkEmVX97Wgd7tIWMfZAJzwH1
         bjEgo7iwckcG8rW2rNxyY8t/Wd98Uqx7wga10OB8llpnJV8kom5dkU7Bn06wmqrdQ8gN
         hYZUQRSNX+4GHHky9EsddVpruM5daCX3Oi0tcCOI0BX4Ju1mFng5ryWcOBF5PjVLUass
         JpdtuMEndM9q4WAyg52yhPkHMo9l9Sfo92XYUDCI93gWYlfG8tBEcpmhWcYH6E9dSlTX
         3Nn9ZWaWP+mBijrKSuICHImc3RULLD50DYeSPsQSokzs0lwDJ+ZPPd4f/b1m4PfUBNAT
         aETA==
X-Forwarded-Encrypted: i=1; AJvYcCXIKf/C63jRROk/GU/rAx0VYWfsGmED0Xxwb5DLPHswtkFx2us7zoCXOBbjGHa4Y74GibNTF0e2iD5QOdlcSC3RWXoZgGKyCpRTxVIN6/6KpojlLVWj5pPo0WybDc+E1r0J
X-Gm-Message-State: AOJu0YxS068XnFDrshJ2Xz5jgPzqbJ6IHs+8XutTg16no+MRlixKEREu
	tXSzwlrUz3fgMPzylrLXE+UNzejczY/qgXYMXEuJ6LEZe5hX7IGhMwlwCo+z
X-Google-Smtp-Source: AGHT+IEKpr1UFCKDIwWRxjnU/uCMgSVrE+o0Upo4NwXVrAnyDnyihhz4pz3m7yaMLFIsDF1d0jQ75A==
X-Received: by 2002:a05:6512:3c98:b0:52b:c27c:ea1f with SMTP id 2adb3069b0e04-530bb39bf01mr11779826e87.55.1722982498234;
        Tue, 06 Aug 2024 15:14:58 -0700 (PDT)
Received: from mobilestation ([95.79.225.241])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530de457b3csm3663e87.161.2024.08.06.15.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 15:14:57 -0700 (PDT)
Date: Wed, 7 Aug 2024 01:14:55 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: jitendra.vegiraju@broadcom.com
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	andrew@lunn.ch, linux@armlinux.org.uk, horms@kernel.org, 
	florian.fainelli@broadcom.com
Subject: Re: [PATCH net-next v3 2/3] net: stmmac: Integrate dwxgmac4 into
 stmmac hwif handling
Message-ID: <o4dgczjefqjek3iqw2y3ca7pwolj5e6otjyuinpuvkwcli5xei@dzehe7xde44x>
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <20240802031822.1862030-3-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802031822.1862030-3-jitendra.vegiraju@broadcom.com>

On Thu, Aug 01, 2024 at 08:18:21PM -0700, jitendra.vegiraju@broadcom.com wrote:
> From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> 
> Integrate dwxgmac4 support into stmmac hardware interface handling.
> A dwxgmac4 is an xgmac device and hence it inherits properties from
> existing stmmac_hw table entry.
> The quirks handling facility is used to update dma_ops field to
> point to dwxgmac400_dma_ops when the user version field matches.
> 
> Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/common.h |  4 +++
>  drivers/net/ethernet/stmicro/stmmac/hwif.c   | 26 +++++++++++++++++++-
>  drivers/net/ethernet/stmicro/stmmac/hwif.h   |  1 +
>  3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
> index cd36ff4da68c..9bf278e11704 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> @@ -37,11 +37,15 @@
>  #define DWXGMAC_CORE_2_10	0x21
>  #define DWXGMAC_CORE_2_20	0x22
>  #define DWXLGMAC_CORE_2_00	0x20

> +#define DWXGMAC_CORE_4_00	0x40

DW25GMAC_CORE_4_00?

>  
>  /* Device ID */
>  #define DWXGMAC_ID		0x76

What is the device ID in your case? Does it match to DWXGMAC_ID?

>  #define DWXLGMAC_ID		0x27
>  
> +/* User Version */
> +#define DWXGMAC_USER_VER_X22	0x22
> +
>  #define STMMAC_CHAN0	0	/* Always supported and default for all chips */
>  
>  /* TX and RX Descriptor Length, these need to be power of two.
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> index 29367105df54..713cb5aa2c3e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> @@ -36,6 +36,18 @@ static u32 stmmac_get_dev_id(struct stmmac_priv *priv, u32 id_reg)
>  	return (reg & GENMASK(15, 8)) >> 8;
>  }
>  

> +static u32 stmmac_get_user_version(struct stmmac_priv *priv, u32 id_reg)
> +{
> +	u32 reg = readl(priv->ioaddr + id_reg);
> +
> +	if (!reg) {
> +		dev_info(priv->device, "User Version not available\n");
> +		return 0x0;
> +	}
> +
> +	return (reg & GENMASK(23, 16)) >> 16;
> +}
> +

The User Version is purely a vendor-specific stuff defined on the
IP-core synthesis stage. Moreover I don't see you'll need it anyway.

>  static void stmmac_dwmac_mode_quirk(struct stmmac_priv *priv)
>  {
>  	struct mac_device_info *mac = priv->hw;
> @@ -82,6 +94,18 @@ static int stmmac_dwmac4_quirks(struct stmmac_priv *priv)
>  	return 0;
>  }
>  

> +static int stmmac_dwxgmac_quirks(struct stmmac_priv *priv)
> +{
> +	struct mac_device_info *mac = priv->hw;
> +	u32 user_ver;
> +
> +	user_ver = stmmac_get_user_version(priv, GMAC4_VERSION);
> +	if (priv->synopsys_id == DWXGMAC_CORE_4_00 &&
> +	    user_ver == DWXGMAC_USER_VER_X22)
> +		mac->dma = &dwxgmac400_dma_ops;
> +	return 0;
> +}
> +
>  static int stmmac_dwxlgmac_quirks(struct stmmac_priv *priv)
>  {
>  	priv->hw->xlgmac = true;
> @@ -256,7 +280,7 @@ static const struct stmmac_hwif_entry {
>  		.mmc = &dwxgmac_mmc_ops,
>  		.est = &dwmac510_est_ops,
>  		.setup = dwxgmac2_setup,
> -		.quirks = NULL,
> +		.quirks = stmmac_dwxgmac_quirks,

Why? You can just introduce a new stmmac_hw[] entry with the DW
25GMAC-specific stmmac_dma_ops instance specified.

-Serge(y)

>  	}, {
>  		.gmac = false,
>  		.gmac4 = false,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index e53c32362774..6213c496385c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -683,6 +683,7 @@ extern const struct stmmac_desc_ops dwxgmac210_desc_ops;
>  extern const struct stmmac_mmc_ops dwmac_mmc_ops;
>  extern const struct stmmac_mmc_ops dwxgmac_mmc_ops;
>  extern const struct stmmac_est_ops dwmac510_est_ops;
> +extern const struct stmmac_dma_ops dwxgmac400_dma_ops;
>  
>  #define GMAC_VERSION		0x00000020	/* GMAC CORE Version */
>  #define GMAC4_VERSION		0x00000110	/* GMAC4+ CORE Version */
> -- 
> 2.34.1
> 
> 

