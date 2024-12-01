Return-Path: <bpf+bounces-45913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832219DF6A8
	for <lists+bpf@lfdr.de>; Sun,  1 Dec 2024 18:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2805F2815FE
	for <lists+bpf@lfdr.de>; Sun,  1 Dec 2024 17:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65731D61B9;
	Sun,  1 Dec 2024 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K5K+Hc7Q"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEFE273FE
	for <bpf@vger.kernel.org>; Sun,  1 Dec 2024 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733075156; cv=none; b=e7YHAPktFyZF5Kjv5ssX0woUETcHAJ71kmm/x/d7/GhX2VwmeD9LA5jzmEEyccy/736DUiI++ZvAbTQcfwJQ2QvuxLPZq4b5k5zIzjTYghWtSOIVc3Wysz+sMHWTNiniEgBgYp+0599L5aYCFFagE8J6eYnXjXkUi0OJrXQsN5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733075156; c=relaxed/simple;
	bh=htDMiYgy0FS4JB2WguWe4tfCbd2zZp8cG/RNeVuQYIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnUM8QIjyyYg3z+cyg0PElU6EYkOeV3W6rg7HpZHbdKoX3Qs1Rase4/pVNzyPBpAnqeO1SF3idedRHve75ZyBXiQFSqx2wHTRxb/hMMech7uj+fQPdCgzBJgjEsxCw0y1VDTJDtCCN9BHaMbL9YN3tPe2dEHCfQp6gVGGUfo+eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K5K+Hc7Q; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <aec0acb2-9232-43da-856d-3ba88d0461e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733075151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNFUERzK0aDTHv8QCI8eSyoNRxacBL6csBVETg8Kjpc=;
	b=K5K+Hc7Q/sGO+kUYEOxBiCBY9zbUxwEhLVE7z7Gwuyx/mCV7XR4MTNotp/PqnW1wD6XbuQ
	Bx+KRpxDSGSoBy/EQ/UHONd9PpcAP6jnkrJ3uQbWh+g454JHLjZU5+Lcjr2LUf3izk3Y2M
	jgc98eUYbi77nz5GTm2MvpF4xihSeF0=
Date: Sun, 1 Dec 2024 17:45:43 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 1/4] bpf: add bpf_get_cpu_time_counter kfunc
To: Thomas Gleixner <tglx@linutronix.de>, Vadim Fedorenko <vadfed@meta.com>,
 Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song
 <yonghong.song@linux.dev>, Mykola Lysenko <mykolal@fb.com>
Cc: x86@kernel.org, bpf@vger.kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Martin KaFai Lau <martin.lau@linux.dev>
References: <20241123005833.810044-1-vadfed@meta.com>
 <20241123005833.810044-2-vadfed@meta.com> <87a5dfwoyo.ffs@tglx>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <87a5dfwoyo.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 01.12.2024 12:46, Thomas Gleixner wrote:
> On Fri, Nov 22 2024 at 16:58, Vadim Fedorenko wrote:
>> diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
>> index de0f9e5f9f73..a549aea25f5f 100644
>> --- a/arch/x86/net/bpf_jit_comp32.c
>> +++ b/arch/x86/net/bpf_jit_comp32.c
>> @@ -2094,6 +2094,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>>   			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
>>   				int err;
>>   
>> +				if (imm32 == BPF_CALL_IMM(bpf_get_cpu_time_counter)) {
>> +					if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))
>> +						EMIT3(0x0F, 0xAE, 0xE8);
>> +					EMIT2(0x0F, 0x31);
> 
> What guarantees that RDTSC is supported by the CPU?

Well, technically it may be a problem on x86_32 because there are x86 compatible
platforms which don't have RDTSC, but they are almost 16+ years old, and I'm not
quite sure we expose vDSO on such platforms.

> 
> Aside of that, if you want the read to be ordered, then you need to take
> RDTSCP into account too.

Yes, we have already had this discussion. RDTSCP has the same ordering
guaranties as "LFENCE; RDTSC" according to the programming manuals. But it also
provides "cookie" value, which is not used in this case and just trashes the
value of ECX. To avoid additional register manipulation, I used lfence option.

>> +#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
>> +__bpf_kfunc u64 bpf_get_cpu_time_counter(void)
>> +{
>> +	const struct vdso_data *vd = __arch_get_k_vdso_data();
>> +
>> +	vd = &vd[CS_RAW];
>> +
>> +	/* CS_RAW clock_mode translates to VDSO_CLOCKMODE_TSC on x86 and
> 
> How so?
> 
> vd->clock_mode is not guaranteed to be VDSO_CLOCKMODE_TSC or
> VDSO_CLOCKMODE_ARCHTIMER. CS_RAW is the access to the raw (uncorrected)
> time of the current clocksource. If the clock mode is not matching, then
> you cannot access it.

That's more about x86 and virtualization options. But in the end all this ends
up in reading tsc value. And we do JIT anyway, so this function call will never
be executed on x86. Other architectures (well, apart from MIPS) don't care about
vd->clock_mode at all. And we don't provide kfuncs for architectures without JIT

For MIPS I think I can ifdef these new kfuncs to the case when CONFIG_CSRC_R4K
is not defined.

I'm going to create a patchset to implement arch-specific replacements for all
architectures supported by BPF JIT, so in the end this call will be effectively
not executed.

> 
>> +	 * to VDSO_CLOCKMODE_ARCHTIMER on aarch64/risc-v. We cannot use
>> +	 * vd->clock_mode directly because it brings possible access to
>> +	 * pages visible by user-space only via vDSO.
> 
> How so? vd->clock_mode is kernel visible.

vd->clock_mode is kernel visible, but compiler cannot optimize out code which
accesses user-space pages if I don't provide constant value here.

> 
>>         * But the constant value
>> +	 * of 1 is exactly what we need - it works for any architecture and
>> +	 * translates to reading of HW timecounter regardles of architecture.
> 
> It does not. Care to look at MIPS?

Yes, this is pretty much specific. But again, the goal is to have JIT
implementation for all architectures and this func will actually be never called
this way.

> 
>> +	 * We still have to provide vdso_data for some architectures to avoid
>> +	 * NULL pointer dereference.
>> +	 */
>> +	return __arch_get_hw_counter(1, vd);
> 
> This is outright dangerous. __arch_get_hw_counter() is for VDSO usage
> and not for in kernel usage. What guarantees you that the architecture
> specific implementation does not need access to user only mappings.
> 
> Aside of that what guarantees that '1' is what you want and stays that
> way forever? It's already broken on MIPS.

I can ifdef MIPS case until we have JIT for it (which has pretty much 
straightforward implementation for HW counter)

> 
> Thanks,
> 
>          tglx


