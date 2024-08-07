Return-Path: <bpf+bounces-36645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3375F94B3ED
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 01:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563FA1C211B1
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 23:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C31158D8F;
	Wed,  7 Aug 2024 23:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xxb24ku/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5343B158A18
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 23:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723075099; cv=none; b=kePvFzbHejgMumWrBKKz9XZyAWhK0TZht6Ey+hz8h5nF/8jhFYPxERfdKei75yjRt+S41qQagsj27EC1Iy96gFsZEPFrQ2jWJHWkMiCx2500UwsrJIIDSfrBLtzwHCcKb9v9JMcy/hAHPXkmvPRmtGzZcCOMRRDISukvjTwxnnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723075099; c=relaxed/simple;
	bh=xOPPAnmBnnTYEPmny61AKWzV6d0fDUh1VxhzDd9NUyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zu/rjerAaCkMUxGZdcpfHWiTXGxOnthSMm6Lwu2CCDPySGo/Z6yetD+EGW3OpdhmHJ6TLK3tuDTKd6k4TT/h75SIcOhc+fUClzLqxOuksBf2Eineku8knmaqM2+acwNgacs0BwlJF5KfImfG1VCa4hH8w3kcU7rCbyeNDgMbUUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xxb24ku/; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6510c0c8e29so3751507b3.0
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2024 16:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723075096; x=1723679896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXVoBVK5ETwjgiUjFSj90XM56GxfkhTLt3oq18UAJak=;
        b=Xxb24ku/miRIld/dUB7Z9JwWA7hDwQTQeXvAutkCsKGUdNUhuCIDuBKng1ZDcS86W4
         3MHfh88yafa/pwGyE4hpVcgsASKlyxKKROPDHFtgoRdeFSt16bMKCMSV8gfEjhKckNZ/
         S16G+NDeYPnuWKHjcyIxtWUDHq6SoEG4EGhktFx7Zg6p3bG82DLjhhFNypZgmapMlrVg
         ceXhanVabkCQViMaki7vFwR9/GAFrCJMrqS4J4RdOC42zqSO/N5HzVuAKWYRiHxoxWoJ
         spOJFc4IaXA8LugAP9f7xCut78lqCEhQU8wMWAxC7GUXBXzfAnO9wHivWifZ/RlrhX4M
         SebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723075096; x=1723679896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXVoBVK5ETwjgiUjFSj90XM56GxfkhTLt3oq18UAJak=;
        b=FOXalAKYjhjkPB0LhcWsAhbOKdnZrMroICIMEuy0nXaiKYqyYjCfXlziItrOeAm5q+
         f3jqBcj/J9WVss88VKuU0i9d+8lSdGvf8KJVjBuMrN1V0nKZKFPaPVd2j+KPF8wu/rdS
         6X9z/21oG5ba8gykzUOLReckICrCf9i4EfKkkYtjwNrwCr8g0Dn3t0sPBu4+Oy0Ird1p
         srxEPRNku3mBqtlwQWwbjxZGEyGFe9dpeMEcbJ4BsJQL4kYwRSN4vX8ef3zFyIqF8fHV
         E/gOMzU2BcRRdvfKbv0XnbTo0gSI1BHaZbo2diSKl+cYdaL6ASpxdLoxIQUmxt4PlaCy
         LSOQ==
X-Gm-Message-State: AOJu0YybSgbM0dL4kN1EofD4mPODJLONb3viNm2xuH8zpHxOtdWZYPrN
	5y5tRRM0gFRc5pwOWcv0qKWBAD84LA+2utysksC+G8GYgjhB9yqYm/deitL3
X-Google-Smtp-Source: AGHT+IFD+VL0nN+sETog0WZnkzpJ/ugkkZ2JiG4MGO+rBbdLDgN3+NeY+FdIauZPTcpLH1qeIHtBGQ==
X-Received: by 2002:a05:690c:7209:b0:645:8fb:71c8 with SMTP id 00721157ae682-69bfb5f8f46mr1063927b3.37.1723075095939;
        Wed, 07 Aug 2024 16:58:15 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:fb5f:452b:3dfd:192])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a0f419358sm21092477b3.26.2024.08.07.16.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 16:58:15 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next 5/5] selftests/bpf: test __kptr_user on the value of a task storage map.
