Return-Path: <bpf+bounces-70373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10611BB8C28
	for <lists+bpf@lfdr.de>; Sat, 04 Oct 2025 11:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CADDE19C2559
	for <lists+bpf@lfdr.de>; Sat,  4 Oct 2025 09:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BDE23A994;
	Sat,  4 Oct 2025 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTYsfwb6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CF2157A6B;
	Sat,  4 Oct 2025 09:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759571233; cv=none; b=gY47rIbgSvWqgpZq32GAUze+sDCbsFw8UaP3hUIUErbP+Up6KjaXJbH1QxTjCTwASiYeX6qlwUyW8wsrB9IHOFJ1AckhCNDL152Ql/hmnXhEmlxjHnO4rLJ9BtX6VcNg0FDlWJovVOhvjw4BT1e65/aBnemGKH/omEiiiiCj8Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759571233; c=relaxed/simple;
	bh=8Z58r/lUJzR4nNBETqyf17v4ZDZhpa1ENzKinXNi7qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtd6mP6MMjA3Xgt0kjj5NfFUX8kVnP6m7AFWScBbgY0SKgMwXqfpgSUZCk6Fjq2YiDFQ6/+Ty2aYdARm3YccsyxRmmjnLSxlR6B8UkpjDN3Yn7jxvrSoJGmpF5+Nugizv/zo7x/XHHAJAuHP0U2s6pPVUhCqsCuR9B+zEzPyrHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTYsfwb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5BFC4CEF1;
	Sat,  4 Oct 2025 09:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759571231;
	bh=8Z58r/lUJzR4nNBETqyf17v4ZDZhpa1ENzKinXNi7qY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=FTYsfwb6WZuYXqI1zLQPguxDOLQQ6mG7D9bZCgc99AHzD5BiR5KTwqoX/hsQn0UON
	 5JMujNUfq5w+kWbUvGUUA21TmmB/t+m/3JZbwwYkIdQXBfc3ZeqNxw8QoOh5IbEHm5
	 kht9558spz+O0vYPWYXrOw0EF1qk81YkE331ReqxqyLBB5Nb7nSGY0e3RQoNY332a3
	 yzuKzZjCmz+yvaAtN/waOg5f1Z0Ws9MeUYC3CEM0cdoXr9wCZLLOn69Dgu4IF66nSN
	 JP3cZ/Mq8J51HMkJ6Ft06fZANE/7IKGIRMot7oYbUS+SvfwkN2/lKgqkcCBIT1ZB/M
	 xv+qb2UafWdzw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B432ECE0CA6; Sat,  4 Oct 2025 02:47:08 -0700 (PDT)
Date: Sat, 4 Oct 2025 02:47:08 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, kernel test robot <oliver.sang@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 02/21] rcu: Re-implement RCU Tasks Trace in terms of
 SRCU-fast
Message-ID: <d24f3987-48de-43e3-a841-2a116ac6d5c7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
 <20251001144832.631770-2-paulmck@kernel.org>
 <aN6eQuTbdwAAhxIj@localhost.localdomain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aN6eQuTbdwAAhxIj@localhost.localdomain>

On Thu, Oct 02, 2025 at 05:46:10PM +0200, Frederic Weisbecker wrote:
> Le Wed, Oct 01, 2025 at 07:48:13AM -0700, Paul E. McKenney a écrit :
> > This commit saves more than 500 lines of RCU code by re-implementing
> > RCU Tasks Trace in terms of SRCU-fast.  Follow-up work will remove
> > more code that does not cause problems by its presence, but that is no
> > longer required.
> > 
> > This variant places smp_mb() in rcu_read_{,un}lock_trace(), which will
> > be removed on common-case architectures in a later commit.
> 
> The changelog doesn't mention what this is ordering :-)

"The ordering that dare not be named"?  ;-)

