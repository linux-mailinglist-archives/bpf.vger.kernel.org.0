Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EF3643A8C
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 02:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiLFBMQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 5 Dec 2022 20:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiLFBMP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 20:12:15 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CB3DFDB
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 17:12:13 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5JQXdQ000558
        for <bpf@vger.kernel.org>; Mon, 5 Dec 2022 17:12:12 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m9n3633r4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 05 Dec 2022 17:12:12 -0800
Received: from twshared25383.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 17:12:10 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 64A8622F7FD26; Mon,  5 Dec 2022 17:12:03 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: convert dynptr_fail and map_kptr_fail subtests to generic tester
Date:   Mon, 5 Dec 2022 17:11:59 -0800
Message-ID: <20221206011159.1208452-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221206011159.1208452-1-andrii@kernel.org>
References: <20221206011159.1208452-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: a0U1faH463cvkOmrJG0HqnFF6HPZnpco
X-Proofpoint-ORIG-GUID: a0U1faH463cvkOmrJG0HqnFF6HPZnpco
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Convert big chunks of dynptr and map_kptr subtests to use generic
verification_tester. They are switched from using manually maintained
tables of test cases, specifying program name and expected error
verifier message, to btf_decl_tag-based annotations directly on
corresponding BPF programs: __failure to specify that BPF program is
expected to fail verification, and __msg() to specify expected log
message.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c | 80 +------------------
 .../selftests/bpf/prog_tests/map_kptr.c       | 80 +------------------
 .../testing/selftests/bpf/progs/dynptr_fail.c | 31 +++++++
 .../selftests/bpf/progs/dynptr_success.c      |  1 +
 .../selftests/bpf/progs/map_kptr_fail.c       | 27 +++++++
 5 files changed, 64 insertions(+), 155 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index b0c06f821cb8..bfbe61e72dcd 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -5,86 +5,16 @@
 #include "dynptr_fail.skel.h"
 #include "dynptr_success.skel.h"
 
-static size_t log_buf_sz = 1048576; /* 1 MB */
-static char obj_log_buf[1048576];
-
 static struct {
 	const char *prog_name;
 	const char *expected_err_msg;
 } dynptr_tests[] = {
-	/* failure cases */
-	{"ringbuf_missing_release1", "Unreleased reference id=1"},
-	{"ringbuf_missing_release2", "Unreleased reference id=2"},
-	{"ringbuf_missing_release_callback", "Unreleased reference id"},
-	{"use_after_invalid", "Expected an initialized dynptr as arg #3"},
-	{"ringbuf_invalid_api", "type=mem expected=ringbuf_mem"},
-	{"add_dynptr_to_map1", "invalid indirect read from stack"},
-	{"add_dynptr_to_map2", "invalid indirect read from stack"},
-	{"data_slice_out_of_bounds_ringbuf", "value is outside of the allowed memory range"},
-	{"data_slice_out_of_bounds_map_value", "value is outside of the allowed memory range"},
-	{"data_slice_use_after_release1", "invalid mem access 'scalar'"},
-	{"data_slice_use_after_release2", "invalid mem access 'scalar'"},
-	{"data_slice_missing_null_check1", "invalid mem access 'mem_or_null'"},
-	{"data_slice_missing_null_check2", "invalid mem access 'mem_or_null'"},
-	{"invalid_helper1", "invalid indirect read from stack"},
-	{"invalid_helper2", "Expected an initialized dynptr as arg #3"},
-	{"invalid_write1", "Expected an initialized dynptr as arg #1"},
-	{"invalid_write2", "Expected an initialized dynptr as arg #3"},
-	{"invalid_write3", "Expected an initialized dynptr as arg #1"},
-	{"invalid_write4", "arg 1 is an unacquired reference"},
-	{"invalid_read1", "invalid read from stack"},
-	{"invalid_read2", "cannot pass in dynptr at an offset"},
-	{"invalid_read3", "invalid read from stack"},
-	{"invalid_read4", "invalid read from stack"},
-	{"invalid_offset", "invalid write to stack"},
-	{"global", "type=map_value expected=fp"},
-	{"release_twice", "arg 1 is an unacquired reference"},
-	{"release_twice_callback", "arg 1 is an unacquired reference"},
-	{"dynptr_from_mem_invalid_api",
-		"Unsupported reg type fp for bpf_dynptr_from_mem data"},
-
 	/* success cases */
 	{"test_read_write", NULL},
 	{"test_data_slice", NULL},
 	{"test_ringbuf", NULL},
 };
 
