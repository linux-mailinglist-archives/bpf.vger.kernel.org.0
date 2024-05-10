Return-Path: <bpf+bounces-29441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 063D48C20A5
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 11:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D5C1F22422
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 09:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ADC161337;
	Fri, 10 May 2024 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="L3paxPLj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C751607B2
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332566; cv=none; b=s1ON9mUnZR02iWCgcLkcD47geUB26BzGvNKCgQk3dJzRj2EXTDxrOi6cLiaTHcGavJZ4HN2M4oM0jO48euRtw0mr8cTGwUbgPc3xFkpuRf1eaXmXCWXf6JrlebehlkD8TiNDoNUisuFWGVR/0zloycsMbvfOXOHP0puNxwFvZOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332566; c=relaxed/simple;
	bh=POHfwIm45CSmeIvSVNf0lMSzO6/PHU/1iSwebp4tWDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SAIYxDun11md/YkpVBeA1TBerVfqxSvGYj7J8c8TiYwGihZxHrCM9JtQtwgWUW+91t4SO4fBEi0275rrfcTAIshkECg9kI4+WW1oxmd+g+Tcl8mKWnUukI09h/Pk+QKnPuiVd3bLeY8WnK2JC6SjsE9Th5TUiU3nsVX/kGwZNQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=L3paxPLj; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f44dd41a5cso1844354b3a.0
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 02:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715332563; x=1715937363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=09EsDfPDeujlowp8cn8X0gI+Ox3NPGsb8Dl/irRuSw8=;
        b=L3paxPLjgGQmfHJTQdLZceAqAwDPmGgMn3JdNxkj5diOf3GQo6i8scBywPda5T8KJB
         KZGZsAkWPlQHhhd7REyfc+4F8z5kIdtlhsHRKWvH+Ww1YrjmiHa1bHcdti4GEbE9hFBM
         moFVM4dTsFa6RuThF4Jq8BLspEBJGu+LxZ8Z4f3Xo0r1Dbu8bh+1QI3EjdE1QFHjB0nE
         6PBsCnY6cj8ZZuf+uiwJUcmPMe7fpbnRQRzZTwoHGaX4IbiVwBZmUWHWmMwtAJIqX43c
         zkb7r9ZjgiCmf6x8vJL5uCYFRT2KqdL/1PTDMIMDeIF+jtD5/Y8RKN4ERrQTiU2kjPRH
         UXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715332563; x=1715937363;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09EsDfPDeujlowp8cn8X0gI+Ox3NPGsb8Dl/irRuSw8=;
        b=XY9TEWLTpZkx/OPAKPDzITh1WNsNGSwhqEKVcm2mMtnHf9m7NhM3ForPQbbWDHbBeR
         M4+q2Yj7+lBFR3wIV4eMJSk3HrI3ladEXeDpnpmnKjFy00abYWDy2RC/vx9P8Pm2+3eS
         t2mOvVgsvehMUIAV0R162EnONQCZR36uJi3FWU49TkAWjs+VmB98c2Mz+kwAAKpWd1qQ
         jNj7Q45NqUDMCuX/Dxto17m7yxfLKmc1/WzoYlLlnSdwMitG2H9lkWEtFyvEiRnYa241
         dG83uLK5WNcFtcLCIjVW39bhHpPsTlcCfePMDv1c3b6V7kLLESzkvDvesGvxOwx/1Nay
         +r/g==
X-Gm-Message-State: AOJu0YxCAFcuttejYG9Aejf2QbaNsd+h+drL1aKDxVMwdzZ2rsz6ExN1
	GmHUHVYUCtx7nYijP91d2TqTRYpKnpW1hwLHy7jxB804gcHBXNw3JlDu2ya1VUM=
X-Google-Smtp-Source: AGHT+IHl6UAzuZOMPjDf4Od9c7F6KGtPLJVjk3aQi8MBMga6hDZ+zPHnwB83YbCEAN9WvBdUo///xA==
X-Received: by 2002:a05:6a20:dc95:b0:1af:9369:9a3 with SMTP id adf61e73a8af0-1afde1b70a0mr2350397637.44.1715332563134;
        Fri, 10 May 2024 02:16:03 -0700 (PDT)
Received: from [192.168.6.6] ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2fe07sm2520501b3a.216.2024.05.10.02.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 02:16:02 -0700 (PDT)
Message-ID: <6994f6c1-29eb-46cb-942e-c2d1e3fe9f5d@bytedance.com>
Date: Fri, 10 May 2024 17:15:58 +0800
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
 <d841cb8f-fb7e-4427-8f21-a850bee3693f@bytedance.com>
 <93840eb4-609d-49d3-b48a-9c26bfb5b8ec@suse.cz>
