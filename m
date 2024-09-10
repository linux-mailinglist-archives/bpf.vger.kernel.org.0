Return-Path: <bpf+bounces-39528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A85A974370
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 21:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A596C1F271D2
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 19:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543091A4F1C;
	Tue, 10 Sep 2024 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtAjNgKc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC44F192B8E;
	Tue, 10 Sep 2024 19:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725996304; cv=none; b=IAPyEZ6MZTsnr9BdgDhUREp/CQ5dUugGtefY6Qhwya+eiL4nZFNfKf3oZJ2Ldqt8C2amqjKP6+DRgjRWUJuYlGjS2JYpm6w1HaiYz/0GwUwtp0umJa1e3/P1FGWpDeF8MDL7Qd02G56Kqlax7Z/JPkT8nDVTwFYvSqvVoqYfYMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725996304; c=relaxed/simple;
	bh=t+nuvwSFsH964Pv7A/ZskWoZC2MJcMqEpbjI8doy/TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqOGXh4xru77B9EaiM+wPXHMi+Vf+xAKus8ZNOE5Ik1DjGQnxJdNoudqeZbc7mhXKGC3UN52LyRFwEuOGEysS+gjPNhBt91zE6bSidHG4TmrkqPxCOTi4iPmIJFG033X9vUF+aMK8KNTHFSgNcCbrLf1OUdHOYOZXQ7bxAY0l10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtAjNgKc; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-535be093a43so1650933e87.3;
        Tue, 10 Sep 2024 12:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725996301; x=1726601101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F+liXnOTOUZPV47MWD+3+P5kmqr14y4l2/py1L5IUI8=;
        b=TtAjNgKcBiDLt0MKTNnqgNqRS4vkAujy1zteso4/FpaXIKLBV9bUE3u7aZNYgpqy9r
         n6t5uiXfYXEZ5POPMf0TO41Gn4x80a6kgBdSVo1Rxzx/NHK9USmjr4DKm8tUZuBbIcwD
         Kuhk0RiICNsYeiCcp5uX5zbbf5/dSBG//YkqorAwaX1lZUnyUn9K/cCe4hZooYNBgMko
         w+pt1o4HmbwK5NrbKR8bKbImgzHtRD/iqZygvAw5/9QN62eUC0xR4LNDVi6v9NNjXrkm
         xWqsoHHPIXir90opscVz18+vgNbi2RdBu1w+5yNkEJ0cnFBxkAkgtVp3z6//l3WEV8Co
         OuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725996301; x=1726601101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+liXnOTOUZPV47MWD+3+P5kmqr14y4l2/py1L5IUI8=;
        b=Ye8ML1cylShK2css+ZDWfEdEEnZs3eWXWWfycn/KDQf3i4B96gJXu0h+mcWb2Br96i
         wEBM9452ztuZ8RTnh/+Xoe+tKmTUBAmlWxXyGrN9TYsydlGkS1mBHTuZ0lsMAXxcAWUR
         IQFeOqGQZnhMk8S1hCJ6I7Qe3G/HJDAIxvgP6xWnfPPG3hdv1FgYg8BBbbsGp6fvg4WA
         itTMn9136/53OU1vMWUyfJ4N/YT1IRh0EimL9iBTsMn4RpHvWnIBmryoNM7LKIUrvWbS
         M8SrKvNw6PNyKW1/4osAnu4jjz9oufpkDyyanQ9S2G0KiSZpFYj0UXA1klIZmDbUxixG
         LhKw==
X-Forwarded-Encrypted: i=1; AJvYcCUS1HaMyg5PujX7rEx3VAJMcKn5SelpTUBMVkfbN4B4PbXjOKgPxNNfGdWY37XQENvt0Nk=@vger.kernel.org, AJvYcCWjQZ9lfmbqFKPb92GJ+xPdvdHn15uOC6xVaENjzWB3bvzv6xyW4PlA4qlzVbzvVddpIKCvMkEYq9UxB98l@vger.kernel.org
X-Gm-Message-State: AOJu0YzbwjnhB9HTsaA0qTI3s3m1TOWRv1h15oIrmvgnvivm5rAVcu7C
	KqriAQ2l1i0sKnWVXj8u0jkNLnqIzP/PwOiXyIY09faNhqvWGEkH
