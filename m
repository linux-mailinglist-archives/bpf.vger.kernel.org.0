Return-Path: <bpf+bounces-56266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF26AA94005
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 00:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5B43BDE0E
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 22:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E6B255247;
	Fri, 18 Apr 2025 22:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S+sPtX2P"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A70255229
	for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 22:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745016451; cv=none; b=poqQZ0amdY+eG0p9cQqcWQnMJ0eYYmiySF1ccvfyJ1GN+5+NfHz9RRvfuEa2mUaGjetOU5MQPZ/ktx4ANhuoecfaqhiWmkOXZqawBx6NX4uREW0q8ilCUPjzZHkXLDDoERjlwXC6fRaJ9xcH+YYLimx1F+UkguO43TypkDc939o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745016451; c=relaxed/simple;
	bh=lC9Bm1Lc9f5Ax6JWpvdySA4XFniaobaJD5K5om4Bu9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UX+DLMnopBfBiVFKdOcCzKTQ1LmusgiHxCKapm64gqH+eAFVeguMH22z4ZGovP+agqnBSixlBkqaiFRu+1WPsenHamLdGhpkGjAhmKsDjKLkPn1wiYKG+YrzPBiSCUTGVdboO/mAgpAccU1F7YIf+qcZsm5SR6Xip7sAMLS/09o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S+sPtX2P; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745016447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OXOHicNF7bqdEgEjAz871TrKeLbksj/UlQAeXjWqm0Y=;
	b=S+sPtX2PV7jZ0ttR+r4FSqYZ3T4DOBuLMnkQ/nIEI8l6RVzGV6BopRylFOliBpSjMqjh58
	fRqiCKC8/BH5jgexhSW2wQc5Md8oq78cHFNhHv+ZHfBUDe5goGPMBHIiXviblQ1RmOXk8H
	gUtishcO9US51AUBU9kjJ7GdyRS7OTM=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	kernel-team@meta.com,
	'Amery Hung ' <ameryhung@gmail.com>
Subject: [RFC PATCH bpf-next 07/12] selftests/bpf: Add rbtree_search test
Date: Fri, 18 Apr 2025 15:46:45 -0700
Message-ID: <20250418224652.105998-8-martin.lau@linux.dev>
In-Reply-To: <20250418224652.105998-1-martin.lau@linux.dev>
References: <20250418224652.105998-1-martin.lau@linux.dev>
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

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/rbtree.c |   6 +
 .../selftests/bpf/progs/rbtree_search.c       | 137 ++++++++++++++++++
 2 files changed, 143 insertions(+)
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
index 000000000000..475f7cf3285f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/rbtree_search.c
@@ -0,0 +1,137 @@
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
+	int i, err, nr_gc = 0;
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
+		err = bpf_rbtree_add(&groot0, &n->r0, less0);
+		bpf_spin_unlock(&glock0);
+
+		bpf_spin_lock(&glock1);
+		err = bpf_rbtree_add(&groot1, &m->r1, less1);
+		bpf_spin_unlock(&glock1);
+
+		if (err)
+			return __LINE__;
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
+char _license[] SEC("license") = "GPL";
-- 
2.47.1


