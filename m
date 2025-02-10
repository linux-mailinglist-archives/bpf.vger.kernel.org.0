Return-Path: <bpf+bounces-51028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83E0A2F5EA
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4D61887AB2
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4E124BD0F;
	Mon, 10 Feb 2025 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGJJz1Qq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF31125B684;
	Mon, 10 Feb 2025 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209986; cv=none; b=kMu2ptuv1NDP8WxbACylnQTBUImVKpknc5Qfyz+j7j/qbnzGZvPpaZfwS0Jxt1/FanMeDNYk2oo65RZ0k02SnIE/cb4mzZI16MASCmC/vuLTjeHL6W78nPp62lQRxDjqyEOqoPsGJBejYrRWRTqYuH22goSzU6jG5COzwgOBbAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209986; c=relaxed/simple;
	bh=MxpIb7Xvc+Xm5PFD4RcTOaX0hsMngpYuRuaEGl6Oywk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIbhzfbuTxFp5mc+Sdv2SfhjTR2E/h+AjCFqO/rDvEHZ/GgQ+2cgR8VeWRvyNTOaZ2qINCeYHswg03WOFMO7F93KKWhVnwXKhGZ4QAKXE47m7wOGbOjCyKnb4iRTxvHEOB1IQoBRnnjIzJ5hapbDzsL3iUb4bWdWjRP2wtlF3HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGJJz1Qq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8B4C4CED1;
	Mon, 10 Feb 2025 17:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739209986;
	bh=MxpIb7Xvc+Xm5PFD4RcTOaX0hsMngpYuRuaEGl6Oywk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WGJJz1QqLvA64bKGkDJHwmWP8QH9Sp9Qvg5O7s8pk2kcHEFAWJqJjkcf7c1WnU1CD
	 QtCQB20Ol3ZpzMNzVqLDFV6xsJTg06E3518lKF5ANtpvjWam5zScsh7Tkstoxewgol
	 7Vn6GBBNt7CrLURGHc/DsapZrXAcnb2pQaXW3hoRG5NBhJnJaPJDvqJ79mN9Js5ZQ4
	 HVufNQUsozNzKJV1dhPZvZqkmhQ4A/1Mu3VhpmiYZ7L/76osLZ5BJctIxbxkIXNfAV
	 KcpZKGOkKstwW5Q/d0NtN00Q12Ho2Ik7v5xwVgusRl3HuQJ6NXnrzzb9DnHUQHgwVh
	 UqhkYDqO3pa/g==
Date: Mon, 10 Feb 2025 17:53:00 +0000
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
Message-ID: <20250210175300.GH554665@kernel.org>
References: <20250206085034.1978172-1-sumang@marvell.com>
 <20250206085034.1978172-2-sumang@marvell.com>
 <20250210162543.GF554665@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210162543.GF554665@kernel.org>

On Mon, Feb 10, 2025 at 04:25:43PM +0000, Simon Horman wrote:
> On Thu, Feb 06, 2025 at 02:20:29PM +0530, Suman Ghosh wrote:
> > xdp_return_frames() will help to free the xdp frames and their
> > associated pages back to page pool.
> > 
> > Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> > Signed-off-by: Suman Ghosh <sumang@marvell.com>
> 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > index 224cef938927..d46f05993d3f 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > @@ -96,20 +96,22 @@ static unsigned int frag_num(unsigned int i)
> >  
> >  static void otx2_xdp_snd_pkt_handler(struct otx2_nic *pfvf,
> >  				     struct otx2_snd_queue *sq,
> > -				 struct nix_cqe_tx_s *cqe)
> > +				     struct nix_cqe_tx_s *cqe)
> >  {
> >  	struct nix_send_comp_s *snd_comp = &cqe->comp;
> >  	struct sg_list *sg;
> >  	struct page *page;
> > -	u64 pa;
> > +	u64 pa, iova;
> >  
> >  	sg = &sq->sg[snd_comp->sqe_id];
> >  
> > -	pa = otx2_iova_to_phys(pfvf->iommu_domain, sg->dma_addr[0]);
> > -	otx2_dma_unmap_page(pfvf, sg->dma_addr[0],
> > -			    sg->size[0], DMA_TO_DEVICE);
> > +	iova = sg->dma_addr[0];
> > +	pa = otx2_iova_to_phys(pfvf->iommu_domain, iova);
> >  	page = virt_to_page(phys_to_virt(pa));
> > -	put_page(page);
> 
> Hi Suman,
> 
> With this patch applied page is assigned but otherwise unused in this
> function. So unless there are some side effects of the above, I think
> page and in turn pa and iova can be removed.

I now see that page and pa are removed in patch 6/6, although iova
is left behind. I think it would be best to move the cleanup forward
to this patch.

> 
> > +	if (sg->flags & XDP_REDIRECT)
> > +		otx2_dma_unmap_page(pfvf, sg->dma_addr[0], sg->size[0], DMA_TO_DEVICE);
> > +	xdp_return_frame((struct xdp_frame *)sg->skb);
> > +	sg->skb = (u64)NULL;
> >  }
> >  
> >  static void otx2_snd_pkt_handler(struct otx2_nic *pfvf,
> 
> ...
> 

