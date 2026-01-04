Return-Path: <bpf+bounces-77786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0417CF10E1
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 15:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 933B0300C0D7
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 14:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8008F1A9F96;
	Sun,  4 Jan 2026 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Da2gClUK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJxQGm1Q"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A49715A86D
	for <bpf@vger.kernel.org>; Sun,  4 Jan 2026 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767535397; cv=none; b=Vctqg/ZszqS9BrcYoscGQwylw3dkpjhRz1slgYJpXCyfizdExt2vNmmY8DsUOdNglC4kmyg/9+pFqW3/VdU96yAcRv+dfT3r/DJlrQjFBYiMEV21Q7b6zrZ0raQJttA72960aibtC0CC9pkz7XAnKdLiPU3kaJ24UPwJTTWrdJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767535397; c=relaxed/simple;
	bh=Mcb0xRQEqWTTD4csAB6KKuBmISFxJYmZyIhRohkCzEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2DPVDv32BbLhB7SMxFN5FONxljsLSa18Y0xfv15OimXaJlUnXn5rz6qTkmWvjHjoKkP1KioEmicdEvEvr8mSaiOHh2DIeOBwhACU5k4BjrvnooatiDtD/fOnS80a4WDnA9Uwe+2mZMk0KVY6ZAb6wofwQpjAfu2eXnxSWGDFLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Da2gClUK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJxQGm1Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767535394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1WmKWHjTK9kQE8cov6ad+xozYqmDEFZuRGy+ZcYHfU4=;
	b=Da2gClUK0178pRz9OrstHo+oDefJkX+fh1onh2hS4d/P2tTG8IgkqrujyUmMPIxgKRsEVN
	Zqc+YQH5T+YLOY1Doop/FobKHzcygVQ83g+gfk+b6gQLceDG9XzZOxlSszfgA6Evz8Svmm
	mPtmrAFtDyOmK6k6CrjNXXrZrLCeLvo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-PbeBTHkdMKOQzoOs2CXT0w-1; Sun, 04 Jan 2026 09:03:12 -0500
X-MC-Unique: PbeBTHkdMKOQzoOs2CXT0w-1
X-Mimecast-MFC-AGG-ID: PbeBTHkdMKOQzoOs2CXT0w_1767535392
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477964c22e0so9441605e9.0
        for <bpf@vger.kernel.org>; Sun, 04 Jan 2026 06:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767535391; x=1768140191; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1WmKWHjTK9kQE8cov6ad+xozYqmDEFZuRGy+ZcYHfU4=;
        b=hJxQGm1Qj2PUB/0g9WvYiimAOHSgqJ9LUlzBaEN6o1ETzBGYJYHejvedblNP+TNxoO
         4rlxvlp3gOgvebB0DTUEBdZ384kV1wh8kVMznP1rhB+Mu+VryWNFnGj26uzFbrV3gTBE
         GXYxhV0JpEpn6O4qKPbHsugX9bHbTFSdkoSmkvdBeklF2tIOmwTgq6aIJfL4K9ka7e2i
         MKLRsl0uYIhDvpYGmjTX3+3bd3xa99fkuhrJclLFwNgNrDfwTDtE13Ji2aeQ2/T2w/xs
         h8WLcpStKdYPH+LmtIqjFtoM15hkmgvAksd99d0zlOndbNEosuEfR4jLYaOUrjXE+klI
         6vYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767535391; x=1768140191;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WmKWHjTK9kQE8cov6ad+xozYqmDEFZuRGy+ZcYHfU4=;
        b=YTYvl16Bs3zSZHPpf2jm5xZPuq4UilGax4v0fe10nXuVrR1zWCib8RQgRukdBZvssq
         7MdyqzmtcjodVoalP1uBovBFzwsrglJ5pQ97j8hnoIexJ7+ad7vxUyzF4KX8iDxQYyAn
         9kRl6bBgRFwajMTBVtgFNvbDKuIaa59c/To351/7jL/7FWAecIC3nzQgApEZLXyfHA5u
         8ILUcYDCKiBKnypQggPYp52enc5nYIVh/dgsqLKr9PVVwu0jV7gngsqZnwWL3/jKyoQJ
         J80kDZN7NgeESKsJVbGpt9KcZO4ikJalKow0qmdXRsG/HYZb+tvm8ZA5LFpzYN7bodiB
         mLxg==
X-Forwarded-Encrypted: i=1; AJvYcCUtzZWM5ZJofUqZax/rSwH/V9Miu4V/mDh42ZpNpoVuaSLqOm/r4CqDQ6b4aSh8/152foQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8HU3/p7b+ojRyOyZPU7dH6Ix/tJw0wUU72ax833jFGkvG+enk
	8hD6SaH5HJRzPA6U9i9ZbcLfV3KFOttJ5iLXQlY7XLK9Nz82TZGnZ+7fBgyZQEmQlb2NCQJCS5E
	hRawRWzz+84AynlcAG4GLiaFOfrCu+YFS3aorG1MEHqtfG8ZcCl8ITQ==
