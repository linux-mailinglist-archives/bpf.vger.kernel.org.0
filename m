Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1B563D091
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 09:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbiK3I1K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 03:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbiK3I0G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 03:26:06 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CA95EF82;
        Wed, 30 Nov 2022 00:24:37 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id p24so12210518plw.1;
        Wed, 30 Nov 2022 00:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1q5Og4gF9TMiIChJG+mXWVfWA2k2pfdZe1vyZxuhx0=;
        b=CoqZis41No0S8AUk07QtKJMLPLj05nVLUMimfEOfLp74zpQCcnVVqlt1H6nQFk1ve/
         eD0V3kPIRlka8f4pfgN2bLigL8t0jy9pzsGeHfP00qpDLt5u0dXNwgZ51qRJPxsPYxAb
         HazKTJA6Wu8jiq7Np76aGR/YMRSmo7S0HS0pb4Gfs7ytvyAsbWL7+6QEhzTW+aymf2tb
         xbOM3aS66kYmbDbC8y6RLCxz7BQKOuvNFof/OPRC37DYYyoJor6HVTiyLalukowsDkRV
         kIgTKxgBLmiOyHSn6T6ihcJHSF8CTR4RCXzAmKVjqYUi79P5LKClyEUVr3kp2Dnq+mgI
         ewzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B1q5Og4gF9TMiIChJG+mXWVfWA2k2pfdZe1vyZxuhx0=;
        b=FbQVU7R4ETpfPXAiW/WAWxVGR8vvpyPLT/qmAPY1uik4J7rz6Pda/XbI5TOepw1FGS
         enkviue67Owd1pcO+ziPRXa11OcNsQugbueMrf/SQ2LABFFzeerCoNMCox1cvxM+MS8d
         M+35U4tyIHhErmIpZ9QGd2s3kLCsBKv0wO/mnfoqK4mBC9x0mSdNDEO+dTWBGH1uK7cQ
         aJZIfeOZXU8X6mod++ixpCz4Du4Bb12s9H+/4ZyVEZYtamWUQr3aAmitHWHd1T4EfPNr
         XdNne0vlRdzEUs/B9w2AJHlc22tfFFbesKLdwiHyE9LlSWMZsCiiqnCdEkFpzCz5/DpP
         ndhQ==
X-Gm-Message-State: ANoB5plOgimV5BXLLW5Y/yVuKzOTSuNIKQOW/7QvoTS/zLVxrTZukPpc
        pHDloBJf+kaNfOuR8ndQQCA=
X-Google-Smtp-Source: AA0mqf6+Fre1nmSTpWARo+gUGk4V/WdO9j19MlfgjXqZNXLR0ssxUZtEHCKYekvslkZMD0TiLdsTKA==
X-Received: by 2002:a17:902:b613:b0:188:f570:7bd6 with SMTP id b19-20020a170902b61300b00188f5707bd6mr41149360pls.97.1669796677134;
        Wed, 30 Nov 2022 00:24:37 -0800 (PST)
Received: from localhost ([2600:380:4a00:1415:d028:b547:7d35:7b0b])
        by smtp.gmail.com with ESMTPSA id mm10-20020a17090b358a00b00218f9bd50c7sm681574pjb.50.2022.11.30.00.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:24:36 -0800 (PST)
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
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 28/31] sched_ext: Add Documentation/scheduler/sched-ext.rst
Date:   Tue, 29 Nov 2022 22:23:10 -1000
Message-Id: <20221130082313.3241517-29-tj@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130082313.3241517-1-tj@kernel.org>
References: <20221130082313.3241517-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 Documentation/scheduler/index.rst     |   1 +
 Documentation/scheduler/sched-ext.rst | 230 ++++++++++++++++++++++++++
 include/linux/sched/ext.h             |   2 +
 kernel/sched/ext.c                    |   2 +
 kernel/sched/ext.h                    |   2 +
 5 files changed, 237 insertions(+)
 create mode 100644 Documentation/scheduler/sched-ext.rst

diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
index b430d856056a..8a27a9967284 100644
--- a/Documentation/scheduler/index.rst
+++ b/Documentation/scheduler/index.rst
@@ -18,6 +18,7 @@ Linux Scheduler
     sched-nice-design
     sched-rt-group
     sched-stats
+    sched-ext
     sched-debug
 
     text_files
diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
new file mode 100644
index 000000000000..81f78e05a6c2
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
+  a runnable task stalls, or on sysrq-S.
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
+Terminating the sched_ext scheduler program, triggering sysrq-S, or
+detection of any internal error including stalled runnable tasks aborts the
+BPF scheduler and reverts all tasks back to CFS.
+
+.. code-block:: none
+
+    # make -j16 -C tools/sched_ext
+    # tools/sched_ext/scx_example_dummy -a
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
+    ops                           : dummy
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
+is ``.name`` which must be a valid BPF object name. All operations are
+optional. The following modified excerpt is from
+``tools/sched/scx_example_dummy.bpf.c`` showing a minimal global FIFO
+scheduler.
+
+.. code-block:: c
+
+    s32 BPF_STRUCT_OPS(dummy_init)
+    {
+            if (switch_all)
+                    scx_bpf_switch_all();
+            return 0;
+    }
+
+    void BPF_STRUCT_OPS(dummy_enqueue, struct task_struct *p, u64 enq_flags)
+    {
+            if (enq_flags & SCX_ENQ_LOCAL)
+                    scx_bpf_dispatch(p, SCX_DSQ_LOCAL, enq_flags);
+            else
+                    scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, enq_flags);
+    }
+
+    void BPF_STRUCT_OPS(dummy_exit, struct scx_exit_info *ei)
+    {
+            exit_type = ei->type;
+    }
+
+    SEC(".struct_ops")
+    struct sched_ext_ops dummy_ops = {
+            .enqueue                = (void *)dummy_enqueue,
+            .init                   = (void *)dummy_init,
+            .exit                   = (void *)dummy_exit,
+            .name                   = "dummy",
+    };
+
+Dispatch Queues
+---------------
+
+To match the impedance between the scheduler core and the BPF scheduler,
+sched_ext uses simple FIFOs called dsq's (dispatch queues). By default,
+there is one global FIFO (``SCX_DSQ_GLOBAL``), and one local dsq per CPU
+(``SCX_DSQ_LOCAL``). The BPF scheduler can manage an arbitrary number of
+dsq's using ``scx_bpf_create_dsq()`` and ``scx_bpf_destroy_dsq()``.
+
+A task is always *dispatch*ed to a dsq for execution. The task starts
+execution when a CPU *consume*s the task from the dsq.
+
+Internally, a CPU only executes tasks which are running on its local dsq,
+and the ``.consume()`` operation is in fact a transfer of a task from a
+remote dsq to the CPU's local dsq. A CPU therefore only consumes from other
+dsq's when its local dsq is empty, and dispatching a task to a local dsq
+will cause it to be executed before the CPU attempts to consume tasks which
+were previously dispatched to other dsq's.
+
+Scheduling Cycle
+----------------
+
+The following briefly shows how a waking task is scheduled and executed.
+
+1. When a task is waking up, ``.select_cpu()`` is the first operation
+   invoked. This serves two purposes. First, CPU selection optimization
+   hint. Second, waking up the selected CPU if idle.
+
+   The CPU selected by ``.select_cpu()`` is an optimization hint and not
+   binding. The actual decision is made at the last step of scheduling.
+   However, there is a small performance gain if the CPU ``.select_cpu()``
+   returns matches the CPU the task eventually runs on.
+
+   A side-effect of selecting a CPU is waking it up from idle. While a BPF
+   scheduler can wake up any cpu using the ``scx_bpf_kick_cpu()`` helper,
+   using ``.select_cpu()`` judiciously can be simpler and more efficient.
+
+   Note that the scheduler core will ignore an invalid CPU selection, for
+   example, if it's outside the allowed cpumask of the task.
+
+2. Once the target CPU is selected, ``.enqueue()`` is invoked. It can make
+   one of the following decisions:
+
+   * Immediately dispatch the task to either the global or local dsq by
+     calling ``scx_bpf_dispatch()`` with ``SCX_DSQ_GLOBAL`` or
+     ``SCX_DSQ_LOCAL``, respectively.
+
+   * Immediately dispatch the task to a user-created dsq by calling
+     ``scx_bpf_dispatch()`` with a dsq ID which is smaller than 2^63.
+
+   * Queue the task on the BPF side.
+
+3. When a CPU is ready to schedule, it first looks at its local dsq. If
+   empty, it invokes ``.consume()`` which should make one or more
+   ``scx_bpf_consume()`` calls to consume tasks from dsq's. If a
+   ``scx_bpf_consume()`` call succeeds, the CPU has the next task to run and
+   ``.consume()`` can return.
+
+   If ``.consume()`` is not implemented, the built-in ``SCX_DSQ_GLOBAL`` dsq
+   is consumed by default.
+
+4. If there's still no task to run, ``.dispatch()`` is invoked which should
+   make one or more ``scx_bpf_dispatch()`` calls to dispatch tasks from the
+   BPF scheduler to one of the dsq's. If more than one task has been
+   dispatched, go back to the previous consumption step.
+
+5. If there's still no task to run, ``.consume_final()`` is invoked.
+   ``.consume_final()`` is equivalent to ``.consume()``, but is invoked
+   right before the CPU goes idle. This provide schedulers with a hook that
+   can be used to implement, e.g., more aggressive work stealing from remote
+   dsq's.
+
+Note that the BPF scheduler can always choose to dispatch tasks immediately
+in ``.enqueue()`` as illustrated in the above dummy example. In such case,
+there's no need to implement ``.dispatch()`` as a task is never queued on
+the BPF side.
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
+  * ``scx_example_dummy[.bpf].c``: Minimal global FIFO scheduler example
+    using a custom dsq.
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
+
+Caveats
+=======
+
+* The current implementation isn't safe in that the BPF scheduler can crash
+  the kernel.
+
+  * Unsafe cpumask helpers should be replaced by proper generic BPF helpers.
+
+  * Currently, all kfunc helpers can be called by any operation as BPF
+    doesn't yet support filtering kfunc calls per struct_ops operation. Some
+    helpers are context sensitive as should be restricted accordingly.
+
+  * Timers used by the BPF scheduler should be shut down when aborting.
+
+* There are a couple BPF hacks which are still needed even for sched_ext
+  proper. They should be removed in the near future.
diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index d9f941e23011..49eda3adeecf 100644
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
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index aab9ae13b88f..a28144220501 100644
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
index e1eaaba3d4c7..b97dbb840ac9 100644
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
2.38.1

