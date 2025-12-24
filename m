Return-Path: <bpf+bounces-77395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE0ECDB1BB
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 02:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C1BD301F8CE
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 01:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C641DED5C;
	Wed, 24 Dec 2025 01:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gz9FLA0E";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyotNl45"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F081ADC83
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 01:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766540740; cv=none; b=TjYjylf6pulT3q29/NGv4ZFUTHxwt3+QiRDh2/XincjZ8hXIpSEQ8hNim4t0SoXBQK9yOQvwcmfFMRIQZQQZNtouKk4NwkaqIUR/rkILU/SBKJUOxOsmn482Nyv75W/kMj+vR5FjfbFZrpIJ0IWEboswMmrUMbvVo9p7f/KpXhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766540740; c=relaxed/simple;
	bh=qLZW3NS0wU1PkWXMkdS8e92GhST35BthsoRFkj6DtlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWQOqP8SiC1jtW6wlSq0h2W2FBIytkdpj/frJfgD1+lMxLkoqHO6PZW3dfOFYaH1tnA7ubLS8tLbLH7/G6dfbBHtNMTNU9hhyk1bNKntFaARbwIL9M12kLiIW4a5Kr2REnu4ipqr3ybZLO4tDfzI5Fjwi1Ypkh1Sf9KGIIhP8j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gz9FLA0E; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iyotNl45; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766540737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eE59yoVU4T1J/ye2BZHXCDqmQXZhh+ZWFAYfrcDt0hw=;
	b=Gz9FLA0EaixFdr0S+nEn+zY45PG17AaEpdynBvJHrG9QdVGOhdgTMRwNDE5hRBr4AfoDHF
	BTRymlfvoj6klcSrqdWGFBaFscsVU2vpTO8gdXN6SHc3MwyoC3SQa3a4Z8JoA9SK8E41Wr
	KVBgWnTWVj7gWzd5EQcZJps5wqM6GDQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-QNAOkRkxMCSJzOo0Y2Y7Hw-1; Tue, 23 Dec 2025 20:45:36 -0500
X-MC-Unique: QNAOkRkxMCSJzOo0Y2Y7Hw-1
X-Mimecast-MFC-AGG-ID: QNAOkRkxMCSJzOo0Y2Y7Hw_1766540735
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42fdbba545fso3472304f8f.0
        for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 17:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766540735; x=1767145535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eE59yoVU4T1J/ye2BZHXCDqmQXZhh+ZWFAYfrcDt0hw=;
        b=iyotNl455yzAAiMgVNZTCBxGreZnKj8pO2drc8Gk5ZEkXLoPmoCqqhhdCCm0w7HegQ
         yeGZKjlQddaexTzuLK0V00MmT+drM8xCkDkU7hLCn502XTTkdB/dZ28TbJdbTFHbXKYt
         EfjcJBl9rBOoVA2rlkrQ+VdU6hkwTYP4sgEvjHxkIIL0IrNThpaz7/PL6LR+SJehjyZI
         bYd6+dupGqDxg0GkrTpkqUu7lbtpB9+RReaX4Yv2E+OVd9b5l2lR8lA/361tlGSWhlWt
         s0Adt3JH/TPWB7Hq31VOgR6Xf1A+YLBIRUHJLSx1vnvyC1GmZOm32t9h6EHiEVhLkWFs
         b+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766540735; x=1767145535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eE59yoVU4T1J/ye2BZHXCDqmQXZhh+ZWFAYfrcDt0hw=;
        b=OdBVgAtaRH7hS7Em/vfTA06OH3NX4IINPE7xmnK33dSVoRXAOrXosX6K9+ZXzxkhcw
         K268llo6/UG8bmCZV2TrHJYwQFbIyuTbzCA+v7HQYEPMIDGbO3XbQRDNg/cxNxecg72j
         tqZVq8phQK2bIN+SH8L0mtm0/wmh586DvfSLXL3zMUpvMZUtXdert3C9faXhenv1lKTm
         CLDDmtxVP7UNfkBnJhv8Tm8/ymRXA3XnP2M1NHHIuVZ1jk340vTs1dQjYbFYMzwV4CCd
         a2LnYVXxO3LXqzEm0AtXqnnxLIj8jNSxiDfG7MK5EhaniYG5OSGKGgWZWiZSpRSiIU3N
         MXDg==
