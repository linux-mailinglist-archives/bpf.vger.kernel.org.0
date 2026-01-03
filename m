Return-Path: <bpf+bounces-77725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF927CEF848
	for <lists+bpf@lfdr.de>; Sat, 03 Jan 2026 01:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8083D3015EC8
	for <lists+bpf@lfdr.de>; Sat,  3 Jan 2026 00:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E167E20B7ED;
	Sat,  3 Jan 2026 00:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hP++kspM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjdvncfR"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A0627470
	for <bpf@vger.kernel.org>; Sat,  3 Jan 2026 00:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767399372; cv=none; b=FDMP/NTrG5Ih1+Xk6p7V6nR3KT3ngw0axDW/NGWMqpoGwd6Q8eTrvH6bCSX4JFIwczUtZzBxgMszxBCcItdHknwJuHhCyF6Jr93orjBRDA4G1N8bb0BEHje5h8wKl3ZiSkZsCPVbnKFW/91u4L+FUoC6qWvgnVHVtVLCEnzmhQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767399372; c=relaxed/simple;
	bh=oeixh7OIs8mUJmcLOGI3IzkhbDJiXpGDI0HEiz+o0bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nS02CosZYQWmcnYirSwVE51HA1F15BK6Tim0gf2KKyKx11qa9GCoP66mjLLyWexLaiqN583BmB4XtkG3UCfDakD4kMDoaOtBLyxUQE5Xq6ocHJPc11QC6r2t60YDsyBKMFngvhjdg9WC5z4FHXed2WmgRgiGscatiGGH2Y8f55g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hP++kspM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjdvncfR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767399368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LgmwNMSPn56V/BSylDuVjsVQwHfchpHkar4n4cWE59k=;
	b=hP++kspMAVBA5GHMPbhaI6TspRmfsTQFMK4UwIARAivylV4Mt3kOrGu5pvuhKoePu6biNw
	apY+O6lFtWvNZydk0HHGxVUFwfpwd/u54rQ+Mh1b0b7dXxZU5OTC7gIITewlbF2Y3/k00p
	5e0hxamCbjNT1s9NxQNemrhzSc+GBe4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-GpRipUgGMcCnJwk-f6z7IQ-1; Fri, 02 Jan 2026 19:16:07 -0500
X-MC-Unique: GpRipUgGMcCnJwk-f6z7IQ-1
X-Mimecast-MFC-AGG-ID: GpRipUgGMcCnJwk-f6z7IQ_1767399366
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430f8866932so10003422f8f.1
        for <bpf@vger.kernel.org>; Fri, 02 Jan 2026 16:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767399366; x=1768004166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LgmwNMSPn56V/BSylDuVjsVQwHfchpHkar4n4cWE59k=;
        b=WjdvncfRf5n53SHe0OsSm2VkH9cRfVBUFmyxvQhRrV+xSedquWUIcDC5w9zii5N/Ti
         M2i6hbeIDYAyObE4y4EZhdVKA7oqmWLjDAC8elekvz/cHSlXlC5hneLbttt65jj7ATYB
         XFRT/z41YRYs6ftgPgz9I+vA3iMZtKg3huzQMRcHtagOWGvtbQsDWtpOhwlydOYVpKYd
         keWe+UvRsyTsD8Zbw2GpiOiVSrxSXjE2F3NCmnGFKLSjZXjz0Hesu3SSLFZDEGVAnZOP
         WvdTeSq8zE6NeSeIBHmD5myiujVBDKsOrWOB3MmpRd2L8cf1wxKKkRMrWuc5bk2h6wih
         DZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767399366; x=1768004166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgmwNMSPn56V/BSylDuVjsVQwHfchpHkar4n4cWE59k=;
        b=ffTLH/ijOb65oYJ9iJFLD0Mpf/pVyhmmF8MnfwNrwHtpDDI2lD+S7VYLsrt4T9Dh1I
         tRzfHiJNG0c+3VAAD3Z5V8ZnRd0avhRGFL0axl1l+brEkca1B9DuIwR+IdMf2NbZ8+BA
         JSjg76f8Jn0TGUDn1U7qRM6UdbuAxiYO9tA8I5MXoWED94cKyCRS4g3Hrzi2yz4aF5Ad
         zqUOYbxE7aZoKmg+uW2IMoYA7KL9CG0NhSgl7Vd6NBRsbHsmACg2vyNmhmJba1X2ExO3
         y/nspA4RU9JhBoRc7HLWXgtlAMm6d+gdhejGeD540eSjm5xB0tZ0bZtisW91F4ksmyME
         nZ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgYVVLM04TbIVpI35SR1PzON2+kmuQqNSd4Z1rphTZW8xxokbRju/Dz1XcZGnbB6XY1do=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGBGuPLCbxBxBIsWwia5h77iT7F3nMaoU5Qq/bPVVIDvRFNQ6I
	w1sfnebyVXdss1UzX9fMHP2fafhHRmvdAN6vnABeNwigkRVr2ypRJzQnjD2iPtBLCHwGa7cHN1n
	x4f8DQusTMODLbQW83olpdP7QqmqO3FMkeZneDqrcR5AS3l37oQfqxw==