-static void verify_fail(const char *prog_name, const char *expected_err_msg)
-{
-	LIBBPF_OPTS(bpf_object_open_opts, opts);
-	struct bpf_program *prog;
-	struct dynptr_fail *skel;
-	int err;
-
-	opts.kernel_log_buf = obj_log_buf;
-	opts.kernel_log_size = log_buf_sz;
-	opts.kernel_log_level = 1;
-
-	skel = dynptr_fail__open_opts(&opts);
-	if (!ASSERT_OK_PTR(skel, "dynptr_fail__open_opts"))
-		goto cleanup;
-
-	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
-	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
-		goto cleanup;
-
-	bpf_program__set_autoload(prog, true);
-
-	bpf_map__set_max_entries(skel->maps.ringbuf, getpagesize());
-
-	err = dynptr_fail__load(skel);
-	if (!ASSERT_ERR(err, "unexpected load success"))
-		goto cleanup;
-
-	if (!ASSERT_OK_PTR(strstr(obj_log_buf, expected_err_msg), "expected_err_msg")) {
-		fprintf(stderr, "Expected err_msg: %s\n", expected_err_msg);
-		fprintf(stderr, "Verifier output: %s\n", obj_log_buf);
-	}
-
-cleanup:
-	dynptr_fail__destroy(skel);
-}
-
 static void verify_success(const char *prog_name)
 {
 	struct dynptr_success *skel;
@@ -97,8 +27,6 @@ static void verify_success(const char *prog_name)
 
 	skel->bss->pid = getpid();
 
-	bpf_map__set_max_entries(skel->maps.ringbuf, getpagesize());
-
 	dynptr_success__load(skel);
 	if (!ASSERT_OK_PTR(skel, "dynptr_success__load"))
 		goto cleanup;
@@ -129,10 +57,8 @@ void test_dynptr(void)
 		if (!test__start_subtest(dynptr_tests[i].prog_name))
 			continue;
 
-		if (dynptr_tests[i].expected_err_msg)
-			verify_fail(dynptr_tests[i].prog_name,
-				    dynptr_tests[i].expected_err_msg);
-		else
-			verify_success(dynptr_tests[i].prog_name);
+		verify_success(dynptr_tests[i].prog_name);
 	}
+
+	RUN_VERIFICATION_TESTS(dynptr_fail);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
index 0d66b1524208..61aa229aacd1 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
@@ -5,83 +5,6 @@
 #include "map_kptr.skel.h"
 #include "map_kptr_fail.skel.h"
 
