Return-Path: <bpf+bounces-67869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E3CB4FD40
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 15:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E5D1C26A78
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 13:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79F0346A0F;
	Tue,  9 Sep 2025 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmtQs6I2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8D93469FB;
	Tue,  9 Sep 2025 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424607; cv=none; b=bB+oHsjGt0HG421CgcbOAZ+3i9SqhDkoicbVDcaw4AuG7IKBo3WrQtwO1BhwQNkwEI/N5HeMgWovGEBIl885YFu51FCUjMyxsECQLqRMKAzolHzKKegeQAqd3CA7q8AzxEcDgDJfIDePUVnWhKqmP8C1B9WHGxqoqGqRAVDalDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424607; c=relaxed/simple;
	bh=HUuseAGox18NVw/+eH/OXN+eVQNGzCFhxG8msFUVayw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRKgcz8CT1DKko9OtO+5S6MOuJi2YIlp28+1zNqr63tgpK3qRIjzxoEzeUwUFJUmQTjocgCmQm/sTS7KkBeIZ/8hfIjxLA7VrB6oI3r15DNctdHc8fNpoLZIBD9svP+WFDl40wwvxTPE7peQAjoDxN7D14xBB1cybWnXKsFYgfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmtQs6I2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624DBC4CEF4;
	Tue,  9 Sep 2025 13:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757424606;
	bh=HUuseAGox18NVw/+eH/OXN+eVQNGzCFhxG8msFUVayw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XmtQs6I2m1bnkiEYYUGG5bRCXUPEruKycGoZE7u+H1iB6Lmeda/zftlLv+WHYF7be
	 ef32kOZrGRJ+2YPjO8bbVgokdKcqf+gLp+FG159KgYdUndMa4jlNilpY3fqgz/ReSh
	 TtEVzP47kMMdYbyzmmMGjKV491NrM6BXPH5JGjnHDE8l8OsumUm7s2Cw29A/lk2AMi
	 VFXD2X4Z4xuagffoaDaP7+XkHwhOVJGuUA4MtiFn+S143czqDFbLhCm4/p9oElojsx
	 B8jRZmm2oW1sCCF0nXyhcRlkpntOzpuAz3C+tff1lgiEmguMpx9Ic+CMpak2YPO7mm
	 okSwldsz7XxWQ==
Message-ID: <669d9245-ac4b-4d43-aea3-cc30ac5836a4@kernel.org>
Date: Tue, 9 Sep 2025 15:30:00 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: xdp: pass full flags to
 xdp_update_skb_shared_info()
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, sdf@fomichev.me, michael.chan@broadcom.com,
 anthony.l.nguyen@intel.com, marcin.s.wojtas@gmail.com, tariqt@nvidia.com,
 mbloch@nvidia.com, jasowang@redhat.com, bpf@vger.kernel.org,
 aleksander.lobakin@intel.com, pavan.chebbi@broadcom.com,
 przemyslaw.kitszel@intel.com
References: <20250905221539.2930285-1-kuba@kernel.org>
 <20250905221539.2930285-2-kuba@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250905221539.2930285-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/09/2025 00.15, Jakub Kicinski wrote:
> xdp_update_skb_shared_info() needs to update skb state which
> was maintained in xdp_buff / frame. Pass full flags into it,
> instead of breaking it out bit by bit. We will need to add
> a bit for unreadable frags (even tho XDP doesn't support
> those the driver paths may be common), at which point almost
> all call sites would become:
> 
>      xdp_update_skb_shared_info(skb, num_frags,
>                                 sinfo->xdp_frags_size,
>                                 MY_PAGE_SIZE * num_frags,
>                                 xdp_buff_is_frag_pfmemalloc(xdp),
>                                 xdp_buff_is_frag_unreadable(xdp));
> 
> Keep a helper for accessing the flags, in case we need to
> transform them somehow in the future (e.g. to cover up xdp_buff
> vs xdp_frame differences).
> 
> While we are touching call callers - rename the helper to
> xdp_update_skb_frags_info(), previous name may have implied that
> it's shinfo that's updated. We are updating flags in struct sk_buff
> based on frags that got attched.
typo                      ^^^^^^^

> 

I'm fine with the name xdp_update_skb_frags_info().
But I want to point out that the function *does* also update shinfo.
The xdp_buff/xdp-frame have a compatible layout for shinfo, except for a
union with sinfo->destructor_arg, which we need to clear.  This is a
transition point from XDP to SKB, which is why I think the function name
change is appropiate.

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v1:
>   - rename skb_flags arg to xdp_flags

Thanks for that. You kept the function name xdp_buff_get_skb_flags(),
indicating this is "skb_flags".  I don't think it matters much, so to
avoid bikesheeting I'm just going to ACK this.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

