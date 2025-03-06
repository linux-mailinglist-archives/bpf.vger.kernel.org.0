Return-Path: <bpf+bounces-53467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81644A548D6
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 12:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37AE1895447
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 11:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745A420A5C1;
	Thu,  6 Mar 2025 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sd+dAWLr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD3D209F31;
	Thu,  6 Mar 2025 11:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259576; cv=none; b=k0G4gTQQVn03sgB7vthHtWZuhmugCED3cKGoxdAX9SPgJOST5nDGDjFIWac83wjb6xHL4pQ0RTG+UL0QbruAeMUlaKBNvHgZcZ1sWy5/fsXaJNo2a13N9XJQPsR+a1U2Y9jjwUZYkjY8OyrKsUExLomwTJSJWEAaFfh5AVM9fFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259576; c=relaxed/simple;
	bh=lYae3WRiLznydk3RHjj+Z/pugxhSWQ36o+GiMUuG2XI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6Jp1eYDXTSw816gjmpXhcwp2PtwPly7C3G0gR7TxAejyRKMD6L+T2nqooXQ+WNLLXA3R3ARTBjJcJ2/yYlsPPTOY3klbQ+bgnB8DLapsBWXK+L/u5U7WmVBxnCzkuV6I7wlomhzvlIV3TeYfTsxQSXbHLCvLYdJnGicQMd1RVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sd+dAWLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C106BC4CEE0;
	Thu,  6 Mar 2025 11:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741259575;
	bh=lYae3WRiLznydk3RHjj+Z/pugxhSWQ36o+GiMUuG2XI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Sd+dAWLrPhqy7K84mF4HKJupEybbidTN6Q5TOfLgUI2s8CaVxwojucugH5VqtoFxB
	 0igOi8Bu4TqDAkvL8pQAPNUvHA19/dMsYfAIbBzO1CBdG8f96iarz9q+AdszpXbSe6
	 087IpifCfWTlG5WNJHVaWit3lNmyxZvSD7criyDZpSAcr8Zy96jsqgHXzFSwrMZYb7
	 6NJFJL2sUj6Bniv599rLbpXKEe0y5fTcG9XXiTJju3UNkrR3HbDcKekGDPtKUeHbXx
	 09fdpAlXslO7YZx55mBl6g3tNWYKpDYeS7h/DIC2qcSX+mR4KRHszV7NqBDEXVMrU1
	 iMKOfxFDxvgMA==
Message-ID: <45522396-0fad-406e-ba53-0bb4aee53e67@kernel.org>
Date: Thu, 6 Mar 2025 12:12:51 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next 07/20] xdp: Track if metadata is supported in
 xdp_frame <> xdp_buff conversions
To: Arthur Fabre <arthur@arthurfabre.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, jakub@cloudflare.com,
 yan@cloudflare.com, jbrandeburg@cloudflare.com, thoiland@redhat.com,
 lbiancon@redhat.com, Arthur Fabre <afabre@cloudflare.com>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
 <20250305-afabre-traits-010-rfc2-v1-7-d0ecfb869797@cloudflare.com>
 <bc356c91-5bff-454a-8f87-7415cb7e82b4@intel.com>
 <D88HSZ3GZZNN.160YSWHX1HIO2@arthurfabre.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <D88HSZ3GZZNN.160YSWHX1HIO2@arthurfabre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/03/2025 18.02, Arthur Fabre wrote:
