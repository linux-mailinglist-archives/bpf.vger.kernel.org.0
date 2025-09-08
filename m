Return-Path: <bpf+bounces-67801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA256B49C4D
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 23:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BDE93B2A9B
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 21:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C822DF6F7;
	Mon,  8 Sep 2025 21:42:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE6020C004;
	Mon,  8 Sep 2025 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367721; cv=none; b=M7KgehF5CMFMM8FJ2Jbcu5P18eb4gf5Yb4OfAZMqMdm4JqAMDZjCKuPepAil9p+HFn8qSx94xhVB0Y6wYjBErA6+gG51Rf5FyymjYdHi8IDDi2nKSCVnVsJYtWhMIzUA5D2w5Z7aOTADrUgnRSS6jlNWtlo8QxVf/h6owBSmv8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367721; c=relaxed/simple;
	bh=pcupT4JxHZa/XBL17X8Hm8c1mg4Gd7THUkTpzM9I1fA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/aojTRnE+3YgneYREcJCsS/OmCH4ChbGi36031mar8WPeAoZoLCNGFKiyFXcxYIzwVP8V4smyYQAqs55Aceh5mxplHRyk3HsX+OFxd65c1FrjxhUXf9KfysEBpUy7SKEihxlLKTUIw2Du4Jiv9vbCWUlaHZUTq8nodyXefTixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id D4FE3119719;
	Mon,  8 Sep 2025 21:41:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 9FD2060011;
	Mon,  8 Sep 2025 21:41:49 +0000 (UTC)
Date: Mon, 8 Sep 2025 17:42:35 -0400
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
Message-ID: <20250908174235.29a57e62@gandalf.local.home>
In-Reply-To: <CAHk-=wjgXGuJVaOmftxnwrS6FafwrLL+yHrH6-sgbBRB-iLn8w@mail.gmail.com>
References: <20250828180300.591225320@kernel.org>
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
	<20250830143114.395ed246@batman.local.home>
	<CAHk-=wjgXGuJVaOmftxnwrS6FafwrLL+yHrH6-sgbBRB-iLn8w@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: gpj98z98daaxksb57udjcmxtab8so5n5
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 9FD2060011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/CfE+ywjht4F27AI8/CvrIl4boMbDPuIQ=
X-HE-Tag: 1757367709-480644
X-HE-Meta: U2FsdGVkX1/ZVrqhJu4Jt72FlxS7qiCR5j663z72R2b1nyrM90EuP+eO8yhIVven4tNTQC0ED3ZsPcdQA8qlSCOXFMZxe+1cdyjvgXOJX4+unGdWGySn9oZL8xQwCeFCO1ioxzXrAi0AstdjZHF6s5ABFQyETmy8OWcwasDG1+elerSFv/3a6zucpoWa2b0kt5BVdknoJL7BzbxAenbEQ6ghs/2dWe0G7SZBphsowA1HM9U26l9SzDTtOSxANJzoy7Uo0a69iuRFTLSscEdsT+9a6JvYV8hNUKv30d+96KrgN2a2wje+asr64R1jdFamUKskzrrRXHuCCCoaX++nOe4lLJ/0ldsfptSo3+X9vLPVsmkdQg/1AGrYZLsosrrE8Yz/erbuHHh4ApFvSGQ/Y6iciS5KDTOuUDv20OjzpozVT36jQB69UhJYJh1zzLs6

On Sat, 30 Aug 2025 12:03:53 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, 30 Aug 2025 at 11:31, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > If we are going to rely on mmap, then we might as well get rid of the
> > vma_lookup() altogether. The mmap event will have the mapping of the
> > file to the actual virtual address.  
> 
> It actually won't - not unless you also track every mremap etc.
> 
> Which is certainly doable, but I'd argue that it's a lot of complexity.
> 
> All you really want is an ID for the file mapping, and yes, I agree
> that it's very very annoying that we don't have anything that can then
> be correlated to user space any other way than also having a stage
> that tracks mmap.
> 
> I've slept on it and tried to come up with something, and I can't. As
> mentioned, the inode->i_ino isn't actually exposed to user space as
> such at all for some common filesystems, so while it's very
> traditional, it really doesn't actually work. It's also almost
> impossible to turn into a path, which is what you often would want for
> many cases.
> 
> That said, having slept on it, I'm starting to come around to the
> inode number model, not because I think it's a good model - it really
> isn't - but because it's a very historical mistake.
> 
> And in particular, it's the same mistake we made in /proc/<xyz>/maps.
> 
> So I think it's very very wrong, but it does have the advantage that
> it's a number that we already do export.
> 
> But the inode we expose that way isn't actually the
> 'vma->vm_file->f_inode' as you'd think, it's actually
> 
>         inode = file_user_inode(vma->vm_file);
> 
> which is subtly different for the backing inode case (ie overlayfs).
> 
> Oh, how I dislike that thing, but using the same thing as
> /proc/<xyz>/maps does avoid some problems.
> 

