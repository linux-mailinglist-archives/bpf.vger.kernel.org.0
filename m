Return-Path: <bpf+bounces-55951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A9FA89F43
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 15:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17471902C13
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 13:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D1E29A3E5;
	Tue, 15 Apr 2025 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ConTDff8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5A22973CD
	for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744723179; cv=none; b=c/MSBkmHbuVJBhL92Be9oyFWu9nNSaelgFVmgat/FzQPMTpDnGajHoi6Tokx0PofZCNEu69ezVukUHu0iim7JJ2yBw6hq+xTGAmqBdCKrhq4X9i3WeItKOQeKGYk0BQo5lxO/SXNdJ4sGeH9AsGbhW9YC0NgbH47NedlNo/f1+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744723179; c=relaxed/simple;
	bh=e9R32tQBSXYQd8goFfR+Lx7lJByV3tKzSiDQM/hj3JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tl0qL4zaPDIBhIbLdrf+wqxagJHTRqt6/RjbnFsNxZ8lF4YA9Fmpn8uBmVRcVWtdPqpyUbGuocNIYN82V/IMw2jZfSUpBjPS/E0eDS50O5AKY6Tlr76tD9BXOovXK1k0dBDRFQILM2KHtZDT1Mue5mLI7CLpQgKwPQuOCd5vXp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ConTDff8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744723176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HDFRVUvYARrrdoMVKwNSz9nrR/1vGVN5NRO4r+H+6kk=;
	b=ConTDff8aFmhqvWqp8FF2covwPRn0QAqp5AOgwI3ABnyPeTCxlvb8H2+U/LfwaHKNZ7lPe
	oF0BlzmeirzQFLfY3hNERpSfQzg6+cCvK9m9JBUjNAo19mo1NdEowgU4Jz3Ju2GJq103k/
	GONr0rfv37DNaIT/pl/CSdHxNYyJ59E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-cG8UmtSDMvabYJWtDV5lcA-1; Tue, 15 Apr 2025 09:19:33 -0400
X-MC-Unique: cG8UmtSDMvabYJWtDV5lcA-1
X-Mimecast-MFC-AGG-ID: cG8UmtSDMvabYJWtDV5lcA_1744723171
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912fe32a30so2275403f8f.1
        for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 06:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744723171; x=1745327971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDFRVUvYARrrdoMVKwNSz9nrR/1vGVN5NRO4r+H+6kk=;
        b=N5M1veM0z7zbkY3qVxLzy3xZ7z+wo/Wnau62PLVhMB7TbTEvFi0UCLOnOkPnsViqys
         Ec9ZYdmlv7uBJpnMz+hlcc5m0cSYLoU80EFBRKw0XkDyJns9zkaQoKQAU6US/vWn4g3d
         mNqYnz8dTX4JswFAXk615W3w2orAO/HcLbLrwrUwcq2lDykjxVXuZ7sDKCuKG2r6OEiJ
         i6yJVHmnAcQaXGIaqpATjqQWe0f5kvnadp4EWn+yIyQy6wZRRWOLEpenOA+jvyuJ3bep
         YEaXF0sfr2QoQd4QTorCW+UdOcpyIOUtF2ddpaErfmPhkJdtkz7rzxSjnuggAZL7knQk
         gGfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtIVjb6tmKxq5VNmi9uMyG1gD4n0ax4K9d/nPS5E5owbolo/OZNUqFDbyIW5YcHBx1gnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwJlpjoCG1XprrHfTAxghbLbZBEK0ZJOA07FjPiasFpAwT24/5
	Bt50bFaaxY6qKmRtAcagb/6xu6nzdwVOohe370Y2a5tDQMLbXB9fe5u90nf1tHCDdMon3hFBM6X
	wfnYvhXBYOqQbKj5F6SCsGyA0nAT+2WOri3TuAdRAsjRhXZAsQA==
X-Gm-Gg: ASbGncuwHmFlTOX6tM0d0/YuaMnWxPAzUsgW/onzwOUkr8xLAg/CniSS6yNT/zMVT0N
	xMcibHum3BDBw4xIKa52XJSIKpk2Yp6JuJA9jDQcpLQ9PYNWWtqlR/q0HDmGYKMh0lodnuijRaI
	Udav/dbv+xCvo3XD36cXou1g5L0ldWtnRDJB47rkbV+SCU6Lob3mF6IaOZ05StMeN3A4hZuLsvK
	g4ug7Agwf5kPvCAEYiHas9zqsFs5StcB90PQupI9nngN7tfhBFDKA68MYNPDuuZPShTjvoNKCA7
	/PHWfg==
