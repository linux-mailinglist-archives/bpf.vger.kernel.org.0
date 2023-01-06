Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A6F660768
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 20:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbjAFTwg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 14:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbjAFTwF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 14:52:05 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3E381C19;
        Fri,  6 Jan 2023 11:52:00 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id t7so1667375qvv.3;
        Fri, 06 Jan 2023 11:52:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIbjYpEwH3yWIQxI6P8WOY68Cya+BwvZ/FljHiUEV/I=;
        b=Z02DfErtgYNsv81fHumHH1CniUXY8noGi0bGrjvrIcaGAGKoIIkvxtAwPHWbYW/28D
         TQaARpZ5skbugC2mzZAKsJhpQlJGqq+kLdRfWzgcNZP7ySYe41xYyL08f2IaKbZszYiJ
         5/LRGuB2HKXNdjWJuefN1WoclrQuujCFyyi/1Sn1er4m5YSQlX7PWS2HmoiDCTWCo9b8
         LQxTECFa0zSI9j7rOVlF4CiavmNP9BTMJpejt/Nrf6Y+l1gsUOs3v0V7A6exwBdWt3cD
         OYMeKwWY5FPNPnVtQBVl5qYu3ixxLNdb5Ro9dIZ4qmezndH7slzas+qFAiAZP10RUYA/
         otEA==
X-Gm-Message-State: AFqh2krUaJDYABZJkBmJhcP05UGcnsAZgfvKRR+n+9fAV+wARIVe9i63
        KKSf9kt0Pay/IZvjluwe8W4JHEUveNf3oDUr
X-Google-Smtp-Source: AMrXdXvPgJ0kOGyC9Ko0dM2+pAgyuHhM3yiP7isCqy/Rn16EGxk5a0prIqM/ebuE9LtaAwW+NsY1ug==
X-Received: by 2002:a0c:e107:0:b0:532:23a5:8271 with SMTP id w7-20020a0ce107000000b0053223a58271mr237383qvk.8.1673034719390;
        Fri, 06 Jan 2023 11:51:59 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:a6f6])
        by smtp.gmail.com with ESMTPSA id y15-20020a05620a0e0f00b006f7ee901674sm1012380qkm.2.2023.01.06.11.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 11:51:59 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 3/3] bpf: Add __bpf_kfunc tag to all kfuncs
Date:   Fri,  6 Jan 2023 13:51:32 -0600
Message-Id: <20230106195130.1216841-4-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106195130.1216841-1-void@manifault.com>
References: <20230106195130.1216841-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that we have the __bpf_kfunc tag, we should use add it to all
existing kfuncs to ensure that they'll never be elided in LTO builds.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/helpers.c                          | 19 +++++
 kernel/cgroup/rstat.c                         |  2 +
 kernel/kexec_core.c                           |  2 +
 kernel/trace/bpf_trace.c                      |  4 +
 net/bpf/test_run.c                            | 76 ++++++++++++-------
 net/ipv4/tcp_bbr.c                            |  8 ++
 net/ipv4/tcp_cong.c                           |  5 ++
 net/ipv4/tcp_cubic.c                          |  6 ++
 net/ipv4/tcp_dctcp.c                          |  6 ++
 net/netfilter/nf_conntrack_bpf.c              | 14 +++-
 net/netfilter/nf_nat_bpf.c                    |  1 +
 net/xfrm/xfrm_interface_bpf.c                 |  4 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  2 +-
 13 files changed, 116 insertions(+), 33 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 458db2db2f81..2c1ea42194e0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1776,6 +1776,7 @@ __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in vmlinux BTF");
 
+__bpf_kfunc
 void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
 {
 	struct btf_struct_meta *meta = meta__ign;
@@ -1790,6 +1791,7 @@ void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
 	return p;
 }
 
