Return-Path: <bpf+bounces-22924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E452186B9AF
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 22:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FF42B23AB5
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 21:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A278627D;
	Wed, 28 Feb 2024 21:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kqarl1gF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F27686264;
	Wed, 28 Feb 2024 21:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709154786; cv=none; b=qgEcygJnDxRSQ7S5e/z1X/rLlc3N2/94iDLEOvu7BTmK7itjcoPILL9MfdZ2wGy4K9q4hqgr6CteyoQa5b25FAk9lYGQ9Q99pxjeKkcD6SysOfL4uhWkMi7T6GiaLJrYLaymmsxOAM4xD6ZMJIbpqoSiom/UhgGoWz7JKXuroT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709154786; c=relaxed/simple;
	bh=bvfUvyOHM3B822eF9dQJqvD3Ut/r4uRrCEE6r01GjYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLRjYyRxbY9Z+Ux+AxqNb79w9wqIEGM9LPv644e5AOIVmVamNqowvuyx1P/HJtg0Hamj6RUWTeYmFLJEiMG9L6xizzQqLwvZhGft7gAlKtjeZHfnWJ6u0tqaWYGqtcNmBQizgJvl9bnfRQhsXQP0OJgDNiOSZI/JpTPbFXQYMI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kqarl1gF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B642EC433F1;
	Wed, 28 Feb 2024 21:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709154785;
	bh=bvfUvyOHM3B822eF9dQJqvD3Ut/r4uRrCEE6r01GjYw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Kqarl1gFzSFgUHKI4+aF3qtI9/m/lCwKKbHSTC+a6BfbeMn7aHR6zeCH+9a0Me85P
	 pCZ28Qjpv5qMPywj2dUTqIG9ZfJitSLdnM2COofeKn7SfJKBSfCN4/3zQj1i+1MP8U
	 bfWE19hieEH58AhQwv7wL40+2kX1PlCdCJ7oqk8Wn0PDjzOjUkRFZJIX++6DjqSto0
	 N3UvDPyxfiQ3/gh3gnK+p9tRK21b86MQ9nO/KmjAPTNdNQYe7wddoSlLw4//TLzwt5
	 BT5d2W6O2FuIEbXaKNjZmzu81bOV+9IqQHdnYscjwieDvq2OAB/0wcwdSV1VshZ8ey
	 tvqRwRGOjNAzg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4CC24CE03F3; Wed, 28 Feb 2024 13:13:05 -0800 (PST)
Date: Wed, 28 Feb 2024 13:13:05 -0800
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
Message-ID: <5b74968d-fe14-48b4-bb16-6cf098a04ca5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <Zd4DXTyCf17lcTfq@debian.debian>
 <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
 <d633c5b9-53a5-4cd6-9dbb-6623bb74c00b@paulmck-laptop>
 <f1d1e0fb-2870-4b8f-8936-881ac29a24f1@joelfernandes.org>
 <CAO3-Pboo32iQBBUHUELUkvvpSa=jZwUqefrwC-NBjDYx4yxYJQ@mail.gmail.com>
 <e592faa3-db99-4074-9492-3f9021b4350c@paulmck-laptop>
 <CAEXW_YRfjhBjsMpBEdCoLd2S+=5YdFSs2AS07xwN72bgtW4sDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YRfjhBjsMpBEdCoLd2S+=5YdFSs2AS07xwN72bgtW4sDQ@mail.gmail.com>

On Wed, Feb 28, 2024 at 03:14:34PM -0500, Joel Fernandes wrote:
> On Wed, Feb 28, 2024 at 12:18 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Feb 28, 2024 at 10:37:51AM -0600, Yan Zhai wrote:
> > > On Wed, Feb 28, 2024 at 9:37 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > Also optionally, I wonder if calling rcu_tasks_qs() directly is better
> > > > (for documentation if anything) since the issue is Tasks RCU specific. Also
> > > > code comment above the rcu_softirq_qs() call about cond_resched() not taking
> > > > care of Tasks RCU would be great!
> > > >
> > > Yes it's quite surprising to me that cond_resched does not help here,
> >
> > In theory, it would be possible to make cond_resched() take care of
> > Tasks RCU.  In practice, the lazy-preemption work is looking to get rid
> > of cond_resched().  But if for some reason cond_resched() needs to stay
> > around, doing that work might make sense.
> 
> In my opinion, cond_resched() doing Tasks-RCU QS does not make sense
> (to me), because cond_resched() is to inform the scheduler to run
> something else possibly of higher priority while the current task is
> still runnable. On the other hand, what's not permitted in a Tasks RCU
> reader is a voluntary sleep. So IMO even though cond_resched() is a
> voluntary call, it is still not a sleep but rather a preemption point.

From the viewpoint of Task RCU's users, the point is to figure out
when it is OK to free an already-removed tracing trampoline.  The
current Task RCU implementation relies on the fact that tracing
trampolines do not do voluntary context switches.

> So a Tasks RCU reader should perfectly be able to be scheduled out in
> the middle of a read-side critical section (in current code) by
> calling cond_resched(). It is just like involuntary preemption in the
> middle of a RCU reader, in disguise, Right?

You lost me on this one.  This for example is not permitted:

	rcu_read_lock();
	cond_resched();
	rcu_read_unlock();

But in a CONFIG_PREEMPT=y kernel, that RCU reader could be preempted.

So cond_resched() looks like a voluntary context switch to me.  Recall
that vanilla non-preemptible RCU will treat them as quiescent states if
the grace period extends long enough.

What am I missing here?

							Thanx, Paul

