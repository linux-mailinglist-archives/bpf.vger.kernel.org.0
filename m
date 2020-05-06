Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD2A1C7B5D
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 22:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgEFUew (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 16:34:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58471 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726627AbgEFUev (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 May 2020 16:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588797289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eBt21xotmA87CN5pxI4GbUVBNDAkGIKysoKBsGfMVZY=;
        b=EIkljIilRvBdD2BsDPFQIW+4pzuHec/6GmIiSOxlPzzVPmjy+LILqNdEsC43Q4LXDpv+V7
        oltS/CToZDL6hNkY+emiWNo4kNX81Cxw0Qbg54rPFgdSaKN35ihmNNCbE1LyGXUU2KC6Wz
        Dzwk0b4xaTpyvlY5y3Kzu1AkXZOo86s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-7PLKWEytNXmKBbKGBg_8AA-1; Wed, 06 May 2020 16:34:47 -0400
X-MC-Unique: 7PLKWEytNXmKBbKGBg_8AA-1
Received: by mail-wr1-f69.google.com with SMTP id f2so1936307wrm.9
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 13:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eBt21xotmA87CN5pxI4GbUVBNDAkGIKysoKBsGfMVZY=;
        b=qVQduut1vpDNkUskRct/HuDFaLYmTvuqVnweIhHxh5+QcCkyhzZC/V2tJrPCXngXw5
         IRJHGc4HnrOvNUx16yaz7rljKnOtwVDHvyAVIgqyCIndTgUe8EVydFAb7Pmr3Hi1C4s7
         jX923VXDGP6dCCqdJ/76AcnHsfdXNp1lanQzWsDylzNB+2EagveJd14jX8s7hYCDINiA
         dHVKYE568MHuzZE0xb09lh+6hOj8+3WL4mLrQ6ZR79r/IszqlMScTVRkmQtZjYmoTPhD
         9yYQ3sm7v+baWHGGqnPY7z+kpThTNiwdgXRSBC3L7ypan/4VsyKoj3FiniWV06MlDfVa
         smNw==
X-Gm-Message-State: AGi0PubUO7SoACfizlbnn3/Wc5e5GsK0UDvE5VPLgUdueh0tHsBszhvX
        DBvqhhDziislo/0xCNEGLNTQjDRvKK5v2YAFH7KLv73AUMlh8A06ZI2IqEGMixELTJzPePn9S58
        MUGuZMTmcDHVo
X-Received: by 2002:a5d:560c:: with SMTP id l12mr6959661wrv.309.1588797286691;
        Wed, 06 May 2020 13:34:46 -0700 (PDT)
X-Google-Smtp-Source: APiQypIx0CKuxgcCwEgOdhBxjP3ZoFYeyenRC8sTzIaPLUznlC1000CFpIJSDeH7XJFfRuz+Kerthw==
X-Received: by 2002:a5d:560c:: with SMTP id l12mr6959635wrv.309.1588797286475;
        Wed, 06 May 2020 13:34:46 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id c19sm4564603wrb.89.2020.05.06.13.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 13:34:45 -0700 (PDT)
Date:   Wed, 6 May 2020 16:34:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     sameehj@amazon.com, Jason Wang <jasowang@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org, zorik@amazon.com,
        akiyano@amazon.com, gtzalik@amazon.com,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        steffen.klassert@secunet.com
Subject: Re: [PATCH net-next v2 21/33] virtio_net: add XDP frame size in two
 code paths
Message-ID: <20200506163414-mutt-send-email-mst@kernel.org>
References: <158824557985.2172139.4173570969543904434.stgit@firesoul>
 <158824572816.2172139.1358700000273697123.stgit@firesoul>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158824572816.2172139.1358700000273697123.stgit@firesoul>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 30, 2020 at 01:22:08PM +0200, Jesper Dangaard Brouer wrote:
> The virtio_net driver is running inside the guest-OS. There are two
> XDP receive code-paths in virtio_net, namely receive_small() and
> receive_mergeable(). The receive_big() function does not support XDP.
> 
> In receive_small() the frame size is available in buflen. The buffer
> backing these frames are allocated in add_recvbuf_small() with same
> size, except for the headroom, but tailroom have reserved room for
> skb_shared_info. The headroom is encoded in ctx pointer as a value.
> 
> In receive_mergeable() the frame size is more dynamic. There are two
> basic cases: (1) buffer size is based on a exponentially weighted
> moving average (see DECLARE_EWMA) of packet length. Or (2) in case
> virtnet_get_headroom() have any headroom then buffer size is
> PAGE_SIZE. The ctx pointer is this time used for encoding two values;
> the buffer len "truesize" and headroom. In case (1) if the rx buffer
> size is underestimated, the packet will have been split over more
> buffers (num_buf info in virtio_net_hdr_mrg_rxbuf placed in top of
> buffer area). If that happens the XDP path does a xdp_linearize_page
> operation.
> 
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c |   15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 11f722460513..1df3676da185 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -689,6 +689,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  		xdp.data_end = xdp.data + len;
>  		xdp.data_meta = xdp.data;
>  		xdp.rxq = &rq->xdp_rxq;
> +		xdp.frame_sz = buflen;
>  		orig_data = xdp.data;
>  		act = bpf_prog_run_xdp(xdp_prog, &xdp);
>  		stats->xdp_packets++;
> @@ -797,10 +798,11 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  	int offset = buf - page_address(page);
>  	struct sk_buff *head_skb, *curr_skb;
>  	struct bpf_prog *xdp_prog;
> -	unsigned int truesize;
> +	unsigned int truesize = mergeable_ctx_to_truesize(ctx);
>  	unsigned int headroom = mergeable_ctx_to_headroom(ctx);
> -	int err;
>  	unsigned int metasize = 0;
> +	unsigned int frame_sz;
> +	int err;
>  
>  	head_skb = NULL;
>  	stats->bytes += len - vi->hdr_len;
> @@ -821,6 +823,11 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  		if (unlikely(hdr->hdr.gso_type))
>  			goto err_xdp;
>  
> +		/* Buffers with headroom use PAGE_SIZE as alloc size,
> +		 * see add_recvbuf_mergeable() + get_mergeable_buf_len()
> +		 */
> +		frame_sz = headroom ? PAGE_SIZE : truesize;
> +
>  		/* This happens when rx buffer size is underestimated
>  		 * or headroom is not enough because of the buffer
>  		 * was refilled before XDP is set. This should only
> @@ -834,6 +841,8 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  						      page, offset,
>  						      VIRTIO_XDP_HEADROOM,
>  						      &len);
> +			frame_sz = PAGE_SIZE;
> +
>  			if (!xdp_page)
>  				goto err_xdp;
>  			offset = VIRTIO_XDP_HEADROOM;
> @@ -850,6 +859,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  		xdp.data_end = xdp.data + (len - vi->hdr_len);
>  		xdp.data_meta = xdp.data;
>  		xdp.rxq = &rq->xdp_rxq;
> +		xdp.frame_sz = frame_sz;
>  
>  		act = bpf_prog_run_xdp(xdp_prog, &xdp);
>  		stats->xdp_packets++;
> @@ -924,7 +934,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  	}
>  	rcu_read_unlock();
>  
> -	truesize = mergeable_ctx_to_truesize(ctx);
>  	if (unlikely(len > truesize)) {
>  		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
>  			 dev->name, len, (unsigned long)ctx);
> 
> 

