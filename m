Return-Path: <bpf+bounces-67054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EEFB3C6ED
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 03:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B00A3AF093
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 01:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E84D22F764;
	Sat, 30 Aug 2025 01:20:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D48E36124;
	Sat, 30 Aug 2025 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756516811; cv=none; b=oFsW4jnxmyXXT81Kncv83lxdrV8uLcMpkQAGozXWli66HkSXwvf/0UqDCZnkdWBVSxSaBUyT1cIzAquYwH3e3JhxQvZShFqypG9qxkzUnPKvdSebTMoQrguJUiG99lU5t/QbFnnsHXKiQ9ZyuVhDiUZipHs6QojWoSbPows/RPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756516811; c=relaxed/simple;
	bh=fA0wTuyke8msvryBWLSqUN3ToVvA7RKDDHu/4HW1bas=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l2l+BRKf+iu2a+ew6Q3rF8SXO1xlvfWKRLEoy+8O7/lHN5FVisSqPBw0T2wrDODULVzrsh8kfrhmSGxib2NGldgd9R9mic8ZlzJ+NTkaX/FkfXg8/eo8ynMLu48jsng4MMTEgWWZKkRK6fomLWjyV0pjJX4hjvO73tgY/a+TFuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 4D55185AE1;
	Sat, 30 Aug 2025 01:20:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 17E0520025;
	Sat, 30 Aug 2025 01:20:00 +0000 (UTC)
Date: Fri, 29 Aug 2025 21:20:23 -0400
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
Message-ID: <20250829212023.4ab9506f@gandalf.local.home>
In-Reply-To: <CAHk-=wgNeu8_=kPnKwFpwMUC=o-uh=KjJWePR9ujk=7F9yNXDQ@mail.gmail.com>
References: <20250828180300.591225320@kernel.org>
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
	<20250829190935.7e014820@gandalf.local.home>
	<CAHk-=wgNeu8_=kPnKwFpwMUC=o-uh=KjJWePR9ujk=7F9yNXDQ@mail.gmail.com>
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
X-Rspamd-Queue-Id: 17E0520025
X-Stat-Signature: hh8tgfixqg6yjq5a38c7smg4ut7eoby6
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+XAwUAQ2TlOZasASPGpnSZNRdZy3TxNAA=
X-HE-Tag: 1756516800-877417
X-HE-Meta: U2FsdGVkX1823Ra0u95wbzUf/FTrTDKuy4UYaNSQU0c3XjaMy32xNgp4Uo39KpsWUrJjYv5QiCjuOEMmVOV/HmB1tWw6J4gQiC5yjoXiN7rukSEJxF06WJesFcDSolp6GJCsMG3xcxmIqpRNy4ImrMi8Xnioe0xkxhulQ3KxkDhwZhS3nS5Pz9ptx/7v8RGh98fh9QR04xYH/CeorLGuEgx2ct5rKxvkT/fA+mKKsJvze3M7T0BMhsnHnW/GlsMvSEf5Fgh9y0z/h+8NJIbnTp5JHS1zdQtU9tGy8iYHFLLT1AnlIlR6yZunitwQigc60SIDf8qOO33DFBsyaf/v2t12/SZ4oTig5tYqp1kCX1t7HAuZS/gFf47indJGrUzTPhV7Gxun04yrPDss91c9dLmuJ8arJola0fFRnHdRPRlpROEE31o6D9ZOsHM0whow

On Fri, 29 Aug 2025 17:45:39 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 29 Aug 2025 at 16:09, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Perf does do things differently, as I believe it processes the events as it
> > reads from the kernel (Arnaldo correct me if I'm wrong).
> >
> > For the tracefs code, the raw data gets saved directly into a file, and the
> > processing happens after the fact. If a tool is recording, it still needs a
> > way to know what those hash values mean, after the tracing is complete.  
> 
> But the data IS ALL THERE.

But only in the kernel. How do I expose it?

> 
> Really. That's the point.
> 
> It's there in the same file, it just needs those mmap events that
> whoever pasrses it - whether it be perf, or somebody reading some

What mmap events are you talking about? Nothing happens to be tracing mmap
events. An interrupt triggered, we want a user space stack trace for that
interrupt, it records the kernel stack trace and a cookie that gets matched
to the user stack trace. It is then deferred until it goes back to user
space and the deferred infrastructure does a callback to the tracer with
the list of addresses that represent the user space call stack.

We do a vma_lookup() to get the vma of each of those addresses. Now we make
some hash that represents that vma for each address. But there has been no
event that maps to this vma to what the file is. And the vma's in these
stack traces are a subset of all the vma's. When the user finally gets
around to reading them, the vmas could be long gone. How is user space
supposed to find out what files they belong to?

Do we need to record most events to grab all the vma's and the files they
belong to? Note, one of the constraints to tracing is the buffer size. We
don't want to be recording information that we don't care about.

> tracefs code - sees the mmap data, sees the cookies (hash values) that
> implies, and then matches those cookies with the subsequent trace
> entry cookies.

That was basically what I was doing with the vma hash table. To print out
the vmas as soon as a new one is referenced. It created the event needed,
and only for the vmas we care about.

> 
> But what it does *NOT* need is munmap() events.

This wouldn't be recording munmap events. It would use the unmap event to
callback and remove the vma from the hash when they happened, so that if
they get reused the new ones would be printed. It's no different if we use
munmap or mmap. I could hook into the mmap event instead and check if it is
in the vma hash and if so, either reprint it, or remove it so if the vma is
in a call stack it would get reprinted.

Writing the file for every mmap seems to be a waste of ring buffer space if
the majority of them is not going to be in a stack trace.

> 
> What it does *NOT* need is translating each hash value for each entry
> by the kernel, when whoever treads the file can just remember and
> re-create it in user space.

What's reading the files? The applications that are being traced?

> 
> I'm done arguing. You're not listening, so I'll just let you know that

I am listening. I'm just not understanding you.

> I'm not pulling garbage. I've had enough garbage in tracefs, I'm still
> smarting from having to fix up the horrendous VFS interfaces, I'm not
> going to pull anything that messes up this too.

I know you keep bringing up the tracefs eventfs issue. Hey, I asked for
help with that when I first started it. I was basically told by some of the
VFS folks (I'm not going to name names) that "don't worry, if it works it's
fine". I was very worried that I wasn't doing it right. And it wasn't until
you got involved where you were the first one to tell me that using dentry
outside of VFS was a bad idea. Most of our arguing then was because I
didn't understand that. That also lead to the "garbage" code you had to fix
up.

So keep bringing that up. It just shows how much of tribal knowledge is
needed to work in the kernel. Heck, the VFS folks are still arguing about
how to handle things like kernfs. Which is similar to the eventfs issue.
And that boils down to things like kernefs, eventfs and procfs have a
fundamental difference to all other file systems. And that is it's a file
interface to the kernel itself, and not some external source. I realized
this during our arguments over eventfs. You do a write or read from a file,
and unlike other file systems, those actions trigger kernel functions
outside of vfs. But this is another topic altogether, and I only brought it
up because you did.

-- Steve

