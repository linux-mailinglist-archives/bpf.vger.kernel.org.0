Return-Path: <bpf+bounces-41907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56D199DAD9
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 02:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D785F1C21468
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 00:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FC5482DD;
	Tue, 15 Oct 2024 00:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xe8SL7ue"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C068E41C79
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 00:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728953441; cv=none; b=GdUybdZ296CFm6UESGbVtsn6kCTFQvOqKHxpFHglUCTjYkEQE7EEnYXOf7a/uTPlZeeV8OcclRLl5IwP50vzFKgl0f8NVvxrklXjS1vSYkJPmkp133zfZBIfMs7B7KRx+0m8iF4DoePs2qiBq5QVuagJpyJdOI/o37C1kdUD8Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728953441; c=relaxed/simple;
	bh=Q30+Ce83D33M0pWz+zz8KzCI0ehUBoJ3kP5AqtsMDDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3G40onLqhCTiI02QWDfsiA1bFsOX3z2Vk3qGTBpmAqFD6EPTRurDLgHBvsg40uoQ6TpsTE/nXR4aRp+5REI/yq5zTsI0Iebxx9nLrcUleJ819Hyx/KLHx53lTzjQ5S/8rNhalaYYwYVOp10XmDrzx1cpdThCBWqN3KcCc3hO1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xe8SL7ue; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728953438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otwiwCdm2oyjYypEuz5bsI2z4lmLvV6DISsgtZBo4G4=;
	b=Xe8SL7uelZZ2zUydAu+pTVra2MmCyFCSVK5r27/wDxBRC/XtTD1gj9evc2ndngVQKuBm3O
	NqAUdkm8KKdNvZjSUhLbjApNPorHD8IiEEvoXArUAUML6iwQHNxgycyhLUSEc5n3AIlPuF
	IM8NQWYvNxQSLv02uGTEAb84HibKeXI=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v5 bpf-next 08/12] selftests/bpf: Some basic __uptr tests
Date: Mon, 14 Oct 2024 17:49:58 -0700
Message-ID: <20241015005008.767267-9-martin.lau@linux.dev>
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

From: Kui-Feng Lee <thinker.li@gmail.com>

Make sure the memory of uptrs have been mapped to the kernel properly.
Also ensure the values of uptrs in the kernel haven't been copied
to userspace.

It also has the syscall update_elem/delete_elem test to test the
pin/unpin code paths.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../bpf/prog_tests/task_local_storage.c       | 142 ++++++++++++++++++
 .../selftests/bpf/progs/task_ls_uptr.c        |  69 +++++++++
 .../testing/selftests/bpf/uptr_test_common.h  |  34 +++++
 3 files changed, 245 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/task_ls_uptr.c
 create mode 100644 tools/testing/selftests/bpf/uptr_test_common.h

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index c33c05161a9e..4c8eadd1f083 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -7,12 +7,15 @@
 #include <pthread.h>
 #include <sys/syscall.h>   /* For SYS_xxx definitions */
 #include <sys/types.h>
+#include <sys/eventfd.h>
 #include <test_progs.h>
 #include "task_local_storage_helpers.h"
 #include "task_local_storage.skel.h"
 #include "task_local_storage_exit_creds.skel.h"
 #include "task_ls_recursion.skel.h"
 #include "task_storage_nodeadlock.skel.h"
+#include "uptr_test_common.h"
+#include "task_ls_uptr.skel.h"
 
 static void test_sys_enter_exit(void)
 {
@@ -227,6 +230,143 @@ static void test_nodeadlock(void)
 	sched_setaffinity(getpid(), sizeof(old), &old);
 }
 
