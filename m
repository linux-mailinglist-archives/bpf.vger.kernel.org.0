Return-Path: <bpf+bounces-63207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DDEB0428F
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 17:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B5316A7BB
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 15:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8749258CEC;
	Mon, 14 Jul 2025 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EIbDYaxC"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F01246778;
	Mon, 14 Jul 2025 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505444; cv=none; b=s0rd73/RBnzXYJqiPrnHop1rgKJxftctdfLdB+k/FgkdAkS3nFjUg8qb0ARqgnXgOJkjijHZ8YB2/YgUQaJgZ+pRlNna/8ZP9OYYNJo0MLRrht4Dfni6akKy4ATLIP+nWNLo1NGnupzdczYtDR6flIM4LlSq5S8KY4LNi/N8930=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505444; c=relaxed/simple;
	bh=7kzQgCqlTjkjlznWYkmhokDiFU/LWNISMUtL8pwfR3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DneE1y0c1lIq85+qj2zSCh5ayNMuzNLcuOUh7Rtjl5I/cKLvo3pWciDl7/7dl5+UAA8UKS0OJOm88971ACp0sRylms7vkOkbHensna8bLiwIbzUngjJBBGxB86qv8FCeEZAOqIQcuyMYd4sLzTm+h3xh8QKSJVCXb2QZ31HONqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EIbDYaxC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rE0ipn3kKI2mA1FsjVZAKGKcjbPn01lZj8/tcXHVRzI=; b=EIbDYaxCcw/NxNHtcL5sQaMn+o
	UXadanzF9T7fTGHeBhlz/OUBeu46P/p83dm2IPmgruw0zP+wbhhoQlCkyOPP1at+LL6bvBjVujMB6
	aczpzZm+UKtPvy2G+idbaalzAASVItqck6LzmNRlPiWpPl/PyEx/ar9n3fJ93Gqway9asI6tNsjpy
	TxBcushnJ9MAl1cwtrvpmHXuh++0DtnYidBF1l5ttgKk/dJdptkjllLxBR/cSHqkeMQ8T9faG5Qee
	oKNGp2A7lIQhXGZd5IW+NKOqinLhJYTmywf1AM332HHTBEWDVtqLzzPa2s3lthUZWwqbZhQB2WrQ0
	+ZgxnIQQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubKiZ-00000009mK7-1F6h;
	Mon, 14 Jul 2025 15:03:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2D2C33001AA; Mon, 14 Jul 2025 17:03:46 +0200 (CEST)
Date: Mon, 14 Jul 2025 17:03:46 +0200
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
Subject: Re: [PATCH v13 09/14] unwind deferred: Use SRCU
 unwind_deferred_task_work()
Message-ID: <20250714150346.GD4105545@noisy.programming.kicks-ass.net>
References: <20250708012239.268642741@kernel.org>
 <20250708012359.172959778@kernel.org>
 <20250714135638.GC4105545@noisy.programming.kicks-ass.net>
 <20250714102140.4886afa0@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714102140.4886afa0@batman.local.home>

On Mon, Jul 14, 2025 at 10:21:40AM -0400, Steven Rostedt wrote:
> On Mon, 14 Jul 2025 15:56:38 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Please; something like so:
> > 
> > --- a/include/linux/srcu.h
> > +++ b/include/linux/srcu.h
> > @@ -524,4 +524,9 @@ DEFINE_LOCK_GUARD_1(srcu, struct srcu_st
> >  		    srcu_read_unlock(_T->lock, _T->idx),
> >  		    int idx)
> >  
> > +DEFINE_LOCK_GUARD_1(srcu_lite, struct srcu_struct,
> > +		    _T->idx = srcu_read_lock_lite(_T->lock),
> > +		    srcu_read_unlock_lite(_T->lock, _T->idx),
> > +		    int idx)
> > +
> >  #endif
> > --- a/kernel/unwind/deferred.c
> > +++ b/kernel/unwind/deferred.c
> > @@ -165,7 +165,7 @@ static void unwind_deferred_task_work(st
> >  
> >  	cookie = info->id.id;
> >  
> > -	guard(mutex)(&callback_mutex);
> > +	guard(srcu_lite)(&unwind_srcu);
> >  	list_for_each_entry(work, &callbacks, list) {
> >  		work->func(work, &trace, cookie);
> >  	}
> 
> I think I rather have a scoped_guard() here. One thing that bothers me
> about the guard() logic is that it could easily start to "leak"
> protection. That is, the unwind_srcu is only needed for walking the
> list. The reason I chose to open code the protection, is because I
> wanted to distinctly denote where the end of the protection was.

Sure. But the point was more to:
 - use scru_lite; and,
 - use guards

