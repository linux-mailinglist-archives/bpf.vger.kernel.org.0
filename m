Return-Path: <bpf+bounces-77969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 410CDCF9225
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 16:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29746301C950
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 15:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6900D34404F;
	Tue,  6 Jan 2026 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6vpMjOZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61997342539
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713959; cv=none; b=isW5oxRihvGAOLiKSanVT8XYdIr0hQGVBCEYe6KHNgNsF1B92qp/DSfASlrv1dXaQXEQHsCly+eZXVlIRlBe9ow1Ab64/M9BVM6RNRn9I4yCoGnhd37AgnRQCwjQrll+BAfYxNtAMwS1MQD/QwwE5/9/xwAydKFKx8M7pZKehb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713959; c=relaxed/simple;
	bh=D4XuZS2ZZKPSGLViie1fG90SrMO9FTV7FKRiDM5R9zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ryq/TjI2IqJAE3/doeMFc1dOyQCDQWwWogg00GT+27SaomdiDFXdobMJ6lqI6iT5p9KvU76tiLii2BcSLHyOsuG4h6Yju75mRGu8Q0pLQ9xIbZPJVQVI2QyP7OOO3kwlqS7fPwuskr3Q6VUsUZ8/fAmOCFn+tX++Qesc+vOerP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6vpMjOZ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c1e7cdf0905so746346a12.0
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 07:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767713957; x=1768318757; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+nev3k8GrDkYwcfroMD2vo+UrG57sb0fdXcs5RtCMf0=;
        b=S6vpMjOZRqWdca3LDKcQDvfDsyo1UOKeorJcDUGSQzlM5emg7xtexu2X15h7m0qSeD
         Ibr57JuQu1xDKDfH7LbgoDYFdnyF9gQ8EjaDJbLIH2kmKFbH9eJLqQcIRgEd6CHGMdnf
         A/ArzBzGE753QkfZBGAAcNlDGwkSn7epFRCza2uhfJWjjLA5mdXHy4NdA4gw8ddZpDyx
         hAQZ69HfR4qfZaUY1M90NyELCql/nhKUztseYnNk13lMfvdq4doLX5BUnE2yLP5C/T2k
         mLs1glPgGlW2r/SOMMYa0z1tuMKkd/vTRkkKyePtz7WoZtlzEhUUhlPurlV0O7VPC1Lf
         OHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767713957; x=1768318757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nev3k8GrDkYwcfroMD2vo+UrG57sb0fdXcs5RtCMf0=;
        b=m/SPW7doXqndy9xqNsgRPYVxw7zimXjmlqoqlSdxzvOwxv2zacG74Y+8pmlrs5zRjh
         gMkU2NUNgJSxzgEDqSfl8GCYJs372OF0PY34BnmCVTVEwv/qto3SL9lQ8QIeseYhDLbD
         S5PvF9/NmR9qzzrAJOZxC+DlfD1R78gzDwNc48JdWC6xDJ5f2uu82WVu+k/l06ZyDNq/
         o0N+YoWAd5BOR3Y1/eNsi/oAotsyHM40qy1IYd2bdLSG/NAWuEPyyr7wv/35owt0ejMB
         ttXUXq3k8GxulO7Rw017BiA3BzzRfI304jM+O9evhJMIGQAldxKcWrWjkxFvhHNOUY/u
         obxg==
X-Forwarded-Encrypted: i=1; AJvYcCXpSPz/k4zLfnNl5z2AUzUdXvyh/eqApfVwIYr/Pl89ZdZxRiClm9pZGFieiDxJjqnvc20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7JtTNYylyU1NBZGfM6ZPtiOb9ux3EESiOY76HYzmUexmSUJ2y
	G+TIuiNzsQBJoe/Dmu2iI2QJ0KNmlluJwt58uBf4yNExNxtC2u31Nv5E
X-Gm-Gg: AY/fxX5oU27mtEt/e/D5p/dB5jQvVuNxm3bmTgKwy1vi4ABsitaPLfrfg03w1HU9QVC
	Adr+c+ou75pJi+wHcIaZ6Z9Fy/gXqCjLvkt1b1V/D5Fw8ISubKedUxNyjiaLNHj6mF+9LbhFYdZ
	iO7Lj1OlpYWkjYbqTx/u3GhdYexhuBHK44TQqUezgdzv9lPgKEmI2cioLsvfkSHIx70j8/hcrw7
	ekBwIz4TClbqDyYaH2K80bYIMRzUp8+iy7tx2ocD5XiipYb+nxySOWTYRhER3TqyBEgfTNLQYox
	J1z0gmtZBPPlv36ZUM0V+s3C7QEaXy9Gc2CHBcWB55mrUkdA3xAXrQlipju35WDRszXaTlGoRWr
	rCcrAFhWomTMTqxpbyBb02EpLca7E/6Nc4q1slXBjSMcShkpAbYlR0j8rq9S/Nczq5Mu7ex8yMK
	uzqrQuC3eN+PU49csXy4mn
