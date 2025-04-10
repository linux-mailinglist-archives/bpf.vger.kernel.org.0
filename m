Return-Path: <bpf+bounces-55637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ECCA83BEA
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 09:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8116D1B63C87
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 07:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDEE1E5B99;
	Thu, 10 Apr 2025 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XjNCyKh1"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F611B85F8
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744271944; cv=none; b=pd05DzUn6ZtwjxnEqyIpgUVhJ9PTU4FIx4X6iFrSJNtC+DrMQ9mO32IwhBdDINAfhAjAol7kneROFM25YjxRkVSBGr2B5HH59GeQv3hy9bF7kihucUPY1xT6gtwKM1nY4jWcH6xNGGhOumPZSRagv0wxO841xfCyJISPakObw28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744271944; c=relaxed/simple;
	bh=gm/a2mEQKsN6DHvodWcdGivkC33nKt6oCoSGpfBdg28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/M5dqxy9ghPLk7+TAIkd7kvUbvPBZPOwLoWmtzPPERv7o0MywoCXBbi2WgQblfRuPoGdnC7jWs0BJVq8gceHALGzB3vKeoKQ/I+wsgGe2DT1T0qegVNKMf5Pgd0yJ6s9iYDGMAwA00ZzCbaoYZROiQVZj+fBLObFQg70bstP3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XjNCyKh1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744271941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tQtoQw7jfUyWu+wsTQSZ7ijVwSrcSMWb6QJOSJ3s0/4=;
	b=XjNCyKh13IKzFcCKmRyeJzHydXGwU2WvmuxA0n98L60xbUABPRgsCl/JeCmtx6lHr9JupI
	wMWzx4U4eGJDCf80wtOrhLAFrA27GsZmRc2ijfV3OUBHUCAnoYBqkkAgTiyzBT6LO6CKKc
	P0RuJWg7TxbfRnL7/1kDRh+JFlzhD7g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257--uD6PYSwPIu7RoyNw1Gosw-1; Thu, 10 Apr 2025 03:58:59 -0400
X-MC-Unique: -uD6PYSwPIu7RoyNw1Gosw-1
X-Mimecast-MFC-AGG-ID: -uD6PYSwPIu7RoyNw1Gosw_1744271938
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43efa869b0aso4301425e9.3
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 00:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744271938; x=1744876738;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQtoQw7jfUyWu+wsTQSZ7ijVwSrcSMWb6QJOSJ3s0/4=;
        b=WhoGQrU9hrPgUssyGvDNUtzpF9ZQhE6EZe1fpVsnfYNw/ApETCSSdPtrqtSN+oKdi1
         /21qRQ+R3xqiswfxynpNEh9tqKP2wCS8sk7bjCH2iTurAMgfv3myz9mQXTH8lWyUuGRf
         KkJPZkdGHJi4+kLGS0u1LHOkVkS1Pgwx7UgO25CEJYIhHNdnj8zEbDOqJ9YecJxrbCyN
         5og+e1oqRa7raERsfA7WPn2g6EL4mPiwL6hQvvmkq/SBFpp1WbvMC16AE0voHyMJtsGZ
         I5WDAICSAJBdMrhqgVmz2anWPwhQU6+nVEVu5d7/PZdm4DTdA65nbp70/6ps/2nuiecM
         +Yxw==
X-Forwarded-Encrypted: i=1; AJvYcCXBIWWHtThxRHHkfcpXVHQSlxfpD7M5YmaBYaFeYncaAiT7qyfGqmCCN6dN3vaLR9iZDW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8lf+TJlcjeCNH0rvY6ODgUuBDcK4o7hQm6AqWlLjo24aK42yJ
	iVUvDHaINdyiFnwErs4l3rk4YBa0bgQs5jOUgfahB+7rqUtN8fAOnUWclOjYNNrCVTvOXe+EDSW
	Fg+PGf9zSRLceX+60/IxDnCHittYCzcDtfWVGmVxfG9eO5ADriQ==
