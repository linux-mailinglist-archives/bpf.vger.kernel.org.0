Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA0A6D148A
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 02:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCaA6B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 20:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjCaA5u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 20:57:50 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4713D322;
        Thu, 30 Mar 2023 17:57:39 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id on15so2200937qvb.7;
        Thu, 30 Mar 2023 17:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680224258; x=1682816258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtNzlrSyreJo1UTt8TC8FltM+QuLpC6lGh3SM/SmsIQ=;
        b=ONNmEsvuRwa6ANX7sY1qBy1Z9veilE4XiJwO+Vlc9tn92US2/7R2125weyCnszO92f
         kgY1H9WoY9K7tA4YNqQNvD+Mk/FAtf+E/Vb3ShFNZsZ8FrMgUMBDmwrRfJOzonyedF0N
         UeozRCQJiDDjIJ24ey3ENGZ8JJD2jfSvqmzFlqZh1Wa5EMl/wucgvRa7xs2xIFUe3HZB
         5Uhnr6zB0Zx3lPNcB3QOnWElNQjz2+t2Ws1s+y5f1Yj/VIySZNYYn5JW9IBooaEvYFDp
         56dGus339sEZMwoflQw8TB9LLtCXvRYjBgpLfagfLcEBLg4a5OqAS/tlRaIfk6wQ24ER
         FjqA==
X-Gm-Message-State: AAQBX9fIIqSKNqq3xhZ26T+zanDOgbt+tsa7DBbIWkgtNJDlsv7jyb6X
        XmdhI9XkLT9ZRcwv9yk6zCuOFrU11SO9vB0m
X-Google-Smtp-Source: AKy350bJ6xcsplUCQFS32GpPt4cxJltfNeINLo7Gzx9pHe5V01d0aFcRndmN97Kj3ClDxPaY50dTyg==
X-Received: by 2002:a05:6214:dad:b0:5b3:e172:b63e with SMTP id h13-20020a0562140dad00b005b3e172b63emr42212890qvh.22.1680224258305;
        Thu, 30 Mar 2023 17:57:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:d9ee])
        by smtp.gmail.com with ESMTPSA id mm17-20020a0562145e9100b005dd8b9345f4sm212824qvb.140.2023.03.30.17.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 17:57:37 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 1/3] bpf: Make struct task_struct an RCU-safe type
Date:   Thu, 30 Mar 2023 19:57:31 -0500
Message-Id: <20230331005733.406202-2-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230331005733.406202-1-void@manifault.com>
References: <20230331005733.406202-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

struct task_struct objects are a bit interesting in terms of how their
lifetime is protected by refcounts. task structs have two refcount
fields:

1. refcount_t usage: Protects the memory backing the task struct. When
   this refcount drops to 0, the task is immediately freed, without
   waiting for an RCU grace period to elapse. This is the field that
   most callers in the kernel currently use to ensure that a task
   remains valid while it's being referenced, and is what's currently
   tracked with bpf_task_acquire() and bpf_task_release().

2. refcount_t rcu_users: A refcount field which, when it drops to 0,
   schedules an RCU callback that drops a reference held on the 'usage'
   field above (which is acquired when the task is first created). This
   field therefore provides a form of RCU protection on the task by
   ensuring that at least one 'usage' refcount will be held until an RCU
   grace period has elapsed. The qualifier "a form of" is important
   here, as a task can remain valid after task->rcu_users has dropped to
   0 and the subsequent RCU gp has elapsed.

In terms of BPF, we want to use task->rcu_users to protect tasks that
function as referenced kptrs, and to allow tasks stored as referenced
kptrs in maps to be accessed with RCU protection.

Let's first determine whether we can safely use task->rcu_users to
protect tasks stored in maps. All of the bpf_task* kfuncs can only be
called from tracepoint, struct_ops, or BPF_PROG_TYPE_SCHED_CLS, program
types. For tracepoint and struct_ops programs, the struct task_struct
passed to a program handler will always be trusted, so it will always be
safe to call bpf_task_acquire() with any task passed to a program.
Note, however, that we must update bpf_task_acquire() to be KF_RET_NULL,
as it is possible that the task has exited by the time the program is
invoked, even if the pointer is still currently valid because the main
kernel holds a task->usage refcount. For BPF_PROG_TYPE_SCHED_CLS, tasks
should never be passed as an argument to the any program handlers, so it
should not be relevant.

