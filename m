Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13B2686D0D
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 18:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjBARbc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 12:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjBARbC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 12:31:02 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A127D2B2;
        Wed,  1 Feb 2023 09:30:28 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id bb40so10272063qtb.2;
        Wed, 01 Feb 2023 09:30:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZukxnOFiT1bPeuhJu280fQvMeaHPU9vG4bn4ywr+N68=;
        b=n55tT20P4p9zYj4uum6gsrPEbVy71nGzU5YItaOcNI6L2zNkEjESDp7gF67xC48nkH
         O5TWJIbH8AAlxifkE5bKzKRO8P4i/Sh5/OmZqjFtQkX9I7eqYsXVTsY8uviUjfAX8WtH
         +2rrZ83jHIQ8knYdwAmcPgp8PhWJSIBUIhC7xIWuCtg3zEPAgZnoJoss0FXeC5LBgJAg
         oknh71hJy29wABOfYGgbVtHofacfbiV3sjkteJbKt1/naENWMBKfa8SEvt7G1NsPAKjc
         28Zqaslvdm7ZTOA5Nsg3aq9kzxrzrKFO/reVZPwqtLNHzR60veXyhvB+Pey307wg2Axh
         9Lnw==
X-Gm-Message-State: AO0yUKUjOYJOicbmkm0GiiJ7LY7Dgr6E4TG6I30GL7J9+TTJHv/W8X2X
        UfChgCp4jISZYYI9gSDiOKby9fNJsRyMjAN2
X-Google-Smtp-Source: AK7set9cy/Ms9JUV3VUC08Gj3imrVb5tv8rWTfL/wglrq+QQOFjYtHKV2UkcHsieZrYY6DAqOSXKKQ==
X-Received: by 2002:ac8:7d88:0:b0:3b9:9625:df55 with SMTP id c8-20020ac87d88000000b003b99625df55mr4624866qtd.12.1675272626204;
        Wed, 01 Feb 2023 09:30:26 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:1971])
        by smtp.gmail.com with ESMTPSA id o2-20020a05620a110200b0071bfeaf5688sm8389098qkk.72.2023.02.01.09.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 09:30:25 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, corbet@lwn.net, hch@infradead.org,
        acme@kernel.org, alan.maguire@oracle.com