+__bpf_kfunc
 void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
 {
 	struct btf_struct_meta *meta = meta__ign;
@@ -1811,11 +1813,13 @@ static void __bpf_list_add(struct bpf_list_node *node, struct bpf_list_head *hea
 	tail ? list_add_tail(n, h) : list_add(n, h);
 }
 
+__bpf_kfunc
 void bpf_list_push_front(struct bpf_list_head *head, struct bpf_list_node *node)
 {
 	return __bpf_list_add(node, head, false);
 }
 
+__bpf_kfunc
 void bpf_list_push_back(struct bpf_list_head *head, struct bpf_list_node *node)
 {
 	return __bpf_list_add(node, head, true);
@@ -1834,11 +1838,13 @@ static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, bool tai
 	return (struct bpf_list_node *)n;
 }
 
+__bpf_kfunc
 struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head)
 {
 	return __bpf_list_del(head, false);
 }
 
+__bpf_kfunc
 struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
 {
 	return __bpf_list_del(head, true);
@@ -1850,6 +1856,7 @@ struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
  * bpf_task_release().
  * @p: The task on which a reference is being acquired.
  */
+__bpf_kfunc
 struct task_struct *bpf_task_acquire(struct task_struct *p)
 {
 	return get_task_struct(p);
@@ -1861,6 +1868,7 @@ struct task_struct *bpf_task_acquire(struct task_struct *p)
  * released by calling bpf_task_release().
  * @p: The task on which a reference is being acquired.
  */
+__bpf_kfunc
 struct task_struct *bpf_task_acquire_not_zero(struct task_struct *p)
 {
 	/* For the time being this function returns NULL, as it's not currently
@@ -1913,6 +1921,7 @@ struct task_struct *bpf_task_acquire_not_zero(struct task_struct *p)
  * be released by calling bpf_task_release().
  * @pp: A pointer to a task kptr on which a reference is being acquired.
  */
+__bpf_kfunc
 struct task_struct *bpf_task_kptr_get(struct task_struct **pp)
 {
 	/* We must return NULL here until we have clarity on how to properly
@@ -1926,6 +1935,7 @@ struct task_struct *bpf_task_kptr_get(struct task_struct **pp)
  * bpf_task_release - Release the reference acquired on a task.
  * @p: The task on which a reference is being released.
  */
+__bpf_kfunc
 void bpf_task_release(struct task_struct *p)
 {
 	if (!p)
@@ -1941,6 +1951,7 @@ void bpf_task_release(struct task_struct *p)
  * calling bpf_cgroup_release().
  * @cgrp: The cgroup on which a reference is being acquired.
  */
+__bpf_kfunc
 struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp)
 {
 	cgroup_get(cgrp);
@@ -1953,6 +1964,7 @@ struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp)
  * be released by calling bpf_cgroup_release().
  * @cgrpp: A pointer to a cgroup kptr on which a reference is being acquired.
  */
+__bpf_kfunc
 struct cgroup *bpf_cgroup_kptr_get(struct cgroup **cgrpp)
 {
 	struct cgroup *cgrp;
@@ -1985,6 +1997,7 @@ struct cgroup *bpf_cgroup_kptr_get(struct cgroup **cgrpp)
  * drops to 0.
  * @cgrp: The cgroup on which a reference is being released.
  */
+__bpf_kfunc
 void bpf_cgroup_release(struct cgroup *cgrp)
 {
 	if (!cgrp)
@@ -2000,6 +2013,7 @@ void bpf_cgroup_release(struct cgroup *cgrp)
  * @cgrp: The cgroup for which we're performing a lookup.
  * @level: The level of ancestor to look up.
  */
+__bpf_kfunc
 struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level)
 {
 	struct cgroup *ancestor;
@@ -2019,6 +2033,7 @@ struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level)
  * stored in a map, or released with bpf_task_release().
  * @pid: The pid of the task being looked up.
  */
+__bpf_kfunc
 struct task_struct *bpf_task_from_pid(s32 pid)
 {
 	struct task_struct *p;
@@ -2032,21 +2047,25 @@ struct task_struct *bpf_task_from_pid(s32 pid)
 	return p;
 }
 
+__bpf_kfunc
 void *bpf_cast_to_kern_ctx(void *obj)
 {
 	return obj;
 }
 
+__bpf_kfunc
 void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k)
 {
 	return obj__ign;
 }
 
+__bpf_kfunc
 void bpf_rcu_read_lock(void)
 {
 	rcu_read_lock();
 }
 
+__bpf_kfunc
 void bpf_rcu_read_unlock(void)
 {
 	rcu_read_unlock();
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 793ecff29038..4fae7f81b5cf 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -26,6 +26,7 @@ static struct cgroup_rstat_cpu *cgroup_rstat_cpu(struct cgroup *cgrp, int cpu)
  * rstat_cpu->updated_children list.  See the comment on top of
  * cgroup_rstat_cpu definition for details.
  */
+__bpf_kfunc
 void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 {
 	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
@@ -231,6 +232,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
  *
  * This function may block.
  */
+__bpf_kfunc
 void cgroup_rstat_flush(struct cgroup *cgrp)
 {
 	might_sleep();
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 969e8f52f7da..1784795f6f72 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -6,6 +6,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/btf.h>
 #include <linux/capability.h>
 #include <linux/mm.h>
 #include <linux/file.h>
@@ -975,6 +976,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
 }
 STACK_FRAME_NON_STANDARD(__crash_kexec);
 
+__bpf_kfunc
 void crash_kexec(struct pt_regs *regs)
 {
 	int old_cpu, this_cpu;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 23ce498bca97..2fe9a549b30f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1233,6 +1233,7 @@ __diag_ignore_all("-Wmissing-prototypes",
  * Return: a bpf_key pointer with a valid key pointer if the key is found, a
  *         NULL pointer otherwise.
  */
+__bpf_kfunc
 struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)
 {
 	key_ref_t key_ref;
@@ -1282,6 +1283,7 @@ struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)
  * Return: a bpf_key pointer with an invalid key pointer set from the
  *         pre-determined ID on success, a NULL pointer otherwise
  */
+__bpf_kfunc
 struct bpf_key *bpf_lookup_system_key(u64 id)
 {
 	struct bpf_key *bkey;
@@ -1306,6 +1308,7 @@ struct bpf_key *bpf_lookup_system_key(u64 id)
  * Decrement the reference count of the key inside *bkey*, if the pointer
  * is valid, and free *bkey*.
  */
+__bpf_kfunc
 void bpf_key_put(struct bpf_key *bkey)
 {
 	if (bkey->has_ref)
@@ -1326,6 +1329,7 @@ void bpf_key_put(struct bpf_key *bkey)
  *
  * Return: 0 on success, a negative value on error.
  */
+__bpf_kfunc
 int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
 			       struct bpf_dynptr_kern *sig_ptr,
 			       struct bpf_key *trusted_keyring)
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 2723623429ac..0e6d7c5379d5 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -484,7 +484,8 @@ static int bpf_test_finish(const union bpf_attr *kattr,
 __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in vmlinux BTF");
-int noinline bpf_fentry_test1(int a)
+__bpf_kfunc
+int bpf_fentry_test1(int a)
 {
 	return a + 1;
 }
@@ -529,23 +530,27 @@ int noinline bpf_fentry_test8(struct bpf_fentry_test_t *arg)
 	return (long)arg->a;
 }
 
-int noinline bpf_modify_return_test(int a, int *b)
+__bpf_kfunc
+int bpf_modify_return_test(int a, int *b)
 {
 	*b += 1;
 	return a + *b;
 }
 
-u64 noinline bpf_kfunc_call_test1(struct sock *sk, u32 a, u64 b, u32 c, u64 d)
+__bpf_kfunc
+u64 bpf_kfunc_call_test1(struct sock *sk, u32 a, u64 b, u32 c, u64 d)
 {
 	return a + b + c + d;
 }
 
-int noinline bpf_kfunc_call_test2(struct sock *sk, u32 a, u32 b)
+__bpf_kfunc
+int bpf_kfunc_call_test2(struct sock *sk, u32 a, u32 b)
 {
 	return a + b;
 }
 
-struct sock * noinline bpf_kfunc_call_test3(struct sock *sk)
+__bpf_kfunc
+struct sock *bpf_kfunc_call_test3(struct sock *sk)
 {
 	return sk;
 }
@@ -574,21 +579,22 @@ static struct prog_test_ref_kfunc prog_test_struct = {
 	.cnt = REFCOUNT_INIT(1),
 };
 
-noinline struct prog_test_ref_kfunc *
+__bpf_kfunc struct prog_test_ref_kfunc *
 bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr)
 {
 	refcount_inc(&prog_test_struct.cnt);
 	return &prog_test_struct;
 }
 
-noinline struct prog_test_member *
+__bpf_kfunc struct prog_test_member *
 bpf_kfunc_call_memb_acquire(void)
 {
 	WARN_ON_ONCE(1);
 	return NULL;
 }
 
-noinline void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
+__bpf_kfunc
+void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
 {
 	if (!p)
 		return;
@@ -596,11 +602,13 @@ noinline void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
 	refcount_dec(&p->cnt);
 }
 
-noinline void bpf_kfunc_call_memb_release(struct prog_test_member *p)
+__bpf_kfunc
+void bpf_kfunc_call_memb_release(struct prog_test_member *p)
 {
 }
 
-noinline void bpf_kfunc_call_memb1_release(struct prog_test_member1 *p)
+__bpf_kfunc
+void bpf_kfunc_call_memb1_release(struct prog_test_member1 *p)
 {
 	WARN_ON_ONCE(1);
 }
@@ -613,12 +621,14 @@ static int *__bpf_kfunc_call_test_get_mem(struct prog_test_ref_kfunc *p, const i
 	return (int *)p;
 }
 
-noinline int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size)
+__bpf_kfunc
+int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size)
 {
 	return __bpf_kfunc_call_test_get_mem(p, rdwr_buf_size);
 }
 
-noinline int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size)
+__bpf_kfunc
+int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size)
 {
 	return __bpf_kfunc_call_test_get_mem(p, rdonly_buf_size);
 }
@@ -628,16 +638,19 @@ noinline int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p,
  * Acquire functions must return struct pointers, so these ones are
  * failing.
  */
-noinline int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size)
+__bpf_kfunc
+int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size)
 {
 	return __bpf_kfunc_call_test_get_mem(p, rdonly_buf_size);
 }
 
-noinline void bpf_kfunc_call_int_mem_release(int *p)
+__bpf_kfunc
+void bpf_kfunc_call_int_mem_release(int *p)
 {
 }
 
-noinline struct prog_test_ref_kfunc *
+__bpf_kfunc
+struct prog_test_ref_kfunc *
 bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **pp, int a, int b)
 {
 	struct prog_test_ref_kfunc *p = READ_ONCE(*pp);
@@ -686,47 +699,58 @@ struct prog_test_fail3 {
 	char arr2[];
 };
 
-noinline void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb)
+__bpf_kfunc
+void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb)
 {
 }
 
