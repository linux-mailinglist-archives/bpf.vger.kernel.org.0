Return-Path: <bpf+bounces-68829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5BAB86228
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 18:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61AFE548486
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 16:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BD2256C9E;
	Thu, 18 Sep 2025 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EU/tfhCm"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B608F25393C;
	Thu, 18 Sep 2025 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758214626; cv=none; b=hJGiAW1FKY+GGq3CWdzE0SBsy7U7V9LU2ofyKGkj9W7xLYumYWzGvzrFMaYJcp+BwdXuQ+TwuTbZUEL+U26aFrTh74R6tVZcdYc58C2UOPMsrqeYsVXhyWfAzgeYtY1mrC8sDithQv/ltUNfXUSNCah72jLbH3uSmDYy9GjwLXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758214626; c=relaxed/simple;
	bh=eHG7S2ll5gm3y5g43IwkUmOfIryIH6xRUR+ty1RONGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=te1hVuZRrhsOIxpi+fb0PkxY4ocLWmRxdArUvC3ZiRUGbDmKpoeDZdDhmHS5DP5MRtk5tE3Qc2rDW3izKHhWwW91NXD7M5MU94fQXdAAan3zpW29FvCWb5JzU/30XaH3ja94SGs1IB0IEgPoL5y+h9DZtDM16UrUSq+q3DJIhB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EU/tfhCm; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fOiVTuIstBHHmkmpDspdiQx3m3FjEIUDZ6oIdw2Go88=; b=EU/tfhCmmXYDTKIwz7lDGql/Hn
	diiGpvWmzY7GCLb7y6VUZ/7aYSm16XE9mdSe6Z3OkTNiMgeqBHq7zmPy2bpQvpznsI4X8RxUuVcgG
	2jQWRNN4Zh5HawaQ9KKb72bKWjtdYgoGQWlJwk9aBza3vtW6ok59AmiUBcBT85dkHekE/IR43GwBd
	IDY22vO4tca8WaKkvmYfCAdueLMdGeuMEpLMrfr9AoanE0zNECHUwVwNppjeQlSzxazcSdHjMfZJE
	hWtUwg8RY0pEDWtZ2vqUaO6Z+q+ZBzZ87Or+a2OkJglD5k3BDENyc1uwc0WOVj/tli0dkTOwHipjA
	yn8YvyIA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzHwH-00000007fQ4-2ro0;
	Thu, 18 Sep 2025 16:56:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A2E74300125; Thu, 18 Sep 2025 18:56:56 +0200 (CEST)
Date: Thu, 18 Sep 2025 18:56:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	kees@kernel.org, samitolvanen@google.com, rppt@kernel.org,
	luto@kernel.org, mhiramat@kernel.org, ast@kernel.org,
	andrii@kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] x86/ibt: make is_endbr() notrace
Message-ID: <20250918165656.GA3409427@noisy.programming.kicks-ass.net>
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
 <20250918130543.GM3245006@noisy.programming.kicks-ass.net>
 <CADxym3ae8NGRt70rVO8ZyHa3BvWhczUkRs=dVn=rTRMVzrU9tA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxym3ae8NGRt70rVO8ZyHa3BvWhczUkRs=dVn=rTRMVzrU9tA@mail.gmail.com>

On Thu, Sep 18, 2025 at 09:32:27PM +0800, Menglong Dong wrote:
> On Thu, Sep 18, 2025 at 9:05???PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Sep 18, 2025 at 08:09:39PM +0800, Menglong Dong wrote:
> > > is_endbr() is called in __ftrace_return_to_handler -> fprobe_return ->
> > > kprobe_multi_link_exit_handler -> is_endbr.
> > >
> > > It is not protected by the "bpf_prog_active", so it can't be traced by
> > > kprobe-multi, which can cause recurring and panic the kernel. Fix it by
> > > make it notrace.
> >
> > This is very much a riddle wrapped in an enigma. Notably
> > kprobe_multi_link_exit_handler() does not call is_endbr(). Nor is that
> > cryptic next line sufficient to explain why its a problem.
> >
> > I suspect the is_endbr() you did mean is the one in
> > arch_ftrace_get_symaddr(), but who knows.
> 
> Yeah, I mean
> kprobe_multi_link_exit_handler -> ftrace_get_entry_ip ->
> arch_ftrace_get_symaddr -> is_endbr
> actually. And CONFIG_X86_KERNEL_IBT is enabled of course.
> 
> >
> > Also, depending on compiler insanity, it is possible the thing
> > out-of-lines things like __is_endbr(), getting you yet another
> > __fentry__ site.
> 
> The panic happens when I run the bpf bench testing:
>   ./bench kretprobe-multi-all
> 
> And skip the "is_endbr" fix this problem.

But why does it panic? Supposedly you've done the analysis; but then
forgot to write it down?

Why is kprobe_multi_link_exit_handler() special; doesn't the issue also
exist with kprobe_multi_link_handler() ? If so, removing __fentry__
isn't going to help much, you can just stick an actual kprobe in
is_endbr(), right?


