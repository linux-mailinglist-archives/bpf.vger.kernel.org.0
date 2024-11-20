Return-Path: <bpf+bounces-45264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 658D99D3C9F
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 14:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F33B9284FDA
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 13:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD11C1AC438;
	Wed, 20 Nov 2024 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JQY9JXpk"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63311A76C4
	for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 13:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732109995; cv=none; b=u+c+YuBfHJSEUJaML8cCWXiJv+z4LqZUK6SUkQmvQ8AV46t4x8KA2CRYZAclCOBSOELoFkhWagq9XL2jIp6+0ZuuDRwNHJRed0pr3R91H/wcJGz61cDDVsqXQltnLrkozjjPNVwVJQGJ9hE3YuaMydVAE6irVCobnsCBn8mf78Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732109995; c=relaxed/simple;
	bh=JLZhcK3UTp0Uo4+KrXeqpJFDEmAaS/Bdhpjfrn67DZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SaNE5bOA0z1sRp4PlbYRajapYMlLWfVFOrF4KNn3om8WMQ+z7T9xd2IOFR2FSoiuoztJTfFTUlD0VBBxAyeaIQmuMPPmkqfI4JNCgt9BT5DV+JdpXVegMB8L6SXnLRjA1Bff5RoaWzf+qXbY7NAMbcBZXv5f7vIewpGVUzIenRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JQY9JXpk; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <47d9fb73-f665-4566-bf3e-e016469ea3e3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732109990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=em7OGNwUhGvHsH5O6kmCphTWKqfFSEfigLXqzlxL+tA=;
	b=JQY9JXpkE+hCdZACJqA4IuT5x0lmp4k7v1IjfFT+w38XISKxW9Trx62Ci+BLgl69MfBAlm
	+alih2ok5D0bGV7R0eZ3+/5oWglOINiKMHqy3HWYC1TbpktXNX6m8kTybLsDkc0Cu/ftrD
	SEXe4mR4FsFnwJ+6EVcJAHNLNcnQGdQ=
Date: Wed, 20 Nov 2024 05:39:43 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 2/4] bpf: add bpf_cpu_cycles_to_ns helper
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Yonghong Song <yonghong.song@linux.dev>, Mykola Lysenko <mykolal@fb.com>,
 x86@kernel.org, bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>
References: <20241118185245.1065000-1-vadfed@meta.com>
 <20241118185245.1065000-3-vadfed@meta.com>
 <20241119112814.GC2328@noisy.programming.kicks-ass.net>
 <a2a219fb-ae89-42e0-b920-9a0704677930@linux.dev>
 <20241120084943.GB19989@noisy.programming.kicks-ass.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241120084943.GB19989@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 20/11/2024 00:49, Peter Zijlstra wrote:
> On Tue, Nov 19, 2024 at 06:38:51AM -0800, Vadim Fedorenko wrote:
>> On 19/11/2024 03:28, Peter Zijlstra wrote:
>>> On Mon, Nov 18, 2024 at 10:52:43AM -0800, Vadim Fedorenko wrote:
>>>
>>>> +			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
>>>> +			    imm32 == BPF_CALL_IMM(bpf_cpu_cycles_to_ns) &&
>>>> +			    cpu_feature_enabled(X86_FEATURE_CONSTANT_TSC)) {
>>>> +				u32 mult, shift;
>>>> +
>>>> +				clocks_calc_mult_shift(&mult, &shift, tsc_khz, USEC_PER_SEC, 0);
>>>> +				/* imul RAX, RDI, mult */
>>>> +				maybe_emit_mod(&prog, BPF_REG_1, BPF_REG_0, true);
>>>> +				EMIT2_off32(0x69, add_2reg(0xC0, BPF_REG_1, BPF_REG_0),
>>>> +					    mult);
>>>> +
>>>> +				/* shr RAX, shift (which is less than 64) */
>>>> +				maybe_emit_1mod(&prog, BPF_REG_0, true);
>>>> +				EMIT3(0xC1, add_1reg(0xE8, BPF_REG_0), shift);
>>>> +
>>>> +				break;
>>>> +			}
>>>
>>> This is ludicrously horrible. Why are you using your own mult/shift and
>>> not offset here instead of using the one from either sched_clock or
>>> clocksource_tsc ?
>>
>> With X86_FEATURE_CONSTANT_TSC, tsc_khz is actually constant after
>> switching from tsc_early. And the very same call to
>> clocks_calc_mult_shift() is used to create clocksource_tsc mult and
>> shift constants. Unfortunately, clocksources don't have proper API to
>> get the underlying info, that's why I have to calculate shift and mult
>> values on my own.
> 
> There is cyc2ns_read_begin() / cyc2ns_read_end(), and you can use the
> VDSO thing you do below.

Looks like I missed arch-specific implementation. Thanks, I'll use it in
the next version.

>>> And being totally inconsistent with your own alternative implementation
>>> which uses the VDSO, which in turn uses clocksource_tsc:
>>
>> With what I said above it is consistent with clocksource_tsc.
>>
>>>
>>>> +__bpf_kfunc u64 bpf_cpu_cycles_to_ns(u64 cycles)
>>>> +{
>>>> +	const struct vdso_data *vd = __arch_get_k_vdso_data();
>>>> +
>>>> +	vd = &vd[CS_RAW];
>>>> +	/* kfunc implementation does less manipulations than vDSO
>>>> +	 * implementation. BPF use-case assumes two measurements are close
>>>> +	 * in time and can simplify the logic.
>>>> +	 */
>>>> +	return mul_u64_u32_shr(cycles, vd->mult, vd->shift);
>>>> +}
>>>
>>> Also, if I'm not mistaken, the above is broken, you really should add
>>> the offset, without it I don't think we guarantee the result is
>>> monotonic.
>>
>> Not quite sure how constant offset can affect monotonic guarantee of
>> cycles, given that the main use case will be to calculate ns out of
>> small deltas?
> 
> Well, when I read this patch I didn't know, because your changelogs
> don't mention anything at all.

Fair, I'll improve commit message in v8, thanks.

