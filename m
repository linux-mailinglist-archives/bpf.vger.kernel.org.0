Return-Path: <bpf+bounces-42040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E7E99EFE3
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D072A1C22EA6
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 14:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D471C4A25;
	Tue, 15 Oct 2024 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBSlLPln"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E4613D520;
	Tue, 15 Oct 2024 14:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003289; cv=none; b=Z6d5YUnPg6AZ3AQWDx5sL29kgFjF1DEhFgLgtUbL/8CrBk2N4YkGIplt/pH/0F/ZbDoKwGAMhmWSXDWmDW3gKYpzq4K6oQs9/AtU4sZHWHfl7frM8zQYuNssL7zIAx7RrFkonGxzPBM0VWCEAlUePTnM5npJnqfaxcxbiIt7/vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003289; c=relaxed/simple;
	bh=cq/4BkMX1uuzIk6CfhT1Rj5dcfcNtZgB8iidWJOYtsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGCMqfEvMQOxJA6BSak6aTP0fPTs1ogVVNEA9nvIRlZib8yVSsS6j1QuxMPpGm2z5Lfq6QuwgeNOdK1Hk6usGWDmjcmMKAn/GHYy7sQHuwk3nhDP9/zp95q7t4oh7Vn70+M4BZDC5YHo5Mj/KLhA5wnsJEppgvKaDRRqHTYHUNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBSlLPln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B82C4CEC6;
	Tue, 15 Oct 2024 14:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729003287;
	bh=cq/4BkMX1uuzIk6CfhT1Rj5dcfcNtZgB8iidWJOYtsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MBSlLPlnviSq0LgnR282AcxyGeSNjmieakzewyuvlOgJFkEJYyZjcnVKPp/LIhYXb
	 nXDwh0SQuJbdgJfaAWRJYXC+7f89C7m6Rn5ESkFKUL858/RlCl902MSyQcx11fhPUr
	 NF+kjdgzznQpMWbzevlbzhKBOY7FK4FojezwY+CHW1E9fGtMdEULmyno1f8irwp1i3
	 cZPtceZNEd0kg1Yn2QvibI8si6WGGSW2wP11sT3a+xedJvdUFHjcwlemFaqswWyID+
	 fIY6bjGvfK/ZrAYcweAfvnxocg8LRdMOgRUn/8VmGAfSvVvP3O8qTUqS5hMNXe6nl6
	 rr7L021od77qw==
Date: Tue, 15 Oct 2024 04:41:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <andrea.righi@linux.dev>
Cc: David Vernet <void@manifault.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4] sched_ext: Trigger ops.update_idle() from
 pick_task_idle()
Message-ID: <Zw5_FlXfbLXDLCPG@slm.duckdns.org>
References: <20241015111539.12136-1-andrea.righi@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015111539.12136-1-andrea.righi@linux.dev>

Hello, Andrea.

On Tue, Oct 15, 2024 at 01:15:39PM +0200, Andrea Righi wrote:
...
> For example, a BPF scheduler might use logic like the following to keep
> the CPU active under specific conditions:
> 
> void BPF_STRUCT_OPS(sched_update_idle, s32 cpu, bool idle)
> {
> 	if (!idle)
> 		return;
> 	if (condition)
> 		scx_bpf_kick_cpu(cpu, 0);
> }
> 
> A call to scx_bpf_kick_cpu() wakes up the CPU, so in theory,
> ops.update_idle() should be triggered again until the condition becomes
> false. However, this doesn't happen, and scx_bpf_kick_cpu() doesn't
> produce the expected effect.

I thought more about this scenario and I'm not sure anymore whether we want
to guarantee that scx_bpf_kick_cpu() is followed by update_idle(cpu, true).
Here are a couple considerations:

- As implemented, the transtions aren't balanced. ie. When the above
  happens, update_idle(cpu, true) will be generated multiple times without
  intervening update_idle(cpu, false). We can insert artificial false
  transtions but that's cumbersome and...

- For the purpose of determining whether a CPU is idle for e.g. task
  placement from ops.select_cpu(). The CPU *should* be considered idle in
  this polling state.

Overall, it feels a bit contrived to generate update_idle() events
consecutively for this. If a scheduler wants to poll in idle state, can't it
do something like the following?

- Trigger kick from update_idle(cpu, true) and remember that the CPU is in
  the polling state.

- Keep kicking from ops.dispatch() until polling state is cleared.

As what kick() guarnatees is at least one dispatch event after kicking, this
is guaranteed to be correct and the control flow, while a bit more
complicated, makes sense - it triggers dispatch on idle transition and keeps
dispatching in the idle state.

What do you think?

Thanks.

-- 
tejun

