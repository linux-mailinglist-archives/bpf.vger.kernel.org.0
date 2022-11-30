Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377B163D066
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 09:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbiK3IYY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 03:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbiK3IXz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 03:23:55 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273605C748;
        Wed, 30 Nov 2022 00:23:49 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 140so16160474pfz.6;
        Wed, 30 Nov 2022 00:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2/8JQ+FgnnSuHcjXh2J3RCUAB76b7QNPLT1f/A9xug=;
        b=BSi9n9GXOiYxxRJdC4TPmhxPiqB0MHRHFnvILrIVFCYNPVdtJrRTEsrU8HbTLbTtTE
         xiVeIMW9m9gb4SOO9kRP0RitBzzv0K+RNYaOHUShGlNlSvjXp38qVFKwEIPPm34dCt0y
         65FmagfmqDP+Da7yyQuLDjhMRltDlcxl3FzDLJEctobX0NijYoU8gFDXAZ3Pp8VE2kQ+
         n62V8Ac4nlzIjFW7Nk04UGSgWF52Ip/AN06Tj0+Z0rEYvUVErZxXyLirXNBP5nVCI0l/
         BfXzfJlV7DKtLbFY2WBlp1JIrngzB41hM5NELWpB7fPKmC7ydK5KhZm6cIC/j1HF2zH0
         agQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U2/8JQ+FgnnSuHcjXh2J3RCUAB76b7QNPLT1f/A9xug=;
        b=GgDyjKUmJj5IepmHj0Cv6E1mTDJ/vwNGFcIEy85tDXGAArSREhF80RnVC3edOTiQlB
         rArZbyaZEsSl6HPiTyS6D0bK2pdOI6ec+U0Z7BKs54Ty37TpN+bHJ6rIGjaQ/4T5I8ir
         /tJnjFki2uDSBhCQLqq5xH2SMfr43e+F/FQBlnZ4+/h8gXUY1am9QMvQ/K+/4zFlpenB
         p1VF+PyzfTNc8CekzBmdU1dWk1cU44/VTyHWB/aLEV90ZEiPQG/OdEVpS7GD7t8ANtRu
         YvAFO6ufVC+FxWjiWgdFaDIvBtD1sSd/GuFqDi47CirkRkEjhCLJ4jVx0Okct+Sr5irS
         H/dQ==
X-Gm-Message-State: ANoB5pnRb8pVmKBCiX6qN7Uw9GodHygTOPImA/i5byqQ7P2P4RYDvjQo
        1rPPfLzsORO9DMRuITXECAk=
X-Google-Smtp-Source: AA0mqf7rsSp9lcZ5WgoCYorTanlglI0Qu4SNRXJjk7DZQxDZxxscIehc8TZmXxMJ/k7hasLfjXXE5g==
X-Received: by 2002:a05:6a00:1d25:b0:562:5f71:d188 with SMTP id a37-20020a056a001d2500b005625f71d188mr42805390pfx.57.1669796628479;
        Wed, 30 Nov 2022 00:23:48 -0800 (PST)
Received: from localhost ([2600:380:4a00:1415:d028:b547:7d35:7b0b])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902e54500b001837b19ebb8sm739977plf.244.2022.11.30.00.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:23:48 -0800 (PST)
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
Subject: [PATCH 05/31] sched: Add sched_class->reweight_task()
Date:   Tue, 29 Nov 2022 22:22:47 -1000
Message-Id: <20221130082313.3241517-6-tj@kernel.org>
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

Currently, during a task weight change, sched core directly calls
reweight_task() defined in fair.c if @p is on CFS. Let's make it a proper
sched_class operation instead. CFS's reweight_task() is renamed to
reweight_task_fair() and now called through sched_class.

While it turns a direct call into an indirect one, set_load_weight() isn't
called from a hot path and this change shouldn't cause any noticeable
difference. This will be used to implement reweight_task for other scheduler
classes.

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
index 85eb82ad2ffd..70ec74dbb45a 100644
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
index e4a0b8bd941c..78263cef1ea8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3330,7 +3330,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
 }
 
-void reweight_task(struct task_struct *p, int prio)
+static void reweight_task_fair(struct rq *rq, struct task_struct *p, int prio)
 {
 	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
@@ -12176,6 +12176,7 @@ DEFINE_SCHED_CLASS(fair) = {
 	.task_tick		= task_tick_fair,
 	.task_fork		= task_fork_fair,
 
+	.reweight_task		= reweight_task_fair,
 	.prio_changed		= prio_changed_fair,
 	.switched_from		= switched_from_fair,
 	.switched_to		= switched_to_fair,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a4a20046e586..08799b2a566e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2193,6 +2193,8 @@ struct sched_class {
 	 */
 	void (*switched_from)(struct rq *this_rq, struct task_struct *task);
 	void (*switched_to)  (struct rq *this_rq, struct task_struct *task);
+	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
+			      int newprio);
 	void (*prio_changed) (struct rq *this_rq, struct task_struct *task,
 			      int oldprio);
 
@@ -2345,8 +2347,6 @@ extern void init_sched_dl_class(void);
 extern void init_sched_rt_class(void);
 extern void init_sched_fair_class(void);
 
-extern void reweight_task(struct task_struct *p, int prio);
-
 extern void resched_curr(struct rq *rq);
 extern void resched_cpu(int cpu);
 
-- 
2.38.1

