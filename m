Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC0D6BF4A0
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 22:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCQVvu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 17:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjCQVvu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 17:51:50 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C9BC3CE7;
        Fri, 17 Mar 2023 14:51:13 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so2177297pjl.4;
        Fri, 17 Mar 2023 14:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679089869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHm+NYWQnKdGMy+c994+YcNwf72k/1epACWefCI4KNA=;
        b=ELiyrGpS0ug/qpUKT1OkjjcYKOXAav6kIo+QL8/nNxFIv5tYFHHuI2q8pSJDs3q+6U
         pC3SxMSEiv3mnkH/lG72+a1n/qzaN4xu5GlPp1vu4nxcaLqe63tVHBQ5uDuwJZ9cruLg
         4fXT+0N+PfoHwbMPz9YgZ/yDyeoKG2aJpI/Fye63W7fvI9qivZ1rRznY4A3J0+fOCzkV
         zY63p8VrOlCys5SAytAwNjah3RmZtjlsQxYJPR3mTieNjq+kzYimhqtliQdKwC6weAmF
         dHdQarnMOog4NSfA2LW1ZDy1EyhdWXtXHvaxP+aRq01tFPwQF0RdKfO3MxmxoN1Bdh98
         UmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679089869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DHm+NYWQnKdGMy+c994+YcNwf72k/1epACWefCI4KNA=;
        b=xFlD/vjI4qV2W9jkKmz6fEwn74b4+p9etUpIRdZZCS/tEHgfXBQbVg2/QO1P6CKaSf
         v8wZgxh/TKOqcvJIl9Cb0D/qpuo5cPUVjurgnnHUD51p1ovXWcmMv7bIZB4JcGjtdgOM
         bAss6QqZZKY/1HcRS+nCW3tqDw+UzpTZUn4Rr9q14ButicJRebtY/m6X4xxTGrCIwxRU
         oQbmBY/XtY14kKBbL6ZzpzRBunl5KEgTzRxiRabMRrLA66DF6q4pGnyc63ESO31z6xeN
         NazlA3NCX59bdUWaO8ZUosM0qXfuCtk+b8LQvo0HrG2E955h/50aC4muzhUaPOBh/o6P
         FKIA==
X-Gm-Message-State: AO0yUKV3txg9jri5efA8ngRR/3Q0ACouYVa3M1nNWuCi1flTerudgIRg
        pXawD+bmWSsGpPSwt6A1hGXI956m5i0=
X-Google-Smtp-Source: AK7set+6PvSSZVTvmWDp0ylnj31HhLaOifZPuAg/KzsQMZJAZ8vWXsoqdztGVwt3IbC+dhk7tYs9Qg==
X-Received: by 2002:a17:90a:1910:b0:23f:2757:ce99 with SMTP id 16-20020a17090a191000b0023f2757ce99mr8038056pjg.49.1679088832114;
        Fri, 17 Mar 2023 14:33:52 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id ch7-20020a17090af40700b0023cd53e7706sm5411264pjb.47.2023.03.17.14.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:33:51 -0700 (PDT)
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
Subject: [PATCH 05/32] sched: Add sched_class->reweight_task()
Date:   Fri, 17 Mar 2023 11:33:06 -1000
Message-Id: <20230317213333.2174969-6-tj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317213333.2174969-1-tj@kernel.org>
References: <20230317213333.2174969-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, during a task weight change, sched core directly calls
reweight_task() defined in fair.c if @p is on CFS. Let's make it a proper
sched_class operation instead. CFS's reweight_task() is renamed to
reweight_task_fair() and now called through sched_class.

While it turns a direct call into an indirect one, set_load_weight() isn't
called from a hot path and this change shouldn't cause any noticeable
difference. This will be used to implement reweight_task for a new BPF
extensible sched_class so that it can keep its cached task weight
up-to-date.

This will be used by a new sched_class to track weight changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/core.c  | 4 ++--
 kernel/sched/fair.c  | 3 ++-
 kernel/sched/sched.h | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fdf4dba12a7e..5a6f4884384e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1277,8 +1277,8 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 	 * SCHED_OTHER tasks have to update their load when changing their
 	 * weight
 	 */
-	if (update_load && p->sched_class == &fair_sched_class) {
-		reweight_task(p, prio);
+	if (update_load && p->sched_class->reweight_task) {
+		p->sched_class->reweight_task(task_rq(p), p, prio);
 	} else {
 		load->weight = scale_load(sched_prio_to_weight[prio]);
 		load->inv_weight = sched_prio_to_wmult[prio];
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7a1b1f855b96..681ab0dd0bc1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3342,7 +3342,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
 }
 
-void reweight_task(struct task_struct *p, int prio)
+static void reweight_task_fair(struct rq *rq, struct task_struct *p, int prio)
 {
 	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
@@ -12547,6 +12547,7 @@ DEFINE_SCHED_CLASS(fair) = {
 	.task_tick		= task_tick_fair,
 	.task_fork		= task_fork_fair,
 
+	.reweight_task		= reweight_task_fair,
 	.prio_changed		= prio_changed_fair,
 	.switched_from		= switched_from_fair,
 	.switched_to		= switched_to_fair,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3e8df6d31c1e..7934b597053d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2213,6 +2213,8 @@ struct sched_class {
 	 */
 	void (*switched_from)(struct rq *this_rq, struct task_struct *task);
 	void (*switched_to)  (struct rq *this_rq, struct task_struct *task);
+	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
+			      int newprio);
 	void (*prio_changed) (struct rq *this_rq, struct task_struct *task,
 			      int oldprio);
 
@@ -2365,8 +2367,6 @@ extern void init_sched_dl_class(void);
 extern void init_sched_rt_class(void);
 extern void init_sched_fair_class(void);
 
-extern void reweight_task(struct task_struct *p, int prio);
-
 extern void resched_curr(struct rq *rq);
 extern void resched_cpu(int cpu);
 
-- 
2.39.2