Subject: [PATCH bpf-next v3 3/4] bpf: Add __bpf_kfunc tag to all kfuncs
Date:   Wed,  1 Feb 2023 11:30:15 -0600
Message-Id: <20230201173016.342758-4-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230201173016.342758-1-void@manifault.com>
References: <20230201173016.342758-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that we have the __bpf_kfunc tag, we should use add it to all
existing kfuncs to ensure that they'll never be elided in LTO builds.

Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/cpumask.c                          | 60 +++++++++----------
 kernel/bpf/helpers.c                          | 38 ++++++------
 kernel/cgroup/rstat.c                         |  4 +-
 kernel/kexec_core.c                           |  3 +-
 kernel/trace/bpf_trace.c                      |  8 +--
 net/bpf/test_run.c                            | 55 +++++++++--------
 net/core/xdp.c                                |  5 +-
 net/ipv4/tcp_bbr.c                            | 16 ++---
 net/ipv4/tcp_cong.c                           | 10 ++--
 net/ipv4/tcp_cubic.c                          | 12 ++--
 net/ipv4/tcp_dctcp.c                          | 12 ++--
 net/netfilter/nf_conntrack_bpf.c              | 20 +++----
 net/netfilter/nf_nat_bpf.c                    |  6 +-
 net/xfrm/xfrm_interface_bpf.c                 |  7 +--
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  2 +-
 15 files changed, 130 insertions(+), 128 deletions(-)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 6bbb67dfc998..52b981512a35 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -48,7 +48,7 @@ __diag_ignore_all("-Wmissing-prototypes",
  * bpf_cpumask_create() allocates memory using the BPF memory allocator, and
  * will not block. It may return NULL if no memory is available.
  */
-struct bpf_cpumask *bpf_cpumask_create(void)
+__bpf_kfunc struct bpf_cpumask *bpf_cpumask_create(void)
 {
 	struct bpf_cpumask *cpumask;
 
@@ -74,7 +74,7 @@ struct bpf_cpumask *bpf_cpumask_create(void)
  * must either be embedded in a map as a kptr, or freed with
  * bpf_cpumask_release().
  */
-struct bpf_cpumask *bpf_cpumask_acquire(struct bpf_cpumask *cpumask)
+__bpf_kfunc struct bpf_cpumask *bpf_cpumask_acquire(struct bpf_cpumask *cpumask)
 {
 	refcount_inc(&cpumask->usage);
 	return cpumask;
@@ -90,7 +90,7 @@ struct bpf_cpumask *bpf_cpumask_acquire(struct bpf_cpumask *cpumask)
  * kptr, or freed with bpf_cpumask_release(). This function may return NULL if
  * no BPF cpumask was found in the specified map value.
  */
-struct bpf_cpumask *bpf_cpumask_kptr_get(struct bpf_cpumask **cpumaskp)
+__bpf_kfunc struct bpf_cpumask *bpf_cpumask_kptr_get(struct bpf_cpumask **cpumaskp)
 {
 	struct bpf_cpumask *cpumask;
 
@@ -116,7 +116,7 @@ struct bpf_cpumask *bpf_cpumask_kptr_get(struct bpf_cpumask **cpumaskp)
  * reference of the BPF cpumask has been released, it is subsequently freed in
  * an RCU callback in the BPF memory allocator.
  */
-void bpf_cpumask_release(struct bpf_cpumask *cpumask)
+__bpf_kfunc void bpf_cpumask_release(struct bpf_cpumask *cpumask)
 {
 	if (!cpumask)
 		return;
@@ -135,7 +135,7 @@ void bpf_cpumask_release(struct bpf_cpumask *cpumask)
  * Find the index of the first nonzero bit of the cpumask. A struct bpf_cpumask
  * pointer may be safely passed to this function.
  */
-u32 bpf_cpumask_first(const struct cpumask *cpumask)
+__bpf_kfunc u32 bpf_cpumask_first(const struct cpumask *cpumask)
 {
 	return cpumask_first(cpumask);
 }
@@ -148,7 +148,7 @@ u32 bpf_cpumask_first(const struct cpumask *cpumask)
  * Find the index of the first unset bit of the cpumask. A struct bpf_cpumask
  * pointer may be safely passed to this function.
  */
-u32 bpf_cpumask_first_zero(const struct cpumask *cpumask)
+__bpf_kfunc u32 bpf_cpumask_first_zero(const struct cpumask *cpumask)
 {
 	return cpumask_first_zero(cpumask);
 }
@@ -158,7 +158,7 @@ u32 bpf_cpumask_first_zero(const struct cpumask *cpumask)
  * @cpu: The CPU to be set in the cpumask.
  * @cpumask: The BPF cpumask in which a bit is being set.
  */
-void bpf_cpumask_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
+__bpf_kfunc void bpf_cpumask_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
 {
 	if (!cpu_valid(cpu))
 		return;
@@ -171,7 +171,7 @@ void bpf_cpumask_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
  * @cpu: The CPU to be cleared from the cpumask.
  * @cpumask: The BPF cpumask in which a bit is being cleared.
  */
-void bpf_cpumask_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
+__bpf_kfunc void bpf_cpumask_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
 {
 	if (!cpu_valid(cpu))
 		return;
@@ -188,7 +188,7 @@ void bpf_cpumask_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
  * * true  - @cpu is set in the cpumask
  * * false - @cpu was not set in the cpumask, or @cpu is an invalid cpu.
  */
-bool bpf_cpumask_test_cpu(u32 cpu, const struct cpumask *cpumask)
+__bpf_kfunc bool bpf_cpumask_test_cpu(u32 cpu, const struct cpumask *cpumask)
 {
 	if (!cpu_valid(cpu))
 		return false;
@@ -205,7 +205,7 @@ bool bpf_cpumask_test_cpu(u32 cpu, const struct cpumask *cpumask)
  * * true  - @cpu is set in the cpumask
  * * false - @cpu was not set in the cpumask, or @cpu is invalid.
  */
-bool bpf_cpumask_test_and_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
+__bpf_kfunc bool bpf_cpumask_test_and_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
 {
 	if (!cpu_valid(cpu))
 		return false;
@@ -223,7 +223,7 @@ bool bpf_cpumask_test_and_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
  * * true  - @cpu is set in the cpumask
  * * false - @cpu was not set in the cpumask, or @cpu is invalid.
  */
-bool bpf_cpumask_test_and_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
+__bpf_kfunc bool bpf_cpumask_test_and_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
 {
 	if (!cpu_valid(cpu))
 		return false;
@@ -235,7 +235,7 @@ bool bpf_cpumask_test_and_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
  * bpf_cpumask_setall() - Set all of the bits in a BPF cpumask.
  * @cpumask: The BPF cpumask having all of its bits set.
  */
-void bpf_cpumask_setall(struct bpf_cpumask *cpumask)
+__bpf_kfunc void bpf_cpumask_setall(struct bpf_cpumask *cpumask)
 {
 	cpumask_setall((struct cpumask *)cpumask);
 }
@@ -244,7 +244,7 @@ void bpf_cpumask_setall(struct bpf_cpumask *cpumask)
  * bpf_cpumask_clear() - Clear all of the bits in a BPF cpumask.
  * @cpumask: The BPF cpumask being cleared.
  */
-void bpf_cpumask_clear(struct bpf_cpumask *cpumask)
+__bpf_kfunc void bpf_cpumask_clear(struct bpf_cpumask *cpumask)
 {
 	cpumask_clear((struct cpumask *)cpumask);
 }
@@ -261,9 +261,9 @@ void bpf_cpumask_clear(struct bpf_cpumask *cpumask)
  *
  * struct bpf_cpumask pointers may be safely passed to @src1 and @src2.
  */
-bool bpf_cpumask_and(struct bpf_cpumask *dst,
-		     const struct cpumask *src1,
-		     const struct cpumask *src2)
+__bpf_kfunc bool bpf_cpumask_and(struct bpf_cpumask *dst,
+				 const struct cpumask *src1,
+				 const struct cpumask *src2)
 {
 	return cpumask_and((struct cpumask *)dst, src1, src2);
 }
@@ -276,9 +276,9 @@ bool bpf_cpumask_and(struct bpf_cpumask *dst,
  *
  * struct bpf_cpumask pointers may be safely passed to @src1 and @src2.
  */
-void bpf_cpumask_or(struct bpf_cpumask *dst,
-		    const struct cpumask *src1,
-		    const struct cpumask *src2)
+__bpf_kfunc void bpf_cpumask_or(struct bpf_cpumask *dst,
+				const struct cpumask *src1,
+				const struct cpumask *src2)
 {
 	cpumask_or((struct cpumask *)dst, src1, src2);
 }
@@ -291,9 +291,9 @@ void bpf_cpumask_or(struct bpf_cpumask *dst,
  *
  * struct bpf_cpumask pointers may be safely passed to @src1 and @src2.
  */
-void bpf_cpumask_xor(struct bpf_cpumask *dst,
-		     const struct cpumask *src1,
-		     const struct cpumask *src2)
+__bpf_kfunc void bpf_cpumask_xor(struct bpf_cpumask *dst,
+				 const struct cpumask *src1,
+				 const struct cpumask *src2)
 {
 	cpumask_xor((struct cpumask *)dst, src1, src2);
 }
@@ -309,7 +309,7 @@ void bpf_cpumask_xor(struct bpf_cpumask *dst,
  *
  * struct bpf_cpumask pointers may be safely passed to @src1 and @src2.
  */
-bool bpf_cpumask_equal(const struct cpumask *src1, const struct cpumask *src2)
+__bpf_kfunc bool bpf_cpumask_equal(const struct cpumask *src1, const struct cpumask *src2)
 {
 	return cpumask_equal(src1, src2);
 }
@@ -325,7 +325,7 @@ bool bpf_cpumask_equal(const struct cpumask *src1, const struct cpumask *src2)
  *
  * struct bpf_cpumask pointers may be safely passed to @src1 and @src2.
  */
-bool bpf_cpumask_intersects(const struct cpumask *src1, const struct cpumask *src2)
+__bpf_kfunc bool bpf_cpumask_intersects(const struct cpumask *src1, const struct cpumask *src2)
 {
 	return cpumask_intersects(src1, src2);
 }
@@ -341,7 +341,7 @@ bool bpf_cpumask_intersects(const struct cpumask *src1, const struct cpumask *sr
  *
  * struct bpf_cpumask pointers may be safely passed to @src1 and @src2.
  */
-bool bpf_cpumask_subset(const struct cpumask *src1, const struct cpumask *src2)
+__bpf_kfunc bool bpf_cpumask_subset(const struct cpumask *src1, const struct cpumask *src2)
 {
 	return cpumask_subset(src1, src2);
 }
@@ -356,7 +356,7 @@ bool bpf_cpumask_subset(const struct cpumask *src1, const struct cpumask *src2)
  *
  * A struct bpf_cpumask pointer may be safely passed to @cpumask.
  */
-bool bpf_cpumask_empty(const struct cpumask *cpumask)
+__bpf_kfunc bool bpf_cpumask_empty(const struct cpumask *cpumask)
 {
 	return cpumask_empty(cpumask);
 }
@@ -371,7 +371,7 @@ bool bpf_cpumask_empty(const struct cpumask *cpumask)
  *
  * A struct bpf_cpumask pointer may be safely passed to @cpumask.
  */
-bool bpf_cpumask_full(const struct cpumask *cpumask)
+__bpf_kfunc bool bpf_cpumask_full(const struct cpumask *cpumask)
 {
 	return cpumask_full(cpumask);
 }
@@ -383,7 +383,7 @@ bool bpf_cpumask_full(const struct cpumask *cpumask)
  *
  * A struct bpf_cpumask pointer may be safely passed to @src.
  */
-void bpf_cpumask_copy(struct bpf_cpumask *dst, const struct cpumask *src)
+__bpf_kfunc void bpf_cpumask_copy(struct bpf_cpumask *dst, const struct cpumask *src)
 {
 	cpumask_copy((struct cpumask *)dst, src);
 }
@@ -398,7 +398,7 @@ void bpf_cpumask_copy(struct bpf_cpumask *dst, const struct cpumask *src)
  *
  * A struct bpf_cpumask pointer may be safely passed to @src.
  */
-u32 bpf_cpumask_any(const struct cpumask *cpumask)
+__bpf_kfunc u32 bpf_cpumask_any(const struct cpumask *cpumask)
 {
 	return cpumask_any(cpumask);
 }
@@ -415,7 +415,7 @@ u32 bpf_cpumask_any(const struct cpumask *cpumask)
  *
  * struct bpf_cpumask pointers may be safely passed to @src1 and @src2.
  */
-u32 bpf_cpumask_any_and(const struct cpumask *src1, const struct cpumask *src2)
+__bpf_kfunc u32 bpf_cpumask_any_and(const struct cpumask *src1, const struct cpumask *src2)
 {
 	return cpumask_any_and(src1, src2);
 }
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 458db2db2f81..2dae44581922 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1776,7 +1776,7 @@ __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in vmlinux BTF");
 
-void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
+__bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
 {
 	struct btf_struct_meta *meta = meta__ign;
 	u64 size = local_type_id__k;
@@ -1790,7 +1790,7 @@ void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
 	return p;
 }
 
-void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
+__bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
 {
 	struct btf_struct_meta *meta = meta__ign;
 	void *p = p__alloc;
@@ -1811,12 +1811,12 @@ static void __bpf_list_add(struct bpf_list_node *node, struct bpf_list_head *hea
 	tail ? list_add_tail(n, h) : list_add(n, h);
 }
 
-void bpf_list_push_front(struct bpf_list_head *head, struct bpf_list_node *node)
+__bpf_kfunc void bpf_list_push_front(struct bpf_list_head *head, struct bpf_list_node *node)
 {
 	return __bpf_list_add(node, head, false);
 }
 
-void bpf_list_push_back(struct bpf_list_head *head, struct bpf_list_node *node)
+__bpf_kfunc void bpf_list_push_back(struct bpf_list_head *head, struct bpf_list_node *node)
 {
 	return __bpf_list_add(node, head, true);
 }
@@ -1834,12 +1834,12 @@ static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, bool tai
 	return (struct bpf_list_node *)n;
 }
 
-struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head)
+__bpf_kfunc struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head)
 {
 	return __bpf_list_del(head, false);
 }
 
-struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
+__bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
 {
 	return __bpf_list_del(head, true);
 }
@@ -1850,7 +1850,7 @@ struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
  * bpf_task_release().
  * @p: The task on which a reference is being acquired.
  */
-struct task_struct *bpf_task_acquire(struct task_struct *p)
+__bpf_kfunc struct task_struct *bpf_task_acquire(struct task_struct *p)
 {
 	return get_task_struct(p);
 }
@@ -1861,7 +1861,7 @@ struct task_struct *bpf_task_acquire(struct task_struct *p)
  * released by calling bpf_task_release().
  * @p: The task on which a reference is being acquired.
  */
-struct task_struct *bpf_task_acquire_not_zero(struct task_struct *p)
+__bpf_kfunc struct task_struct *bpf_task_acquire_not_zero(struct task_struct *p)
 {
 	/* For the time being this function returns NULL, as it's not currently
 	 * possible to safely acquire a reference to a task with RCU protection
@@ -1913,7 +1913,7 @@ struct task_struct *bpf_task_acquire_not_zero(struct task_struct *p)
  * be released by calling bpf_task_release().
  * @pp: A pointer to a task kptr on which a reference is being acquired.
  */
-struct task_struct *bpf_task_kptr_get(struct task_struct **pp)
+__bpf_kfunc struct task_struct *bpf_task_kptr_get(struct task_struct **pp)
 {
 	/* We must return NULL here until we have clarity on how to properly
 	 * leverage RCU for ensuring a task's lifetime. See the comment above
@@ -1926,7 +1926,7 @@ struct task_struct *bpf_task_kptr_get(struct task_struct **pp)
  * bpf_task_release - Release the reference acquired on a task.
  * @p: The task on which a reference is being released.
  */
-void bpf_task_release(struct task_struct *p)
+__bpf_kfunc void bpf_task_release(struct task_struct *p)
 {
 	if (!p)
 		return;
@@ -1941,7 +1941,7 @@ void bpf_task_release(struct task_struct *p)
  * calling bpf_cgroup_release().
  * @cgrp: The cgroup on which a reference is being acquired.
  */
-struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp)
+__bpf_kfunc struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp)
 {
 	cgroup_get(cgrp);
 	return cgrp;
@@ -1953,7 +1953,7 @@ struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp)
  * be released by calling bpf_cgroup_release().
  * @cgrpp: A pointer to a cgroup kptr on which a reference is being acquired.
  */
-struct cgroup *bpf_cgroup_kptr_get(struct cgroup **cgrpp)
+__bpf_kfunc struct cgroup *bpf_cgroup_kptr_get(struct cgroup **cgrpp)
 {
 	struct cgroup *cgrp;
 
@@ -1985,7 +1985,7 @@ struct cgroup *bpf_cgroup_kptr_get(struct cgroup **cgrpp)
  * drops to 0.
  * @cgrp: The cgroup on which a reference is being released.
  */
-void bpf_cgroup_release(struct cgroup *cgrp)
+__bpf_kfunc void bpf_cgroup_release(struct cgroup *cgrp)
 {
 	if (!cgrp)
 		return;
@@ -2000,7 +2000,7 @@ void bpf_cgroup_release(struct cgroup *cgrp)
  * @cgrp: The cgroup for which we're performing a lookup.
  * @level: The level of ancestor to look up.
  */
-struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level)
+__bpf_kfunc struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level)
 {
 	struct cgroup *ancestor;
 
@@ -2019,7 +2019,7 @@ struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level)
  * stored in a map, or released with bpf_task_release().
  * @pid: The pid of the task being looked up.
  */
-struct task_struct *bpf_task_from_pid(s32 pid)
+__bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
 {
 	struct task_struct *p;
 
@@ -2032,22 +2032,22 @@ struct task_struct *bpf_task_from_pid(s32 pid)
 	return p;
 }
 
-void *bpf_cast_to_kern_ctx(void *obj)
+__bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
 {
 	return obj;
 }
 
-void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k)
+__bpf_kfunc void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k)
 {
 	return obj__ign;
 }
 
-void bpf_rcu_read_lock(void)
+__bpf_kfunc void bpf_rcu_read_lock(void)
 {
 	rcu_read_lock();
 }
 
-void bpf_rcu_read_unlock(void)
+__bpf_kfunc void bpf_rcu_read_unlock(void)
 {
 	rcu_read_unlock();
 }
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 793ecff29038..831f1f472bb8 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -26,7 +26,7 @@ static struct cgroup_rstat_cpu *cgroup_rstat_cpu(struct cgroup *cgrp, int cpu)
  * rstat_cpu->updated_children list.  See the comment on top of
  * cgroup_rstat_cpu definition for details.
  */
-void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
+__bpf_kfunc void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 {
 	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
 	unsigned long flags;
@@ -231,7 +231,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
  *
  * This function may block.
  */
-void cgroup_rstat_flush(struct cgroup *cgrp)
+__bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
 {
 	might_sleep();
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 969e8f52f7da..b1cf259854ca 100644
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
+__bpf_kfunc void crash_kexec(struct pt_regs *regs)
 {
 	int old_cpu, this_cpu;
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b1eff2efd3b4..ff1458e541a8 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1236,7 +1236,7 @@ __diag_ignore_all("-Wmissing-prototypes",
  * Return: a bpf_key pointer with a valid key pointer if the key is found, a
  *         NULL pointer otherwise.
  */
-struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)
+__bpf_kfunc struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)
 {
 	key_ref_t key_ref;
 	struct bpf_key *bkey;
@@ -1285,7 +1285,7 @@ struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)
  * Return: a bpf_key pointer with an invalid key pointer set from the
  *         pre-determined ID on success, a NULL pointer otherwise
  */
-struct bpf_key *bpf_lookup_system_key(u64 id)
+__bpf_kfunc struct bpf_key *bpf_lookup_system_key(u64 id)
 {
 	struct bpf_key *bkey;
 
@@ -1309,7 +1309,7 @@ struct bpf_key *bpf_lookup_system_key(u64 id)
  * Decrement the reference count of the key inside *bkey*, if the pointer
  * is valid, and free *bkey*.
  */
-void bpf_key_put(struct bpf_key *bkey)
+__bpf_kfunc void bpf_key_put(struct bpf_key *bkey)
 {
 	if (bkey->has_ref)
 		key_put(bkey->key);
@@ -1329,7 +1329,7 @@ void bpf_key_put(struct bpf_key *bkey)
  *
  * Return: 0 on success, a negative value on error.
  */
-int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
+__bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
 			       struct bpf_dynptr_kern *sig_ptr,
 			       struct bpf_key *trusted_keyring)
 {
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 7dbefa4fd2eb..af9827c4b351 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -484,7 +484,7 @@ static int bpf_test_finish(const union bpf_attr *kattr,
 __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in vmlinux BTF");
-int noinline bpf_fentry_test1(int a)
+__bpf_kfunc int bpf_fentry_test1(int a)
 {
 	return a + 1;
 }
@@ -529,23 +529,23 @@ int noinline bpf_fentry_test8(struct bpf_fentry_test_t *arg)
 	return (long)arg->a;
 }
 
-int noinline bpf_modify_return_test(int a, int *b)
+__bpf_kfunc int bpf_modify_return_test(int a, int *b)
 {
 	*b += 1;
 	return a + *b;
 }
 
-u64 noinline bpf_kfunc_call_test1(struct sock *sk, u32 a, u64 b, u32 c, u64 d)
+__bpf_kfunc u64 bpf_kfunc_call_test1(struct sock *sk, u32 a, u64 b, u32 c, u64 d)
 {
 	return a + b + c + d;
 }
 
-int noinline bpf_kfunc_call_test2(struct sock *sk, u32 a, u32 b)
+__bpf_kfunc int bpf_kfunc_call_test2(struct sock *sk, u32 a, u32 b)
 {
 	return a + b;
 }
 
-struct sock * noinline bpf_kfunc_call_test3(struct sock *sk)
+__bpf_kfunc struct sock *bpf_kfunc_call_test3(struct sock *sk)
 {
 	return sk;
 }
@@ -582,21 +582,21 @@ static struct prog_test_ref_kfunc prog_test_struct = {
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
+__bpf_kfunc void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
 {
 	if (!p)
 		return;
@@ -604,11 +604,11 @@ noinline void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
 	refcount_dec(&p->cnt);
 }
 
-noinline void bpf_kfunc_call_memb_release(struct prog_test_member *p)
+__bpf_kfunc void bpf_kfunc_call_memb_release(struct prog_test_member *p)
 {
 }
 
-noinline void bpf_kfunc_call_memb1_release(struct prog_test_member1 *p)
+__bpf_kfunc void bpf_kfunc_call_memb1_release(struct prog_test_member1 *p)
 {
 	WARN_ON_ONCE(1);
 }
@@ -621,12 +621,14 @@ static int *__bpf_kfunc_call_test_get_mem(struct prog_test_ref_kfunc *p, const i
 	return (int *)p;
 }
 
-noinline int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size)
+__bpf_kfunc int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p,
+						  const int rdwr_buf_size)
 {
 	return __bpf_kfunc_call_test_get_mem(p, rdwr_buf_size);
 }
 
-noinline int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size)
+__bpf_kfunc int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p,
+						    const int rdonly_buf_size)
 {
 	return __bpf_kfunc_call_test_get_mem(p, rdonly_buf_size);
 }
@@ -636,16 +638,17 @@ noinline int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p,
  * Acquire functions must return struct pointers, so these ones are
  * failing.
  */
-noinline int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size)
+__bpf_kfunc int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p,
+						    const int rdonly_buf_size)
 {
 	return __bpf_kfunc_call_test_get_mem(p, rdonly_buf_size);
 }
 
-noinline void bpf_kfunc_call_int_mem_release(int *p)
+__bpf_kfunc void bpf_kfunc_call_int_mem_release(int *p)
 {
 }
 
-noinline struct prog_test_ref_kfunc *
+__bpf_kfunc struct prog_test_ref_kfunc *
 bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **pp, int a, int b)
 {
 	struct prog_test_ref_kfunc *p = READ_ONCE(*pp);
@@ -694,47 +697,47 @@ struct prog_test_fail3 {
 	char arr2[];
 };
 
-noinline void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb)
+__bpf_kfunc void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb)
 {
 }
 
-noinline void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p)
+__bpf_kfunc void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p)
 {
 }
 
-noinline void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p)
+__bpf_kfunc void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p)
 {
 }
 
-noinline void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p)
+__bpf_kfunc void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p)
 {
 }
 
-noinline void bpf_kfunc_call_test_fail2(struct prog_test_fail2 *p)
+__bpf_kfunc void bpf_kfunc_call_test_fail2(struct prog_test_fail2 *p)
 {
 }
 
-noinline void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p)
+__bpf_kfunc void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p)
 {
 }
 
