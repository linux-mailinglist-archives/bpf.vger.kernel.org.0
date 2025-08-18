Return-Path: <bpf+bounces-65899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4391DB2AED3
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 19:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18165808C0
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 17:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3430227B35A;
	Mon, 18 Aug 2025 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YJQDKt0c"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A58342CB9
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 17:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536514; cv=none; b=D9zPBY6DY1MnKoIvX8fBR/tIFe8zcxcaKR7gXeWLgTBMjXRsEsyfoFSk8BFGn9XwTuvCa8hXCYFLal/MM6oQxg1FBv6hN2zMt4cfmxGX6NPSHT7pcZXT6eQE10MAyxuEpBw5N0Fz4ebL7POXg/pA878QTF/228beMBYtTNjCzL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536514; c=relaxed/simple;
	bh=nk4cg1zfeP+aFL6Ac5QA/xUBA8OJihACsC6uBn47WzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hn2V6x5AC+zszRyYnEak5bRrW7dYxiUz5f6XmzP6VVUEBQAK9Ol1Bbyd3zhgbdYWY5wRdkHWVDRIclLoid42Z+ttLDNem4rIdFKBttJRbFVkss1hUYVSopZS5L2LZH5PoGmbxia2s0dLMxTvbmFOw69GiSX2nTtjzj43lsiSTfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YJQDKt0c; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755536511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JNLqPQvVnvWTwD+rLbtBhy1f6P7SG3IVoIVxszQU1Bw=;
	b=YJQDKt0cJsjXZZ9sUygYWpuDbmyDiOjE4s2t6gSApi0XBw6W8MPhjjKlpy6QxHC2bfXram
	P7hGTgH0zN0T46at7gjGacKdiLd/ADpgIW8zq4OXHo3ZCbo38vL8c3IYpqR1PyM/sC/YAw
	fX92oeD5jUIm1LhZ09Tkckli3JpasOg=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: linux-mm@kvack.org,
	bpf@vger.kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
Date: Mon, 18 Aug 2025 10:01:23 -0700
Message-ID: <20250818170136.209169-2-roman.gushchin@linux.dev>
In-Reply-To: <20250818170136.209169-1-roman.gushchin@linux.dev>
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce a bpf struct ops for implementing custom OOM handling policies.

The struct ops provides the bpf_handle_out_of_memory() callback,
which expected to return 1 if it was able to free some memory and 0
otherwise.

In the latter case it's guaranteed that the in-kernel OOM killer will
be invoked. Otherwise the kernel also checks the bpf_memory_freed
field of the oom_control structure, which is expected to be set by
kfuncs suitable for releasing memory. It's a safety mechanism which
prevents a bpf program to claim forward progress without actually
releasing memory. The callback program is sleepable to enable using
iterators, e.g. cgroup iterators.

The callback receives struct oom_control as an argument, so it can
easily filter out OOM's it doesn't want to handle, e.g. global vs
memcg OOM's.

The callback is executed just before the kernel victim task selection
algorithm, so all heuristics and sysctls like panic on oom,
sysctl_oom_kill_allocating_task and sysctl_oom_kill_allocating_task
are respected.

The struct ops also has the name field, which allows to define a
custom name for the implemented policy. It's printed in the OOM report
in the oom_policy=<policy> format. "default" is printed if bpf is not
used or policy name is not specified.

[  112.696676] test_progs invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=0, oom_score_adj=0
               oom_policy=bpf_test_policy
