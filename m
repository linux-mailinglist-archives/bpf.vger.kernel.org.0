Return-Path: <bpf+bounces-32879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F289145AA
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 11:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A841C213FE
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 09:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062377FBA4;
	Mon, 24 Jun 2024 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SjwyFFRr"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1DB1805E;
	Mon, 24 Jun 2024 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219744; cv=none; b=oCvW+mb9Xh7ths5VU+jpYNQzqG4b6godZ6yHLYgo7fjSIdtqQWlKYwel6rDtVjiCr2KE3eauKVqshf/q08nXxhw3hTGLLMrbuAv0XrZMGG44t8RMeESbrfwf5jlGQ6M2/p9rJwyfJKGhQa7zuAx34S8gJiDiBGlnbRBTXWxY/Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219744; c=relaxed/simple;
	bh=qW14qvlfyzAV3hBFCCz0Zk9O5SJ94HMlDELFbn2mIfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1hSaUcitvr2HqPu0ygBR3WmxNANfs4JaI3jQvebjfBfXcniVpJ7AE7druRuTffKxV32vxZcf2YUwCxhgtkhLaAsCaGIzPktt3mwPywSZLrqS8WUnUtN/mOiQKZZnVr9oqLYi0GL17myLgbQlZL3fqKzIlIeAWaQHH1fvoCSiGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SjwyFFRr; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LvYWZE6bAq7zPMbYQGr0sFU14B9itT+ZBDY02wHnCrE=; b=SjwyFFRrVC3GX+esFoo0G3i2OT
	ul+/9O4Ngutck4qsRMkki737D5t1xKz7yBSq1ieD4BBM/08RjwPJoyo9XYEqKKY1FMsIEi8bu3Rzp
	7omtixEa2zme5/FlxTVj8HoiRsTWF02+wmvVgIAOV5pI1RbWyJyl4h7T2jyQjNUt9e/erMhtfWdnO
	O2OnGZY6ti20bkOEk8OCDyS2PbgU8q8+x1vvfoctUJqTUQlrID7vXAN9he4XgLSG312x7yVGWECgC
	pkfqyBazNfE83bLa/wkJ6eDZgWxDodQd+Ym26QyUfrjZa8frWnSCFMaEqnzRmwh/RDVYxXepcBwEk
	rLUYCB1Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLfaR-00000008DBk-1UQy;
	Mon, 24 Jun 2024 09:02:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F29F7300754; Mon, 24 Jun 2024 11:02:06 +0200 (CEST)
Date: Mon, 24 Jun 2024 11:02:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, andrea.righi@canonical.com,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH sched_ext/for-6.11] sched, sched_ext: Replace
 scx_next_task_picked() with sched_class->switch_class()
Message-ID: <20240624090206.GF31592@noisy.programming.kicks-ass.net>
References: <87ed8sps71.ffs@tglx>
 <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx>
 <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx>
 <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <CAHk-=wgjbNLRtOvcmeEUtBQyJtYYAtvRTROBy9GHeF1Quszfgg@mail.gmail.com>
 <ZnRptXC-ONl-PAyX@slm.duckdns.org>
 <ZnSp5mVp3uhYganb@slm.duckdns.org>
 <CAHk-=wjFPLqo7AXu8maAGEGnOy6reUg-F4zzFhVB0Kyu22h7pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjFPLqo7AXu8maAGEGnOy6reUg-F4zzFhVB0Kyu22h7pw@mail.gmail.com>

On Thu, Jun 20, 2024 at 03:42:48PM -0700, Linus Torvalds wrote:
> Btw, indirect calls are now expensive enough that when you have only a
> handful of choices, instead of a variable
> 
>         class->some_callback(some_arguments);
> 
> you might literally be better off with a macro that does
> 
>        #define call_sched_fn(class, name, arg...) switch (class) { \
>         case &fair_name_class: fair_name_class.name(arg); break; \
>         ... unroll them all here..
> 
> which then just generates a (very small) tree of if-statements.
> 
> Again, this is entirely too ugly to do unless people *really* care.
> But for situations where you have a small handful of cases known at
> compile-time, it's not out of the question, and it probably does
> generate better code.
> 
> NOTE NOTE NOTE! This is a comp[letely independent aside, and has
> nothing to do with sched_ext except for the very obvious indirect fact
> that sched_ext would be one of the classes in this kind of code.
> 
> And yes, I suspect it is too ugly to actually do this.

Very early on in the retpoline mess I briefly considered doing this, but
I decided against doing the ugly until someone came with numbers bad
enough to warrant them.

We're now many years later and I'm very glad we never really *had* to go
down that route.