Date: Wed,  7 Aug 2024 16:57:55 -0700
Message-Id: <20240807235755.1435806-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807235755.1435806-1-thinker.li@gmail.com>
References: <20240807235755.1435806-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure the memory of user kptrs have been mapped to the kernel
properly. Also ensure the values of user kptrs in the kernel haven't been
copied to userspace.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../bpf/prog_tests/task_local_storage.c       | 122 ++++++++++++++++++
 .../selftests/bpf/progs/task_ls_kptr_user.c   |  72 +++++++++++
 2 files changed, 194 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/task_ls_kptr_user.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index c33c05161a9e..17221024fb28 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -5,8 +5,10 @@
 #include <unistd.h>
 #include <sched.h>
 #include <pthread.h>
+#include <sys/eventfd.h>
 #include <sys/syscall.h>   /* For SYS_xxx definitions */
 #include <sys/types.h>
+#include <sys/mman.h>
 #include <test_progs.h>
 #include "task_local_storage_helpers.h"
 #include "task_local_storage.skel.h"
@@ -14,6 +16,21 @@
 #include "task_ls_recursion.skel.h"
 #include "task_storage_nodeadlock.skel.h"
 
+struct user_data {
+	int a;
+	int b;
+	int result;
+};
+
+struct value_type {
+	struct user_data *udata_mmap;
+	struct user_data *udata;
+};
+
+#define MAGIC_VALUE 0xabcd1234
+
+#include "task_ls_kptr_user.skel.h"
+
 static void test_sys_enter_exit(void)
 {
 	struct task_local_storage *skel;
@@ -40,6 +57,109 @@ static void test_sys_enter_exit(void)
 	task_local_storage__destroy(skel);
 }
 
