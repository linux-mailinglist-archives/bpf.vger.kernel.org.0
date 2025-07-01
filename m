Return-Path: <bpf+bounces-62021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6ACAF06ED
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 01:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A545B1BC6BA6
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 23:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B835302CA7;
	Tue,  1 Jul 2025 23:25:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861CD265CC8;
	Tue,  1 Jul 2025 23:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751412351; cv=none; b=mjeNDwcwU8JXr4PPUbX2XbaM1jY3TdSC3fXluZ0Sn+Gwcg1Q4DIlbtDbhsbY24zMfeveqi8omgBE2QDO+z+fAc5kN4WSGieKWDGohxBDFvYnCXMn8WwcGSNx9FrUaWLdVP6vp89bEVWGqC4DSqq0y1SuKb8KbBt8OwN8V3TG47I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751412351; c=relaxed/simple;
	bh=5LAi1AOn7t8Tm+vFBUGNdaWr1EwOHiTYD0dfTqMEO+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HS/PW0oCkqeT1VusB6ZeED8+QoVK6ISxJSrWwhMuJTkK9a2rLOsjPXPpQGtvtA044BrlBZTs5SlXdVGqF2jhD1yJDVv3wrKU5WM0ZmSZ38GR7ImJrUjMem83F20aLHHzgs/+MFUF/V6N1C6/fKqZLNuRJ2n3dUbQezmnNd9tqE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id B0854140698;
	Tue,  1 Jul 2025 23:25:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 5611220024;
	Tue,  1 Jul 2025 23:25:41 +0000 (UTC)
Date: Tue, 1 Jul 2025 19:26:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v12 00/14] unwind_user: x86: Deferred unwinding
 infrastructure
Message-ID: <20250701192619.20eb2a58@gandalf.local.home>
In-Reply-To: <202507011547.D291476BE1@keescook>
References: <20250701005321.942306427@goodmis.org>
	<CAHk-=wijwK_idn0TFvu2NL0vUaQF93xK01_Rru78EMqUHj=b1w@mail.gmail.com>
	<20250630224539.3ccf38b0@gandalf.local.home>
	<202507011547.D291476BE1@keescook>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: tryfq3spsju364iez3ck1zrf7mt7enjs
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 5611220024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Quzu2eU2osAE3RdCKzkTyOA2Ps8IYTmg=
X-HE-Tag: 1751412341-261051
X-HE-Meta: U2FsdGVkX1+pOpssR8artnZXR620RStoUESbyBTmV1nqsXqVd+7Cd+0dbSMwBZAlLzhIXluPkWuMp8vrnXp3LYszOvRajvAfz0Q97/lv+SON7IClC5Jsp695rmInoxhUw95MPkUKs62z2nQ/A68+X3hApa63qFHuFL1oYBk/WvGB1zws/FqOI3mnpDnq/4yzFiMIof+xzwQuB/uL6jo9mZU1xBiSZlF88+f1yhv0e5tCwpdKQbkw84W8VYm927Xkm71XdiPrggYXWn0MFfqobVM475TwdaXgjHXh8Z5Pgd47rfQkwu/6wT/+FvSL0nCvtB+XffwFXsxVVTHpjMpLAqzIruUZHg3tV71CWG+neISVTgWokbHm+v2ExpYk98Af+KeX99+gmbG9gj9PcEGRXf+ZwVgH3NjswkOUSksJ4g9zQesrHaNSK7b72AE++39X4cLXnc9kLFpqV5UsHtLXBaMZDJufUogIOY6Ag+9uxdlK2RngOwi5jDn1leQHGMZxckrrW7U9/mk=

On Tue, 1 Jul 2025 15:49:23 -0700
Kees Cook <kees@kernel.org> wrote:

> On Mon, Jun 30, 2025 at 10:45:39PM -0400, Steven Rostedt wrote:
> > On Mon, 30 Jun 2025 19:06:12 -0700
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >   
> > > On Mon, 30 Jun 2025 at 17:54, Steven Rostedt <rostedt@goodmis.org> wrote:  
> > > >
> > > > This is the first patch series of a set that will make it possible to be able
> > > > to use SFrames[1] in the Linux kernel. A quick recap of the motivation for
> > > > doing this.    
> > > 
> > > You have a '[1]' to indicate there's a link to what SFrames are.  
> > [...]
> >   [1] https://sourceware.org/binutils/wiki/sframe  
> 
> Okay, I've read the cover letter and this wiki page, but I am dense: why
> does the _kernel_ want to do this? Shouldn't it only be userspace that
> cares about userspace unwinding? I don't use perf, ftrace, and ebpf
> enough to make this obvious to me, I guess. ;)
> 

It's how perf does profiling. It needs to walk the user space stack to see
what functions are being called. Ftrace can do the same thing, but is not
as used because it doesn't have the tooling (yet) to figure out what the
user space addresses mean (but I'm working on fixing that).

And BPF has commands that it can do, but I don't know BPF enough to comment.

The big user is perf with profiling. It currently uses frame pointers, but
because of the way frame pointers are set up, it misses a lot of the leaf
functions when the interrupt triggers (which sframes does not have that
problem). Also, if frame pointers is not configured, perf may just copy
thousands of bytes of the user space stack into the kernel ring buffer and
then parse it later (this isn't used often due to the overhead).

Then there's s390 that doesn't have frame pointers and only has the copy of
thousands of bytes to do any meaningful user space profiling.

Note, this has been a long standing issue where in 2022, we had a BOF on
this, looking for something like ORC in user space as it would solve lots
of our issues. Then December of that same year, we heard about SFrames.

At Kernel Recipes in 2023, Brendan Gregg during his talk was saying that
there needs to be a better way to do profiling of user space from the
kernel without frame pointers. I mentioned SFrames and he was quite excited
to hear about it. That's also when Josh, who was in the attendance, asked
if he could do the implementation of it in the kernel!

Anyway, yeah, it's something that has a ton of interest, as it's the way
for tools like perf to give nice graphs of where user space bottlenecks
exist.

-- Steve