-noinline void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p)
+__bpf_kfunc
+void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p)
 {
 }
 
-noinline void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p)
+__bpf_kfunc
+void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p)
 {
 }
 
-noinline void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p)
+__bpf_kfunc
+void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p)
 {
 }
 
-noinline void bpf_kfunc_call_test_fail2(struct prog_test_fail2 *p)
+__bpf_kfunc
+void bpf_kfunc_call_test_fail2(struct prog_test_fail2 *p)
 {
 }
 
-noinline void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p)
+__bpf_kfunc
+void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p)
 {
 }
 
-noinline void bpf_kfunc_call_test_mem_len_pass1(void *mem, int mem__sz)
+__bpf_kfunc
+void bpf_kfunc_call_test_mem_len_pass1(void *mem, int mem__sz)
 {
 }
 
-noinline void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len)
+__bpf_kfunc
+void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len)
 {
 }
 
-noinline void bpf_kfunc_call_test_mem_len_fail2(u64 *mem, int len)
+__bpf_kfunc
+void bpf_kfunc_call_test_mem_len_fail2(u64 *mem, int len)
 {
 }
 
-noinline void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p)
+__bpf_kfunc
+void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p)
 {
 }
 
-noinline void bpf_kfunc_call_test_destructive(void)
+__bpf_kfunc
+void bpf_kfunc_call_test_destructive(void)
 {
 }
 
diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
index d2c470524e58..f6a0c155e64d 100644
--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -295,6 +295,7 @@ static void bbr_set_pacing_rate(struct sock *sk, u32 bw, int gain)
 }
 
 /* override sysctl_tcp_min_tso_segs */
+__bpf_kfunc
 static u32 bbr_min_tso_segs(struct sock *sk)
 {
 	return sk->sk_pacing_rate < (bbr_min_tso_rate >> 3) ? 1 : 2;
@@ -328,6 +329,7 @@ static void bbr_save_cwnd(struct sock *sk)
 		bbr->prior_cwnd = max(bbr->prior_cwnd, tcp_snd_cwnd(tp));
 }
 
+__bpf_kfunc
 static void bbr_cwnd_event(struct sock *sk, enum tcp_ca_event event)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -1023,6 +1025,7 @@ static void bbr_update_model(struct sock *sk, const struct rate_sample *rs)
 	bbr_update_gains(sk);
 }
 
+__bpf_kfunc
 static void bbr_main(struct sock *sk, const struct rate_sample *rs)
 {
 	struct bbr *bbr = inet_csk_ca(sk);
@@ -1035,6 +1038,7 @@ static void bbr_main(struct sock *sk, const struct rate_sample *rs)
 	bbr_set_cwnd(sk, rs, rs->acked_sacked, bw, bbr->cwnd_gain);
 }
 
