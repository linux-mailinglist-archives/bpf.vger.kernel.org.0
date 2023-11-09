Return-Path: <bpf+bounces-14559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C879D7E64FA
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 09:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0B32810DB
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 08:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16218107B4;
	Thu,  9 Nov 2023 08:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ApAn+4eB"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F45107A6
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 08:12:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE642D50
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 00:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699517560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3TtQkLzXAXLHc3UJQsu7PPbU+hHtju2TNGzcG1eMX/E=;
	b=ApAn+4eB9A4meWYliDAMPh40MvFfriWvWBH8OK6Od/tJKQXrFTZwufBQDhEofnc0W1BMzU
	6awVmA4K2AUG/fIgQcR9QEwqf6TOhBxj87Xq+EQPMLOuzAvUeQvPb7ZFz83z6bUcRCusJK
	+Ruc5il4w/WYmICyls1l6UDa8353/JY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-sUKP3oihPR2d82sazpJUrw-1; Thu, 09 Nov 2023 03:12:34 -0500
X-MC-Unique: sUKP3oihPR2d82sazpJUrw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9ddae43f3f7so45854566b.3
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 00:12:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699517553; x=1700122353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TtQkLzXAXLHc3UJQsu7PPbU+hHtju2TNGzcG1eMX/E=;
        b=ad3EyZ5e2w2WzC2WWNZGpcLCvS1b1r56PfF6VFuCbow1pvwDkdwyA0HXLDyOco9wAD
         8kP9kZTaDoXIGSDCYz+3ObJNY+LVv3MCknueecmzy4ZERHBn3o53AfBgqt0802UcaezL
         JO4BSzLqVvPhitKEzSKd0/Lqbz22SAmT+yx+lYJhmjZJH2FowbUyBDqd+m9iM8rMMlQQ
         w69HhdYG9bFtnBLiQg7w+6ra1ljQExt35WfNGFE7A5HdqNvu++StqmHkE6qwnh9vjlZv
         Uiq8UEe4+aycqgG0IECna00fVE4clVMu0NMYx1irN2t5EPNPaHTyxhEV/CTPIVDv5kBA
         kvHg==
X-Gm-Message-State: AOJu0YzId+YEoUmOyaJsdBUHZQcJ6sJamq7LP/7nsRgD4v/QyXZmonpK
	e7q0qEDHOSJlsTNaMOhCj9roJTPglh2I/Ooip6Qd7wRrkHtMPbO86mBDis7PwiG63FUckUAaSvp
	JDxtfN2y2yHT7
X-Received: by 2002:a17:907:96a0:b0:9dd:8603:ce with SMTP id hd32-20020a17090796a000b009dd860300cemr4051049ejc.9.1699517553100;
        Thu, 09 Nov 2023 00:12:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWo6Llt8v+2ywmjkukcaaZqqnfwiyYvDgAr2DUpk6IKjaTUAoQ/imwHduk+oI2LokR5fTx9w==
X-Received: by 2002:a17:907:96a0:b0:9dd:8603:ce with SMTP id hd32-20020a17090796a000b009dd860300cemr4051023ejc.9.1699517552743;
        Thu, 09 Nov 2023 00:12:32 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f4:2044:be5a:328c:4b98:1420])
        by smtp.gmail.com with ESMTPSA id t6-20020a170906064600b00997e00e78e6sm2210800ejb.112.2023.11.09.00.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 00:12:32 -0800 (PST)
Date: Thu, 9 Nov 2023 03:12:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 16/21] virtio_net: xsk: rx: introduce
 add_recvbuf_xsk()
Message-ID: <20231109031003-mutt-send-email-mst@kernel.org>
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
 <20231107031227.100015-17-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107031227.100015-17-xuanzhuo@linux.alibaba.com>