X-Gm-Gg: AY/fxX6mM/j8bsYKKuPFgsfg49Vm2vEkZ7zyCJYO3k7e5SgQThWuCc09fldQTa2RLis
	fczsOqHjg7iu35DJac/Bq1kcITg4Z3XuFUTfXw7UduOZryrKP6OpjezvVH4LXvSORgYo0hTze2D
	tOJvk8ocY8oLHBDIqwnwN0e+rMEgRYHlyTF+EGlMQsG3PGDhcBTS1jX13rgAvF3SjM6CE3qUjiH
	KX/520RT7JxqueHGlfLB+n4nZz0GmCSjE3KV0uuy+qmgm1cI4BD4ck8PCYyDariTWglmnNak+QE
	cwt2JoM5gOIFc6j9H7zfIRGPxlCTJuGHSguQMZqjmegUaM3otv0SKi2wDYSimazhzIH4InxxoSv
	8tPLLaA==
X-Received: by 2002:a05:6000:2909:b0:430:f97a:6f43 with SMTP id ffacd0b85a97d-4324e709710mr66217947f8f.53.1767399365825;
        Fri, 02 Jan 2026 16:16:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9aB7zkIrFTuuZ7xl2WvyXAoAEavadLOe7DzHD1qTfvtUGbDJjbs2g2P+Yqoa6knBaVtt76Q==
X-Received: by 2002:a05:6000:2909:b0:430:f97a:6f43 with SMTP id ffacd0b85a97d-4324e709710mr66217916f8f.53.1767399365267;
        Fri, 02 Jan 2026 16:16:05 -0800 (PST)
Received: from redhat.com ([2a06:c701:73d7:4800:ba30:1c4a:380d:b509])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa64cesm87134943f8f.35.2026.01.02.16.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:16:04 -0800 (PST)
Date: Fri, 2 Jan 2026 19:16:00 -0500
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
Message-ID: <20260102190935-mutt-send-email-mst@kernel.org>
References: <20260102152023.10773-1-minhquangbui99@gmail.com>
 <20260102152023.10773-2-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102152023.10773-2-minhquangbui99@gmail.com>

On Fri, Jan 02, 2026 at 10:20:21PM +0700, Bui Quang Minh wrote:
> When we fail to refill the receive buffers, we schedule a delayed worker
> to retry later. However, this worker creates some concurrency issues
> such as races and deadlocks.

include at least one example here, pls.

> To simplify the logic and avoid further
> problems, we will instead retry refilling in the next NAPI poll.
> 
> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
> Cc: stable@vger.kernel.org
> Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 55 ++++++++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1bb3aeca66c6..ac514c9383ae 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3035,7 +3035,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
>  }
>  
>  static int virtnet_receive(struct receive_queue *rq, int budget,
> -			   unsigned int *xdp_xmit)
> +			   unsigned int *xdp_xmit, bool *retry_refill)
>  {
>  	struct virtnet_info *vi = rq->vq->vdev->priv;
>  	struct virtnet_rq_stats stats = {};
> @@ -3047,12 +3047,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>  		packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
>  
>  	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> -		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> -			spin_lock(&vi->refill_lock);
> -			if (vi->refill_enabled)
> -				schedule_delayed_work(&vi->refill, 0);
> -			spin_unlock(&vi->refill_lock);
> -		}
> +		if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> +			*retry_refill = true;
>  	}
>  
>  	u64_stats_set(&stats.packets, packets);

