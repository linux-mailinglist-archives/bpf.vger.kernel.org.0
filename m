Return-Path: <bpf+bounces-32463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A55F890DE56
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1991C23782
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3312D19E80B;
	Tue, 18 Jun 2024 21:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAZqJy+J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1293419E7C4;
	Tue, 18 Jun 2024 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745725; cv=none; b=a7KczVipWvX8pNbIPZU2wg6PXpuxeZb0I24YV2IfnvyFpm1SaxNtxsN1FkJ3wgKDkLBfcokfS7w3Vf0aFEERPq48LoSB6LgwsBCPeozlEcy4MoVqZGROXnffsuN/iQvC0cyDi2BZjlRuLDRyDDL2mAXyAY7h0nyG3pJEmPMqb5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745725; c=relaxed/simple;
	bh=HbKluMLqVHOyXypvxKa0qJPU5R+ZViUgkCmqyWjo+kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akBntKjAIB2wI9I1aZZd7dQv9OC3oKPuT1jREVHVzP1Nx1lcE7u5U3s5XbO2mO1mflOSRGzf0VWh2zRL/x5qR1Lm7av4swpozQFsVn4bN7CW7TZUw2Koq8Fa4yFVhLxcS961WGquvqUAJ3ZJK6EHQF35mSBcU0mD7ziqE4EGh0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAZqJy+J; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c70c37287fso963424a91.0;
        Tue, 18 Jun 2024 14:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745722; x=1719350522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2Fh6rd0k8ETjtf4cnW/BnAj+Q6YlIEcR0PBAFrGwF8=;
        b=TAZqJy+J9YO6OGHqMS8uRy+D4Hftvo9pnKGNFUvWYu7q/BXJRnJ2lI3tFOPijFEFRc
         Qv5E9eAbDKTpBGQVjCsVJd5FkCwLjaI/DeZQS75dMfROuyZMo3/zDrCmAaAn1rV8cumS
         N2LeKrE7hwSk9DhLTQm1XXl4q6AGx3sJI8BDTG4V8XwMo6XTpYj3R/FRiwyzw0HX5Deq
         jYWggWvyW4so0VLWdb1nseBPisa5T2sEUpYds6DwaHArVx4/mSQNUe78O2xxVr7MtADL
         Vu9DzsmEfe+VuyAEdHV/6QEUyCdSMGroq2G1wIl7f1FUmpG/zogcfjjwPyzZUvTwLAyI
         osKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745722; x=1719350522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/2Fh6rd0k8ETjtf4cnW/BnAj+Q6YlIEcR0PBAFrGwF8=;
        b=P2HIDr/F5zyg+1WviW6TWi1uiOfUC6gntSDSji7sqqeqwsfDdgXFRuL6yXNBo+5mtm
         aBhjvBlTKxvyf0EtwmhdZ+xNXeF7RjA62vGkQsBF1uk0FlrZNDbvX4paWaDqeo3ywdtq
         PMTGoeDEo4EuE5POu66gqbq7PL6jgviLdyAn/xuUTmZdY7ShqPAp5FLtBhOo/fQfPhJ/
         mBJS42CJVwu0VYuvbncOL2/1Te3d3O5+G+kXTvz+E2z15tOpJxX+2hYbGIZYega831+1
         Swrb97trp1hDA49VPuGJvz9kx576kn5Qjl7EreA0zksW0WHkJFJf2PIYq5sOZtiQeuYr
         3NrA==
X-Forwarded-Encrypted: i=1; AJvYcCWojUSMcG9OxM6uf/yKFYse8xP5iioFFTOwrdxYa7fEb3T+v7E2xJEOlq94S0pDA3fAuAVlMn/wA8vx6yrlDDRIe7Cc
X-Gm-Message-State: AOJu0YzL4LztjZx06sTZwiuzlbuJlgmicd/+3Gi/9cfNKmLF6HFwiPq+
	sl5uPjebvEDG/4RX2lj9M9jE1Zua4CKQUe91NBhk9ku3i+QZzDOo