X-Google-Smtp-Source: AGHT+IH7h7nMsPnJM5DLDYU7ruoVNkI47PUGmGGDvmGbr5hRc1m5j2pA6BQCYOGF0ngdjX3ukTQR4g==
X-Received: by 2002:a05:6512:1589:b0:52e:a68a:6076 with SMTP id 2adb3069b0e04-53673ca1524mr327461e87.49.1725996299754;
        Tue, 10 Sep 2024 12:24:59 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f8cabddsm1279795e87.149.2024.09.10.12.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 12:24:59 -0700 (PDT)
Date: Tue, 10 Sep 2024 22:24:55 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: jitendra.vegiraju@broadcom.com
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, rmk+kernel@armlinux.org.uk, ahalaney@redhat.com, 
	xiaolei.wang@windriver.com, rohan.g.thomas@intel.com, Jianheng.Zhang@synopsys.com, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, linux@armlinux.org.uk, 
	horms@kernel.org, florian.fainelli@broadcom.com
Subject: Re: [PATCH net-next v5 2/5] net: stmmac: Add basic dw25gmac support
 in stmmac core
Message-ID: <mhfssgiv7unjlpve45rznyzr72llvchcwzk4f7obnvp5edijqc@ilmxqr5gaktb>
References: <20240904054815.1341712-1-jitendra.vegiraju@broadcom.com>
 <20240904054815.1341712-3-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904054815.1341712-3-jitendra.vegiraju@broadcom.com>