So this function sets retry_refill to true but assumes caller
will set it to false? seems unnecessarily complex.
just have to always set retry_refill correctly
and not rely on the caller.


> @@ -3129,18 +3125,18 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  	struct send_queue *sq;
>  	unsigned int received;
>  	unsigned int xdp_xmit = 0;
> -	bool napi_complete;
> +	bool napi_complete, retry_refill = false;
>  
>  	virtnet_poll_cleantx(rq, budget);
>  
> -	received = virtnet_receive(rq, budget, &xdp_xmit);
> +	received = virtnet_receive(rq, budget, &xdp_xmit, &retry_refill);
>  	rq->packets_in_napi += received;
>  
>  	if (xdp_xmit & VIRTIO_XDP_REDIR)
>  		xdp_do_flush();
>  
>  	/* Out of packets? */
> -	if (received < budget) {
> +	if (received < budget && !retry_refill) {
>  		napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
>  		/* Intentionally not taking dim_lock here. This may result in a
>  		 * spurious net_dim call. But if that happens virtnet_rx_dim_work
> @@ -3160,7 +3156,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  		virtnet_xdp_put_sq(vi, sq);
>  	}
>  
> -	return received;
> +	return retry_refill ? budget : received;

a comment can't hurt here, to document what is going on.

>  }
>  
>  static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
> @@ -3230,9 +3226,11 @@ static int virtnet_open(struct net_device *dev)
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		if (i < vi->curr_queue_pairs)
> -			/* Make sure we have some buffers: if oom use wq. */
> -			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> -				schedule_delayed_work(&vi->refill, 0);
> +			/* If this fails, we will retry later in
> +			 * NAPI poll, which is scheduled in the below
> +			 * virtnet_enable_queue_pair
> +			 */
> +			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
>  
>  		err = virtnet_enable_queue_pair(vi, i);
>  		if (err < 0)
> @@ -3473,15 +3471,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>  				bool refill)
>  {
>  	bool running = netif_running(vi->dev);
> -	bool schedule_refill = false;
>  
> -	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> -		schedule_refill = true;
> +	if (refill)
> +		/* If this fails, we will retry later in NAPI poll, which is
> +		 * scheduled in the below virtnet_napi_enable
> +		 */
> +		try_fill_recv(vi, rq, GFP_KERNEL);
> +
>  	if (running)
>  		virtnet_napi_enable(rq);
> -
> -	if (schedule_refill)
> -		schedule_delayed_work(&vi->refill, 0);
>  }
>  
>  static void virtnet_rx_resume_all(struct virtnet_info *vi)
> @@ -3777,6 +3775,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  	struct virtio_net_rss_config_trailer old_rss_trailer;
>  	struct net_device *dev = vi->dev;
>  	struct scatterlist sg;
> +	int i;
>  
>  	if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
>  		return 0;
> @@ -3829,11 +3828,17 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  	}
>  succ:
>  	vi->curr_queue_pairs = queue_pairs;
> -	/* virtnet_open() will refill when device is going to up. */
> -	spin_lock_bh(&vi->refill_lock);
> -	if (dev->flags & IFF_UP && vi->refill_enabled)
> -		schedule_delayed_work(&vi->refill, 0);
> -	spin_unlock_bh(&vi->refill_lock);
> +	if (dev->flags & IFF_UP) {
> +		/* Let the NAPI poll refill the receive buffer for us. We can't
> +		 * safely call try_fill_recv() here because the NAPI might be
> +		 * enabled already.
> +		 */
> +		local_bh_disable();
> +		for (i = 0; i < vi->curr_queue_pairs; i++)

you cam declare i here in the for loop.
and ++i is a bit clearer.

> +			virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
> +
> +		local_bh_enable();
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.43.0


