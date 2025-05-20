Return-Path: <bpf+bounces-58535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14471ABD38A
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 11:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336F01B65F8C
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 09:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB73E267F5C;
	Tue, 20 May 2025 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYa2NsAu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2629B26280C;
	Tue, 20 May 2025 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733763; cv=none; b=cLl6TUcRz7rB15o3W4eih2KRfqCaIDLC7puQLXpu2aX15AtY33l6MzEBSebgf/SsQHrvu5woJMTLcACXW9VNaD0u2eYw5KPsdRnSZDBNLC9CKMG2SKFCnRUbuLJWegzGI3vJR4wg31eL3oXMbVU5+8qq1gjWdHmY00V0NoaUIHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733763; c=relaxed/simple;
	bh=JA8oTikPcbG+z/+pD4UM1hHcLKF4vcypC9SpfNfiEZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIX04ehS68YbemHhwXvFOwf/xyOZLTcvpLUu4APX5GFNlTgqQS3Lea78/5Ct6eKTlngIcNXVTVkvrTfSaor83Y0ERlawG5XeOE4HPLtvgsApa4z5HTzu7bvB3NWo7GIev6tr24JwK26wlUdLj+o7ex0YIQJn6SYd6oumCcYwrxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYa2NsAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D38C4CEEF;
	Tue, 20 May 2025 09:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747733762;
	bh=JA8oTikPcbG+z/+pD4UM1hHcLKF4vcypC9SpfNfiEZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NYa2NsAuTJKMTEnXvp2z7m60eNwk2h2CymStl5Mk14gYBcNxkLegYVsSyBf3h+yYR
	 b/hDmr6HVFNgWzuzBoax7yOayBXNdMiyCBgrd6zRGPO5SxFhS7uQH8DcHFpaGZvkE6
	 ht/dhxMfj5SSasUSYjw30LkKJcGgNjYOHTHwkbtH4t9WSGQotFuftPj+aen/pSEET1
	 rFRG4g0jYV1II/o5PDOTsldj6qx209eOQ6zofyeJfbUzdDYU2XWX1qJnxhBDyFRuc+
	 GZ+P56YdIRrbDXeRbRc0r+/gDDfMPLHBvWk2lSbLpJXMZQnOd40g3uDEB0vKT/NDWj
	 mX6V6aZQApGGA==
Date: Tue, 20 May 2025 11:35:56 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v9 00/13] unwind_user: x86: Deferred unwinding
 infrastructure
Message-ID: <aCxM_BizulyIVcdb@gmail.com>
References: <20250513223435.636200356@goodmis.org>
 <20250514132720.6b16880c@gandalf.local.home>
 <aCfMzJ-zN0JKKTjO@google.com>
 <20250519113339.027c2a68@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519113339.027c2a68@batman.local.home>


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 16 May 2025 16:39:56 -0700
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > Hi Steve,
> > 
> > On Wed, May 14, 2025 at 01:27:20PM -0400, Steven Rostedt wrote:
> > > On Tue, 13 May 2025 18:34:35 -0400
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > >   
> > > > This has modifications in x86 and I would like it to go through the x86
> > > > tree. Preferably it can go into this merge window so we can focus on getting
> > > > perf and ftrace to work on top of this.  
> > > 
> > > I think it may be best for me to remove the two x86 specific patches, and
> > > rebuild the ftrace work on top of it. For testing, I'll just keep those two
> > > patches in my tree locally, but then I can get this moving for this merge
> > > window.  
> > 
> > Maybe I asked this before but I don't remember if I got the answer. :)
> > How does it handle task exits as it won't go to userspace?  I guess it'll
> > lose user callstacks for exit syscalls and other termination paths.
> > 
> > Similarly, it will miss user callstacks in the samples at the end of
> > profiling if the target tasks remain in the kernel (or they sleep).
> > It looks like a fundamental limitation of the deferred callchains.
> > 
> 
> Ah, I think I forgot about that. I believe the exit path can also be a
> faultable path. All it needs is a hook to do the exit. Is there any
> "task work" clean up on exit? I need to take a look.

Could you please not rush this facility into v6.16? It barely had any 
design review so far, and I'm still not entirely sure about the 
approach.

Thanks,

	Ingo

