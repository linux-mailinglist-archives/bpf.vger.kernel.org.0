Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED455F1CEF
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 16:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJAOr1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Oct 2022 10:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiJAOrZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Oct 2022 10:47:25 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F2A76444;
        Sat,  1 Oct 2022 07:47:24 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id r20so4250481qtn.12;
        Sat, 01 Oct 2022 07:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bzObDDV6G3UN99uqQBo8JNheJgFMgXoLOKtIf7ymH+8=;
        b=qgHkFsUyuzJnZyEvxSfg0ANN1YEGDi+gT1AT/v4jdascDjPQoTaZdzzKb0d/QFqKQ1
         S5UsE28P9M7h3WMiIUDADhP4k6BA+lL1cv/iiOalIyQ2r2OSTHM6CxKz1rWPkkJzG7/Z
         zzeXONiu2Lgoysw56vCXVnNdzO17SGaT6FCRLcrzhuDtSpgujTZBWbp+BSsXCrnlRXAN
         6vgRHkwCpktpORrfhzZH/kgjzD99HcvRH6tp4XuIPKLw2r0ldlSPkHjGhongkgUIAW26
         A2Vbj5Rv5fdzk2YYV4Npnn6dDr4khCgxkDtdD0vKXqqNSr36zNCgqJp8/2uxCrXtso/y
         +f0A==
X-Gm-Message-State: ACrzQf2VuxR89pcHg5zOwvWZymoKnqDta9InydKdEATnL/RNkvTtp3rs
        jQV6mWSuDHv5LTXJPfv3UQ0=
X-Google-Smtp-Source: AMsMyM7YakYogqWN2rAIe0kVeHzi0PK0EhTweq0dcdoTeP4dTqcqEz1So7S1o7wkL6Ke1UNtiqXWjQ==
X-Received: by 2002:ac8:5786:0:b0:35c:aa82:303 with SMTP id v6-20020ac85786000000b0035caa820303mr10837688qta.343.1664635643226;
        Sat, 01 Oct 2022 07:47:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::dcb2])
        by smtp.gmail.com with ESMTPSA id bl11-20020a05620a1a8b00b006ce30a5f892sm5424670qkb.102.2022.10.01.07.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 07:47:22 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev
Cc:     kernel-team@fb.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yhs@fb.com, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        memxor@gmail.com
Subject: [PATCH v2 2/2] bpf/selftests: Add selftests for new task kfuncs
Date:   Sat,  1 Oct 2022 09:47:16 -0500
Message-Id: <20221001144716.3403120-3-void@manifault.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001144716.3403120-1-void@manifault.com>
References: <20221001144716.3403120-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A previous change added a series of kfuncs for storing struct
task_struct objects as referenced kptrs. This patch adds a new
task_kfunc test suite for validating their expected behavior.

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../selftests/bpf/prog_tests/task_kfunc.c     | 155 ++++++++++++
 .../selftests/bpf/progs/task_kfunc_common.h   |  83 +++++++
 .../selftests/bpf/progs/task_kfunc_failure.c  | 225 ++++++++++++++++++
 .../selftests/bpf/progs/task_kfunc_success.c  | 113 +++++++++
 5 files changed, 577 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_success.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index 17e074eb42b8..4c34818ec1ee 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -75,3 +75,4 @@ user_ringbuf                             # failed to find kernel BTF type ID of
 lookup_key                               # JIT does not support calling kernel function                                (kfunc)
 verify_pkcs7_sig                         # JIT does not support calling kernel function                                (kfunc)
 kfunc_dynptr_param                       # JIT does not support calling kernel function                                (kfunc)
