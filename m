Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BCC6334F3
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 06:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiKVF4i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 00:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiKVF4S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 00:56:18 -0500
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9552654A;
        Mon, 21 Nov 2022 21:55:48 -0800 (PST)
Received: by mail-qv1-f52.google.com with SMTP id k2so8308221qvo.1;
        Mon, 21 Nov 2022 21:55:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZ4x5r/AX97bCLXUzrPxLnjjqC4hv8tbiW47sVTozyc=;
        b=ZNHXvjg84k6AEEe8THUld9f+MFJAd3FU0X163NEaja3DaD8mX1PItJRybnoiT3g4zG
         bPWNGQ5oYw1GlhKkoph2LtlqdJq5VYVxURLP5XGzXeD+fBQW/vLZ6CvF2qHVDiw+xSjA
         czFmOODG1nir5LLRh7iHLuOGNoIFqL58EdoWN/aCiQsn1JQNk2y5XGy0IwpDbuGn6qIy
         OtNqSMmQ5O/o8BcDM3hqguNHHI44dXwcO7rQ1kYQgVsGFrZNGBNjzNSm/ZvcbE/PoE0e
         jsG9o9TRv0nrcgURWnJhnAC/RCkuRmMhM9O2HIjgxiqWubq7SdqdO/L0ejEiMiAXe/wo
         XEnw==
X-Gm-Message-State: ANoB5pkZOjZ5V3oE8C1o8/nA/uQmULjgDxfhH43AeF3b3SCSoh/wBt1L
        MIYfcHng+WU+/YnJe35lrcPM2vCx6Q3xCyH6
X-Google-Smtp-Source: AA0mqf5PURn0wkoklGy4OVAmElUQNPBUswKdM2HWRYwtHnYrx/cpYGyqnc2X3/KYswst7w6LcIJSSg==
X-Received: by 2002:a05:6214:1c6:b0:4ba:171b:8978 with SMTP id c6-20020a05621401c600b004ba171b8978mr3759141qvt.82.1669096547498;
        Mon, 21 Nov 2022 21:55:47 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:3170])
        by smtp.gmail.com with ESMTPSA id u13-20020a05622a17cd00b003a530a32f67sm7823359qtk.65.2022.11.21.21.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 21:55:47 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        haoluo@google.com, tj@kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/4] selftests/bpf: Add cgroup kfunc / kptr selftests
Date:   Mon, 21 Nov 2022 23:54:56 -0600
Message-Id: <20221122055458.173143-3-void@manifault.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122055458.173143-1-void@manifault.com>
References: <20221122055458.173143-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds a selftest suite to validate the cgroup kfuncs that were
added in the prior patch.

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../selftests/bpf/prog_tests/cgrp_kfunc.c     | 174 ++++++++++++
 .../selftests/bpf/progs/cgrp_kfunc_common.h   |  71 +++++
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  | 260 ++++++++++++++++++
 .../selftests/bpf/progs/cgrp_kfunc_success.c  | 125 +++++++++
 5 files changed, 631 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index 12cf2159975e..b9a3d80204c6 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -10,6 +10,7 @@ bpf_nf                                   # JIT does not support calling kernel f
 bpf_tcp_ca                               # JIT does not support calling kernel function                                (kfunc)
 cb_refs                                  # expected error message unexpected error: -524                               (trampoline)
 cgroup_hierarchical_stats                # JIT does not support calling kernel function                                (kfunc)
+cgrp_kfunc                               # JIT does not support calling kernel function
 cgrp_local_storage                       # prog_attach unexpected error: -524                                          (trampoline)
 core_read_macros                         # unknown func bpf_probe_read#4                                               (overlapping)
 d_path                                   # failed to auto-attach program 'prog_stat': -524                             (trampoline)
diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
new file mode 100644
index 000000000000..a59b166bbcc4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#define _GNU_SOURCE
+#include <cgroup_helpers.h>
+#include <test_progs.h>
+
+#include "cgrp_kfunc_failure.skel.h"
+#include "cgrp_kfunc_success.skel.h"
+
+static size_t log_buf_sz = 1 << 20; /* 1 MB */
+static char obj_log_buf[1048576];
+
+static struct cgrp_kfunc_success *open_load_cgrp_kfunc_skel(void)
+{
+	struct cgrp_kfunc_success *skel;
+	int err;
+
+	skel = cgrp_kfunc_success__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return NULL;
+
+	skel->bss->pid = getpid();
+
+	err = cgrp_kfunc_success__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	return skel;
+
+cleanup:
+	cgrp_kfunc_success__destroy(skel);
+	return NULL;
+}
+
+static int mkdir_rm_test_dir(void)
+{
+	int fd;
+	const char *cgrp_path = "cgrp_kfunc";
+
+	fd = create_and_get_cgroup(cgrp_path);
+	if (!ASSERT_GT(fd, 0, "mkdir_cgrp_fd"))
+		return -1;
+
+	close(fd);
+	remove_cgroup(cgrp_path);
+
+	return 0;
+}
+
+static void run_success_test(const char *prog_name)
+{
+	struct cgrp_kfunc_success *skel;
+	struct bpf_program *prog;
+	struct bpf_link *link = NULL;
+
+	skel = open_load_cgrp_kfunc_skel();
+	if (!ASSERT_OK_PTR(skel, "open_load_skel"))
+		return;
+
+	if (!ASSERT_OK(skel->bss->err, "pre_mkdir_err"))
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
+	ASSERT_EQ(skel->bss->invocations, 0, "pre_rmdir_count");
+	if (!ASSERT_OK(mkdir_rm_test_dir(), "cgrp_mkdir"))
+		goto cleanup;
+
+	ASSERT_EQ(skel->bss->invocations, 1, "post_rmdir_count");
+	ASSERT_OK(skel->bss->err, "post_rmdir_err");
+
+cleanup:
+	bpf_link__destroy(link);
+	cgrp_kfunc_success__destroy(skel);
+}
+
+static const char * const success_tests[] = {
+	"test_cgrp_acquire_release_argument",
+	"test_cgrp_acquire_leave_in_map",
+	"test_cgrp_xchg_release",
+	"test_cgrp_get_release",
+};
+
+static struct {
+	const char *prog_name;
+	const char *expected_err_msg;
+} failure_tests[] = {
+	{"cgrp_kfunc_acquire_untrusted", "R1 must be referenced or trusted"},
+	{"cgrp_kfunc_acquire_fp", "arg#0 pointer type STRUCT cgroup must point"},
+	{"cgrp_kfunc_acquire_unsafe_kretprobe", "reg type unsupported for arg#0 function"},
+	{"cgrp_kfunc_acquire_trusted_walked", "R1 must be referenced or trusted"},
+	{"cgrp_kfunc_acquire_null", "arg#0 pointer type STRUCT cgroup must point"},
+	{"cgrp_kfunc_acquire_unreleased", "Unreleased reference"},
+	{"cgrp_kfunc_get_non_kptr_param", "arg#0 expected pointer to map value"},
+	{"cgrp_kfunc_get_non_kptr_acquired", "arg#0 expected pointer to map value"},
+	{"cgrp_kfunc_get_null", "arg#0 expected pointer to map value"},
+	{"cgrp_kfunc_xchg_unreleased", "Unreleased reference"},
+	{"cgrp_kfunc_get_unreleased", "Unreleased reference"},
+	{"cgrp_kfunc_release_untrusted", "arg#0 is untrusted_ptr_or_null_ expected ptr_ or socket"},
+	{"cgrp_kfunc_release_fp", "arg#0 pointer type STRUCT cgroup must point"},
+	{"cgrp_kfunc_release_null", "arg#0 is ptr_or_null_ expected ptr_ or socket"},
+	{"cgrp_kfunc_release_unacquired", "release kernel function bpf_cgroup_release expects"},
+};
+
+static void verify_fail(const char *prog_name, const char *expected_err_msg)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+	struct cgrp_kfunc_failure *skel;
+	int err, i;
+
+	opts.kernel_log_buf = obj_log_buf;
+	opts.kernel_log_size = log_buf_sz;
+	opts.kernel_log_level = 1;
+
+	skel = cgrp_kfunc_failure__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "cgrp_kfunc_failure__open_opts"))
+		goto cleanup;
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
+	err = cgrp_kfunc_failure__load(skel);
+	if (!ASSERT_ERR(err, "unexpected load success"))
+		goto cleanup;
+
+	if (!ASSERT_OK_PTR(strstr(obj_log_buf, expected_err_msg), "expected_err_msg")) {
+		fprintf(stderr, "Expected err_msg: %s\n", expected_err_msg);
+		fprintf(stderr, "Verifier output: %s\n", obj_log_buf);
+	}
+
+cleanup:
+	cgrp_kfunc_failure__destroy(skel);
+}
+
+void test_cgrp_kfunc(void)
+{
+	int i, err;
+
+	err = setup_cgroup_environment();
+	if (!ASSERT_OK(err, "cgrp_env_setup"))
+		goto cleanup;
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
+
+cleanup:
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h b/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
new file mode 100644
index 000000000000..3f18def0e45c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#ifndef _CGRP_KFUNC_COMMON_H
+#define _CGRP_KFUNC_COMMON_H
+
+#include <errno.h>
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct __cgrps_kfunc_map_value {
+	struct cgroup __kptr_ref * cgrp;
+};
+
+struct hash_map {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int);
+	__type(value, struct __cgrps_kfunc_map_value);
+	__uint(max_entries, 1);
+} __cgrps_kfunc_map SEC(".maps");
+
+struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
+struct cgroup *bpf_cgroup_kptr_get(struct cgroup **pp) __ksym;
+void bpf_cgroup_release(struct cgroup *p) __ksym;
+
+static inline struct __cgrps_kfunc_map_value *cgrps_kfunc_map_value_lookup(struct cgroup *cgrp)
+{
+	s32 id;
+	long status;
+
+	status = bpf_probe_read_kernel(&id, sizeof(id), &cgrp->self.id);
+	if (status)
+		return NULL;
+
+	return bpf_map_lookup_elem(&__cgrps_kfunc_map, &id);
+}
+
+static inline int cgrps_kfunc_map_insert(struct cgroup *cgrp)
+{
+	struct __cgrps_kfunc_map_value local, *v;
+	long status;
+	struct cgroup *acquired, *old;
+	s32 id;
+
+	status = bpf_probe_read_kernel(&id, sizeof(id), &cgrp->self.id);
+	if (status)
+		return status;
+
+	local.cgrp = NULL;
+	status = bpf_map_update_elem(&__cgrps_kfunc_map, &id, &local, BPF_NOEXIST);
+	if (status)
+		return status;
+
+	v = bpf_map_lookup_elem(&__cgrps_kfunc_map, &id);
+	if (!v) {
+		bpf_map_delete_elem(&__cgrps_kfunc_map, &id);
+		return -ENOENT;
+	}
+
+	acquired = bpf_cgroup_acquire(cgrp);
+	old = bpf_kptr_xchg(&v->cgrp, acquired);
+	if (old) {
+		bpf_cgroup_release(old);
+		return -EEXIST;
+	}
+
+	return 0;
+}
+
+#endif /* _CGRP_KFUNC_COMMON_H */
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
new file mode 100644
index 000000000000..a1369b5ebcf8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#include "cgrp_kfunc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+/* Prototype for all of the program trace events below:
+ *
+ * TRACE_EVENT(cgroup_mkdir,
+ *         TP_PROTO(struct cgroup *cgrp, const char *path),
+ *         TP_ARGS(cgrp, path)
+ */
+
+static struct __cgrps_kfunc_map_value *insert_lookup_cgrp(struct cgroup *cgrp)
+{
+	int status;
+
+	status = cgrps_kfunc_map_insert(cgrp);
+	if (status)
+		return NULL;
+
+	return cgrps_kfunc_map_value_lookup(cgrp);
+}
+
+SEC("tp_btf/cgroup_mkdir")
+int BPF_PROG(cgrp_kfunc_acquire_untrusted, struct cgroup *cgrp, const char *path)
+{
+	struct cgroup *acquired;
+	struct __cgrps_kfunc_map_value *v;
+
+	v = insert_lookup_cgrp(cgrp);
+	if (!v)
+		return 0;
+
+	/* Can't invoke bpf_cgroup_acquire() on an untrusted pointer. */
+	acquired = bpf_cgroup_acquire(v->cgrp);
+	bpf_cgroup_release(acquired);
+
+	return 0;
+}
+
+SEC("tp_btf/cgroup_mkdir")
+int BPF_PROG(cgrp_kfunc_acquire_fp, struct cgroup *cgrp, const char *path)
+{
+	struct cgroup *acquired, *stack_cgrp = (struct cgroup *)&path;
+
+	/* Can't invoke bpf_cgroup_acquire() on a random frame pointer. */
+	acquired = bpf_cgroup_acquire((struct cgroup *)&stack_cgrp);
+	bpf_cgroup_release(acquired);
+
+	return 0;
+}
+
+SEC("kretprobe/cgroup_destroy_locked")
+int BPF_PROG(cgrp_kfunc_acquire_unsafe_kretprobe, struct cgroup *cgrp)
+{
+	struct cgroup *acquired;
+
+	/* Can't acquire an untrusted struct cgroup * pointer. */
+	acquired = bpf_cgroup_acquire(cgrp);
+	bpf_cgroup_release(acquired);
+
+	return 0;
+}
+
+SEC("tp_btf/cgroup_mkdir")
+int BPF_PROG(cgrp_kfunc_acquire_trusted_walked, struct cgroup *cgrp, const char *path)
+{
+	struct cgroup *acquired;
+
+	/* Can't invoke bpf_cgroup_acquire() on a pointer obtained from walking a trusted cgroup. */
+	acquired = bpf_cgroup_acquire(cgrp->old_dom_cgrp);
+	bpf_cgroup_release(acquired);
+
+	return 0;
+}
+
+
+SEC("tp_btf/cgroup_mkdir")
+int BPF_PROG(cgrp_kfunc_acquire_null, struct cgroup *cgrp, const char *path)
+{
+	struct cgroup *acquired;
+
+	/* Can't invoke bpf_cgroup_acquire() on a NULL pointer. */
+	acquired = bpf_cgroup_acquire(NULL);
+	if (!acquired)
+		return 0;
+	bpf_cgroup_release(acquired);
+
+	return 0;
+}
+
+SEC("tp_btf/cgroup_mkdir")
+int BPF_PROG(cgrp_kfunc_acquire_unreleased, struct cgroup *cgrp, const char *path)
+{
+	struct cgroup *acquired;
+
+	acquired = bpf_cgroup_acquire(cgrp);
+
+	/* Acquired cgroup is never released. */
+
+	return 0;
+}
+
+SEC("tp_btf/cgroup_mkdir")
+int BPF_PROG(cgrp_kfunc_get_non_kptr_param, struct cgroup *cgrp, const char *path)
+{
+	struct cgroup *kptr;
+
+	/* Cannot use bpf_cgroup_kptr_get() on a non-kptr, even on a valid cgroup. */
+	kptr = bpf_cgroup_kptr_get(&cgrp);
+	if (!kptr)
+		return 0;
+
+	bpf_cgroup_release(kptr);
+
+	return 0;
+}
+
+SEC("tp_btf/cgroup_mkdir")
+int BPF_PROG(cgrp_kfunc_get_non_kptr_acquired, struct cgroup *cgrp, const char *path)
+{
+	struct cgroup *kptr, *acquired;
+
+	acquired = bpf_cgroup_acquire(cgrp);
+
+	/* Cannot use bpf_cgroup_kptr_get() on a non-map-value, even if the kptr was acquired. */
+	kptr = bpf_cgroup_kptr_get(&acquired);
+	bpf_cgroup_release(acquired);
+	if (!kptr)
+		return 0;
+
+	bpf_cgroup_release(kptr);
+
+	return 0;
+}
+
+SEC("tp_btf/cgroup_mkdir")
+int BPF_PROG(cgrp_kfunc_get_null, struct cgroup *cgrp, const char *path)
+{
+	struct cgroup *kptr;
+
+	/* Cannot use bpf_cgroup_kptr_get() on a NULL pointer. */
+	kptr = bpf_cgroup_kptr_get(NULL);
+	if (!kptr)
+		return 0;
+
+	bpf_cgroup_release(kptr);
+
+	return 0;
+}
+
+SEC("tp_btf/cgroup_mkdir")
+int BPF_PROG(cgrp_kfunc_xchg_unreleased, struct cgroup *cgrp, const char *path)
+{
+	struct cgroup *kptr;
+	struct __cgrps_kfunc_map_value *v;
+
+	v = insert_lookup_cgrp(cgrp);
+	if (!v)
+		return 0;
+
+	kptr = bpf_kptr_xchg(&v->cgrp, NULL);
+	if (!kptr)
+		return 0;
+
+	/* Kptr retrieved from map is never released. */
+
+	return 0;
+}
+
+SEC("tp_btf/cgroup_mkdir")
+int BPF_PROG(cgrp_kfunc_get_unreleased, struct cgroup *cgrp, const char *path)
+{
+	struct cgroup *kptr;
+	struct __cgrps_kfunc_map_value *v;
+
+	v = insert_lookup_cgrp(cgrp);
+	if (!v)
+		return 0;
+
+	kptr = bpf_cgroup_kptr_get(&v->cgrp);
+	if (!kptr)
+		return 0;
+
+	/* Kptr acquired above is never released. */
+
+	return 0;
+}
+
+SEC("tp_btf/cgroup_mkdir")
+int BPF_PROG(cgrp_kfunc_release_untrusted, struct cgroup *cgrp, const char *path)
+{
+	struct __cgrps_kfunc_map_value *v;
+
+	v = insert_lookup_cgrp(cgrp);
+	if (!v)
+		return 0;
+
+	/* Can't invoke bpf_cgroup_release() on an untrusted pointer. */
+	bpf_cgroup_release(v->cgrp);
+
+	return 0;
+}
+
+SEC("tp_btf/cgroup_mkdir")
+int BPF_PROG(cgrp_kfunc_release_fp, struct cgroup *cgrp, const char *path)
+{
+	struct cgroup *acquired = (struct cgroup *)&path;
+
+	/* Cannot release random frame pointer. */
+	bpf_cgroup_release(acquired);
+
+	return 0;
+}
+
+SEC("tp_btf/cgroup_mkdir")
+int BPF_PROG(cgrp_kfunc_release_null, struct cgroup *cgrp, const char *path)
+{
+	struct __cgrps_kfunc_map_value local, *v;
+	long status;
+	struct cgroup *acquired, *old;
+	s32 id;
+
+	status = bpf_probe_read_kernel(&id, sizeof(id), &cgrp->self.id);
+	if (status)
+		return 0;
+
+	local.cgrp = NULL;
+	status = bpf_map_update_elem(&__cgrps_kfunc_map, &id, &local, BPF_NOEXIST);
+	if (status)
+		return status;
+
+	v = bpf_map_lookup_elem(&__cgrps_kfunc_map, &id);
+	if (!v)
+		return -ENOENT;
+
+	acquired = bpf_cgroup_acquire(cgrp);
+
+	old = bpf_kptr_xchg(&v->cgrp, acquired);
+
+	/* old cannot be passed to bpf_cgroup_release() without a NULL check. */
+	bpf_cgroup_release(old);
+
+	return 0;
+}
+
+SEC("tp_btf/cgroup_mkdir")
+int BPF_PROG(cgrp_kfunc_release_unacquired, struct cgroup *cgrp, const char *path)
+{
+	/* Cannot release trusted cgroup pointer which was not acquired. */
+	bpf_cgroup_release(cgrp);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c b/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
new file mode 100644
index 000000000000..9f4569f7598b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#include "cgrp_kfunc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+int err, pid, invocations;
+
+/* Prototype for all of the program trace events below:
+ *
+ * TRACE_EVENT(cgroup_mkdir,
+ *         TP_PROTO(struct cgroup *cgrp, const char *path),
+ *         TP_ARGS(cgrp, path)
+ */
+
+static bool is_test_kfunc_task(void)
+{
+	int cur_pid = bpf_get_current_pid_tgid() >> 32;
+	bool same = pid == cur_pid;
+
+	if (same)
+		__sync_fetch_and_add(&invocations, 1);
+
+	return same;
+}
+
+SEC("tp_btf/cgroup_mkdir")
+int BPF_PROG(test_cgrp_acquire_release_argument, struct cgroup *cgrp, const char *path)
+{
+	struct cgroup *acquired;
+
+	if (!is_test_kfunc_task())
+		return 0;
+
+	acquired = bpf_cgroup_acquire(cgrp);
+	bpf_cgroup_release(acquired);
+
+	return 0;
+}
+
+SEC("tp_btf/cgroup_mkdir")
+int BPF_PROG(test_cgrp_acquire_leave_in_map, struct cgroup *cgrp, const char *path)
+{
+	long status;
+
+	if (!is_test_kfunc_task())
+		return 0;
+
+	status = cgrps_kfunc_map_insert(cgrp);
+	if (status)
+		err = 1;
+
+	return 0;
+}
+
+SEC("tp_btf/cgroup_mkdir")
+int BPF_PROG(test_cgrp_xchg_release, struct cgroup *cgrp, const char *path)
+{
+	struct cgroup *kptr;
+	struct __cgrps_kfunc_map_value *v;
+	long status;
+
+	if (!is_test_kfunc_task())
+		return 0;
+
+	status = cgrps_kfunc_map_insert(cgrp);
+	if (status) {
+		err = 1;
+		return 0;
+	}
+
+	v = cgrps_kfunc_map_value_lookup(cgrp);
+	if (!v) {
+		err = 2;
+		return 0;
+	}
+
+	kptr = bpf_kptr_xchg(&v->cgrp, NULL);
+	if (!kptr) {
+		err = 3;
+		return 0;
+	}
+
+	bpf_cgroup_release(kptr);
+
+	return 0;
+}
+
+SEC("tp_btf/cgroup_mkdir")
+int BPF_PROG(test_cgrp_get_release, struct cgroup *cgrp, const char *path)
+{
+	struct cgroup *kptr;
+	struct __cgrps_kfunc_map_value *v;
+	long status;
+
+	if (!is_test_kfunc_task())
+		return 0;
+
+	status = cgrps_kfunc_map_insert(cgrp);
+	if (status) {
+		err = 1;
+		return 0;
+	}
+
+	v = cgrps_kfunc_map_value_lookup(cgrp);
+	if (!v) {
+		err = 2;
+		return 0;
+	}
+
+	kptr = bpf_cgroup_kptr_get(&v->cgrp);
+	if (!kptr) {
+		err = 3;
+		return 0;
+	}
+
+	bpf_cgroup_release(kptr);
+
+	return 0;
+}
-- 
2.38.1

