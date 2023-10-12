Return-Path: <bpf+bounces-12018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 086787C693C
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 11:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62CC8282855
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 09:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D25B210F5;
	Thu, 12 Oct 2023 09:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JO6OBjir"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C14D20B39
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 09:16:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26B4C9
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 02:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697102160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4eIreTvOrPbXoRX8kLZoDSLvSMGfzMrvC2GtND0F9cA=;
	b=JO6OBjirKgE01i4QRjZSGCzXzSNldDULo78ebFADgkBNKWz1BKqEAldhBZtltSdrs7ctI/
	hirJfSc50pov58sLBIqkYBMutt/7xPBoiwKa2DFSqfStAXdkaWrrnzHo4Y6jpI/eqCYXI1
	95mGukBCZQi6/iE7TTrfwWEVe/vt68Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-dUHb0d1zMSmas3I52mwgNw-1; Thu, 12 Oct 2023 05:15:58 -0400
X-MC-Unique: dUHb0d1zMSmas3I52mwgNw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32d33e3aea5so561904f8f.0
        for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 02:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697102157; x=1697706957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eIreTvOrPbXoRX8kLZoDSLvSMGfzMrvC2GtND0F9cA=;
        b=nfEti53ZccIjYvMalgnDl9YmaYtO6+BBtWxL6D2eSomel8XfpxB3eM7tiGF0suaalO
         bvra0BoCYAhmvBpYp+FwsinlT6yPWjdnYw3J2R1vwOWWXwRd2mGOrrfnzSgixbpNfboN
         V0tzLbvF+fxJi1vXESsfsAmBKkl5zDWeftC9uJO5jjgmbAxrczRPuQjiQS0wQaTgPvHw
         jVKcK0a1UCQJGfBmomKtz1slTFwvAxC08hIVQ6TzfeturOlwOx6iD1+GIlg5hSEeplvh
         3qXamPQmJ7wQY9sVKCRSS9FCLNNilQNU5nunTOHKBcgGcWtYAbwn4TOGxH02c9OjHawC
         o4Nw==
X-Gm-Message-State: AOJu0Yw0BSbL+ndGko202c52HloL+3/fzFHDXeVsbBqMyR/R1+RLykL6
	S3T3mHago74Zk+98ZvqqFHqyC6KeYsW1lZwGEcqHFZ8vZgNVbUMdat6ONg9eKZpjtlozp1v3Jbo
	ZhhpL71qXEvkt
X-Received: by 2002:a05:6000:790:b0:32c:af13:9084 with SMTP id bu16-20020a056000079000b0032caf139084mr5909598wrb.22.1697102157221;
        Thu, 12 Oct 2023 02:15:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7rlxuZwEbkVYUGkhTv9pQBj6vyLGx+IlgJ2DB/HwhEWz42oWGHfUHsA+i3qGbwFoJtnbzXA==
X-Received: by 2002:a05:6000:790:b0:32c:af13:9084 with SMTP id bu16-20020a056000079000b0032caf139084mr5909588wrb.22.1697102156824;
        Thu, 12 Oct 2023 02:15:56 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
        by smtp.gmail.com with ESMTPSA id z19-20020a7bc7d3000000b0040641a9d49bsm18663377wmk.17.2023.10.12.02.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 02:15:56 -0700 (PDT)
Date: Thu, 12 Oct 2023 05:15:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH vhost 01/22] virtio_ring: virtqueue_set_dma_premapped
 support disable
Message-ID: <20231012051416-mutt-send-email-mst@kernel.org>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011092728.105904-2-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 05:27:07PM +0800, Xuan Zhuo wrote:
> virtqueue_set_dma_premapped() adds a new parameter to disable the
> virtqueue premapped mode.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c     |  2 +-
>  drivers/virtio/virtio_ring.c | 11 ++++++++---
>  include/linux/virtio.h       |  2 +-
>  3 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index fe7f314d65c9..6b5f47ebf9b2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -737,7 +737,7 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
>  		return;
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> +		if (virtqueue_set_dma_premapped(vi->rq[i].vq, true))
>  			continue;
>  
>  		vi->rq[i].do_dma = true;
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 51d8f3299c10..b3ded56722f4 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2784,7 +2784,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
>   * 0: success.
>   * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
>   */
> -int virtqueue_set_dma_premapped(struct virtqueue *_vq)
> +int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool mode)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  	u32 num;
> @@ -2803,8 +2803,13 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
>  		return -EINVAL;
>  	}
>  
> -	vq->premapped = true;
> -	vq->do_unmap = false;
> +	if (mode) {
> +		vq->premapped = true;
> +		vq->do_unmap = false;
> +	} else {
> +		vq->premapped = false;
> +		vq->do_unmap = vq->use_dma_api;
> +	}
>  
>  	END_USE(vq);
>  
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 4cc614a38376..1cf7b004348b 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -81,7 +81,7 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
>  
>  unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
>  
> -int virtqueue_set_dma_premapped(struct virtqueue *_vq);
> +int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool mode);
>  
>  bool virtqueue_poll(struct virtqueue *vq, unsigned);

Wait a sec I thought we never change premapped. If you make this
dynamic don't you need a bunch of locking?
Or maybe queue is empty when you change this?
If yes pls add a bunch of BUG_ON checks to make sure this is not misused.


> -- 
> 2.32.0.3.g01195cf9f


