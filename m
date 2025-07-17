Return-Path: <bpf+bounces-63622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25552B090D5
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 17:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C8CD7BA34A
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 15:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3328324EABC;
	Thu, 17 Jul 2025 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jo8rV8nz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A6C3208;
	Thu, 17 Jul 2025 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767073; cv=none; b=mb1XMz5T3bMeLHzggreaXzmFsBAqapuz7fSYP3SB0Z4GNCbXbG+fxBtFWMQb0weAOhKqKcxBDrzlEf28LYpTk0lmJ8kiBhe4wMI5E9mfHX3JtAT+BHD8//EVKXmy6CBi+u8KfhBoa71qlBevXMdYIWoPN5ABOpeW9X2YkGy2x3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767073; c=relaxed/simple;
	bh=o11Bw4VJl29vTAOAmU3mAt0GARhGL4vIrojI38A1Cao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMB8DzJE8qya/bUsSNaVyAy2oSsVPf5v6cH1tObnHm20VKFyWmYnM4aImFoQnWM9qWZHMznbsbMEd292/v6yGGXjhNYA0SV8XOKdHSexCEvV09c9UIhoUWkLvSKWaYxL6hhqOZMgh/vxn48CXuzE6ZlPKZ4XCvrWNDc9qMvQYlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jo8rV8nz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29643C4CEEB;
	Thu, 17 Jul 2025 15:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752767073;
	bh=o11Bw4VJl29vTAOAmU3mAt0GARhGL4vIrojI38A1Cao=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=jo8rV8nz9Cv5ctIUF22pbPQxMq6Df9NYRq2VOAQZa7EOU4iO3IT+xc4r7uV4RxiOO
	 d8Fe3WxmCgIzNXIXLztfzDBY9LdZ1minb7duxAM7O9X5RFu8rhBuOn52ZTol0MDqZE
	 /0UeVU0mGxOu4H00RyK0k8IYstqE5p35sIYwRJ61nxjTPuW9jrjIV4Fghxe7b1crwP
	 +t27QBcWrAtnn8xKSWspUGF342f9PBBhduFpUYbznfq2Do2K2y4iItNrt89UYQqNQ3
	 YlCPttE+INWrnnMaJ+VY7XkPIqIOHjH4tfci5Oq5l2jOlE+hn/cTxqYiGd1SyhjGS/
	 lBSXs3eSQiQUg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BA878CE09F5; Thu, 17 Jul 2025 08:44:32 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:44:32 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>, linux-rt-devel@lists.linux.dev,
	rcu@vger.kernel.org,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
	bpf <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
Message-ID: <b5bad938-05fe-4f2b-9085-3675e9350984@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
 <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
 <20250716110922.0dadc4ec@batman.local.home>
 <895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop>
 <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
 <e8f7829c-51c9-494a-827a-ee471b2e17cd@efficios.com>
 <CAADnVQL7gz3OwUVCzt7dbJHvZzOK1zC4AOgMDu5mg6ssKuYU6Q@mail.gmail.com>
 <20250717111216.4949063d@batman.local.home>
 <CAADnVQ+r8=Nw0fz8huFHDNe2Z6UnQNyqXW1=sMOrOGd8WniTyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+r8=Nw0fz8huFHDNe2Z6UnQNyqXW1=sMOrOGd8WniTyw@mail.gmail.com>

On Thu, Jul 17, 2025 at 08:27:24AM -0700, Alexei Starovoitov wrote:
> On Thu, Jul 17, 2025 at 8:12 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Thu, 17 Jul 2025 07:57:27 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >
> > > I still don't understand what problem is being solved.
> > > As current tracepoint code stands there is no issue with it at all
> > > on PREEMPT_RT from bpf pov.
> > > bpf progs that attach to tracepoints are not sleepable.
> > > They don't call rt_spinlock either.
> > > Recognizing tracepoints that can sleep/fault and allow
> > > sleepable bpf progs there is on our to do list,
> > > but afaik it doesn't need any changes to tracepoint infra.
> > > There is no need to replace existing preempt_disable wrappers
> > > with sleepable srcu_fast or anything else.
> >
> > From the PREEMPT_RT point of view, it wants BPF to be preemptable. It
> > may stop migration, but if someone adds a long running BPF program
> > (when I say long running, it could be anything more than 10us), and it
> > executes on a low priority task. If that BPF program is not preemptable
> > it can delay a high priority task from running. That defeats the
> > purpose of PREEMPT_RT.
> >
> > If this is unsolvable, then we will need to make PREEMPT_RT and BPF
> > mutually exclusive in the configs.
> 
> Stop this fud, please.
> 
> bpf progs were preemptible for years and had no issue in RT.
> tracepoints are using preempt_disable() still and that's a
> tracepoint infra problem. Nothing to do with users of tracepoints.

And the tracepoint infrastructure is in fact where my proposed fix
is located.

To be fair, several upgrades to SRCU-fast were required to handle this
particular use case.

But to Steven's point, if there was no feasible fix, wherever that fix
might be, then users of real-time Linux would (at best!) need to be *very*
careful about how they used BPF.  In fact, those having safety-critical
appliations might well choose to turn BPF off entirely, just to prevent
accidents.

						Thanx, Paul

