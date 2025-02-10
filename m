Return-Path: <bpf+bounces-50999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E2DA2F364
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B70D33A2A2D
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 16:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D4C2580FB;
	Mon, 10 Feb 2025 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3XnPEH5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9364A2580D6;
	Mon, 10 Feb 2025 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204750; cv=none; b=CfIf53/MgNRjogw7ZzB/X9TCmrzY/FGkxu36a4IT48/UPYtnReQiseJ9bQ8sYuHoAy1H/zS0jzQqkMyY62pwZKB6mckvBWUrn4UxglmUoAdxdWym0VpRoa6/4+nSHAxjN9pKFR9fOOij98MGJsAWYPGEKP+2wsxpCFJ15GGEwxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204750; c=relaxed/simple;
	bh=48RpgmHD1hoBrZcm4gSDbROrUBR/h5yG6mfOKRTppm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeQbs8VT3o0nnIXcTs74zHe+qn+NsJRdp88YzIivxEyqbaATJtdljPmd/DnkErX2RorqYx7Gw+gk+MXA0GiM0u26sebHb0Y3WE2ulb7Mjv+rJtEngMOpc0BfTNN3UHT3e/4TOdH0VKQNmceS1bvwsd9O7sXgmELbdTEGgaJy1ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3XnPEH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26691C4CED1;
	Mon, 10 Feb 2025 16:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739204750;
	bh=48RpgmHD1hoBrZcm4gSDbROrUBR/h5yG6mfOKRTppm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A3XnPEH5cn1vz9o7echKUcZ/LbuRSpi8TJAzRBzzQPtQdVwnGQnvCOEF+r2h9wEI4
	 2aIBf5nEz7ibAQBTAlI31MlOQddU+VsUVRQN14RaHmnSJhBQZ2OtUxK8BTTs83BO0g
	 gLbl+ThDA2Re7Sf+lx2ajw8Qy5ZI2s6x6gEt66E1wDBv4tfh3rAYliL3dfNUaRUGT2
	 1daiqLv2OeOApjTYk86uTSmtGzNqAAhVu7PVLiuYh51SECmFo7QvrEOsugpnwpuRF9
	 PVa0Xbd7S0zZ42KBDotfTEu3woITZq/NIAl6ZxgOpDqd95SjZ3P2yToMCYOfm7TS8R
	 WvdZbMPUPiIOg==
Date: Mon, 10 Feb 2025 16:25:43 +0000
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
Message-ID: <20250210162543.GF554665@kernel.org>
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

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index 224cef938927..d46f05993d3f 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -96,20 +96,22 @@ static unsigned int frag_num(unsigned int i)
>  
>  static void otx2_xdp_snd_pkt_handler(struct otx2_nic *pfvf,
>  				     struct otx2_snd_queue *sq,
> -				 struct nix_cqe_tx_s *cqe)
> +				     struct nix_cqe_tx_s *cqe)
>  {
>  	struct nix_send_comp_s *snd_comp = &cqe->comp;
>  	struct sg_list *sg;
>  	struct page *page;
> -	u64 pa;
> +	u64 pa, iova;
>  
>  	sg = &sq->sg[snd_comp->sqe_id];
>  
> -	pa = otx2_iova_to_phys(pfvf->iommu_domain, sg->dma_addr[0]);
> -	otx2_dma_unmap_page(pfvf, sg->dma_addr[0],
> -			    sg->size[0], DMA_TO_DEVICE);
> +	iova = sg->dma_addr[0];
> +	pa = otx2_iova_to_phys(pfvf->iommu_domain, iova);
>  	page = virt_to_page(phys_to_virt(pa));
> -	put_page(page);

Hi Suman,

With this patch applied page is assigned but otherwise unused in this
function. So unless there are some side effects of the above, I think
page and in turn pa and iova can be removed.

> +	if (sg->flags & XDP_REDIRECT)
> +		otx2_dma_unmap_page(pfvf, sg->dma_addr[0], sg->size[0], DMA_TO_DEVICE);
> +	xdp_return_frame((struct xdp_frame *)sg->skb);
> +	sg->skb = (u64)NULL;
>  }
>  
>  static void otx2_snd_pkt_handler(struct otx2_nic *pfvf,

...

