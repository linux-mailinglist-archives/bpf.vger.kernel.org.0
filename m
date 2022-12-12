Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289FA64A5B0
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 18:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbiLLRQL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 12:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiLLRQI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 12:16:08 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D08912A82;
        Mon, 12 Dec 2022 09:16:07 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id x66so349972pfx.3;
        Mon, 12 Dec 2022 09:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KkETVtjNql38ee8U9feqE4wHK2PcTNpDFmLjvIwrvXA=;
        b=VYx3w9d+j77ACI97pFFJiiVhnFEBP4ZG5nUGeA1+sv9wkkRyLmbtZNKegUSNvP/lWA
         F4+bi7XkVLNYh/xRxzhM2g61Q6zwKsv6I+bqHrcC8ktX5q8TiZTo6yvRlESnSzbEb7fX
         X8nIunviPh7DpRbtRSvPyIX4rUg3n4uRR85Ac4L1Ul2STSoOoSPwmZS0+FB829oTZh1U
         pEmjYbwqDnoXJzLXdXjihkbjtk8IvZ9w6UQtpnMdCiBk56suwV1z7l87rKA47/3qy7PK
         4PaIxDGRvPu9AHhqYqB7/vxFQRsDWS0BpUSprJy4ZVSr4i8cMxaHuBSczo0ZYVQT9LKS
         IkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkETVtjNql38ee8U9feqE4wHK2PcTNpDFmLjvIwrvXA=;
        b=hNfAFOyy8HtuEIddtw+QkIRenU4aCYG8lgChhj800QiZ68oWUvMZBjcvSOFa/pFRU0
         CcWpNnnoJWbrZ75YHFuOkDW21ZhTbk3xVrV49UpsfVvIR5zFvJWY89x/5w2tPQa6HlBF
         eMiq5EhFFzCMPc8lGe6j9OlSKiYs3Bkkx6avxFs3fLnE5HItkk5yg3QlxAoi7T4KYoQ7
         ig2pqLE/J8lmIa80k3q91EJtiPsxIztZeJpD40VQ3jtyG6KtnJtWCEzjXBQoOHmgv3T8
         Bi2yM6w6xGLM4zTKsQbcsPdGCxDJuxVAW9qkbmWcnF3I+WPMyQ957Xgba7DkL1gixcfU
         YpYQ==
X-Gm-Message-State: ANoB5pl2GKEJLhLBFoYS3UY3oVus6GqTOt4vM29QEBZThirItVsn+Io5
        iAQQIz3MHNGLQWeD5I5Wt7I=
X-Google-Smtp-Source: AA0mqf79wMrtwyJxk3t9uzBUVB0XXjqL/Cdh7BSgYvAlGok23onw8EHJOM79xmUV2D5GkTibE3gB/A==
X-Received: by 2002:aa7:8093:0:b0:574:cc3d:a24e with SMTP id v19-20020aa78093000000b00574cc3da24emr14413968pff.5.1670865365926;
        Mon, 12 Dec 2022 09:16:05 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:9159])
        by smtp.gmail.com with ESMTPSA id o11-20020aa7978b000000b00576e4c7b9ecsm6034131pfp.214.2022.12.12.09.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 09:16:05 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Dec 2022 07:16:03 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, joshdon@google.com, brho@google.com,
        pjt@google.com, derkling@google.com, haoluo@google.com,
        dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
        riel@surriel.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 28/31] sched_ext: Add
 Documentation/scheduler/sched-ext.rst
Message-ID: <Y5dh0yejx4t2iIe8@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-29-tj@kernel.org>
 <Y5cg6FgDnYkVES0R@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5cg6FgDnYkVES0R@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Mon, Dec 12, 2022 at 01:39:04PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 29, 2022 at 10:23:10PM -1000, Tejun Heo wrote:
> 
> If you expect me to read this, please as to provide something readable,
> not markup gibberish.

Hmmm... Everything under Documentation/scheduler is in rst markup. I don't
care about the file format. If plain text is preferable, that's fine but
that'd look odd in that directory.

For your reading convenience, the following is the formatted output:

 https://github.com/htejun/sched_ext/blob/sched_ext/Documentation/scheduler/sched-ext.rst

and the following is the plain text version with markups stripped out. FWIW,
while the double-backtick quoting is a bit distracting, there aren't whole
lot of markups to strip out.

==========================
Extensible Scheduler Class
==========================

