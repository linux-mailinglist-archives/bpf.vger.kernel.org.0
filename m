Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4412569583E
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 06:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjBNFOP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 00:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBNFOO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 00:14:14 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29281BF2
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 21:14:12 -0800 (PST)
Received: by devvm15675.prn0.facebook.com (Postfix, from userid 115148)
        id 45EA765F54ED; Mon, 13 Feb 2023 21:14:00 -0800 (PST)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        martin.lau@linux.dev, kernel-team@fb.com,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 bpf-next 1/2] selftests/bpf: Clean up user_ringbuf, cgrp_kfunc, kfunc_dynptr_param tests
Date:   Mon, 13 Feb 2023 21:13:31 -0800
Message-Id: <20230214051332.4007131-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_SOFTFAIL,SPOOFED_FREEMAIL,SPOOF_GMAIL_MID,
        TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Clean up user_ringbuf, cgrp_kfunc, and kfunc_dynptr_param tests to use
the generic verification tester for checking verifier rejections.
The generic verification tester uses btf_decl_tag-based annotations
for verifying that the tests fail with the expected log messages.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Acked-by: David Vernet <void@manifault.com>
Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../selftests/bpf/prog_tests/cgrp_kfunc.c     | 69 +-----------------
 .../bpf/prog_tests/kfunc_dynptr_param.c       | 72 ++++---------------
 .../selftests/bpf/prog_tests/user_ringbuf.c   | 62 +---------------
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  | 17 ++++-
 .../bpf/progs/test_kfunc_dynptr_param.c       |  4 ++
 .../selftests/bpf/progs/user_ringbuf_fail.c   | 31 +++++---
 6 files changed, 58 insertions(+), 197 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c b/tools/=
testing/selftests/bpf/prog_tests/cgrp_kfunc.c
index f3bb0e16e088..b3f7985c8504 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
@@ -8,9 +8,6 @@
 #include "cgrp_kfunc_failure.skel.h"
 #include "cgrp_kfunc_success.skel.h"
