Return-Path: <bpf+bounces-67015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB2BB3C171
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 19:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E5AA2342C
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 17:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AD833A01C;
	Fri, 29 Aug 2025 17:02:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F1F3A1DB;
	Fri, 29 Aug 2025 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486952; cv=none; b=B9cPlYtWoX1ntnSDY+mc69yUWT3hvqn14Kjoy/UzkM/nfveYODDL7Dn8tbbP3RilqiAdLHwflGEgRkPYO/jlqwZLMMUdy01181n5zckgGmGoWZokZ6Xj8C6qOoC+WYo8QVPQPTp0BxudrMU9NzW0jHbXVHMuxxbxqGjkh7fs77U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486952; c=relaxed/simple;
	bh=AsYSDcCvGRYfnSv74ffyi7VKLJBKc9BzzYtyWyzxWZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghFUGvLkjYipTjfIy+bniZq8JNzkyYspSSKDgOVLcu7TVI1xFvfQ+nHRNLW0GiTLA6/NmaRCbkmgRhC38ybeTZM42qGlpN6S+A0Gd4w1kLPNBUHFRI9IBVjIDPjPI2UlcrHRNzb1AUjqx63OYGStnoUNMEMpPKkP76GlRsmG3/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id AA027160850;
	Fri, 29 Aug 2025 17:02:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 4D7D02000F;
	Fri, 29 Aug 2025 17:02:16 +0000 (UTC)
Date: Fri, 29 Aug 2025 13:02:39 -0400
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
Message-ID: <20250829130239.61e25379@gandalf.local.home>
In-Reply-To: <CAHk-=whbHyKvJ5VSvObfmGSSEukYhv5DZVhR3_-smu_1_b54mg@mail.gmail.com>
References: <20250828180300.591225320@kernel.org>
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
	<20250829123321.63c9f525@gandalf.local.home>
	<CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com>
	<CAHk-=whbHyKvJ5VSvObfmGSSEukYhv5DZVhR3_-smu_1_b54mg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: uh9qiu3ia5bgsp5icdgagfjbwxsqd5p3
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 4D7D02000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+9IovbtNRLJxfrsJ/GnO9v0te3ayW3eNU=
X-HE-Tag: 1756486936-50009
X-HE-Meta: U2FsdGVkX193s8aJ0xNbZih+i1YHm2l/z6jfuxgEnyr4Oi0TgmoqNXadxdqu8xLxkf17h+71/IXt+hPjuhBJ+CThS+6bMIrNytyahvkvNC93aOAA2xGc7EmlsmFnD0Th4Jmwcb62L4Ys58pDbdxof9fuwqg8nLyseF/xMnqXh5lnQWINicH77/UA7grRANVGboagTU2WjLfRLrT2VYK/3gdZbz6LocqTo1YbY4iLuFK9O60hFWOU3ZcanWG5r72gyU5YujnPmLWy+c17MqarmyS3AEGZiXzQtcKUxfY/kQnRjPjJ/R4gKDvQ854DJ5C4v0ln+iZfczAU+0IdhSgUgN0PLOdtsuuaGlsxTAhhni9al5LEiAbYis3hGnJRJuYK

On Fri, 29 Aug 2025 09:50:12 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 29 Aug 2025 at 09:42, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Just use the hash. Don't do anything to it. Don't mess with it.  
> 
> In fact, at actual stack trace time, don't even do the hashing. Just
> save the raw pointer value (but as a *value*, not as a pointer: we
> absolutely do *not* want people to think that the random value can be
> used as a 'struct file' *: it needs to be a plain unsigned long, not
> some kernel pointer).
> 
> Then the hashing can happen when you expose those entries to user
> space (in the "print" stage). At that point you can do that
> 
>        hash = siphash_1u64(value, secret);
> 
> thing.
> 
> That will likely help I$ and D$ too, since you won't be accessing the
> secret hashing data randomly, but do it only at trace output time
> (presumably in a fairly tight loop at that point).

Note, the ring buffer can be mapped to user space. So anything written into
the buffer is already exposed. The "at trace output time" is done by user
space, not the kernel (except when using "trace" and "trace_pipe" files).

-- Steve