X-Received: by 2002:a5d:6d82:0:b0:38f:2b77:a9f3 with SMTP id ffacd0b85a97d-39eaaecd9d3mr14812797f8f.43.1744723171094;
        Tue, 15 Apr 2025 06:19:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3g59/gkleqCg6T/d47/qE3AgIRCAsXkZY+0Zs8YtzSwtO0Ld+xwTSwCyCTlke980a+IysoQ==
X-Received: by 2002:a5d:6d82:0:b0:38f:2b77:a9f3 with SMTP id ffacd0b85a97d-39eaaecd9d3mr14812768f8f.43.1744723170724;
        Tue, 15 Apr 2025 06:19:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f206269c8sm217509515e9.16.2025.04.15.06.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 06:19:30 -0700 (PDT)
Date: Tue, 15 Apr 2025 09:19:26 -0400
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
Subject: Re: [PATCH v3 1/3] virtio-net: disable delayed refill when pausing rx
Message-ID: <20250415091917-mutt-send-email-mst@kernel.org>
References: <20250415074341.12461-1-minhquangbui99@gmail.com>
 <20250415074341.12461-2-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415074341.12461-2-minhquangbui99@gmail.com>

On Tue, Apr 15, 2025 at 02:43:39PM +0700, Bui Quang Minh wrote:
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

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 69 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 57 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7e4617216a4b..848fab51dfa1 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3342,7 +3342,8 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	return NETDEV_TX_OK;
>  }
>  
> -static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
> +static void __virtnet_rx_pause(struct virtnet_info *vi,
> +			       struct receive_queue *rq)
>  {
>  	bool running = netif_running(vi->dev);
>  
> @@ -3352,17 +3353,63 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>  	}
>  }
>  
> -static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
> +static void virtnet_rx_pause_all(struct virtnet_info *vi)
> +{
> +	int i;
> +
> +	/*
> +	 * Make sure refill_work does not run concurrently to
> +	 * avoid napi_disable race which leads to deadlock.
> +	 */
> +	disable_delayed_refill(vi);
> +	cancel_delayed_work_sync(&vi->refill);
> +	for (i = 0; i < vi->max_queue_pairs; i++)
> +		__virtnet_rx_pause(vi, &vi->rq[i]);
> +}
> +
> +static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
> +{
> +	/*
> +	 * Make sure refill_work does not run concurrently to
> +	 * avoid napi_disable race which leads to deadlock.
> +	 */
> +	disable_delayed_refill(vi);
> +	cancel_delayed_work_sync(&vi->refill);
> +	__virtnet_rx_pause(vi, rq);
> +}
> +
> +static void __virtnet_rx_resume(struct virtnet_info *vi,
> +				struct receive_queue *rq,
> +				bool refill)
>  {
>  	bool running = netif_running(vi->dev);
>  
> -	if (!try_fill_recv(vi, rq, GFP_KERNEL))
> +	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
>  		schedule_delayed_work(&vi->refill, 0);
>  
>  	if (running)
>  		virtnet_napi_enable(rq);
>  }
>  
> +static void virtnet_rx_resume_all(struct virtnet_info *vi)
> +{
> +	int i;
> +
> +	enable_delayed_refill(vi);
> +	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		if (i < vi->curr_queue_pairs)
> +			__virtnet_rx_resume(vi, &vi->rq[i], true);
> +		else
> +			__virtnet_rx_resume(vi, &vi->rq[i], false);
> +	}
> +}
> +
> +static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
> +{
> +	enable_delayed_refill(vi);
> +	__virtnet_rx_resume(vi, rq, true);
> +}
> +
>  static int virtnet_rx_resize(struct virtnet_info *vi,
>  			     struct receive_queue *rq, u32 ring_num)
>  {
> @@ -5959,12 +6006,12 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
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
> @@ -5996,13 +6043,12 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
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
> @@ -6014,11 +6060,10 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
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


