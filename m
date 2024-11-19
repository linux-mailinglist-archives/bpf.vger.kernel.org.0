Return-Path: <bpf+bounces-45167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A369D24B0
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 12:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C707282E84
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 11:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4874B1C3F0E;
	Tue, 19 Nov 2024 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HnX/Tpub"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0381198E63
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 11:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732015106; cv=none; b=t0LBJZtsXu+mJ6Ah0d9LEAuwC8QxdCWQNV7vpow82WYk5YfO4glGwCKluT4qnzZu+9o0+nsXoZEnVvmCH5i/jbikkR6B56i+gbA5Upe4WqmMENIq3rB2Qbj53mFmbgJo0zLsK9kk26u3DEW92KdYaBkyA4/ZTnRHAcGwVFmfclk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732015106; c=relaxed/simple;
	bh=wLngPFSkyiBGIpyLXieAkQOBUSvIOcUzw8WGpXi5yNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9XCKfUS0tNLI+pIcpeZvhL6PCMsi3plLesTjfdAPBrguPC+4u+NMCj8guE8Dt4RLWs1cQ7u+ing8oqu661LMHFhKJIlbVPkMDDoExXEzTjIVA/qT/pQu3eEqPheVjTK+s8cl1FlzFqhAfcWdaiyXGWKHaFhV7qRElwn24YpiKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HnX/Tpub; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RLrVQiNcfMB6d3HKCa0XFl/nEeJK7JxRTEXtm8stgQM=; b=HnX/TpubVPKXqtLNJstOQoUWyK
	Sk50h5rBTOqotY7wGVm+iHepeYRimFIDRpo+LVeeBfbfytFot6YpH86qBlDGlZQwFyli78rQETpLE
	vDk3lhP9QG44UUYbQrDSzH0Dz1YvsUSb38X4xrITutBmwASzjInI+osz3Bw0NCXRVAS4vi661aR2h
	uL9YILidQfXM+oFZhUjcwW4B6jrnzcaru3nqGAU/JJAYuj0oJSQj4QOW18ZYBCe5oRs5Gz+FGRPZq
	MFf6aNRCJtKgiq8fyFP7HBbQoekvDTRP609+NOgaxSSgPVZWVrFvROcpF4nh+gFleJjdFUXGlfuEO
	ZRchVZJQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDMFG-00000000L0n-2zQj;
	Tue, 19 Nov 2024 11:18:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C7E5A3006AB; Tue, 19 Nov 2024 12:18:09 +0100 (CET)
Date: Tue, 19 Nov 2024 12:18:09 +0100
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
Subject: Re: [PATCH bpf-next v7 1/4] bpf: add bpf_get_cpu_cycles kfunc
Message-ID: <20241119111809.GB2328@noisy.programming.kicks-ass.net>
References: <20241118185245.1065000-1-vadfed@meta.com>
 <20241118185245.1065000-2-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118185245.1065000-2-vadfed@meta.com>

On Mon, Nov 18, 2024 at 10:52:42AM -0800, Vadim Fedorenko wrote:
> @@ -2094,6 +2094,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>  			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
>  				int err;
>  
> +				if (imm32 == BPF_CALL_IMM(bpf_get_cpu_cycles)) {
> +					if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))
> +						EMIT3(0x0F, 0xAE, 0xE8);
> +					EMIT2(0x0F, 0x31);
> +					break;
> +				}

TSC != cycles. Naming is bad.

