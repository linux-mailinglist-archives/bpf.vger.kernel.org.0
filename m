Return-Path: <bpf+bounces-38045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF7995E80C
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 07:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462281F217AC
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 05:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AFF7404B;
	Mon, 26 Aug 2024 05:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRuUzEPV"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E031B8C11
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 05:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724651044; cv=none; b=QTUHTt+5sAosMTDyOIsivA+cHIeT4YHrVx25k372ad/eEfvprom5f8SBeC/86EIF4YwBTrlY4iy7h+q9EJgFxFKnmcnwQidgsSKDXRXbnHfJx1KCGKtUWBEEDFjLosqP/U75onVb9WECxzQ6OAOcNJuy9HBIvQir5jtk1OQzEyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724651044; c=relaxed/simple;
	bh=Q1oRQngxTTnA3gPaTQEECKTXmvsVDUYO1PaMuD5a8qI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eENfgACkBvJWO9ylYqnJ/ahrTG6ehR3jzuwa2ZomQVJIO9t4S0N+BkGoQlcwzy8Il0pM8tH8NlDRllJHbkKDJ5VCpf7fSaL0/L8Jhl8Rt508l6EwU1olw7ibJNYaIVcLNLlbvh4VvVZm+yPYNcMLu9NdQiryssTO/p9HioUcRL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RRuUzEPV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724651041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yxtq9iY/r8SrNDlVi18vzeYR1SSCUPaDrfoqXoIobZg=;
	b=RRuUzEPVh9Mh3AI8SZdoP8xy3MJ6KOyfQmb4ldQ5nHj4V1MfFckv5rKHQgLHWV1eTs0OM7
	aZxdJA+32nQR0/DJFend5cjAVzS4KmwJQqz2KboWZk0jvN2yq4iG8Ubm3ByB+TvAb5iRz8
	YnXAkKwhBwkvb8sOu5NS8wr3pnzvBY4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-DG1VC69RNUyaFWj5IRWuKQ-1; Mon, 26 Aug 2024 01:43:59 -0400
X-MC-Unique: DG1VC69RNUyaFWj5IRWuKQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5bec6d21e36so3204519a12.3
        for <bpf@vger.kernel.org>; Sun, 25 Aug 2024 22:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724651039; x=1725255839;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yxtq9iY/r8SrNDlVi18vzeYR1SSCUPaDrfoqXoIobZg=;
        b=mL/W6rf/F6A/MbZnwGw3wDN4DS12ixj0M0mwZ1XwdEUbE5BIRgiOGA2oeoKZpOlsro
         X9e7PEcYhGh7MybrdSLm2DTVh9Ms26ZENj6ZqQ/W5KsPo8aksUQff/Gilcb0bSype1TB
         F8iwMA2DY6eP5/J518xhzSBskh2eMwXcLeO1oSzN0qPJ5rz3LyreIjPlDB1gEpJVswwK
         c2kju2RBX4dp1CtyqPRbAiwuMcwOEY4CJEbiJyUfWGT02LLOEagmep9n5vPK39mDzCKc
         R8+DIuHf14jqnqZsblfxXKGt8Zi4BK84kdIjUueFXa8NKFByEkgPYfp5SKZN3WUWdLyD
         ceng==
X-Forwarded-Encrypted: i=1; AJvYcCVpgIQVgnjeU+UsxM7LD8d+OTGUJg568kOWCLhXJkCXcm31hZ2jfNMFzpS2nzlWOGSwykU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiUi9yRtp1xcQHm9xYUA/0BzA+33KEjloF+Q9otlFtyM1ieSQJ
	06Hv4qOdruwnav1CucLNl9z6dR0gWRoc/55mG0xWfg9yxItUCLgCKqGjrSwu2SNfdyYez8WThUi
	JUPqBXdpVCi4FiZTVbMFlZD6+ojwuUBAMwTFoCLFGNcGx7tI0
