Return-Path: <bpf+bounces-15011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3707EA435
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 21:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253B91F215DD
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 20:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC78241E9;
	Mon, 13 Nov 2023 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Zwmjb2k1"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C56241E3
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 20:04:58 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477CCD7E
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 12:04:56 -0800 (PST)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C255240C5A
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 20:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1699905894;
	bh=XP0wmVYGpCJhtArJ5xv90z4qmq6+35imiMwA4MCF8eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=Zwmjb2k1SFRTroqUbhc7fW5sSvu4N3H8dHPrPBJzFpIW+v7AnxF1gVQveai3tuxVh
	 IPu5JeUaUecufmK0MSmqidxmPDlT0s1RasQJfnLV0ui/HyUvoN2aLhPWASfYEyfDwX
	 4Y/CIplXAKPY9o4HaGQTjVGiAgFso91GP9xZ/miV3HCtoEQldzRhKHlSMzj4+7ALDz
	 xNt5/D5byHH5+QELunV+1vGvyNcvkPkmrRDt5e+R2IwzJ6uHN3267EOwwbdnx5hBFI
	 OFjyLLxTdKbY3y3xG5QoPlMXtPGioNeWwrIkRUpvNqNvp4dlhEKnIKn97z9WWgFUtF
	 xMZAsFfs5Wt9g==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-280740f54b9so4782512a91.3
        for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 12:04:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699905893; x=1700510693;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XP0wmVYGpCJhtArJ5xv90z4qmq6+35imiMwA4MCF8eQ=;
        b=kKNlATUlA2iCSyDzUld4NB/r9j1DoMOE8W0qo5Vl1NABRhQMHuBo6auD7HvEbjOuCr
         tx9dfLH+lXDnPWa+S9Z4Be479XtDwmmmyWCwTnJjSap7DVVE7L7fEfn72MVaFRqNIziW
         L6QTDBmXnM/XalDg9RJTWAlg1AYQO6E1HwzbO6VZLtsjEIiXJFsQJB6QzbMUwXyX0SJp
         3gmYNBKZJZmmrmUY2Rvd8ijMIdWcmsLTw5lor52KivaRa6OD9kduHero+QpFMDmCFyt2
         Jc0ve6b64g8f82/4I7RzrbBn+gBmX7AvmxzVaMXlHHP8ewn9CU1YFH0Sn5yMvdNpkHJ3
         SijQ==
X-Gm-Message-State: AOJu0YzQpaNdTNIbOnbrIKsT6bcjRqxUBb2RLj9N14TiPmBR5CgfYlsp
	XavARwL2cfx/Sqx9y1S7oA2xIXViT/5wPwzdl483n8IRlztKncXxVwx9Dc1GBoeS+KxGW5kehCB
	MxXMYJtn/mxkNzzPutAOMxam2tu3JAQ==
X-Received: by 2002:a05:620a:2a06:b0:76c:b3cb:a9e5 with SMTP id o6-20020a05620a2a0600b0076cb3cba9e5mr260571qkp.51.1699905872359;
        Mon, 13 Nov 2023 12:04:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHx0dr/GSRycupb1BbGLsT1KRqW4lFC1KWiROAe8f377Z7btZVJsopyC8nGB18pWYfanxVZzw==
X-Received: by 2002:a05:620a:2a06:b0:76c:b3cb:a9e5 with SMTP id o6-20020a05620a2a0600b0076cb3cba9e5mr260516qkp.51.1699905871898;
        Mon, 13 Nov 2023 12:04:31 -0800 (PST)
Received: from localhost ([12.186.190.1])
        by smtp.gmail.com with ESMTPSA id i7-20020a05620a248700b0077892023fc5sm2103898qkn.120.2023.11.13.12.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:04:30 -0800 (PST)
Date: Mon, 13 Nov 2023 15:04:24 -0500
From: Andrea Righi <andrea.righi@canonical.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 12/36] sched_ext: Implement BPF extensible scheduler class
Message-ID: <ZVKBSIPqJnAvrE3g@gpd>
References: <20231111024835.2164816-1-tj@kernel.org>
 <20231111024835.2164816-13-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231111024835.2164816-13-tj@kernel.org>

