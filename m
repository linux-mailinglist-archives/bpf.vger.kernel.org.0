Return-Path: <bpf+bounces-18396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D03D81A3A4
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 17:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C696A1F2612A
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 16:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E54C4645F;
	Wed, 20 Dec 2023 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+2gZ7NQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8F74776A;
	Wed, 20 Dec 2023 16:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DD0C433C7;
	Wed, 20 Dec 2023 16:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703088102;
	bh=CSa9vgnYzla1CprgzfBcXsc621DZ4W/ZOKDD7gCZCkY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r+2gZ7NQizZOTLdTMypX8PTNe4zhCKmn5V4QP+/IHWYvtm1aEXom+X5RpsGOLGfzd
	 J5HlOFlaQHyPrFTRqYzyPjP9zr6HocL48UO6BUY0igY2It6ekHCZ1CQ5c63yCJK/r/
	 eCseZG9ZuAhuyDEVWuEZuXXx/O6G+zmp1kIHa2JsI2kjDaCdUEdd53sZqEDVwNvbmL
	 OWOGHLzbxALpz8+0/MtVGNWn2wQ4logZp4feSFk2VdhBo+oCUjP4oCNy4Po8NXDxPx
	 uUAC9UoWYQV/vfzkqRJd47OdhZxOfsSh2V7jY59ebMnFOmnMI0Tc1DMp8TJPhu+iFv
	 ClBF4ZmNDM1bA==
Message-ID: <d617df2b-620f-4a6f-b7dd-852bf156f904@kernel.org>
Date: Wed, 20 Dec 2023 17:01:37 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 3/3] xdp: add multi-buff support for xdp
 running in generic mode
Content-Language: en-US
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, bpf@vger.kernel.org,
 toke@redhat.com, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 sdf@google.com, Yan Zhai <yan@cloudflare.com>
References: <cover.1702563810.git.lorenzo@kernel.org>
 <e73a75e0d0f81a3b20568675829df4763fa0d389.1702563810.git.lorenzo@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <e73a75e0d0f81a3b20568675829df4763fa0d389.1702563810.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/12/2023 15.29, Lorenzo Bianconi wrote:
> Similar to native xdp, do not always linearize the skb in
> netif_receive_generic_xdp routine but create a non-linear xdp_buff to be
> processed by the eBPF program. This allow to add  multi-buffer support
> for xdp running in generic mode.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   net/core/dev.c | 153 +++++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 134 insertions(+), 19 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index d7857de03dba..47164acc3268 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4854,6 +4854,12 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
>   	xdp_init_buff(xdp, frame_sz, &rxqueue->xdp_rxq);
>   	xdp_prepare_buff(xdp, hard_start, skb_headroom(skb) - mac_len,
>   			 skb_headlen(skb) + mac_len, true);
> +	if (skb_is_nonlinear(skb)) {
> +		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
> +		xdp_buff_set_frags_flag(xdp);
> +	} else {
> +		xdp_buff_clear_frags_flag(xdp);
> +	}
>   
>   	orig_data_end = xdp->data_end;
>   	orig_data = xdp->data;
> @@ -4883,6 +4889,14 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
>   		skb->len += off; /* positive on grow, negative on shrink */
>   	}
>   
> +	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> +	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> +	 */
> +	if (xdp_buff_has_frags(xdp))
> +		skb->data_len = skb_shinfo(skb)->xdp_frags_size;
> +	else
> +		skb->data_len = 0;
> +
>   	/* check if XDP changed eth hdr such SKB needs update */
>   	eth = (struct ethhdr *)xdp->data;
>   	if ((orig_eth_type != eth->h_proto) ||
> @@ -4916,12 +4930,118 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
>   	return act;
>   }
>   
> +static int netif_skb_segment_for_xdp(struct sk_buff **pskb,

This function "...segment_for_xdp" always reallocate SKB and copies all
bits over.
Should it have been named "skb_realloc_for_xdp" ?

I was really hopeing we can find a design to avoid doing this realloc.

If the BPF-prog doesn't write into any of the fragments, then we can
avoid this realloc (+copy) dance. We designed XDP multi-buff to have
exactly the same layout+location as SKB in skb_shared_info, exactly to
avoid having to reallocated.

More comments inline below...

> +				     struct bpf_prog *prog)
> +{
> +#if IS_ENABLED(CONFIG_PAGE_POOL)
> +	struct softnet_data *sd = this_cpu_ptr(&softnet_data);
> +	u32 size, truesize, len, max_head_size, off;
> +	struct sk_buff *skb = *pskb, *nskb;
> +	int err, i, head_off;
> +	void *data;
> +
> +	/* XDP does not support fraglist so we need to linearize
> +	 * the skb.
> +	 */
> +	if (skb_has_frag_list(skb) || !prog->aux->xdp_has_frags)
> +		return -EOPNOTSUPP;
> +
> +	max_head_size = SKB_WITH_OVERHEAD(PAGE_SIZE - XDP_PACKET_HEADROOM);
> +	if (skb->len > max_head_size + MAX_SKB_FRAGS * PAGE_SIZE)
> +		return -ENOMEM;
> +
> +	size = min_t(u32, skb->len, max_head_size);
> +	truesize = SKB_HEAD_ALIGN(size) + XDP_PACKET_HEADROOM;
> +	data = page_pool_dev_alloc_va(sd->page_pool, &truesize);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	nskb = napi_build_skb(data, truesize);
> +	if (!nskb) {
> +		page_pool_free_va(sd->page_pool, data, true);
> +		return -ENOMEM;
> +	}
> +
> +	skb_reserve(nskb, XDP_PACKET_HEADROOM);
> +	skb_copy_header(nskb, skb);
> +	skb_mark_for_recycle(nskb);
> +
> +	err = skb_copy_bits(skb, 0, nskb->data, size);

This will likely copy part of the "frags" into the SKB "head" area.

Especially for netstack generated TCP packets, this will change the
segmentation layout significantly.  I wonder what (performance) effects
this will have on further handling of these SKBs.



> +	if (err) {
> +		consume_skb(nskb);
> +		return err;
> +	}
> +	skb_put(nskb, size);
> +
> +	head_off = skb_headroom(nskb) - skb_headroom(skb);
> +	skb_headers_offset_update(nskb, head_off);
> +
> +	off = size;
> +	len = skb->len - off;
> +	for (i = 0; i < MAX_SKB_FRAGS && off < skb->len; i++) {
> +		struct page *page;
> +		u32 page_off;
> +
> +		size = min_t(u32, len, PAGE_SIZE);
> +		truesize = size;
> +
> +		page = page_pool_dev_alloc(sd->page_pool, &page_off,
> +					   &truesize);
> +		if (!data) {
> +			consume_skb(nskb);
> +			return -ENOMEM;
> +		}
> +
> +		skb_add_rx_frag(nskb, i, page, page_off, size, truesize);
> +		err = skb_copy_bits(skb, off, page_address(page) + page_off,
> +				    size);

I think it is correct, but we can easily endup with the new SKB (nskb)
having a different nskb->nr_frags.


> +		if (err) {
> +			consume_skb(nskb);
> +			return err;
> +		}
> +
> +		len -= size;
> +		off += size;
> +	}
> +
> +	consume_skb(skb);
> +	*pskb = nskb;
> +
> +	return 0;
> +#else
> +	return -EOPNOTSUPP;
> +#endif
> +}
> +
> +static int netif_skb_check_for_xdp(struct sk_buff **pskb,
> +				   struct bpf_prog *prog)
> +{
> +	struct sk_buff *skb = *pskb;
> +	int err, hroom, troom;
> +
> +	if (!netif_skb_segment_for_xdp(pskb, prog))
> +		return 0;

IMHO the code call logic, does not make it easy to add cases where we
can avoid the realloc.  With this patch, it feels like the realloc+copy
code path is the "main" code path for XDP-generic.

Our goal should be to avoid realloc.

My goal for XDP multi-buff was/is that it can co-exist with GSO/GRO
packets.  This patchset is a step in the direction of enabling GRO on
devices with XDP (generic) loaded.  And I was really excited about this,
but the overhead is going to be massive compared to normal GRO (without
realloc+copy) that XDP end-users are going to be disappointed.


> +
> +	/* In case we have to go down the path and also linearize,
> +	 * then lets do the pskb_expand_head() work just once here.
> +	 */
> +	hroom = XDP_PACKET_HEADROOM - skb_headroom(skb);
> +	troom = skb->tail + skb->data_len - skb->end;
> +	err = pskb_expand_head(skb,
> +			       hroom > 0 ? ALIGN(hroom, NET_SKB_PAD) : 0,
> +			       troom > 0 ? troom + 128 : 0, GFP_ATOMIC);
> +	if (err)
> +		return err;
> +
> +	return skb_linearize(skb);
> +}
> +
>   static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
>   				     struct xdp_buff *xdp,
>   				     struct bpf_prog *xdp_prog)
>   {
>   	struct sk_buff *skb = *pskb;
> -	u32 act = XDP_DROP;
> +	u32 mac_len, act = XDP_DROP;
>   
>   	/* Reinjected packets coming from act_mirred or similar should
>   	 * not get XDP generic processing.
> @@ -4929,41 +5049,36 @@ static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
>   	if (skb_is_redirected(skb))
>   		return XDP_PASS;
>   
> -	/* XDP packets must be linear and must have sufficient headroom
> -	 * of XDP_PACKET_HEADROOM bytes. This is the guarantee that also
> -	 * native XDP provides, thus we need to do it here as well.
> +	/* XDP packets must have sufficient headroom of XDP_PACKET_HEADROOM
> +	 * bytes. This is the guarantee that also native XDP provides,
> +	 * thus we need to do it here as well.

Some "native" XDP provider only have 192 bytes as HEADROOM and XDP code
can this not being static (256 bytes).  So, perhaps it is time to allow
XDP generic to only require 192 bytes?

>   	 */
> +	mac_len = skb->data - skb_mac_header(skb);
> +	__skb_push(skb, mac_len);
> +
>   	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
>   	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
> -		int hroom = XDP_PACKET_HEADROOM - skb_headroom(skb);
> -		int troom = skb->tail + skb->data_len - skb->end;
> -
> -		/* In case we have to go down the path and also linearize,
> -		 * then lets do the pskb_expand_head() work just once here.
> -		 */
> -		if (pskb_expand_head(skb,
> -				     hroom > 0 ? ALIGN(hroom, NET_SKB_PAD) : 0,
> -				     troom > 0 ? troom + 128 : 0, GFP_ATOMIC))
> -			goto do_drop;
> -		if (skb_linearize(skb))
> +		if (netif_skb_check_for_xdp(pskb, xdp_prog))
>   			goto do_drop;
>   	}
>   
> -	act = bpf_prog_run_generic_xdp(skb, xdp, xdp_prog);
> +	__skb_pull(*pskb, mac_len);
> +
> +	act = bpf_prog_run_generic_xdp(*pskb, xdp, xdp_prog);
>   	switch (act) {
>   	case XDP_REDIRECT:
>   	case XDP_TX:
>   	case XDP_PASS:
>   		break;
>   	default:
> -		bpf_warn_invalid_xdp_action(skb->dev, xdp_prog, act);
> +		bpf_warn_invalid_xdp_action((*pskb)->dev, xdp_prog, act);
>   		fallthrough;
>   	case XDP_ABORTED:
> -		trace_xdp_exception(skb->dev, xdp_prog, act);
> +		trace_xdp_exception((*pskb)->dev, xdp_prog, act);
>   		fallthrough;
>   	case XDP_DROP:
>   	do_drop:
> -		kfree_skb(skb);
> +		kfree_skb(*pskb);
>   		break;
>   	}
>   