=20
-static size_t log_buf_sz =3D 1 << 20; /* 1 MB */
-static char obj_log_buf[1048576];
-
 static struct cgrp_kfunc_success *open_load_cgrp_kfunc_skel(void)
 {
 	struct cgrp_kfunc_success *skel;
@@ -89,65 +86,6 @@ static const char * const success_tests[] =3D {
 	"test_cgrp_get_ancestors",
 };
=20
-static struct {
-	const char *prog_name;
-	const char *expected_err_msg;
-} failure_tests[] =3D {
-	{"cgrp_kfunc_acquire_untrusted", "Possibly NULL pointer passed to trust=
ed arg0"},
-	{"cgrp_kfunc_acquire_fp", "arg#0 pointer type STRUCT cgroup must point"=
},
-	{"cgrp_kfunc_acquire_unsafe_kretprobe", "reg type unsupported for arg#0=
 function"},
-	{"cgrp_kfunc_acquire_trusted_walked", "R1 must be referenced or trusted=
"},
-	{"cgrp_kfunc_acquire_null", "Possibly NULL pointer passed to trusted ar=
g0"},
-	{"cgrp_kfunc_acquire_unreleased", "Unreleased reference"},
-	{"cgrp_kfunc_get_non_kptr_param", "arg#0 expected pointer to map value"=
},
-	{"cgrp_kfunc_get_non_kptr_acquired", "arg#0 expected pointer to map val=
ue"},
-	{"cgrp_kfunc_get_null", "arg#0 expected pointer to map value"},
-	{"cgrp_kfunc_xchg_unreleased", "Unreleased reference"},
-	{"cgrp_kfunc_get_unreleased", "Unreleased reference"},
-	{"cgrp_kfunc_release_untrusted", "arg#0 is untrusted_ptr_or_null_ expec=
ted ptr_ or socket"},
-	{"cgrp_kfunc_release_fp", "arg#0 pointer type STRUCT cgroup must point"=
},
-	{"cgrp_kfunc_release_null", "arg#0 is ptr_or_null_ expected ptr_ or soc=
ket"},
-	{"cgrp_kfunc_release_unacquired", "release kernel function bpf_cgroup_r=
elease expects"},
-};
-
-static void verify_fail(const char *prog_name, const char *expected_err_=
msg)
-{
-	LIBBPF_OPTS(bpf_object_open_opts, opts);
-	struct cgrp_kfunc_failure *skel;
-	int err, i;
-
-	opts.kernel_log_buf =3D obj_log_buf;
-	opts.kernel_log_size =3D log_buf_sz;
-	opts.kernel_log_level =3D 1;
-
-	skel =3D cgrp_kfunc_failure__open_opts(&opts);
-	if (!ASSERT_OK_PTR(skel, "cgrp_kfunc_failure__open_opts"))
-		goto cleanup;
-
-	for (i =3D 0; i < ARRAY_SIZE(failure_tests); i++) {
-		struct bpf_program *prog;
-		const char *curr_name =3D failure_tests[i].prog_name;
-
-		prog =3D bpf_object__find_program_by_name(skel->obj, curr_name);
-		if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
-			goto cleanup;
-
-		bpf_program__set_autoload(prog, !strcmp(curr_name, prog_name));
-	}
-
-	err =3D cgrp_kfunc_failure__load(skel);
-	if (!ASSERT_ERR(err, "unexpected load success"))
-		goto cleanup;
-
-	if (!ASSERT_OK_PTR(strstr(obj_log_buf, expected_err_msg), "expected_err=
_msg")) {
-		fprintf(stderr, "Expected err_msg: %s\n", expected_err_msg);
-		fprintf(stderr, "Verifier output: %s\n", obj_log_buf);
-	}
-
-cleanup:
-	cgrp_kfunc_failure__destroy(skel);
-}
-
 void test_cgrp_kfunc(void)
 {
 	int i, err;
@@ -163,12 +101,7 @@ void test_cgrp_kfunc(void)
 		run_success_test(success_tests[i]);
 	}
=20
-	for (i =3D 0; i < ARRAY_SIZE(failure_tests); i++) {
-		if (!test__start_subtest(failure_tests[i].prog_name))
-			continue;
-
-		verify_fail(failure_tests[i].prog_name, failure_tests[i].expected_err_=
msg);
-	}
+	RUN_TESTS(cgrp_kfunc_failure);
=20
 cleanup:
 	cleanup_cgroup_environment();
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c =
b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
index 72800b1e8395..8cd298b78e44 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
@@ -10,17 +10,11 @@
 #include <test_progs.h>
 #include "test_kfunc_dynptr_param.skel.h"
=20
-static size_t log_buf_sz =3D 1048576; /* 1 MB */
-static char obj_log_buf[1048576];
-
 static struct {
 	const char *prog_name;
-	const char *expected_verifier_err_msg;
 	int expected_runtime_err;
 } kfunc_dynptr_tests[] =3D {
-	{"not_valid_dynptr", "cannot pass in dynptr at an offset=3D-8", 0},
-	{"not_ptr_to_stack", "arg#0 expected pointer to stack or dynptr_ptr", 0=
},
-	{"dynptr_data_null", NULL, -EBADMSG},
+	{"dynptr_data_null", -EBADMSG},
 };
=20
 static bool kfunc_not_supported;
@@ -38,29 +32,15 @@ static int libbpf_print_cb(enum libbpf_print_level le=
vel, const char *fmt,
 	return 0;
 }
=20
-static void verify_fail(const char *prog_name, const char *expected_err_=
msg)
+static bool has_pkcs7_kfunc_support(void)
 {
 	struct test_kfunc_dynptr_param *skel;
-	LIBBPF_OPTS(bpf_object_open_opts, opts);
 	libbpf_print_fn_t old_print_cb;
-	struct bpf_program *prog;
 	int err;
=20
-	opts.kernel_log_buf =3D obj_log_buf;
-	opts.kernel_log_size =3D log_buf_sz;
-	opts.kernel_log_level =3D 1;
-
-	skel =3D test_kfunc_dynptr_param__open_opts(&opts);
-	if (!ASSERT_OK_PTR(skel, "test_kfunc_dynptr_param__open_opts"))
-		goto cleanup;
-
-	prog =3D bpf_object__find_program_by_name(skel->obj, prog_name);
-	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
-		goto cleanup;
-
-	bpf_program__set_autoload(prog, true);
-
-	bpf_map__set_max_entries(skel->maps.ringbuf, getpagesize());
+	skel =3D test_kfunc_dynptr_param__open();
+	if (!ASSERT_OK_PTR(skel, "test_kfunc_dynptr_param__open"))
+		return false;
=20
 	kfunc_not_supported =3D false;
=20
@@ -72,26 +52,18 @@ static void verify_fail(const char *prog_name, const =
char *expected_err_msg)
 		fprintf(stderr,
 		  "%s:SKIP:bpf_verify_pkcs7_signature() kfunc not supported\n",
 		  __func__);
-		test__skip();
-		goto cleanup;
-	}
-
-	if (!ASSERT_ERR(err, "unexpected load success"))
-		goto cleanup;
-
-	if (!ASSERT_OK_PTR(strstr(obj_log_buf, expected_err_msg), "expected_err=
_msg")) {
-		fprintf(stderr, "Expected err_msg: %s\n", expected_err_msg);
-		fprintf(stderr, "Verifier output: %s\n", obj_log_buf);
+		test_kfunc_dynptr_param__destroy(skel);
+		return false;
 	}
=20
-cleanup:
 	test_kfunc_dynptr_param__destroy(skel);
+
+	return true;
 }
=20
 static void verify_success(const char *prog_name, int expected_runtime_e=
rr)
 {
 	struct test_kfunc_dynptr_param *skel;
-	libbpf_print_fn_t old_print_cb;
 	struct bpf_program *prog;
 	struct bpf_link *link;
 	__u32 next_id;
@@ -103,21 +75,7 @@ static void verify_success(const char *prog_name, int=
 expected_runtime_err)
=20
 	skel->bss->pid =3D getpid();
=20
-	bpf_map__set_max_entries(skel->maps.ringbuf, getpagesize());
-
-	kfunc_not_supported =3D false;
-
-	old_print_cb =3D libbpf_set_print(libbpf_print_cb);
 	err =3D test_kfunc_dynptr_param__load(skel);
-	libbpf_set_print(old_print_cb);
-
-	if (err < 0 && kfunc_not_supported) {
-		fprintf(stderr,
-		  "%s:SKIP:bpf_verify_pkcs7_signature() kfunc not supported\n",
-		  __func__);
-		test__skip();
-		goto cleanup;
-	}
=20
 	if (!ASSERT_OK(err, "test_kfunc_dynptr_param__load"))
 		goto cleanup;
@@ -147,15 +105,15 @@ void test_kfunc_dynptr_param(void)
 {
 	int i;
=20
+	if (!has_pkcs7_kfunc_support())
+		return;
+
 	for (i =3D 0; i < ARRAY_SIZE(kfunc_dynptr_tests); i++) {
 		if (!test__start_subtest(kfunc_dynptr_tests[i].prog_name))
 			continue;
=20
-		if (kfunc_dynptr_tests[i].expected_verifier_err_msg)
-			verify_fail(kfunc_dynptr_tests[i].prog_name,
-			  kfunc_dynptr_tests[i].expected_verifier_err_msg);
-		else
-			verify_success(kfunc_dynptr_tests[i].prog_name,
-				kfunc_dynptr_tests[i].expected_runtime_err);
+		verify_success(kfunc_dynptr_tests[i].prog_name,
+			kfunc_dynptr_tests[i].expected_runtime_err);
 	}
+	RUN_TESTS(test_kfunc_dynptr_param);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tool=
s/testing/selftests/bpf/prog_tests/user_ringbuf.c
index dae68de285b9..3a13e102c149 100644
--- a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
@@ -19,8 +19,6 @@
=20
 #include "../progs/test_user_ringbuf.h"
=20
-static size_t log_buf_sz =3D 1 << 20; /* 1 MB */
-static char obj_log_buf[1048576];
 static const long c_sample_size =3D sizeof(struct sample) + BPF_RINGBUF_=
HDR_SZ;
 static const long c_ringbuf_size =3D 1 << 12; /* 1 small page */
 static const long c_max_entries =3D c_ringbuf_size / c_sample_size;
@@ -663,23 +661,6 @@ static void test_user_ringbuf_blocking_reserve(void)
 	user_ringbuf_success__destroy(skel);
 }
=20
-static struct {
-	const char *prog_name;
-	const char *expected_err_msg;
-} failure_tests[] =3D {
-	/* failure cases */
-	{"user_ringbuf_callback_bad_access1", "negative offset dynptr_ptr ptr"}=
,
-	{"user_ringbuf_callback_bad_access2", "dereference of modified dynptr_p=
tr ptr"},
-	{"user_ringbuf_callback_write_forbidden", "invalid mem access 'dynptr_p=
tr'"},
-	{"user_ringbuf_callback_null_context_write", "invalid mem access 'scala=
r'"},
-	{"user_ringbuf_callback_null_context_read", "invalid mem access 'scalar=
'"},
-	{"user_ringbuf_callback_discard_dynptr", "cannot release unowned const =
bpf_dynptr"},
-	{"user_ringbuf_callback_submit_dynptr", "cannot release unowned const b=
pf_dynptr"},
-	{"user_ringbuf_callback_invalid_return", "At callback return the regist=
er R0 has value"},
-	{"user_ringbuf_callback_reinit_dynptr_mem", "Dynptr has to be an uninit=
ialized dynptr"},
-	{"user_ringbuf_callback_reinit_dynptr_ringbuf", "Dynptr has to be an un=
initialized dynptr"},
-};
-
 #define SUCCESS_TEST(_func) { _func, #_func }
=20
 static struct {
@@ -700,42 +681,6 @@ static struct {
 	SUCCESS_TEST(test_user_ringbuf_blocking_reserve),
 };
=20
-static void verify_fail(const char *prog_name, const char *expected_err_=
msg)
-{
-	LIBBPF_OPTS(bpf_object_open_opts, opts);
-	struct bpf_program *prog;
-	struct user_ringbuf_fail *skel;
-	int err;
-
-	opts.kernel_log_buf =3D obj_log_buf;
-	opts.kernel_log_size =3D log_buf_sz;
-	opts.kernel_log_level =3D 1;
-
-	skel =3D user_ringbuf_fail__open_opts(&opts);
-	if (!ASSERT_OK_PTR(skel, "dynptr_fail__open_opts"))
-		goto cleanup;
-
-	prog =3D bpf_object__find_program_by_name(skel->obj, prog_name);
-	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
-		goto cleanup;
-
-	bpf_program__set_autoload(prog, true);
-
-	bpf_map__set_max_entries(skel->maps.user_ringbuf, getpagesize());
-
-	err =3D user_ringbuf_fail__load(skel);
-	if (!ASSERT_ERR(err, "unexpected load success"))
-		goto cleanup;
-
-	if (!ASSERT_OK_PTR(strstr(obj_log_buf, expected_err_msg), "expected_err=
_msg")) {
-		fprintf(stderr, "Expected err_msg: %s\n", expected_err_msg);
-		fprintf(stderr, "Verifier output: %s\n", obj_log_buf);
-	}
-
-cleanup:
-	user_ringbuf_fail__destroy(skel);
-}
-
 void test_user_ringbuf(void)
 {
 	int i;
@@ -747,10 +692,5 @@ void test_user_ringbuf(void)
 		success_tests[i].test_callback();
 	}
=20
-	for (i =3D 0; i < ARRAY_SIZE(failure_tests); i++) {
-		if (!test__start_subtest(failure_tests[i].prog_name))
-			continue;
-
-		verify_fail(failure_tests[i].prog_name, failure_tests[i].expected_err_=
msg);
-	}
+	RUN_TESTS(user_ringbuf_fail);
 }
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c b/too=
ls/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
index a1369b5ebcf8..4ad7fe24966d 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
@@ -5,6 +5,7 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
=20
+#include "bpf_misc.h"
 #include "cgrp_kfunc_common.h"
=20
 char _license[] SEC("license") =3D "GPL";
@@ -28,6 +29,7 @@ static struct __cgrps_kfunc_map_value *insert_lookup_cg=
rp(struct cgroup *cgrp)
 }
=20
 SEC("tp_btf/cgroup_mkdir")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
 int BPF_PROG(cgrp_kfunc_acquire_untrusted, struct cgroup *cgrp, const ch=
ar *path)
 {
 	struct cgroup *acquired;
@@ -45,6 +47,7 @@ int BPF_PROG(cgrp_kfunc_acquire_untrusted, struct cgrou=
p *cgrp, const char *path
 }
=20
 SEC("tp_btf/cgroup_mkdir")
+__failure __msg("arg#0 pointer type STRUCT cgroup must point")
 int BPF_PROG(cgrp_kfunc_acquire_fp, struct cgroup *cgrp, const char *pat=
h)
 {
 	struct cgroup *acquired, *stack_cgrp =3D (struct cgroup *)&path;
@@ -57,6 +60,7 @@ int BPF_PROG(cgrp_kfunc_acquire_fp, struct cgroup *cgrp=
, const char *path)
 }
=20
 SEC("kretprobe/cgroup_destroy_locked")
+__failure __msg("reg type unsupported for arg#0 function")
 int BPF_PROG(cgrp_kfunc_acquire_unsafe_kretprobe, struct cgroup *cgrp)
 {
 	struct cgroup *acquired;
@@ -69,6 +73,7 @@ int BPF_PROG(cgrp_kfunc_acquire_unsafe_kretprobe, struc=
t cgroup *cgrp)
 }
=20
 SEC("tp_btf/cgroup_mkdir")
+__failure __msg("cgrp_kfunc_acquire_trusted_walked")
 int BPF_PROG(cgrp_kfunc_acquire_trusted_walked, struct cgroup *cgrp, con=
st char *path)
 {
 	struct cgroup *acquired;
@@ -80,8 +85,8 @@ int BPF_PROG(cgrp_kfunc_acquire_trusted_walked, struct =
cgroup *cgrp, const char
 	return 0;
 }
=20
-
 SEC("tp_btf/cgroup_mkdir")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
 int BPF_PROG(cgrp_kfunc_acquire_null, struct cgroup *cgrp, const char *p=
ath)
 {
 	struct cgroup *acquired;
@@ -96,6 +101,7 @@ int BPF_PROG(cgrp_kfunc_acquire_null, struct cgroup *c=
grp, const char *path)
 }
=20
 SEC("tp_btf/cgroup_mkdir")
+__failure __msg("Unreleased reference")
 int BPF_PROG(cgrp_kfunc_acquire_unreleased, struct cgroup *cgrp, const c=
har *path)
 {
 	struct cgroup *acquired;
@@ -108,6 +114,7 @@ int BPF_PROG(cgrp_kfunc_acquire_unreleased, struct cg=
roup *cgrp, const char *pat
 }
=20
 SEC("tp_btf/cgroup_mkdir")
+__failure __msg("arg#0 expected pointer to map value")
 int BPF_PROG(cgrp_kfunc_get_non_kptr_param, struct cgroup *cgrp, const c=
har *path)
 {
 	struct cgroup *kptr;
@@ -123,6 +130,7 @@ int BPF_PROG(cgrp_kfunc_get_non_kptr_param, struct cg=
roup *cgrp, const char *pat
 }
=20
 SEC("tp_btf/cgroup_mkdir")
+__failure __msg("arg#0 expected pointer to map value")
 int BPF_PROG(cgrp_kfunc_get_non_kptr_acquired, struct cgroup *cgrp, cons=
t char *path)
 {
 	struct cgroup *kptr, *acquired;
@@ -141,6 +149,7 @@ int BPF_PROG(cgrp_kfunc_get_non_kptr_acquired, struct=
 cgroup *cgrp, const char *
 }
=20
 SEC("tp_btf/cgroup_mkdir")
+__failure __msg("arg#0 expected pointer to map value")
 int BPF_PROG(cgrp_kfunc_get_null, struct cgroup *cgrp, const char *path)
 {
 	struct cgroup *kptr;
@@ -156,6 +165,7 @@ int BPF_PROG(cgrp_kfunc_get_null, struct cgroup *cgrp=
, const char *path)
 }
=20
 SEC("tp_btf/cgroup_mkdir")
+__failure __msg("Unreleased reference")
 int BPF_PROG(cgrp_kfunc_xchg_unreleased, struct cgroup *cgrp, const char=
 *path)
 {
 	struct cgroup *kptr;
@@ -175,6 +185,7 @@ int BPF_PROG(cgrp_kfunc_xchg_unreleased, struct cgrou=
p *cgrp, const char *path)
 }
=20
 SEC("tp_btf/cgroup_mkdir")
+__failure __msg("Unreleased reference")
 int BPF_PROG(cgrp_kfunc_get_unreleased, struct cgroup *cgrp, const char =
*path)
 {
 	struct cgroup *kptr;
@@ -194,6 +205,7 @@ int BPF_PROG(cgrp_kfunc_get_unreleased, struct cgroup=
 *cgrp, const char *path)
 }
=20
 SEC("tp_btf/cgroup_mkdir")
+__failure __msg("arg#0 is untrusted_ptr_or_null_ expected ptr_ or socket=
")
 int BPF_PROG(cgrp_kfunc_release_untrusted, struct cgroup *cgrp, const ch=
ar *path)
 {
 	struct __cgrps_kfunc_map_value *v;
@@ -209,6 +221,7 @@ int BPF_PROG(cgrp_kfunc_release_untrusted, struct cgr=
oup *cgrp, const char *path
 }
=20
 SEC("tp_btf/cgroup_mkdir")
+__failure __msg("arg#0 pointer type STRUCT cgroup must point")
 int BPF_PROG(cgrp_kfunc_release_fp, struct cgroup *cgrp, const char *pat=
h)
 {
 	struct cgroup *acquired =3D (struct cgroup *)&path;
@@ -220,6 +233,7 @@ int BPF_PROG(cgrp_kfunc_release_fp, struct cgroup *cg=
rp, const char *path)
 }
=20
 SEC("tp_btf/cgroup_mkdir")
+__failure __msg("arg#0 is ptr_or_null_ expected ptr_ or socket")
 int BPF_PROG(cgrp_kfunc_release_null, struct cgroup *cgrp, const char *p=
ath)
 {
 	struct __cgrps_kfunc_map_value local, *v;
@@ -251,6 +265,7 @@ int BPF_PROG(cgrp_kfunc_release_null, struct cgroup *=
cgrp, const char *path)
 }
=20
 SEC("tp_btf/cgroup_mkdir")
+__failure __msg("release kernel function bpf_cgroup_release expects")
 int BPF_PROG(cgrp_kfunc_release_unacquired, struct cgroup *cgrp, const c=
har *path)
 {
 	/* Cannot release trusted cgroup pointer which was not acquired. */
diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c =
b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
index f4a8250329b2..2fbef3cc7ad8 100644
--- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
+++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
=20
 extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
 extern void bpf_key_put(struct bpf_key *key) __ksym;
@@ -19,6 +20,7 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr=
 *data_ptr,
=20
 struct {
 	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
 } ringbuf SEC(".maps");
=20
 struct {
@@ -33,6 +35,7 @@ int err, pid;
 char _license[] SEC("license") =3D "GPL";
=20
 SEC("?lsm.s/bpf")
+__failure __msg("cannot pass in dynptr at an offset=3D-8")
 int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned i=
nt size)
 {
 	unsigned long val;
@@ -42,6 +45,7 @@ int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr =
*attr, unsigned int size)
 }
=20
 SEC("?lsm.s/bpf")
+__failure __msg("arg#0 expected pointer to stack or dynptr_ptr")
 int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned i=
nt size)
 {
 	unsigned long val;
diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c b/tool=
s/testing/selftests/bpf/progs/user_ringbuf_fail.c
index f3201dc69a60..03ee946c6bf7 100644
--- a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
+++ b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
@@ -16,6 +16,7 @@ struct sample {
=20
 struct {
 	__uint(type, BPF_MAP_TYPE_USER_RINGBUF);
+	__uint(max_entries, 4096);
 } user_ringbuf SEC(".maps");
=20
 struct {
@@ -39,7 +40,8 @@ bad_access1(struct bpf_dynptr *dynptr, void *context)
 /* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callbac=
k should
  * not be able to read before the pointer.
  */
-SEC("?raw_tp/")
+SEC("?raw_tp")
+__failure __msg("negative offset dynptr_ptr ptr")
 int user_ringbuf_callback_bad_access1(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, bad_access1, NULL, 0);
@@ -61,7 +63,8 @@ bad_access2(struct bpf_dynptr *dynptr, void *context)
 /* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callbac=
k should
  * not be able to read past the end of the pointer.
  */
-SEC("?raw_tp/")
+SEC("?raw_tp")
+__failure __msg("dereference of modified dynptr_ptr ptr")
 int user_ringbuf_callback_bad_access2(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, bad_access2, NULL, 0);
@@ -80,7 +83,8 @@ write_forbidden(struct bpf_dynptr *dynptr, void *contex=
t)
 /* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callbac=
k should
  * not be able to write to that pointer.
  */
-SEC("?raw_tp/")
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'dynptr_ptr'")
 int user_ringbuf_callback_write_forbidden(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, write_forbidden, NULL, 0);
@@ -99,7 +103,8 @@ null_context_write(struct bpf_dynptr *dynptr, void *co=
ntext)
 /* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callbac=
k should
  * not be able to write to that pointer.
  */
-SEC("?raw_tp/")
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
 int user_ringbuf_callback_null_context_write(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, null_context_write, NULL, 0);
@@ -120,7 +125,8 @@ null_context_read(struct bpf_dynptr *dynptr, void *co=
ntext)
 /* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callbac=
k should
  * not be able to write to that pointer.
  */
-SEC("?raw_tp/")
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
 int user_ringbuf_callback_null_context_read(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, null_context_read, NULL, 0);
@@ -139,7 +145,8 @@ try_discard_dynptr(struct bpf_dynptr *dynptr, void *c=
ontext)
 /* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callbac=
k should
  * not be able to read past the end of the pointer.
  */
-SEC("?raw_tp/")
+SEC("?raw_tp")
+__failure __msg("cannot release unowned const bpf_dynptr")
 int user_ringbuf_callback_discard_dynptr(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, try_discard_dynptr, NULL, 0);
@@ -158,7 +165,8 @@ try_submit_dynptr(struct bpf_dynptr *dynptr, void *co=
ntext)
 /* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callbac=
k should
  * not be able to read past the end of the pointer.
  */
-SEC("?raw_tp/")
+SEC("?raw_tp")
+__failure __msg("cannot release unowned const bpf_dynptr")
 int user_ringbuf_callback_submit_dynptr(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, try_submit_dynptr, NULL, 0);
@@ -175,7 +183,8 @@ invalid_drain_callback_return(struct bpf_dynptr *dynp=
tr, void *context)
 /* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callbac=
k should
  * not be able to write to that pointer.
  */
-SEC("?raw_tp/")
+SEC("?raw_tp")
+__failure __msg("At callback return the register R0 has value")
 int user_ringbuf_callback_invalid_return(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, invalid_drain_callback_return, NU=
LL, 0);
@@ -197,14 +206,16 @@ try_reinit_dynptr_ringbuf(struct bpf_dynptr *dynptr=
, void *context)
 	return 0;
 }
=20
-SEC("?raw_tp/")
+SEC("?raw_tp")
+__failure __msg("Dynptr has to be an uninitialized dynptr")
 int user_ringbuf_callback_reinit_dynptr_mem(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, try_reinit_dynptr_mem, NULL, 0);
 	return 0;
 }
=20
-SEC("?raw_tp/")
+SEC("?raw_tp")
+__failure __msg("Dynptr has to be an uninitialized dynptr")
 int user_ringbuf_callback_reinit_dynptr_ringbuf(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, try_reinit_dynptr_ringbuf, NULL, =
0);
--=20
2.30.2

