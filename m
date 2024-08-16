Return-Path: <bpf+bounces-37396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E25955145
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 21:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158191C22E50
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 19:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5781C578C;
	Fri, 16 Aug 2024 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTpz1xca"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161001C460E
	for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723835546; cv=none; b=vBn57K9EOAC/+Y9Hv/vARQNy9Mfem42kwoxhpSdgzHMqL9oj6VO/gdA2pR3y1ThOdxlx8HI0+HsW/TbV3L+ZgRKNp6fT0eM6R1ecHKQQ59e72W1XFVkFV68NSwvCYOnnx1TJb5uj9mOGF0Asds/HGGwOBmH9GTTEo1/fJ+fHqSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723835546; c=relaxed/simple;
	bh=D34mojUig8vZuHPyC8TaZRR0VKlsSdjtAlsD/lb7vLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RoRQ17HBhRrarC7r1mKm2jAAmTzhwz+ZCcgs+/FS6gbeIUXeBsS4ir7qRvVtHlYiqubRQ9u7HbLQ3uIMgwqo7AjC/pFAQKN0pqVqNx/K3MU7DTlAK1FlvLXGspyQcA7+XqMMfalHyuehATZ7AYFQKHEheHrNyzQPuSSsWzOHMW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTpz1xca; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7093705c708so2284810a34.1
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 12:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723835544; x=1724440344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3GlU5Fpsfnwd7Yq8PAloGm0P5P3SvGYUSsiYTJ2NW0=;
        b=QTpz1xcaNN3PB5uWv7rzBOFrL+R74Ck+CPkpngGxHekVJSh+cDfhYUQWeUb+njtqJF
         RNE0RmiS87s/4ajEBYuxeJzw1TiDOQK8yKs7qCByulXD1YBUw2dJ7QMxXu2wCui3yTaY
         RRMdeHasUxrmeDfYYKliB3O5tKGSmrTq+CEWRI21dQyCo7BhUanCrlOfZy5B8nANUI8q
         s1wNtcmjhR2w/DMDbZG42fpTQy7510ZdLZKT/GmIephF/SvqGQXO7EsK+YsH3jGZtxPT
         g4F0cmjtAxgVyNI3qNTBxtKGdNG90opZCEEAXRA2ZAFo5ugUleUIpzvAKFyEvrA980vw
         mWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723835544; x=1724440344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3GlU5Fpsfnwd7Yq8PAloGm0P5P3SvGYUSsiYTJ2NW0=;
        b=FQVzsyyrdMUzYhHyFH+e/14tg5RI+ZpnvLXjMZtZgs3iM8GZuI8Eh9m6AJpMd5HcqZ
         BCpNKjLtr7Ofbhg5cW1pQhRpPKjqyO6kJnX43IqM52k7W1fFNKuFY7QFl52nyDJdu8Sw
         knyfFO2UZKz3K/3Lo3DgjkX5yoe2Tk6e7DSWmKEispN+Q4xXrTR6K3oMWlUbdAymsIP/
         wyUOn83lCD6Hz727kwd3JKtzPFrJqd1np78zlYZ5GAUUhy56NbSxkiCD/i5PW6794tWp
         wYs98DnDQRQt3lGJRrPOkiTVl9OhFCkwP8fsOuHmYVkwi8uMNl0CkCXe5KxAODW1XpuO
         RTiA==
X-Gm-Message-State: AOJu0YzFubQgCV7zKuTtk1ptzKvG8Ebm556dgOX4Vl4/3WSO4KyFdgBA
	qZTAXIEHuEWLflzJZU5kMaRgmMkoWpXDzNwPcft4Q8DOI4LiJ7pmA3E+yv3U
X-Google-Smtp-Source: AGHT+IFG0eHk/XknX8Q6i6RaxxBjk+vVrvyo01EDeczL+6d1mVSvCwFOaHuvC73naxjTTim9fxj2qA==
X-Received: by 2002:a05:6830:d8c:b0:703:6e7e:3e18 with SMTP id 46e09a7af769-70cb329c998mr596488a34.26.1723835543962;
        Fri, 16 Aug 2024 12:12:23 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:ca12:c8db:5571:aa13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9cd7a50dsm7233327b3.94.2024.08.16.12.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 12:12:23 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v4 6/6] selftests/bpf: test __uptr on the value of a task storage map.
