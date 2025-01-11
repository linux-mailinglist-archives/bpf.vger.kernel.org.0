Return-Path: <bpf+bounces-48629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC52A0A50F
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 18:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB88188AD6B
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 17:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C191B415E;
	Sat, 11 Jan 2025 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XEOcLBr+"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A2118CBFE;
	Sat, 11 Jan 2025 17:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736616466; cv=none; b=Py/XI5FpHNqQWnDOaS86V4+uX14GbD2zGlOHLFoirgmQez5wde5ZBvV+v0HRdVrKvdZDIKNfQKSCeqK5zwa+q7RrUdDB+LSsRMjUm9SoXRb/pvyOmqKt6P3R3XjN/czPy3ilfVNWze5j6c/zbmV3OGKNNIram5AShbG7XoybIZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736616466; c=relaxed/simple;
	bh=Sszkkw4rWHcC9WMvUMekBIpm8ae5ItTZB2ayGsmmQO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LCj2Befa0RO+qyEqC5Fu1MFOezGF5Zu1xtZQAIDMQUWBBxRfQkUGYei/oArnO8oG0QvnsGky0OXi+NwYj8atApqGUGAUBU4BTTd2VvVqqFFNwrDztLB+JPGkptVlpg560wCzoWn7sl4vjkDHkSeJXkcpT6gfw2TA7FwuwBtUyR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XEOcLBr+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=8gRbQXXqE54Z1+02qZv0R0E8GwOPfpKsIedbN9IqHDo=; b=XEOcLBr+0LHD60SSJB/qp5q7fc
	RrE0aqT2BMSx2mlbgUF5cMHNQCD9yA7VONjxuTsBodGevoLkb46Mlix8Wh1PQd8SKuuC5Ql3623yf
	C631IGsFgbnLAvxTJ1Zy5IwAYHrrIY3LJMg+z/r9CMbxUesWGzzx4NCHn1UUVLn62eEz2F4i1+g3N
	LlSNWnaS89KkBW44H87uZdg/exqkvEwZId9ivzIF80+q8lvUDUyv0nrsQV2KHFMRG2zEsQ4qez4FV
	Zt3fZaNf3u78yXv8EXsKjGPn+0x2betx5lfhglCL/prorSwuZHluDZygwMgTUs1LJ5m1gDQPl/fYI
	oGoqXJzA==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tWfGn-0000000A4pT-0BU3;
	Sat, 11 Jan 2025 17:27:33 +0000
Message-ID: <5faf8551-d434-4e2e-980b-0ff5831d3db2@infradead.org>
Date: Sat, 11 Jan 2025 09:27:27 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched_ext: fix kernel-doc warnings
To: Andrea Righi <arighi@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 bpf@vger.kernel.org
References: <20250111063136.910862-1-rdunlap@infradead.org>
 <Z4I9tXouDIVdWBN5@gpd3>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Z4I9tXouDIVdWBN5@gpd3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/11/25 1:45 AM, Andrea Righi wrote:
