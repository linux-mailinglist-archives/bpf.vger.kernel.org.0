Return-Path: <bpf+bounces-66999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66186B3C0CF
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 18:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25A437AF537
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 16:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1026B320CDA;
	Fri, 29 Aug 2025 16:33:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD1F1C1F05;
	Fri, 29 Aug 2025 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485189; cv=none; b=e9vNKvlxmB+Bvk5/f9S2dG+Xrs6ohegr6ZZfbrh+jvCD530vi3TB9L8M2x93RzjPIggptsYelAB+Q5WQxo3wiy6WbMpXD6vovv0dHZdGoTwujfgVlL2WjqNQEazg4Mc/r0pJ4lgTW0akEDsOOLqtWSJb0G1dnVb7nGmXZ/l4w+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485189; c=relaxed/simple;
	bh=nvG0E5ZhYK5MJoTg4GDlBaItGIBcw2d9WraWaihQzpE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lfFJAWFtf7bE1zlfJwGrQ3nca8xV0oYuOVHSGl8bZ/qp5FAQX9JwNtdNdkZmY6mrOipaL3BwEdyCtRK7bU6DeMhhKa5cwDPG/RuZp9isGXZPZJh7rCu9qQ7jub+UcvQ+HNVevi/0tcOWJaOTKq32OvyfwWOWr/gXwHJOYvoq3KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 3C9FCC0896;
	Fri, 29 Aug 2025 16:33:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id ECA1E80015;
	Fri, 29 Aug 2025 16:32:58 +0000 (UTC)
Date: Fri, 29 Aug 2025 12:33:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Arnaldo Carvalho de Melo
 <arnaldo.melo@gmail.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <20250829123321.63c9f525@gandalf.local.home>
In-Reply-To: <CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com>
References: <20250828180300.591225320@kernel.org>
	<20250828180357.223298134@kernel.org>
	<CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
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
	<CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: fajkd43mw64d5hsx51m4n734ki86gnp7
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: ECA1E80015
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+bqOqdpN7LTQMsmPjOiNjsKgQJjfUekco=
X-HE-Tag: 1756485178-347167
X-HE-Meta: U2FsdGVkX1/6r0lfSm84U5iVNsJiuqkZyHmu8dDfJFZxSk088FqCrEwXM1xBNjtM/svUyMJqVyYDcj8rUIM8ey1O6me8UarWSysyky7t8Dhku/ztC/hmCRVdIbQ55BgEr+niMHY6tGbXoLK4Q+Sib9dxiPjTg8OJlknfZcUuB0cDKbZNeyI/wdBLbByfvV7P/79/jxCz+xDLMpysW3EV3xNGAH5In15Sg/USnJeI8OfnOMp1O03QSSeH13ZXwAEBAFN+n1Nf99qWBI6mGhlB23BG/M6jKk983TOLysz+btWdso1WM1YcEGzF4pj8kWu23fvF3TDfz8yPH4I+sX/3FwBeeChPdzu4wanQYcUuRmSdA+sZfjVW7krSUvy2BoW9

On Fri, 29 Aug 2025 09:07:58 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> The dentry pointer will typically stick around rather aggressively,
> and will likely remain the same when you delete a file and create
> another one with the same name, and the mnt pointer will stick around
> too, so the contents of 'struct path' will be the exact same for two
> completely different files across a delete/create event.

I'm not sure how often a trace would expand the event of running code,
deleting the code, recreating it, and running it again. But that means the
stack traces of the original code will be useless regardless. But at a
minimum, the recreating of the code should trigger another print, and this
would give it a different build-id (which I'm not recording as well as the
path).

> 
> So hashing the path is very likely to stay the same as long as the
> actual path stays the same, but would be fairly insensitive to the
> underlying data changing. People might not care, particularly with
> executables and libraries that simply don't get switched around much.
> 
> And, 'struct file *' will get reused randomly just based on memory
> allocation issues, but I wouldn't be surprised if a close/open
> sequence would get the same 'struct file *' pointer.
> 
> So these will all have various different 'value stays the same, but
> the underlying data changed' patterns. I really think that you should
> just treat the hash as a very random number, not assign it *any*
> meaning at trace collection time, and the more random the better.
> 
> And then do all the "figure it out" work in user space when *looking*
> at the traces. It might be a bit more work, and involve a bit more
> data, but I _think_ it should be very straightforward to just do a
> "what was the last mmap that had this hash"

I just realized that I'm using the rhashtable as an "does this hash exist".
I could get the content of the item that matches the hash and compare it to
what was used to create the hash in the first place. If there's a reference
counter or some other identifier I could use to know that the passed in vma
is the same as what is in the hash table, I can use this to know if the
hash needs to be updated with the new information or not.

-- Steve

