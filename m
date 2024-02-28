Return-Path: <bpf+bounces-22881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AA586B2E7
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 16:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4DF287B50
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 15:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A267A15B993;
	Wed, 28 Feb 2024 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2qlz3Hk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5DA145351;
	Wed, 28 Feb 2024 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133343; cv=none; b=A3gmjVa/abASf0MMfMxzRfOjZjnDVfNvcqLuSkBjXIGJjzhEJ8dFAZKkBFSYpOg82iGXyxM9t7feh4pSFbi+mlhbuCYBLxPvbCeKtOL8f+xsjmwtCAc/+GxTPE1nnLJmf7Gkk7CJ51ZkF5qVPEQZwz1JjiOnmmbW7Vo6ywAyyHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133343; c=relaxed/simple;
	bh=n/a5TZj5zgQAI3QJKUDFCp6oKQYRJ0TA2PQIbSDat8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XARBZWyYG0W+7z1MPg2T4dcfUYUQIXpsr06amYosxEqgV/nzlA6KKpz5v8UJFHW5n0vI3hYRibUJsyZ005gl3T7kHx7DzJYdHZWqA7m1fvf6hZx1+p/bbZYIyA3TOv8sFetFG73/HFWviFGeCtdCQI5/ifQk1gAViQG79DJEs+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2qlz3Hk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC423C433C7;
	Wed, 28 Feb 2024 15:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709133342;
	bh=n/a5TZj5zgQAI3QJKUDFCp6oKQYRJ0TA2PQIbSDat8s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=K2qlz3HksEhthbbat+plgwHuxHT6aiChhK7Vizq9KHvm2FVTVy/18RqszB35y5VHx
	 leYHGqW3qlTX2Tommj2xmj+dYHsq6mbGZ4qzYLgz5phkXbsDfYNUcj6cxYls4IanVg
	 oXv08IelN8kPlZlesoWyA3ra1qS7rCTyajAKAoevQ97avzEyJBGgp/XWCAoj6VB+bu
	 UFe28JUHuWZ5WHgsOj1bTeHAr8yK0BiKDRoHZbYhI/skvnSDWXcYBWkWr/01KDHBy+
	 mJ2Q18mHoo/0Pn4O2jLFw7y5+5iCgjgOrkybM26bcrgN95zwghJGjLh0hSPsKzvk61
	 blAugI+UNlh+Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 53625CE074C; Wed, 28 Feb 2024 07:15:42 -0800 (PST)
Date: Wed, 28 Feb 2024 07:15:42 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Yan Zhai <yan@cloudflare.com>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
Message-ID: <9a0052f9-b022-42c9-a5da-1d6ca3b00885@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <Zd4DXTyCf17lcTfq@debian.debian>
 <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
 <d633c5b9-53a5-4cd6-9dbb-6623bb74c00b@paulmck-laptop>
 <20240227191001.0c521b03@kernel.org>
 <66a81295-ab6f-41f4-a3da-8b5003634c6a@paulmck-laptop>
 <20240228064343.578a5363@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228064343.578a5363@kernel.org>

On Wed, Feb 28, 2024 at 06:43:43AM -0800, Jakub Kicinski wrote:
> On Tue, 27 Feb 2024 20:42:24 -0800 Paul E. McKenney wrote:
> > On Tue, Feb 27, 2024 at 07:10:01PM -0800, Jakub Kicinski wrote:
> > > On Tue, 27 Feb 2024 10:32:22 -0800 Paul E. McKenney wrote:  
> > > > The theory is that PREEMPT_RCU kernels have preemption, and get their
> > > > quiescent states that way.  
> > > 
> > > But that doesn't work well enough?
> > > 
> > > Assuming that's the case why don't we add it with the inverse ifdef
> > > condition next to the cond_resched() which follows a few lines down?
> > > 
> > > 			skb_defer_free_flush(sd);
> > > +
> > > +			if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> > > +				rcu_softirq_qs();
> > > +
> > > 			local_bh_enable();
> > > 
> > > 			if (!repoll)
> > > 				break;
> > > 
> > > 			cond_resched();
> > > 		}
> > > 
> > > We won't repoll majority of the time.  
> > 
> > I am not completely clear on what you are proposing, but one complication
> > is that We need preemption disabled across calls to rcu_softirq_qs()
> > and we cannot have preemption disabled across calls to cond_resched().
> 
> I was thinking of using rcu_all_qs(), like cond_resched() does.
> Not sure how it compares in terms of functionality and cost.

It is probably a bit cheaper, but it does nothing for Tasks RCU.  And that
"_all" in the name is a holdover from when there were separate mechanisms
for bh, sched, and preempt, so maybe we should change that name.

> > Another complication is that although CONFIG_PREEMPT_RT kernels are
> > built with CONFIG_PREEMPT_RCU, the reverse is not always the case.
> > And if we are not repolling, don't we have a high probability of doing
> > a voluntary context when we reach napi_thread_wait() at the beginning
> > of that loop?
> 
> Very much so, which is why adding the cost of rcu_softirq_qs()
> for every NAPI run feels like an overkill.

Would it be better to do the rcu_softirq_qs() only once every 1000 times
or some such?  Or once every HZ jiffies?

Or is there a better way?

							Thanx, Paul

