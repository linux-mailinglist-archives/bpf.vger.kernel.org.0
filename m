Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D626782B8
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 18:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbjAWRQG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 12:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjAWRP4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 12:15:56 -0500
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FEA2CC42;
        Mon, 23 Jan 2023 09:15:19 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 66so15710149yba.4;
        Mon, 23 Jan 2023 09:15:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHlyxHCEexg13DqSbeGy72WwioCUWH3UJdSrEkH1PeQ=;
        b=Y5K4sq4FA3VhVjYigQmT74pOiqz/8DD1rdy8iQPaLpLnFsTSRmN/GHT4pdNMcqqH4g
         yl8y8WZnunNd0fQf1XtdTKHDhiCbnbP3cre3/fJDQCTBAU2oIKNXZd+Y6gBj5K/Dv6Hf
         WvZ0QOIvesekqtzNN6riQO9J+dxaALAlGzC4w/jHpl41u90eiLfWI42yDHDT65p1ZDk9
         /w06AR/7cwkpZk+XqF7LAeh8Pk2HP3ENwL0XR9gILJxM8LnYPizuCgfxvZnijbCxO8eK
         EK3Vbidg4Kwa25s7PURgYopCrFh1bx4x+GVp5DPo6SvrZJLjXgKsWrE1CGa8yMuMbPO2
         MCYA==
X-Gm-Message-State: AFqh2ko8pOEvzEeVH4hCM6yMjsT3oo0ye3D62NGw4Fa2E+6r2QiT/k73
        5HDgvZK8J7j4d8IwXy3x/b6fvfwi09di4mrR
X-Google-Smtp-Source: AMrXdXtLR6hmJyOIYZK8p09WiOvXA8w2JLcxvlufBJuceCZRcOuYgJ5SRQBKKiCCr+PMK+GCfxLDYA==
X-Received: by 2002:a25:9849:0:b0:7b8:620c:d3e4 with SMTP id k9-20020a259849000000b007b8620cd3e4mr16988524ybo.26.1674494118319;
        Mon, 23 Jan 2023 09:15:18 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:93a0])
        by smtp.gmail.com with ESMTPSA id y15-20020a05620a0e0f00b006f7ee901674sm31629527qkm.2.2023.01.23.09.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:15:17 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, memxor@gmail.com
Subject: [PATCH bpf-next v2 3/3] bpf: Use BPF_KFUNC macro at all kfunc definitions
Date:   Mon, 23 Jan 2023 11:15:06 -0600
Message-Id: <20230123171506.71995-4-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230123171506.71995-1-void@manifault.com>
References: <20230123171506.71995-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that we have the BPF_KFUNC macro, we should use it to define all
existing kfuncs to ensure that they'll never be elided in LTO builds,
and so that we can remove the __diag blocks around them.

Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/helpers.c                          | 44 ++++++-------
 kernel/cgroup/rstat.c                         |  4 +-
 kernel/kexec_core.c                           |  3 +-
 kernel/trace/bpf_trace.c                      | 18 ++----
 net/bpf/test_run.c                            | 64 +++++++++----------
 net/ipv4/tcp_bbr.c                            | 16 ++---
 net/ipv4/tcp_cong.c                           | 10 +--
 net/ipv4/tcp_cubic.c                          | 12 ++--
 net/ipv4/tcp_dctcp.c                          | 12 ++--
 net/netfilter/nf_conntrack_bpf.c              | 34 ++++------
 net/netfilter/nf_nat_bpf.c                    | 12 +---
 net/xfrm/xfrm_interface_bpf.c                 | 14 +---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  3 +-
 13 files changed, 105 insertions(+), 141 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 458db2db2f81..51d102fdfc29 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1772,11 +1772,7 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
 	}
 }
 
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "Global functions as their definitions will be in vmlinux BTF");
-
-void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
+BPF_KFUNC(void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign))
 {
 	struct btf_struct_meta *meta = meta__ign;
 	u64 size = local_type_id__k;
@@ -1790,7 +1786,7 @@ void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
 	return p;
 }
 
-void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
+BPF_KFUNC(void bpf_obj_drop_impl(void *p__alloc, void *meta__ign))
 {
 	struct btf_struct_meta *meta = meta__ign;
 	void *p = p__alloc;
@@ -1811,12 +1807,12 @@ static void __bpf_list_add(struct bpf_list_node *node, struct bpf_list_head *hea
 	tail ? list_add_tail(n, h) : list_add(n, h);
 }
 
-void bpf_list_push_front(struct bpf_list_head *head, struct bpf_list_node *node)
+BPF_KFUNC(void bpf_list_push_front(struct bpf_list_head *head, struct bpf_list_node *node))
 {
 	return __bpf_list_add(node, head, false);
 }
 
-void bpf_list_push_back(struct bpf_list_head *head, struct bpf_list_node *node)
+BPF_KFUNC(void bpf_list_push_back(struct bpf_list_head *head, struct bpf_list_node *node))
 {
 	return __bpf_list_add(node, head, true);
 }
@@ -1834,12 +1830,12 @@ static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, bool tai
 	return (struct bpf_list_node *)n;
 }
 
-struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head)
+BPF_KFUNC(struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head))
 {
 	return __bpf_list_del(head, false);
 }
 
-struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
+BPF_KFUNC(struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head))
 {
 	return __bpf_list_del(head, true);
 }
@@ -1850,7 +1846,7 @@ struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
  * bpf_task_release().
  * @p: The task on which a reference is being acquired.
  */
-struct task_struct *bpf_task_acquire(struct task_struct *p)
+BPF_KFUNC(struct task_struct *bpf_task_acquire(struct task_struct *p))
 {
 	return get_task_struct(p);
 }
@@ -1861,7 +1857,7 @@ struct task_struct *bpf_task_acquire(struct task_struct *p)
  * released by calling bpf_task_release().
  * @p: The task on which a reference is being acquired.
  */
-struct task_struct *bpf_task_acquire_not_zero(struct task_struct *p)
+BPF_KFUNC(struct task_struct *bpf_task_acquire_not_zero(struct task_struct *p))
 {
 	/* For the time being this function returns NULL, as it's not currently
 	 * possible to safely acquire a reference to a task with RCU protection
@@ -1913,7 +1909,7 @@ struct task_struct *bpf_task_acquire_not_zero(struct task_struct *p)
  * be released by calling bpf_task_release().
  * @pp: A pointer to a task kptr on which a reference is being acquired.
  */
-struct task_struct *bpf_task_kptr_get(struct task_struct **pp)
+BPF_KFUNC(struct task_struct *bpf_task_kptr_get(struct task_struct **pp))
 {
 	/* We must return NULL here until we have clarity on how to properly
 	 * leverage RCU for ensuring a task's lifetime. See the comment above
@@ -1926,7 +1922,7 @@ struct task_struct *bpf_task_kptr_get(struct task_struct **pp)
  * bpf_task_release - Release the reference acquired on a task.
  * @p: The task on which a reference is being released.
  */
-void bpf_task_release(struct task_struct *p)
+BPF_KFUNC(void bpf_task_release(struct task_struct *p))
 {
 	if (!p)
 		return;
@@ -1941,7 +1937,7 @@ void bpf_task_release(struct task_struct *p)
  * calling bpf_cgroup_release().
  * @cgrp: The cgroup on which a reference is being acquired.
  */
-struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp)
+BPF_KFUNC(struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp))
 {
 	cgroup_get(cgrp);
 	return cgrp;
@@ -1953,7 +1949,7 @@ struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp)
  * be released by calling bpf_cgroup_release().
  * @cgrpp: A pointer to a cgroup kptr on which a reference is being acquired.
  */
-struct cgroup *bpf_cgroup_kptr_get(struct cgroup **cgrpp)
+BPF_KFUNC(struct cgroup *bpf_cgroup_kptr_get(struct cgroup **cgrpp))
 {
 	struct cgroup *cgrp;
 
@@ -1985,7 +1981,7 @@ struct cgroup *bpf_cgroup_kptr_get(struct cgroup **cgrpp)
  * drops to 0.
  * @cgrp: The cgroup on which a reference is being released.
  */
-void bpf_cgroup_release(struct cgroup *cgrp)
+BPF_KFUNC(void bpf_cgroup_release(struct cgroup *cgrp))
 {
 	if (!cgrp)
 		return;
@@ -2000,7 +1996,7 @@ void bpf_cgroup_release(struct cgroup *cgrp)
  * @cgrp: The cgroup for which we're performing a lookup.
  * @level: The level of ancestor to look up.
  */
-struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level)
+BPF_KFUNC(struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level))
 {
 	struct cgroup *ancestor;
 
@@ -2019,7 +2015,7 @@ struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level)
  * stored in a map, or released with bpf_task_release().
  * @pid: The pid of the task being looked up.
  */
-struct task_struct *bpf_task_from_pid(s32 pid)
+BPF_KFUNC(struct task_struct *bpf_task_from_pid(s32 pid))
 {
 	struct task_struct *p;
 
@@ -2032,28 +2028,26 @@ struct task_struct *bpf_task_from_pid(s32 pid)
 	return p;
 }
 
-void *bpf_cast_to_kern_ctx(void *obj)
+BPF_KFUNC(void *bpf_cast_to_kern_ctx(void *obj))
 {
 	return obj;
 }
 
-void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k)
+BPF_KFUNC(void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k))
 {
 	return obj__ign;
 }
 
-void bpf_rcu_read_lock(void)
+BPF_KFUNC(void bpf_rcu_read_lock(void))
 {
 	rcu_read_lock();
 }
 
-void bpf_rcu_read_unlock(void)
+BPF_KFUNC(void bpf_rcu_read_unlock(void))
 {
 	rcu_read_unlock();
 }
 
-__diag_pop();
-
 BTF_SET8_START(generic_btf_ids)
 #ifdef CONFIG_KEXEC_CORE
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 793ecff29038..fbf41b434e1b 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -26,7 +26,7 @@ static struct cgroup_rstat_cpu *cgroup_rstat_cpu(struct cgroup *cgrp, int cpu)
  * rstat_cpu->updated_children list.  See the comment on top of
  * cgroup_rstat_cpu definition for details.
  */
