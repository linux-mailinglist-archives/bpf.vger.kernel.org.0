Return-Path: <bpf+bounces-58488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EC2ABC288
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 17:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926F71893CA1
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 15:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA5F2857E4;
	Mon, 19 May 2025 15:33:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127C372639;
	Mon, 19 May 2025 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747668822; cv=none; b=IRzkvsCnCHULjKr0ZtWMuvw8FCIOExWgu2ZH1PTHZIOmRZrLYLuSWyn3jOT7JPnhJQAAnytEcJmY3Z3pJD+RlBatfKBXI3TGgPhF3ls1iCyqwKeNFRIqQlPDljU2AgVBvj/KLEKi1GEwTJYQMisGpBvvP/zicLkbn8EESzdQyZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747668822; c=relaxed/simple;
	bh=lrLr7Kc5pMqOCD87GeQi49MHcJwGpnQAiHPxBcWrvpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YH1rbicVUaAbLFnyQhoxs92TMCuIlCzo7VcZzBX0z/JUGAHv0746NoCRmYjVI/xt325h7hoGf2dSd5vdWHhDmoYGoqyAwRJjfW06wRQP9oyK77N2hhA4m97qdTMPvja4xeNuQxS7q0OsMb04H7H9qQUDsdWQO2yloBqvjfv6Quc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E39C4CEE4;
	Mon, 19 May 2025 15:33:40 +0000 (UTC)
Date: Mon, 19 May 2025 11:33:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v9 00/13] unwind_user: x86: Deferred unwinding
 infrastructure
Message-ID: <20250519113339.027c2a68@batman.local.home>
In-Reply-To: <aCfMzJ-zN0JKKTjO@google.com>
References: <20250513223435.636200356@goodmis.org>
	<20250514132720.6b16880c@gandalf.local.home>
	<aCfMzJ-zN0JKKTjO@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 May 2025 16:39:56 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> Hi Steve,
> 
> On Wed, May 14, 2025 at 01:27:20PM -0400, Steven Rostedt wrote:
> > On Tue, 13 May 2025 18:34:35 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> > > This has modifications in x86 and I would like it to go through the x86
> > > tree. Preferably it can go into this merge window so we can focus on getting
> > > perf and ftrace to work on top of this.  
> > 
> > I think it may be best for me to remove the two x86 specific patches, and
> > rebuild the ftrace work on top of it. For testing, I'll just keep those two
> > patches in my tree locally, but then I can get this moving for this merge
> > window.  
> 
> Maybe I asked this before but I don't remember if I got the answer. :)
> How does it handle task exits as it won't go to userspace?  I guess it'll
> lose user callstacks for exit syscalls and other termination paths.
> 
> Similarly, it will miss user callstacks in the samples at the end of
> profiling if the target tasks remain in the kernel (or they sleep).
> It looks like a fundamental limitation of the deferred callchains.
> 

Ah, I think I forgot about that. I believe the exit path can also be a
faultable path. All it needs is a hook to do the exit. Is there any
"task work" clean up on exit? I need to take a look.

-- Steve