Sorry for the late reply. I left to the Tracing Summit the following
Monday, and when I got back home on Thursday, I came down with a nasty cold
that prevented me from thinking about any of this.

I just re-read the entire thread, and I'm still not sure where to go with
this. Thus, let me start with what I'm trying to accomplish, and even add
one example of a real world use case we would like to have.

Several times we find issues with futexes causing applications to either
lock up or cause long latency. Since a futex is mostly managed in user
space, it's good to be able to at least have a backtrace of where a
contended futex occurs. Thus we start tracing the futex system call and
triggering a user space backtrace on each one. Using this information can
help us figure out where the futex contention lies. This is just one use
case, we do have others.

Ideally, the user space stack trace should look like:

   futex_requeue-1044    [002] .....   168.761423: <user stack unwind>
cookie=31500000003
 =>  <000000000009a9ee> : path=/usr/lib/x86_64-linux-gnu/libselinux.so.1 build_id={0x3ba6e0c2,0xdd815e8,0xe1821a58,0xa5940cef,0x7c7bc5ab}
 =>  <0000000000001472> : path=/work/c/futex_requeue build_id={0xc02417ea,0x1f4e0143,0x338cf27d,0x506a7a5d,0x7884d090}
 =>  <0000000000092b7b> : path=/usr/lib/x86_64-linux-gnu/libselinux.so.1 build_id={0x3ba6e0c2,0xdd815e8,0xe1821a58,0xa5940cef,0x7c7bc5ab}

Where the above shows the callstack (offset from the file), the path to the
file, and a build id of that file such that the tooling can verify that the
path is indeed the same library/executable as for when the trace occurred.

Note, the build-id isn't really necessary for my own use case, because the
applications seldom change on a chromebook. I added it as it appears to be
useful for others I've talked to that would like to use this.

But printing a copy of the full path name and build-id at every stack trace
is expensive. The path lookup may not be so bad, but the space on the ring
buffer is.

To compensate this, we could replace the path and build-id with a unique
identifier, (being an inode/device or hash, or whatever) to associate that
file. It may even work if it is unique per task. Then whenever one of these
identifiers were to show up representing a new file, it would be printed.

We could monitor an event that if a file is deleted, renamed, or whatever,
and a new file with the same name comes around, the identifier with the
path and build-id gets printed for the new file.

Where the output would be, instead:

             sed-1037    [007] ...1.   167.362583: file_map: hash=0x51eff94b path=/usr/lib/x86_64-linux-gnu/libselinux.so.1 build_id={0x3ba6e0c2,0xdd815e8,0xe1821a58,0xa5940cef,0x7c7bc5ab}
[..]
   futex_requeue-1042    [007] ...1.   168.754128: file_map: hash=0xad2c6f1b path=/work/c/futex_requeue build_id={0xc02417ea,0x1f4e0143,0x338cf27d,0x506a7a5d,0x7884d090}
[..]
   futex_requeue-1042    [007] .....   168.757912: <user stack unwind>
cookie=34900000008
 =>  <00000000001001ca> : 0x51eff94b
 =>  <000000000000173c> : 0xad2c6f1b
 =>  <0000000000029ca8> : 0x51eff94b
[.. repeats several more traces without having to save the path names again ..]

It comes down to when do we print these mappings?

I noticed that uprobes has hooks to all the mmappings in the vma code as it
needs to keep track of them. We could change those hooks to tracepoints,
and have both uprobes and tracing monitor the changes, and when a new
mapping happens, it traces it. Changing them to tracepoints may be useful
anyway, as it would then turn them over to static branchs and not a normal
"if" statement.

We could even add a file to tracefs that would trigger the dump of all
files that are mapped executable for all currently running tasks.Then when
tracing starts, it would trigger the "show all currently running task
mappings" and then only do the mappings on demand. This way, the tracer
would get the mappings of the identifier (or hash, or whatever) to the
files and build-ids at the start of tracing, as well as get any of the
mappings when they happen later on.

This should have enough information for the post processing to put the
stack traces back to what is ideal in the first place. That is, the tooling
could output:

   futex_requeue-1044    [002] .....   168.761423: <user stack unwind>
cookie=31500000003
 =>  <000000000009a9ee> : path=/usr/lib/x86_64-linux-gnu/libselinux.so.1 build_id={0x3ba6e0c2,0xdd815e8,0xe1821a58,0xa5940cef,0x7c7bc5ab}
 =>  <0000000000001472> : path=/work/c/futex_requeue build_id={0xc02417ea,0x1f4e0143,0x338cf27d,0x506a7a5d,0x7884d090}
 =>  <0000000000092b7b> : path=/usr/lib/x86_64-linux-gnu/libselinux.so.1 build_id={0x3ba6e0c2,0xdd815e8,0xe1821a58,0xa5940cef,0x7c7bc5ab}

and hide the identifier that was used in the ring buffer.

-- Steve



