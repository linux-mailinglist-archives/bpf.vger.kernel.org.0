Return-Path: <bpf+bounces-60343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A81AD5BEA
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 18:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB9218911FC
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 16:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0937B1E9B28;
	Wed, 11 Jun 2025 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5SsMI4P"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B121C245C;
	Wed, 11 Jun 2025 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658567; cv=none; b=jtKikx8w7cynSXCELLVmLOipcJ2nnS5JRFkyL5OIfjfAONWfhdtcWpt1nGak6izmW4/qxp+jZAwuNgUod0PXoIeDdBSvFwSdOpt6G+EKECRm0OStgvdvqUNHnseYgRBGRkx1TkaOsOj4eCNlkxM6v2MRHPkhcof+RxyPO5VPIPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658567; c=relaxed/simple;
	bh=lP9gzkyo2SB1Zb3WgBljR00/GqGDCXaDC6eCHABGu/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o921umo3csecHRLIqeT2MqAjEYevTTwVhdtZdSNs5sWuEEPOdV1jSxvVmyf1e+jEt50Kc8H86LaVyxPzyET43yKqCJp4PK34ETpd5ngrZxZZv9OtDHd98lmG9qUDn0W7QC+6zNewVqWamF8V1Ud09Xj6ONAQhbW8kk7zbGn2NvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5SsMI4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2080C4CEE3;
	Wed, 11 Jun 2025 16:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749658565;
	bh=lP9gzkyo2SB1Zb3WgBljR00/GqGDCXaDC6eCHABGu/g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=R5SsMI4PjouvkDrGKyT7rYg6I2zk1kU/066uUf22Y5Qq2bz16Q9mVgEPjq+saI8iu
	 rabL33lu8oioCvH40QgYvkfdqFEoZdHM8E7OntYjkgu6BYyc2y0FrTsW0TYqdXVssm
	 C6ixf4pQvhjL70k2NPWma65f1h44sIp7jt08tGqKDZc114WA6xFhebUJTKmzCr2QbY
	 nLSkMCq5UdiVEI/Gjfi2wSvzLs6pIBOuYGZcZsb4UKCG9O68NRomSOnLBnW7mHgmvl
	 8Oviy1ou7tHLrBJi8YZ6Kewx4K5xmGrm1wnah/H6y4MfS7Kgz0jNYVK1VorkT4EP0S
	 92Zn5hHap284g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7158BCE077D; Wed, 11 Jun 2025 09:16:05 -0700 (PDT)
Date: Wed, 11 Jun 2025 09:16:05 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Xiongfeng Wang <wangxiongfeng2@huawei.com>, rcu@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] rcu: Fix lockup when RCU reader used while IRQ
 exiting
Message-ID: <2a0902a7-852b-4868-b0c5-2a6962f273ed@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250609180125.2988129-1-joelagnelf@nvidia.com>
 <20250609180125.2988129-2-joelagnelf@nvidia.com>
 <aEmpMohtFsVf4Uh_@tardis.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEmpMohtFsVf4Uh_@tardis.local>

On Wed, Jun 11, 2025 at 09:05:06AM -0700, Boqun Feng wrote:
> On Mon, Jun 09, 2025 at 02:01:24PM -0400, Joel Fernandes wrote:
> > During rcu_read_unlock_special(), if this happens during irq_exit(), we
> > can lockup if an IPI is issued. This is because the IPI itself triggers
> > the irq_exit() path causing a recursive lock up.
> > 
> > This is precisely what Xiongfeng found when invoking a BPF program on
> > the trace_tick_stop() tracepoint As shown in the trace below. Fix by
> > using context-tracking to tell us if we're still in an IRQ.
> > context-tracking keeps track of the IRQ until after the tracepoint, so
> > it cures the issues.
> > 
> > irq_exit()
> >   __irq_exit_rcu()
> >     /* in_hardirq() returns false after this */
> >     preempt_count_sub(HARDIRQ_OFFSET)
> >     tick_irq_exit()
> 
> @Frederic, while we are at it, what's the purpose of in_hardirq() in
> tick_irq_exit()? For nested interrupt detection?

If you are talking about the comment, these sorts of comments help
people reading the code, the point being that some common-code function
that invokes in_hardirq() after that point will get the wrong answer
from it.  The context-tracking code does the same for whether or not
RCU is watching.

							Thanx, Paul

> Regards,
> Boqun
> 
> >       tick_nohz_irq_exit()
> > 	    tick_nohz_stop_sched_tick()
> > 	      trace_tick_stop()  /* a bpf prog is hooked on this trace point */
> > 		   __bpf_trace_tick_stop()
> > 		      bpf_trace_run2()
> > 			    rcu_read_unlock_special()
> >                               /* will send a IPI to itself */
> > 			      irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
> > 
> > A simple reproducer can also be obtained by doing the following in
> > tick_irq_exit(). It will hang on boot without the patch:
> > 
> >   static inline void tick_irq_exit(void)
> >   {
> >  +	rcu_read_lock();
> >  +	WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, true);
> >  +	rcu_read_unlock();
> >  +
> > 
> > While at it, add some comments to this code.
> > 
> > Reported-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> > Closes: https://lore.kernel.org/all/9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com/
> > Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> [...]

