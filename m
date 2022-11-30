Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7639863D068
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 09:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbiK3IY0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 03:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbiK3IX4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 03:23:56 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521DE65E4B;
        Wed, 30 Nov 2022 00:23:51 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id io19so15943802plb.8;
        Wed, 30 Nov 2022 00:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pluDkz1LDp7E7JUyCCPK7UNMM5NVNT0Y38yg2BcWmFs=;
        b=mCDeRUH4Ouwb2Jm6I9rgWHU8YyNp0l8cxQUrHnc6pIUDmdnyIaRxVbglSNYJesOXjT
         a3jpT1uJwSVTiSg7uJ3o+DKPignfb01PwxD4ho+WhlbTFgyoihvVg5szIGRJEmGU8c5G
         OFOPA4cOMnLCxUDVe4QtmoBc+YjrMXCcBayKmWcITnCHCG3xI3r5S49PZY8iuXVXA/ZC
         W2SY2yB2E+tPupuH+k5vxHwfLxOMmE8sOakTzkLCMKGHnysYTtXO88GH5KBPQeSV2mj0
         o++mVg7UVuO6XV74dveJtzRvpPevpqmiqH1y1JUDnIFyXOs6sxRk5YsKyJvm62ZUGuBu
         iFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pluDkz1LDp7E7JUyCCPK7UNMM5NVNT0Y38yg2BcWmFs=;
        b=SjyV5CV77eMCv/jwCwNq9TOFnlBrMOJU0KchZjy37/xDEBIqwldNl5eef6E4814I3U
         BSAWG+lskYvhNKoP+zOt8UfZU7XQFhr3zqI0prHUp7fAaDYwtCXWh9PzMh+CW1tNj4mm
         MuPpA3WMyMXhz0P+p90Dy4a+BGbnUV4fsfokmbYHvCGrp4lGA3NcBq3rRo2ADBRboW+w
         6hg5P2szSg4uJgh8T5z+FD1Oov29KpJHyIrof4wxWd7tMHPcBXUUDePMOFq/UaxUGzXQ
         wnN3+lpS+whRay8I2oK5mcUTdh3SudR+P2+7tIWkE/OBulp/WetPJWMyP19WH6MwpN0K
         N1rQ==
X-Gm-Message-State: ANoB5pm5AUSlqAlIjkAJUCSGiji+C9mkKaRotUx9bMOs+OH//4EEx7j7
        cBb7Is3UAVVF4ZSfTadp44Y=
X-Google-Smtp-Source: AA0mqf5wRcUWJx9QjxiJGhLEm2Uj2g8fv4bUSgks58qS+LVh+MEtmoofSaMC/e1gZ0tSHDiC1kCwWg==
X-Received: by 2002:a17:902:d395:b0:189:58a9:14aa with SMTP id e21-20020a170902d39500b0018958a914aamr30172508pld.22.1669796630448;
        Wed, 30 Nov 2022 00:23:50 -0800 (PST)
Received: from localhost ([2600:380:4a00:1415:d028:b547:7d35:7b0b])
        by smtp.gmail.com with ESMTPSA id s3-20020a625e03000000b0056bf29c9ba3sm819636pfb.146.2022.11.30.00.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:23:50 -0800 (PST)
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
Subject: [PATCH 06/31] sched: Add sched_class->switching_to() and expose check_class_changing/changed()
Date:   Tue, 29 Nov 2022 22:22:48 -1000
Message-Id: <20221130082313.3241517-7-tj@kernel.org>
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

When a task switches to a new sched_class, the prev and new classes are
notified through ->switched_from() and ->switched_to(), respectively, after
the switching is done. However, a new sched_class needs to prepare the task
state before it is enqueued on the new class for the first time.

This patch adds ->switching_to() which is called during sched_class switch
through check_class_changing() before the task is restored and exposes
check_class_changing/changed() in kernel/sched/sched.h.

This is a prep patch and doesn't cause any behavior changes. The new
operation and exposed functions aren't used yet.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/core.c  | 20 +++++++++++++++++---
 kernel/sched/sched.h |  7 +++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 70ec74dbb45a..d2247e8144e3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2151,6 +2151,17 @@ inline int task_curr(const struct task_struct *p)
 	return cpu_curr(task_cpu(p)) == p;
 }
 
+/*
+ * ->switching_to() is called with the pi_lock and rq_lock held and must not
+ * mess with locking.
+ */
+void check_class_changing(struct rq *rq, struct task_struct *p,
+			  const struct sched_class *prev_class)
+{
+	if (prev_class != p->sched_class && p->sched_class->switching_to)
+		p->sched_class->switching_to(rq, p);
+}
+
 /*
  * switched_from, switched_to and prio_changed must _NOT_ drop rq->lock,
  * use the balance_callback list if you want balancing.
@@ -2158,9 +2169,9 @@ inline int task_curr(const struct task_struct *p)
  * this means any call to check_class_changed() must be followed by a call to
  * balance_callback().
  */
-static inline void check_class_changed(struct rq *rq, struct task_struct *p,
-				       const struct sched_class *prev_class,
-				       int oldprio)
+void check_class_changed(struct rq *rq, struct task_struct *p,
+			 const struct sched_class *prev_class,
+			 int oldprio)
 {
 	if (prev_class != p->sched_class) {
 		if (prev_class->switched_from)
@@ -6974,6 +6985,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	}
 
 	__setscheduler_prio(p, prio);
+	check_class_changing(rq, p, prev_class);
 
 	if (queued)
 		enqueue_task(rq, p, queue_flag);
@@ -7603,6 +7615,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	}
 	__setscheduler_uclamp(p, attr);
 
+	check_class_changing(rq, p, prev_class);
+
 	if (queued) {
 		/*
 		 * We enqueue to tail when the priority of a task is
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 08799b2a566e..3f98773d66dd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2191,6 +2191,7 @@ struct sched_class {
 	 * cannot assume the switched_from/switched_to pair is serialized by
 	 * rq->lock. They are however serialized by p->pi_lock.
 	 */
+	void (*switching_to) (struct rq *this_rq, struct task_struct *task);
 	void (*switched_from)(struct rq *this_rq, struct task_struct *task);
 	void (*switched_to)  (struct rq *this_rq, struct task_struct *task);
 	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
@@ -2427,6 +2428,12 @@ static inline void sub_nr_running(struct rq *rq, unsigned count)
 extern void activate_task(struct rq *rq, struct task_struct *p, int flags);
 extern void deactivate_task(struct rq *rq, struct task_struct *p, int flags);
 
+extern void check_class_changing(struct rq *rq, struct task_struct *p,
+				 const struct sched_class *prev_class);
+extern void check_class_changed(struct rq *rq, struct task_struct *p,
+				const struct sched_class *prev_class,
+				int oldprio);
+
 extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
 
 #ifdef CONFIG_PREEMPT_RT
-- 
2.38.1

