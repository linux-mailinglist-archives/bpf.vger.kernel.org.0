Return-Path: <bpf+bounces-48413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AD0A07CF8
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 17:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB99162B6B
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 16:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B832206BA;
	Thu,  9 Jan 2025 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGH/nKDl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C9121C193;
	Thu,  9 Jan 2025 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438938; cv=none; b=e10/6zg17fRs7enjIgvpddr3zmFuhyq12mId/ewDS8M7e2HaZ9R+lQ4C0Y6DwYTwnD1VWAhGTvNXARgsv3XWYZ1e1FGx39pTbgxJacaihWu3kByB5/bJF9D+vlYFeVSV8N7KxAtp0jbFgI+azanDEFxSnawxbE3Qp7ZEUHAmN8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438938; c=relaxed/simple;
	bh=wBOmjGj7U7kIguqoGCDjLxj7vqsOb8WjHOdQiprEyf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtC2DY7If+Cla4s7R+u6noPuNwANYriFnjiOeu7urpaC2UTlqCCd/Xgq+QO05MgMM3sStM5gbOwPGrv11v0D4QAPEqn0jAcoK0SkPYhkVFkd3FL8yrriUY/mRlMmkttmJkXklabmQBxLDot7328MEbTrHB033aQUO/btV8QTQ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGH/nKDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF14C4CED2;
	Thu,  9 Jan 2025 16:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736438937;
	bh=wBOmjGj7U7kIguqoGCDjLxj7vqsOb8WjHOdQiprEyf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EGH/nKDl+1XVs8xgVYoo3J60Or33gStMSf1J9vuXfqZ0qYpfJ10lmaFWH6Q6uJbCw
	 WpneShLUIo+ZX2LXYFbzt+InaDfmUd1CR3p75NrDpa0Nr+sTBaS5ENKsg4kGgpxPYC
	 nS+VVyXpCqg9egefdSlKSI7Lts79im7/ym9ODSosAjh9OQqwatYJhj8N8s5kyjeoMN
	 D6ZcMCdKTNESWq+mb3tzunGm9qry8hkwW/XLRtyZ5OoS88QRepyZb/3umd/z+klGnJ
	 uRZO5P9JsnKyz0UhtpFjLTSR+zTCIvNao6ZxxYUaIB/PHum4KDE2qA6Rykr67Hy8xb
	 YU/bUqq+zUg+Q==
Date: Thu, 9 Jan 2025 16:08:51 +0000
From: Simon Horman <horms@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lcherian@marvell.com,
	jerinj@marvell.com, john.fastabend@gmail.com, bbhushan2@marvell.com,
	hawk@kernel.org, andrew+netdev@lunn.ch, ast@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [net-next PATCH v2 1/6] octeontx2-pf: Add AF_XDP non-zero copy
 support
Message-ID: <20250109160851.GJ7706@kernel.org>
References: <20250108183329.2207738-1-sumang@marvell.com>
 <20250108183329.2207738-2-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108183329.2207738-2-sumang@marvell.com>

On Thu, Jan 09, 2025 at 12:03:24AM +0530, Suman Ghosh wrote:
> For XDP, page_pool APIs are getting used now. But the memory type was
> not getting set due to which XDP_REDIRECT and hence AF_XDP was not
> working. This patch ads the memory type MEM_TYPE_PAGE_POOL as the memory
> model of the XDP program.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c

...

> @@ -109,6 +109,11 @@ static void otx2_xdp_snd_pkt_handler(struct otx2_nic *pfvf,
>  	otx2_dma_unmap_page(pfvf, sg->dma_addr[0],
>  			    sg->size[0], DMA_TO_DEVICE);
>  	page = virt_to_page(phys_to_virt(pa));
> +	if (page->pp) {
> +		page_pool_recycle_direct(page->pp, page);
> +		return;
> +	}
> +
>  	put_page(page);
>  }
>  

Hi Suman,

It is included indirectly in the following patch,
[v2 2/6] octeontx2-pf: Don't unmap page pool buffer used by XDP,
but I believe you need the following in order for this to compile:

#include <net/page_pool/helpers.h>

...

pw-bot: changes-requested