X-Gm-Gg: ASbGncsBywPa7MWs58QZ4IhWexiNrIhCHRvrY23mx/t43dmU9ti926MzqFHcj0e9BEl
	4LiLL4s3a3c0AbegqHeNKhbNISH7a7E6YuBuwutw8ZLY8CfaqJXSJCVLYPK0GVJXoQX8c9RJxWU
	dlXpBhmm0mIzQskfs0ZQNgbaZ3U2f17MEfEZZ6gSQO7PQsDRMdwhn6EU0vz8pq/ur+VHuGBvbWf
	sq6CQAZ1TjZDOiNLsNinZJ4A3EfpJ7A53eEFZzWqfrXEXE79smOXdKIqxmFFo4cSgZfLCt3XZW7
	/xFqcQ==
X-Received: by 2002:a05:600c:c0e:b0:43d:aed:f7d0 with SMTP id 5b1f17b1804b1-43f2ffa04ccmr10843525e9.28.1744271938406;
        Thu, 10 Apr 2025 00:58:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnSNBEpGfHLNho/6PLwuLbgIXtPDmPI4Z7XkP6MyCZknh4+7smqJ4ID7o9X7MgjDoqER9qwA==
X-Received: by 2002:a05:600c:c0e:b0:43d:aed:f7d0 with SMTP id 5b1f17b1804b1-43f2ffa04ccmr10843325e9.28.1744271938017;
        Thu, 10 Apr 2025 00:58:58 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233a273fsm41808445e9.9.2025.04.10.00.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 00:58:57 -0700 (PDT)
Date: Thu, 10 Apr 2025 03:58:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] virtio-net: hold netdev_lock when pausing rx
Message-ID: <20250410035158-mutt-send-email-mst@kernel.org>
References: <20250404093903.37416-1-minhquangbui99@gmail.com>
 <1743987836.9938157-1-xuanzhuo@linux.alibaba.com>
 <30419bd6-13b1-4426-9f93-b38b66ef7c3a@gmail.com>
 <CACGkMEs7O7D5sztwJVn45c+1pap20Oi5f=02Sy_qxFjbeHuYiQ@mail.gmail.com>
 <4195db62-db43-4d61-88c3-7a7fbb164726@gmail.com>
 <b7b1f5de-7003-4960-a9d1-883bf2f1aa77@gmail.com>
 <4d3a1478-b6fc-47a3-8d77-7eca6a973a06@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d3a1478-b6fc-47a3-8d77-7eca6a973a06@gmail.com>

