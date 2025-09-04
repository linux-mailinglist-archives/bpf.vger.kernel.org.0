Return-Path: <bpf+bounces-67386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7B3B42FCE
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 04:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D831BC6681
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 02:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8591FAC34;
	Thu,  4 Sep 2025 02:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m+16xFdK"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC8A129E6E
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 02:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756953395; cv=none; b=jMBKybItRVDThuWR7T6IQUcB8AisqQZ0Zrltlc5PZZjfpHp8WX3nGCuHb/3tlOJn1BUjAl1XUCGJvRG/OIw3ji5Rph3Xjr4C8q/Cwt1blfs1aEXX906dIXw/Y10XAZBTWY3oynBb9FML9tbZ9KVetS2ws7TfG1u9P9gRuJnmk5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756953395; c=relaxed/simple;
	bh=6bPgq0uuIfc1SOjnfNfm5Z6ziy+jTFRkm4MqCx8g5KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=to2jWgq2fsPlbef4D6tZxN/Mu/W9+fRB2UsoPhBFeIZb+DXukMCwLHXa1EHjpR9qXr0jd22noh2QTjuYJj+vytCQsiTqeI6Y3K3/J0Am+pJ/CINofKz3B022Y1/QnHitSSXLsxbgqDVnuR5/DEeOeG90uVLc/12yGjoFXsOn53U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m+16xFdK; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b28aa5f0-053a-4e32-b0c8-88295fd8001e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756953391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PmyHYLXEcLu/Jpbj8J6U/tPWnLBvNEljpuFNn1AvWlU=;
	b=m+16xFdKuBm/0ECvoSZBg3tQM6c2QkIepDoXbiaw8AujzmgfcfjaZeEs920tCa7VnDrkmQ
	9U59RswhIxZNhwVFz8eBPD2T6kMwwAjgB2IHTxtCJafixl2JHpvDxm2a732xnv8ok/gr0b
	b0dUtu340rQ0lUPUC9vAS+0ygOrik+o=
Date: Thu, 4 Sep 2025 10:36:24 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/7] bpf: Introduce BPF_F_CPU and
 BPF_F_ALL_CPUS flags
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev,
 song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net,
 kernel-patches-bot@fb.com
References: <20250827164509.7401-1-leon.hwang@linux.dev>
 <20250827164509.7401-3-leon.hwang@linux.dev>
 <CAEf4BzaUw868nNG3ngMci4fLPDGsaffQ-O3YrPOEo7N5QEkM_w@mail.gmail.com>
 <DCJ8H98X6UL4.3O75SJOM2WWRG@linux.dev>
 <CAEf4BzZOVtHu6NMFpEToC5C_Rf1qZ=HLqN5UntG-+PxG2dOn5g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzZOVtHu6NMFpEToC5C_Rf1qZ=HLqN5UntG-+PxG2dOn5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/9/25 07:53, Andrii Nakryiko wrote:
> On Wed, Sep 3, 2025 at 7:27 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> On Thu Aug 28, 2025 at 7:18 AM +08, Andrii Nakryiko wrote:
>>> On Wed, Aug 27, 2025 at 9:45 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>>
>>
>> [...]
>>
>>>>
>>>> +#ifdef CONFIG_BPF_SYSCALL
>>>> +static inline void bpf_percpu_copy_to_user(struct bpf_map *map, void __percpu *pptr, void *value,
>>>> +                                          u32 size, u64 flags)
>>>> +{
>>>> +       int current_cpu = raw_smp_processor_id();
>>>> +       int cpu, off = 0;
>>>> +
>>>> +       if (flags & BPF_F_CPU) {
>>>> +               cpu = flags >> 32;
>>>> +               copy_map_value_long(map, value, cpu != current_cpu ? per_cpu_ptr(pptr, cpu) :
>>>> +                                   this_cpu_ptr(pptr));
>>>> +               check_and_init_map_value(map, value);
>>>
>>> I'm not sure it's the question to you, but why would we
>>> "check_and_init_map_value" when copying data to user space?... this is
>>> so confusing...
>>>
>>
>> After reading its code, I think it's to hide some kernel details from
>> user space, e.g. refcount, list nodes, rb nodes.
> 
> we don't copy those details, so there is nothing to hide, so no, I
> think it's just weird that we do this, unless there is some
> non-obvious reasoning behind this
> 

Ack.

check_and_init_map_value() is useless here.

>>
>>>> +       } else {
>>>> +               for_each_possible_cpu(cpu) {
>>>> +                       copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
>>>> +                       check_and_init_map_value(map, value + off);
>>>> +                       off += size;
>>>> +               }
>>>> +       }
>>>> +}
>>>> +
>>>> +void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
>>>> +
>>>> +static inline void bpf_percpu_copy_from_user(struct bpf_map *map, void __percpu *pptr, void *value,
>>>> +                                            u32 size, u64 flags)
>>>> +{
>>
>> [...]
>>
>>>> +}
>>>> +#endif
>>>
>>> hm... these helpers are just here with no way to validate that they
>>> generalize existing logic correctly... Do a separate patch where you
>>> introduce this helper before adding per-CPU flags *and* make use of
>>> them in existing code? Then we can check that you didn't introduce any
>>> subtle differences? Then in this patch you can adjust helpers to
>>> handle BPF_F_CPU and BPF_F_ALL_CPUS?
>>>
>>
>> Get it.
>>
>> I'll send a separate patch later.
> 
> separate patch as part of the patch set to show the value of this refactoring :)
> 

Sorry for my misunderstanding. :/

Thanks,
Leon


