Return-Path: <bpf+bounces-29437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1743B8C1F62
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 10:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977F21F21B37
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 08:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BC215F330;
	Fri, 10 May 2024 07:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bvIvL4bc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8369715ECE2
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 07:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715327995; cv=none; b=sl3rd6JMy451EdogQLp+AmaQK0AySVHaPEphryIaeedMrEuvFthceLVQ7ElSptspu5P4JHld4nuvutZcA86fVTkeiEInjv89hqBzS+1JJnu11szkp219zbpykHBvvy/IxH3ln4tOF50HczYB3KTrjDFso3ATaH3n+gRubw6EgHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715327995; c=relaxed/simple;
	bh=npWzHj9ZThuz0LC+ejy72dCyaxcJq0/47rbGM+8noc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nv661S/vt3odZgbT80ZH1DojfvKpxiSgZsMGCfg9Wd4qV1N+QYOUkMaH6nK/uZnu5iT0X9MEW2lB0INmr7jDI1mw01WiyH/yIeJQwDgUQwYGdp6NeY/7yzrR0JXsgauAgG9HgLUnYAR4yeaXO0kL6WbsuYWHXK1snaBmrEbFVRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bvIvL4bc; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-23d1c4c14ceso1074960fac.0
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715327992; x=1715932792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uJeEXiZ6QtsPIlVB8Y2HLkUohZd7HSL2XlP+CmBisvo=;
        b=bvIvL4bc60K/whstl4xnMge2Di8BV4y+9UkPZeHUiRQT+HOWpVvig6g2DwZKd7JYxb
         r1Tld/D6xpvKPWucaXrtMaoGhzAcyThNQr0hanw0MghsFnsvGDI0HO0ym446Jr5BGy8z
         8crrUE7TgYLjFEszwtmsJF4Oc+h/f22MDer1qQZiF5fuKbqD6FIKEWWtI9NbNEv8oh/p
         BJE041eVgNfCEUmpS4jslGESlry8XYFwbiJ/U7hmvnzJoqHbfTg6vudRhm0pL8jx1Iv0
         WIUHhZKKc9VnOj8R3vnb+gcsCO7MPjDtRfmVKWgW3f375HwLUTpUL6AhOHNGk5XDaAfB
         O2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715327992; x=1715932792;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJeEXiZ6QtsPIlVB8Y2HLkUohZd7HSL2XlP+CmBisvo=;
        b=fWvEf6YIwt17h+IWs+X00BPZEEFAG4w2Hvt9yKcp/FNQV5xPxDLoUc3AwrkXcniLf5
         qKiqOOeASSG58ZHhVnIGHOi/zzSWjWnCyTZ3GgxXqyroZZvzq4Jm5MXLogf0q2X7wANa
         hW6Wz9zRbImoRou785WS5xgdAGnbIremuPOH6+HYaw8g7NAKnc6ncSBgzwpUqpnqDAXQ
         HOm8iogx3e1pAlakMF6UxAQqVimK22aXTnK2sTkC927RvFvExh8pPimrkNnvZVWGk35c
         pJQPs+1JB4jrY+ySEMmFkf8MXm9PHouqp/XIQzjLLKFj8AN/qzMKKqyPEfAZWFiEoxLd
         cpFQ==
X-Gm-Message-State: AOJu0Yz9vArN50MISpizbKYNZrOKBYTN5mLYIR+5ECt5ss+Z/3sZ6kiZ
	TDvNFdeEZLLA5ec/qKnXKm3e2SLv8YKril1xkjN5QkHoM93oDtvwqT2FHyPVPtrdkMcOTY5cL+k
	A
X-Google-Smtp-Source: AGHT+IFRwknCqD7FhW8JOzyEtPWPo02Cr3jFZQMVaJo1LKmpFsS5qD2JyQtO8Q8o2+3+Kt2s5FRKcg==
X-Received: by 2002:a05:6870:8289:b0:240:8382:7834 with SMTP id 586e51a60fabf-24172e2ebe2mr2252473fac.45.1715327992622;
        Fri, 10 May 2024 00:59:52 -0700 (PDT)
Received: from [192.168.6.6] ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b150dfsm2412609b3a.183.2024.05.10.00.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 00:59:52 -0700 (PDT)
Message-ID: <d841cb8f-fb7e-4427-8f21-a850bee3693f@bytedance.com>
Date: Fri, 10 May 2024 15:59:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] objpool: enable inlining objpool_push() and
 objpool_pop() operations
Content-Language: en-US
To: Vlastimil Babka <vbabka@suse.cz>, Andrii Nakryiko <andrii@kernel.org>,
 linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org
Cc: bpf@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20240424215214.3956041-1-andrii@kernel.org>
 <20240424215214.3956041-2-andrii@kernel.org>
 <0e8b7482-478e-4efc-ad5f-76d60cf02bfd@suse.cz>
From: "wuqiang.matt" <wuqiang.matt@bytedance.com>
Autocrypt: addr=wuqiang.matt@bytedance.com; keydata=
 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
 4mCJUdEkdwCS