[  112.698160] CPU: 1 UID: 0 PID: 660 Comm: test_progs Not tainted 6.16.0-00015-gf09eb0d6badc #102 PREEMPT(full)
[  112.698165] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
[  112.698167] Call Trace:
[  112.698177]  <TASK>
[  112.698182]  dump_stack_lvl+0x4d/0x70
[  112.698192]  dump_header+0x59/0x1c6
[  112.698199]  oom_kill_process.cold+0x8/0xef
[  112.698206]  bpf_oom_kill_process+0x59/0xb0
[  112.698216]  bpf_prog_7ecad0f36a167fd7_test_out_of_memory+0x2be/0x313
[  112.698229]  bpf__bpf_oom_ops_handle_out_of_memory+0x47/0xaf
[  112.698236]  ? srso_alias_return_thunk+0x5/0xfbef5
[  112.698240]  bpf_handle_oom+0x11a/0x1e0
[  112.698250]  out_of_memory+0xab/0x5c0
[  112.698258]  mem_cgroup_out_of_memory+0xbc/0x110
[  112.698274]  try_charge_memcg+0x4b5/0x7e0
[  112.698288]  charge_memcg+0x2f/0xc0
[  112.698293]  __mem_cgroup_charge+0x30/0xc0
[  112.698299]  do_anonymous_page+0x40f/0xa50
[  112.698311]  __handle_mm_fault+0xbba/0x1140
[  112.698317]  ? srso_alias_return_thunk+0x5/0xfbef5
[  112.698335]  handle_mm_fault+0xe6/0x370
[  112.698343]  do_user_addr_fault+0x211/0x6a0
[  112.698354]  exc_page_fault+0x75/0x1d0
[  112.698363]  asm_exc_page_fault+0x26/0x30
[  112.698366] RIP: 0033:0x7fa97236db00

It's possible to load multiple bpf struct programs. In the case of
oom, they will be executed one by one in the same order they been
loaded until one of them returns 1 and bpf_memory_freed is set to 1
- an indication that the memory was freed. This allows to have
multiple bpf programs to focus on different types of OOM's - e.g.
one program can only handle memcg OOM's in one memory cgroup.
But the filtering is done in bpf - so it's fully flexible.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/bpf_oom.h |  49 +++++++++++++
 include/linux/oom.h     |   8 ++
 mm/Makefile             |   3 +
 mm/bpf_oom.c            | 157 ++++++++++++++++++++++++++++++++++++++++
 mm/oom_kill.c           |  22 +++++-
 5 files changed, 237 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/bpf_oom.h
 create mode 100644 mm/bpf_oom.c

diff --git a/include/linux/bpf_oom.h b/include/linux/bpf_oom.h
new file mode 100644
index 000000000000..29cb5ea41d97
--- /dev/null
+++ b/include/linux/bpf_oom.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __BPF_OOM_H
+#define __BPF_OOM_H
+
+struct bpf_oom;
+struct oom_control;
+
+#define BPF_OOM_NAME_MAX_LEN 64
+
+struct bpf_oom_ops {
+	/**
+	 * @handle_out_of_memory: Out of memory bpf handler, called before
+	 * the in-kernel OOM killer.
+	 * @oc: OOM control structure
+	 *
+	 * Should return 1 if some memory was freed up, otherwise
+	 * the in-kernel OOM killer is invoked.
+	 */
+	int (*handle_out_of_memory)(struct oom_control *oc);
+
+	/**
+	 * @name: BPF OOM policy name
+	 */
+	char name[BPF_OOM_NAME_MAX_LEN];
+
+	/* Private */
+	struct bpf_oom *bpf_oom;
+};
+
+#ifdef CONFIG_BPF_SYSCALL
+/**
+ * @bpf_handle_oom: handle out of memory using bpf programs
+ * @oc: OOM control structure
+ *
+ * Returns true if a bpf oom program was executed, returned 1
+ * and some memory was actually freed.
+ */
+bool bpf_handle_oom(struct oom_control *oc);
+
+#else /* CONFIG_BPF_SYSCALL */
+static inline bool bpf_handle_oom(struct oom_control *oc)
+{
+	return false;
+}
+
+#endif /* CONFIG_BPF_SYSCALL */
+
+#endif /* __BPF_OOM_H */
diff --git a/include/linux/oom.h b/include/linux/oom.h
index 1e0fc6931ce9..ef453309b7ea 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -51,6 +51,14 @@ struct oom_control {
 
 	/* Used to print the constraint info. */
 	enum oom_constraint constraint;
+
+#ifdef CONFIG_BPF_SYSCALL
+	/* Used by the bpf oom implementation to mark the forward progress */
+	bool bpf_memory_freed;
+
+	/* Policy name */
+	const char *bpf_policy_name;
+#endif
 };
 
 extern struct mutex oom_lock;