From: "wuqiang.matt" <wuqiang.matt@bytedance.com>
Autocrypt: addr=wuqiang.matt@bytedance.com; keydata=
 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
 4mCJUdEkdwCS
In-Reply-To: <93840eb4-609d-49d3-b48a-9c26bfb5b8ec@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/10 16:20, Vlastimil Babka wrote:
> On 5/10/24 9:59 AM, wuqiang.matt wrote:
>> On 2024/5/7 21:55, Vlastimil Babka wrote:
>   >>
>>>> +	} while (!try_cmpxchg_acquire(&slot->tail, &tail, tail + 1));
>>>> +
>>>> +	/* now the tail position is reserved for the given obj */
>>>> +	WRITE_ONCE(slot->entries[tail & slot->mask], obj);
>>>> +	/* update sequence to make this obj available for pop() */
>>>> +	smp_store_release(&slot->last, tail + 1);
>>>> +
>>>> +	return 0;
>>>> +}
>>>>    
>>>>    /**
>>>>     * objpool_push() - reclaim the object and return back to objpool
>>>> @@ -134,7 +219,19 @@ void *objpool_pop(struct objpool_head *pool);
>>>>     * return: 0 or error code (it fails only when user tries to push
>>>>     * the same object multiple times or wrong "objects" into objpool)
>>>>     */
>>>> -int objpool_push(void *obj, struct objpool_head *pool);
>>>> +static inline int objpool_push(void *obj, struct objpool_head *pool)
>>>> +{
>>>> +	unsigned long flags;
>>>> +	int rc;
>>>> +
>>>> +	/* disable local irq to avoid preemption & interruption */
>>>> +	raw_local_irq_save(flags);
>>>> +	rc = __objpool_try_add_slot(obj, pool, raw_smp_processor_id());
>>>
>>> And IIUC, we could in theory objpool_pop() on one cpu, then later another
>>> cpu might do objpool_push() and cause the latter cpu's pool to go over
>>> capacity? Is there some implicit requirements of objpool users to take care
>>> of having matched cpu for pop and push? Are the current objpool users
>>> obeying this requirement? (I can see the selftests do, not sure about the
>>> actual users).
>>> Or am I missing something? Thanks.
>>
>> The objects are all pre-allocated along with creation of the new objpool
>> and the total number of objects never exceeds the capacity on local node.
> 
> Aha, I see, the capacity of entries is enough to hold objects from all nodes
> in the most unfortunate case they all end up freed from a single cpu.
> 
>> So objpool_push() would always find an available slot from the ring-array
>> for the given object to insert back. objpool_pop() would try looping all
>> the percpu slots until an object is found or whole objpool is empty.
> 
> So it's correct, but seems rather wasteful to have the whole capacity for
> entries replicated on every cpu? It does make objpool_push() simple and
> fast, but as you say, objpool_pop() still has to search potentially all
> non-local percpu slots, with disabled irqs, which is far from ideal.

Yes, it's a trade-off between performance and memory usage, with a slight
increase of memory consumption for a significant improvement of performance.

The reason of disabling local irqs is objpool uses a 32bit sequence number
as the state description of each element. It could likely overflow and go
back with the same value for extreme cases. 64bit value could eliminate the
collision but seems too heavy.

> And the "abort if the slot was already full" comment for
> objpool_try_add_slot() seems still misleading? Maybe that was your initial
> idea but changed later?

Right, the comments are just left unchanged during iterations. The original
implementation kept each percpu ring-array very compact and objpool_push will
try looping all cpu nodes to return the given object to objpool.

Actually my new update would remove objpool_try_add_slot and integrate it's 
functionality into objpool_push. I'll submit the new patch when I finish the
verification.

> 
>> Currently kretprobe is the only actual usecase of objpool.
>>
>> I'm testing an updated objpool in our HIDS project for critical pathes,
>> which is widely deployed on servers inside my company. The new version
>> eliminates the raw_local_irq_save and raw_local_irq_restore pair of
>> objpool_push and gains up to 5% of performance boost.
> 
> Mind Ccing me and linux-mm once you are posting that?

Sure, I'll make sure to let you know.

> Thanks,
> Vlastimil
> 

Regards,
Matt Wu

