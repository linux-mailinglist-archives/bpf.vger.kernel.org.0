Return-Path: <bpf+bounces-42762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EE99A9C3A
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 10:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D465F283162
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 08:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED0017B51B;
	Tue, 22 Oct 2024 08:20:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03CB13BAC6;
	Tue, 22 Oct 2024 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585207; cv=none; b=Up78S8KLwa5Qb3fOhJvBNxdLDOgy2BzR27Ic9wdmvke+690z4F/ez15anmh9TjZxp8mw5yC1epG/lKxdvFC0esotB+tiUm+Pc4FXYQ9R51US2jFjK0EUtPrev/m5rsiiftZcpyQvxFT78mLl9AApUqn6qsy3vphYYDs5o3YT+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585207; c=relaxed/simple;
	bh=IY2vJ4lBZFQ9T1PaAjWN5lFuG7xVDM/dvhYtDtFIOno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHlMg9mml1AVO1OEmM/eWmO8sZxoKenL7m0JzgnmpKhvyOH+/xJzUKBELTIcdsjRWGdP2XUGOJn0Pvvm3dPS6EUmAFysaTvnKaR2z88OsgcCQkAbJT6gvxFjumPeI3UsPw6CjQNFIyVlXIQRYfUqoX3iGJF8eRwsnVcbIY6ls3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C13C4CEC3;
	Tue, 22 Oct 2024 08:20:04 +0000 (UTC)
Date: Tue, 22 Oct 2024 04:20:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jordan Rife <jrife@google.com>, mathieu.desnoyers@efficios.com
Cc: syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 martin.lau@linux.dev, mattbobrowski@google.com, mhiramat@kernel.org,
 sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com,
 yonghong.song@linux.dev
Subject: Re: [syzbot] [trace?] [bpf?] KASAN: slab-use-after-free Read in
 bpf_trace_run2 (2)
Message-ID: <20241022042001.09055543@rorschach.local.home>
In-Reply-To: <20241021182347.77750-1-jrife@google.com>
References: <67121037.050a0220.10f4f4.000f.GAE@google.com>
	<20241021182347.77750-1-jrife@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Mathieu, can you look at this?

[ more below ]

On Mon, 21 Oct 2024 18:23:47 +0000
Jordan Rife <jrife@google.com> wrote:

> I performed a bisection and this issue starts with commit a363d27cdbc2
> ("tracing: Allow system call tracepoints to handle page faults") which
> introduces this change.
> 
> > + *
> > + * With @syscall=0, the tracepoint callback array dereference is
> > + * protected by disabling preemption.
> > + * With @syscall=1, the tracepoint callback array dereference is
> > + * protected by Tasks Trace RCU, which allows probes to handle page
> > + * faults.
> >   */
> >  #define __DO_TRACE(name, args, cond, syscall)				\
> >  	do {								\
> > @@ -204,11 +212,17 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> >  		if (!(cond))						\
> >  			return;						\
> >  									\
> > -		preempt_disable_notrace();				\
> > +		if (syscall)						\
> > +			rcu_read_lock_trace();				\
> > +		else							\
> > +			preempt_disable_notrace();			\
> >  									\
> >  		__DO_TRACE_CALL(name, TP_ARGS(args));			\
> >  									\
> > -		preempt_enable_notrace();				\
> > +		if (syscall)						\
> > +			rcu_read_unlock_trace();			\
> > +		else							\
> > +			preempt_enable_notrace();			\
> >  	} while (0)  
> 
> Link: https://lore.kernel.org/bpf/20241009010718.2050182-6-mathieu.desnoyers@efficios.com/
> 
> I reproduced the bug locally by running syz-execprog inside a QEMU VM.
> 
> > ./syz-execprog -repeat=0 -procs=5 ./repro.syz.txt  
> 
> I /think/ what is happening is that with this change preemption may now
> occur leading to a scenario where the RCU grace period is insufficient
> in a few places where call_rcu() is used. In other words, there are a
> few scenarios where call_rcu_tasks_trace() should be used instead to
> prevent a use-after-free bug when a preempted tracepoint call tries to
> access a program, link, etc. that was freed. It seems the syzkaller
> program induces page faults while attaching raw tracepoints to
> sys_enter making preemption more likely to occur.
> 
> kernel/tracepoint.c
> ===================
> > ...
> > static inline void release_probes(struct tracepoint_func *old)
> > {
> > 	...
> > 	call_rcu(&tp_probes->rcu, rcu_free_old_probes); <-- Here

Have you tried just changing this one to call_rcu_tasks_trace()?

-- Steve

> > 	...
> > }
> > ...  
> 
> kernel/bpf/syscall.c
> ====================
> > static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
> > {
> > 	bpf_prog_kallsyms_del_all(prog);
> > 	btf_put(prog->aux->btf);
> > 	module_put(prog->aux->mod);
> > 	kvfree(prog->aux->jited_linfo);
> > 	kvfree(prog->aux->linfo);
> > 	kfree(prog->aux->kfunc_tab);
> > 	if (prog->aux->attach_btf)
> > 		btf_put(prog->aux->attach_btf);
> > 
> > 	if (deferred) {
> > 		if (prog->sleepable) <------ HERE: New condition needed?
> > 			call_rcu_tasks_trace(&prog->aux->rcu, __bpf_prog_put_rcu);
> > 		else
> > 			call_rcu(&prog->aux->rcu, __bpf_prog_put_rcu);
> > 	} else {
> > 		__bpf_prog_put_rcu(&prog->aux->rcu);
> > 	}
> > }
> > 
> > static void bpf_link_free(struct bpf_link *link)
> > {
> > 	const struct bpf_link_ops *ops = link->ops;
> > 	bool sleepable = false;
> > 
> > 	bpf_link_free_id(link->id);
> > 	if (link->prog) {
> > 		sleepable = link->prog->sleepable;
> > 		/* detach BPF program, clean up used resources */
> > 		ops->release(link);
> > 		bpf_prog_put(link->prog);
> > 	}
> > 	if (ops->dealloc_deferred) {
> > 		/* schedule BPF link deallocation; if underlying BPF program
> > 		 * is sleepable, we need to first wait for RCU tasks trace
> > 		 * sync, then go through "classic" RCU grace period
> > 		 */
> > 		if (prog->sleepable) <------ HERE: New condition needed?
> > 			call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
> > 		else
> > 			call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
> > 	} else if (ops->dealloc)
> > 		ops->dealloc(link);
> > }  
> 
> After patching things locally to ensure that call_rcu_tasks_trace() is
> always used in these three places I was unable to induce a KASAN bug
> to occur whereas before it happened pretty much every time I ran 
> ./sys-execprog within a minute or so.
> 
> I'm a bit unsure about the actual conditions under which
> call_rcu_tasks_trace() should be used here though. Should there perhaps
> be another condition such as `preemptable` which is used to determine
> if call_rcu_tasks_trace() or call_rcu() should be used to free
> links/programs? Is there any harm in just using call_rcu_tasks_trace()
> every time in combination with rcu_trace_implies_rcu_gp() like it is
> in bpf_link_defer_dealloc_mult_rcu_gp()?
> 
> > static void bpf_link_defer_dealloc_mult_rcu_gp(struct rcu_head *rcu)?
> > {
> > 	if (rcu_trace_implies_rcu_gp())
> > 		bpf_link_defer_dealloc_rcu_gp(rcu);
> > 	else
> > 		call_rcu(rcu, bpf_link_defer_dealloc_rcu_gp);
> > }  
> 
> - Jordan


