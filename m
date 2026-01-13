Return-Path: <bpf+bounces-78701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1F6D18A61
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 13:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37343303D8B6
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 12:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B564B38E5F3;
	Tue, 13 Jan 2026 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9Wes4aL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B973438E5DD
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768306386; cv=none; b=UtFA7tNTVywHvX4XXFkWwljrkzSKxKj3pHTFk9l3zKBeqDGc9Qo9RlNGGcG3ptWceWJeNbJP+N2AyDksbqO0peVNSEAwLfIQBlzI0EyQqcliWN7goNEbBj/dSFZBvR4opGzbp+gaAKkyN7HxAZ953gLEIsWOIFqV5ZCZk/TWfY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768306386; c=relaxed/simple;
	bh=vfmH95SocIK2+iN81F6d7tSSpqj9q3Js1VxKpA19Sqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbOevD9faVKuHWcEqIg8S/jHTX+5uZSsn7lzwr6E1xYid+j/j2ZUy6Jrh64SfwDGkkZcirnTtXFdFSiharE46zj7PyNPvGRsXkUjoFliR0PuLXg0F5/q0i5Uh4njrpwn1TqL2X8m5fNlu3xF/K1Lh3PetLc6g4R/oIKadY1k4FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9Wes4aL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-81f4dfa82edso1166902b3a.0
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 04:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768306384; x=1768911184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yn6xpjrnCqbqcpG1ijdeHcwn4K62gY18RMymEm3vNG0=;
        b=L9Wes4aL9spb1sbdsegGsTdCbpyCvwhVfxmZjpo25dqoeE8DtRHfNrVIuguO8gcRz3
         n67p/A2/8c8IW9IY0FfxpTLl16Fy8yPPbRK+bfq2bMg5EZk4SuwbdutR+hFyiZsEZsCy
         zg4By2KEPEyBhkP1i5E1XKpQl/fS408HSNKLXGAUF5WbpVmQv+04MTuTeN2FMjhwfgbg
         HrDz2rfMKrl0vaEnCwwKFhaG2ZObLjnriPqlX/gpOBySUVBxJu4JghKiqkhARbSDcogn
         eFu60KBoF/63easmb9l4YhowE3C/irRd5AslHGhnmnXPEtHsZ9NKshrUogYergIjRIFG
         YszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768306384; x=1768911184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yn6xpjrnCqbqcpG1ijdeHcwn4K62gY18RMymEm3vNG0=;
        b=j7g/wCZAkYi3JzExDEQp7FozpZF0UkA7ahE0aqzC4bPnbgYMriBgTR/jPjVYz2eqWn
         ASYdFsNDwrEI0HsPrNRejU8qdqkbx+5tx1vf1RZaK5/CZ2B/VFwkVz5C4Z+2XH6Mi3sr
         LMHp8Gw+VQSm4Cmd7uGqshxMlLpQTL5KGaQku7ERA6D0SjmIGvvpebwtOHoIBZ+b0qHZ
         xYd77KDyRTASTfwj37ioyfpT949RqZuDzgiPghhs8S1FUSuBMh8PxOxusJzk4YoUvQcb
         NJ6Iagrx6014bRlg17b9820gO3EN1FqMypXRNWZ54dGHJzauXd7tXACm9f968gol91kE
         NzOg==
X-Gm-Message-State: AOJu0YwTZbC/4hJ4aD4ifKD1uxbsyBfcgFNynTCZnzFjhhOyh3UueGNq
	G9RKgHEA5/NNpXIRJ2iUZi5gcKgIX8Y6Td73QKleN1+td/dh+U97N2+Q
X-Gm-Gg: AY/fxX7bc9eCFnxTXHi8WhVzS6mQjetHUOzVHWrmCBOw8J9t3yf4eSW9bzgScuqhtZK
	K41NRhl7b5v6kUiI6E7JtFLPLsJuE97J6Jlj4fH6oDPEm4HNG+NTt/i/ApphCN6eoaAwHF0qxMA
	2yq8XIMJP6BYaDtgZ5ocfGIhzrA86V8TRT3nbmTq0Wt4qyw2wQalxhrY1x0o8XtOhHXtwGROh6T
	I3LH3hURrxTHePi94nA/HTuDzSYgfVya271+7kvrBHOtlUiqUZhFtS+tmvadGUIAWpNlsw1uNh+
	A0ULlI5dxwOS508iSbUQROZHvHp273bzi2cAT3zjKn2FTQQewdU2p3pBN7iQiyFhCF3edzg0EYZ
	xy6vifYQmBCi//8jz9XAsJGeXVbNXjzHtkxMC73ef7fM/grv02pzc7w4ki8JymEGEd6wAmH+/eJ
	fWkzuT8fv/0brKk//rsxEkkmhmVbiVpaNXnKjP3cEWg8mfCp3H5Pi7ObM=
