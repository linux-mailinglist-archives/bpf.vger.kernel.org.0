Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAD8263827
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 23:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIIVEs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 17:04:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgIIVEs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 17:04:48 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5269921D6C;
        Wed,  9 Sep 2020 21:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599685487;
        bh=J5rHdyFMK5tPA95lx00yQbHGNJitdXED5RDkSsdfEj0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FVuTuHdn/ZOYbi80ewkGpjHZ1vpyHY+qo/QbT3Uax8q2BdQmQd58c09cVuDribWP8
         FXfVYCzke9wppp7KyHg7AuYUpattmao2pcpBXkMiOBcP3S7tL7wUmXpIyvCIuY7uR3
         tKZ7l8tGsfh9YEKn1HSoH8z1Z0ty/7wJ2WKZKSSA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1C7EE3522602; Wed,  9 Sep 2020 14:04:47 -0700 (PDT)
Date:   Wed, 9 Sep 2020 14:04:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: slow sync rcu_tasks_trace
Message-ID: <20200909210447.GL29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAADnVQK_AiX+S_L_A4CQWT11XyveppBbQSQgH_qWGyzu_E8Yeg@mail.gmail.com>
 <20200909113858.GF29330@paulmck-ThinkPad-P72>
 <20200909171228.dw7ra5mkmvqrvptp@ast-mbp.dhcp.thefacebook.com>
 <20200909173512.GI29330@paulmck-ThinkPad-P72>
 <20200909180418.hlivoaekhkchlidw@ast-mbp.dhcp.thefacebook.com>
 <20200909193900.GK29330@paulmck-ThinkPad-P72>
 <20200909194828.urz6islrqajifukj@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909194828.urz6islrqajifukj@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 09, 2020 at 12:48:28PM -0700, Alexei Starovoitov wrote:
> On Wed, Sep 09, 2020 at 12:39:00PM -0700, Paul E. McKenney wrote:
> > > > 
> > > > When do you need this by?
> > > > 
> > > > Left to myself, I will aim for the merge window after the upcoming one,
> > > > and then backport to the prior -stable versions having RCU tasks trace.
> > > 
> > > That would be too late.
> > > We would have to disable sleepable bpf progs or convert them to srcu.
> > > bcc/bpftrace have a limit of 1000 probes for regexes to make sure
> > > these tools don't add too many kprobes to the kernel at once.
> > > Right now fentry/fexit/freplace are using trampoline which does
> > > synchronize_rcu_tasks(). My measurements show that it's roughly
> > > equal to synchronize_rcu() on idle box and perfectly capable to
> > > be a replacement for kprobe based attaching.
> > > It's not uncommon to attach a hundred kprobes or fentry probes at
> > > a start time. So bpf trampoline has to be able to do 1000 in a second.
> > > And it was the case before sleepable got added to the trampoline.
> > > Now it's doing:
> > > synchronize_rcu_mult(call_rcu_tasks, call_rcu_tasks_trace);
> > > and it's causing this massive slowdown which makes bpf trampoline
> > > pretty much unusable and everything that builds on top suffers.
> > > I can add a counter of sleepable progs to trampoline and do
> > > either sync rcu_tasks or sync_mult(tasks, tasks_trace),
> > > but we've discussed exactly that idea few months back and concluded that
> > > rcu_tasks is likely to be heavier than rcu_tasks_trace, so I didn't
> > > bother with the counter. I can still add it, but slow rcu_tasks_trace
> > > means that sleepable progs are not usable due to slow startup time,
> > > so have to do something with sleepable anyway.
> > > So "when do you need this by?" the answer is asap.
> > > I'm considering such changes to be a bugfix, not a feture.
> > 
> > Got it.
> > 
> > With the patch below, I am able to reproduce this issue, as expected.
> 
> I think your tests is more stressful than mine.
> test_progs -t trampoline_count
> doesn't run the sleepable progs. So there is no lock/unlock_trace at all.
> It's updating trampoline and doing sync_mult() that's all.
> 
> > My plan is to try the following:
> > 
> > 1.	Parameterize the backoff sequence so that RCU Tasks Trace
> > 	uses faster rechecking than does RCU Tasks.  Experiment as
> > 	needed to arrive at a good backoff value.
> > 
> > 2.	If the tasks-list scan turns out to be a tighter bottleneck 
> > 	than the backoff waits, look into parallelizing this scan.
> > 	(This seems unlikely, but the fact remains that RCU Tasks
> > 	Trace must do a bit more work per task than RCU Tasks.)
> > 
> > 3.	If these two approaches, still don't get the update-side
> > 	latency where it needs to be, improvise.
> > 
> > The exact path into mainline will of course depend on how far down this
> > list I must go, but first to get a solution.
> 
> I think there is a case of 4. Nothing is inside rcu_trace critical section.
> I would expect single ipi would confirm that.

Unless the task moves, yes.  So a single IPI should suffice in the
common case.

							Thanx, Paul
