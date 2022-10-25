Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7943660D3E0
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 20:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiJYSq0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 14:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbiJYSqS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 14:46:18 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187E315712
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 11:45:56 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666723554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LahaojD6bofe18UT9gbUbHE4FR4B7FwVw0cyJG0A0rY=;
        b=mSA75VC/LlSWtEr8kfQ1LCcgUyBYx4cyaxV3ctODtx0avBGi+OkS5eAgSMBbmoWm7Sf3Ow
        KP/cq270rnGt03NHX0EGoAhYCjLGMFuo1pzmykMPPjj2gQ6Jg2H4zRsLszczDm+x/XKJDC
        JDVxg0EaZQNIMNqLiXZcmonH5NaJgUs=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     'Alexei Starovoitov ' <ast@kernel.org>,
        'Andrii Nakryiko ' <andrii@kernel.org>,
        'Daniel Borkmann ' <daniel@iogearbox.net>,
        'Song Liu ' <songliubraving@meta.com>, kernel-team@meta.com
Subject: [PATCH bpf-next 8/9] selftests/bpf: Ensure no task storage failure for bpf_lsm.s prog due to deadlock detection
Date:   Tue, 25 Oct 2022 11:45:23 -0700
Message-Id: <20221025184524.3526117-9-martin.lau@linux.dev>
In-Reply-To: <20221025184524.3526117-1-martin.lau@linux.dev>
References: <20221025184524.3526117-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch adds a test to check for deadlock failure
in bpf_task_storage_{get,delete} when called by a sleepable bpf_lsm prog.
It also checks if the prog_info.recursion_misses is non zero.

The test starts with 32 threads and they are affinitized to one cpu.
In my qemu setup, with CONFIG_PREEMPT=y, I can reproduce it within
one second if it is run without the previous patches of this set.

Here is the test error message before adding the no deadlock detection
version of the bpf_task_storage_{get,delete}:

test_nodeadlock:FAIL:bpf_task_storage_get busy unexpected bpf_task_storage_get busy: actual 2 != expected 0
test_nodeadlock:FAIL:bpf_task_storage_delete busy unexpected bpf_task_storage_delete busy: actual 2 != expected 0

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../bpf/prog_tests/task_local_storage.c       | 98 +++++++++++++++++++
 .../bpf/progs/task_storage_nodeadlock.c       | 47 +++++++++
 2 files changed, 145 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index 99a42a2b6e14..ae535f5de6a2 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -3,12 +3,15 @@
 
 #define _GNU_SOURCE         /* See feature_test_macros(7) */
 #include <unistd.h>
+#include <sched.h>
+#include <pthread.h>
 #include <sys/syscall.h>   /* For SYS_xxx definitions */
 #include <sys/types.h>
 #include <test_progs.h>
 #include "task_local_storage.skel.h"
 #include "task_local_storage_exit_creds.skel.h"
 #include "task_ls_recursion.skel.h"
+#include "task_storage_nodeadlock.skel.h"
 
 static void test_sys_enter_exit(void)
 {
@@ -93,6 +96,99 @@ static void test_recursion(void)
 	task_ls_recursion__destroy(skel);
 }
 
+static bool stop;
+
+static void waitall(const pthread_t *tids, int nr)
+{
+	int i;
+
+	stop = true;
+	for (i = 0; i < nr; i++)
+		pthread_join(tids[i], NULL);
+}
+
+static void *sock_create_loop(void *arg)
+{
+	struct task_storage_nodeadlock *skel = arg;
+	int fd;
+
+	while (!stop) {
+		fd = socket(AF_INET, SOCK_STREAM, 0);
+		close(fd);
+		if (skel->bss->nr_get_errs || skel->bss->nr_del_errs)
+			stop = true;
+	}
+
+	return NULL;
+}
+
+static void test_nodeadlock(void)
+{
+	struct task_storage_nodeadlock *skel;
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
+	const int nr_threads = 32;
+	pthread_t tids[nr_threads];
+	int i, prog_fd, err;
+	cpu_set_t old, new;
+
+	/* Pin all threads to one cpu to increase the chance of preemption
+	 * in a sleepable bpf prog.
+	 */
+	CPU_ZERO(&new);
+	CPU_SET(0, &new);
+	err = sched_getaffinity(getpid(), sizeof(old), &old);
+	if (!ASSERT_OK(err, "getaffinity"))
+		return;
+	err = sched_setaffinity(getpid(), sizeof(new), &new);
+	if (!ASSERT_OK(err, "setaffinity"))
+		return;
+
+	skel = task_storage_nodeadlock__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto done;
+
+	/* Unnecessary recursion and deadlock detection are reproducible
+	 * in the preemptible kernel.
+	 */
+	if (!skel->kconfig->CONFIG_PREEMPT) {
+		test__skip();
+		goto done;
+	}
+
+	err = task_storage_nodeadlock__attach(skel);
+	ASSERT_OK(err, "attach prog");
+
+	for (i = 0; i < nr_threads; i++) {
+		err = pthread_create(&tids[i], NULL, sock_create_loop, skel);
+		if (err) {
+			/* Only assert once here to avoid excessive
+			 * PASS printing during test failure.
+			 */
+			ASSERT_OK(err, "pthread_create");
+			waitall(tids, i);
+			goto done;
+		}
+	}
+
+	/* With 32 threads, 1s is enough to reproduce the issue */
+	sleep(1);
+	waitall(tids, nr_threads);
+
+	info_len = sizeof(info);
+	prog_fd = bpf_program__fd(skel->progs.socket_post_create);
+	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	ASSERT_OK(err, "get prog info");
+	ASSERT_EQ(info.recursion_misses, 0, "prog recursion");
+
+	ASSERT_EQ(skel->bss->nr_get_errs, 0, "bpf_task_storage_get busy");
+	ASSERT_EQ(skel->bss->nr_del_errs, 0, "bpf_task_storage_delete busy");
+
+done:
+	task_storage_nodeadlock__destroy(skel);
+	sched_setaffinity(getpid(), sizeof(old), &old);
+}
+
 void test_task_local_storage(void)
 {
 	if (test__start_subtest("sys_enter_exit"))
@@ -101,4 +197,6 @@ void test_task_local_storage(void)
 		test_exit_creds();
 	if (test__start_subtest("recursion"))
 		test_recursion();
+	if (test__start_subtest("nodeadlock"))
+		test_nodeadlock();
 }
diff --git a/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c b/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c
new file mode 100644
index 000000000000..ea2dbb80f7b3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+#ifndef EBUSY
+#define EBUSY 16
+#endif
+
+extern bool CONFIG_PREEMPT __kconfig __weak;
+int nr_get_errs = 0;
+int nr_del_errs = 0;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, int);
+} task_storage SEC(".maps");
+
+SEC("lsm.s/socket_post_create")
+int BPF_PROG(socket_post_create, struct socket *sock, int family, int type,
+	     int protocol, int kern)
+{
+	struct task_struct *task;
+	int ret, zero = 0;
+	int *value;
+
+	if (!CONFIG_PREEMPT)
+		return 0;
+
+	task = bpf_get_current_task_btf();
+	value = bpf_task_storage_get(&task_storage, task, &zero,
+				     BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!value)
+		__sync_fetch_and_add(&nr_get_errs, 1);
+
+	ret = bpf_task_storage_delete(&task_storage,
+				      bpf_get_current_task_btf());
+	if (ret == -EBUSY)
+		__sync_fetch_and_add(&nr_del_errs, 1);
+
+	return 0;
+}
-- 
2.30.2

