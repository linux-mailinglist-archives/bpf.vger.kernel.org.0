Return-Path: <bpf+bounces-56589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4731A9AD16
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 14:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E211895FAF
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 12:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5297022DF9F;
	Thu, 24 Apr 2025 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sjii1C9Y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FF71AF0C7;
	Thu, 24 Apr 2025 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497048; cv=none; b=PsrQwZmzTYeCJ60ZppcmO37TLEj1yruRXDBZLDHWlmRJ4wQx2HU/tqKxlcB2S2fEmUZWDfyePgIgqEwdyoO29JPCo2dW4aHzlhT4fXUNNk/IPUbaGXABVvr+EKk0L+35Tk0E1hPmPVOcV+gCwg/oQrRf89KJAJZaZipJfqLna2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497048; c=relaxed/simple;
	bh=Fa0JMJmKW07jw7qoCo4mzqLiB0/HwjaZUJP82v+kjAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fu+wrZSYLuT+q3VjZZjpGkpK6X2DyYfE0j0a9gXSuUdnwMBFDUiKzrdovI8vMK/gnSeQtEz/5/xvqm2bWnn0WuhzbQtzlNXroaMUC+A6lMjUAONKybRu8verzDcWsXGYRYfhLNAIz8am5f1C+rRsMVYiCPPXToKcJJqM3+Ks6ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sjii1C9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E330AC4CEE3;
	Thu, 24 Apr 2025 12:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745497048;
	bh=Fa0JMJmKW07jw7qoCo4mzqLiB0/HwjaZUJP82v+kjAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sjii1C9YSuUdt8xaFxLkC9UA/BiBmfYthu1hg340GoNrnIBIyilWZYrgmN4uYkjSD
	 R5DImLgX4b0nhROVBdLpK/T+AU1fijmW/phyzmqkq9VskN7jHVkFLGwbZHiMTj8jnk
	 UXtFuZz9UlnRzCGuRBVk1YMPQTCMWrpr/1OvvqxiFiNRb6aczVLAzTFY4zZ/jhD2vG
	 ntPPuctiWswMRDm10D8v5tFfM6OuD+mUQpIaRMCFfmxcMtyG+qClKm51w6hqngPTKd
	 54IJ6YVrG7tMCyt6bQu0q/o9xZiSC0gjINFn9AVM0Idr1Tjna99tAB8s7trQWQsC/3
	 XTVvWZfl9+uxA==
Date: Thu, 24 Apr 2025 13:17:21 +0100
From: Simon Horman <horms@kernel.org>
To: Boon Khai Ng <boon.khai.ng@altera.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Tien Sung Ang <tien.sung.ang@altera.com>,
	Mun Yew Tham <mun.yew.tham@altera.com>,
	G Thomas Rohan <rohan.g.thomas@altera.com>
Subject: Re: [PATCH net-next v4 2/2] net: stmmac: dwxgmac2: Add support for
 HW-accelerated VLAN stripping
Message-ID: <20250424121721.GF3042781@horms.kernel.org>
References: <20250421162930.10237-1-boon.khai.ng@altera.com>
 <20250421162930.10237-3-boon.khai.ng@altera.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421162930.10237-3-boon.khai.ng@altera.com>

On Tue, Apr 22, 2025 at 12:29:30AM +0800, Boon Khai Ng wrote:
> This patch adds support for MAC level VLAN tag stripping for the
> dwxgmac2 IP. This feature can be configured through ethtool.
> If the rx-vlan-offload is off, then the VLAN tag will be stripped
> by the driver. If the rx-vlan-offload is on then the VLAN tag
> will be stripped by the MAC.
> 
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>

...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c

...

> @@ -69,6 +70,21 @@ static int dwxgmac2_get_tx_ls(struct dma_desc *p)
>  	return (le32_to_cpu(p->des3) & XGMAC_RDES3_LD) > 0;
>  }
>  
> +static u16 dwxgmac2_wrback_get_rx_vlan_tci(struct dma_desc *p)
> +{
> +	return (le32_to_cpu(p->des0) & XGMAC_RDES0_VLAN_TAG_MASK);

nit: The outer parentheses are not needed on the line above.

	return le32_to_cpu(p->des0) & XGMAC_RDES0_VLAN_TAG_MASK;


> +}

...

