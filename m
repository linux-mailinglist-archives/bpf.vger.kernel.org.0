Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAF360D3E1
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 20:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbiJYSq2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 14:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbiJYSqS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 14:46:18 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46250895F8
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 11:45:58 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666723556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JsqydMh/Z8t373qWG4F0IpAsNPYXlMnSRuTTTINYgE4=;
        b=ee8PXCyPAwW3ExwTev1Hvtad3v/hkhdbVjKFhHu5O0yE2/YTUDjMurSf0PxeymyXUeMr/j
        qT5UhEZP5XbAvOL6ng1HGuZYWnCfviIMA3oYqA3XtjMOZhueu5hNNiEu+Nh7A5aWVXdq+D
        squ/yKp2+1xntrkz/7S0LuG8BQ1/MqQ=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     'Alexei Starovoitov ' <ast@kernel.org>,
        'Andrii Nakryiko ' <andrii@kernel.org>,
        'Daniel Borkmann ' <daniel@iogearbox.net>,
        'Song Liu ' <songliubraving@meta.com>, kernel-team@meta.com
Subject: [PATCH bpf-next 9/9] selftests/bpf: Tracing prog can still do lookup under busy lock
Date:   Tue, 25 Oct 2022 11:45:24 -0700
Message-Id: <20221025184524.3526117-10-martin.lau@linux.dev>
In-Reply-To: <20221025184524.3526117-1-martin.lau@linux.dev>
References: <20221025184524.3526117-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch modifies the task_ls_recursion test to check that
the first bpf_task_storage_get(&map_a, ...) in BPF_PROG(on_update)
can still do the lockless lookup even it cannot acquire the percpu
busy lock.  If the lookup succeeds, it will increment the value
by 1 and the value in the task storage map_a will become 200+1=201.
After that, BPF_PROG(on_update) tries to delete from map_a and
should get -EBUSY because it cannot acquire the percpu busy lock
after finding the data.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../bpf/prog_tests/task_local_storage.c       | 48 ++++++++++++++++++-
 .../selftests/bpf/progs/task_ls_recursion.c   | 43 +++++++++++++++--
 2 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index ae535f5de6a2..a176bd75a748 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -8,6 +8,7 @@
 #include <sys/syscall.h>   /* For SYS_xxx definitions */
 #include <sys/types.h>
 #include <test_progs.h>
+#include "task_local_storage_helpers.h"
 #include "task_local_storage.skel.h"
 #include "task_local_storage_exit_creds.skel.h"
 #include "task_ls_recursion.skel.h"
