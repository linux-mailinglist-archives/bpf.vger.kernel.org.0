Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BED6BF450
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 22:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjCQVg3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 17:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCQVgW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 17:36:22 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E56C2B9D9;
        Fri, 17 Mar 2023 14:35:38 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so10569099pjt.2;
        Fri, 17 Mar 2023 14:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hj8cLjQDLjXQ1ZfCGY4fgdKd/DSkCX4r/5xti3BJx2Q=;
        b=SL77xmJ9qXwFUFkWfvQLbr2oAZctrFIRH1zYs6aiSXgaXesy4X9bbCc43J+9eu7BwZ
         oQ5gpgLhJe8AlvwhIjFD9fwm6HOV+aTa/I02IjXcjxAmaJNGPS3ymgflyQg833brBgs7
         84m+/ooDtKn6Ij3ePqTiRldtbg/5JadmV2CKcQHFrYHK1MIZb3JiQZItVnLirykhMwD+
         4DXceV50PClFpYHAnpemnfed3iOsz3CZOXKBLcLNOYZQ0bjx2AwMxczYK+4Wbtn5m0Td
         6qyHhqHDOe90XFAfM7/SJjOm33J83u/+ekfpbYg6lZzffSkpzsbctqrsa8GiLeQQhE54
         qDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hj8cLjQDLjXQ1ZfCGY4fgdKd/DSkCX4r/5xti3BJx2Q=;
        b=dBqx6jNGU870rF2nB3NnRfn+uSFhXDgJOXZgfiJWYa/YWheyzySirKyKr6K2PYxKAr
         UaNGpsrA3KIlNUlX4CL1uXvCNgDMSsgRQUdDLN0EC7VIkXYjiuZ4Zl3x3SMK3Vko5fdc
         3c/Ej3Y5XNvXUddHznN/+IISKGDWk719DCGCwkGWCL8MKD8MBqObjQRsLXPorMLGlqsN
         6X/CAm+evanquY+3zxpS5CKLp1AY8KDkvKUu+7zcU2kHZa9Fu7q4RqKpHBT+so2aIFt1
         2HP2cvUW8CCZTJIXpPJ2nDv7UlYZiXGX5/0lrhml7COf5KDlLlnLK7zUJL4jjMh83bgY
         Oqcg==
X-Gm-Message-State: AO0yUKUwXNGzff0TtoybdnxugoabD+n/hiKBwVoblu9qK6bf5LpwWC4H
        usEUy0u0cwZyyvEL4SiJb34=
X-Google-Smtp-Source: AK7set8tTIMwbsrX82yWCWzS7G+Yo1Zo2mQnccqtgoMU9W4EomnZ107bQTHWY8qfkhWvNO360+SAtA==
X-Received: by 2002:a17:902:ec91:b0:1a0:72b8:4030 with SMTP id x17-20020a170902ec9100b001a072b84030mr10550746plg.48.1679088830398;
        Fri, 17 Mar 2023 14:33:50 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id jl24-20020a170903135800b001a0450da45csm1973726plb.185.2023.03.17.14.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:33:50 -0700 (PDT)
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
Subject: [PATCH 04/32] sched: Allow sched_cgroup_fork() to fail and introduce sched_cancel_fork()
Date:   Fri, 17 Mar 2023 11:33:05 -1000
Message-Id: <20230317213333.2174969-5-tj@kernel.org>
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
index f68954d05e89..0d166537a1a3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2242,7 +2242,7 @@ static __latent_entropy struct task_struct *copy_process(
 
 	retval = perf_event_init_task(p, clone_flags);
 	if (retval)
-		goto bad_fork_cleanup_policy;
+		goto bad_fork_sched_cancel_fork;
 	retval = audit_alloc(p);
 	if (retval)
 		goto bad_fork_cleanup_perf;
@@ -2383,7 +2383,9 @@ static __latent_entropy struct task_struct *copy_process(
 	 * cgroup specific, it unconditionally needs to place the task on a
 	 * runqueue.
 	 */
-	sched_cgroup_fork(p, args);
+	retval = sched_cgroup_fork(p, args);
+	if (retval)
+		goto bad_fork_cancel_cgroup;
 
 	/*
 	 * From this point on we must avoid any synchronous user-space
@@ -2429,13 +2431,13 @@ static __latent_entropy struct task_struct *copy_process(
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
@@ -2510,10 +2512,11 @@ static __latent_entropy struct task_struct *copy_process(
 
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
@@ -2552,6 +2555,8 @@ static __latent_entropy struct task_struct *copy_process(
 	audit_free(p);
 bad_fork_cleanup_perf:
 	perf_event_free_task(p);
+bad_fork_sched_cancel_fork:
+	sched_cancel_fork(p);
 bad_fork_cleanup_policy:
 	lockdep_free_task(p);
 #ifdef CONFIG_NUMA
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index efac96fd6cfd..fdf4dba12a7e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4768,7 +4768,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	return 0;
 }
 
-void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
+int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 {
 	unsigned long flags;
 
@@ -4795,6 +4795,12 @@ void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
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
2.39.2

