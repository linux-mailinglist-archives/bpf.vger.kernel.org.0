Return-Path: <bpf+bounces-77760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AFECF09A7
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 05:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01260301AD02
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 04:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03BE2BE7CD;
	Sun,  4 Jan 2026 04:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX0dLO7W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFB17261D
	for <bpf@vger.kernel.org>; Sun,  4 Jan 2026 04:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767501210; cv=none; b=qmIQlOV6XlqE6+xEhTHbn3c5wyYPplxyHVOFAC8RpbELHkvXX1rVIFuxX08sWlH8WPIuHBPArUMBDJH8+IxFOK9JFKi2dKEcXf11rE5EvzCKJ7BAiSXtKFoRsZPujqaxICQyRNOFyB1lYt26cUQarleGiqejD4qaZT/iNzCio/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767501210; c=relaxed/simple;
	bh=Azwx+AL8KmSFQIQRgjJqUjmvNOX7v8ooqEUNYFJliwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NN9mZJdcqKC2ANZ4VvGlKfL1lOmg663oFxo2/zR7ft26FupWjbYi8SSg5MZof1j8OvJbbsrRBdMX/v2q09KbZTtwC4KRwjzr2/clxSHREkeTiP1EBoylVRsPuUlZxWhKgnZ104+1iS27WXTuvkAg9w+Mu4yZ2Um4X5fXERyJ2No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HX0dLO7W; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a2ea96930cso148894475ad.2
        for <bpf@vger.kernel.org>; Sat, 03 Jan 2026 20:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767501208; x=1768106008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qBW8X32z55Qusotc/ih9rFjkX9VkwnLcf6FQb4x2l9g=;
        b=HX0dLO7WzeWhfd6dkWCnKTz/BCvFxNvz7tMyEC0xfhlaIhhsvjs9RDvu3uHo5Ge6kJ
         /PUqdLQgYK7cF08Q6TFMJJoEMSHVEBU9nmljzPG9PKFTt8ZaVIz2658jfYZBRxhxHxbW
         10qBujQsB0S9f1jLnUZTcS8PK7RlwM4+fXUShPuZtnDlNJl6/TTjz0A+qp+8TK/lZvPp
         p/T16O0fiCeuJkDqcevJpQw9K3pcqvWAxrZSJX4L1RCG11ekumlHrbo7/5liuMJC3JWv
         zAcuDF28uLCu3aceOxw8wHXk5K2gOTVy4OQURiGRnXj9JBzKKxGveGukPYo5JZFTtcpT
         44+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767501208; x=1768106008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBW8X32z55Qusotc/ih9rFjkX9VkwnLcf6FQb4x2l9g=;
        b=Z+b4CCcOixQzjRRJ3vyNhC/myjnT8mp8PlLTeB4VtWgehpHri6Aac9Xfx5FYyshNlS
         OPjBHJ1Uhs5NgWTEL9QXdxIBOvRm9XMsz63kfPbxvHlZBi2rlbz70wqqUX2QaQRzvj2W
         6+J87hknttwsXB5CRpeOAJHrK8/KPLMI+aYx1nuHt/D3xFdklG7ad69bcxtCEeujaUt4
         dBc2SvQz4CswYvFsTpfkPwfSZC6ThuuKOYKQHAkickdMlsWXGAHqusvWYgpLuFxVAirT
         RcREPVmKt0oFBeER+ni6URbKjoF8j4GgjnIJG1dYl+cRoEKOX83Mtq8ZH8kl59oFychu
         aVuA==
X-Forwarded-Encrypted: i=1; AJvYcCVvZr3qjLQQoF1qbNzwGalKwcQkNOK2woaBM4ns9WMgcDM9Ob/aLXBDZO+Is+MoHEggHt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw4Pk/7RNIyPIBZ9q1EWtumrN5R97ns+l1jFkWg39DexI04k2F
	v5jsyG7J4xRT7FVnRkemQOigpPCBF565qgQcH6kVJLhA+nkPJMfmsecT
