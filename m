Return-Path: <bpf+bounces-67047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8F8B3C582
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 01:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A639A7A9A35
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 23:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E5435AAB0;
	Fri, 29 Aug 2025 23:09:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9343B35A2B3;
	Fri, 29 Aug 2025 23:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756508970; cv=none; b=P3xGQE/6Ela9PWDJT9W9mtka9GAAoVxBPNRTBypWB/m3+x1GGLBVIBS+SZZGtb6QUddKoKP05ZIJ0W/r/1zgO58VKqm8K9hM3lNKH/Oj+srWD1swTqTmVIZjlXVyRoy0Iv2/ypioYoFYxOPORYEt+RGk7Mx6dKbjU2SGA/79Etw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756508970; c=relaxed/simple;
	bh=3JyHbvRnaaHIi/b1C2NzRUSgFamGapR3ArvHz4sLaHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KnysLuXD/PsMhhS5MsIswnVu3rDTxmADYt700PuaFS0G+Qzd9UqC8n4x4GiqBGW1qOpI5aaB63nmZG56BaWdo1Ux/h+cw9WGdAVM3zDaujDDK1Mxr0xGOZ98ecGbh7TeqpEWpMswp4FMgj6KgBsy4BwgsE1iCiC3CPCPN8sIJKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 71BA985A5A;
	Fri, 29 Aug 2025 23:09:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 49DA93C;
	Fri, 29 Aug 2025 23:09:13 +0000 (UTC)
Date: Fri, 29 Aug 2025 19:09:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Steven Rostedt
 <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave
 <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, Andrew
 Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell"
 <codonell@redhat.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
Message-ID: <20250829190935.7e014820@gandalf.local.home>
In-Reply-To: <CAHk-=wj7rL47QetC+e70y7pgyH4v7Q2vcSZatRsCk+Z6urA3hw@mail.gmail.com>
References: <20250828180300.591225320@kernel.org>
	<20250828164819.51e300ec@batman.local.home>
	<CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
	<20250828171748.07681a63@batman.local.home>
	<CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
	<20250829110639.1cfc5dcc@gandalf.local.home>
	<CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
	<20250829121900.0e79673c@gandalf.local.home>
	<CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
	<20250829124922.6826cfe6@gandalf.local.home>
	<CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
	<6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com>
	<CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
	<20250829141142.3ffc8111@gandalf.local.home>
	<CAHk-=wh8QVL4rb_17+6NfxW=AF-HS0WarMmq-nYm42akG0-Gbg@mail.gmail.com>
	<20250829171855.64f2cbfc@gandalf.local.home>
	<CAHk-=wj7rL47QetC+e70y7pgyH4v7Q2vcSZatRsCk+Z6urA3hw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 49DA93C
X-Stat-Signature: d91bwhi77buw9f5ee1t6gu5rys1gt79y
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18qW41vAqv+HdNuucWLcvLSUcUm7Wgw5IM=
X-HE-Tag: 1756508953-116910
X-HE-Meta: U2FsdGVkX1990IGdbs27+Hu1eiR1l1guVyVGIfePesD6zFXIv/6j7ycmy4oB8/l8hMQ3n6t0HtQgs8Ufm2P2/eKrL0VS5riLWTqjy3QcmU5OYN58W54RPhK5WOsnScXxn09N2oN81YTv1rzAtUxzD7Z3+QHcAGe1PjePU7aWwG7bO0MwZJFcciS2KwNkgdnO174dKUophsuHhv65hEJH2EeMqK2XWDYVKMj/neiJBdP8bal15dNWD3G12/XEUpO8tW9RmUmslgxtCmEfD2kPOcDCHxoug3/zsi/sslE9kZpqSNlicqmz9LCTICwNe9gKqu7aPQ6CaYTDn1a8z+uPHSaxRYE/P7NNGxY5zS+2bvZq+ryE3K4KhtrZeS4vQrfOiB/pjJE2oQ/Hqd1pYftS+JgARvNB6exHGXHgju7nZcwb5ItYjdWawxqNzT4hHAT2

On Fri, 29 Aug 2025 15:40:07 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 29 Aug 2025 at 14:18, Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > Just do the parsing at parse time. End of story.  
> >
> > What does "parsing at parse time" mean?  
> 
> In user space. When parsing the trace events.
> 
> Not in kernel space, when generating the events.
> 
> Arnaldo already said it was workable.

Perf does do things differently, as I believe it processes the events as it
reads from the kernel (Arnaldo correct me if I'm wrong).

For the tracefs code, the raw data gets saved directly into a file, and the
processing happens after the fact. If a tool is recording, it still needs a
way to know what those hash values mean, after the tracing is complete.

Same for when the user cats the "trace" file. If the vma's have already
been freed, when this happens, how do we map these hashes from the vma? Do
we need to have trace events in the unmap to trigger them? If tracing is
not recording anymore, those events will be dropped too. Also, we only want
to record the vmas that are in the stack traces. Not just any vma.

> 
> > When I get a user space stack trace, I get the virtual addresses of each of
> > the user space functions. This is saved into an user stack trace event in
> > the ring buffer that usually gets mapped right to a file for post
> > processing.
> >
> > I still do the:
> >
> >  user_stack_trace() {
> >    foreach addr each stack frame
> >       vma = vma_lookup(mm, addr);
> >       callchain[i++] = (addr - vma->vm_start) + (vma->vm_pgoff << PAGE_SHIFT);
> >
> > Are you saying that this shouldn't be done either?  
> 
> I'm saying that's ALL that should be done. And then that *ONE* single thing:
> 
>      callchain_filehash[i++] = hash(vma->vm_file);
> 
> BUT NOTHING ELSE.
> 
> None of that trace_file_map() garbage.
> 
> None of that add_into_hash() garbage.
> 
> NOTHING like that. You don't look at the hash. You don't "register"
> it. You don't touch it in any way. You literally just use it as a
> value, and user space will figure it out later. At event parsing time.

I guess this is where I'm stuck. How does user space know what those hash
values mean? Where does it get the information from?

> 
> At most, you could have some trivial optimization to avoid hashing the
> same pointer twice, ie have some single-entry cache of "it's still the
> same file pointer, I'll just use the same hash I calculated last
> time".
> 
> And I mean *single*-level, because siphash is fast enough that doing
> anything *more* than that is going to be slower than just
> re-calculating the hash.
> 
> In fact, you should probably do that optimization at the whole
> vma_lookup() level, and try to not look up the same vma multiple times
> when a common situation is probably that you'll have multiple stack
> frames all with entries pointing to the same executable (or library)
> mapping. Because "vma_lookup()" is likely about as expensive as the
> hashing is.

Yeah, we could add an optimization to store vma's in the callchain walk to
see if the next call chain belongs to a previous one. Could even just cache
the previous vma, as it's not as common to have one library calling into
another and back again.

That is, this would likely be useful:

  vma = NULL;
  foreach addr in callchain
    if (!vma || addr not in range of vma)
      vma = vma_lookup(addr);

-- Steve

