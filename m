Return-Path: <bpf+bounces-55854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3719A87F84
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 13:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38743A9FF3
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 11:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEC12980BA;
	Mon, 14 Apr 2025 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyW+Ri1L"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD3F19B5B1
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 11:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744631187; cv=none; b=OnF+ywGysPf3u4ayAhdoJ0+6Fo0Z2Dvu9AstcFbJndmM9CewF8YZqKBvd9gtHYiOwxfUPf6LDpWqLuApev/9VtmwuGflFvh6jCY2McQAg6PJKO6Y5gjMGr3TQWdeLuzLit5w/b3BWOr0ECtLXdQRDV4Y3k/qkRgM2LDcXVmjQtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744631187; c=relaxed/simple;
	bh=TGa5A74hhJRFatKtiDaBCJm3bNAxG+RmuZi9KC/N3rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBJjBI9FuFbDjDaZxjfQHvp4BrMSF79/PlAlqNx5ShzOqh+s/w0bp+UiMVH1tVWwdjzdlO/ALerMlIGwdrKjTHZbj3t4QTihCW9XdiSQLjrH5b/2BqJKdPNSZV5RwRjGweuwO3FpIRXsA6xlB6qwhC/Es8N21UgAYiLUWvx8+/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YyW+Ri1L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744631184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zjO+mv63DF8OWXZ5ZxlPzpl6bC2oyYwvBcdRfK7EHgs=;
	b=YyW+Ri1LouoYiQ6jEOLNP7tC7xviKPrPKuKXiEml4RBIDw7tE3C/Xk2aIzrhjtoZpsNyYm
	rZtinFTAy0Iefsaof/nQodpoF/JMvyWojruxjTtJ/R0DDtNzQqS5D06PImqK3rtPT1aEI4
	EXWzpklgoqJZLrm1MHO/l4w8ICotJL0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-bz2p-wA2PiSAslNNA6DtUg-1; Mon, 14 Apr 2025 07:46:22 -0400
X-MC-Unique: bz2p-wA2PiSAslNNA6DtUg-1
X-Mimecast-MFC-AGG-ID: bz2p-wA2PiSAslNNA6DtUg_1744631182
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cfda30a3cso23492755e9.3
        for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 04:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744631181; x=1745235981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjO+mv63DF8OWXZ5ZxlPzpl6bC2oyYwvBcdRfK7EHgs=;
        b=jxQUQ8o7dEnq+r4ekyQEsTGm6f8K79JdBeyXDO6oDKOMI88sG5BvMWrXmW4qJ0XZ3u
         p06C/lX821Dj2rPa2wy90412LypJk2+UQGGVSBfTy3wZfjxTueQZikAhoSeSiSJMdsFj
         9r6cPYW/GsVsoP3CL4ozBHd3tqk7VDXAWFYF6S/Mouf0FJrHsUJVeIQmJSTS2mS88MVd
         KLPPW+Q2kZ4zj2ntFCqTKoHfdvjaRaH6ieiaFOd0z6GN1P9sCe/oZMaTfAqD0uhIEV17
         rk7+BRBifEkcyMbbrWUuX/tRlhKKkuezTlY3Z4Q5KT/JCueYSGcS96GrnnoIh+q0Vc8K
         rc2A==
X-Forwarded-Encrypted: i=1; AJvYcCVZdCZTvqeqS4/ZDVI9PKgAIkKOmCTMg7ftx8hszM7uFntDeDAMH74flkJNObnIiuXYVFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YysnIXEqrisbdt2pWjitN9d0KVCbCh15IZyAIJedRbWswuN4i4t
	l/tU/gi3FLFAWRA3I24sfuEprkHWh/54ZPrzq7x8eJugnFdyt6ARR8sa8hG1eGl9ws1gEsTm4dj
	CVk22WYMV4Zn7bTcT05glpNJ+I9ODw/DsrNNuuEQ4iS72fvGm1g==
X-Gm-Gg: ASbGncuwLdcw5wBt58cvF2tFPr2tPQR0gNAbldOFD4lOKQt4ABLObERfFEh0z7cAZzF
	eEifizwZxkFPs7us3MXebkFTnQeqmOKWjN79Ovfb9J8F4dwGV/F3X5xiaZN5Ay2pMeSV0SjT4pE
	1WYa6OL0YBaX/5NXlyTLGPsAfmao59//dVUlA0nn6uEtO+EVTbaIPX2T5xz14/t+jZ4qk1HhFJk
	siq5qby7C4DojW55rv1ChtpaYqdIGUCc6mkrCIStCrCLKcez+jVrLjUjtX/ppy6faguve08OukI
	AJqxww==
X-Received: by 2002:a05:600c:810b:b0:43c:f61e:6ea8 with SMTP id 5b1f17b1804b1-43f3a926c29mr101650445e9.2.1744631181500;
        Mon, 14 Apr 2025 04:46:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq+5ke4eamrk9xDN2am47+k03CAk53gsv1lkSszP4cGrTySTbHEceig7E6SA/uputECe8AcA==