X-Gm-Gg: AY/fxX4XItABiXlbA0fTMISLsJQ4Fc3iO7ZZjI7wbvCSFYCI+zhC4UaDacxMqOFGIF3
	rR1DpzpnIMjRUe1rCeRrTL2gk+UpfyTnUrrerncbebH3bmi442rzHSL4WwjHEGvo7ttezQ7J97D
	hSLqDse1/YCFmgKCm5YYXXZS373nOAiht/fnHKMkCi0dU5eggGcjrYKdLp/xGAoHrGulqO+03HE
	n8PGxNwMlKcGRrGC4RE0bvKy8iyW2bTM/dFtYdIwtaNfAj/vJ/b7RukpJGu7RxnPNPhvlpFnqsX
	BXdq3URoasTmi8QIk0Uc8iu3h+rYT41FbmhiHpRi8nQ10n+4Q5yQS8DRoxmFM8FAQoLDFQ8yr+R
	XRQzuyU3DlAC5YV5IYGecNLiH80DEeor7JqHgkBeIcFX1A67qAeZ1wDVKfBnN5n2ASRA3pIc0wq
	P5AX08z6LHCAi2o3k+kA3PE0+ZD1TBNRjP66OhcR7jKxddwpG06o+i7HIgx01qig==
X-Google-Smtp-Source: AGHT+IHAP6HstceTiUON2ww82yVe7wKorskRc1Xlv8znyZhqX3KnfCKFkh0Us5J1NyViW6DnoWm9WQ==
X-Received: by 2002:a17:902:cf11:b0:2a0:b438:fc15 with SMTP id d9443c01a7336-2a2f2202f2cmr469738505ad.11.1767501207873;
        Sat, 03 Jan 2026 20:33:27 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:6eab:bb4c:4cd9:ccec? ([2001:ee0:4f4c:210:6eab:bb4c:4cd9:ccec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c828e6sm410760635ad.24.2026.01.03.20.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jan 2026 20:33:27 -0800 (PST)
Message-ID: <54e15e32-ee0d-4677-a85d-eb54ffe60a77@gmail.com>
Date: Sun, 4 Jan 2026 11:33:20 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/3] virtio-net: don't schedule delayed refill
 worker
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20260102152023.10773-1-minhquangbui99@gmail.com>
 <20260102152023.10773-2-minhquangbui99@gmail.com>
 <20260103115424-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20260103115424-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/3/26 23:57, Michael S. Tsirkin wrote:
> On Fri, Jan 02, 2026 at 10:20:21PM +0700, Bui Quang Minh wrote:
>> When we fail to refill the receive buffers, we schedule a delayed worker
>> to retry later. However, this worker creates some concurrency issues
>> such as races and deadlocks. To simplify the logic and avoid further
>> problems, we will instead retry refilling in the next NAPI poll.
>>
>> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
>> Cc: stable@vger.kernel.org
>> Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 55 ++++++++++++++++++++++------------------
>>   1 file changed, 30 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 1bb3aeca66c6..ac514c9383ae 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3035,7 +3035,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
>>   }
>>   
>>   static int virtnet_receive(struct receive_queue *rq, int budget,
>> -			   unsigned int *xdp_xmit)
>> +			   unsigned int *xdp_xmit, bool *retry_refill)
>>   {
>>   	struct virtnet_info *vi = rq->vq->vdev->priv;
>>   	struct virtnet_rq_stats stats = {};
>> @@ -3047,12 +3047,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>>   		packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
>>   
>>   	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
>> -		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
>> -			spin_lock(&vi->refill_lock);
>> -			if (vi->refill_enabled)
>> -				schedule_delayed_work(&vi->refill, 0);
>> -			spin_unlock(&vi->refill_lock);
>> -		}
>> +		if (!try_fill_recv(vi, rq, GFP_ATOMIC))
>> +			*retry_refill = true;
>>   	}
>>   
>>   	u64_stats_set(&stats.packets, packets);
>> @@ -3129,18 +3125,18 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>>   	struct send_queue *sq;
>>   	unsigned int received;
>>   	unsigned int xdp_xmit = 0;
>> -	bool napi_complete;
>> +	bool napi_complete, retry_refill = false;
>>   
>>   	virtnet_poll_cleantx(rq, budget);
>>   
>> -	received = virtnet_receive(rq, budget, &xdp_xmit);
>> +	received = virtnet_receive(rq, budget, &xdp_xmit, &retry_refill);
>>   	rq->packets_in_napi += received;
>>   
>>   	if (xdp_xmit & VIRTIO_XDP_REDIR)
>>   		xdp_do_flush();
>>   
>>   	/* Out of packets? */
>> -	if (received < budget) {
>> +	if (received < budget && !retry_refill) {
>>   		napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
>>   		/* Intentionally not taking dim_lock here. This may result in a
>>   		 * spurious net_dim call. But if that happens virtnet_rx_dim_work
>> @@ -3160,7 +3156,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>>   		virtnet_xdp_put_sq(vi, sq);
>>   	}
>>   
>> -	return received;
>> +	return retry_refill ? budget : received;
>>   }
>>   
>>   static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
>> @@ -3230,9 +3226,11 @@ static int virtnet_open(struct net_device *dev)
>>   
>>   	for (i = 0; i < vi->max_queue_pairs; i++) {
>>   		if (i < vi->curr_queue_pairs)
>> -			/* Make sure we have some buffers: if oom use wq. */
>> -			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
>> -				schedule_delayed_work(&vi->refill, 0);
>> +			/* If this fails, we will retry later in
>> +			 * NAPI poll, which is scheduled in the below
>> +			 * virtnet_enable_queue_pair
> hmm do we even need this, then?
>
>> +			 */
>> +			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
>>   
>>   		err = virtnet_enable_queue_pair(vi, i);
>>   		if (err < 0)
>> @@ -3473,15 +3471,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>>   				bool refill)
>>   {
>>   	bool running = netif_running(vi->dev);
>> -	bool schedule_refill = false;
>>   
>> -	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
>> -		schedule_refill = true;
>> +	if (refill)
>> +		/* If this fails, we will retry later in NAPI poll, which is
>> +		 * scheduled in the below virtnet_napi_enable
>> +		 */
>> +		try_fill_recv(vi, rq, GFP_KERNEL);
>
> hmm do we even need this, then?
>
>> +
>>   	if (running)
>>   		virtnet_napi_enable(rq);
>> -
>> -	if (schedule_refill)
>> -		schedule_delayed_work(&vi->refill, 0);
>>   }
>>   
>>   static void virtnet_rx_resume_all(struct virtnet_info *vi)
>> @@ -3777,6 +3775,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>   	struct virtio_net_rss_config_trailer old_rss_trailer;
>>   	struct net_device *dev = vi->dev;
>>   	struct scatterlist sg;
>> +	int i;
>>   
>>   	if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
>>   		return 0;
>> @@ -3829,11 +3828,17 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>   	}
>>   succ:
>>   	vi->curr_queue_pairs = queue_pairs;
>> -	/* virtnet_open() will refill when device is going to up. */
>> -	spin_lock_bh(&vi->refill_lock);
>> -	if (dev->flags & IFF_UP && vi->refill_enabled)
>> -		schedule_delayed_work(&vi->refill, 0);
>> -	spin_unlock_bh(&vi->refill_lock);
>> +	if (dev->flags & IFF_UP) {
>> +		/* Let the NAPI poll refill the receive buffer for us. We can't
>> +		 * safely call try_fill_recv() here because the NAPI might be
>> +		 * enabled already.
>> +		 */
> I'd drop this comment, it does not clarify much.

Here I want to note on why we can't use try_fill_recv like in other places.

>
>> +		local_bh_disable();
>> +		for (i = 0; i < vi->curr_queue_pairs; i++)
>> +			virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
>> +
>> +		local_bh_enable();
>> +	}
>>   
>>   	return 0;
>>   }
>> -- 
>> 2.43.0


