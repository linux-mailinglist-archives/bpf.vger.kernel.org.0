Return-Path: <bpf+bounces-77404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6637CDBF4F
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 11:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 835F130402CA
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 10:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E354313E2B;
	Wed, 24 Dec 2025 10:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eR4Lb9j+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="p8gIe8Fk"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBDB287268
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766571620; cv=none; b=NzI815uSdzB6LiFiNFBAb0/lmAB5++kZrO27OEME0f4cy2TwFComOwJLhkPDckHS5aWj5wSDcveIRMCM2EIQprhlBH/1xTCP5wsOLXaJPyUsbwAO6jTZAFKSmxWbJu2YwbV3OGwhtwbl+yfPbPHb0xaXQpSfj3h9Wc9oSVgzkN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766571620; c=relaxed/simple;
	bh=oYrwPO86ZCxudCbsRZuqfzHLWeJAOAoyrphKxk8LHjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnR8zuU0LO9HTRCDQB6eL9OfoYPmuhN06IYUyIKBR+SRc7WyUKNZdZ+FZV+XwC1Z2CFPpqDB3kpm4LUu3eopjoi8EiMTmU/pXrJoeF3htgKfW12Bau5+Yd7vaRY+bBqgXb/a43fXQQeirLt+riPcx4ACch6vOjFsEflCS0V+c/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eR4Lb9j+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=p8gIe8Fk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766571618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6O2EtwV8zLDpt91a2UuKYvEZqcHN8Sgzg6sMdCfF3b8=;
	b=eR4Lb9j+gs3NeiHv8lbAwcKiEBClAeHhnRNWx+bp9AmesBUqcGR/KUbxCMZNwC+JooT6Xh
	g6rLQksCedxdU3DhdzNHMfAZIj8A00tdI2e8aliOwJLOwzS1dIL2EruTT81FAmpZmv49uW
	sVHiarvldyaD3Spy54z3hvzefjhcxjQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-uXc8k9I1NoyIetdYwqbSiw-1; Wed, 24 Dec 2025 05:20:14 -0500
X-MC-Unique: uXc8k9I1NoyIetdYwqbSiw-1
X-Mimecast-MFC-AGG-ID: uXc8k9I1NoyIetdYwqbSiw_1766571613
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4325ddc5babso1625527f8f.0
        for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 02:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766571613; x=1767176413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6O2EtwV8zLDpt91a2UuKYvEZqcHN8Sgzg6sMdCfF3b8=;
        b=p8gIe8Fk542Na8IvMjt7FR9THEKInLYVKz7A2BKB+TLh0zlK3le6LT5nRblRxy3xYM
         NBGs8Gyz+3uGNYVeF6KN0SyZn1VpqTr1mNke9bvSopxGlOjlAotPEE7uCBz4PxSo+R9D
         uYFjrxGEpIbiqnqKTlIx+0HZ2AjI6lzTg9JaJZVtYxUQ7UEiq98yJi8Q/5U6PCYu0gwq
         n8k53XgfQmW5S2huII8+ZlesqsUc7BRZnUKv78Io1axlOw+xqsY1LgVQRhhpcqvC1RA8
         66emyeZpaIC8qQiDglkB4cssI6IcSRDSLvAHi/b9qFmK8HKdBNb2hT+U+0JsReh3v/cy
         zvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766571613; x=1767176413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6O2EtwV8zLDpt91a2UuKYvEZqcHN8Sgzg6sMdCfF3b8=;
        b=tDaCgY5+Clb1DneyWS08Ece6I0Kv+KSmgZzZ97jU1NP/BPUHgLFrJP492rlFwNEB66
         E37kGleTBfoe675Ob3ihVjAW5gz7BsI2DWZg6Tr2xlB2veiqPSWjKRWmypZ+4bf5TyO7
         2mjYIN8eYV1V+LTRqqpXSHOneOjehKrvhnEikLZVIIPUv85bvYjYoDq1I/dgdwjkg3vT
         0kswHTPR8DZociOn1UVuVQjtihtzrgD73K6u+aBgMuY7ORdNHgcq6/qWLeY91DTIsotp
         NK7BR22KX8FeZAAK1SJOAi8HosXoYxjUBI4IMzHAO6Fu/kyQ9cSUYCW5iMZd3jtPqe07
         doog==
X-Forwarded-Encrypted: i=1; AJvYcCVjcNoeNjI9DmFiFEcalGC2HFH+6oeI+dhmH3e6NDBuEdb3uOZPqOY5oUnfyPUh/QrAblE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySjFMSAKXLJz4d0QrjuArMP53PJe+HNwwlhpVJ76i50jabhsNB
	C1nrBwr+Zy4NNu6AX/CaI+0Uhlb4Yc9lZC281VJoUVHtLbkSVMJEgYaG6p9zgAJPk+cmkmBI6Fi
	Pig3r15u3YgZUi8ECcr0Z91a5QJe93YI6Ues47UnvEUlEytMkDXtn+Q==
