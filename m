Return-Path: <bpf+bounces-68931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F02EB89771
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 14:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E10EE7ACA52
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 12:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7C71E32CF;
	Fri, 19 Sep 2025 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZff96pM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C361B4F2C;
	Fri, 19 Sep 2025 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285309; cv=none; b=lNXH33jC39SA6MI8WvKS/c/iK7LIRIB/kP+SrlKD1jMgLbny10cbwb4MHLxBAmFJvxP1HrLyzvx6GzUIiOIZ4Zh9LiRu17OynC/8RD+UEA7HD1a+rPDALV1ZgZ9KZxB0lRukX6WURd7Xtc3oQZiAeT8qopodvpwB0kyrMXfMARg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285309; c=relaxed/simple;
	bh=B/LAeSfpF+38Ojzu+TVsThBEqCYyFGk+412u00MRL1Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=er+x6w2jPi4NtcoDxY36VhwwjZZI8Sz45OljifuVN/r4UPjmh9i6eFjSKTuE8ArB1P6Wua2fJ2BM15EClFDd7QsYRKWF/oP9BR/8nqLMYhig35ltxO0CFLHKfDYRDx25Cr/AGqeLuIfQ62zrPgJiCSXyuhEixAUppMMmW8vqA7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZff96pM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D401C4CEF0;
	Fri, 19 Sep 2025 12:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758285308;
	bh=B/LAeSfpF+38Ojzu+TVsThBEqCYyFGk+412u00MRL1Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TZff96pMxFcA0LMfL1fVfinD2uaCwHCmZg1t87v+5E8XBkg9tRMbQ2vFeQJL2jttY
	 s5bIpg2XKyrSzU4F0wpsp3Q6y5OpLqPL2Yp9wCU7ZnAlMScIPGeNdTLdTfjFLP8DCi
	 UGmcDzTsj+ljEONK7BhrUagg0OZM27qhNlE/xN195gpUikwEwrrVaMPJMH3bK/H3J1
	 cor3J+RnkgqxC16xS7H5buD7l9wdhNsSjDJSGdr+QdXEKsO/f5Ua5JylO4zsYj/P/v
	 n6ByozH1Fmhqa9oGwYDCTkppIIH7qU7KPRkTzH2bMWoGkn5QRQTB0GRic8OZP+Xg6y
	 nYGmSyzoeXuRg==
Date: Fri, 19 Sep 2025 21:35:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>, jolsa@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 kees@kernel.org, samitolvanen@google.com, rppt@kernel.org, luto@kernel.org,
 mhiramat@kernel.org, ast@kernel.org, andrii@kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] x86/ibt: make is_endbr() notrace
Message-Id: <20250919213502.2d621c5b19e059134d0f8991@kernel.org>
In-Reply-To: <20250918165656.GA3409427@noisy.programming.kicks-ass.net>
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
	<20250918130543.GM3245006@noisy.programming.kicks-ass.net>
	<CADxym3ae8NGRt70rVO8ZyHa3BvWhczUkRs=dVn=rTRMVzrU9tA@mail.gmail.com>
	<20250918165656.GA3409427@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 18:56:56 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Sep 18, 2025 at 09:32:27PM +0800, Menglong Dong wrote:
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
> > 
> > >
> > > Also, depending on compiler insanity, it is possible the thing
> > > out-of-lines things like __is_endbr(), getting you yet another
> > > __fentry__ site.
> > 
> > The panic happens when I run the bpf bench testing:
> >   ./bench kretprobe-multi-all
> > 
> > And skip the "is_endbr" fix this problem.
> 
> But why does it panic? Supposedly you've done the analysis; but then
> forgot to write it down?

Yeah, that is an fprobe's bug. It should not panic. I sent a fix.

https://lore.kernel.org/all/175828305637.117978.4183947592750468265.stgit@devnote2/

Thank you,

> 
> Why is kprobe_multi_link_exit_handler() special; doesn't the issue also
> exist with kprobe_multi_link_handler() ? If so, removing __fentry__
> isn't going to help much, you can just stick an actual kprobe in
> is_endbr(), right?
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

