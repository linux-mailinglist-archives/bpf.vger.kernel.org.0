Return-Path: <bpf+bounces-22890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B97A86B5BA
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 18:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48691288FB0
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 17:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1AE15A4A3;
	Wed, 28 Feb 2024 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAX+x29n"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77E73FBB9;
	Wed, 28 Feb 2024 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140726; cv=none; b=JUi7WGAsQoPh2yzLn57yXqvuNPt8zQJrbVXhIb9YeDjYgIJgW5dMejqMjmDVsYadc0thg8epEeqs7pZ5k/9bXpvzAkGyfQRipFM+86u05dgo7a7QFqnVL/vQbmHslFJP/OjBG1HYk8W+mhK4M7pOu4Ibx4jvwJY7FcO/suzxDaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140726; c=relaxed/simple;
	bh=7Np/zr7DLGjyYYuEcCZgtLSlELCkIkd/WVEd69z0kMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlNhS5cv4yPn2aaKHaYgbeTUSzgNAYC11WAM7qpT5Ze5wk9Lig2uUDIlUtOFAhW+LeJBDjxvVhsR7bwN5w6H/J9/dwa9ovm8df6gOObxeIJtoa3FJx3ZZ3uCoUFAOBeSebsxLNBSK9a1JL4MsH42zhEP8O/BdTvI22Kk4+LiGO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAX+x29n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E491C433F1;
	Wed, 28 Feb 2024 17:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709140726;
	bh=7Np/zr7DLGjyYYuEcCZgtLSlELCkIkd/WVEd69z0kMc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=VAX+x29njD0xyB/7dX1OBluP0fZD01XLb/o6qWLQZ2NdW1DHt1rHYqynOg+cg78KY
	 MdOE7NTHMQqZWU5MV7j2CL/6pBhnQVQYkThsu1lLFcoT9f6/oS+NE/iLkfE5MfmT5g
	 APD05lDataW1ksboB3PUyNrEKksUgdQHHrz09vHuVrhpkr0i2ty2ZJdKY+qCL/859/
	 R8a9UB3WItSLzZvXj2HRRqv0ydrN849cM1ZV75tfsT7nwMWfvN8vbakpXb6GqIT2bl
	 MVOQ52AXKs/rtcGOtf7eX0I3gfZgZfcPWHQHBe6g8sjTE3fUUYT7uZJ2jM3wbTpUrM
	 glSDi+5RaFrRQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BEA77CE0350; Wed, 28 Feb 2024 09:18:45 -0800 (PST)
Date: Wed, 28 Feb 2024 09:18:45 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Yan Zhai <yan@cloudflare.com>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com,
	rostedt@goodmis.org, mark.rutland@arm.com
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
Message-ID: <e592faa3-db99-4074-9492-3f9021b4350c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <Zd4DXTyCf17lcTfq@debian.debian>
 <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
 <d633c5b9-53a5-4cd6-9dbb-6623bb74c00b@paulmck-laptop>
 <f1d1e0fb-2870-4b8f-8936-881ac29a24f1@joelfernandes.org>
 <CAO3-Pboo32iQBBUHUELUkvvpSa=jZwUqefrwC-NBjDYx4yxYJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO3-Pboo32iQBBUHUELUkvvpSa=jZwUqefrwC-NBjDYx4yxYJQ@mail.gmail.com>

On Wed, Feb 28, 2024 at 10:37:51AM -0600, Yan Zhai wrote:
> On Wed, Feb 28, 2024 at 9:37 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > Also optionally, I wonder if calling rcu_tasks_qs() directly is better
> > (for documentation if anything) since the issue is Tasks RCU specific. Also
> > code comment above the rcu_softirq_qs() call about cond_resched() not taking
> > care of Tasks RCU would be great!
> >
> Yes it's quite surprising to me that cond_resched does not help here,

In theory, it would be possible to make cond_resched() take care of
Tasks RCU.  In practice, the lazy-preemption work is looking to get rid
of cond_resched().  But if for some reason cond_resched() needs to stay
around, doing that work might make sense.

> I will include that comment. Raising just the task RCU QS seems
> sufficient to the problem we encountered. But according to commit
> d28139c4e967 ("rcu: Apply RCU-bh QSes to RCU-sched and RCU-preempt
> when safe"), there might be additional threat factor in __do_softirq
> that also applies to threaded poll.

We did look into more focused alternatives for Tasks RCU a few days ago,
but they all had problems, for example, requiring that it be possible
to get exact information on the instruction pointers for interrupts on
any given CPU's stack.  The key point of Tasks RCU is to work out when
an old tracing trampoline may safely be freed, so a better way of doing
that would remove the need for this sort of addition to NAPI polling.

(Adding Steve and Mark for their thoughts.)

							Thanx, Paul

> Yan
> 
> 
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >
> > thanks,
> >
> >  - Joel
> > [1]
> > @@ -381,8 +553,10 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
> >                 pending >>= softirq_bit;
> >         }
> >
> > -       if (__this_cpu_read(ksoftirqd) == current)
> > +       if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> > +           __this_cpu_read(ksoftirqd) == current)
> >                 rcu_softirq_qs();
> > +
> >         local_irq_disable();