@@ -78,21 +79,64 @@ static void test_exit_creds(void)
 
 static void test_recursion(void)
 {
+	int err, map_fd, prog_fd, task_fd;
 	struct task_ls_recursion *skel;
-	int err;
+	struct bpf_prog_info info;
+	__u32 info_len = sizeof(info);
+	long value;
+
+	task_fd = sys_pidfd_open(getpid(), 0);
+	if (!ASSERT_NEQ(task_fd, -1, "sys_pidfd_open"))
+		return;
 
 	skel = task_ls_recursion__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
-		return;
+		goto out;
 
 	err = task_ls_recursion__attach(skel);
 	if (!ASSERT_OK(err, "skel_attach"))
 		goto out;
 
 	/* trigger sys_enter, make sure it does not cause deadlock */
+	skel->bss->test_pid = getpid();
 	syscall(SYS_gettid);
+	skel->bss->test_pid = 0;
+	task_ls_recursion__detach(skel);
+
+	/* Refer to the comment in BPF_PROG(on_update) for
+	 * the explanation on the value 201 and 100.
+	 */
+	map_fd = bpf_map__fd(skel->maps.map_a);
+	err = bpf_map_lookup_elem(map_fd, &task_fd, &value);
+	ASSERT_OK(err, "lookup map_a");
+	ASSERT_EQ(value, 201, "map_a value");
+	ASSERT_EQ(skel->bss->nr_del_errs, 1, "bpf_task_storage_delete busy");
+
+	map_fd = bpf_map__fd(skel->maps.map_b);
+	err = bpf_map_lookup_elem(map_fd, &task_fd, &value);
+	ASSERT_OK(err, "lookup map_b");
+	ASSERT_EQ(value, 100, "map_b value");
+
+	prog_fd = bpf_program__fd(skel->progs.on_lookup);
+	memset(&info, 0, sizeof(info));
+	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	ASSERT_OK(err, "get prog info");
+	ASSERT_GT(info.recursion_misses, 0, "on_lookup prog recursion");
+
+	prog_fd = bpf_program__fd(skel->progs.on_update);
+	memset(&info, 0, sizeof(info));
+	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	ASSERT_OK(err, "get prog info");
+	ASSERT_EQ(info.recursion_misses, 0, "on_update prog recursion");
+
+	prog_fd = bpf_program__fd(skel->progs.on_enter);
+	memset(&info, 0, sizeof(info));
+	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	ASSERT_OK(err, "get prog info");
+	ASSERT_EQ(info.recursion_misses, 0, "on_enter prog recursion");
 
 out:
+	close(task_fd);
 	task_ls_recursion__destroy(skel);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/task_ls_recursion.c b/tools/testing/selftests/bpf/progs/task_ls_recursion.c
index 564583dca7c8..4542dc683b44 100644
--- a/tools/testing/selftests/bpf/progs/task_ls_recursion.c
+++ b/tools/testing/selftests/bpf/progs/task_ls_recursion.c
@@ -5,7 +5,13 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
+#ifndef EBUSY
+#define EBUSY 16
+#endif
+
 char _license[] SEC("license") = "GPL";
+int nr_del_errs = 0;
+int test_pid = 0;
 
 struct {
 	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
@@ -26,6 +32,13 @@ int BPF_PROG(on_lookup)
 {
 	struct task_struct *task = bpf_get_current_task_btf();
 
+	if (!test_pid || task->pid != test_pid)
+		return 0;
+
+	/* The bpf_task_storage_delete will call
+	 * bpf_local_storage_lookup.  The prog->active will
+	 * stop the recursion.
+	 */
 	bpf_task_storage_delete(&map_a, task);
 	bpf_task_storage_delete(&map_b, task);
 	return 0;
@@ -37,11 +50,32 @@ int BPF_PROG(on_update)
 	struct task_struct *task = bpf_get_current_task_btf();
 	long *ptr;
 
+	if (!test_pid || task->pid != test_pid)
+		return 0;
+
 	ptr = bpf_task_storage_get(&map_a, task, 0,
 				   BPF_LOCAL_STORAGE_GET_F_CREATE);
-	if (ptr)
+	/* ptr will not be NULL when it is called from
+	 * the bpf_task_storage_get(&map_b,...F_CREATE) in
+	 * the BPF_PROG(on_enter) below.  It is because
+	 * the value can be found in map_a and the kernel
+	 * does not need to acquire any spin_lock.
+	 */
+	if (ptr) {
+		int err;
+
 		*ptr += 1;
+		err = bpf_task_storage_delete(&map_a, task);
+		if (err == -EBUSY)
+			nr_del_errs++;
+	}
 
+	/* This will still fail because map_b is empty and
+	 * this BPF_PROG(on_update) has failed to acquire
+	 * the percpu busy lock => meaning potential
+	 * deadlock is detected and it will fail to create
+	 * new storage.
+	 */
 	ptr = bpf_task_storage_get(&map_b, task, 0,
 				   BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (ptr)
@@ -57,14 +91,17 @@ int BPF_PROG(on_enter, struct pt_regs *regs, long id)
 	long *ptr;
 
 	task = bpf_get_current_task_btf();
+	if (!test_pid || task->pid != test_pid)
+		return 0;
+
 	ptr = bpf_task_storage_get(&map_a, task, 0,
 				   BPF_LOCAL_STORAGE_GET_F_CREATE);
-	if (ptr)
+	if (ptr && !*ptr)
 		*ptr = 200;
 
 	ptr = bpf_task_storage_get(&map_b, task, 0,
 				   BPF_LOCAL_STORAGE_GET_F_CREATE);
-	if (ptr)
+	if (ptr && !*ptr)
 		*ptr = 100;
 	return 0;
 }
-- 
2.30.2

