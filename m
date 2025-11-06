Return-Path: <bpf+bounces-73907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A09C3DA04
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 23:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74CD93AE99C
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 22:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30557337BA6;
	Thu,  6 Nov 2025 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lz/E9QpJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18303396FD
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 22:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468594; cv=none; b=DrZWSrdNsbUp1HlUZM/TC5zOGHGQG9TjQy5QEFaGYjfg4YZj+EOlcwaU1KYfQoy19qOa7Lr9Gnmj33+ftk7WuXaL5exqbk/5B7vdJztwYcpmItHkvNW71yTtcZfgvZA88k0XXoeZ7QrAnrJB3KpJ+73R/mIu+VQos9mlX7EbVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468594; c=relaxed/simple;
	bh=2o45RpA8zDDKPnHm6jzFFXEJrO/5rxQCtUjAzmD4kww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYI4AlDdiIHk+03bxzX9PbfoTSZK/0b4DJuP1HE01XSNQkyvEEL1OXrxXmik4zYqvYXF93tjusfH0sqgKRenwdG0gB+KREBj9KU2u9zfdeuIRbSMf8pWCe3+55umxEOE0ruiyr8JlfEdMeo9JNbmhNqmdNlblsQDxjx3BrhRjSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lz/E9QpJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477632d9326so920785e9.1
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 14:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762468591; x=1763073391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ApOM3DPCGYGT094HwTdMT5aZxHa8LpUh27sMGA4A7rY=;
        b=Lz/E9QpJ/Ub5sp+xPaFL8MtraD8FxCN8M8C6UFmffojAhWBMPdU8i72GqPUfMXimQX
         qmxUpkH1XmdQk4nHLgbFUpYxToy2HkwyTrqArlDqX7vhXUtx36DDZ5NOG94/bcO8URRl
         INJheeBfKpqDD+oufthqnCcou4TBPIbsu/3rcniyDtXWVlE/lwBzOlHmsybTCjpGWvDm
         8/P2DGHem2LKmPjMIiqsBbHOCGV8Y/6GaUVabV7wtIfkaPg7mK3j3IGmVahSMAMkDXgT
         scBnOcLMcOIFhGPSnRhCKFiFTSeh3QrgzY2HKN+e/3dHFYap6IRUXt/nu34yajpVbjW3
         JfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762468591; x=1763073391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ApOM3DPCGYGT094HwTdMT5aZxHa8LpUh27sMGA4A7rY=;
        b=oR/5Jcq4b+FsHTElJj+S5RQbyhtcfxhE2+W/OtvV8JBlYVobg1MPkQdYQzDZ7GlF7Y
         BcHYDOKH2Hava8CmFLq/+/K3908ffTV1b+c3UFRvBvT8GmUwOg/2vqB3L9gVa4uny5eI
         bqv3qtodL74Q6o3yvsRh038XTPL3TfBc9YWaKNGO/8qJ6i8ML+VmfdFMLGRC6PIInvkh
         ohZks8SQ+UbEUmnPlNnsdHxIOFWIMdBu3Q/1w0eILZTiY41V9Fbg8mQqBu8aRhL/6v9d
         dDwyE3I4n6/rql3u2XAWNuqrXGMi8FvvJd+piIcvZKbNLxm6g5f+pGflWTGJ3xCatKT8
         mv5A==
X-Forwarded-Encrypted: i=1; AJvYcCXNe67Dxq3zsCx8zyPPYZ6mTQDRZ6q9EPS2gk+Ii29ODa/6Wijh++7YUyDD7oVoGKRvRoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtsCY90MlNqVu8JjJeEGfDgL0UWsTNio8tMaN0lG3Q62CYLYlI
	VDXmmFH9AYJbG77Ed/izDUON7zyJvcBZLfpQtdS11xxY+mW6k5KnnPHJ
X-Gm-Gg: ASbGncuA/gs0hpkw30BG+CQwzYT/H77Gr5BlDjdXVYiTOLvncbNZY9hL+nAW9uNQxX+
	VPKGHjT7kaVa5w55JT1WzjuLT26KOtftelqy5QMtMXzGPnxpQfwbewSEg8vBaPgaWFB3tuorlnJ
	XeIcqgfhf7qDmILdxsnZksr2oOFswJ26SttRGIkufpaNIH1IZo/Hogn+A0HP46Zqfy8qqDnIOMk
	dA+r3Hb5HsjV0AcKWv+ETd1xxE5ZHhsdM5Kw3r7/3ccxVmdbh9AaObeWR5I6uYLIPBJVm69zG2w
	X0PSl8YfX3txyXCIlCLTxvJCIEHkdJAF1ZQR9pC36KTW/Z7m3/WfblF08+VZPZAyhL3QTmpJYi0
	VStV0laDX2yJfT4B2Zj4VECQQAQu1qGWZlzuE/XSjW91220P40PjNwBJ3dyC2X5SSuQgRmQzXDd
	+IjpL6RScffg64EWMvT4sZ4bxhsHJIBgnX/6OkXyUWMugdIP8yTjpwC4vyBblwNGV0