+static struct user_data udata __attribute__((aligned(16))) = {
+	.a = 1,
+	.b = 2,
+};
+
+static struct user_data udata2 __attribute__((aligned(16))) = {
+	.a = 3,
+	.b = 4,
+};
+
+static void check_udata2(int expected)
+{
+	udata2.result = udata2.nested_result = 0;
+	usleep(1);
+	ASSERT_EQ(udata2.result, expected, "udata2.result");
+	ASSERT_EQ(udata2.nested_result, expected, "udata2.nested_result");
+}
+
+static void test_uptr_basic(void)
+{
+	int map_fd, parent_task_fd, ev_fd;
+	struct value_type value = {};
+	struct task_ls_uptr *skel;
+	pid_t child_pid, my_tid;
+	__u64 ev_dummy_data = 1;
+	int err;
+
+	my_tid = syscall(SYS_gettid);
+	parent_task_fd = sys_pidfd_open(my_tid, 0);
+	if (!ASSERT_OK_FD(parent_task_fd, "parent_task_fd"))
+		return;
+
+	ev_fd = eventfd(0, 0);
+	if (!ASSERT_OK_FD(ev_fd, "ev_fd")) {
+		close(parent_task_fd);
+		return;
+	}
+
+	skel = task_ls_uptr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		goto out;
+
+	map_fd = bpf_map__fd(skel->maps.datamap);
+	value.udata = &udata;
+	value.nested.udata = &udata;
+	err = bpf_map_update_elem(map_fd, &parent_task_fd, &value, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "update_elem(udata)"))
+		goto out;
+
+	err = task_ls_uptr__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto out;
+
+	child_pid = fork();
+	if (!ASSERT_NEQ(child_pid, -1, "fork"))
+		goto out;
+
+	/* Call syscall in the child process, but access the map value of
+	 * the parent process in the BPF program to check if the user kptr
+	 * is translated/mapped correctly.
+	 */
+	if (child_pid == 0) {
+		/* child */
+
+		/* Overwrite the user_data in the child process to check if
+		 * the BPF program accesses the user_data of the parent.
+		 */
+		udata.a = 0;
+		udata.b = 0;
+
+		/* Wait for the parent to set child_pid */
+		read(ev_fd, &ev_dummy_data, sizeof(ev_dummy_data));
+		exit(0);
+	}
+
+	skel->bss->parent_pid = my_tid;
+	skel->bss->target_pid = child_pid;
+
+	write(ev_fd, &ev_dummy_data, sizeof(ev_dummy_data));
+
+	err = waitpid(child_pid, NULL, 0);
+	ASSERT_EQ(err, child_pid, "waitpid");
+	ASSERT_EQ(udata.result, MAGIC_VALUE + udata.a + udata.b, "udata.result");
+	ASSERT_EQ(udata.nested_result, MAGIC_VALUE + udata.a + udata.b, "udata.nested_result");
+
+	skel->bss->target_pid = my_tid;
+
+	/* update_elem: uptr changes from udata1 to udata2 */
+	value.udata = &udata2;
+	value.nested.udata = &udata2;
+	err = bpf_map_update_elem(map_fd, &parent_task_fd, &value, BPF_EXIST);
+	if (!ASSERT_OK(err, "update_elem(udata2)"))
+		goto out;
+	check_udata2(MAGIC_VALUE + udata2.a + udata2.b);
+
+	/* update_elem: uptr changes from udata2 uptr to NULL */
+	memset(&value, 0, sizeof(value));
+	err = bpf_map_update_elem(map_fd, &parent_task_fd, &value, BPF_EXIST);
+	if (!ASSERT_OK(err, "update_elem(udata2)"))
+		goto out;
+	check_udata2(0);
+
+	/* update_elem: uptr changes from NULL to udata2 */
+	value.udata = &udata2;
+	value.nested.udata = &udata2;
+	err = bpf_map_update_elem(map_fd, &parent_task_fd, &value, BPF_EXIST);
+	if (!ASSERT_OK(err, "update_elem(udata2)"))
+		goto out;
+	check_udata2(MAGIC_VALUE + udata2.a + udata2.b);
+
+	/* Check if user programs can access the value of user kptrs
+	 * through bpf_map_lookup_elem(). Make sure the kernel value is not
+	 * leaked.
+	 */
+	err = bpf_map_lookup_elem(map_fd, &parent_task_fd, &value);
+	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
+		goto out;
+	ASSERT_EQ(value.udata, NULL, "value.udata");
+	ASSERT_EQ(value.nested.udata, NULL, "value.nested.udata");
+
+	/* delete_elem */
+	err = bpf_map_delete_elem(map_fd, &parent_task_fd);
+	ASSERT_OK(err, "delete_elem(udata2)");
+	check_udata2(0);
+
+	/* update_elem: add uptr back to test map_free */
+	value.udata = &udata2;
+	value.nested.udata = &udata2;
+	err = bpf_map_update_elem(map_fd, &parent_task_fd, &value, BPF_NOEXIST);
+	ASSERT_OK(err, "update_elem(udata2)");
+
+out:
+	task_ls_uptr__destroy(skel);
+	close(ev_fd);
+	close(parent_task_fd);
+}
+
 void test_task_local_storage(void)
 {
 	if (test__start_subtest("sys_enter_exit"))
@@ -237,4 +377,6 @@ void test_task_local_storage(void)
 		test_recursion();
 	if (test__start_subtest("nodeadlock"))
 		test_nodeadlock();
+	if (test__start_subtest("uptr_basic"))
+		test_uptr_basic();
 }
