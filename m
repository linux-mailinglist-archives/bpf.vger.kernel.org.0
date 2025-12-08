Return-Path: <bpf+bounces-76290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B0BCADA44
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 16:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF92E3062910
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 15:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FA423EA8D;
	Mon,  8 Dec 2025 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STVmL7as"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4987019DF4F
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765208916; cv=none; b=sKvul6o5ASQIYkLu+mGQ8MOGrdwIgjn15Kzxv4aS8BrBMT4BUbMgrTTv2oWrz4vLPNabaqfIsDBDJ5sgxvxiTyXGKYy9VPctMtX9C6bDbIoCWjoJpb1Df2p6XpYrdxpnlxh9dS1nC8cYTDShufJc3qo6HODSXsE5kypcx1cPsrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765208916; c=relaxed/simple;
	bh=GIe51SBbOV61i2OkQiV+hl9lrmVGOhg2GykPvA68RG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRKnTarhRygzKFQfrnZORTk7y2v6Wb7pI73O8PP2nHqhNxml6fNmKjobQgTmFQGQse1l5kGRzTl4uvwRkp//Mk+go7+h2WIvlZnYQvoComSiwGeJGTl1AVslqR98CJdQZOWkkyT7zJuOMLujjtCL83xcyX7/JDeJ38eImegDd3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STVmL7as; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2958db8ae4fso45103105ad.2
        for <bpf@vger.kernel.org>; Mon, 08 Dec 2025 07:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765208915; x=1765813715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HGv9aN7BEkdqP9E26uFmq1NkbKlMnXUqNJ54IveYt7c=;
        b=STVmL7asS+AruQm66X17T9x6/jeDQMxWIhrpM5mI/WgbPeBr3MYNZhfU9Ntf4a98/l
         +rdwm9Tyli1141IPB0JnlBkVEMBQQFKeENkfnt12m9McVS0y+Xgif7oj8vmTlfbL6rKO
         xElVFRN0D7kDYVHAWsyrMEfbENab8NRqYX4netEp6TWeACmQRT9vP25Avg4kxJsZCSlK
         ingWLJP0ZLr20t2q+XEUeZt38N6qV3jrNta7kXfAaHHYlCe9YBP40xUJwf01B+TUAbp3
         Da5pG8B7HAuywNmV7VKbSgCr7jxoALnuTg256sedaclPmOwqiLdoHL53EdnDQa+94wmF
         dwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765208915; x=1765813715;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGv9aN7BEkdqP9E26uFmq1NkbKlMnXUqNJ54IveYt7c=;
        b=I+ufcUDBjgxRwfpBa5jy+Yq6Z+IGLA+1jeImLve6/eOD8632ciaNXcZRDzvs/uvJEM
         1rIeDglxtf0eG8snVD2sxokiDoF0CR8w6+CFpZAWZjI5tHFb6bNgheYMoSW9RIpAUz70
         LrSXhyu6VtN/Jlgi47TDRDTy8TgYAHNVYuKoWWSjhbBE58l+rItBL2ZGTm0WujiTi7ft
         XAygg3X8xku954qcmScVnDqAWHe63wNk3wXHGA+dwOEiBsATeWu1W5YAUOi9BQJ8Xs2g
         yyBAzeh3AEhCRJFVWgM7gR1XDRJk7NXwk9bAz9i+/gg8wrl8ZfH9NbbNIXaCQ/+p+vjW
         Wr1g==
X-Forwarded-Encrypted: i=1; AJvYcCVTOlU+M3qZASUkhHL7W+qYtR8A4BM0kgjDo7qvl+286L511Kc4aqJnnj4bvnlYaaOhm4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx39YPdZ5/HdyMvQbRb2WjWKnLev/xhMxlYGuD5kEbZfpPEwo7
	P9cyt89QKRv/Ta96oQqA5AgTUPjl+ATEnNVxmwggT/3iEIuNztlXGVKE
X-Gm-Gg: ASbGncvesXIKz16TyhzC7utgUNWSPzaYy79CEHGrldW0FT3Ur5cwYLmCx7bGFEP0vgo
	PVqL8aOtBJYkNfFRpiKciHM+etnLULcpeJsb5/08XWjbHhrnDRvIWQbzJTP6iD7ppuvcXuWxlqQ
	ZVKoJu0NhIHeKB+ovNLvBwF5CNI6z0UZIfNydEn955r+SSsYyq5LJzLDG9U8Q/o+ypr9KumagjH
	1GkY4CCp6owHDDcr0MaMA2AHHJ1QCiWPgSZ5YhDIsvnomgpLuM3i74E0aTZiNYpyag7+m31+HQT
	noF1TFvX5+IJRq0RSUIBIBsiu+cshzidFbHN2HvqgHanP75dvaCiDXmBfeYCeJ/+a4diBZJK2N4
	KBD0mOH0fWkdfHGYZPEpWuYJnnSk5e80KZJZloXYM+leyoXZ3/WfJt8wRqUY4r31HuvGArGCgqm
	dIa6QcTfEhuTOQ4h96vNoOqbnBRd1+DQ6Bxd38pyaLv0pJh/Bw59xj+bz1qDWuZw==
