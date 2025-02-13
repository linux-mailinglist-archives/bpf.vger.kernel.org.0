Return-Path: <bpf+bounces-51392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36829A33BD7
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 11:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2333A30B7
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 09:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA944211494;
	Thu, 13 Feb 2025 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WPw+oqHN"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC77211292;
	Thu, 13 Feb 2025 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440769; cv=none; b=ZwK3Yzx1B2SWD8Nm/qv3klAQAJBT7AQQG0Rqbe/OQMAG0alRV2JWO3RyvCMNo5qtLqYO/2IKOdqQru5i+BkgSFouqbNC985GMlRk2C0Syi2hpMqxfpKiM/nNeBnqY+x50tSPSd2QyQggWpMx7iFXVAcnUbgGfUy2qAtXVqXtyuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440769; c=relaxed/simple;
	bh=80ywDfww+kmELyRiFn0bexIaEho8JtvhUo8i8AyBu3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfAtTBZtW5rV04M4NGsFSBM7q6XYSlYjkdw80YDDsbI4kMimZagAJ2ps3ZLvRhWuGk706HGkLIhOff1zV5WuaCICRd+YRzNyorN8FcXVQdPCjZt13cubJFSeWW2rZBkWQNcJ3cAQ5q6wx7lKsn4TVr2iLdP3GUavbb3BdAIAqrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WPw+oqHN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pJc3YrbSrZjb+1WUbDYoQQxBsow526Z2Yq1LAQIerb4=; b=WPw+oqHNIzSpQadkIEozzuYPCc
	QD+mVmk1T0MZVKzQvFvpAyjOg5GDQgMLWKWtdccpnC1bjnNtDQhUBlhUPK6PLYgFf5h/MJE+3Q/rN
	oT7aUhrYy6jKadGcY4/mVAtseuFTfUG+b+VBL3V8IM2jqJBow6WoTA/Z48M/5Zsiq8w13GONkf23b
	1CdwiX6+AZd/lmYib1M8wVMwgzVSK/CsZ7xg2ojI0XO/aSq/W6t1vbYPWm0LeHnMegImCBPK2Jxkg
	kTopfL/r/vHQQ/fw/VbdzFDH9Prp+iUV6+fwdU2ObBrtzZBqzhC8o/11V9usdg1M0Am5aSWwbbtaT
	K7W0k1DA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tiW07-00000000xD3-0Ago;
	Thu, 13 Feb 2025 09:59:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9D39A3002E5; Thu, 13 Feb 2025 10:59:18 +0100 (CET)
Date: Thu, 13 Feb 2025 10:59:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2 00/26] Resilient Queued Spin Lock
Message-ID: <20250213095918.GB28068@noisy.programming.kicks-ass.net>
References: <20250206105435.2159977-1-memxor@gmail.com>
 <20250210093840.GE10324@noisy.programming.kicks-ass.net>
 <20250210104931.GE31462@noisy.programming.kicks-ass.net>
 <CAADnVQ+3wu0WB2pXs4cccxfkbTb3TK8Z+act5egytiON+qN9tA@mail.gmail.com>
 <20250211104352.GC29593@noisy.programming.kicks-ass.net>
 <CAADnVQJ=81PE19JWeNjq6aNOy+GM-wo6n7WU9StX1b6kevqCUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJ=81PE19JWeNjq6aNOy+GM-wo6n7WU9StX1b6kevqCUw@mail.gmail.com>

On Tue, Feb 11, 2025 at 10:33:00AM -0800, Alexei Starovoitov wrote:

> Ohh. No unpriv here.
> Since spectre was discovered unpriv bpf died.
> BPF_UNPRIV_DEFAULT_OFF=y was the default for distros and
> all hyperscalers for quite some time.

Ah, okay. Time to remove the option then?

> > So much details not clear to me and not explained either :/
> 
> Yes. The plan is to "kill" bpf prog when it misbehaves.
> But this is orthogonal to this res_spin_lock set which is
> a building block.
> 
> > Right, but it might have already modified things, how are you going to
> > recover from that?
> 
> Tracking resources acquisition and release by the bpf prog
> is a normal verifier job.
> When bpf prog does bpf_rcu_read_lock() the verifier makes sure
> that all execution paths from there on have bpf_rcu_read_unlock()
> before program reaches the exit.
> Same thing with locks.

Ah, okay, this wasn't stated anywhere. This is rather crucial
information.

> If bpf_res_spin_lock() succeeds the verifier will make sure
> there is matching bpf_res_spin_unlock().
> If some resource was acquired before bpf_res_spin_lock() and
> it returned -EDEADLK the verifier will not allow early return
> without releasing all acquired resources.

Good.

> > Have the program structured such that it must acquire all locks before
> > it does a modification / store -- and have the verifier enforce this.
> > Then any lock failure can be handled by the bpf core, not the program
> > itself. Core can unlock all previously acquired locks, and core can
> > either re-attempt the program or 'skip' it after N failures.
> 
> We definitely don't want to bpf core to keep track of acquired resources.
> That just doesn't scale.
> There could be rcu_read_locks, all kinds of refcounted objects,
> locks taken, and so on.
> The verifier makes sure that the program does the release no matter
> what the execution path.
> That's how it scales.
> On my devserver I have 152 bpf programs running.
> All of them keep acquiring and releasing resources (locks, sockets,
> memory) million times a second.
> The verifier checks that each prog is doing its job individually.

Well, this patch set tracks the held lock stack -- which is required in
order to do the deadlock thing after all.

> > It does mean the bpf core needs to track the acquired locks -- which you
> > already do,
> 
> We don't. 

This patch set does exactly that. Is required for deadlock analysis.

> The bpf infra does static checks only.
> The core doesn't track objects at run-time.
> The only exceptions are map elements.
> bpf prog might store an acquired object in a map.
> Only in that case bpf infra will free that object when it frees
> the whole map.
> But that doesn't apply to short lived things like RCU CS and
> locks. Those cannot last long. They must complete within single
> execution of the prog.

Right. Held lock stack is like that.

> > > That was a conscious trade-off. Deadlocks are not normal.
> >
> > I really do think you should assume they are normal, unpriv and all
> > that.
> 
> No unpriv and no, we don't want deadlocks to be considered normal
> by bpf users. They need to hear "fix your broken prog" message loud
> and clear. Patch 14 splat is a step in that direction.
> Currently it's only for in-kernel res_spin_lock() usage
> (like in bpf hashtab). Eventually we will deliver the message to users
> without polluting dmesg. Still debating the actual mechanism.

OK; how is the user supposed to handle locking two hash buckets? Does
the BPF prog create some global lock to serialize the multi bucket case?


Anyway, I wonder. Since the verifier tracks all this, it can determine
lock order for the prog. Can't it do what lockdep does and maintain lock
order graph of all loaded BPF programs?

This is load-time overhead, rather than runtime.

