Return-Path: <bpf+bounces-70195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D05DBB4116
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 15:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D91E167880
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C54B31196B;
	Thu,  2 Oct 2025 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoiE1Hp4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B77279DD3;
	Thu,  2 Oct 2025 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759412311; cv=none; b=avAQOg49ABNZt2+STaSPq7wh1uBar+g9Lgzn4gwTuLTtX2RnpBuZ4fzhJVSWw6RafCsYpf50Yl9QGi5xGzJUax/D4Sc7Bhj7BGZnk0zrXQnmFPHeojYEz9tHmQjDxt3qF1oTeEghhoAMGu5/Begjd15lZWdWtThb3a73zokCqVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759412311; c=relaxed/simple;
	bh=2oft3Au5B4OOW0yabtivw0E2y/k2pqPeKWqw5yQV9c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7ZTlguWawsqqMEvwSjwQLvMl5O40XwFY+rpH4KElSX7oUVGZVH6okU61tfBvSVnOqmUOsr9rs26kC8ccd/oykOHYDOLPIwyKRdQ/Il/CXC54BW8op29Cn/c/Ofm1GqvVP2J9UY7kSowmZmxnDljhRRjKyVWNvFsU2Gt/HIP5C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoiE1Hp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18F0C4CEF4;
	Thu,  2 Oct 2025 13:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759412311;
	bh=2oft3Au5B4OOW0yabtivw0E2y/k2pqPeKWqw5yQV9c8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=QoiE1Hp4DjOETKkO+w1k/llxFR+f+vhrqhY/WDsEALOJSCK4WODd+MZdEpliEOLY4
	 brQbOhbO77dHhU+JlKIKJK6BAjDaEiYh46A3slxZJc8LMboZNUkVfUwNRxGLq2hgf7
	 HLn9uP+gLEkg3jGNAai4XgMvg80exptIa3HDzdx1m9Ijdw33kFu20fZpmZlaTiA5Ju
	 E1w5rnxzAKYD8pPi/KKznYVz0T8cMjFBoxaePv72mMGqmJf2s/mnDoxrjTgbg9M8/4
	 n9QUnalhvsprbndHeTb9a3ncU5PgjUdSpHgFdBr/U+bLXm+nKvu8Lnxr3BNjbm8GpR
	 nscGCw4AV2v8A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 94E76CE0E5A; Thu,  2 Oct 2025 06:38:28 -0700 (PDT)
Date: Thu, 2 Oct 2025 06:38:28 -0700
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
Message-ID: <5e9b7d89-fbd9-48f2-a538-a3aeaab5d9ec@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
 <20251001144832.631770-8-paulmck@kernel.org>
 <CAADnVQLozKuSPMe4qUDxCV6pCSQ=rQNKy524K7R=uM5yTpLV0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLozKuSPMe4qUDxCV6pCSQ=rQNKy524K7R=uM5yTpLV0Q@mail.gmail.com>

On Wed, Oct 01, 2025 at 06:37:33PM -0700, Alexei Starovoitov wrote:
> On Wed, Oct 1, 2025 at 7:48 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > +static inline struct srcu_ctr __percpu *rcu_read_lock_tasks_trace(void)
> > +{
> > +       struct srcu_ctr __percpu *ret = __srcu_read_lock_fast(&rcu_tasks_trace_srcu_struct);
> > +
> > +       rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map);
> > +       if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB))
> > +               smp_mb(); // Provide ordering on noinstr-incomplete architectures.
> > +       return ret;
> > +}
> 
> ...
> 
> > @@ -50,14 +97,15 @@ static inline void rcu_read_lock_trace(void)
> >  {
> >         struct task_struct *t = current;
> >
> > +       rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map);
> >         if (t->trc_reader_nesting++) {
> >                 // In case we interrupted a Tasks Trace RCU reader.
> > -               rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map);
> >                 return;
> >         }
> >         barrier();  // nesting before scp to protect against interrupt handler.
> > -       t->trc_reader_scp = srcu_read_lock_fast(&rcu_tasks_trace_srcu_struct);
> > -       smp_mb(); // Placeholder for more selective ordering
> > +       t->trc_reader_scp = __srcu_read_lock_fast(&rcu_tasks_trace_srcu_struct);
> > +       if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB))
> > +               smp_mb(); // Placeholder for more selective ordering
> >  }
> 
> Since srcu_fast() __percpu pointers must be incremented/decremented
> within the same task, should we expose "raw" rcu_read_lock_tasks_trace()
> at all?
> rcu_read_lock_trace() stashes that pointer within a task,
> so implementation guarantees that unlock will happen within the same task,
> while _tasks_trace() requires the user not to do stupid things.
> 
> I guess it's fine to have both versions and the amount of copy paste
> seems justified, but I keep wondering.
> Especially since _tasks_trace() needs more work on bpf trampoline
> side to pass this pointer around from lock to unlock.
> We can add extra 8 bytes to struct bpf_tramp_run_ctx and save it there,
> but set/reset run_ctx operates on current anyway, so it's not clear
> which version will be faster. I suspect _trace() will be good enough.
> Especially since trc_reader_nesting is kinda an optimization.

The idea is to convert callers and get rid of rcu_read_lock_trace()
in favor of rcu_read_lock_tasks_trace(), the reason being the slow
task_struct access on x86.  But if the extra storage is an issue for
some use cases, we can keep both.  In that case, I would of course reduce
the copy-pasta in a future patch.

							Thanx, Paul

