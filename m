Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8630463D088
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 09:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbiK3I0o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 03:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbiK3IZZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 03:25:25 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E722E5C776;
        Wed, 30 Nov 2022 00:24:24 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d3so10968524plr.10;
        Wed, 30 Nov 2022 00:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTx6H8f+ndFeS1WR24S49kfIzumfz2ZStsXAYvcIlho=;
        b=WeAHEayqB1rE8cJMhH0BNAf20UpSIBGx/i4g+C1yIjyzBp9rAcSEniWNobf/5Dav7C
         CESxiyh0gEtHlZTT3hG7TPOaPAEz8DFjxfhUzbdSF3yAX9CA9VkXKLYMS5nr9fPXj/3l
         5m81ZwF1hwCsHzmLC9BqebSdD+uwBb06HVnQsUseYgseGzz+sm2wgOSFgmMrajiOak8j
         8SDninprROYJep3hfEgrexvxoJ0NFjWSdiJVuX2HpKGLbPqTJoERJOHMxwnzL5Pd6mvk
         ddaGJ3PPHSU225HBlRahWCQi38moCjShla+JoAtZ0Wa7wqvDb2nqQ6K4Fdjy4fFQXPng
         HLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sTx6H8f+ndFeS1WR24S49kfIzumfz2ZStsXAYvcIlho=;
        b=CpRvGj406fh5PcEKvh4pm0HbOsf1sxrHTze04aSkLS2lycXwip9XoMJzeKUjqovFbG
         EyJJOF+nNcE1IvnyBSGdwCrCMTJzDQSPh2iHoqBJBiQcKXJYdY+XgKiN/9IiGQJi8wAV
         PDkyWSSTuwBfGxWyOJLAdy6DrimgkcWiCIQ/HET2U/oKKnelfXn87bhX1eE5nVC2ySrN
         Gs1CKgU586qWATaiXnfBhEYX8AMut9RU4ppy5ShjoOZ+BIvWIxSgdw0YakhxWgUHIzy+
         so0of0eKnT/cZ1t99pcBISDW/uZmDNIuSEYCcDS0deOXVWr/xofKqFtN8uAyX0oqUyH3
         NnmQ==
X-Gm-Message-State: ANoB5pkkKiYaqE+YOFveiAGx8DpQylRv4StnRbDWfTAeIhe2kJZEA04V
        Ub5fmBMm2sgHjGUxI1/lY8I=
X-Google-Smtp-Source: AA0mqf5TZN5pEmu46xuGXI8smPjweGBma2CdnQPyJR3K7eVBRBdquc+nxuWiBys1CYzH3/JZLn04Yg==
X-Received: by 2002:a17:902:e807:b0:188:f6b7:bbf8 with SMTP id u7-20020a170902e80700b00188f6b7bbf8mr41537349plg.112.1669796664242;
        Wed, 30 Nov 2022 00:24:24 -0800 (PST)
Received: from localhost ([2600:380:4a00:1415:d028:b547:7d35:7b0b])
        by smtp.gmail.com with ESMTPSA id i15-20020a17090332cf00b001892af9472esm741249plr.261.2022.11.30.00.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:24:23 -0800 (PST)
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
Subject: [PATCH 22/31] sched_ext: Add task state tracking operations
Date:   Tue, 29 Nov 2022 22:23:04 -1000
Message-Id: <20221130082313.3241517-23-tj@kernel.org>
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

Being able to track the task runnable and running state transitions are
useful for a variety of purposes including latency tracking and load factor
calculation.

Currently, BPF schedulers don't have a good way of tracking these
transitions. Becoming runnable can be determined from ops.enqueue() but
becoming quiescent can only be inferred from the lack of subsequent enqueue.
Also, as the local dsq can have multiple tasks and some events are handled
in the sched_ext core, it's difficult to determine when a given task starts
and stops executing.

