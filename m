Return-Path: <bpf+bounces-22939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9EE86BAA8
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480B028BB58
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 22:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B801361D0;
	Wed, 28 Feb 2024 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeJJq6/z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178401361B4;
	Wed, 28 Feb 2024 22:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709158752; cv=none; b=OXJcvcQoQLrO6jbI/DAEYGrvw+isZhbHY1WOuiysyWxabXGp4JR7NRuKAzCeQ6QOb0UxAh8t1M2ncxeyygrf6/oQxONUhOR1h0FtdllKM6Ht9LQD10s2g94gR1ZEos0AvoKIWmipbCRqn5sJvDb/4NJi5/pKI6jzd08lRzPw7dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709158752; c=relaxed/simple;
	bh=+7apalvwMqyqMX/hzGj7jyyLU7wXZnb5wwBuDuGCTvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OerYC1JI2tPPV7vjlJWZHd53WMimIOrktP/bLlmoL0rdbsWqs3eoJzXiJsyiXbGYdwpqmP30sF1Jnlk3G9xJ71tEnIy9eivPKFRncxPb7iaEIyNcaqJtVDL6ZgaW6ULve4woFH9u2sqwJUyj8IwHRrriN6T1TbkifRCNt8Y2LnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeJJq6/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8F3C433F1;
	Wed, 28 Feb 2024 22:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709158751;
	bh=+7apalvwMqyqMX/hzGj7jyyLU7wXZnb5wwBuDuGCTvg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=SeJJq6/zJx9VFse1Hh68yaTtcJSIbzhHZ6qWme6W8kJhvsIQ9V087qEaLI4qJ7wrX
	 m2pXtYu2NQu9j4CdSn3ctSLt/SrrBPbxtmfr6Zr7ox7NYxuRzZr0sO20yqZR1Kb6JH
	 TYl6TfF+3VetCBZORgWex4m37uKlpwjSC8iaW/rX5MEg9ElzQL2YZceSf4V29M7uZJ
	 aaF9QuFszfBfEuqP75u1oRuZIu3YKL46Nz4Hzp47e2TVyfJLdbrjjdGcQaUddbnVHE
	 UcDbkhjC6Cda7YDVkCoN8WIJ2y/VysMEFsOjCuW6Z+tUwUjIWD2Togw+VHLcn+hbGw
	 Er7cjjH5iwFtA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 518FDCE0F91; Wed, 28 Feb 2024 14:19:11 -0800 (PST)
Date: Wed, 28 Feb 2024 14:19:11 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Yan Zhai <yan@cloudflare.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
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
Message-ID: <ba95955d-b63d-4670-b947-e77b740b1a49@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <02913b40-7b74-48b3-b15d-53133afd3ba6@paulmck-laptop>
 <3D27EFEF-0452-4555-8277-9159486B41BF@joelfernandes.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3D27EFEF-0452-4555-8277-9159486B41BF@joelfernandes.org>

On Wed, Feb 28, 2024 at 05:10:43PM -0500, Joel Fernandes wrote:
> 
> 
> > On Feb 28, 2024, at 4:52 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > ﻿On Wed, Feb 28, 2024 at 04:27:47PM -0500, Joel Fernandes wrote:
> >> 
> >> 
> >>>> On Feb 28, 2024, at 4:13 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> >>> 
> >>> ﻿On Wed, Feb 28, 2024 at 03:14:34PM -0500, Joel Fernandes wrote:
> >>>>> On Wed, Feb 28, 2024 at 12:18 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >>>>> 
> >>>>> On Wed, Feb 28, 2024 at 10:37:51AM -0600, Yan Zhai wrote:
> >>>>>> On Wed, Feb 28, 2024 at 9:37 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >>>>>>> Also optionally, I wonder if calling rcu_tasks_qs() directly is better
> >>>>>>> (for documentation if anything) since the issue is Tasks RCU specific. Also
> >>>>>>> code comment above the rcu_softirq_qs() call about cond_resched() not taking
> >>>>>>> care of Tasks RCU would be great!
> >>>>>>> 
> >>>>>> Yes it's quite surprising to me that cond_resched does not help here,
> >>>>> 
> >>>>> In theory, it would be possible to make cond_resched() take care of
> >>>>> Tasks RCU.  In practice, the lazy-preemption work is looking to get rid
> >>>>> of cond_resched().  But if for some reason cond_resched() needs to stay
> >>>>> around, doing that work might make sense.
> >>>> 
> >>>> In my opinion, cond_resched() doing Tasks-RCU QS does not make sense
> >>>> (to me), because cond_resched() is to inform the scheduler to run
> >>>> something else possibly of higher priority while the current task is
> >>>> still runnable. On the other hand, what's not permitted in a Tasks RCU
> >>>> reader is a voluntary sleep. So IMO even though cond_resched() is a
> >>>> voluntary call, it is still not a sleep but rather a preemption point.
> >>> 
> >>> From the viewpoint of Task RCU's users, the point is to figure out
> >>> when it is OK to free an already-removed tracing trampoline.  The
> >>> current Task RCU implementation relies on the fact that tracing
> >>> trampolines do not do voluntary context switches.
> >> 
> >> Yes.
> >> 
> >>> 
> >>>> So a Tasks RCU reader should perfectly be able to be scheduled out in
> >>>> the middle of a read-side critical section (in current code) by
> >>>> calling cond_resched(). It is just like involuntary preemption in the
> >>>> middle of a RCU reader, in disguise, Right?
> >>> 
> >>> You lost me on this one.  This for example is not permitted:
> >>> 
> >>>   rcu_read_lock();
> >>>   cond_resched();
> >>>   rcu_read_unlock();
> >>> 
> >>> But in a CONFIG_PREEMPT=y kernel, that RCU reader could be preempted.
> >>> 
> >>> So cond_resched() looks like a voluntary context switch to me.  Recall
> >>> that vanilla non-preemptible RCU will treat them as quiescent states if
> >>> the grace period extends long enough.
> >>> 
> >>> What am I missing here?
> >> 
> >> That we are discussing Tasks-RCU read side section? Sorry I should have been more clear. I thought sleeping was not permitted in Tasks RCU reader, but non-sleep context switches (example involuntarily getting preempted were).
> > 
> > Well, to your initial point, cond_resched() does eventually invoke
> > preempt_schedule_common(), so you are quite correct that as far as
> > Tasks RCU is concerned, cond_resched() is not a quiescent state.
> 
>  Thanks for confirming. :-)

However, given that the current Tasks RCU use cases wait for trampolines
to be evacuated, Tasks RCU could make the choice that cond_resched()
be a quiescent state, for example, by adjusting rcu_all_qs() and
.rcu_urgent_qs accordingly.

But this seems less pressing given the chance that cond_resched() might
go away in favor of lazy preemption.

							Thanx, Paul