sched_ext is a scheduler class whose behavior can be defined by a set of BPF
programs - the BPF scheduler.

* sched_ext exports a full scheduling interface so that any scheduling
  algorithm can be implemented on top.

* The BPF scheduler can group CPUs however it sees fit and schedule them
  together, as tasks aren't tied to specific CPUs at the time of wakeup.

* The BPF scheduler can be turned on and off dynamically anytime.

* The system integrity is maintained no matter what the BPF scheduler does.
  The default scheduling behavior is restored anytime an error is detected,
  a runnable task stalls, or on invoking SysRq key sequence like `SysRq-s`.

Switching to and from sched_ext
===============================

CONFIG_SCHED_CLASS_EXT is the config option to enable sched_ext and
tools/sched_ext contains the example schedulers.

sched_ext is used only when the BPF scheduler is loaded and running.

If a task explicitly sets its scheduling policy to SCHED_EXT, it will be
treated as SCHED_NORMAL and scheduled by CFS until the BPF scheduler is
loaded. On load, such tasks will be switched to and scheduled by sched_ext.

The BPF scheduler can choose to schedule all normal and lower class tasks by
calling scx_bpf_switch_all() from its init() operation. In this case, all
SCHED_NORMAL, SCHED_BATCH, SCHED_IDLE and SCHED_EXT tasks are scheduled by
sched_ext. In the example schedulers, this mode can be selected with the -a
option.

Terminating the sched_ext scheduler program, triggering SysRq key, or
detection of any internal error including stalled runnable tasks aborts the
BPF scheduler and reverts all tasks back to CFS.

    # make -j16 -C tools/sched_ext
    # tools/sched_ext/scx_example_dummy -a
    local=0 global=3
    local=5 global=24
    local=9 global=44
    local=13 global=56
    local=17 global=72
    ^CEXIT: BPF scheduler unregistered

If CONFIG_SCHED_DEBUG is set, the current status of the BPF scheduler and
whether a given task is on sched_ext can be determined as follows:

    # cat /sys/kernel/debug/sched/ext
    ops                           : dummy
    enabled                       : 1
    switching_all                 : 1
    switched_all                  : 1
    enable_state                  : enabled

    # grep ext /proc/self/sched
    ext.enabled                                  :                    1

The Basics
==========

Userspace can implement an arbitrary BPF scheduler by loading a set of BPF
programs that implement struct sched_ext_ops. The only mandatory field is
ops.name which must be a valid BPF object name. All operations are optional.
The following modified excerpt is from tools/sched/scx_example_dummy.bpf.c
showing a minimal global FIFO scheduler.

    s32 BPF_STRUCT_OPS(dummy_init)
    {
            if (switch_all)
                    scx_bpf_switch_all();
            return 0;
    }

    void BPF_STRUCT_OPS(dummy_enqueue, struct task_struct *p, u64 enq_flags)
    {
            if (enq_flags & SCX_ENQ_LOCAL)
                    scx_bpf_dispatch(p, SCX_DSQ_LOCAL, enq_flags);
            else
                    scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, enq_flags);
    }

    void BPF_STRUCT_OPS(dummy_exit, struct scx_exit_info *ei)
    {
            exit_type = ei->type;
    }

    SEC(".struct_ops")
    struct sched_ext_ops dummy_ops = {
            .enqueue                = (void *)dummy_enqueue,
            .init                   = (void *)dummy_init,
            .exit                   = (void *)dummy_exit,
            .name                   = "dummy",
    };

Dispatch Queues
---------------

To match the impedance between the scheduler core and the BPF scheduler,
sched_ext uses simple FIFOs called DSQs (dispatch queues). By default, there
is one global FIFO (SCX_DSQ_GLOBAL), and one local dsq per CPU
(SCX_DSQ_LOCAL). The BPF scheduler can manage an arbitrary number of dsq's
using scx_bpf_create_dsq() and scx_bpf_destroy_dsq().

A CPU always executes a task from its local DSQ. A task is "dispatched" to a
DSQ. A non-local DSQ is "consumed" to transfer a task to the consuming CPU's
local DSQ.

When a CPU is looking for the next task to run, if the local DSQ is not
empty, the first task is picked. Otherwise, the CPU tries to consume the
global DSQ. If that doesn't yield a runnable task either, ops.dispatch() is
invoked.

Scheduling Cycle
----------------

The following briefly shows how a waking task is scheduled and executed.