Date: Fri, 16 Aug 2024 12:12:13 -0700
Message-Id: <20240816191213.35573-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816191213.35573-1-thinker.li@gmail.com>
References: <20240816191213.35573-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure the memory of uptrs have been mapped to the kernel properly. Also
ensure the values of uptrs in the kernel haven't been copied to userspace.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../bpf/prog_tests/task_local_storage.c       | 106 ++++++++++++++++++
 .../selftests/bpf/progs/task_ls_uptr.c        |  65 +++++++++++
 2 files changed, 171 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/task_ls_uptr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index c33c05161a9e..5709b083021c 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -5,6 +5,7 @@
 #include <unistd.h>
 #include <sched.h>
 #include <pthread.h>
+#include <sys/eventfd.h>
 #include <sys/syscall.h>   /* For SYS_xxx definitions */
 #include <sys/types.h>
 #include <test_progs.h>
@@ -14,6 +15,20 @@
 #include "task_ls_recursion.skel.h"
 #include "task_storage_nodeadlock.skel.h"
 
+struct user_data {
+	int a;
+	int b;
+	int result;
+};
+
+struct value_type {
+	struct user_data *udata;
+};
+
+#define MAGIC_VALUE 0xabcd1234
+
+#include "task_ls_uptr.skel.h"
+
 static void test_sys_enter_exit(void)
 {
 	struct task_local_storage *skel;
@@ -40,6 +55,95 @@ static void test_sys_enter_exit(void)
 	task_local_storage__destroy(skel);
 }
 
+static struct user_data user_data __attribute__((aligned(16))) = {
+	.a = 1,
+	.b = 2,
+};
+
+static void test_uptr(void)
+{
+	struct task_ls_uptr *skel = NULL;
+	int task_fd = -1, ev_fd = -1;
+	struct value_type value;
+	int err, wstatus;
+	__u64 dummy = 1;
+	pid_t pid;
+
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
+	skel = task_ls_uptr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		goto out;
+
+	err = bpf_map_update_elem(bpf_map__fd(skel->maps.datamap), &task_fd, &value, 0);
+	if (!ASSERT_OK(err, "update_datamap"))
+		exit(1);
+
+	err = task_ls_uptr__attach(skel);
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
+	ASSERT_EQ(MAGIC_VALUE + user_data.a + user_data.b,
+		  user_data.result, "result");
+
+	/* Check if user programs can access the value of user kptrs
+	 * through bpf_map_lookup_elem(). Make sure the kernel value is not
+	 * leaked.
+	 */
+	err = bpf_map_lookup_elem(bpf_map__fd(skel->maps.datamap), &task_fd, &value);
+	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
+		goto out;
+	ASSERT_EQ(value.udata, NULL, "lookup_udata");
+
+out:
+	task_ls_uptr__destroy(skel);
+	close(ev_fd);
+	close(task_fd);
+}
+
 static void test_exit_creds(void)
 {
 	struct task_local_storage_exit_creds *skel;
@@ -237,4 +341,6 @@ void test_task_local_storage(void)
 		test_recursion();
 	if (test__start_subtest("nodeadlock"))
 		test_nodeadlock();
+	if (test__start_subtest("uptr"))
+		test_uptr();
 }
diff --git a/tools/testing/selftests/bpf/progs/task_ls_uptr.c b/tools/testing/selftests/bpf/progs/task_ls_uptr.c
new file mode 100644
index 000000000000..473e6890d522
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_ls_uptr.c
@@ -0,0 +1,65 @@
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
+	struct user_data __uptr *udata;
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
+	udata = ptr->udata;
+	if (!udata)
+		return 0;
+	udata->result = MAGIC_VALUE + udata->a + udata->b;
+
+	return 0;
+}
-- 
2.34.1


