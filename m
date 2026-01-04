Return-Path: <bpf+bounces-77785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 234A5CF0FF7
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 14:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 869A93009550
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 13:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AF230DEB0;
	Sun,  4 Jan 2026 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LF2/Qqmx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131B418C332;
	Sun,  4 Jan 2026 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767533661; cv=none; b=ouHwf04DBouQemNZ2+CbLWKr7rM0DdE54cWzHGiSSL7EafsIJcOfx+hcB7v/0ishVF7aKltD3fJmYW5DNfJjFbx1s8idkXCSykbbTK+l2LTNLVUSmF18AzcOrFrlQ1zdzyvYdJ//I4k4Pry784qvowJThwHoAbkmSXQBVl/kCrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767533661; c=relaxed/simple;
	bh=N0L6XvnNB1qvZL1c++Orzx2mTUa1KFODZzyzqoGfs/w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=It8sX0ragR82JNF7syhUCNfDH49DbkELeP6q6WB1gqy/1/q4BqxO7Ln/rD1QCwKV3rUPlqkLpd5YZ7SOyDPU7rVtZ3Xjp6mN5YPzwkETHM6Hrg2HR7tdrE29c3wSWsg5HXl9TKmU229bg9ICmYfVhrkHU8wsCyedSvY5pITeZac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LF2/Qqmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B715C4CEF7;
	Sun,  4 Jan 2026 13:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767533660;
	bh=N0L6XvnNB1qvZL1c++Orzx2mTUa1KFODZzyzqoGfs/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LF2/Qqmx7cycOOAoJ7Vc+ukOjTVc4eYgk0QIxW0/1mYoC4aMyCkVQJ4E9IpPCmYRx
	 KpOnbyfpoY/W4/1N6l5dtg/PAAkl8sqH+aP72FXIagGjxMgtUGv0YCS9RR/h//5YmK
	 E5UJ6Dgiy+K30aACPyjyScD4p6FtWcsmKV318iNzEB3auutal8izRdVwhuh823H7CT
	 IA+wi+6VSaYCbS6h879ioIClNilpLhg/dWqg67qwGEY5b9KVeUUI8jNgvHyWoer/E5
	 2LjcBlceRrdIf9Mk8quOZ/FjxBSQHxKbyMWR8rrKdZTWTC6kShMUDYr17iHMLUNslr
	 MEj9it+WYZc1g==
Date: Sun, 4 Jan 2026 22:34:15 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>, Will Deacon <will@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>,
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org, Yonghong Song
 <yhs@fb.com>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko
 <andrii@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mahe Tardy
 <mahe.tardy@gmail.com>
Subject: Re: [BUG/RFC 1/2] arm64/ftrace,bpf: Fix partial regs after
 bpf_prog_run
Message-Id: <20260104223415.0a31f423c861c0b651de966b@kernel.org>
In-Reply-To: <aVfbqYsWdGXu4lh8@willie-the-truck>
References: <20251105125924.365205-1-jolsa@kernel.org>
	<aVfbqYsWdGXu4lh8@willie-the-truck>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Jan 2026 14:52:25 +0000
Will Deacon <will@kernel.org> wrote:

> On Wed, Nov 05, 2025 at 01:59:23PM +0100, Jiri Olsa wrote:
> > hi,
> > Mahe reported issue with bpf_override_return helper not working
> > when executed from kprobe.multi bpf program on arm.
> > 
> > The problem seems to be that on arm we use alternate storage for
> > pt_regs object that is passed to bpf_prog_run and if any register
> > is changed (which is the case of bpf_override_return) it's not
> > propagated back to actual pt_regs object.
> > 
> > The change below seems to fix the issue, but I have no idea if
> > that's proper fix for arm, thoughts?
> > 
> > I'm attaching selftest to actually test bpf_override_return helper
> > functionality, because currently we only test that we are able to
> > attach a program with it, but not the override itself.
> > 
> > thanks,
> > jirka
> > 
> > 
> > ---
> >  arch/arm64/include/asm/ftrace.h | 11 +++++++++++
> >  include/linux/ftrace.h          |  3 +++
> >  kernel/trace/bpf_trace.c        |  1 +
> >  3 files changed, 15 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> > index ba7cf7fec5e9..ad6cf587885c 100644
> > --- a/arch/arm64/include/asm/ftrace.h
> > +++ b/arch/arm64/include/asm/ftrace.h
> > @@ -157,6 +157,17 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
> >  	return regs;
> >  }
> >  
> > +static __always_inline void
> > +ftrace_partial_regs_fix(const struct ftrace_regs *fregs, struct pt_regs *regs)
> > +{
> > +	struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
> > +
> > +	if (afregs->pc != regs->pc) {
> > +		afregs->pc = regs->pc;
> > +		afregs->regs[0] = regs->regs[0];
> > +	}
> > +}
> 
> This looks a bit grotty to me and presumably other architectures would
> need similar treatement. Wouldn't it be cleaner to reuse the existing
> API instead? For example, by calling ftrace_regs_set_instruction_pointer()
> and ftrace_regs_set_return_value() to update the relevant registers from
> the core code?

I agreed with using the generic APIs. Also, ftrace_partial_regs_fix() is
not self-explained. Maybe ftrace_regs_set_by_regs()?

Thank you,

> 
> Will


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