The second question is whether it's safe to use RCU to access a task
that was acquired with bpf_task_acquire(), and stored in a map. Because
bpf_task_acquire() now uses task->rcu_users, it follows that if the task
is present in the map, that it must have had at least one
task->rcu_users refcount by the time the current RCU cs was started.
Therefore, it's safe to access that task until the end of the current
RCU cs.

With all that said, this patch makes struct task_struct is an
RCU-protected object. In doing so, we also change bpf_task_acquire() to
be KF_ACQUIRE | KF_RCU | KF_RET_NULL, and adjust any selftests as
necessary. A subsequent patch will remove bpf_task_kptr_get(), and
bpf_task_acquire_not_zero() respectively.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/helpers.c                          | 11 ++-
 kernel/bpf/verifier.c                         |  1 +
 .../selftests/bpf/prog_tests/task_kfunc.c     |  2 +
 .../selftests/bpf/progs/task_kfunc_common.h   |  5 +
 .../selftests/bpf/progs/task_kfunc_failure.c  | 98 +++++++++++++++++--
 .../selftests/bpf/progs/task_kfunc_success.c  | 52 +++++++++-
 6 files changed, 153 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8980f6859443..e71a4a54ce99 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -18,6 +18,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/poison.h>
 #include <linux/proc_ns.h>
+#include <linux/sched/task.h>
 #include <linux/security.h>
 #include <linux/btf_ids.h>
 #include <linux/bpf_mem_alloc.h>
@@ -2013,7 +2014,9 @@ __bpf_kfunc struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root)
  */
 __bpf_kfunc struct task_struct *bpf_task_acquire(struct task_struct *p)
 {
-	return get_task_struct(p);
+	if (refcount_inc_not_zero(&p->rcu_users))
+		return p;
+	return NULL;
 }
 
 /**
@@ -2089,7 +2092,7 @@ __bpf_kfunc struct task_struct *bpf_task_kptr_get(struct task_struct **pp)
  */
 __bpf_kfunc void bpf_task_release(struct task_struct *p)
 {
-	put_task_struct(p);
+	put_task_struct_rcu_user(p);
 }
 
 #ifdef CONFIG_CGROUPS
@@ -2199,7 +2202,7 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
 	rcu_read_lock();
 	p = find_task_by_pid_ns(pid, &init_pid_ns);
 	if (p)
-		bpf_task_acquire(p);
+		p = bpf_task_acquire(p);
 	rcu_read_unlock();
 
 	return p;
@@ -2371,7 +2374,7 @@ BTF_ID_FLAGS(func, bpf_list_push_front)
 BTF_ID_FLAGS(func, bpf_list_push_back)
 BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_acquire_not_zero, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_kptr_get, KF_ACQUIRE | KF_KPTR_GET | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 52738f9dcb15..92ae4e8ab87b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4600,6 +4600,7 @@ BTF_SET_START(rcu_protected_types)
 BTF_ID(struct, prog_test_ref_kfunc)
 BTF_ID(struct, cgroup)
 BTF_ID(struct, bpf_cpumask)
+BTF_ID(struct, task_struct)
 BTF_SET_END(rcu_protected_types)
 
 static bool rcu_protected_object(const struct btf *btf, u32 btf_id)
diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
index f79fa5bc9a8d..5c76e5d4ca0e 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
@@ -78,6 +78,8 @@ static const char * const success_tests[] = {
 	"test_task_from_pid_arg",
 	"test_task_from_pid_current",
 	"test_task_from_pid_invalid",
+	"task_kfunc_acquire_trusted_walked",
+	"task_kfunc_acquire_untrusted_walked_null_check",
 };
 
 void test_task_kfunc(void)
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_common.h b/tools/testing/selftests/bpf/progs/task_kfunc_common.h
index 4c2a4b0e3a25..bf0d1da9aff8 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_common.h
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_common.h
@@ -24,6 +24,8 @@ struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
 struct task_struct *bpf_task_kptr_get(struct task_struct **pp) __ksym;
 void bpf_task_release(struct task_struct *p) __ksym;
 struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
 
 static inline struct __tasks_kfunc_map_value *tasks_kfunc_map_value_lookup(struct task_struct *p)
 {
@@ -60,6 +62,9 @@ static inline int tasks_kfunc_map_insert(struct task_struct *p)
 	}
 
 	acquired = bpf_task_acquire(p);