-void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
+BPF_KFUNC(void cgroup_rstat_updated(struct cgroup *cgrp, int cpu))
 {
 	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
 	unsigned long flags;
@@ -231,7 +231,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
  *
  * This function may block.
  */
-void cgroup_rstat_flush(struct cgroup *cgrp)
+BPF_KFUNC(void cgroup_rstat_flush(struct cgroup *cgrp))
 {
 	might_sleep();
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 969e8f52f7da..6ea662dbc053 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -6,6 +6,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/btf.h>
 #include <linux/capability.h>
 #include <linux/mm.h>
 #include <linux/file.h>
@@ -975,7 +976,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
 }
 STACK_FRAME_NON_STANDARD(__crash_kexec);
 
-void crash_kexec(struct pt_regs *regs)
+BPF_KFUNC(void crash_kexec(struct pt_regs *regs))
 {
 	int old_cpu, this_cpu;
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 8124f1ad0d4a..c30be8d3a6fc 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1204,10 +1204,6 @@ static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
 };
 
 #ifdef CONFIG_KEYS
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "kfuncs which will be used in BPF programs");
-
 /**
  * bpf_lookup_user_key - lookup a key by its serial
  * @serial: key handle serial number
@@ -1233,7 +1229,7 @@ __diag_ignore_all("-Wmissing-prototypes",
  * Return: a bpf_key pointer with a valid key pointer if the key is found, a
  *         NULL pointer otherwise.
  */
-struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)
+BPF_KFUNC(struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags))
 {
 	key_ref_t key_ref;
 	struct bpf_key *bkey;
@@ -1282,7 +1278,7 @@ struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)
  * Return: a bpf_key pointer with an invalid key pointer set from the
  *         pre-determined ID on success, a NULL pointer otherwise
  */
-struct bpf_key *bpf_lookup_system_key(u64 id)
+BPF_KFUNC(struct bpf_key *bpf_lookup_system_key(u64 id))
 {
 	struct bpf_key *bkey;
 
@@ -1306,7 +1302,7 @@ struct bpf_key *bpf_lookup_system_key(u64 id)
  * Decrement the reference count of the key inside *bkey*, if the pointer
  * is valid, and free *bkey*.
  */
-void bpf_key_put(struct bpf_key *bkey)
+BPF_KFUNC(void bpf_key_put(struct bpf_key *bkey))
 {
 	if (bkey->has_ref)
 		key_put(bkey->key);
@@ -1326,9 +1322,9 @@ void bpf_key_put(struct bpf_key *bkey)
  *
  * Return: 0 on success, a negative value on error.
  */
-int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
-			       struct bpf_dynptr_kern *sig_ptr,
-			       struct bpf_key *trusted_keyring)
+BPF_KFUNC(int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
+					 struct bpf_dynptr_kern *sig_ptr,
+					 struct bpf_key *trusted_keyring))
 {
 	int ret;
 
@@ -1356,8 +1352,6 @@ int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
 }
 #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
 
-__diag_pop();
-
 BTF_SET8_START(key_sig_kfunc_set)
 BTF_ID_FLAGS(func, bpf_lookup_user_key, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_lookup_system_key, KF_ACQUIRE | KF_RET_NULL)
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 2723623429ac..f024717b98a2 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -481,10 +481,7 @@ static int bpf_test_finish(const union bpf_attr *kattr,
  * architecture dependent calling conventions. 7+ can be supported in the
  * future.
  */
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "Global functions as their definitions will be in vmlinux BTF");
-int noinline bpf_fentry_test1(int a)
+BPF_KFUNC(int bpf_fentry_test1(int a))
 {
 	return a + 1;
 }
@@ -529,23 +526,23 @@ int noinline bpf_fentry_test8(struct bpf_fentry_test_t *arg)
 	return (long)arg->a;
 }
 
-int noinline bpf_modify_return_test(int a, int *b)
+BPF_KFUNC(int bpf_modify_return_test(int a, int *b))
 {
 	*b += 1;
 	return a + *b;
 }
 
-u64 noinline bpf_kfunc_call_test1(struct sock *sk, u32 a, u64 b, u32 c, u64 d)
+BPF_KFUNC(u64 bpf_kfunc_call_test1(struct sock *sk, u32 a, u64 b, u32 c, u64 d))
 {
 	return a + b + c + d;
 }
 
-int noinline bpf_kfunc_call_test2(struct sock *sk, u32 a, u32 b)
+BPF_KFUNC(int bpf_kfunc_call_test2(struct sock *sk, u32 a, u32 b))
 {
 	return a + b;
 }
 
-struct sock * noinline bpf_kfunc_call_test3(struct sock *sk)
+BPF_KFUNC(struct sock *bpf_kfunc_call_test3(struct sock *sk))
 {
 	return sk;
 }
@@ -574,21 +571,19 @@ static struct prog_test_ref_kfunc prog_test_struct = {
 	.cnt = REFCOUNT_INIT(1),
 };
 
-noinline struct prog_test_ref_kfunc *
-bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr)
+BPF_KFUNC(struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr))
 {
 	refcount_inc(&prog_test_struct.cnt);
 	return &prog_test_struct;
 }
 