X-Gm-Gg: AY/fxX7Nw00Ocytwf6sWlazmPVzhQwAp+SlAS6zxCR39mQzDPH4h35SNMU58NQeo93h
	i1I0UYGJaxbeY+j+sN2OHWBK8NSE5BMvaOFLR9A+5dYlKkR39w7+1sKnjVXNNN+4fRcw/z5NH1C
	g6xVNJqHLwMUKJK2Yj/N7VijnPqM1MSbtXtY0TYXm9LeRJfiMtLOx7b0kpRS3X3M+X9nwafMHDN
	EGkt1uWgrlt8JKg1MszT767kX2Pt5YqgR4sUKhYahf+WNlhEUsEFHUQSEG1JOKfVkDln2bOClsO
	0/hU43ZonK8Dyipg9M6zSvfjg3SMViS4w8IGC519PPtJT+9EdUOU0ZN1QVGLigKJyTCxQyWmmby
	EzVqRIbBkR1QdZD7+TewMKCos3ZPSGjG7ow==
X-Received: by 2002:a05:600c:1f0f:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-47d6ba88537mr68390735e9.13.1767535391440;
        Sun, 04 Jan 2026 06:03:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUGdUDvh1D/AAd/73vhi+i7WC7g6t/YWcLmIxzwKqgOiJl8nVvOTHVTG0aB3EomaU37dw0yw==
X-Received: by 2002:a05:600c:1f0f:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-47d6ba88537mr68390295e9.13.1767535390916;
        Sun, 04 Jan 2026 06:03:10 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d1490efsm94869865e9.7.2026.01.04.06.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 06:03:10 -0800 (PST)
Date: Sun, 4 Jan 2026 09:03:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] virtio-net: don't schedule delayed refill
 worker
Message-ID: <20260104085846-mutt-send-email-mst@kernel.org>
References: <20260102152023.10773-1-minhquangbui99@gmail.com>
 <20260102152023.10773-2-minhquangbui99@gmail.com>
 <CACGkMEs9wCM8s4_r1HCQGj9mUDdTF+BqkF0rse+dzB3USprhMA@mail.gmail.com>
 <6bac1895-d4a3-4e98-8f39-358fa14102db@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6bac1895-d4a3-4e98-8f39-358fa14102db@gmail.com>

