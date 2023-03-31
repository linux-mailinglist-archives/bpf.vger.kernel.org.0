Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DE36D1486
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 02:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjCaA5z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 20:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCaA5v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 20:57:51 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD8D1880C;
        Thu, 30 Mar 2023 17:57:41 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id h16so13513140qtn.7;
        Thu, 30 Mar 2023 17:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680224260; x=1682816260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Px8AxHmKDSTvRlARMauuD9mEpC8koNdrhnI2pj2fTzU=;
        b=ptAcD8C4Z2s1Fmvj6QIoAtWQZIroKI2MzSJiTOyIj2wMEHGIMLCJRgEto08F07EEzw
         3K6pDeI/GkQFhw7+LNhp+a4HnK7Su4zJPRzRrZndYBWscvZhKJtGQBm5PkiyU+vgNDVA
         FFcN5PfCA7QGLFCtoHw+/L6jwhbJrWlNp80xziJB8Ih6OpjRd/M4pedyYZZc6j7658+R
         hFbVHh+T40wrtQvpb6qvwD/vw5uK95D1SQdn2YRFHYpycXWBA4mj4bU22bJMPTlZjLY1
         j2tCM7rFwnx/LDamsGF/g1Q1mXRevs/RzXOPxoeSQxqGIjeW9AlN82dGM426rpKZeD5L
         ks9w==
X-Gm-Message-State: AO0yUKWWMACG5Ijn29VzfeMufpDU7MUx9/MLVNbCK+odi6pXrCXe+uRx
        6V+LySYo6KH4NAV1thDmZICLCrC0w9MZ4zGl
X-Google-Smtp-Source: AK7set/cf+8tB7Fmv4uGsNuiq4R9mlKMPRjgkaE+VP5Ff/BnZ5n7jEnM6lZ0xYD36RteaQ02X+CASw==
X-Received: by 2002:a05:622a:14d4:b0:3b8:6cb0:8d28 with SMTP id u20-20020a05622a14d400b003b86cb08d28mr44280603qtx.6.1680224260006;
        Thu, 30 Mar 2023 17:57:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:d9ee])
        by smtp.gmail.com with ESMTPSA id t12-20020a37460c000000b0074a0a6ce71csm275233qka.61.2023.03.30.17.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 17:57:39 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 2/3] bpf: Remove now-defunct task kfuncs
Date:   Thu, 30 Mar 2023 19:57:32 -0500
Message-Id: <20230331005733.406202-3-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230331005733.406202-1-void@manifault.com>
References: <20230331005733.406202-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In commit 22df776a9a86 ("tasks: Extract rcu_users out of union"), the
'refcount_t rcu_users' field was extracted out of a union with the
'struct rcu_head rcu' field. This allows us to safely perform a
refcount_inc_not_zero() on task->rcu_users when acquiring a reference on
a task struct. A prior patch leveraged this by making struct task_struct
an RCU-protected object in the verifier, and by bpf_task_acquire() to
use the task->rcu_users field for synchronization.

Now that we can use RCU to protect tasks, we no longer need
bpf_task_kptr_get(), or bpf_task_acquire_not_zero(). bpf_task_kptr_get()
is truly completely unnecessary, as we can just use RCU to get the
object. bpf_task_acquire_not_zero() is now equivalent to
bpf_task_acquire().

In addition to these changes, this patch also updates the associated
selftests to no longer use these kfuncs.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/helpers.c                          | 69 ------------------
 .../selftests/bpf/prog_tests/task_kfunc.c     |  2 +-
 .../selftests/bpf/progs/rcu_read_lock.c       |  9 +--
 .../selftests/bpf/progs/task_kfunc_common.h   |  1 -
 .../selftests/bpf/progs/task_kfunc_failure.c  | 73 -------------------
 .../selftests/bpf/progs/task_kfunc_success.c  | 22 +++---
 6 files changed, 14 insertions(+), 162 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e71a4a54ce99..6be16db9f188 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2019,73 +2019,6 @@ __bpf_kfunc struct task_struct *bpf_task_acquire(struct task_struct *p)
 	return NULL;
 }
 
