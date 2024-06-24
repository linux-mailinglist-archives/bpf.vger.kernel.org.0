Return-Path: <bpf+bounces-32878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE6A91459D
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 11:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E71284DC0
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 09:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B13B1304BA;
	Mon, 24 Jun 2024 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lS+z8JCP"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191F912F592;
	Mon, 24 Jun 2024 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219594; cv=none; b=YZqKNXEkijQT4R9sN0sIgUalv5MHvTc1m7jSoStcCYHKwkI+KSbzuG2vuBcWP2JPakUZZ/mdCmNDrgA9HsV+VpiuWLDnpEvRJBp7Ic+IQQInXQMnCVxYCJmjL35Y1g/8qzLhXn1SIoJDZvo8+hxYuWEMPsdzAhOUQ1EZEoRqefI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219594; c=relaxed/simple;
	bh=zR+Z1N+EZ3isj1g1/KFSQCRwz+fPYr8+TiZFjyyt76k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNWRH9hzjLHq7HF9sSYVNggQ8B43Dmjf/cezQoyA/DGmr/H4ePLy+xUR1+rB5NFNdr3kbML1Vub1t8XkFI5a/qfmykv24x66DQBlzjXWUIr+R6qkxwJrNu4UwaSCbW9Ou6Hr7IrsV8J2A88yDRppnE5Qyl/KqED9nB7sfLnhkEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lS+z8JCP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fx6negkJ0UbrXTy7OETKcusDrtopdIdMIjgaGFy4Iws=; b=lS+z8JCPY3+ZfEIXWjvAJi3wNH
	hEgmex6QDlLqryUIXIJqtbl0KnXJNNa35UuR9fLYcR8Jt1kbl//FW8oBsRlXfkDQLcsf2NYYgBn+b
	8NT3+jDpGTtXDqZJeUO999PF64owBlFmUPno2Y1h55qRcy9NCakjNJer4RSiptcsTI3fdx5S9s01y
	FPI9ODf4H3Pd8ItVHJv48Xo5yqVtx33bCPo+lxeGX4nIAKpQbAb7/novU09vfXsj4/fb7Li+iqC78
	fi4sqmZbHoalz2jNx6EziIWwcnlKPfMuc2f4YG8gKi+rO0tuRJ+I2aGy/FX1u8c1q38c1+xXlIqFf
	I4+0F2Ng==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLfXs-00000008D9q-0Uo7;
	Mon, 24 Jun 2024 08:59:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id ACD20300754; Mon, 24 Jun 2024 10:59:27 +0200 (CEST)
Date: Mon, 24 Jun 2024 10:59:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
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
Subject: Re: [PATCH sched_ext/for-6.11] sched, sched_ext: Replace
 scx_next_task_picked() with sched_class->switch_class()
Message-ID: <20240624085927.GE31592@noisy.programming.kicks-ass.net>
References: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
 <87ed8sps71.ffs@tglx>
 <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx>
 <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx>
 <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <CAHk-=wgjbNLRtOvcmeEUtBQyJtYYAtvRTROBy9GHeF1Quszfgg@mail.gmail.com>
 <ZnRptXC-ONl-PAyX@slm.duckdns.org>
 <ZnSp5mVp3uhYganb@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnSp5mVp3uhYganb@slm.duckdns.org>

On Thu, Jun 20, 2024 at 12:15:02PM -1000, Tejun Heo wrote:
> scx_next_task_picked() is used by sched_ext to notify the BPF scheduler when
> a CPU is taken away by a task dispatched from a higher priority sched_class
> so that the BPF scheduler can, e.g., punt the task[s] which was running or
> were waiting for the CPU to other CPUs.
> 
> Replace the sched_ext specific hook scx_next_task_picked() with a new
> sched_class operation switch_class().
> 
> The changes are straightforward and the code looks better afterwards.
> However, when !CONFIG_SCHED_CLASS_EXT, this just ends up adding an unused
> hook which is unlikely to be useful to other sched_classes. We can #ifdef
> the op with CONFIG_SCHED_CLASS_EXT but then I'm not sure the code
> necessarily looks better afterwards.
> 
> Please let me know the preference. If adding #ifdef's is preferable, that's
> okay too.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/sched/core.c  |    5 ++++-
>  kernel/sched/ext.c   |   20 ++++++++++----------
>  kernel/sched/ext.h   |    4 ----
>  kernel/sched/sched.h |    2 ++
>  4 files changed, 16 insertions(+), 15 deletions(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5907,7 +5907,10 @@ restart:
>  	for_each_active_class(class) {
>  		p = class->pick_next_task(rq);
>  		if (p) {
> -			scx_next_task_picked(rq, p, class);
> +			const struct sched_class *prev_class = prev->sched_class;
> +
> +			if (class != prev_class && prev_class->switch_class)
> +				prev_class->switch_class(rq, p);
>  			return p;
>  		}
>  	}

I would much rather see sched_class::pick_next_task() get an extra
argument so that the BPF thing can do what it needs in there and we can
avoid this extra code here.

