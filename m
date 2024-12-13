Return-Path: <bpf+bounces-46882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D7A9F1514
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 19:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F636188C76C
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 18:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBB11E8826;
	Fri, 13 Dec 2024 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c/UPhDQS"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE3D1DA5F;
	Fri, 13 Dec 2024 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115206; cv=none; b=rNLddm1ZIF6xp6057eQ0901ISbElgNcHATI34ULchXNHoaWjzBNPHFTX5mRt2nn13Yh4kig7yIMfQuU6pimBdcDgCbby+DA5545bL0RgXoCBS33h8KD+qBTLBtb/+7292NWFj0bNaqGajz7GeacBhLSpr1uqmX8wn6v/SzuCW8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115206; c=relaxed/simple;
	bh=xMNsAPFvZuA+NrJu83NQGrP2O8/ufm+BzVZ+3vFgscM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Au0MQmBXDkzTTYT0WdxnXtMyYoa/nKJDFDMbndkhjPzlFFtg3nRrmTwand12/p+KhX4kWJNPwViPxlAYwYna0jw/hQw7nNe+U/w3/M9HVcYEVB6F0epKhoTUDhfWh9RQG8V/tLnAfHVCXSTvHaqEoS6rnxiVXLCmQd39WWVY4ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c/UPhDQS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eN/bpRlJXvU90UpuFFSXEIh3EXCbcD08E2hHzMuc9qQ=; b=c/UPhDQS1aoQ6mVjzuP9w3rKZR
	3xC6b4tRSP/TapmbKPbCewvDTNeX0jjRu84FHZSmkLiYXSu4578F5Kb+xE/t/m4qOyc1v8Tjpv5NP
	5RbdscgGRMNe+phbGTcJ5fRaJWJax1e3bHIIGKt6LYwD1Yo9AXBTME3usYeIqSjKsGHP3N3wx0wih
	Jpz+giszGsb7C/93KW9qbTkZesz979hwff+x+lf3wrG/ZT0/yoq4yoGX3/YaubW6U92kvVqz71MYD
	7u0FDPKdEI9F46sI1mpM2I77L8ONZ6LDWun0d1wbqb03VASVTbbJWwF2aUr1olJYfWDgvWQk4C0ZA
	BFdlmgIg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tMAZx-0000000Ezhy-1nr2;
	Fri, 13 Dec 2024 18:39:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D03EB30049D; Fri, 13 Dec 2024 19:39:54 +0100 (CET)
Date: Fri, 13 Dec 2024 19:39:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 00/13] uprobes: Add support to optimize usdt
 probes on x86_64
Message-ID: <20241213183954.GC12338@noisy.programming.kicks-ass.net>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241213105105.GB35539@noisy.programming.kicks-ass.net>
 <Z1wxqhwHbDbA2UHc@krava>
 <20241213135433.GD35539@noisy.programming.kicks-ass.net>
 <Z1w_Qi_Wya56YDO_@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1w_Qi_Wya56YDO_@krava>

On Fri, Dec 13, 2024 at 03:05:54PM +0100, Jiri Olsa wrote:
> On Fri, Dec 13, 2024 at 02:54:33PM +0100, Peter Zijlstra wrote:
> > On Fri, Dec 13, 2024 at 02:07:54PM +0100, Jiri Olsa wrote:
> > > On Fri, Dec 13, 2024 at 11:51:05AM +0100, Peter Zijlstra wrote:
> > > > On Wed, Dec 11, 2024 at 02:33:49PM +0100, Jiri Olsa wrote:
> > > > > hi,
> > > > > this patchset adds support to optimize usdt probes on top of 5-byte
> > > > > nop instruction.
> > > > > 
> > > > > The generic approach (optimize all uprobes) is hard due to emulating
> > > > > possible multiple original instructions and its related issues. The
> > > > > usdt case, which stores 5-byte nop seems much easier, so starting
> > > > > with that.
> > > > > 
> > > > > The basic idea is to replace breakpoint exception with syscall which
> > > > > is faster on x86_64. For more details please see changelog of patch 8.
> > > > 
> > > > So ideally we'd put a check in the syscall, which verifies it comes from
> > > > one of our trampolines and reject any and all other usage.
> > > > 
> > > > The reason to do this is that we can then delete all this code the
> > > > moment it becomes irrelevant without having to worry userspace might be
> > > > 'creative' somewhere.
> > > 
> > > yes, we do that already in SYSCALL_DEFINE0(uprobe):
> > > 
> > >         /* Allow execution only from uprobe trampolines. */
> > >         vma = vma_lookup(current->mm, regs->ip);
> > >         if (!vma || vma->vm_private_data != (void *) &tramp_mapping) {
> > >                 force_sig(SIGILL);
> > >                 return -1;
> > >         }
> > 
> > Ah, right I missed that. Doesn't that need more locking through? The
> > moment vma_lookup() returns that vma can go bad.
> 
> ugh yes.. I guess mmap_read_lock(current->mm) should do, will check

If you check
tip/perf/core:kernel/events/uprobe.c:find_active_uprobe_speculative()
you'll find means of doing it locklessly using RCU.

