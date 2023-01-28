Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4B267F2DF
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjA1ARC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjA1ARB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:17:01 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169717BE71;
        Fri, 27 Jan 2023 16:17:00 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso10221399pjg.2;
        Fri, 27 Jan 2023 16:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6m4TN++jZD6FdNJ/Ga+E1HCyQ4pLOMCr/1n+B6pb86U=;
        b=jKNJ8NuC4o+YDO+K4XVtGLbMUMs3aK2o3rk8+j7goEVvwlzii8eL4Cx4+RVAG3dCDj
         2E+sWsu12WNfyZihx45sRlOuDpAhmTyURLv0CmMy6YfEQhNStjMX1utKNv9njpEsgpXt
         jcj+4L5DaHMf0WbZjPZt8hIO++d9jIsMVWqlhJQgbPZE7w0lRcUizb26dL/DI0o40ys+
         4Jzvrt0h4t3mPKjwQKASoI1t4iVLBWlSev5F1CnvJdhUAdecACy7r7eA9DWrYlkYqvLl
         jIwwg/wK61qMP1yfM5gT7X2/KWcnltxEsJlMh8nZbmws6t8kELJIsrsZldtpHWN+L0ve
         78XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6m4TN++jZD6FdNJ/Ga+E1HCyQ4pLOMCr/1n+B6pb86U=;
        b=HTtiDzJGBlIkZOQfCbLnPw88H/bQ7Vk/veDIeddA+d/WCEOq2GJ+MBHgVP3S/JjOeS
         9vBjdVxHO9BsogvuNN/0ks+noDeLaJqzDj9ACQafOX+Z7xytdHeFQHxEsdlNSAHPS5bE
         MVW1yb4fsfiMhddGsa6fyJUIijioaxqaA/H/HvEdIc0oauT3Uka+lNrCmL+AAXEEhN67
         FmfunhTRgaZVk3ZPPT0DV8jM73Ol3sgARG7UD172XdIrjcgmSgpwVldNNKnRN2/uCMIX
         upEdTcT4Os9hdqkFvdK3nmxCQcF5sJ2hHM9UHLk7eyzq8bf15GBeS73eWCi5IBypdl4W
         tNRg==
X-Gm-Message-State: AO0yUKX+Wtj3djgdTaGChAhSSe2wGyFGVHF+AhvDYry/RoI+uy5dur+o
        CSdXVRFhpY9afMVncjx7qG4=
X-Google-Smtp-Source: AK7set/5c9xMYx+ooq/lVp0WQamE+4ra85rjVxMtTFfCAINcH+qxDlh+TVUZidQqfIATcQc3vxTbPg==
X-Received: by 2002:a17:90b:38cf:b0:22c:15a4:62a0 with SMTP id nn15-20020a17090b38cf00b0022c15a462a0mr10144927pjb.37.1674865019607;
        Fri, 27 Jan 2023 16:16:59 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id em6-20020a17090b014600b00217090ece49sm3251225pjb.31.2023.01.27.16.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:16:59 -0800 (PST)
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
Subject: [PATCH 04/30] sched: Allow sched_cgroup_fork() to fail and introduce sched_cancel_fork()
Date:   Fri, 27 Jan 2023 14:16:13 -1000
Message-Id: <20230128001639.3510083-5-tj@kernel.org>
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

A new BPF extensible sched_class will need more control over the forking
process. It wants to be able to fail from sched_cgroup_fork() after the new
task's sched_task_group is initialized so that the loaded BPF program can
prepare the task with its cgroup association is established and reject fork
if e.g. allocation fails.

Allow sched_cgroup_fork() to fail by making it return int instead of void
and adding sched_cancel_fork() to undo sched_fork() in the error path.

sched_cgroup_fork() doesn't fail yet and this patch shouldn't cause any
behavior changes.

v2: Patch description updated to detail the expected use.

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
index 357e0068497c..dcff721170c3 100644
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
index 9f7fe3541897..184c622b5513 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2239,7 +2239,7 @@ static __latent_entropy struct task_struct *copy_process(
 
 	retval = perf_event_init_task(p, clone_flags);
 	if (retval)
-		goto bad_fork_cleanup_policy;
+		goto bad_fork_sched_cancel_fork;
 	retval = audit_alloc(p);
 	if (retval)
 		goto bad_fork_cleanup_perf;
@@ -2380,7 +2380,9 @@ static __latent_entropy struct task_struct *copy_process(
 	 * cgroup specific, it unconditionally needs to place the task on a
 	 * runqueue.
 	 */
-	sched_cgroup_fork(p, args);
+	retval = sched_cgroup_fork(p, args);
+	if (retval)
+		goto bad_fork_cancel_cgroup;
 
 	/*
 	 * From this point on we must avoid any synchronous user-space
@@ -2426,13 +2428,13 @@ static __latent_entropy struct task_struct *copy_process(
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
 
 	/* No more failure paths after this point. */
@@ -2507,10 +2509,11 @@ static __latent_entropy struct task_struct *copy_process(
 
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
@@ -2549,6 +2552,8 @@ static __latent_entropy struct task_struct *copy_process(
 	audit_free(p);
 bad_fork_cleanup_perf:
 	perf_event_free_task(p);
+bad_fork_sched_cancel_fork:
+	sched_cancel_fork(p);
 bad_fork_cleanup_policy:
 	lockdep_free_task(p);
 #ifdef CONFIG_NUMA
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 65f21f8bf738..49b3d8ce84ca 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4709,7 +4709,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	return 0;
 }
 
-void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
+int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 {
 	unsigned long flags;
 
@@ -4736,6 +4736,12 @@ void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
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
2.39.1

