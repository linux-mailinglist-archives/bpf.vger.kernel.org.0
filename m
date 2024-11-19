Return-Path: <bpf+bounces-45211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B43289D2AA2
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 17:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5F01F23451
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 16:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C621CF7DB;
	Tue, 19 Nov 2024 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CUOnknXZ"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDA878C76
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033084; cv=none; b=C7XuW5Sh3Cx0/yW4Ol1+p0Zo/b8wyA5bf8KiuCl4MH0gY9071HNp0u2jHGZxbKnV81VDvQ+7WEUrQYkadldD0Uc0x3MSESag0IMf3oRIU3Gzp3P2+JDY4XB0LCUkrqaUxk2y8glEalHQSmRu7ZvxtMgUjLv4YMouRMg7KhyHNe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033084; c=relaxed/simple;
	bh=3PFWdD7nwTQ4C0nec3wVqAja7Vmb6iGj6M0K5bxySR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSW4WRuEpg2Aida8wu6sb/BI1/8lN5URlB5Ic0TroM4gW2EGn5f7DugbVVI1dv8XQqS74BxrA2miTujbqbYq3oNQG6heNAxemxg7HQ/xkbID/nG8cxjW9lVC5SsiQMk23io+q2O5hnkCl0cDVr5lCQmNeQ7PPm1cqMAc71QRNuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CUOnknXZ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nYFgcjCueV+6cR7np5RCfwb6q1dXgAYJTV3bbCiFaFg=; b=CUOnknXZa8i6m/VJu3p4lIlGsC
	Jr9pnWju+34/BC9Bidm/OtNepl3oY9MT6fed5GWjQxCa3cLpC2oNOvaEz09tb7rGGCK5Q/arIoOxK
	W1juUMwe9Lw04FidQYHJdJbhD1bIwhdMWQedhIqmSy0oqroeHJhOesjt2x9D+z67KAJv0h9BHV5N0
	AzmRkIBLIwRy3tuLkVAoxhpW1b5tQqvRKGT7p3HumyTYFW1xCIjIHUJ0lz2wSoOijiY/0fQ5pL2D/
	tySCFa15BswrgbYyXLm6I2vJOQqqFB6BKjyEs17NBLTB61xsY+ntZM4zMogXXFNMv2hNiKiwgar9m
	VHUQ/yzA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDQvK-00000000MPx-2waH;
	Tue, 19 Nov 2024 16:17:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 854DE3006AB; Tue, 19 Nov 2024 17:17:53 +0100 (CET)
Date: Tue, 19 Nov 2024 17:17:53 +0100
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
Subject: Re: [PATCH bpf-next v7 1/4] bpf: add bpf_get_cpu_cycles kfunc
Message-ID: <20241119161753.GA28920@noisy.programming.kicks-ass.net>
References: <20241118185245.1065000-1-vadfed@meta.com>
 <20241118185245.1065000-2-vadfed@meta.com>
 <20241119111809.GB2328@noisy.programming.kicks-ass.net>
 <bade75b3-92d2-42e8-aede-f7a361b491a9@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bade75b3-92d2-42e8-aede-f7a361b491a9@linux.dev>

On Tue, Nov 19, 2024 at 06:29:09AM -0800, Vadim Fedorenko wrote:
> On 19/11/2024 03:18, Peter Zijlstra wrote:
> > On Mon, Nov 18, 2024 at 10:52:42AM -0800, Vadim Fedorenko wrote:
> > > @@ -2094,6 +2094,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
> > >   			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
> > >   				int err;
> > > +				if (imm32 == BPF_CALL_IMM(bpf_get_cpu_cycles)) {
> > > +					if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))
> > > +						EMIT3(0x0F, 0xAE, 0xE8);
> > > +					EMIT2(0x0F, 0x31);
> > > +					break;
> > > +				}
> > 
> > TSC != cycles. Naming is bad.
> 
> Any suggestions?
> 
> JIT for other architectures will come after this one is merged and some
> of them will be using cycles, so not too far away form the truth..

bpf_get_time_stamp() ?
bpf_get_counter() ?