--Jesper

>   - rename xdp_update_skb_shared_info() -> xdp_update_skb_frags_info()
> RFC: https://lore.kernel.org/20250812161528.835855-1-kuba@kernel.org
> ---
>   include/net/xdp.h                             | 25 +++++++++----------
>   drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  7 +++---
>   drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 15 ++++++-----
>   drivers/net/ethernet/intel/ice/ice_txrx.c     | 15 ++++++-----
>   drivers/net/ethernet/marvell/mvneta.c         |  7 +++---
>   .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 23 ++++++++---------
>   drivers/net/virtio_net.c                      |  7 +++---
>   net/core/xdp.c                                | 21 ++++++++--------
>   8 files changed, 56 insertions(+), 64 deletions(-)
> 
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index b40f1f96cb11..57189fc21168 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -104,17 +104,16 @@ static __always_inline void xdp_buff_clear_frags_flag(struct xdp_buff *xdp)
>   	xdp->flags &= ~XDP_FLAGS_HAS_FRAGS;
>   }
>   
> -static __always_inline bool
> -xdp_buff_is_frag_pfmemalloc(const struct xdp_buff *xdp)
> -{
> -	return !!(xdp->flags & XDP_FLAGS_FRAGS_PF_MEMALLOC);
> -}
> -
>   static __always_inline void xdp_buff_set_frag_pfmemalloc(struct xdp_buff *xdp)
>   {
>   	xdp->flags |= XDP_FLAGS_FRAGS_PF_MEMALLOC;
>   }
>   
> +static __always_inline u32 xdp_buff_get_skb_flags(const struct xdp_buff *xdp)
> +{
> +	return xdp->flags;
> +}
> +
>   static __always_inline void
>   xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
>   {
> @@ -272,10 +271,10 @@ static __always_inline bool xdp_frame_has_frags(const struct xdp_frame *frame)
>   	return !!(frame->flags & XDP_FLAGS_HAS_FRAGS);
>   }
>   
> -static __always_inline bool
> -xdp_frame_is_frag_pfmemalloc(const struct xdp_frame *frame)
> +static __always_inline u32
> +xdp_frame_get_skb_flags(const struct xdp_frame *frame)
>   {
> -	return !!(frame->flags & XDP_FLAGS_FRAGS_PF_MEMALLOC);
> +	return frame->flags;
>   }
>   
>   #define XDP_BULK_QUEUE_SIZE	16
> @@ -312,9 +311,9 @@ static inline void xdp_scrub_frame(struct xdp_frame *frame)
>   }
>   
>   static inline void
> -xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
> -			   unsigned int size, unsigned int truesize,
> -			   bool pfmemalloc)
> +xdp_update_skb_frags_info(struct sk_buff *skb, u8 nr_frags,
> +			  unsigned int size, unsigned int truesize,
> +			  u32 xdp_flags)
>   {
>   	struct skb_shared_info *sinfo = skb_shinfo(skb);
>   
> @@ -328,7 +327,7 @@ xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
>   	skb->len += size;
>   	skb->data_len += size;
>   	skb->truesize += truesize;
> -	skb->pfmemalloc |= pfmemalloc;
> +	skb->pfmemalloc |= !!(xdp_flags & XDP_FLAGS_FRAGS_PF_MEMALLOC);
>   }
>   
>   /* Avoids inlining WARN macro in fast-path */
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> index 58d579dca3f1..3e77a96e5a3e 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> @@ -468,9 +468,8 @@ bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
>   	if (!skb)
>   		return NULL;
>   
> -	xdp_update_skb_shared_info(skb, num_frags,
> -				   sinfo->xdp_frags_size,
> -				   BNXT_RX_PAGE_SIZE * num_frags,
> -				   xdp_buff_is_frag_pfmemalloc(xdp));
> +	xdp_update_skb_frags_info(skb, num_frags, sinfo->xdp_frags_size,
> +				  BNXT_RX_PAGE_SIZE * num_frags,
> +				  xdp_buff_get_skb_flags(xdp));
>   	return skb;
>   }
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 048c33039130..98601c62c592 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -2151,10 +2151,10 @@ static struct sk_buff *i40e_construct_skb(struct i40e_ring *rx_ring,
>   		memcpy(&skinfo->frags[skinfo->nr_frags], &sinfo->frags[0],
>   		       sizeof(skb_frag_t) * nr_frags);
>   
> -		xdp_update_skb_shared_info(skb, skinfo->nr_frags + nr_frags,
> -					   sinfo->xdp_frags_size,
> -					   nr_frags * xdp->frame_sz,
> -					   xdp_buff_is_frag_pfmemalloc(xdp));
> +		xdp_update_skb_frags_info(skb, skinfo->nr_frags + nr_frags,
> +					  sinfo->xdp_frags_size,
> +					  nr_frags * xdp->frame_sz,
> +					  xdp_buff_get_skb_flags(xdp));
>   
>   		/* First buffer has already been processed, so bump ntc */
>   		if (++rx_ring->next_to_clean == rx_ring->count)
> @@ -2206,10 +2206,9 @@ static struct sk_buff *i40e_build_skb(struct i40e_ring *rx_ring,
>   		skb_metadata_set(skb, metasize);
>   
>   	if (unlikely(xdp_buff_has_frags(xdp))) {
> -		xdp_update_skb_shared_info(skb, nr_frags,
> -					   sinfo->xdp_frags_size,
> -					   nr_frags * xdp->frame_sz,
> -					   xdp_buff_is_frag_pfmemalloc(xdp));
> +		xdp_update_skb_frags_info(skb, nr_frags, sinfo->xdp_frags_size,
> +					  nr_frags * xdp->frame_sz,
> +					  xdp_buff_get_skb_flags(xdp));
>   
>   		i40e_process_rx_buffs(rx_ring, I40E_XDP_PASS, xdp);
>   	} else {
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index d2871757ec94..107632a71f3c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -1035,10 +1035,9 @@ ice_build_skb(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp)
>   		skb_metadata_set(skb, metasize);
>   
>   	if (unlikely(xdp_buff_has_frags(xdp)))
> -		xdp_update_skb_shared_info(skb, nr_frags,
> -					   sinfo->xdp_frags_size,
> -					   nr_frags * xdp->frame_sz,
> -					   xdp_buff_is_frag_pfmemalloc(xdp));
> +		xdp_update_skb_frags_info(skb, nr_frags, sinfo->xdp_frags_size,
> +					  nr_frags * xdp->frame_sz,
> +					  xdp_buff_get_skb_flags(xdp));
>   
>   	return skb;
>   }
> @@ -1115,10 +1114,10 @@ ice_construct_skb(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp)
>   		memcpy(&skinfo->frags[skinfo->nr_frags], &sinfo->frags[0],
>   		       sizeof(skb_frag_t) * nr_frags);
>   
> -		xdp_update_skb_shared_info(skb, skinfo->nr_frags + nr_frags,
> -					   sinfo->xdp_frags_size,
> -					   nr_frags * xdp->frame_sz,
> -					   xdp_buff_is_frag_pfmemalloc(xdp));
> +		xdp_update_skb_frags_info(skb, skinfo->nr_frags + nr_frags,
> +					  sinfo->xdp_frags_size,
> +					  nr_frags * xdp->frame_sz,
> +					  xdp_buff_get_skb_flags(xdp));
>   	}
>   
>   	return skb;
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 476e73e502fe..7351e98d73f4 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -2416,10 +2416,9 @@ mvneta_swbm_build_skb(struct mvneta_port *pp, struct page_pool *pool,
>   	skb->ip_summed = mvneta_rx_csum(pp, desc_status);
>   
>   	if (unlikely(xdp_buff_has_frags(xdp)))
> -		xdp_update_skb_shared_info(skb, num_frags,
> -					   sinfo->xdp_frags_size,
> -					   num_frags * xdp->frame_sz,
> -					   xdp_buff_is_frag_pfmemalloc(xdp));
> +		xdp_update_skb_frags_info(skb, num_frags, sinfo->xdp_frags_size,
> +					  num_frags * xdp->frame_sz,
> +					  xdp_buff_get_skb_flags(xdp));
>   
>   	return skb;
>   }
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index b8c609d91d11..2925ece136c4 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -1796,10 +1796,9 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
>   
>   	if (xdp_buff_has_frags(&mxbuf->xdp)) {
>   		/* sinfo->nr_frags is reset by build_skb, calculate again. */
> -		xdp_update_skb_shared_info(skb, wi - head_wi - 1,
> -					   sinfo->xdp_frags_size, truesize,
> -					   xdp_buff_is_frag_pfmemalloc(
> -						&mxbuf->xdp));
> +		xdp_update_skb_frags_info(skb, wi - head_wi - 1,
> +					  sinfo->xdp_frags_size, truesize,
> +					  xdp_buff_get_skb_flags(&mxbuf->xdp));
>   
>   		for (struct mlx5e_wqe_frag_info *pwi = head_wi + 1; pwi < wi; pwi++)
>   			pwi->frag_page->frags++;
> @@ -2105,10 +2104,10 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>   			struct mlx5e_frag_page *pagep;
>   
>   			/* sinfo->nr_frags is reset by build_skb, calculate again. */
> -			xdp_update_skb_shared_info(skb, frag_page - head_page,
> -						   sinfo->xdp_frags_size, truesize,
> -						   xdp_buff_is_frag_pfmemalloc(
> -							&mxbuf->xdp));
> +			xdp_update_skb_frags_info(skb, frag_page - head_page,
> +						  sinfo->xdp_frags_size,
> +						  truesize,
> +						  xdp_buff_get_skb_flags(&mxbuf->xdp));
>   
>   			pagep = head_page;
>   			do
> @@ -2122,10 +2121,10 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>   		if (xdp_buff_has_frags(&mxbuf->xdp)) {
>   			struct mlx5e_frag_page *pagep;
>   
> -			xdp_update_skb_shared_info(skb, sinfo->nr_frags,
> -						   sinfo->xdp_frags_size, truesize,
> -						   xdp_buff_is_frag_pfmemalloc(
> -							&mxbuf->xdp));
> +			xdp_update_skb_frags_info(skb, sinfo->nr_frags,
> +						  sinfo->xdp_frags_size,
> +						  truesize,
> +						  xdp_buff_get_skb_flags(&mxbuf->xdp));
>   
>   			pagep = frag_page - sinfo->nr_frags;
>   			do
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 975bdc5dab84..06708c9a979e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2185,10 +2185,9 @@ static struct sk_buff *build_skb_from_xdp_buff(struct net_device *dev,
>   		skb_metadata_set(skb, metasize);
>   
>   	if (unlikely(xdp_buff_has_frags(xdp)))
> -		xdp_update_skb_shared_info(skb, nr_frags,
> -					   sinfo->xdp_frags_size,
> -					   xdp_frags_truesz,
> -					   xdp_buff_is_frag_pfmemalloc(xdp));
> +		xdp_update_skb_frags_info(skb, nr_frags, sinfo->xdp_frags_size,
> +					  xdp_frags_truesz,
> +					  xdp_buff_get_skb_flags(xdp));
>   
>   	return skb;
>   }
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 491334b9b8be..9100e160113a 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -663,9 +663,8 @@ struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
>   		u32 tsize;
>   
>   		tsize = sinfo->xdp_frags_truesize ? : nr_frags * xdp->frame_sz;
> -		xdp_update_skb_shared_info(skb, nr_frags,
> -					   sinfo->xdp_frags_size, tsize,
> -					   xdp_buff_is_frag_pfmemalloc(xdp));
> +		xdp_update_skb_frags_info(skb, nr_frags, sinfo->xdp_frags_size,
> +					  tsize, xdp_buff_get_skb_flags(xdp));
>   	}
>   
>   	skb->protocol = eth_type_trans(skb, rxq->dev);
> @@ -692,7 +691,7 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
>   	struct skb_shared_info *sinfo = skb_shinfo(skb);
>   	const struct skb_shared_info *xinfo;
>   	u32 nr_frags, tsize = 0;
> -	bool pfmemalloc = false;
> +	u32 flags = 0;
>   
>   	xinfo = xdp_get_shared_info_from_buff(xdp);
>   	nr_frags = xinfo->nr_frags;
> @@ -714,11 +713,12 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
>   		__skb_fill_page_desc_noacc(sinfo, i, page, offset, len);
>   
>   		tsize += truesize;
> -		pfmemalloc |= page_is_pfmemalloc(page);
> +		if (page_is_pfmemalloc(page))
> +			flags |= XDP_FLAGS_FRAGS_PF_MEMALLOC;
>   	}
>   
> -	xdp_update_skb_shared_info(skb, nr_frags, xinfo->xdp_frags_size,
> -				   tsize, pfmemalloc);
> +	xdp_update_skb_frags_info(skb, nr_frags, xinfo->xdp_frags_size, tsize,
> +				  flags);
>   
>   	return true;
>   }
> @@ -823,10 +823,9 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
>   		skb_metadata_set(skb, xdpf->metasize);
>   
>   	if (unlikely(xdp_frame_has_frags(xdpf)))
> -		xdp_update_skb_shared_info(skb, nr_frags,
> -					   sinfo->xdp_frags_size,
> -					   nr_frags * xdpf->frame_sz,
> -					   xdp_frame_is_frag_pfmemalloc(xdpf));
> +		xdp_update_skb_frags_info(skb, nr_frags, sinfo->xdp_frags_size,
> +					  nr_frags * xdpf->frame_sz,
> +					  xdp_frame_get_skb_flags(xdpf));
>   
>   	/* Essential SKB info: protocol and skb->dev */
>   	skb->protocol = eth_type_trans(skb, dev);