diff --git a/tools/testing/selftests/bpf/progs/task_ls_uptr.c b/tools/testing/selftests/bpf/progs/task_ls_uptr.c
new file mode 100644
index 000000000000..3abb71806efa
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_ls_uptr.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "uptr_test_common.h"
+
+struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+void bpf_cgroup_release(struct cgroup *cgrp) __ksym;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct value_type);
+} datamap SEC(".maps");
+
+/* This is a workaround to avoid clang generating a forward reference for
+ * struct user_data. This is a known issue and will be fixed in the future.
+ */
+struct user_data __dummy;
+
+pid_t target_pid = 0;
+pid_t parent_pid = 0;
+
+SEC("tp_btf/sys_enter")
+int on_enter(__u64 *ctx)
+{
+	struct task_struct *task, *data_task;
+	struct value_type *ptr;
+	struct user_data *udata;
+	struct cgroup *cgrp;
+
+	task = bpf_get_current_task_btf();
+	if (task->pid != target_pid)
+		return 0;
+
+	data_task = bpf_task_from_pid(parent_pid);
+	if (!data_task)
+		return 0;
+
+	ptr = bpf_task_storage_get(&datamap, data_task, 0, 0);
+	bpf_task_release(data_task);
+	if (!ptr)
+		return 0;
+
+	cgrp = bpf_kptr_xchg(&ptr->cgrp, NULL);
+	if (cgrp) {
+		/* Avoid fwd cgroup type in btf */
+		int lvl = cgrp->level;
+
+		bpf_cgroup_release(cgrp);
+		return lvl;
+	}
+
+	udata = ptr->udata;
+	if (!udata || udata->result)
+		return 0;
+	udata->result = MAGIC_VALUE + udata->a + udata->b;
+
+	udata = ptr->nested.udata;
+	if (udata && !udata->nested_result)
+		udata->nested_result = udata->result;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/uptr_test_common.h b/tools/testing/selftests/bpf/uptr_test_common.h
new file mode 100644
index 000000000000..eb81bdd31949
--- /dev/null
+++ b/tools/testing/selftests/bpf/uptr_test_common.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#ifndef _UPTR_TEST_COMMON_H
+#define _UPTR_TEST_COMMON_H
+
+#define MAGIC_VALUE 0xabcd1234
+
+#ifndef __BPF__
+struct cgroup {
+	int level;
+};
+#define __uptr
+#define __kptr
+#endif
+
+struct user_data {
+	int a;
+	int b;
+	int result;
+	int nested_result;
+};
+
+struct nested_udata {
+	struct user_data __uptr *udata;
+};
+
+struct value_type {
+	struct user_data __uptr *udata;
+	struct cgroup __kptr *cgrp;
+	struct nested_udata nested;
+};
+
+#endif
-- 
2.43.5


