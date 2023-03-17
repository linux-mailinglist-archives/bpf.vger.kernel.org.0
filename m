Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7CD6BF463
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 22:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCQVhY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 17:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjCQVgi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 17:36:38 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CC74FF22;
        Fri, 17 Mar 2023 14:35:48 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id p20so6654423plw.13;
        Fri, 17 Mar 2023 14:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7Hqrh9uN2SM85IaShnwVlwcijKtM51E3ZRSdB4nYhM=;
        b=Cb2TShSHt6KJ55AyY5x9lfqprejDfYU0CXDVD+UW+x+n5Y6uLkK1KUI946QZDXxxuo
         cmxhGoEP5QZ6SYPpw4cwDVoFukLoWo75e4yR5m5+CLqRnXsB6cbqgAQRDcxBnt32pgM1
         mTIlh7nrPWsY8C8Wb+kp6afrGjNRS4cL2DAKdhWcsYVbRc8lUDYgk0XqP7BwR8ADAqJJ
         Z8VYDaeB2g2mq0sXCPgXXnj3KbvrJg0p5hJLoP9DpjDHF+tLVirs0IPG/o5aqRV2h9v5
         gJuhwJ/Md6PnfrkDzsYXsjH37QPEvpXuQhajrANZApByBAG+ye0ZlqzBVFzf46XaC7un
         8hZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X7Hqrh9uN2SM85IaShnwVlwcijKtM51E3ZRSdB4nYhM=;
        b=Cy+oZuMkShu9yb8vrIfIKufq4NZr6avlrttxt92CNmxpdqivPGFGBuJ4hHmwMsxSwD
         GCVHL6SibbZ0bRjpUWVhD6dKmUMgzBlaO/747yYiOzaJCo9oLDS+z8IKkxrd3mR64BOa
         YbS2UT4IclV0MMX+/9+bdRTW4BJ4ATcgNOl6YS4bmCrZ1alSthdf8ZKY29FNX/IPSLvo
         06rY33KAUJ/zHC3k1APkpsMTqCg8TVTDZqi2tB2ZK0jWvIf2nVpk/u8q8CIivRsFEX2q
         ZG2xW8SkDquUZ1ph4nV6gXJCdVyKgfJE2raMMJXMvBmdGou9DvZ5hkTIzF+hHGGyV+UM
         mc6Q==
X-Gm-Message-State: AO0yUKWvcX7PhCyofiG9ycMM9cpFw90/Gt7wUqM8HXnT8VR4IsUA4xg7
        MKcHiqwtIgVqI069+TqhvFk=
X-Google-Smtp-Source: AK7set9INggfGZa4ErWTtF2kMhh3wTwIqQLcYiaTp3WqY3uExH2V64lcOwZpR4j0BKsaJce0Zfp/FQ==
X-Received: by 2002:a17:902:d411:b0:1a0:53b3:ee87 with SMTP id b17-20020a170902d41100b001a053b3ee87mr6657558ple.62.1679088877607;
        Fri, 17 Mar 2023 14:34:37 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id s19-20020a170902989300b00186cf82717fsm1970146plp.165.2023.03.17.14.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:34:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 30/32] sched_ext: Documentation: scheduler: Document extensible scheduler class
Date:   Fri, 17 Mar 2023 11:33:31 -1000
Message-Id: <20230317213333.2174969-31-tj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317213333.2174969-1-tj@kernel.org>
References: <20230317213333.2174969-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add Documentation/scheduler/sched-ext.rst which gives a high-level overview
and pointers to the examples.

v2: Apply minor edits suggested by Bagas. Caveats section dropped as all of
    them are addressed.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/scheduler/index.rst     |   1 +
 Documentation/scheduler/sched-ext.rst | 230 ++++++++++++++++++++++++++
 include/linux/sched/ext.h             |   2 +
 kernel/Kconfig.preempt                |   2 +
 kernel/sched/ext.c                    |   2 +
 kernel/sched/ext.h                    |   2 +
 6 files changed, 239 insertions(+)
 create mode 100644 Documentation/scheduler/sched-ext.rst

diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
index 3170747226f6..0b650bb550e6 100644
--- a/Documentation/scheduler/index.rst
+++ b/Documentation/scheduler/index.rst
@@ -19,6 +19,7 @@ Scheduler
     sched-nice-design
     sched-rt-group
     sched-stats
+    sched-ext
     sched-debug
 
     text_files
diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
new file mode 100644
index 000000000000..84c30b44f104
--- /dev/null
+++ b/Documentation/scheduler/sched-ext.rst
@@ -0,0 +1,230 @@
+==========================
+Extensible Scheduler Class
+==========================
+
+sched_ext is a scheduler class whose behavior can be defined by a set of BPF
+programs - the BPF scheduler.
+
+* sched_ext exports a full scheduling interface so that any scheduling
+  algorithm can be implemented on top.
+
+* The BPF scheduler can group CPUs however it sees fit and schedule them
+  together, as tasks aren't tied to specific CPUs at the time of wakeup.
+
+* The BPF scheduler can be turned on and off dynamically anytime.
+
+* The system integrity is maintained no matter what the BPF scheduler does.
+  The default scheduling behavior is restored anytime an error is detected,
+  a runnable task stalls, or on invoking the SysRq key sequence
+  :kbd:`SysRq-S`.
+
+Switching to and from sched_ext
+===============================
+
+``CONFIG_SCHED_CLASS_EXT`` is the config option to enable sched_ext and
+``tools/sched_ext`` contains the example schedulers.
+
+sched_ext is used only when the BPF scheduler is loaded and running.
+
+If a task explicitly sets its scheduling policy to ``SCHED_EXT``, it will be
+treated as ``SCHED_NORMAL`` and scheduled by CFS until the BPF scheduler is
+loaded. On load, such tasks will be switched to and scheduled by sched_ext.
+
+The BPF scheduler can choose to schedule all normal and lower class tasks by
+calling ``scx_bpf_switch_all()`` from its ``init()`` operation. In this
+case, all ``SCHED_NORMAL``, ``SCHED_BATCH``, ``SCHED_IDLE`` and
+``SCHED_EXT`` tasks are scheduled by sched_ext. In the example schedulers,
+this mode can be selected with the ``-a`` option.
+
+Terminating the sched_ext scheduler program, triggering :kbd:`SysRq-S`, or
+detection of any internal error including stalled runnable tasks aborts the
+BPF scheduler and reverts all tasks back to CFS.
+
+.. code-block:: none
+
+    # make -j16 -C tools/sched_ext
+    # tools/sched_ext/scx_example_simple
+    local=0 global=3
+    local=5 global=24
+    local=9 global=44
+    local=13 global=56
+    local=17 global=72
+    ^CEXIT: BPF scheduler unregistered
+
+If ``CONFIG_SCHED_DEBUG`` is set, the current status of the BPF scheduler
+and whether a given task is on sched_ext can be determined as follows:
+
+.. code-block:: none
+
+    # cat /sys/kernel/debug/sched/ext
+    ops                           : simple
+    enabled                       : 1
+    switching_all                 : 1
+    switched_all                  : 1
+    enable_state                  : enabled
+
+    # grep ext /proc/self/sched
+    ext.enabled                                  :                    1
+
+The Basics
+==========
+
+Userspace can implement an arbitrary BPF scheduler by loading a set of BPF
+programs that implement ``struct sched_ext_ops``. The only mandatory field
+is ``ops.name`` which must be a valid BPF object name. All operations are
+optional. The following modified excerpt is from
+``tools/sched/scx_example_simple.bpf.c`` showing a minimal global FIFO
+scheduler.
+
+.. code-block:: c
+
+    s32 BPF_STRUCT_OPS(simple_init)
+    {
+            if (!switch_partial)
+                    scx_bpf_switch_all();
+            return 0;
+    }
+
+    void BPF_STRUCT_OPS(simple_enqueue, struct task_struct *p, u64 enq_flags)
+    {
+            if (enq_flags & SCX_ENQ_LOCAL)
+                    scx_bpf_dispatch(p, SCX_DSQ_LOCAL, enq_flags);
+            else
+                    scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, enq_flags);
+    }
+
+    void BPF_STRUCT_OPS(simple_exit, struct scx_exit_info *ei)
+    {
+            exit_type = ei->type;
+    }
+
+    SEC(".struct_ops")
+    struct sched_ext_ops simple_ops = {
+            .enqueue                = (void *)simple_enqueue,
+            .init                   = (void *)simple_init,
+            .exit                   = (void *)simple_exit,
+            .name                   = "simple",
+    };
+
+Dispatch Queues
+---------------
+
+To match the impedance between the scheduler core and the BPF scheduler,
+sched_ext uses DSQs (dispatch queues) which can operate as both a FIFO and a
+priority queue. By default, there is one global FIFO (``SCX_DSQ_GLOBAL``),
+and one local dsq per CPU (``SCX_DSQ_LOCAL``). The BPF scheduler can manage
+an arbitrary number of dsq's using ``scx_bpf_create_dsq()`` and
+``scx_bpf_destroy_dsq()``.
+
+A CPU always executes a task from its local DSQ. A task is "dispatched" to a
+DSQ. A non-local DSQ is "consumed" to transfer a task to the consuming CPU's
+local DSQ.
+
+When a CPU is looking for the next task to run, if the local DSQ is not
+empty, the first task is picked. Otherwise, the CPU tries to consume the
+global DSQ. If that doesn't yield a runnable task either, ``ops.dispatch()``
+is invoked.
+
+Scheduling Cycle
+----------------
+
+The following briefly shows how a waking task is scheduled and executed.
+
+1. When a task is waking up, ``ops.select_cpu()`` is the first operation
+   invoked. This serves two purposes. First, CPU selection optimization
+   hint. Second, waking up the selected CPU if idle.
+
+   The CPU selected by ``ops.select_cpu()`` is an optimization hint and not
+   binding. The actual decision is made at the last step of scheduling.
+   However, there is a small performance gain if the CPU
+   ``ops.select_cpu()`` returns matches the CPU the task eventually runs on.
+
+   A side-effect of selecting a CPU is waking it up from idle. While a BPF
+   scheduler can wake up any cpu using the ``scx_bpf_kick_cpu()`` helper,
+   using ``ops.select_cpu()`` judiciously can be simpler and more efficient.
+
+   Note that the scheduler core will ignore an invalid CPU selection, for
+   example, if it's outside the allowed cpumask of the task.
+
+2. Once the target CPU is selected, ``ops.enqueue()`` is invoked. It can
+   make one of the following decisions:
+
+   * Immediately dispatch the task to either the global or local DSQ by
+     calling ``scx_bpf_dispatch()`` with ``SCX_DSQ_GLOBAL`` or
+     ``SCX_DSQ_LOCAL``, respectively.
+
+   * Immediately dispatch the task to a custom DSQ by calling
+     ``scx_bpf_dispatch()`` with a DSQ ID which is smaller than 2^63.
+
+   * Queue the task on the BPF side.
+
+3. When a CPU is ready to schedule, it first looks at its local DSQ. If
+   empty, it then looks at the global DSQ. If there still isn't a task to
+   run, ``ops.dispatch()`` is invoked which can use the following two
+   functions to populate the local DSQ.
+
+   * ``scx_bpf_dispatch()`` dispatches a task to a DSQ. Any target DSQ can
+     be used - ``SCX_DSQ_LOCAL``, ``SCX_DSQ_LOCAL_ON | cpu``,
+     ``SCX_DSQ_GLOBAL`` or a custom DSQ. While ``scx_bpf_dispatch()``
+     currently can't be called with BPF locks held, this is being worked on
+     and will be supported. ``scx_bpf_dispatch()`` schedules dispatching
+     rather than performing them immediately. There can be up to
+     ``ops.dispatch_max_batch`` pending tasks.
+
+   * ``scx_bpf_consume()`` tranfers a task from the specified non-local DSQ
+     to the dispatching DSQ. This function cannot be called with any BPF
+     locks held. ``scx_bpf_consume()`` flushes the pending dispatched tasks
+     before trying to consume the specified DSQ.
+
+4. After ``ops.dispatch()`` returns, if there are tasks in the local DSQ,
+   the CPU runs the first one. If empty, the following steps are taken:
+
+   * Try to consume the global DSQ. If successful, run the task.
+
+   * If ``ops.dispatch()`` has dispatched any tasks, retry #3.
+
+   * If the previous task is an SCX task and still runnable, keep executing
+     it (see ``SCX_OPS_ENQ_LAST``).
+
+   * Go idle.
+
+Note that the BPF scheduler can always choose to dispatch tasks immediately
+in ``ops.enqueue()`` as illustrated in the above simple example. If only the
+built-in DSQs are used, there is no need to implement ``ops.dispatch()`` as
+a task is never queued on the BPF scheduler and both the local and global
+DSQs are consumed automatically.
+
+``scx_bpf_dispatch()`` queues the task on the FIFO of the target DSQ. Use
+``scx_bpf_dispatch_vtime()`` for the priority queue. See the function
+documentation and usage in ``tools/sched_ext/scx_example_simple.bpf.c`` for
+more information.
+
+Where to Look
+=============
+
+* ``include/linux/sched/ext.h`` defines the core data structures, ops table
+  and constants.
+
+* ``kernel/sched/ext.c`` contains sched_ext core implementation and helpers.
+  The functions prefixed with ``scx_bpf_`` can be called from the BPF
+  scheduler.
+
+* ``tools/sched_ext/`` hosts example BPF scheduler implementations.
+
+  * ``scx_example_simple[.bpf].c``: Minimal global FIFO scheduler example
+    using a custom DSQ.
+
+  * ``scx_example_qmap[.bpf].c``: A multi-level FIFO scheduler supporting
+    five levels of priority implemented with ``BPF_MAP_TYPE_QUEUE``.
+
+ABI Instability
+===============
+
+The APIs provided by sched_ext to BPF schedulers programs have no stability
+guarantees. This includes the ops table callbacks and constants defined in
+``include/linux/sched/ext.h``, as well as the ``scx_bpf_`` kfuncs defined in
+``kernel/sched/ext.c``.
+
+While we will attempt to provide a relatively stable API surface when
+possible, they are subject to change without warning between kernel
+versions.
diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index fe2b051230b2..61837aac8ab3 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
+ * BPF extensible scheduler class: Documentation/scheduler/sched-ext.rst
+ *
  * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
  * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
  * Copyright (c) 2022 David Vernet <dvernet@meta.com>
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index e12a057ead7b..bae49b743834 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -154,3 +154,5 @@ config SCHED_CLASS_EXT
 	  wish to implement scheduling policies. The struct_ops structure
 	  exported by sched_ext is struct sched_ext_ops, and is conceptually
 	  similar to struct sched_class.
+
+	  See Documentation/scheduler/sched-ext.rst for more details.
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 869d11e738cd..f4a2b1d1374a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
+ * BPF extensible scheduler class: Documentation/scheduler/sched-ext.rst
+ *
  * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
  * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
  * Copyright (c) 2022 David Vernet <dvernet@meta.com>
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index b5a31fae2168..998b790b3928 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
+ * BPF extensible scheduler class: Documentation/scheduler/sched-ext.rst
+ *
  * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
  * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
  * Copyright (c) 2022 David Vernet <dvernet@meta.com>
-- 
2.39.2