-noinline void bpf_kfunc_call_test_mem_len_pass1(void *mem, int mem__sz)
+__bpf_kfunc void bpf_kfunc_call_test_mem_len_pass1(void *mem, int mem__sz)
 {
 }
 
-noinline void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len)
+__bpf_kfunc void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len)
 {
 }
 
-noinline void bpf_kfunc_call_test_mem_len_fail2(u64 *mem, int len)
+__bpf_kfunc void bpf_kfunc_call_test_mem_len_fail2(u64 *mem, int len)
 {
 }
 
-noinline void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p)
+__bpf_kfunc void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p)
 {
 }
 
-noinline void bpf_kfunc_call_test_destructive(void)
+__bpf_kfunc void bpf_kfunc_call_test_destructive(void)
 {
 }
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index a5a7ecf6391c..787fb9f92b36 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2017 Jesper Dangaard Brouer, Red Hat Inc.
  */
 #include <linux/bpf.h>
+#include <linux/btf.h>
 #include <linux/btf_ids.h>
 #include <linux/filter.h>
 #include <linux/types.h>
@@ -722,7 +723,7 @@ __diag_ignore_all("-Wmissing-prototypes",
  *
  * Returns 0 on success or ``-errno`` on error.
  */
-int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
+__bpf_kfunc int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
 {
 	return -EOPNOTSUPP;
 }
@@ -734,7 +735,7 @@ int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
  *
  * Returns 0 on success or ``-errno`` on error.
  */
-int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
+__bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
index d2c470524e58..146792cd26fe 100644
--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -295,7 +295,7 @@ static void bbr_set_pacing_rate(struct sock *sk, u32 bw, int gain)
 }
 
 /* override sysctl_tcp_min_tso_segs */
