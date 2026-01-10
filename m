Return-Path: <bpf+bounces-78438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AC0D0CCBE
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 03:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00AD8303C2B2
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 02:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E692246774;
	Sat, 10 Jan 2026 02:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mo/OnHH9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D432A1CF;
	Sat, 10 Jan 2026 02:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011161; cv=none; b=dRaprGrqSeDztAqSGRZcJMNVYuREX8sQvGgNC1FhkeEYMGdHMXaRfvwMh2qIxuZ9w+cf9fq0u3/Mtu6bWfSNKZ1iimt0D45TnICFSrVvJ5UZ1fCpv7KWN3jPLivzADATQPKR051Sbnq0diqX7Eg4YpH0DyRyEdB3HmxBYbpxha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011161; c=relaxed/simple;
	bh=D5bkcgNL5G1VYcSawL2KHr0EISsJ30WpEfjpKWoSQE0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fK4BzQXVU/+dCwjwlubmh6SQ5NW/uCUE+qbCVyJZTtOqs6uhp5xK3EwjwC03eqHcwBuEO97TFRT3Eh3z/WIg5pTqMMoWq7MpnG+VXnI0CrlzFofnKmhPu/VKtB0T1nJK3mCyavqU8vdhicaB819FxxIMKVfZAecVgANL88Jgh2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mo/OnHH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BABC4CEF1;
	Sat, 10 Jan 2026 02:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768011160;
	bh=D5bkcgNL5G1VYcSawL2KHr0EISsJ30WpEfjpKWoSQE0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mo/OnHH9evnQn6WCMUPGVnFmo3gC1O+BzB8N0PdXAcjjprjXUBamM9FVphhGRm6J7
	 FgefALw29cEzdsOkt0nwoJxeyemxWvHSyRynpSZCD0F7tSD2EOsJyMVqIuFr7g/WlB
	 GMVtmh01VcKx86t8p9Cf8xDGBFrnHkVfGMErTycOxI8x1TBlLf8gGy3rD5d+481Zhh
	 G/4bbVz+cRuXLoKeAbv43uNPXkIjhFtvH0FAodBMY+b1R6ftMQ8muuvUK6Q5TUrhmm
	 Ll5X/6nBIq4z+5LSySDj7JyyGDDngrdyPJrIQp335UQjGPigEWlhDRwXL9skF8xNRc
	 qTqCq6izikjxw==
Date: Fri, 9 Jan 2026 18:12:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/3] virtio-net: don't schedule delayed refill
 worker
Message-ID: <20260109181239.1c272f88@kernel.org>
In-Reply-To: <20260106150438.7425-2-minhquangbui99@gmail.com>
References: <20260106150438.7425-1-minhquangbui99@gmail.com>
	<20260106150438.7425-2-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Jan 2026 22:04:36 +0700 Bui Quang Minh wrote:
> When we fail to refill the receive buffers, we schedule a delayed worker
> to retry later. However, this worker creates some concurrency issues.
> For example, when the worker runs concurrently with virtnet_xdp_set,
> both need to temporarily disable queue's NAPI before enabling again.
> Without proper synchronization, a deadlock can happen when
> napi_disable() is called on an already disabled NAPI. That
> napi_disable() call will be stuck and so will the subsequent
> napi_enable() call.
> 
> To simplify the logic and avoid further problems, we will instead retry
> refilling in the next NAPI poll.

Happy to see this go FWIW. If it causes issues we should consider
adding some retry logic in the core (NAPI) rather than locally in
the driver..

> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr

The Closes should probably point to Paolo's report. We'll wipe these CI
logs sooner or later but the lore archive will stick around.

> @@ -3230,9 +3230,10 @@ static int virtnet_open(struct net_device *dev)
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		if (i < vi->curr_queue_pairs)
> -			/* Make sure we have some buffers: if oom use wq. */
> -			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> -				schedule_delayed_work(&vi->refill, 0);
> +			/* Pre-fill rq agressively, to make sure we are ready to
> +			 * get packets immediately.
> +			 */
> +			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);

We should enforce _some_ minimal fill level at the time of open().
If the ring is completely empty no traffic will ever flow, right?
Perhaps I missed scheduling the NAPI somewhere..

>  		err = virtnet_enable_queue_pair(vi, i);
>  		if (err < 0)
> @@ -3472,16 +3473,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>  				struct receive_queue *rq,
>  				bool refill)
>  {
> -	bool running = netif_running(vi->dev);
> -	bool schedule_refill = false;
> +	if (netif_running(vi->dev)) {
> +		/* Pre-fill rq agressively, to make sure we are ready to get
> +		 * packets immediately.
> +		 */
> +		if (refill)
> +			try_fill_recv(vi, rq, GFP_KERNEL);

Similar thing here? Tho not sure we can fail here..

> -	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> -		schedule_refill = true;
> -	if (running)
>  		virtnet_napi_enable(rq);
> -
> -	if (schedule_refill)
> -		schedule_delayed_work(&vi->refill, 0);
> +	}
>  }
>  
>  static void virtnet_rx_resume_all(struct virtnet_info *vi)
> @@ -3829,11 +3829,13 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  	}
>  succ:
>  	vi->curr_queue_pairs = queue_pairs;
> -	/* virtnet_open() will refill when device is going to up. */
> -	spin_lock_bh(&vi->refill_lock);
> -	if (dev->flags & IFF_UP && vi->refill_enabled)
> -		schedule_delayed_work(&vi->refill, 0);
> -	spin_unlock_bh(&vi->refill_lock);
> +	if (dev->flags & IFF_UP) {
> +		local_bh_disable();
> +		for (int i = 0; i < vi->curr_queue_pairs; ++i)
> +			virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
> +

nit: spurious new line

> +		local_bh_enable();
> +	}
>  
>  	return 0;
>  }


