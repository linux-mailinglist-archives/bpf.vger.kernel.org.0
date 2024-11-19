Return-Path: <bpf+bounces-45187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A919D2857
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 15:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF04282FC8
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 14:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8CF1CDFC3;
	Tue, 19 Nov 2024 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ggq3KZm1"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E062556E
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027140; cv=none; b=WwuaJgnDNWdQegnmHBq/n3oPHOV4BhTZGl3byEZ2MWdnDcqgBVhQtQ25kltupwYNGQJt2WexK++y7xiQXbu5pyt8Ro89Jdo2o6iOdqs4DVGHN6uevjjVQ4po5Hlzno6UN8JrgL+2EyKkZlq+gHSzq981N5a9G7K5Xv3nrrF+tSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027140; c=relaxed/simple;
	bh=28IVNaQJQxSxDjT4bX7JjDjaLpm5nuMGztF09cE5wPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZEr975JdfD0BZOF4eVsFwsj0fGsTukKe58ArbwwDhvixPIaiaxe2G4HHa2kTwWYVKBlrEx2Ib+GJHuwmcny/cQb2+PTAFjSo00qQyvgLozAS2/TturCr5HaZGueH78RbeAdBrjR/zVNU0e1m+k3z+D+ewqxTBAQd0o6yhHpykis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ggq3KZm1; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a2a219fb-ae89-42e0-b920-9a0704677930@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732027137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1JMK2sVS0Ku57jhG4qpa6lVg4Au4QnNXkh9zTzoakzg=;
	b=ggq3KZm1a/Qz5d5fSOOp48APeQ1VLCVSgzrlFVT+gqEKyRxMBlzVx0U3KuSBz1H2AH9+Bw
	FdERAEWf8DzA7X1401bAroLy4PPg04qq6XoaGSZ1hZqk8tdcSEpjF5eylzvaBQdgSMLAAn
	zHo2l3SW6SAOmACw0h8lNkL9oOr0Vfk=
Date: Tue, 19 Nov 2024 06:38:51 -0800
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241119112814.GC2328@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 19/11/2024 03:28, Peter Zijlstra wrote:
> On Mon, Nov 18, 2024 at 10:52:43AM -0800, Vadim Fedorenko wrote:
> 
>> +			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
>> +			    imm32 == BPF_CALL_IMM(bpf_cpu_cycles_to_ns) &&
>> +			    cpu_feature_enabled(X86_FEATURE_CONSTANT_TSC)) {
>> +				u32 mult, shift;
>> +
>> +				clocks_calc_mult_shift(&mult, &shift, tsc_khz, USEC_PER_SEC, 0);
>> +				/* imul RAX, RDI, mult */
>> +				maybe_emit_mod(&prog, BPF_REG_1, BPF_REG_0, true);
>> +				EMIT2_off32(0x69, add_2reg(0xC0, BPF_REG_1, BPF_REG_0),
>> +					    mult);
>> +
>> +				/* shr RAX, shift (which is less than 64) */
>> +				maybe_emit_1mod(&prog, BPF_REG_0, true);
>> +				EMIT3(0xC1, add_1reg(0xE8, BPF_REG_0), shift);
>> +
>> +				break;
>> +			}
> 
> This is ludicrously horrible. Why are you using your own mult/shift and
> not offset here instead of using the one from either sched_clock or
> clocksource_tsc ?

With X86_FEATURE_CONSTANT_TSC, tsc_khz is actually constant after
switching from tsc_early. And the very same call to
clocks_calc_mult_shift() is used to create clocksource_tsc mult and
shift constants. Unfortunately, clocksources don't have proper API to
get the underlying info, that's why I have to calculate shift and mult
values on my own.

> And being totally inconsistent with your own alternative implementation
> which uses the VDSO, which in turn uses clocksource_tsc:

With what I said above it is consistent with clocksource_tsc.

> 
>> +__bpf_kfunc u64 bpf_cpu_cycles_to_ns(u64 cycles)
>> +{
>> +	const struct vdso_data *vd = __arch_get_k_vdso_data();
>> +
>> +	vd = &vd[CS_RAW];
>> +	/* kfunc implementation does less manipulations than vDSO
>> +	 * implementation. BPF use-case assumes two measurements are close
>> +	 * in time and can simplify the logic.
>> +	 */
>> +	return mul_u64_u32_shr(cycles, vd->mult, vd->shift);
>> +}
> 
> Also, if I'm not mistaken, the above is broken, you really should add
> the offset, without it I don't think we guarantee the result is
> monotonic.

Not quite sure how constant offset can affect monotonic guarantee of
cycles, given that the main use case will be to calculate ns out of
small deltas? AFAIU, the offset is needed to get ns of CLOCK_MONOTONIC,
which can be affected by NTP manipulation. But in this helper we don't
follow any clock_id, we just want to calculate nanoseconds value out of
stable and monotonically increasing counter provided by architecture.



