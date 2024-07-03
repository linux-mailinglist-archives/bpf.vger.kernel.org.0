Return-Path: <bpf+bounces-33731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD32B9254F1
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 09:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430832829B9
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 07:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336551386D8;
	Wed,  3 Jul 2024 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pd+Nud4w"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E4A944E;
	Wed,  3 Jul 2024 07:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719993294; cv=none; b=vGVRwkq6QG1O3onVoNRumxn54YdIj46c0Q3TsXAJ2B7b9pFgaSsb0wudhsgugMd+H0KlImpbg2ubCiTdsGsPC42FKNSt/c2/up+bM7/wXFEVQ0V/094BsaQVA5llpdOMLMbIi4grqARuM0VgbuVlu1Rhguky/hG/N4KmSMkfqKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719993294; c=relaxed/simple;
	bh=vtE/NNoAZRdyDR7r3N+ZuXRuMoxw7RThxPjInKSm2k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHUC/z3QI28gLLVDsZzoegsPoXTBAkrBvUrl8CJdLtpILUL+kollsWc9vM2Ue5W/UVjZRqJAevDQfdgTamF6E+y36DIcjA6QExfAwA3pJHROaV+YHdNyk0XPU3RP5rAUUBSQRD70eJCQ1SEuPWx9a5fWJCiset4yntSBZEbxWPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pd+Nud4w; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T95oREdPztj0OUcXPuTTOjyptMYHlUv4BqXqqdFX70Q=; b=pd+Nud4wJQs2g5c1OkbqTV4KFg
	7tgtnvPjY2k6rytrgNwxouiFNBpxle+N687GfrgWHdoN22ufB5t9ejmXQ6/EphHz9Lg6iqysTOTdj
	ui93mE0cKFpy5g1WV3MCZ8DWKoPD3l/9rryu57HEV/RdF4mFT8vO7KY0tTJKux6/frk3QuBPxj35P
	AMDxbHdoa8bkkDnXNI5Y2LVA5SRnpMIe4BQNkoNhmajyxoLsEUU4FGdJ3SYG4/6L2fPfOKx9ITzEG
	zlEBqVvHw5qwpCHvtpNyBCzN2Q+8Z8ZA1Ox0I1zUI3pjn2Wuu+E+DLxtY01IazAfT1J2Rpk/TdwHg
	eemb0pZQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOulz-00000009wWD-0jhs;
	Wed, 03 Jul 2024 07:53:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 33DA33006B7; Wed,  3 Jul 2024 09:50:57 +0200 (CEST)
Date: Wed, 3 Jul 2024 09:50:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, oleg@redhat.com, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, clm@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] uprobes: add batched register/unregister APIs
 and per-CPU RW semaphore
Message-ID: <20240703075057.GK11386@noisy.programming.kicks-ass.net>
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240702102353.GG11386@noisy.programming.kicks-ass.net>
 <20240702115447.GA28838@noisy.programming.kicks-ass.net>
 <CAEf4BzaQUzQdba2=F2NoV7=Th98fxz2EN62QX2Ej92bazt1GAg@mail.gmail.com>
 <20240702191857.GJ11386@noisy.programming.kicks-ass.net>
 <fd1d8b71-2a42-4649-b7ba-1b2e88028a20@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd1d8b71-2a42-4649-b7ba-1b2e88028a20@paulmck-laptop>

On Tue, Jul 02, 2024 at 04:56:53PM -0700, Paul E. McKenney wrote:

> > Paul, isn't this the RCU flavour you created to deal with
> > !rcu_is_watching()? The flavour that never should have been created in
> > favour of just cleaning up the mess instead of making more.
> 
> My guess is that you are instead thinking of RCU Tasks Rude, which can
> be eliminated once all architectures get their entry/exit/deep-idle
> functions either inlined or marked noinstr.

Would it make sense to disable it for those architectures that have
already done this work?

> > > I will
> > > ultimately use it anyway to avoid uprobe taking unnecessary refcount
> > > and to protect uprobe->consumers iteration and uc->handler() calls,
> > > which could be sleepable, so would need rcu_read_lock_trace().
> > 
> > I don't think you need trace-rcu for that. SRCU would do nicely I think.
> 
> From a functional viewpoint, agreed.
> 
> However, in the past, the memory-barrier and array-indexing overhead
> of SRCU has made it a no-go for lightweight probes into fastpath code.
> And these cases were what motivated RCU Tasks Trace (as opposed to RCU
> Tasks Rude).

I'm thinking we're growing too many RCU flavours again :/ I suppose I'll
have to go read up on rcu/tasks.* and see what's what.

> The other rule for RCU Tasks Trace is that although readers are permitted
> to block, this blocking can be for no longer than a major page fault.
> If you need longer-term blocking, then you should instead use SRCU.

I think this would render it unsuitable for uprobes. The whole point of
having a sleepable handler is to be able to take faults.



