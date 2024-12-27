Return-Path: <bpf+bounces-47646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6324C9FCF98
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 03:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B82163A64
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 02:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F388C35944;
	Fri, 27 Dec 2024 02:19:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD4B1FB3;
	Fri, 27 Dec 2024 02:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735265979; cv=none; b=ks/TkSf1dZooKtcwIQ7riWULvjqIDrznGRijYrINsuM6CGUeyqKqw0k+YAbdf/Opi0BR4sYbp07aM9NK4ypK+rIC/f7mBMWf99uR7lOUl9hUN42tW5Cu0HUbHYl6ztJzJqkC+sZWz0fZGcLZ7U7y1FZNuS/lYGt+PObqCYsnMMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735265979; c=relaxed/simple;
	bh=imNOJJS3npxrdjdZNZPydQET7iUEAWqyOwtg9L36I7g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXIjXSA8eBZUwivUEtbKTT2XKui/t3+TqqgApgEwqczvMmWwWpy33lqP7o+9udD0XXgNAMn+uE9KeozRjfsNGycajS7OfRoAk7xK/F78Ctu+eJzPV3MWAqE3Q5dS7H1BjZXJC1bQ5TMBVcSLh6P/YCz8VGmaG+3AnNNhW2GBctg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B28C4CED1;
	Fri, 27 Dec 2024 02:19:36 +0000 (UTC)
Date: Thu, 26 Dec 2024 21:19:35 -0500
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
Message-ID: <20241226211935.02d34076@batman.local.home>
In-Reply-To: <CAHk-=wgTFSqiMvbGYqFLQaERoeXR5nK1Y=-L3SN7rB3UtzG0PQ@mail.gmail.com>
References: <20241226164957.5cab9f2d@gandalf.local.home>
	<CAHk-=wgTFSqiMvbGYqFLQaERoeXR5nK1Y=-L3SN7rB3UtzG0PQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Dec 2024 15:01:07 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 26 Dec 2024 at 13:49, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > But then, when the linker removes these functions because they were
> > overridden, the code does not disappear, leaving the pointers in the
> > __mcount_loc locations.  
> 
> This seems entirely unrelated to weak functions, and will be true for
> any other "linker removed it" (which can happen for other reasons
> too).
> 
> So your "fix" seems to be hacking around a symptom.

Yeah, that's why this was just a POC.

> 
> And honestly, the kallsyms argument seems bogus too. The problem with
> kallsyms is that it looks up the size the wrong way. Making up new
> function names doesn't fix the problem, it - once again - just hacks
> around the symptom of doing something wrong.
> 
> Christ, kallsyms looking at nm output and going by "next symbol" was
> always bogus, but I think that's how the old a.out format worked
> originally.
> 
> But "nm" literally takes a "-S" argument. We just don't use it.
> 
> So I think the fix is literally to just make kallsysms have the size
> data. Of course, very annoyingly out /proc/kallsyms file format also
> tracks the (legacy) nm output that doesn't have size information.
> 
> But I do think that if you hit real problems, you need to fix the
> *source* of the issue, not add another ugly hack around things.

So basically the real solution is to fix kallsyms to know about the end
of functions. Peter Zijlstra mentioned that before, but it would take a
bit more work and understanding of kallsyms to fix it properly.

I'm fine not doing the hack and hopefully one day someone will have the
time to fix kallsyms. This was just something I could do quickly,
knowing it is mostly keeping with the status quo and not actually
fixing the root of the issue. I also needed to refresh my ELF parsing
abilities ;-)

I may take a look at kallsyms internals. I have some spare time before
the new year to try and work on things I don't normally get time to
work on.

-- Steve

