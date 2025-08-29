Return-Path: <bpf+bounces-67027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABA8B3C246
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 20:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F02B1CC3C9F
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 18:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A287F3431F8;
	Fri, 29 Aug 2025 18:11:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86CF209F5A;
	Fri, 29 Aug 2025 18:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756491090; cv=none; b=fxbbe9rRJvBwQaaaXkcOkhgzTaMyr3Vo4CD0F3GT3ykpNtBjpBoCb/axRImFBRKAomxgXZkdxvXYabgvCnyPvC1IfO6ui1ShPHlwUanpisfKKCHsEBE5FQLE/valNi/rOBX28l39FMwYiLFqEUD7rURSiAw9ArIKb4UPtSZQQyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756491090; c=relaxed/simple;
	bh=aTMz6QKRB8sX8tPG29W2hZGoOIxk1SKdVcBnuPoHXgI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MONg9NU8BtjDX4WR0jsNAdsg3RyvS2ZUamtFXMkqyU1kfUPuxPO/apoyewgTv1Zx56OGmzTI2Cl4OXvZLVLcrUMGm93an7DExGFIep3hFeNv7zLL5I5yn+jJgCG5GuatUjMGyFZA+leFhYOpwMQaGsFMM+Kxo4yDt8HcqUPKjBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 8842513A96D;
	Fri, 29 Aug 2025 18:11:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 76F576000F;
	Fri, 29 Aug 2025 18:11:19 +0000 (UTC)
Date: Fri, 29 Aug 2025 14:11:42 -0400
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
Message-ID: <20250829141142.3ffc8111@gandalf.local.home>
In-Reply-To: <CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
References: <20250828180300.591225320@kernel.org>
	<D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com>
	<CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
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
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 76F576000F
X-Stat-Signature: 7g4cgxahc864hsc8pkq97bkmqmtg4bh9
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19VoDMXkG87cPh4pXXWRE7cb0ZOSUa8IWQ=
X-HE-Tag: 1756491079-407632
X-HE-Meta: U2FsdGVkX183qe31Z0942gMaignr2sHg+i2BLFlOyekXIPjeyCIt7jp8b81kngcQMUgvle8KM99ttt01QkLid3YpfHt3Qs8U2Vixniwd7aQHFt6BgE3JVVcAdgbAoEGPr008+Vl7hHHuE0Crwsn5Zf7H1mOHut/052ABwhZBXAbOSczNE7+aVRTKH8Ors48Y4NEq6fpd398417dlcXb9rDw5cYA/qFgUdZ+lAv9Uok1R1Hrosqk1UF73ndYYLZoJlmdjxsbTfXEy+s0HmRP6gGn0F4UolHdcqNsRde/qfzFRYy3/vLGkGPt556WrMs9gZknbesNA/t7oDx/YuPUKh039jkwT4tN7V+3L40IWcR90wAudf+7RCk5hPeHBSbw8Qxo1G4si1Vv5GEPVktpabQ==

On Fri, 29 Aug 2025 10:33:38 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 29 Aug 2025 at 10:18, Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > As long as we don't lose those mmap events due to memory pressure/lost
> > events and we have timestamps to order it all before lookups, yeah
> > should work.  
> 
> The main reason to lose mmap events that I can see is that you start
> tracing in the middle of running something (for example, tracing
> systemd or some other "started at boot" thing).

Note, for on-demand tracing, the applications are already running before
the tracing starts. That is actually the common case. Yes, people do often
"enabled tracing, run my code, stop tracing", but most of the use cases I
deal with, it's (we are noticing something in the field, start tracing,
issue gets hit, stop tracing), where the applications we are monitoring are
already running when the tracing started. Just tracing the mmap when it
happens will not be useful for us.

Not to mention, in the future, this will also have to work with JIT. I was
thinking of using 64 bit hashes in the stack trace, where the top bits are
reserved for context (is this a file, or something dynamically created).

> 
> Then you'd not have any record of an actual mmap at all because it
> happened before you started tracing, even if there is no memory
> pressure or other thing going on.
> 
> That is not necessarily a show-stopper: you could have some fairly
> simple count for "how many times have I seen this hash", and add a
> "mmap reminder" event (which would just be the exact same thing as the
> regular mmap event).

I thought about clearing the file cache periodically, if for any other
reason, but for dropped events where the mapping is lost.

This is why I'm looking at clearing on "unmap". Yes, we don't care about
unmap, but as soon as an unmap happens if that value gets used again then
we know it's a new mapping. That is, dropped the hashes out of the file
cache when they are no longer around.

The idea is this (pseudo code):

 user_stack_trace() {
   foreach vma in each stack frame:
       key = hash(vma->vm_file);
       if (!lookup(key)) {
           trace_file_map(key, generate_path(vma), generate_buildid(vma));
           add_into_hash(key);
       }
   }
 }

On unmmaping:

 key = hash(vma->vm_file);
 remove_from_hash(key);

Now if a new mmap happens where the vma->vm_file is reused, the lookup(key)
will return false again and the file_map event will get triggered again.

We don't need to look at the mmap() calls, as those new mappings may never
end up in a user stack trace, and writing them out will just waste space in
the ring buffer.

-- Steve

