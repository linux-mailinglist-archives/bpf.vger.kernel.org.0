Return-Path: <bpf+bounces-22945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5458E86BAF4
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E777D1F22DF8
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 22:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2449972903;
	Wed, 28 Feb 2024 22:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDAiNwqx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902EA71EA1;
	Wed, 28 Feb 2024 22:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160556; cv=none; b=hMeB8ebCc6IhOom1dQ+2ee8amDRlyaXU07DIxJ9suRINd3mPRBcGomdH5EHzsuMTZfychG/rB9BFiXTjo/TZqrs6PrglImoGb9FpmVV0OvqF1nmrzJNX+TFx2JWoQIMIzogMk7YCmeVieLJYzxYNeKhLte3r2PZsTsSrVuZHU4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160556; c=relaxed/simple;
	bh=Pz9CnoezD/dgggmHZ3jrf8PSRKN8xh1HR0itqdgzHns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVAsTHNNAYMaopIHEtktVusp21OPPnHxD8xQFwpmAOT1GoefmvuZVkSeFf1OPncucDCL+kY7hhEiCkX5XSLPsgB32JeVtTPyqEpyJiYDhGJ6OQ7ZkKkxwwfVon9WjaVC8CCA9ebo+jWHxSdmPx6eJq6r01tYZF/lMlafVl+Lo94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDAiNwqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1718AC433C7;
	Wed, 28 Feb 2024 22:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709160556;
	bh=Pz9CnoezD/dgggmHZ3jrf8PSRKN8xh1HR0itqdgzHns=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=DDAiNwqx+QFzs0aDq1cZJl97xgt+E/dg1Af4G2GKL33IXpDj8V3cWpBUTpQaAEbA8
	 8BdPe8jeJKVBgwhxZM8YwycQ0CBjFu5d+dQZgPntkoQraatbu+xNqN5kQE/W7yDZO9
	 EnKx/GLbjSM5KEff5lED6jUWU7OGdi67V4i96UO/QM//7NEBrh68n7nBTg+R/BpEub
	 ILiifH/zub8EF+lKJ/MoYHWDVv1B7d4qpUrwi3McsbgFZk/+/qelCZ1AzjVTkY9PnT
	 Av7XpO6wqlQceFttGkfsj419JZadiMHwaj9oVmz9xVARRlpDwVwgKNNaqN7/P7lap6
	 HR2r3PUBnRvqQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A9DFFCE0F91; Wed, 28 Feb 2024 14:49:15 -0800 (PST)
Date: Wed, 28 Feb 2024 14:49:15 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, Yan Zhai <yan@cloudflare.com>,
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
	mark.rutland@arm.com,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
Message-ID: <1880cb02-d259-46d8-b4f7-0b3e2e0f0745@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <02913b40-7b74-48b3-b15d-53133afd3ba6@paulmck-laptop>
 <3D27EFEF-0452-4555-8277-9159486B41BF@joelfernandes.org>
 <ba95955d-b63d-4670-b947-e77b740b1a49@paulmck-laptop>
 <20240228173307.529d11ee@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228173307.529d11ee@gandalf.local.home>

On Wed, Feb 28, 2024 at 05:33:07PM -0500, Steven Rostedt wrote:
> On Wed, 28 Feb 2024 14:19:11 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > > 
> > > > Well, to your initial point, cond_resched() does eventually invoke
> > > > preempt_schedule_common(), so you are quite correct that as far as
> > > > Tasks RCU is concerned, cond_resched() is not a quiescent state.  
> > > 
> > >  Thanks for confirming. :-)  
> > 
> > However, given that the current Tasks RCU use cases wait for trampolines
> > to be evacuated, Tasks RCU could make the choice that cond_resched()
> > be a quiescent state, for example, by adjusting rcu_all_qs() and
> > .rcu_urgent_qs accordingly.
> > 
> > But this seems less pressing given the chance that cond_resched() might
> > go away in favor of lazy preemption.
> 
> Although cond_resched() is technically a "preemption point" and not truly a
> voluntary schedule, I would be happy to state that it's not allowed to be
> called from trampolines, or their callbacks. Now the question is, does BPF
> programs ever call cond_resched()? I don't think they do.

Nor do I, but I too must defer to Alexei.  ;-)

> [ Added Alexei ]

The other issue with making cond_resched() be a Tasks RCU quiescent
state is that the CONFIG_PREEMPTION=y version of cond_resched() would
need to stop being a complete no-op.  Which actually might be OK.

							Thanx, Paul

