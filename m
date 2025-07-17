Return-Path: <bpf+bounces-63626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F29B6B09141
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 18:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377C63BBC33
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 16:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20F22F85FE;
	Thu, 17 Jul 2025 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nq6hYFFp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8FE35963;
	Thu, 17 Jul 2025 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768241; cv=none; b=neSb9vWmOEaQwHilHnOKng9OjBzOdEPDxFpnYPfV+uQBBB6cLznVrTnluiqGIDue7nNp8m9sv/yIAXVnR5qRRNmRMjd4KsyCclcF1U5bCR0MnGHZQ7iQVKbAKZxXdd9+RlxF3witGfZDqeNaT4kIqlRDBgrWd1wgxtvz7ipgbzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768241; c=relaxed/simple;
	bh=Ql40KFJ+kQuxrg56fLq03oBwJa9AGIhjbEY6BnbzsmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJXPxDhDqjLP9w4HKw60TQkS1cG40UmeDTxTl4jnTaw0HJipUjHB5EKez2qsTOzwTQX5l1x9NOfPGJMTnPQioDrJW2mZmgubpVZTSnkkqGkeHP5Y2KRZF18U6SNMPNVNIc9RdHg7kpbHpksmact7ERt14erGK801owWHbHcOmCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nq6hYFFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E3BC4CEE3;
	Thu, 17 Jul 2025 16:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752768241;
	bh=Ql40KFJ+kQuxrg56fLq03oBwJa9AGIhjbEY6BnbzsmM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=nq6hYFFpb9OoQom7Cb+ncofeV9J9HsZCbcL0aFBxDsahigGVsxH8XsUpt4OpVTwfb
	 zj8hS/YHHyIDccK8EdRzJd6kWgnw+HzrGv2t+s+dViKj2snN2XIZHBcYOSneZMvYPB
	 kfOm17WiNFFlnDIG4kzFY52IdESZX2dF76eGx/Ot20eSlBPM4qM+QHmkfRdu4jWmLZ
	 Do6hEbET0QkQWElbK8RPiNX4kbvgU5YTNr/JR5lnBjQcBEqw2i72BHyBoqq3NEPsAB
	 IUtO8g+gGzYt2Mm0zgbw7tvj0rts7imau4rBrFl426pdzUHdQjKa6deR7xZlrF9Uva
	 hXgvkGUVazB+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 94553CE09F5; Thu, 17 Jul 2025 09:04:00 -0700 (PDT)
Date: Thu, 17 Jul 2025 09:04:00 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Message-ID: <9fc968c0-214a-44eb-9f1c-06af4bbbb815@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
 <20250716110922.0dadc4ec@batman.local.home>
 <895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop>
 <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
 <e8f7829c-51c9-494a-827a-ee471b2e17cd@efficios.com>
 <CAADnVQL7gz3OwUVCzt7dbJHvZzOK1zC4AOgMDu5mg6ssKuYU6Q@mail.gmail.com>
 <20250717111216.4949063d@batman.local.home>
 <CAADnVQ+r8=Nw0fz8huFHDNe2Z6UnQNyqXW1=sMOrOGd8WniTyw@mail.gmail.com>
 <20250717114028.77ea7745@batman.local.home>
 <20250717115510.7717f839@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717115510.7717f839@batman.local.home>

On Thu, Jul 17, 2025 at 11:55:10AM -0400, Steven Rostedt wrote:
> On Thu, 17 Jul 2025 11:40:28 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Yes, it is a tracepoint infra problem that we are trying to solve. The
> > reason we are trying to solve it is because BPF programs can extend the
> > time a tracepoint takes. If anything else extended the time, this would
> > need to be solved as well. But currently it's only BPF programs that
> > cause the issue.
> 
> BTW, if we can't solve this issue and something else came along and
> attached to tracepoints that caused unbounded latency, I would also
> argue that whatever came along would need to be prevented from being
> configured with PREEMPT_RT. My comment wasn't a strike against BPF
> programs; It was a strike against something adding unbounded latency
> into a critical section that has preemption disabled.

I would imagine that many PREEMPT_RT installations would have a severe
and heavy-weight review, test, and approval process for BPF programs
intended for use in production systems...

							Thanx, Paul