diff --git a/mm/Makefile b/mm/Makefile
index 1a7a11d4933d..a714aba03759 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -105,6 +105,9 @@ obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
 ifdef CONFIG_SWAP
 obj-$(CONFIG_MEMCG) += swap_cgroup.o
 endif
+ifdef CONFIG_BPF_SYSCALL
+obj-y += bpf_oom.o
+endif
 obj-$(CONFIG_CGROUP_HUGETLB) += hugetlb_cgroup.o
 obj-$(CONFIG_GUP_TEST) += gup_test.o
 obj-$(CONFIG_DMAPOOL_TEST) += dmapool_test.o
diff --git a/mm/bpf_oom.c b/mm/bpf_oom.c
new file mode 100644
index 000000000000..47633046819c
--- /dev/null
+++ b/mm/bpf_oom.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * BPF-driven OOM killer customization
+ *
+ * Author: Roman Gushchin <roman.gushchin@linux.dev>
+ */
+
+#include <linux/bpf.h>
+#include <linux/oom.h>
+#include <linux/bpf_oom.h>
+#include <linux/srcu.h>
+
+DEFINE_STATIC_SRCU(bpf_oom_srcu);
+static DEFINE_SPINLOCK(bpf_oom_lock);
+static LIST_HEAD(bpf_oom_handlers);
+
+struct bpf_oom {
+	struct bpf_oom_ops *ops;
+	struct list_head node;
+	struct srcu_struct srcu;
+};
+
+bool bpf_handle_oom(struct oom_control *oc)
+{
+	struct bpf_oom_ops *ops;
+	struct bpf_oom *bpf_oom;
+	int list_idx, idx, ret = 0;
+
+	oc->bpf_memory_freed = false;
+
+	list_idx = srcu_read_lock(&bpf_oom_srcu);
+	list_for_each_entry_srcu(bpf_oom, &bpf_oom_handlers, node, false) {
+		ops = READ_ONCE(bpf_oom->ops);
+		if (!ops || !ops->handle_out_of_memory)
+			continue;
+		idx = srcu_read_lock(&bpf_oom->srcu);
+		oc->bpf_policy_name = ops->name[0] ? &ops->name[0] :
+			"bpf_defined_policy";
+		ret = ops->handle_out_of_memory(oc);
+		oc->bpf_policy_name = NULL;
+		srcu_read_unlock(&bpf_oom->srcu, idx);
+
+		if (ret && oc->bpf_memory_freed)
+			break;
+	}
+	srcu_read_unlock(&bpf_oom_srcu, list_idx);
+
+	return ret && oc->bpf_memory_freed;
+}
+
+static int __handle_out_of_memory(struct oom_control *oc)
+{
+	return 0;
+}
+
+static struct bpf_oom_ops __bpf_oom_ops = {
+	.handle_out_of_memory = __handle_out_of_memory,
+};
+
+static const struct bpf_func_proto *
+bpf_oom_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	return tracing_prog_func_proto(func_id, prog);
+}
+
+static bool bpf_oom_ops_is_valid_access(int off, int size,
+					enum bpf_access_type type,
+					const struct bpf_prog *prog,
+					struct bpf_insn_access_aux *info)
+{
+	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
+}
+
+static const struct bpf_verifier_ops bpf_oom_verifier_ops = {
+	.get_func_proto = bpf_oom_func_proto,
+	.is_valid_access = bpf_oom_ops_is_valid_access,
+};
+
+static int bpf_oom_ops_reg(void *kdata, struct bpf_link *link)
+{
+	struct bpf_oom_ops *ops = kdata;
+	struct bpf_oom *bpf_oom;
+	int ret;
+
+	bpf_oom = kmalloc(sizeof(*bpf_oom), GFP_KERNEL_ACCOUNT);
+	if (!bpf_oom)
+		return -ENOMEM;
+
+	ret = init_srcu_struct(&bpf_oom->srcu);
+	if (ret) {
+		kfree(bpf_oom);
+		return ret;
+	}
+
+	WRITE_ONCE(bpf_oom->ops, ops);
+	ops->bpf_oom = bpf_oom;
+
+	spin_lock(&bpf_oom_lock);
+	list_add_rcu(&bpf_oom->node, &bpf_oom_handlers);
+	spin_unlock(&bpf_oom_lock);
+
+	return 0;
+}
+
+static void bpf_oom_ops_unreg(void *kdata, struct bpf_link *link)
+{
+	struct bpf_oom_ops *ops = kdata;
+	struct bpf_oom *bpf_oom = ops->bpf_oom;
+
+	WRITE_ONCE(bpf_oom->ops, NULL);
+
+	spin_lock(&bpf_oom_lock);
+	list_del_rcu(&bpf_oom->node);
+	spin_unlock(&bpf_oom_lock);
+
+	synchronize_srcu(&bpf_oom->srcu);
+
+	kfree(bpf_oom);
+}
+
+static int bpf_oom_ops_init_member(const struct btf_type *t,
+				   const struct btf_member *member,
+				   void *kdata, const void *udata)
+{
+	const struct bpf_oom_ops *uops = (const struct bpf_oom_ops *)udata;
+	struct bpf_oom_ops *ops = (struct bpf_oom_ops *)kdata;
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+
+	switch (moff) {
+	case offsetof(struct bpf_oom_ops, name):
+		strscpy_pad(ops->name, uops->name, sizeof(ops->name));
+		return 1;
+	}
+	return 0;
+}
+
+static int bpf_oom_ops_init(struct btf *btf)
+{
+	return 0;
+}
+
+static struct bpf_struct_ops bpf_oom_bpf_ops = {
+	.verifier_ops = &bpf_oom_verifier_ops,
+	.reg = bpf_oom_ops_reg,
+	.unreg = bpf_oom_ops_unreg,
+	.init_member = bpf_oom_ops_init_member,
+	.init = bpf_oom_ops_init,
+	.name = "bpf_oom_ops",
+	.owner = THIS_MODULE,
+	.cfi_stubs = &__bpf_oom_ops
+};
+
+static int __init bpf_oom_struct_ops_init(void)
+{
+	return register_bpf_struct_ops(&bpf_oom_bpf_ops, bpf_oom_ops);
+}
+late_initcall(bpf_oom_struct_ops_init);
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 25923cfec9c6..ad7bd65061d6 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -45,6 +45,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/cred.h>
 #include <linux/nmi.h>
