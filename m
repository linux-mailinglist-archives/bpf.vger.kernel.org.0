Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07930674945
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 03:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjATCTp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 21:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjATCTo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 21:19:44 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3DD9F3A2;
        Thu, 19 Jan 2023 18:19:42 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id z9so3186778qtv.5;
        Thu, 19 Jan 2023 18:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3Mh24f3syw1YMuVpvRFLAyGbyazWD5wf6ZyZDnVgNQ=;
        b=r7mhRBF7ys3T5QHmkn/ez80xwb1ELwkOwtnx7W4b5lpt48nULRJQCG//TYuOOG0djw
         l4dAAW47OcxFi1FqtKuwEehfPoibkE5HD+Wg+xHOfeEFa6OuCCZ4FMtJbxJjcKSgl+Xr
         fgowi0F+qNukPGRA6aqEjxZnGAKQXp6WOKw3FfCore4K+0Bi1MFVdbKPcieCUtXZxFUR
         03YgPCUrYcgf9Fgev4GIcxbjbeKERCcyYyh+x4hWT8S2WTI1ap3PPQ5c/7EU4a1M9nox
         6zwnZF/dFcFDzzGTdosDTBMi0ABEyjlp2xlnibNJO4ke0RUOeZcmDyiAn4cb2BqNG/GO
         5OqQ==
X-Gm-Message-State: AFqh2krMFBKOsYRSCoxdiqBf5JEnewvk7qCA2f6AU2foparavaoGzS+B
        zKiMqW3fay/4eCk/oawWLdnOqlapySq2ZTsh
X-Google-Smtp-Source: AMrXdXuAg7pEF6hX69ZJhacnCAJ48oe4T/AM5UiQ5ryNHvZy11K/NRwKWDB/Os+p4vQUtsZS7lXN9g==
X-Received: by 2002:ac8:44ac:0:b0:3a5:f9f8:3ec4 with SMTP id a12-20020ac844ac000000b003a5f9f83ec4mr16390621qto.30.1674181181587;
        Thu, 19 Jan 2023 18:19:41 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id d25-20020ac85459000000b003b630456b8fsm6957275qtq.89.2023.01.19.18.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 18:19:41 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next] selftests/bpf: Use __failure macro in task kfunc testsuite
Date:   Thu, 19 Jan 2023 20:18:44 -0600
Message-Id: <20230120021844.3048244-1-void@manifault.com>
X-Mailer: git-send-email 2.39.0
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

