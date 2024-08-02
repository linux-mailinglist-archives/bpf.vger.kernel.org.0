Return-Path: <bpf+bounces-36290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A2B945F84
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 16:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0181C21941
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 14:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F96A2101B9;
	Fri,  2 Aug 2024 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHbTgnaF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815C71171C;
	Fri,  2 Aug 2024 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722609505; cv=none; b=YGaXEXilx58pSMPzXy5D+r+ZDJtEP+/z1qUg7LN/uPKmzBgTOEQMnj26cUjdSxqthxojeoGih6u4/NbEviGXWBLmp8Q45LFjg0bk86tnm7AGWT6PCUfCbFUiS0q+tPHiK6/Lad0OFD49LaB0ark9x2K/M1/wmTsJNQWhUcb0lyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722609505; c=relaxed/simple;
	bh=71o3IObaA9yD0TmHXVj+9FSEWjx+F9BkQDM7P7obTFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBhq+yqHLY+SqPOdYpdx6thXFcygXX/1ReTav5HJPmmfTaWmFheb46ZnCr6Yg42zpdf5ad4RDECslMrwpRVDefXhFmh0T9LasXuGGoOz3MoEiqq+cIFLiw8Z4WGOky2Z0w3UeHpSIenEt4fQpRBF8bNo/OfwLDnP1JzI2i3HhHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHbTgnaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96FFC4AF0B;
	Fri,  2 Aug 2024 14:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722609505;
	bh=71o3IObaA9yD0TmHXVj+9FSEWjx+F9BkQDM7P7obTFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZHbTgnaFYKrgsR9M1xdGzOxKcaswozfv8aTwEnqKf9T80BhyLaFfXsV7g3Y23zxSB
	 45Y++ZWnlDnVAN0khOr1S8gjWTEq6o4xt5DP0dNP+DRvz3Wn3Jen5Sgn0L3FZUEfCj
	 47IR7ZEYaao6/G8KMJBu5PL6bf4V1ddZaDmYxxreZefHY37B6nMNW9wnIuxTfsXgXk
	 XoWR7oNS8BaT/73Qdwp/26IivfQdo5GoqelZBzGiycXL/oZSXtwYatuMYruchpwAWu
	 PGQk/9D1nc5SmCZIW/uIsbPOe+bNEX08CUEFQfgg63jETYD/0FvB2QQrudQ3819eBg
	 TnJ0WZyBdrY4Q==
Date: Fri, 2 Aug 2024 15:38:18 +0100
From: Simon Horman <horms@kernel.org>
To: jitendra.vegiraju@broadcom.com
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, richardcochran@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	andrew@lunn.ch, linux@armlinux.org.uk,
	florian.fainelli@broadcom.com
Subject: Re: [PATCH net-next v3 1/3] net: stmmac: Add basic dwxgmac4 support
 to stmmac core
Message-ID: <20240802143818.GB2504122@kernel.org>
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <20240802031822.1862030-2-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802031822.1862030-2-jitendra.vegiraju@broadcom.com>

On Thu, Aug 01, 2024 at 08:18:20PM -0700, jitendra.vegiraju@broadcom.com wrote:
> From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> 
> Adds support for DWC_xgmac version 4.00a in stmmac core module.
> This version adds enhancements to DMA architecture for virtualization
> scalability. This is realized by decoupling physical DMA channels (PDMA)
> from Virtual DMA channels (VDMA). The  VDMAs are software abastractions
> that map to PDMAs for frame transmission and reception.
> 
> The virtualization enhancements are currently not being used and hence
> a fixed mapping of VDMA to PDMA is configured in the init functions.
> Because of the new init functions, a new instance of struct stmmac_dma_ops
> dwxgmac400_dma_ops is added.
> Most of the other dma operation functions in existing dwxgamc2_dma.c file
> can be reused.
> 
> Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>

...

>  stmmac-$(CONFIG_STMMAC_SELFTESTS) += stmmac_selftests.o
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c

...

> @@ -641,3 +642,33 @@ const struct stmmac_dma_ops dwxgmac210_dma_ops = {
>  	.enable_sph = dwxgmac2_enable_sph,
>  	.enable_tbs = dwxgmac2_enable_tbs,
>  };
> +
> +const struct stmmac_dma_ops dwxgmac400_dma_ops = {
> +	.reset = dwxgmac2_dma_reset,
> +	.init = dwxgmac4_dma_init,
> +	.init_chan = dwxgmac2_dma_init_chan,
> +	.init_rx_chan = dwxgmac4_dma_init_rx_chan,
> +	.init_tx_chan = dwxgmac4_dma_init_tx_chan,
> +	.axi = dwxgmac2_dma_axi,
> +	.dump_regs = dwxgmac2_dma_dump_regs,
> +	.dma_rx_mode = dwxgmac2_dma_rx_mode,
> +	.dma_tx_mode = dwxgmac2_dma_tx_mode,
> +	.enable_dma_irq = dwxgmac2_enable_dma_irq,
> +	.disable_dma_irq = dwxgmac2_disable_dma_irq,
> +	.start_tx = dwxgmac2_dma_start_tx,
> +	.stop_tx = dwxgmac2_dma_stop_tx,
> +	.start_rx = dwxgmac2_dma_start_rx,
> +	.stop_rx = dwxgmac2_dma_stop_rx,
> +	.dma_interrupt = dwxgmac2_dma_interrupt,
> +	.get_hw_feature = dwxgmac2_get_hw_feature,
> +	.rx_watchdog = dwxgmac2_rx_watchdog,
> +	.set_rx_ring_len = dwxgmac2_set_rx_ring_len,
> +	.set_tx_ring_len = dwxgmac2_set_tx_ring_len,
> +	.set_rx_tail_ptr = dwxgmac2_set_rx_tail_ptr,
> +	.set_tx_tail_ptr = dwxgmac2_set_tx_tail_ptr,
> +	.enable_tso = dwxgmac2_enable_tso,
> +	.qmode = dwxgmac2_qmode,
> +	.set_bfsize = dwxgmac2_set_bfsize,
> +	.enable_sph = dwxgmac2_enable_sph,
> +	.enable_tbs = dwxgmac2_enable_tbs,
> +};

Please add dwxgmac400_dma_ops to hwif.h in this patch rather than a
subsequent one to avoid Sparse suggesting the symbol should be static.

...

