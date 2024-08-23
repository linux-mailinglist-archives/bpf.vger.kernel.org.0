Return-Path: <bpf+bounces-37952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7CF95CE5E
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 15:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492E61F21F09
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 13:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173E0188596;
	Fri, 23 Aug 2024 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIunKEcd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED0518660E;
	Fri, 23 Aug 2024 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724420947; cv=none; b=h3SFvwhiowrPhdb626OFj4c6xSBozOSZIvJbXxW/zcAgm6bvNYQEsZ2KwgXWms8S1QuNyyxZ9qCnwJgMixTMdwfoCDodrobgKqM0au06CZbqc+pVjnFU7Zl07sJl9kf4hyRvjK49sG7OX93NyUEXkvn/7milo7qkumEsMNCRXVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724420947; c=relaxed/simple;
	bh=YMftd6XZeiGQUSkzplX6UUjBW8Ul0425anmLA1D6RN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzgpuKGLGlzRi9pJAYjlKpWLbngLlg3CniZ5UuZhptmHtK3eKbukTkiBjX8pP5yHHvYOyDvV77kdI/LFVXeZQXEOPvtOKBaW56y4kwg9mzF4MhfuARFjBU+ANEoXEFASVSk9LHDkKjXLm8XDXKhWbWfX+/5bqvKhFjfAF80lAB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIunKEcd; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5334e41c30bso2129126e87.0;
        Fri, 23 Aug 2024 06:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724420944; x=1725025744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j0rAa/Diw1/WxbqtV5SQj80lVWGH9itqJcEAREaEyNk=;
        b=DIunKEcd1ob5AAb5Nfiz2nS5nPjvi4Y7EqbJkgzqodeEIHWprD74+N19inFWb0sKN1
         3XoaJoDsu9j2a8mEu17U/sJHoscLcDt5jXFeRIRzGqawSLY4ZwMCDFJOfJAMWzHyYPm3
         HfhbkNLvvKuF0sCtSNXIivE1i3PM5+Jnq3jn6ThTg01rmHqs3A//Gzwkpb0XG7E4Mr3y
         NpY+OycSsVN9oHh0Lm4sDYn5FxLzAHgEWkdpZvO3+U1gqio3SEXywaZUhun5kne1e8Cv
         d/HnqUBgqA2x2iqAe2QxoqVkjK8V5fRMxe+47k5+e6JVwDCNkUMaPrwURzY3kUVNSo7i
         sOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724420944; x=1725025744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0rAa/Diw1/WxbqtV5SQj80lVWGH9itqJcEAREaEyNk=;
        b=ZyvDLfw7t1ym4GZa3x/xfmtUjA9KkW/7neGAeSN9BtbWmvWbw5pzyMQiOUfRyZFKZt
         xK0TPm55t7KwROx13TwSXuvw4uAodbbw0RrbHeutvEZcvy8PndPVgZ6ThgaklXCMslxG
         tioMjoO5Mi7FBefo6qjh99HuxIMwuYy/e66THFxSc3k+GOy/3GYwPTaUORiOYYCrtKNa
         Zl3RGDU4x2X4debpgvtW4tqAUu+hTyQBlUAtCrZr7LqyIkcFJwmePp6qmYj0VWYXglrv
         wsl13pV2SWeO5TCcsiEZSC3BXj7r+7A8LJv3Q7ssZp0UwrK3duZymqyWmOyWz1tXBb3q
         6C0g==
X-Forwarded-Encrypted: i=1; AJvYcCUmzzT5n3yvMXBlWZmCtXuKhmY3pg3PfPPBY9J28fVgSiCfthERI+BQsZL0htv/ZM+rnHk=@vger.kernel.org, AJvYcCVP3j62TB3Dz3UCiUvbTc+n/VpSG86r3B3sIXYrFygTMhG2Gp3loG/QxF6q+2wlXNiEqtqKr8nvciKwOnNV@vger.kernel.org
X-Gm-Message-State: AOJu0YyO7MqeyWzOs2O0xt5VjdeLWEjE4tOWGm7+XyEqBWsv0X6Az4fk
	TRHGGubGEUbZz6jKoZfHU4tcQ++LPYTyh5wTo1nIXjBjk6Rxca4o
X-Google-Smtp-Source: AGHT+IGm6RnZflH6pQQEhkfwEn48Hiaxow66a2JnEtfny/y8K7ryKkohPurdHVQhp41PUetWoXRf4A==
X-Received: by 2002:a05:6512:39c5:b0:533:46cc:a736 with SMTP id 2adb3069b0e04-534387be65emr1558356e87.37.1724420943446;
        Fri, 23 Aug 2024 06:49:03 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea36c0esm544064e87.98.2024.08.23.06.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 06:49:03 -0700 (PDT)
Date: Fri, 23 Aug 2024 16:48:59 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: jitendra.vegiraju@broadcom.com
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, rmk+kernel@armlinux.org.uk, ahalaney@redhat.com, 
	xiaolei.wang@windriver.com, rohan.g.thomas@intel.com, Jianheng.Zhang@synopsys.com, 
	leong.ching.swee@intel.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	andrew@lunn.ch, linux@armlinux.org.uk, horms@kernel.org, 
	florian.fainelli@broadcom.com
Subject: Re: [net-next v4 3/5] net: stmmac: Integrate dw25gmac into stmmac
 hwif handling
Message-ID: <vxpwwstbvbruaafcatq5zyi257hf25x5levct3y7s7ympcsqvh@b6wmfkd4cxfy>
References: <20240814221818.2612484-1-jitendra.vegiraju@broadcom.com>
 <20240814221818.2612484-4-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814221818.2612484-4-jitendra.vegiraju@broadcom.com>

