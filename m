Return-Path: <bpf+bounces-45910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5089DF592
	for <lists+bpf@lfdr.de>; Sun,  1 Dec 2024 13:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2032816FC
	for <lists+bpf@lfdr.de>; Sun,  1 Dec 2024 12:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2968F1BC091;
	Sun,  1 Dec 2024 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BHJkhLWI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gK353R/G"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDDC1BC06E
	for <bpf@vger.kernel.org>; Sun,  1 Dec 2024 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733057187; cv=none; b=K0LSrSAIpFeR2KCMBX+/6La1cU2QY+wu+Xs8mgBQIHS8Dhs/ElNVxDvUrUbk37KWPOlTHw4WfVHosF2F8kD2g5xKECFw1UtMgHuM+XM8wDb5RaOUtVkn/QT7Ju+Rs2p5D6wQWUNQOuDMwZ4aT28TY30MBKUvs0eoexGMtxcjOmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733057187; c=relaxed/simple;
	bh=FSAdue1Jh1ZGvW6J+zoGVe9yDPX8zvm1XziVk60JEeQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LTLFDPvK8IuiUFAovz38h6Cw87YdV4KYBvvIFiLa/zjQqB+gNqkHwlExoLJqj82mELARyszTSYdV45hakP6RM7Istw/KDu2RZ6PrdMcmxKdAY59DJMWBJjnfgOytE3kIIL1pIeUKJNtEUDEqb9CqOpax+BiekZOUkkYrEkmqaUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BHJkhLWI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gK353R/G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733057184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8vqKe2nJ+vDx8Qtvez5NmVHWX94c8WEQvkghCaRLB+A=;
	b=BHJkhLWIH6kbs7/c4h72ijTd3Li3sHcHH9/qQ/+xLV7kNi2ir1f1bsEfVpB9Zdehff3U6t
	ne+89wlLh234dMe3NEyaAQlX3jQ4fKfInSe2wf+XZfF8QVN8rbYQueiIXOxwgMt6DQfR34
	UEdHznDMp+HvKkULXOBHNoiwnaoNQf2BLOpvYn+Vg2PNI7iaC9lI6GQAXW+L9silSEhJ03
	lRNSFp0LkaRVopwq9zFxuSejhupXO7/dhyKPMW4k7Xq8SIpjcm3WGaaiNGVBQWuV3JBtxt
	PfMID46rDE4hjUvHeSnhmD47UZFNYH6uqX7TnyPoVI1pU1/q1FSiwm71EYsa9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733057184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8vqKe2nJ+vDx8Qtvez5NmVHWX94c8WEQvkghCaRLB+A=;
	b=gK353R/GLiChZgjsacGgtu5W/RAZFaCVRQJcXsyTr27nP4PNvV/1ki5g5EjM14iVwKs7Ua
	+p3ppuGc9ihBSCAw==
To: Vadim Fedorenko <vadfed@meta.com>, Borislav Petkov <bp@alien8.de>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Mykola Lysenko
 <mykolal@fb.com>
Cc: x86@kernel.org, bpf@vger.kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Vadim Fedorenko <vadfed@meta.com>, Martin KaFai
 Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v9 1/4] bpf: add bpf_get_cpu_time_counter kfunc
In-Reply-To: <20241123005833.810044-2-vadfed@meta.com>
References: <20241123005833.810044-1-vadfed@meta.com>
 <20241123005833.810044-2-vadfed@meta.com>
Date: Sun, 01 Dec 2024 13:46:23 +0100
Message-ID: <87a5dfwoyo.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Nov 22 2024 at 16:58, Vadim Fedorenko wrote:
> diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
> index de0f9e5f9f73..a549aea25f5f 100644
> --- a/arch/x86/net/bpf_jit_comp32.c
> +++ b/arch/x86/net/bpf_jit_comp32.c
> @@ -2094,6 +2094,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>  			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
>  				int err;
>  
> +				if (imm32 == BPF_CALL_IMM(bpf_get_cpu_time_counter)) {
> +					if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))
> +						EMIT3(0x0F, 0xAE, 0xE8);
> +					EMIT2(0x0F, 0x31);

What guarantees that RDTSC is supported by the CPU?

Aside of that, if you want the read to be ordered, then you need to take
RDTSCP into account too.

> +#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
> +__bpf_kfunc u64 bpf_get_cpu_time_counter(void)
> +{
> +	const struct vdso_data *vd = __arch_get_k_vdso_data();
> +
> +	vd = &vd[CS_RAW];
> +
> +	/* CS_RAW clock_mode translates to VDSO_CLOCKMODE_TSC on x86 and

How so?

vd->clock_mode is not guaranteed to be VDSO_CLOCKMODE_TSC or
VDSO_CLOCKMODE_ARCHTIMER. CS_RAW is the access to the raw (uncorrected)
time of the current clocksource. If the clock mode is not matching, then
you cannot access it.

> +	 * to VDSO_CLOCKMODE_ARCHTIMER on aarch64/risc-v. We cannot use
> +	 * vd->clock_mode directly because it brings possible access to
> +	 * pages visible by user-space only via vDSO.

How so? vd->clock_mode is kernel visible.

>        * But the constant value
> +	 * of 1 is exactly what we need - it works for any architecture and
> +	 * translates to reading of HW timecounter regardles of architecture.

It does not. Care to look at MIPS?

> +	 * We still have to provide vdso_data for some architectures to avoid
> +	 * NULL pointer dereference.
> +	 */
> +	return __arch_get_hw_counter(1, vd);

This is outright dangerous. __arch_get_hw_counter() is for VDSO usage
and not for in kernel usage. What guarantees you that the architecture
specific implementation does not need access to user only mappings.

Aside of that what guarantees that '1' is what you want and stays that
way forever? It's already broken on MIPS.

Thanks,

        tglx

