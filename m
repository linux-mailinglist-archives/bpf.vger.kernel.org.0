Return-Path: <bpf+bounces-22946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AA286BB61
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F6B1C23C55
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 22:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3142472932;
	Wed, 28 Feb 2024 22:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YILRbG+K"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C69E1361D0;
	Wed, 28 Feb 2024 22:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161134; cv=none; b=Xd5UrYVZMDdQJt3c4bftSdqjVWCDbBsjjyQOw0RGQ5w4v+KY92O2lV7lDPQaM8m0roXTLlfeZ7E4VqedVf3QHxhj+NGGw8Csf9vg1uHqhy06sFozIQUa63NNa7Vrb8WeSkuAndFuUyXN9r64f8FjgoZLH4lRCwVFDduNk+Y+ssc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161134; c=relaxed/simple;
	bh=JxkkjdGFf/rPehnVheEO5cySQ/MvnKPHAt51ceI+tUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrtRjNvz7kV3JBNP4mAcxuUMas3TfHs+gyduXILUT2jC8cpd/BvHnFMwln5CKuzQZV8Dlvuen0gZ1rXmP4aadtUxAn46A0FFbm2IAzBP0eyOmctLD4cviUYK3icOLrUi5c+GTQKCvpyiqGVJC1wmUsyWvM8DmwZrrNwR/cWJ8Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YILRbG+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CBDC433F1;
	Wed, 28 Feb 2024 22:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709161134;
	bh=JxkkjdGFf/rPehnVheEO5cySQ/MvnKPHAt51ceI+tUI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=YILRbG+Kodk7xTlswzoQEZ9TF6XCGKOlWutaj4rhKtSkMEjm4xXdSQjLSLwtYVAzA
	 7qqEDv/OLK57bWSda4rfLtdQ/6gIA+A/k2SJA+h7fqxGv/FJupSq/95KQeppuZfo07
	 eMhC6K6qSy2mapQst4KdNGsixHapSUtiXRtM2m3dprBMKwrdjdO2e9vjzeFjywUzP0
	 gQMONVoFID9Bkdl3xbJ3UPC7UgxxbnW+YaHCjjKuhZviWzTXBRRhhnkWf1CdPY7B5U
	 bP+YEPsMBuJ+MSrQ7f1guWJ3+/hXe08hS0mRthTPb0+vzjMqb+gtL3xLT/zxjJbuC8
	 S3SqYbfb1O8xA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B8F37CE0F91; Wed, 28 Feb 2024 14:58:53 -0800 (PST)
Date: Wed, 28 Feb 2024 14:58:53 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Yan Zhai <yan@cloudflare.com>, Eric Dumazet <edumazet@google.com>,
	Network Development <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
	bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
Message-ID: <8ae889cb-ee1d-4c72-9414-e21258118ce3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <02913b40-7b74-48b3-b15d-53133afd3ba6@paulmck-laptop>
 <3D27EFEF-0452-4555-8277-9159486B41BF@joelfernandes.org>
 <ba95955d-b63d-4670-b947-e77b740b1a49@paulmck-laptop>
 <20240228173307.529d11ee@gandalf.local.home>
 <CAADnVQ+szRDGaDJPoBFR9KyeMjwpuxOCNys=yxDaCLYZkSkyYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+szRDGaDJPoBFR9KyeMjwpuxOCNys=yxDaCLYZkSkyYw@mail.gmail.com>

On Wed, Feb 28, 2024 at 02:48:44PM -0800, Alexei Starovoitov wrote:
> On Wed, Feb 28, 2024 at 2:31 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Wed, 28 Feb 2024 14:19:11 -0800
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >
> > > > >
> > > > > Well, to your initial point, cond_resched() does eventually invoke
> > > > > preempt_schedule_common(), so you are quite correct that as far as
> > > > > Tasks RCU is concerned, cond_resched() is not a quiescent state.
> > > >
> > > >  Thanks for confirming. :-)
> > >
> > > However, given that the current Tasks RCU use cases wait for trampolines
> > > to be evacuated, Tasks RCU could make the choice that cond_resched()
> > > be a quiescent state, for example, by adjusting rcu_all_qs() and
> > > .rcu_urgent_qs accordingly.
> > >
> > > But this seems less pressing given the chance that cond_resched() might
> > > go away in favor of lazy preemption.
> >
> > Although cond_resched() is technically a "preemption point" and not truly a
> > voluntary schedule, I would be happy to state that it's not allowed to be
> > called from trampolines, or their callbacks. Now the question is, does BPF
> > programs ever call cond_resched()? I don't think they do.
> >
> > [ Added Alexei ]
> 
> I'm a bit lost in this thread :)
> Just answering the above question.
> bpf progs never call cond_resched() directly.
> But there are sleepable (aka faultable) bpf progs that
> can call some helper or kfunc that may call cond_resched()
> in some path.
> sleepable bpf progs are protected by rcu_tasks_trace.
> That's a very different one vs rcu_tasks.

Suppose that the various cond_resched() invocations scattered throughout
the kernel acted as RCU Tasks quiescent states, so that as soon as a
given task executed a cond_resched(), synchronize_rcu_tasks() might
return or call_rcu_tasks() might invoke its callback.

Would that cause BPF any trouble?

My guess is "no", because it looks like BPF is using RCU Tasks (as you
say, as opposed to RCU Tasks Trace) only to wait for execution to leave a
trampoline.  But I trust you much more than I trust myself on this topic!

							Thanx, Paul