> Hi Randy,
> 
> On Fri, Jan 10, 2025 at 10:31:36PM -0800, Randy Dunlap wrote:
>> Use the correct function parameter names and function names.
>> Use the correct kernel-doc comment format for struct sched_ext_ops
>> to eliminate a bunch of warnings.
>>
>> ext.c:1418: warning: Excess function parameter 'include_dead' description in 'scx_task_iter_next_locked'
>> ext.c:7261: warning: expecting prototype for scx_bpf_dump(). Prototype was for scx_bpf_dump_bstr() instead
>> ext.c:7352: warning: Excess function parameter 'flags' description in 'scx_bpf_cpuperf_set'
>>
>> ext.c:3150: warning: Function parameter or struct member 'in_fi' not described in 'scx_prio_less'
>> ext.c:4711: warning: Function parameter or struct member 'dur_s' not described in 'scx_softlockup'
>> ext.c:4775: warning: Function parameter or struct member 'bypass' not described in 'scx_ops_bypass'
>> ext.c:7453: warning: Function parameter or struct member 'idle_mask' not described in 'scx_bpf_put_idle_cpumask'
>>
>> ext.c:209: warning: Incorrect use of kernel-doc format:          * select_cpu - Pick the target CPU for a task which is being woken up
>> ext.c:236: warning: Incorrect use of kernel-doc format:          * enqueue - Enqueue a task on the BPF scheduler
>> ext.c:251: warning: Incorrect use of kernel-doc format:          * dequeue - Remove a task from the BPF scheduler
>> ext.c:267: warning: Incorrect use of kernel-doc format:          * dispatch - Dispatch tasks from the BPF scheduler and/or user DSQs
>> ext.c:290: warning: Incorrect use of kernel-doc format:          * tick - Periodic tick
>> ext.c:300: warning: Incorrect use of kernel-doc format:          * runnable - A task is becoming runnable on its associated CPU
>> ext.c:327: warning: Incorrect use of kernel-doc format:          * running - A task is starting to run on its associated CPU
>> ext.c:335: warning: Incorrect use of kernel-doc format:          * stopping - A task is stopping execution
>> ext.c:346: warning: Incorrect use of kernel-doc format:          * quiescent - A task is becoming not runnable on its associated CPU
>> ext.c:366: warning: Incorrect use of kernel-doc format:          * yield - Yield CPU
>> ext.c:381: warning: Incorrect use of kernel-doc format:          * core_sched_before - Task ordering for core-sched
>> ext.c:399: warning: Incorrect use of kernel-doc format:          * set_weight - Set task weight
>> ext.c:408: warning: Incorrect use of kernel-doc format:          * set_cpumask - Set CPU affinity
>> ext.c:418: warning: Incorrect use of kernel-doc format:          * update_idle - Update the idle state of a CPU
>> ext.c:439: warning: Incorrect use of kernel-doc format:          * cpu_acquire - A CPU is becoming available to the BPF scheduler
>> ext.c:449: warning: Incorrect use of kernel-doc format:          * cpu_release - A CPU is taken away from the BPF scheduler
>> ext.c:461: warning: Incorrect use of kernel-doc format:          * init_task - Initialize a task to run in a BPF scheduler
>> ext.c:476: warning: Incorrect use of kernel-doc format:          * exit_task - Exit a previously-running task from the system
>> ext.c:485: warning: Incorrect use of kernel-doc format:          * enable - Enable BPF scheduling for a task
>> ext.c:494: warning: Incorrect use of kernel-doc format:          * disable - Disable BPF scheduling for a task
>> ext.c:504: warning: Incorrect use of kernel-doc format:          * dump - Dump BPF scheduler state on error
>> ext.c:512: warning: Incorrect use of kernel-doc format:          * dump_cpu - Dump BPF scheduler state for a CPU on error
>> ext.c:524: warning: Incorrect use of kernel-doc format:          * dump_task - Dump BPF scheduler state for a runnable task on error
>> ext.c:535: warning: Incorrect use of kernel-doc format:          * cgroup_init - Initialize a cgroup
>> ext.c:550: warning: Incorrect use of kernel-doc format:          * cgroup_exit - Exit a cgroup
>> ext.c:559: warning: Incorrect use of kernel-doc format:          * cgroup_prep_move - Prepare a task to be moved to a different cgroup
>> ext.c:574: warning: Incorrect use of kernel-doc format:          * cgroup_move - Commit cgroup move
>> ext.c:585: warning: Incorrect use of kernel-doc format:          * cgroup_cancel_move - Cancel cgroup move
>> ext.c:597: warning: Incorrect use of kernel-doc format:          * cgroup_set_weight - A cgroup's weight is being changed
>> ext.c:611: warning: Incorrect use of kernel-doc format:          * cpu_online - A CPU became online
>> ext.c:620: warning: Incorrect use of kernel-doc format:          * cpu_offline - A CPU is going offline
>> ext.c:633: warning: Incorrect use of kernel-doc format:          * init - Initialize the BPF scheduler
>> ext.c:638: warning: Incorrect use of kernel-doc format:          * exit - Clean up after the BPF scheduler
>> ext.c:648: warning: Incorrect use of kernel-doc format:          * dispatch_max_batch - Max nr of tasks that dispatch() can dispatch
>> ext.c:653: warning: Incorrect use of kernel-doc format:          * flags - %SCX_OPS_* flags
>> ext.c:658: warning: Incorrect use of kernel-doc format:          * timeout_ms - The maximum amount of time, in milliseconds, that a
>> ext.c:667: warning: Incorrect use of kernel-doc format:          * exit_dump_len - scx_exit_info.dump buffer length. If 0, the default
>> ext.c:673: warning: Incorrect use of kernel-doc format:          * hotplug_seq - A sequence number that may be set by the scheduler to
>> ext.c:682: warning: Incorrect use of kernel-doc format:          * name - BPF scheduler's name
>>
>> ext.c:689: warning: Function parameter or struct member 'select_cpu' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'enqueue' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'dequeue' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'dispatch' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'tick' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'runnable' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'running' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'stopping' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'quiescent' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'yield' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'core_sched_before' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'set_weight' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'set_cpumask' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'update_idle' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'cpu_acquire' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'cpu_release' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'init_task' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'exit_task' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'enable' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'disable' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'dump' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'dump_cpu' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'dump_task' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'cgroup_init' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'cgroup_exit' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'cgroup_prep_move' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'cgroup_move' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'cgroup_cancel_move' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'cgroup_set_weight' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'cpu_online' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'cpu_offline' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'init' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'exit' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'dispatch_max_batch' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'flags' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'timeout_ms' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'exit_dump_len' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'hotplug_seq' not described in 'sched_ext_ops'
>> ext.c:689: warning: Function parameter or struct member 'name' not described in 'sched_ext_ops'
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: David Vernet <void@manifault.com>
>> Cc: Andrea Righi <arighi@nvidia.com>
>> Cc: Changwoo Min <changwoo@igalia.com>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: bpf@vger.kernel.org
> 
> Thanks for this cleanup, looks good to me. I left a small comment below,
> but feel free to ignore.
> 
> Acked-by: Andrea Righi <arighi@nvidia.com>
> 
>> @@ -1408,7 +1409,6 @@ static struct task_struct *scx_task_iter
>>  /**
>>   * scx_task_iter_next_locked - Next non-idle task with its rq locked
>>   * @iter: iterator to walk
>> - * @include_dead: Whether we should include dead tasks in the iteration
>>   *
>>   * Visit the non-idle task with its rq lock held. Allows callers to specify
>>   * whether they would like to filter out dead tasks. See scx_task_iter_start()
>> @@ -3132,6 +3132,7 @@ static struct task_struct *pick_task_scx
>>   * scx_prio_less - Task ordering for core-sched
>>   * @a: task A
>>   * @b: task B
>> + * @in_fi: in forced idle state
> 
> in_fi is currently not used / not passed to ops.core_sched_before(), should
> we metion this? Like appending (unused) or similar to the description?

Hi Andrea,
I'm not sure that anyone would update that comment if it did become used  ;(
so I think it's OK not to mention that.

Thanks.
-- 
~Randy