X-Google-Smtp-Source: AGHT+IE8ejJE8RFOP9c8itGxmieNrGjuChLZX13mes6KWtCaRvhRYNthjZ5Gk3btfTYxr9V/a1AZog==
X-Received: by 2002:a05:600c:6287:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-4776bcc52fbmr7355365e9.27.1762468591014;
        Thu, 06 Nov 2025 14:36:31 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf4bsm1527265f8f.8.2025.11.06.14.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 14:36:30 -0800 (PST)
Message-ID: <d8310c25-a0c7-4b84-8fa6-0e1c3c369a29@gmail.com>
Date: Thu, 6 Nov 2025 22:36:29 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 4/5] bpf: add refcnt into struct bpf_async_cb
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20251105-timer_nolock-v2-0-32698db08bfa@meta.com>
 <20251105-timer_nolock-v2-4-32698db08bfa@meta.com>
 <79f2f8d6-f8dd-41a6-90fe-2464397a0c6c@linux.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <79f2f8d6-f8dd-41a6-90fe-2464397a0c6c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/6/25 21:41, Yonghong Song wrote:
>
>
> On 11/5/25 7:59 AM, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> To manage lifetime guarantees of the struct bpf_async_cb, when
>> no lock serializes mutations, introduce refcnt field into the struct.
>> Implement bpf_async_tryget() and bpf_async_put() to handle the refcnt.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   kernel/bpf/helpers.c | 39 ++++++++++++++++++++++++++++++++-------
>>   1 file changed, 32 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 
>> 2eb2369cae3ad34fd218387aa237140003cc1853..1cd4011faca519809264b2152c7c446269bee5de 
>> 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -1102,6 +1102,7 @@ struct bpf_async_cb {
>>           struct work_struct delete_work;
>>       };
>>       u64 flags;
>> +    refcount_t refcnt;
>>   };
>>     /* BPF map elements can contain 'struct bpf_timer'.
>> @@ -1155,6 +1156,33 @@ static DEFINE_PER_CPU(struct bpf_hrtimer *, 
>> hrtimer_running);
>>     static void bpf_timer_delete(struct bpf_hrtimer *t);
>>   +static bool bpf_async_tryget(struct bpf_async_cb *cb)
>> +{
>> +    return refcount_inc_not_zero(&cb->refcnt);
>> +}
>
> Looks like bpf_async_tryget() is not used in this patch and it is
> actually used in the next patch. Should we move it to the next patch?
I'll do that, thanks, just wanted to keep the next patch smaller as it 
is the most difficult
for reading.
>
>> +
>> +static void bpf_async_put(struct bpf_async_cb *cb, enum 
>> bpf_async_type type)
>> +{
>> +    if (!refcount_dec_and_test(&cb->refcnt))
>> +        return;
>> +
>> +    switch (type) {
>> +    case BPF_ASYNC_TYPE_TIMER:
>> +        bpf_timer_delete((struct bpf_hrtimer *)cb);
>> +        break;
>> +    case BPF_ASYNC_TYPE_WQ: {
>> +        struct bpf_work *work = (void *)cb;
>> +        /* Trigger cancel of the sleepable work, but *do not* wait for
>> +         * it to finish if it was running as we might not be in a
>> +         * sleepable context.
>> +         * kfree will be called once the work has finished.
>> +         */
>> +        schedule_work(&work->delete_work);
>> +        break;
>> +    }
>> +    }
>> +}
>> +
>>   static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
>>   {
>>       struct bpf_hrtimer *t = container_of(hrtimer, struct 
>> bpf_hrtimer, timer);
>> @@ -1304,6 +1332,7 @@ static int __bpf_async_init(struct 
>> bpf_async_kern *async, struct bpf_map *map, u
>>       cb->prog = NULL;
>>       cb->flags = flags;
>>       rcu_assign_pointer(cb->callback_fn, NULL);
>> +    refcount_set(&cb->refcnt, 1); /* map's own ref */
>>         WRITE_ONCE(async->cb, cb);
>>       /* Guarantee the order between async->cb and map->usercnt. So
>> @@ -1642,7 +1671,7 @@ void bpf_timer_cancel_and_free(void *val)
>>       if (!t)
>>           return;
>>   -    bpf_timer_delete(t);
>> +    bpf_async_put(&t->cb, BPF_ASYNC_TYPE_TIMER); /* Put map's own 
>> reference */
>>   }
>>     /* This function is called by map_delete/update_elem for 
>> individual element and
>> @@ -1657,12 +1686,8 @@ void bpf_wq_cancel_and_free(void *val)
>>       work = (struct bpf_work *)__bpf_async_cancel_and_free(val);
>>       if (!work)
>>           return;
>> -    /* Trigger cancel of the sleepable work, but *do not* wait for
>> -     * it to finish if it was running as we might not be in a
>> -     * sleepable context.
>> -     * kfree will be called once the work has finished.
>> -     */
>> -    schedule_work(&work->delete_work);
>> +
>> +    bpf_async_put(&work->cb, BPF_ASYNC_TYPE_WQ); /* Put map's own 
>> reference */
>>   }
>>     BPF_CALL_2(bpf_kptr_xchg, void *, dst, void *, ptr)
>>
>


