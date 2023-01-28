Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4BB67F302
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjA1AT1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjA1ASR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:18:17 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CAD8B7AF;
        Fri, 27 Jan 2023 16:17:39 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z1so1364338pfg.12;
        Fri, 27 Jan 2023 16:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EL6l4GyppJeuoMhOYlGrh8XYIK9k9J2icjfC6nfKvKE=;
        b=KgRwsDKwpRyUF6WZ0KfgZvKuQmPE4gaAxPRADwRHqeAenv4OwimnsvGqOepdYFmoiN
         Fw0pDTU4p9hpgJ70xaFsYTZmsdxQ4KfwYo15tthjll4gMIESRJcv/pZ0I9OpYHSfmrX9
         2w/yDuAVipvPXuZyxBZuERVuc9ANfapklzVoakNIG/WrwaQkTV1hInMH8hXOWw55CSzj
         5dQ5QJOe30yQkyrnmGsP2b1zX+y0zUg5nVOztpVVvzMmTZ9/b7RRLFQEX7c7z/kEMRZl
         XvxPOMiDaXowOLm0CmWdtYgmb5ehVGYRsKfIiHlNzEaa0fMUrTJFNK/50NSij4kFDv9z
         aGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EL6l4GyppJeuoMhOYlGrh8XYIK9k9J2icjfC6nfKvKE=;
        b=1zgnguE1jBT9YxdduNCGmZWeDlrGVZ+alo1seGUumfkIWB+BctqTA+ezUFviVTKNLa
         4jz6CCYahUkDcUFMsLUhKiBskdIhnxHwz7k4Jdig+fjrosaYvC44cpVN85HeunALLcRw
         ReUkq3/SVtSMPSv6YP617ZnFV4TiVJX+St9xdCzghl9iYtaGB0RUesz7n/cLNVEWJU1o
         I+m7sMWOd5ynHHU+H8nCHIRQ2HDpgp+Tg74EyIDr9/u7AVC8Ogr3v4+v0pNY0QWc3J1a
         bhrdO+v6A3Fn3bsGMJAnm1sy3xRbCTOhSM3qurTP/dwJJDMPhW0y1T0sVqm7mhoI+yDt
         mlrA==
X-Gm-Message-State: AO0yUKU8IV+Bng+gKaSTg80fKyKZ0RlI6T5ZsbWVfdJZPa7+U7018Xoc
        PJ8j6gWQx8gXpNztMIO+6z8=
X-Google-Smtp-Source: AK7set9ASOUgqlO0AjamBITpY29W5rUev3hU4n74R22c344yebowhTIX1jJWxBiLBBZ+VY5i/m3log==
X-Received: by 2002:a05:6a00:1243:b0:58b:b29c:50c2 with SMTP id u3-20020a056a00124300b0058bb29c50c2mr254140pfi.26.1674865050717;
        Fri, 27 Jan 2023 16:17:30 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id w188-20020a6262c5000000b0059394f7a583sm63954pfb.185.2023.01.27.16.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:17:30 -0800 (PST)
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
Subject: [PATCH 21/30] sched_ext: Add task state tracking operations
Date:   Fri, 27 Jan 2023 14:16:30 -1000
Message-Id: <20230128001639.3510083-22-tj@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128001639.3510083-1-tj@kernel.org>
References: <20230128001639.3510083-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
index 10cd3ede5ae5..338b41cd79fa 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -193,6 +193,71 @@ struct sched_ext_ops {
 	 */
 	void (*dispatch)(s32 cpu, struct task_struct *prev);
 
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
index 9bc625676bbc..4acaf39ea879 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -743,6 +743,9 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	rq->scx.nr_running++;
 	add_nr_running(rq, 1);
 
+	if (SCX_HAS_OP(runnable))
+		scx_ops.runnable(p, enq_flags);
+
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
 }
 
@@ -803,6 +806,26 @@ static void dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 
 	ops_dequeue(p, deq_flags);
 
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
 	if (deq_flags & SCX_DEQ_SLEEP)
 		p->scx.flags |= SCX_TASK_DEQD_FOR_SLEEP;
 	else
@@ -1328,6 +1351,10 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	p->se.exec_start = rq_clock_task(rq);
 
+	/* see dequeue_task_scx() on why we skip when !QUEUED */
+	if (SCX_HAS_OP(running) && (p->scx.flags & SCX_TASK_QUEUED))
+		scx_ops.running(p);
+
 	watchdog_unwatch_task(p, true);
 }
 
@@ -1366,6 +1393,10 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
 
 	update_curr_scx(rq);
 
+	/* see dequeue_task_scx() on why we skip when !QUEUED */
+	if (SCX_HAS_OP(stopping) && (p->scx.flags & SCX_TASK_QUEUED))
+		scx_ops.stopping(p, true);
+
 	/*
 	 * If we're being called from put_prev_task_balance(), balance_scx() may
 	 * have decided that @p should keep running.
-- 
2.39.1

