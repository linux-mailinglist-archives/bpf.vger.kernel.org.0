Return-Path: <bpf+bounces-67040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 828DEB3C435
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 23:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1033B3B14AB
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 21:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA64528505C;
	Fri, 29 Aug 2025 21:18:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB5C1EEA49;
	Fri, 29 Aug 2025 21:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756502324; cv=none; b=sO6RCpiS3FtzSrg8Xg+DpYXF6IKZdUA8hbHtqAm4ai1gsNs9fT3C1F9DR0a5LCLDO5P4i7L6TtBE/bN4K405jqcFbI5Ntqm3HlrG82nbw1yrv7J9sq8it09p6x8xh0m3FsuwAILbk2aVzW6/2uN4RwFexr+uP7T5j6tC5LU8wb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756502324; c=relaxed/simple;
	bh=RYOu0bMYVMS0CJNjElebnSBdnOQ7QIVuZ+Ry/6lRIn0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n/hx6ha5lu8ZFVzwxDkOMODLG0aLbn6HFr5RYfAOxavPH8mjLomMMuBWhQ4CU8ejnVqpyoOarPskUTiaKHZqWYqLyM3pFbNChhPMv3kIJuzjmMMs49iLk4Zxl5srhwgP5gQx/CIcP/eTK7BssbMD7xpRTkG2QGY9ck1wZy7RcQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id F2D42119DC2;
	Fri, 29 Aug 2025 21:18:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id AB7CF2000E;
	Fri, 29 Aug 2025 21:18:33 +0000 (UTC)
Date: Fri, 29 Aug 2025 17:18:55 -0400
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
Message-ID: <20250829171855.64f2cbfc@gandalf.local.home>
In-Reply-To: <CAHk-=wh8QVL4rb_17+6NfxW=AF-HS0WarMmq-nYm42akG0-Gbg@mail.gmail.com>
References: <20250828180300.591225320@kernel.org>
	<20250828161718.77cb6e61@batman.local.home>
	<CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
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
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AB7CF2000E
X-Stat-Signature: w3ym7wpa6zzpwnb7t6ru45gcf9o647yf
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/xOwhcpNx8jBJvzSWcQKR6NMQEpBrR9Ws=
X-HE-Tag: 1756502313-711946
X-HE-Meta: U2FsdGVkX1+iQ1x6FBp3lwKCTTU9jDI5hstb9vfH4+g/iGcQlxwYXiPatWIIZJMfUouB8xBufqf1/oRk/Dk4ZoiCyHjqCIJIYwjTzASXDmS3W6QWsUf0yP0LY7juuCpQ+qZKViSMyUSfmfRgQKPzM4zjsW1/1MNvrhQX1RrRdQ8tkOZP9vbPvuqGeIY9N2pvySkqeJYttAnlxvRK8lKIuiq33RaxQl8Z20s0tlumroF6y67zmVYpCyefKjMTz1YOSAw/Jc0KxkYeS/Dd+zi+SH5lR9oP9DgmJKdVUFErLw+T6mmNzkwqAmPcwSA0m5JkDYxcodmFE6GK8Fw0Q4C3y0wIxq78A1dLSBW+U4Jih/s2+38HL9/uRtL2c/zrmtIx/WiQIs4R8sPYPH3pkn7V++LPQL8ZzudClF8Ut+5GgzkTSxZME666jJwEi01EqYJ7

On Fri, 29 Aug 2025 13:54:08 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 29 Aug 2025 at 11:11, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > The idea is this (pseudo code):
> >
> >  user_stack_trace() {
> >    foreach vma in each stack frame:
> >        key = hash(vma->vm_file);
> >        if (!lookup(key)) {
> >            trace_file_map(key, generate_path(vma), generate_buildid(vma));
> >            add_into_hash(key);
> >        }
> >    }  
> 
> I see *zero* advantage to this. It's only doing stupid things that
> cost extra, and only because you don't want to do the smart thing that
> I've explained extensively that has *NONE* of these overheads.
> 
> Just do the parsing at parse time. End of story.

What does "parsing at parse time" mean?

> 
> Or don't do this at all. Justy forget the whole thing entirely. Throw
> the patch that started this all away, and just DON'T DO THIS.

Maybe we are talking past each other.

When I get a user space stack trace, I get the virtual addresses of each of
the user space functions. This is saved into an user stack trace event in
the ring buffer that usually gets mapped right to a file for post
processing.

I still do the:

 user_stack_trace() {
   foreach addr each stack frame
      vma = vma_lookup(mm, addr);
      callchain[i++] = (addr - vma->vm_start) + (vma->vm_pgoff << PAGE_SHIFT);

Are you saying that this shouldn't be done either? And to just record the
the virtual address in the chain and the vma->vm_start and
vma->vm_pgoff in another event? Where the post processing could do the
math? This other event could also record the path and build id.

The question is, when do I record this vma event? How do I know it's new?

I can't rely too much on other events (like mmap) and such as those events
may have occurred before the tracing started. I have to have some way to
know if the vma has been saved previously, which was why I had the hash
lookup, and only add vma's on new instances.

My main question is, when do I record the vma data event?

-- Steve


