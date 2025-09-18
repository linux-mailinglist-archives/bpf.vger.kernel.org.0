Return-Path: <bpf+bounces-68830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53848B86237
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 18:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14AC156028F
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 16:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D23A25742F;
	Thu, 18 Sep 2025 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V4PVmfmy"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D21A24DCEC;
	Thu, 18 Sep 2025 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758214781; cv=none; b=YqdhcZTEAU0ezzsK/oV5bkU0+Gjih1pBFECwFthRd4/0yztAHcAXXO5dUw/PLk512rIdtGK1Wu1iy1/eawdjUqqoKt/WzYUg2lKi/z/QFqyu5cGJZhYgLWGFvSM34uPjA9VcOiuJgIJgMJgHZRN5+4XYKKmhBI3PmH7ECypyIxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758214781; c=relaxed/simple;
	bh=pfyWM3zCV0p04m781Ji1FMv4FYVLwCB+NFARLMRAcKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYSc1QgezJplCqSYJ12A2diuLu3Y9jf+MeCUHEqaK1+NScxxxErmY21cffpTOi3TA8LtGHGP9y+/MD0GpNjkekeADyCUPi6WrgQufGu5CQd7pO206vL80bLH18O+S0Fp4uireAyD0b/phYplbeG4gvdTbdowWNQmomIQJJxC2o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V4PVmfmy; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KYlbrh/+zbSaV0aKvPofumpTBr/wNHfVy6ZSzlqoomw=; b=V4PVmfmyy9GgkSK7a/EpJUev6B
	MWwWNpfvlv8f3QSEEVWYME8XWf7v3eYBSwY5UqsE8HJOt1nFmLhYqquKhWEj0fMcjSLJ9R0u0daVa
	2b0RKVkiuVcjOadtADH1Hn7+NCG0l2NLsPIjVGzvfX683nblUEuc8KVWYX/kxOwchB3pLD0wdLIU9
	Ha1nVBOTHIignII1yz7KLHnBUbViZruiDmUILIYX7rYao8kAR0clFBpvUlL/8jl2WFvuqiYtijL46
	KmtL9s1bmFc/fYilfd+QiEIOM3MYtB4AfF/2r4O5cYgd51ZiFE/pjmzNBYi+i7YGsK/KP4Ud5/PMD
	t/2Lptlw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzHyp-00000007fS2-3Pj6;
	Thu, 18 Sep 2025 16:59:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5C188300125; Thu, 18 Sep 2025 18:59:35 +0200 (CEST)
Date: Thu, 18 Sep 2025 18:59:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Mike Rapoport <rppt@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] x86/ibt: make is_endbr() notrace
Message-ID: <20250918165935.GB3409427@noisy.programming.kicks-ass.net>
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
 <20250918130543.GM3245006@noisy.programming.kicks-ass.net>
 <CADxym3ae8NGRt70rVO8ZyHa3BvWhczUkRs=dVn=rTRMVzrU9tA@mail.gmail.com>
 <CAADnVQ+hOdOpCR6s_GyO_7xxehCPBHSttidia38P5xFie6yjnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+hOdOpCR6s_GyO_7xxehCPBHSttidia38P5xFie6yjnw@mail.gmail.com>

On Thu, Sep 18, 2025 at 09:02:31AM -0700, Alexei Starovoitov wrote:
> On Thu, Sep 18, 2025 at 6:32???AM Menglong Dong <menglong8.dong@gmail.com> wrote:
> >
> > On Thu, Sep 18, 2025 at 9:05???PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, Sep 18, 2025 at 08:09:39PM +0800, Menglong Dong wrote:
> > > > is_endbr() is called in __ftrace_return_to_handler -> fprobe_return ->
> > > > kprobe_multi_link_exit_handler -> is_endbr.
> > > >
> > > > It is not protected by the "bpf_prog_active", so it can't be traced by
> > > > kprobe-multi, which can cause recurring and panic the kernel. Fix it by
> > > > make it notrace.
> > >
> > > This is very much a riddle wrapped in an enigma. Notably
> > > kprobe_multi_link_exit_handler() does not call is_endbr(). Nor is that
> > > cryptic next line sufficient to explain why its a problem.
> > >
> > > I suspect the is_endbr() you did mean is the one in
> > > arch_ftrace_get_symaddr(), but who knows.
> >
> > Yeah, I mean
> > kprobe_multi_link_exit_handler -> ftrace_get_entry_ip ->
> > arch_ftrace_get_symaddr -> is_endbr
> > actually. And CONFIG_X86_KERNEL_IBT is enabled of course.
> 
> All this makes sense to me.

As written down, I'm still clueless.

> __noendbr bool is_endbr(u32 *val) needs "notrace",
> since it's in alternative.c and won't get inlined (unless LTO+luck).

notrace don't help with kprobes in general, only with __fentry__ sites.

I've still not clue why there is a panic, or why notrace would be
sufficient.

