Return-Path: <bpf+bounces-75959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F03C9E750
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 10:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6689B4E10CC
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 09:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CB52DCC1A;
	Wed,  3 Dec 2025 09:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKHocn3f";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMuSosis"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7262DC79C
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764753897; cv=none; b=KvQ+V7Xa4h/g/EMd5xSn/qQYHeOiRcqBF/XTADzwtA49zxPyZwk8c3qbC+6UuUInvYg9C/i9E9UysrR843j6+hN5IkTGtOGpR1lo2PQWZAaV7L66LX3o851e3ZIJo0dZXU4M/qR9INVNgLZOug8dv7juiW4Z9bN8Z1BZPJTg7WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764753897; c=relaxed/simple;
	bh=12L9W0R3MCNtXsx34voYJ99A6DPe/1QJsgaFbgeAdiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3isq+XrJMo5/SwKhu48jIxz/v3UtSnxJtTafvn/t2wvAJrNceNxGtu7BuXKf2QYkQN8uWDacPBIs0MOuzNxIE+l4oKtfA/AkUTOlktR6BHaS6635K03W4cvzjQcyKNx67fO7s+6nnqgfD8LFIZf6hlhQbU9dd3dtd5DX4NS2n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKHocn3f; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMuSosis; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764753894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5gVe0b2LRwo6O+lcd1v7GXLIzDlfh1KdccOHDDQvARE=;
	b=SKHocn3faJYCPWkQpk2BZznCdUOBugXmpgMq9q+drMhk0AFZJZTcgMNSrJmTyuKMDKUrfp
	VuFfZUekMGH3l4ciC1K0PHnYzLDffGASNcvU09u0x5bHZmhYDOZY5nyDgWT8y87VunytNU
	AMJ+xgmL7rwktL48TLZz4Tf01xhQNxE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-zd9EblUTMdmYhkmfK-QZhA-1; Wed, 03 Dec 2025 04:24:53 -0500
X-MC-Unique: zd9EblUTMdmYhkmfK-QZhA-1
X-Mimecast-MFC-AGG-ID: zd9EblUTMdmYhkmfK-QZhA_1764753892
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779d8fd4ecso3213975e9.1
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 01:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764753892; x=1765358692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5gVe0b2LRwo6O+lcd1v7GXLIzDlfh1KdccOHDDQvARE=;
        b=BMuSosisFx9/IYmYzXLhIqhGR9FNyvQRMfw7G4ZruVRckZ4XSo6BO6EiYSHUbfa3g8
         oSUsOOMQQtPoNnE/TDxOjgqIb4es+Yb/SZ8LSa80Kls6oQbhnPx3vWIqcpcEawZ7YZ36
         9TZt6cvgRx7Ji/0Q0ac1KyruBz1YnrJF/YQyZWrT236aKtBW3R4IRaZmugiV1VD7S9oG
         aOrPCcN0gfwPT7itIXpAWzE/HRNPibEsxWwICpH3bYTePB3jAzrGzJftOr1wD1zXOFnk
         AXIgcUlcAkns3vfzzVxMNqkkZQdcGDkFpCqJef/JPqqbTHqK8GPMfiUc8TIm+1OL87AP
         JvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764753892; x=1765358692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gVe0b2LRwo6O+lcd1v7GXLIzDlfh1KdccOHDDQvARE=;
        b=eP4WxceUztjTiwHLm3LhCjtOrNw8HMGwcVIDc8jqu2O90FMK1L+wTRhGublrXKPIzR
         jXXIS0gUx/CJzP7ZkPafolOXyHtAVd2L8QKnNal1bpnfXjT0cj0kmYWqVfvykojSSPuw
         7txy388/3p172Vus3ZI1kf+hEPNROhPl2RvuhH9hx0vIoLqlbnwNjTV7vO/asWOF91sf
         uBuzkJigev1Z/zs4h+/UOUMDCaAwUwR37IMRRoHu75imdwei31s8EzW4i7WT9tKPLeCl
         eN7wtcmKCaWLts0JWzYrYbeY+v4XLA2tPmDeLglMNvTIA8o++/O+eITol7v6Yglcu0+z
         6txg==
X-Forwarded-Encrypted: i=1; AJvYcCUuVNSwZeGks7/vturGmbzn3VlKlJCSsjMqdcXK7MNkX+r6K1AuqhOrEDAApuBNc3lviu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7G9B9MOgbapkbGYpH0KmdJ8M5o13iwnTpZGffe30Z8Y7cx47m
	UV1pvuk5CMsAH8zLDVnJ/BQGRC1qx5SmEJbciZFHXH8SEZm9eFWcG9rCH8P46Uhy7ngJSO2POWa
	kGLyMO2va+9Xh1r4UXjJPiimZDIZvXw2NsXIk/l/a66CBzR2PGRSGUg==
