Return-Path: <bpf+bounces-66125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 333F9B2E866
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 01:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 996C27AD243
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 22:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7388A2DC341;
	Wed, 20 Aug 2025 23:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U7l0i6CL"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1111A2356CE
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 23:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755730807; cv=none; b=ZEGSY3lFu5OiBKrEaiV/8/O1jQCud5LOki5lK7EagVnfi3dJhOFqmTGoPXmPrfmtLVJ2L153d9IgdMneOdY9Y5Sg0DZ40381VqSyp1K03jnDnsl2iImXFz2XzPgL1RH3zUe6q7BnqzwHXEJS3ufevLOXJAMz80/Vpb7DFrzMzG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755730807; c=relaxed/simple;
	bh=x4K0iLjGZFeXuNimOGdOcEHhd2/2bbTeCrm3B72xoOk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RvEe8aWh7S97i1NBT4NkdkIDTig4gwwzRlBXWVY9gbEGzh1TP1K89Bu/14stul8uIDncjrH3AAQgkfxbjFWzvOCegBZQOBeYseLSu7MJvLeck9/iIdGob2GLzzyMf1nha7W7KyvnBCsaNeaTqMXuoefyJ+TE0LqtrA24FOVf3iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U7l0i6CL; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755730800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LwMfKt/z+b32Yog71y0IpHQR50ir1+SPpvMPlDiQyXM=;
	b=U7l0i6CLs6K5elGR2S9r3KYV+KT3KbqTIrQKQ4wXxtsjxNCdZjVBOTgvSdznS3eWHzCcNj
	yoXFsMF3+BeByV5AOH6oeYMWD8+Xc9fai/nBhrUKeCusI2O3ZuyRhw20Hzssg7XDCT743J
	cS0Oxf9asNw/vgky++prC0R8zDSg+4M=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: linux-mm@kvack.org,  bpf@vger.kernel.org,  Suren Baghdasaryan
 <surenb@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Michal Hocko
 <mhocko@suse.com>,  David Rientjes <rientjes@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  Song Liu <song@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 06/14] mm: introduce bpf_out_of_memory() bpf kfunc
In-Reply-To: <CAP01T777JF7wvHDaQ-Bz-Vp_dFM=NXvpAK0RY7kLjs2amEd85Q@mail.gmail.com>
	(Kumar Kartikeya Dwivedi's message of "Wed, 20 Aug 2025 11:34:39
	+0200")
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
	<20250818170136.209169-7-roman.gushchin@linux.dev>
	<CAP01T777JF7wvHDaQ-Bz-Vp_dFM=NXvpAK0RY7kLjs2amEd85Q@mail.gmail.com>
Date: Wed, 20 Aug 2025 15:59:53 -0700
Message-ID: <87349loaza.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Mon, 18 Aug 2025 at 19:02, Roman Gushchin <roman.gushchin@linux.dev> wrote:
>>
>> Introduce bpf_out_of_memory() bpf kfunc, which allows to declare
>> an out of memory events and trigger the corresponding kernel OOM
>> handling mechanism.
>>
>> It takes a trusted memcg pointer (or NULL for system-wide OOMs)
>> as an argument, as well as the page order.
>>
>> If the wait_on_oom_lock argument is not set, only one OOM can be
>> declared and handled in the system at once, so if the function is
>> called in parallel to another OOM handling, it bails out with -EBUSY.
>> This mode is suited for global OOM's: any concurrent OOMs will likely
>> do the job and release some memory. In a blocking mode (which is
>> suited for memcg OOMs) the execution will wait on the oom_lock mutex.
>>
>> The function is declared as sleepable. It guarantees that it won't
>> be called from an atomic context. It's required by the OOM handling
>> code, which is not guaranteed to work in a non-blocking context.
>>
>> Handling of a memcg OOM almost always requires taking of the
>> css_set_lock spinlock. The fact that bpf_out_of_memory() is sleepable
>> also guarantees that it can't be called with acquired css_set_lock,
>> so the kernel can't deadlock on it.
>>
>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> ---
>>  mm/oom_kill.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>
>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>> index 25fc5e744e27..df409f0fac45 100644
>> --- a/mm/oom_kill.c
>> +++ b/mm/oom_kill.c
>> @@ -1324,10 +1324,55 @@ __bpf_kfunc int bpf_oom_kill_process(struct oom_control *oc,
>>         return 0;
>>  }
>>
>> +/**
>> + * bpf_out_of_memory - declare Out Of Memory state and invoke OOM killer
>> + * @memcg__nullable: memcg or NULL for system-wide OOMs
>> + * @order: order of page which wasn't allocated
>> + * @wait_on_oom_lock: if true, block on oom_lock
>> + * @constraint_text__nullable: custom constraint description for the OOM report
>> + *
>> + * Declares the Out Of Memory state and invokes the OOM killer.
>> + *
>> + * OOM handlers are synchronized using the oom_lock mutex. If wait_on_oom_lock
>> + * is true, the function will wait on it. Otherwise it bails out with -EBUSY
>> + * if oom_lock is contended.
>> + *
>> + * Generally it's advised to pass wait_on_oom_lock=true for global OOMs
>> + * and wait_on_oom_lock=false for memcg-scoped OOMs.
>> + *
>> + * Returns 1 if the forward progress was achieved and some memory was freed.
>> + * Returns a negative value if an error has been occurred.
>> + */
>> +__bpf_kfunc int bpf_out_of_memory(struct mem_cgroup *memcg__nullable,
>> +                                 int order, bool wait_on_oom_lock)
>
> I think this bool should be a u64 flags instead, just to make it
> easier to extend behavior in the future.

I like it, will change in the next version.

Thanks for the idea and also for reviewing the series!

