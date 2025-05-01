Return-Path: <bpf+bounces-57132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAA3AA6046
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 16:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3106A3B1675
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 14:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869BE1FBC8C;
	Thu,  1 May 2025 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kF2iDmMJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C7629CE6;
	Thu,  1 May 2025 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746111378; cv=none; b=HKlVwo1DcD3cMAldI1o5QTS0f4KHjlf+u6E1YCswhJwtoNVSqzAMwJPTW4Ghe25Mjyvin4ZFLVnS02dVlxLS7DIV/se9Rk3Hsi7NovgUh0bVkP7Wv3LpWEUcISj+BuZ2zCJip7j5B9HYEFLcODdfWelrVZhj2v8Lcz6ldCgSwgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746111378; c=relaxed/simple;
	bh=MX3wK1gITwvKn9W4CUlzrPrwvL5OfB/8if8y5oLIEGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QbEleU4s+7aXoMVEhSkbB5UlU9CiuvZyV7bD1+vbdQV9XzzEH0sZO7CqG0pm4mO59MrVdHMHHcZZ/YAkVaiClyt2tU95xWEiSOka7JAxry1C6Xf/ImGFloQ/+mCOYQpHDyBOFg52dh/rCKQWwGgqjqOXtAx1DV4gII1x39s0eZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kF2iDmMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96135C4CEE3;
	Thu,  1 May 2025 14:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746111377;
	bh=MX3wK1gITwvKn9W4CUlzrPrwvL5OfB/8if8y5oLIEGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kF2iDmMJQ4GyE2K52WiyrmCkHHd6xa5zZjEUJqhGzNvQShuuA0CHAZuw+agLE1DEL
	 4jPAW3h5o9WVFrbfmg1NtcEZLwwruNf1At+Xni4BNtLoWS8JO49bMUeiGGq2gizlPa
	 DcktDOrm0lIgJM762Kz9ZusWCFFTXU7oD6vA4LkoLp6hGagOzKQnPg5KRthO2YAuiw
	 KjjGr8Qvr/b5AXPqgzG+47gpQQIGfXHQ+bSdhPafLs19l122+9PYaTTzY8Ze+Q+UGp
	 UAvQRG2uF2FYi92CLTjAsr8/10+tW1ivUWWNyJHu/UKUUaaaF/dtyO5wbfdJFe/VO8
	 PIuCSvRaK6k3g==
Date: Thu, 1 May 2025 07:56:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: <dan.carpenter@linaro.org>, <john.fastabend@gmail.com>,
 <hawk@kernel.org>, <daniel@iogearbox.net>, <ast@kernel.org>,
 <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
 <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: Re: [PATCH net 3/4] net: ti: icssg-prueth: Fix race condition for
 traffic from different network sockets
Message-ID: <20250501075615.34573158@kernel.org>
In-Reply-To: <20250428120459.244525-4-m-malladi@ti.com>
References: <20250428120459.244525-1-m-malladi@ti.com>
	<20250428120459.244525-4-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 17:34:58 +0530 Meghana Malladi wrote:
> When dealing with transmitting traffic from different network
> sockets to a single Tx channel, freeing the DMA descriptors can lead
> to kernel panic with the following error:
> 
> [  394.602494] ------------[ cut here ]------------
> [  394.607134] kernel BUG at lib/genalloc.c:508!
> [  394.611485] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> 
> logs: https://gist.github.com/MeghanaMalladiTI/ad1d1da3b6e966bc6962c105c0b1d0b6
> 
> The above error was reproduced when sending XDP traffic from XSK
> socket along with network traffic from BSD socket. This causes
> a race condition leading to corrupted DMA descriptors. Fix this
> by adding spinlock protection while accessing the DMA descriptors
> of a Tx ring.

IDK how XSK vs normal sockets matters after what is now patch 4.
The only possible race you may be protecting against is pushing 
work vs completion. Please double check this is even needed, 
and if so fix the commit msg.

> Fixes: 62aa3246f462 ("net: ti: icssg-prueth: Add XDP support")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_common.c | 7 +++++++
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
> index 4f45f2b6b67f..a120ff6fec8f 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -157,7 +157,9 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>  	tx_chn = &emac->tx_chns[chn];
>  
>  	while (true) {
> +		spin_lock(&tx_chn->lock);
>  		res = k3_udma_glue_pop_tx_chn(tx_chn->tx_chn, &desc_dma);
> +		spin_unlock(&tx_chn->lock);
>  		if (res == -ENODATA)
>  			break;
>  
> @@ -325,6 +327,7 @@ int prueth_init_tx_chns(struct prueth_emac *emac)
>  		snprintf(tx_chn->name, sizeof(tx_chn->name),
>  			 "tx%d-%d", slice, i);
>  
> +		spin_lock_init(&tx_chn->lock);
>  		tx_chn->emac = emac;
>  		tx_chn->id = i;
>  		tx_chn->descs_num = PRUETH_MAX_TX_DESC;
> @@ -627,7 +630,9 @@ u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
>  	cppi5_hdesc_set_pktlen(first_desc, xdpf->len);
>  	desc_dma = k3_cppi_desc_pool_virt2dma(tx_chn->desc_pool, first_desc);
>  
> +	spin_lock_bh(&tx_chn->lock);
>  	ret = k3_udma_glue_push_tx_chn(tx_chn->tx_chn, first_desc, desc_dma);
> +	spin_unlock_bh(&tx_chn->lock);

I'm afraid this needs to be some form of spin_lock_irq
The completions may run from hard irq context when netpoll/netconsole
is used.
-- 
pw-bot: cr

