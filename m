Return-Path: <bpf+bounces-16251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD027FECF3
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 11:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A261C20F30
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 10:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21C638F8D;
	Thu, 30 Nov 2023 10:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNKX8n4H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A3A3B7B7;
	Thu, 30 Nov 2023 10:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC330C433C8;
	Thu, 30 Nov 2023 10:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701340623;
	bh=auSd9LTLM2YqrQCHw22Aa3ocIy6OhoyWMVFO4KXgl/s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qNKX8n4HYD9dCKOL7liHI2PVACbln1Su1TI8VtdjODlssdsyA52SpDZ2PiHRrVtXB
	 4eFcImhr27aAGDEG2zHT5WzIbx7uO+V2/M+RSG6RDOlVjQqTE+kawu/rNAE1emHrLZ
	 Vifhwm+cYPG/afyQXlwswRVdn4Iu/p9uHcNnj5mfAyh0UJ2etd5s1OCMcPO//6whK6
	 OqCSjEItSOeupC6t/yJosPSqU+R5T0pwU2b4QpZpZWPvOmP1WJem5VbFHsoOG83VwC
	 kqARwYIBQ4SIcEs4BwHyPBjsFEXzZ86KMT6os79C+rPxwS3Jb6Bm8odsGduTxkaUOb
	 s09/GUrXfvjgg==
Message-ID: <f41935a3-790b-4d23-870c-a37b757aea99@kernel.org>
Date: Thu, 30 Nov 2023 11:36:58 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/2] xdp: add multi-buff support for xdp
 running in generic mode
Content-Language: en-US
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lorenzo.bianconi@redhat.com, bpf@vger.kernel.org,
 toke@redhat.com, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 kernel-team <kernel-team@cloudflare.com>, Yan Zhai <yan@cloudflare.com>
References: <cover.1701334869.git.lorenzo@kernel.org>
 <ce8cc5ce6e25d5e455704aa42fbf633be206ce85.1701334869.git.lorenzo@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <ce8cc5ce6e25d5e455704aa42fbf633be206ce85.1701334869.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/30/23 10:11, Lorenzo Bianconi wrote:
> Similar to native xdp, do not always linearize the skb in
> netif_receive_generic_xdp routine but create a non-linear xdp_buff to be
> processed by the eBPF program. This allow to add  multi-buffer support
> for xdp running in generic mode.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   net/core/dev.c | 144 ++++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 119 insertions(+), 25 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 4df68d7f04a2..0d08e755bb7f 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4853,6 +4853,12 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
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
> @@ -4882,6 +4888,14 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
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
> @@ -4915,54 +4929,134 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
>   	return act;
>   }
>   
> -static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
> -				     struct xdp_buff *xdp,
> -				     struct bpf_prog *xdp_prog)
> +static int netif_skb_check_for_generic_xdp(struct sk_buff **pskb,
> +					   struct bpf_prog *prog)

I like this is split out into a check function.

