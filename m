Return-Path: <bpf+bounces-55638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C669CA83C31
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 10:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1BD93A2CF8
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 08:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9041EBA03;
	Thu, 10 Apr 2025 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqiiYjQ+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F151B85F8;
	Thu, 10 Apr 2025 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744272563; cv=none; b=HMvF49VGJNBJAdf7I1xOMTO+5QpZz9fk8OvtbvYonGDDWLFnIXleqZX/K7JKUqektL/ufBgokXn9Hb2nA2D1ymTwyCUT62BDt7cf9ziaLDjOalIqpSA5V9zb4J0LPphZvI5hka6ABXy7/KnWXeFXnan/U7sH87vDThXrsd+1B28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744272563; c=relaxed/simple;
	bh=Vyno924JZezqTnFi39JNlTWkIO0+AmDF/Z/qP+4RgJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AqhA6P1ygwuytcrIHzc8hYed89nIe32zqK9HEuD4ZKvYK5jVMubYSk8E4qRtWoVsdDI5MyYffB5mRFi0i0H75ZnAYn4JUK7xVCwQ8KBaqIL++he0Qj/ZavvJAS5Y6h6Qcfc6LYZ803Vs3059It8c20LQ2chtG+rAEwKegbWQJGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqiiYjQ+; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af6a315b491so555700a12.1;
        Thu, 10 Apr 2025 01:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744272561; x=1744877361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AjG0X0ILsaEZt1vBf8MVQgDYPYTp29VUnEYLYjosri4=;
        b=UqiiYjQ+DKxd5CciMNKBKpygRw1wjcqh2lMMMNLIVQKJm4LGb1u8gS5KMBYEEY3Hlc
         zQpf1skvMLeHbDuUAFYt6YTvbQIJSTkPYR70x0IZKWF5hT7Ry+cSkWueokxflcTTSl29
         /2otoLCUlFi9Pq8u2NPANayjWz0FBTD8HcKBjo8TlFpHM7tmI8tAqxrbEiyQcf0whs5T
         n/Ad+PD5oyS0f5Ot4mHpJkExXq4LN0o8LHLuzBGg486xfVNhYTSDGuurdxl7sJCUB6cS
         uOOpF6PQ7DD7kRIrGXs1gBYL/qC86hB6WbnbZXWeJ/nELvjDQ0WLMxkwEJCEYSAsBZTl
         t1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744272561; x=1744877361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AjG0X0ILsaEZt1vBf8MVQgDYPYTp29VUnEYLYjosri4=;
        b=n2Db9YvA1pqoumJwlw2EZqYl3AOp0GQuTM/9unhFrf9WXDim4D3WOv336AGhXmHdHP
         aJk6UcZ/CgZLCYkFmc1GoqsWLBeo7PG/bQpjb6gMVKuqk6nnTNm461SmyYj/0vAwx/c2
         JmxRXiNfhu2FDhbXjB00JeqBy5ROg98U6wVYGEqZQMwuMBeiwgDrfrjwlLPVZxxkJezs
         xLEOLBN342AsVNO1AIqz4hA/kWRXO+1W9IaL+EzlgHGKc3XuT1FehCS4r/6gb3MTMaPk
         gDIdX3rAJuXB72SQSBc2tG8GTz26Npfoitm6NjGlAwjmjUhd/FxQTwK0BJk5f+XixLSR
         l4Og==
X-Forwarded-Encrypted: i=1; AJvYcCVi2CiBE2PQgdT6kTHA2vtc33fZd8UjILS2NV/ggy9QOyn9zUIX53Lt4crhkQ7x7CIQRiH00ouN@vger.kernel.org, AJvYcCWBGz5hBWwMhGKz+EyduqqyYgDrAvy91gJCibpFHUKWcEWYoeYYgnj42pw+WWRXEPNenp+HtmjnAX4EVOiA@vger.kernel.org, AJvYcCXHBEBZHjHN4GcVd6ujqUVDo9T+kq7Mse0zQLlF+rvmaYpW+QVMqtaZDGuAdGAfuXiH9zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG5EmjKWnMe+USi7tZrbmxdofvrXjvxyFjOtdAi38fUPIB4Z2X
	hfrfSSEHN64yCiusmpSVf9YaE56ZeV6Nd+5tj1SHNcZ05Fy5o+8L
