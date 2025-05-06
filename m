Return-Path: <bpf+bounces-57478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 607B0AAB938
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A216B1C24B9C
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A539028EA46;
	Tue,  6 May 2025 04:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mZjVU8Vf"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBBC307235
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 01:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746496769; cv=none; b=DRxVlJMI76t3gFcS0Jznwq2wrC+vB2qr7YoFOhrzJdC3K04WBli6kpkZTUY177mb9R46mfKF41CBiXzDaruNANvud3ztydomYjfpzcynFbswnvD/ss883AnLegwVkyj+0ydCcQPWUG/u4ekfMj/KJLjtu+RuxY2anXUyHcTaX8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746496769; c=relaxed/simple;
	bh=sGXEJ9UzTKTJ6orUxxf20O42nPHtvGlhnGXRezZo6OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dy+E11YW2pQCKU3G2OF9z6lcBQMzzKuLiaREdlkweOkqQFvOggPQER80ocUEFX7Da2hAwXz2YPVSpHKjfgW/nbs2T5iseSz4beXNaKkEYprpmKhQjUhqJ1pwgkuB6K9uwvpbQP7uRyTggXaAqeITzVJqvKfTeJ0c8B/2mNWND0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mZjVU8Vf; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746496765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKYIeM0rTydpOKf0DepkQmkMK1bRwSRWPs+8CNcvjiE=;
	b=mZjVU8VfpLD0DMw0NQOXY3R3xtev2q7dX2YpkrgCAONrABzRUKOcjxPcJ4bmcGYY62Lsp1
	iSg1QvAft4+GxqBYSMsWXOllhZqsWgln7HbRfz2RvIe6mxTygK3XpOQu697pkIArpMOx+Z
	TNC8cakKxAnkWyKgmd2yYqnqN6gW6c4=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	'Kumar Kartikeya Dwivedi ' <memxor@gmail.com>,
	'Amery Hung ' <ameryhung@gmail.com>,
	netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 8/8] selftests/bpf: Add test for bpf_list_{front,back}
Date: Mon,  5 May 2025 18:58:55 -0700
Message-ID: <20250506015857.817950-9-martin.lau@linux.dev>
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

This patch adds the "list_peek" test to use the new
bpf_list_{front,back} kfunc.

The test_{front,back}* tests ensure that the return value
is a non_own_ref node pointer and requires the spinlock to be held.

Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com> # check non_own_ref marking
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../selftests/bpf/prog_tests/linked_list.c    |   6 +
 .../selftests/bpf/progs/linked_list_peek.c    | 113 ++++++++++++++++++
 2 files changed, 119 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/linked_list_peek.c

diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
index 77d07e0a4a55..5266c7022863 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -7,6 +7,7 @@
 
 #include "linked_list.skel.h"
 #include "linked_list_fail.skel.h"
+#include "linked_list_peek.skel.h"
 
 static char log_buf[1024 * 1024];
 
@@ -805,3 +806,8 @@ void test_linked_list(void)
 	test_linked_list_success(LIST_IN_LIST, true);
 	test_linked_list_success(TEST_ALL, false);
 }
+
+void test_linked_list_peek(void)
+{
+	RUN_TESTS(linked_list_peek);
+}
diff --git a/tools/testing/selftests/bpf/progs/linked_list_peek.c b/tools/testing/selftests/bpf/progs/linked_list_peek.c
new file mode 100644
index 000000000000..264e81bfb287
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/linked_list_peek.c
@@ -0,0 +1,113 @@
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
+#define NR_NODES 16
+
+int zero = 0;
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
+#define TEST_FB(op, dolock)					\
+SEC("syscall")							\
+__failure __msg(MSG)						\
+long test_##op##_spinlock_##dolock(void *ctx)			\
+{								\
+	struct bpf_list_node *l_n;				\
+	__u64 jiffies = 0;					\
+								\
+	if (dolock)						\
+		bpf_spin_lock(&glock);				\
+	l_n = bpf_list_##op(&ghead);				\
+	if (l_n)						\
+		jiffies = bpf_jiffies64();			\
+	if (dolock)						\
+		bpf_spin_unlock(&glock);			\
+								\
+	return !!jiffies;					\
+}
+
+#define MSG "call bpf_list_{{(front|back).+}}; R0{{(_w)?}}=ptr_or_null_node_data(id={{[0-9]+}},non_own_ref"
+TEST_FB(front, true)
+TEST_FB(back, true)
+#undef MSG
+
+#define MSG "bpf_spin_lock at off=0 must be held for bpf_list_head"
+TEST_FB(front, false)
+TEST_FB(back, false)
+#undef MSG
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.1


