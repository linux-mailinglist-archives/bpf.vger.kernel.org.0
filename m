Return-Path: <bpf+bounces-11239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02C47B5E86
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 03:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7690B2817CF
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 01:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211CC652;
	Tue,  3 Oct 2023 01:18:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8714634
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 01:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0339C433C7;
	Tue,  3 Oct 2023 01:18:35 +0000 (UTC)
Date: Mon, 2 Oct 2023 21:19:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, Michael Jeanson <mjeanson@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, Ingo Molnar <mingo@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC PATCH v3 1/5] tracing: Introduce faultable tracepoints
 (v3)
Message-ID: <20231002211936.5948253e@gandalf.local.home>
In-Reply-To: <97c559c9-51cf-415c-8b0b-39eba47b8898@paulmck-laptop>
References: <20231002202531.3160-1-mathieu.desnoyers@efficios.com>
	<20231002202531.3160-2-mathieu.desnoyers@efficios.com>
	<20231002191023.6175294d@gandalf.local.home>
	<97c559c9-51cf-415c-8b0b-39eba47b8898@paulmck-laptop>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Oct 2023 17:14:39 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Mon, Oct 02, 2023 at 07:10:23PM -0400, Steven Rostedt wrote:
> > On Mon,  2 Oct 2023 16:25:27 -0400
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >   
> > > @@ -202,8 +198,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> > >  		if (WARN_ON_ONCE(RCUIDLE_COND(rcuidle)))		\
> > >  			return;						\
> > >  									\
> > > -		/* keep srcu and sched-rcu usage consistent */		\
> > > -		preempt_disable_notrace();				\
> > > +		if (mayfault) {						\
> > > +			rcu_read_lock_trace();				\  
> > 
> > I thought rcu_trace was for the case that a task can not voluntarily call
> > schedule. If this tracepoint tries to read user space memory that isn't
> > paged in, and faults, can't the faulting logic call schedule and break this
> > requirement?  
> 
> Well, additional new uses of rcu_read_lock_trace() do bear close scrutiny,
> but RCU Tasks Trace readers are permitted to block for page faults.
> The BPF folks already use it for this purpose, so this should be OK.
> (If for some unknown-to-me reason it isn't, I am sure that Alexei,
> who is on CC, will not suffer in silence.)
> 
> One way of thinking of RCU Tasks Trace is as a form of SRCU with
> lightweight readers.  Except that, unlike SRCU, there is only one global
> RCU Tasks Trace.  This means that all RCU Tasks Trace users need to keep
> each other informed, because one users' unruly readers will affect all
> RCU Tasks Trace users.
> 
> But given that the BPF folks already have page faults in RCU Tasks Trace
> readers, this one should be OK.

Then I think we should update the documentation.

From: Documentation/RCU/checklist.rst:

        If the updater uses call_rcu_tasks() or synchronize_rcu_tasks(),
        then the readers must refrain from executing voluntary
        context switches, that is, from blocking.  If the updater uses
        call_rcu_tasks_trace() or synchronize_rcu_tasks_trace(), then
        the corresponding readers must use rcu_read_lock_trace() and
        rcu_read_unlock_trace().  If an updater uses call_rcu_tasks_rude()
        or synchronize_rcu_tasks_rude(), then the corresponding readers
        must use anything that disables preemption, for example,
        preempt_disable() and preempt_enable().

Because it's all one paragraph it's a bit confusing to know what uses what.
Perhaps it should be broken up a bit more?

        If the updater uses call_rcu_tasks() or synchronize_rcu_tasks(),
        then the readers must refrain from executing voluntary
        context switches, that is, from blocking.

        If the updater uses call_rcu_tasks_trace() or
        synchronize_rcu_tasks_trace(), then the corresponding readers must
        use rcu_read_lock_trace() and rcu_read_unlock_trace().

        If an updater uses call_rcu_tasks_rude() or synchronize_rcu_tasks_rude(),
        then the corresponding readers must use anything that disables
        preemption, for example, preempt_disable() and preempt_enable().

That way it is clear what uses what, as I read the original paragraph a
couple of times and could have sworn that rcu_read_lock_trace() required
tasks to not block.

-- Steve

