Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDF2435474
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 22:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhJTUUG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 16:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhJTUUG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 16:20:06 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96066C06161C;
        Wed, 20 Oct 2021 13:17:51 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s61-20020a17090a69c300b0019f663cfcd1so1420460pjj.1;
        Wed, 20 Oct 2021 13:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7tYXzZsIUPHC9petvQsmxGrHEyba4hQpZFGJPgwTC6k=;
        b=QxNKxBpjkXDs6LnLdIWDcFD5kHIujTWp6uOwYypQCXa953ensZsOGtyeYTom+jaCrc
         u4VWB744Tji+QQKz6TZY6BjKnKFGIOvmg7uj9AFyScoINbGNInpQIqdAVphphG5zzWQ4
         hEr1aFlgexygMfWnZLQpmSkuQysVBC6rp0gYO4KSuj1v/1zV0y54beAVwtEcyD6u+xGj
         oAZfQMy3cb8NnWzhqArrB3uc2gS9qD34hdgW3zgY9z34CvSsdk/t/9zml6v2W4XJ1/Ss
         fOmOl097nTkvs4WfXIUZ7b0AAbysn+jjr+CRuj7G/7S+VXi91lI2VECVyEawZRHz3znM
         X7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7tYXzZsIUPHC9petvQsmxGrHEyba4hQpZFGJPgwTC6k=;
        b=HjSdjncdSTLTPYpwcNpWBA2QOmyS71hBi8PJeCd/dRYQSlJ78HnTLlOg6j3fp1HaTu
         cPByrjk++F4O78dnJDfKFgAVcwqfYQZQeKVPjruF1QZaEalvK47yqGgP8nv3LOwctYmO
         TaCteoQlWrSsdwq3FQT+Nxco4cneEbPzyNJXTORkrMyJcLClUQHCOs3rnsj1CIzYYDKL
         Qmvh2wEDqSWrNXLus4TcG5bdjgR7aq/t/NLLJPRpV1zGevPWVONlI1Glf+6RgqDel896
         5OAl2UcGqI2mKEMkWilQdvVDlWJOAume5FJDlQZ8nWYvw0qYLYx9VbKva/PTvS7QiOse
         jmEA==
X-Gm-Message-State: AOAM531j0Rm0Ol8Ce2Dd0at4L8dr8+6vs74jrGOvJtSYsZp+aD3P9pxk
        4HhH4XAs2sU1+ZQ79Po82rI=
X-Google-Smtp-Source: ABdhPJyXRZQ3EURNrqdAz8DOBliSwumdi5SON4xS3eprSZ9GbDdXiuMIokLRiStHhXDgn0FR/L3PYw==
X-Received: by 2002:a17:90a:b117:: with SMTP id z23mr1370261pjq.74.1634761070937;
        Wed, 20 Oct 2021 13:17:50 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id j6sm2974684pgq.0.2021.10.20.13.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 13:17:50 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 20 Oct 2021 10:17:48 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     bpf@vger.kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] sched, cgroup: Generalize threadgroup_rwsem
Message-ID: <YXB5bGiFmACYWw2y@slm.duckdns.org>
References: <YXB5Mec4ahxXRx8K@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXB5Mec4ahxXRx8K@slm.duckdns.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From 1b07d36b074acb8a97c8bb5c0f1604960763578e Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Tue, 19 Oct 2021 10:12:27 -1000

Generalize threadgroup stabilization through threadgroup_rwsem so that it
can be used outside cgroup.

* A new config option CONFIG_THREADGROUP_RWSEM which is selected by
  CONFIG_CGROUPS enables threadgroup_rwsem.

* The declarations are moved to linux/sched/threadgroup_rwsem.h and the
  rwsem is now defined in kernel/sched/core.c.

* cgroup_mutex nests outside threadgroup_rwsem. During fork,
  cgroup_css_set_fork() which is called from cgroup_can_fork() was acquiring
  both. However, generalizing threadgroup_rwsem means that it needs to be
  acquired and released in the outer copy_process(). To maintain the locking
  order, break out cgroup_mutex acquisition into a separate function
  cgroup_prep_fork() which is called from copy_process() before acquiring
  threadgroup_rwsem.

