Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070975FF468
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 22:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiJNUPc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 16:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiJNUPM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 16:15:12 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A08437C6;
        Fri, 14 Oct 2022 13:15:04 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id f8so3225986qkg.3;
        Fri, 14 Oct 2022 13:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3kA6sfh9ixG31h28lqpzkA8keoz0b9VTmFg5pP/IKA=;
        b=71SdWxefO0NFUegUERN/K2pR6DyS7lj2vMTo97gPnWSL9MUbyoM90AJlm/GgLBsox6
         uHl2Ipj7lZPxno7m+uFw8rLbpJhMnfX5UckPz2rgU8c13BMUmhDbc7U7oqjjHKa274yu
         MczzUJ/Bht7v3uyiZwkN3TKm1f+3/L1hcPYcImyC0u4vWXzhP7SEXwCFB0X/8uqt1fSI
         uGCi/cYSM/xBxlx4BGz+m4gq/o+fWeFlBiTI0dHkqycCT3ctvlTitq+uISqHUOX/1o8n
         hLD+gFVo98voA5LGb2766D+19RXPQMpAsJhUVrkyTXC8E7+tvDmJr0sJVYYeaTKpMy95
         PZXg==
X-Gm-Message-State: ACrzQf3FUz/wN9kKdgrNbN2qVzzKdBn4mW1Lmq/1VSOWxYaLUY8N7ImU
        ch5QRCFimv7Hed3ARV3IwSlsbG/nwhRKRQ==
X-Google-Smtp-Source: AMsMyM63FASCxpiv51nJipKMgJ+75aBHX5TphhyBCgOXxZuI3voSfGEXzT76gAjsU+aNZF/KA6n0BA==
X-Received: by 2002:a37:6044:0:b0:6cf:ce19:a73 with SMTP id u65-20020a376044000000b006cfce190a73mr5034924qkb.21.1665778503474;
        Fri, 14 Oct 2022 13:15:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::6918])
        by smtp.gmail.com with ESMTPSA id x10-20020a05620a448a00b006eecc4a0de9sm2843942qkp.62.2022.10.14.13.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 13:15:03 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH v3 3/3] bpf/selftests: Add selftests for new task kfuncs
Date:   Fri, 14 Oct 2022 15:14:27 -0500
Message-Id: <20221014201427.2435461-4-void@manifault.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221014201427.2435461-1-void@manifault.com>
References: <20221014201427.2435461-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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
 .../selftests/bpf/prog_tests/task_kfunc.c     | 160 +++++++++
 .../selftests/bpf/progs/task_kfunc_common.h   |  83 +++++
 .../selftests/bpf/progs/task_kfunc_failure.c  | 315 ++++++++++++++++++
 .../selftests/bpf/progs/task_kfunc_success.c  | 132 ++++++++
 5 files changed, 691 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_success.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index 520f12229b98..323a0e312b3d 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -52,6 +52,7 @@ skc_to_unix_sock                         # could not attach BPF object unexpecte
 socket_cookie                            # prog_attach unexpected error: -524                                          (trampoline)
 stacktrace_build_id                      # compare_map_keys stackid_hmap vs. stackmap err -2 errno 2                   (?)
 tailcalls                                # tail_calls are not allowed in non-JITed programs with bpf-to-bpf calls      (?)
+task_kfunc                               # JIT does not support calling kernel function
 task_local_storage                       # failed to auto-attach program 'trace_exit_creds': -524                      (trampoline)
 test_bpffs                               # bpffs test  failed 255                                                      (iterator)
 test_bprm_opts                           # failed to auto-attach program 'secure_exec': -524                           (trampoline)
diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
new file mode 100644
index 000000000000..18492d010c45
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
@@ -0,0 +1,160 @@
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
+	"test_task_acquire_release_argument",
+	"test_task_acquire_release_current",
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
+	{"task_kfunc_acquire_fp", "arg#0 pointer type STRUCT task_struct must point"},
+	{"task_kfunc_acquire_no_null_check", "arg#0 pointer type STRUCT task_struct must point"},
+	{"task_kfunc_acquire_trusted_nested", "arg#0 pointer type STRUCT task_struct must point"},
+	{"task_kfunc_acquire_null", "arg#0 pointer type STRUCT task_struct must point"},
+	{"task_kfunc_acquire_unreleased", "Unreleased reference"},
+	{"task_kfunc_get_non_kptr_param", "arg#0 expected pointer to map value"},
+	{"task_kfunc_get_non_kptr_acquired", "arg#0 expected pointer to map value"},
+	{"task_kfunc_get_null", "arg#0 expected pointer to map value"},
+	{"task_kfunc_xchg_unreleased", "Unreleased reference"},
+	{"task_kfunc_get_unreleased", "Unreleased reference"},
+	{"task_kfunc_release_untrusted", "arg#0 pointer type STRUCT task_struct must point"},
+	{"task_kfunc_release_fp", "arg#0 pointer type STRUCT task_struct must point"},
+	{"task_kfunc_release_null", "arg#0 pointer type STRUCT task_struct must point"},
+	{"task_kfunc_release_unacquired", "release kernel function bpf_task_release expects refcounted PTR_TO_BTF_ID"},
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
index 000000000000..f51257bdd695
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
+static inline bool is_test_kfunc_task(void)
+{
+	int cur_pid = bpf_get_current_pid_tgid() >> 32;
+
+	return pid == cur_pid;
+}
+
+#endif /* _TASK_KFUNC_COMMON_H */
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
new file mode 100644
index 000000000000..74d2f176a2de
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -0,0 +1,315 @@
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
+static struct __tasks_kfunc_map_value *insert_lookup_task(struct task_struct *task)
+{
+	int status;
+
+	status = tasks_kfunc_map_insert(task);
+	if (status)
+		return NULL;
+
+	return tasks_kfunc_map_value_lookup(task);
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(task_kfunc_acquire_untrusted, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *acquired;
+	struct __tasks_kfunc_map_value *v;
+
+	if (!is_test_kfunc_task())
+		return 0;
+
+	v = insert_lookup_task(task);
+	if (!v)
+		return 0;
+
+	/* Can't invoke bpf_task_acquire() on an untrusted pointer. */
+	acquired = bpf_task_acquire(v->task);
+	if (!acquired)
+		return 0;
+
+	bpf_task_release(acquired);
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(task_kfunc_acquire_fp, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *acquired, *stack_task = (struct task_struct *)&clone_flags;
+
+	if (!is_test_kfunc_task())
+		return 0;
+
+	/* Can't invoke bpf_task_acquire() on a random frame pointer. */
+	acquired = bpf_task_acquire((struct task_struct *)&stack_task);
+	if (!acquired)
+		return 0;
+	bpf_task_release(acquired);
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(task_kfunc_acquire_no_null_check, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *acquired;
+
+	if (!is_test_kfunc_task())
+		return 0;
+
+	acquired = bpf_task_acquire(task);
+	/* Can't release a bpf_task_acquire()'d task without a NULL check. */
+	bpf_task_release(acquired);
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(task_kfunc_acquire_trusted_nested, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *acquired;
+
+	if (!is_test_kfunc_task())
+		return 0;
+
+	/* Can't invoke bpf_task_acquire() on a trusted pointer at a nonzero offset. */
+	acquired = bpf_task_acquire(task->last_wakee);
+	if (!acquired)
+		return 0;
+	bpf_task_release(acquired);
+
+	return 0;
+}
+
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(task_kfunc_acquire_null, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *acquired;
+
+	if (!is_test_kfunc_task())
+		return 0;
+
+	/* Can't invoke bpf_task_acquire() on a NULL pointer. */
+	acquired = bpf_task_acquire(NULL);
+	if (!acquired)
+		return 0;
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
+	if (!is_test_kfunc_task())
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
+	if (!is_test_kfunc_task())
+		return 0;
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
+	if (!is_test_kfunc_task())
+		return 0;
+
+	acquired = bpf_task_acquire(task);
+	if (!acquired)
+		return 0;
+
+	/* Cannot use bpf_task_kptr_get() on a non-kptr, even if it was acquired. */
+	kptr = bpf_task_kptr_get(&acquired);
+	bpf_task_release(acquired);
+	if (!kptr)
+		return 0;
+
+	bpf_task_release(kptr);
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(task_kfunc_get_null, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *kptr;
+
+	if (!is_test_kfunc_task())
+		return 0;
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
+
+	if (!is_test_kfunc_task())
+		return 0;
+
+	v = insert_lookup_task(task);
+	if (!v)
+		return 0;
+
+	kptr = bpf_kptr_xchg(&v->task, NULL);
+	if (!kptr)
+		return 0;
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
+
+	if (!is_test_kfunc_task())
+		return 0;
+
+	v = insert_lookup_task(task);
+	if (!v)
+		return 0;
+
+	kptr = bpf_task_kptr_get(&v->task);
+	if (!kptr)
+		return 0;
+
+	/* Kptr acquired above is never released. */
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(task_kfunc_release_untrusted, struct task_struct *task, u64 clone_flags)
+{
+	struct __tasks_kfunc_map_value *v;
+
+	if (!is_test_kfunc_task())
+		return 0;
+
+	v = insert_lookup_task(task);
+	if (!v)
+		return 0;
+
+	/* Can't invoke bpf_task_release() on an untrusted pointer. */
+	bpf_task_release(v->task);
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(task_kfunc_release_fp, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *acquired = (struct task_struct *)&clone_flags;
+
+	if (!is_test_kfunc_task())
+		return 0;
+
+	/* Cannot release random frame pointer. */
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
+	if (!is_test_kfunc_task())
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
+	if (!acquired)
+		return 0;
+
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
+	if (!is_test_kfunc_task())
+		return 0;
+
+	/* Cannot release trusted task pointer which was not acquired. */
+	bpf_task_release(task);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
new file mode 100644
index 000000000000..8d5c05b41d53
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
@@ -0,0 +1,132 @@
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
+static int test_acquire_release(struct task_struct *task)
+{
+	struct task_struct *acquired;
+
+	acquired = bpf_task_acquire(task);
+	if (!acquired) {
+		err = 1;
+		return 0;
+	}
+
+	bpf_task_release(acquired);
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_task_acquire_release_argument, struct task_struct *task, u64 clone_flags)
+{
+	if (!is_test_kfunc_task())
+		return 0;
+
+	return test_acquire_release(task);
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_task_acquire_release_current, struct task_struct *task, u64 clone_flags)
+{
+	if (!is_test_kfunc_task())
+		return 0;
+
+	return test_acquire_release(bpf_get_current_task_btf());
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_task_acquire_leave_in_map, struct task_struct *task, u64 clone_flags)
+{
+	long status;
+
+	if (!is_test_kfunc_task())
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
+	if (!is_test_kfunc_task())
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
+	if (!is_test_kfunc_task())
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
2.38.0

