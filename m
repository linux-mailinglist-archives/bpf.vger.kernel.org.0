Return-Path: <bpf+bounces-54625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 425FFA6EBE0
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 09:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21901896460
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 08:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D852825484D;
	Tue, 25 Mar 2025 08:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWrUA0oE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CED8253F2D;
	Tue, 25 Mar 2025 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742892077; cv=none; b=uB/yK9pXThqLjiyTLJ+XaaGcIhtraa3/f5QdEnW0/rt8qNj5i9oD/44xCz0zreCKxJ2GeyKYLcJliIZ/VOW6siKdUGebPxm+bNO38oGyrk1PxF3x8eLfXh0RNtEiscIdPzcC0v0MwhgTPN2xmuV62dr5KPkiWhVOEXwaas90x8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742892077; c=relaxed/simple;
	bh=CY5RP842umNjCXx2QIefjQ/33Qh6ZSa0whh4kFlNOwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcL7E3/OgxkabOlocVIRiq1Bjpz4ktNb6N8MyHSmLElOf9EnhdYe6HiE9Yxr5hs7IDHmHPRZf0jQRG4Ih3d5qGJ/h0TiAyfzHNvSb96uZVghHtdHzL/ZY7GHfWu0WfiJf/VwigGEyLVhQRfQdBXavibtidPo6vZTPRi9TF1E3zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWrUA0oE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FDBC4CEE4;
	Tue, 25 Mar 2025 08:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742892076;
	bh=CY5RP842umNjCXx2QIefjQ/33Qh6ZSa0whh4kFlNOwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fWrUA0oEG3GWgwAvoabVeyqyPfN7/TU9eaLCZoSwA9RhUTZ9Po4eF5siEeVlVF+xI
	 tX5I2WQ6gz+LaiDsDz5xqhXJMZm894wU3O/nnq2g/RNQJW1ufzcXKTtAbB9A4J8PXd
	 XY9gymc19bMnu46AZ8Rf+dpKusxA5miFnD2OAYSkUy2KkJX0lnwAF2XMnsUZh0vydv
	 fOvkZvDsnaBznwusgjP7KZfuEkgV5cAmY1LJMBuSXV2jw71AboL6gEqXDmP0Q/9XOw
	 ZDLmve8SJ8i6P5VcuqXxvtsqvm68bMooZdDdUc+GHw0lhS4ojEFbmd76T4AbU9db6R
	 0PUMIaizQMxkg==
Date: Tue, 25 Mar 2025 09:41:10 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
	bpf@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
	Greg Thelen <gthelen@google.com>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] x86/alternatives: remove false sharing in
 poke_int3_handler()
Message-ID: <Z-JsJruueRgLQ8st@gmail.com>
References: <20250323072511.2353342-1-edumazet@google.com>
 <Z-B_R737uM31m6_K@gmail.com>
 <CANn89i+fmyJ8p=vBpwBy38yhVMCJv8XjrTkrXSUnSGedboCM_Q@mail.gmail.com>
 <Z-EGvjhkg6llyX24@gmail.com>
 <CANn89iL8o0UZTpomaT1oaMxRTBv1YdaXZGwXQn3H0dDO81UyGA@mail.gmail.com>
 <CANn89iKwPpV7v=EnK2ac5KjHSef64eyVwUST=q=+oFaqTB95sQ@mail.gmail.com>
 <20250324113304.GB14944@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324113304.GB14944@noisy.programming.kicks-ass.net>


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Mar 24, 2025 at 08:53:31AM +0100, Eric Dumazet wrote:
> 
> > BTW the atomic_cond_read_acquire() part is never called even during my
> > stress test.
> 
> Yes, IIRC this is due to text_poke_sync() serializing the state, as that
> does a synchronous IPI broadcast, which by necessity requires all
> previous INT3 handlers to complete.
> 
> You can only hit that case if the INT3 remains after step-3 (IOW you're
> actively writing INT3 into the text). This is exceedingly rare.

Might make sense to add a comment for that.

Also, any strong objections against doing this in the namespace:

  s/bp_/int3_

?

Half of the code already calls it a variant of 'int3', half of it 'bp', 
which I had to think for a couple of seconds goes for breakpoint, not 
base pointer ... ;-)

Might as well standardize on int3_ and call it a day?

Thanks,

	Ingo