X-Google-Smtp-Source: AGHT+IGmbfIl7NyoUo95cfo8QNuBQkl2912kPXCWCLXH8tdHo7E0mYEfwU/13KN2H1fLR1Kj58zNGA==
X-Received: by 2002:a17:90a:f3c5:b0:2c3:195b:dc2e with SMTP id 98e67ed59e1d1-2c7b57fefacmr956959a91.9.1718745721893;
        Tue, 18 Jun 2024 14:22:01 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c45f68e4sm11371174a91.28.2024.06.18.14.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:22:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	joshdon@google.com,
	brho@google.com,
	pjt@google.com,
	derkling@google.com,
	haoluo@google.com,
	dvernet@meta.com,
	dschatzberg@meta.com,
	dskarlat@cs.cmu.edu,
	riel@surriel.com,
	changwoo@igalia.com,
	himadrics@inria.fr,
	memxor@gmail.com,
	andrea.righi@canonical.com,
	joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 29/30] sched_ext: Documentation: scheduler: Document extensible scheduler class
Date: Tue, 18 Jun 2024 11:17:44 -1000
Message-ID: <20240618212056.2833381-30-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618212056.2833381-1-tj@kernel.org>
References: <20240618212056.2833381-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Documentation/scheduler/sched-ext.rst which gives a high-level overview
and pointers to the examples.

v6: - Add paragraph explaining debug dump.

v5: - Updated to reflect /sys/kernel interface change. Kconfig options
      added.

v4: - README improved, reformatted in markdown and renamed to README.md.

v3: - Added tools/sched_ext/README.

    - Dropped _example prefix from scheduler names.

v2: - Apply minor edits suggested by Bagas. Caveats section dropped as all
      of them are addressed.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/scheduler/index.rst     |   1 +
 Documentation/scheduler/sched-ext.rst | 314 ++++++++++++++++++++++++++
 include/linux/sched/ext.h             |   2 +
 kernel/Kconfig.preempt                |   1 +
 kernel/sched/ext.c                    |   2 +
 kernel/sched/ext.h                    |   2 +
 tools/sched_ext/README.md             | 258 +++++++++++++++++++++
 7 files changed, 580 insertions(+)
 create mode 100644 Documentation/scheduler/sched-ext.rst
 create mode 100644 tools/sched_ext/README.md

diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
index 43bd8a145b7a..0611dc3dda8e 100644
--- a/Documentation/scheduler/index.rst
+++ b/Documentation/scheduler/index.rst
@@ -20,6 +20,7 @@ Scheduler
     sched-nice-design
     sched-rt-group
     sched-stats
+    sched-ext
     sched-debug
 
     text_files
diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
new file mode 100644
index 000000000000..497eeaa5ecbe
--- /dev/null
+++ b/Documentation/scheduler/sched-ext.rst
@@ -0,0 +1,314 @@
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
+* When the BPF scheduler triggers an error, debug information is dumped to
+  aid debugging. The debug dump is passed to and printed out by the
+  scheduler binary. The debug dump can also be accessed through the
+  `sched_ext_dump` tracepoint. The SysRq key sequence :kbd:`SysRq-D`
+  triggers a debug dump. This doesn't terminate the BPF scheduler and can
+  only be read through the tracepoint.
+
+Switching to and from sched_ext
+===============================
+
+``CONFIG_SCHED_CLASS_EXT`` is the config option to enable sched_ext and
+``tools/sched_ext`` contains the example schedulers. The following config
+options should be enabled to use sched_ext:
+
+.. code-block:: none
+
+    CONFIG_BPF=y
+    CONFIG_SCHED_CLASS_EXT=y
+    CONFIG_BPF_SYSCALL=y
+    CONFIG_BPF_JIT=y
+    CONFIG_DEBUG_INFO_BTF=y
+    CONFIG_BPF_JIT_ALWAYS_ON=y
+    CONFIG_BPF_JIT_DEFAULT_ON=y
+    CONFIG_PAHOLE_HAS_SPLIT_BTF=y
+    CONFIG_PAHOLE_HAS_BTF_TAG=y
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
+    # tools/sched_ext/scx_simple
+    local=0 global=3
+    local=5 global=24
+    local=9 global=44
+    local=13 global=56
+    local=17 global=72
+    ^CEXIT: BPF scheduler unregistered
+
+The current status of the BPF scheduler can be determined as follows:
+
+.. code-block:: none
+
+    # cat /sys/kernel/sched_ext/state
+    enabled
+    # cat /sys/kernel/sched_ext/root/ops
+    simple
+
+``tools/sched_ext/scx_show_state.py`` is a drgn script which shows more
+detailed information:
+
+.. code-block:: none
+
+    # tools/sched_ext/scx_show_state.py
+    ops           : simple
+    enabled       : 1
+    switching_all : 1
+    switched_all  : 1
+    enable_state  : enabled (2)
+    bypass_depth  : 0
+    nr_rejected   : 0
+
+If ``CONFIG_SCHED_DEBUG`` is set, whether a given task is on sched_ext can
+be determined as follows:
+
+.. code-block:: none
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
+``tools/sched/scx_simple.bpf.c`` showing a minimal global FIFO scheduler.
+
+.. code-block:: c
+
+    /*
+     * Decide which CPU a task should be migrated to before being
+     * enqueued (either at wakeup, fork time, or exec time). If an
+     * idle core is found by the default ops.select_cpu() implementation,
+     * then dispatch the task directly to SCX_DSQ_LOCAL and skip the
+     * ops.enqueue() callback.
+     *
+     * Note that this implementation has exactly the same behavior as the
+     * default ops.select_cpu implementation. The behavior of the scheduler
+     * would be exactly same if the implementation just didn't define the
+     * simple_select_cpu() struct_ops prog.
+     */
+    s32 BPF_STRUCT_OPS(simple_select_cpu, struct task_struct *p,
+                       s32 prev_cpu, u64 wake_flags)
+    {
+            s32 cpu;
+            /* Need to initialize or the BPF verifier will reject the program */
+            bool direct = false;
+
+            cpu = scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags, &direct);
+
+            if (direct)
+                    scx_bpf_dispatch(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+
+            return cpu;
+    }
+
+    /*
+     * Do a direct dispatch of a task to the global DSQ. This ops.enqueue()
+     * callback will only be invoked if we failed to find a core to dispatch
+     * to in ops.select_cpu() above.
+     *
+     * Note that this implementation has exactly the same behavior as the
+     * default ops.enqueue implementation, which just dispatches the task
+     * to SCX_DSQ_GLOBAL. The behavior of the scheduler would be exactly same
+     * if the implementation just didn't define the simple_enqueue struct_ops
+     * prog.
+     */
+    void BPF_STRUCT_OPS(simple_enqueue, struct task_struct *p, u64 enq_flags)
+    {
+            scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+    }
+
+    s32 BPF_STRUCT_OPS(simple_init)
+    {
+            /*
+             * All SCHED_OTHER, SCHED_IDLE, and SCHED_BATCH tasks should
+             * use sched_ext.
+             */
+            scx_bpf_switch_all();
+            return 0;
+    }
+
+    void BPF_STRUCT_OPS(simple_exit, struct scx_exit_info *ei)
+    {
+            exit_type = ei->type;
+    }
+
+    SEC(".struct_ops")
+    struct sched_ext_ops simple_ops = {
+            .select_cpu             = (void *)simple_select_cpu,
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
+   A task can be immediately dispatched to a DSQ from ``ops.select_cpu()`` by
+   calling ``scx_bpf_dispatch()``. If the task is dispatched to
+   ``SCX_DSQ_LOCAL`` from ``ops.select_cpu()``, it will be dispatched to the
+   local DSQ of whichever CPU is returned from ``ops.select_cpu()``.
+   Additionally, dispatching directly from ``ops.select_cpu()`` will cause the
+   ``ops.enqueue()`` callback to be skipped.
+
+   Note that the scheduler core will ignore an invalid CPU selection, for
+   example, if it's outside the allowed cpumask of the task.
+
+2. Once the target CPU is selected, ``ops.enqueue()`` is invoked (unless the
+   task was dispatched directly from ``ops.select_cpu()``). ``ops.enqueue()``
+   can make one of the following decisions:
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
+``scx_bpf_dispatch_vtime()`` for the priority queue. Internal DSQs such as
+``SCX_DSQ_LOCAL`` and ``SCX_DSQ_GLOBAL`` do not support priority-queue
+dispatching, and must be dispatched to with ``scx_bpf_dispatch()``.  See the
+function documentation and usage in ``tools/sched_ext/scx_simple.bpf.c`` for
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
+  * ``scx_simple[.bpf].c``: Minimal global FIFO scheduler example using a
+    custom DSQ.
+
+  * ``scx_qmap[.bpf].c``: A multi-level FIFO scheduler supporting five
+    levels of priority implemented with ``BPF_MAP_TYPE_QUEUE``.
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
index 9cee193dab19..fe9a67ffe6b1 100644
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
index 7dde5e424ac3..f035c87d02f1 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -156,4 +156,5 @@ config SCHED_CLASS_EXT
 	  similar to struct sched_class.
 
 	  For more information:
+	    Documentation/scheduler/sched-ext.rst
 	    https://github.com/sched-ext/scx
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f186c576e7d9..f814e84ceeb3 100644
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
index 6555878c5da3..c41d742b5d62 100644
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
diff --git a/tools/sched_ext/README.md b/tools/sched_ext/README.md
new file mode 100644
index 000000000000..8efe70cc4363
--- /dev/null
+++ b/tools/sched_ext/README.md
@@ -0,0 +1,258 @@
+SCHED_EXT EXAMPLE SCHEDULERS
+============================
+
+# Introduction
+
+This directory contains a number of example sched_ext schedulers. These
+schedulers are meant to provide examples of different types of schedulers
+that can be built using sched_ext, and illustrate how various features of
+sched_ext can be used.
+
+Some of the examples are performant, production-ready schedulers. That is, for
+the correct workload and with the correct tuning, they may be deployed in a
+production environment with acceptable or possibly even improved performance.
+Others are just examples that in practice, would not provide acceptable
+performance (though they could be improved to get there).
+
+This README will describe these example schedulers, including describing the
+types of workloads or scenarios they're designed to accommodate, and whether or
+not they're production ready. For more details on any of these schedulers,
+please see the header comment in their .bpf.c file.
+
+
+# Compiling the examples
+
+There are a few toolchain dependencies for compiling the example schedulers.
+
+## Toolchain dependencies
+
+1. clang >= 16.0.0
+
+The schedulers are BPF programs, and therefore must be compiled with clang. gcc
+is actively working on adding a BPF backend compiler as well, but are still
+missing some features such as BTF type tags which are necessary for using
+kptrs.
+
+2. pahole >= 1.25
+
+You may need pahole in order to generate BTF from DWARF.
+
+3. rust >= 1.70.0
+
+Rust schedulers uses features present in the rust toolchain >= 1.70.0. You
+should be able to use the stable build from rustup, but if that doesn't
+work, try using the rustup nightly build.
+
+There are other requirements as well, such as make, but these are the main /
+non-trivial ones.
+
+## Compiling the kernel
+
+In order to run a sched_ext scheduler, you'll have to run a kernel compiled
+with the patches in this repository, and with a minimum set of necessary
+Kconfig options:
+
+```
+CONFIG_BPF=y
+CONFIG_SCHED_CLASS_EXT=y
+CONFIG_BPF_SYSCALL=y
+CONFIG_BPF_JIT=y
+CONFIG_DEBUG_INFO_BTF=y
+```
+
+It's also recommended that you also include the following Kconfig options:
+
+```
+CONFIG_BPF_JIT_ALWAYS_ON=y
+CONFIG_BPF_JIT_DEFAULT_ON=y
+CONFIG_PAHOLE_HAS_SPLIT_BTF=y
+CONFIG_PAHOLE_HAS_BTF_TAG=y
+```
+
+There is a `Kconfig` file in this directory whose contents you can append to
+your local `.config` file, as long as there are no conflicts with any existing
+options in the file.
+
+## Getting a vmlinux.h file
+
+You may notice that most of the example schedulers include a "vmlinux.h" file.
+This is a large, auto-generated header file that contains all of the types
+defined in some vmlinux binary that was compiled with
+[BTF](https://docs.kernel.org/bpf/btf.html) (i.e. with the BTF-related Kconfig
+options specified above).
+
+The header file is created using `bpftool`, by passing it a vmlinux binary
+compiled with BTF as follows:
+
+```bash
+$ bpftool btf dump file /path/to/vmlinux format c > vmlinux.h
+```
+
+`bpftool` analyzes all of the BTF encodings in the binary, and produces a
+header file that can be included by BPF programs to access those types.  For
+example, using vmlinux.h allows a scheduler to access fields defined directly
+in vmlinux as follows:
+
+```c
+#include "vmlinux.h"
+// vmlinux.h is also implicitly included by scx_common.bpf.h.
+#include "scx_common.bpf.h"
+
+/*
+ * vmlinux.h provides definitions for struct task_struct and
+ * struct scx_enable_args.
+ */
+void BPF_STRUCT_OPS(example_enable, struct task_struct *p,
+		    struct scx_enable_args *args)
+{
+	bpf_printk("Task %s enabled in example scheduler", p->comm);
+}
+
+// vmlinux.h provides the definition for struct sched_ext_ops.
+SEC(".struct_ops.link")
+struct sched_ext_ops example_ops {
+	.enable	= (void *)example_enable,
+	.name	= "example",
+}
+```
+
+The scheduler build system will generate this vmlinux.h file as part of the
+scheduler build pipeline. It looks for a vmlinux file in the following
+dependency order:
+
+1. If the O= environment variable is defined, at `$O/vmlinux`
+2. If the KBUILD_OUTPUT= environment variable is defined, at
+   `$KBUILD_OUTPUT/vmlinux`
+3. At `../../vmlinux` (i.e. at the root of the kernel tree where you're
+   compiling the schedulers)
+3. `/sys/kernel/btf/vmlinux`
+4. `/boot/vmlinux-$(uname -r)`
+
+In other words, if you have compiled a kernel in your local repo, its vmlinux
+file will be used to generate vmlinux.h. Otherwise, it will be the vmlinux of
+the kernel you're currently running on. This means that if you're running on a
+kernel with sched_ext support, you may not need to compile a local kernel at
+all.
+
+### Aside on CO-RE
+
+One of the cooler features of BPF is that it supports
+[CO-RE](https://nakryiko.com/posts/bpf-core-reference-guide/) (Compile Once Run
+Everywhere). This feature allows you to reference fields inside of structs with
+types defined internal to the kernel, and not have to recompile if you load the
+BPF program on a different kernel with the field at a different offset. In our
+example above, we print out a task name with `p->comm`. CO-RE would perform
+relocations for that access when the program is loaded to ensure that it's
+referencing the correct offset for the currently running kernel.
+
+## Compiling the schedulers
+
+Once you have your toolchain setup, and a vmlinux that can be used to generate
+a full vmlinux.h file, you can compile the schedulers using `make`:
+
+```bash
+$ make -j($nproc)
+```
+
+# Example schedulers
+
+This directory contains the following example schedulers. These schedulers are
+for testing and demonstrating different aspects of sched_ext. While some may be
+useful in limited scenarios, they are not intended to be practical.
+
+For more scheduler implementations, tools and documentation, visit
+https://github.com/sched-ext/scx.
+
+## scx_simple
+
+A simple scheduler that provides an example of a minimal sched_ext scheduler.
+scx_simple can be run in either global weighted vtime mode, or FIFO mode.
+
+Though very simple, in limited scenarios, this scheduler can perform reasonably
+well on single-socket systems with a unified L3 cache.
+
+## scx_qmap
+
+Another simple, yet slightly more complex scheduler that provides an example of
+a basic weighted FIFO queuing policy. It also provides examples of some common
+useful BPF features, such as sleepable per-task storage allocation in the
+`ops.prep_enable()` callback, and using the `BPF_MAP_TYPE_QUEUE` map type to
+enqueue tasks. It also illustrates how core-sched support could be implemented.
+
+## scx_central
+
+A "central" scheduler where scheduling decisions are made from a single CPU.
+This scheduler illustrates how scheduling decisions can be dispatched from a
+single CPU, allowing other cores to run with infinite slices, without timer
+ticks, and without having to incur the overhead of making scheduling decisions.
+
+The approach demonstrated by this scheduler may be useful for any workload that
+benefits from minimizing scheduling overhead and timer ticks. An example of
+where this could be particularly useful is running VMs, where running with
+infinite slices and no timer ticks allows the VM to avoid unnecessary expensive
+vmexits.
+
+
+# Troubleshooting
+
+There are a number of common issues that you may run into when building the
+schedulers. We'll go over some of the common ones here.
+
+## Build Failures
+
+### Old version of clang
+
+```
+error: static assertion failed due to requirement 'SCX_DSQ_FLAG_BUILTIN': bpftool generated vmlinux.h is missing high bits for 64bit enums, upgrade clang and pahole
+        _Static_assert(SCX_DSQ_FLAG_BUILTIN,
+                       ^~~~~~~~~~~~~~~~~~~~
+1 error generated.
+```
+
+This means you built the kernel or the schedulers with an older version of
+clang than what's supported (i.e. older than 16.0.0). To remediate this:
+
+1. `which clang` to make sure you're using a sufficiently new version of clang.
+
+2. `make fullclean` in the root path of the repository, and rebuild the kernel
+   and schedulers.
+
+3. Rebuild the kernel, and then your example schedulers.
+
+The schedulers are also cleaned if you invoke `make mrproper` in the root
+directory of the tree.
+
+### Stale kernel build / incomplete vmlinux.h file
+
+As described above, you'll need a `vmlinux.h` file that was generated from a
+vmlinux built with BTF, and with sched_ext support enabled. If you don't,
+you'll see errors such as the following which indicate that a type being
+referenced in a scheduler is unknown:
+
+```
+/path/to/sched_ext/tools/sched_ext/user_exit_info.h:25:23: note: forward declaration of 'struct scx_exit_info'
+
+const struct scx_exit_info *ei)
+
+^
+```
+
+In order to resolve this, please follow the steps above in
+[Getting a vmlinux.h file](#getting-a-vmlinuxh-file) in order to ensure your
+schedulers are using a vmlinux.h file that includes the requisite types.
+
+## Misc
+
+### llvm: [OFF]
+
+You may see the following output when building the schedulers:
+
+```
+Auto-detecting system features:
+...                         clang-bpf-co-re: [ on  ]
+...                                    llvm: [ OFF ]
+...                                  libcap: [ on  ]
+...                                  libbfd: [ on  ]
+```
+
+Seeing `llvm: [ OFF ]` here is not an issue. You can safely ignore.
-- 
2.45.2


