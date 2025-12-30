Return-Path: <bpf+bounces-77528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E859CEA357
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 17:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E517730245FF
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 16:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9048286D4B;
	Tue, 30 Dec 2025 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMJ2HAoy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sDTnLUdn"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A54137923
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767113060; cv=none; b=EeE5wgEbhckDq3QR0juZJB62ZZB0gUHykVpTCm2ezGU8UO1U/WStKGhvFBoj4zf/0sEM70G/4VDVH6d4yj4N0MfbFpdN90o0DQTSZb4XwkW9Dn9WB7HMWDEzh7mZnbPmN9ojC+ZQQIopYQMu/deYVtXU8EzRPX5Z01g7pchhOhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767113060; c=relaxed/simple;
	bh=q7NyvwLa9sicZtWBXMJxS7E+6FRDA40em7tVFCO+yco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKPIrI+037IgWy8Z13eaMa0dq0EGYVGzVV64cWw2g/L5umBPX2pqmyZexW7PhKwwNZSPUaJnTRDYv09kFQgHLVk8kA5cXlU6PuEAI4E7ijgCqwjWFX1ymgyK/4RuNHOqVtuG6BUYHd8PlEvaEjtGnvWhz6Jt7T44aV2eQCe8b90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MMJ2HAoy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sDTnLUdn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767113057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYI37eW2c8supzl6v0y3GWwFPuk4FGpGgqwaJcS9l/c=;
	b=MMJ2HAoy/oZ8R/4JoXRCOUxtr7lb9b+oRBmI8AqhT6o2ho3GC38U9WdN7fitRY6yfZSUtP
	MHif+r8TZIm/BGax0C/h7LK6XS8VFHqxKqxnzvP2J9iM9cTEm8kRRxn3k+fwposixYknIX
	331rdHDD1S3MKdbDx6hNEmKT0jh4Tmo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-PDH1wCvJOO20udwaQN5K0g-1; Tue, 30 Dec 2025 11:44:16 -0500
X-MC-Unique: PDH1wCvJOO20udwaQN5K0g-1
X-Mimecast-MFC-AGG-ID: PDH1wCvJOO20udwaQN5K0g_1767113055
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4775d8428e8so84869085e9.0
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 08:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767113055; x=1767717855; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xYI37eW2c8supzl6v0y3GWwFPuk4FGpGgqwaJcS9l/c=;
        b=sDTnLUdn1AAYL0aOf9pqjVS5BnbWtDW3gaLzYK1wpnQMXg2vzjQaHczCGoDtvxUbGq
         pOMhh9XIxdW8R5T14VYegqF9vw2JuDwmooqLx/KN9foArb2F9Wug3+NInDDILHj+1/Tq
         9d/+XjBbDhHlWKqxolfRbNtd0hVlWkQVG4BSfWwNv2C8YQhJD50uBQ3nE5E2H4zAv7jy
         r+FfqoheduAKK9X8r8DlAHPYrxuis/ixtvPly1hz4OwL52ZS33ti+ZTGI2960ITFInM9
         2CcsKr3ikx66EYjfsY4svSi5Nw/+Si46UYFxyDDVZhJcEF/ErFahGX8lp1L9dLKMTavw
         rYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767113055; x=1767717855;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xYI37eW2c8supzl6v0y3GWwFPuk4FGpGgqwaJcS9l/c=;
        b=hTxOTS4Kvqf76Gdmm+BwY2lOf6TVhQaIn0mgEj3RDPFxTx4UqUcy9qsCc0nusVIuBf
         x3NUe96et+6kdEfxQm7A0BGGCskc8EOx12zPcuuv3DrLL7dNf4SUL9mEtACDOr0VmFqQ
         TV+HP+cn8m4t1qBnXO0GP+NE2oOxyjlPdcd6MA17cseuiQb00xHorv0qj5k0tsGP9GJu
         jErZgV6VNX54nVh931ID3lcKYK7b5nPwkY/E9qfXJSFHjRHTZWD3Rd0i1Ebpd/c5AyPh
         hcOVmcWv4cWJGrB5iEOad+OCwfc06yeXeXnUrJxTVbSgNmI72drscfWFja6p6wmX/1/0
         tZ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoJ4acWlQKiJ33JD21wyu47/hI9JQA/Hc8gCijVULe+KAbW0k5/GW9Zc93gUlqzX65rrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw92UYcSWnPc6hzNU6jZU+tCd009vp3DEr49b1nyR4i1/xi3n45
	OUCWOIl9EaqzhtmwzDWzaOEjSt5cZipmbY55V/zA1MKmZtm/Kj4Hg3pP4zEaiAz0d6Ar8iSfrhN
	F9rkaj5yX/b1PvZyjpOkbdVtC3H3DRxjKf08xhw+AnWrqTvG8LxpE6Q==