On Tue, Nov 07, 2023 at 11:12:22AM +0800, Xuan Zhuo wrote:
> Implement the logic of filling rq with XSK buffers.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c       |  4 ++-
>  drivers/net/virtio/virtio_net.h |  5 ++++
>  drivers/net/virtio/xsk.c        | 49 ++++++++++++++++++++++++++++++++-
>  drivers/net/virtio/xsk.h        |  2 ++
>  4 files changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index 6210a6e37396..15943a22e17d 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -1798,7 +1798,9 @@ static bool try_fill_recv(struct virtnet_info *vi, struct virtnet_rq *rq,
>  	bool oom;
>  
>  	do {
> -		if (vi->mergeable_rx_bufs)
> +		if (rq->xsk.pool)
> +			err = virtnet_add_recvbuf_xsk(vi, rq, rq->xsk.pool, gfp);
> +		else if (vi->mergeable_rx_bufs)
>  			err = add_recvbuf_mergeable(vi, rq, gfp);
>  		else if (vi->big_packets)
>  			err = add_recvbuf_big(vi, rq, gfp);

I'm not sure I understand. How does this handle mergeable flag still being set?


> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
> index a13d6d301fdb..1242785e311e 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -140,6 +140,11 @@ struct virtnet_rq {
>  
>  		/* xdp rxq used by xsk */
>  		struct xdp_rxq_info xdp_rxq;
> +
> +		struct xdp_buff **xsk_buffs;
> +		u32 nxt_idx;
> +		u32 num;
> +		u32 size;
>  	} xsk;
>  };
>  
> diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> index ea5804ddd44e..e737c3353212 100644
> --- a/drivers/net/virtio/xsk.c
> +++ b/drivers/net/virtio/xsk.c
> @@ -38,6 +38,41 @@ static void virtnet_xsk_check_queue(struct virtnet_sq *sq)
>  		netif_stop_subqueue(dev, qnum);
>  }
>  
> +int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct virtnet_rq *rq,
> +			    struct xsk_buff_pool *pool, gfp_t gfp)
> +{
> +	struct xdp_buff **xsk_buffs;
> +	dma_addr_t addr;
> +	u32 len, i;
> +	int err = 0;
> +
> +	xsk_buffs = rq->xsk.xsk_buffs;
> +
> +	if (rq->xsk.nxt_idx >= rq->xsk.num) {
> +		rq->xsk.num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->xsk.size);
> +		if (!rq->xsk.num)
> +			return -ENOMEM;
> +		rq->xsk.nxt_idx = 0;
> +	}

Another manually rolled linked list implementation.
Please, don't.


> +
> +	i = rq->xsk.nxt_idx;
> +
> +	/* use the part of XDP_PACKET_HEADROOM as the virtnet hdr space */
> +	addr = xsk_buff_xdp_get_dma(xsk_buffs[i]) - vi->hdr_len;
> +	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> +
> +	sg_init_table(rq->sg, 1);
> +	sg_fill_dma(rq->sg, addr, len);
> +
> +	err = virtqueue_add_inbuf(rq->vq, rq->sg, 1, xsk_buffs[i], gfp);
> +	if (err)
> +		return err;
> +
> +	rq->xsk.nxt_idx++;
> +
> +	return 0;
> +}
> +
>  static int virtnet_xsk_xmit_one(struct virtnet_sq *sq,
>  				struct xsk_buff_pool *pool,
>  				struct xdp_desc *desc)
> @@ -213,7 +248,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
>  	struct virtnet_sq *sq;
>  	struct device *dma_dev;
>  	dma_addr_t hdr_dma;
> -	int err;
> +	int err, size;
>  
>  	/* In big_packets mode, xdp cannot work, so there is no need to
>  	 * initialize xsk of rq.
> @@ -249,6 +284,16 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
>  	if (!dma_dev)
>  		return -EPERM;
>  
> +	size = virtqueue_get_vring_size(rq->vq);
> +
> +	rq->xsk.xsk_buffs = kcalloc(size, sizeof(*rq->xsk.xsk_buffs), GFP_KERNEL);
> +	if (!rq->xsk.xsk_buffs)
> +		return -ENOMEM;
> +
> +	rq->xsk.size = size;
> +	rq->xsk.nxt_idx = 0;
> +	rq->xsk.num = 0;
> +
>  	hdr_dma = dma_map_single(dma_dev, &xsk_hdr, vi->hdr_len, DMA_TO_DEVICE);
>  	if (dma_mapping_error(dma_dev, hdr_dma))
>  		return -ENOMEM;
> @@ -307,6 +352,8 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
>  
>  	dma_unmap_single(dma_dev, sq->xsk.hdr_dma_address, vi->hdr_len, DMA_TO_DEVICE);
>  
> +	kfree(rq->xsk.xsk_buffs);
> +
>  	return err1 | err2;
>  }
>  
> diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
> index 7ebc9bda7aee..bef41a3f954e 100644
> --- a/drivers/net/virtio/xsk.h
> +++ b/drivers/net/virtio/xsk.h
> @@ -23,4 +23,6 @@ int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
>  bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
>  		      int budget);
>  int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag);
> +int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct virtnet_rq *rq,
> +			    struct xsk_buff_pool *pool, gfp_t gfp);
>  #endif
> -- 
> 2.32.0.3.g01195cf9f


