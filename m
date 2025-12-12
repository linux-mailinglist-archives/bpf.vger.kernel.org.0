Return-Path: <bpf+bounces-76543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E38E3CBA07A
	for <lists+bpf@lfdr.de>; Sat, 13 Dec 2025 00:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B575300BEE7
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 23:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AEA30C632;
	Fri, 12 Dec 2025 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTASDC+w"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9B130170B;
	Fri, 12 Dec 2025 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765581030; cv=none; b=iRmNqrGWaNPCfeSLEe4d2ozH/EyTKqtAvBDVdqNf7MVv6TrSA/Uwn9Id/1JA7Of89HNJug6SJ6kSWJXouxI9NwxG+fxDCbe/rZLecwTvg14S7LmNutgyfdx4Q0hUpdqmISqbtGG/rPEPY9Ii7O/YFgozfuz20EAyd3etmZpEL+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765581030; c=relaxed/simple;
	bh=EKlPA2ZmfaPZIYOhn4YdeRunNaUzv0YIyc0vrgBrtN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FV5eF5Ug2I2vKHhH9wVyokn06vDklAPyIgVr8eLIEp3189/DegHWccQJIDDrnv9zkzVJKmmSimnJQ9pjU0+o75OTTQMT84p6iRDzQqGPfY7KAUchVQd33LJvXBv0V5I96kJApt5fGfHhWNmC3sy2c4WjCH2zt7fBgvULZ3IbLck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTASDC+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F41DC4CEF1;
	Fri, 12 Dec 2025 23:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765581029;
	bh=EKlPA2ZmfaPZIYOhn4YdeRunNaUzv0YIyc0vrgBrtN4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=CTASDC+w8AADARPEw2jrjqMYBIkenkp5RQA8NIUGGWP4nHg7ltZUUbcR/bAY4AmfZ
	 jamkTZDFZuJQrepCEyw+tcwXWttJPmCvWQ0cp+Mykff0sO1GgbjCi1kE+VU29m+jqU
	 RqQbH2zLZkN+rQmTDPxlA/HIqPWPMH17ViJmU6zlj87MFSK668HH9qplndTXIFb8KB
	 TBL6QZG3aAq8R4FbFXr1Ydcrs0+zAUUIGc4BcU6yqPFaOKYn+0UKAz8gGg8wQE4bxM
	 U2g2h5Gb0eKP50rV8Li+LtznuaF1/BwulKpPxoiCzPubUS3zMrAqBOSZpdmLtjIldq
	 GHX8onpVImDsA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 96635CE0B2E; Fri, 12 Dec 2025 15:10:26 -0800 (PST)
Date: Fri, 12 Dec 2025 15:10:26 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Steve Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v3] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <d863f1ad-477d-4e3f-a0b5-fa9f282a164a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e2fe3162-4b7b-44d6-91ff-f439b3dce706@paulmck-laptop>
 <B5D08899-9C23-4FA3-B988-3BB3E8E6D908@nvidia.com>
 <febd477b-c111-4d5e-be89-cae3685853f5@paulmck-laptop>
 <bce9a781-3cc3-45d7-8c95-9f747e08a3cd@nvidia.com>
 <0ec97a2d-5aee-4214-b387-229e9822b468@paulmck-laptop>
 <C0D26D77-316D-467F-81C9-030D4E0EBCD8@nvidia.com>
 <83cd4b4d-1eec-47d0-be91-57c915775612@paulmck-laptop>
 <7683319A-AB3D-4DF4-8720-9C39E3C683BA@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7683319A-AB3D-4DF4-8720-9C39E3C683BA@nvidia.com>

