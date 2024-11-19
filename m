Return-Path: <bpf+bounces-45168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C749D24D1
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 12:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BC4BB26C2E
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 11:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6A41C68BD;
	Tue, 19 Nov 2024 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EgvITnvr"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C891C4A18
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732015704; cv=none; b=i4wYySU4eO0Ebk3lUwP4PYBv9GQ222wSQVl/pPmVU/lZqgmRD3jIp5rD4+NygVQR9mDARxWMe4Un4Fb1sSDcTFl90p6GOOXZampiMgMV1HVn7/XPGjWvALOuiXLIMl5qaFgO5oMvZ6xuO4MAMrkWXhS1/naAo8p8A0uXpIK0RMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732015704; c=relaxed/simple;
	bh=vy7sJFeTVnUMk5OxceNQj31s7Jk/D8dcdG2K1oscZtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsLHYKtX1gaGE796rN0wz6iTAg4/lM4Tsvl+1IzpMBHQWo48+fu4jHx2IAyNOYDGMc0DaNyLqQq1sLzLvRiDdYBSt5hNHAw2Jdno2XAXIl81JbMxZNv0tTNG6X/cV+Pvw60EsEQZCwzUYN8EedPDpchAujooWniupbR1voXEcVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EgvITnvr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GV22KPdeILYxNtJgs0Sb/gGZE6PJjptUNhZLpYOA+sU=; b=EgvITnvrdWV1E++CBDy2xzJ1Iq
	oYPMfeFtfA/4b33IuaCAAoji54DOoL/uSzQORd6pg+U+2ht2KCZ8lFFzBO1wx5MTyJQTD4dsXqNRQ
	g6SEqFEVwX7LXrZS08cKjna5K1lCN0T5eV5fw8+rbV1CGrSlZiUHByQr1LVkK5cObZWRO61xZAwSN
	lgz6dtldEIzKp1l1tDYNphYk3itIvkMWr+nBCyx2qicdadpQS8ZQixlDe071qg8bsSybSr4bHB79c
	osW7HnwuHVsi1KT+MWjkUbZl5f3QooUCqQMMq7yDWInMTfIBYsmXTOx8b26Bn4vkOuaztsNLzuvrs
	8S0uwRqQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDMOz-000000040d5-1iiR;
	Tue, 19 Nov 2024 11:28:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4D1E83006AB; Tue, 19 Nov 2024 12:28:14 +0100 (CET)
Date: Tue, 19 Nov 2024 12:28:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>, x86@kernel.org,
	bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v7 2/4] bpf: add bpf_cpu_cycles_to_ns helper
Message-ID: <20241119112814.GC2328@noisy.programming.kicks-ass.net>
References: <20241118185245.1065000-1-vadfed@meta.com>
 <20241118185245.1065000-3-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118185245.1065000-3-vadfed@meta.com>

On Mon, Nov 18, 2024 at 10:52:43AM -0800, Vadim Fedorenko wrote:

> +			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
> +			    imm32 == BPF_CALL_IMM(bpf_cpu_cycles_to_ns) &&
> +			    cpu_feature_enabled(X86_FEATURE_CONSTANT_TSC)) {
> +				u32 mult, shift;
> +
> +				clocks_calc_mult_shift(&mult, &shift, tsc_khz, USEC_PER_SEC, 0);
> +				/* imul RAX, RDI, mult */
> +				maybe_emit_mod(&prog, BPF_REG_1, BPF_REG_0, true);
> +				EMIT2_off32(0x69, add_2reg(0xC0, BPF_REG_1, BPF_REG_0),
> +					    mult);
> +
> +				/* shr RAX, shift (which is less than 64) */
> +				maybe_emit_1mod(&prog, BPF_REG_0, true);
> +				EMIT3(0xC1, add_1reg(0xE8, BPF_REG_0), shift);
> +
> +				break;
> +			}

This is ludicrously horrible. Why are you using your own mult/shift and
not offset here instead of using the one from either sched_clock or
clocksource_tsc ?

And being totally inconsistent with your own alternative implementation
which uses the VDSO, which in turn uses clocksource_tsc:

> +__bpf_kfunc u64 bpf_cpu_cycles_to_ns(u64 cycles)
> +{
> +	const struct vdso_data *vd = __arch_get_k_vdso_data();
> +
> +	vd = &vd[CS_RAW];
> +	/* kfunc implementation does less manipulations than vDSO
> +	 * implementation. BPF use-case assumes two measurements are close
> +	 * in time and can simplify the logic.
> +	 */
> +	return mul_u64_u32_shr(cycles, vd->mult, vd->shift);
> +}

Also, if I'm not mistaken, the above is broken, you really should add
the offset, without it I don't think we guarantee the result is
monotonic.



