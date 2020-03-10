Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 557DB180401
	for <lists+bpf@lfdr.de>; Tue, 10 Mar 2020 17:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCJQym (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Mar 2020 12:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgCJQym (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Mar 2020 12:54:42 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97F9420873;
        Tue, 10 Mar 2020 16:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583859281;
        bh=XQQa0PLtN8swMBCXZL8OPpBHL06E8seSbXfVlS1Sc9Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RKDipRUKJ4U3391gbaAHXUKR1S+8mTtl+uFLWAbWba+gU8n0RpHJr/1SIjXTSIhU0
         Bm4OOqSdpTzZJBCaQMFaWl3ktQZzcHMcTH4BR+B5EdFhtKMFQlMlFubU0T+tj3F3ss
         zeD4uis+T1/Zbf8eS4tKJtPq20m+lfLf5kPScK94=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7617F35229CC; Tue, 10 Mar 2020 09:54:41 -0700 (PDT)
Date:   Tue, 10 Mar 2020 09:54:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>, bpf@vger.kernel.org
Subject: Re: Instrumentation and RCU
Message-ID: <20200310165441.GE2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <87mu8p797b.fsf@nanos.tec.linutronix.de>
 <1403546357.21810.1583779060302.JavaMail.zimbra@efficios.com>
 <20200310014043.4dbagqbr2wsbuarm@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310014043.4dbagqbr2wsbuarm@ast-mbp>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 09, 2020 at 06:40:45PM -0700, Alexei Starovoitov wrote:
> On Mon, Mar 09, 2020 at 02:37:40PM -0400, Mathieu Desnoyers wrote:
> > > 
> > >    But what's relevant is the tracer overhead which is e.g. inflicted
> > >    with todays trace_hardirqs_off/on() implementation because that
> > >    unconditionally uses the rcuidle variant with the scru/rcu_irq dance
> > >    around every tracepoint.
> > 
> > I think one of the big issues here is that most of the uses of
> > trace_hardirqs_off() are from sites which already have RCU watching,
> > so we are doing heavy-weight operations for nothing.
> 
> I think kernel/trace/trace_preemptirq.c created too many problems for the
> kernel without providing tangible benefits. My understanding no one is using it
> in production. It's a tool to understand how kernel works. And such debugging
> tool can and should be removed.
> 
> One of Thomas's patches mentioned that bpf can be invoked from hardirq and
> preempt tracers. This connection doesn't exist in a direct way, but
> theoretically it's possible. There is no practical use though and I would be
> happy to blacklist such bpf usage at a minimum.
> 
> > We could use the approach proposed by Peterz's and Steven's patches to basically
> > do a lightweight "is_rcu_watching()" check for rcuidle tracepoint, and only enable
> > RCU for those cases. We could then simply go back on using regular RCU like so:
> > 
> > #define __DO_TRACE(tp, proto, args, cond, rcuidle)                      \
> >         do {                                                            \
> >                 struct tracepoint_func *it_func_ptr;                    \
> >                 void *it_func;                                          \
> >                 void *__data;                                           \
> >                 bool exit_rcu = false;                                  \
> >                                                                         \
> >                 if (!(cond))                                            \
> >                         return;                                         \
> >                                                                         \
> >                 if (rcuidle && !rcu_is_watching()) {                    \
> >                         rcu_irq_enter_irqson();                         \
> >                         exit_rcu = true;                                \
> >                 }                                                       \
> >                 preempt_disable_notrace();                              \
> >                 it_func_ptr = rcu_dereference_raw((tp)->funcs);         \
> >                 if (it_func_ptr) {                                      \
> >                         do {                                            \
> >                                 it_func = (it_func_ptr)->func;          \
> >                                 __data = (it_func_ptr)->data;           \
> >                                 ((void(*)(proto))(it_func))(args);      \
> >                         } while ((++it_func_ptr)->func);                \
> >                 }                                                       \
> >                 preempt_enable_notrace();                               \
> >                 if (exit_rcu)                                           \
> >                         rcu_irq_exit_irqson();                          \
> >         } while (0)
> 
> I think it's a fine approach interim.
> 
> Long term sounds like Paul is going to provide sleepable and low overhead
> rcu_read_lock_for_tracers() that will include bpf.

It now builds without errors, so the obvious problems are taken care of...

Working on the less-obvious errors as rcutorture encounters them.

> My understanding that this new rcu flavor won't have "idle" issues,
> so rcu_is_watching() checks will not be necessary.

True.  However, if the from-idle code invokes other code relying on
vanilla RCU, such checks are still required.  But I must let others
weigh in on this.

> And if we remove trace_preemptirq.c the only thing left will be Thomas's points
> 1 (low level entry) and 2 (breakpoints) that can be addressed without
> creating fancy .text annotations and teach objtool about it.

And the intent is to cover these cases as well.  Of course, we all know
which road is paved with good intentions.  ;-)

> In the mean time I've benchmarked srcu for sleepable bpf and it's quite heavy.
> srcu_read_lock+unlock roughly adds 10x execution cost to trivial bpf prog.
> I'm proceeding with it anyway, but really hoping that
> rcu_read_lock_for_tracers() will materialize soon.

OK, 10x is a bit on the painful side!

							Thanx, Paul

> In general I'm sceptical that .text annotations will work. Let's say all of
> idle is a red zone. But a ton of normal functions are called when idle. So
> objtool will go and mark them as red zone too. This way large percent of the
> kernel will be off limits for tracers. Which is imo not a good trade off. I
> think addressing 1 and 2 with explicit notrace/nokprobe annotations will cover
> all practical cases where people can shot themselves in a foot with a tracer. I
> realize that there will be forever whack-a-mole game and these annotations will
> never reach 100%. I think it's a fine trade off. Security is never 100% either.
> Tracing is never going to be 100% safe too.