No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/exec.c                               |  1 +
 include/linux/cgroup-defs.h             | 33 ------------------
 include/linux/cgroup.h                  | 11 +++---
 include/linux/sched/threadgroup_rwsem.h | 46 +++++++++++++++++++++++++
 init/Kconfig                            |  4 +++
 kernel/cgroup/cgroup-v1.c               |  1 +
 kernel/cgroup/cgroup.c                  | 38 +++++++++++++-------
 kernel/fork.c                           | 10 +++++-
 kernel/sched/core.c                     |  4 +++
 kernel/sched/sched.h                    |  1 +
 kernel/signal.c                         |  1 +
 11 files changed, 98 insertions(+), 52 deletions(-)
 create mode 100644 include/linux/sched/threadgroup_rwsem.h

diff --git a/fs/exec.c b/fs/exec.c
index caedd06a6d472..b18abc76e1ce0 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -39,6 +39,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/numa_balancing.h>
 #include <linux/sched/task.h>
+#include <linux/sched/threadgroup_rwsem.h>
 #include <linux/pagemap.h>
 #include <linux/perf_event.h>
 #include <linux/highmem.h>
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 1a77731e33096..b7e89b0c17057 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -16,7 +16,6 @@
 #include <linux/rcupdate.h>
 #include <linux/refcount.h>
 #include <linux/percpu-refcount.h>
-#include <linux/percpu-rwsem.h>
 #include <linux/u64_stats_sync.h>
 #include <linux/workqueue.h>
 #include <linux/bpf-cgroup.h>
@@ -708,42 +707,10 @@ struct cgroup_subsys {
 	unsigned int depends_on;
 };
 
-extern struct percpu_rw_semaphore threadgroup_rwsem;
-
-/**
- * threadgroup_change_begin - threadgroup exclusion for cgroups
- * @tsk: target task
- *
- * Allows cgroup operations to synchronize against threadgroup changes
- * using a percpu_rw_semaphore.
- */
-static inline void threadgroup_change_begin(struct task_struct *tsk)
-{
-	percpu_down_read(&threadgroup_rwsem);
-}
-
-/**
- * threadgroup_change_end - threadgroup exclusion for cgroups
- * @tsk: target task
- *
- * Counterpart of threadgroup_change_begin().
- */
-static inline void threadgroup_change_end(struct task_struct *tsk)
-{
-	percpu_up_read(&threadgroup_rwsem);
-}
-
 #else	/* CONFIG_CGROUPS */
 
 #define CGROUP_SUBSYS_COUNT 0
 
-static inline void threadgroup_change_begin(struct task_struct *tsk)
-{
-	might_sleep();
-}
-
-static inline void threadgroup_change_end(struct task_struct *tsk) {}
-
 #endif	/* CONFIG_CGROUPS */
 
 #ifdef CONFIG_SOCK_CGROUP_DATA
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 75c151413fda8..aa3df6361105f 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -121,12 +121,10 @@ int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 		     struct pid *pid, struct task_struct *tsk);
 
 void cgroup_fork(struct task_struct *p);
-extern int cgroup_can_fork(struct task_struct *p,
-			   struct kernel_clone_args *kargs);
-extern void cgroup_cancel_fork(struct task_struct *p,
-			       struct kernel_clone_args *kargs);
-extern void cgroup_post_fork(struct task_struct *p,
-			     struct kernel_clone_args *kargs);
+void cgroup_prep_fork(struct kernel_clone_args *kargs);
+int cgroup_can_fork(struct task_struct *p, struct kernel_clone_args *kargs);
+void cgroup_cancel_fork(struct task_struct *p, struct kernel_clone_args *kargs);
+void cgroup_post_fork(struct task_struct *p, struct kernel_clone_args *kargs);
 void cgroup_exit(struct task_struct *p);
 void cgroup_release(struct task_struct *p);
 void cgroup_free(struct task_struct *p);
@@ -713,6 +711,7 @@ static inline int cgroupstats_build(struct cgroupstats *stats,
 				    struct dentry *dentry) { return -EINVAL; }
 
 static inline void cgroup_fork(struct task_struct *p) {}
