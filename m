Return-Path: <bpf+bounces-28704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49F28BD502
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 20:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBB5DB23A66
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 18:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DE08494;
	Mon,  6 May 2024 18:58:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFEE158DB0;
	Mon,  6 May 2024 18:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715021898; cv=none; b=EsCHGazoIkwhQPqY2r2i8UY2snR4s8qpBMmTPGwG/50cTYJOvtN5zECEJmFyLTRq8jcABsqJG2WZooRQiLqvjapkO+DtkMuSmSKFamsUm6Jpb7d5Phu1oIfr9b63/nXp1vJdZ4vtjpgx1QAWJcSBO6pKP98pj6sIzpwxEScthFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715021898; c=relaxed/simple;
	bh=V5Q/PtAoa1EYXLeQtATWPzqJIo+EJXn8vpl0tEf4S8I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B69ZsePTjOSw7rcvWOXjEJniGwA+NG8AkJRiPPgWG88aV+PlbweJBfL2JnZ+Fl8AT94ZBYBzxlT2f6FyT84myAGC3I3fLOMdX18fiLagxNo3uy7DknuMZF8xlR5fxqs6Dem2spVGh4PFwmHfH7ArxmzWdgofsX6X9XFRZiSrEOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1s43NP-000000002I5-3dwS;
	Mon, 06 May 2024 14:47:51 -0400
Message-ID: <798768ad5db073d36467a432352b968b01649898.camel@surriel.com>
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
From: Rik van Riel <riel@surriel.com>
To: Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, juri.lelli@redhat.com, 
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com,  ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org,  joshdon@google.com,
 brho@google.com, pjt@google.com, derkling@google.com,  haoluo@google.com,
 dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu, 
 changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com, 
 andrea.righi@canonical.com, joel@joelfernandes.org,
 linux-kernel@vger.kernel.org,  bpf@vger.kernel.org, kernel-team@meta.com
Date: Mon, 06 May 2024 14:47:47 -0400
In-Reply-To: <20240503085232.GC30852@noisy.programming.kicks-ass.net>
References: <20240501151312.635565-1-tj@kernel.org>
	 <20240502084800.GY30852@noisy.programming.kicks-ass.net>
	 <ZjPnb1vdt80FrksA@slm.duckdns.org>
	 <20240503085232.GC30852@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Fri, 2024-05-03 at 10:52 +0200, Peter Zijlstra wrote:
> On Thu, May 02, 2024 at 09:20:15AM -1000, Tejun Heo wrote:
> > Hello, Peter.
> >=20
> > On Thu, May 02, 2024 at 10:48:00AM +0200, Peter Zijlstra wrote:
> > > Can you please put your efforts and the touted Google
> > > collaboration in
> > > fixing the existing cgroup mess?
> >=20
> > I suppose you're referring to Rik's flattened hierarchy patchset.
> >=20
> > =C2=A0
> > https://lore.kernel.org/all/20190822021740.15554-1-riel@surriel.com
> >=20
>=20
> You guys Google/Facebook got us the cgroup thing, Google did a lot of
> the work for cpu-cgroup, and now you Facebook say you can't live with
> it
> because it's too expensive. Yes Rik did put a lot of effort into it,
> but
> Google shot it down. What am I to do?

I believe the issues that Paul pointed out with my
flattened cgroup code are fixable. I ended up not
getting back to this code because it took me a few
months to think of ways to fix the issues Paul found,
and by then I had moved on to other projects.

For reference, Paul found these two (very real) issues
with my implementation.

1) Thundering herd problem. If many tasks in a low
   priority cgroup wake up at the same time, they can
   end up swamping a CPU.

   I believe this can be solved with the same idea
   I had for reimplementing CONFIG_CFS_BANDWIDTH.
   Specifically, the code that determines the time
   slice length for a task already has a way to
   determine whether a CPU is "overloaded", and
   time slices need to be shortened.  Once we reach
   that situation, we can place woken up tasks on
   a secondary heap of per-cgroup runqueues, from
   which we do not directly run tasks, but pick
   the lowest vruntime task from the lowest vruntime
   cgroup and put that on the main runqueue, if
   the previously running task has a vruntime that
   is higher than that of a task in the secondary
   group. If a task is woken up in a cgroup that
   already has tasks on that secondary queue, we
   wake up the task onto that secondary queue.

   This means on overloaded CPUs, we move back to
   a task selection mechanism closer to what we
   currently have, while in the non-overloaded
   situation we use a flat runqueue.

   This same scheme could be used to implement
   CFS bandwidth control. A task belonging to a
   throttled group would be placed on the group's
   queue, not the CPU's flat runqueue.

2) The vruntime for a task can be advanced by way
   to much at once. If we have tasks A & B running,
   and task B has a priority that is 1/100th of that
   of task A, its vruntime would be advanced 100x
   as much as task A, when running the same length
   time slice.

   This creates a big issue if we get a wakeup of
   task C, at the same priority as task B, and then
   task A goes to sleep. Due to the very far advanced
   runtime of task B, task C could get to monopolize
   the CPU for a considerable amount of time, and
   task B could get starved.

   A potential fix for this is to never account more
   than the maximum time slice length at a time, while
   any excess delta_exec time for the task gets remembered.

   At pick_next_entity time, the scheduler can see that
   task B has a lot of delta_exec time left, and account
   up to the maximum slice length to the task's vruntime,
   and place it back in the queue if the next task now has
   a lower vruntime.

   For a steady state of a high priority task A and a low
   priority task B, this makes pick_next_task more expensive,
   but when task A disappears and task C appears, CPU time
   will continue to be fair between them.

   Limiting the total weight of tasks on the flat runqueue,
   using the mechanism for thundering herd and CFS bandwidth
   outlined above, should keep this overhead bounded to
   something reasonable.

Does the above sound like it would work?

Does it sound like code that you would be ok with merging?

Is it a large enough improvement over the current hierarchical
runqueue that it would be worth doing?

This would be a fairly large project, so we should probably discuss
some of the details before investing too much time in it.

--=20
All Rights Reversed.

