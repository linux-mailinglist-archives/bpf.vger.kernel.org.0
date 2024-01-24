Return-Path: <bpf+bounces-20202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1DB83A43E
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 09:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CECBE1C23522
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 08:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F29175BB;
	Wed, 24 Jan 2024 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeVQ9ma4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C37E171D8;
	Wed, 24 Jan 2024 08:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085448; cv=none; b=SJWi4hE/jVswCvU4/jcNqXkbEvfRehMGDhCrbfVmK4TP4ZTn+BhfwJ8y5hyKwfatZWOE8Vg4k5ixglRgiSP5ZZG7VK6vQiojAEa/bdmpt4BrgbWSjtjEzfxRlONK5IybYJR69/c0NAMPtwDdnfgto7QCjSTIRJjlyy+IjAjwf40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085448; c=relaxed/simple;
	bh=zB3mn3TMR5uRvNxU/1HaMoDvAmBqxw1DqmLmXJ2EaQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3GKUHzmlG1rY+0msXdb8lGJR5sW6SQRb/Ma+gxoqsflGcNsb7gZQ1F7Y7MLGr6lDc6MP+ficclZ/nnUaO78Eu7BLyhkv3UNoJu7uSd6ez8mwd1dv8hC9t8SWY1IH0M/E/MV2TBGNPvfgpyt7rWm4ZNE13qehfENFSFNBXcbe1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeVQ9ma4; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-783ae53037fso15569785a.0;
        Wed, 24 Jan 2024 00:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706085445; x=1706690245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nJTVntF2VlItmD4v8LVNNH72RGP5v4kzuTD33v2nbSc=;
        b=VeVQ9ma4mNNGpNCIzeW85Syae+sDfpOJJ94RNv1FsMoJVciPVDutF77FHwyBlGmEez
         DXY9k9odYUmFW0unct8xWHdt7kdoL/lNTsc6jnS6RM8gcGpoJKhbKdkDPoxAigaaIX7k
         pQ9vslBXGdekLTwclrShlF4X8C2Qlrq44MG+zSZfPpjqN/gfQBCiD0XgrFaJtKq/1hIJ
         pOXAFb8Y2Jcvo9DKGwtlW6mEfbn/u4b6PSOZat0gb3VNXddm0bV1YhPex9MdBBOFsmp5
         ACfzkJYQIJi+RtAHCcgv06wrl0JFkYPtIibgUKrdod4mgulP2f6JkB0+7HhA/ar3da3l
         1ZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706085445; x=1706690245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nJTVntF2VlItmD4v8LVNNH72RGP5v4kzuTD33v2nbSc=;
        b=h62YxjLCRbl24scqSCGYLA+d5KiQBN/AInDTXGNe973Dkv/ymIUGJ9ovm1+KRyFMiw
         E2NdpxodTcTd0+yrI0GzNRn9XSOjhwRq6x8bmdTU7trTSgaqeBATSdHW/0dlg58MRqjs
         x8GK4vFJkY0V4IXHmwgyedf/NQKk4JKSnbi+69EVgPCBFSHguOkTJ1PCky1QB40zki2i
         vtUrS7KsIPNHAs5vkEGtozkT+fcQhOh8+wmrtkoyQ7OD0WYg7lXgoVEPNpQjSltLdBAg
         brAwKrSP/tKeRbRiVlKekeJQj4LQt5dX5ZosbAn7iFh5+DPnXWKsYbHmTuivnFe9wtuV
         rsfw==
X-Gm-Message-State: AOJu0YxWpWcHYQgmVgZbIyWxMLWMwvlJKHSaHAPJyJsVFz93c52Seqri
	9SDkLY/AQHsxV+VIUIydmCggZMRXtfD8/UrgBVheytD8VcWbjgOEvQTeU/+wFmO8DJzCFIXQGF4
	QKhVZNenCowt4oQw3ZBC49ONbLvM=
X-Google-Smtp-Source: AGHT+IHOsVVVHBUbByJUa6uWDyW/l6Jnfbte5Q9BHJAvgAGRo1oSN0AQ3jSjn2cGqQlFd6JL8nGuAapdFfJDYK8GeI8=
X-Received: by 2002:a05:6214:3008:b0:685:65ee:b06c with SMTP id
 ke8-20020a056214300800b0068565eeb06cmr1676490qvb.3.1706085444933; Wed, 24 Jan
 2024 00:37:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122221610.556746-1-maciej.fijalkowski@intel.com> <20240122221610.556746-5-maciej.fijalkowski@intel.com>
In-Reply-To: <20240122221610.556746-5-maciej.fijalkowski@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 24 Jan 2024 09:37:13 +0100
Message-ID: <CAJ8uoz2w3A7+aOAKWKjdATUgwQ8u10GHAtjodc_Nhp9FALE9KQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf 04/11] ice: work on pre-XDP prog frag count
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org, echaudro@redhat.com, lorenzo@kernel.org, 
	martin.lau@linux.dev, tirthendu.sarkar@intel.com, john.fastabend@gmail.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 23:16, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Fix an OOM panic in XDP_DRV mode when a XDP program shrinks a