X-Google-Smtp-Source: AGHT+IHXpWgQsZZVkYiBPmILc7RuvE2kIhv57m1OcBr+zSddLJY/KSgXIs3QQTHErJ1IF0Y6gXvhwg==
X-Received: by 2002:a17:902:f64e:b0:297:dde4:8024 with SMTP id d9443c01a7336-29df55763efmr81526195ad.23.1765208914432;
        Mon, 08 Dec 2025 07:48:34 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:2998:e0cd:90d5:9648? ([2001:ee0:4f4c:210:2998:e0cd:90d5:9648])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49ca50sm128075925ad.20.2025.12.08.07.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 07:48:33 -0800 (PST)
Message-ID: <39958cd6-3ab1-433a-8eed-129304bc059e@gmail.com>
Date: Mon, 8 Dec 2025 22:48:26 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: enable all napis before scheduling refill
 work
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251208153419.18196-1-minhquangbui99@gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20251208153419.18196-1-minhquangbui99@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/8/25 22:34, Bui Quang Minh wrote:
> Calling napi_disable() on an already disabled napi can cause the
> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
> when pausing rx"), to avoid the deadlock, when pausing the RX in
> virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
> However, in the virtnet_rx_resume_all(), we enable the delayed refill
> work too early before enabling all the receive queue napis.
>
> The deadlock can be reproduced by running
> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
> device and inserting a cond_resched() inside the for loop in
> virtnet_rx_resume_all() to increase the success rate. Because the worker
> processing the delayed refilled work runs on the same CPU as
> virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
> In real scenario, the contention on netdev_lock can cause the
> reschedule.
>
> This fixes the deadlock by ensuring all receive queue's napis are
> enabled before we enable the delayed refill work in
> virtnet_rx_resume_all() and virtnet_open().
>
> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

I forgot to add Cc:stable@vger.kernel.org. I will add in next version.

Thanks,
Quang Minh.

> ---
>   drivers/net/virtio_net.c | 59 +++++++++++++++++++---------------------
>   1 file changed, 28 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e04adb57f52..f2b1ea65767d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2858,6 +2858,20 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
>   	return err != -ENOMEM;
>   }
>   
> +static void virtnet_rx_refill_all(struct virtnet_info *vi)
> +{
> +	bool schedule_refill = false;
> +	int i;
> +
> +	enable_delayed_refill(vi);
> +	for (i = 0; i < vi->curr_queue_pairs; i++)
> +		if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> +			schedule_refill = true;
> +
> +	if (schedule_refill)
> +		schedule_delayed_work(&vi->refill, 0);
> +}
> +
>   static void skb_recv_done(struct virtqueue *rvq)
>   {
>   	struct virtnet_info *vi = rvq->vdev->priv;
> @@ -3216,19 +3230,14 @@ static int virtnet_open(struct net_device *dev)
>   	struct virtnet_info *vi = netdev_priv(dev);
>   	int i, err;
>   
> -	enable_delayed_refill(vi);
> -
>   	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		if (i < vi->curr_queue_pairs)
> -			/* Make sure we have some buffers: if oom use wq. */
> -			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> -				schedule_delayed_work(&vi->refill, 0);
> -
>   		err = virtnet_enable_queue_pair(vi, i);
>   		if (err < 0)
>   			goto err_enable_qp;
>   	}
>   
> +	virtnet_rx_refill_all(vi);
> +
>   	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
>   		if (vi->status & VIRTIO_NET_S_LINK_UP)
>   			netif_carrier_on(vi->dev);
> @@ -3463,39 +3472,27 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>   	__virtnet_rx_pause(vi, rq);
>   }
>   
> -static void __virtnet_rx_resume(struct virtnet_info *vi,
> -				struct receive_queue *rq,
> -				bool refill)
> -{
> -	bool running = netif_running(vi->dev);
> -	bool schedule_refill = false;
> -
> -	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> -		schedule_refill = true;
> -	if (running)
> -		virtnet_napi_enable(rq);
> -
> -	if (schedule_refill)
> -		schedule_delayed_work(&vi->refill, 0);
> -}
> -
>   static void virtnet_rx_resume_all(struct virtnet_info *vi)
>   {
>   	int i;
>   
> -	enable_delayed_refill(vi);
> -	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		if (i < vi->curr_queue_pairs)
> -			__virtnet_rx_resume(vi, &vi->rq[i], true);
> -		else
> -			__virtnet_rx_resume(vi, &vi->rq[i], false);
> +	if (netif_running(vi->dev)) {
> +		for (i = 0; i < vi->max_queue_pairs; i++)
> +			virtnet_napi_enable(&vi->rq[i]);
> +
> +		virtnet_rx_refill_all(vi);
>   	}
>   }
>   
>   static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
>   {
> -	enable_delayed_refill(vi);
> -	__virtnet_rx_resume(vi, rq, true);
> +	if (netif_running(vi->dev)) {
> +		virtnet_napi_enable(rq);
> +
> +		enable_delayed_refill(vi);
> +		if (!try_fill_recv(vi, rq, GFP_KERNEL))
> +			schedule_delayed_work(&vi->refill, 0);
> +	}
>   }
>   
>   static int virtnet_rx_resize(struct virtnet_info *vi,