-noinline struct prog_test_member *
-bpf_kfunc_call_memb_acquire(void)
+BPF_KFUNC(struct prog_test_member *bpf_kfunc_call_memb_acquire(void))
 {
 	WARN_ON_ONCE(1);
 	return NULL;
 }
 
-noinline void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
+BPF_KFUNC(void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p))
 {
 	if (!p)
 		return;
@@ -596,11 +591,11 @@ noinline void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
 	refcount_dec(&p->cnt);
 }
 
-noinline void bpf_kfunc_call_memb_release(struct prog_test_member *p)
+BPF_KFUNC(void bpf_kfunc_call_memb_release(struct prog_test_member *p))
 {
 }
 
-noinline void bpf_kfunc_call_memb1_release(struct prog_test_member1 *p)
+BPF_KFUNC(void bpf_kfunc_call_memb1_release(struct prog_test_member1 *p))
 {
 	WARN_ON_ONCE(1);
 }
@@ -613,12 +608,14 @@ static int *__bpf_kfunc_call_test_get_mem(struct prog_test_ref_kfunc *p, const i
 	return (int *)p;
 }
 
-noinline int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size)
+BPF_KFUNC(int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p,
+						const int rdwr_buf_size))
 {
 	return __bpf_kfunc_call_test_get_mem(p, rdwr_buf_size);
 }
 
-noinline int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size)
+BPF_KFUNC(int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p,
+						  const int rdonly_buf_size))
 {
 	return __bpf_kfunc_call_test_get_mem(p, rdonly_buf_size);
 }
@@ -628,17 +625,18 @@ noinline int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p,
  * Acquire functions must return struct pointers, so these ones are
  * failing.
  */
-noinline int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size)
+BPF_KFUNC(int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p,
+						  const int rdonly_buf_size))
 {
 	return __bpf_kfunc_call_test_get_mem(p, rdonly_buf_size);
 }
 
-noinline void bpf_kfunc_call_int_mem_release(int *p)
+BPF_KFUNC(void bpf_kfunc_call_int_mem_release(int *p))
 {
 }
 
-noinline struct prog_test_ref_kfunc *
-bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **pp, int a, int b)
+BPF_KFUNC(struct prog_test_ref_kfunc *
+bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **pp, int a, int b))
 {
 	struct prog_test_ref_kfunc *p = READ_ONCE(*pp);
 
@@ -686,52 +684,50 @@ struct prog_test_fail3 {
 	char arr2[];
 };
 
-noinline void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb)
+BPF_KFUNC(void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb))
 {
 }
 
-noinline void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p)
+BPF_KFUNC(void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p))
 {
 }
 
-noinline void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p)
+BPF_KFUNC(void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p))
 {
 }
 
-noinline void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p)
+BPF_KFUNC(void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p))
 {
 }
 
-noinline void bpf_kfunc_call_test_fail2(struct prog_test_fail2 *p)
+BPF_KFUNC(void bpf_kfunc_call_test_fail2(struct prog_test_fail2 *p))
 {
 }
 
-noinline void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p)
+BPF_KFUNC(void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p))
 {
 }
 
-noinline void bpf_kfunc_call_test_mem_len_pass1(void *mem, int mem__sz)
+BPF_KFUNC(void bpf_kfunc_call_test_mem_len_pass1(void *mem, int mem__sz))
 {
 }
 
-noinline void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len)
+BPF_KFUNC(void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len))
 {
 }
 
-noinline void bpf_kfunc_call_test_mem_len_fail2(u64 *mem, int len)
+BPF_KFUNC(void bpf_kfunc_call_test_mem_len_fail2(u64 *mem, int len))
 {
 }
 
-noinline void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p)
+BPF_KFUNC(void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p))
 {
 }
 
-noinline void bpf_kfunc_call_test_destructive(void)
+BPF_KFUNC(void bpf_kfunc_call_test_destructive(void))
 {
 }
 
-__diag_pop();
-
 BTF_SET8_START(bpf_test_modify_return_ids)
 BTF_ID_FLAGS(func, bpf_modify_return_test)
 BTF_ID_FLAGS(func, bpf_fentry_test1, KF_SLEEPABLE)
diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
index d2c470524e58..a3f6d3ab4182 100644
--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -295,7 +295,7 @@ static void bbr_set_pacing_rate(struct sock *sk, u32 bw, int gain)
 }
 
 /* override sysctl_tcp_min_tso_segs */
-static u32 bbr_min_tso_segs(struct sock *sk)
+BPF_KFUNC(static u32 bbr_min_tso_segs(struct sock *sk))
 {
 	return sk->sk_pacing_rate < (bbr_min_tso_rate >> 3) ? 1 : 2;
 }
@@ -328,7 +328,7 @@ static void bbr_save_cwnd(struct sock *sk)
 		bbr->prior_cwnd = max(bbr->prior_cwnd, tcp_snd_cwnd(tp));
 }
 
-static void bbr_cwnd_event(struct sock *sk, enum tcp_ca_event event)
+BPF_KFUNC(static void bbr_cwnd_event(struct sock *sk, enum tcp_ca_event event))
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct bbr *bbr = inet_csk_ca(sk);
@@ -1023,7 +1023,7 @@ static void bbr_update_model(struct sock *sk, const struct rate_sample *rs)
 	bbr_update_gains(sk);
 }
 
