Return-Path: <bpf+bounces-22879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE43686B222
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 15:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CE5BB248BB
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 14:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D76C15B961;
	Wed, 28 Feb 2024 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4Z9GmA0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E00158D95;
	Wed, 28 Feb 2024 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131425; cv=none; b=FBS1RjeU33IPZQs0Bz725OCa3CxT77XuzOZK30x8LPrgUxp73OTgOSbCFjSD4N1mXCj405Y7BsDPGnRMoBHMVaF1RQkP+wU5Pu3ZtMUjXK4326V3mUYgINOmxg4oe97lpq6P1YCT6RvpuWAl5KTFgdEpXgtZ++TcXreIwlpAWqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131425; c=relaxed/simple;
	bh=wvEapABnIlz3cWAlJclMlhGCT209K3a/fzamCpEyPdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajcY4byRkY/3sh/tyiIwNyysZehxSJE8oV03pzV+ASrz3GNRKD6euPbQd1x950byC0Lo+ApIdvAcn5p5A+AJs2K1KctjFflaCPr6RvLjc9sWQl965gYDTqkMSscl1quxAilxJsMaxaC4zyiXi3WWJbj2rDHZzmII8YSdteVbdQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4Z9GmA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D85C433C7;
	Wed, 28 Feb 2024 14:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709131425;
	bh=wvEapABnIlz3cWAlJclMlhGCT209K3a/fzamCpEyPdQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n4Z9GmA0bQq97/493YJupgjJBZsDOPLYgiZML8s/f0fQ1rBOqUaSOR7in+Q3338N8
	 o0Z2vXW1+8p9G14v+gzNL9hzT+MQCc0qRu9UqDdPD9ut88cgy/tp4ojSBggScSh5Xr
	 V4dfQy6Ev21c5onwhuhpFpoQio/iQzzdIm3RWPVPTCBBA0+Z2hMkQrRQ99zCX+ZpLn
	 vgeWznAeQ2hElj3Daj7RX5MvNNWnaQx4ionAbDW7p9cPlul2mxdTJMMXyp+lgpp78r
	 PTGq4TcgNbb/yehJy0dc6eZgk6Kljka29fsGTO0eV3f4D6AiG1JeAKvZfloWAVYMlr
	 62rumrOhqKlpA==
Date: Wed, 28 Feb 2024 06:43:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Yan Zhai <yan@cloudflare.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Simon Horman
 <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang
 <weiwan@google.com>, Alexander Duyck <alexanderduyck@fb.com>, Hannes
 Frederic Sowa <hannes@stressinduktion.org>, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, bpf@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
Message-ID: <20240228064343.578a5363@kernel.org>
In-Reply-To: <66a81295-ab6f-41f4-a3da-8b5003634c6a@paulmck-laptop>
References: <Zd4DXTyCf17lcTfq@debian.debian>
	<CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
	<d633c5b9-53a5-4cd6-9dbb-6623bb74c00b@paulmck-laptop>
	<20240227191001.0c521b03@kernel.org>
	<66a81295-ab6f-41f4-a3da-8b5003634c6a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Feb 2024 20:42:24 -0800 Paul E. McKenney wrote:
> On Tue, Feb 27, 2024 at 07:10:01PM -0800, Jakub Kicinski wrote:
> > On Tue, 27 Feb 2024 10:32:22 -0800 Paul E. McKenney wrote:  
> > > The theory is that PREEMPT_RCU kernels have preemption, and get their
> > > quiescent states that way.  
> > 
> > But that doesn't work well enough?
> > 
> > Assuming that's the case why don't we add it with the inverse ifdef
> > condition next to the cond_resched() which follows a few lines down?
> > 
> > 			skb_defer_free_flush(sd);
> > +
> > +			if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> > +				rcu_softirq_qs();
> > +
> > 			local_bh_enable();
> > 
> > 			if (!repoll)
> > 				break;
> > 
> > 			cond_resched();
> > 		}
> > 
> > We won't repoll majority of the time.  
> 
> I am not completely clear on what you are proposing, but one complication
> is that We need preemption disabled across calls to rcu_softirq_qs()
> and we cannot have preemption disabled across calls to cond_resched().

I was thinking of using rcu_all_qs(), like cond_resched() does.
Not sure how it compares in terms of functionality and cost.

> Another complication is that although CONFIG_PREEMPT_RT kernels are
> built with CONFIG_PREEMPT_RCU, the reverse is not always the case.
> And if we are not repolling, don't we have a high probability of doing
> a voluntary context when we reach napi_thread_wait() at the beginning
> of that loop?

Very much so, which is why adding the cost of rcu_softirq_qs()
for every NAPI run feels like an overkill.