-static char log_buf[1024 * 1024];
-
-struct {
-	const char *prog_name;
-	const char *err_msg;
-} map_kptr_fail_tests[] = {
-	{ "size_not_bpf_dw", "kptr access size must be BPF_DW" },
-	{ "non_const_var_off", "kptr access cannot have variable offset" },
-	{ "non_const_var_off_kptr_xchg", "R1 doesn't have constant offset. kptr has to be" },
-	{ "misaligned_access_write", "kptr access misaligned expected=8 off=7" },
-	{ "misaligned_access_read", "kptr access misaligned expected=8 off=1" },
-	{ "reject_var_off_store", "variable untrusted_ptr_ access var_off=(0x0; 0x1e0)" },
-	{ "reject_bad_type_match", "invalid kptr access, R1 type=untrusted_ptr_prog_test_ref_kfunc" },
-	{ "marked_as_untrusted_or_null", "R1 type=untrusted_ptr_or_null_ expected=percpu_ptr_" },
-	{ "correct_btf_id_check_size", "access beyond struct prog_test_ref_kfunc at off 32 size 4" },
-	{ "inherit_untrusted_on_walk", "R1 type=untrusted_ptr_ expected=percpu_ptr_" },
-	{ "reject_kptr_xchg_on_unref", "off=8 kptr isn't referenced kptr" },
-	{ "reject_kptr_get_no_map_val", "arg#0 expected pointer to map value" },
-	{ "reject_kptr_get_no_null_map_val", "arg#0 expected pointer to map value" },
-	{ "reject_kptr_get_no_kptr", "arg#0 no referenced kptr at map value offset=0" },
-	{ "reject_kptr_get_on_unref", "arg#0 no referenced kptr at map value offset=8" },
-	{ "reject_kptr_get_bad_type_match", "kernel function bpf_kfunc_call_test_kptr_get args#0" },
-	{ "mark_ref_as_untrusted_or_null", "R1 type=untrusted_ptr_or_null_ expected=percpu_ptr_" },
-	{ "reject_untrusted_store_to_ref", "store to referenced kptr disallowed" },
-	{ "reject_bad_type_xchg", "invalid kptr access, R2 type=ptr_prog_test_ref_kfunc expected=ptr_prog_test_member" },
-	{ "reject_untrusted_xchg", "R2 type=untrusted_ptr_ expected=ptr_" },
-	{ "reject_member_of_ref_xchg", "invalid kptr access, R2 type=ptr_prog_test_ref_kfunc" },
-	{ "reject_indirect_helper_access", "kptr cannot be accessed indirectly by helper" },
-	{ "reject_indirect_global_func_access", "kptr cannot be accessed indirectly by helper" },
-	{ "kptr_xchg_ref_state", "Unreleased reference id=5 alloc_insn=" },
-	{ "kptr_get_ref_state", "Unreleased reference id=3 alloc_insn=" },
-};
-
-static void test_map_kptr_fail_prog(const char *prog_name, const char *err_msg)
-{
-	LIBBPF_OPTS(bpf_object_open_opts, opts, .kernel_log_buf = log_buf,
-						.kernel_log_size = sizeof(log_buf),
-						.kernel_log_level = 1);
-	struct map_kptr_fail *skel;
-	struct bpf_program *prog;
-	int ret;
-
-	skel = map_kptr_fail__open_opts(&opts);
-	if (!ASSERT_OK_PTR(skel, "map_kptr_fail__open_opts"))
-		return;
-
-	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
-	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
-		goto end;
-
-	bpf_program__set_autoload(prog, true);
-
-	ret = map_kptr_fail__load(skel);
-	if (!ASSERT_ERR(ret, "map_kptr__load must fail"))
-		goto end;
-
-	if (!ASSERT_OK_PTR(strstr(log_buf, err_msg), "expected error message")) {
-		fprintf(stderr, "Expected: %s\n", err_msg);
-		fprintf(stderr, "Verifier: %s\n", log_buf);
-	}
-
-end:
-	map_kptr_fail__destroy(skel);
-}
-
-static void test_map_kptr_fail(void)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(map_kptr_fail_tests); i++) {
-		if (!test__start_subtest(map_kptr_fail_tests[i].prog_name))
-			continue;
-		test_map_kptr_fail_prog(map_kptr_fail_tests[i].prog_name,
-					map_kptr_fail_tests[i].err_msg);
-	}
-}
-
 static void test_map_kptr_success(bool test_run)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts,
@@ -145,5 +68,6 @@ void test_map_kptr(void)
 		 */
 		test_map_kptr_success(true);
 	}
