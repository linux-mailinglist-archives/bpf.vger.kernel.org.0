Return-Path: <bpf+bounces-60817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710C1ADD029
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 16:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4FE3AD7A6
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 14:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8FA201006;
	Tue, 17 Jun 2025 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E7gHG8O5"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252331CDA2E;
	Tue, 17 Jun 2025 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171014; cv=none; b=S+DyROj2g3D5KAIMUCATckEECrLsv2oS8RGbP5D7BobpESW8Q9FiTb9/bazbBfYi06G5SGcBdBMHbxGWM4SIpbBgryoxRA3XwlVJjtfURkdww73nsCgC3jNX/1a+V+SetonFx5rULiYItBJB90Pu9RtjjXMthrajWOhKbPcKSIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171014; c=relaxed/simple;
	bh=bH5eztucliOZhea2XXdkOphR9rOQDw32gpLCRrbUAIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/2pXYb2TF46BT7LPc0em6Pkf+X/Kqo2QYnnP/jY7nj3b+Up+uNfG7oszVtHNinq+WFWkV3a7CGBqLjsWJTQSpDfmXsytrhNigA+9ojwmVT+tSzwh5COFsB2G/8a44Jt0rlN4A8Z8Y+N8EjrM5xAxyXu6RABUeAWBMZhsnGvH+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E7gHG8O5; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750171013; x=1781707013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bH5eztucliOZhea2XXdkOphR9rOQDw32gpLCRrbUAIg=;
  b=E7gHG8O51WRdcERJpUKCG8Zr60PALSQP0ExCsasg/dThaHXlyNW6tIsa
   xP8r1pHBnz31uuRa8Vb1+UQ8LMUC5jsNJgWATXIRzMMYpWcHxnwmfwzHU
   +F1e0AjIw3hObntE96iO0v32z59T8ZVRRuRrakc2IzonTKCgQVOgOKY7Q
   2K7h2r8wGEbQA1mVUIWAGQkQ+/iR/GMp8MKI2v3VSpNbgDBRZRb37nB2f
   g8uZKe3/Vpemljzf5EKpsXkgmaD59gSmmavbFwEgQGoP0viznKtPu/Nqv
   2wwkq1fJ58PX+r+FnDguXCRhTjbjAIiS0K862dYL2HDI+3JliWDHpk7Bj
   g==;
X-CSE-ConnectionGUID: Jq4ONtGzQQ+phiOjvS6J3g==
X-CSE-MsgGUID: hA+5qZc9TrSt4wQtKCnPBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52490070"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="52490070"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 07:36:52 -0700
X-CSE-ConnectionGUID: sNFJbrCnRfCBKO/VS9iFeQ==
X-CSE-MsgGUID: D8nGVFcKRJWzKZ22rsQFrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="149690666"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 07:36:47 -0700
Date: Tue, 17 Jun 2025 16:35:55 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Taehee Yoo <ap420073@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] ethernet: ionic: Fix DMA mapping test in
 `ionic_xdp_post_frame()`
Message-ID: <aFF9S1BX8HgY+ihO@mev-dev.igk.intel.com>
References: <20250617091842.29732-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617091842.29732-2-fourier.thomas@gmail.com>

On Tue, Jun 17, 2025 at 11:18:36AM +0200, Thomas Fourier wrote:
> The `ionic_tx_map_frag()` wrapper function is used which returns 0 or a
> valid DMA address.  Testing that pointer with `dma_mapping_error()`could
> be eroneous since the error value exptected by `dma_mapping_error()` is
> not 0 but `DMA_MAPPING_ERROR` which is often ~0.
> 
> Fixes: ac8813c0ab7d ("ionic: convert Rx queue buffers to use page_pool")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>  drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> index 2ac59564ded1..beefdc43013e 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> @@ -357,7 +357,7 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
>  			} else {
>  				dma_addr = ionic_tx_map_frag(q, frag, 0,
>  							     skb_frag_size(frag));
> -				if (dma_mapping_error(q->dev, dma_addr)) {
> +				if (!dma_addr) {
>  					ionic_tx_desc_unmap_bufs(q, desc_info);
>  					return -EIO;

Right, in ionic_tx_map_skb() it is used correctly (like here now).
Thanks for fixing.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

>  				}
> -- 
> 2.43.0

