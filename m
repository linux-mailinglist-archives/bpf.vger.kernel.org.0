Return-Path: <bpf+bounces-56269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB04A94006
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 00:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE231B67D16
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 22:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486532561D9;
	Fri, 18 Apr 2025 22:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RCORlsvf"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042FF2561B3
	for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745016458; cv=none; b=BQ86QL/YpVDigpZ9EbVCsisvpjloLZW2t74ge8yXHd14DWrb0m0kzECJT0rWxM3VH8RUbzk3zw5TSi04GwZtJqex8SSbV/ZFch++W9fK9Rn7mIvSWK6JJnfNH3IF+zuQLLo4WnWlrfAdBcxJmWeb814o5WiflGFeGC5qvdtMJIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745016458; c=relaxed/simple;
	bh=FAVDjxgMGD68wDfcuJ9OgkQ6hNFmKo+dnfT7mWT24ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BqS6svYth2VEdAp+xzWD+Zrj5CpAY07jT8gslMmfASooRWmRb3e/cjlMlGR5WLzRDjXPF8IFm+Ab1WYpt4OSRMz0Yu2RIRmWOIoMWv80oYOSQz3ojssFpS5JNNNQAQZ8vpQQqrGr+nKUuhEmaOij7zCxfTiuzjcA9DZprcIoXX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RCORlsvf; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745016455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=npWiVMwD7DIHq80EQckjRfNw4J8zE0gtQXoaeTokPy4=;
	b=RCORlsvflOWcJtCyPfT83iZnWA1EGtV3k29LbEQNybeQYvgFn9vAa5ObV/XdlG9NP0ZTWp
	r39rqn0EuencjeOM+sRwp6chUxH9ejB+FxZIYu0HdBHLG+eU9cnSQ+rnWcFQU7zr4lOK4L
	/SSfqeHBWvkyQsFda2jy5t7gHekMzTo=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	kernel-team@meta.com,
	'Amery Hung ' <ameryhung@gmail.com>
Subject: [RFC PATCH bpf-next 10/12] selftests/bpf: Add test for bpf_list_{front,back}
Date: Fri, 18 Apr 2025 15:46:48 -0700
Message-ID: <20250418224652.105998-11-martin.lau@linux.dev>
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

This patch adds a test for the new bpf_list_{front,back} kfunc.

It also adds a test to ensure the non-owning node pointer cannot
be used after unlock.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../selftests/bpf/prog_tests/linked_list.c    |   2 +
 .../selftests/bpf/progs/linked_list_peek.c    | 104 ++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/linked_list_peek.c

diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
index 77d07e0a4a55..559f45239a83 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -7,6 +7,7 @@
 
 #include "linked_list.skel.h"
 #include "linked_list_fail.skel.h"
+#include "linked_list_peek.skel.h"
 
 static char log_buf[1024 * 1024];
 
@@ -804,4 +805,5 @@ void test_linked_list(void)
 	test_linked_list_success(LIST_IN_LIST, false);
 	test_linked_list_success(LIST_IN_LIST, true);
 	test_linked_list_success(TEST_ALL, false);
+	RUN_TESTS(linked_list_peek);
 }
diff --git a/tools/testing/selftests/bpf/progs/linked_list_peek.c b/tools/testing/selftests/bpf/progs/linked_list_peek.c
new file mode 100644
index 000000000000..26c978091e5b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/linked_list_peek.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+struct node_data {
+	struct bpf_list_node l;
+	int key;
+};
+
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
+private(A) struct bpf_spin_lock glock;
+private(A) struct bpf_list_head ghead __contains(node_data, l);
+
+#define list_entry(ptr, type, member) container_of(ptr, type, member)
+#define NR_NODES 32
+
+int zero = 0;
+
+SEC("syscall")
+__failure __msg("invalid mem access 'scalar'")
+long list_peek_unlock_scalar_node(void *ctx)
+{
+	struct bpf_list_node *l_n;
+	struct node_data *n;
+
+	bpf_spin_lock(&glock);
+	l_n = bpf_list_front(&ghead);
+	bpf_spin_unlock(&glock);
+
+	if (l_n) {
+		n = list_entry(l_n, struct node_data, l);
+		if (n->key == 0)
+			return __LINE__;
+	}
+
+	return 0;
+}
+
+SEC("syscall")
+__retval(0)
+long list_peek(void *ctx)
+{
+	struct bpf_list_node *l_n;
+	struct node_data *n;
+	int i, err = 0;
+
+	bpf_spin_lock(&glock);
+	l_n = bpf_list_front(&ghead);
+	bpf_spin_unlock(&glock);
+	if (l_n)
+		return __LINE__;
+
+	bpf_spin_lock(&glock);
+	l_n = bpf_list_back(&ghead);
+	bpf_spin_unlock(&glock);
+	if (l_n)
+		return __LINE__;
+
+	for (i = zero; i < NR_NODES && can_loop; i++) {
+		n = bpf_obj_new(typeof(*n));
+		if (!n)
+			return __LINE__;
+		n->key = i;
+		bpf_spin_lock(&glock);
+		bpf_list_push_back(&ghead, &n->l);
+		bpf_spin_unlock(&glock);
+	}
+
+	bpf_spin_lock(&glock);
+
+	l_n = bpf_list_front(&ghead);
+	if (!l_n) {
+		err = __LINE__;
+		goto done;
+	}
+
+	n = list_entry(l_n, struct node_data, l);
+	if (n->key != 0) {
+		err = __LINE__;
+		goto done;
+	}
+
+	l_n = bpf_list_back(&ghead);
+	if (!l_n) {
+		err = __LINE__;
+		goto done;
+	}
+
+	n = list_entry(l_n, struct node_data, l);
+	if (n->key != NR_NODES - 1) {
+		err = __LINE__;
+		goto done;
+	}
+
+done:
+	bpf_spin_unlock(&glock);
+	return err;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.1


