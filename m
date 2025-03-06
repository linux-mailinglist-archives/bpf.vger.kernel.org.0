Return-Path: <bpf+bounces-53468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C1BA5492B
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 12:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ED127A5313
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 11:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B4620ADE6;
	Thu,  6 Mar 2025 11:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiRmzsrT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221551FC7CC;
	Thu,  6 Mar 2025 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260158; cv=none; b=C3d2LoVtSJEPGF0FUrp1nfIU7BzoUsW2rH7na9x9o6bZTD4/w3hKIXHfkEKgYJ5xak92dIx3bhg7fhq/ca9LUB5Txm5vPhwFPW+lVv0JBkfSMKZJYZcyu/y6JpVR5f7+46Vega0yEj+Biemujhr7GeO5U6vKzd47qKPStHZC+K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260158; c=relaxed/simple;
	bh=A5vWqVVEhD1qhbiazA8Hzh5/5bAJFQ8kYAx13LBjVQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ty5/1ecHkB+1r1KRNN8pVVkmnklj8BmVlBO72X9v+SDkr0FliJ8vt+jSZV0Eu/6HN79Jfi5ObiGysKf7+LPogAmI4Nc1xHjy7mZ7eeH8epAXnAjubJJ+MUZ0f4MO+o0oNj6ndonMiqS0utRh9axr7EimzVfDIyVi8nK38W4X268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiRmzsrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A48C4CEE0;
	Thu,  6 Mar 2025 11:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741260157;
	bh=A5vWqVVEhD1qhbiazA8Hzh5/5bAJFQ8kYAx13LBjVQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fiRmzsrTc1BdjZep8qFZW3HTCkQ+1p+2ogJtnzDMnx4FuuqWH7hf5U5LYZw1YXlTD
	 Dch0S8f0ozH8E3LObpHBJwpyNzYGfhMQsU29ZwsFz9zn936g5ByiCMfYU6zr0nbQNd
	 yfcHMxjBkv4oQ2nNcakOsff08vTg6GhqrcnfoznnNEoc11XiWgkI4QrVZjsr6fmsLW
	 M6mPEAI92mf46iveTCYSXRkglQjYMeSvI5fqw87ko3lvgaiXICSPKzv+uK0a22hlO4
	 axJ+qkLGRT9IjmaEmDshFEBnkkA1B2LUoMDzdipw4gCjEchAF/PPBU3hWbldnEbusw
	 JowSONo9xkTMQ==
Date: Thu, 6 Mar 2025 12:22:30 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>, Kees Cook <kees@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>, stable@vger.kernel.org,
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, bpf@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Deepak Gupta <debug@rivosinc.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCHv3 perf/core] uprobes: Harden uretprobe syscall trampoline
 check
Message-ID: <Z8mFditQWBjxO2vn@gmail.com>
References: <20250212220433.3624297-1-jolsa@kernel.org>
 <CALCETrVFdAFVinbpPK+q7pSQHo3=JgGxZSPZVz-y7oaG=xP3fA@mail.gmail.com>
 <Z623ZcZj6Wsbnrhs@krava>
 <CALCETrVt=N-QG3zGyPspNCF=8tA4icC75RVVe70-DvJfsh7Sww@mail.gmail.com>
 <Z7MnB3yf2u9eR1yp@krava>
 <Z8l_ipCn8tBE1d9Q@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8l_ipCn8tBE1d9Q@krava>


* Jiri Olsa <olsajiri@gmail.com> wrote:

> On Mon, Feb 17, 2025 at 01:09:43PM +0100, Jiri Olsa wrote:
> > On Thu, Feb 13, 2025 at 09:58:29AM -0800, Andy Lutomirski wrote:
> > > On Thu, Feb 13, 2025 at 1:16 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > On Wed, Feb 12, 2025 at 05:37:11PM -0800, Andy Lutomirski wrote:
> > > > > On Wed, Feb 12, 2025 at 2:04 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > > > > >
> > > > > > Jann reported [1] possible issue when trampoline_check_ip returns
> > > > > > address near the bottom of the address space that is allowed to
> > > > > > call into the syscall if uretprobes are not set up.
> > > > > >
> > > > > > Though the mmap minimum address restrictions will typically prevent
> > > > > > creating mappings there, let's make sure uretprobe syscall checks
> > > > > > for that.
> > > > >
> > > > > It would be a layering violation, but we could perhaps do better here:
> > > > >
> > > > > > -       if (regs->ip != trampoline_check_ip())
> > > > > > +       /* Make sure the ip matches the only allowed sys_uretprobe caller. */
> > > > > > +       if (unlikely(regs->ip != trampoline_check_ip(tramp)))
> > > > > >                 goto sigill;
> > > > >
> > > > > Instead of SIGILL, perhaps this should do the seccomp action?  So the
> > > > > logic in seccomp would be (sketchily, with some real mode1 mess):
> > > > >
> > > > > if (is_a_real_uretprobe())
> > > > >     skip seccomp;
> > > >
> > > > IIUC you want to move the address check earlier to the seccomp path..
> > > > with the benefit that we would kill not allowed caller sooner?
> > > 
> > > The benefit would be that seccomp users that want to do something
> > > other than killing a process (returning an error code, getting
> > > notified, etc) could retain that functionality without the new
> > > automatic hole being poked for uretprobe() in cases where uprobes
> > > aren't in use or where the calling address doesn't match the uprobe
> > > trampoline.  IOW it would reduce the scope to which we're making
> > > seccomp behave unexpectedly.
> > 
> > Kees, any thoughts about this approach?
> 
> ping, any idea?

So in any case I think the seccomp QoL tie-in suggested by Andy should 
be done in a separate patch, and I've applied the -v3 patch to 
tip:perf/core as-is.

( I've added Alexei's Acked-by too, which as I've read the v2 thread's 
  discussion was a given as long as his ~0 suggestion was implemented,
  which you did. )

Thanks,

	Ingo

