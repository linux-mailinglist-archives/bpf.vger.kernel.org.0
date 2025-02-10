Return-Path: <bpf+bounces-51029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F4DA2F5F9
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF45162AF2
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B15A25B66B;
	Mon, 10 Feb 2025 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NS/GqyIc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB73C25B66E;
	Mon, 10 Feb 2025 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739210062; cv=none; b=aWZlFqVYXinm3UhfTJqQmemmpj03ZzrfIvfF11XxCo+sezIPPXYfZkwAstjjtDiiVfzFz9IeK1Uc8wOmDLWbHmruku0RosuYlRSDJ/cBwvCoB4hBs1dL2n2kfV9cUl3PMCKR0Mqklog8a9h0v3WdI0T3p3qcrttVm8YQUYUN/Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739210062; c=relaxed/simple;
	bh=6ZRr2MjnfSqMr4uiBxnh7NlNHUxN69N+x0PHOj6xK/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M901oi0Wuj/Iq0LjP7CpYo5j+Y/Yl1DR7XX8kYHe4xK9lP43pQgQt4uCPSIS6uOjLouF22S6NXwxWIcqrif73C3akyZG7x8Ndi0tJlbK6ntnQWj4+qlLKf+YYMq2jOI5lwQs+edVVCHoVCFiSqs2G0qECYvAyLqXfbp1LXLn/Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NS/GqyIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA88C4CED1;
	Mon, 10 Feb 2025 17:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739210061;
	bh=6ZRr2MjnfSqMr4uiBxnh7NlNHUxN69N+x0PHOj6xK/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NS/GqyIc5ImpcezegSX6vO6BjnL5FAgiqKX/FXkmjMga/liwNZ0Is+PbJ4hKbi10r
	 w/RqE5VrDelIQawOOO7J9moHLVKPCylB98DgTIPGEnHQxfkVVCC5braZq8XJkol0ih
	 f57DYV0rjyvbCxfd3Ke2pfRMy9zxKtIlGrQcW0f9W5aflQW+qv3OnD0ZYWEnVMEzKn
	 XcsQGuKqV+6bd0ybT3iYn9u1jmaFb02s/7MG/7aDhUNhDusJis7SKwamceTLOQ/fSn
	 hajRpcVsncofqaHdysEyET9qmsu9epr7AAdwx9+xVNZgqKgznfXbZTJZqYhgcf2+me
	 rUi9k2Q3a3P5Q==
Date: Mon, 10 Feb 2025 17:54:15 +0000
From: Simon Horman <horms@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lcherian@marvell.com,
	jerinj@marvell.com, john.fastabend@gmail.com, bbhushan2@marvell.com,
	hawk@kernel.org, andrew+netdev@lunn.ch, ast@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org, larysa.zaremba@intel.com
Subject: Re: [net-next PATCH v5 1/6] octeontx2-pf: use xdp_return_frame() to
 free xdp buffers
Message-ID: <20250210175415.GI554665@kernel.org>
References: <20250206085034.1978172-1-sumang@marvell.com>
 <20250206085034.1978172-2-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206085034.1978172-2-sumang@marvell.com>

On Thu, Feb 06, 2025 at 02:20:29PM +0530, Suman Ghosh wrote:
> xdp_return_frames() will help to free the xdp frames and their
> associated pages back to page pool.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c

...

> @@ -1465,10 +1476,14 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
>  		trace_xdp_exception(pfvf->netdev, prog, act);
>  		break;
>  	case XDP_DROP:
> +		cq->pool_ptrs++;
> +		if (page->pp) {
> +			page_pool_recycle_direct(pool->page_pool, page);
> +			return true;
> +		}
>  		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
>  				    DMA_FROM_DEVICE);
>  		put_page(page);
> -		cq->pool_ptrs++;
>  		return true;

The above seems to get shuffled around in the next patch anyway, so
maybe it's best to do this here (completely untested):

	case XDP_DROP:
		cq->pool_ptrs++;
		if (page->pp) {
			page_pool_recycle_direct(pool->page_pool, page);
		} else {
			otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
					    DMA_FROM_DEVICE);
			put_page(page);
		}
		return true;

>  	}
>  	return false;

...

