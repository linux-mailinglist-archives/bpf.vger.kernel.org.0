Return-Path: <bpf+bounces-6493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BC276A591
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 02:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0221F1C20D9E
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 00:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674CD641;
	Tue,  1 Aug 2023 00:31:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BB17E;
	Tue,  1 Aug 2023 00:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFA5C433C7;
	Tue,  1 Aug 2023 00:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690849881;
	bh=edKPUxJSfxSwSgMp4ELrc17mhd6XvhBB05dcUDTu8PM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o52owDH10zGOWCtUIT8xi646am/uSlnvhQg5alGDBcj6z+WgLHgQr14m1GIENgyko
	 YCmsi6UwSKPXC7H5UCme6ceAfT6mg2qCZwNrxhfhvPhV5FhEMAtNa0LMrkOigaeRNi
	 XTR6LkX+85ifqjNVdK3q2b4/wE0EPneTiOmHgfqx/R9wt+n1Y+4Apn9dxBkwnhDDv+
	 qedsv/MKItKNBFjYfsI/41KDd7LuNjZNg2g+8G3Rq5DEsWapBovfCf1dr33K9NKSmd
	 vIYfqGXElKeaxFaZo2wKq4pgFgsue0aFEu1FydnI+z4eYoBGQv+g71nN+3Qv2BVXHE
	 0ju5++uayZdLg==
Date: Mon, 31 Jul 2023 17:31:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 decui@microsoft.com, kys@microsoft.com, paulros@microsoft.com,
 olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
 wei.liu@kernel.org, edumazet@google.com, pabeni@redhat.com,
 leon@kernel.org, longli@microsoft.com, ssengar@linux.microsoft.com,
 linux-rdma@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 bpf@vger.kernel.org, ast@kernel.org, sharmaajay@microsoft.com,
 hawk@kernel.org, tglx@linutronix.de, shradhagupta@linux.microsoft.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4,net-next] net: mana: Add page pool for RX buffers
Message-ID: <20230731173119.3ca14894@kernel.org>
In-Reply-To: <1690580767-18937-1-git-send-email-haiyangz@microsoft.com>
References: <1690580767-18937-1-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jul 2023 14:46:07 -0700 Haiyang Zhang wrote:
>  static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
> -			     dma_addr_t *da, bool is_napi)
> +			     dma_addr_t *da, bool *from_pool, bool is_napi)
>  {
>  	struct page *page;
>  	void *va;
>  
> +	*from_pool = false;
> +
>  	/* Reuse XDP dropped page if available */
>  	if (rxq->xdp_save_va) {
>  		va = rxq->xdp_save_va;
> @@ -1533,17 +1543,22 @@ static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
>  			return NULL;
>  		}
>  	} else {
> -		page = dev_alloc_page();
> +		page = page_pool_dev_alloc_pages(rxq->page_pool);
>  		if (!page)
>  			return NULL;
>  
> +		*from_pool = true;
>  		va = page_to_virt(page);
>  	}
>  
>  	*da = dma_map_single(dev, va + rxq->headroom, rxq->datasize,
>  			     DMA_FROM_DEVICE);
>  	if (dma_mapping_error(dev, *da)) {
> -		put_page(virt_to_head_page(va));
> +		if (*from_pool)
> +			page_pool_put_full_page(rxq->page_pool, page, is_napi);

AFAICT you only pass the is_napi to recycle in case of error?
It's fine to always pass in false, passing true enables some
optimizations but it's not worth trying to optimize error paths.

Otherwise you may be passing in true, even tho budget was 0,
see the recently added warnings in this doc:

https://www.kernel.org/doc/html/next/networking/napi.html

In general the driver seems to be processing Rx regardless
of budget? This looks like a bug which should be fixed with
a separate patch for the net tree..
-- 
pw-bot: cr

