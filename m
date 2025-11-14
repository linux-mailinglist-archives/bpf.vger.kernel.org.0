Return-Path: <bpf+bounces-74500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F584C5C9F3
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 11:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E6F29356694
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 10:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F6A31282C;
	Fri, 14 Nov 2025 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXyqydi2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B05530E0D0;
	Fri, 14 Nov 2025 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763116407; cv=none; b=DfuWSfYyPNhaQ9GQA8sSe2LX0NVZzktl0F8BXUf+p5ZDBEYgTrzmzB2CGaebMTkCFmEpotkroXOpdoLtnRdve7HfQNsIyCHuqRyJAqyYPXgfciw9xFitTqTWSPhWmygd+5hBcknidQPsNZSpzDrD8FgDQxhDdVcDdpjmYUJeoe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763116407; c=relaxed/simple;
	bh=b5OwkNMvy1x2IysaOqDsG57B8PQrzrGFhfkbSYYkR0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvFNgh8tTxSoZXHk7ZsFe8cF4HdqYpxOGMMYp+vaCa22xmnRAZpJqrNLyjIre3P/hOW2oW4VmokBkozs4sZCoBWMCoj+ulHYpaGOCMPxhYvFC5ECeinuD5hVQbJcSbrWwRAh9MjGIpr7cwMOPykiaT7DLqXVHc8ZSBDmixeS2Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXyqydi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6D8C19421;
	Fri, 14 Nov 2025 10:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763116406;
	bh=b5OwkNMvy1x2IysaOqDsG57B8PQrzrGFhfkbSYYkR0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HXyqydi2lZnpyrw0/0lR0YpZSKujyfxxMKaUGDtahDIfqEtu2IhKlYLGiFiNp099a
	 sH1MABdbFsTk8b/RExfQfa5+BE7oRzzP5rT4HX71LoLe5Jbkuz/7MW/Zbc6Dsok55P
	 z+7x6UlX0MPC63XsIdSkoq4y61m4hpV2b0iyrDAj3E8Z0BT8AbapSk9oqbvbpvm/Wc
	 3AadrhNV6gfNdF7zUvaFohO42kaQ3CoJX5cNic+oKWI8jI+RK0LEZ+TObjXOmFlbcq
	 XwbI/C1fqbXSa48xYujH5mxmAaTGqF4T4K6g1w3GW5s9VTnlRstsMNrB+pQUl0C0y9
	 d2C769XDAMMTA==
Date: Fri, 14 Nov 2025 10:33:19 +0000
From: Simon Horman <horms@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: namcao@linutronix.de, vadim.fedorenko@linux.dev,
	jacob.e.keller@intel.com, christian.koenig@amd.com,
	sumit.semwal@linaro.org, sdf@fomichev.me, john.fastabend@gmail.com,
	hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
Subject: Re: [PATCH net-next v5 5/6] net: ti: icssg-prueth: Add AF_XDP zero
 copy for RX
Message-ID: <aRcFb-vsoLw24MbU@horms.kernel.org>
References: <20251111101523.3160680-1-m-malladi@ti.com>
 <20251111101523.3160680-6-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111101523.3160680-6-m-malladi@ti.com>

On Tue, Nov 11, 2025 at 03:45:22PM +0530, Meghana Malladi wrote:

...

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c

...

> +static int prueth_dma_rx_push_mapped_zc(struct prueth_emac *emac,
> +					struct prueth_rx_chn *rx_chn,
> +					struct xdp_buff *xdp)
> +{
> +	struct net_device *ndev = emac->ndev;
> +	struct cppi5_host_desc_t *desc_rx;
> +	struct prueth_swdata *swdata;
> +	dma_addr_t desc_dma;
> +	dma_addr_t buf_dma;
> +	int buf_len;
> +
> +	buf_dma = xsk_buff_xdp_get_dma(xdp);
> +	desc_rx = k3_cppi_desc_pool_alloc(rx_chn->desc_pool);
> +	if (!desc_rx) {
> +		netdev_err(ndev, "rx push: failed to allocate descriptor\n");
> +		return -ENOMEM;
> +	}
> +	desc_dma = k3_cppi_desc_pool_virt2dma(rx_chn->desc_pool, desc_rx);
> +
> +	cppi5_hdesc_init(desc_rx, CPPI5_INFO0_HDESC_EPIB_PRESENT,
> +			 PRUETH_NAV_PS_DATA_SIZE);
> +	k3_udma_glue_rx_dma_to_cppi5_addr(rx_chn->rx_chn, &buf_dma);
> +	buf_len = xsk_pool_get_rx_frame_size(rx_chn->xsk_pool);
> +	cppi5_hdesc_attach_buf(desc_rx, buf_dma, buf_len, buf_dma, buf_len);
> +	swdata = cppi5_hdesc_get_swdata(desc_rx);
> +	swdata->type = PRUETH_SWDATA_XSK;
> +	swdata->data.xdp = xdp;
> +
> +	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, PRUETH_RX_FLOW_DATA,
> +					desc_rx, desc_dma);
> +
> +	return 0;

nit: The line above is dead code.

> +}

...