On Fri, Nov 10, 2023 at 04:47:38PM -1000, Tejun Heo wrote:
> Implement a new scheduler class sched_ext (SCX), which allows scheduling
> policies to be implemented as BPF programs to achieve the following:
> 
> 1. Ease of experimentation and exploration: Enabling rapid iteration of new
>    scheduling policies.
> 
> 2. Customization: Building application-specific schedulers which implement
>    policies that are not applicable to general-purpose schedulers.
> 
> 3. Rapid scheduler deployments: Non-disruptive swap outs of scheduling
>    policies in production environments.
> 
> sched_ext leverages BPF’s struct_ops feature to define a structure which
> exports function callbacks and flags to BPF programs that wish to implement
> scheduling policies. The struct_ops structure exported by sched_ext is
> struct sched_ext_ops, and is conceptually similar to struct sched_class. The
> role of sched_ext is to map the complex sched_class callbacks to the more
> simple and ergonomic struct sched_ext_ops callbacks.
> 
> For more detailed discussion on the motivations and overview, please refer
> to the cover letter.
> 
> Later patches will also add several example schedulers and documentation.
> 
> This patch implements the minimum core framework to enable implementation of
> BPF schedulers. Subsequent patches will gradually add functionalities
> including safety guarantee mechanisms, nohz and cgroup support.
> 
> include/linux/sched/ext.h defines struct sched_ext_ops. With the comment on
> top, each operation should be self-explanatory. The followings are worth
> noting:
> 
> * Both "sched_ext" and its shorthand "scx" are used. If the identifier
>   already has "sched" in it, "ext" is used; otherwise, "scx".
> 
> * In sched_ext_ops, only .name is mandatory. Every operation is optional and
>   if omitted a simple but functional default behavior is provided.
> 
> * A new policy constant SCHED_EXT is added and a task can select sched_ext
>   by invoking sched_setscheduler(2) with the new policy constant. However,
>   if the BPF scheduler is not loaded, SCHED_EXT is the same as SCHED_NORMAL
>   and the task is scheduled by CFS. When the BPF scheduler is loaded, all
>   tasks which have the SCHED_EXT policy are switched to sched_ext.
> 
> * To bridge the workflow imbalance between the scheduler core and
>   sched_ext_ops callbacks, sched_ext uses simple FIFOs called dispatch
>   queues (dsq's). By default, there is one global dsq (SCX_DSQ_GLOBAL), and
>   one local per-CPU dsq (SCX_DSQ_LOCAL). SCX_DSQ_GLOBAL is provided for
>   convenience and need not be used by a scheduler that doesn't require it.
>   SCX_DSQ_LOCAL is the per-CPU FIFO that sched_ext pulls from when putting
>   the next task on the CPU. The BPF scheduler can manage an arbitrary number
>   of dsq's using scx_bpf_create_dsq() and scx_bpf_destroy_dsq().
> 
> * sched_ext guarantees system integrity no matter what the BPF scheduler
>   does. To enable this, each task's ownership is tracked through
>   p->scx.ops_state and all tasks are put on scx_tasks list. The disable path
>   can always recover and revert all tasks back to CFS. See p->scx.ops_state
>   and scx_tasks.
> 
> * A task is not tied to its rq while enqueued. This decouples CPU selection
>   from queueing and allows sharing a scheduling queue across an arbitrary
>   subset of CPUs. This adds some complexities as a task may need to be
>   bounced between rq's right before it starts executing. See
>   dispatch_to_local_dsq() and move_task_to_local_dsq().
> 
> * One complication that arises from the above weak association between task
>   and rq is that synchronizing with dequeue() gets complicated as dequeue()
>   may happen anytime while the task is enqueued and the dispatch path might
>   need to release the rq lock to transfer the task. Solving this requires a
>   bit of complexity. See the logic around p->scx.sticky_cpu and
>   p->scx.ops_qseq.
> 
> * Both enable and disable paths are a bit complicated. The enable path
>   switches all tasks without blocking to avoid issues which can arise from
>   partially switched states (e.g. the switching task itself being starved).
>   The disable path can't trust the BPF scheduler at all, so it also has to
>   guarantee forward progress without blocking. See scx_ops_enable() and
>   scx_ops_disable_workfn().
> 
> * When sched_ext is disabled, static_branches are used to shut down the
>   entry points from hot paths.
> 
> v5: * To accommodate 32bit configs, p->scx.ops_state is now atomic_long_t
>       instead of atomic64_t and scx_dsp_buf_ent.qseq which uses
>       load_acquire/store_release is now unsigned long instead of u64.
> 
>     * Fix the bug where bpf_scx_btf_struct_access() was allowing write
>       access to arbitrary fields.
> 
>     * Distinguish kfuncs which can be called from any sched_ext ops and from
>       anywhere. e.g. scx_bpf_pick_idle_cpu() can now be called only from
>       sched_ext ops.
> 
>     * Rename "type" to "kind" in scx_exit_info to make it easier to use on
>       languages in which "type" is a reserved keyword.
> 
>     * Since cff9b2332ab7 ("kernel/sched: Modify initial boot task idle
>       setup"), PF_IDLE is not set on idle tasks which haven't been online
>       yet which made scx_task_iter_next_filtered() include those idle tasks
>       in iterations leading to oopses. Update scx_task_iter_next_filtered()
>       to directly test p->sched_class against idle_sched_class instead of
>       using is_idle_task() which tests PF_IDLE.
> 
>     * Other updates to match upstream changes such as adding const to
>       set_cpumask() param and renaming check_preempt_curr() to
>       wakeup_preempt().
> 
> v4: * SCHED_CHANGE_BLOCK replaced with the previous
>       sched_deq_and_put_task()/sched_enq_and_set_tsak() pair. This is
>       because upstream is adaopting a different generic cleanup mechanism.
>       Once that lands, the code will be adapted accordingly.
> 
>     * task_on_scx() used to test whether a task should be switched into SCX,
>       which is confusing. Renamed to task_should_scx(). task_on_scx() now
>       tests whether a task is currently on SCX.
> 
>     * scx_has_idle_cpus is barely used anymore and replaced with direct
>       check on the idle cpumask.
> 
>     * SCX_PICK_IDLE_CORE added and scx_pick_idle_cpu() improved to prefer
>       fully idle cores.
> 
>     * ops.enable() now sees up-to-date p->scx.weight value.
> 
>     * ttwu_queue path is disabled for tasks on SCX to avoid confusing BPF
>       schedulers expecting ->select_cpu() call.
> 
>     * Use cpu_smt_mask() instead of topology_sibling_cpumask() like the rest
>       of the scheduler.
> 
> v3: * ops.set_weight() added to allow BPF schedulers to track weight changes
>       without polling p->scx.weight.
> 
>     * move_task_to_local_dsq() was losing SCX-specific enq_flags when
>       enqueueing the task on the target dsq because it goes through
>       activate_task() which loses the upper 32bit of the flags. Carry the
>       flags through rq->scx.extra_enq_flags.
> 
>     * scx_bpf_dispatch(), scx_bpf_pick_idle_cpu(), scx_bpf_task_running()
>       and scx_bpf_task_cpu() now use the new KF_RCU instead of
>       KF_TRUSTED_ARGS to make it easier for BPF schedulers to call them.
> 
>     * The kfunc helper access control mechanism implemented through
>       sched_ext_entity.kf_mask is improved. Now SCX_CALL_OP*() is always
>       used when invoking scx_ops operations.
> 
> v2: * balance_scx_on_up() is dropped. Instead, on UP, balance_scx() is
>       called from put_prev_taks_scx() and pick_next_task_scx() as necessary.
>       To determine whether balance_scx() should be called from
>       put_prev_task_scx(), SCX_TASK_DEQD_FOR_SLEEP flag is added. See the
>       comment in put_prev_task_scx() for details.
> 
>     * sched_deq_and_put_task() / sched_enq_and_set_task() sequences replaced
>       with SCHED_CHANGE_BLOCK().
> 
>     * Unused all_dsqs list removed. This was a left-over from previous
>       iterations.
> 
>     * p->scx.kf_mask is added to track and enforce which kfunc helpers are
>       allowed. Also, init/exit sequences are updated to make some kfuncs
>       always safe to call regardless of the current BPF scheduler state.
>       Combined, this should make all the kfuncs safe.
> 
>     * BPF now supports sleepable struct_ops operations. Hacky workaround
>       removed and operations and kfunc helpers are tagged appropriately.
> 
>     * BPF now supports bitmask / cpumask helpers. scx_bpf_get_idle_cpumask()
>       and friends are added so that BPF schedulers can use the idle masks
>       with the generic helpers. This replaces the hacky kfunc helpers added
>       by a separate patch in V1.
> 
>     * CONFIG_SCHED_CLASS_EXT can no longer be enabled if SCHED_CORE is
>       enabled. This restriction will be removed by a later patch which adds
>       core-sched support.
> 
>     * Add MAINTAINERS entries and other misc changes.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Co-authored-by: David Vernet <dvernet@meta.com>
> Acked-by: Josh Don <joshdon@google.com>
> Acked-by: Hao Luo <haoluo@google.com>
> Acked-by: Barret Rhoden <brho@google.com>
> Cc: Andrea Righi <andrea.righi@canonical.com>

...

> +#ifdef CONFIG_SCHED_DEBUG
> +static const char *scx_ops_enable_state_str[] = {
> +	[SCX_OPS_PREPPING]	= "prepping",
> +	[SCX_OPS_ENABLING]	= "enabling",
> +	[SCX_OPS_ENABLED]	= "enabled",
> +	[SCX_OPS_DISABLING]	= "disabling",
> +	[SCX_OPS_DISABLED]	= "disabled",
> +};

We may want to move scx_ops_enable_state_str[] outside of
CONFIG_SCHED_DEBUG, because we're using it later in print_scx_info()
("sched_ext: Print sched_ext info when dumping stack"), or we make
print_scx_info() dependent of CONFIG_SCHED_DEBUG.

-Andrea

