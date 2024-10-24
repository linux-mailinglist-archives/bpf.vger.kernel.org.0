Return-Path: <bpf+bounces-42980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 426379AD8A6
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 01:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621351C21040
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 23:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917131FF047;
	Wed, 23 Oct 2024 23:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T+9uDgtf"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD241FF7B9
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 23:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727341; cv=none; b=N3SxOqV7nm34R8QDI0lEmmvWaBktcOrMxHfspJirh6Q7HUTzl/tN/ZY7qmO063bNlXDFlz4ApLWx8KULHLTtrw5NVvtvvSayuA/xyvg/0CHLV+EesUVdMaOwaxSc7Pds3TXtVk9R93UcSvYO8w12uB6Z1V3UC104iDOcG7K1ALo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727341; c=relaxed/simple;
	bh=1D+rdEY9EPwJrFsqKLYh9tIcme5QNqtgiLJp4DH19MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krFwIUpZWD/brPiLe3rDZXA+ecZy+zOxToTbUSbYGVLu8RKibr9U7RjrYUVm54OwlVuviuHV4g6cqiWCzYRVY18zoPCwixdjk3Er7B6fR9jpp5liSpinT3wASgrcHLnpsz97XKet4vljVt1qLXxYF46taq2LAMfPNquuPujb55c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T+9uDgtf; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729727337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sru6Ari+0BqR4IGmrLYa4/PP+pSkNwJhuWTKV1JwGKM=;
	b=T+9uDgtfQhjDPwzVl0nCOGhrVaXnKcyvLBC/oMaKEf/h1ti4EOupS2pmqfI6iue261gPbS
	P/UNmjJon1n+cFlSFKh4UZ/XfMjjiKXyIvFf2vjnQmgKKoaEKEUhlIk3EV7OQdbm+nMUuX
	1a3KJDIkHZnUJWhvlRzinUQA0051udU=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v6 bpf-next 12/12] selftests/bpf: Create task_local_storage map with invalid uptr's struct
Date: Wed, 23 Oct 2024 16:47:59 -0700
Message-ID: <20241023234759.860539-13-martin.lau@linux.dev>
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

This patch tests the map creation failure when the map_value
has unsupported uptr. The three cases are the struct is larger
than one page, the struct is empty, and the struct is a kernel struct.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../bpf/prog_tests/task_local_storage.c       | 46 +++++++++++++++++++
 .../selftests/bpf/progs/uptr_map_failure.c    | 27 +++++++++++
 tools/testing/selftests/bpf/test_progs.h      |  8 ++++
 .../testing/selftests/bpf/uptr_test_common.h  | 23 ++++++++++
 4 files changed, 104 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uptr_map_failure.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index 772ed7ce4feb..00cc9d0aee5d 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -10,6 +10,7 @@
 #include <sys/eventfd.h>
 #include <sys/mman.h>
 #include <test_progs.h>
+#include <bpf/btf.h>
 #include "task_local_storage_helpers.h"
 #include "task_local_storage.skel.h"
 #include "task_local_storage_exit_creds.skel.h"
@@ -19,6 +20,7 @@
 #include "task_ls_uptr.skel.h"
 #include "uptr_update_failure.skel.h"
 #include "uptr_failure.skel.h"
+#include "uptr_map_failure.skel.h"
 
 static void test_sys_enter_exit(void)
 {
@@ -452,6 +454,40 @@ static void test_uptr_update_failure(void)
 	close(task_fd);
 }
 
