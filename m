Return-Path: <bpf+bounces-76887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C65CC9094
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 18:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C59A13018185
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 17:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AC3350A33;
	Wed, 17 Dec 2025 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cm7O/hG5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BC934D923
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765991973; cv=none; b=jwqkyRHWr4il92LyhWkhYWiCZZ2NzJk6f20UpxOP7aFBUMUHXa1V0bzRWFGK1eIvghA2xo9SnItHOK5A59ZfsxG09a3RA1/bSJ4U7OcqWNkWDY0SkNy0ADaDOQwxNGyWVU/B9EcyixVlyUuTufDs0Wn7qa1jgdgDcgP+ntY0SX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765991973; c=relaxed/simple;
	bh=nxfMjWlGH75gU72zw0mAEOa0tjE5Lk2Vo0HgdWgx5UY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bieMkbIpckjqKQXUwR8tfgTc31r9MxQ3kxbZRUfsQJS6Uljbz2AvMVNTQUmS4LdSwgv5o/GaXXTx9PjptqLi/unqnrRx2CrB54okayLmR3L1oK4oaRfNCC6NajfoSQAi9CyE5p616rkKxIZLp/zsofK5+apefJ1yn85l+FidxPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cm7O/hG5; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-430f8866932so2734366f8f.1
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 09:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765991968; x=1766596768; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fmH64XmJ0F0IHGr/hDAMtzC5HIceqcOPcSCpGBeY+GU=;
        b=cm7O/hG56tBzvgILJp5bz/3kQnjx3fHybSEh3IVD4xmrwqJORcK4XvkN76yoAt3bC6
         RhL86m8WqBENIlwXIxpUvqhS5i2Chvzw1BrqvInHg00y0e4rXhFMNVOWnC+P4/DAIXw6
         pu6zj3KDVEqB1GfkFqQuU5rUp7tNI3o4aqtM5WAm6nqSshS1mlnoIqbp4QiIgvhV3glI
         p6WG1MUlaWHAk0eTdFpWdbsQeqUATKc3/viFRieEr2r5TAjlh1jSSkbBAnpVr7hIWOO8
         6/37Rt/4dGFtLNP9bOWeFDgdB1PYN/M3dz/tSdrurqWfQgv73FP6Zz5hM2lxckba55rp
         vU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765991968; x=1766596768;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmH64XmJ0F0IHGr/hDAMtzC5HIceqcOPcSCpGBeY+GU=;
        b=E6/i+dev7zqzj4r3PCD2++o7pNVHAoiSyjxbMS73iub04s4wlaCpvmQCrIRl2nUGq1
         YIyBxaX4IiVHun/S84jyGFJbDK6X+bDHaRMFA8m775Qe2nSc5MjBnNgVe1k1Dhgbu0+y
         k/U2NvmnpltgmnOxrHX5mM5JFeGOOeELjk08dQx90StcJb4rYk4ulEYA0VXxu1I5DdJh
         2gW+vHyrekqfLRvcZI9z+996e63oAY1pTaWFJ33Jwf+b/0Zct8FKP04TgjLRMSxcTNbC
         b2mPXRU/Mw/Dd6j3UIvjRV8SlgV2sfCBJBCYOuYyq5A/I44GOk5QugjZdTxp51t6CCP9
         UJrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh4/POdplCm75a21aE8JUo7v8BRxTjEWIVuaesTN976NL+1o0kh1T95Q1wKpCJM59PJpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPt316mhOr79wcMF/Tu0jBeM+UW2LaxSgIMYti/JUZNXOMOnHc
	y9HOab7FzAEgG/+eUHUMogqPGCgyxofZ0anCpUcqkXazTPQudJo4Vj4L0SE7xgvxfaYQ3xdINis
	rQFpw8SUs0I+4Lw==
X-Google-Smtp-Source: AGHT+IHT10heBTKc0la75zjUcdcWeKQLxIjteE6wN3WG7RYWYRpvl3lG55/6zSe2LENPLJF5rOBhHUOFskHNYw==
X-Received: from wrbfo17.prod.google.com ([2002:a05:6000:2911:b0:430:fdbe:cc61])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2404:b0:431:864:d492 with SMTP id ffacd0b85a97d-4310864d73emr6566925f8f.36.1765991967910;
 Wed, 17 Dec 2025 09:19:27 -0800 (PST)
