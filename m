Return-Path: <bpf+bounces-71388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 729E9BF0CC6
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 13:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A1E3BC429
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 11:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7147258EE0;
	Mon, 20 Oct 2025 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjCUk5Gu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EA7248F66;
	Mon, 20 Oct 2025 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959263; cv=none; b=c7i4QPdKpNsAZL9LXH0rLWCQPg86TK5XmAa/DEGzOPWsHAvykvwpYowZ0DvBILWeMCiObVSFzmarOA5m7qJTP3v9eiYynutZ9K9Co8543A6Ro/fQDuM3h8k4CQbxXMuR2HBp7c8VIeTU1pOkVLXUpR/rfgZuhnpeYtcWIzaN5zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959263; c=relaxed/simple;
	bh=4euNQMf16389IGt0BW8gnG05rO6cM6yVJ13Vd19t33E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVlSmalgMvUfC/TyapCCBl8Y2zs0Z+efn7bkKFHcz2OViZTxCG5LoTFrVNayqAOQAGOr9jitbKJd8icMcbR04SkdgBTMVap+tIrmxr61MKPNDOTWqchw4esKEEBVJfv7S2rOMt52tD36CVkhvAKo57x/t6Td3m5/xM3V5x4wfvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjCUk5Gu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E680C4CEF9;
	Mon, 20 Oct 2025 11:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760959262;
	bh=4euNQMf16389IGt0BW8gnG05rO6cM6yVJ13Vd19t33E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pjCUk5GuEmQSRyQL/TCWa5vqqd6yZw8wb8s8sEuOs82yoc8enfUvn3DZBS5xuOUHX
	 D/u6ncjvYzQs/1DgzZP8pMQTEkOSPBPGy+UfRppfaZZaVaeI3Vb8+QCZat9rOc/9IT
	 9O0P9MCBluTd42qkwHaoZlqBQ7yfaYRyCb7GmiB4tMdITwJzYDJbXsEiQoX2vuwUfr
	 4AVCkFwE1i7gOgWLBzRJrchSiT2oCEoMiQu6XdcoucLYyQM5yAwtiEkVwyF2hWBJhf
	 ov9Q5+ICLUh2qYphrOrpenY8HciPyy6h1JSXHkYspalrzXkmJpbuDNU0iVxjmN6w0n
	 4rvZ0l83rdDRA==
Message-ID: <50cbda75-9e0c-4d04-8d01-75dc533b8bb9@kernel.org>
Date: Mon, 20 Oct 2025 13:20:57 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf 1/2] xdp: update xdp_rxq_info's mem type in XDP
 generic hook
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, ilias.apalodimas@linaro.org,
 toke@redhat.com, lorenzo@kernel.org, kuba@kernel.org
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, andrii@kernel.org,
 stfomichev@gmail.com, aleksander.lobakin@intel.com,
 syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
References: <20251017143103.2620164-1-maciej.fijalkowski@intel.com>
 <20251017143103.2620164-2-maciej.fijalkowski@intel.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20251017143103.2620164-2-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/10/2025 16.31, Maciej Fijalkowski wrote:
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

Does the code not set the skb->pp_recycle ?

> Pull out the existing code from bpf_prog_run_generic_xdp() that
> init/prepares xdp_buff onto new helper xdp_convert_skb_to_buff() and
> embed there rxq's mem_type initialization that is assigned to xdp_buff.
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
>   include/net/xdp.h | 31 +++++++++++++++++++++++++++++++
>   net/core/dev.c    | 25 ++++---------------------
>   2 files changed, 35 insertions(+), 21 deletions(-)
> 
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index aa742f413c35..51f3321e4f94 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -384,6 +384,37 @@ struct sk_buff *xdp_build_skb_from_frame(struct xdp_frame *xdpf,
>   					 struct net_device *dev);
>   struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf);
>   
> +static inline
> +void xdp_convert_skb_to_buff(struct sk_buff *skb, struct xdp_buff *xdp,
> +			     struct xdp_rxq_info *xdp_rxq)
> +{

I really like that this is getting put into a helper function :-)

> +	u32 frame_sz, mac_len;
> +	void *hard_start;
> +
> +	/* The XDP program wants to see the packet starting at the MAC
> +	 * header.
> +	 */
> +	mac_len = skb->data - skb_mac_header(skb);
> +	hard_start = skb->data - skb_headroom(skb);
> +
> +	/* SKB "head" area always have tailroom for skb_shared_info */
> +	frame_sz = skb_end_pointer(skb) - skb->head;
> +	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +	xdp_init_buff(xdp, frame_sz, xdp_rxq);
> +	xdp_prepare_buff(xdp, hard_start, skb_headroom(skb) - mac_len,
> +			 skb_headlen(skb) + mac_len, true);
> +
> +	if (skb_is_nonlinear(skb)) {
> +		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
> +		xdp_buff_set_frags_flag(xdp);
> +	} else {
> +		xdp_buff_clear_frags_flag(xdp);
> +	}
> +

The SKB should be marked via skb->pp_recycle, but I guess you are trying
to catch code that doesn't set this correctly?
(Slightly worried this will "paper-over" some other buggy code?)

> +	xdp->rxq->mem.type = page_pool_page_is_pp(virt_to_page(xdp->data)) ?
> +				MEM_TYPE_PAGE_POOL : MEM_TYPE_PAGE_SHARED;
> +}

In the beginning PP_MAGIC / PP_SIGNATURE was primarily used as a
debugging feature to catch faulty code that released pp pages to the
real page allocator.  It seems to have evolved into something more
critical.  Someone also tried to elevate this into a page flag, which
would make this more reliable.

> +
>   static inline
>   void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
>   			       struct xdp_buff *xdp)
> diff --git a/net/core/dev.c b/net/core/dev.c
> index a64cef2c537e..3d607dce292b 100644
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


