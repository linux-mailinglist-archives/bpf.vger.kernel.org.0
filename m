Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D974F3519F5
	for <lists+bpf@lfdr.de>; Thu,  1 Apr 2021 20:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbhDAR5P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 13:57:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44794 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235717AbhDARxU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 1 Apr 2021 13:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617299599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/WIH82Frtp5hCmNsUyVlrmv/kUHMvfnWwTMXrVesmnI=;
        b=bvC+wQycqarvAAbme1LNVMeR86khgg9TvSATgwoufrBa9uqMADrQAQ5lTOFhesopp8F3T2
        ELvAxyM3Fd46q1lsGTw1PSaf3uanAhsa0AdZNQUzDxo1GYoOSN7iAbhX39I6BI3Gu21kBD
        YpaQaUWWh/Oh9ycSTVxE1yl3lHcAzBw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-u3GriAWXNBiAJIuKZ9FwzQ-1; Thu, 01 Apr 2021 07:26:06 -0400
X-MC-Unique: u3GriAWXNBiAJIuKZ9FwzQ-1
Received: by mail-ej1-f72.google.com with SMTP id bg7so2091007ejb.12
        for <bpf@vger.kernel.org>; Thu, 01 Apr 2021 04:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/WIH82Frtp5hCmNsUyVlrmv/kUHMvfnWwTMXrVesmnI=;
        b=cIVrINaiUsOu0N24ThPPbqazddP/TEzbnAD3P6cn+5+OBrELf8nftDAMkuvz0YiQv2
         H4kjqho39VSl/+GBNzxmjMoVA6yASTgQi1EXDRGvsKkVGwb7fSEP326gW7aVJgZe7bMY
         tERVYZuRHPICTfIP4vpyzGpGaShTRYsK/cwLQlgj1ooN/dXhJvtzt9lRgQAj8w8T7Tgi
         Omt/ZK6aMng2B/unUSlkz9nGRo7CNjvRo5Ea7Y5Rhoob9/LnhJKN8vC8jSbUQ8DF2ZSk
         XHyMuWH1WIRy9tlfVcRu34ksXKAetqNimb/vTMZTR4TI//P/9E2F+E4GkJQixHOvHNbj
         Aq8w==
X-Gm-Message-State: AOAM530kBdwTnSF0u6cKjNuxE6yrnzPCvd6dQhgiILwXFowEeFayA9KB
        wxbXOqK0v9Hg9y1jsJQp9P3aw/clgX1TJeE2wM2K558JVYmHb2T35Z6KvT9mp3FRVi7v+hVQ/lu
        +0KiWsLnnUXD3
X-Received: by 2002:a50:d84e:: with SMTP id v14mr9460080edj.357.1617276364216;
        Thu, 01 Apr 2021 04:26:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2rCngM/PVbWCboVHBsUhhEP8Qp74/oRMuVXooCLZkwBOa9KWC2E/+GYh7k2cS+edI/N86oQ==
X-Received: by 2002:a50:d84e:: with SMTP id v14mr9460055edj.357.1617276364050;
        Thu, 01 Apr 2021 04:26:04 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id q10sm3329547eds.67.2021.04.01.04.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 04:26:03 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C4587180290; Thu,  1 Apr 2021 13:26:02 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Vladimir Oltean <olteanv@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next 9/9] net: enetc: add support for XDP_REDIRECT
In-Reply-To: <20210331200857.3274425-10-olteanv@gmail.com>
References: <20210331200857.3274425-1-olteanv@gmail.com>
 <20210331200857.3274425-10-olteanv@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 01 Apr 2021 13:26:02 +0200
Message-ID: <87blaynt4l.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Vladimir Oltean <olteanv@gmail.com> writes:

> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>
> The driver implementation of the XDP_REDIRECT action reuses parts from
> XDP_TX, most notably the enetc_xdp_tx function which transmits an array
> of TX software BDs. Only this time, the buffers don't have DMA mappings,
> we need to create them.
>
> When a BPF program reaches the XDP_REDIRECT verdict for a frame, we can
> employ the same buffer reuse strategy as for the normal processing path
> and for XDP_PASS: we can flip to the other page half and seed that to
> the RX ring.
>
> Note that scatter/gather support is there, but disabled due to lack of
> multi-buffer support in XDP (which is added by this series):
> https://patchwork.kernel.org/project/netdevbpf/cover/cover.1616179034.git.lorenzo@kernel.org/
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c  | 212 +++++++++++++++++-
>  drivers/net/ethernet/freescale/enetc/enetc.h  |  11 +-
>  .../ethernet/freescale/enetc/enetc_ethtool.c  |   6 +
>  .../net/ethernet/freescale/enetc/enetc_pf.c   |   1 +
>  4 files changed, 218 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index ba5313a5d7a4..57049ae97201 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -8,6 +8,23 @@
>  #include <linux/vmalloc.h>
>  #include <net/pkt_sched.h>
>  
> +static struct sk_buff *enetc_tx_swbd_get_skb(struct enetc_tx_swbd *tx_swbd)
> +{
> +	if (tx_swbd->is_xdp_tx || tx_swbd->is_xdp_redirect)
> +		return NULL;
> +
> +	return tx_swbd->skb;
> +}
> +
> +static struct xdp_frame *
> +enetc_tx_swbd_get_xdp_frame(struct enetc_tx_swbd *tx_swbd)
> +{
> +	if (tx_swbd->is_xdp_redirect)
> +		return tx_swbd->xdp_frame;
> +
> +	return NULL;
> +}
> +
>  static void enetc_unmap_tx_buff(struct enetc_bdr *tx_ring,
>  				struct enetc_tx_swbd *tx_swbd)
>  {
> @@ -25,14 +42,20 @@ static void enetc_unmap_tx_buff(struct enetc_bdr *tx_ring,
>  	tx_swbd->dma = 0;
>  }
>  
> -static void enetc_free_tx_skb(struct enetc_bdr *tx_ring,
> -			      struct enetc_tx_swbd *tx_swbd)
> +static void enetc_free_tx_frame(struct enetc_bdr *tx_ring,
> +				struct enetc_tx_swbd *tx_swbd)
>  {
> +	struct xdp_frame *xdp_frame = enetc_tx_swbd_get_xdp_frame(tx_swbd);
> +	struct sk_buff *skb = enetc_tx_swbd_get_skb(tx_swbd);
> +
>  	if (tx_swbd->dma)
>  		enetc_unmap_tx_buff(tx_ring, tx_swbd);
>  
> -	if (tx_swbd->skb) {
> -		dev_kfree_skb_any(tx_swbd->skb);
> +	if (xdp_frame) {
> +		xdp_return_frame(tx_swbd->xdp_frame);
> +		tx_swbd->xdp_frame = NULL;
> +	} else if (skb) {
> +		dev_kfree_skb_any(skb);
>  		tx_swbd->skb = NULL;
>  	}
>  }
> @@ -183,7 +206,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb,
>  
>  	do {
>  		tx_swbd = &tx_ring->tx_swbd[i];
> -		enetc_free_tx_skb(tx_ring, tx_swbd);
> +		enetc_free_tx_frame(tx_ring, tx_swbd);
>  		if (i == 0)
>  			i = tx_ring->bd_count;
>  		i--;
> @@ -381,6 +404,9 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
>  	do_tstamp = false;
>  
>  	while (bds_to_clean && tx_frm_cnt < ENETC_DEFAULT_TX_WORK) {
> +		struct xdp_frame *xdp_frame = enetc_tx_swbd_get_xdp_frame(tx_swbd);
> +		struct sk_buff *skb = enetc_tx_swbd_get_skb(tx_swbd);
> +
>  		if (unlikely(tx_swbd->check_wb)) {
>  			struct enetc_ndev_priv *priv = netdev_priv(ndev);
>  			union enetc_tx_bd *txbd;
> @@ -400,12 +426,15 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
>  		else if (likely(tx_swbd->dma))
>  			enetc_unmap_tx_buff(tx_ring, tx_swbd);
>  
> -		if (tx_swbd->skb) {
> +		if (xdp_frame) {
> +			xdp_return_frame(xdp_frame);
> +			tx_swbd->xdp_frame = NULL;
> +		} else if (skb) {
>  			if (unlikely(do_tstamp)) {
> -				enetc_tstamp_tx(tx_swbd->skb, tstamp);
> +				enetc_tstamp_tx(skb, tstamp);
>  				do_tstamp = false;
>  			}
> -			napi_consume_skb(tx_swbd->skb, napi_budget);
> +			napi_consume_skb(skb, napi_budget);
>  			tx_swbd->skb = NULL;
>  		}
>  
> @@ -827,6 +856,109 @@ static bool enetc_xdp_tx(struct enetc_bdr *tx_ring,
>  	return true;
>  }
>  
> +static int enetc_xdp_frame_to_xdp_tx_swbd(struct enetc_bdr *tx_ring,
> +					  struct enetc_tx_swbd *xdp_tx_arr,
> +					  struct xdp_frame *xdp_frame)
> +{
> +	struct enetc_tx_swbd *xdp_tx_swbd = &xdp_tx_arr[0];
> +	struct skb_shared_info *shinfo;
> +	void *data = xdp_frame->data;
> +	int len = xdp_frame->len;
> +	skb_frag_t *frag;
> +	dma_addr_t dma;
> +	unsigned int f;
> +	int n = 0;
> +
> +	dma = dma_map_single(tx_ring->dev, data, len, DMA_TO_DEVICE);
> +	if (unlikely(dma_mapping_error(tx_ring->dev, dma))) {
> +		netdev_err(tx_ring->ndev, "DMA map error\n");
> +		return -1;
> +	}
> +
> +	xdp_tx_swbd->dma = dma;
> +	xdp_tx_swbd->dir = DMA_TO_DEVICE;
> +	xdp_tx_swbd->len = len;
> +	xdp_tx_swbd->is_xdp_redirect = true;
> +	xdp_tx_swbd->is_eof = false;
> +	xdp_tx_swbd->xdp_frame = NULL;
> +
> +	n++;
> +	xdp_tx_swbd = &xdp_tx_arr[n];
> +
> +	shinfo = xdp_get_shared_info_from_frame(xdp_frame);
> +
> +	for (f = 0, frag = &shinfo->frags[0]; f < shinfo->nr_frags;
> +	     f++, frag++) {
> +		data = skb_frag_address(frag);
> +		len = skb_frag_size(frag);
> +
> +		dma = dma_map_single(tx_ring->dev, data, len, DMA_TO_DEVICE);
> +		if (unlikely(dma_mapping_error(tx_ring->dev, dma))) {
> +			/* Undo the DMA mapping for all fragments */
> +			while (n-- >= 0)
> +				enetc_unmap_tx_buff(tx_ring, &xdp_tx_arr[n]);
> +
> +			netdev_err(tx_ring->ndev, "DMA map error\n");
> +			return -1;
> +		}
> +
> +		xdp_tx_swbd->dma = dma;
> +		xdp_tx_swbd->dir = DMA_TO_DEVICE;
> +		xdp_tx_swbd->len = len;
> +		xdp_tx_swbd->is_xdp_redirect = true;
> +		xdp_tx_swbd->is_eof = false;
> +		xdp_tx_swbd->xdp_frame = NULL;
> +
> +		n++;
> +		xdp_tx_swbd = &xdp_tx_arr[n];
> +	}
> +
> +	xdp_tx_arr[n - 1].is_eof = true;
> +	xdp_tx_arr[n - 1].xdp_frame = xdp_frame;
> +
> +	return n;
> +}
> +
> +int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
> +		   struct xdp_frame **frames, u32 flags)
> +{
> +	struct enetc_tx_swbd xdp_redirect_arr[ENETC_MAX_SKB_FRAGS] = {0};
> +	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> +	struct enetc_bdr *tx_ring;
> +	int xdp_tx_bd_cnt, i, k;
> +	int xdp_tx_frm_cnt = 0;
> +
> +	tx_ring = priv->tx_ring[smp_processor_id()];

What mechanism guarantees that this won't overflow the array? :)

-Toke

