Return-Path: <bpf+bounces-72502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86602C13729
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 09:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42AA71893733
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 08:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CFB2D3EE5;
	Tue, 28 Oct 2025 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBUWJTiC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A082AE8E;
	Tue, 28 Oct 2025 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761638938; cv=none; b=CuVpDP3dqAcuW4sQbszLCHmndFaD6vI8Zhzz/mLZyAD7QtMrlh3Hbrauq5XBKlwfAp+G5T8Vl59H2SAZwUysXbIyPRxKXmHm5y4O5PXJ9wfnJvl3Nj7YD1xpCyicjAbcfbqQlftkP3hMntwUquayocyvczePcfO9s+EJZwuE5IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761638938; c=relaxed/simple;
	bh=4sTJoE3Tj68a0XVvk4bdhjMbSBfYSqrGGw2z4DoVkBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQnWA49hcuGO1UzmW4tEONLcFLZbp+Eh5yvcHwITVWhx9V/mo6DLKXLafqoA1kYarEbqZm/0fCTLyMy58VWeePAEtTW4RHhWnnLdWmP0QuF8lFhGu2WcUhZUVjyZZ9VGBesoSQoFpUVpqArlbOTx/P/mscHzMDkRN1PQ4EYLX6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBUWJTiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A866C4CEE7;
	Tue, 28 Oct 2025 08:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761638937;
	bh=4sTJoE3Tj68a0XVvk4bdhjMbSBfYSqrGGw2z4DoVkBg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eBUWJTiCpui8Y8h+rvZhpFQCXrOkAqagYnefylVdojremZPo7WYSML7ZocFScXett
	 y67QVMobugvi0pXljU3f4XCwl+cah7D9PGCN0ATzbKvwz5zo3uGIF4y0knvVoskCgp
	 2KBRN4H5Mot8OHVZzC5kYcVcLjuh0bhaJRB3uGmwC+oBAXGcxDGS/b3nlS4HN5ppQq
	 EhsJ29jp31kjJQVnpGEaClfk80RQfqPIZ9Hgjj85w33y9h84gaxHQCHXyHn5CgdGiZ
	 HsLJ5S5gGc1FpLD5WmL2ixlZSHdS+vZzrOHuFyeJASNexKja3mlqXlPMbf29mOoptY
	 UqryBxuo5eAOg==
Message-ID: <11142984-9bbe-4611-bbe7-fa5494036b8f@kernel.org>
Date: Tue, 28 Oct 2025 09:08:52 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 bpf 1/2] xdp: introduce xdp_convert_skb_to_buff()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com,
 aleksander.lobakin@intel.com, ilias.apalodimas@linaro.org, toke@redhat.com,
 lorenzo@kernel.org, kuba@kernel.org,
 syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
References: <20251027121318.2679226-1-maciej.fijalkowski@intel.com>
 <20251027121318.2679226-2-maciej.fijalkowski@intel.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20251027121318.2679226-2-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/10/2025 13.13, Maciej Fijalkowski wrote:
> Currently, generic XDP hook uses xdp_rxq_info from netstack Rx queues
> which do not have its XDP memory model registered. There is a case when
> XDP program calls bpf_xdp_adjust_tail() BPF helper, which in turn
> releases underlying memory. This happens when it consumes enough amount
> of bytes and when XDP buffer has fragments. For this action the memory
> model knowledge passed to XDP program is crucial so that core can call
> suitable function for freeing/recycling the page.
> 
> For netstack queues it defaults to MEM_TYPE_PAGE_SHARED (0) due to lack
> of mem model registration. The problem we're fixing here is when kernel
> copied the skb to new buffer backed by system's page_pool and XDP buffer
> is built around it. Then when bpf_xdp_adjust_tail() calls
> __xdp_return(), it acts incorrectly due to mem type not being set to
> MEM_TYPE_PAGE_POOL and causes a page leak.
> 
> Pull out the existing code from bpf_prog_run_generic_xdp() that
> init/prepares xdp_buff onto new helper xdp_convert_skb_to_buff() and
> embed there rxq's mem_type initialization that is assigned to xdp_buff.
> Make it agnostic to current skb->data position.
> 
> This problem was triggered by syzbot as well as AF_XDP test suite which
> is about to be integrated to BPF CI.
> 
> Reported-by: syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6756c37b.050a0220.a30f1.019a.GAE@google.com/
> Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
> Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Co-developed-by: Octavian Purdila <tavip@google.com>
> Signed-off-by: Octavian Purdila <tavip@google.com> # whole analysis, testing, initiating a fix
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # commit msg and proposed more robust fix
> ---
>   include/net/xdp.h | 25 +++++++++++++++++++++++++
>   net/core/dev.c    | 25 ++++---------------------
>   2 files changed, 29 insertions(+), 21 deletions(-)
> 
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index aa742f413c35..eba1c0cd5800 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -384,6 +384,31 @@ struct sk_buff *xdp_build_skb_from_frame(struct xdp_frame *xdpf,
>   					 struct net_device *dev);
>   struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf);
>   
> +static inline
> +void xdp_convert_skb_to_buff(struct sk_buff *skb, struct xdp_buff *xdp,
> +			     struct xdp_rxq_info *xdp_rxq)
> +{
> +	u32 frame_sz, pkt_len;
> +
> +	/* SKB "head" area always have tailroom for skb_shared_info */
> +	frame_sz = skb_end_pointer(skb) - skb->head;
> +	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +	pkt_len =  skb_tail_pointer(skb) - skb_mac_header(skb);
> +
> +	xdp_init_buff(xdp, frame_sz, xdp_rxq);
> +	xdp_prepare_buff(xdp, skb->head, skb->mac_header, pkt_len, true);
> +
> +	if (skb_is_nonlinear(skb)) {
> +		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
> +		xdp_buff_set_frags_flag(xdp);
> +	} else {
> +		xdp_buff_clear_frags_flag(xdp);
> +	}
> +
> +	xdp->rxq->mem.type = page_pool_page_is_pp(virt_to_head_page(xdp->data)) ?
> +				MEM_TYPE_PAGE_POOL : MEM_TYPE_PAGE_SHARED;

We are slowly killing performance with these paper cuts.  The
information we are looking for should be available via skb->pp_recycle,
but instead we go lookup the page to deref that memory.  And plus the
virt_to_head_page() is more expensive than virt_to_page().

Why don't we check skb->pp_recycle first, and then fall-back to checking
the page to catch the mentioned problems?

--Jesper

> +}
> +
>   static inline
>   void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
>   			       struct xdp_buff *xdp)
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 2acfa44927da..a71da4edc493 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5320,35 +5320,18 @@ static struct netdev_rx_queue *netif_get_rxqueue(struct sk_buff *skb)
>   u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
>   			     const struct bpf_prog *xdp_prog)
>   {
> -	void *orig_data, *orig_data_end, *hard_start;
> +	void *orig_data, *orig_data_end;
>   	struct netdev_rx_queue *rxqueue;
>   	bool orig_bcast, orig_host;
> -	u32 mac_len, frame_sz;
> +	u32 metalen, act, mac_len;
>   	__be16 orig_eth_type;
>   	struct ethhdr *eth;
> -	u32 metalen, act;
>   	int off;
>   
> -	/* The XDP program wants to see the packet starting at the MAC
> -	 * header.
> -	 */
> +	rxqueue = netif_get_rxqueue(skb);
>   	mac_len = skb->data - skb_mac_header(skb);
> -	hard_start = skb->data - skb_headroom(skb);
> -
> -	/* SKB "head" area always have tailroom for skb_shared_info */
> -	frame_sz = (void *)skb_end_pointer(skb) - hard_start;
> -	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>   
> -	rxqueue = netif_get_rxqueue(skb);
> -	xdp_init_buff(xdp, frame_sz, &rxqueue->xdp_rxq);
> -	xdp_prepare_buff(xdp, hard_start, skb_headroom(skb) - mac_len,
> -			 skb_headlen(skb) + mac_len, true);
> -	if (skb_is_nonlinear(skb)) {
> -		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
> -		xdp_buff_set_frags_flag(xdp);
> -	} else {
> -		xdp_buff_clear_frags_flag(xdp);
> -	}
> +	xdp_convert_skb_to_buff(skb, xdp, &rxqueue->xdp_rxq);
>   
>   	orig_data_end = xdp->data_end;
>   	orig_data = xdp->data;


