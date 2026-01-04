Return-Path: <bpf+bounces-77783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AEDCF0FDC
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 14:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72D193025F82
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 13:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AE7306D36;
	Sun,  4 Jan 2026 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sgyf/qc5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bq315AxK"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1A4289367
	for <bpf@vger.kernel.org>; Sun,  4 Jan 2026 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767533066; cv=none; b=cPZUBHr2BYhZ+xC9WhY/dfyCmB6QDowyFUZrcjWWQ8i/B8dekK9bTxwssroxDdRgmpElQ+YI66tQVgICjPcLnQwNy9g/04MvK9BihuecvLHxjqUINjucpbMKvFEAucSGPlFzgqx3Y8EJAxzJRO5nH4aNN4VcMLfboO49TXwUt2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767533066; c=relaxed/simple;
	bh=B0uBy44yYPCTeijF+QCyYAj5mL/FFSH+8NOvUkxu0aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ss1B8Pl8MWf4Cip4n6qYGtFBAWKwszO4+QAX91wCoYlO6HVS20/q22ylWGwyZ3mJJm8YqU1EBpprx7Q5a+Wi4A1oYIN7JVrlaIzcvygYJ+JAosh9bNdAPTGh8iSBdxuUkka3/oEtr+KBHuW7/F2A1ZxsCPj7d4hVec5gANMoDYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sgyf/qc5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bq315AxK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767533062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EAyKUkQEsR6IIIqmAgORcUN7qmUQxHIzTwUFN+JXvjA=;
	b=Sgyf/qc5xWBLGpZOWdI9IK3rThkgKaZPsS0xpHfja35udt+3f9CAM9CQPyInhAr+XmcsJT
	gqr4LAY91fJXOgkwoCy5W2UB1OSpXGPGmtLo3M+fRVEWxhpZvDeIllzEOPi+46Zqpl0pTX
	ckZkV6/rGnPkERjFC6B9B6HG+0h2OXk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-DqezcDCBNL6xoV7NM_6hXw-1; Sun, 04 Jan 2026 08:24:21 -0500
X-MC-Unique: DqezcDCBNL6xoV7NM_6hXw-1
X-Mimecast-MFC-AGG-ID: DqezcDCBNL6xoV7NM_6hXw_1767533060
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d28e7960fso82974255e9.0
        for <bpf@vger.kernel.org>; Sun, 04 Jan 2026 05:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767533060; x=1768137860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EAyKUkQEsR6IIIqmAgORcUN7qmUQxHIzTwUFN+JXvjA=;
        b=bq315AxKOffqgntHz5gTirKmvuc9uyJqNYPO0ZBD8kg0oigwMibfBScTn1rbf6N2UP
         8dDuQlkT7hp5W3YK98B39o/KnZd0cO3MZ1OhcwALuaj+xkl5KycQXyL4340N3kWiu2mJ
         qbvwb9ZddVP9tWPGm0vpE/DD7ToVzDFyUqPaax4fC0yeZCsTos+bj2s971tAM7UDL5dn
         rmunwkjzg5v4tXI4svYnS/epKHBQdksbHqyWneUvXLsq8/0BrFISCLjqmip3KzsNwTYJ
         1YYcuICrHrfso+5iBGEdDEFJMyHSUmGkUoXwUl31XLhYLQ7AXmrs5wurnagpUo5STz87
         9PFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767533060; x=1768137860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAyKUkQEsR6IIIqmAgORcUN7qmUQxHIzTwUFN+JXvjA=;
        b=jADoPoxLXwY4an9FH5ILl272dm8E82d8ROot2H/yDGUTsBzr45qrxJ9L+mt4WW3BHP
         mcksb97V1CF/QTQwNuQUskQVwp+rHB335hzcu9mn6RAPe6FRreV4A/c3DwK1NRxX7Tnv
         XNA+Sbsp5vplRLBxNmi+9BORlh+kn42cYvoCWPlhgzOIVa65MU5wMA/Y4Bi2jxbGaZix
         EP3OIFUDvbN7aSCLK61dHsp7pN6HsiJkpwWwn+BiBDr1ei4nHrGb8hckhT3bo9SDqdtb
         gP4fgO0y8O1ioNlv3opRTNOFB/7DbmDLUrYyz+/vK+Tj/+SKV218XU2DAEZd4N7s6AOB
         HV5A==