On Tue, Sep 03, 2024 at 10:48:12PM -0700, jitendra.vegiraju@broadcom.com wrote:
> From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> 
> The BCM8958x uses early adopter version of DWC_xgmac version 4.00a for
> Ethernet MAC. The DW25GMAC introduced in this version adds new DMA
> architecture called Hyper-DMA (HDMA) for virtualization scalability.
> This is realized by decoupling physical DMA channels(PDMA) from potentially
> large number of virtual DMA channels (VDMA). The VDMAs are software
> abstractions that map to PDMAs for frame transmission and reception.
> 
> Define new macros DW25GMAC_CORE_4_00 and DW25GMAC_ID to identify 25GMAC
> device.
> To support the new HDMA architecture, a new instance of stmmac_dma_ops
> dw25gmac400_dma_ops is added.
> Most of the other dma operation functions in existing dwxgamc2_dma.c file
> are reused where applicable.
> Added setup function for DW25GMAC's stmmac_hwif_entry in stmmac core.
> 
> Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
>  drivers/net/ethernet/stmicro/stmmac/common.h  |   4 +
>  .../net/ethernet/stmicro/stmmac/dw25gmac.c    | 224 ++++++++++++++++++
>  .../net/ethernet/stmicro/stmmac/dw25gmac.h    |  92 +++++++
>  .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |   1 +
>  .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  43 ++++
>  .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  31 +++
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |   1 +
>  8 files changed, 397 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dw25gmac.c
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dw25gmac.h
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
> index c2f0e91f6bf8..967e8a9aa432 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
> +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
> @@ -6,7 +6,7 @@ stmmac-objs:= stmmac_main.o stmmac_ethtool.o stmmac_mdio.o ring_mode.o	\
>  	      mmc_core.o stmmac_hwtstamp.o stmmac_ptp.o dwmac4_descs.o	\
>  	      dwmac4_dma.o dwmac4_lib.o dwmac4_core.o dwmac5.o hwif.o \
>  	      stmmac_tc.o dwxgmac2_core.o dwxgmac2_dma.o dwxgmac2_descs.o \
> -	      stmmac_xdp.o stmmac_est.o \
> +	      stmmac_xdp.o stmmac_est.o dw25gmac.o \
>  	      $(stmmac-y)
>  
>  stmmac-$(CONFIG_STMMAC_SELFTESTS) += stmmac_selftests.o
> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
> index 684489156dce..9a747b89ba51 100644
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
> @@ -563,6 +565,7 @@ struct mac_link {
>  		u32 speed2500;
>  		u32 speed5000;
>  		u32 speed10000;
> +		u32 speed25000;
>  	} xgmii;
>  	struct {
>  		u32 speed25000;
> @@ -621,6 +624,7 @@ int dwmac100_setup(struct stmmac_priv *priv);
>  int dwmac1000_setup(struct stmmac_priv *priv);
>  int dwmac4_setup(struct stmmac_priv *priv);
>  int dwxgmac2_setup(struct stmmac_priv *priv);
> +int dw25gmac_setup(struct stmmac_priv *priv);
>  int dwxlgmac2_setup(struct stmmac_priv *priv);
>  
>  void stmmac_set_mac_addr(void __iomem *ioaddr, const u8 addr[6],
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dw25gmac.c b/drivers/net/ethernet/stmicro/stmmac/dw25gmac.c
> new file mode 100644
> index 000000000000..adb33700ffbb
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dw25gmac.c
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024 Broadcom Corporation
> + */
> +#include "stmmac.h"
> +#include "dwxgmac2.h"
> +#include "dw25gmac.h"
> +
> +static u32 decode_vdma_count(u32 regval)
> +{
> +	/* compressed encoding for vdma count
> +	 * regval: VDMA count
> +	 * 0-15	 : 1 - 16
> +	 * 16-19 : 20, 24, 28, 32
> +	 * 20-23 : 40, 48, 56, 64
> +	 * 24-27 : 80, 96, 112, 128
> +	 */
> +	if (regval < 16)
> +		return regval + 1;
> +	return (4 << ((regval - 16) / 4)) * ((regval % 4) + 5);

The shortest code isn't always the best one. This one gives me a
headache in trying to decipher whether it really matches to what is
described in the comment. What about just:

	if (regval < 16) /* Direct mapping */
		return regval + 1;
	else if (regval < 20) /* 20, 24, 28, 32 */
		return 20 + (regval - 16) * 4;
	else if (regval < 24) /* 40, 48, 56, 64 */
		return 40 + (regval - 20) * 8;
	else if (regval < 28) /* 80, 96, 112, 128 */
		return 80 + (regval - 24) * 16;

?

> +}
> +
> +static void dw25gmac_read_hdma_limits(void __iomem *ioaddr,
> +				      struct stmmac_hdma_cfg *hdma)
> +{
> +	u32 hw_cap;
> +
> +	/* Get VDMA/PDMA counts from HW */
> +	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE2);


> +	hdma->tx_vdmas = decode_vdma_count(FIELD_GET(XXVGMAC_HWFEAT_VDMA_TXCNT,
> +						     hw_cap));
> +	hdma->rx_vdmas = decode_vdma_count(FIELD_GET(XXVGMAC_HWFEAT_VDMA_RXCNT,
> +						     hw_cap));
> +	hdma->tx_pdmas = FIELD_GET(XGMAC_HWFEAT_TXQCNT, hw_cap) + 1;
> +	hdma->rx_pdmas = FIELD_GET(XGMAC_HWFEAT_RXQCNT, hw_cap) + 1;

Hmm, these are the Tx/Rx DMA-channels and Tx/Rx MTL-queues count
fields. Can't you just use the
dma_features::{number_tx_channel,number_tx_queues} and
dma_features::{number_rx_channel,number_rx_queues} fields to store the
retrieved data?

Moreover why not to add the code above to the dwxgmac2_get_hw_feature() method?

> +}
> +
> +int dw25gmac_hdma_cfg_init(struct stmmac_priv *priv)
> +{
> +	struct plat_stmmacenet_data *plat = priv->plat;
> +	struct device *dev = priv->device;
> +	struct stmmac_hdma_cfg *hdma;
> +	int i;
> +
> +	hdma = devm_kzalloc(dev,
> +			    sizeof(*plat->dma_cfg->hdma_cfg),
> +			    GFP_KERNEL);
> +	if (!hdma)
> +		return -ENOMEM;
> +
> +	dw25gmac_read_hdma_limits(priv->ioaddr, hdma);
> +
> +	hdma->tvdma_tc = devm_kzalloc(dev,
> +				      sizeof(*hdma->tvdma_tc) * hdma->tx_vdmas,
> +				      GFP_KERNEL);
> +	if (!hdma->tvdma_tc)
> +		return -ENOMEM;
> +
> +	hdma->rvdma_tc = devm_kzalloc(dev,
> +				      sizeof(*hdma->rvdma_tc) * hdma->rx_vdmas,
> +				      GFP_KERNEL);
> +	if (!hdma->rvdma_tc)
> +		return -ENOMEM;
> +
> +	hdma->tpdma_tc = devm_kzalloc(dev,
> +				      sizeof(*hdma->tpdma_tc) * hdma->tx_pdmas,
> +				      GFP_KERNEL);
> +	if (!hdma->tpdma_tc)
> +		return -ENOMEM;
> +
> +	hdma->rpdma_tc = devm_kzalloc(dev,
> +				      sizeof(*hdma->rpdma_tc) * hdma->rx_pdmas,
> +				      GFP_KERNEL);
> +	if (!hdma->rpdma_tc)
> +		return -ENOMEM;
> +

> +	/* Initialize one-to-one mapping for each of the used queues */
> +	for (i = 0; i < plat->tx_queues_to_use; i++) {
> +		hdma->tvdma_tc[i] = i;
> +		hdma->tpdma_tc[i] = i;
> +	}
> +	for (i = 0; i < plat->rx_queues_to_use; i++) {
> +		hdma->rvdma_tc[i] = i;
> +		hdma->rpdma_tc[i] = i;
> +	}

So the Traffic Class ID is initialized for the
tx_queues_to_use/rx_queues_to_use number of channels only, right? What
about the Virtual and Physical DMA-channels with numbers greater than
these values?

> +	plat->dma_cfg->hdma_cfg = hdma;
> +
> +	return 0;
> +}
> +
> +static int rd_dma_ch_ind(void __iomem *ioaddr, u8 mode, u32 channel)
> +{
> +	u32 reg_val = 0;
> +
> +	reg_val |= FIELD_PREP(XXVGMAC_MODE_SELECT, mode);
> +	reg_val |= FIELD_PREP(XXVGMAC_ADDR_OFFSET, channel);
> +	reg_val |= XXVGMAC_CMD_TYPE | XXVGMAC_OB;
> +	writel(reg_val, ioaddr + XXVGMAC_DMA_CH_IND_CONTROL);
> +	return readl(ioaddr + XXVGMAC_DMA_CH_IND_DATA);
> +}
> +
> +static void wr_dma_ch_ind(void __iomem *ioaddr, u8 mode, u32 channel, u32 val)
> +{
> +	u32 reg_val = 0;
> +
> +	writel(val, ioaddr + XXVGMAC_DMA_CH_IND_DATA);
> +	reg_val |= FIELD_PREP(XXVGMAC_MODE_SELECT, mode);
> +	reg_val |= FIELD_PREP(XXVGMAC_ADDR_OFFSET, channel);
> +	reg_val |= XGMAC_OB;
> +	writel(reg_val, ioaddr + XXVGMAC_DMA_CH_IND_CONTROL);
> +}
> +
> +static void xgmac4_tp2tc_map(void __iomem *ioaddr, u8 pdma_ch, u32 tc_num)
> +{
> +	u32 val = 0;
> +
> +	val = rd_dma_ch_ind(ioaddr, MODE_TXEXTCFG, pdma_ch);
> +	val &= ~XXVGMAC_TP2TCMP;
> +	val |= FIELD_PREP(XXVGMAC_TP2TCMP, tc_num);
> +	wr_dma_ch_ind(ioaddr, MODE_TXEXTCFG, pdma_ch, val);
> +}
> +
> +static void xgmac4_rp2tc_map(void __iomem *ioaddr, u8 pdma_ch, u32 tc_num)
> +{
> +	u32 val = 0;
> +
> +	val = rd_dma_ch_ind(ioaddr, MODE_RXEXTCFG, pdma_ch);
> +	val &= ~XXVGMAC_RP2TCMP;
> +	val |= FIELD_PREP(XXVGMAC_RP2TCMP, tc_num);
> +	wr_dma_ch_ind(ioaddr, MODE_RXEXTCFG, pdma_ch, val);
> +}
> +
> +void dw25gmac_dma_init(void __iomem *ioaddr,
> +		       struct stmmac_dma_cfg *dma_cfg)
> +{
> +	u32 value;
> +	u32 i;
> +
> +	value = readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
> +	value &= ~(XGMAC_AAL | XGMAC_EAME);
> +	if (dma_cfg->aal)
> +		value |= XGMAC_AAL;
> +	if (dma_cfg->eame)
> +		value |= XGMAC_EAME;
> +	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
> +
> +	for (i = 0; i < dma_cfg->hdma_cfg->tx_vdmas; i++) {
> +		value = rd_dma_ch_ind(ioaddr, MODE_TXDESCCTRL, i);
> +		value &= ~XXVGMAC_TXDCSZ;
> +		value |= FIELD_PREP(XXVGMAC_TXDCSZ,
> +				    XXVGMAC_TXDCSZ_256BYTES);
> +		value &= ~XXVGMAC_TDPS;
> +		value |= FIELD_PREP(XXVGMAC_TDPS, XXVGMAC_TDPS_HALF);
> +		wr_dma_ch_ind(ioaddr, MODE_TXDESCCTRL, i, value);
> +	}
> +
> +	for (i = 0; i < dma_cfg->hdma_cfg->rx_vdmas; i++) {
> +		value = rd_dma_ch_ind(ioaddr, MODE_RXDESCCTRL, i);
> +		value &= ~XXVGMAC_RXDCSZ;
> +		value |= FIELD_PREP(XXVGMAC_RXDCSZ,
> +				    XXVGMAC_RXDCSZ_256BYTES);
> +		value &= ~XXVGMAC_RDPS;
> +		value |= FIELD_PREP(XXVGMAC_TDPS, XXVGMAC_RDPS_HALF);
> +		wr_dma_ch_ind(ioaddr, MODE_RXDESCCTRL, i, value);
> +	}
> +

> +	for (i = 0; i < dma_cfg->hdma_cfg->tx_pdmas; i++) {
> +		value = rd_dma_ch_ind(ioaddr, MODE_TXEXTCFG, i);
> +		value &= ~(XXVGMAC_TXPBL | XXVGMAC_TPBLX8_MODE);
> +		if (dma_cfg->pblx8)
> +			value |= XXVGMAC_TPBLX8_MODE;
> +		value |= FIELD_PREP(XXVGMAC_TXPBL, dma_cfg->pbl);
> +		wr_dma_ch_ind(ioaddr, MODE_TXEXTCFG, i, value);
> +		xgmac4_tp2tc_map(ioaddr, i, dma_cfg->hdma_cfg->tpdma_tc[i]);
> +	}
> +
> +	for (i = 0; i < dma_cfg->hdma_cfg->rx_pdmas; i++) {
> +		value = rd_dma_ch_ind(ioaddr, MODE_RXEXTCFG, i);
> +		value &= ~(XXVGMAC_RXPBL | XXVGMAC_RPBLX8_MODE);
> +		if (dma_cfg->pblx8)
> +			value |= XXVGMAC_RPBLX8_MODE;
> +		value |= FIELD_PREP(XXVGMAC_RXPBL, dma_cfg->pbl);
> +		wr_dma_ch_ind(ioaddr, MODE_RXEXTCFG, i, value);
> +		xgmac4_rp2tc_map(ioaddr, i, dma_cfg->hdma_cfg->rpdma_tc[i]);

What if tx_pdmas doesn't match plat_stmmacenet_data::tx_queues_to_use
and rx_pdmas doesn't match to plat_stmmacenet_data::rx_queues_to_use?

If they don't then you'll get out of the initialized tpdma_tc/rpdma_tc
fields and these channels will be pre-initialized with the zero TC. Is
that what expected? I doubt so.

> +	}
> +}
> +

> +void dw25gmac_dma_init_tx_chan(struct stmmac_priv *priv,
> +			       void __iomem *ioaddr,
> +			       struct stmmac_dma_cfg *dma_cfg,
> +			       dma_addr_t dma_addr, u32 chan)
> +{
> +	u32 value;
> +

> +	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> +	value &= ~XXVGMAC_TVDMA2TCMP;
> +	value |= FIELD_PREP(XXVGMAC_TVDMA2TCMP,
> +			    dma_cfg->hdma_cfg->tvdma_tc[chan]);
> +	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));