Date: Wed, 17 Dec 2025 17:19:27 +0000
In-Reply-To: <d5354d96-6f28-41d7-9f66-64c254d9477b@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251212161832.2067134-1-yeoreum.yun@arm.com> <916c17ba-22b1-456e-a184-cb3f60249af7@arm.com>
 <aUGOPd7gNRf1xHEc@e129823.arm.com> <100cc8da-b826-4fc2-a624-746bf6fb049d@arm.com>
 <aUKKZR0u22KOPfd7@e129823.arm.com> <d96ac977-222e-4e8d-9487-da1306198419@arm.com>
 <aUKnfU/3FREY13g1@e129823.arm.com> <d912480a-5229-4efe-9336-b31acded30f5@suse.cz>
 <DF0J58HOVLL4.2E16Q87D2UXRW@google.com> <d5354d96-6f28-41d7-9f66-64c254d9477b@suse.cz>
X-Mailer: aerc 0.21.0
Message-ID: <DF0NWLWKRKYI.3PLY78UGGG2PD@google.com>
Subject: Re: [PATCH 0/2] introduce pagetable_alloc_nolock()
From: Brendan Jackman <jackmanb@google.com>
To: Vlastimil Babka <vbabka@suse.cz>, Brendan Jackman <jackmanb@google.com>, 
	Yeoreum Yun <yeoreum.yun@arm.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: <akpm@linux-foundation.org>, <david@kernel.org>, 
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <rppt@kernel.org>, 
	<surenb@google.com>, <mhocko@suse.com>, <ast@kernel.org>, 
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>, 
	<eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>, 
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>, 
	<haoluo@google.com>, <jolsa@kernel.org>, <hannes@cmpxchg.org>, 
	<ziy@nvidia.com>, <bigeasy@linutronix.de>, <clrkwllms@kernel.org>, 
	<rostedt@goodmis.org>, <catalin.marinas@arm.com>, <will@kernel.org>, 
	<kevin.brodsky@arm.com>, <dev.jain@arm.com>, <yang@os.amperecomputing.com>, 
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, 
	<linux-rt-devel@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

>> From 4c6b4d4cb08aee9559d02a348b9ecf799142c96f Mon Sep 17 00:00:00 2001
>> From: Brendan Jackman <jackmanb@google.com>
>> Date: Wed, 17 Dec 2025 13:26:28 +0000
>> Subject: [PATCH] mm: clarify GFP_ATOMIC/GFP_NOWAIT doc-comment
>> 
>> The current description of contexts where it's invalid to make
>> GFP_ATOMIC and GFP_NOWAIT calls is rather vague.
>> 
>> Replace this with a direct description of the actual contexts of concern
>> and refer to the RT docs where this is explained more discursively.
>> 
>> While rejigging this prose, also move the documentation of GFP_NOWAIT to
>> the GFP_NOWAIT section.
>
> There doesn't seem to be any move?

This is referring to [0] and [1].

>> diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
>> index 3de43b12209ee..07a378542caf2 100644
>> --- a/include/linux/gfp_types.h
>> +++ b/include/linux/gfp_types.h
>> @@ -309,8 +309,10 @@ enum {
>>   *
>>   * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
>>   * watermark is applied to allow access to "atomic reserves".
>> - * The current implementation doesn't support NMI and few other strict
>> - * non-preemptive contexts (e.g. raw_spin_lock). The same applies to %GFP_NOWAIT.
[0]                                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^
>> + * The current implementation doesn't support NMI, nor contexts that disable
>> + * preemption under PREEMPT_RT. This includes raw_spin_lock() and plain
>> + * preempt_disable() - see Documentation/core-api/real-time/differences.rst for
>> + * more info.
>
> Can we reference the "Memory allocation" section directly?

Yeah good point. I will send this as a standalone [PATCH] mail tomorrow.

>>   *
>>   * %GFP_KERNEL is typical for kernel-internal allocations. The caller requires
>>   * %ZONE_NORMAL or a lower zone for direct access but can direct reclaim.
>> @@ -321,6 +323,7 @@ enum {
>>   * %GFP_NOWAIT is for kernel allocations that should not stall for direct
>>   * reclaim, start physical IO or use any filesystem callback.  It is very
>>   * likely to fail to allocate memory, even for very small allocations.
>> + * The same restrictions on calling contexts apply as for %GFP_ATOMIC.
[1]     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


