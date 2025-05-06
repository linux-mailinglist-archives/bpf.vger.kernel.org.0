Return-Path: <bpf+bounces-57475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C7DAAB8F8
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C82E7BC325
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5012028E601;
	Tue,  6 May 2025 04:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n7pOeGLs"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B682C2F8DFA
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 01:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746496761; cv=none; b=lwwO1NPnoz+VQF1dPQ2mWl2gqnKDRjRh1vi2Ncfn8Q1qhS3zzAxjkjFWiE++auDDPHblRKWOSE0Pg5d7QEcjisBrqKwh0lWp8pd82FBJEWTz1w5wzi/3zlB10oKi5/AvvxWeh2ngqTEWQha3KmyPH20aTlQQyhzfvoWrktrPnkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746496761; c=relaxed/simple;
	bh=rVMXtcNVZ+35ZH0LH6wv0E2gnu6/mb2uqcoeFLFZ0kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8RNNd4zlp+eK3GLrbqOgsjSAlJtq9mo8O4Dt3fVUUUk+9KIpiDJsf8UrsKtl4jjVbiu5s7XwPX1NWfGu5ignp9zj+axbXN/Ca29H3CZtvm/KCNxHm3oLpl9O9XfEQuA6KZ0KnZGweAccR3ksFrq1JjkC3EKVmyj5IkSfgHUOgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n7pOeGLs; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746496758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rxIMVCBdAGRYBNy9mYJRwNL15xTSbq5/hnlMw2EBes=;
	b=n7pOeGLsPOoBoAUZILVsYW4W4hl9ocft5Sy33XeLlSgnpX3F2f/Z+DjqV17glfKiwhqojI
	9lmoT3Klz6QPrGTCH102f8d2AjnduCMsfERN9fUJ2mjHHM2Y4biVI0Gnx9gvNDUBeORovS
	e9jxL5RXPlrj5psKOglAog268TA99Ng=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	'Kumar Kartikeya Dwivedi ' <memxor@gmail.com>,
	'Amery Hung ' <ameryhung@gmail.com>,
	netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 5/8] selftests/bpf: Add tests for bpf_rbtree_{root,left,right}
Date: Mon,  5 May 2025 18:58:52 -0700
Message-ID: <20250506015857.817950-6-martin.lau@linux.dev>
In-Reply-To: <20250506015857.817950-1-martin.lau@linux.dev>
References: <20250506015857.817950-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch has a much simplified rbtree usage from the
kernel sch_fq qdisc. It has a "struct node_data" which can be
added to two different rbtrees which are ordered by different keys.

The test first populates both rbtrees. Then search for a lookup_key
from the "groot0" rbtree. Once the lookup_key is found, that node
refcount is taken. The node is then removed from another "groot1"
rbtree.

While searching the lookup_key, the test will also try to remove
all rbnodes in the path leading to the lookup_key.

The test_{root,left,right}_spinlock_true tests ensure that the
return value of the bpf_rbtree functions is a non_own_ref node pointer.
This is done by forcing an verifier error by calling a helper
bpf_jiffies64() while holding the spinlock. The tests then
check for the verifier message
"call bpf_rbtree...R0=rcu_ptr_or_null_node..."

The other test_{root,left,right}_spinlock_false tests ensure that
they must be called with spinlock held.

Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com> # Check non_own_ref marking
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/rbtree.c |   6 +
 .../selftests/bpf/progs/rbtree_search.c       | 206 ++++++++++++++++++
 2 files changed, 212 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_search.c

diff --git a/tools/testing/selftests/bpf/prog_tests/rbtree.c b/tools/testing/selftests/bpf/prog_tests/rbtree.c
index 9818f06c97c5..d8f3d7a45fe9 100644
--- a/tools/testing/selftests/bpf/prog_tests/rbtree.c
+++ b/tools/testing/selftests/bpf/prog_tests/rbtree.c
@@ -8,6 +8,7 @@
 #include "rbtree_fail.skel.h"
 #include "rbtree_btf_fail__wrong_node_type.skel.h"
 #include "rbtree_btf_fail__add_wrong_type.skel.h"