Please note this will have only first
plat_stmmacenet_data::{tx_queues_to_use,rx_queues_to_use} VDMA
channels initialized. Don't you have much more than just 4 channels?

> +
> +	writel(upper_32_bits(dma_addr),
> +	       ioaddr + XGMAC_DMA_CH_TxDESC_HADDR(chan));
> +	writel(lower_32_bits(dma_addr),
> +	       ioaddr + XGMAC_DMA_CH_TxDESC_LADDR(chan));
> +}
> +
> +void dw25gmac_dma_init_rx_chan(struct stmmac_priv *priv,
> +			       void __iomem *ioaddr,
> +			       struct stmmac_dma_cfg *dma_cfg,
> +			       dma_addr_t dma_addr, u32 chan)
> +{
> +	u32 value;
> +

> +	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
> +	value &= ~XXVGMAC_RVDMA2TCMP;
> +	value |= FIELD_PREP(XXVGMAC_RVDMA2TCMP,
> +			    dma_cfg->hdma_cfg->rvdma_tc[chan]);
> +	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));

The same question.

> +
> +	writel(upper_32_bits(dma_addr),
> +	       ioaddr + XGMAC_DMA_CH_RxDESC_HADDR(chan));
> +	writel(lower_32_bits(dma_addr),
> +	       ioaddr + XGMAC_DMA_CH_RxDESC_LADDR(chan));
> +}

These methods are called for each
plat_stmmacenet_data::{tx_queues_to_use,rx_queues_to_use}
DMA-channel/Queue. The static mapping means you'll have each
PDMA/Queue assigned a static traffic class ID corresponding to the
channel ID. Meanwhile the VDMA channels are supposed to be initialized
with the TC ID corresponding to the matching PDMA ID.

The TC ID in this case is passed as the DMA/Queue channel ID. Then the
Tx/Rx DMA-channels init methods can be converted to:

dw25gmac_dma_init_Xx_chan(chan)
{
	/* Map each chan-th VDMA to the single chan PDMA by assigning
	 * the static TC ID.
	 */
	for (i = chan; i < Xx_vdmas; i += (Xx_vdmas / Xx_queues_to_use)) {
		/* Initialize VDMA channels */
		XXVGMAC_TVDMA2TCMP = chan;
	}

	/* Assign the static TC ID to the specified PDMA channel */
	xgmac4_rp2tc_map(chan, chan)
}

, where X={t,r}.

Thus you can redistribute the loops implemented in dw25gmac_dma_init()
to the respective Tx/Rx DMA-channel init methods.

Am I missing something?

-Serge()

> [...]

