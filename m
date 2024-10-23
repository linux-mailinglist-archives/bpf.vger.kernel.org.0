Return-Path: <bpf+bounces-42978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F40D29AD8A3
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 01:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32F1283CAF
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 23:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17A61FF7B7;
	Wed, 23 Oct 2024 23:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I9CM/iN5"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E6D1FF7B4
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727336; cv=none; b=i8JKdYNpWmRDySkO5VS84/ckd89rO1VEDo51OaHZffm/hn9wNSIq4BAr6LR+J//aN1ciJ7K4ArP1cHfU2L5IYWxIeBAmeXm5rv9z7dH8rrJNRk19e70nhGwRAg6nDPnUhI3oRxXR+ke0fobtZQLRRhog0TTRzEWYoUbOnq4NoN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727336; c=relaxed/simple;
	bh=zDCt6zGbRK6sOif1jHdELZzbngM3DdOFvbVRw227GpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0v+sRyBc89rst1smpGGBCt3JSjojJ8cq2N+7c97ISPJMyHphfdXsCkGNaE4hiKPE3P1JRtsDABkcmRcx0wNVAiiC9g8AKLcId6hd1bA/WGy4ZXZ/LAUEnoScxcREB+C8m8dgSeRMDVXS9Yi053KEjQXjnkPiVzHOp2K2QXXG2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I9CM/iN5; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729727331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OxLlnaw3vKVZjGzwfDSxBowjq0XZbTPInGG9b0y1VWg=;
	b=I9CM/iN5POsjj/gH/xQQMjVf4EEY2jXJbfcoPkfU2iPpZeonX074JuMrWi1IOvyxZAnaud
	7yCvIP48SjA/TfvmqInq/rlOOzN/ot4dNrugp1Pa1RyvtLl2CK5cMHYQbPWf7WKU8zjQTb
	+QB7CZqvLNiaiozkd1RrvO9b6l9mJxE=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v6 bpf-next 10/12] selftests/bpf: Add update_elem failure test for task storage uptr
Date: Wed, 23 Oct 2024 16:47:57 -0700
Message-ID: <20241023234759.860539-11-martin.lau@linux.dev>
In-Reply-To: <20241023234759.860539-1-martin.lau@linux.dev>
References: <20241023234759.860539-1-martin.lau@linux.dev>
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
 .../selftests/bpf/progs/uptr_update_failure.c | 42 +++++++++++++++++
 .../testing/selftests/bpf/uptr_test_common.h  |  5 +++
 3 files changed, 92 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uptr_update_failure.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index b7af0921b3da..e985665efe7a 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -17,6 +17,7 @@
 #include "task_storage_nodeadlock.skel.h"
 #include "uptr_test_common.h"
 #include "task_ls_uptr.skel.h"
+#include "uptr_update_failure.skel.h"
 
 static void test_sys_enter_exit(void)
 {
@@ -408,6 +409,48 @@ static void test_uptr_across_pages(void)
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
@@ -422,4 +465,6 @@ void test_task_local_storage(void)
 		test_uptr_basic();
 	if (test__start_subtest("uptr_across_pages"))
 		test_uptr_across_pages();
+	if (test__start_subtest("uptr_update_failure"))
+		test_uptr_update_failure();
 }
diff --git a/tools/testing/selftests/bpf/progs/uptr_update_failure.c b/tools/testing/selftests/bpf/progs/uptr_update_failure.c
new file mode 100644
index 000000000000..86c3bb954abc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uptr_update_failure.c
@@ -0,0 +1,42 @@
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
index feb41176888c..45c00c80d935 100644
--- a/tools/testing/selftests/bpf/uptr_test_common.h
+++ b/tools/testing/selftests/bpf/uptr_test_common.h
@@ -32,4 +32,9 @@ struct value_type {
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


