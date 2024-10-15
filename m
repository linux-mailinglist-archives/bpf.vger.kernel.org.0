Return-Path: <bpf+bounces-41911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B76099DADD
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 02:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC2F282F7B
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 00:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449254D8DA;
	Tue, 15 Oct 2024 00:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HmqiYBfX"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E2850285
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 00:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728953451; cv=none; b=PCRSB7fZ17PhJgXxzvFJsT5rN1Rp67pk8jo/dGmqJbyu6eX/GG8dCl1NvMGjG57CmFTF1PjwfifnjJLuwAonwehQwo9V7UWWO7Byi2BR1RLJl2f6RUjGNrTabrzNuZDhkD+lnaHanuPi9yE01RqIVtMn2G9rvNSXyYSK0sMSvuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728953451; c=relaxed/simple;
	bh=cADOfNss6Vt6FY6dU3qbAnK89LJqUEJ0IutnShQyyYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vc7rYf68GTUOY6otuDPu7O5cgDDLrRGL96SR06sGekojwtzkYxwKu1KlUS0TVgVQbgCrzWpAve8dzqkk6FNdZaJHlUWzzi4AZPyXMbt2ZpVmhysV4uQv3xatxHxtaINJ3khIHijA1134QDkjuqNUzl1Ri9cxBSNXEHNf+Bq0E6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HmqiYBfX; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728953448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ki6bqCuubJOtljTc48ZkxQvdEezGObz9kUoNCNQHYCM=;
	b=HmqiYBfX7CXq79x1rAfxd4ot1wMnJf2cIo+o3aWcQQKKEWV4C3AyFotPtR4aHt+1/AoafN
	No5x8WGXB66G7mzLEx6uJQD4nIst6leAUo7un6rebIjMOO8gXxcBlVQeJ++1ZlGcOz3mZ+
	dkaPY0iyfxzmFYAW7cCRQZRTba744sE=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v5 bpf-next 12/12] selftests/bpf: Create task_local_storage map with invalid uptr's struct
Date: Mon, 14 Oct 2024 17:50:02 -0700
Message-ID: <20241015005008.767267-13-martin.lau@linux.dev>
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

This patch tests the map creation failure when the map_value
has unsupported uptr. The two caes are the struct is larger
than one page or the struct is a kernel struct.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../bpf/prog_tests/task_local_storage.c       | 44 +++++++++++++++++
 .../selftests/bpf/progs/uptr_map_failure.c    | 49 +++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h      |  8 +++
 .../testing/selftests/bpf/uptr_test_common.h  | 14 ++++++
 4 files changed, 115 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uptr_map_failure.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index 55e36956bf52..8076545e064e 100644
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
@@ -448,6 +450,40 @@ static void test_uptr_update_failure(void)
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
@@ -464,5 +500,13 @@ void test_task_local_storage(void)
 		test_uptr_across_pages();
 	if (test__start_subtest("uptr_update_failure"))
 		test_uptr_update_failure();
+	if (test__start_subtest("uptr_map_failure_e2big")) {
+		if (getpagesize() == PAGE_SIZE)
+			test_uptr_map_failure("large_uptr_map", E2BIG);
+		else
+			test__skip();
+	}
+	if (test__start_subtest("uptr_map_failure_kstruct"))
+		test_uptr_map_failure("kstruct_uptr_map", EINVAL);
 	RUN_TESTS(uptr_failure);
 }
diff --git a/tools/testing/selftests/bpf/progs/uptr_map_failure.c b/tools/testing/selftests/bpf/progs/uptr_map_failure.c
new file mode 100644
index 000000000000..f3afc2e5aff6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uptr_map_failure.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "uptr_test_common.h"
+
+/* Avoid fwd btf type */
+struct large_data dummy_large_data;
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
+	__type(value, struct kstruct_uptr);
+} kstruct_uptr_map SEC(".maps");
+
+/* compile only. not loaded */
+SEC("?syscall")
+int not_loaded(const void *ctx)
+{
+	struct kstruct_uptr *kstruct_uptr;
+	struct large_uptr *large_uptr;
+	struct task_struct *task;
+
+	task = bpf_get_current_task_btf();
+
+	kstruct_uptr = bpf_task_storage_get(&kstruct_uptr_map, task, NULL,
+					    BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!kstruct_uptr)
+		return 0;
+
+	if (kstruct_uptr->cgrp)
+		return kstruct_uptr->cgrp->level;
+
+	large_uptr = bpf_task_storage_get(&large_uptr_map, task, NULL,
+					  BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (large_uptr && large_uptr->udata)
+		large_uptr->udata->a = 0;
+
+	return 0;
+}
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
index 1356a61bce36..c332d7be6631 100644
--- a/tools/testing/selftests/bpf/uptr_test_common.h
+++ b/tools/testing/selftests/bpf/uptr_test_common.h
@@ -5,6 +5,7 @@
 #define _UPTR_TEST_COMMON_H
 
 #define MAGIC_VALUE 0xabcd1234
+#define PAGE_SIZE 4096
 
 #ifndef __BPF__
 struct cgroup {
@@ -36,4 +37,17 @@ struct value_lock_type {
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
+struct kstruct_uptr {
+	struct cgroup __uptr *cgrp;
+};
+
 #endif
-- 
2.43.5