X-Gm-Gg: AY/fxX4exhMxFtVzK9uVUJGuEMYt4iBtiLow3ZyW7UNoFQgToxjakyzc/Ikc4WpWknJ
	GNOOY/i3fEFudu+UxkmL5T134g4KJgsbQzoXoSjPEEE81jQCAa8jStnwh6E4uSTpecy8ri2EQL7
	tTP2/TJ2GOM+jHPtjKMj5awFYeKYh/SYXvVz4krvn1noqusFcmEZdVaNR9sKL19vCYKm6Emuith
	LpBM0x7lYawmn2JOaRnQM38qdrFFdmxTHgu06vaykWG2crUyWp/vplSobQkEEHhKTdMkpYPBf7W
	ggNW2ehMZC62KnpJ/M9S3J5Pgfak4/R4MdkhyO5a0KxBiCWnES9O47mleV4eWvVsGfuszk4oT+H
	koBrNFc/AJndMd0ILN7u10uqtajiQiefNug==
X-Received: by 2002:a05:600d:102:b0:477:9ce2:a0d8 with SMTP id 5b1f17b1804b1-47d197fa272mr258316465e9.0.1767113054547;
        Tue, 30 Dec 2025 08:44:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExM9stLawDuC2XzpEaGqqSH1Qt3OQeeOH56cPRU+M9oRh04T9pEzHr6R7usT5ampfEyN0iTQ==
X-Received: by 2002:a05:600d:102:b0:477:9ce2:a0d8 with SMTP id 5b1f17b1804b1-47d197fa272mr258316135e9.0.1767113054022;
        Tue, 30 Dec 2025 08:44:14 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d192e88f5sm596270045e9.0.2025.12.30.08.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 08:44:13 -0800 (PST)
Date: Tue, 30 Dec 2025 11:44:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
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
	bpf@vger.kernel.org
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
Message-ID: <20251230114250-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>
 <20251223204555-mutt-send-email-mst@kernel.org>
 <CACGkMEs7_-=-8w=7gW8R_EhzfWOwuDoj4p-iCPQ7areOa9uaUw@mail.gmail.com>
 <20251225112729-mutt-send-email-mst@kernel.org>
 <CACGkMEt33BAWGmeFfHWYrjQLOT4+JB7HsWWVMKUn6yFxQ9y2gg@mail.gmail.com>
 <20251226022727-mutt-send-email-mst@kernel.org>
 <7143657a-a52f-4cff-acbc-e89f4c713cc4@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7143657a-a52f-4cff-acbc-e89f4c713cc4@gmail.com>