X-Forwarded-Encrypted: i=1; AJvYcCW35YqGuVC4GokBbFCYwgn70OASvTfVCvhldxg35T1a0L7bi42dJj6K8Hds/g/IyN+BTCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YynQGyTPBv1rP9Vn55a1s77ctfyCL7Dc3uZQ5tr+6ylZ8673Vtf
	6SyIaSJb3xpEqwZWUqWAPRz1vzLTySvCXBWjr2E/1lzuG+Ya3wtL+50kYT+GrJLamagUQTRh1Cv
	jzNsLuIGuE7862+mpFnS/20nHfvcM1iSM6nYm26xFa3ZxyQyskxDetg==
X-Gm-Gg: AY/fxX621nU1CDHbXFgTJ/Dvb+KHuyOi1VeC/tSPa/ChxPlpOgkJm7Zexy+/MlAp6t1
	oSchp0Po6R/wDVlrL55gqHuhADNibTMBsQMXtrUNdpYt6lWd6EiFb+dj4AdvF04K97nqp+vjHg1
	Yor8ka8h6/uYLNHDPFCYmI48D6oYJ7tuXrOgs8/7ZXTca1E+Hm8tWLUfXajSEti3uxZEa0iQV8H
	0b550Tn72lpIj2hs1ZmGLRYFmOto6/xIQ7VAPoDPzXpokGN1aKtBHuNlZ1oe5zljqFrXPvjsKlZ
	YZxYpOvTv+cJCrkXPryk0q1bKJG4tUwe1TX6WlHCbNh3aBUL6gPuOQ3EBb4lRSjgsWZxNb+M8o5
	q0HDUS5VVemLkcanJfaSvdQj7ZZnZ2/HxSw==
X-Received: by 2002:a05:600c:1d0b:b0:479:2a0b:180d with SMTP id 5b1f17b1804b1-47d1954a5f7mr566473055e9.11.1767533060166;
        Sun, 04 Jan 2026 05:24:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb41BDbLCFSoL5eNoJrrUmAc0eU1cSU5k6C7Avn1X7zNYgXzU4Nec6OswY+7dRbZjOlu/+8w==
X-Received: by 2002:a05:600c:1d0b:b0:479:2a0b:180d with SMTP id 5b1f17b1804b1-47d1954a5f7mr566472815e9.11.1767533059553;
        Sun, 04 Jan 2026 05:24:19 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1af20sm90322786f8f.2.2026.01.04.05.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 05:24:18 -0800 (PST)
Date: Sun, 4 Jan 2026 08:24:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
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
Message-ID: <20260104082317-mutt-send-email-mst@kernel.org>
References: <20260102152023.10773-1-minhquangbui99@gmail.com>
 <20260102152023.10773-2-minhquangbui99@gmail.com>
 <20260103115424-mutt-send-email-mst@kernel.org>
 <54e15e32-ee0d-4677-a85d-eb54ffe60a77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54e15e32-ee0d-4677-a85d-eb54ffe60a77@gmail.com>