+__bpf_kfunc
 static void bbr_init(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -1077,6 +1081,7 @@ static void bbr_init(struct sock *sk)
 	cmpxchg(&sk->sk_pacing_status, SK_PACING_NONE, SK_PACING_NEEDED);
 }
 
+__bpf_kfunc
 static u32 bbr_sndbuf_expand(struct sock *sk)
 {
 	/* Provision 3 * cwnd since BBR may slow-start even during recovery. */
@@ -1086,6 +1091,7 @@ static u32 bbr_sndbuf_expand(struct sock *sk)
 /* In theory BBR does not need to undo the cwnd since it does not
  * always reduce cwnd on losses (see bbr_main()). Keep it for now.
  */
+__bpf_kfunc
 static u32 bbr_undo_cwnd(struct sock *sk)
 {
 	struct bbr *bbr = inet_csk_ca(sk);
@@ -1097,6 +1103,7 @@ static u32 bbr_undo_cwnd(struct sock *sk)
 }
 
 /* Entering loss recovery, so save cwnd for when we exit or undo recovery. */
+__bpf_kfunc
 static u32 bbr_ssthresh(struct sock *sk)
 {
 	bbr_save_cwnd(sk);
@@ -1125,6 +1132,7 @@ static size_t bbr_get_info(struct sock *sk, u32 ext, int *attr,
 	return 0;
 }
 
+__bpf_kfunc
 static void bbr_set_state(struct sock *sk, u8 new_state)
 {
 	struct bbr *bbr = inet_csk_ca(sk);
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index d3cae40749e8..dbdb22c84462 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -403,6 +403,7 @@ int tcp_set_congestion_control(struct sock *sk, const char *name, bool load,
  * ABC caps N to 2. Slow start exits when cwnd grows over ssthresh and
  * returns the leftover acks to adjust cwnd in congestion avoidance mode.
  */
+__bpf_kfunc
 u32 tcp_slow_start(struct tcp_sock *tp, u32 acked)
 {
 	u32 cwnd = min(tcp_snd_cwnd(tp) + acked, tp->snd_ssthresh);
@@ -417,6 +418,7 @@ EXPORT_SYMBOL_GPL(tcp_slow_start);
 /* In theory this is tp->snd_cwnd += 1 / tp->snd_cwnd (or alternative w),
  * for every packet that was ACKed.
  */
+__bpf_kfunc
 void tcp_cong_avoid_ai(struct tcp_sock *tp, u32 w, u32 acked)
 {
 	/* If credits accumulated at a higher w, apply them gently now. */
@@ -443,6 +445,7 @@ EXPORT_SYMBOL_GPL(tcp_cong_avoid_ai);
 /* This is Jacobson's slow start and congestion avoidance.
  * SIGCOMM '88, p. 328.
  */
+__bpf_kfunc
 void tcp_reno_cong_avoid(struct sock *sk, u32 ack, u32 acked)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -462,6 +465,7 @@ void tcp_reno_cong_avoid(struct sock *sk, u32 ack, u32 acked)
 EXPORT_SYMBOL_GPL(tcp_reno_cong_avoid);
 
 /* Slow start threshold is half the congestion window (min 2) */
+__bpf_kfunc
 u32 tcp_reno_ssthresh(struct sock *sk)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
@@ -470,6 +474,7 @@ u32 tcp_reno_ssthresh(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(tcp_reno_ssthresh);
 
+__bpf_kfunc
 u32 tcp_reno_undo_cwnd(struct sock *sk)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 768c10c1f649..c958d6c97b2e 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -126,6 +126,7 @@ static inline void bictcp_hystart_reset(struct sock *sk)
 	ca->sample_cnt = 0;
 }
 
+__bpf_kfunc
 static void cubictcp_init(struct sock *sk)
 {
 	struct bictcp *ca = inet_csk_ca(sk);
@@ -139,6 +140,7 @@ static void cubictcp_init(struct sock *sk)
 		tcp_sk(sk)->snd_ssthresh = initial_ssthresh;
 }
 
+__bpf_kfunc
 static void cubictcp_cwnd_event(struct sock *sk, enum tcp_ca_event event)
 {
 	if (event == CA_EVENT_TX_START) {
@@ -321,6 +323,7 @@ static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
 	ca->cnt = max(ca->cnt, 2U);
 }
 
+__bpf_kfunc
 static void cubictcp_cong_avoid(struct sock *sk, u32 ack, u32 acked)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -338,6 +341,7 @@ static void cubictcp_cong_avoid(struct sock *sk, u32 ack, u32 acked)
 	tcp_cong_avoid_ai(tp, ca->cnt, acked);
 }
 
+__bpf_kfunc
 static u32 cubictcp_recalc_ssthresh(struct sock *sk)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
@@ -355,6 +359,7 @@ static u32 cubictcp_recalc_ssthresh(struct sock *sk)
 	return max((tcp_snd_cwnd(tp) * beta) / BICTCP_BETA_SCALE, 2U);
 }
 
+__bpf_kfunc
 static void cubictcp_state(struct sock *sk, u8 new_state)
 {
 	if (new_state == TCP_CA_Loss) {
@@ -445,6 +450,7 @@ static void hystart_update(struct sock *sk, u32 delay)
 	}
 }
 
+__bpf_kfunc
 static void cubictcp_acked(struct sock *sk, const struct ack_sample *sample)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index e0a2ca7456ff..d2d8e1690d40 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -75,6 +75,7 @@ static void dctcp_reset(const struct tcp_sock *tp, struct dctcp *ca)
 	ca->old_delivered_ce = tp->delivered_ce;
 }
 
+__bpf_kfunc
 static void dctcp_init(struct sock *sk)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
@@ -104,6 +105,7 @@ static void dctcp_init(struct sock *sk)
 	INET_ECN_dontxmit(sk);
 }
 
+__bpf_kfunc
 static u32 dctcp_ssthresh(struct sock *sk)
 {
 	struct dctcp *ca = inet_csk_ca(sk);
@@ -113,6 +115,7 @@ static u32 dctcp_ssthresh(struct sock *sk)
 	return max(tcp_snd_cwnd(tp) - ((tcp_snd_cwnd(tp) * ca->dctcp_alpha) >> 11U), 2U);
 }
 
+__bpf_kfunc
 static void dctcp_update_alpha(struct sock *sk, u32 flags)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
@@ -169,6 +172,7 @@ static void dctcp_react_to_loss(struct sock *sk)
 	tp->snd_ssthresh = max(tcp_snd_cwnd(tp) >> 1U, 2U);
 }
 
+__bpf_kfunc
 static void dctcp_state(struct sock *sk, u8 new_state)
 {
 	if (new_state == TCP_CA_Recovery &&
@@ -179,6 +183,7 @@ static void dctcp_state(struct sock *sk, u8 new_state)
 	 */
 }
 
+__bpf_kfunc
 static void dctcp_cwnd_event(struct sock *sk, enum tcp_ca_event ev)
 {
 	struct dctcp *ca = inet_csk_ca(sk);
@@ -229,6 +234,7 @@ static size_t dctcp_get_info(struct sock *sk, u32 ext, int *attr,
 	return 0;
 }
 
+__bpf_kfunc
 static u32 dctcp_cwnd_undo(struct sock *sk)
 {
 	const struct dctcp *ca = inet_csk_ca(sk);
diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index 24002bc61e07..344a0659963e 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -249,7 +249,7 @@ __diag_ignore_all("-Wmissing-prototypes",
  * @opts__sz	- Length of the bpf_ct_opts structure
  *		    Must be NF_BPF_CT_OPTS_SZ (12)
  */
-struct nf_conn___init *
+__bpf_kfunc struct nf_conn___init *
 bpf_xdp_ct_alloc(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
 		 u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
 {
@@ -283,7 +283,7 @@ bpf_xdp_ct_alloc(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
  * @opts__sz	- Length of the bpf_ct_opts structure
  *		    Must be NF_BPF_CT_OPTS_SZ (12)
  */
-struct nf_conn *
+__bpf_kfunc struct nf_conn *
 bpf_xdp_ct_lookup(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
 		  u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
 {
@@ -316,7 +316,7 @@ bpf_xdp_ct_lookup(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
  * @opts__sz	- Length of the bpf_ct_opts structure
  *		    Must be NF_BPF_CT_OPTS_SZ (12)
  */
-struct nf_conn___init *
+__bpf_kfunc struct nf_conn___init *
 bpf_skb_ct_alloc(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
 		 u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
 {
@@ -351,7 +351,7 @@ bpf_skb_ct_alloc(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
  * @opts__sz	- Length of the bpf_ct_opts structure
  *		    Must be NF_BPF_CT_OPTS_SZ (12)
  */
-struct nf_conn *
+__bpf_kfunc struct nf_conn *
 bpf_skb_ct_lookup(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
 		  u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
 {
@@ -376,6 +376,7 @@ bpf_skb_ct_lookup(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
  * @nfct	 - Pointer to referenced nf_conn___init object, obtained
  *		   using bpf_xdp_ct_alloc or bpf_skb_ct_alloc.
  */
+__bpf_kfunc
 struct nf_conn *bpf_ct_insert_entry(struct nf_conn___init *nfct_i)
 {
 	struct nf_conn *nfct = (struct nf_conn *)nfct_i;
@@ -400,6 +401,7 @@ struct nf_conn *bpf_ct_insert_entry(struct nf_conn___init *nfct_i)
  * @nf_conn	 - Pointer to referenced nf_conn object, obtained using
  *		   bpf_xdp_ct_lookup or bpf_skb_ct_lookup.
  */
+__bpf_kfunc
 void bpf_ct_release(struct nf_conn *nfct)
 {
 	if (!nfct)
@@ -417,6 +419,7 @@ void bpf_ct_release(struct nf_conn *nfct)
  *                 bpf_xdp_ct_alloc or bpf_skb_ct_alloc.
  * @timeout      - Timeout in msecs.
  */
+__bpf_kfunc
 void bpf_ct_set_timeout(struct nf_conn___init *nfct, u32 timeout)
 {
 	__nf_ct_set_timeout((struct nf_conn *)nfct, msecs_to_jiffies(timeout));
@@ -432,6 +435,7 @@ void bpf_ct_set_timeout(struct nf_conn___init *nfct, u32 timeout)
  *		   bpf_ct_insert_entry, bpf_xdp_ct_lookup, or bpf_skb_ct_lookup.
  * @timeout      - New timeout in msecs.
  */
+__bpf_kfunc
 int bpf_ct_change_timeout(struct nf_conn *nfct, u32 timeout)
 {
 	return __nf_ct_change_timeout(nfct, msecs_to_jiffies(timeout));
@@ -447,6 +451,7 @@ int bpf_ct_change_timeout(struct nf_conn *nfct, u32 timeout)
  *		   bpf_xdp_ct_alloc or bpf_skb_ct_alloc.
  * @status       - New status value.
  */
+__bpf_kfunc
 int bpf_ct_set_status(const struct nf_conn___init *nfct, u32 status)
 {
 	return nf_ct_change_status_common((struct nf_conn *)nfct, status);
@@ -462,6 +467,7 @@ int bpf_ct_set_status(const struct nf_conn___init *nfct, u32 status)
  *		   bpf_ct_insert_entry, bpf_xdp_ct_lookup or bpf_skb_ct_lookup.
  * @status       - New status value.
  */
+__bpf_kfunc
 int bpf_ct_change_status(struct nf_conn *nfct, u32 status)
 {
 	return nf_ct_change_status_common(nfct, status);
diff --git a/net/netfilter/nf_nat_bpf.c b/net/netfilter/nf_nat_bpf.c
index 0fa5a0bbb0ff..6312b257e363 100644
--- a/net/netfilter/nf_nat_bpf.c
+++ b/net/netfilter/nf_nat_bpf.c
@@ -30,6 +30,7 @@ __diag_ignore_all("-Wmissing-prototypes",
  *		  interpreted as select a random port.
  * @manip	- NF_NAT_MANIP_SRC or NF_NAT_MANIP_DST
  */
+__bpf_kfunc
 int bpf_ct_set_nat_info(struct nf_conn___init *nfct,
 			union nf_inet_addr *addr, int port,
 			enum nf_nat_manip_type manip)
diff --git a/net/xfrm/xfrm_interface_bpf.c b/net/xfrm/xfrm_interface_bpf.c
index 1ef2162cebcf..855cf6c75bf3 100644
--- a/net/xfrm/xfrm_interface_bpf.c
+++ b/net/xfrm/xfrm_interface_bpf.c
@@ -39,7 +39,7 @@ __diag_ignore_all("-Wmissing-prototypes",
  * @to		- Pointer to memory to which the metadata will be copied
  *		    Cannot be NULL
  */
-__used noinline
+__bpf_kfunc
 int bpf_skb_get_xfrm_info(struct __sk_buff *skb_ctx, struct bpf_xfrm_info *to)
 {
 	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
@@ -62,7 +62,7 @@ int bpf_skb_get_xfrm_info(struct __sk_buff *skb_ctx, struct bpf_xfrm_info *to)
  * @from	- Pointer to memory from which the metadata will be copied
  *		    Cannot be NULL
  */
-__used noinline
+__bpf_kfunc
 int bpf_skb_set_xfrm_info(struct __sk_buff *skb_ctx,
 			  const struct bpf_xfrm_info *from)
 {
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 5085fea3cac5..46500636d8cd 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -59,7 +59,7 @@ bpf_testmod_test_struct_arg_5(void) {
 	return bpf_testmod_test_struct_arg_result;
 }
 
-noinline void
+__bpf_kfunc void
 bpf_testmod_test_mod_kfunc(int i)
 {
 	*(int *)this_cpu_ptr(&bpf_testmod_ksym_percpu) = i;
-- 
2.39.0

