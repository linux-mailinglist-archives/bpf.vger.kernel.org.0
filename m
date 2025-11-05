Return-Path: <bpf+bounces-73750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A9670C38631
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 00:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C4BB34E32C
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 23:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137BB2F3C21;
	Wed,  5 Nov 2025 23:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nq31fmrM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89861CAA6C
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 23:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762385990; cv=none; b=IGScDzNusxH3khR2MNkWfqPCEEAEUZs7r6x0IH88MACvQ7kxrEkMzp4ln2hpyOg8elDL1kDoGffWIx4UTXBM3N+AsykZ1NuNPTC+iLtEbu5xOvR1xCt5koI0XpykMWzjl5NIcXCgFKuKSCFIyz71cImJq8AQizHtNa17iVxrKow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762385990; c=relaxed/simple;
	bh=w2Dxd97mYWnrxPNw5o2swa3sF0DNc/nt/mpaD1dVH60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZG+8NZn2JwJahvcNjcnyUBNHxrdA/FbB1ZuvalI1ut35W89PDxNMZoQOFKtkfqt5Iu3j0YEiQFOTdnkIsNGQeDJqsZGe7D/6oKy9UgCgUiqRkaBvHMha4YJKpxIou6GoBOMfjBxE/PcYKbns3zQQE1IbzERFSkeyZr6u28iO+uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nq31fmrM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so6851395e9.1
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 15:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762385987; x=1762990787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sSqNnS3YmUlrpVYEFIZ6Oi20bDm76nBzJwCgcR2xrXw=;
        b=Nq31fmrMxgNQD07c9G9+66zQ3DxyWojkVSd2v5B3bUJyEFkL/sjAjSfI/C5yQF6+QB
         8tnDl5wchVEeWDg/BLjDEVU5OHsqE9z9GW5wgXsztEfDzhikCAhuqgE3BXBCx/+J03e9
         J/QzuUDy5etpG+77RTGlLh56lZYEP0IGYz51P+b+RQQjpQ3P0n+uFiHcJ87Ehgw8AnRi
         BET2iLtHK2tfNZlkEau0nymeKStLhhp9PzC2ghJYp51MjZRoH2qc+ZDEn3aPdhUKZJSv
         lddnwXrMEKtdieKRcwJ00MPT2jn29TAGEsDv3YleIo2wMoFPwjb/74SeieuwRzuPqpUC
         PLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762385987; x=1762990787;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSqNnS3YmUlrpVYEFIZ6Oi20bDm76nBzJwCgcR2xrXw=;
        b=EW0LSDL2vJt34lVF3c+XkasLxr+QgArw/TqYHPPkPsM6WBCRQFeYJ9yUypKKGavFwi
         UBxM7YUSneP1xfNO4DaZ2exAu6HXD56WeH36w4POvybofV3ohj2gBz1DrZxzQczhvfHM
         0r4wiQ664tvnSPkwk0QeP494Df/nygLl0Y+0vs3SH+8xabPUDgalsNce2pV6LYLujv4z
         w78bT7FJsM3A++4WBMieb+DFQHvkzQVucisAaKNJdkeQL8XvrazOPr0W4TjlaZQQfjrV
         pF/HKr7Cp8gu5z7ufuvXed+6lQ/73p0Mt5He5oCLD8ppzYNSdF4eZIuVSaF4rgG3CKMm
         tP8w==
X-Forwarded-Encrypted: i=1; AJvYcCVBMpDoye6t0DGegmTEyauwKTzA1jjzGsiIj6TQHvLvqkHcHrsXzbT6LaBJs4VUu+RftDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpZam9rPwvGALYXjj87Y5RA64Fn2q4OlAYj9wMOflmHpdCEXPU
	K9DpO9FajKnx2MOIxsRzFtB+g6AqWnhImORrjZ00Sl7jJW8BigNjRg0p
X-Gm-Gg: ASbGncv9ld/SsbGfscTkxgpCiWQrf5KHHqjLJCWrHw2bLE+5etW8AutQG7VL5OHexdQ
	IRo6vuw9y7vOqVP6pxf8g8vmTbAKAK+kHTMbCTNklMeT4LP2IB/Xim4v0a9oe9+YDJp/+5FIxJt
	I6+ShWTNyMjoUTSK43Tmz1Qb1gQVwCmlSB+LCk6wRocsXyneNm8OH9yeZMM2yu1w/ggygowrgrY
	9Moy9UgmdDbkPpo5NkzlZybiTagu+U3yxX3YeQepZCojBhjC4N2BWnalvQEAAGbeSyh/fGovVpS
	h5eyl8wOafxzWCd1rgQJhOpj+dXwMd4IRXnAU1JKUHVkJW1/Jz66A1OvXtJk6Dwv5EH19y/wtM0
	WaNeR7TwcL4bo+svzRRWe7YhVIY2pp2hACOFrP+XHedDOzLdiBTwR52eV3ELyxDuOSyRmQMjFtU
	XBHAJrURTgvsLfbn1JwIj5SsdyGhRAxEGXKieW3b48Ld1Lq7DHftdyKLCarL1/KYPP
X-Google-Smtp-Source: AGHT+IGzgqdVSNjrjpvx/OZqs/BcOY2ftZ5ans9neT8tmWBn28Etfln4Yd1YPsncpa7OJiKpoz5KrA==
X-Received: by 2002:a5d:5887:0:b0:429:ca7f:8d5b with SMTP id ffacd0b85a97d-429eb160496mr1023764f8f.14.1762385986974;
        Wed, 05 Nov 2025 15:39:46 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb4ad537sm1383573f8f.42.2025.11.05.15.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 15:39:46 -0800 (PST)
