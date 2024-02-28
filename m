Return-Path: <bpf+bounces-22838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2455C86A7A7
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 05:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3703289B4A
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 04:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F65B21105;
	Wed, 28 Feb 2024 04:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjDPcJWB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8127720DFD;
	Wed, 28 Feb 2024 04:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709095346; cv=none; b=JEqxT8GADVo84KTeO6us+ClptTh2ZLLbynl7SDeP20JPD3mT64x1wAgyqk2vnBIkEhEbT8v5BCEfb5FrWYJPAk6nVNPT04W6ook2skQcwXOVfA0HHNrgtYO2UwUfOBBviqnuPEFLqUJejlV6DxdoW/esZo4FvJRPI+FI9fxBGZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709095346; c=relaxed/simple;
	bh=mHd/KQs2I6DtcTXYUjb2qGOo80+cn1MWMpEjtSlbgWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/XaYlUKnfKWu5FQ8U522YyzndQN4BYY5DQbUR5nacx5aEMCxxSNkvbJd6jmZZbsLIAG/6H421FMd2OkjC/0I2qIBln8D0B+dELRXlZGLjaeykIJpJhdib2ZXwAhRjhd6Jzp95s2rOM8zEnTt0NEyEDNkm4QfN3SpJR2ABncybI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjDPcJWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C45C43390;
	Wed, 28 Feb 2024 04:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709095345;
	bh=mHd/KQs2I6DtcTXYUjb2qGOo80+cn1MWMpEjtSlbgWg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=bjDPcJWBRSScqEAHFdMNHIvdus7GT20rmgdWQlLM6komppf0OM9pXAtksqKLXpO5X
	 sF/lPVh6a0C+tvwD5qQzR4k0bhKYjTiNkVJoihwKgob+xq0QzEjpgbAsN+l506CarJ
	 8qf8m2m21wgxOJMZQE1AHU0DF6xc9R8vxZlvvU5OKRsXZMeAc7DocSr7RTsP1qBcIQ
	 szC+Z2RO5Jlei1nuFHhCeKKWnZTjczypK+blhtyu07FKHs1JdOktWgYXWbDJSYDqzH
	 mYLrFKMyYTRynVYd+qaq3oYVvC8755GzhGLuu3PVxgN/ThoAQdefhjgb/t1j1MzgGs
	 fvOLvQJ0twNdw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D86F5CE088C; Tue, 27 Feb 2024 20:42:24 -0800 (PST)
Date: Tue, 27 Feb 2024 20:42:24 -0800
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
Message-ID: <66a81295-ab6f-41f4-a3da-8b5003634c6a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <Zd4DXTyCf17lcTfq@debian.debian>
 <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
 <d633c5b9-53a5-4cd6-9dbb-6623bb74c00b@paulmck-laptop>
 <20240227191001.0c521b03@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227191001.0c521b03@kernel.org>

On Tue, Feb 27, 2024 at 07:10:01PM -0800, Jakub Kicinski wrote:
> On Tue, 27 Feb 2024 10:32:22 -0800 Paul E. McKenney wrote:
> > > > +                       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> > > > +                               rcu_softirq_qs();
> > > > +
> > > >                         local_bh_enable();
> > > >
> > > >                         if (!repoll)
> > >
> > > Hmm....
> > > Why napi_busy_loop() does not have a similar problem ?
> > > 
> > > It is unclear why rcu_all_qs() in __cond_resched() is guarded by
> > > 
> > > #ifndef CONFIG_PREEMPT_RCU
> > >      rcu_all_qs();
> > > #endif  
> > 
> > The theory is that PREEMPT_RCU kernels have preemption, and get their
> > quiescent states that way.
> 
> But that doesn't work well enough?
> 
> Assuming that's the case why don't we add it with the inverse ifdef
> condition next to the cond_resched() which follows a few lines down?
> 
> 			skb_defer_free_flush(sd);
> +
> +			if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +				rcu_softirq_qs();
> +
> 			local_bh_enable();
> 
> 			if (!repoll)
> 				break;
> 
> 			cond_resched();
> 		}
> 
> We won't repoll majority of the time.

I am not completely clear on what you are proposing, but one complication
is that We need preemption disabled across calls to rcu_softirq_qs()
and we cannot have preemption disabled across calls to cond_resched().
Another complication is that although CONFIG_PREEMPT_RT kernels are
built with CONFIG_PREEMPT_RCU, the reverse is not always the case.
And if we are not repolling, don't we have a high probability of doing
a voluntary context when we reach napi_thread_wait() at the beginning
of that loop?

All in all, I suspect that I am missing your point.

							Thanx, Paul

