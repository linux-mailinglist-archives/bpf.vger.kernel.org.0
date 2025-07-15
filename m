Return-Path: <bpf+bounces-63361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 878C8B0667F
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 21:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741F51AA3126
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 19:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F044C2BEC41;
	Tue, 15 Jul 2025 19:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vWC/ojFp"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B6822127C;
	Tue, 15 Jul 2025 19:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606452; cv=none; b=FgwWprGbzjhfOiH6eoH5pXDGxxrTTAi+Wzr972m9/HsS56SxPEXrYliqBQ6Z9nkNUnnCEb7EmGROkudwtesw5sO2ieyapNyMZZ7yuqOcO41gkXYtf4eGRRwhUYevAXg1XvasYeftNo6LDYk8Y7Nlsa2lHpZNRnjsAzAm6bGfh+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606452; c=relaxed/simple;
	bh=pGSsRkZlxFE4/rDI5BTTMbWX+r1CfkdOa/U2M96EyA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3KO0lfOux3rDjhCfect6HzrgNoQHIYJofkiW3k4ppmV+bh7mNQOtgUi0gh945QQOdU24A2+3+oEGKw6sKmmrvoGXfLnU4mXqDZuzTDxJhBVfTwDDjh7dcRDBTGAuxZjpBCZZZyExe2osisVoAt9Gvvet8bJ771xiTqttDtTFNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vWC/ojFp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BT3B1DtxJah2Y+P2ydapGunbjX2yfyQbDYuMIQAZfck=; b=vWC/ojFpmd+xp5mEgWTFMQ8TMr
	jk+JjiXjRkFD3XHRA1ShZhl3aZ+7PhpQm4LP8XBSDHGyo7qeUetQw1sbg7eI4DgZne7aXR2e68C7L
	bJV0BptTyHhLRjNVXGtFc7uPx9RM1VCBsZJNXnLialsiJWNVYcBAhrUJprWzH4e1JRjV+UuvSc5/W
	N55Jzjf1RVn2BDVDuzyEuDakucvHkggNawl6kcMfQy+qUz7LQbPV5X9y7kdjLzi5LoFbY/UObXNJW
	DTg1aLnM1vfw4o/G9ZghOBkBIpgFs10JjprJA4iClXLSvjE/aD0dA/uDyh+S3iPdsCnkz1iUdXdDy
	q6JqM6mw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubkzr-0000000DVTi-0ZXY;
	Tue, 15 Jul 2025 19:07:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B58A83001AA; Tue, 15 Jul 2025 21:07:22 +0200 (CEST)
Date: Tue, 15 Jul 2025 21:07:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
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
Subject: Re: [PATCH v13 10/14] unwind: Clear unwind_mask on exit back to user
 space
Message-ID: <20250715190722.GH4105545@noisy.programming.kicks-ass.net>
References: <20250708012239.268642741@kernel.org>
 <20250708012359.345060579@kernel.org>
 <20250715102912.GQ1613200@noisy.programming.kicks-ass.net>
 <20250715132016.409b1082@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715132016.409b1082@batman.local.home>

On Tue, Jul 15, 2025 at 01:20:16PM -0400, Steven Rostedt wrote:
> On Tue, 15 Jul 2025 12:29:12 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > @@ -170,41 +193,62 @@ static void unwind_deferred_task_work(st
> >  int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
> >  {
> >  	struct unwind_task_info *info = &current->unwind_info;
> > -	int ret;
> > +	unsigned long bits, mask;
> > +	int bit, ret;
> >  
> >  	*cookie = 0;
> >  
> > -	if (WARN_ON_ONCE(in_nmi()))
> > -		return -EINVAL;
> > -
> >  	if ((current->flags & (PF_KTHREAD | PF_EXITING)) ||
> >  	    !user_mode(task_pt_regs(current)))
> >  		return -EINVAL;
> >  
> > +	/* NMI requires having safe cmpxchg operations */
> > +	if (WARN_ON_ONCE(!UNWIND_NMI_SAFE && in_nmi()))
> > +		return -EINVAL;
> 
> I don't think we want to have a WARN_ON() here as the perf series tries
> to first do the deferred unwinding and if that fails, it will go back
> to it's old method.

The thing is, I don't think we have an architecture that supports NMIs
and does not have NMI safe cmpxchg. And if we do have one such -- I
don't think it has perf; perf very much assumes cmpxchg is NMI safe.

Calling this from NMI context and not having an NMI safe cmpxchg is very
much a dodgy use case. Please leave the WARN, if it ever triggers, we'll
look at who manages and deal with it then.

