Return-Path: <bpf+bounces-45251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F209D35E1
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 09:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C09AAB22BD7
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 08:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802E01991A8;
	Wed, 20 Nov 2024 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FjcrMVoA"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F75166F07
	for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732092594; cv=none; b=o19VDmep9E8/vcegjlRybYofDqccFpwZpr0FGLltekfBbgRkOsK3sXhFgwtpOOcBkJ9ExK7kwftm7W2Etd2Bjkc1ryT/cDTbTbn6gAoBEmrQbE2Ce9nRvgiWvsCOYbm26Al2vYlAdfq8OqLUYMI04S7ZJuG2tvFpHjI4stBDAd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732092594; c=relaxed/simple;
	bh=HHTFJj3rQehiYoK8icKl+0XuJ2UEY8Ycd5U7fRIeXYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0LgKyLJtkz1/RFANs6J2eZenvwXNGRzn4NDRiOdYDvQitc1E6H6a50vgFLzqgP2t6D+aInBc/ZyuVL6/VHWZFgbF+71vGRubplCctj/6OXWw8p+20Ytdd9ESiybjKSCnA6sLatFyNjCnncuaHi6RIfYRML+mnDdEbwaeIXL6Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FjcrMVoA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0xP0QbEvvZQ5SB/7+fkzRlwD+FJiXHkFwdYtGtCoFxQ=; b=FjcrMVoAPKz+HsVPsXPpXOiBBt
	oVPF0y2rw8uY42r9pyESVC61rqo2L0FitGP9kqXkI6OnkZjpDzN7gnxt2volPSoCjDp35HjNHL0RV
	5D5jKLzzGqXDC8ofLm4yQUfOqtUxk+KfC5RGdcwYKBCc83RqdDLNDHhwHMitp9bVauZtRXzCWhpwI
	0jmsNoISLShCI6QNGtcMv78nHY8nkvxCsacPhtt0z3p8pujgQHfDLng6c2YEjQSREuTexBGK9GLYX
	WOSEZRjlsvtEJ0qfTbLCq2qyEnIksONfU0zICoqOKZPtaxOf7mOxMwHthoe/dy5gPr4z9i+5tlPme
	a5P0U1tA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDgP9-000000052jw-1kfW;
	Wed, 20 Nov 2024 08:49:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B7F523006AB; Wed, 20 Nov 2024 09:49:43 +0100 (CET)
Date: Wed, 20 Nov 2024 09:49:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>, x86@kernel.org,
	bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v7 2/4] bpf: add bpf_cpu_cycles_to_ns helper
Message-ID: <20241120084943.GB19989@noisy.programming.kicks-ass.net>
References: <20241118185245.1065000-1-vadfed@meta.com>
 <20241118185245.1065000-3-vadfed@meta.com>
 <20241119112814.GC2328@noisy.programming.kicks-ass.net>
 <a2a219fb-ae89-42e0-b920-9a0704677930@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2a219fb-ae89-42e0-b920-9a0704677930@linux.dev>

On Tue, Nov 19, 2024 at 06:38:51AM -0800, Vadim Fedorenko wrote:
> On 19/11/2024 03:28, Peter Zijlstra wrote:
> > On Mon, Nov 18, 2024 at 10:52:43AM -0800, Vadim Fedorenko wrote:
> > 
> > > +			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
> > > +			    imm32 == BPF_CALL_IMM(bpf_cpu_cycles_to_ns) &&
> > > +			    cpu_feature_enabled(X86_FEATURE_CONSTANT_TSC)) {
> > > +				u32 mult, shift;
> > > +
> > > +				clocks_calc_mult_shift(&mult, &shift, tsc_khz, USEC_PER_SEC, 0);
> > > +				/* imul RAX, RDI, mult */
> > > +				maybe_emit_mod(&prog, BPF_REG_1, BPF_REG_0, true);
> > > +				EMIT2_off32(0x69, add_2reg(0xC0, BPF_REG_1, BPF_REG_0),
> > > +					    mult);
> > > +
> > > +				/* shr RAX, shift (which is less than 64) */
> > > +				maybe_emit_1mod(&prog, BPF_REG_0, true);
> > > +				EMIT3(0xC1, add_1reg(0xE8, BPF_REG_0), shift);
> > > +
> > > +				break;
> > > +			}
> > 
> > This is ludicrously horrible. Why are you using your own mult/shift and
> > not offset here instead of using the one from either sched_clock or
> > clocksource_tsc ?
> 
> With X86_FEATURE_CONSTANT_TSC, tsc_khz is actually constant after
> switching from tsc_early. And the very same call to
> clocks_calc_mult_shift() is used to create clocksource_tsc mult and
> shift constants. Unfortunately, clocksources don't have proper API to
> get the underlying info, that's why I have to calculate shift and mult
> values on my own.

There is cyc2ns_read_begin() / cyc2ns_read_end(), and you can use the
VDSO thing you do below.

> > And being totally inconsistent with your own alternative implementation
> > which uses the VDSO, which in turn uses clocksource_tsc:
> 
> With what I said above it is consistent with clocksource_tsc.
> 
> > 
> > > +__bpf_kfunc u64 bpf_cpu_cycles_to_ns(u64 cycles)
> > > +{
> > > +	const struct vdso_data *vd = __arch_get_k_vdso_data();
> > > +
> > > +	vd = &vd[CS_RAW];
> > > +	/* kfunc implementation does less manipulations than vDSO
> > > +	 * implementation. BPF use-case assumes two measurements are close
> > > +	 * in time and can simplify the logic.
> > > +	 */
> > > +	return mul_u64_u32_shr(cycles, vd->mult, vd->shift);
> > > +}
> > 
> > Also, if I'm not mistaken, the above is broken, you really should add
> > the offset, without it I don't think we guarantee the result is
> > monotonic.
> 
> Not quite sure how constant offset can affect monotonic guarantee of
> cycles, given that the main use case will be to calculate ns out of
> small deltas?

Well, when I read this patch I didn't know, because your changelogs
don't mention anything at all.