Hi Jitendra

On Wed, Aug 14, 2024 at 03:18:16PM -0700, jitendra.vegiraju@broadcom.com wrote:
> From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> 
> Integrate dw25gmac support into stmmac hardware interface handling.
> Added a new entry to the stmmac_hw table in hwif.c.
> Define new macros DW25GMAC_CORE_4_00 and DW25GMAC_ID to identify 25GMAC
> device.
> Since BCM8958x is an early adaptor device, the synopsis_id reported in HW
> is 0x32 and device_id is DWXGMAC_ID. Provide override support by defining
> synopsys_dev_id member in struct stmmac_priv so that driver specific setup
> functions can override the hardware reported values.
> 
> Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/common.h |  2 ++
>  drivers/net/ethernet/stmicro/stmmac/hwif.c   | 25 ++++++++++++++++++--
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h |  1 +
>  3 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
> index 684489156dce..46edbe73a124 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> @@ -38,9 +38,11 @@
>  #define DWXGMAC_CORE_2_10	0x21
>  #define DWXGMAC_CORE_2_20	0x22
>  #define DWXLGMAC_CORE_2_00	0x20
> +#define DW25GMAC_CORE_4_00	0x40
>  
>  /* Device ID */
>  #define DWXGMAC_ID		0x76
> +#define DW25GMAC_ID		0x55
>  #define DWXLGMAC_ID		0x27
>  
>  #define STMMAC_CHAN0	0	/* Always supported and default for all chips */
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> index 29367105df54..97e5594ddcda 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> @@ -278,6 +278,27 @@ static const struct stmmac_hwif_entry {
>  		.est = &dwmac510_est_ops,
>  		.setup = dwxlgmac2_setup,
>  		.quirks = stmmac_dwxlgmac_quirks,

> +	}, {
> +		.gmac = false,
> +		.gmac4 = false,
> +		.xgmac = true,
> +		.min_id = DW25GMAC_CORE_4_00,
> +		.dev_id = DW25GMAC_ID,
> +		.regs = {
> +			.ptp_off = PTP_XGMAC_OFFSET,
> +			.mmc_off = MMC_XGMAC_OFFSET,
> +			.est_off = EST_XGMAC_OFFSET,
> +		},
> +		.desc = &dwxgmac210_desc_ops,
> +		.dma = &dw25gmac400_dma_ops,
> +		.mac = &dwxgmac210_ops,
> +		.hwtimestamp = &stmmac_ptp,
> +		.mode = NULL,
> +		.tc = &dwmac510_tc_ops,
> +		.mmc = &dwxgmac_mmc_ops,
> +		.est = &dwmac510_est_ops,
> +		.setup = dwxgmac2_setup,
> +		.quirks = NULL,
>  	},

This can be replaced with just:

+	}, {
+		.gmac = false,
+		.gmac4 = false,
+		.xgmac = true,
+		.min_id = DW25GMAC_CORE_4_00,
+		.dev_id = DWXGMAC_ID, /* Early DW 25GMAC IP-core had XGMAC ID */
+		.regs = {
+			.ptp_off = PTP_XGMAC_OFFSET,
+			.mmc_off = MMC_XGMAC_OFFSET,
+			.est_off = EST_XGMAC_OFFSET,
+		},
+		.desc = &dwxgmac210_desc_ops,
+		.dma = &dw25gmac400_dma_ops,
+		.mac = &dwxgmac210_ops,
+		.hwtimestamp = &stmmac_ptp,
+		.mode = NULL,
+		.tc = &dwmac510_tc_ops,
+		.mmc = &dwxgmac_mmc_ops,
+		.est = &dwmac510_est_ops,
+		.setup = dw25gmac_setup,
+		.quirks = NULL,
	}

and you won't need to pre-define the setup() method in the
glue driver. Instead you can define a new dw25xgmac_setup() method in
the dwxgmac2_core.c as it's done for the DW XGMAC/LXGMAC IP-cores.

Note if your device is capable to work with up to 10Gbps speed, then
just set the plat_stmmacenet_data::max_speed field to SPEED_10000.
Alternatively if you really need to specify the exact MAC
capabilities, then you can implement what Russell suggested here
sometime ago:
https://lore.kernel.org/netdev/Zf3ifH%2FCjyHtmXE3@shell.armlinux.org.uk/

If you also have a DW 25GMAC-based device with 0x55 device ID, then
just add another stmmac_hw[] array entry.

>  };
>  
> @@ -304,7 +325,7 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
>  
>  	/* Save ID for later use */
>  	priv->synopsys_id = id;
> -
> +	priv->synopsys_dev_id = dev_id;
>  	/* Lets assume some safe values first */
>  	priv->ptpaddr = priv->ioaddr +
>  		(needs_gmac4 ? PTP_GMAC4_OFFSET : PTP_GMAC3_X_OFFSET);
> @@ -339,7 +360,7 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
>  		/* Use synopsys_id var because some setups can override this */
>  		if (priv->synopsys_id < entry->min_id)
>  			continue;
> -		if (needs_xgmac && (dev_id ^ entry->dev_id))
> +		if (needs_xgmac && (priv->synopsys_dev_id ^ entry->dev_id))
>  			continue;
>  
>  		/* Only use generic HW helpers if needed */
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index b23b920eedb1..9784bbaf9a51 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -282,6 +282,7 @@ struct stmmac_priv {
>  	struct stmmac_counters mmc;
>  	int hw_cap_support;
>  	int synopsys_id;

> +	int synopsys_dev_id;

With the suggestion above implemented you won't need this.

-Serge(y)

>  	u32 msg_enable;
>  	int wolopts;
>  	int wol_irq;
> -- 
> 2.34.1
> 

