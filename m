Return-Path: <bpf+bounces-45225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 384DC9D2ED2
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 20:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F122B2843A9
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 19:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17B01D04BF;
	Tue, 19 Nov 2024 19:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tc9jXsbp"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AFF8528E
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732044457; cv=none; b=auh6pbBH8fhPJuAxgjrAPGFBI/qmvzunBFOFpHE/cVqIw3p33JVTqCqePOmZTrBkLSNrjfqKyO5QKqmGA8ZGUjCPNpCa1bJetroAKcF+f6nySf/03UPzkpImC460joy7NvhuEtwFUKbOAs8YnD6fCBF8+Ua1UJM4CmRffFj0iwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732044457; c=relaxed/simple;
	bh=wWTLxf603LZG6b+/uWhMm3wAZcWtQAYB8kOFsnsyETM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7qRKftAzLvI7lM0/4AfjsCkwGpL8v4/EHdQfkC+HHx2ircXZhxzUZRULUsLKlYnLvIqCMJ+LGSnCnZAY6EksSz4mGGJeLD1k8rX7Co0FFFUH0sg0hdan5y5mef/3jJFZiu684YVo0eFwHRwc+qUWtzo0s9vBtCR2Whp8e0H9Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tc9jXsbp; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e6886e32-0200-42d8-8f37-808487595081@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732044452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JilRxa0SoMmNYBEkylYW+bTughLuJ0jd6r87UEGff7s=;
	b=Tc9jXsbpb6O8YwnlwtaG7LOq86WT8sBagwUjwwQNUp0t21xLTi1T+NBIZnQziWYO+yqNzo
	QlTlJdZlORkOISCxa7wOJH1L5Q4Ts/inckfkFKU9hY/KaMLxBODe+IT7/Sinw1SpiO7h7T
	4q3VCKTZPSsjZ9+w6oak2HXAPJRYbDw=
Date: Tue, 19 Nov 2024 11:27:25 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 1/4] bpf: add bpf_get_cpu_cycles kfunc
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Yonghong Song <yonghong.song@linux.dev>, Mykola Lysenko <mykolal@fb.com>,
 x86@kernel.org, bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>
References: <20241118185245.1065000-1-vadfed@meta.com>
 <20241118185245.1065000-2-vadfed@meta.com>
 <20241119111809.GB2328@noisy.programming.kicks-ass.net>
 <bade75b3-92d2-42e8-aede-f7a361b491a9@linux.dev>
 <20241119161753.GA28920@noisy.programming.kicks-ass.net>
 <6d525549-b623-4292-b700-ee94eb313eb1@linux.dev>
 <CAEf4BzbK5JS6dXxOcXJ344KE1mDcH-sHKX+b+U8k_9FyQ4jW6Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAEf4BzbK5JS6dXxOcXJ344KE1mDcH-sHKX+b+U8k_9FyQ4jW6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 19/11/2024 11:16, Andrii Nakryiko wrote:
> On Tue, Nov 19, 2024 at 10:03 AM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> On 19/11/2024 08:17, Peter Zijlstra wrote:
>>> On Tue, Nov 19, 2024 at 06:29:09AM -0800, Vadim Fedorenko wrote:
>>>> On 19/11/2024 03:18, Peter Zijlstra wrote:
>>>>> On Mon, Nov 18, 2024 at 10:52:42AM -0800, Vadim Fedorenko wrote:
>>>>>> @@ -2094,6 +2094,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>>>>>>                             if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
>>>>>>                                     int err;
>>>>>> +                          if (imm32 == BPF_CALL_IMM(bpf_get_cpu_cycles)) {
>>>>>> +                                  if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))
>>>>>> +                                          EMIT3(0x0F, 0xAE, 0xE8);
>>>>>> +                                  EMIT2(0x0F, 0x31);
>>>>>> +                                  break;
>>>>>> +                          }
>>>>>
>>>>> TSC != cycles. Naming is bad.
>>>>
>>>> Any suggestions?
>>>>
>>>> JIT for other architectures will come after this one is merged and some
>>>> of them will be using cycles, so not too far away form the truth..
>>>
>>> bpf_get_time_stamp() ?
>>> bpf_get_counter() ?
>>
>> Well, we have already been somewhere nearby these names [1].
>>
>> [1]
>> https://lore.kernel.org/bpf/CAEf4BzaBNNCYaf9a4oHsB2AzYyc6JCWXpHx6jk22Btv=UAgX4A@mail.gmail.com/
>>
>> bpf_get_time_stamp() doesn't really explain that the actual timestamp
>> will be provided by CPU hardware.
>> bpf_get_counter() is again too general, doesn't provide any information
>> about what type of counter will be returned. The more specific name,
>> bpf_get_cycles_counter(), was also discussed in v3 (accidentally, it
>> didn't reach mailing list). The quote of feedback from Andrii is:
>>
>>     Bikeshedding time, but let's be consistently slightly verbose, but
>>     readable. Give nwe have bpf_get_cpu_cycles_counter (which maybe we
>>     should shorten to "bpf_get_cpu_cycles()"), we should call this
>>     something like "bpf_cpu_cycles_to_ns()".
>>
>> It might make a bit more sense to name it bpf_get_cpu_counter(), but it
>> still looks too general.
>>
>> Honestly, I'm not a fan of renaming functions once again, I would let
>> Andrii to vote for naming.
> 
> Let's go with bpf_get_cpu_time_counter() and bpf_cpu_time_counter_to_ns().

Ok, sure. @Peter are you OK with these names?

