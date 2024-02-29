Return-Path: <bpf+bounces-23059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 628E886CFF0
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 18:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8612B1C22298
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 17:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16D9757E6;
	Thu, 29 Feb 2024 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChYI0Izp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458D04AECA;
	Thu, 29 Feb 2024 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225828; cv=none; b=P9MHXHKIt4g6kiEYGOPOEM7hw62/jnjDercmNhO5wio0s20CUYIb1YqhEMyg2q3FAo6aHYD9vPpRsNkHIpcbJwqFKqBCHobMyC8woZC8yC5PfC0tVNlDI+ZautRmVcrtYd3zcjHHZ/xL+AqVhbJLsRy8Vs0lt8forOLRQSMB/XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225828; c=relaxed/simple;
	bh=Mwc8vNp+uod54n1G0L5TDfKxmF1IHGJ1xIbnsW3iay4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6qVWQ5CEVYR9+HvbSl7i/WZEXJDpBnhOcRl9ZWMrKg3AUOrMu8F3m77FVKhEt1XtvKET4lsnmOS5dzpTJy4RLofgNj4du+WFyX0l3Vgh0+9xsDKoGlkrKUlN+83pQmolp8kFhh30y/3kxhfnHEI4FLRcA0TXavWpwN/6XUtmqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChYI0Izp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7DAC433F1;
	Thu, 29 Feb 2024 16:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709225827;
	bh=Mwc8vNp+uod54n1G0L5TDfKxmF1IHGJ1xIbnsW3iay4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ChYI0Izpo0ktPuD4KG2X/yX16oi6tuLY10Q9/6jSNsqXSGeF7eaifXryORkS7c+mW
	 cziaoYXUMWtTDW3EJAcmL1i67/U8mXCXgyjqpojAlwHpaU9Mbk0CSHw86LLa4dWa4b
	 RpQPrsPvx56wayKNkkqAiJZgcNt2hhtKOlvUAcHBWBdmBmV8jR74rmrpWbrXmFofcJ
	 sfdFIz14cK0wLBpjC09qmVaZ6a19d+hbql12/3zcDELL4gosCQU5gFfmWDgzn7XM48
	 It0/2Ty27HpMKTZUQmpDwhNYNj7ZaxXMgR7VnbBlnbSKV7sDzrcjkAmp19pJUbI/G9
	 1GwJOE0rCVxqQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3BF06CE1382; Thu, 29 Feb 2024 08:57:07 -0800 (PST)
Date: Thu, 29 Feb 2024 08:57:07 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, Yan Zhai <yan@cloudflare.com>,
	Eric Dumazet <edumazet@google.com>,
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
Message-ID: <55900c6a-f181-4c5c-8de2-bca640c4af3e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <02913b40-7b74-48b3-b15d-53133afd3ba6@paulmck-laptop>
 <3D27EFEF-0452-4555-8277-9159486B41BF@joelfernandes.org>
 <ba95955d-b63d-4670-b947-e77b740b1a49@paulmck-laptop>
 <20240228173307.529d11ee@gandalf.local.home>
 <CAADnVQ+szRDGaDJPoBFR9KyeMjwpuxOCNys=yxDaCLYZkSkyYw@mail.gmail.com>
 <8ae889cb-ee1d-4c72-9414-e21258118ce3@paulmck-laptop>
 <888d2f90-6d2f-4d4f-a9f6-fbf2f2611821@joelfernandes.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <888d2f90-6d2f-4d4f-a9f6-fbf2f2611821@joelfernandes.org>

On Thu, Feb 29, 2024 at 09:21:48AM -0500, Joel Fernandes wrote:
> 
> 
> On 2/28/2024 5:58 PM, Paul E. McKenney wrote:
> > On Wed, Feb 28, 2024 at 02:48:44PM -0800, Alexei Starovoitov wrote:
> >> On Wed, Feb 28, 2024 at 2:31 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >>>
> >>> On Wed, 28 Feb 2024 14:19:11 -0800
> >>> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >>>
> >>>>>>
> >>>>>> Well, to your initial point, cond_resched() does eventually invoke
> >>>>>> preempt_schedule_common(), so you are quite correct that as far as
> >>>>>> Tasks RCU is concerned, cond_resched() is not a quiescent state.
> >>>>>
> >>>>>  Thanks for confirming. :-)
> >>>>
> >>>> However, given that the current Tasks RCU use cases wait for trampolines
> >>>> to be evacuated, Tasks RCU could make the choice that cond_resched()
> >>>> be a quiescent state, for example, by adjusting rcu_all_qs() and
> >>>> .rcu_urgent_qs accordingly.
> >>>>
> >>>> But this seems less pressing given the chance that cond_resched() might
> >>>> go away in favor of lazy preemption.
> >>>
> >>> Although cond_resched() is technically a "preemption point" and not truly a
> >>> voluntary schedule, I would be happy to state that it's not allowed to be
> >>> called from trampolines, or their callbacks. Now the question is, does BPF
> >>> programs ever call cond_resched()? I don't think they do.
> >>>
> >>> [ Added Alexei ]
> >>
> >> I'm a bit lost in this thread :)
> >> Just answering the above question.
> >> bpf progs never call cond_resched() directly.
> >> But there are sleepable (aka faultable) bpf progs that
> >> can call some helper or kfunc that may call cond_resched()
> >> in some path.
> >> sleepable bpf progs are protected by rcu_tasks_trace.
> >> That's a very different one vs rcu_tasks.
> > 
> > Suppose that the various cond_resched() invocations scattered throughout
> > the kernel acted as RCU Tasks quiescent states, so that as soon as a
> > given task executed a cond_resched(), synchronize_rcu_tasks() might
> > return or call_rcu_tasks() might invoke its callback.
> > 
> > Would that cause BPF any trouble?
> > 
> > My guess is "no", because it looks like BPF is using RCU Tasks (as you
> > say, as opposed to RCU Tasks Trace) only to wait for execution to leave a
> > trampoline.  But I trust you much more than I trust myself on this topic!
> 
> But it uses RCU Tasks Trace as well (for sleepable bpf programs), not just
> Tasks? Looks like that's what Alexei said above as well, and I confirmed it in
> bpf/trampoline.c
> 
>         /* The trampoline without fexit and fmod_ret progs doesn't call original
>          * function and doesn't use percpu_ref.
>          * Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
>          * Then use call_rcu_tasks() to wait for the rest of trampoline asm
>          * and normal progs.
>          */
>         call_rcu_tasks_trace(&im->rcu, __bpf_tramp_image_put_rcu_tasks);
> 
> The code comment says it uses both.

BPF does quite a few interesting things with these.

But would you like to look at the update-side uses of RCU Tasks Rude
to see if lazy preemption affects them?  I don't believe that there
are any problems here, but we do need to check.

							Thanx, Paul

