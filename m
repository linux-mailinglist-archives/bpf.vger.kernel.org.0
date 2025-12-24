Return-Path: <bpf+bounces-77422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12962CDCF7A
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 18:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4545C3024E55
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 17:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62440329C7A;
	Wed, 24 Dec 2025 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCYro+8z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B953A3195EA
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766598601; cv=none; b=mrulUSBQVcxE+oS8A619MYJwb8r8utkVN/03kjXJ2RlpGMqhs+x3Ttrf5b2KUPIulT0n1sm8Q3scAQmcYfm5wNuDN0XL8T+1XDDKl/rt7bvG6JSBRTXwrk+YbSHREwAbbGAPh04zTFekN+AHBp1daDWGWgihG3aJs6zjFzxSTrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766598601; c=relaxed/simple;
	bh=Uy2GuzMWLXSScd2jys7HD/4lMT6yYktAwCAK7y1dxs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hofr3XvPyIw+H9JfCx15g7u5fJ5PoQmFIRCCEHYXsQHb3Og4X3qCGGV8hj0eWAoOxu/zDO1OZlpP2vXkkEf759onifZiWtG+RO6Brd8w9eUan5Y2EancXn0tYIgdpjnr4YA+XwxgTxqfSl20MD3pozND8D1X3BNYKe43WhZQFUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCYro+8z; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so4824304b3a.0
        for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 09:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766598596; x=1767203396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dyaIVMgw4ATEaUXqxaNcG5tML3N8wIlrK8h87W4urnk=;
        b=nCYro+8zzvCeE6Xo914YmQ4yIBts6jU6oEjNKLyBU/AFVWdhLGZVeA/lsRPsk7zwny
         8l6aI1dRonJ54hb2ARkUggAYIexArm6icOOrJxR89jO384d8zAaB+YCqRuay/cnxYAOH
         J+kAMe3tc9YVAcsezF+3d2cMEEIwkyjWmgFFcvMidNs3heR2lXmy5CAkeypAWJqCgoQZ
         pg90xoG67xAd1XdTyZCinpl1zwiAy9cAH2rVMNkBpR+6VCOqGed3TiLs5CR/8i8Y5+r2
         ZSWpYHxtxBCktIwFzTmwiS6wBM6m+rMorD093XijjNekJnxMKtVtuberh5cv3tipq9/C
         Dp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766598596; x=1767203396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dyaIVMgw4ATEaUXqxaNcG5tML3N8wIlrK8h87W4urnk=;
        b=o18PvH60VVB4lAlHfdmvi5nXLBrufwRhOHvnRCF/dJs/OdnAfwqVSUt8xcNquUyxHN
         uhzt4ZNubfbdE50T2RscvomJN9J/m6a16Ii49nXJkKT+/97P35lnBnw82vgtEJmlhpAQ
         xFNMlHoPb8OguBuQ181ymnwUHKstRHkl8EY4Ioj2sLd7KmJPPscoRYFdoBTLipvTIUBa
         42JZps6Uj94Fzjs8Zf7a8XcufXibcTKw7CjC1cHfOKpfMcjb+eL9QzmRHhPK+wRZlCMz
         Tmnl0NTULH1T03tIen8k6o8H8kwzTCNqbVLVN/cUxSKiwQPpc9eRhUab5yf+t3PHHagI
         OOyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYmhWh2hYArGiFvQl21Y9qjdFdkaqtfsxrl4ZpI3e09qxsFYmwxsXUuPipBaK3JfVwT/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTBzg2vL2v+J1gAcwzIkVTL6cEdvSot7Otwxu3oYYYmfltKV3U
	4LdYw7EZDAIxDzAxBxK+2j7dK9ogXgpeHibhbO6oMuwNHoP3A5Gv4Qxo
X-Gm-Gg: AY/fxX5jcbvCL07Lr/pMwIKAZx24/VFvcD/U7V1ppXuksW23lX7Fw4uRfRy6/HuvXmn
	VfpT3Tn1bIfRlXK62AVdkMFIgaUwpft5xgZ5uM5vH1OEpAmm/PLBFBbtXYWah1mldvty1UwFKb2
	/15XvSLch3O+XuFYtQqygnqCOzzUeYegz8ILtoFnkZpxSp7XrqTgdHDsCCVHWrItJYplDrSKLeR
	VOzHJRDx/x0suAapve6S7gSp8RnloXawz7+ueZtyH/+lEpSn6xiA1i8R3l1iE7Z17L9qzE+rzkH
	gOpUEVAvyl0w/cZDM08Lycasaww/n1zoxvZLM17vL3Pfk8l9ahsVswpY/QkYOR7LmePJIrPnu7Y
	U7cvH+RdTdHE/cM6M0jrLFHYeoUOKOoAOndvp3UXRaZJN4VTVSrj/xC3cCwLoCAOSf1He+cWyHF
	Md68fQfzLUuzDaILBqC8NUygZX0e9MnYVRsgPs4tGrmHVCawfN4xIgfgjBPN0=