-/**
- * bpf_task_acquire_not_zero - Acquire a reference to a rcu task object. A task
- * acquired by this kfunc which is not stored in a map as a kptr, must be
- * released by calling bpf_task_release().
- * @p: The task on which a reference is being acquired.
- */
-__bpf_kfunc struct task_struct *bpf_task_acquire_not_zero(struct task_struct *p)
-{
-	/* For the time being this function returns NULL, as it's not currently
-	 * possible to safely acquire a reference to a task with RCU protection
-	 * using get_task_struct() and put_task_struct(). This is due to the
-	 * slightly odd mechanics of p->rcu_users, and how task RCU protection
-	 * works.
-	 *
-	 * A struct task_struct is refcounted by two different refcount_t
-	 * fields:
-	 *
-	 * 1. p->usage:     The "true" refcount field which tracks a task's
-	 *		    lifetime. The task is freed as soon as this
-	 *		    refcount drops to 0.
-	 *
-	 * 2. p->rcu_users: An "RCU users" refcount field which is statically
-	 *		    initialized to 2, and is co-located in a union with
-	 *		    a struct rcu_head field (p->rcu). p->rcu_users
-	 *		    essentially encapsulates a single p->usage
-	 *		    refcount, and when p->rcu_users goes to 0, an RCU
-	 *		    callback is scheduled on the struct rcu_head which
-	 *		    decrements the p->usage refcount.
-	 *
-	 * There are two important implications to this task refcounting logic
-	 * described above. The first is that
-	 * refcount_inc_not_zero(&p->rcu_users) cannot be used anywhere, as
-	 * after the refcount goes to 0, the RCU callback being scheduled will
-	 * cause the memory backing the refcount to again be nonzero due to the
-	 * fields sharing a union. The other is that we can't rely on RCU to
-	 * guarantee that a task is valid in a BPF program. This is because a
-	 * task could have already transitioned to being in the TASK_DEAD
-	 * state, had its rcu_users refcount go to 0, and its rcu callback
-	 * invoked in which it drops its single p->usage reference. At this
-	 * point the task will be freed as soon as the last p->usage reference
-	 * goes to 0, without waiting for another RCU gp to elapse. The only
-	 * way that a BPF program can guarantee that a task is valid is in this
-	 * scenario is to hold a p->usage refcount itself.
-	 *
-	 * Until we're able to resolve this issue, either by pulling
-	 * p->rcu_users and p->rcu out of the union, or by getting rid of
-	 * p->usage and just using p->rcu_users for refcounting, we'll just
-	 * return NULL here.
-	 */
-	return NULL;
-}
-
-/**
- * bpf_task_kptr_get - Acquire a reference on a struct task_struct kptr. A task
- * kptr acquired by this kfunc which is not subsequently stored in a map, must
- * be released by calling bpf_task_release().
- * @pp: A pointer to a task kptr on which a reference is being acquired.
- */
-__bpf_kfunc struct task_struct *bpf_task_kptr_get(struct task_struct **pp)
-{
-	/* We must return NULL here until we have clarity on how to properly
-	 * leverage RCU for ensuring a task's lifetime. See the comment above
-	 * in bpf_task_acquire_not_zero() for more details.
-	 */
-	return NULL;
-}
-
 /**
  * bpf_task_release - Release the reference acquired on a task.
  * @p: The task on which a reference is being released.
@@ -2375,8 +2308,6 @@ BTF_ID_FLAGS(func, bpf_list_push_back)
 BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_task_acquire_not_zero, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_task_kptr_get, KF_ACQUIRE | KF_KPTR_GET | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE)
 BTF_ID_FLAGS(func, bpf_rbtree_add)
diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
index 5c76e5d4ca0e..0aff319e3946 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
@@ -73,7 +73,7 @@ static const char * const success_tests[] = {
 	"test_task_acquire_release_current",
 	"test_task_acquire_leave_in_map",
 	"test_task_xchg_release",
-	"test_task_get_release",
+	"test_task_map_acquire_release",
 	"test_task_current_acquire_release",
 	"test_task_from_pid_arg",
 	"test_task_from_pid_current",
diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
index 6a8c88e58df2..14fb01437fb8 100644
--- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
@@ -23,7 +23,7 @@ struct bpf_key *bpf_lookup_user_key(__u32 serial, __u64 flags) __ksym;
 void bpf_key_put(struct bpf_key *key) __ksym;
 void bpf_rcu_read_lock(void) __ksym;
 void bpf_rcu_read_unlock(void) __ksym;
-struct task_struct *bpf_task_acquire_not_zero(struct task_struct *p) __ksym;
+struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
 void bpf_task_release(struct task_struct *p) __ksym;
 
 SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
@@ -159,13 +159,8 @@ int task_acquire(void *ctx)
 		goto out;
 
 	/* acquire a reference which can be used outside rcu read lock region */
-	gparent = bpf_task_acquire_not_zero(gparent);
+	gparent = bpf_task_acquire(gparent);
 	if (!gparent)
-		/* Until we resolve the issues with using task->rcu_users, we
-		 * expect bpf_task_acquire_not_zero() to return a NULL task.
-		 * See the comment at the definition of
-		 * bpf_task_acquire_not_zero() for more details.
-		 */
 		goto out;
 
 	(void)bpf_task_storage_get(&map_a, gparent, 0, 0);
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_common.h b/tools/testing/selftests/bpf/progs/task_kfunc_common.h
index bf0d1da9aff8..41f2d44f49cb 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_common.h
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_common.h
@@ -21,7 +21,6 @@ struct hash_map {
 } __tasks_kfunc_map SEC(".maps");
 
 struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
