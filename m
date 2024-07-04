Return-Path: <bpf+bounces-33873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A029272C7
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 11:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A19BB2185C
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 09:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53E91A4F3D;
	Thu,  4 Jul 2024 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l+et9/WP"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC8616C6BA;
	Thu,  4 Jul 2024 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720084572; cv=none; b=iO759uGt4tmOA+jrOfBAEabZeoXe9lqIpOR0ALvE1qSus/xITEVd/Lk0Y1y/kVp6dog+MFPvNHFTs/XGNiwyKJiYijfROAwWZeDbtDujTA40hsr783hrLtOeUu3bbPrWg312yLRBGN/zz4Zi5hjTZXv/wW134URFdA5SkrzFkto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720084572; c=relaxed/simple;
	bh=ihatN4AJ5XqzTEMYL7tfSvzND3MrgRo5Gw/35iMssV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGmwf0gwbrqUXpfLcHxtMZVqYJQzI6FXI1F6fSqkFPnOmfW4gTaX/6ccKv6cwH7zmzIlLp31x2Dql4x93s9zunJx9Ej2oebgXQ5x/pSIaFxznc1kHjNxSRTZBa8u2YFAvg730SJJ1Q+pLKegjDARMQFo25+IxOafGv/Lt9fNDMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l+et9/WP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EqNsEuxV/l/0e6GLDEy/5SmhvWKF+eO2yu493ws1VK4=; b=l+et9/WPwX8ueU339iK1+KMyB0
	bOnduWl49NdtOeRDGEEuHiMYr54MZlCHKlWL1V0qNYny0oFYM1V3BVKzFjzOc4c34jGIEFIn2mCfE
	1SJpol6tX8dw9VnIBmEE3x/AKsNLsy+IUy58QHsYk91AZ/VfmSbPpIVVAuJDgqLfgaLYceJFSrCsX
	iRZ2cj3kFNMcXbMfdCQkW0B6Vgha88fzMuMrQ4zuMFl4EuTesbdhnKDWu1v6LPHfVEFXYbJOvP8rl
	+dEiK7KY+SUqIwPrvnupMvDwyor+qwCTeGZOVUDHRjUXmo7FvuuHLQ76dA6MXtj8hZV22rtxGjdtf
	Hv4rNWEw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPIZQ-00000002gs3-1fca;
	Thu, 04 Jul 2024 09:16:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D6A8C3003FF; Thu,  4 Jul 2024 11:15:59 +0200 (CEST)
Date: Thu, 4 Jul 2024 11:15:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, oleg@redhat.com,
	mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org, clm@meta.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/12] uprobes: add batched register/unregister APIs
 and per-CPU RW semaphore
Message-ID: <20240704091559.GS11386@noisy.programming.kicks-ass.net>
References: <20240701223935.3783951-1-andrii@kernel.org>
 <CAEf4BzaZhi+_MZ0M4Pz-1qmej6rrJeLO9x1+nR5QH9pnQXzwdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaZhi+_MZ0M4Pz-1qmej6rrJeLO9x1+nR5QH9pnQXzwdw@mail.gmail.com>

On Wed, Jul 03, 2024 at 02:33:06PM -0700, Andrii Nakryiko wrote:

> 2. More tactically, RCU protection seems like the best way forward. We
> got hung up on SRCU vs RCU Tasks Trace. Thanks to Paul, we also
> clarified that RCU Tasks Trace has nothing to do with Tasks Rude
> flavor (whatever that is, I have no idea).
> 
> Now, RCU Tasks Trace were specifically designed for least overhead
> hotpath (reader side) performance, at the expense of slowing down much
> rarer writers. My microbenchmarking does show at least 5% difference.
> Both flavors can handle sleepable uprobes waiting for page faults.
> Tasks Trace flavor is already used for tracing in the BPF realm,
> including for sleepable uprobes and works well. It's not going away.

I need to look into this new RCU flavour and why it exists -- for
example, why can't SRCU be improved to gain the same benefits. This is
what we've always done, improve SRCU.

> Now, you keep pushing for SRCU instead of RCU Tasks Trace, but I
> haven't seen a single argument why. Please provide that, or let's
> stick to RCU Tasks Trace, because uprobe's use case is an ideal case
> of what Tasks Trace flavor was designed for.

Because I actually know SRCU, and because it provides a local scope.
It isolates the unregister waiters from other random users. I'm not
going to use this funky new flavour until I truly understand it.

Also, we actually want two scopes here, there is no reason for the
consumer unreg to wait for the retprobe stuff.

> 3. Regardless of RCU flavor, due to RCU protection, we have to add
> batched register/unregister APIs, so we can amortize sync_rcu cost
> during deregistration. Can we please agree on that as well? This is
> the main goal of this patch set and I'd like to land it before working
> further on changing and improving the rest of the locking schema.

See my patch here:

  https://lkml.kernel.org/r/20240704084524.GC28838@noisy.programming.kicks-ass.net

I don't think it needs to be more complicated than that.

> I won't be happy about it, but just to move things forward, I can drop
> a) custom refcounting and/or b) percpu RW semaphore. Both are
> beneficial but not essential for batched APIs work. But if you force
> me to do that, please state clearly your reasons/arguments.

The reason I'm pushing RCU here is because AFAICT uprobes doesn't
actually need the stronger serialisation that rwlock (any flavour)
provide. It is a prime candidate for RCU, and I think you'll find plenty
papers / articles (by both Paul and others) that show that RCU scales
better.

As a bonus, you avoid that horrific write side cost that per-cpu rwsem
has.

The reason I'm not keen on that refcount thing was initially because I
did not understand the justification for it, but worse, once I did read
your justification, your very own numbers convinced me that the refcount
is fundamentally problematic, in any way shape or form.

> No one had yet pointed out why refcounting is broken 

Your very own numbers point out that refcounting is a problem here. 

> and why percpu RW semaphore is bad. 

Literature and history show us that RCU -- where possible -- is
always better than any reader-writer locking scheme.

> 4. Another tactical thing, but an important one. Refcounting schema
> for uprobes. I've replied already, but I think refcounting is
> unavoidable for uretprobes,

I think we can fix that, I replied here:

  https://lkml.kernel.org/r/20240704083152.GQ11386@noisy.programming.kicks-ass.net

> and current refcounting schema is
> problematic for batched APIs due to race between finding uprobe and
> there still being a possibility we'd need to undo all that and retry
> again.

Right, I've not looked too deeply at that, because I've not seen a
reason to actually change that. I can go think about it if you want, but
meh.