+#include "rbtree_search.skel.h"
 
 static void test_rbtree_add_nodes(void)
 {
@@ -187,3 +188,8 @@ void test_rbtree_fail(void)
 {
 	RUN_TESTS(rbtree_fail);
 }
+
+void test_rbtree_search(void)
+{
+	RUN_TESTS(rbtree_search);
+}
diff --git a/tools/testing/selftests/bpf/progs/rbtree_search.c b/tools/testing/selftests/bpf/progs/rbtree_search.c
new file mode 100644
index 000000000000..098ef970fac1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/rbtree_search.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+struct node_data {
+	struct bpf_refcount ref;
+	struct bpf_rb_node r0;
+	struct bpf_rb_node r1;
+	int key0;
+	int key1;
+};
+
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
+private(A) struct bpf_spin_lock glock0;
+private(A) struct bpf_rb_root groot0 __contains(node_data, r0);
+
+private(B) struct bpf_spin_lock glock1;
+private(B) struct bpf_rb_root groot1 __contains(node_data, r1);
+
+#define rb_entry(ptr, type, member) container_of(ptr, type, member)
+#define NR_NODES 16
+
+int zero = 0;
+
+static bool less0(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct node_data *node_a;
+	struct node_data *node_b;
+
+	node_a = rb_entry(a, struct node_data, r0);
+	node_b = rb_entry(b, struct node_data, r0);
+
+	return node_a->key0 < node_b->key0;
+}
+
+static bool less1(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct node_data *node_a;
+	struct node_data *node_b;
+
+	node_a = rb_entry(a, struct node_data, r1);
+	node_b = rb_entry(b, struct node_data, r1);
+
+	return node_a->key1 < node_b->key1;
+}
+
+SEC("syscall")
+__retval(0)
+long rbtree_search(void *ctx)
+{
+	struct bpf_rb_node *rb_n, *rb_m, *gc_ns[NR_NODES];
+	long lookup_key = NR_NODES / 2;
+	struct node_data *n, *m;
+	int i, nr_gc = 0;
+
+	for (i = zero; i < NR_NODES && can_loop; i++) {
+		n = bpf_obj_new(typeof(*n));
+		if (!n)
+			return __LINE__;
+
+		m = bpf_refcount_acquire(n);
+
+		n->key0 = i;
+		m->key1 = i;
+
+		bpf_spin_lock(&glock0);
+		bpf_rbtree_add(&groot0, &n->r0, less0);
+		bpf_spin_unlock(&glock0);
+
+		bpf_spin_lock(&glock1);
+		bpf_rbtree_add(&groot1, &m->r1, less1);
+		bpf_spin_unlock(&glock1);
+	}
+
+	n = NULL;
+	bpf_spin_lock(&glock0);
+	rb_n = bpf_rbtree_root(&groot0);
+	while (can_loop) {
+		if (!rb_n) {
+			bpf_spin_unlock(&glock0);
+			return __LINE__;
+		}
+
+		n = rb_entry(rb_n, struct node_data, r0);
+		if (lookup_key == n->key0)
+			break;
+		if (nr_gc < NR_NODES)
+			gc_ns[nr_gc++] = rb_n;
+		if (lookup_key < n->key0)
+			rb_n = bpf_rbtree_left(&groot0, rb_n);
+		else
+			rb_n = bpf_rbtree_right(&groot0, rb_n);
+	}
+
+	if (!n || lookup_key != n->key0) {
+		bpf_spin_unlock(&glock0);
+		return __LINE__;
+	}
+
+	for (i = 0; i < nr_gc; i++) {
+		rb_n = gc_ns[i];
+		gc_ns[i] = bpf_rbtree_remove(&groot0, rb_n);
+	}
+
+	m = bpf_refcount_acquire(n);
+	bpf_spin_unlock(&glock0);
+
+	for (i = 0; i < nr_gc; i++) {
+		rb_n = gc_ns[i];
+		if (rb_n) {
+			n = rb_entry(rb_n, struct node_data, r0);
+			bpf_obj_drop(n);
+		}
+	}
+
+	if (!m)
+		return __LINE__;
+
+	bpf_spin_lock(&glock1);
+	rb_m = bpf_rbtree_remove(&groot1, &m->r1);
+	bpf_spin_unlock(&glock1);
+	bpf_obj_drop(m);
+	if (!rb_m)
+		return __LINE__;
+	bpf_obj_drop(rb_entry(rb_m, struct node_data, r1));
+
+	return 0;
+}
+
+#define TEST_ROOT(dolock)				\
+SEC("syscall")						\
+__failure __msg(MSG)					\
+long test_root_spinlock_##dolock(void *ctx)		\
+{							\
+	struct bpf_rb_node *rb_n;			\
+	__u64 jiffies = 0;				\
+							\
+	if (dolock)					\
+		bpf_spin_lock(&glock0);			\
+	rb_n = bpf_rbtree_root(&groot0);		\
+	if (rb_n)					\
+		jiffies = bpf_jiffies64();		\
+	if (dolock)					\
+		bpf_spin_unlock(&glock0);		\
+							\
+	return !!jiffies;				\
+}
+
+#define TEST_LR(op, dolock)				\
+SEC("syscall")						\
+__failure __msg(MSG)					\
+long test_##op##_spinlock_##dolock(void *ctx)		\
+{							\
+	struct bpf_rb_node *rb_n;			\
+	struct node_data *n;				\
+	__u64 jiffies = 0;				\
+							\
+	bpf_spin_lock(&glock0);				\
+	rb_n = bpf_rbtree_root(&groot0);		\
+	if (!rb_n) {					\
+		bpf_spin_unlock(&glock0);		\
+		return 1;				\
+	}						\
+	n = rb_entry(rb_n, struct node_data, r0);	\
+	n = bpf_refcount_acquire(n);			\
+	bpf_spin_unlock(&glock0);			\
+	if (!n)						\
+		return 1;				\
+							\
+	if (dolock)					\
+		bpf_spin_lock(&glock0);			\
+	rb_n = bpf_rbtree_##op(&groot0, &n->r0);	\
+	if (rb_n)					\
+		jiffies = bpf_jiffies64();		\
+	if (dolock)					\
+		bpf_spin_unlock(&glock0);		\
+							\
+	return !!jiffies;				\
+}
+
+/*
+ * Use a spearate MSG macro instead of passing to TEST_XXX(..., MSG)
+ * to ensure the message itself is not in the bpf prog lineinfo
+ * which the verifier includes in its log.
+ * Otherwise, the test_loader will incorrectly match the prog lineinfo
+ * instead of the log generated by the verifier.
+ */
+#define MSG "call bpf_rbtree_root{{.+}}; R0{{(_w)?}}=rcu_ptr_or_null_node_data(id={{[0-9]+}},non_own_ref"
+TEST_ROOT(true)
+#undef MSG
+#define MSG "call bpf_rbtree_{{(left|right).+}}; R0{{(_w)?}}=rcu_ptr_or_null_node_data(id={{[0-9]+}},non_own_ref"
+TEST_LR(left,  true)
+TEST_LR(right, true)
+#undef MSG
+
+#define MSG "bpf_spin_lock at off=0 must be held for bpf_rb_root"
+TEST_ROOT(false)
+TEST_LR(left, false)
+TEST_LR(right, false)
+#undef MSG
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.1