-static void bbr_main(struct sock *sk, const struct rate_sample *rs)
+BPF_KFUNC(static void bbr_main(struct sock *sk, const struct rate_sample *rs))
 {
 	struct bbr *bbr = inet_csk_ca(sk);
 	u32 bw;
@@ -1035,7 +1035,7 @@ static void bbr_main(struct sock *sk, const struct rate_sample *rs)
 	bbr_set_cwnd(sk, rs, rs->acked_sacked, bw, bbr->cwnd_gain);
 }
 
-static void bbr_init(struct sock *sk)
+BPF_KFUNC(static void bbr_init(struct sock *sk))
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct bbr *bbr = inet_csk_ca(sk);
@@ -1077,7 +1077,7 @@ static void bbr_init(struct sock *sk)
 	cmpxchg(&sk->sk_pacing_status, SK_PACING_NONE, SK_PACING_NEEDED);
 }
 
-static u32 bbr_sndbuf_expand(struct sock *sk)
+BPF_KFUNC(static u32 bbr_sndbuf_expand(struct sock *sk))
 {
 	/* Provision 3 * cwnd since BBR may slow-start even during recovery. */
 	return 3;
@@ -1086,7 +1086,7 @@ static u32 bbr_sndbuf_expand(struct sock *sk)
 /* In theory BBR does not need to undo the cwnd since it does not
  * always reduce cwnd on losses (see bbr_main()). Keep it for now.
  */
-static u32 bbr_undo_cwnd(struct sock *sk)
+BPF_KFUNC(static u32 bbr_undo_cwnd(struct sock *sk))
 {
 	struct bbr *bbr = inet_csk_ca(sk);
 
@@ -1097,7 +1097,7 @@ static u32 bbr_undo_cwnd(struct sock *sk)
 }
 
 /* Entering loss recovery, so save cwnd for when we exit or undo recovery. */
-static u32 bbr_ssthresh(struct sock *sk)
+BPF_KFUNC(static u32 bbr_ssthresh(struct sock *sk))
 {
 	bbr_save_cwnd(sk);
 	return tcp_sk(sk)->snd_ssthresh;
@@ -1125,7 +1125,7 @@ static size_t bbr_get_info(struct sock *sk, u32 ext, int *attr,
 	return 0;
 }
 
-static void bbr_set_state(struct sock *sk, u8 new_state)
+BPF_KFUNC(static void bbr_set_state(struct sock *sk, u8 new_state))
 {
 	struct bbr *bbr = inet_csk_ca(sk);
 
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index d3cae40749e8..0a7ca941af65 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -403,7 +403,7 @@ int tcp_set_congestion_control(struct sock *sk, const char *name, bool load,
  * ABC caps N to 2. Slow start exits when cwnd grows over ssthresh and
  * returns the leftover acks to adjust cwnd in congestion avoidance mode.
  */
-u32 tcp_slow_start(struct tcp_sock *tp, u32 acked)
+BPF_KFUNC(u32 tcp_slow_start(struct tcp_sock *tp, u32 acked))
 {
 	u32 cwnd = min(tcp_snd_cwnd(tp) + acked, tp->snd_ssthresh);
 
@@ -417,7 +417,7 @@ EXPORT_SYMBOL_GPL(tcp_slow_start);
 /* In theory this is tp->snd_cwnd += 1 / tp->snd_cwnd (or alternative w),
  * for every packet that was ACKed.
  */
-void tcp_cong_avoid_ai(struct tcp_sock *tp, u32 w, u32 acked)
+BPF_KFUNC(void tcp_cong_avoid_ai(struct tcp_sock *tp, u32 w, u32 acked))
 {
 	/* If credits accumulated at a higher w, apply them gently now. */
 	if (tp->snd_cwnd_cnt >= w) {
@@ -443,7 +443,7 @@ EXPORT_SYMBOL_GPL(tcp_cong_avoid_ai);
 /* This is Jacobson's slow start and congestion avoidance.
  * SIGCOMM '88, p. 328.
  */
-void tcp_reno_cong_avoid(struct sock *sk, u32 ack, u32 acked)
+BPF_KFUNC(void tcp_reno_cong_avoid(struct sock *sk, u32 ack, u32 acked))
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
@@ -462,7 +462,7 @@ void tcp_reno_cong_avoid(struct sock *sk, u32 ack, u32 acked)
 EXPORT_SYMBOL_GPL(tcp_reno_cong_avoid);
 
 /* Slow start threshold is half the congestion window (min 2) */
-u32 tcp_reno_ssthresh(struct sock *sk)
+BPF_KFUNC(u32 tcp_reno_ssthresh(struct sock *sk))
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 
@@ -470,7 +470,7 @@ u32 tcp_reno_ssthresh(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(tcp_reno_ssthresh);
 
-u32 tcp_reno_undo_cwnd(struct sock *sk)
+BPF_KFUNC(u32 tcp_reno_undo_cwnd(struct sock *sk))
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 
diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 768c10c1f649..bad9f3adba7f 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -126,7 +126,7 @@ static inline void bictcp_hystart_reset(struct sock *sk)
 	ca->sample_cnt = 0;
 }
 
-static void cubictcp_init(struct sock *sk)
+BPF_KFUNC(static void cubictcp_init(struct sock *sk))
 {
 	struct bictcp *ca = inet_csk_ca(sk);
 
@@ -139,7 +139,7 @@ static void cubictcp_init(struct sock *sk)
 		tcp_sk(sk)->snd_ssthresh = initial_ssthresh;
 }
 
-static void cubictcp_cwnd_event(struct sock *sk, enum tcp_ca_event event)
+BPF_KFUNC(static void cubictcp_cwnd_event(struct sock *sk, enum tcp_ca_event event))
 {
 	if (event == CA_EVENT_TX_START) {
 		struct bictcp *ca = inet_csk_ca(sk);
@@ -321,7 +321,7 @@ static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
 	ca->cnt = max(ca->cnt, 2U);
 }
 
-static void cubictcp_cong_avoid(struct sock *sk, u32 ack, u32 acked)
+BPF_KFUNC(static void cubictcp_cong_avoid(struct sock *sk, u32 ack, u32 acked))
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct bictcp *ca = inet_csk_ca(sk);
@@ -338,7 +338,7 @@ static void cubictcp_cong_avoid(struct sock *sk, u32 ack, u32 acked)
 	tcp_cong_avoid_ai(tp, ca->cnt, acked);
 }
 
-static u32 cubictcp_recalc_ssthresh(struct sock *sk)
+BPF_KFUNC(static u32 cubictcp_recalc_ssthresh(struct sock *sk))
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 	struct bictcp *ca = inet_csk_ca(sk);
@@ -355,7 +355,7 @@ static u32 cubictcp_recalc_ssthresh(struct sock *sk)
 	return max((tcp_snd_cwnd(tp) * beta) / BICTCP_BETA_SCALE, 2U);
 }
 
-static void cubictcp_state(struct sock *sk, u8 new_state)
+BPF_KFUNC(static void cubictcp_state(struct sock *sk, u8 new_state))
 {
 	if (new_state == TCP_CA_Loss) {
 		bictcp_reset(inet_csk_ca(sk));
@@ -445,7 +445,7 @@ static void hystart_update(struct sock *sk, u32 delay)
 	}
 }
 
-static void cubictcp_acked(struct sock *sk, const struct ack_sample *sample)
+BPF_KFUNC(static void cubictcp_acked(struct sock *sk, const struct ack_sample *sample))
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 	struct bictcp *ca = inet_csk_ca(sk);
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index e0a2ca7456ff..3748099f014e 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -75,7 +75,7 @@ static void dctcp_reset(const struct tcp_sock *tp, struct dctcp *ca)
 	ca->old_delivered_ce = tp->delivered_ce;
 }
 
-static void dctcp_init(struct sock *sk)
+BPF_KFUNC(static void dctcp_init(struct sock *sk))
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 
@@ -104,7 +104,7 @@ static void dctcp_init(struct sock *sk)
 	INET_ECN_dontxmit(sk);
 }
 
-static u32 dctcp_ssthresh(struct sock *sk)
+BPF_KFUNC(static u32 dctcp_ssthresh(struct sock *sk))
 {
 	struct dctcp *ca = inet_csk_ca(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -113,7 +113,7 @@ static u32 dctcp_ssthresh(struct sock *sk)
 	return max(tcp_snd_cwnd(tp) - ((tcp_snd_cwnd(tp) * ca->dctcp_alpha) >> 11U), 2U);
 }
 
-static void dctcp_update_alpha(struct sock *sk, u32 flags)
+BPF_KFUNC(static void dctcp_update_alpha(struct sock *sk, u32 flags))
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 	struct dctcp *ca = inet_csk_ca(sk);
@@ -169,7 +169,7 @@ static void dctcp_react_to_loss(struct sock *sk)
 	tp->snd_ssthresh = max(tcp_snd_cwnd(tp) >> 1U, 2U);
 }
 
-static void dctcp_state(struct sock *sk, u8 new_state)
+BPF_KFUNC(static void dctcp_state(struct sock *sk, u8 new_state))
 {
 	if (new_state == TCP_CA_Recovery &&
 	    new_state != inet_csk(sk)->icsk_ca_state)
@@ -179,7 +179,7 @@ static void dctcp_state(struct sock *sk, u8 new_state)
 	 */
 }
 
-static void dctcp_cwnd_event(struct sock *sk, enum tcp_ca_event ev)
+BPF_KFUNC(static void dctcp_cwnd_event(struct sock *sk, enum tcp_ca_event ev))
 {
 	struct dctcp *ca = inet_csk_ca(sk);
 
@@ -229,7 +229,7 @@ static size_t dctcp_get_info(struct sock *sk, u32 ext, int *attr,
 	return 0;
 }
 
-static u32 dctcp_cwnd_undo(struct sock *sk)
+BPF_KFUNC(static u32 dctcp_cwnd_undo(struct sock *sk))
 {
 	const struct dctcp *ca = inet_csk_ca(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index 24002bc61e07..5512c8f563a7 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -230,10 +230,6 @@ static int _nf_conntrack_btf_struct_access(struct bpf_verifier_log *log,
 	return 0;
 }
 
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "Global functions as their definitions will be in nf_conntrack BTF");
-
 /* bpf_xdp_ct_alloc - Allocate a new CT entry
  *
  * Parameters:
@@ -249,9 +245,9 @@ __diag_ignore_all("-Wmissing-prototypes",
  * @opts__sz	- Length of the bpf_ct_opts structure
  *		    Must be NF_BPF_CT_OPTS_SZ (12)
  */
-struct nf_conn___init *
+BPF_KFUNC(struct nf_conn___init *
 bpf_xdp_ct_alloc(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
-		 u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
+		 u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz))
 {
 	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
 	struct nf_conn *nfct;
@@ -283,9 +279,9 @@ bpf_xdp_ct_alloc(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
  * @opts__sz	- Length of the bpf_ct_opts structure
  *		    Must be NF_BPF_CT_OPTS_SZ (12)
  */
-struct nf_conn *
+BPF_KFUNC(struct nf_conn *
 bpf_xdp_ct_lookup(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
-		  u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
+		  u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz))
 {
 	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
 	struct net *caller_net;
@@ -316,9 +312,9 @@ bpf_xdp_ct_lookup(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
  * @opts__sz	- Length of the bpf_ct_opts structure
  *		    Must be NF_BPF_CT_OPTS_SZ (12)
  */
-struct nf_conn___init *
+BPF_KFUNC(struct nf_conn___init *
 bpf_skb_ct_alloc(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
-		 u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
+		 u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz))
 {
 	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
 	struct nf_conn *nfct;
@@ -351,9 +347,9 @@ bpf_skb_ct_alloc(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
  * @opts__sz	- Length of the bpf_ct_opts structure
  *		    Must be NF_BPF_CT_OPTS_SZ (12)
  */
-struct nf_conn *
+BPF_KFUNC(struct nf_conn *
 bpf_skb_ct_lookup(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
-		  u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
+		  u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz))
 {
 	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
 	struct net *caller_net;
@@ -376,7 +372,7 @@ bpf_skb_ct_lookup(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
  * @nfct	 - Pointer to referenced nf_conn___init object, obtained
  *		   using bpf_xdp_ct_alloc or bpf_skb_ct_alloc.
  */
-struct nf_conn *bpf_ct_insert_entry(struct nf_conn___init *nfct_i)
+BPF_KFUNC(struct nf_conn *bpf_ct_insert_entry(struct nf_conn___init *nfct_i))
 {
 	struct nf_conn *nfct = (struct nf_conn *)nfct_i;
 	int err;
@@ -400,7 +396,7 @@ struct nf_conn *bpf_ct_insert_entry(struct nf_conn___init *nfct_i)
  * @nf_conn	 - Pointer to referenced nf_conn object, obtained using
  *		   bpf_xdp_ct_lookup or bpf_skb_ct_lookup.
  */
-void bpf_ct_release(struct nf_conn *nfct)
+BPF_KFUNC(void bpf_ct_release(struct nf_conn *nfct))
 {
 	if (!nfct)
 		return;
@@ -417,7 +413,7 @@ void bpf_ct_release(struct nf_conn *nfct)
  *                 bpf_xdp_ct_alloc or bpf_skb_ct_alloc.
  * @timeout      - Timeout in msecs.
  */
-void bpf_ct_set_timeout(struct nf_conn___init *nfct, u32 timeout)
+BPF_KFUNC(void bpf_ct_set_timeout(struct nf_conn___init *nfct, u32 timeout))
 {
 	__nf_ct_set_timeout((struct nf_conn *)nfct, msecs_to_jiffies(timeout));
 }
@@ -432,7 +428,7 @@ void bpf_ct_set_timeout(struct nf_conn___init *nfct, u32 timeout)
  *		   bpf_ct_insert_entry, bpf_xdp_ct_lookup, or bpf_skb_ct_lookup.
  * @timeout      - New timeout in msecs.
  */
-int bpf_ct_change_timeout(struct nf_conn *nfct, u32 timeout)
+BPF_KFUNC(int bpf_ct_change_timeout(struct nf_conn *nfct, u32 timeout))
 {
 	return __nf_ct_change_timeout(nfct, msecs_to_jiffies(timeout));
 }
@@ -447,7 +443,7 @@ int bpf_ct_change_timeout(struct nf_conn *nfct, u32 timeout)
  *		   bpf_xdp_ct_alloc or bpf_skb_ct_alloc.
  * @status       - New status value.
  */
-int bpf_ct_set_status(const struct nf_conn___init *nfct, u32 status)
+BPF_KFUNC(int bpf_ct_set_status(const struct nf_conn___init *nfct, u32 status))
 {
 	return nf_ct_change_status_common((struct nf_conn *)nfct, status);
 }
@@ -462,13 +458,11 @@ int bpf_ct_set_status(const struct nf_conn___init *nfct, u32 status)
  *		   bpf_ct_insert_entry, bpf_xdp_ct_lookup or bpf_skb_ct_lookup.
  * @status       - New status value.
  */
-int bpf_ct_change_status(struct nf_conn *nfct, u32 status)
+BPF_KFUNC(int bpf_ct_change_status(struct nf_conn *nfct, u32 status))
 {
 	return nf_ct_change_status_common(nfct, status);
 }
 
-__diag_pop()
-
 BTF_SET8_START(nf_ct_kfunc_set)
 BTF_ID_FLAGS(func, bpf_xdp_ct_alloc, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_xdp_ct_lookup, KF_ACQUIRE | KF_RET_NULL)
diff --git a/net/netfilter/nf_nat_bpf.c b/net/netfilter/nf_nat_bpf.c
index 0fa5a0bbb0ff..8de652043819 100644
--- a/net/netfilter/nf_nat_bpf.c
+++ b/net/netfilter/nf_nat_bpf.c
@@ -12,10 +12,6 @@
 #include <net/netfilter/nf_conntrack_core.h>
 #include <net/netfilter/nf_nat.h>
 
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "Global functions as their definitions will be in nf_nat BTF");
-
 /* bpf_ct_set_nat_info - Set source or destination nat address
  *
  * Set source or destination nat address of the newly allocated
@@ -30,9 +26,9 @@ __diag_ignore_all("-Wmissing-prototypes",
  *		  interpreted as select a random port.
  * @manip	- NF_NAT_MANIP_SRC or NF_NAT_MANIP_DST
  */
-int bpf_ct_set_nat_info(struct nf_conn___init *nfct,
-			union nf_inet_addr *addr, int port,
-			enum nf_nat_manip_type manip)
+BPF_KFUNC(int bpf_ct_set_nat_info(struct nf_conn___init *nfct,
+				  union nf_inet_addr *addr, int port,
+				  enum nf_nat_manip_type manip))
 {
 	struct nf_conn *ct = (struct nf_conn *)nfct;
 	u16 proto = nf_ct_l3num(ct);
@@ -54,8 +50,6 @@ int bpf_ct_set_nat_info(struct nf_conn___init *nfct,
 	return nf_nat_setup_info(ct, &range, manip) == NF_DROP ? -ENOMEM : 0;
 }
 
-__diag_pop()
-
 BTF_SET8_START(nf_nat_kfunc_set)
 BTF_ID_FLAGS(func, bpf_ct_set_nat_info, KF_TRUSTED_ARGS)
 BTF_SET8_END(nf_nat_kfunc_set)
diff --git a/net/xfrm/xfrm_interface_bpf.c b/net/xfrm/xfrm_interface_bpf.c
index 1ef2162cebcf..b2b2ae603e4d 100644
--- a/net/xfrm/xfrm_interface_bpf.c
+++ b/net/xfrm/xfrm_interface_bpf.c
@@ -27,10 +27,6 @@ struct bpf_xfrm_info {
 	int link;
 };
 
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "Global functions as their definitions will be in xfrm_interface BTF");
-
 /* bpf_skb_get_xfrm_info - Get XFRM metadata
  *
  * Parameters:
@@ -39,8 +35,7 @@ __diag_ignore_all("-Wmissing-prototypes",
  * @to		- Pointer to memory to which the metadata will be copied
  *		    Cannot be NULL
  */
-__used noinline
-int bpf_skb_get_xfrm_info(struct __sk_buff *skb_ctx, struct bpf_xfrm_info *to)
+BPF_KFUNC(int bpf_skb_get_xfrm_info(struct __sk_buff *skb_ctx, struct bpf_xfrm_info *to))
 {
 	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
 	struct xfrm_md_info *info;
@@ -62,9 +57,8 @@ int bpf_skb_get_xfrm_info(struct __sk_buff *skb_ctx, struct bpf_xfrm_info *to)
  * @from	- Pointer to memory from which the metadata will be copied
  *		    Cannot be NULL
  */
-__used noinline
-int bpf_skb_set_xfrm_info(struct __sk_buff *skb_ctx,
-			  const struct bpf_xfrm_info *from)
+BPF_KFUNC(int bpf_skb_set_xfrm_info(struct __sk_buff *skb_ctx,
+				    const struct bpf_xfrm_info *from))
 {
 	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
 	struct metadata_dst *md_dst;
@@ -96,8 +90,6 @@ int bpf_skb_set_xfrm_info(struct __sk_buff *skb_ctx,
 	return 0;
 }
 
-__diag_pop()
-
 BTF_SET8_START(xfrm_ifc_kfunc_set)
 BTF_ID_FLAGS(func, bpf_skb_get_xfrm_info)
 BTF_ID_FLAGS(func, bpf_skb_set_xfrm_info)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 5085fea3cac5..9392e5e406ec 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -59,8 +59,7 @@ bpf_testmod_test_struct_arg_5(void) {
 	return bpf_testmod_test_struct_arg_result;
 }
 
-noinline void
-bpf_testmod_test_mod_kfunc(int i)
+BPF_KFUNC(void bpf_testmod_test_mod_kfunc(int i))
 {
 	*(int *)this_cpu_ptr(&bpf_testmod_ksym_percpu) = i;
 }
-- 
2.39.0

