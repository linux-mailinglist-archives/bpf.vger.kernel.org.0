Return-Path: <bpf+bounces-47677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD539FD776
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 20:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D3D1880655
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 19:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC281F8925;
	Fri, 27 Dec 2024 19:18:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8962B433D9;
	Fri, 27 Dec 2024 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735327103; cv=none; b=HnmceHchBJj8VnkC/IBtn66jUK/nQ4WFw4eD5oHCjfht3ByQEUOKclEcFhxeoeL2NP9oii8S0pjiL6XTGIYj5XHasyTY299k/OXGkrplcFU4s3DEPyk89qepoEqHn7bBrigzgXdGZ9bpoeuEd7BjSnTCFpIvZjiynD19EpdQbP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735327103; c=relaxed/simple;
	bh=MNC59m0llm1QZEZpGU6HmaiknNf/Ngd+RoAoSzDsUqI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhLpwAupfwi1rVtxKlJdlR6r+Wz1VJMJA7pOOfKoiMJWJojCvuN87+DJ7PRKBP2TtgHM1sZAnfXD3RxL6ejuxc2VXfLnCVRcWgoXMEP/1q+Sih4t0GIDF3Ze2ERcZn0FGcHEU83e6yCZGBSEFrHang17StQYU8YpbCpHWx3viXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5DFC4CED0;
	Fri, 27 Dec 2024 19:18:21 +0000 (UTC)
Date: Fri, 27 Dec 2024 14:19:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 linux-kbuild@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
 <peterz@infradead.org>, Masahiro Yamada <masahiroy@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Zheng
 Yejian <zhengyejian1@huawei.com>, Martin Kelly
 <martin.kelly@crowdstrike.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@redhat.com>, Mark
 Rutland <mark.rutland@arm.com>
Subject: Re: [POC][RFC][PATCH] build: Make weak functions visible in
 kallsyms
Message-ID: <20241227141922.56f44e82@gandalf.local.home>
In-Reply-To: <CAHk-=wgoORBJ6OkOA1g2MNHW4oEMRSkCbnyf7Ab+CL8pCQ0-ag@mail.gmail.com>
References: <20241226164957.5cab9f2d@gandalf.local.home>
	<CAHk-=wiL8B2=fPaRwDPGgQhVs=3G=8Gy=QyR59L85L0GF67Gbg@mail.gmail.com>
	<20241226224521.2d159a02@batman.local.home>
	<CAHk-=wgoORBJ6OkOA1g2MNHW4oEMRSkCbnyf7Ab+CL8pCQ0-ag@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Dec 2024 10:09:40 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 26 Dec 2024 at 19:45, Steven Rostedt <rostedt@goodmis.org> wrote:
> >  
> > >
> > > Btw, does this actually happen when the compiler does the mcount thing for us?  
> >
> > Yes.  
> 
> Ok, that's actually good.
> 
> I'm not really worried about the "unused symbols aren't in kallsyms"
> issue, even if it confuses the mcount logic. THAT confusion is easy to
> deal with by either adding symbol size information (which I think
> would be a good thing in general, although perhaps not worth it).
> 
> Even without the symbol size, the mcount issue can be dealt with by
> just knowing that the mcount location has to be at the very beginning
> of the function and just taking the offset - that we already do have -
> into account.

This is actually what we do today. A check is made against the location of
the fentry/mcount, and if it's too far away from the function entry, it is
considered a weak function. The distance is architecture dependent, as well
as options (adding ENDBR and such needs to be accounted for).

Now we still need to list them in the available_filter_functions, as the
order of what's in mcount_loc is used by the set_filter_function, and if we
"hide" any, it can screw up the accounting, because you can enable
functions via the index into that file. Using an index is an O(1)
operation, where as by name it needs to search all addresses and call
kallsyms for a name look up and then compare to what was passed in. Tooling
uses the index, as it's much faster to enable several functions (which by
name turns into an O(n^2) operation). Enabling a thousand functions by name
can take over a minute to complete, whereas by index takes less than a
second.

For now, we have in available_filter_functions:

  trace_initcall_finish_cb
  initcall_blacklisted
  do_one_initcall
  __ftrace_invalid_address___708
  rootfs_init_fs_context
  wait_for_initramfs
  __ftrace_invalid_address___68
  calibration_delay_done
  calibrate_delay

Where those "__ftrace_invalid_address_*" is detected as a weak function.
This is ugly and a hack, but we still need a place holder for them :-(
I would love to find a better way to handle this.

Now, the .mcount_loc is sorted at build time. If there's a way to find
which addresses are no longer visible, then that code could possibly remove
them from the mcount_loc. Perhaps, it could do a 'nm -S' and check to make
sure that all addresses are within a listed size, and if not, remove it.
That way, we could get rid of those place holders.

> 
> I was more worried that there might also be some much deeper confusion
> with the linker actually garbage collecting the unused weak function
> code away, and now an unused symbol that kallsyms doesn't know about
> wouldn't just have an unexpected mcount pointer to it, but the mcount
> pointer would actually be stale and point to some unrelated code.
> 
> So as long as *that* isn't what is happening, this all seems fairly benign.

For now, the mcount_loc is just an annoyance as we have those ugly place
holders. The real bug is with live kernel patching, where there's a
mismatch in the function size. IIUC, the building of the module for the
live patching finds the size of the function it's patching with 'nm'. And
then before patching, asks kallsyms for the size of the function. Because
kallsyms uses the next function to determine the size, it returns the size
of the function plus the size of the weak function. There's a mismatch and
live kernel patching refuses to patch the function.

By adding the actual size of the function to kallsyms, that would fix the
problem. The size doesn't need to be exported to /proc/kallsyms, as you
mentioned before, all users happen to be in-kernel.

The one downsize of storing the numbers, is that we will need to store a
size for every function, and that can add up.

 $ wc -l /proc/kallsyms 
 208784 /proc/kallsyms

That's 208 thousand numbers to store!

Perhaps this is the one advantage of having a weak placeholder in kallsyms
as well. It may save memory.

-- Steve


