Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933DF67F2E5
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjA1ARO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjA1ARD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:17:03 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608227D994;
        Fri, 27 Jan 2023 16:17:02 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id g23so6538810plq.12;
        Fri, 27 Jan 2023 16:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFJCGyWZiDUG3qGifcKWzgbjT+7GhVFjmLYX9EINejM=;
        b=oL6aQNP9ZmNgM9+EnsT3Bygs83aNPidgbX/vKqfC9WVA7tE+BsP0EBMFXjvKtcxY7+
         CrZ8XbEZQ8Qh7XLQiMATkbcj1PEGWDH0TdNA26OiAaH1C2uhxQ1l5cBKSC0z8Bz8g5ae
         0PaGjUzn/YapB5X6+jacBo5QvOqxR0bxcMOwLuGbKM2Vs0I+4XGv4W8twq5Jidv08GqG
         gmbZPvRbVx/Wa6W7DS19D5TsHcDlhHBs4wlzcEcDbfD1zF+dLJQ1KLQDdnzlTFa+e4N/
         /iFeudWGZizIbF5PQCqGEQzxCA6Ttx2l95Ak0yPDu4AW33Hkptmp6IcTUlWinc3EcYP0
         bB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tFJCGyWZiDUG3qGifcKWzgbjT+7GhVFjmLYX9EINejM=;
        b=HDaO2lqsjfunTYFoV28sjr28UUDz4Jmar+derNmLC5ll8FQ14U/A0ZouzUHd5PPEWL
         r/wKeo82OV4Ic5pyy5Lt6eGA5826z7R5xqS9aRDZIW/WcYCfvkBH5Cu4aIWlhiwoVo9C
         bi9102iyWnfrEEWcRrtoPfuoRabRcWJHzA3dXBB0SpK1RCgdwTtOlfiZ5JijA3UJjcUc
         Vl2yK+m2KHdoLWkpg2O6ANAHjnNHGcl0wQTb2qEcYu9Y5I9NqU0TOnr+YgOcnp/Bbpyt
         kHMHMm70vK5WqVP5jknBhwE58aVX6KszIamaSus3L+Ea/u/as1Xj5MZAM4V3da4f/oIG
         bTwA==
X-Gm-Message-State: AO0yUKXd+GPLng1ixKu5q3x0YkoU6/K8wIWSkYYDFFzfu/fwLGJqqDZ4
        MpX+Sd9CPmg6Rk4MBNeHrRc=
X-Google-Smtp-Source: AK7set8M6exx7EB8VUhHYDOI0L/aBM+C9Mwb/QU489KTVCkyAT1LOYmGWw3whLCvaRTB65e3zwxDHg==
X-Received: by 2002:a17:90b:4d0e:b0:22c:4220:6ff2 with SMTP id mw14-20020a17090b4d0e00b0022c42206ff2mr5549209pjb.18.1674865021628;
        Fri, 27 Jan 2023 16:17:01 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x34-20020a17090a6c2500b0022bfcf5d297sm5695710pjj.9.2023.01.27.16.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:17:01 -0800 (PST)
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
Subject: [PATCH 05/30] sched: Add sched_class->reweight_task()
Date:   Fri, 27 Jan 2023 14:16:14 -1000
Message-Id: <20230128001639.3510083-6-tj@kernel.org>
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
index 49b3d8ce84ca..ce27ed857975 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1275,8 +1275,8 @@ static void set_load_weight(struct task_struct *p, bool update_load)
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
index c36aa54ae071..fbedf99ed953 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3342,7 +3342,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
 }
 
-void reweight_task(struct task_struct *p, int prio)
+static void reweight_task_fair(struct rq *rq, struct task_struct *p, int prio)
 {
 	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
@@ -12413,6 +12413,7 @@ DEFINE_SCHED_CLASS(fair) = {
 	.task_tick		= task_tick_fair,
 	.task_fork		= task_fork_fair,
 
+	.reweight_task		= reweight_task_fair,
 	.prio_changed		= prio_changed_fair,
 	.switched_from		= switched_from_fair,
 	.switched_to		= switched_to_fair,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 771f8ddb7053..070603f00470 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2208,6 +2208,8 @@ struct sched_class {
 	 */
 	void (*switched_from)(struct rq *this_rq, struct task_struct *task);
 	void (*switched_to)  (struct rq *this_rq, struct task_struct *task);
+	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
+			      int newprio);
 	void (*prio_changed) (struct rq *this_rq, struct task_struct *task,
 			      int oldprio);
 
@@ -2360,8 +2362,6 @@ extern void init_sched_dl_class(void);
 extern void init_sched_rt_class(void);
 extern void init_sched_fair_class(void);
 
-extern void reweight_task(struct task_struct *p, int prio);
-
 extern void resched_curr(struct rq *rq);
 extern void resched_cpu(int cpu);
 
-- 
2.39.1