On Sun, Jan 04, 2026 at 11:33:20AM +0700, Bui Quang Minh wrote:
> On 1/3/26 23:57, Michael S. Tsirkin wrote:
> > On Fri, Jan 02, 2026 at 10:20:21PM +0700, Bui Quang Minh wrote:
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
> > >   static int virtnet_receive(struct receive_queue *rq, int budget,
> > > -			   unsigned int *xdp_xmit)
> > > +			   unsigned int *xdp_xmit, bool *retry_refill)
> > >   {
> > >   	struct virtnet_info *vi = rq->vq->vdev->priv;
> > >   	struct virtnet_rq_stats stats = {};
> > > @@ -3047,12 +3047,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
> > >   		packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
> > >   	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> > > -		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> > > -			spin_lock(&vi->refill_lock);
> > > -			if (vi->refill_enabled)
> > > -				schedule_delayed_work(&vi->refill, 0);
> > > -			spin_unlock(&vi->refill_lock);
> > > -		}
> > > +		if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> > > +			*retry_refill = true;
> > >   	}
> > >   	u64_stats_set(&stats.packets, packets);
> > > @@ -3129,18 +3125,18 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
> > >   	struct send_queue *sq;
> > >   	unsigned int received;
> > >   	unsigned int xdp_xmit = 0;
> > > -	bool napi_complete;
> > > +	bool napi_complete, retry_refill = false;
> > >   	virtnet_poll_cleantx(rq, budget);
> > > -	received = virtnet_receive(rq, budget, &xdp_xmit);
> > > +	received = virtnet_receive(rq, budget, &xdp_xmit, &retry_refill);
> > >   	rq->packets_in_napi += received;
> > >   	if (xdp_xmit & VIRTIO_XDP_REDIR)
> > >   		xdp_do_flush();
> > >   	/* Out of packets? */
> > > -	if (received < budget) {
> > > +	if (received < budget && !retry_refill) {
> > >   		napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
> > >   		/* Intentionally not taking dim_lock here. This may result in a
> > >   		 * spurious net_dim call. But if that happens virtnet_rx_dim_work
> > > @@ -3160,7 +3156,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
> > >   		virtnet_xdp_put_sq(vi, sq);
> > >   	}
> > > -	return received;
> > > +	return retry_refill ? budget : received;
> > >   }
> > >   static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
> > > @@ -3230,9 +3226,11 @@ static int virtnet_open(struct net_device *dev)
> > >   	for (i = 0; i < vi->max_queue_pairs; i++) {
> > >   		if (i < vi->curr_queue_pairs)
> > > -			/* Make sure we have some buffers: if oom use wq. */
> > > -			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> > > -				schedule_delayed_work(&vi->refill, 0);
> > > +			/* If this fails, we will retry later in
> > > +			 * NAPI poll, which is scheduled in the below
> > > +			 * virtnet_enable_queue_pair
> > hmm do we even need this, then?
> > 
> > > +			 */
> > > +			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
> > >   		err = virtnet_enable_queue_pair(vi, i);
> > >   		if (err < 0)
> > > @@ -3473,15 +3471,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
> > >   				bool refill)
> > >   {
> > >   	bool running = netif_running(vi->dev);
> > > -	bool schedule_refill = false;
> > > -	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> > > -		schedule_refill = true;
> > > +	if (refill)
> > > +		/* If this fails, we will retry later in NAPI poll, which is
> > > +		 * scheduled in the below virtnet_napi_enable
> > > +		 */
> > > +		try_fill_recv(vi, rq, GFP_KERNEL);
> > 
> > hmm do we even need this, then?
> > 
> > > +
> > >   	if (running)
> > >   		virtnet_napi_enable(rq);
> > > -
> > > -	if (schedule_refill)
> > > -		schedule_delayed_work(&vi->refill, 0);
> > >   }
> > >   static void virtnet_rx_resume_all(struct virtnet_info *vi)
> > > @@ -3777,6 +3775,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
> > >   	struct virtio_net_rss_config_trailer old_rss_trailer;
> > >   	struct net_device *dev = vi->dev;
> > >   	struct scatterlist sg;
> > > +	int i;
> > >   	if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
> > >   		return 0;
> > > @@ -3829,11 +3828,17 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
> > >   	}
> > >   succ:
> > >   	vi->curr_queue_pairs = queue_pairs;
> > > -	/* virtnet_open() will refill when device is going to up. */
> > > -	spin_lock_bh(&vi->refill_lock);
> > > -	if (dev->flags & IFF_UP && vi->refill_enabled)
> > > -		schedule_delayed_work(&vi->refill, 0);
> > > -	spin_unlock_bh(&vi->refill_lock);
> > > +	if (dev->flags & IFF_UP) {
> > > +		/* Let the NAPI poll refill the receive buffer for us. We can't
> > > +		 * safely call try_fill_recv() here because the NAPI might be
> > > +		 * enabled already.
> > > +		 */
> > I'd drop this comment, it does not clarify much.
> 
> Here I want to note on why we can't use try_fill_recv like in other places.

It does not really answer the question why, you could just disable napi
if you wanted.

> > 
> > > +		local_bh_disable();
> > > +		for (i = 0; i < vi->curr_queue_pairs; i++)
> > > +			virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
> > > +
> > > +		local_bh_enable();
> > > +	}
> > >   	return 0;
> > >   }
> > > -- 
> > > 2.43.0