X-Google-Smtp-Source: AGHT+IGmz5X7RmHTN7Om3Y73fhpr1DCMUZXlhaYVrlBKhzxTpjZRQOCkR/MHPw9SZol8kY+ggzWVcg==
X-Received: by 2002:a05:6a00:6c91:b0:81f:3d13:e070 with SMTP id d2e1a72fcca58-81f3d13e574mr9704595b3a.12.1768306384014;
        Tue, 13 Jan 2026 04:13:04 -0800 (PST)
Received: from localhost.localdomain ([2409:891f:1d24:c3f5:8074:4004:163:94af])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81e7fd708fdsm11596703b3a.65.2026.01.13.04.12.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Jan 2026 04:13:03 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: roman.gushchin@linux.dev,
	inwardvessel@gmail.com,
	shakeel.butt@linux.dev,
	akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	mkoutny@suse.com,
	yu.c.chen@intel.com,
	zhao1.liu@intel.com
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 2/3] mm: add support for bpf based numa balancing
Date: Tue, 13 Jan 2026 20:12:37 +0800
Message-ID: <20260113121238.11300-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260113121238.11300-1-laoar.shao@gmail.com>
References: <20260113121238.11300-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_numab_ops enables NUMA balancing for tasks within a specific memcg,
even when global NUMA balancing is disabled. This allows selective NUMA
optimization for workloads that benefit from it, while avoiding potential
latency spikes for other workloads.

The policy must be attached to a leaf memory cgroup. To reduce lookup
overhead, we can cache memcg::bpf_numab in the mm_struct of tasks within
the memcg when it becomes a performance bottleneck.

The cgroup ID is embedded in bpf_numab_ops as a compile-time constant,
which restricts each instance to a single cgroup and prevents attachment
to multiple cgroups. Roman is working on a solution to remove this
limitation, after which we can migrate to the new approach.

Currently only the normal mode is supported.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 MAINTAINERS                          |   1 +
 include/linux/memcontrol.h           |   6 +
 include/linux/sched/numa_balancing.h |  10 +-
 mm/Makefile                          |   5 +
 mm/bpf_numa_balancing.c              | 224 +++++++++++++++++++++++++++
 5 files changed, 245 insertions(+), 1 deletion(-)
 create mode 100644 mm/bpf_numa_balancing.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 70c2b73b3941..0d2c083557e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4807,6 +4807,7 @@ L:	bpf@vger.kernel.org
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	mm/bpf_memcontrol.c
+F:	mm/bpf_numa_balancing.c
 
 BPF [MISC]
 L:	bpf@vger.kernel.org
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 229ac9835adb..b02e8f380275 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -29,6 +29,7 @@ struct obj_cgroup;
 struct page;
 struct mm_struct;
 struct kmem_cache;
