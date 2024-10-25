Return-Path: <bpf+bounces-43163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D759B04E6
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 16:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1E11F241F5
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE271487C8;
	Fri, 25 Oct 2024 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hVhY/bcC"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68892212168
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864923; cv=none; b=YGWh6tiXkwQkkv8/CfNqN3gIJ1Wfp64avjnmMNf/z2eMZgFdkfPR2OQ4UYJw4AK+SBAm5crPgLNCbe2h6k1FSMxHdw/9w3dVeUcOTQt+W3aH3imG8vmvfNcSqLKkpooiVvhBJix41PM17cI+/yP/Ko6dxiyBcFyq9PXU+m4V3G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864923; c=relaxed/simple;
	bh=9wndvJO3ogqWEj0x3FhbMNOsLUJxzLNQrABREFnrRig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QYpHrxZSX8oR7VmD7KAivaJuK+pqMC25CB/l/AHI5Xwj0+6T2Vu+Kjou+jh3cCA03EhKbqfv1AC+/ZcHEYHBWLQo7bQcQsILMCNnwJ8mmdXLij9Mq1Ut0aK22LmV5Idkc3mf8EQ62bbpWVyCq6CIzBCy24+J/zDBfrW0dDmpLGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hVhY/bcC; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d5222de7-020c-4bff-b314-86a232d42065@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729864917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rBCdG6WwJhOW/rUHSB00moCZ/CTrIeGoZ5I8AiZp+dc=;
	b=hVhY/bcCZHdAN+6y02oC4K3l6CusmAtAf5zuCoexL8bF8LECephd+sLiYcM15p2RiTNHeX
	wh+iKQuZIi1/JgdP4MYlZVVx1DPidSz6tmLl8NalaN+kNR3R7ArBzeo09iVyNBl/anmksD
	abv3S8LDp7bJb7AXL8bHeg5mPup8HuQ=
Date: Fri, 25 Oct 2024 15:01:51 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add bpf_get_hw_counter kfunc
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, bpf@vger.kernel.org
References: <20241024205113.762622-1-vadfed@meta.com>
 <CAEf4BzZa8QCxFO0YPk3LQE2A_kp2yawN-h24V+RoiH7q8BLVVw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAEf4BzZa8QCxFO0YPk3LQE2A_kp2yawN-h24V+RoiH7q8BLVVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 25/10/2024 00:17, Andrii Nakryiko wrote:
> On Thu, Oct 24, 2024 at 1:51 PM Vadim Fedorenko <vadfed@meta.com> wrote:
>>
>> New kfunc to return ARCH-specific timecounter. For x86 BPF JIT converts
>> it into rdtsc ordered call. Other architectures will get JIT
>> implementation too if supported. The fallback is to
>> __arch_get_hw_counter().
>>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>> v1 -> v2:
>> * Fix incorrect function return value type to u64
>> * Introduce bpf_jit_inlines_kfunc_call() and use it in
>>    mark_fastcall_pattern_for_call() to avoid clobbering in case of
>>          running programs with no JIT (Eduard)
>> * Avoid rewriting instruction and check function pointer directly
>>    in JIT (Alexei)
>> * Change includes to fix compile issues on non x86 architectures
>> ---
>>   arch/x86/net/bpf_jit_comp.c   | 30 ++++++++++++++++++++++++++++++
>>   arch/x86/net/bpf_jit_comp32.c | 16 ++++++++++++++++
>>   include/linux/filter.h        |  1 +
>>   kernel/bpf/core.c             | 11 +++++++++++
>>   kernel/bpf/helpers.c          |  7 +++++++
>>   kernel/bpf/verifier.c         |  4 +++-
>>   6 files changed, 68 insertions(+), 1 deletion(-)
>>
> 
> [...]
> 
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 5c3fdb29c1b1..f7bf3debbcc4 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -23,6 +23,7 @@
>>   #include <linux/btf_ids.h>
>>   #include <linux/bpf_mem_alloc.h>
>>   #include <linux/kasan.h>
>> +#include <vdso/datapage.h>
>>
>>   #include "../../lib/kstrtox.h"
>>
>> @@ -3023,6 +3024,11 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void __user
>>          return ret + 1;
>>   }
>>
>> +__bpf_kfunc u64 bpf_get_hw_counter(void)
> 
> Hm... so the main idea behind this helper is to measure latency (i.e.,
> time), right? So, first of all, the name itself doesn't make it clear
> that this is **time stamp** counter, so maybe let's mention
> "timestamp" somehow?

Well, it's time stamp counter only on x86. Other architectures use cycle
or time counter naming. We might think of changing it to
bpf_get_hw_cycle_counter() if it gives more information.

> But then also, if I understand correctly, it will return the number of
> cycles, right? 

Yes, it will return the amount of cycles passed from the last CPU reset.

> And users would need to somehow convert that to
> nanoseconds to make it useful.

That's questionable. If you think about comparing the performance of the
same kernel function or bpf program on machines with the same
architecture but different generation or slightly different base
frequency. It's much more meaningful to compare CPU cycles instead of
nanoseconds. And with current CPU base frequencies cycles will be more
precise than nanoseconds.

> Is it trivial to do that from the BPF side?

Unfortunately, it is not. The program has to have an access to the cycle
counter configuration/specification to convert cycles to any time value.

 > If not, can we specify this helper to return nanoseconds instead> of 
cycles, maybe?

If we change the specification of the helper to return nanoseconds,
there will be no actual difference between this helper and
bpf_ktime_get_ns() which ends up in read_tsc() if tsc is setup as
system clock source.
At the same time I agree that it might be useful to have an option to
convert cycles into nanoseconds. I can introduce another helper to do
the actual conversion of cycles into nanoseconds using the same 
mechanics as in timekeeping or vDSO implementation of gettimeofday().
The usecase I see here is that the program can save start point in
cycles, then execute the function to check the latency, get the
cycles right after function ends and then use another kfunc to convert
cycles spent into nanoseconds. There will be no need to have this
additional kfunc inlined because it won't be on hot-path. WDYT?

> It would be great if selftest demonstratef the intended use case of
> measuring some kernel function latency (or BPF helper latency, doesn't
> matter much).

I can implement a use case described above if it's OK.

> 
> [...]


