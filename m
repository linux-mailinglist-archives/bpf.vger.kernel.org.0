Return-Path: <bpf+bounces-45953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7319E0DDD
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 22:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0202FB3BA14
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 20:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697EE1DEFE9;
	Mon,  2 Dec 2024 20:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IOeWk2Vs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eE98/WBq"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F8B1D9A6D
	for <bpf@vger.kernel.org>; Mon,  2 Dec 2024 20:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172780; cv=none; b=XpKnBM2n/EDwKWBm1v4JxpAy5UH27Ww9FjtwwxH/FasADz8LuYVVu9dWBEBcwQWXFMQWKWNczN72gH9qnUrqCNqXQXzYl2lPB3T5CxJ8el14FB4tXsdTZDQV2g7d0be8awJUDNk4iA1EF0BS+zpud5Gp/U2LDkotLdhXIv4EIGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172780; c=relaxed/simple;
	bh=pecplru8HVjVuhiaQQrovG46P6CLeD8vZiys4kzG/bU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GYCmId340aoAywJJ0jcrJl0VQ3Mh+wiEGP0YMDEB34q2GQXRLrKSrRG8Pf/psFN3sgjbNQ/PWrbMcN+0AEZ96wMEP3N+vrUTmlfg8YNN3KvEQ0DC3+NLntIwDMQOC9uLMczHLF+IktkECK3bHH7ovUTz27CB4Dm1xEdw/2N+qdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IOeWk2Vs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eE98/WBq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733172776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RSxVdwK4qyw5ZYoDrvyubWZh/aQQ6pPK2M5Bb6c88gc=;
	b=IOeWk2VsoBXb4Zx1nxopxC91yHtJ2d5mZQ8GACqTi1oglDaPKOKrfJ0sswB5JcxrQIvBk6
	5egal+rTjZ3upH9PrcwwoXqWHt/skLJRdDq0rp/Yf6QlNU1HT+27AD/jlISv7zmPW2aETS
	V3Otw6IXprZKRNgPWSeJdE0MV81thholWkzfm+5ofRcxhpWHeXDzSyWBK3wPl14vLuKMS9
	keTAdmvmwxhmLKnGB9xVVMMnBmKJ1/encBmECrMhWjPBRWPRg4ATA/AbAvFXYe4YuXASD4
	emv0SjwknyIVzIWDRCEpQ5pTKM6Y5xwNRlVMYZo57AdE56N7Ti2OzoUo9fFQQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733172776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RSxVdwK4qyw5ZYoDrvyubWZh/aQQ6pPK2M5Bb6c88gc=;
	b=eE98/WBqGH2L8MsMb+qHBo/T6GWDMWPFpg3mhVfYkd6VQOCg1aX5lvLdr4OX7GKV5dUE3m
	Ic3finNLBv/F5yAg==
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Vadim Fedorenko
 <vadfed@meta.com>, Borislav Petkov <bp@alien8.de>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song
 <yonghong.song@linux.dev>, Mykola Lysenko <mykolal@fb.com>
Cc: x86@kernel.org, bpf@vger.kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v9 1/4] bpf: add bpf_get_cpu_time_counter kfunc
In-Reply-To: <aec0acb2-9232-43da-856d-3ba88d0461e2@linux.dev>
References: <20241123005833.810044-1-vadfed@meta.com>
 <20241123005833.810044-2-vadfed@meta.com> <87a5dfwoyo.ffs@tglx>
 <aec0acb2-9232-43da-856d-3ba88d0461e2@linux.dev>