+struct bpf_numab_ops;
 
 /* Cgroup-specific page state, on top of universal node page state */
 enum memcg_stat_item {
@@ -284,6 +285,11 @@ struct mem_cgroup {
 	struct lru_gen_mm_list mm_list;
 #endif
 
+#ifdef CONFIG_BPF
+	/* per cgroup NUMA balancing control */
+	struct bpf_numab_ops __rcu *bpf_numab;
+#endif
+
 #ifdef CONFIG_MEMCG_V1
 	/* Legacy consumer-oriented counters */
 	struct page_counter kmem;		/* v1 only */
diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index 792b6665f476..c58d32ab39a7 100644
--- a/include/linux/sched/numa_balancing.h
+++ b/include/linux/sched/numa_balancing.h
@@ -35,17 +35,25 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 				int src_nid, int dst_cpu);
 
 extern struct static_key_false sched_numa_balancing;
+extern struct static_key_false bpf_numab_enabled_key;
+int bpf_numab_hook(struct task_struct *p);
 static inline bool task_numab_enabled(struct task_struct *p)
 {
 	if (static_branch_unlikely(&sched_numa_balancing))
 		return true;
-	return false;
+	if (!static_branch_unlikely(&bpf_numab_enabled_key))
+		return false;
+
+	/* A BPF prog is attached. */
+	return bpf_numab_hook(p);
 }
 
 static inline bool task_numab_mode_normal(void)
 {
 	if (sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL)
 		return true;
+	if (static_branch_unlikely(&bpf_numab_enabled_key))
+		return true;
 	return false;
 }
 
diff --git a/mm/Makefile b/mm/Makefile
index bf46fe31dc14..c2b887491f09 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -107,8 +107,13 @@ ifdef CONFIG_SWAP
 obj-$(CONFIG_MEMCG) += swap_cgroup.o
 endif
 ifdef CONFIG_BPF_SYSCALL
+ifdef CONFIG_NUMA_BALANCING
 obj-$(CONFIG_MEMCG) += bpf_memcontrol.o
 endif
+endif
+ifdef CONFIG_BPF_SYSCALL
+obj-$(CONFIG_MEMCG) += bpf_numa_balancing.o
+endif
 obj-$(CONFIG_CGROUP_HUGETLB) += hugetlb_cgroup.o
 obj-$(CONFIG_GUP_TEST) += gup_test.o
 obj-$(CONFIG_DMAPOOL_TEST) += dmapool_test.o
diff --git a/mm/bpf_numa_balancing.c b/mm/bpf_numa_balancing.c
new file mode 100644
index 000000000000..aac4eec7c6ba
--- /dev/null
+++ b/mm/bpf_numa_balancing.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/memcontrol.h>
+#include <linux/sched/numa_balancing.h>
+
+typedef int numab_fn_t(struct task_struct *p);
+
+struct bpf_numab_ops {
+	numab_fn_t *numab_hook;
+
+	/* TODO:
+	 * The cgroup_id embedded in this struct is set at compile time
+	 * and cannot be modified during BPF program attach time.
+	 * Modifying it at attach time requires libbpf support,
+	 * which is currently under development by Roman.
+	 */
+	int cgroup_id;
+};
+
+static DEFINE_SPINLOCK(numab_ops_lock);
+DEFINE_STATIC_KEY_FALSE(bpf_numab_enabled_key);
+
+int bpf_numab_hook(struct task_struct *p)
+{
+	struct bpf_numab_ops *bpf_numab;
+	struct mem_cgroup *task_memcg;
+	int ret = 0;
+
+	if (!p->mm)
+		return 0;
+
+	/* We can cache memcg::bpf_numab to mm::bpf_numab if it becomes a bettleneck */
+	rcu_read_lock();
+	task_memcg = mem_cgroup_from_task(rcu_dereference(p->mm->owner));
+	if (!task_memcg)
+		goto out;
+
+	/* Users can install BPF NUMA policies on leaf memory cgroups.
+	 * This eliminates the need to traverse the cgroup hierarchy or
+	 * propagate policies during registration, simplifying the kernel design.
+	 */
+	bpf_numab = rcu_dereference(task_memcg->bpf_numab);
+	if (!bpf_numab || !bpf_numab->numab_hook)
+		goto out;
+
+	ret = bpf_numab->numab_hook(p);
+
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
+static const struct bpf_func_proto *
+bpf_numab_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	return bpf_base_func_proto(func_id, prog);
+}
+
+static bool bpf_numab_ops_is_valid_access(int off, int size,
+					  enum bpf_access_type type,
+					  const struct bpf_prog *prog,
+					  struct bpf_insn_access_aux *info)
+{
+	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
+}
+
+static const struct bpf_verifier_ops bpf_numab_verifier_ops = {
+	.get_func_proto = bpf_numab_get_func_proto,
+	.is_valid_access = bpf_numab_ops_is_valid_access,
+};
+
+static int bpf_numab_init(struct btf *btf)
+{
+	return 0;
+}
+
+static int bpf_numab_check_member(const struct btf_type *t,
+				  const struct btf_member *member,
+				  const struct bpf_prog *prog)
+{
+	/* The call site operates under RCU protection. */
+	if (prog->sleepable)
+		return -EINVAL;
+	return 0;
+}
+
+static int bpf_numab_init_member(const struct btf_type *t,
+			       const struct btf_member *member,
+			       void *kdata, const void *udata)
+{
+	const struct bpf_numab_ops *ubpf_numab;
+	struct bpf_numab_ops *kbpf_numab;
+	u32 moff;
+
+	ubpf_numab = (const struct bpf_numab_ops *)udata;
+	kbpf_numab = (struct bpf_numab_ops *)kdata;
+
+	moff = __btf_member_bit_offset(t, member) / 8;
+	switch (moff) {
+	case offsetof(struct bpf_numab_ops, cgroup_id):
+		/* bpf_struct_ops only handles func ptrs and zero-ed members.
+		 * Return 1 to bypass the default handler.
+		 */
+		kbpf_numab->cgroup_id = ubpf_numab->cgroup_id;
+		return 1;
+	}
+	return 0;
+}
+
+static int bpf_numab_reg(void *kdata, struct bpf_link *link)
+{
+	struct bpf_numab_ops *ops = kdata;
+	struct mem_cgroup *memcg;
+	int err = 0;
+
+	/* Only the link mode is supported. */
+	if (!link)
+		return -EOPNOTSUPP;
+
+	/* Depends on CONFIG_SHRINKER_DEBUG */
+	memcg = mem_cgroup_get_from_ino(ops->cgroup_id);
+	if (!memcg || IS_ERR(memcg))
+		return -ENOENT;
+
+	spin_lock(&numab_ops_lock);
+	/* Each memory cgroup can have at most one attached BPF program to ensure
+	 * exclusive control and avoid interference between different BPF policies.
+	 */
+	if (rcu_access_pointer(memcg->bpf_numab)) {
+		err = -EBUSY;
+		goto out;
+	}
+	rcu_assign_pointer(memcg->bpf_numab, ops);
+	spin_unlock(&numab_ops_lock);
+	static_branch_inc(&bpf_numab_enabled_key);
+
+out:
+	mem_cgroup_put(memcg);
+	return err;
+}
+
+static void bpf_numab_unreg(void *kdata, struct bpf_link *link)
+{
+	struct bpf_numab_ops *ops = kdata;
+	struct mem_cgroup *memcg;
+
+	memcg = mem_cgroup_get_from_ino(ops->cgroup_id);
+	if (!memcg)
+		return;
+
+	spin_lock(&numab_ops_lock);
+	if (!rcu_access_pointer(memcg->bpf_numab)) {
+		spin_unlock(&numab_ops_lock);
+		return;
+	}
+	rcu_replace_pointer(memcg->bpf_numab, NULL, lockdep_is_held(&numab_ops_lock));
+	spin_unlock(&numab_ops_lock);
+	static_branch_dec(&bpf_numab_enabled_key);
+	synchronize_rcu();
+}
+
+static int bpf_numab_update(void *kdata, void *old_kdata, struct bpf_link *link)
+{
+	struct bpf_numab_ops *ops = kdata;
+	struct mem_cgroup *memcg;
+
+	memcg = mem_cgroup_get_from_ino(ops->cgroup_id);
+	if (!memcg)
+		return -EINVAL;
+
+	spin_lock(&numab_ops_lock);
+	/* The update can proceed regardless of whether memcg->bpf_numab has been previously set. */
+	rcu_replace_pointer(memcg->bpf_numab, ops, lockdep_is_held(&numab_ops_lock));
+	spin_unlock(&numab_ops_lock);
+	synchronize_rcu();
+	return 0;
+}
+
+static int bpf_numab_validate(void *kdata)
+{
+	struct bpf_numab_ops *ops = kdata;
+
+	if (!ops->numab_hook) {
+		pr_err("bpf_numab: required ops isn't implemented\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int bpf_numa_balancing(struct task_struct *p)
+{
+	return 1;
+}
+
+static struct bpf_numab_ops __bpf_numab_ops = {
+	.numab_hook = (numab_fn_t *)bpf_numa_balancing,
+};
+
+static struct bpf_struct_ops bpf_bpf_numab_ops = {
+	.verifier_ops = &bpf_numab_verifier_ops,
+	.init = bpf_numab_init,
+	.check_member = bpf_numab_check_member,
+	.init_member = bpf_numab_init_member,
+	.reg = bpf_numab_reg,
+	.unreg = bpf_numab_unreg,
+	.update = bpf_numab_update,
+	.validate = bpf_numab_validate,
+	.cfi_stubs = &__bpf_numab_ops,
+	.owner = THIS_MODULE,
+	.name = "bpf_numab_ops",
+};
+
+static int __init bpf_numab_ops_init(void)
+{
+	int err;
+
+	err = register_bpf_struct_ops(&bpf_bpf_numab_ops, bpf_numab_ops);
+	if (err)
+		pr_err("bpf_numab: Failed to register struct_ops (%d)\n", err);
+	return err;
+}
+late_initcall(bpf_numab_ops_init);
-- 
2.43.5