+	if (!acquired)
+		return -ENOENT;
+
 	old = bpf_kptr_xchg(&v->task, acquired);
 	if (old) {
 		bpf_task_release(old);
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
index 2c374a7ffece..175f8871ce16 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -40,6 +40,9 @@ int BPF_PROG(task_kfunc_acquire_untrusted, struct task_struct *task, u64 clone_f
 
 	/* Can't invoke bpf_task_acquire() on an untrusted pointer. */
 	acquired = bpf_task_acquire(v->task);
+	if (!acquired)
+		return 0;
+
 	bpf_task_release(acquired);
 
 	return 0;
@@ -53,38 +56,49 @@ int BPF_PROG(task_kfunc_acquire_fp, struct task_struct *task, u64 clone_flags)
 
 	/* Can't invoke bpf_task_acquire() on a random frame pointer. */
 	acquired = bpf_task_acquire((struct task_struct *)&stack_task);
+	if (!acquired)
+		return 0;
+
 	bpf_task_release(acquired);
 
 	return 0;
 }
 
 SEC("kretprobe/free_task")
-__failure __msg("reg type unsupported for arg#0 function")
+__failure __msg("calling kernel function bpf_task_acquire is not allowed")
 int BPF_PROG(task_kfunc_acquire_unsafe_kretprobe, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *acquired;
 
+	/* Can't call bpf_task_acquire() or bpf_task_release() in an untrusted prog. */
 	acquired = bpf_task_acquire(task);
-	/* Can't release a bpf_task_acquire()'d task without a NULL check. */
+	if (!acquired)
+		return 0;
 	bpf_task_release(acquired);
 
 	return 0;
 }
 
-SEC("tp_btf/task_newtask")
-__failure __msg("R1 must be referenced or trusted")
-int BPF_PROG(task_kfunc_acquire_trusted_walked, struct task_struct *task, u64 clone_flags)
+SEC("kretprobe/free_task")
+__failure __msg("calling kernel function bpf_task_acquire is not allowed")
+int BPF_PROG(task_kfunc_acquire_unsafe_kretprobe_rcu, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *acquired;
 
-	/* Can't invoke bpf_task_acquire() on a trusted pointer obtained from walking a struct. */
-	acquired = bpf_task_acquire(task->group_leader);
-	bpf_task_release(acquired);
+	bpf_rcu_read_lock();
+	if (!task) {
+		bpf_rcu_read_unlock();
+		return 0;
+	}
+	/* Can't call bpf_task_acquire() or bpf_task_release() in an untrusted prog. */
+	acquired = bpf_task_acquire(task);
+	if (acquired)
+		bpf_task_release(acquired);
+	bpf_rcu_read_unlock();
 
 	return 0;
 }
 
-
 SEC("tp_btf/task_newtask")
 __failure __msg("Possibly NULL pointer passed to trusted arg0")
 int BPF_PROG(task_kfunc_acquire_null, struct task_struct *task, u64 clone_flags)
@@ -137,6 +151,8 @@ int BPF_PROG(task_kfunc_get_non_kptr_acquired, struct task_struct *task, u64 clo
 	struct task_struct *kptr, *acquired;
 
 	acquired = bpf_task_acquire(task);
+	if (!acquired)
+		return 0;
 
 	/* Cannot use bpf_task_kptr_get() on a non-kptr, even if it was acquired. */
 	kptr = bpf_task_kptr_get(&acquired);
@@ -185,6 +201,19 @@ int BPF_PROG(task_kfunc_xchg_unreleased, struct task_struct *task, u64 clone_fla
 	return 0;
 }
 
+SEC("tp_btf/task_newtask")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+int BPF_PROG(task_kfunc_acquire_release_no_null_check, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *acquired;
+
+	acquired = bpf_task_acquire(task);
+	/* Can't invoke bpf_task_release() on an acquired task without a NULL check. */
+	bpf_task_release(acquired);
+
+	return 0;
+}
+
 SEC("tp_btf/task_newtask")
 __failure __msg("Unreleased reference")
 int BPF_PROG(task_kfunc_get_unreleased, struct task_struct *task, u64 clone_flags)
@@ -256,12 +285,13 @@ int BPF_PROG(task_kfunc_release_null, struct task_struct *task, u64 clone_flags)
 		return -ENOENT;
 
 	acquired = bpf_task_acquire(task);
+	if (!acquired)
+		return -EEXIST;
 
 	old = bpf_kptr_xchg(&v->task, acquired);
 
 	/* old cannot be passed to bpf_task_release() without a NULL check. */
 	bpf_task_release(old);
-	bpf_task_release(old);
 
 	return 0;
 }
@@ -298,6 +328,9 @@ int BPF_PROG(task_kfunc_from_lsm_task_free, struct task_struct *task)
 
 	/* the argument of lsm task_free hook is untrusted. */
 	acquired = bpf_task_acquire(task);
+	if (!acquired)
+		return 0;
+
 	bpf_task_release(acquired);
 	return 0;
 }