X-Forwarded-Encrypted: i=1; AJvYcCV5z4CBifPbqD8FqIwk6F2HteKNl6Q1/vEUcERsJlQrxr9z3ue8Qk82p2B68rtEu0Sgr48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyoEwRl2pgbR/9122wd6GYK65d3X4LydqF5PXdJpEfHgmD/VCL
	6gmh8ankckeHDiHXU2e8+r6jSoD3xTzVpv9UryOA/YAxHx75/gXdWQmlkxcSpar9pwyDMf3sPbX
	0btSbk3eRAcrANAR5TbgZ4tCJ3ch7cP6s+/Cmf4cDMbLxitHpwgMrYA==
X-Gm-Gg: AY/fxX6MqXfT4gHjaKEtfhUXmTLVUEYreKITtAlalTmJXW3hk/m0p2qU8sjd5uu5uhE
	3IQA4MqlA/5ybmuPGEAHtIBCKULm6j8xaiVUeYLt3WthztKH1g+/aXxy3xwTLoP1wKdvKvjS/A4
	nuhceJCnsjscacqbuCFF2C2VSIcwevLWJ8GxMRFAgskEuM6gtu8P6lb/iQLOZj5DLk8yiHf36NR
	2p6diCiMoDPBR/o3/FkICXQKJW3REcZ/bw7DFcagwjug1Li0Jr71upZygTX/aFb7XLKVYQjOaPb
	v7C+BxHvvdLhfeT7ikjoliIULQj2a9SqF3i6zKE9AGycZZo9qjbQ17NGMr/5OMPrrhBraBvaLTW
	U
X-Received: by 2002:a05:6000:1889:b0:42b:2a41:f20 with SMTP id ffacd0b85a97d-4324e41725fmr18915024f8f.18.1766540734570;
        Tue, 23 Dec 2025 17:45:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrk944sB9ALtgrKmusKW3zRCVN5YKqSNp/nlu8sC1ya5zS0cqE0ZbPcPVKQitwZWGzuZSn8w==
X-Received: by 2002:a05:6000:1889:b0:42b:2a41:f20 with SMTP id ffacd0b85a97d-4324e41725fmr18914986f8f.18.1766540733985;
        Tue, 23 Dec 2025 17:45:33 -0800 (PST)
Received: from redhat.com ([31.187.78.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa46c0sm31426547f8f.34.2025.12.23.17.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 17:45:33 -0800 (PST)
Date: Tue, 23 Dec 2025 20:45:29 -0500
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
Message-ID: <20251223203908-mutt-send-email-mst@kernel.org>
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
> deadlock. Because the delayed refill work will call napi_disable(), we
> must ensure that refill work is only enabled and scheduled after we have
> enabled the rx queue's NAPI.
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


I would do:

	bool refill = i < vi->curr_queue_pairs;

in fact this is almost the same as resume with
one small difference. pass a flag so we do not duplicate code?

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


hmm. should not schedule be under the lock?

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

so maybe common code?

>  	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
>  		schedule_refill = true;
>  	if (running)
>  		virtnet_napi_enable(rq);
>  
> +	enable_delayed_refill(rq);
>  	if (schedule_refill)
>  		schedule_delayed_work(&rq->refill, 0);

hmm. should not schedule be under the lock?

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

so I would add bool to virtnet_rx_resume and call it everywhere,
removing __virtnet_rx_resume. can be a patch on top.

>  
> -- 
> 2.43.0


