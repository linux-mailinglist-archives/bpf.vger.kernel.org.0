Return-Path: <bpf+bounces-63623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC141B090E1
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 17:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7B81C46250
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 15:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA6F2F94B4;
	Thu, 17 Jul 2025 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fk7a8rpe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDFD2F9498;
	Thu, 17 Jul 2025 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767322; cv=none; b=bqYZ4iZkRd9eHYCFHwyuuRlb6rqJJuAGu6dB8/kJFmNed/xDyFsK0Ni0XMwQUIDGs3ruWmYj6lHUFb4gzB9fYt/Xgs8ZhvSjx7EiarlmUscDH8VtRMYN4DyscgrYCu/5HIWhCNXTPntODYVs4eTLjCQHKDScAyNb3wulNP5tg1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767322; c=relaxed/simple;
	bh=LF9nWCrlhrGlVLFvTgknGtgi9psMrgEBFZQTYYGnL14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBZsper2bXRDIKpytug1fpEth4Km7HSvObINOS6AqyhllViqm3/5iG5wdtsd7s9o8HOxZ/rvmgFd0ppNZFNsqwmIqxTLhfXdt3I48uuBLO1s7iHpBdu3mgr/oM96zEaCB0a6tFVgEvaVlmRfaxiLoq6n5TSrgpD+3SgtmY0n0Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fk7a8rpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8C4C4CEED;
	Thu, 17 Jul 2025 15:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752767320;
	bh=LF9nWCrlhrGlVLFvTgknGtgi9psMrgEBFZQTYYGnL14=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Fk7a8rpe8IvXSdYsHfA9mBGin4bxpF4ko6Dj2B3O/OWvOtSdlifQal5Q5Dhb8hb9l
	 IBIe7elcAr077+K0VxpB44tht1cOnBt5eYrsBuYYdH9PfJ8sbV4Y5BeyHmMYEa5uY/
	 zBvWu24BIy5kQ368A+6rRuyrpQE9Lsix/oZiBcctCjVf2Bjj1twdEuZiajywsLHfFT
	 FuEFHnLpQ1BoYcZCQW1YF5RvZUBBEI+gygT32RQmA9f6aKuzF825ByIik90l8aRr0W
	 SRbbqBLoS5Xec12etuju1MBAHE9vJqJWb9wtLDjyshgrybo73Y+BzaBOV1GTmcMm/x
	 wYHpnqxZ+LBDg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4806ECE09F5; Thu, 17 Jul 2025 08:48:40 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:48:40 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
	Sam James <sam@gentoo.org>
Subject: Re: [PATCH v14 09/12] unwind deferred: Use SRCU
 unwind_deferred_task_work()
Message-ID: <41c204c0-eabc-4f4f-93f4-2568e2f962a9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250717004910.297898999@kernel.org>
 <20250717004957.918908732@kernel.org>
 <47c3b0df-9f11-4e14-97e2-0f3ba3b09855@paulmck-laptop>
 <20250717082526.7173106a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717082526.7173106a@gandalf.local.home>

On Thu, Jul 17, 2025 at 08:25:26AM -0400, Steven Rostedt wrote:
> On Wed, 16 Jul 2025 21:43:47 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > +DEFINE_LOCK_GUARD_1(srcu_lite, struct srcu_struct,  
> > 
> > You need srcu_fast because srcu_lite is being removed.  They are quite
> > similar, but srcu_fast is faster and is NMI-safe.  (This last might or
> > might not matter here.)
> > 
> > See https://lore.kernel.org/all/20250716225418.3014815-3-paulmck@kernel.org/
> > for a srcu_fast_notrace, so something like this:
> 
> Yeah, I already saw that patch.
> 
> > 
> > DEFINE_LOCK_GUARD_1(srcu_fast, struct srcu_struct,
> > 		    _T->scp = srcu_read_lock_fast(_T->lock),
> > 		    srcu_read_unlock_fast(_T->lock, _T->scp),
> > 		    struct srcu_ctr __percpu *scp)
> > 
> > Other than that, it looks plausible.
> 
> Using srcu_lite or srcu_fast is an optimization here. And since I saw you
> adding the guard for srcu_fast in that other thread, I'll just use normal
> SRCU here for this series, and in the future we could convert it over to
> srcu_fast.

Works for me!

That said, "in the future" started in -next some time back and is slated
to start in mainline in the upcoming v6.17 merge window.  SRCU-lite is
being removed from the kernel, and has been deprecated via checkpatch.pl.

So if there is some reason that you absolutely cannot immediately convert
to SRCU-fast, let's please discuss.

							Thanx, Paul

