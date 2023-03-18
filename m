Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA3F6BF754
	for <lists+bpf@lfdr.de>; Sat, 18 Mar 2023 03:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCRCGJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 22:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRCGI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 22:06:08 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7C350726;
        Fri, 17 Mar 2023 19:06:06 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c10so4130593pfv.13;
        Fri, 17 Mar 2023 19:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679105166;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aBIwOrliQlzq74KKk9CVIcEQWE6djUauoKBeZyvQpEI=;
        b=Ttb2B9E36gRQd/rH7197D6SBTEN4TrS52J3Y/I7z1zVsaF2yH9s0QqBYr4v2RaqnK/
         gj8ZnVfbwFA5Ovm82BwYHVbKbz/fzKoCrXyp5Yq9CEnYqPDjMt0kVAKT54CkloVNvIg1
         KycHazwkxm7mH9rgTcZaVHXaY9U1rzVAZTbgA7C6WVVegA9EQhGvu11BGINYnNqfSz02
         NGSRGZFom3QzIb5Bue9CnJ1QmyCj5GDCahppwA7XULOOcc9dj+v3+qCfT+1dHquwZns+
         X9Q4cV+pOJatUaJyqHpX/e+X6+5KslKh7p/2kSOLna+MNym7sXWenqW0wkNik9HTRZyc
         j/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679105166;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aBIwOrliQlzq74KKk9CVIcEQWE6djUauoKBeZyvQpEI=;
        b=OjOkteQGPHGYMTZBwMFUMcqiT4bp+FS/9N1KBllEnJAhsDJEIH2psRA6JWm1d9aP2H
         nXLLbHaj7IbsXKwL6IR4akXG3GFmenG2b0C4Cghkxl28KdxraGZtNJWW3g4WN3vcOTFD
         zoLOqGJwv5xsuDJ8WocZI4u665J7yoZDn7XvVVe5vWTxZ3MwxHRbQzFkpDQnDXaziwNe
         CTQy3YZc0Sg0NjEtqe7pMXndBJ7teM6DpuqTQLcghxZgG2hCsGBzMupiTwZfQ2q00der
         i+kwUH2DvApTakLq1OxSpnLyHLh+Xqd/74D9VHe5bRe7XspwKRCfQBt8uTTA0pzUNiPe
         w5EA==
X-Gm-Message-State: AO0yUKVHHEhAYaJ3xvbbjuDpGO2vbHVcunzCNpX/Y6q/duQnYtIxPexF
        FPwLAFscGpTecLq5RM9PK4Q=
X-Google-Smtp-Source: AK7set/i9NEHMglMgKf0EI9cPWjE4/onFkv1r0lpi7SrT7RVIsS2rOeiY1RWsg9n5vxWKMnaXyDgwQ==
X-Received: by 2002:aa7:850f:0:b0:625:5403:cd87 with SMTP id v15-20020aa7850f000000b006255403cd87mr4136577pfn.11.1679105165464;
        Fri, 17 Mar 2023 19:06:05 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-7.three.co.id. [180.214.232.7])
        by smtp.gmail.com with ESMTPSA id p14-20020a62ab0e000000b0062505afff9fsm2153831pff.126.2023.03.17.19.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 19:06:05 -0700 (PDT)
Message-ID: <9437e5fa-3bf8-5e7a-7150-ccc5eac3ad57@gmail.com>
Date:   Sat, 18 Mar 2023 09:05:55 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 30/32] sched_ext: Documentation: scheduler: Document
 extensible scheduler class
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, torvalds@linux-foundation.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
References: <20230317213333.2174969-1-tj@kernel.org>
 <20230317213333.2174969-31-tj@kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230317213333.2174969-31-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/18/23 04:33, Tejun Heo wrote:
> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> new file mode 100644
> index 000000000000..84c30b44f104
> --- /dev/null
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -0,0 +1,230 @@
> +==========================
> +Extensible Scheduler Class
> +==========================
> +
> +sched_ext is a scheduler class whose behavior can be defined by a set of BPF
> +programs - the BPF scheduler.
> +
> +* sched_ext exports a full scheduling interface so that any scheduling
> +  algorithm can be implemented on top.
> +
> +* The BPF scheduler can group CPUs however it sees fit and schedule them
> +  together, as tasks aren't tied to specific CPUs at the time of wakeup.
> +
> +* The BPF scheduler can be turned on and off dynamically anytime.
> +
> +* The system integrity is maintained no matter what the BPF scheduler does.
> +  The default scheduling behavior is restored anytime an error is detected,
> +  a runnable task stalls, or on invoking the SysRq key sequence
> +  :kbd:`SysRq-S`.
> +
> +Switching to and from sched_ext
> +===============================
> +
> +``CONFIG_SCHED_CLASS_EXT`` is the config option to enable sched_ext and
> +``tools/sched_ext`` contains the example schedulers.
> +
> +sched_ext is used only when the BPF scheduler is loaded and running.
> +
> +If a task explicitly sets its scheduling policy to ``SCHED_EXT``, it will be
> +treated as ``SCHED_NORMAL`` and scheduled by CFS until the BPF scheduler is
> +loaded. On load, such tasks will be switched to and scheduled by sched_ext.
> +
> +The BPF scheduler can choose to schedule all normal and lower class tasks by
> +calling ``scx_bpf_switch_all()`` from its ``init()`` operation. In this
> +case, all ``SCHED_NORMAL``, ``SCHED_BATCH``, ``SCHED_IDLE`` and
> +``SCHED_EXT`` tasks are scheduled by sched_ext. In the example schedulers,
> +this mode can be selected with the ``-a`` option.
> +
> +Terminating the sched_ext scheduler program, triggering :kbd:`SysRq-S`, or
> +detection of any internal error including stalled runnable tasks aborts the
> +BPF scheduler and reverts all tasks back to CFS.
> +
> +.. code-block:: none
> +
> +    # make -j16 -C tools/sched_ext
> +    # tools/sched_ext/scx_example_simple
> +    local=0 global=3
> +    local=5 global=24
> +    local=9 global=44
> +    local=13 global=56
> +    local=17 global=72
> +    ^CEXIT: BPF scheduler unregistered
> +
> +If ``CONFIG_SCHED_DEBUG`` is set, the current status of the BPF scheduler
> +and whether a given task is on sched_ext can be determined as follows:
> +
> +.. code-block:: none
> +
> +    # cat /sys/kernel/debug/sched/ext
> +    ops                           : simple
> +    enabled                       : 1
> +    switching_all                 : 1
> +    switched_all                  : 1
> +    enable_state                  : enabled
> +
> +    # grep ext /proc/self/sched
> +    ext.enabled                                  :                    1
> +
> +The Basics
> +==========
> +
> +Userspace can implement an arbitrary BPF scheduler by loading a set of BPF
> +programs that implement ``struct sched_ext_ops``. The only mandatory field
> +is ``ops.name`` which must be a valid BPF object name. All operations are
> +optional. The following modified excerpt is from
> +``tools/sched/scx_example_simple.bpf.c`` showing a minimal global FIFO
> +scheduler.
> +
> +.. code-block:: c
> +
> +    s32 BPF_STRUCT_OPS(simple_init)
> +    {
> +            if (!switch_partial)
> +                    scx_bpf_switch_all();
> +            return 0;
> +    }
> +
> +    void BPF_STRUCT_OPS(simple_enqueue, struct task_struct *p, u64 enq_flags)
> +    {
> +            if (enq_flags & SCX_ENQ_LOCAL)
> +                    scx_bpf_dispatch(p, SCX_DSQ_LOCAL, enq_flags);
> +            else
> +                    scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, enq_flags);
> +    }
> +
> +    void BPF_STRUCT_OPS(simple_exit, struct scx_exit_info *ei)
> +    {
> +            exit_type = ei->type;
> +    }
> +
> +    SEC(".struct_ops")
> +    struct sched_ext_ops simple_ops = {
> +            .enqueue                = (void *)simple_enqueue,
> +            .init                   = (void *)simple_init,
> +            .exit                   = (void *)simple_exit,
> +            .name                   = "simple",
> +    };
> +
> +Dispatch Queues
> +---------------
> +
> +To match the impedance between the scheduler core and the BPF scheduler,
> +sched_ext uses DSQs (dispatch queues) which can operate as both a FIFO and a
> +priority queue. By default, there is one global FIFO (``SCX_DSQ_GLOBAL``),
> +and one local dsq per CPU (``SCX_DSQ_LOCAL``). The BPF scheduler can manage
> +an arbitrary number of dsq's using ``scx_bpf_create_dsq()`` and
> +``scx_bpf_destroy_dsq()``.
> +
> +A CPU always executes a task from its local DSQ. A task is "dispatched" to a
> +DSQ. A non-local DSQ is "consumed" to transfer a task to the consuming CPU's
> +local DSQ.
> +
> +When a CPU is looking for the next task to run, if the local DSQ is not
> +empty, the first task is picked. Otherwise, the CPU tries to consume the
> +global DSQ. If that doesn't yield a runnable task either, ``ops.dispatch()``
> +is invoked.
> +
> +Scheduling Cycle
> +----------------
> +
> +The following briefly shows how a waking task is scheduled and executed.
> +
> +1. When a task is waking up, ``ops.select_cpu()`` is the first operation
> +   invoked. This serves two purposes. First, CPU selection optimization
> +   hint. Second, waking up the selected CPU if idle.
> +
> +   The CPU selected by ``ops.select_cpu()`` is an optimization hint and not
> +   binding. The actual decision is made at the last step of scheduling.
> +   However, there is a small performance gain if the CPU
> +   ``ops.select_cpu()`` returns matches the CPU the task eventually runs on.
> +
> +   A side-effect of selecting a CPU is waking it up from idle. While a BPF
> +   scheduler can wake up any cpu using the ``scx_bpf_kick_cpu()`` helper,
> +   using ``ops.select_cpu()`` judiciously can be simpler and more efficient.
> +
> +   Note that the scheduler core will ignore an invalid CPU selection, for
> +   example, if it's outside the allowed cpumask of the task.
> +
> +2. Once the target CPU is selected, ``ops.enqueue()`` is invoked. It can
> +   make one of the following decisions:
> +
> +   * Immediately dispatch the task to either the global or local DSQ by
> +     calling ``scx_bpf_dispatch()`` with ``SCX_DSQ_GLOBAL`` or
> +     ``SCX_DSQ_LOCAL``, respectively.
> +
> +   * Immediately dispatch the task to a custom DSQ by calling
> +     ``scx_bpf_dispatch()`` with a DSQ ID which is smaller than 2^63.
> +
> +   * Queue the task on the BPF side.
> +
> +3. When a CPU is ready to schedule, it first looks at its local DSQ. If
> +   empty, it then looks at the global DSQ. If there still isn't a task to
> +   run, ``ops.dispatch()`` is invoked which can use the following two
> +   functions to populate the local DSQ.
> +
> +   * ``scx_bpf_dispatch()`` dispatches a task to a DSQ. Any target DSQ can
> +     be used - ``SCX_DSQ_LOCAL``, ``SCX_DSQ_LOCAL_ON | cpu``,
> +     ``SCX_DSQ_GLOBAL`` or a custom DSQ. While ``scx_bpf_dispatch()``
> +     currently can't be called with BPF locks held, this is being worked on
> +     and will be supported. ``scx_bpf_dispatch()`` schedules dispatching
> +     rather than performing them immediately. There can be up to
> +     ``ops.dispatch_max_batch`` pending tasks.
> +
> +   * ``scx_bpf_consume()`` tranfers a task from the specified non-local DSQ
> +     to the dispatching DSQ. This function cannot be called with any BPF
> +     locks held. ``scx_bpf_consume()`` flushes the pending dispatched tasks
> +     before trying to consume the specified DSQ.
> +
> +4. After ``ops.dispatch()`` returns, if there are tasks in the local DSQ,
> +   the CPU runs the first one. If empty, the following steps are taken:
> +
> +   * Try to consume the global DSQ. If successful, run the task.
> +
> +   * If ``ops.dispatch()`` has dispatched any tasks, retry #3.
> +
> +   * If the previous task is an SCX task and still runnable, keep executing
> +     it (see ``SCX_OPS_ENQ_LAST``).
> +
> +   * Go idle.
> +
> +Note that the BPF scheduler can always choose to dispatch tasks immediately
> +in ``ops.enqueue()`` as illustrated in the above simple example. If only the
> +built-in DSQs are used, there is no need to implement ``ops.dispatch()`` as
> +a task is never queued on the BPF scheduler and both the local and global
> +DSQs are consumed automatically.
> +
> +``scx_bpf_dispatch()`` queues the task on the FIFO of the target DSQ. Use
> +``scx_bpf_dispatch_vtime()`` for the priority queue. See the function
> +documentation and usage in ``tools/sched_ext/scx_example_simple.bpf.c`` for
> +more information.
> +
> +Where to Look
> +=============
> +
> +* ``include/linux/sched/ext.h`` defines the core data structures, ops table
> +  and constants.
> +
> +* ``kernel/sched/ext.c`` contains sched_ext core implementation and helpers.
> +  The functions prefixed with ``scx_bpf_`` can be called from the BPF
> +  scheduler.
> +
> +* ``tools/sched_ext/`` hosts example BPF scheduler implementations.
> +
> +  * ``scx_example_simple[.bpf].c``: Minimal global FIFO scheduler example
> +    using a custom DSQ.
> +
> +  * ``scx_example_qmap[.bpf].c``: A multi-level FIFO scheduler supporting
> +    five levels of priority implemented with ``BPF_MAP_TYPE_QUEUE``.
> +
> +ABI Instability
> +===============
> +
> +The APIs provided by sched_ext to BPF schedulers programs have no stability
> +guarantees. This includes the ops table callbacks and constants defined in
> +``include/linux/sched/ext.h``, as well as the ``scx_bpf_`` kfuncs defined in
> +``kernel/sched/ext.c``.
> +
> +While we will attempt to provide a relatively stable API surface when
> +possible, they are subject to change without warning between kernel
> +versions.

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