This patch adds sched_ext_ops.runnable(), .running(), .stopping() and
.quiescent() operations to track the task runnable and running state
transitions. They're mostly self explanatory; however, we want to ensure
that running <-> stopping transitions are always contained within runnable
<-> quiescent transitions which is a bit different from how the scheduler
core behaves. This adds a bit of complication. See the comment in
dequeue_task_scx().

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/sched/ext.h | 65 +++++++++++++++++++++++++++++++++++++++
 kernel/sched/ext.c        | 31 +++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 6e25c3431bb4..4f8898556b28 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -209,6 +209,71 @@ struct sched_ext_ops {
 	 */
 	void (*consume_final)(s32 cpu);
 
+	/**
+	 * runnable - A task is becoming runnable on its associated CPU
+	 * @p: task becoming runnable
+	 * @enq_flags: %SCX_ENQ_*
+	 *
+	 * This and the following three functions can be used to track a task's
+	 * execution state transitions. A task becomes ->runnable() on a CPU,
+	 * and then goes through one or more ->running() and ->stopping() pairs
+	 * as it runs on the CPU, and eventually becomes ->quiescent() when it's
+	 * done running on the CPU.
+	 *
+	 * @p is becoming runnable on the CPU because it's
+	 *
+	 * - waking up (%SCX_ENQ_WAKEUP)
+	 * - being moved from another CPU
+	 * - being restored after temporarily taken off the queue for an
+	 *   attribute change.
+	 *
+	 * This and ->enqueue() are related but not coupled. This operation
+	 * notifies @p's state transition and may not be followed by ->enqueue()
+	 * e.g. when @p is being dispatched to a remote CPU. Likewise, a task
+	 * may be ->enqueue()'d without being preceded by this operation e.g.
+	 * after exhausting its slice.
+	 */
+	void (*runnable)(struct task_struct *p, u64 enq_flags);
+
+	/**
+	 * running - A task is starting to run on its associated CPU
+	 * @p: task starting to run
+	 *
+	 * See ->runnable() for explanation on the task state notifiers.
+	 */
+	void (*running)(struct task_struct *p);
+
+	/**
+	 * stopping - A task is stopping execution
+	 * @p: task stopping to run
+	 * @runnable: is task @p still runnable?
+	 *
+	 * See ->runnable() for explanation on the task state notifiers. If
+	 * !@runnable, ->quiescent() will be invoked after this operation
+	 * returns.
+	 */
+	void (*stopping)(struct task_struct *p, bool runnable);
+
+	/**
+	 * quiescent - A task is becoming not runnable on its associated CPU
+	 * @p: task becoming not runnable
+	 * @deq_flags: %SCX_DEQ_*
+	 *
+	 * See ->runnable() for explanation on the task state notifiers.
+	 *
+	 * @p is becoming quiescent on the CPU because it's
+	 *
+	 * - sleeping (%SCX_DEQ_SLEEP)
+	 * - being moved to another CPU
+	 * - being temporarily taken off the queue for an attribute change
+	 *   (%SCX_DEQ_SAVE)
+	 *
+	 * This and ->dequeue() are related but not coupled. This operation
+	 * notifies @p's state transition and may not be preceded by ->dequeue()
+	 * e.g. when @p is being dispatched to a remote CPU.
+	 */
+	void (*quiescent)(struct task_struct *p, u64 deq_flags);
+
 	/**
 	 * yield - Yield CPU
 	 * @from: yielding task
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 4a98047a06bc..2eb382ed0e2f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -670,6 +670,9 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	rq->scx.nr_running++;
 	add_nr_running(rq, 1);
 
+	if (SCX_HAS_OP(runnable))
+		scx_ops.runnable(p, enq_flags);
+
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
 }
 
@@ -716,6 +719,26 @@ static void dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 		break;
 	}
 
+	/*
+	 * A currently running task which is going off @rq first gets dequeued
+	 * and then stops running. As we want running <-> stopping transitions
+	 * to be contained within runnable <-> quiescent transitions, trigger
+	 * ->stopping() early here instead of in put_prev_task_scx().
+	 *
+	 * @p may go through multiple stopping <-> running transitions between
+	 * here and put_prev_task_scx() if task attribute changes occur while
+	 * balance_scx() leaves @rq unlocked. However, they don't contain any
+	 * information meaningful to the BPF scheduler and can be suppressed by
+	 * skipping the callbacks if the task is !QUEUED.
+	 */
+	if (SCX_HAS_OP(stopping) && task_current(rq, p)) {
+		update_curr_scx(rq);
+		scx_ops.stopping(p, false);
+	}
+
+	if (SCX_HAS_OP(quiescent))
+		scx_ops.quiescent(p, deq_flags);
+
 	p->scx.flags &= ~SCX_TASK_QUEUED;
 	scx_rq->nr_running--;
 	sub_nr_running(rq, 1);
@@ -1223,6 +1246,10 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	p->se.exec_start = rq_clock_task(rq);
 
+	/* see dequeue_task_scx() on why we skip when !QUEUED */
+	if (SCX_HAS_OP(running) && (p->scx.flags & SCX_TASK_QUEUED))
+		scx_ops.running(p);
+
 	watchdog_unwatch_task(p, true);
 }
 
@@ -1230,6 +1257,10 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
 {
 	update_curr_scx(rq);
 
+	/* see dequeue_task_scx() on why we skip when !QUEUED */
+	if (SCX_HAS_OP(stopping) && (p->scx.flags & SCX_TASK_QUEUED))
+		scx_ops.stopping(p, true);
+
 	/*
 	 * If we're being called from put_prev_task_balance(), balance_scx() may
 	 * have decided that @p should keep running.
-- 
2.38.1