>   {
>   	struct sk_buff *skb = *pskb;
> -	u32 act = XDP_DROP;
> -
> -	/* Reinjected packets coming from act_mirred or similar should
> -	 * not get XDP generic processing.
> -	 */
> -	if (skb_is_redirected(skb))
> -		return XDP_PASS;

(For other reviewers)
This reinjected check is moved further down.

> +	int err;
>   
> -	/* XDP packets must be linear and must have sufficient headroom
> -	 * of XDP_PACKET_HEADROOM bytes. This is the guarantee that also
> -	 * native XDP provides, thus we need to do it here as well.
> +	/* XDP does not support fraglist so we need to linearize
> +	 * the skb.
>   	 */
> -	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
> -	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
> +	if (skb_has_frag_list(skb) || !prog->aux->xdp_has_frags) {
>   		int hroom = XDP_PACKET_HEADROOM - skb_headroom(skb);
>   		int troom = skb->tail + skb->data_len - skb->end;
>   
>   		/* In case we have to go down the path and also linearize,
>   		 * then lets do the pskb_expand_head() work just once here.
>   		 */
> -		if (pskb_expand_head(skb,
> -				     hroom > 0 ? ALIGN(hroom, NET_SKB_PAD) : 0,
> -				     troom > 0 ? troom + 128 : 0, GFP_ATOMIC))
> -			goto do_drop;
> -		if (skb_linearize(skb))
> -			goto do_drop;
> +		err = pskb_expand_head(skb,
> +				       hroom > 0 ? ALIGN(hroom, NET_SKB_PAD) : 0,
> +				       troom > 0 ? troom + 128 : 0, GFP_ATOMIC);
> +		if (err)
> +			return err;
> +
> +		err = skb_linearize(skb);
> +		if (err)
> +			return err;
> +
> +		return 0;
> +	}
> +
> +	/* XDP packets must have sufficient headroom of XDP_PACKET_HEADROOM
> +	 * bytes. This is the guarantee that also native XDP provides,
> +	 * thus we need to do it here as well.
> +	 */
> +	if (skb_cloned(skb) || skb_shinfo(skb)->nr_frags ||

I though we could allow a SKB with skb_shinfo(skb)->nr_frags (that isn't
cloned or shared) to be processed by generic XDP without any reallocation?

So check would be: (skb_cloned(skb) || skb_shared(skb) ||)

> +	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {

[Headroom trick]
For layered devices the netstack could be the process that created the
SKB.  If you noticed my veth patchset[4/4], when I detect an XDP-prog
attach, I'm increasing the net_device headroom (.ndo_set_rx_headroom)
such that netstack will allocated enough headroom to satisfy
XDP_PACKET_HEADROOM.

[4/4] 
https://lore.kernel.org/netdev/169272716651.1975370.10514711233878278884.stgit@firesoul/



> +		u32 mac_len = skb->data - skb_mac_header(skb);
> +		u32 size, len, max_head_size, off;
> +		struct sk_buff *nskb;
> +		int i, head_off;
> +
> +		__skb_push(skb, mac_len);
> +		max_head_size = SKB_WITH_OVERHEAD(PAGE_SIZE -
> +						  XDP_PACKET_HEADROOM);
> +		if (skb->len > max_head_size + MAX_SKB_FRAGS * PAGE_SIZE)
> +			return -ENOMEM;
> +
> +		size = min_t(u32, skb->len, max_head_size);
> +		nskb = netdev_alloc_skb(skb->dev, size + XDP_PACKET_HEADROOM);


Would is be possible to use napi_alloc_skb() here?

The napi_alloc_skb() is faster than netdev_alloc_skb(), but it as name
suggest assumes this is called under NAPI protection/context.  It
used-to-be the case for generic XDP, but code got moved around to
support layered devices, so I not 100% sure if this is always true (NAPI
context).


> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		skb_reserve(nskb, XDP_PACKET_HEADROOM);
> +		skb_copy_header(nskb, skb);
> +
> +		err = skb_copy_bits(skb, 0, nskb->data, size);
> +		if (err) {
> +			consume_skb(nskb);
> +			return err;
> +		}
> +		skb_put(nskb, size);
> +
> +		head_off = skb_headroom(nskb) - skb_headroom(skb);
> +		skb_headers_offset_update(nskb, head_off);
> +
> +		off = size;
> +		len = skb->len - off;
> +		for (i = 0; i < MAX_SKB_FRAGS && off < skb->len; i++) {
> +			struct page *page;
> +			void *frag;
> +
> +			size = min_t(u32, len, PAGE_SIZE);
> +			frag = netdev_alloc_frag(size);

Again the slower variant.

> +			if (!frag) {
> +				consume_skb(nskb);
> +				return -ENOMEM;
> +			}
> +
> +			page = virt_to_head_page(frag);
> +			skb_add_rx_frag(nskb, i, page,
> +					frag - page_address(page), size, size);
> +			err = skb_copy_bits(skb, off, frag, size);
> +			if (err) {
> +				consume_skb(nskb);
> +				return err;
> +			}
> +
> +			len -= size;
> +			off += size;
> +		}
> +
> +		consume_skb(skb);
> +		*pskb = nskb;
> +		__skb_pull(nskb, mac_len);
>   	}
>   
> -	act = bpf_prog_run_generic_xdp(skb, xdp, xdp_prog);
> +	return 0;
> +}
> +
> +static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
> +				     struct xdp_buff *xdp,
> +				     struct bpf_prog *xdp_prog)
> +{
> +	u32 act = XDP_DROP;
> +
> +	/* Reinjected packets coming from act_mirred or similar should
> +	 * not get XDP generic processing.
> +	 */
> +	if (skb_is_redirected(*pskb))
> +		return XDP_PASS;
> +
> +	if (netif_skb_check_for_generic_xdp(pskb, xdp_prog))
> +		goto do_drop;
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

Overall I like the patch :-)

Are we missing more things to allow GRO packets getting processed by 
generic XDP?

--Jesper

