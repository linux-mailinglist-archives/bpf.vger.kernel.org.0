Return-Path: <bpf+bounces-64706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE31B16208
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 15:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE641885813
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 13:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196E22D8763;
	Wed, 30 Jul 2025 13:56:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADBB29A9D3;
	Wed, 30 Jul 2025 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883800; cv=none; b=UNc5O419biy1y/6RCWn53xYJAuDMRqIQLDseXUqsQaPrT5XQm/R1HyWlUsmWTK2DBW0Id6MSh86ZvQw9L8WsY6zCpGaSFwltv++tUI+8mmCq6SZucM4GaUuW36ECZwTClCUSW+0nRQ6DetXgLeZqW4oUa8qnRti40cQDAaQ7HTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883800; c=relaxed/simple;
	bh=eOMWDKHUmy1gD0Z7poNwDp33IXetjz2L4RUzoqiHY7I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gu9lMPd4Z+IEHCKygHZdTC6vZ/ymtQ65q6Q3EoYxOg5sJl82gQrqrQzJN9XiJRCTG1D0/msnRdiCe8s1sRc5r9UT+lLynGgJXyPG8YETjrrxIEYBxzwJv0K5nwzaMAy//ZvlfP2OyEw2em1xokwH9reI0xmG4E7VWL2U3wZQxpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 5A0C41DA394;
	Wed, 30 Jul 2025 13:56:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id B003A6000C;
	Wed, 30 Jul 2025 13:56:25 +0000 (UTC)
Date: Wed, 30 Jul 2025 09:56:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Steven Rostedt
 <rostedt@kernel.org>, Florent Revest <revest@google.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Menglong Dong
 <menglong8.dong@gmail.com>, Naveen N Rao <naveen@kernel.org>, Michael
 Ellerman <mpe@ellerman.id.au>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Andy Chiu <andybnac@gmail.com>, Alexandre Ghiti
 <alexghiti@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [RFC 00/10] ftrace,bpf: Use single direct ops for bpf
 trampolines
Message-ID: <20250730095641.660800b1@gandalf.local.home>
In-Reply-To: <aIn_12KHz7ikF2t1@krava>
References: <20250729102813.1531457-1-jolsa@kernel.org>
	<aIkLlB7Z7V--BeGi@J2N7QTR9R3.cambridge.arm.com>
	<aIn_12KHz7ikF2t1@krava>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B003A6000C
X-Stat-Signature: 7a4jg1qcadtiqm5ucfmr9eog7prsws1c
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+GT+298XNw3sUtH/KUCJiMoJtrK0AAras=
X-HE-Tag: 1753883785-400689
X-HE-Meta: U2FsdGVkX18Y/wSr2PULlU+lJxRhXXAG/s/Ujl4zZXjBJpuMO1KJcwBl6CXFVM4KjGtjbyoRKGWOanlXAYGH35krn+qg641/t3dLIKJfubRLoHassBCAHH6NHSYjV/xU5DlgyPLzrruf7cTfAVQU9yhZdLOm/GBzFYd+mN3oTIa+0e7LTcEeMguNJfkLqAD2pGsjrgYJ3s851UwStnvdSsq4aYxwsejKlXtgRJJeRLAs7eeWOr/Tg2BKayY4NyeqP1CBq5OgEApEpQE0HhY/LrzaUzbgxIIpBzuhqDSUWNpJUT/neq02SIPkdVnRkvuWsVLeU+OMwlHlphB1TE8cvDSNbsG80ko4

On Wed, 30 Jul 2025 13:19:51 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> so it's all work on PoC stage, the idea is to be able to attach many
> (like 20,30,40k) functions to their trampolines quickly, which at the
> moment is slow because all the involved interfaces work with just single
> function/tracempoline relation

Sounds like you are reinventing the ftrace mechanism itself. Which I warned
against when I first introduced direct trampolines, which were purposely
designed to do a few functions, not thousands. But, oh well.


> Steven, please correct me if/when I'm wrong ;-)
> 
> IIUC in x86_64, IF there's just single ftrace_ops defined for the function,
> it will bypass ftrace trampoline and call directly the direct trampoline
> for the function, like:
> 
>    <foo>:
>      call direct_trampoline
>      ...

Yes.

And it will also do the same for normal ftrace functions. If you have:

struct ftrace_ops {
	.func = myfunc;
};

It will create a trampoline that has:

      <tramp>
	...
	call myfunc
	...
	ret

On x86, I believe the ftrace_ops for myfunc is added to the trampoline,
where as in arm, it's part of the function header. To modify it, it
requires converting to the list operation (which ignores the ops
parameter), then the ops at the function gets changed before it goes to the
new function.

And if it is the only ops attached to a function foo, the function foo
would have:

      <foo>
	call tramp
	...

But what's nice about this is that if you have 12 different ftrace_ops that
each attach to a 1000 different functions, but no two ftrace_ops attach to
the same function, they all do the above. No hash needed!

> 
> IF there are other ftrace_ops 'users' on the same function, we execute
> each of them like:
> 
>   <foo>:
>     call ftrace_trampoline
>       call ftrace_ops_1->func
>       call ftrace_ops_2->func
>       ...
> 
> with our direct ftrace_ops->func currently using ftrace_ops->direct_call
> to return direct trampoline for the function:
> 
> 	-static void call_direct_funcs(unsigned long ip, unsigned long pip,
> 	-                             struct ftrace_ops *ops, struct ftrace_regs *fregs)
> 	-{
> 	-       unsigned long addr = READ_ONCE(ops->direct_call);
> 	-
> 	-       if (!addr)
> 	-               return;
> 	-
> 	-       arch_ftrace_set_direct_caller(fregs, addr);
> 	-}
> 
> in the new changes it will do hash lookup (based on ip) for the direct
> trampoline we want to execute:
> 
> 	+static void call_direct_funcs_hash(unsigned long ip, unsigned long pip,
> 	+                                  struct ftrace_ops *ops, struct ftrace_regs *fregs)
> 	+{
> 	+       unsigned long addr;
> 	+
> 	+       addr = ftrace_find_rec_direct(ip);
> 	+       if (!addr)
> 	+               return;
> 	+
> 	+       arch_ftrace_set_direct_caller(fregs, addr);
> 	+}

I think the above will work.

> 
> still this is the slow path for the case where multiple ftrace_ops objects use
> same function.. for the fast path we have the direct attachment as described above
> 
> sorry I probably forgot/missed discussion on this, but doing the fast path like in
> x86_64 is not an option in arm, right?

That's a question for Mark, right?

-- Steve