+static inline void cgroup_prep_fork(struct kernel_clone_args *kargs) { }
 static inline int cgroup_can_fork(struct task_struct *p,
 				  struct kernel_clone_args *kargs) { return 0; }
 static inline void cgroup_cancel_fork(struct task_struct *p,
diff --git a/include/linux/sched/threadgroup_rwsem.h b/include/linux/sched/threadgroup_rwsem.h
new file mode 100644
index 0000000000000..31ab72703724b
--- /dev/null
+++ b/include/linux/sched/threadgroup_rwsem.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SCHED_THREADGROUP_RWSEM_H
+#define _LINUX_SCHED_THREADGROUP_RWSEM_H
+
+#ifdef CONFIG_THREADGROUP_RWSEM
+/* including before task_struct definition causes dependency loop */
+#include <linux/percpu-rwsem.h>
+
+extern struct percpu_rw_semaphore threadgroup_rwsem;
+
+/**
+ * threadgroup_change_begin - mark the beginning of changes to a threadgroup
+ * @tsk: task causing the changes
+ *
+ * All operations which modify a threadgroup - a new thread joining the group,
+ * death of a member thread (the assertion of PF_EXITING) and exec(2)
+ * dethreading the process and replacing the leader - read-locks
+ * threadgroup_rwsem so that write-locking stabilizes thread groups.
+ */
+static inline void threadgroup_change_begin(struct task_struct *tsk)
+{
+	percpu_down_read(&threadgroup_rwsem);
+}
+
+/**
+ * threadgroup_change_end - mark the end of changes to a threadgroup
+ * @tsk: task causing the changes
+ *
+ * See threadgroup_change_begin().
+ */
+static inline void threadgroup_change_end(struct task_struct *tsk)
+{
+	percpu_up_read(&threadgroup_rwsem);
+}
+#else
+static inline void threadgroup_change_begin(struct task_struct *tsk)
+{
+	might_sleep();
+}
+
+static inline void threadgroup_change_end(struct task_struct *tsk)
+{
+}
+#endif
+
+#endif
diff --git a/init/Kconfig b/init/Kconfig
index 11f8a845f259d..3a3699ccff3ce 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -917,8 +917,12 @@ config NUMA_BALANCING_DEFAULT_ENABLED
 	  If set, automatic NUMA balancing will be enabled if running on a NUMA
 	  machine.
 
+config THREADGROUP_RWSEM
+        bool
+
 menuconfig CGROUPS
 	bool "Control Group support"
+	select THREADGROUP_RWSEM
 	select KERNFS
 	help
 	  This option adds support for grouping sets of processes together, for
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 03808e7deb2ea..9c747e258ae7c 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -8,6 +8,7 @@
 #include <linux/mm.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
+#include <linux/sched/threadgroup_rwsem.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 2fd01c901b1ae..937888386210a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -42,6 +42,7 @@
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
 #include <linux/sched/task.h>
+#include <linux/sched/threadgroup_rwsem.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/percpu-rwsem.h>
@@ -109,8 +110,6 @@ static DEFINE_SPINLOCK(cgroup_idr_lock);
  */
 static DEFINE_SPINLOCK(cgroup_file_kn_lock);
 
-DEFINE_PERCPU_RWSEM(threadgroup_rwsem);
-
 #define cgroup_assert_mutex_or_rcu_locked()				\
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&			\
 			   !lockdep_is_held(&cgroup_mutex),		\
@@ -6050,7 +6049,6 @@ static struct cgroup *cgroup_get_from_file(struct file *f)
  * to the target cgroup.
  */
 static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
-	__acquires(&cgroup_mutex) __acquires(&threadgroup_rwsem)
 {
 	int ret;
 	struct cgroup *dst_cgrp = NULL;
@@ -6058,11 +6056,6 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 	struct super_block *sb;
 	struct file *f;
 
-	if (kargs->flags & CLONE_INTO_CGROUP)
-		mutex_lock(&cgroup_mutex);
-
-	threadgroup_change_begin(current);
-
 	spin_lock_irq(&css_set_lock);
 	cset = task_css_set(current);
 	get_css_set(cset);
@@ -6118,7 +6111,6 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 	return ret;
 
 err:
-	threadgroup_change_end(current);
 	mutex_unlock(&cgroup_mutex);
 	if (f)
 		fput(f);
@@ -6138,10 +6130,8 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
  * CLONE_INTO_CGROUP was requested.
  */
 static void cgroup_css_set_put_fork(struct kernel_clone_args *kargs)
-	__releases(&threadgroup_rwsem) __releases(&cgroup_mutex)
+	__releases(&cgroup_mutex)
 {
-	threadgroup_change_end(current);
-
 	if (kargs->flags & CLONE_INTO_CGROUP) {
 		struct cgroup *cgrp = kargs->cgrp;
 		struct css_set *cset = kargs->cset;
@@ -6160,9 +6150,26 @@ static void cgroup_css_set_put_fork(struct kernel_clone_args *kargs)
 	}
 }
 
+/**
+ * cgroup_prep_fork - called during fork before threadgroup_rwsem is acquired
+ * @kargs: the arguments passed to create the child process
+ *
+ * CLONE_INTO_CGROUP requires cgroup_mutex as we're migrating while forking.
+ * However, cgroup_mutex must nest outside threadgroup_rwsem which is
+ * read-locked before cgroup_can_fork(). Break out cgroup_mutex locking to this
+ * function to follow the locking order.
+ */
+void cgroup_prep_fork(struct kernel_clone_args *kargs)
+	__acquires(&cgroup_mutex)
+{
+	if (kargs->flags & CLONE_INTO_CGROUP)
+		mutex_lock(&cgroup_mutex);
+}
+
 /**
  * cgroup_can_fork - called on a new task before the process is exposed
  * @child: the child process
+ * @kargs: the arguments passed to create the child process
  *
  * This prepares a new css_set for the child process which the child will
  * be attached to in cgroup_post_fork().
@@ -6175,6 +6182,13 @@ int cgroup_can_fork(struct task_struct *child, struct kernel_clone_args *kargs)
 	struct cgroup_subsys *ss;
 	int i, j, ret;
 
+	/*
+	 * cgroup_mutex should have been acquired by cgroup_prep_fork() if
+	 * CLONE_INTO_CGROUP
+	 */
+	if (kargs->flags & CLONE_INTO_CGROUP)
+		lockdep_assert_held(&cgroup_mutex);
+
 	ret = cgroup_css_set_fork(kargs);
 	if (ret)
 		return ret;
diff --git a/kernel/fork.c b/kernel/fork.c
index 38681ad44c76b..34fb9db59148b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -23,6 +23,7 @@
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/cputime.h>
+#include <linux/sched/threadgroup_rwsem.h>
 #include <linux/seq_file.h>
 #include <linux/rtmutex.h>
 #include <linux/init.h>
@@ -2285,6 +2286,10 @@ static __latent_entropy struct task_struct *copy_process(
 	p->kretprobe_instances.first = NULL;
 #endif
 
+	cgroup_prep_fork(args);
+
+	threadgroup_change_begin(current);
+
 	/*
 	 * Ensure that the cgroup subsystem policies allow the new process to be
 	 * forked. It should be noted that the new process's css_set can be changed
@@ -2293,7 +2298,7 @@ static __latent_entropy struct task_struct *copy_process(
 	 */
 	retval = cgroup_can_fork(p, args);
 	if (retval)
-		goto bad_fork_put_pidfd;
+		goto bad_fork_threadgroup_change_end;
 
 	/*
 	 * From this point on we must avoid any synchronous user-space
@@ -2407,6 +2412,7 @@ static __latent_entropy struct task_struct *copy_process(
 	proc_fork_connector(p);
 	sched_post_fork(p);
 	cgroup_post_fork(p, args);
+	threadgroup_change_end(current);
 	perf_event_fork(p);
 
 	trace_task_newtask(p, clone_flags);
@@ -2421,6 +2427,8 @@ static __latent_entropy struct task_struct *copy_process(
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
 	cgroup_cancel_fork(p, args);
+bad_fork_threadgroup_change_end:
+	threadgroup_change_end(current);
 bad_fork_put_pidfd:
 	if (clone_flags & CLONE_PIDFD) {
 		fput(pidfile);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1bba4128a3e68..bee6bf6d9659d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -84,6 +84,10 @@ unsigned int sysctl_sched_rt_period = 1000000;
 
 __read_mostly int scheduler_running;
 
+#ifdef CONFIG_THREADGROUP_RWSEM
+DEFINE_PERCPU_RWSEM(threadgroup_rwsem);
+#endif
+
 #ifdef CONFIG_SCHED_CORE
 
 DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3d3e5793e1172..135e4265fd259 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -28,6 +28,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
+#include <linux/sched/threadgroup_rwsem.h>
 #include <linux/sched/topology.h>
 #include <linux/sched/user.h>
 #include <linux/sched/wake_q.h>
diff --git a/kernel/signal.c b/kernel/signal.c
index f01b249369ce2..d46e63266faf4 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -20,6 +20,7 @@
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/cputime.h>
+#include <linux/sched/threadgroup_rwsem.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
-- 
2.33.1