+static void test_kptr_user(void)
+{
+	struct user_data user_data = { .a = 1, .b = 2, .result = 0 };
+	struct user_data user_data_mmap_v = { .a = 7, .b = 7 };
+	struct task_ls_kptr_user *skel = NULL;
+	struct user_data *user_data_mmap;
+	int task_fd = -1, ev_fd = -1;
+	struct value_type value;
+	pid_t pid;
+	int err, wstatus;
+	__u64 dummy = 1;
+
+	user_data_mmap = mmap(NULL, sizeof(*user_data_mmap), PROT_READ | PROT_WRITE,
+			      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (!ASSERT_NEQ(user_data_mmap, MAP_FAILED, "mmap"))
+		return;
+
+	memcpy(user_data_mmap, &user_data_mmap_v, sizeof(*user_data_mmap));
+	value.udata_mmap = user_data_mmap;
+	value.udata = &user_data;
+
+	task_fd = sys_pidfd_open(getpid(), 0);
+	if (!ASSERT_NEQ(task_fd, -1, "sys_pidfd_open"))
+		goto out;
+
+	ev_fd = eventfd(0, 0);
+	if (!ASSERT_NEQ(ev_fd, -1, "eventfd"))
+		goto out;
+
+	skel = task_ls_kptr_user__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		goto out;
+
+	err = bpf_map_update_elem(bpf_map__fd(skel->maps.datamap), &task_fd, &value, 0);
+	if (!ASSERT_OK(err, "update_datamap"))
+		exit(1);
+
+	/* Make sure the BPF program can access the user_data_mmap even if
+	 * it's munmapped already.
+	 */
+	munmap(user_data_mmap, sizeof(*user_data_mmap));
+	user_data_mmap = NULL;
+
+	err = task_ls_kptr_user__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto out;
+
+	fflush(stdout);
+	fflush(stderr);
+
+	pid = fork();
+	if (pid < 0)
+		goto out;
+
+	/* Call syscall in the child process, but access the map value of
+	 * the parent process in the BPF program to check if the user kptr
+	 * is translated/mapped correctly.
+	 */
+	if (pid == 0) {
+		/* child */
+
+		/* Overwrite the user_data in the child process to check if
+		 * the BPF program accesses the user_data of the parent.
+		 */
+		user_data.a = 0;
+		user_data.b = 0;
+
+		/* Wait for the parent to set child_pid */
+		read(ev_fd, &dummy, sizeof(dummy));
+
+		exit(0);
+	}
+
+	skel->bss->parent_pid = syscall(SYS_gettid);
+	skel->bss->child_pid = pid;
+
+	write(ev_fd, &dummy, sizeof(dummy));
+
+	err = waitpid(pid, &wstatus, 0);
+	ASSERT_EQ(err, pid, "waitpid");
+	skel->bss->child_pid = 0;
+
+	ASSERT_EQ(MAGIC_VALUE + user_data.a + user_data.b +
+		  user_data_mmap_v.a + user_data_mmap_v.b,
+		  user_data.result, "result");
+
+	/* Check if user programs can access the value of user kptrs
+	 * through bpf_map_lookup_elem(). Make sure the kernel value is not
+	 * leaked.
+	 */
+	err = bpf_map_lookup_elem(bpf_map__fd(skel->maps.datamap), &task_fd, &value);
+	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
+		goto out;
+	ASSERT_EQ(value.udata_mmap, NULL, "lookup_udata_mmap");
+	ASSERT_EQ(value.udata, NULL, "lookup_udata");
+
+out:
+	task_ls_kptr_user__destroy(skel);
+	close(ev_fd);
+	close(task_fd);
+	munmap(user_data_mmap, sizeof(*user_data_mmap));
+}
+
 static void test_exit_creds(void)
 {
 	struct task_local_storage_exit_creds *skel;
@@ -237,4 +357,6 @@ void test_task_local_storage(void)
 		test_recursion();
 	if (test__start_subtest("nodeadlock"))
 		test_nodeadlock();
+	if (test__start_subtest("kptr_user"))
+		test_kptr_user();
 }
diff --git a/tools/testing/selftests/bpf/progs/task_ls_kptr_user.c b/tools/testing/selftests/bpf/progs/task_ls_kptr_user.c
new file mode 100644
index 000000000000..ff5ca3a5da1e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_ls_kptr_user.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "task_kfunc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct user_data {
+	int a;
+	int b;
+	int result;
+};
+
+struct value_type {
+	struct user_data __kptr_user *udata_mmap;
+	struct user_data __kptr_user *udata;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct value_type);
+} datamap SEC(".maps");
+
+#define MAGIC_VALUE 0xabcd1234
+
+/* This is a workaround to avoid clang generating a forward reference for
+ * struct user_data. This is a known issue and will be fixed in the future.
+ */
+struct user_data __dummy;
+
+pid_t child_pid = 0;
+pid_t parent_pid = 0;
+
+SEC("tp_btf/sys_enter")
+int BPF_PROG(on_enter, struct pt_regs *regs, long id)
+{
+	struct task_struct *task, *data_task;
+	struct value_type *ptr;
+	struct user_data *udata;
+	int acc;
+
+	task = bpf_get_current_task_btf();
+	if (task->pid != child_pid)
+		return 0;
+
+	data_task = bpf_task_from_pid(parent_pid);
+	if (!data_task)
+		return 0;
+
+	ptr = bpf_task_storage_get(&datamap, data_task, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	bpf_task_release(data_task);
+	if (!ptr)
+		return 0;
+
+	udata = ptr->udata_mmap;
+	if (!udata)
+		return 0;
+	acc = udata->a + udata->b;
+
+	udata = ptr->udata;
+	if (!udata)
+		return 0;
+	udata->result = MAGIC_VALUE + udata->a + udata->b + acc;
+
+	return 0;
+}
-- 
2.34.1


