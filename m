Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05BA63D065
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 09:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbiK3IYX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 03:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbiK3IXy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 03:23:54 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B687654C7;
        Wed, 30 Nov 2022 00:23:47 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id z17so11344071pff.1;
        Wed, 30 Nov 2022 00:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JjbQFqfdsaVhZqtFfQSRXxMBSehwkQCfe7x4A4m6D0=;
        b=EqvLmZuOXH1Zu4wV8SRbBjPk6VDpBCHsg+vQDcTngJACJKrZ/EG8ThdJydry1OyED5
         aqP1XIZbP3/xA1c0VRJ0+xB4iMIw9gMn3hd/uvGfPoJ4ajT2r3UdPTExbybW/OFOOq3I
         pnpUfWXJlUkihue1VSjbbqZGJiXLEbsFmDSnn2o6/MWcCL8LJliZeN1f6F6vn+W6+oCe
         MM3aMX+nDAOyB3Ct8ua63fXfF3b0oZNXvDtF499k7ElWAq4GSirE8n3nCtJeTwTQrr/p
         gBn+xpd1VyGomr4YSlAIPOisotD/Tsw98Oja+KxKyDDLwu5axVENTJIgtRzwIDJsQsbO
         rZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1JjbQFqfdsaVhZqtFfQSRXxMBSehwkQCfe7x4A4m6D0=;
        b=1CNF2kz7TjNEIN4nSpWk8UWVwjJ2aWwPHJqIl14jBzbKVq9cA5FfdNLbq3SnZ5lAsS
         EWfkrBWUWw18wKIO85Lhdwu9y/zjHRPxkVWyTG6CeT+NQPCIzvPhox1j14+xG9LhcIGI
         QFZqL48X9IhqGw2dfCHahoeowaVQQHr6BiMTLtLvbiHbHsqBkCxBD3FMx4DAB9hysBV5
         PS9X+hdwiX2di7XPQZcmqcfSUggr/ivygkKHLRUuj9VPqWLKd9nQUxc9Gs+zaOcZd/t4
         jrCkpjexFSDmYp2z+uZ2wf3rEDDhtu0zTzzAVbSAIp9oaHEu4pAyNiXz48xZwe2j2/B7
         IAaQ==
X-Gm-Message-State: ANoB5pkvSwwk6SZEgCroHblD/ApwV+6lSnjDXl9nrSVLt2rg50cy5Kco
        Db0mF9HeZijAj61FTgIC/b4=
X-Google-Smtp-Source: AA0mqf5iBqlSrn0+Stho4qdCinOFxoRLiURspBXjmTMrjNfE21w7GMJIi3yXNJzzGuhk1n740H7VWA==
X-Received: by 2002:a05:6a02:187:b0:46b:26a6:51bc with SMTP id bj7-20020a056a02018700b0046b26a651bcmr53295988pgb.204.1669796626483;
        Wed, 30 Nov 2022 00:23:46 -0800 (PST)
Received: from localhost ([2600:380:4a00:1415:d028:b547:7d35:7b0b])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902cec900b001896040022asm753472plg.190.2022.11.30.00.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:23:46 -0800 (PST)
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
Subject: [PATCH 04/31] sched: Allow sched_cgroup_fork() to fail and introduce sched_cancel_fork()
Date:   Tue, 29 Nov 2022 22:22:46 -1000
Message-Id: <20221130082313.3241517-5-tj@kernel.org>
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

A new sched_clas needs a bit more control over forking. This patch makes the
following changes:

* Add sched_cancel_fork() which is called if fork fails after sched_fork()
  succeeds so that the preparation can be undone.

* Allow sched_cgroup_fork() to fail.

Neither is used yet and this patch shouldn't cause any behavior changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/sched/task.h |  3 ++-
 kernel/fork.c              | 15 ++++++++++-----
 kernel/sched/core.c        |  8 +++++++-
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index d6c48163c6de..b5ff1361ac8d 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -58,7 +58,8 @@ extern asmlinkage void schedule_tail(struct task_struct *prev);
 extern void init_idle(struct task_struct *idle, int cpu);
 
 extern int sched_fork(unsigned long clone_flags, struct task_struct *p);
-extern void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs);
+extern int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs);
+extern void sched_cancel_fork(struct task_struct *p);
 extern void sched_post_fork(struct task_struct *p);
 extern void sched_dead(struct task_struct *p);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 08969f5aa38d..a90c6a4938c6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2226,7 +2226,7 @@ static __latent_entropy struct task_struct *copy_process(
 
 	retval = perf_event_init_task(p, clone_flags);
 	if (retval)
-		goto bad_fork_cleanup_policy;
+		goto bad_fork_sched_cancel_fork;
 	retval = audit_alloc(p);
 	if (retval)
 		goto bad_fork_cleanup_perf;
@@ -2367,7 +2367,9 @@ static __latent_entropy struct task_struct *copy_process(
 	 * cgroup specific, it unconditionally needs to place the task on a
 	 * runqueue.
 	 */
-	sched_cgroup_fork(p, args);
+	retval = sched_cgroup_fork(p, args);
+	if (retval)
+		goto bad_fork_cancel_cgroup;
 
 	/*
 	 * From this point on we must avoid any synchronous user-space
@@ -2419,13 +2421,13 @@ static __latent_entropy struct task_struct *copy_process(
 	/* Don't start children in a dying pid namespace */
 	if (unlikely(!(ns_of_pid(pid)->pid_allocated & PIDNS_ADDING))) {
 		retval = -ENOMEM;
-		goto bad_fork_cancel_cgroup;
+		goto bad_fork_core_free;
 	}
 
 	/* Let kill terminate clone/fork in the middle */
 	if (fatal_signal_pending(current)) {
 		retval = -EINTR;
-		goto bad_fork_cancel_cgroup;
+		goto bad_fork_core_free;
 	}
 
 	init_task_pid_links(p);
@@ -2492,10 +2494,11 @@ static __latent_entropy struct task_struct *copy_process(
 
 	return p;
 
-bad_fork_cancel_cgroup:
+bad_fork_core_free:
 	sched_core_free(p);
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
+bad_fork_cancel_cgroup:
 	cgroup_cancel_fork(p, args);
 bad_fork_put_pidfd:
 	if (clone_flags & CLONE_PIDFD) {
@@ -2534,6 +2537,8 @@ static __latent_entropy struct task_struct *copy_process(
 	audit_free(p);
 bad_fork_cleanup_perf:
 	perf_event_free_task(p);
+bad_fork_sched_cancel_fork:
+	sched_cancel_fork(p);
 bad_fork_cleanup_policy:
 	lockdep_free_task(p);
 #ifdef CONFIG_NUMA
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cb2aa2b54c7a..85eb82ad2ffd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4604,7 +4604,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	return 0;
 }
 
-void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
+int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 {
 	unsigned long flags;
 
@@ -4631,6 +4631,12 @@ void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 	if (p->sched_class->task_fork)
 		p->sched_class->task_fork(p);
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+
+	return 0;
+}
+
+void sched_cancel_fork(struct task_struct *p)
+{
 }
 
 void sched_post_fork(struct task_struct *p)
-- 
2.38.1