X-Received: by 2002:a17:907:724a:b0:a86:43c0:7d2 with SMTP id a640c23a62f3a-a86a4eb39b3mr511870866b.0.1724651038660;
        Sun, 25 Aug 2024 22:43:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAefvNNdN/mHju3rH0d4R1UkuSc7CWVPuD7wnSHEo0s3htw2tBWER4ScnjSBcqkuUNBI2WVQ==
X-Received: by 2002:a17:907:724a:b0:a86:43c0:7d2 with SMTP id a640c23a62f3a-a86a4eb39b3mr511869566b.0.1724651037854;
        Sun, 25 Aug 2024 22:43:57 -0700 (PDT)
Received: from [192.168.0.113] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f222b2esm614124866b.24.2024.08.25.22.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 22:43:57 -0700 (PDT)
Message-ID: <3eab33a2-0f04-4285-b705-d82e886184a7@redhat.com>
Date: Mon, 26 Aug 2024 07:43:56 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] objpool: fix choosing allocation for percpu slots
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Matt Wu
 <wuqiang.matt@bytedance.com>, bpf@vger.kernel.org
References: <20240822082519.216070-1-vmalik@redhat.com>
 <CAEf4BzbY4XWLFKgH1cB+86jsr0snRU2gG_UNZ7O1+3mg0hb9eQ@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAEf4BzbY4XWLFKgH1cB+86jsr0snRU2gG_UNZ7O1+3mg0hb9eQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/22/24 11:30 PM, Andrii Nakryiko wrote:
> On Thu, Aug 22, 2024 at 1:27 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> objpool intends to use vmalloc for default (non-atomic) allocations of
>> percpu slots and objects. However, the condition checking if GFP flags
>> are equal to GFP_ATOMIC is wrong and causes kmalloc to be used in most
> 
> I was confused by this, because original code has no equality and it
> looks like correct code. But in reality GFP_ATOMIC is a collection of
> bits (__GFP_HIGH|__GFP_KSWAPD_RECLAIM), and so `pool->gfp &
> GFP_ATOMIC` will be true if either bit is set, hence your change.
> Also, GFP_ATOMIC and GFP_KERNEL share ___GFP_KSWAPD_RECLAIM bit
> specifically, which is what causes the use of kmalloc_node(), always.
> 
> It would be nice to expand on that in the commit. Other than that LGTM

Right, the commit message could use a better explanation, thanks!

I'll update it, add the acks, and send v2.

Viktor

> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
>> cases (even if GFP_KERNEL is requested). Since kmalloc cannot allocate
>> large amounts of memory, this may lead to unexpected OOM errors.
>>
>> For instance, objpool is used by fprobe rethook which in turn is used by
>> BPF kretprobe.multi and kprobe.session probe types. Trying to attach
>> these to all kernel functions with libbpf using
>>
>>     SEC("kprobe.session/*")
>>     int kprobe(struct pt_regs *ctx)
>>     {
>>         [...]
>>     }
>>
>> fails on objpool slot allocation with ENOMEM.
>>
>> Fix the condition to truly use vmalloc by default.
>>
>> Fixes: b4edb8d2d464 ("lib: objpool added: ring-array based lockless MPMC")
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---
>>  lib/objpool.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/objpool.c b/lib/objpool.c
>> index 234f9d0bd081..fd108fe0d095 100644
>> --- a/lib/objpool.c
>> +++ b/lib/objpool.c
>> @@ -76,7 +76,7 @@ objpool_init_percpu_slots(struct objpool_head *pool, int nr_objs,
>>                  * mimimal size of vmalloc is one page since vmalloc would
>>                  * always align the requested size to page size
>>                  */
>> -               if (pool->gfp & GFP_ATOMIC)
>> +               if ((pool->gfp & GFP_ATOMIC) == GFP_ATOMIC)
>>                         slot = kmalloc_node(size, pool->gfp, cpu_to_node(i));
>>                 else
>>                         slot = __vmalloc_node(size, sizeof(void *), pool->gfp,
>> --
>> 2.46.0
>>
>>
> 