In-Reply-To: <0e8b7482-478e-4efc-ad5f-76d60cf02bfd@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/5/7 21:55, Vlastimil Babka wrote:
> On 4/24/24 11:52 PM, Andrii Nakryiko wrote:
>> objpool_push() and objpool_pop() are very performance-critical functions
>> and can be called very frequently in kretprobe triggering path.
>>
>> As such, it makes sense to allow compiler to inline them completely to
>> eliminate function calls overhead. Luckily, their logic is quite well
>> isolated and doesn't have any sprawling dependencies.
>>
>> This patch moves both objpool_push() and objpool_pop() into
>> include/linux/objpool.h and marks them as static inline functions,
>> enabling inlining. To avoid anyone using internal helpers
>> (objpool_try_get_slot, objpool_try_add_slot), rename them to use leading
>> underscores.
>>
>> We used kretprobe microbenchmark from BPF selftests (bench trig-kprobe
>> and trig-kprobe-multi benchmarks) running no-op BPF kretprobe/kretprobe.multi
>> programs in a tight loop to evaluate the effect. BPF own overhead in
>> this case is minimal and it mostly stresses the rest of in-kernel
>> kretprobe infrastructure overhead. Results are in millions of calls per
>> second. This is not super scientific, but shows the trend nevertheless.
>>
>> BEFORE
>> ======
>> kretprobe      :    9.794 ± 0.086M/s
>> kretprobe-multi:   10.219 ± 0.032M/s
>>
>> AFTER
>> =====
>> kretprobe      :    9.937 ± 0.174M/s (+1.5%)
>> kretprobe-multi:   10.440 ± 0.108M/s (+2.2%)
>>
>> Cc: Matt (Qiang) Wu <wuqiang.matt@bytedance.com>
>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> Hello,
> 
Hi Vlastimil,

