Return-Path: <bpf+bounces-73661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A545BC36795
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 16:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3701A43663
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 15:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD473164AF;
	Wed,  5 Nov 2025 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhgV47PQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CDA213E6D
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356648; cv=none; b=SX80pQwhDZVywu6odiw5oKGLZhBMyx/KDwITsRw1otcGLty/s0AOQNHeIbu+ZW6P0rUXupACrz/0J7O0fXNaEldNv+BNQKT1oXidwG6n8hBvriiogSZ3Ge8X8tYo6qZlGgUiY98c/aq6RDpRxViWVoN0eePvGmQ4DFuao6bfyGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356648; c=relaxed/simple;
	bh=JuKNlG2iQJW6TVfVgjP+0zfpGGDHui7Wp2d5trtYOHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/cydw3mFB/Lqyr+XDTOLiwpYAue4uzzKOlXOPL33fqAQy9gtVIsXDcQZjgpt1MYDEFHUTRlWxwsh+IdqPZJgP8wL7laZeSTopKu96qTSmALky+9AUVTqotazZZ8q6fSvMhyUk6ad54VXxcxuLZWBmP8cmM4SUmYaywwmG2kejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhgV47PQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47754e9cc7fso15099945e9.2
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 07:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762356645; x=1762961445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H6dj8jqTVG7cpe/f8kLP/CzwriwxZP7orBgj4pDJFHI=;
        b=JhgV47PQmo3kvSBkYQfsvk5MWDEPIch9GNRkR1HeOwFYLiAELETaq1utzMq9ySM27k
         pm0nCAJIIGwJJvAI3x4Q+tc3pCJtXHozb19Binlr8+2qYdZfRUj36XLW+cS6oly+ABxH
         qIp6COmxUAVhFgdUYJzjnipD8rVTqq7HR3342ZYf6ZBc4fsUZw+BUnkI9VPdenOmEnDU
         PVg50UKlmVRO2O/cqXV3lrB7OG6IqP3YUxoiY9Wrx74T0ehDFd5DCcwJcot6AHMU8jtT
         3tJo2AANAJRf31twhDmnOMJFhKfbv0E3ozhjnf7wz1DMzitj5jHT02x4pI8i57t4G580
         Rmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762356645; x=1762961445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H6dj8jqTVG7cpe/f8kLP/CzwriwxZP7orBgj4pDJFHI=;
        b=U+EcejXL+JfH5VLf+BUYOKmr8o5kCK+otc+9Cc712Z4JZxiBbF30ceEfrPh9+fdNZU
         es69XmGWdsj5CyG+ahytg35U/JT+NL2RGomPxMjAbozY176bgNNpgXnZc8/qBjvaAZVf
         /Gx0hjD4pwff5YRl4qrSgNSNLnvxW2ik2r1I4J3nop+afOYvcrllvbdZQ/v18/t0i4+y
         2CHCqDlhzP9t/6tMbZQuFocqv+P4aUa65IkQf9gwDbat+O14OyAegLpn4uLRMvtZbrxm
         RHvMYbcxHVRKNu0LORXqNOCrquIF6bnUJWrcVuzZHrxsgRp6EG5cYRQzTzbLzYURVCl5
         Soww==
X-Forwarded-Encrypted: i=1; AJvYcCVYihS2RmebH7xEIjaQAp6rkpAQUmubcviE0ZHL4iORUnzz2zrgeio8IJPjX++7Vre48pE=@vger.kernel.org
X-Gm-Message-State: AOJu0YybglXe2kNs+Szl6DyTYMUPqNo3zwcC4KJUVBDLGCHBY12/EZ3Y
	j7EmdE9QLOsXpCmgaNN8Ei+lHdtac7JfjAUxre6CC+GV8lTHMrngtvGP
X-Gm-Gg: ASbGncsTx5PsvFrfDCSD9wxidClC6nzS9twXk3X2Lvj3GHgHbYG4aFx+pixWtJVsULf
	oGsDVAOg2B6mHgipCVVWtSC3yuf/T2CxqscAQ6YGYmr34f3AuEAmKANPpugnrh7JiGkCPy6MznK
	eqhVbfd9tezq6nqjakRaIuPY6u2X4nkCP0tOUNnP6i2pPD7w8ZsQlD5SKqOYTud58yV4or1EkBa
	rm7pR/XaZouZ/5WvABsJsYw1QZG7veRmwlQtMy5zAg0u24qow5APGPgse8yQOilzfr4pJxlAts1
	IlF6mFYZKLm+kFPIAfzX8Rx1co6Qzn4YfHrpk6USrOe+Cvsaa8K4GtpLrCzKU47/Kf+FkrBgaFN
	Jewj19gt+gaRc/U79rxBi5ncMXnPuxkiG++BSsVDLPQBRYJFPDCP/AxxqrZNFDpwZ9AmbCMDzD2
	3CnjWfR/zqrY4SoT/mJ5VauTgm+4FDGREqRFLb2L0PvA==