X-Google-Smtp-Source: AGHT+IF0mZFbkjRBIubqLKVOfr698jKaejtisA/43GyJJji0AoxWu2L/C2JuZyOyvdKgIUNJcZv0HA==
X-Received: by 2002:a05:6a21:6da1:b0:366:584c:62ef with SMTP id adf61e73a8af0-389823c3f46mr3343295637.65.1767713956663;
        Tue, 06 Jan 2026 07:39:16 -0800 (PST)
Received: from [192.168.0.118] ([14.187.47.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc95d5f10sm2712050a12.26.2026.01.06.07.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 07:39:16 -0800 (PST)
Message-ID: <e8db28a3-61ae-4988-9ac6-ba67926056ab@gmail.com>
Date: Tue, 6 Jan 2026 22:39:09 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] virtio-net: don't schedule delayed refill
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
References: <20260106150438.7425-1-minhquangbui99@gmail.com>
 <20260106150438.7425-2-minhquangbui99@gmail.com>
 <20260106100959-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20260106100959-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/26 22:29, Michael S. Tsirkin wrote:
> On Tue, Jan 06, 2026 at 10:04:36PM +0700, Bui Quang Minh wrote:
>> When we fail to refill the receive buffers, we schedule a delayed worker
>> to retry later. However, this worker creates some concurrency issues.
>> For example, when the worker runs concurrently with virtnet_xdp_set,
>> both need to temporarily disable queue's NAPI before enabling again.
>> Without proper synchronization, a deadlock can happen when
>> napi_disable() is called on an already disabled NAPI. That
>> napi_disable() call will be stuck and so will the subsequent
>> napi_enable() call.
>>
>> To simplify the logic and avoid further problems, we will instead retry
>> refilling in the next NAPI poll.
>>
>> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
>> Cc: stable@vger.kernel.org
>> Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> and CC stable I think. Can you do that pls?

I've added Cc stable already.

Thanks for you review.

>
>> ---
>>   drivers/net/virtio_net.c | 48 +++++++++++++++++++++-------------------
>>   1 file changed, 25 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 1bb3aeca66c6..f986abf0c236 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3046,16 +3046,16 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>>   	else
>>   		packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
>>   
>> +	u64_stats_set(&stats.packets, packets);
>>   	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
>> -		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
>> -			spin_lock(&vi->refill_lock);
>> -			if (vi->refill_enabled)
>> -				schedule_delayed_work(&vi->refill, 0);
>> -			spin_unlock(&vi->refill_lock);
>> -		}
>> +		if (!try_fill_recv(vi, rq, GFP_ATOMIC))
>> +			/* We need to retry refilling in the next NAPI poll so
>> +			 * we must return budget to make sure the NAPI is
>> +			 * repolled.
>> +			 */
>> +			packets = budget;
>>   	}
>>   
>> -	u64_stats_set(&stats.packets, packets);
>>   	u64_stats_update_begin(&rq->stats.syncp);
>>   	for (i = 0; i < ARRAY_SIZE(virtnet_rq_stats_desc); i++) {
>>   		size_t offset = virtnet_rq_stats_desc[i].offset;
>> @@ -3230,9 +3230,10 @@ static int virtnet_open(struct net_device *dev)
>>   
>>   	for (i = 0; i < vi->max_queue_pairs; i++) {
>>   		if (i < vi->curr_queue_pairs)
>> -			/* Make sure we have some buffers: if oom use wq. */
>> -			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
>> -				schedule_delayed_work(&vi->refill, 0);
>> +			/* Pre-fill rq agressively, to make sure we are ready to
>> +			 * get packets immediately.
>> +			 */
>> +			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
>>   
>>   		err = virtnet_enable_queue_pair(vi, i);
>>   		if (err < 0)
>> @@ -3472,16 +3473,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>>   				struct receive_queue *rq,
>>   				bool refill)
>>   {
>> -	bool running = netif_running(vi->dev);
>> -	bool schedule_refill = false;
>> +	if (netif_running(vi->dev)) {
>> +		/* Pre-fill rq agressively, to make sure we are ready to get
>> +		 * packets immediately.
>> +		 */
>> +		if (refill)
>> +			try_fill_recv(vi, rq, GFP_KERNEL);
>>   
>> -	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
>> -		schedule_refill = true;
>> -	if (running)
>>   		virtnet_napi_enable(rq);
>> -
>> -	if (schedule_refill)
>> -		schedule_delayed_work(&vi->refill, 0);
>> +	}
>>   }
>>   
>>   static void virtnet_rx_resume_all(struct virtnet_info *vi)
>> @@ -3829,11 +3829,13 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>   	}
>>   succ:
>>   	vi->curr_queue_pairs = queue_pairs;
>> -	/* virtnet_open() will refill when device is going to up. */
>> -	spin_lock_bh(&vi->refill_lock);
>> -	if (dev->flags & IFF_UP && vi->refill_enabled)
>> -		schedule_delayed_work(&vi->refill, 0);
>> -	spin_unlock_bh(&vi->refill_lock);
>> +	if (dev->flags & IFF_UP) {
>> +		local_bh_disable();
>> +		for (int i = 0; i < vi->curr_queue_pairs; ++i)
>> +			virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
>> +
>> +		local_bh_enable();
>> +	}
>>   
>>   	return 0;
>>   }
>> -- 
>> 2.43.0