> On Wed Mar 5, 2025 at 4:24 PM CET, Alexander Lobakin wrote:
>> From: Arthur <arthur@arthurfabre.com>
>> Date: Wed, 05 Mar 2025 15:32:04 +0100
>>
>>> From: Arthur Fabre <afabre@cloudflare.com>
>>>
>>> xdp_buff stores whether metadata is supported by a NIC by setting
>>> data_meta to be greater than data.
>>>
>>> But xdp_frame only stores the metadata size (as metasize), so converting
>>> between xdp_frame and xdp_buff is lossy.
>>>
>>> Steal an unused bit in xdp_frame to track whether metadata is supported
>>> or not.
>>>
>>> This will lets us have "generic" functions for setting skb fields from
>>> either xdp_frame or xdp_buff from drivers.
>>>
>>> Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
>>> ---
>>>   include/net/xdp.h | 10 +++++++++-
>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/net/xdp.h b/include/net/xdp.h
>>> index 58019fa299b56dbd45c104fdfa807f73af6e4fa4..84afe07d09efdb2ab0cb78b904f02cb74f9a56b6 100644
>>> --- a/include/net/xdp.h
>>> +++ b/include/net/xdp.h
>>> @@ -116,6 +116,9 @@ static __always_inline void xdp_buff_set_frag_pfmemalloc(struct xdp_buff *xdp)
>>>   	xdp->flags |= XDP_FLAGS_FRAGS_PF_MEMALLOC;
>>>   }
>>>   
>>> +static bool xdp_data_meta_unsupported(const struct xdp_buff *xdp);
>>> +static void xdp_set_data_meta_invalid(struct xdp_buff *xdp);
>>> +
>>>   static __always_inline void *xdp_buff_traits(const struct xdp_buff *xdp)
>>>   {
>>>   	return xdp->data_hard_start + _XDP_FRAME_SIZE;
>>> @@ -270,7 +273,9 @@ struct xdp_frame {
>>>   	void *data;
>>>   	u32 len;
>>>   	u32 headroom;
>>> -	u32 metasize; /* uses lower 8-bits */
>>> +	u32	:23, /* unused */
>>> +		meta_unsupported:1,
>>> +		metasize:8;
>>
>> See the history of this structure how we got rid of using bitfields here
>> and why.
>>
>> ...because of performance.
>>
>> Even though metasize uses only 8 bits, 1-byte access is slower than
>> 32-byte access.
> 
> Interesting, thanks!
> 

I agree with Olek, we should not use bitfields.  Thanks for catching this.

(The xdp_frame have a flags member...)
Why don't we use the flags member for storing this information?


>> I was going to write "you can use the fact that metasize is always a
>> multiple of 4 or that it's never > 252, for example, you could reuse LSB
>> as a flag indicating that meta is not supported", but first of all
>>
>> Do we still have drivers which don't support metadata?
>> Why don't they do that? It's not HW-specific or even driver-specific.
>> They don't reserve headroom? Then they're invalid, at least XDP_REDIRECT
>> won't work.
>>

I'm fairly sure that all drivers support XDP_REDIRECT.
Except didn't Lorenzo add a feature bit for this?
(so, some drivers might explicitly not-support this)

>> So maybe we need to fix those drivers first, if there are any.
> 
> Most drivers don't support metadata unfortunately:
> 
>> rg -U "xdp_prepare_buff\([^)]*false\);" drivers/net/
> drivers/net/tun.c
> 1712:		xdp_prepare_buff(&xdp, buf, pad, len, false);
> 
> drivers/net/ethernet/microsoft/mana/mana_bpf.c
> 94:	xdp_prepare_buff(xdp, buf_va, XDP_PACKET_HEADROOM, pkt_len, false);
> 
> drivers/net/ethernet/marvell/mvneta.c
> 2344:	xdp_prepare_buff(xdp, data, pp->rx_offset_correction + MVNETA_MH_SIZE,
> 2345:			 data_len, false);
> 
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> 1436:	xdp_prepare_buff(&xdp, hard_start, OTX2_HEAD_ROOM,
> 1437:			 cqe->sg.seg_size, false);
> 
> drivers/net/ethernet/socionext/netsec.c
> 1021:		xdp_prepare_buff(&xdp, desc->addr, NETSEC_RXBUF_HEADROOM,
> 1022:				 pkt_len, false);
> 
> drivers/net/ethernet/google/gve/gve_rx.c
> 740:	xdp_prepare_buff(&new, frame, headroom, len, false);
> 859:		xdp_prepare_buff(&xdp, page_info->page_address +
> 860:				 page_info->page_offset, GVE_RX_PAD,
> 861:				 len, false);
> 
> drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> 3984:			xdp_prepare_buff(&xdp, data,
> 3985:					 MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM,
> 3986:					 rx_bytes, false);
> 
> drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> 794:		xdp_prepare_buff(&xdp, hard_start, rx_ring->page_offset,
> 795:				 buff->len, false);
> 
> drivers/net/ethernet/cavium/thunder/nicvf_main.c
> 554:	xdp_prepare_buff(&xdp, hard_start, data - hard_start, len, false);
> 
> drivers/net/ethernet/ti/cpsw_new.c
> 348:		xdp_prepare_buff(&xdp, pa, headroom, size, false);
> 
> drivers/net/ethernet/freescale/enetc/enetc.c
> 1710:	xdp_prepare_buff(xdp_buff, hard_start - rx_ring->buffer_offset,
> 1711:			 rx_ring->buffer_offset, size, false);
> 
> drivers/net/ethernet/ti/am65-cpsw-nuss.c
> 1335:		xdp_prepare_buff(&xdp, page_addr, AM65_CPSW_HEADROOM,
> 1336:				 pkt_len, false);
> 
> drivers/net/ethernet/ti/cpsw.c
> 403:		xdp_prepare_buff(&xdp, pa, headroom, size, false);
> 
> drivers/net/ethernet/sfc/rx.c
> 289:	xdp_prepare_buff(&xdp, *ehp - EFX_XDP_HEADROOM, EFX_XDP_HEADROOM,
> 290:			 rx_buf->len, false);
> 
> drivers/net/ethernet/mediatek/mtk_eth_soc.c
> 2097:			xdp_prepare_buff(&xdp, data, MTK_PP_HEADROOM, pktlen,
> 2098:					 false);
> 
> drivers/net/ethernet/sfc/siena/rx.c
> 291:	xdp_prepare_buff(&xdp, *ehp - EFX_XDP_HEADROOM, EFX_XDP_HEADROOM,
> 292:			 rx_buf->len, false)
> 
> I don't know if it's just because no one has added calls to
> skb_metadata_set() in yet, or if there's a more fundamental reason.
> 

I simply think driver developers have been lazy.

If someone want some easy kernel commits, these drivers should be fairly
easy to fix...

> I think they all reserve some amount of headroom, but not always the
> full XDP_PACKET_HEADROOM. Eg sfc:
> 

The Intel drivers use 192 (AFAIK if that is still true). The API ended
up supporting non-standard XDP_PACKET_HEADROOM, due to the Intel
drivers, when XDP support was added to those (which is a long time ago now).

> drivers/net/ethernet/sfc/net_driver.h:
> /* Non-standard XDP_PACKET_HEADROOM and tailroom to satisfy XDP_REDIRECT and
>   * still fit two standard MTU size packets into a single 4K page.
>   */
> #define EFX_XDP_HEADROOM	128
> 

This is smaller than most drivers, but still have enough headroom for 
xdp_frame + traits.

> If it's just because skb_metadata_set() is missing, I can take the
> patches from this series that adds a "generic" XDP -> skb hook ("trait:
> Propagate presence of traits to sk_buff"), have it call
> skb_metadata_set(), and try to add it to all the drivers in a separate
> series.
> 

I think someone should cleanup those drivers and add support.

--Jesper

>>>   	/* Lifetime of xdp_rxq_info is limited to NAPI/enqueue time,
>>>   	 * while mem_type is valid on remote CPU.
>>>   	 */
>>> @@ -369,6 +374,8 @@ void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
>>>   	xdp->data = frame->data;
>>>   	xdp->data_end = frame->data + frame->len;
>>>   	xdp->data_meta = frame->data - frame->metasize;
>>> +	if (frame->meta_unsupported)
>>> +		xdp_set_data_meta_invalid(xdp);
>>>   	xdp->frame_sz = frame->frame_sz;
>>>   	xdp->flags = frame->flags;
>>>   }
>>> @@ -396,6 +403,7 @@ int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
>>>   	xdp_frame->len  = xdp->data_end - xdp->data;
>>>   	xdp_frame->headroom = headroom - sizeof(*xdp_frame);
>>>   	xdp_frame->metasize = metasize;
>>> +	xdp_frame->meta_unsupported = xdp_data_meta_unsupported(xdp);
>>>   	xdp_frame->frame_sz = xdp->frame_sz;
>>>   	xdp_frame->flags = xdp->flags;
>>
>> Thanks,
>> Olek