On Tue, Dec 30, 2025 at 11:28:50PM +0700, Bui Quang Minh wrote:
> On 12/26/25 14:37, Michael S. Tsirkin wrote:
> > On Fri, Dec 26, 2025 at 09:31:26AM +0800, Jason Wang wrote:
> > > On Fri, Dec 26, 2025 at 12:27 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > On Thu, Dec 25, 2025 at 03:33:29PM +0800, Jason Wang wrote:
> > > > > On Wed, Dec 24, 2025 at 9:48 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
> > > > > > > Hi Jason,
> > > > > > > 
> > > > > > > I'm wondering why we even need this refill work. Why not simply let NAPI retry
> > > > > > > the refill on its next run if the refill fails? That would seem much simpler.
> > > > > > > This refill work complicates maintenance and often introduces a lot of
> > > > > > > concurrency issues and races.
> > > > > > > 
> > > > > > > Thanks.
> > > > > > refill work can refill from GFP_KERNEL, napi only from ATOMIC.
> > > > > > 
> > > > > > And if GFP_ATOMIC failed, aggressively retrying might not be a great idea.
> > > > > Btw, I see some drivers are doing things as Xuan said. E.g
> > > > > mlx5e_napi_poll() did:
> > > > > 
> > > > > busy |= INDIRECT_CALL_2(rq->post_wqes,
> > > > >                                  mlx5e_post_rx_mpwqes,
> > > > >                                  mlx5e_post_rx_wqes,
> > > > > 
> > > > > ...
> > > > > 
> > > > > if (busy) {
> > > > >           if (likely(mlx5e_channel_no_affinity_change(c))) {
> > > > >                  work_done = budget;
> > > > >                  goto out;
> > > > > ...
> > > > 
> > > > is busy a GFP_ATOMIC allocation failure?
> > > Yes, and I think the logic here is to fallback to ksoftirqd if the
> > > allocation fails too much.
> > > 
> > > Thanks
> > 
> > True. I just don't know if this works better or worse than the
> > current design, but it is certainly simpler and we never actually
> > worried about the performance of the current one.
> > 
> > 
> > So you know, let's roll with this approach.
> > 
> > I do however ask that some testing is done on the patch forcing these OOM
> > situations just to see if we are missing something obvious.
> > 
> > 
> > the beauty is the patch can be very small:
> > 1. patch 1 do not schedule refill ever, just retrigger napi
> > 2. remove all the now dead code
> > 
> > this way patch 1 will be small and backportable to stable.
> 
> I've tried 1. with this patch
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1bb3aeca66c6..9e890aff2d95 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3035,7 +3035,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
>  }
> 
>  static int virtnet_receive(struct receive_queue *rq, int budget,
> -               unsigned int *xdp_xmit)
> +               unsigned int *xdp_xmit, bool *retry_refill)
>  {
>      struct virtnet_info *vi = rq->vq->vdev->priv;
>      struct virtnet_rq_stats stats = {};
> @@ -3047,12 +3047,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>          packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
> 
>      if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> -        if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> -            spin_lock(&vi->refill_lock);
> -            if (vi->refill_enabled)
> -                schedule_delayed_work(&vi->refill, 0);
> -            spin_unlock(&vi->refill_lock);
> -        }
> +        if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> +            *retry_refill = true;
>      }
> 
>      u64_stats_set(&stats.packets, packets);
> @@ -3129,18 +3125,18 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>      struct send_queue *sq;
>      unsigned int received;
>      unsigned int xdp_xmit = 0;
> -    bool napi_complete;
> +    bool napi_complete, retry_refill = false;
> 
>      virtnet_poll_cleantx(rq, budget);
> 
> -    received = virtnet_receive(rq, budget, &xdp_xmit);
> +    received = virtnet_receive(rq, budget, &xdp_xmit, &retry_refill);
>      rq->packets_in_napi += received;
> 
>      if (xdp_xmit & VIRTIO_XDP_REDIR)
>          xdp_do_flush();
> 
>      /* Out of packets? */
> -    if (received < budget) {
> +    if (received < budget && !retry_refill) {
>          napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
>          /* Intentionally not taking dim_lock here. This may result in a
>           * spurious net_dim call. But if that happens virtnet_rx_dim_work
> @@ -3230,9 +3226,11 @@ static int virtnet_open(struct net_device *dev)
> 
>      for (i = 0; i < vi->max_queue_pairs; i++) {
>          if (i < vi->curr_queue_pairs)
> -            /* Make sure we have some buffers: if oom use wq. */
> -            if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> -                schedule_delayed_work(&vi->refill, 0);
> +            /* If this fails, we will retry later in
> +             * NAPI poll, which is scheduled in the below
> +             * virtnet_enable_queue_pair
> +             */
> +            try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
> 
>          err = virtnet_enable_queue_pair(vi, i);
>          if (err < 0)
> @@ -3473,15 +3471,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>                  bool refill)
>  {
>      bool running = netif_running(vi->dev);
> -    bool schedule_refill = false;
> 
> -    if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> -        schedule_refill = true;
> +    if (refill)
> +        /* If this fails, we will retry later in NAPI poll, which is
> +         * scheduled in the below virtnet_napi_enable
> +         */
> +        try_fill_recv(vi, rq, GFP_KERNEL);
> +
>      if (running)
>          virtnet_napi_enable(rq);
> -
> -    if (schedule_refill)
> -        schedule_delayed_work(&vi->refill, 0);
>  }
> 
>  static void virtnet_rx_resume_all(struct virtnet_info *vi)
> @@ -3777,6 +3775,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>      struct virtio_net_rss_config_trailer old_rss_trailer;
>      struct net_device *dev = vi->dev;
>      struct scatterlist sg;
> +    int i;
> 
>      if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
>          return 0;
> @@ -3829,11 +3828,8 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>      }
>  succ:
>      vi->curr_queue_pairs = queue_pairs;
> -    /* virtnet_open() will refill when device is going to up. */
> -    spin_lock_bh(&vi->refill_lock);
> -    if (dev->flags & IFF_UP && vi->refill_enabled)
> -        schedule_delayed_work(&vi->refill, 0);
> -    spin_unlock_bh(&vi->refill_lock);
> +    for (i = 0; i < vi->curr_queue_pairs; i++)
> +        try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
> 
>      return 0;
>  }
> 
> 
> But I got an issue with selftests/drivers/net/hw/xsk_reconfig.py. This
> test sets up XDP zerocopy (Xsk) but does not provide any descriptors to
> the fill ring. So xsk_pool does not have any descriptors and
> try_fill_recv will always fail. The RX NAPI keeps polling. Later, when
> we want to disable the xsk_pool, in virtnet_xsk_pool_disable path,
> 
> virtnet_xsk_pool_disable
> -> virtnet_rq_bind_xsk_pool
>   -> virtnet_rx_pause
>     -> __virtnet_rx_pause
>       -> virtnet_napi_disable
>         -> napi_disable
> 
> We get stuck in napi_disable because the RX NAPI is still polling.
> 
> In drivers/net/ethernet/mellanox/mlx5, AFAICS, it uses state bit for
> synchronization between xsk setup (mlx5e_xsk_setup_pool) with RX NAPI
> (mlx5e_napi_poll) without using napi_disable/enable. However, in
> drivers/net/ethernet/intel/ice,
> 
> ice_xsk_pool_setup
> -> ice_qp_dis
>   -> ice_qvec_toggle_napi
>     -> napi_disable
> 
> it still uses napi_disable. Did I miss something in the above patch?
> I'll try to look into using another synchronization instead of
> napi_disable/enable in xsk_pool setup path too.
> 
> Thanks,
> Quang Minh.


... and the simplicity is out of the window. Up to you but maybe
it is easier to keep plugging the holes in the current approach.
It has been in the field for a very long time now, at least.

-- 
MST