Message-ID: <0ee6e906-6bba-4145-8e06-f1c47ab19af3@gmail.com>
Date: Wed, 5 Nov 2025 23:39:45 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 5/5] bpf: remove lock from bpf_async_cb
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20251031-timer_nolock-v1-0-bf8266d2fb20@meta.com>
 <20251031-timer_nolock-v1-5-bf8266d2fb20@meta.com>
 <80b877f638eef0971bceeb2d4a4d9fd776483379.camel@gmail.com>
 <a85b3b32-57a7-4d0a-b925-27e6a59e7f67@gmail.com>
 <e9a2c7fc68b5d69abeadf38350eae375f24c58bf.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <e9a2c7fc68b5d69abeadf38350eae375f24c58bf.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/25 22:44, Eduard Zingerman wrote:
> On Wed, 2025-11-05 at 15:30 +0000, Mykyta Yatsenko wrote:
>
> [...]
>
>>>> @@ -1472,12 +1489,19 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, timer, u64, nsecs, u64, fla
>>>>    		return -EOPNOTSUPP;
>>>>    	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN))
>>>>    		return -EINVAL;
>>>> -	__bpf_spin_lock_irqsave(&timer->lock);
>>>> -	t = timer->timer;
>>>> -	if (!t || !t->cb.prog) {
>>>> -		ret = -EINVAL;
>>>> -		goto out;
>>>> -	}
>>>> +
>>>> +	guard(rcu)();
>>>> +
>>>> +	t = READ_ONCE(async->timer);
>>>> +	if (!t)
>>>> +		return -EINVAL;
>>>> +
>>>> +	/*
>>>> +	 * Hold ref while scheduling timer, to make sure, we only cancel and free after
>>>> +	 * hrtimer_start().
>>>> +	 */
>>>> +	if (!bpf_async_tryget(&t->cb))
>>>> +		return -EINVAL;
>>> Could you please explain in a bit more detail why tryget/put pair is
>>> needed here?
>> Yeah, we need to hold the reference to make sure even if cancel_and_free()
>> go through, the underlying timer struct is not detached/freed, so we won't
>> get into the situation when we first free, then schedule, with refcnt hold,
>> we always first schedule and then free, this allows for cancellation run
>> when
>> the last ref is put.
> Sorry, I still don't get it.
> In bpf_timer_start() you added `guard(rcu)()`.
> In bpf_timer_cancel_and_free():
>
>   - bpf_timer_cancel_and_free
>     - bpf_async_put(cb: &t->cb, type: BPF_ASYNC_TYPE_TIMER)
>       - bpf_timer_delete(t: (struct bpf_hrtimer *)cb);
>         - bpf_timer_delete_work(work: &t->cb.delete_work);
>         	 - call_rcu(head: &t->cb.rcu, func: bpf_async_cb_rcu_free)
>
> So, it looks like `t->cb` is protected by RCU and can't go away
> between `guard(rcu)()` and bpf_timer_start() exit.
> What will go wrong if tryget is removed?
bpf_timer_delete() also calls hrtimer_cancel(). If bpf_timer_start()
does not hold refcnt, we may run into the situation when hrtimer_cancel()
runs before hrtimer_start(). The timer is going to be deleted after the
grace period but it is not cancelled, and the timer callback may read 
after free.
Holding refcnt makes sure hrtimer_cancel() will be called after 
hrtimer_start()
(or way before it, and we error out).
>>>>    	if (flags & BPF_F_TIMER_ABS)
>>>>    		mode = HRTIMER_MODE_ABS_SOFT;
>>> [...]
>>>
>>>> @@ -1587,22 +1598,17 @@ static struct bpf_async_cb *__bpf_async_cancel_and_free(struct bpf_async_kern *a
>>>>    {
>>>>    	struct bpf_async_cb *cb;
>>>>    
>>>> -	/* Performance optimization: read async->cb without lock first. */
>>>> -	if (!READ_ONCE(async->cb))
>>>> -		return NULL;
>>>> -
>>>> -	__bpf_spin_lock_irqsave(&async->lock);
>>>> -	/* re-read it under lock */
>>>> -	cb = async->cb;
>>>> -	if (!cb)
>>>> -		goto out;
>>>> -	drop_prog_refcnt(cb);
>>>> -	/* The subsequent bpf_timer_start/cancel() helpers won't be able to use
>>>> +	/*
>>>> +	 * The subsequent bpf_timer_start/cancel() helpers won't be able to use
>>>>    	 * this timer, since it won't be initialized.
>>>>    	 */
>>>> -	WRITE_ONCE(async->cb, NULL);
>>>> -out:
>>>> -	__bpf_spin_unlock_irqrestore(&async->lock);
>>>> +	cb = xchg(&async->cb, NULL);
>>>> +	if (!cb)
>>>> +		return NULL;
>>>> +
>>>> +	/* cb is detached, set state to FREED, so that concurrent users drop it */
>>>> +	xchg(&cb->state, BPF_ASYNC_FREED);
>>>> +	bpf_async_update_callback(cb, NULL, NULL);
>>> Calling bpf_async_update_callback() is a bit strange here.
>>> That function protects 'cb' state by checking the 'cb->state',
>>> but here that check is sidestepped.
>>> Is this why you jump to drop for FREED state in bpf_async_update_callback()?
>> yes, this is probably a bit ugly, but I find it handy to have all the
>> tricky code that mutates callback and prog inside the single function
>> bpf_async_update_callback().
> Probably subjective, but it makes things more confusing for me.
Yes, I think I see how it may not be super obvious from reader's 
perspective,
I'll change this, thanks!


