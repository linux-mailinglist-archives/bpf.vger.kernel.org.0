Return-Path: <bpf+bounces-41909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB9E99DADC
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 02:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAE57B21EA0
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 00:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E68482EB;
	Tue, 15 Oct 2024 00:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aSgqGV48"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC0150285
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 00:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728953446; cv=none; b=SNbf6WzcaNhh90OM6llkmDlsmRZ5a4SeOw07Ij625/9olaTmduczReYGkj7R++XSbwDomoXIDjzmZ2QpeO0VDC4vgJJJGtPcdbnJI1vp02VU2YwGZi8S2b6Q0ZP6vwKyn5CgTe7MVUpRRmG0WNOcC9dpyt39dMRtMbRTbCrGb+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728953446; c=relaxed/simple;
	bh=iGMeIqK+kOVUnJCR+JTQY82a2XAZgQe03k/TT6CfqMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2MoDmdM5syXHGNP/v8tFt4Xg95hzQ+0VHNSTG6inm4ktmJNGmKJBLPq1R/3LWEizJgP0WMeOoeaO8fUK4aJ2JovEHRCy5UE7GSR4zepyNYpQJl+KDMkWY4QfmOZVlaBlMXCAZX0yyK4NlPfI3YpNjb0qFaxUmTVSeYu8d4o7/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aSgqGV48; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728953443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/6WYrtn3u3mhY3z9OtDumK7nyd5MYlnMvisoK3b50PY=;
	b=aSgqGV48m8J2kTXbofVrSh2EPyBF5LGwxiPPJ6Q4aq7Kfm3MlVu+BCBSIR2mIfZVNsH4e1
	oPrHahdvQXNwHUR/i6a13Y0zzvLbFegrU1vx81uuOU3mMfnexqKpqW0Cji3p+/PBW18BOK
	2HMdkzH/ezVKwH2alLmjsk99Wg7UBI8=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v5 bpf-next 10/12] selftests/bpf: Add update_elem failure test for task storage uptr
Date: Mon, 14 Oct 2024 17:50:00 -0700
Message-ID: <20241015005008.767267-11-martin.lau@linux.dev>
In-Reply-To: <20241015005008.767267-1-martin.lau@linux.dev>
References: <20241015005008.767267-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch test the following failures in syscall update_elem
1. The first update_elem(BPF_F_LOCK) should be EOPNOTSUPP. syscall.c takes
   care of unpinning the uptr.
2. The second update_elem(BPF_EXIST) fails. syscall.c takes care of
   unpinning the uptr.
3. The forth update_elem(BPF_NOEXIST) fails. bpf_local_storage_update
   takes care of unpinning the uptr.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../bpf/prog_tests/task_local_storage.c       | 45 +++++++++++++++++++
 .../selftests/bpf/progs/uptr_update_failure.c | 44 ++++++++++++++++++
 .../testing/selftests/bpf/uptr_test_common.h  |  5 +++
 3 files changed, 94 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uptr_update_failure.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index 9a081aaa26a3..4abe1621c5c0 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -17,6 +17,7 @@
 #include "task_storage_nodeadlock.skel.h"
 #include "uptr_test_common.h"
 #include "task_ls_uptr.skel.h"
+#include "uptr_update_failure.skel.h"
 
 static void test_sys_enter_exit(void)
 {
@@ -404,6 +405,48 @@ static void test_uptr_across_pages(void)
 	munmap(mem, page_size * 2);
 }
 
+static void test_uptr_update_failure(void)
+{
+	struct value_lock_type value = {};
+	struct uptr_update_failure *skel;
+	int err, task_fd, map_fd;
+
+	task_fd = sys_pidfd_open(getpid(), 0);
+	if (!ASSERT_OK_FD(task_fd, "task_fd"))
+		return;
+
+	skel = uptr_update_failure__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		goto out;
+
+	map_fd = bpf_map__fd(skel->maps.datamap);
+
+	value.udata = &udata;
+	err = bpf_map_update_elem(map_fd, &task_fd, &value, BPF_F_LOCK);
+	if (!ASSERT_ERR(err, "update_elem(udata, BPF_F_LOCK)"))
+		goto out;
+	ASSERT_EQ(errno, EOPNOTSUPP, "errno");
+
+	err = bpf_map_update_elem(map_fd, &task_fd, &value, BPF_EXIST);
+	if (!ASSERT_ERR(err, "update_elem(udata, BPF_EXIST)"))
+		goto out;
+	ASSERT_EQ(errno, ENOENT, "errno");
+
+	err = bpf_map_update_elem(map_fd, &task_fd, &value, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "update_elem(udata, BPF_NOEXIST)"))
+		goto out;
+
+	value.udata = &udata2;
+	err = bpf_map_update_elem(map_fd, &task_fd, &value, BPF_NOEXIST);
+	if (!ASSERT_ERR(err, "update_elem(udata2, BPF_NOEXIST)"))
+		goto out;
+	ASSERT_EQ(errno, EEXIST, "errno");
+
+out:
+	uptr_update_failure__destroy(skel);
+	close(task_fd);
+}
+
 void test_task_local_storage(void)
 {
 	if (test__start_subtest("sys_enter_exit"))
@@ -418,4 +461,6 @@ void test_task_local_storage(void)
 		test_uptr_basic();
 	if (test__start_subtest("uptr_across_pages"))
 		test_uptr_across_pages();
+	if (test__start_subtest("uptr_update_failure"))
+		test_uptr_update_failure();
 }
diff --git a/tools/testing/selftests/bpf/progs/uptr_update_failure.c b/tools/testing/selftests/bpf/progs/uptr_update_failure.c
new file mode 100644
index 000000000000..f986e521a053
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uptr_update_failure.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "uptr_test_common.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct value_lock_type);
+} datamap SEC(".maps");
+
+struct user_data __dummy;
+
+/* load test only. not used */
+SEC("syscall")
+int not_used(void *ctx)
+{
+	struct value_lock_type *ptr;
+	struct task_struct *task;
+	struct user_data *udata;
+
+	task = bpf_get_current_task_btf();
+	ptr = bpf_task_storage_get(&datamap, task, 0, 0);
+	if (!ptr)
+		return 0;
+
+	bpf_spin_lock(&ptr->lock);
+
+	udata = ptr->udata;
+	if (!udata) {
+		bpf_spin_unlock(&ptr->lock);
+		return 0;
+	}
+	udata->result = MAGIC_VALUE + udata->a + udata->b;
+
+	bpf_spin_unlock(&ptr->lock);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/uptr_test_common.h b/tools/testing/selftests/bpf/uptr_test_common.h
index eb81bdd31949..1356a61bce36 100644
--- a/tools/testing/selftests/bpf/uptr_test_common.h
+++ b/tools/testing/selftests/bpf/uptr_test_common.h
@@ -31,4 +31,9 @@ struct value_type {
 	struct nested_udata nested;
 };
 
+struct value_lock_type {
+	struct user_data __uptr *udata;
+	struct bpf_spin_lock lock;
+};
+
 #endif
-- 
2.43.5