-struct task_struct *bpf_task_kptr_get(struct task_struct **pp) __ksym;
 void bpf_task_release(struct task_struct *p) __ksym;
 struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
 void bpf_rcu_read_lock(void) __ksym;
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
index 175f8871ce16..3a4cfb90bcdb 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -128,59 +128,6 @@ int BPF_PROG(task_kfunc_acquire_unreleased, struct task_struct *task, u64 clone_
 	return 0;
 }
 
-SEC("tp_btf/task_newtask")
-__failure __msg("arg#0 expected pointer to map value")
-int BPF_PROG(task_kfunc_get_non_kptr_param, struct task_struct *task, u64 clone_flags)
-{
-	struct task_struct *kptr;
-
-	/* Cannot use bpf_task_kptr_get() on a non-kptr, even on a valid task. */
-	kptr = bpf_task_kptr_get(&task);
-	if (!kptr)
-		return 0;
-
-	bpf_task_release(kptr);
-
-	return 0;
-}
-
-SEC("tp_btf/task_newtask")
-__failure __msg("arg#0 expected pointer to map value")
-int BPF_PROG(task_kfunc_get_non_kptr_acquired, struct task_struct *task, u64 clone_flags)
-{
-	struct task_struct *kptr, *acquired;
-
-	acquired = bpf_task_acquire(task);
-	if (!acquired)
-		return 0;
-
-	/* Cannot use bpf_task_kptr_get() on a non-kptr, even if it was acquired. */
-	kptr = bpf_task_kptr_get(&acquired);
-	bpf_task_release(acquired);
-	if (!kptr)
-		return 0;
-
-	bpf_task_release(kptr);
-
-	return 0;
-}
-
-SEC("tp_btf/task_newtask")
-__failure __msg("arg#0 expected pointer to map value")
-int BPF_PROG(task_kfunc_get_null, struct task_struct *task, u64 clone_flags)
-{
-	struct task_struct *kptr;
-
-	/* Cannot use bpf_task_kptr_get() on a NULL pointer. */
-	kptr = bpf_task_kptr_get(NULL);
-	if (!kptr)
-		return 0;
-
-	bpf_task_release(kptr);
-
-	return 0;
-}
-
 SEC("tp_btf/task_newtask")
 __failure __msg("Unreleased reference")
 int BPF_PROG(task_kfunc_xchg_unreleased, struct task_struct *task, u64 clone_flags)
@@ -214,26 +161,6 @@ int BPF_PROG(task_kfunc_acquire_release_no_null_check, struct task_struct *task,
 	return 0;
 }
 
-SEC("tp_btf/task_newtask")
-__failure __msg("Unreleased reference")
-int BPF_PROG(task_kfunc_get_unreleased, struct task_struct *task, u64 clone_flags)
-{
-	struct task_struct *kptr;
-	struct __tasks_kfunc_map_value *v;
-
-	v = insert_lookup_task(task);
-	if (!v)
-		return 0;
-
-	kptr = bpf_task_kptr_get(&v->task);
-	if (!kptr)
-		return 0;
-
-	/* Kptr acquired above is never released. */
-
-	return 0;
-}
-
 SEC("tp_btf/task_newtask")
 __failure __msg("Possibly NULL pointer passed to trusted arg0")
 int BPF_PROG(task_kfunc_release_untrusted, struct task_struct *task, u64 clone_flags)
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
index 25710f632f19..49da7d0a3ebc 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_success.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
@@ -122,7 +122,7 @@ int BPF_PROG(test_task_xchg_release, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("tp_btf/task_newtask")
-int BPF_PROG(test_task_get_release, struct task_struct *task, u64 clone_flags)
+int BPF_PROG(test_task_map_acquire_release, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *kptr;
 	struct __tasks_kfunc_map_value *v;
@@ -143,18 +143,18 @@ int BPF_PROG(test_task_get_release, struct task_struct *task, u64 clone_flags)
 		return 0;
 	}
 
-	kptr = bpf_task_kptr_get(&v->task);
-	if (kptr) {
-		/* Until we resolve the issues with using task->rcu_users, we
-		 * expect bpf_task_kptr_get() to return a NULL task. See the
-		 * comment at the definition of bpf_task_acquire_not_zero() for
-		 * more details.
-		 */
-		bpf_task_release(kptr);
+	bpf_rcu_read_lock();
+	kptr = v->task;
+	if (!kptr) {
 		err = 3;
-		return 0;
+	} else {
+		kptr = bpf_task_acquire(kptr);
+		if (!kptr)
+			err = 4;
+		else
+			bpf_task_release(kptr);
 	}
-
+	bpf_rcu_read_unlock();
 
 	return 0;
 }
-- 
2.39.0