> this question is not specific to your patch, but since it's a recent thread,
> I'll ask it here instead of digging up the original objpool patches.
> 
> I'm trying to understand how objpool works and if it could be integrated
> into SLUB, for the LSF/MM discussion next week:
> 
> https://lore.kernel.org/all/b929d5fb-8e88-4f23-8ec7-6bdaf61f84f9@suse.cz/
> 
>> +/* adding object to slot, abort if the slot was already full */
> 
> I don't see any actual abort in the code (not in this code nor in the
> deleted code - it's the same code, just moved for inlining purposes).
> 
>> +static inline int
>> +__objpool_try_add_slot(void *obj, struct objpool_head *pool, int cpu)
>> +{
>> +	struct objpool_slot *slot = pool->cpu_slots[cpu];
>> +	uint32_t head, tail;
>> +
>> +	/* loading tail and head as a local snapshot, tail first */
>> +	tail = READ_ONCE(slot->tail);
>> +
>> +	do {
>> +		head = READ_ONCE(slot->head);
>> +		/* fault caught: something must be wrong */
>> +		WARN_ON_ONCE(tail - head > pool->nr_objs);
> 
> So this will only WARN if we go over the capacity, but continue and
> overwrite a pointer that was already there, effectively leaking said object, no?

Yes, the WARN is only for error-catch in caller side (try to push one
same object multiple times for example).

> 
>> +	} while (!try_cmpxchg_acquire(&slot->tail, &tail, tail + 1));
>> +
>> +	/* now the tail position is reserved for the given obj */
>> +	WRITE_ONCE(slot->entries[tail & slot->mask], obj);
>> +	/* update sequence to make this obj available for pop() */
>> +	smp_store_release(&slot->last, tail + 1);
>> +
>> +	return 0;
>> +}
>>   
>>   /**
>>    * objpool_push() - reclaim the object and return back to objpool
>> @@ -134,7 +219,19 @@ void *objpool_pop(struct objpool_head *pool);
>>    * return: 0 or error code (it fails only when user tries to push
>>    * the same object multiple times or wrong "objects" into objpool)
>>    */
>> -int objpool_push(void *obj, struct objpool_head *pool);
>> +static inline int objpool_push(void *obj, struct objpool_head *pool)
>> +{
>> +	unsigned long flags;
>> +	int rc;
>> +
>> +	/* disable local irq to avoid preemption & interruption */
>> +	raw_local_irq_save(flags);
>> +	rc = __objpool_try_add_slot(obj, pool, raw_smp_processor_id());
> 
> And IIUC, we could in theory objpool_pop() on one cpu, then later another
> cpu might do objpool_push() and cause the latter cpu's pool to go over
> capacity? Is there some implicit requirements of objpool users to take care
> of having matched cpu for pop and push? Are the current objpool users
> obeying this requirement? (I can see the selftests do, not sure about the
> actual users).
> Or am I missing something? Thanks.

The objects are all pre-allocated along with creation of the new objpool
and the total number of objects never exceeds the capacity on local node.
So objpool_push() would always find an available slot from the ring-array
for the given object to insert back. objpool_pop() would try looping all
the percpu slots until an object is found or whole objpool is empty.

Currently kretprobe is the only actual usecase of objpool.

I'm testing an updated objpool in our HIDS project for critical pathes,
which is widely deployed on servers inside my company. The new version
eliminates the raw_local_irq_save and raw_local_irq_restore pair of
objpool_push and gains up to 5% of performance boost.

> 
>> +	raw_local_irq_restore(flags);
>> +
>> +	return rc;
>> +}
>> +
>>   
>>   /**
>>    * objpool_drop() - discard the object and deref objpool
>> diff --git a/lib/objpool.c b/lib/objpool.c
>> index cfdc02420884..f696308fc026 100644
>> --- a/lib/objpool.c
>> +++ b/lib/objpool.c
>> @@ -152,106 +152,6 @@ int objpool_init(struct objpool_head *pool, int nr_objs, int object_size,
>>   }
>>   EXPORT_SYMBOL_GPL(objpool_init);
>>   
>> -/* adding object to slot, abort if the slot was already full */
>> -static inline int
>> -objpool_try_add_slot(void *obj, struct objpool_head *pool, int cpu)
>> -{
>> -	struct objpool_slot *slot = pool->cpu_slots[cpu];
>> -	uint32_t head, tail;
>> -
>> -	/* loading tail and head as a local snapshot, tail first */
>> -	tail = READ_ONCE(slot->tail);
>> -
>> -	do {
>> -		head = READ_ONCE(slot->head);
>> -		/* fault caught: something must be wrong */
>> -		WARN_ON_ONCE(tail - head > pool->nr_objs);
>> -	} while (!try_cmpxchg_acquire(&slot->tail, &tail, tail + 1));
>> -
>> -	/* now the tail position is reserved for the given obj */
>> -	WRITE_ONCE(slot->entries[tail & slot->mask], obj);
>> -	/* update sequence to make this obj available for pop() */
>> -	smp_store_release(&slot->last, tail + 1);
>> -
>> -	return 0;
>> -}
>> -
>> -/* reclaim an object to object pool */
>> -int objpool_push(void *obj, struct objpool_head *pool)
>> -{
>> -	unsigned long flags;
>> -	int rc;
>> -
>> -	/* disable local irq to avoid preemption & interruption */
>> -	raw_local_irq_save(flags);
>> -	rc = objpool_try_add_slot(obj, pool, raw_smp_processor_id());
>> -	raw_local_irq_restore(flags);
>> -
>> -	return rc;
>> -}
>> -EXPORT_SYMBOL_GPL(objpool_push);
>> -
>> -/* try to retrieve object from slot */
>> -static inline void *objpool_try_get_slot(struct objpool_head *pool, int cpu)
>> -{
>> -	struct objpool_slot *slot = pool->cpu_slots[cpu];
>> -	/* load head snapshot, other cpus may change it */
>> -	uint32_t head = smp_load_acquire(&slot->head);
>> -
>> -	while (head != READ_ONCE(slot->last)) {
>> -		void *obj;
>> -
>> -		/*
>> -		 * data visibility of 'last' and 'head' could be out of
>> -		 * order since memory updating of 'last' and 'head' are
>> -		 * performed in push() and pop() independently
>> -		 *
>> -		 * before any retrieving attempts, pop() must guarantee
>> -		 * 'last' is behind 'head', that is to say, there must
>> -		 * be available objects in slot, which could be ensured
>> -		 * by condition 'last != head && last - head <= nr_objs'
>> -		 * that is equivalent to 'last - head - 1 < nr_objs' as
>> -		 * 'last' and 'head' are both unsigned int32
>> -		 */
>> -		if (READ_ONCE(slot->last) - head - 1 >= pool->nr_objs) {
>> -			head = READ_ONCE(slot->head);
>> -			continue;
>> -		}
>> -
>> -		/* obj must be retrieved before moving forward head */
>> -		obj = READ_ONCE(slot->entries[head & slot->mask]);
>> -
>> -		/* move head forward to mark it's consumption */
>> -		if (try_cmpxchg_release(&slot->head, &head, head + 1))
>> -			return obj;
>> -	}
>> -
>> -	return NULL;
>> -}
>> -
>> -/* allocate an object from object pool */
>> -void *objpool_pop(struct objpool_head *pool)
>> -{
>> -	void *obj = NULL;
>> -	unsigned long flags;
>> -	int i, cpu;
>> -
>> -	/* disable local irq to avoid preemption & interruption */
>> -	raw_local_irq_save(flags);
>> -
>> -	cpu = raw_smp_processor_id();
>> -	for (i = 0; i < num_possible_cpus(); i++) {
>> -		obj = objpool_try_get_slot(pool, cpu);
>> -		if (obj)
>> -			break;
>> -		cpu = cpumask_next_wrap(cpu, cpu_possible_mask, -1, 1);
>> -	}
>> -	raw_local_irq_restore(flags);
>> -
>> -	return obj;
>> -}
>> -EXPORT_SYMBOL_GPL(objpool_pop);
>> -
>>   /* release whole objpool forcely */
>>   void objpool_free(struct objpool_head *pool)
>>   {
> 

Regards,
Matt Wu


