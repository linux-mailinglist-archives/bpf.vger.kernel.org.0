Return-Path: <bpf+bounces-67052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABB5B3C69E
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 02:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85EE71BA22BC
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 00:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23401D6195;
	Sat, 30 Aug 2025 00:44:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9F21CCEE0;
	Sat, 30 Aug 2025 00:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514686; cv=none; b=mxHUh5Xl7udFK3Mlbj9+Cn1AYAp0JOqBD70yEHDKLNkpHJ/8bI4wXCHcLW+72JQRAFclI2DhvhedRgYO21eJo1W6kqAt8/k2Ng1sDDvZ3sxFI0OA7dS6Fb6Yl0FN7ByApz0k8mTP5otKcy/cvxjwqLXeyJXoCzrrXRRgX4YGY1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514686; c=relaxed/simple;
	bh=lpddepxRjNM+Jah/wSuL8Sm09Ygknht0LVd4mig4g00=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D936rZcGRsThjFm8UPAmLy+yjKfCKIXns9yT+F50+39/33F8irzCy9X9vUpknnUgsLRjQLDstV8nju9l7LZTbyJF5+EB34BSHpeFqrk42YBusgGr6xLQbf2ZGbYMIlQHf9pPu3JISFWhnr7ebGA7y3OOHWWYVzXeP24XldLblRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 5C23D119E52;
	Sat, 30 Aug 2025 00:44:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 37BE92002E;
	Sat, 30 Aug 2025 00:44:36 +0000 (UTC)
Date: Fri, 29 Aug 2025 20:44:59 -0400
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
Message-ID: <20250829204459.6ea62c31@gandalf.local.home>
In-Reply-To: <20250829190935.7e014820@gandalf.local.home>
References: <20250828180300.591225320@kernel.org>
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
	<20250829190935.7e014820@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 37BE92002E
X-Stat-Signature: cc5jdic8b9uokx7zbzn5hunotaxqir71
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19pl6C6Kqnejk8tIUdrvZf4zNQEFz+Ax6w=
X-HE-Tag: 1756514676-477073
X-HE-Meta: U2FsdGVkX18PN91WHs6dIsuh4/qRVy2Jy4rubtURT4o6fCFBr/KthGOlbftdPYGY9SqWoP5If/oQP92D/X9khPPlkPyLJr/8YLUmeKu2/wr83Rwms6cO3eagEfCtNS8uLL609Zl1nT6lZTclhIxJCTtgdQpawXkNbow0/2MHZC83UeeTZ9j0GJhMxIO+C6WEKobAh7+U1nsUzCinUCeH1jz7VyUPLJ2vHhCH4GQPs3FvogZQXliqKejYUAUqsnZpgV9Jy+vv5B+jmQ5ynA1dqRWrSqps393ly1L7wsQvOMy51X97hARmEBudxmLnN+FePPw91D1e1gKj7R4bN6mp+M13Noi8DvrX42YrVqPS0tYZ2EuUMnuGjEGM4+2cdKCB6JJUV13UPJiG6e+kup4xDm7ICGBBRb0I

On Fri, 29 Aug 2025 19:09:35 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Yeah, we could add an optimization to store vma's in the callchain walk to
> see if the next call chain belongs to a previous one. Could even just cache
> the previous vma, as it's not as common to have one library calling into
> another and back again.

Although, it does happen with libc. :-p

cookie=300000004
 =>  <000000000008f687> : 0x666220af
 =>  <0000000000014560> : 0x88512fee
 =>  <000000000001f94a> : 0x88512fee
 =>  <000000000001fc9e> : 0x88512fee
 =>  <000000000001fcfa> : 0x88512fee
 =>  <000000000000ebae> : 0x88512fee
 =>  <0000000000029ca8> : 0x666220af

The 0x666220af is libc, where the first item is (according to objdump):

000000000008f570 <__libc_alloca_cutoff@@GLIBC_PRIVATE>:

And the last one (top of the stack) is:

0000000000029c20 <__libc_init_first@@GLIBC_2.2.5>:

Of course libc starts the application, and then the application will likely
call back into libc. We could optimize for this case with:

  first_vma = NULL;
  vma = NULL;
  foreach addr in callchain
    if (!first_vma)
      vma = first_vma = vma_alloc()
    else if (addr in range of first_vma)
      vma = first_vma
    else (addr not in range of vma)
      vma = vma_lookup(addr);

-- Steve