> multi-buffer packet by 4k bytes and then redirects it to an AF_XDP
> socket.
>
> Since support for handling multi-buffer frames was added to XDP, usage
> of bpf_xdp_adjust_tail() helper within XDP program can free the page
> that given fragment occupies and in turn decrease the fragment count
> within skb_shared_info that is embedded in xdp_buff struct. In current
> ice driver codebase, it can become problematic when page recycling logic
> decides not to reuse the page. In such case, __page_frag_cache_drain()
> is used with ice_rx_buf::pagecnt_bias that was not adjusted after
> refcount of page was changed by XDP prog which in turn does not drain
> the refcount to 0 and page is never freed.
>
> To address this, let us store the count of frags before the XDP program
> was executed on Rx ring struct. This will be used to compare with
> current frag count from skb_shared_info embedded in xdp_buff. A smaller
> value in the latter indicates that XDP prog freed frag(s). Then, for
> given delta decrement pagecnt_bias for XDP_DROP verdict.
>
> While at it, let us also handle the EOP frag within
> ice_set_rx_bufs_act() to make our life easier, so all of the adjustments
> needed to be applied against freed frags are performed in the single
> place.
>
> Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c     | 14 ++++++---
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 31 +++++++++++++------
>  3 files changed, 32 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 59617f055e35..1760e81379cc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -603,9 +603,7 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
>                 ret = ICE_XDP_CONSUMED;
>         }
>  exit:
> -       rx_buf->act = ret;
> -       if (unlikely(xdp_buff_has_frags(xdp)))
> -               ice_set_rx_bufs_act(xdp, rx_ring, ret);
> +       ice_set_rx_bufs_act(xdp, rx_ring, ret);
>  }
>
>  /**
> @@ -893,14 +891,17 @@ ice_add_xdp_frag(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
>         }
>
>         if (unlikely(sinfo->nr_frags == MAX_SKB_FRAGS)) {
> -               if (unlikely(xdp_buff_has_frags(xdp)))
> -                       ice_set_rx_bufs_act(xdp, rx_ring, ICE_XDP_CONSUMED);
> +               ice_set_rx_bufs_act(xdp, rx_ring, ICE_XDP_CONSUMED);
>                 return -ENOMEM;
>         }
>
>         __skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++, rx_buf->page,
>                                    rx_buf->page_offset, size);
>         sinfo->xdp_frags_size += size;
> +       /* remember frag count before XDP prog execution; bpf_xdp_adjust_tail()
> +        * can pop off frags but driver has to handle it on its own
> +        */
> +       rx_ring->nr_frags = sinfo->nr_frags;
>
>         if (page_is_pfmemalloc(rx_buf->page))
>                 xdp_buff_set_frag_pfmemalloc(xdp);
> @@ -1251,6 +1252,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>
>                 xdp->data = NULL;
>                 rx_ring->first_desc = ntc;
> +               rx_ring->nr_frags = 0;
>                 continue;
>  construct_skb:
>                 if (likely(ice_ring_uses_build_skb(rx_ring)))
> @@ -1266,10 +1268,12 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>                                                     ICE_XDP_CONSUMED);
>                         xdp->data = NULL;
>                         rx_ring->first_desc = ntc;
> +                       rx_ring->nr_frags = 0;
>                         break;
>                 }
>                 xdp->data = NULL;
>                 rx_ring->first_desc = ntc;
> +               rx_ring->nr_frags = 0;

Are these needed? Or asked in another way, is there some way in which
ice_set_rx_bufs_act() can be executed before ice_add_xdp_frag()? If
not, we could remove them.

Looks good otherwise.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

>
>                 stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_RXE_S);
>                 if (unlikely(ice_test_staterr(rx_desc->wb.status_error0,
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
> index b3379ff73674..af955b0e5dc5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> @@ -358,6 +358,7 @@ struct ice_rx_ring {
>         struct ice_tx_ring *xdp_ring;
>         struct ice_rx_ring *next;       /* pointer to next ring in q_vector */
>         struct xsk_buff_pool *xsk_pool;
> +       u32 nr_frags;
>         dma_addr_t dma;                 /* physical address of ring */
>         u16 rx_buf_len;
>         u8 dcb_tc;                      /* Traffic class of ring */
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> index 762047508619..afcead4baef4 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> @@ -12,26 +12,39 @@
>   * act: action to store onto Rx buffers related to XDP buffer parts
>   *
>   * Set action that should be taken before putting Rx buffer from first frag
> - * to one before last. Last one is handled by caller of this function as it
> - * is the EOP frag that is currently being processed. This function is
> - * supposed to be called only when XDP buffer contains frags.
> + * to the last.
>   */
>  static inline void
>  ice_set_rx_bufs_act(struct xdp_buff *xdp, const struct ice_rx_ring *rx_ring,
>                     const unsigned int act)
>  {
> -       const struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> -       u32 first = rx_ring->first_desc;
> -       u32 nr_frags = sinfo->nr_frags;
> +       u32 sinfo_frags = xdp_get_shared_info_from_buff(xdp)->nr_frags;
> +       u32 nr_frags = rx_ring->nr_frags + 1;
> +       u32 idx = rx_ring->first_desc;
>         u32 cnt = rx_ring->count;
>         struct ice_rx_buf *buf;
>
>         for (int i = 0; i < nr_frags; i++) {
> -               buf = &rx_ring->rx_buf[first];
> +               buf = &rx_ring->rx_buf[idx];
>                 buf->act = act;
>
> -               if (++first == cnt)
> -                       first = 0;
> +               if (++idx == cnt)
> +                       idx = 0;
> +       }
> +
> +       /* adjust pagecnt_bias on frags freed by XDP prog */
> +       if (sinfo_frags < rx_ring->nr_frags && act == ICE_XDP_CONSUMED) {
> +               u32 delta = rx_ring->nr_frags - sinfo_frags;
> +
> +               while (delta) {
> +                       if (idx == 0)
> +                               idx = cnt - 1;
> +                       else
> +                               idx--;
> +                       buf = &rx_ring->rx_buf[idx];
> +                       buf->pagecnt_bias--;
> +                       delta--;
> +               }
>         }
>  }
>
> --
> 2.34.1
>
>