X-Gm-Gg: AY/fxX4N0AprLyT4I9tJoFFXBQmwmAPpBoRcsAmqrxPCTfVG+emEob3mDoySQ/93A+2
	yYse7LT5puaTJmgMRk0gRnJF7bgCWx7TYxa9/Xyq+GFu0jvIbL0k4ddU3D8aeGw34nwDO/xYF5B
	g+Mg3K1BGgjtkTDQaF58qZwXkk8ZCgOkgvqeu0Vyq+N8umzbKRZgF44p9qkAesM1rCrpbuS7Pgh
	IN/LlkfS9v7MtjpyIh6oWrYEcrl8HfC6G5K0muq76fIuA+hKf2lY7WQVx28NYKxKH6CFclZrprF
	dqvI29pbISaBbkb6dy3RKutOAUUuP7GPnMIc39HIKTQHgRf7Zb4yLnjf1qo29mS/hLdTvQ6xmzK
	t
X-Received: by 2002:a05:600c:350c:b0:477:7658:572a with SMTP id 5b1f17b1804b1-47d19584900mr150239415e9.20.1766571613416;
        Wed, 24 Dec 2025 02:20:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmKYK5ou+1W1Pze+hjbzHTs9SfZ3rn+HzocgNknKunmQm1zT8c7gWFoIrC37NzpjjUkVO+xA==
X-Received: by 2002:a05:600c:350c:b0:477:7658:572a with SMTP id 5b1f17b1804b1-47d19584900mr150239105e9.20.1766571612873;
        Wed, 24 Dec 2025 02:20:12 -0800 (PST)
Received: from redhat.com ([31.187.78.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a40a14sm146641555e9.2.2025.12.24.02.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 02:20:12 -0800 (PST)
Date: Wed, 24 Dec 2025 05:20:09 -0500
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
	bpf@vger.kernel.org
Subject: Re: [PATCH net 2/3] virtio-net: ensure rx NAPI is enabled before
 enabling refill work
Message-ID: <20251224051936-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-3-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223152533.24364-3-minhquangbui99@gmail.com>

On Tue, Dec 23, 2025 at 10:25:32PM +0700, Bui Quang Minh wrote:
> Calling napi_disable() on an already disabled napi can cause the
> deadlock.

a deadlock?

> Because the delayed refill work will call napi_disable(), we
> must ensure that refill work is only enabled and scheduled after we have
> enabled the rx queue's NAPI.


a bugfix so needs a Fixes tag.

> 
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 63126e490bda..8016d2b378cf 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3208,16 +3208,31 @@ static int virtnet_open(struct net_device *dev)
>  	int i, err;
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		bool schedule_refill = false;
> +
> +		/* - We must call try_fill_recv before enabling napi of the same
> +		 * receive queue so that it doesn't race with the call in
> +		 * virtnet_receive.
> +		 * - We must enable and schedule delayed refill work only when
> +		 * we have enabled all the receive queue's napi. Otherwise, in
> +		 * refill_work, we have a deadlock when calling napi_disable on
> +		 * an already disabled napi.
> +		 */
>  		if (i < vi->curr_queue_pairs) {
> -			enable_delayed_refill(&vi->rq[i]);
>  			/* Make sure we have some buffers: if oom use wq. */
>  			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> -				schedule_delayed_work(&vi->rq[i].refill, 0);
> +				schedule_refill = true;
>  		}
>  
>  		err = virtnet_enable_queue_pair(vi, i);
>  		if (err < 0)
>  			goto err_enable_qp;
> +
> +		if (i < vi->curr_queue_pairs) {
> +			enable_delayed_refill(&vi->rq[i]);
> +			if (schedule_refill)
> +				schedule_delayed_work(&vi->rq[i].refill, 0);
> +		}
>  	}
>  
>  	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> @@ -3456,11 +3471,16 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>  	bool running = netif_running(vi->dev);
>  	bool schedule_refill = false;
>  
> +	/* See the comment in virtnet_open for the ordering rule
> +	 * of try_fill_recv, receive queue napi_enable and delayed
> +	 * refill enable/schedule.
> +	 */
>  	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
>  		schedule_refill = true;
>  	if (running)
>  		virtnet_napi_enable(rq);
>  
> +	enable_delayed_refill(rq);
>  	if (schedule_refill)
>  		schedule_delayed_work(&rq->refill, 0);
>  }
> @@ -3470,18 +3490,15 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
>  	int i;
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		if (i < vi->curr_queue_pairs) {
> -			enable_delayed_refill(&vi->rq[i]);
> +		if (i < vi->curr_queue_pairs)
>  			__virtnet_rx_resume(vi, &vi->rq[i], true);
> -		} else {
> +		else
>  			__virtnet_rx_resume(vi, &vi->rq[i], false);
> -		}
>  	}
>  }
>  
>  static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
>  {
> -	enable_delayed_refill(rq);
>  	__virtnet_rx_resume(vi, rq, true);
>  }
>  
> -- 
> 2.43.0