X-Google-Smtp-Source: AGHT+IEKDKwtoWFLPXzFBcU4E8Zv8YndOFJaZE0gM1BFUm+ijRAmrrAaCVxvmh8AU0cQLw5uSHQtJQ==
X-Received: by 2002:a05:600c:3f07:b0:477:5c45:8100 with SMTP id 5b1f17b1804b1-4775ce61f57mr25118205e9.24.1762356644934;
        Wed, 05 Nov 2025 07:30:44 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:35fe:5fdc:3cf6:a737? ([2620:10d:c092:500::7:64d7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdd3028sm55075935e9.8.2025.11.05.07.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 07:30:44 -0800 (PST)
Message-ID: <a85b3b32-57a7-4d0a-b925-27e6a59e7f67@gmail.com>
Date: Wed, 5 Nov 2025 15:30:43 +0000
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
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <80b877f638eef0971bceeb2d4a4d9fd776483379.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/4/25 22:01, Eduard Zingerman wrote:
> On Fri, 2025-10-31 at 21:58 +0000, Mykyta Yatsenko wrote:
>
> [...]
>
>> @@ -1344,12 +1348,17 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
>>   		/* maps with timers must be either held by user space
>>   		 * or pinned in bpffs.
>>   		 */
>> -		WRITE_ONCE(async->cb, NULL);
>> -		kfree_nolock(cb);
>> -		ret = -EPERM;
>> +		switch (type) {
>> +		case BPF_ASYNC_TYPE_TIMER:
>> +			bpf_timer_cancel_and_free(async);
>> +			break;
>> +		case BPF_ASYNC_TYPE_WQ:
>> +			bpf_wq_cancel_and_free(async);
>> +			break;
>> +		}
>> +		return -EPERM;
> Just want to double-check my understanding, are below points correct?
> - You need to call cancel_and_free() instead of kfree_nolock() because
>    after cmpxchg() the map value is published and some other thread
>    could have scheduled work/armed the timer.
> - Previously this was not possible, because the other thread had to
>    take the async->lock.
That's right. This is similar to task work implementation:
```
     if (!atomic64_read(&map->usercnt)) {
         ...
         /* transfer map's ref into cancel_and_free() */
         bpf_task_work_cancel_and_free(tw);
```

>>   	}
>> -out:
>> -	__bpf_spin_unlock_irqrestore(&async->lock);
>> +
>>   	return ret;
>>   }
>>   
>> @@ -1398,41 +1407,42 @@ static int bpf_async_swap_prog(struct bpf_async_cb *cb, struct bpf_prog *prog)
>>   		if (IS_ERR(prog))
>>   			return PTR_ERR(prog);
>>   	}
>> +	/* Make sure only one thread runs bpf_prog_put() */
>> +	prev = xchg(&cb->prog, prog);
>>   	if (prev)
>>   		/* Drop prev prog refcnt when swapping with new prog */
>>   		bpf_prog_put(prev);
>>   
>> -	cb->prog = prog;
>>   	return 0;
>>   }
>>   
>> -static int bpf_async_update_callback(struct bpf_async_kern *async, void *callback_fn,
>> +static int bpf_async_update_callback(struct bpf_async_cb *cb, void *callback_fn,
>>   				     struct bpf_prog *prog)
>>   {
>> -	struct bpf_async_cb *cb;
>> +	enum bpf_async_state state;
>>   	int err = 0;
>>   
>> -	__bpf_spin_lock_irqsave(&async->lock);
>> -	cb = async->cb;
>> -	if (!cb) {
>> -		err = -EINVAL;
>> -		goto out;
>> -	}
>> -	if (!atomic64_read(&cb->map->usercnt)) {
>> -		/* maps with timers must be either held by user space
>> -		 * or pinned in bpffs. Otherwise timer might still be
>> -		 * running even when bpf prog is detached and user space
>> -		 * is gone, since map_release_uref won't ever be called.
>> -		 */
>> -		err = -EPERM;
>> -		goto out;
>> -	}
>> +	state = cmpxchg(&cb->state, BPF_ASYNC_READY, BPF_ASYNC_BUSY);
>> +	if (state == BPF_ASYNC_BUSY)
>> +		return -EBUSY;
>> +	if (state == BPF_ASYNC_FREED)
>> +		goto drop;
> Why do you need to 'drop' at this point?
> 'cb' object had not been changed by current thread yet,
> so it seems that something like:
>
>    if (state == BPF_ASYNC_FREED)
>      return -EPERM;
>
> Should suffice.
Good point, although you correctly figured it out below.
bpf_async_update_callback() is the only function that mutates prog and 
callback_fn fields.
For me it makes things a little simpler.
>
>>   
>>   	err = bpf_async_swap_prog(cb, prog);
>>   	if (!err)
>>   		rcu_assign_pointer(cb->callback_fn, callback_fn);
>> -out:
>> -	__bpf_spin_unlock_irqrestore(&async->lock);
>> +
>> +	state = cmpxchg(&cb->state, BPF_ASYNC_BUSY, BPF_ASYNC_READY);
>> +	if (state == BPF_ASYNC_FREED) {
>> +		/*
>> +		 * cb is freed concurrently, we may have overwritten prog and callback,
>> +		 * make sure to drop them
>> +		 */
>> +drop:
>> +		bpf_async_swap_prog(cb, NULL);
>> +		rcu_assign_pointer(cb->callback_fn, NULL);
>> +		return -EPERM;
>> +	}
>>   	return err;
>>   }
> [...]
>
>> @@ -1472,12 +1489,19 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, timer, u64, nsecs, u64, fla
>>   		return -EOPNOTSUPP;
>>   	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN))
>>   		return -EINVAL;
>> -	__bpf_spin_lock_irqsave(&timer->lock);
>> -	t = timer->timer;
>> -	if (!t || !t->cb.prog) {
>> -		ret = -EINVAL;
>> -		goto out;
>> -	}
>> +
>> +	guard(rcu)();
>> +
>> +	t = READ_ONCE(async->timer);
>> +	if (!t)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * Hold ref while scheduling timer, to make sure, we only cancel and free after
>> +	 * hrtimer_start().
>> +	 */
>> +	if (!bpf_async_tryget(&t->cb))
>> +		return -EINVAL;
> Could you please explain in a bit more detail why tryget/put pair is
> needed here?
Yeah, we need to hold the reference to make sure even if cancel_and_free()
go through, the underlying timer struct is not detached/freed, so we won't
get into the situation when we first free, then schedule, with refcnt hold,
we always first schedule and then free, this allows for cancellation run 
when
the last ref is put.
>>   	if (flags & BPF_F_TIMER_ABS)
>>   		mode = HRTIMER_MODE_ABS_SOFT;
> [...]
>
>> @@ -1587,22 +1598,17 @@ static struct bpf_async_cb *__bpf_async_cancel_and_free(struct bpf_async_kern *a
>>   {
>>   	struct bpf_async_cb *cb;
>>   
>> -	/* Performance optimization: read async->cb without lock first. */
>> -	if (!READ_ONCE(async->cb))
>> -		return NULL;
>> -
>> -	__bpf_spin_lock_irqsave(&async->lock);
>> -	/* re-read it under lock */
>> -	cb = async->cb;
>> -	if (!cb)
>> -		goto out;
>> -	drop_prog_refcnt(cb);
>> -	/* The subsequent bpf_timer_start/cancel() helpers won't be able to use
>> +	/*
>> +	 * The subsequent bpf_timer_start/cancel() helpers won't be able to use
>>   	 * this timer, since it won't be initialized.
>>   	 */
>> -	WRITE_ONCE(async->cb, NULL);
>> -out:
>> -	__bpf_spin_unlock_irqrestore(&async->lock);
>> +	cb = xchg(&async->cb, NULL);
>> +	if (!cb)
>> +		return NULL;
>> +
>> +	/* cb is detached, set state to FREED, so that concurrent users drop it */
>> +	xchg(&cb->state, BPF_ASYNC_FREED);
>> +	bpf_async_update_callback(cb, NULL, NULL);
> Calling bpf_async_update_callback() is a bit strange here.
> That function protects 'cb' state by checking the 'cb->state',
> but here that check is sidestepped.
> Is this why you jump to drop for FREED state in bpf_async_update_callback()?
yes, this is probably a bit ugly, but I find it handy to have all the
tricky code that mutates callback and prog inside the single function
bpf_async_update_callback().
>
>>   	return cb;
>>   }
> [...]