1. When a task is waking up, ops.select_cpu() is the first operation
   invoked. This serves two purposes. First, CPU selection optimization
   hint. Second, waking up the selected CPU if idle.

   The CPU selected by ops.select_cpu() is an optimization hint and not
   binding. The actual decision is made at the last step of scheduling.
   However, there is a small performance gain if the CPU ops.select_cpu()
   returns matches the CPU the task eventually runs on.

   A side-effect of selecting a CPU is waking it up from idle. While a BPF
   scheduler can wake up any cpu using the scx_bpf_kick_cpu() helper, using
   ops.select_cpu() judiciously can be simpler and more efficient.

   Note that the scheduler core will ignore an invalid CPU selection, for
   example, if it's outside the allowed cpumask of the task.

2. Once the target CPU is selected, ops.enqueue() is invoked. It can make
   one of the following decisions:

   * Immediately dispatch the task to either the global or local DSQ by
     calling scx_bpf_dispatch() with SCX_DSQ_GLOBAL or SCX_DSQ_LOCAL,
     respectively.

   * Immediately dispatch the task to a custom DSQ by calling
     scx_bpf_dispatch() with a DSQ ID which is smaller than 2^63.

   * Queue the task on the BPF side.

3. When a CPU is ready to schedule, it first looks at its local DSQ. If
   empty, it then looks at the global DSQ. If there still isn't a task to
   run, ops.dispatch() is invoked which can use the following two functions
   to populate the local DSQ.

   * scx_bpf_dispatch() dispatches a task to a DSQ. Any target DSQ can be
     used - SCX_DSQ_LOCAL, SCX_DSQ_LOCAL_ON | cpu, SCX_DSQ_GLOBAL or a
     custom DSQ. While scx_bpf_dispatch() currently can't be called with BPF
     locks held, this is being worked on and will be supported.
     scx_bpf_dispatch() schedules dispatching rather than performing them
     immediately. There can be up to ops.dispatch_max_batch pending tasks.

   * scx_bpf_consume() tranfers a task from the specified non-local DSQ to
     the dispatching DSQ. This function cannot be called with any BPF locks
     held. scx_bpf_consume() flushes the pending dispatched tasks before
     trying to consume the specified DSQ.

4. After ops.dispatch() returns, if there are tasks in the local DSQ, the
   CPU runs the first one. If empty, the following steps are taken:

   * Try to consume the global DSQ. If successful, run the task.

   * If ops.dispatch() has dispatched any tasks, retry #3.

   * If the previous task is an SCX task and still runnable, keep executing
     it (see SCX_OPS_ENQ_LAST).

   * Go idle.

Note that the BPF scheduler can always choose to dispatch tasks immediately
in ops.enqueue() as illustrated in the above dummy example. If only the
built-in DSQs are used, there is no need to implement ops.dispatch() as a
task is never queued on the BPF scheduler and both the local and global DSQs
are consumed automatically.

Where to Look
=============

* include/linux/sched/ext.h defines the core data structures, ops table and
  constants.

* kernel/sched/ext.c contains sched_ext core implementation and helpers. The
  functions prefixed with scx_bpf_ can be called from the BPF scheduler.

* tools/sched_ext/ hosts example BPF scheduler implementations.

  * scx_example_dummy[.bpf].c: Minimal global FIFO scheduler example using a
    custom DSQ.

  * scx_example_qmap[.bpf].c: A multi-level FIFO scheduler supporting five
    levels of priority implemented with BPF_MAP_TYPE_QUEUE.

ABI Instability
===============

The APIs provided by sched_ext to BPF schedulers programs have no stability
guarantees. This includes the ops table callbacks and constants defined in
include/linux/sched/ext.h, as well as the scx_bpf_ kfuncs defined in
kernel/sched/ext.c.

While we will attempt to provide a relatively stable API surface when
possible, they are subject to change without warning between kernel
versions.

Caveats
=======

* The current implementation isn't safe in that the BPF scheduler can crash
  the kernel.

  * Unsafe cpumask helpers should be replaced by proper generic BPF helpers.

  * Currently, all kfunc helpers can be called by any operation as BPF
    doesn't yet support filtering kfunc calls per struct_ops operation. Some
    helpers are context sensitive as should be restricted accordingly.

  * Timers used by the BPF scheduler should be shut down when aborting.

* There are a couple BPF hacks which are still needed even for sched_ext
  proper. They should be removed in the near future.


-- 
tejun
