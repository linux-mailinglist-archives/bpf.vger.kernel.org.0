Return-Path: <bpf+bounces-70285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF5ABB635B
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 10:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC2719E7666
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 08:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58812263F22;
	Fri,  3 Oct 2025 08:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbnldUrQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FD78C1F;
	Fri,  3 Oct 2025 08:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759478839; cv=none; b=oXZrCuHIs5MJEsbjVi2j5a4vZexdgNUz24bfOkWNof4vo9IHhe8nFCiZH3LcIVksFBwE2pMJXzIGEr0PnrYJ0s1DZh1AM1cE8a+2OPc475R8RuBXcLlFj9zLFRS3Brod30jQPusrO3C+SqT3NhwLwuiwrUXZfsR1lUK999aIUWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759478839; c=relaxed/simple;
	bh=Xf/+MWjQ6Yf/NRxmjdms6RpBDZyzb5YtCa8fLSx+uuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOav7yHJPOqIHUCIXAW6cu0E7KaLWk3/YUFULU4EmzjI0YYaAkBicr0pREtCVZcVouOK+hxdPQdJwAeiLqf1x2LtHfVd2Y1XyjW+CIzt/1j6E5j1iLPd7fv9Phi52wbHamiBd11xAJu6W2qS1YQ5hlYn8xgTcBZB4Xbe94zJOBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbnldUrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DBDC4CEF5;
	Fri,  3 Oct 2025 08:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759478839;
	bh=Xf/+MWjQ6Yf/NRxmjdms6RpBDZyzb5YtCa8fLSx+uuk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=HbnldUrQQBDe4WlQMST5O/ZRbp3SnULl+TuvOhMAPrmvaJgdzPS0qSmTV+Mc+WORv
	 HPiz8hWpeeunVtmDUXgMyNzkymcRVdgx2YkK3oKBmLfrMms4VIfepOLbLbtIhBtd+E
	 vg29zrm8XrRQAf65J1zhQYmfwCyy3/n5nKW4FYPv9ZZZWgv/pkRJ3775CjiSO0khnF
	 K9KoQlmFzzqQXxfgKcOywERg/4ZY+fDuHXiH0oz6If3PyTTgRpJ4Wrhaw7THIBp4bQ
	 iNN1jqR3XnzgGZLHvknw9raLOSf5Z4afDX5iB73MnWAW1ZHtH+jMMoDPB7ZpC8kPvY
	 Hu+6z68AWZFNQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EF95CCE1590; Fri,  3 Oct 2025 01:07:15 -0700 (PDT)
Date: Fri, 3 Oct 2025 01:07:15 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Kernel Team <kernel-team@meta.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 08/21] rcu: Add noinstr-fast
 rcu_read_{,un}lock_tasks_trace() APIs
Message-ID: <9d93f63e-cbb3-405e-aa8c-d6ecf54d22b1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
 <20251001144832.631770-8-paulmck@kernel.org>
 <CAADnVQLozKuSPMe4qUDxCV6pCSQ=rQNKy524K7R=uM5yTpLV0Q@mail.gmail.com>
 <5e9b7d89-fbd9-48f2-a538-a3aeaab5d9ec@paulmck-laptop>
 <CAADnVQJQCA-PCnaCVP8QE8W-S_8PsX8W=L7AUjo2Q10ekYndUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJQCA-PCnaCVP8QE8W-S_8PsX8W=L7AUjo2Q10ekYndUA@mail.gmail.com>

On Thu, Oct 02, 2025 at 08:56:01AM -0700, Alexei Starovoitov wrote:
> On Thu, Oct 2, 2025 at 6:38 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Oct 01, 2025 at 06:37:33PM -0700, Alexei Starovoitov wrote:
> > > On Wed, Oct 1, 2025 at 7:48 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > +static inline struct srcu_ctr __percpu *rcu_read_lock_tasks_trace(void)
> > > > +{
> > > > +       struct srcu_ctr __percpu *ret = __srcu_read_lock_fast(&rcu_tasks_trace_srcu_struct);
> > > > +
> > > > +       rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map);
> > > > +       if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB))
> > > > +               smp_mb(); // Provide ordering on noinstr-incomplete architectures.
> > > > +       return ret;
> > > > +}
> > >
> > > ...
> > >
> > > > @@ -50,14 +97,15 @@ static inline void rcu_read_lock_trace(void)
> > > >  {
> > > >         struct task_struct *t = current;
> > > >
> > > > +       rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map);
> > > >         if (t->trc_reader_nesting++) {
> > > >                 // In case we interrupted a Tasks Trace RCU reader.
> > > > -               rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map);
> > > >                 return;
> > > >         }
> > > >         barrier();  // nesting before scp to protect against interrupt handler.
> > > > -       t->trc_reader_scp = srcu_read_lock_fast(&rcu_tasks_trace_srcu_struct);
> > > > -       smp_mb(); // Placeholder for more selective ordering
> > > > +       t->trc_reader_scp = __srcu_read_lock_fast(&rcu_tasks_trace_srcu_struct);
> > > > +       if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB))
> > > > +               smp_mb(); // Placeholder for more selective ordering
> > > >  }
> > >
> > > Since srcu_fast() __percpu pointers must be incremented/decremented
> > > within the same task, should we expose "raw" rcu_read_lock_tasks_trace()
> > > at all?
> > > rcu_read_lock_trace() stashes that pointer within a task,
> > > so implementation guarantees that unlock will happen within the same task,
> > > while _tasks_trace() requires the user not to do stupid things.
> > >
> > > I guess it's fine to have both versions and the amount of copy paste
> > > seems justified, but I keep wondering.
> > > Especially since _tasks_trace() needs more work on bpf trampoline
> > > side to pass this pointer around from lock to unlock.
> > > We can add extra 8 bytes to struct bpf_tramp_run_ctx and save it there,
> > > but set/reset run_ctx operates on current anyway, so it's not clear
> > > which version will be faster. I suspect _trace() will be good enough.
> > > Especially since trc_reader_nesting is kinda an optimization.
> >
> > The idea is to convert callers and get rid of rcu_read_lock_trace()
> > in favor of rcu_read_lock_tasks_trace(), the reason being the slow
> > task_struct access on x86.  But if the extra storage is an issue for
> > some use cases, we can keep both.  In that case, I would of course reduce
> > the copy-pasta in a future patch.
> 
> slow task_struct access on x86? That's news to me.
> Why is it slow?
> static __always_inline struct task_struct *get_current(void)
> {
>         if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
>                 return this_cpu_read_const(const_current_task);
> 
>         return this_cpu_read_stable(current_task);
> }
> 
> 
> The former is used with gcc 14+ while later is with clang.
> I don't understand the difference between the two.
> I'm guessing gcc14+ can be optimized better within the function,
> but both look plenty fast.
> 
> We need current access anyway for run_ctx.

Last I measured it, task_struct access was quite a bit slower than was
access to per-CPU variables.  The assembly language was such that this
was unsurprising.

But maybe things have changed, and it certainly would be a good thing
if task_struct access had improved.  Once I get done hammering it with
functional tests, I will of course do benchmarking and adjust as needed.

							Thanx, Paul