X-Gm-Gg: ASbGncsQKvOgA44AsX3xIcZ2xKaSNR+KthQC7u1om/60ik0bDRQTpLQxXtq6LgrNUCh
	VP5wBhz1ShAXP9dsAr1iHy1npDIIz2jiuo0jxXHMXEnQ3oQG5NW5MsSxNvfccwWD4MPC+6IMFnX
	c1NgQ0vlh4DQG1HThYBE1W8rPzHR7iWOE78ooFdYj83gFNwmlLzHFb2PRT1dY+L8Wd5l669p6yC
	RujAGq4pYWaB8LC5VM0AZypLhhLlFu9ycPo1Gknbx3J5QpdY3agBKiklP/6LV6CmkMOWlKdG4fl
	iYOgT5Jwymukn0PeEX/J9aM5CqYdYODR2cXhbwYm6MGjKPg8kIfDKn3vp77JVsvtMAbTuWjUCoP
	JxDPXTdWof+HO9g==
X-Received: by 2002:a05:600c:8b37:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-4792af42d81mr16702205e9.15.1764753892067;
        Wed, 03 Dec 2025 01:24:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEk/K2oa1iDwcnHThYI/t8UhGUUSdyWmyjcPXycWDo2ZovR1yrBtY5++HFzgfhEEWPWRSZMNw==
X-Received: by 2002:a05:600c:8b37:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-4792af42d81mr16701845e9.15.1764753891614;
        Wed, 03 Dec 2025 01:24:51 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792a8c5fdesm38874805e9.10.2025.12.03.01.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 01:24:50 -0800 (PST)
Message-ID: <92e34c61-550a-449f-b183-cd8917fc5f9b@redhat.com>
Date: Wed, 3 Dec 2025 10:24:49 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/3] xsk: use atomic operations around
 cached_prod for copy mode
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20251128134601.54678-1-kerneljasonxing@gmail.com>
 <20251128134601.54678-3-kerneljasonxing@gmail.com>
 <8fa70565-0f4a-4a73-a464-5530b2e29fa5@redhat.com>
 <CAL+tcoDk0f+p2mRV=2auuYfTLA-cPPe-1az7NfEnw+FFaPR5kA@mail.gmail.com>
 <CAL+tcoBMRdMevWCS1puVD4zEDt+69S6t2r6Ov8tw7zhgq_n=PA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAL+tcoBMRdMevWCS1puVD4zEDt+69S6t2r6Ov8tw7zhgq_n=PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/3/25 7:56 AM, Jason Xing wrote:
> On Sat, Nov 29, 2025 at 8:55 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
>> On Fri, Nov 28, 2025 at 10:20 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>> On 11/28/25 2:46 PM, Jason Xing wrote:
>>>> From: Jason Xing <kernelxing@tencent.com>
>>>>
>>>> Use atomic_try_cmpxchg operations to replace spin lock. Technically
>>>> CAS (Compare And Swap) is better than a coarse way like spin-lock
>>>> especially when we only need to perform a few simple operations.
>>>> Similar idea can also be found in the recent commit 100dfa74cad9
>>>> ("net: dev_queue_xmit() llist adoption") that implements the lockless
>>>> logic with the help of try_cmpxchg.
>>>>
>>>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
>>>> ---
>>>> Paolo, sorry that I didn't try to move the lock to struct xsk_queue
>>>> because after investigation I reckon try_cmpxchg can add less overhead
>>>> when multiple xsks contend at this point. So I hope this approach
>>>> can be adopted.
>>>
>>> I still think that moving the lock would be preferable, because it makes
>>> sense also from a maintenance perspective.
>>
>> I can see your point here. Sure, moving the lock is relatively easier
>> to understand. But my take is that atomic changes here are not that
>> hard to read :) It has the same effect as spin lock because it will
>> atomically check, compare and set in try_cmpxchg().
>>
>>> Can you report the difference
>>> you measure atomics vs moving the spin lock?
>>
>> No problem, hopefully I will give a detailed report next week because
>> I'm going to apply it directly in production where we have multiple
>> xsk sharing the same umem.
> 
> I'm done with the test in production where a few applications rely on
> multiple xsks sharing the same pool to send UDP packets. Here are
> significant numbers from bcc tool that recorded the latency caused by
> these particular functions:
> 
> 1. use spin lock
> $ sudo ./funclatency xsk_cq_reserve_locked
> Tracing 1 functions for "xsk_cq_reserve_locked"... Hit Ctrl-C to end.
> ^C
>      nsecs               : count     distribution
>          0 -> 1          : 0        |                                        |
>          2 -> 3          : 0        |                                        |
>          4 -> 7          : 0        |                                        |
>          8 -> 15         : 0        |                                        |
>         16 -> 31         : 0        |                                        |
>         32 -> 63         : 0        |                                        |
>         64 -> 127        : 0        |                                        |
>        128 -> 255        : 25308114 |**                                      |
>        256 -> 511        : 283924647 |**********************                  |
>        512 -> 1023       : 501589652 |****************************************|
>       1024 -> 2047       : 93045664 |*******                                 |
>       2048 -> 4095       : 746395   |                                        |
>       4096 -> 8191       : 424053   |                                        |
>       8192 -> 16383      : 1041     |                                        |
>      16384 -> 32767      : 0        |                                        |
>      32768 -> 65535      : 0        |                                        |
>      65536 -> 131071     : 0        |                                        |
>     131072 -> 262143     : 0        |                                        |
>     262144 -> 524287     : 0        |                                        |
>     524288 -> 1048575    : 6        |                                        |
>    1048576 -> 2097151    : 2        |                                        |
> 
> avg = 664 nsecs, total: 601186432273 nsecs, count: 905039574
> 
> 2. use atomic
> $ sudo ./funclatency xsk_cq_cached_prod_reserve
> Tracing 1 functions for "xsk_cq_cached_prod_reserve"... Hit Ctrl-C to end.
> ^C
>      nsecs               : count     distribution
>          0 -> 1          : 0        |                                        |
>          2 -> 3          : 0        |                                        |
>          4 -> 7          : 0        |                                        |
>          8 -> 15         : 0        |                                        |
>         16 -> 31         : 0        |                                        |
>         32 -> 63         : 0        |                                        |
>         64 -> 127        : 0        |                                        |
>        128 -> 255        : 109815401 |*********                               |
>        256 -> 511        : 485028947 |****************************************|
>        512 -> 1023       : 320121627 |**************************              |
>       1024 -> 2047       : 38538584 |***                                     |
>       2048 -> 4095       : 377026   |                                        |
>       4096 -> 8191       : 340961   |                                        |
>       8192 -> 16383      : 549      |                                        |
>      16384 -> 32767      : 0        |                                        |
>      32768 -> 65535      : 0        |                                        |
>      65536 -> 131071     : 0        |                                        |
>     131072 -> 262143     : 0        |                                        |
>     262144 -> 524287     : 0        |                                        |
>     524288 -> 1048575    : 10       |                                        |
> 
> avg = 496 nsecs, total: 473682265261 nsecs, count: 954223105
> 
> And those numbers were verified over and over again which means they
> are quite stable.
> 
> You can see that when using atomic, the avg is smaller and the count
> of [128 -> 255] is larger, which shows better performance.
> 
> I will add the above numbers in the commit log after the merge window is open.

It's not just a matter of performance. Spinlock additionally give you
fairness and lockdep guarantees, beyond being easier to graps for
however is going to touch this code in the future, while raw atomic none
of them.

From a maintainability perspective spinlocks are much more preferable.

IMHO micro-benchmarking is not a strong enough argument to counter the
spinlock adavantages: at very _least_ large performance gain should be
observed in relevant test-cases and/or real live workloads.

>>> Have you tried moving cq_prod_lock, too?
>>
>> Not yet, thanks for reminding me. It should not affect the sending
>> rate but the tx completion time, I think.
> 
> I also tried moving this lock, but sadly I noticed that in completion
> time the lock was set which led to invalidation of the cache line of
> another thread sending packets. It can be obviously proved by perf
> cycles:ppp:
> 1. before
> 8.70% xsk_cq_cached_prod_reserve
> 
> 2. after
> 12.31% xsk_cq_cached_prod_reserve
> 
> So I decided not to bring such a modification. Anyway, thanks for your
> valuable suggestions and I learnt a lot from those interesting
> experiments.

The goal of such change would be reducing the number of touched
cachelines; when I suggested the above, I did not dive into the producer
specifics, I assumed the relevant producer data were inside the
xsk_queue struct.

It looks like the data is actually inside 'struct xdp_ring', so the
producer lock should be moved there, specifically:

struct xdp_ring {
	u32 producer ____cacheline_aligned_in_smp;
	spinlock_t producer_lock;
	// ...	

I'm a bit lost in the structs indirection, but I think the above would
be beneficial even for the ZC path.

/P