On Thu, Apr 10, 2025 at 02:05:57PM +0700, Bui Quang Minh wrote:
> When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
> napi_disable() on the receive queue's napi. In delayed refill_work, it
> also calls napi_disable() on the receive queue's napi. When
> napi_disable() is called on an already disabled napi, it will sleep in
> napi_disable_locked while still holding the netdev_lock. As a result,
> later napi_enable gets stuck too as it cannot acquire the netdev_lock.
> This leads to refill_work and the pause-then-resume tx are stuck
> altogether.
> 
> This scenario can be reproducible by binding a XDP socket to virtio-net
> interface without setting up the fill ring. As a result, try_fill_recv
> will fail until the fill ring is set up and refill_work is scheduled.
> 
> This commit makes the pausing rx path hold the netdev_lock until
> resuming, prevent any napi_disable() to be called on a temporarily
> disabled napi.
> 
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 74 +++++++++++++++++++++++++---------------
>  1 file changed, 47 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7e4617216a4b..74bd1065c586 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2786,9 +2786,13 @@ static void skb_recv_done(struct virtqueue *rvq)
>  }
> 
>  static void virtnet_napi_do_enable(struct virtqueue *vq,
> -                   struct napi_struct *napi)
> +                   struct napi_struct *napi,
> +                   bool netdev_locked)
>  {
> -    napi_enable(napi);
> +    if (netdev_locked)
> +        napi_enable_locked(napi);
> +    else
> +        napi_enable(napi);
> 
>      /* If all buffers were filled by other side before we napi_enabled, we
>       * won't get another interrupt, so process any outstanding packets now.
> @@ -2799,16 +2803,16 @@ static void virtnet_napi_do_enable(struct virtqueue
> *vq,




Your patch is line-wrapped, unfortunately. Here and elsewhere.




>      local_bh_enable();
>  }
> 
> -static void virtnet_napi_enable(struct receive_queue *rq)
> +static void virtnet_napi_enable(struct receive_queue *rq, bool
> netdev_locked)
>  {
>      struct virtnet_info *vi = rq->vq->vdev->priv;
>      int qidx = vq2rxq(rq->vq);
> 
> -    virtnet_napi_do_enable(rq->vq, &rq->napi);
> +    virtnet_napi_do_enable(rq->vq, &rq->napi, netdev_locked);
>      netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_RX, &rq->napi);
>  }
> 
> -static void virtnet_napi_tx_enable(struct send_queue *sq)
> +static void virtnet_napi_tx_enable(struct send_queue *sq, bool
> netdev_locked)
>  {
>      struct virtnet_info *vi = sq->vq->vdev->priv;
>      struct napi_struct *napi = &sq->napi;
> @@ -2825,11 +2829,11 @@ static void virtnet_napi_tx_enable(struct send_queue
> *sq)
>          return;
>      }
> 
> -    virtnet_napi_do_enable(sq->vq, napi);
> +    virtnet_napi_do_enable(sq->vq, napi, netdev_locked);
>      netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_TX, napi);
>  }
> 
> -static void virtnet_napi_tx_disable(struct send_queue *sq)
> +static void virtnet_napi_tx_disable(struct send_queue *sq, bool
> netdev_locked)
>  {
>      struct virtnet_info *vi = sq->vq->vdev->priv;
>      struct napi_struct *napi = &sq->napi;
> @@ -2837,18 +2841,24 @@ static void virtnet_napi_tx_disable(struct
> send_queue *sq)
> 
>      if (napi->weight) {
>          netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_TX, NULL);
> -        napi_disable(napi);
> +        if (netdev_locked)
> +            napi_disable_locked(napi);
> +        else
> +            napi_disable(napi);
>      }
>  }
> 
> -static void virtnet_napi_disable(struct receive_queue *rq)
> +static void virtnet_napi_disable(struct receive_queue *rq, bool
> netdev_locked)
>  {
>      struct virtnet_info *vi = rq->vq->vdev->priv;
>      struct napi_struct *napi = &rq->napi;
>      int qidx = vq2rxq(rq->vq);
> 
>      netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_RX, NULL);
> -    napi_disable(napi);
> +    if (netdev_locked)
> +        napi_disable_locked(napi);
> +    else
> +        napi_disable(napi);
>  }
> 
>  static void refill_work(struct work_struct *work)
> @@ -2875,9 +2885,11 @@ static void refill_work(struct work_struct *work)
>           *     instance lock)
>           *   - check netif_running() and return early to avoid a race
>           */
> -        napi_disable(&rq->napi);
> +        netdev_lock(vi->dev);
> +        napi_disable_locked(&rq->napi);
>          still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);


This does mean netdev_lock is held potentially for a long while,
while try_fill_recv and processing inside virtnet_napi_do_enable
finish. Better ideas?

