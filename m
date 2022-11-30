Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8747063D075
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 09:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbiK3IZJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 03:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbiK3IY0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 03:24:26 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B577697F3;
        Wed, 30 Nov 2022 00:24:01 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 6so15376487pgm.6;
        Wed, 30 Nov 2022 00:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7y4gENgPynEKBUdFJwGmBAsFu1euUGtdtu24JG61qwA=;
        b=CJvW8ygBlZVDZ74fJVPYgS2dv/GKHVTIJmr5+sz1/txVMlnhk8dVxjsGp3Wxhkee+P
         72OXixyd+hEQSEnN2v4DfzI6r6VaxPTpGRPiVAkgg8tz5g5EeD3CFhh5ncJVRWQWOker
         ZsrqidAXjSwZvnhsVs2P5a7/QYBNEYsfTWABSprkg8Xl2i2kAXlUEaoVh3FWYlFkUMSq
         2H+p11u0QwvfSukVrlFAhqwLGJhLdHz1s9NohzuM9MpambkBDf3rvHnhDrRAnvt3evl6
         WZpfmBeT/pLW5J8klGCZwCxA1QZOa/BtKgN7rCZGq9nFTo+oSw4mFUCwJDmTuFObEbk3
         3RaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7y4gENgPynEKBUdFJwGmBAsFu1euUGtdtu24JG61qwA=;
        b=W2jkhv3jBJ6zbe1ItpR2Xv5Coy4LreYhq21gB3fe5KSpwzENagsVykE3I0KoJr0Nwm
         OvNVimq6EhDCDBf3cGlagHjSbi4GuZB9oWEd9Rzms4lqjm+gnoI9f0vkc8/kHaZ2KJpz
         6lvMpAy5YJIOvCXGJDKahtYdUniVhmTDxlhdn8rml+pxzUBu7a6Q8KObn/L3xhxQQMZ7
         689g+U7L2+LSt4cSISH6ZpANgnCGXOtMNh1SCPgQVy67YZ+nAONUv/v7RuepPnazwcDy
         UWi+kejEj+rX3VnJ0mAETxeKJRfO7agqFYf/CTBd28TyONz2NYF3xmOnsurN8Oy9hcu6
         egOQ==
X-Gm-Message-State: ANoB5plC7Z9i0o3TfcT+b2Xu1inKNWgciIPJNg9NlEjaQbJEHlNdUzrg
        CkbgyyJOsyGEbQFqeLvYBN4=
X-Google-Smtp-Source: AA0mqf4bvkU+fnRZ8mV+saHzyKt7pe/mzs18ZpR5lZIbv6rSS0Vb8lLdcliU5/9E7HAY9a+REmm/RA==
X-Received: by 2002:a05:6a00:c5:b0:56b:a4f6:e030 with SMTP id e5-20020a056a0000c500b0056ba4f6e030mr43147233pfj.85.1669796640619;
        Wed, 30 Nov 2022 00:24:00 -0800 (PST)
Received: from localhost ([2600:380:4a00:1415:d028:b547:7d35:7b0b])
        by smtp.gmail.com with ESMTPSA id o11-20020a1709026b0b00b00186616b8fbasm774285plk.10.2022.11.30.00.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:24:00 -0800 (PST)
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
Subject: [PATCH 11/31] sched: Add @reason to sched_move_task()
Date:   Tue, 29 Nov 2022 22:22:53 -1000
Message-Id: <20221130082313.3241517-12-tj@kernel.org>
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

sched_move_task() can be called for both cgroup and autogroup moves. Add a
parameter to distinguish the two cases. This will be used by a new
sched_class to track cgroup migrations.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/autogroup.c | 4 ++--
 kernel/sched/core.c      | 4 ++--
 kernel/sched/sched.h     | 7 ++++++-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index 991fc9002535..2be1b10ce93e 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -151,7 +151,7 @@ void sched_autogroup_exit_task(struct task_struct *p)
 	 * see this thread after that: we can no longer use signal->autogroup.
 	 * See the PF_EXITING check in task_wants_autogroup().
 	 */
-	sched_move_task(p);
+	sched_move_task(p, SCHED_MOVE_TASK_AUTOGROUP);
 }
 
 static void
@@ -183,7 +183,7 @@ autogroup_move_group(struct task_struct *p, struct autogroup *ag)
 	 * sched_autogroup_exit_task().
 	 */
 	for_each_thread(p, t)
-		sched_move_task(t);
+		sched_move_task(t, SCHED_MOVE_TASK_AUTOGROUP);
 
 	unlock_task_sighand(p, &flags);
 	autogroup_kref_put(prev);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0699b49b1a21..9c5bfeeb30ba 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10210,7 +10210,7 @@ static void sched_change_group(struct task_struct *tsk)
  * now. This function just updates tsk->se.cfs_rq and tsk->se.parent to reflect
  * its new group.
  */
-void sched_move_task(struct task_struct *tsk)
+void sched_move_task(struct task_struct *tsk, enum sched_move_task_reason reason)
 {
 	int queued, running, queue_flags =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
@@ -10321,7 +10321,7 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 	struct cgroup_subsys_state *css;
 
 	cgroup_taskset_for_each(task, css, tset)
-		sched_move_task(task);
+		sched_move_task(task, SCHED_MOVE_TASK_CGROUP);
 }
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3c6ea8296ae4..ef8da88e677c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -506,7 +506,12 @@ extern void sched_online_group(struct task_group *tg,
 extern void sched_destroy_group(struct task_group *tg);
 extern void sched_release_group(struct task_group *tg);
 
-extern void sched_move_task(struct task_struct *tsk);
+enum sched_move_task_reason {
+	SCHED_MOVE_TASK_CGROUP,
+	SCHED_MOVE_TASK_AUTOGROUP,
+};
+extern void sched_move_task(struct task_struct *tsk,
+			    enum sched_move_task_reason reason);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 extern int sched_group_set_shares(struct task_group *tg, unsigned long shares);
-- 
2.38.1

