Return-Path: <bpf+bounces-22937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3553D86BA3C
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 22:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56661F2395A
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 21:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CDF71EC5;
	Wed, 28 Feb 2024 21:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLaHDwKt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9AD8626B;
	Wed, 28 Feb 2024 21:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157168; cv=none; b=RskXWOd6qS8xnOW6jWqz2gbdmIpzyUaZ/7Lohop2QP2uHaBrZq7/mj6G2JjEzru7c8eZEhuZqKWKKfw09pguoydJzcDiEUfIFezbbkSXMuyXtFVXpmkj8toj9Bi0ogVIDoK3ACqwbm08V/jd+70pOrdCrN0uzhAMMx+Bi2Jc+30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157168; c=relaxed/simple;
	bh=hAcOllotrdS9EgbXpniA2u60AjkuJzxlibPgqmRp5RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQhVYPOURraOM0q+teg1NMGfbs0DJJpyAPWY72+GWiXcf6kx1T43bR1ih7UhZok7Byec3D2MbfT6l8+84nPXuUxrnJXOdi735YfejyZ3cpqaG7XBxR/MgLUhd7sAJnJIM7AuFTgfDMW8PplEGtkj/pDvAz/AbMTXlf63CV3FtbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLaHDwKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A58C433C7;
	Wed, 28 Feb 2024 21:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709157167;
	bh=hAcOllotrdS9EgbXpniA2u60AjkuJzxlibPgqmRp5RY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=lLaHDwKt8tLOjzfXjX8yc0frSG1xGDlhScvISRoLiQT6SPFNE24YbRAMdRpwJje9K
	 PquUXH3tCFSvpcUfXPV9KZJ/HEOuCpryiaA69DefTXlCKju/mJXR1ZorxfeIIUmevv
	 GIvopfoaSB5W7/qPG2R+lDCOhH9UjRvoc0p++yCogXsYIJ9DBJLzJB7S0JJACCyCA0
	 pwUJQOSaFEwmX2GHFMRCwTGv5F8tahd24SRZoMr1TF3UXd0MZhCqQWVA9nDSuS7J9e
	 /1fRnYja9aBcNhO4cWpsK5p7/k9Gm+gx2aPSpOMO519kcPptyPbYWrT0pdFpiKpLe1
	 aYSqPGW10F+EA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2B3D3CE0F91; Wed, 28 Feb 2024 13:52:47 -0800 (PST)
Date: Wed, 28 Feb 2024 13:52:47 -0800
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
Message-ID: <02913b40-7b74-48b3-b15d-53133afd3ba6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <5b74968d-fe14-48b4-bb16-6cf098a04ca5@paulmck-laptop>
 <4965F5CD-B33C-4B75-818A-021372020881@joelfernandes.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4965F5CD-B33C-4B75-818A-021372020881@joelfernandes.org>

On Wed, Feb 28, 2024 at 04:27:47PM -0500, Joel Fernandes wrote:
> 
> 
> > On Feb 28, 2024, at 4:13 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > ﻿On Wed, Feb 28, 2024 at 03:14:34PM -0500, Joel Fernandes wrote:
> >>> On Wed, Feb 28, 2024 at 12:18 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >>> 
> >>> On Wed, Feb 28, 2024 at 10:37:51AM -0600, Yan Zhai wrote:
> >>>> On Wed, Feb 28, 2024 at 9:37 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >>>>> Also optionally, I wonder if calling rcu_tasks_qs() directly is better
> >>>>> (for documentation if anything) since the issue is Tasks RCU specific. Also
> >>>>> code comment above the rcu_softirq_qs() call about cond_resched() not taking
> >>>>> care of Tasks RCU would be great!
> >>>>> 
> >>>> Yes it's quite surprising to me that cond_resched does not help here,
> >>> 
> >>> In theory, it would be possible to make cond_resched() take care of
> >>> Tasks RCU.  In practice, the lazy-preemption work is looking to get rid
> >>> of cond_resched().  But if for some reason cond_resched() needs to stay
> >>> around, doing that work might make sense.
> >> 
> >> In my opinion, cond_resched() doing Tasks-RCU QS does not make sense
> >> (to me), because cond_resched() is to inform the scheduler to run
> >> something else possibly of higher priority while the current task is
> >> still runnable. On the other hand, what's not permitted in a Tasks RCU
> >> reader is a voluntary sleep. So IMO even though cond_resched() is a
> >> voluntary call, it is still not a sleep but rather a preemption point.
> > 
> > From the viewpoint of Task RCU's users, the point is to figure out
> > when it is OK to free an already-removed tracing trampoline.  The
> > current Task RCU implementation relies on the fact that tracing
> > trampolines do not do voluntary context switches.
> 
> Yes.
> 
> > 
> >> So a Tasks RCU reader should perfectly be able to be scheduled out in
> >> the middle of a read-side critical section (in current code) by
> >> calling cond_resched(). It is just like involuntary preemption in the
> >> middle of a RCU reader, in disguise, Right?
> > 
> > You lost me on this one.  This for example is not permitted:
> > 
> >    rcu_read_lock();
> >    cond_resched();
> >    rcu_read_unlock();
> > 
> > But in a CONFIG_PREEMPT=y kernel, that RCU reader could be preempted.
> > 
> > So cond_resched() looks like a voluntary context switch to me.  Recall
> > that vanilla non-preemptible RCU will treat them as quiescent states if
> > the grace period extends long enough.
> > 
> > What am I missing here?
> 
> That we are discussing Tasks-RCU read side section? Sorry I should have been more clear. I thought sleeping was not permitted in Tasks RCU reader, but non-sleep context switches (example involuntarily getting preempted were).

Well, to your initial point, cond_resched() does eventually invoke
preempt_schedule_common(), so you are quite correct that as far as
Tasks RCU is concerned, cond_resched() is not a quiescent state.

						Thanx, Paul