On Sun, Jan 04, 2026 at 03:34:52PM +0700, Bui Quang Minh wrote:
> On 1/4/26 13:09, Jason Wang wrote:
> > On Fri, Jan 2, 2026 at 11:20 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
> > > When we fail to refill the receive buffers, we schedule a delayed worker
> > > to retry later. However, this worker creates some concurrency issues
> > > such as races and deadlocks. To simplify the logic and avoid further
> > > problems, we will instead retry refilling in the next NAPI poll.
> > > 
> > > Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> > > Reported-by: Paolo Abeni <pabeni@redhat.com>
> > > Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
> > > Cc: stable@vger.kernel.org
> > > Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > > ---
> > >   drivers/net/virtio_net.c | 55 ++++++++++++++++++++++------------------
> > >   1 file changed, 30 insertions(+), 25 deletions(-)
> > > 
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 1bb3aeca66c6..ac514c9383ae 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -3035,7 +3035,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
> > >   }
> > > 
> > >   static int virtnet_receive(struct receive_queue *rq, int budget,
> > > -                          unsigned int *xdp_xmit)
> > > +                          unsigned int *xdp_xmit, bool *retry_refill)
> > >   {
> > >          struct virtnet_info *vi = rq->vq->vdev->priv;
> > >          struct virtnet_rq_stats stats = {};
> > > @@ -3047,12 +3047,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
> > >                  packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
> > > 
> > >          if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> > > -               if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> > > -                       spin_lock(&vi->refill_lock);
> > > -                       if (vi->refill_enabled)
> > > -                               schedule_delayed_work(&vi->refill, 0);
> > > -                       spin_unlock(&vi->refill_lock);
> > > -               }
> > > +               if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> > > +                       *retry_refill = true;
> > >          }
> > > 
> > >          u64_stats_set(&stats.packets, packets);
> > > @@ -3129,18 +3125,18 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
> > >          struct send_queue *sq;
> > >          unsigned int received;
> > >          unsigned int xdp_xmit = 0;
> > > -       bool napi_complete;
> > > +       bool napi_complete, retry_refill = false;
> > > 
> > >          virtnet_poll_cleantx(rq, budget);
> > > 
> > > -       received = virtnet_receive(rq, budget, &xdp_xmit);
> > > +       received = virtnet_receive(rq, budget, &xdp_xmit, &retry_refill);
> > I think we can simply let virtnet_receive() to return the budget when
> > reill fails.
> 
> That makes sense, I'll change it.
> 
> > 
> > >          rq->packets_in_napi += received;
> > > 
> > >          if (xdp_xmit & VIRTIO_XDP_REDIR)
> > >                  xdp_do_flush();
> > > 
> > >          /* Out of packets? */
> > > -       if (received < budget) {
> > > +       if (received < budget && !retry_refill) {
> > >                  napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
> > >                  /* Intentionally not taking dim_lock here. This may result in a
> > >                   * spurious net_dim call. But if that happens virtnet_rx_dim_work
> > > @@ -3160,7 +3156,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
> > >                  virtnet_xdp_put_sq(vi, sq);
> > >          }
> > > 
> > > -       return received;
> > > +       return retry_refill ? budget : received;
> > >   }
> > > 
> > >   static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
> > > @@ -3230,9 +3226,11 @@ static int virtnet_open(struct net_device *dev)
> > > 
> > >          for (i = 0; i < vi->max_queue_pairs; i++) {
> > >                  if (i < vi->curr_queue_pairs)
> > > -                       /* Make sure we have some buffers: if oom use wq. */
> > > -                       if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> > > -                               schedule_delayed_work(&vi->refill, 0);
> > > +                       /* If this fails, we will retry later in
> > > +                        * NAPI poll, which is scheduled in the below
> > > +                        * virtnet_enable_queue_pair
> > > +                        */
> > > +                       try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
> > Consider NAPI will be eventually scheduled, I wonder if it's still
> > worth to refill here.
> 
> With GFP_KERNEL here, I think it's more likely to succeed than GFP_ATOMIC in
> NAPI poll. Another small benefit is that the actual packet can happen
> earlier. In case the receive buffer is empty and we don't refill here, the
> #1 NAPI poll refill the buffer and the #2 NAPI poll can receive packets. The
> #2 NAPI poll is scheduled in the interrupt handler because the #1 NAPI poll
> will deschedule the NAPI and enable the device interrupt. In case we
> successfully refill here, the #1 NAPI poll can receive packets right away.
> 

Right. But I think this is a part that needs elucidating, not
error handling.

/* Pre-fill rq agressively, to make sure we are ready to get packets
 * immediately.
 * */

> > 
> > >                  err = virtnet_enable_queue_pair(vi, i);
> > >                  if (err < 0)
> > > @@ -3473,15 +3471,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
> > >                                  bool refill)
> > >   {
> > >          bool running = netif_running(vi->dev);
> > > -       bool schedule_refill = false;
> > > 
> > > -       if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> > > -               schedule_refill = true;
> > > +       if (refill)
> > > +               /* If this fails, we will retry later in NAPI poll, which is
> > > +                * scheduled in the below virtnet_napi_enable
> > > +                */
> > > +               try_fill_recv(vi, rq, GFP_KERNEL);
> > and here.
> > 
> > > +
> > >          if (running)
> > >                  virtnet_napi_enable(rq);

here the part that isn't clear is why are we refilling if !running
and what handles failures in that case.

> > > -
> > > -       if (schedule_refill)
> > > -               schedule_delayed_work(&vi->refill, 0);
> > >   }
> > > 
> > >   static void virtnet_rx_resume_all(struct virtnet_info *vi)
> > > @@ -3777,6 +3775,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
> > >          struct virtio_net_rss_config_trailer old_rss_trailer;
> > >          struct net_device *dev = vi->dev;
> > >          struct scatterlist sg;
> > > +       int i;
> > > 
> > >          if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
> > >                  return 0;
> > > @@ -3829,11 +3828,17 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
> > >          }
> > >   succ:
> > >          vi->curr_queue_pairs = queue_pairs;
> > > -       /* virtnet_open() will refill when device is going to up. */
> > > -       spin_lock_bh(&vi->refill_lock);
> > > -       if (dev->flags & IFF_UP && vi->refill_enabled)
> > > -               schedule_delayed_work(&vi->refill, 0);
> > > -       spin_unlock_bh(&vi->refill_lock);
> > > +       if (dev->flags & IFF_UP) {
> > > +               /* Let the NAPI poll refill the receive buffer for us. We can't
> > > +                * safely call try_fill_recv() here because the NAPI might be
> > > +                * enabled already.
> > > +                */
> > > +               local_bh_disable();
> > > +               for (i = 0; i < vi->curr_queue_pairs; i++)
> > > +                       virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
> > > +
> > > +               local_bh_enable();
> > > +       }
> > > 
> > >          return 0;
> > >   }
> > > --
> > > 2.43.0
> > > 
> > Thanks
> > 
> 
> Thanks,
> Quang Minh.