In commit 537c3f66eac1 ("selftests/bpf: add generic BPF program
tester-loader"), a new mechanism was added to the BPF selftest framework
to allow testsuites to use macros to define expected failing testcases.
This allows any testsuite which tests verification failure to remove a
good amount of boilerplate code. This patch updates the task_kfunc
selftest suite to use these new macros.

Signed-off-by: David Vernet <void@manifault.com>
---
 .../selftests/bpf/prog_tests/task_kfunc.c     | 71 +------------------
 .../selftests/bpf/progs/task_kfunc_failure.c  | 18 +++++
 2 files changed, 19 insertions(+), 70 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
index 18848c31e36f..f79fa5bc9a8d 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
@@ -9,9 +9,6 @@
 #include "task_kfunc_failure.skel.h"
 #include "task_kfunc_success.skel.h"
 
-static size_t log_buf_sz = 1 << 20; /* 1 MB */
-static char obj_log_buf[1048576];
-
 static struct task_kfunc_success *open_load_task_kfunc_skel(void)
 {
 	struct task_kfunc_success *skel;
@@ -83,67 +80,6 @@ static const char * const success_tests[] = {
 	"test_task_from_pid_invalid",
 };
 
-static struct {
-	const char *prog_name;
-	const char *expected_err_msg;
-} failure_tests[] = {
-	{"task_kfunc_acquire_untrusted", "R1 must be referenced or trusted"},
-	{"task_kfunc_acquire_fp", "arg#0 pointer type STRUCT task_struct must point"},
-	{"task_kfunc_acquire_unsafe_kretprobe", "reg type unsupported for arg#0 function"},
-	{"task_kfunc_acquire_trusted_walked", "R1 must be referenced or trusted"},
-	{"task_kfunc_acquire_null", "arg#0 pointer type STRUCT task_struct must point"},
-	{"task_kfunc_acquire_unreleased", "Unreleased reference"},
-	{"task_kfunc_get_non_kptr_param", "arg#0 expected pointer to map value"},
-	{"task_kfunc_get_non_kptr_acquired", "arg#0 expected pointer to map value"},
-	{"task_kfunc_get_null", "arg#0 expected pointer to map value"},
-	{"task_kfunc_xchg_unreleased", "Unreleased reference"},
-	{"task_kfunc_get_unreleased", "Unreleased reference"},
-	{"task_kfunc_release_untrusted", "arg#0 is untrusted_ptr_or_null_ expected ptr_ or socket"},
-	{"task_kfunc_release_fp", "arg#0 pointer type STRUCT task_struct must point"},
-	{"task_kfunc_release_null", "arg#0 is ptr_or_null_ expected ptr_ or socket"},
-	{"task_kfunc_release_unacquired", "release kernel function bpf_task_release expects"},
-	{"task_kfunc_from_pid_no_null_check", "arg#0 is ptr_or_null_ expected ptr_ or socket"},
-	{"task_kfunc_from_lsm_task_free", "reg type unsupported for arg#0 function"},
-};
-
-static void verify_fail(const char *prog_name, const char *expected_err_msg)
-{
-	LIBBPF_OPTS(bpf_object_open_opts, opts);
-	struct task_kfunc_failure *skel;
-	int err, i;
-
-	opts.kernel_log_buf = obj_log_buf;
-	opts.kernel_log_size = log_buf_sz;
-	opts.kernel_log_level = 1;
-
-	skel = task_kfunc_failure__open_opts(&opts);
-	if (!ASSERT_OK_PTR(skel, "task_kfunc_failure__open_opts"))
-		goto cleanup;
-
-	for (i = 0; i < ARRAY_SIZE(failure_tests); i++) {
-		struct bpf_program *prog;
-		const char *curr_name = failure_tests[i].prog_name;
-
-		prog = bpf_object__find_program_by_name(skel->obj, curr_name);
-		if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
-			goto cleanup;
-
-		bpf_program__set_autoload(prog, !strcmp(curr_name, prog_name));
-	}
-
-	err = task_kfunc_failure__load(skel);
-	if (!ASSERT_ERR(err, "unexpected load success"))
-		goto cleanup;
-
-	if (!ASSERT_OK_PTR(strstr(obj_log_buf, expected_err_msg), "expected_err_msg")) {
-		fprintf(stderr, "Expected err_msg: %s\n", expected_err_msg);
-		fprintf(stderr, "Verifier output: %s\n", obj_log_buf);
-	}
-
-cleanup:
-	task_kfunc_failure__destroy(skel);
-}
-
 void test_task_kfunc(void)
 {
 	int i;
@@ -155,10 +91,5 @@ void test_task_kfunc(void)
 		run_success_test(success_tests[i]);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(failure_tests); i++) {
-		if (!test__start_subtest(failure_tests[i].prog_name))
-			continue;
-
-		verify_fail(failure_tests[i].prog_name, failure_tests[i].expected_err_msg);
-	}
+	RUN_TESTS(task_kfunc_failure);
 }
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
index 1b47b94dbca0..e6950d6a9cf0 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -5,6 +5,7 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
 
+#include "bpf_misc.h"
 #include "task_kfunc_common.h"
 
 char _license[] SEC("license") = "GPL";
@@ -27,6 +28,7 @@ static struct __tasks_kfunc_map_value *insert_lookup_task(struct task_struct *ta
 }
 
 SEC("tp_btf/task_newtask")
+__failure __msg("R1 must be referenced or trusted")
 int BPF_PROG(task_kfunc_acquire_untrusted, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *acquired;
@@ -44,6 +46,7 @@ int BPF_PROG(task_kfunc_acquire_untrusted, struct task_struct *task, u64 clone_f
 }
 
 SEC("tp_btf/task_newtask")
+__failure __msg("arg#0 pointer type STRUCT task_struct must point")
 int BPF_PROG(task_kfunc_acquire_fp, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *acquired, *stack_task = (struct task_struct *)&clone_flags;
@@ -56,6 +59,7 @@ int BPF_PROG(task_kfunc_acquire_fp, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("kretprobe/free_task")
+__failure __msg("reg type unsupported for arg#0 function")
 int BPF_PROG(task_kfunc_acquire_unsafe_kretprobe, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *acquired;
@@ -68,6 +72,7 @@ int BPF_PROG(task_kfunc_acquire_unsafe_kretprobe, struct task_struct *task, u64
 }
 
 SEC("tp_btf/task_newtask")
+__failure __msg("R1 must be referenced or trusted")
 int BPF_PROG(task_kfunc_acquire_trusted_walked, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *acquired;
@@ -81,6 +86,7 @@ int BPF_PROG(task_kfunc_acquire_trusted_walked, struct task_struct *task, u64 cl
 
 
 SEC("tp_btf/task_newtask")
+__failure __msg("arg#0 pointer type STRUCT task_struct must point")
 int BPF_PROG(task_kfunc_acquire_null, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *acquired;
@@ -95,6 +101,7 @@ int BPF_PROG(task_kfunc_acquire_null, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("tp_btf/task_newtask")
+__failure __msg("Unreleased reference")
 int BPF_PROG(task_kfunc_acquire_unreleased, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *acquired;
@@ -107,6 +114,7 @@ int BPF_PROG(task_kfunc_acquire_unreleased, struct task_struct *task, u64 clone_
 }
 
 SEC("tp_btf/task_newtask")
+__failure __msg("arg#0 expected pointer to map value")
 int BPF_PROG(task_kfunc_get_non_kptr_param, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *kptr;
@@ -122,6 +130,7 @@ int BPF_PROG(task_kfunc_get_non_kptr_param, struct task_struct *task, u64 clone_
 }
 
 SEC("tp_btf/task_newtask")
+__failure __msg("arg#0 expected pointer to map value")
 int BPF_PROG(task_kfunc_get_non_kptr_acquired, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *kptr, *acquired;
@@ -140,6 +149,7 @@ int BPF_PROG(task_kfunc_get_non_kptr_acquired, struct task_struct *task, u64 clo
 }
 
 SEC("tp_btf/task_newtask")
+__failure __msg("arg#0 expected pointer to map value")
 int BPF_PROG(task_kfunc_get_null, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *kptr;
@@ -155,6 +165,7 @@ int BPF_PROG(task_kfunc_get_null, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("tp_btf/task_newtask")
+__failure __msg("Unreleased reference")
 int BPF_PROG(task_kfunc_xchg_unreleased, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *kptr;
@@ -174,6 +185,7 @@ int BPF_PROG(task_kfunc_xchg_unreleased, struct task_struct *task, u64 clone_fla
 }
 
 SEC("tp_btf/task_newtask")
+__failure __msg("Unreleased reference")
 int BPF_PROG(task_kfunc_get_unreleased, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *kptr;
@@ -193,6 +205,7 @@ int BPF_PROG(task_kfunc_get_unreleased, struct task_struct *task, u64 clone_flag
 }
 
 SEC("tp_btf/task_newtask")
+__failure __msg("arg#0 is untrusted_ptr_or_null_ expected ptr_ or socket")
 int BPF_PROG(task_kfunc_release_untrusted, struct task_struct *task, u64 clone_flags)
 {
 	struct __tasks_kfunc_map_value *v;
@@ -208,6 +221,7 @@ int BPF_PROG(task_kfunc_release_untrusted, struct task_struct *task, u64 clone_f
 }
 
 SEC("tp_btf/task_newtask")
+__failure __msg("arg#0 pointer type STRUCT task_struct must point")
 int BPF_PROG(task_kfunc_release_fp, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *acquired = (struct task_struct *)&clone_flags;
@@ -219,6 +233,7 @@ int BPF_PROG(task_kfunc_release_fp, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("tp_btf/task_newtask")
+__failure __msg("arg#0 is ptr_or_null_ expected ptr_ or socket")
 int BPF_PROG(task_kfunc_release_null, struct task_struct *task, u64 clone_flags)
 {
 	struct __tasks_kfunc_map_value local, *v;
@@ -251,6 +266,7 @@ int BPF_PROG(task_kfunc_release_null, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("tp_btf/task_newtask")
+__failure __msg("release kernel function bpf_task_release expects")
 int BPF_PROG(task_kfunc_release_unacquired, struct task_struct *task, u64 clone_flags)
 {
 	/* Cannot release trusted task pointer which was not acquired. */
@@ -260,6 +276,7 @@ int BPF_PROG(task_kfunc_release_unacquired, struct task_struct *task, u64 clone_
 }
 
 SEC("tp_btf/task_newtask")
+__failure __msg("arg#0 is ptr_or_null_ expected ptr_ or socket")
 int BPF_PROG(task_kfunc_from_pid_no_null_check, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *acquired;
@@ -273,6 +290,7 @@ int BPF_PROG(task_kfunc_from_pid_no_null_check, struct task_struct *task, u64 cl
 }
 
 SEC("lsm/task_free")
+__failure __msg("reg type unsupported for arg#0 function")
 int BPF_PROG(task_kfunc_from_lsm_task_free, struct task_struct *task)
 {
 	struct task_struct *acquired;
-- 
2.39.0