X-Received: by 2002:a05:600c:810b:b0:43c:f61e:6ea8 with SMTP id 5b1f17b1804b1-43f3a926c29mr101650165e9.2.1744631181039;
        Mon, 14 Apr 2025 04:46:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96c074sm10536365f8f.28.2025.04.14.04.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 04:46:20 -0700 (PDT)
Date: Mon, 14 Apr 2025 07:46:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
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
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/3] virtio-net: disable delayed refill when pausing rx
Message-ID: <20250414074407-mutt-send-email-mst@kernel.org>
References: <20250414050837.31213-1-minhquangbui99@gmail.com>
 <20250414050837.31213-2-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414050837.31213-2-minhquangbui99@gmail.com>

On Mon, Apr 14, 2025 at 12:08:35PM +0700, Bui Quang Minh wrote:
> When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
> napi_disable() on the receive queue's napi. In delayed refill_work, it
> also calls napi_disable() on the receive queue's napi.  When
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
> This commit adds virtnet_rx_(pause/resume)_all helpers and fixes up the
> virtnet_rx_resume to disable future and cancel all inflights delayed
> refill_work before calling napi_disable() to pause the rx.
> 
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 60 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 51 insertions(+), 9 deletions(-)


Thans for the patch! Yes something to improve:

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7e4617216a4b..4361b91ccc64 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3342,10 +3342,53 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	return NETDEV_TX_OK;
>  }
>  
> +static void virtnet_rx_pause_all(struct virtnet_info *vi)
> +{
> +	bool running = netif_running(vi->dev);
> +
> +	/*
> +	 * Make sure refill_work does not run concurrently to
> +	 * avoid napi_disable race which leads to deadlock.
> +	 */
> +	disable_delayed_refill(vi);
> +	cancel_delayed_work_sync(&vi->refill);
> +	if (running) {
> +		int i;
> +
> +		for (i = 0; i < vi->max_queue_pairs; i++) {
> +			virtnet_napi_disable(&vi->rq[i]);
> +			virtnet_cancel_dim(vi, &vi->rq[i].dim);

duplicates a bit of code from virtnet_rx_pause_all.


> +		}
> +	}
> +}
> +
> +static void virtnet_rx_resume_all(struct virtnet_info *vi)
> +{
> +	bool running = netif_running(vi->dev);
> +	int i;
> +
> +	enable_delayed_refill(vi);
> +	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		if (i < vi->curr_queue_pairs) {
> +			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> +				schedule_delayed_work(&vi->refill, 0);
> +		}
> +
> +		if (running)
> +			virtnet_napi_enable(&vi->rq[i]);
> +	}
> +}
> +
>  static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>  {
>  	bool running = netif_running(vi->dev);
>  
> +	/*
> +	 * Make sure refill_work does not run concurrently to
> +	 * avoid napi_disable race which leads to deadlock.
> +	 */
> +	disable_delayed_refill(vi);
> +	cancel_delayed_work_sync(&vi->refill);


Maybe rename this e.g. __virtnet_rx_pause ?


>  	if (running) {
>  		virtnet_napi_disable(rq);
>  		virtnet_cancel_dim(vi, &rq->dim);
> @@ -3356,6 +3399,7 @@ static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
>  {
>  	bool running = netif_running(vi->dev);
>  
> +	enable_delayed_refill(vi);
>  	if (!try_fill_recv(vi, rq, GFP_KERNEL))
>  		schedule_delayed_work(&vi->refill, 0);
>  
> @@ -5959,12 +6003,12 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  	if (prog)
>  		bpf_prog_add(prog, vi->max_queue_pairs - 1);
>  
> +	virtnet_rx_pause_all(vi);
> +
>  	/* Make sure NAPI is not using any XDP TX queues for RX. */
>  	if (netif_running(dev)) {
> -		for (i = 0; i < vi->max_queue_pairs; i++) {
> -			virtnet_napi_disable(&vi->rq[i]);
> +		for (i = 0; i < vi->max_queue_pairs; i++)
>  			virtnet_napi_tx_disable(&vi->sq[i]);
> -		}
>  	}
>  
>  	if (!prog) {
> @@ -5996,13 +6040,12 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  		vi->xdp_enabled = false;
>  	}
>  
> +	virtnet_rx_resume_all(vi);
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		if (old_prog)
>  			bpf_prog_put(old_prog);
> -		if (netif_running(dev)) {
> -			virtnet_napi_enable(&vi->rq[i]);
> +		if (netif_running(dev))
>  			virtnet_napi_tx_enable(&vi->sq[i]);
> -		}
>  	}
>  
>  	return 0;
> @@ -6014,11 +6057,10 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  			rcu_assign_pointer(vi->rq[i].xdp_prog, old_prog);
>  	}
>  
> +	virtnet_rx_resume_all(vi);
>  	if (netif_running(dev)) {
> -		for (i = 0; i < vi->max_queue_pairs; i++) {
> -			virtnet_napi_enable(&vi->rq[i]);
> +		for (i = 0; i < vi->max_queue_pairs; i++)
>  			virtnet_napi_tx_enable(&vi->sq[i]);
> -		}
>  	}
>  	if (prog)
>  		bpf_prog_sub(prog, vi->max_queue_pairs - 1);
> -- 
> 2.43.0