+#include <linux/bpf_oom.h>
 
 #include <asm/tlb.h>
 #include "internal.h"
@@ -246,6 +247,15 @@ static const char * const oom_constraint_text[] = {
 	[CONSTRAINT_MEMCG] = "CONSTRAINT_MEMCG",
 };
 
+static const char *oom_policy_name(struct oom_control *oc)
+{
+#ifdef CONFIG_BPF_SYSCALL
+	if (oc->bpf_policy_name)
+		return oc->bpf_policy_name;
+#endif
+	return "default";
+}
+
 /*
  * Determine the type of allocation constraint.
  */
@@ -458,9 +468,10 @@ static void dump_oom_victim(struct oom_control *oc, struct task_struct *victim)
 
 static void dump_header(struct oom_control *oc)
 {
-	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, oom_score_adj=%hd\n",
+	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, oom_score_adj=%hd\noom_policy=%s\n",
 		current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order,
-			current->signal->oom_score_adj);
+		current->signal->oom_score_adj,
+		oom_policy_name(oc));
 	if (!IS_ENABLED(CONFIG_COMPACTION) && oc->order)
 		pr_warn("COMPACTION is disabled!!!\n");
 
@@ -1161,6 +1172,13 @@ bool out_of_memory(struct oom_control *oc)
 		return true;
 	}
 
+	/*
+	 * Let bpf handle the OOM first. If it was able to free up some memory,
+	 * bail out. Otherwise fall back to the kernel OOM killer.
+	 */
+	if (bpf_handle_oom(oc))
+		return true;
+
 	select_bad_process(oc);
 	/* Found nothing?!?! */
 	if (!oc->chosen) {
-- 
2.50.1