-static u32 bbr_min_tso_segs(struct sock *sk)
+__bpf_kfunc static u32 bbr_min_tso_segs(struct sock *sk)
 {
 	return sk->sk_pacing_rate < (bbr_min_tso_rate >> 3) ? 1 : 2;
 }
@@ -328,7 +328,7 @@ static void bbr_save_cwnd(struct sock *sk)
 		bbr->prior_cwnd = max(bbr->prior_cwnd, tcp_snd_cwnd(tp));
 }
 
-static void bbr_cwnd_event(struct sock *sk, enum tcp_ca_event event)
+__bpf_kfunc static void bbr_cwnd_event(struct sock *sk, enum tcp_ca_event event)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct bbr *bbr = inet_csk_ca(sk);
@@ -1023,7 +1023,7 @@ static void bbr_update_model(struct sock *sk, const struct rate_sample *rs)
 	bbr_update_gains(sk);
 }
 
-static void bbr_main(struct sock *sk, const struct rate_sample *rs)
+__bpf_kfunc static void bbr_main(struct sock *sk, const struct rate_sample *rs)
 {
 	struct bbr *bbr = inet_csk_ca(sk);
 	u32 bw;
@@ -1035,7 +1035,7 @@ static void bbr_main(struct sock *sk, const struct rate_sample *rs)
 	bbr_set_cwnd(sk, rs, rs->acked_sacked, bw, bbr->cwnd_gain);
 }
 