+task_kfunc                               # JIT does not support calling kernel function
diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
new file mode 100644
index 000000000000..6c577fbca8f7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#define _GNU_SOURCE
+#include <sys/wait.h>
+#include <test_progs.h>
+#include <unistd.h>
+
+#include "task_kfunc_failure.skel.h"
+#include "task_kfunc_success.skel.h"
+
+static size_t log_buf_sz = 1 << 20; /* 1 MB */
+static char obj_log_buf[1048576];
+
+static struct task_kfunc_success *open_load_task_kfunc_skel(void)
+{
+	struct task_kfunc_success *skel;
+	int err;
+
+	skel = task_kfunc_success__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return NULL;
+
+	skel->bss->pid = getpid();
+
+	err = task_kfunc_success__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	return skel;
+
+cleanup:
+	task_kfunc_success__destroy(skel);
+	return NULL;
+}
+
+static void run_success_test(const char *prog_name)
+{
+	struct task_kfunc_success *skel;
+	int status;
+	pid_t child_pid;
+	struct bpf_program *prog;
+	struct bpf_link *link = NULL;
+
+	skel = open_load_task_kfunc_skel();
+	if (!ASSERT_OK_PTR(skel, "open_load_skel"))
+		return;
+
+	if (!ASSERT_OK(skel->bss->err, "pre_spawn_err"))
+		goto cleanup;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto cleanup;
+
+	link = bpf_program__attach(prog);
+	if (!ASSERT_OK_PTR(link, "attached_link"))
+		goto cleanup;
+
+	child_pid = fork();
+	if (!ASSERT_GT(child_pid, -1, "child_pid"))
+		goto cleanup;
+	if (child_pid == 0)
+		_exit(0);
+	waitpid(child_pid, &status, 0);
+
+	ASSERT_OK(skel->bss->err, "post_wait_err");
+
+cleanup:
+	bpf_link__destroy(link);
+	task_kfunc_success__destroy(skel);
+}
+
+static const char * const success_tests[] = {
+	"test_task_acquire_release",
+	"test_task_acquire_leave_in_map",
+	"test_task_xchg_release",
+	"test_task_get_release",
+};
+
+static struct {
+	const char *prog_name;
+	const char *expected_err_msg;
+} failure_tests[] = {
+	{"task_kfunc_acquire_untrusted", "arg#0 pointer type STRUCT task_struct must point"},
+	{"task_kfunc_acquire_null", "arg#0 pointer type STRUCT task_struct must point"},
+	{"task_kfunc_acquire_unreleased", "Unreleased reference"},
+	{"task_kfunc_get_non_kptr_param", "arg#0 expected pointer to map value"},
+	{"task_kfunc_get_non_kptr_acquired", "arg#0 expected pointer to map value"},
+	{"task_kfunc_get_null", "arg#0 expected pointer to map value"},
+	{"task_kfunc_xchg_unreleased", "Unreleased reference"},
+	{"task_kfunc_get_unreleased", "Unreleased reference"},
+	{"task_kfunc_release_untrusted", "arg#0 pointer type STRUCT task_struct must point"},
+	{"task_kfunc_release_null", "arg#0 pointer type STRUCT task_struct must point"},
+	{"task_kfunc_release_unacquired", "R1 must be referenced"},
+};
+
+static void verify_fail(const char *prog_name, const char *expected_err_msg)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+	struct task_kfunc_failure *skel;
+	int err, i;
+
+	opts.kernel_log_buf = obj_log_buf;
+	opts.kernel_log_size = log_buf_sz;
+	opts.kernel_log_level = 1;
+
+	skel = task_kfunc_failure__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "task_kfunc_failure__open_opts"))
+		goto cleanup;
+
+	skel->bss->pid = getpid();
+
+	for (i = 0; i < ARRAY_SIZE(failure_tests); i++) {
+		struct bpf_program *prog;
+		const char *curr_name = failure_tests[i].prog_name;
+
+		prog = bpf_object__find_program_by_name(skel->obj, curr_name);
+		if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+			goto cleanup;
+
+		bpf_program__set_autoload(prog, !strcmp(curr_name, prog_name));
+	}
+
+	err = task_kfunc_failure__load(skel);
+	if (!ASSERT_ERR(err, "unexpected load success"))
+		goto cleanup;
+
+	if (!ASSERT_OK_PTR(strstr(obj_log_buf, expected_err_msg), "expected_err_msg")) {
+		fprintf(stderr, "Expected err_msg: %s\n", expected_err_msg);
+		fprintf(stderr, "Verifier output: %s\n", obj_log_buf);
+	}
+
+cleanup:
+	task_kfunc_failure__destroy(skel);
+}
+
+void test_task_kfunc(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(success_tests); i++) {
+		if (!test__start_subtest(success_tests[i]))
+			continue;
+
+		run_success_test(success_tests[i]);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(failure_tests); i++) {
+		if (!test__start_subtest(failure_tests[i].prog_name))
+			continue;
+
+		verify_fail(failure_tests[i].prog_name, failure_tests[i].expected_err_msg);
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_common.h b/tools/testing/selftests/bpf/progs/task_kfunc_common.h
new file mode 100644
index 000000000000..bbb0a40572fd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_common.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#ifndef _TASK_KFUNC_COMMON_H
+#define _TASK_KFUNC_COMMON_H
+
+#include <errno.h>
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+struct __tasks_kfunc_map_value {
+	struct task_struct __kptr_ref * task;
+};
+
+struct hash_map {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int);
+	__type(value, struct __tasks_kfunc_map_value);
+	__uint(max_entries, 1);
+} __tasks_kfunc_map SEC(".maps");
+
+struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
+struct task_struct *bpf_task_kptr_get(struct task_struct **pp) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+#define TEST_NAME_SZ 128
+
+/* The pid of the test process used to determine if a newly created task is the test task. */
+int pid;
+
+static inline struct __tasks_kfunc_map_value *tasks_kfunc_map_value_lookup(struct task_struct *p)
+{
+	s32 pid;
+	long status;
+
+	status = bpf_probe_read_kernel(&pid, sizeof(pid), &p->pid);
+	if (status)
+		return NULL;
+
+	return bpf_map_lookup_elem(&__tasks_kfunc_map, &pid);
+}
+
+static inline int tasks_kfunc_map_insert(struct task_struct *p)
+{
+	struct __tasks_kfunc_map_value local, *v;
+	long status;
+	struct task_struct *acquired, *old;
+	s32 pid;
+
+	status = bpf_probe_read_kernel(&pid, sizeof(pid), &p->pid);
+	if (status)
+		return status;
+
+	local.task = NULL;
+	status = bpf_map_update_elem(&__tasks_kfunc_map, &pid, &local, BPF_NOEXIST);
+	if (status)
+		return status;
+
+	v = bpf_map_lookup_elem(&__tasks_kfunc_map, &pid);
+	if (!v) {
+		bpf_map_delete_elem(&__tasks_kfunc_map, &pid);
+		return status;
+	}
+
+	acquired = bpf_task_acquire(p);
+	old = bpf_kptr_xchg(&v->task, acquired);
+	if (old) {
+		bpf_task_release(old);
+		return -EEXIST;
+	}
+
+	return 0;
+}
+
+static inline bool is_test_kfunc_task(struct task_struct *task)
+{
+	int cur_pid = bpf_get_current_pid_tgid() >> 32;
+
+	return pid == cur_pid;
+}
+
+#endif /* _TASK_KFUNC_COMMON_H */
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
new file mode 100644
index 000000000000..4cf01bbc8a16
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#include "task_kfunc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+/* Prototype for all of the program trace events below:
+ *
+ * TRACE_EVENT(task_newtask,
+ *         TP_PROTO(struct task_struct *p, u64 clone_flags)
+ */
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(task_kfunc_acquire_untrusted, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *acquired, *stack_ptr;
+
+	if (!is_test_kfunc_task(task))
+		return 0;
+
+	/* Can't invoke bpf_task_acquire() on an untrusted, random pointer. */
+	stack_ptr = (struct task_struct *)0xcafef00d;
+	acquired = bpf_task_acquire(stack_ptr);
+	bpf_task_release(acquired);
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(task_kfunc_acquire_null, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *acquired;
+
+	if (!is_test_kfunc_task(task))
+		return 0;
+
+	/* Can't invoke bpf_task_acquire() on a NULL pointer. */
+	acquired = bpf_task_acquire(NULL);
+	bpf_task_release(acquired);
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(task_kfunc_acquire_unreleased, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *acquired;
+
+	if (!is_test_kfunc_task(task))
+		return 0;
+
+	acquired = bpf_task_acquire(task);
+
+	/* Acquired task is never released. */
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(task_kfunc_get_non_kptr_param, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *kptr;
+
+	/* Cannot use bpf_task_kptr_get() on a non-kptr, even on a valid task. */
+	kptr = bpf_task_kptr_get(&task);
+	if (!kptr)
+		return 0;
+
+	bpf_task_release(kptr);
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(task_kfunc_get_non_kptr_acquired, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *kptr, *acquired;
+
+	acquired = bpf_task_acquire(task);
+
+	/* Cannot use bpf_task_kptr_get() on a non-kptr, even if it was acquired. */
+	kptr = bpf_task_kptr_get(&acquired);
+	if (!kptr)
+		return 0;
+
+	bpf_task_release(kptr);
+	bpf_task_release(acquired);
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(task_kfunc_get_null, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *kptr;
+
+	/* Cannot use bpf_task_kptr_get() on a NULL pointer. */
+	kptr = bpf_task_kptr_get(NULL);
+	if (!kptr)
+		return 0;
+
+	bpf_task_release(kptr);
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(task_kfunc_xchg_unreleased, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *kptr;
+	struct __tasks_kfunc_map_value *v;
+	int status;
+
+	if (!is_test_kfunc_task(task))
+		return 0;
+
+	status = tasks_kfunc_map_insert(task);
+	if (status)
+		return 0;
+
+	v = tasks_kfunc_map_value_lookup(task);
+	if (!v)
+		return 0;
+
+	kptr = bpf_kptr_xchg(&v->task, NULL);
+	if (!kptr)
+		return 0;
+
+
+	/* Kptr retrieved from map is never released. */
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(task_kfunc_get_unreleased, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *kptr;
+	struct __tasks_kfunc_map_value *v;
+	int status;
+
+	if (!is_test_kfunc_task(task))
+		return 0;
+
+	status = tasks_kfunc_map_insert(task);
+	if (status)
+		return 0;
+
+	v = tasks_kfunc_map_value_lookup(task);
+	if (!v)
+		return 0;
+
+	kptr = bpf_task_kptr_get(&v->task);
+	if (!kptr)
+		return 0;
+
+
+	/* Kptr acquired above is never released. */
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(task_kfunc_release_untrusted, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *acquired = (struct task_struct *)0xcafef00d;
+
+	if (!is_test_kfunc_task(task))
+		return 0;
+
+	/* Cannot release random on-stack pointer. */
+	bpf_task_release(acquired);
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(task_kfunc_release_null, struct task_struct *task, u64 clone_flags)
+{
+	struct __tasks_kfunc_map_value local, *v;
+	long status;
+	struct task_struct *acquired, *old;
+	s32 pid;
+
+	if (!is_test_kfunc_task(task))
+		return 0;
+
+	status = bpf_probe_read_kernel(&pid, sizeof(pid), &task->pid);
+	if (status)
+		return 0;
+
+	local.task = NULL;
+	status = bpf_map_update_elem(&__tasks_kfunc_map, &pid, &local, BPF_NOEXIST);
+	if (status)
+		return status;
+
+	v = bpf_map_lookup_elem(&__tasks_kfunc_map, &pid);
+	if (!v)
+		return status;
+
+	acquired = bpf_task_acquire(task);
+	old = bpf_kptr_xchg(&v->task, acquired);
+
+	/* old cannot be passed to bpf_task_release() without a NULL check. */
+	bpf_task_release(old);
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(task_kfunc_release_unacquired, struct task_struct *task, u64 clone_flags)
+{
+	if (!is_test_kfunc_task(task))
+		return 0;
+
+	/* Cannot release trusted task pointer which was not acquired. */
+	bpf_task_release(task);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
new file mode 100644
index 000000000000..783d42fa60e4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#include "task_kfunc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+int err;
+
+/* Prototype for all of the program trace events below:
+ *
+ * TRACE_EVENT(task_newtask,
+ *         TP_PROTO(struct task_struct *p, u64 clone_flags)
+ */
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_task_acquire_release, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *acquired;
+
+	if (!is_test_kfunc_task(task))
+		return 0;
+
+	acquired = bpf_task_acquire(task);
+	bpf_task_release(acquired);
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_task_acquire_leave_in_map, struct task_struct *task, u64 clone_flags)
+{
+	long status;
+
+	if (!is_test_kfunc_task(task))
+		return 0;
+
+	status = tasks_kfunc_map_insert(task);
+	if (status)
+		err = 1;
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_task_xchg_release, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *kptr;
+	struct __tasks_kfunc_map_value *v;
+	long status;
+
+	if (!is_test_kfunc_task(task))
+		return 0;
+
+	status = tasks_kfunc_map_insert(task);
+	if (status) {
+		err = 1;
+		return 0;
+	}
+
+	v = tasks_kfunc_map_value_lookup(task);
+	if (!v) {
+		err = 2;
+		return 0;
+	}
+
+	kptr = bpf_kptr_xchg(&v->task, NULL);
+	if (!kptr) {
+		err = 3;
+		return 0;
+	}
+
+	bpf_task_release(kptr);
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_task_get_release, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *kptr;
+	struct __tasks_kfunc_map_value *v;
+	long status;
+
+	if (!is_test_kfunc_task(task))
+		return 0;
+
+	status = tasks_kfunc_map_insert(task);
+	if (status) {
+		err = 1;
+		return 0;
+	}
+
+	v = tasks_kfunc_map_value_lookup(task);
+	if (!v) {
+		err = 2;
+		return 0;
+	}
+
+	kptr = bpf_task_kptr_get(&v->task);
+	if (!kptr) {
+		err = 3;
+		return 0;
+	}
+
+	bpf_task_release(kptr);
+
+	return 0;
+}
-- 
2.37.3