@@ -337,3 +370,48 @@ int BPF_PROG(task_access_comm4, struct task_struct *task, const char *buf, bool
 	bpf_strncmp(task->comm, 16, "foo");
 	return 0;
 }
+
+SEC("tp_btf/task_newtask")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+int BPF_PROG(task_kfunc_acquire_untrusted_walked, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *acquired;
+
+	bpf_rcu_read_lock();
+	/* Can't invoke bpf_task_acquire() on a nullable RCU-protected field in
+	 * a task_struct.
+	 */
+	acquired = bpf_task_acquire(task->parent);
+	bpf_rcu_read_unlock();
+	if (acquired)
+		bpf_task_release(acquired);
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+__failure __msg("R1 must be referenced or trusted")
+int BPF_PROG(task_kfunc_release_in_map, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *local;
+	struct __tasks_kfunc_map_value *v;
+
+	if (tasks_kfunc_map_insert(task))
+		return 0;
+
+	v = tasks_kfunc_map_value_lookup(task);
+	if (!v)
+		return 0;
+
+	bpf_rcu_read_lock();
+	local = v->task;
+	if (!local) {
+		bpf_rcu_read_unlock();
+		return 0;
+	}
+	/* Can't release a kptr that's still stored in a map. */
+	bpf_task_release(local);
+	bpf_rcu_read_unlock();
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
index cfa7f12b84e8..25710f632f19 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_success.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
@@ -47,7 +47,10 @@ static int test_acquire_release(struct task_struct *task)
 	}
 
 	acquired = bpf_task_acquire(task);
-	bpf_task_release(acquired);
+	if (acquired)
+		bpf_task_release(acquired);
+	else
+		err = 6;
 
 	return 0;
 }
@@ -166,7 +169,10 @@ int BPF_PROG(test_task_current_acquire_release, struct task_struct *task, u64 cl
 
 	current = bpf_get_current_task_btf();
 	acquired = bpf_task_acquire(current);
-	bpf_task_release(acquired);
+	if (acquired)
+		bpf_task_release(acquired);
+	else
+		err = 1;
 
 	return 0;
 }
@@ -241,3 +247,45 @@ int BPF_PROG(test_task_from_pid_invalid, struct task_struct *task, u64 clone_fla
 
 	return 0;
 }
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(task_kfunc_acquire_trusted_walked, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *acquired;
+
+	/* task->group_leader is listed as a trusted, non-NULL field of task struct. */
+	acquired = bpf_task_acquire(task->group_leader);
+	if (acquired)
+		bpf_task_release(acquired);
+	else
+		err = 1;
+
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(task_kfunc_acquire_untrusted_walked_null_check,
+	     struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *acquired, *parent;
+
+	/* task->parent is _NOT_ a trusted, non-NULLable field of task struct,
+	 * so we must do an explicit NULL check.
+	 */
+	bpf_rcu_read_lock();
+	parent = task->parent;
+	if (!parent) {
+		bpf_rcu_read_unlock();
+		err = 1;
+		return 0;
+	}
+	acquired = bpf_task_acquire(parent);
+	bpf_rcu_read_unlock();
+	if (acquired)
+		bpf_task_release(acquired);
+	else
+		err = 2;
+
+	return 0;
+}
-- 
2.39.0

