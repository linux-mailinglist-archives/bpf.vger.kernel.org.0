Return-Path: <bpf+bounces-65114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC26BB1C41C
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 12:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C78E3BDECF
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 10:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD07B28A738;
	Wed,  6 Aug 2025 10:20:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916BE1922C0;
	Wed,  6 Aug 2025 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754475619; cv=none; b=OriULYYK4vDFCB9VKH9LoUmN60IFA8xvkDGiRvYix+7b1rsIvtPZUy4McDx/KGjES39cH/4d9dN148Yz3ve3OoiwiB9st7xFHbJi75NFyVm/9FU4Af+7+0PdvwShnF5WOplecjTrmftJNLrZdIgRL+q5egILC4J3zuNd5kB4ZCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754475619; c=relaxed/simple;
	bh=COvGXp7LtjUshMDg0yELE6cQAN8nXPTRktokIYkICsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5ZKHf4DjDqeLzfdg+8W1CoIG7DyPTymTxm1aKGcuNlhDSLuotGWABS/UEdQyEYmOsqV/+XHQf+Y4N1wGo33JbzupgT46JndKOhXJxRT3Y9G9mU3L2J9Ld+xMV/g0g9UEUheyHY/1YIEk3z3R88w6BroseZar6PsETeyQwik7Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE8981E8D;
	Wed,  6 Aug 2025 03:20:08 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 115603F738;
	Wed,  6 Aug 2025 03:20:13 -0700 (PDT)
Date: Wed, 6 Aug 2025 11:20:08 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@kernel.org>, Florent Revest <revest@google.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [RFC 00/10] ftrace,bpf: Use single direct ops for bpf trampolines
Message-ID: <aJMsWB2Sxb7-66zs@J2N7QTR9R3>
References: <aIn_12KHz7ikF2t1@krava>
 <aIyNOd18TRLu8EpY@J2N7QTR9R3>
 <aI6CltnCRbVXwyfm@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aI6CltnCRbVXwyfm@krava>

On Sat, Aug 02, 2025 at 11:26:46PM +0200, Jiri Olsa wrote:
> On Fri, Aug 01, 2025 at 10:49:56AM +0100, Mark Rutland wrote:
> > On Wed, Jul 30, 2025 at 01:19:51PM +0200, Jiri Olsa wrote:
> > > On Tue, Jul 29, 2025 at 06:57:40PM +0100, Mark Rutland wrote:
> > > > 
> > > > On Tue, Jul 29, 2025 at 12:28:03PM +0200, Jiri Olsa wrote:
> > > > > hi,
> > > > > while poking the multi-tracing interface I ended up with just one
> > > > > ftrace_ops object to attach all trampolines.
> > > > > 
> > > > > This change allows to use less direct API calls during the attachment
> > > > > changes in the future code, so in effect speeding up the attachment.
> > > > 
> > > > How important is that, and what sort of speedup does this result in? I
> > > > ask due to potential performance hits noted below, and I'm lacking
> > > > context as to why we want to do this in the first place -- what is this
> > > > intended to enable/improve?
> > > 
> > > so it's all work on PoC stage, the idea is to be able to attach many
> > > (like 20,30,40k) functions to their trampolines quickly, which at the
> > > moment is slow because all the involved interfaces work with just single
> > > function/tracempoline relation
> > 
> > Do you know which aspect of that is slow? e.g. is that becuase you have
> > to update each ftrace_ops independently, and pay the synchronization
> > overhead per-ops?
> > 
> > I ask because it might be possible to do some more batching there, at
> > least for architectures like arm64 that use the CALL_OPS approach.
> 
> IIRC it's the rcu sync in register_ftrace_direct and ftrace_shutdown
> I'll try to profile that case again, there  might have been changes
> since the last time we did that

Do you mean synchronize_rcu_tasks()?

The call in register_ftrace_direct() was removed in commit:

  33f137143e651321 ("ftrace: Use asynchronous grace period for register_ftrace_direct()")

... but in ftrace_shutdown() we still have a call to synchronize_rcu_tasks(),
and to synchronize_rcu_tasks_rude().

The call to synchronize_rcu_tasks() is still necessary, but we might be
abel to batch that better with API changes.

I think we might be able to remove the call to
synchronize_rcu_tasks_rude() on architectures with ARCH_WANTS_NO_INSTR,
since there shouldn't be any instrumentable functions called with RCU
not watching. That'd need to be checked.

[...]

> > > sorry I probably forgot/missed discussion on this, but doing the fast path like in
> > > x86_64 is not an option in arm, right?
> > 
> > On arm64 we have a fast path, BUT branch range limitations means that we
> > cannot always branch directly from the instrumented function to the
> > direct func with a single branch instruction. We use ops->direct_call to
> > handle that case within a common trampoline, which is significantly
> > cheaper that iterating over the ops and/or looking up the direct func
> > from a hash.
> > 
> > With CALL_OPS, we place a pointer to the ops immediately before the
> > instrumented function, and have the instrumented function branch to a
> > common trampoline which can load that pointer (and can then branch to
> > any direct func as necessary).
> > 
> > The instrumented function looks like:
> > 
> > 	# Aligned to 8 bytes
> > 	func - 8:
> > 		< pointer to ops >
> 
> stupid question.. so there's ftrace_ops pointer stored for each function at
> 'func - 8` ?  why not store the func's direct trampoline address in there?

Once reason is that today we don't have trampolines for all ops. Since
branch range limitations can require bouncing through the common ops,
it's simpler/better to bounce from that to the regular call than to
bounce from that to a trampoline which makes the regular call.

We *could* consider adding trampolines, but that comes with a jump in
complexity that we originally tried to avoid, and a potential
performance hit for regular ftrace calls. IIUC that will require similar
synchronization to what we have today, so it's not clearly a win
generally.

I'd like to better understand what the real bottleneck is; AFAICT it's
the tasks-rcu synchronization, and sharing the hash means that you only
need to do that once. I think that it should be possible to share that
synchronization across multiple ops updates with some API changes (e.g.
something like the batching of text_poke on x86).

If we can do that, it might benefit other users too (e.g.
live-patching), even if trampolines aren't being used, and would keep
the arch bits simple/maintainable.

[...]

> thanks for all the details, I'll check if both the new change and ops->direct_call
> could live together for x86 and other arch, but it will probably complicate
> things a lot more

Thanks; please let me know if there's any challenges there!

Mark.

