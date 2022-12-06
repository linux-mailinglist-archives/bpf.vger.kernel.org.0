Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADF5644DBC
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 22:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiLFVFt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 16:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLFVFs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 16:05:48 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3EEEA7;
        Tue,  6 Dec 2022 13:05:46 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id jr1so14779997qtb.7;
        Tue, 06 Dec 2022 13:05:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWT2GZF2oePCDXbUr1HIe1iJVZEEvLGC46quUCIfd88=;
        b=4faggOzmnyr9Xuny7guMoZUnd64jLSdaxGl+hlXMSrzdI8lqahSVNcRkXBT1nteQ0c
         7e7x6LlDx7E4U4D+7yiGvQhOedr4PcHigkgEx2LmcHuOTWn/2WDQGAT+NT4WLNbRQ0th
         Z0LOMMnV2eO3bGIJsQ/DMU/0hRzjN6fs3QaEUu7aUbbmerQRN0JZ2dB+fD9CviX3VGce
         zQjJUPqi7lXCJntBFJ5Lfiet/Ly0hE+EnMCNkmmcLste1vVPM+QGKUN9XjSvCFOM7aHR
         zllaQfzFpcc8de1k6dasQyOpBYVqqTUnkyzeTewwpCXUCiuOwdv+rm4N9hNY+PzS1CBy
         txAg==
X-Gm-Message-State: ANoB5pmdlb32BvTbXour7DR2IAVESIOSmx9Bx/Nuh/5OTFQMWAYWeWAN
        aYVD4WE405GNHqULskwjx73sqGr95pHZbM87
X-Google-Smtp-Source: AA0mqf7vMC+fDPLtIrFtxDcsLvZOo4r00+TQO2SqirFFMaTLgjNKIXXtaqbs8nnFWGS/xVfbBoUkQQ==
X-Received: by 2002:a05:622a:5c1b:b0:3a6:930b:b3b5 with SMTP id gd27-20020a05622a5c1b00b003a6930bb3b5mr22103167qtb.613.1670360745508;
        Tue, 06 Dec 2022 13:05:45 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:ed4c])
        by smtp.gmail.com with ESMTPSA id r12-20020a05620a298c00b006e16dcf99c8sm15870995qkp.71.2022.12.06.13.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 13:05:44 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Matus Jokay <matus.jokay@stuba.sk>
Subject: [PATCH bpf-next] bpf: Don't use rcu_users to refcount in task kfuncs
Date:   Tue,  6 Dec 2022 15:05:38 -0600
Message-Id: <20221206210538.597606-1-void@manifault.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A series of prior patches added some kfuncs that allow struct
task_struct * objects to be used as kptrs. These kfuncs leveraged the
'refcount_t rcu_users' field of the task for performing refcounting.
This field was used instead of 'refcount_t usage', as we wanted to
leverage the safety provided by RCU for ensuring a task's lifetime.

A struct task_struct is refcounted by two different refcount_t fields:

1. p->usage:     The "true" refcount field which task lifetime. The
		 task is freed as soon as this refcount drops to 0.

2. p->rcu_users: An "RCU users" refcount field which is statically
		 initialized to 2, and is co-located in a union with
		 a struct rcu_head field (p->rcu). p->rcu_users
		 essentially encapsulates a single p->usage
		 refcount, and when p->rcu_users goes to 0, an RCU
		 callback is scheduled on the struct rcu_head which
		 decrements the p->usage refcount.

Our logic was that by using p->rcu_users, we would be able to use RCU to
safely issue refcount_inc_not_zero() a task's rcu_users field to
determine if a task could still be acquired, or was exiting.
Unfortunately, this does not work due to p->rcu_users and p->rcu sharing
a union. When p->rcu_users goes to 0, an RCU callback is scheduled to
drop a single p->usage refcount, and because the fields share a union,
the refcount immediately becomes nonzero again after the callback is
scheduled.

If we were to split the fields out of the union, this wouldn't be a
problem. Doing so should also be rather non-controversial, as there are
a number of places in struct task_struct that have padding which we
could use to avoid growing the structure by splitting up the fields.

For now, so as to fix the kfuncs to be correct, this patch instead
updates bpf_task_acquire() and bpf_task_release() to use the p->usage
field for refcounting via the get_task_struct() and put_task_struct()
functions. Because we can no longer rely on RCU, the change also guts
the bpf_task_acquire_not_zero() and bpf_task_kptr_get() functions
pending a resolution on the above problem.

In addition, the task fixes the kfunc and rcu_read_lock selftests to
expect this new behavior.