-static void bbr_init(struct sock *sk)
+__bpf_kfunc static void bbr_init(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct bbr *bbr = inet_csk_ca(sk);
@@ -1077,7 +1077,7 @@ static void bbr_init(struct sock *sk)
 	cmpxchg(&sk->sk_pacing_status, SK_PACING_NONE, SK_PACING_NEEDED);
 }
 
-static u32 bbr_sndbuf_expand(struct sock *sk)
+__bpf_kfunc static u32 bbr_sndbuf_expand(struct sock *sk)
 {
 	/* Provision 3 * cwnd since BBR may slow-start even during recovery. */
 	return 3;
@@ -1086,7 +1086,7 @@ static u32 bbr_sndbuf_expand(struct sock *sk)
 /* In theory BBR does not need to undo the cwnd since it does not
  * always reduce cwnd on losses (see bbr_main()). Keep it for now.
  */
-static u32 bbr_undo_cwnd(struct sock *sk)
+__bpf_kfunc static u32 bbr_undo_cwnd(struct sock *sk)
 {
 	struct bbr *bbr = inet_csk_ca(sk);
 
@@ -1097,7 +1097,7 @@ static u32 bbr_undo_cwnd(struct sock *sk)
 }
 
 /* Entering loss recovery, so save cwnd for when we exit or undo recovery. */
-static u32 bbr_ssthresh(struct sock *sk)
+__bpf_kfunc static u32 bbr_ssthresh(struct sock *sk)
 {
 	bbr_save_cwnd(sk);
 	return tcp_sk(sk)->snd_ssthresh;
@@ -1125,7 +1125,7 @@ static size_t bbr_get_info(struct sock *sk, u32 ext, int *attr,
 	return 0;
 }
 
-static void bbr_set_state(struct sock *sk, u8 new_state)
+__bpf_kfunc static void bbr_set_state(struct sock *sk, u8 new_state)
 {
 	struct bbr *bbr = inet_csk_ca(sk);
 
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index d3cae40749e8..db8b4b488c31 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -403,7 +403,7 @@ int tcp_set_congestion_control(struct sock *sk, const char *name, bool load,
  * ABC caps N to 2. Slow start exits when cwnd grows over ssthresh and
  * returns the leftover acks to adjust cwnd in congestion avoidance mode.
  */
-u32 tcp_slow_start(struct tcp_sock *tp, u32 acked)
+__bpf_kfunc u32 tcp_slow_start(struct tcp_sock *tp, u32 acked)
 {
 	u32 cwnd = min(tcp_snd_cwnd(tp) + acked, tp->snd_ssthresh);
 
@@ -417,7 +417,7 @@ EXPORT_SYMBOL_GPL(tcp_slow_start);
 /* In theory this is tp->snd_cwnd += 1 / tp->snd_cwnd (or alternative w),
  * for every packet that was ACKed.
  */
-void tcp_cong_avoid_ai(struct tcp_sock *tp, u32 w, u32 acked)
+__bpf_kfunc void tcp_cong_avoid_ai(struct tcp_sock *tp, u32 w, u32 acked)
 {
 	/* If credits accumulated at a higher w, apply them gently now. */
 	if (tp->snd_cwnd_cnt >= w) {
@@ -443,7 +443,7 @@ EXPORT_SYMBOL_GPL(tcp_cong_avoid_ai);
 /* This is Jacobson's slow start and congestion avoidance.
  * SIGCOMM '88, p. 328.
  */
-void tcp_reno_cong_avoid(struct sock *sk, u32 ack, u32 acked)
+__bpf_kfunc void tcp_reno_cong_avoid(struct sock *sk, u32 ack, u32 acked)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
@@ -462,7 +462,7 @@ void tcp_reno_cong_avoid(struct sock *sk, u32 ack, u32 acked)
 EXPORT_SYMBOL_GPL(tcp_reno_cong_avoid);
 
 /* Slow start threshold is half the congestion window (min 2) */
-u32 tcp_reno_ssthresh(struct sock *sk)
+__bpf_kfunc u32 tcp_reno_ssthresh(struct sock *sk)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 
@@ -470,7 +470,7 @@ u32 tcp_reno_ssthresh(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(tcp_reno_ssthresh);
 
-u32 tcp_reno_undo_cwnd(struct sock *sk)
+__bpf_kfunc u32 tcp_reno_undo_cwnd(struct sock *sk)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 
diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 768c10c1f649..0fd78ecb67e7 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -126,7 +126,7 @@ static inline void bictcp_hystart_reset(struct sock *sk)
 	ca->sample_cnt = 0;
 }
 
-static void cubictcp_init(struct sock *sk)
+__bpf_kfunc static void cubictcp_init(struct sock *sk)
 {
 	struct bictcp *ca = inet_csk_ca(sk);
 
@@ -139,7 +139,7 @@ static void cubictcp_init(struct sock *sk)
 		tcp_sk(sk)->snd_ssthresh = initial_ssthresh;
 }
 
-static void cubictcp_cwnd_event(struct sock *sk, enum tcp_ca_event event)
+__bpf_kfunc static void cubictcp_cwnd_event(struct sock *sk, enum tcp_ca_event event)
 {
 	if (event == CA_EVENT_TX_START) {
 		struct bictcp *ca = inet_csk_ca(sk);
@@ -321,7 +321,7 @@ static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
 	ca->cnt = max(ca->cnt, 2U);
 }
 
-static void cubictcp_cong_avoid(struct sock *sk, u32 ack, u32 acked)
+__bpf_kfunc static void cubictcp_cong_avoid(struct sock *sk, u32 ack, u32 acked)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct bictcp *ca = inet_csk_ca(sk);
@@ -338,7 +338,7 @@ static void cubictcp_cong_avoid(struct sock *sk, u32 ack, u32 acked)
 	tcp_cong_avoid_ai(tp, ca->cnt, acked);
 }
 
-static u32 cubictcp_recalc_ssthresh(struct sock *sk)
+__bpf_kfunc static u32 cubictcp_recalc_ssthresh(struct sock *sk)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 	struct bictcp *ca = inet_csk_ca(sk);
@@ -355,7 +355,7 @@ static u32 cubictcp_recalc_ssthresh(struct sock *sk)
 	return max((tcp_snd_cwnd(tp) * beta) / BICTCP_BETA_SCALE, 2U);
 }
 
-static void cubictcp_state(struct sock *sk, u8 new_state)
+__bpf_kfunc static void cubictcp_state(struct sock *sk, u8 new_state)
 {
 	if (new_state == TCP_CA_Loss) {
 		bictcp_reset(inet_csk_ca(sk));
@@ -445,7 +445,7 @@ static void hystart_update(struct sock *sk, u32 delay)
 	}
 }
 
-static void cubictcp_acked(struct sock *sk, const struct ack_sample *sample)
+__bpf_kfunc static void cubictcp_acked(struct sock *sk, const struct ack_sample *sample)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 	struct bictcp *ca = inet_csk_ca(sk);
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index e0a2ca7456ff..bb23bb5b387a 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -75,7 +75,7 @@ static void dctcp_reset(const struct tcp_sock *tp, struct dctcp *ca)
 	ca->old_delivered_ce = tp->delivered_ce;
 }
 
-static void dctcp_init(struct sock *sk)
+__bpf_kfunc static void dctcp_init(struct sock *sk)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 
@@ -104,7 +104,7 @@ static void dctcp_init(struct sock *sk)
 	INET_ECN_dontxmit(sk);
 }
 
-static u32 dctcp_ssthresh(struct sock *sk)
+__bpf_kfunc static u32 dctcp_ssthresh(struct sock *sk)
 {
 	struct dctcp *ca = inet_csk_ca(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -113,7 +113,7 @@ static u32 dctcp_ssthresh(struct sock *sk)
 	return max(tcp_snd_cwnd(tp) - ((tcp_snd_cwnd(tp) * ca->dctcp_alpha) >> 11U), 2U);
 }
 
-static void dctcp_update_alpha(struct sock *sk, u32 flags)
+__bpf_kfunc static void dctcp_update_alpha(struct sock *sk, u32 flags)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 	struct dctcp *ca = inet_csk_ca(sk);
@@ -169,7 +169,7 @@ static void dctcp_react_to_loss(struct sock *sk)
 	tp->snd_ssthresh = max(tcp_snd_cwnd(tp) >> 1U, 2U);
 }
 
-static void dctcp_state(struct sock *sk, u8 new_state)
+__bpf_kfunc static void dctcp_state(struct sock *sk, u8 new_state)
 {
 	if (new_state == TCP_CA_Recovery &&
 	    new_state != inet_csk(sk)->icsk_ca_state)
@@ -179,7 +179,7 @@ static void dctcp_state(struct sock *sk, u8 new_state)
 	 */
 }
 
-static void dctcp_cwnd_event(struct sock *sk, enum tcp_ca_event ev)
+__bpf_kfunc static void dctcp_cwnd_event(struct sock *sk, enum tcp_ca_event ev)
 {
 	struct dctcp *ca = inet_csk_ca(sk);
 
@@ -229,7 +229,7 @@ static size_t dctcp_get_info(struct sock *sk, u32 ext, int *attr,
 	return 0;
 }
 
-static u32 dctcp_cwnd_undo(struct sock *sk)
+__bpf_kfunc static u32 dctcp_cwnd_undo(struct sock *sk)
 {
 	const struct dctcp *ca = inet_csk_ca(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index 24002bc61e07..34913521c385 100644
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
@@ -376,7 +376,7 @@ bpf_skb_ct_lookup(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
  * @nfct	 - Pointer to referenced nf_conn___init object, obtained
  *		   using bpf_xdp_ct_alloc or bpf_skb_ct_alloc.
  */
-struct nf_conn *bpf_ct_insert_entry(struct nf_conn___init *nfct_i)
+__bpf_kfunc struct nf_conn *bpf_ct_insert_entry(struct nf_conn___init *nfct_i)
 {
 	struct nf_conn *nfct = (struct nf_conn *)nfct_i;
 	int err;
@@ -400,7 +400,7 @@ struct nf_conn *bpf_ct_insert_entry(struct nf_conn___init *nfct_i)
  * @nf_conn	 - Pointer to referenced nf_conn object, obtained using
  *		   bpf_xdp_ct_lookup or bpf_skb_ct_lookup.
  */
-void bpf_ct_release(struct nf_conn *nfct)
+__bpf_kfunc void bpf_ct_release(struct nf_conn *nfct)
 {
 	if (!nfct)
 		return;
@@ -417,7 +417,7 @@ void bpf_ct_release(struct nf_conn *nfct)
  *                 bpf_xdp_ct_alloc or bpf_skb_ct_alloc.
  * @timeout      - Timeout in msecs.
  */
-void bpf_ct_set_timeout(struct nf_conn___init *nfct, u32 timeout)
+__bpf_kfunc void bpf_ct_set_timeout(struct nf_conn___init *nfct, u32 timeout)
 {
 	__nf_ct_set_timeout((struct nf_conn *)nfct, msecs_to_jiffies(timeout));
 }
@@ -432,7 +432,7 @@ void bpf_ct_set_timeout(struct nf_conn___init *nfct, u32 timeout)
  *		   bpf_ct_insert_entry, bpf_xdp_ct_lookup, or bpf_skb_ct_lookup.
  * @timeout      - New timeout in msecs.
  */
-int bpf_ct_change_timeout(struct nf_conn *nfct, u32 timeout)
+__bpf_kfunc int bpf_ct_change_timeout(struct nf_conn *nfct, u32 timeout)
 {
 	return __nf_ct_change_timeout(nfct, msecs_to_jiffies(timeout));
 }
@@ -447,7 +447,7 @@ int bpf_ct_change_timeout(struct nf_conn *nfct, u32 timeout)
  *		   bpf_xdp_ct_alloc or bpf_skb_ct_alloc.
  * @status       - New status value.
  */
-int bpf_ct_set_status(const struct nf_conn___init *nfct, u32 status)
+__bpf_kfunc int bpf_ct_set_status(const struct nf_conn___init *nfct, u32 status)
 {
 	return nf_ct_change_status_common((struct nf_conn *)nfct, status);
 }
@@ -462,7 +462,7 @@ int bpf_ct_set_status(const struct nf_conn___init *nfct, u32 status)
  *		   bpf_ct_insert_entry, bpf_xdp_ct_lookup or bpf_skb_ct_lookup.
  * @status       - New status value.
  */
-int bpf_ct_change_status(struct nf_conn *nfct, u32 status)
+__bpf_kfunc int bpf_ct_change_status(struct nf_conn *nfct, u32 status)
 {
 	return nf_ct_change_status_common(nfct, status);
 }
diff --git a/net/netfilter/nf_nat_bpf.c b/net/netfilter/nf_nat_bpf.c
index 0fa5a0bbb0ff..141ee7783223 100644
--- a/net/netfilter/nf_nat_bpf.c
+++ b/net/netfilter/nf_nat_bpf.c
@@ -30,9 +30,9 @@ __diag_ignore_all("-Wmissing-prototypes",
  *		  interpreted as select a random port.
  * @manip	- NF_NAT_MANIP_SRC or NF_NAT_MANIP_DST
  */
-int bpf_ct_set_nat_info(struct nf_conn___init *nfct,
-			union nf_inet_addr *addr, int port,
-			enum nf_nat_manip_type manip)
+__bpf_kfunc int bpf_ct_set_nat_info(struct nf_conn___init *nfct,
+				    union nf_inet_addr *addr, int port,
+				    enum nf_nat_manip_type manip)
 {
 	struct nf_conn *ct = (struct nf_conn *)nfct;
 	u16 proto = nf_ct_l3num(ct);
diff --git a/net/xfrm/xfrm_interface_bpf.c b/net/xfrm/xfrm_interface_bpf.c
index 1ef2162cebcf..d74f3fd20f2b 100644
--- a/net/xfrm/xfrm_interface_bpf.c
+++ b/net/xfrm/xfrm_interface_bpf.c
@@ -39,8 +39,7 @@ __diag_ignore_all("-Wmissing-prototypes",
  * @to		- Pointer to memory to which the metadata will be copied
  *		    Cannot be NULL
  */
-__used noinline
-int bpf_skb_get_xfrm_info(struct __sk_buff *skb_ctx, struct bpf_xfrm_info *to)
+__bpf_kfunc int bpf_skb_get_xfrm_info(struct __sk_buff *skb_ctx, struct bpf_xfrm_info *to)
 {
 	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
 	struct xfrm_md_info *info;
@@ -62,9 +61,7 @@ int bpf_skb_get_xfrm_info(struct __sk_buff *skb_ctx, struct bpf_xfrm_info *to)
  * @from	- Pointer to memory from which the metadata will be copied
  *		    Cannot be NULL
  */
-__used noinline
-int bpf_skb_set_xfrm_info(struct __sk_buff *skb_ctx,
-			  const struct bpf_xfrm_info *from)
+__bpf_kfunc int bpf_skb_set_xfrm_info(struct __sk_buff *skb_ctx, const struct bpf_xfrm_info *from)
 {
 	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
 	struct metadata_dst *md_dst;
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