On Fri, Dec 12, 2025 at 09:28:37AM +0000, Joel Fernandes wrote:
> 
> 
> > On Dec 12, 2025, at 4:50 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > ﻿On Fri, Dec 12, 2025 at 03:43:07AM +0000, Joel Fernandes wrote:
> >> 
> >> 
> >>>> On Dec 12, 2025, at 9:47 AM, Paul E. McKenney <paulmck@kernel.org> wrote:
> >>> 
> >>> ﻿On Fri, Dec 12, 2025 at 09:12:07AM +0900, Joel Fernandes wrote:
> >>>> 
> >>>> 
> >>>>> On 12/11/2025 3:23 PM, Paul E. McKenney wrote:
> >>>>> On Thu, Dec 11, 2025 at 08:02:15PM +0000, Joel Fernandes wrote:
> >>>>>> 
> >>>>>> 
> >>>>>>> On Dec 8, 2025, at 1:20 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> >>>>>>> 
> >>>>>>> ﻿The current use of guard(preempt_notrace)() within __DECLARE_TRACE()
> >>>>>>> to protect invocation of __DO_TRACE_CALL() means that BPF programs
> >>>>>>> attached to tracepoints are non-preemptible.  This is unhelpful in
> >>>>>>> real-time systems, whose users apparently wish to use BPF while also
> >>>>>>> achieving low latencies.  (Who knew?)
> >>>>>>> 
> >>>>>>> One option would be to use preemptible RCU, but this introduces
> >>>>>>> many opportunities for infinite recursion, which many consider to
> >>>>>>> be counterproductive, especially given the relatively small stacks
> >>>>>>> provided by the Linux kernel.  These opportunities could be shut down
> >>>>>>> by sufficiently energetic duplication of code, but this sort of thing
> >>>>>>> is considered impolite in some circles.
> >>>>>>> 
> >>>>>>> Therefore, use the shiny new SRCU-fast API, which provides somewhat faster
> >>>>>>> readers than those of preemptible RCU, at least on Paul E. McKenney's
> >>>>>>> laptop, where task_struct access is more expensive than access to per-CPU
> >>>>>>> variables.  And SRCU-fast provides way faster readers than does SRCU,
> >>>>>>> courtesy of being able to avoid the read-side use of smp_mb().  Also,
> >>>>>>> it is quite straightforward to create srcu_read_{,un}lock_fast_notrace()
> >>>>>>> functions.
> >>>>>>> 
> >>>>>>> While in the area, SRCU now supports early boot call_srcu().  Therefore,
> >>>>>>> remove the checks that used to avoid such use from rcu_free_old_probes()
> >>>>>>> before this commit was applied:
> >>>>>>> 
> >>>>>>> e53244e2c893 ("tracepoint: Remove SRCU protection")
> >>>>>>> 
> >>>>>>> The current commit can be thought of as an approximate revert of that
> >>>>>>> commit, with some compensating additions of preemption disabling.
> >>>>>>> This preemption disabling uses guard(preempt_notrace)().
> >>>>>>> 
> >>>>>>> However, Yonghong Song points out that BPF assumes that non-sleepable
> >>>>>>> BPF programs will remain on the same CPU, which means that migration
> >>>>>>> must be disabled whenever preemption remains enabled.  In addition,
> >>>>>>> non-RT kernels have performance expectations that would be violated by
> >>>>>>> allowing the BPF programs to be preempted.
> >>>>>>> 
> >>>>>>> Therefore, continue to disable preemption in non-RT kernels, and protect
> >>>>>>> the BPF program with both SRCU and migration disabling for RT kernels,
> >>>>>>> and even then only if preemption is not already disabled.
> >>>>>> 
> >>>>>> Hi Paul,
> >>>>>> 
> >>>>>> Is there a reason to not make non-RT also benefit from SRCU fast and trace points for BPF? Can be a follow up patch though if needed.
> >>>>> 
> >>>>> Because in some cases the non-RT benefit is suspected to be negative
> >>>>> due to increasing the probability of preemption in awkward places.
> >>>> 
> >>>> Since you mentioned suspected, I am guessing there is no concrete data collected
> >>>> to substantiate that specifically for BPF programs, but correct me if I missed
> >>>> something. Assuming you're referring to latency versus tradeoffs issues, due to
> >>>> preemption, Android is not PREEMPT_RT but is expected to be low latency in
> >>>> general as well. So is this decision the right one for Android as well,
> >>>> considering that (I heard) it uses BPF? Just an open-ended question.
> >>>> 
> >>>> There is also issue of 2 different paths for PREEMPT_RT versus otherwise,
> >>>> complicating the tracing side so there better be a reason for that I guess.
> >>> 
> >>> You are advocating a change in behavior for non-RT workloads.  Why do
> >>> you believe that this change would be OK for those workloads?
> >> 
> >> Same reasons I provided in my last email. If we are saying SRCU-fast is required for lower latency, I find it strange that we are leaving out Android which has low latency audio usecases, for instance.
> > 
> > If Android provides numbers showing that it helps them, then it is easy
> > to provide a Kconfig option that defaults to PREEMPT_RT, but that Android
> > can override.  Right?
> 
> Sure, but my suspicion is Android or others are not going to look into every PREEMPT_RT specific optimization (not just this one) and see if it benefits their interactivity usecases. They will simply miss out on it without knowing they are.
> 
> It might be a good idea (for me) to explore how many such optimizations exist though, that we take for granted. I will look into exploring this on my side. :)

One workload's optimization is another workload's pessimization, in
part because there are a lot of different measures of performance that
different workloads care about..

But as a practical matter, this is Steven's decision.

Though if he does change the behavior on non-RT setups, I would thank
him to remove my name from the commit, or at least record in the commit
log that I object to changing other workloads' behaviors.

							Thanx, Paul

> thanks,
> 
>  - Joel 
> 
> > 
> >                            Thanx, Paul
> > 
> >> Thanks,
> >> 
> >> - Joel
> >> 
> >> 
> >>> 
> >>>                           Thanx, Paul