+static void test_uptr_map_failure(const char *map_name, int expected_errno)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, create_attr);
+	struct uptr_map_failure *skel;
+	struct bpf_map *map;
+	struct btf *btf;
+	int map_fd, err;
+
+	skel = uptr_map_failure__open();
+	if (!ASSERT_OK_PTR(skel, "uptr_map_failure__open"))
+		return;
+
+	map = bpf_object__find_map_by_name(skel->obj, map_name);
+	btf = bpf_object__btf(skel->obj);
+	err = btf__load_into_kernel(btf);
+	if (!ASSERT_OK(err, "btf__load_into_kernel"))
+		goto done;
+
+	create_attr.map_flags = bpf_map__map_flags(map);
+	create_attr.btf_fd = btf__fd(btf);
+	create_attr.btf_key_type_id = bpf_map__btf_key_type_id(map);
+	create_attr.btf_value_type_id = bpf_map__btf_value_type_id(map);
+	map_fd = bpf_map_create(bpf_map__type(map), map_name,
+				bpf_map__key_size(map), bpf_map__value_size(map),
+				0, &create_attr);
+	if (ASSERT_ERR_FD(map_fd, "map_create"))
+		ASSERT_EQ(errno, expected_errno, "errno");
+	else
+		close(map_fd);
+
+done:
+	uptr_map_failure__destroy(skel);
+}
+
 void test_task_local_storage(void)
 {
 	if (test__start_subtest("sys_enter_exit"))
@@ -468,5 +504,15 @@ void test_task_local_storage(void)
 		test_uptr_across_pages();
 	if (test__start_subtest("uptr_update_failure"))
 		test_uptr_update_failure();
+	if (test__start_subtest("uptr_map_failure_e2big")) {
+		if (getpagesize() == PAGE_SIZE)
+			test_uptr_map_failure("large_uptr_map", E2BIG);
+		else
+			test__skip();
+	}
+	if (test__start_subtest("uptr_map_failure_size0"))
+		test_uptr_map_failure("empty_uptr_map", EINVAL);
+	if (test__start_subtest("uptr_map_failure_kstruct"))
+		test_uptr_map_failure("kstruct_uptr_map", EINVAL);
 	RUN_TESTS(uptr_failure);
 }
diff --git a/tools/testing/selftests/bpf/progs/uptr_map_failure.c b/tools/testing/selftests/bpf/progs/uptr_map_failure.c
new file mode 100644
index 000000000000..417b763d76b4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uptr_map_failure.c
@@ -0,0 +1,27 @@
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
+	__type(value, struct large_uptr);
+} large_uptr_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct empty_uptr);
+} empty_uptr_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct kstruct_uptr);
+} kstruct_uptr_map SEC(".maps");
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 7767d9a825ae..7a58895867c3 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -390,6 +390,14 @@ int test__join_cgroup(const char *path);
 	___ok;								\
 })
 
+#define ASSERT_ERR_FD(fd, name) ({					\
+	static int duration = 0;					\
+	int ___fd = (fd);						\
+	bool ___ok = ___fd < 0;						\
+	CHECK(!___ok, (name), "unexpected fd: %d\n", ___fd);		\
+	___ok;								\
+})
+
 #define SYS(goto_label, fmt, ...)					\
 	({								\
 		char cmd[1024];						\
diff --git a/tools/testing/selftests/bpf/uptr_test_common.h b/tools/testing/selftests/bpf/uptr_test_common.h
index 45c00c80d935..f8a134ba12f9 100644
--- a/tools/testing/selftests/bpf/uptr_test_common.h
+++ b/tools/testing/selftests/bpf/uptr_test_common.h
@@ -5,9 +5,12 @@
 #define _UPTR_TEST_COMMON_H
 
 #define MAGIC_VALUE 0xabcd1234
+#define PAGE_SIZE 4096
 
 #ifdef __BPF__
 /* Avoid fwd btf type being generated for the following struct */
+struct large_data *dummy_large_data;
+struct empty_data *dummy_empty_data;
 struct user_data *dummy_data;
 struct cgroup *dummy_cgrp;
 #else
@@ -37,4 +40,24 @@ struct value_lock_type {
 	struct bpf_spin_lock lock;
 };
 
+struct large_data {
+	__u8 one_page[PAGE_SIZE];
+	int a;
+};
+
+struct large_uptr {
+	struct large_data __uptr *udata;
+};
+
+struct empty_data {
+};
+
+struct empty_uptr {
+	struct empty_data __uptr *udata;
+};
+
+struct kstruct_uptr {
+	struct cgroup __uptr *cgrp;
+};
+
 #endif
-- 
2.43.5