X-Google-Smtp-Source: AGHT+IGqeYfA0scfRJSZs642UZrJmT7+8QWmvt0tszu/L1Nmzf2uk5Nb/WZyy+4ewshxFonCJ6CNgQ==
X-Received: by 2002:a05:6a00:e13:b0:781:2291:1045 with SMTP id d2e1a72fcca58-7ff64fc5fd4mr15854544b3a.8.1766598596164;
        Wed, 24 Dec 2025 09:49:56 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:c711:242:cd10:6c98? ([2001:ee0:4f4c:210:c711:242:cd10:6c98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e0a19besm17215370b3a.40.2025.12.24.09.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 09:49:55 -0800 (PST)
Message-ID: <3acaaca3-37b3-4104-ac5a-441f3d4243c6@gmail.com>
Date: Thu, 25 Dec 2025 00:49:49 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] virtio-net: ensure rx NAPI is enabled before
 enabling refill work
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
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-3-minhquangbui99@gmail.com>
 <20251223203908-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20251223203908-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/24/25 08:45, Michael S. Tsirkin wrote:
> On Tue, Dec 23, 2025 at 10:25:32PM +0700, Bui Quang Minh wrote:
>> Calling napi_disable() on an already disabled napi can cause the
>> deadlock. Because the delayed refill work will call napi_disable(), we
>> must ensure that refill work is only enabled and scheduled after we have
>> enabled the rx queue's NAPI.
>>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 31 ++++++++++++++++++++++++-------
>>   1 file changed, 24 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 63126e490bda..8016d2b378cf 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3208,16 +3208,31 @@ static int virtnet_open(struct net_device *dev)
>>   	int i, err;
>>   
>>   	for (i = 0; i < vi->max_queue_pairs; i++) {
>> +		bool schedule_refill = false;
>
>
>> +
>> +		/* - We must call try_fill_recv before enabling napi of the same
>> +		 * receive queue so that it doesn't race with the call in
>> +		 * virtnet_receive.
>> +		 * - We must enable and schedule delayed refill work only when
>> +		 * we have enabled all the receive queue's napi. Otherwise, in
>> +		 * refill_work, we have a deadlock when calling napi_disable on
>> +		 * an already disabled napi.
>> +		 */
>
> I would do:
>
> 	bool refill = i < vi->curr_queue_pairs;
>
> in fact this is almost the same as resume with
> one small difference. pass a flag so we do not duplicate code?

I'll fix it in next version.

>
>>   		if (i < vi->curr_queue_pairs) {
>> -			enable_delayed_refill(&vi->rq[i]);
>>   			/* Make sure we have some buffers: if oom use wq. */
>>   			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
>> -				schedule_delayed_work(&vi->rq[i].refill, 0);
>> +				schedule_refill = true;
>>   		}
>>   
>>   		err = virtnet_enable_queue_pair(vi, i);
>>   		if (err < 0)
>>   			goto err_enable_qp;
>> +
>> +		if (i < vi->curr_queue_pairs) {
>> +			enable_delayed_refill(&vi->rq[i]);
>> +			if (schedule_refill)
>> +				schedule_delayed_work(&vi->rq[i].refill, 0);
>
> hmm. should not schedule be under the lock?

I see that schedule is safe to be called concurrently.

     struct work_struct {
         atomic_long_t data;
         struct list_head entry;
         work_func_t func;
     #ifdef CONFIG_LOCKDEP
         struct lockdep_map lockdep_map;
     #endif
     };

The atomic_long_t field to set pending bit and worker pool's lock help 
with the synchronization.


>
>> +		}
>>   	}
>>   
>>   	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
>> @@ -3456,11 +3471,16 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>>   	bool running = netif_running(vi->dev);
>>   	bool schedule_refill = false;
>>   
>> +	/* See the comment in virtnet_open for the ordering rule
>> +	 * of try_fill_recv, receive queue napi_enable and delayed
>> +	 * refill enable/schedule.
>> +	 */
> so maybe common code?
>
>>   	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
>>   		schedule_refill = true;
>>   	if (running)
>>   		virtnet_napi_enable(rq);
>>   
>> +	enable_delayed_refill(rq);
>>   	if (schedule_refill)
>>   		schedule_delayed_work(&rq->refill, 0);
> hmm. should not schedule be under the lock?
>
>>   }
>> @@ -3470,18 +3490,15 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
>>   	int i;
>>   
>>   	for (i = 0; i < vi->max_queue_pairs; i++) {
>> -		if (i < vi->curr_queue_pairs) {
>> -			enable_delayed_refill(&vi->rq[i]);
>> +		if (i < vi->curr_queue_pairs)
>>   			__virtnet_rx_resume(vi, &vi->rq[i], true);
>> -		} else {
>> +		else
>>   			__virtnet_rx_resume(vi, &vi->rq[i], false);
>> -		}
>>   	}
>>   }
>>   
>>   static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
>>   {
>> -	enable_delayed_refill(rq);
>>   	__virtnet_rx_resume(vi, rq, true);
>>   }
> so I would add bool to virtnet_rx_resume and call it everywhere,
> removing __virtnet_rx_resume. can be a patch on top.

I'll create another patch after this patch to clean up the 
__virtnet_rx_resume in the next version.

Thanks,
Quang Minh.

>
>>   
>> -- 
>> 2.43.0