> -        virtnet_napi_do_enable(rq->vq, &rq->napi);
> +        virtnet_napi_do_enable(rq->vq, &rq->napi, true);
> +        netdev_unlock(vi->dev);
> 
>          /* In theory, this can happen: if we don't get any buffers in
>           * we will *never* try to fill again.
> @@ -3074,8 +3086,8 @@ static int virtnet_poll(struct napi_struct *napi, int
> budget)
> 
>  static void virtnet_disable_queue_pair(struct virtnet_info *vi, int
> qp_index)
>  {
> -    virtnet_napi_tx_disable(&vi->sq[qp_index]);
> -    virtnet_napi_disable(&vi->rq[qp_index]);
> +    virtnet_napi_tx_disable(&vi->sq[qp_index], false);
> +    virtnet_napi_disable(&vi->rq[qp_index], false);
>      xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
>  }
> 
> @@ -3094,8 +3106,8 @@ static int virtnet_enable_queue_pair(struct
> virtnet_info *vi, int qp_index)
>      if (err < 0)
>          goto err_xdp_reg_mem_model;
> 
> -    virtnet_napi_enable(&vi->rq[qp_index]);
> -    virtnet_napi_tx_enable(&vi->sq[qp_index]);
> +    virtnet_napi_enable(&vi->rq[qp_index], false);
> +    virtnet_napi_tx_enable(&vi->sq[qp_index], false);
> 
>      return 0;
> 
> @@ -3347,7 +3359,8 @@ static void virtnet_rx_pause(struct virtnet_info *vi,
> struct receive_queue *rq)
>      bool running = netif_running(vi->dev);
> 
>      if (running) {
> -        virtnet_napi_disable(rq);
> +        netdev_lock(vi->dev);
> +        virtnet_napi_disable(rq, true);
>          virtnet_cancel_dim(vi, &rq->dim);
>      }
>  }
> @@ -3359,8 +3372,10 @@ static void virtnet_rx_resume(struct virtnet_info
> *vi, struct receive_queue *rq)
>      if (!try_fill_recv(vi, rq, GFP_KERNEL))
>          schedule_delayed_work(&vi->refill, 0);
> 
> -    if (running)
> -        virtnet_napi_enable(rq);
> +    if (running) {
> +        virtnet_napi_enable(rq, true);
> +        netdev_unlock(vi->dev);
> +    }
>  }
> 
>  static int virtnet_rx_resize(struct virtnet_info *vi,
> @@ -3389,7 +3404,7 @@ static void virtnet_tx_pause(struct virtnet_info *vi,
> struct send_queue *sq)
>      qindex = sq - vi->sq;
> 
>      if (running)
> -        virtnet_napi_tx_disable(sq);
> +        virtnet_napi_tx_disable(sq, false);
> 
>      txq = netdev_get_tx_queue(vi->dev, qindex);
> 
> @@ -3423,7 +3438,7 @@ static void virtnet_tx_resume(struct virtnet_info *vi,
> struct send_queue *sq)
>      __netif_tx_unlock_bh(txq);
> 
>      if (running)
> -        virtnet_napi_tx_enable(sq);
> +        virtnet_napi_tx_enable(sq, false);
>  }
> 
>  static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue
> *sq,
> @@ -5961,9 +5976,10 @@ static int virtnet_xdp_set(struct net_device *dev,
> struct bpf_prog *prog,
> 
>      /* Make sure NAPI is not using any XDP TX queues for RX. */
>      if (netif_running(dev)) {
> +        netdev_lock(dev);
>          for (i = 0; i < vi->max_queue_pairs; i++) {
> -            virtnet_napi_disable(&vi->rq[i]);
> -            virtnet_napi_tx_disable(&vi->sq[i]);
> +            virtnet_napi_disable(&vi->rq[i], true);
> +            virtnet_napi_tx_disable(&vi->sq[i], true);
>          }
>      }
> 
> @@ -6000,11 +6016,14 @@ static int virtnet_xdp_set(struct net_device *dev,
> struct bpf_prog *prog,
>          if (old_prog)
>              bpf_prog_put(old_prog);
>          if (netif_running(dev)) {
> -            virtnet_napi_enable(&vi->rq[i]);
> -            virtnet_napi_tx_enable(&vi->sq[i]);
> +            virtnet_napi_enable(&vi->rq[i], true);
> +            virtnet_napi_tx_enable(&vi->sq[i], true);
>          }
>      }
> 
> +    if (netif_running(dev))
> +        netdev_unlock(dev);
> +
>      return 0;
> 
>  err:
> @@ -6016,9 +6035,10 @@ static int virtnet_xdp_set(struct net_device *dev,
> struct bpf_prog *prog,
> 
>      if (netif_running(dev)) {
>          for (i = 0; i < vi->max_queue_pairs; i++) {
> -            virtnet_napi_enable(&vi->rq[i]);
> -            virtnet_napi_tx_enable(&vi->sq[i]);
> +            virtnet_napi_enable(&vi->rq[i], true);
> +            virtnet_napi_tx_enable(&vi->sq[i], true);
>          }
> +        netdev_unlock(dev);
>      }
>      if (prog)
>          bpf_prog_sub(prog, vi->max_queue_pairs - 1);
> -- 
> 2.43.0
> 