How about like this for that second paragraph?

	This variant places smp_mb() in rcu_read_{,un}lock_trace(),
	which will be removed on common-case architectures in a
	later commit.  In the meantime, it serves to enforce ordering
	between the underlying srcu_read_{,un}lock_fast() markers and
	the intervening critical section, even on architectures that
	permit attaching tracepoints on regions of code not watched
	by RCU.  Such architectures defeat SRCU-fast's use of implicit
	single-instruction, interrupts-disabled, and atomic-operation
	RCU read-side critical sections, which have no effect when RCU is
	not watching.  The aforementioned later commit will insert these
	smp_mb() calls only on architectures that have not used noinstr to
	prevent attaching tracepoints to code where RCU is not watching.

> > [ paulmck: Apply kernel test robot, Boqun Feng, and Zqiang feedback. ]
> > [ paulmck: Split out Tiny SRCU fixes per Andrii Nakryiko feedback. ]
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Tested-by: kernel test robot <oliver.sang@intel.com>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: <bpf@vger.kernel.org>
> > ---
> [...]
> > @@ -50,12 +50,14 @@ static inline void rcu_read_lock_trace(void)
> >  {
> >  	struct task_struct *t = current;
> >  
> > -	WRITE_ONCE(t->trc_reader_nesting, READ_ONCE(t->trc_reader_nesting) + 1);
> > -	barrier();
> > -	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) &&
> > -	    t->trc_reader_special.b.need_mb)
> > -		smp_mb(); // Pairs with update-side barriers
> > -	rcu_lock_acquire(&rcu_trace_lock_map);
> > +	if (t->trc_reader_nesting++) {
> > +		// In case we interrupted a Tasks Trace RCU reader.
> > +		rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map);
> > +		return;
> > +	}
> > +	barrier();  // nesting before scp to protect against interrupt handler.
> > +	t->trc_reader_scp = srcu_read_lock_fast(&rcu_tasks_trace_srcu_struct);
> > +	smp_mb(); // Placeholder for more selective ordering
> 
> Mysterious :-)

Does the reworked commit-log paragraph help clear up this mystery?

> >  }
> >  
> >  /**
> > @@ -69,26 +71,75 @@ static inline void rcu_read_lock_trace(void)
> >   */
> >  static inline void rcu_read_unlock_trace(void)
> >  {
> > -	int nesting;
> > +	struct srcu_ctr __percpu *scp;
> >  	struct task_struct *t = current;
> >  
> > -	rcu_lock_release(&rcu_trace_lock_map);
> > -	nesting = READ_ONCE(t->trc_reader_nesting) - 1;
> > -	barrier(); // Critical section before disabling.
> > -	// Disable IPI-based setting of .need_qs.
> > -	WRITE_ONCE(t->trc_reader_nesting, INT_MIN + nesting);
> > -	if (likely(!READ_ONCE(t->trc_reader_special.s)) || nesting) {
> > -		WRITE_ONCE(t->trc_reader_nesting, nesting);
> > -		return;  // We assume shallow reader nesting.
> > -	}
> > -	WARN_ON_ONCE(nesting != 0);
> > -	rcu_read_unlock_trace_special(t);
> > +	smp_mb(); // Placeholder for more selective ordering
> 
> Bizarre :-)

And this bizarreness?  ;-)

> > +	scp = t->trc_reader_scp;
> > +	barrier();  // scp before nesting to protect against interrupt handler.
> 
> What is it protecting against interrupt?

The incrementing of ->trc_reader_nesting vs the fetch of ->trc_reader_scp.

							Thanx, Paul

> > +	if (!--t->trc_reader_nesting)
> > +		srcu_read_unlock_fast(&rcu_tasks_trace_srcu_struct, scp);
> > +	else
> > +		srcu_lock_release(&rcu_tasks_trace_srcu_struct.dep_map);
> > +}
> 
> Thanks (very happy to see all the rest of the code going away!)
> 
> -- 
> Frederic Weisbecker
> SUSE Labs

