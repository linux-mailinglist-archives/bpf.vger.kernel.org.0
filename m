Return-Path: <bpf+bounces-32882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75691914682
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 11:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2E22849F7
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 09:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36136131BDF;
	Mon, 24 Jun 2024 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qDYCHtgj"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E062613210F;
	Mon, 24 Jun 2024 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719221687; cv=none; b=Qrl6wNx7ys4dKQ6DkMENWvuTZ7BSx5/bU0xFS1oxTPXldLP/RNurNfJ3SV4kavC/3UO7k3EsGbiML42WrhzK9bHzCgEjDeyVit9L+mG08uP71/uXHOfIud0FpmwE6MCKg5J87DeRBCkUFYmjclclA8xsmGRe9R9Tfa0KNEcYBFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719221687; c=relaxed/simple;
	bh=oxzlghZgpQWtf/OS0zWg77UMd18e5XjpCpXTG4Hfc5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrHHP+olz2lefXn+POGbLVQDUkjzGMda/pLjKXIpk/9vFVvXX/1HqWAzR+pN0RAiHzv2nhDal1A/jXKoJx6hd+AcUgUxLT7f2j2mR9BFUVnkMYtyuLeRck2thiW3hEcc4M3XxPpiqIKnMEtyKGwcFXU9g5D86/IQY3zmbNH3T6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qDYCHtgj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K+eOtGw0JPdHqQ+WHRRD+LrINl24U1Sy3e5EKvb4k4k=; b=qDYCHtgj0+UxwEYXea2hA++mmC
	1EOdbITg63sYh8PJ0H13h+DiiPIhxC0X0Od95qsOSnVV+HzXXfCmgtZyAhOEXTIMBnRkmc2u1ZlFl
	5H9UIUNrOGCn817FNXNJwKbGP/J2ecENH8BIAxksc0W0Jf/Mo51y0GuypB6NDNKiBXYcFOa7QGxsF
	DZwgdT3+Bc+Vd5SUSSaWSOdocuHHvENRv3A5ylYjS9QkBI4xLk8GgVAo9HrG5vdzcBmhSsXhK16uW
	NsIpOMTOqopXhIBp9QAteGqh3XPinTEEfSu763xASVf9akn7vLygA2FP4xTIt+1tF/M8c2H/SvZtC
	7EQGavJQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLg5j-00000008DNW-0AZI;
	Mon, 24 Jun 2024 09:34:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6CE19300754; Mon, 24 Jun 2024 11:34:26 +0200 (CEST)
Date: Mon, 24 Jun 2024 11:34:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, andrea.righi@canonical.com,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
Message-ID: <20240624093426.GH31592@noisy.programming.kicks-ass.net>
References: <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <871q4rpi2s.ffs@tglx>
 <ZnSJ67xyroVUwIna@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnSJ67xyroVUwIna@slm.duckdns.org>

On Thu, Jun 20, 2024 at 09:58:35AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Thu, Jun 20, 2024 at 08:47:23PM +0200, Thomas Gleixner wrote:
> > One example I very explicitely mentioned back then is the dance around
> > fork().  It took me at least an hour last year to grok the convoluted
> > logic and it did not get any faster when I stared at it today again.
> > 
> > fork()
> >   sched_fork()
> >     scx_pre_fork()
> >       percpu_down_rwsem(&scx_fork_rwsem);
> > 
> >     if (dl_prio(p)) {
> >     	ret = -EINVAL;
> >         goto cancel; // required to release the semaphore
> >     }
> > 
> >   sched_cgroup_fork()
> >     return scx_fork();
> > 
> >   sched_post_fork()
> >     scx_post_fork()
> >       percpu_up_rwsem(&scx_fork_rwsem);
> > 
> > Plus the extra scx_cancel_fork() which releases the scx_fork_rwsem in
> > case that any call after sched_fork() fails.
> 
> This part is actually tricky. sched_cgroup_fork() part is mostly just me
> trying to find the right place among existing hooks. We can either just
> rename sched_cgroup_fork() to a more generic name or separate out the SCX
> hook in the fork path.
> 
> When a BPF scheduler attaches, it needs to establish its base operating
> condition - ie. allocate per-task data structures, change sched class, and
> so on. There is trade-off between how fine-grained the synchronization can
> be and how easy it is for the BPF schedulers and we really do wanna make it
> easy for the BPF schedulers.
> 
> So, the current approach is just locking things down while attaching which
> makes things a lot easier for the BPF schedulers. The locking is through a
> percpu_rwsem, so it's super heavy on the writer side but really light on the
> reader (fork) side. Maybe the overhead can be further reduced by guarding it
> with static_key but the difference won't be much and I doubt it'd make any
> noticeable difference in the fork path.

I'm confused. Once you've loaded the BPF thing, 'all' tasks you care
about should already be in the bpf class. So any fork() thereafter
should not need to switch classes.

This means we can have this rwsem be strictly for the bpf tasks as
Thomas suggested.

What are we missing?