X-Gm-Gg: ASbGncvvbHmpFiGLYuddaEYhW9MFWegjsYEa7RjNNpf4rDo4ljjjVJUGFiJ30HQk+Yf
	mlCE/QluMFEkeMolMHBuX1piWW69ZJCH+SmB/YQ+PbYeQfmxQaeb2hwh/dPsBKeIDBOeF7ZPh78
	zo1baX4ViaPy8KWJRMlnlipO6reSlRksJ1nMnbtn7JEE1VW7ynX7tg6SvV+7nYjOz9+fADOSSSy
	NfIEOft/4jsrNK2wVCBA1x6ejjQCDiI6cG1iMbWhQyJrq9ULyv9KHwc7v+eIIV5Bdte0Ku2/r/p
	soCpOTvislZ+yNJ1tKtKqJfJqD+oOsS6X1Mv/Q/Ih99YNrok/5SEiNi5kqC43uAILFkqHwwYd+H
	MtvsdD3YbY7DgultaeJg=
X-Google-Smtp-Source: AGHT+IGlFaX35JSmF5xXiiSbldTiaLvL6d+ktyX+51i5YLyTONObh2bMZLgvRVqMK1AZZfqqaQtgRg==
X-Received: by 2002:a17:90a:d64b:b0:2ee:f687:6acb with SMTP id 98e67ed59e1d1-30718b76a8emr2884244a91.13.1744272560461;
        Thu, 10 Apr 2025 01:09:20 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:959f:bd4a:33b6:cab1? ([2001:ee0:4f0e:fb30:959f:bd4a:33b6:cab1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8b2absm24625785ad.83.2025.04.10.01.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 01:09:20 -0700 (PDT)
Message-ID: <84adec63-0ccd-449c-babf-994d579f3677@gmail.com>
Date: Thu, 10 Apr 2025 15:09:13 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: hold netdev_lock when pausing rx
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20250404093903.37416-1-minhquangbui99@gmail.com>
 <1743987836.9938157-1-xuanzhuo@linux.alibaba.com>
 <30419bd6-13b1-4426-9f93-b38b66ef7c3a@gmail.com>
 <CACGkMEs7O7D5sztwJVn45c+1pap20Oi5f=02Sy_qxFjbeHuYiQ@mail.gmail.com>
 <4195db62-db43-4d61-88c3-7a7fbb164726@gmail.com>
 <b7b1f5de-7003-4960-a9d1-883bf2f1aa77@gmail.com>
 <4d3a1478-b6fc-47a3-8d77-7eca6a973a06@gmail.com>
 <20250410035158-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250410035158-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/10/25 14:58, Michael S. Tsirkin wrote:
> On Thu, Apr 10, 2025 at 02:05:57PM +0700, Bui Quang Minh wrote:
>> When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
>> napi_disable() on the receive queue's napi. In delayed refill_work, it
>> also calls napi_disable() on the receive queue's napi. When
>> napi_disable() is called on an already disabled napi, it will sleep in
>> napi_disable_locked while still holding the netdev_lock. As a result,
>> later napi_enable gets stuck too as it cannot acquire the netdev_lock.
>> This leads to refill_work and the pause-then-resume tx are stuck
>> altogether.
>>
>> This scenario can be reproducible by binding a XDP socket to virtio-net
>> interface without setting up the fill ring. As a result, try_fill_recv
>> will fail until the fill ring is set up and refill_work is scheduled.
>>
>> This commit makes the pausing rx path hold the netdev_lock until
>> resuming, prevent any napi_disable() to be called on a temporarily
>> disabled napi.
>>
>> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 74 +++++++++++++++++++++++++---------------
>>   1 file changed, 47 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 7e4617216a4b..74bd1065c586 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -2786,9 +2786,13 @@ static void skb_recv_done(struct virtqueue *rvq)
>>   }
>>
>>   static void virtnet_napi_do_enable(struct virtqueue *vq,
>> -                   struct napi_struct *napi)
>> +                   struct napi_struct *napi,
>> +                   bool netdev_locked)
>>   {
>> -    napi_enable(napi);
>> +    if (netdev_locked)
>> +        napi_enable_locked(napi);
>> +    else
>> +        napi_enable(napi);
>>
>>       /* If all buffers were filled by other side before we napi_enabled, we
>>        * won't get another interrupt, so process any outstanding packets now.
>> @@ -2799,16 +2803,16 @@ static void virtnet_napi_do_enable(struct virtqueue
>> *vq,
>
>
>
> Your patch is line-wrapped, unfortunately. Here and elsewhere.
>
>
>
>
>>       local_bh_enable();
>>   }
>>
>> -static void virtnet_napi_enable(struct receive_queue *rq)
>> +static void virtnet_napi_enable(struct receive_queue *rq, bool
>> netdev_locked)
>>   {
>>       struct virtnet_info *vi = rq->vq->vdev->priv;
>>       int qidx = vq2rxq(rq->vq);
>>
>> -    virtnet_napi_do_enable(rq->vq, &rq->napi);
>> +    virtnet_napi_do_enable(rq->vq, &rq->napi, netdev_locked);
>>       netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_RX, &rq->napi);
>>   }
>>
>> -static void virtnet_napi_tx_enable(struct send_queue *sq)
>> +static void virtnet_napi_tx_enable(struct send_queue *sq, bool
>> netdev_locked)
>>   {
>>       struct virtnet_info *vi = sq->vq->vdev->priv;
>>       struct napi_struct *napi = &sq->napi;
>> @@ -2825,11 +2829,11 @@ static void virtnet_napi_tx_enable(struct send_queue
>> *sq)
>>           return;
>>       }
>>
>> -    virtnet_napi_do_enable(sq->vq, napi);
>> +    virtnet_napi_do_enable(sq->vq, napi, netdev_locked);
>>       netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_TX, napi);
>>   }
>>
>> -static void virtnet_napi_tx_disable(struct send_queue *sq)
>> +static void virtnet_napi_tx_disable(struct send_queue *sq, bool
>> netdev_locked)
>>   {
>>       struct virtnet_info *vi = sq->vq->vdev->priv;
>>       struct napi_struct *napi = &sq->napi;
>> @@ -2837,18 +2841,24 @@ static void virtnet_napi_tx_disable(struct
>> send_queue *sq)
>>
>>       if (napi->weight) {
>>           netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_TX, NULL);
>> -        napi_disable(napi);
>> +        if (netdev_locked)
>> +            napi_disable_locked(napi);
>> +        else
>> +            napi_disable(napi);
>>       }
>>   }
>>
>> -static void virtnet_napi_disable(struct receive_queue *rq)
>> +static void virtnet_napi_disable(struct receive_queue *rq, bool
>> netdev_locked)
>>   {
>>       struct virtnet_info *vi = rq->vq->vdev->priv;
>>       struct napi_struct *napi = &rq->napi;
>>       int qidx = vq2rxq(rq->vq);
>>
>>       netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_RX, NULL);
>> -    napi_disable(napi);
>> +    if (netdev_locked)
>> +        napi_disable_locked(napi);
>> +    else
>> +        napi_disable(napi);
>>   }
>>
>>   static void refill_work(struct work_struct *work)
>> @@ -2875,9 +2885,11 @@ static void refill_work(struct work_struct *work)
>>            *     instance lock)
>>            *   - check netif_running() and return early to avoid a race
>>            */
>> -        napi_disable(&rq->napi);
>> +        netdev_lock(vi->dev);
>> +        napi_disable_locked(&rq->napi);
>>           still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
>
> This does mean netdev_lock is held potentially for a long while,
> while try_fill_recv and processing inside virtnet_napi_do_enable
> finish. Better ideas?
I prefer the first patch in this thread where we disable delayed refill 
and cancel all inflight refill_work before pausing rx.

Thanks,
Quang Minh.