Date: Mon, 02 Dec 2024 21:52:55 +0100
Message-ID: <87ldwxvmc8.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Dec 01 2024 at 17:45, Vadim Fedorenko wrote:
> On 01.12.2024 12:46, Thomas Gleixner wrote:
>> On Fri, Nov 22 2024 at 16:58, Vadim Fedorenko wrote:
>>> diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
>>> index de0f9e5f9f73..a549aea25f5f 100644
>>> --- a/arch/x86/net/bpf_jit_comp32.c
>>> +++ b/arch/x86/net/bpf_jit_comp32.c
>>> @@ -2094,6 +2094,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>>>   			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
>>>   				int err;
>>>   
>>> +				if (imm32 == BPF_CALL_IMM(bpf_get_cpu_time_counter)) {
>>> +					if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))
>>> +						EMIT3(0x0F, 0xAE, 0xE8);
>>> +					EMIT2(0x0F, 0x31);
>> 
>> What guarantees that RDTSC is supported by the CPU?
>
> Well, technically it may be a problem on x86_32 because there are x86 compatible
> platforms which don't have RDTSC, but they are almost 16+ years old, and I'm not
> quite sure we expose vDSO on such platforms.

Care to look at the VDSO related config symbols? They are
unconditionally selected independent of 16+ year old platforms.

Also TSC can be disabled at boot time by a particular platform because
it's implementation is buggy.

It does not matter at all whether those platforms are old or not. What
matters is that the code which tries to access the TSC has to be correct
under all circumstances and not under magic assumptions.

>> Aside of that, if you want the read to be ordered, then you need to take
>> RDTSCP into account too.
>
> Yes, we have already had this discussion. RDTSCP has the same ordering
> guaranties as "LFENCE; RDTSC" according to the programming manuals. But it also
> provides "cookie" value, which is not used in this case and just trashes the
> value of ECX. To avoid additional register manipulation, I used lfence option.

With zero comment and zero explanation in the change log.

>>> +#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
>>> +__bpf_kfunc u64 bpf_get_cpu_time_counter(void)
>>> +{
>>> +	const struct vdso_data *vd = __arch_get_k_vdso_data();
>>> +
>>> +	vd = &vd[CS_RAW];
>>> +
>>> +	/* CS_RAW clock_mode translates to VDSO_CLOCKMODE_TSC on x86 and
>> 
>> How so?
>> 
>> vd->clock_mode is not guaranteed to be VDSO_CLOCKMODE_TSC or
>> VDSO_CLOCKMODE_ARCHTIMER. CS_RAW is the access to the raw (uncorrected)
>> time of the current clocksource. If the clock mode is not matching, then
>> you cannot access it.
>
> That's more about x86 and virtualization options. But in the end all this ends
> up in reading tsc value.

As long as VDSO_CLOCKMODE_TSC == 1. There is no guarantee for this.

> And we do JIT anyway, so this function call will never be executed on
> x86. Other architectures (well, apart from MIPS) don't care about
> vd->clock_mode at all. And we don't provide kfuncs for architectures
> without JIT

They care. Because all of them can set VDSO_CLOCKMODE_NONE, which forces
the fallback into the syscall. And they do so for good reasons. Either
because the clocksource is not functional or has other limitiations
which prevent VDSO usage or even usage in the kernel.

> For MIPS I think I can ifdef these new kfuncs to the case when CONFIG_CSRC_R4K
> is not defined.

Which excludes VDSO_CLOCKMODE_GIC, which is the most common clock source
on modern MIPS systems.

Aside of that a config symbol does not guarantee at all that the
clocksource exists on the actual hardware or is properly configured and
enabled.

>>> +	 * We still have to provide vdso_data for some architectures to avoid
>>> +	 * NULL pointer dereference.
>>> +	 */
>>> +	return __arch_get_hw_counter(1, vd);
>> 
>> This is outright dangerous. __arch_get_hw_counter() is for VDSO usage
>> and not for in kernel usage. What guarantees you that the architecture
>> specific implementation does not need access to user only mappings.
>> 
>> Aside of that what guarantees that '1' is what you want and stays that
>> way forever? It's already broken on MIPS.
>
> I can ifdef MIPS case until we have JIT for it (which has pretty much 
> straightforward implementation for HW counter)

Again. You cannot make any assumptions about any implementation detail
of __arch_get_hw_counter().

It is a function solely designed for user space VDSO usage and in kernel
usage is simply bogus.

Just because it "works" today, does not guarantee that it works tomorrow
and there is no justification for BPF to enforce compatibility with
magic number '1' and a constraint that the code has to work in the
kernel.

Thanks,

        tglx