-	test_map_kptr_fail();
+
+	RUN_VERIFICATION_TESTS(map_kptr_fail);
 }
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index b0f08ff024fb..78debc1b3820 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -43,6 +43,7 @@ struct sample {
 
 struct {
 	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
 } ringbuf SEC(".maps");
 
 int err, val;
@@ -66,6 +67,7 @@ static int get_map_val_dynptr(struct bpf_dynptr *ptr)
  * bpf_ringbuf_submit/discard_dynptr call
  */
 SEC("?raw_tp")
+__failure __msg("Unreleased reference id=1")
 int ringbuf_missing_release1(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -78,6 +80,7 @@ int ringbuf_missing_release1(void *ctx)
 }
 
 SEC("?raw_tp")
+__failure __msg("Unreleased reference id=2")
 int ringbuf_missing_release2(void *ctx)
 {
 	struct bpf_dynptr ptr1, ptr2;
@@ -113,6 +116,7 @@ static int missing_release_callback_fn(__u32 index, void *data)
 
 /* Any dynptr initialized within a callback must have bpf_dynptr_put called */
 SEC("?raw_tp")
+__failure __msg("Unreleased reference id")
 int ringbuf_missing_release_callback(void *ctx)
 {
 	bpf_loop(10, missing_release_callback_fn, NULL, 0);
@@ -121,6 +125,7 @@ int ringbuf_missing_release_callback(void *ctx)
 
 /* Can't call bpf_ringbuf_submit/discard_dynptr on a non-initialized dynptr */
 SEC("?raw_tp")
+__failure __msg("arg 1 is an unacquired reference")
 int ringbuf_release_uninit_dynptr(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -133,6 +138,7 @@ int ringbuf_release_uninit_dynptr(void *ctx)
 
 /* A dynptr can't be used after it has been invalidated */
 SEC("?raw_tp")
+__failure __msg("Expected an initialized dynptr as arg #3")
 int use_after_invalid(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -152,6 +158,7 @@ int use_after_invalid(void *ctx)
 
 /* Can't call non-dynptr ringbuf APIs on a dynptr ringbuf sample */
 SEC("?raw_tp")
+__failure __msg("type=mem expected=ringbuf_mem")
 int ringbuf_invalid_api(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -174,6 +181,7 @@ int ringbuf_invalid_api(void *ctx)
 
 /* Can't add a dynptr to a map */
 SEC("?raw_tp")
+__failure __msg("invalid indirect read from stack")
 int add_dynptr_to_map1(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -191,6 +199,7 @@ int add_dynptr_to_map1(void *ctx)
 
 /* Can't add a struct with an embedded dynptr to a map */
 SEC("?raw_tp")
+__failure __msg("invalid indirect read from stack")
 int add_dynptr_to_map2(void *ctx)
 {
 	struct test_info x;
@@ -208,6 +217,7 @@ int add_dynptr_to_map2(void *ctx)
 
 /* A data slice can't be accessed out of bounds */
 SEC("?raw_tp")
+__failure __msg("value is outside of the allowed memory range")
 int data_slice_out_of_bounds_ringbuf(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -228,6 +238,7 @@ int data_slice_out_of_bounds_ringbuf(void *ctx)
 }
 
 SEC("?raw_tp")
+__failure __msg("value is outside of the allowed memory range")
 int data_slice_out_of_bounds_map_value(void *ctx)
 {
 	__u32 key = 0, map_val;
@@ -248,6 +259,7 @@ int data_slice_out_of_bounds_map_value(void *ctx)
 
 /* A data slice can't be used after it has been released */
 SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
 int data_slice_use_after_release1(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -279,6 +291,7 @@ int data_slice_use_after_release1(void *ctx)
  * ptr2 is at fp - 16).
  */
 SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
 int data_slice_use_after_release2(void *ctx)
 {
 	struct bpf_dynptr ptr1, ptr2;
@@ -310,6 +323,7 @@ int data_slice_use_after_release2(void *ctx)
 
 /* A data slice must be first checked for NULL */
 SEC("?raw_tp")
+__failure __msg("invalid mem access 'mem_or_null'")
 int data_slice_missing_null_check1(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -330,6 +344,7 @@ int data_slice_missing_null_check1(void *ctx)
 
 /* A data slice can't be dereferenced if it wasn't checked for null */
 SEC("?raw_tp")
+__failure __msg("invalid mem access 'mem_or_null'")
 int data_slice_missing_null_check2(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -352,6 +367,7 @@ int data_slice_missing_null_check2(void *ctx)
  * dynptr argument
  */
 SEC("?raw_tp")
+__failure __msg("invalid indirect read from stack")
 int invalid_helper1(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -366,6 +382,7 @@ int invalid_helper1(void *ctx)
 
 /* A dynptr can't be passed into a helper function at a non-zero offset */
 SEC("?raw_tp")
+__failure __msg("Expected an initialized dynptr as arg #3")
 int invalid_helper2(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -381,6 +398,7 @@ int invalid_helper2(void *ctx)
 
 /* A bpf_dynptr is invalidated if it's been written into */
 SEC("?raw_tp")
+__failure __msg("Expected an initialized dynptr as arg #1")
 int invalid_write1(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -402,6 +420,7 @@ int invalid_write1(void *ctx)
  * offset
  */
 SEC("?raw_tp")
+__failure __msg("Expected an initialized dynptr as arg #3")
 int invalid_write2(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -425,6 +444,7 @@ int invalid_write2(void *ctx)
  * non-const offset
  */
 SEC("?raw_tp")
+__failure __msg("Expected an initialized dynptr as arg #1")
 int invalid_write3(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -456,6 +476,7 @@ static int invalid_write4_callback(__u32 index, void *data)
  * be invalidated as a dynptr
  */
 SEC("?raw_tp")
+__failure __msg("arg 1 is an unacquired reference")
 int invalid_write4(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -472,7 +493,9 @@ int invalid_write4(void *ctx)
 
 /* A globally-defined bpf_dynptr can't be used (it must reside as a stack frame) */
 struct bpf_dynptr global_dynptr;
+
 SEC("?raw_tp")
+__failure __msg("type=map_value expected=fp")
 int global(void *ctx)
 {
 	/* this should fail */
@@ -485,6 +508,7 @@ int global(void *ctx)
 
 /* A direct read should fail */
 SEC("?raw_tp")
+__failure __msg("invalid read from stack")
 int invalid_read1(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -501,6 +525,7 @@ int invalid_read1(void *ctx)
 
 /* A direct read at an offset should fail */
 SEC("?raw_tp")
+__failure __msg("cannot pass in dynptr at an offset")
 int invalid_read2(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -516,6 +541,7 @@ int invalid_read2(void *ctx)
 
 /* A direct read at an offset into the lower stack slot should fail */
 SEC("?raw_tp")
+__failure __msg("invalid read from stack")
 int invalid_read3(void *ctx)
 {
 	struct bpf_dynptr ptr1, ptr2;
@@ -542,6 +568,7 @@ static int invalid_read4_callback(__u32 index, void *data)
 
 /* A direct read within a callback function should fail */
 SEC("?raw_tp")
+__failure __msg("invalid read from stack")
 int invalid_read4(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -557,6 +584,7 @@ int invalid_read4(void *ctx)
 
 /* Initializing a dynptr on an offset should fail */
 SEC("?raw_tp")
+__failure __msg("invalid write to stack")
 int invalid_offset(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -571,6 +599,7 @@ int invalid_offset(void *ctx)
 
 /* Can't release a dynptr twice */
 SEC("?raw_tp")
+__failure __msg("arg 1 is an unacquired reference")
 int release_twice(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -597,6 +626,7 @@ static int release_twice_callback_fn(__u32 index, void *data)
  * within a calback function, fails
  */
 SEC("?raw_tp")
+__failure __msg("arg 1 is an unacquired reference")
 int release_twice_callback(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -612,6 +642,7 @@ int release_twice_callback(void *ctx)
 
 /* Reject unsupported local mem types for dynptr_from_mem API */
 SEC("?raw_tp")
+__failure __msg("Unsupported reg type fp for bpf_dynptr_from_mem data")
 int dynptr_from_mem_invalid_api(void *ctx)
 {
 	struct bpf_dynptr ptr;
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index a3a6103c8569..35db7c6c1fc7 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -20,6 +20,7 @@ struct sample {
 
 struct {
 	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
 } ringbuf SEC(".maps");
 
 struct {
diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
index 05e209b1b12a..760e41e1a632 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
@@ -3,6 +3,7 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
 
 struct map_value {
 	char buf[8];
@@ -23,6 +24,7 @@ extern struct prog_test_ref_kfunc *
 bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **p, int a, int b) __ksym;
 
 SEC("?tc")
+__failure __msg("kptr access size must be BPF_DW")
 int size_not_bpf_dw(struct __sk_buff *ctx)
 {
 	struct map_value *v;
@@ -37,6 +39,7 @@ int size_not_bpf_dw(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
+__failure __msg("kptr access cannot have variable offset")
 int non_const_var_off(struct __sk_buff *ctx)
 {
 	struct map_value *v;
@@ -55,6 +58,7 @@ int non_const_var_off(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
+__failure __msg("R1 doesn't have constant offset. kptr has to be")
 int non_const_var_off_kptr_xchg(struct __sk_buff *ctx)
 {
 	struct map_value *v;
@@ -73,6 +77,7 @@ int non_const_var_off_kptr_xchg(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
+__failure __msg("kptr access misaligned expected=8 off=7")
 int misaligned_access_write(struct __sk_buff *ctx)
 {
 	struct map_value *v;
@@ -88,6 +93,7 @@ int misaligned_access_write(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
+__failure __msg("kptr access misaligned expected=8 off=1")
 int misaligned_access_read(struct __sk_buff *ctx)
 {
 	struct map_value *v;
@@ -101,6 +107,7 @@ int misaligned_access_read(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
+__failure __msg("variable untrusted_ptr_ access var_off=(0x0; 0x1e0)")
 int reject_var_off_store(struct __sk_buff *ctx)
 {
 	struct prog_test_ref_kfunc *unref_ptr;
@@ -124,6 +131,7 @@ int reject_var_off_store(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
+__failure __msg("invalid kptr access, R1 type=untrusted_ptr_prog_test_ref_kfunc")
 int reject_bad_type_match(struct __sk_buff *ctx)
 {
 	struct prog_test_ref_kfunc *unref_ptr;
@@ -144,6 +152,7 @@ int reject_bad_type_match(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
+__failure __msg("R1 type=untrusted_ptr_or_null_ expected=percpu_ptr_")
 int marked_as_untrusted_or_null(struct __sk_buff *ctx)
 {
 	struct map_value *v;
@@ -158,6 +167,7 @@ int marked_as_untrusted_or_null(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
+__failure __msg("access beyond struct prog_test_ref_kfunc at off 32 size 4")
 int correct_btf_id_check_size(struct __sk_buff *ctx)
 {
 	struct prog_test_ref_kfunc *p;
@@ -175,6 +185,7 @@ int correct_btf_id_check_size(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
+__failure __msg("R1 type=untrusted_ptr_ expected=percpu_ptr_")
 int inherit_untrusted_on_walk(struct __sk_buff *ctx)
 {
 	struct prog_test_ref_kfunc *unref_ptr;
@@ -194,6 +205,7 @@ int inherit_untrusted_on_walk(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
+__failure __msg("off=8 kptr isn't referenced kptr")
 int reject_kptr_xchg_on_unref(struct __sk_buff *ctx)
 {
 	struct map_value *v;
@@ -208,6 +220,7 @@ int reject_kptr_xchg_on_unref(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
+__failure __msg("arg#0 expected pointer to map value")
 int reject_kptr_get_no_map_val(struct __sk_buff *ctx)
 {
 	bpf_kfunc_call_test_kptr_get((void *)&ctx, 0, 0);
@@ -215,6 +228,7 @@ int reject_kptr_get_no_map_val(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
+__failure __msg("arg#0 expected pointer to map value")
 int reject_kptr_get_no_null_map_val(struct __sk_buff *ctx)
 {
 	bpf_kfunc_call_test_kptr_get(bpf_map_lookup_elem(&array_map, &(int){0}), 0, 0);
@@ -222,6 +236,7 @@ int reject_kptr_get_no_null_map_val(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
+__failure __msg("arg#0 no referenced kptr at map value offset=0")
 int reject_kptr_get_no_kptr(struct __sk_buff *ctx)
 {
 	struct map_value *v;
@@ -236,6 +251,7 @@ int reject_kptr_get_no_kptr(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
+__failure __msg("arg#0 no referenced kptr at map value offset=8")
 int reject_kptr_get_on_unref(struct __sk_buff *ctx)
 {
 	struct map_value *v;
@@ -250,6 +266,7 @@ int reject_kptr_get_on_unref(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
+__failure __msg("kernel function bpf_kfunc_call_test_kptr_get args#0")
 int reject_kptr_get_bad_type_match(struct __sk_buff *ctx)
 {
 	struct map_value *v;
@@ -264,6 +281,7 @@ int reject_kptr_get_bad_type_match(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
+__failure __msg("R1 type=untrusted_ptr_or_null_ expected=percpu_ptr_")
 int mark_ref_as_untrusted_or_null(struct __sk_buff *ctx)
 {
 	struct map_value *v;
@@ -278,6 +296,7 @@ int mark_ref_as_untrusted_or_null(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
+__failure __msg("store to referenced kptr disallowed")
 int reject_untrusted_store_to_ref(struct __sk_buff *ctx)
 {
 	struct prog_test_ref_kfunc *p;
@@ -297,6 +316,7 @@ int reject_untrusted_store_to_ref(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
+__failure __msg("R2 type=untrusted_ptr_ expected=ptr_")
 int reject_untrusted_xchg(struct __sk_buff *ctx)
 {
 	struct prog_test_ref_kfunc *p;
@@ -315,6 +335,8 @@ int reject_untrusted_xchg(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
+__failure
+__msg("invalid kptr access, R2 type=ptr_prog_test_ref_kfunc expected=ptr_prog_test_member")
 int reject_bad_type_xchg(struct __sk_buff *ctx)
 {
 	struct prog_test_ref_kfunc *ref_ptr;
@@ -333,6 +355,7 @@ int reject_bad_type_xchg(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
+__failure __msg("invalid kptr access, R2 type=ptr_prog_test_ref_kfunc")
 int reject_member_of_ref_xchg(struct __sk_buff *ctx)
 {
 	struct prog_test_ref_kfunc *ref_ptr;
@@ -351,6 +374,7 @@ int reject_member_of_ref_xchg(struct __sk_buff *ctx)
 }
 
 SEC("?syscall")
+__failure __msg("kptr cannot be accessed indirectly by helper")
 int reject_indirect_helper_access(struct __sk_buff *ctx)
 {
 	struct map_value *v;
@@ -371,6 +395,7 @@ int write_func(int *p)
 }
 
 SEC("?tc")
+__failure __msg("kptr cannot be accessed indirectly by helper")
 int reject_indirect_global_func_access(struct __sk_buff *ctx)
 {
 	struct map_value *v;
@@ -384,6 +409,7 @@ int reject_indirect_global_func_access(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
+__failure __msg("Unreleased reference id=5 alloc_insn=")
 int kptr_xchg_ref_state(struct __sk_buff *ctx)
 {
 	struct prog_test_ref_kfunc *p;
@@ -402,6 +428,7 @@ int kptr_xchg_ref_state(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
+__failure __msg("Unreleased reference id=3 alloc_insn=")
 int kptr_get_ref_state(struct __sk_buff *ctx)
 {
 	struct map_value *v;
-- 
2.30.2

