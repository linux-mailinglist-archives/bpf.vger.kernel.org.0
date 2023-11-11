Return-Path: <bpf+bounces-14824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 554517E886B
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6011F20F73
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D1E53B1;
	Sat, 11 Nov 2023 02:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyfWXJx/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6367063AC
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:49:03 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F434682;
	Fri, 10 Nov 2023 18:49:01 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b2e330033fso1480052b6e.3;
        Fri, 10 Nov 2023 18:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670940; x=1700275740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUHH5CPwRNzgz9d7dU60g96xAAx6plF4qt1RwMDTFYk=;
        b=AyfWXJx/nf0yGRMP0nsYs8CxWdqPg6km98XhkmtQJTLnIIWL8iUItei4XSvlPbiicH
         TdOrmXygruj+kn4ruP/wxzTIVQCBIW1iIQkIfnf8lHhu2ZiKHWzg/G8M4lnIadnPaUc9
         VebIu/fsHD1KloX/7r9+pdeZip4xbJbd0EyGjQWkFEpZY97rWcEU0QY7FazAUDh1l1ov
         EfoNN5VdlJddUVyF4560o506fWUgHUgxnRqlObkXFaQu7VG7w3Rwe59zDE4rXgSccN7N
         k+qDgEi50lk4ZN3dJimmxZCuXVhiG7k4Prs1yYwlaVzJBEey5o/tcAA+R1qmoSwrCAEL
         3yfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670940; x=1700275740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lUHH5CPwRNzgz9d7dU60g96xAAx6plF4qt1RwMDTFYk=;
        b=BU+qE0g7qMxO7DCe2WNbXIS0UKZudvthsRaL65rav7c7+++Yn0/u2jR+yJXA3d9FRy
         8aaPSabpkmTz22NIJK/J+6U9cuGSsIQPGjKURINuZe0C/oaQmnT2h/cgXkHPWmj7G48a
         apYiiH8himBU/WfVMheKb1PsNw1GkmN0dlnt8Dev6IRmQNRalzSDtHO3XCG92ClNFWaa
         /99lSALBASXkCzonRfYaDcyw1KLv7I42DPRiF953utp4965A+NJSdzM6pCVxWrTfuZeJ
         SGeR43s6OZig6rLbRigE47PKG/0Mzac/EkEXaK53x8G+hlHyquzasZm37dpODko7ZqBp
         Bbkg==
X-Gm-Message-State: AOJu0Yzqu//QLys788FgyFxCmvC8WX9ynthXkmxZRS5SOYnkaeHwG70z
	TqK6DlHHePrs3eysyZG8mx8=
X-Google-Smtp-Source: AGHT+IFbmEdgitsdOKyuKkl4DTbfi0zHNg+vgGNMPvrhljoXQ93piekXo8Cuww3jOYS4REPIH8lzFQ==
X-Received: by 2002:a05:6808:4395:b0:3a7:1d15:28fe with SMTP id dz21-20020a056808439500b003a71d1528femr1041649oib.56.1699670940265;
        Fri, 10 Nov 2023 18:49:00 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id 71-20020a63004a000000b0057412d84d25sm408459pga.4.2023.11.10.18.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:48:59 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	joshdon@google.com,
	brho@google.com,
	pjt@google.com,
	derkling@google.com,
	haoluo@google.com,
	dvernet@meta.com,
	dschatzberg@meta.com,
	dskarlat@cs.cmu.edu,
	riel@surriel.com,
	changwoo@igalia.com,
	himadrics@inria.fr,
	memxor@gmail.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 03/36] sched: Allow sched_cgroup_fork() to fail and introduce sched_cancel_fork()
Date: Fri, 10 Nov 2023 16:47:29 -1000
Message-ID: <20231111024835.2164816-4-tj@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111024835.2164816-1-tj@kernel.org>
References: <20231111024835.2164816-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index a23af225c898..03d35e3eda3c 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -61,7 +61,8 @@ extern asmlinkage void schedule_tail(struct task_struct *prev);
 extern void init_idle(struct task_struct *idle, int cpu);
 
 extern int sched_fork(unsigned long clone_flags, struct task_struct *p);
-extern void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs);
+extern int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs);
+extern void sched_cancel_fork(struct task_struct *p);
 extern void sched_post_fork(struct task_struct *p);
 extern void sched_dead(struct task_struct *p);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 204bc1c33533..38c5d142c691 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2472,7 +2472,7 @@ __latent_entropy struct task_struct *copy_process(
 
 	retval = perf_event_init_task(p, clone_flags);
 	if (retval)
-		goto bad_fork_cleanup_policy;
+		goto bad_fork_sched_cancel_fork;
 	retval = audit_alloc(p);
 	if (retval)
 		goto bad_fork_cleanup_perf;
@@ -2604,7 +2604,9 @@ __latent_entropy struct task_struct *copy_process(
 	 * cgroup specific, it unconditionally needs to place the task on a
 	 * runqueue.
 	 */
-	sched_cgroup_fork(p, args);
+	retval = sched_cgroup_fork(p, args);
+	if (retval)
+		goto bad_fork_cancel_cgroup;
 
 	/*
 	 * From this point on we must avoid any synchronous user-space
@@ -2650,13 +2652,13 @@ __latent_entropy struct task_struct *copy_process(
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
@@ -2732,10 +2734,11 @@ __latent_entropy struct task_struct *copy_process(
 
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
@@ -2774,6 +2777,8 @@ __latent_entropy struct task_struct *copy_process(
 	audit_free(p);
 bad_fork_cleanup_perf:
 	perf_event_free_task(p);
+bad_fork_sched_cancel_fork:
+	sched_cancel_fork(p);
 bad_fork_cleanup_policy:
 	lockdep_free_task(p);
 #ifdef CONFIG_NUMA
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5c0ef271a31a..b5fb4b894477 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4784,7 +4784,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	return 0;
 }
 
-void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
+int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 {
 	unsigned long flags;
 
@@ -4811,6 +4811,12 @@ void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
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
2.42.0