Fixes: 90660309b0c7 ("bpf: Add kfuncs for storing struct task_struct * as a kptr")
Fixes: fca1aa75518c ("bpf: Handle MEM_RCU type properly")
Reported-by: Matus Jokay <matus.jokay@stuba.sk>
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/helpers.c                          | 76 ++++++++++++-------
 .../selftests/bpf/progs/rcu_read_lock.c       |  5 ++
 .../selftests/bpf/progs/task_kfunc_success.c  |  9 ++-
 3 files changed, 60 insertions(+), 30 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index cca642358e80..284b3ffdbe48 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1833,8 +1833,7 @@ struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
  */
 struct task_struct *bpf_task_acquire(struct task_struct *p)
 {
-	refcount_inc(&p->rcu_users);
-	return p;
+	return get_task_struct(p);
 }
 
 /**
@@ -1845,9 +1844,48 @@ struct task_struct *bpf_task_acquire(struct task_struct *p)
  */
 struct task_struct *bpf_task_acquire_not_zero(struct task_struct *p)
 {
-	if (!refcount_inc_not_zero(&p->rcu_users))
-		return NULL;
-	return p;
+	/* For the time being this function returns NULL, as it's not currently
+	 * possible to safely acquire a reference to a task with RCU protection
+	 * using get_task_struct() and put_task_struct(). This is due to the
+	 * slightly odd mechanics of p->rcu_users, and how task RCU protection
+	 * works.
+	 *
+	 * A struct task_struct is refcounted by two different refcount_t
+	 * fields:
+	 *
+	 * 1. p->usage:     The "true" refcount field which tracks a task's
+	 *		    lifetime. The task is freed as soon as this
+	 *		    refcount drops to 0.
+	 *
+	 * 2. p->rcu_users: An "RCU users" refcount field which is statically
+	 *		    initialized to 2, and is co-located in a union with
+	 *		    a struct rcu_head field (p->rcu). p->rcu_users
+	 *		    essentially encapsulates a single p->usage
+	 *		    refcount, and when p->rcu_users goes to 0, an RCU
+	 *		    callback is scheduled on the struct rcu_head which
+	 *		    decrements the p->usage refcount.
+	 *
+	 * There are two important implications to this task refcounting logic
+	 * described above. The first is that
+	 * refcount_inc_not_zero(&p->rcu_users) cannot be used anywhere, as
+	 * after the refcount goes to 0, the RCU callback being scheduled will
+	 * cause the memory backing the refcount to again be nonzero due to the
+	 * fields sharing a union. The other is that we can't rely on RCU to
+	 * guarantee that a task is valid in a BPF program. This is because a
+	 * task could have already transitioned to being in the TASK_DEAD
+	 * state, had its rcu_users refcount go to 0, and its rcu callback
+	 * invoked in which it drops its single p->usage reference. At this
+	 * point the task will be freed as soon as the last p->usage reference
+	 * goes to 0, without waiting for another RCU gp to elapse. The only
+	 * way that a BPF program can guarantee that a task is valid is in this
+	 * scenario is to hold a p->usage refcount itself.
+	 *
+	 * Until we're able to resolve this issue, either by pulling
+	 * p->rcu_users and p->rcu out of the union, or by getting rid of
+	 * p->usage and just using p->rcu_users for refcounting, we'll just
+	 * return NULL here.
+	 */
+	return NULL;
 }
 
 /**
@@ -1858,33 +1896,15 @@ struct task_struct *bpf_task_acquire_not_zero(struct task_struct *p)
  */
 struct task_struct *bpf_task_kptr_get(struct task_struct **pp)
 {
-	struct task_struct *p;
-
-	rcu_read_lock();
-	p = READ_ONCE(*pp);
-
-	/* Another context could remove the task from the map and release it at
-	 * any time, including after we've done the lookup above. This is safe
-	 * because we're in an RCU read region, so the task is guaranteed to
-	 * remain valid until at least the rcu_read_unlock() below.
+	/* We must return NULL here until we have clarity on how to properly
+	 * leverage RCU for ensuring a task's lifetime. See the comment above
+	 * in bpf_task_acquire_not_zero() for more details.
 	 */
-	if (p && !refcount_inc_not_zero(&p->rcu_users))
-		/* If the task had been removed from the map and freed as
-		 * described above, refcount_inc_not_zero() will return false.
-		 * The task will be freed at some point after the current RCU
-		 * gp has ended, so just return NULL to the user.
-		 */
-		p = NULL;
-	rcu_read_unlock();
-
-	return p;
+	return NULL;
 }
 
 /**
  * bpf_task_release - Release the reference acquired on a struct task_struct *.
- * If this kfunc is invoked in an RCU read region, the task_struct is
- * guaranteed to not be freed until the current grace period has ended, even if
- * its refcount drops to 0.
  * @p: The task on which a reference is being released.
  */
 void bpf_task_release(struct task_struct *p)
@@ -1892,7 +1912,7 @@ void bpf_task_release(struct task_struct *p)
 	if (!p)
 		return;
 
-	put_task_struct_rcu_user(p);
+	put_task_struct(p);
 }
 
 #ifdef CONFIG_CGROUPS
diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
index cf06a34fcb02..125f908024d3 100644
--- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
@@ -161,6 +161,11 @@ int task_acquire(void *ctx)
 	/* acquire a reference which can be used outside rcu read lock region */
 	gparent = bpf_task_acquire_not_zero(gparent);
 	if (!gparent)
+		/* Until we resolve the issues with using task->rcu_users, we
+		 * expect bpf_task_acquire_not_zero() to return a NULL task.
+		 * See the comment at the definition of
+		 * bpf_task_acquire_not_zero() for more details.
+		 */
 		goto out;
 
 	(void)bpf_task_storage_get(&map_a, gparent, 0, 0);
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
index 60c7ead41cfc..9f359cfd29e7 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_success.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
@@ -123,12 +123,17 @@ int BPF_PROG(test_task_get_release, struct task_struct *task, u64 clone_flags)
 	}
 
 	kptr = bpf_task_kptr_get(&v->task);
-	if (!kptr) {
+	if (kptr) {
+		/* Until we resolve the issues with using task->rcu_users, we
+		 * expect bpf_task_kptr_get() to return a NULL task. See the
+		 * comment at the definition of bpf_task_acquire_not_zero() for
+		 * more details.
+		 */
+		bpf_task_release(kptr);
 		err = 3;
 		return 0;
 	}
 
-	bpf_task_release(kptr);
 
 	return 0;
 }
-- 
2.38.1

