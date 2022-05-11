Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA501523DCD
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 21:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347107AbiEKTqg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 15:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347115AbiEKTqf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 15:46:35 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251462B1AE
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 12:46:34 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e24so3194016pjt.2
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 12:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mItuG3LSb4L0/0d8ced1l26d0Mn+UkoBToBglGRj234=;
        b=UTwFFLEnBhHllTbxX/AetSsO+DiNAv8Kn6DMOrc35gvVXpFQpsCNpBJNxO+hp/NRMd
         BvsVxcsc3RqzAAVlY9bvjzOZUNPK8vU11TXRjn/+4lbTWxSk3LeY8a73IdQmDT1v0NSr
         MRXZxNOkzl/5PQAuF8l4q4tih+fdH+PbmWHTb641JUY6CiaRb71b//VJj6ekFcYIjTe1
         QX8AGMeT1o+6lE4a9pYX46t/FbGof8Myfyx/G7k76ubTiSdyE77Zq06PhaLe0s5eEet2
         NqBWr+GHx3rxkbIeiMiPuAeBrXaW0P/IXrnD3zF7GN0VuEr0NuAmE2Hm+0XqbbTdarNe
         ElZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mItuG3LSb4L0/0d8ced1l26d0Mn+UkoBToBglGRj234=;
        b=eQwLpSQBYfI+YURlDqu+tjZLGymIhwgLBBaPx9r2VafLAjmoMAjb4Q+SxTLGNVXNP9
         13RHtld4kUNaeMBGNZgT/F8/sl3o+qa4NleJjtWUDSR7MhoBkcRe86yN0S/sK3HhmeXn
         SWTQBEDvpSn+H8+3a6Wq9RUmEMfmBvsQDf0oguLDiMNb5ZDI8WaLzCL2NCkIy7ZvK2y3
         eoHyMACg9+eu2WU1O3dkhlivh6t1fqEkGvF3FSqJr6bFA9u1+Oh2VhGyPg8vnu3kDEWD
         OMGbq6uF7t7Z0Ak/uG/ADlNb84AUYslbEEsCDaCvJCxm6POlXql3iEdgK5A1/Y95MJ56
         WxYA==
X-Gm-Message-State: AOAM532HixBWD0a5AJak+Rj3oyura3JaI5zFIa+lJS+b5cp4AGijT5zQ
        oI6XhjIjrOj5Dlvz9qZKI4+Nr+nDbcc=
X-Google-Smtp-Source: ABdhPJyf1JOmC2YlHIsti5G6a4JzomrCEQuAKWvK37kJmpQyhedLhr35osRqlDLf/XtOicpM/DY92Q==
X-Received: by 2002:a17:90a:b106:b0:1d9:7cde:7914 with SMTP id z6-20020a17090ab10600b001d97cde7914mr6942346pjq.56.1652298393461;
        Wed, 11 May 2022 12:46:33 -0700 (PDT)
Received: from localhost ([112.79.166.171])
        by smtp.gmail.com with ESMTPSA id y16-20020a170902d65000b0015e8d4eb26fsm2246517plh.185.2022.05.11.12.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 12:46:32 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: Add negative C tests for kptrs
Date:   Thu, 12 May 2022 01:16:53 +0530
Message-Id: <20220511194654.765705-4-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511194654.765705-1-memxor@gmail.com>
References: <20220511194654.765705-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13298; h=from:subject; bh=lsOkZO8HmKnLQ2bZCAOPAdV2rs8C6/JYTkO0FIdpHFw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBifBG7haQliH451dytQJF7L3R0VVdUb8s+k7V0mm7n 89OBpYmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYnwRuwAKCRBM4MiGSL8RypZND/ 4iW/jsTJfD1Qns5kRN733vmTnn+V1eADYMb/Iv08GF7YNFvk+iYjq1arv4nnZuGnk3NPMrTUNW91I0 0QEzBkYUDrzPPJelfo1Bc4GxzM11S693GymLhuT83A51gmpnSIEbnABtfnDt+20kJo6ngP3HRtULqP ttYkxi8X155MSYddItqUZXBJ2uNNKbKXW5SLC6qoFUFGiubJIvMYbHGZH0oGWoOk2XR24zMfTHOMkF jOc+JdzAO7gAtwBS9Fd7U9XrMH9YHtUyDZ6AUHMkcy8jlEQAmtr9/ms+jpCtfvPiSeXcrYc0HQkpRG O/4ZsNGzS+8rY0wAqgES1C/wLPLfZGVFFdEM5mbs5e+JWCCMmSPAa+dfV+7yVOepZrN5+1QaT+OucA a0BxW3+DKNK8H8D8TNtGeMkNFhDQgIcG0erkC8/2PirYVabPAl/xhVkLoLD30T9rt8c1sXHIJO0RwR /1Oc3JfEjiUipk0SUEnjwpXe7lzxlmk2pjdDOfuqBNvrORuMtJHMhz2LTmPHQ4v5V9kc0PAplhWjrH rC3f8tB2fkdn+BRHae8NmHSPap8OcoZ7uFzMPTHzToBx+uinFWtEiGZQsvU3tYSoXmobWPo2gTRHa7 YEceNu5rn7Lr0XlUIoIO6KHPqWZtpSLOmemkau5d2FNCflVJpe/zduwoCz+A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This uses the newly added SEC("?foo") naming to disable autoload of
programs, and then loads them one by one for the object and verifies
that loading fails and matches the returned error string from verifier.
This is similar to already existing verifier tests but provides coverage
for BPF C.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/map_kptr.c       |  87 +++-
 .../selftests/bpf/progs/map_kptr_fail.c       | 418 ++++++++++++++++++
 2 files changed, 504 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/map_kptr_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
index 9e2fbda64a65..00819277cb17 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
@@ -2,8 +2,86 @@
 #include <test_progs.h>
 
 #include "map_kptr.skel.h"
+#include "map_kptr_fail.skel.h"
 
-void test_map_kptr(void)
+static char log_buf[1024 * 1024];
+
+struct {
+	const char *prog_name;
+	const char *err_msg;
+} map_kptr_fail_tests[] = {
+	{ "size_not_bpf_dw", "kptr access size must be BPF_DW" },
+	{ "non_const_var_off", "kptr access cannot have variable offset" },
+	{ "non_const_var_off_kptr_xchg", "R1 doesn't have constant offset. kptr has to be" },
+	{ "misaligned_access_write", "kptr access misaligned expected=8 off=7" },
+	{ "misaligned_access_read", "kptr access misaligned expected=8 off=1" },
+	{ "reject_var_off_store", "variable untrusted_ptr_ access var_off=(0x0; 0x1e0)" },
+	{ "reject_bad_type_match", "invalid kptr access, R1 type=untrusted_ptr_prog_test_ref_kfunc" },
+	{ "marked_as_untrusted_or_null", "R1 type=untrusted_ptr_or_null_ expected=percpu_ptr_" },
+	{ "correct_btf_id_check_size", "access beyond struct prog_test_ref_kfunc at off 32 size 4" },
+	{ "inherit_untrusted_on_walk", "R1 type=untrusted_ptr_ expected=percpu_ptr_" },
+	{ "reject_kptr_xchg_on_unref", "off=8 kptr isn't referenced kptr" },
+	{ "reject_kptr_get_no_map_val", "arg#0 expected pointer to map value" },
+	{ "reject_kptr_get_no_null_map_val", "arg#0 expected pointer to map value" },
+	{ "reject_kptr_get_no_kptr", "arg#0 no referenced kptr at map value offset=0" },
+	{ "reject_kptr_get_on_unref", "arg#0 no referenced kptr at map value offset=8" },
+	{ "reject_kptr_get_bad_type_match", "kernel function bpf_kfunc_call_test_kptr_get args#0" },
+	{ "mark_ref_as_untrusted_or_null", "R1 type=untrusted_ptr_or_null_ expected=percpu_ptr_" },
+	{ "reject_untrusted_store_to_ref", "store to referenced kptr disallowed" },
+	{ "reject_bad_type_xchg", "invalid kptr access, R2 type=ptr_prog_test_ref_kfunc expected=ptr_prog_test_member" },
+	{ "reject_untrusted_xchg", "R2 type=untrusted_ptr_ expected=ptr_" },
+	{ "reject_member_of_ref_xchg", "invalid kptr access, R2 type=ptr_prog_test_ref_kfunc" },
+	{ "reject_indirect_helper_access", "kptr cannot be accessed indirectly by helper" },
+	{ "reject_indirect_global_func_access", "kptr cannot be accessed indirectly by helper" },
+	{ "kptr_xchg_ref_state", "Unreleased reference id=5 alloc_insn=" },
+	{ "kptr_get_ref_state", "Unreleased reference id=3 alloc_insn=" },
+};
+
+static void test_map_kptr_fail_prog(const char *prog_name, const char *err_msg)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, opts, .kernel_log_buf = log_buf,
+						.kernel_log_size = sizeof(log_buf),
+						.kernel_log_level = 1);
+	struct map_kptr_fail *skel;
+	struct bpf_program *prog;
+	int ret;
+
+	skel = map_kptr_fail__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "map_kptr_fail__open_opts"))
+		return;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto end;
+
+	bpf_program__set_autoload(prog, true);
+
+	ret = map_kptr_fail__load(skel);
+	if (!ASSERT_ERR(ret, "map_kptr__load must fail"))
+		goto end;
+
+	if (!ASSERT_OK_PTR(strstr(log_buf, err_msg), "expected error message")) {
+		fprintf(stderr, "Expected: %s\n", err_msg);
+		fprintf(stderr, "Verifier: %s\n", log_buf);
+	}
+
+end:
+	map_kptr_fail__destroy(skel);
+}
+
+static void test_map_kptr_fail(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(map_kptr_fail_tests); i++) {
+		if (!test__start_subtest(map_kptr_fail_tests[i].prog_name))
+			continue;
+		test_map_kptr_fail_prog(map_kptr_fail_tests[i].prog_name,
+					map_kptr_fail_tests[i].err_msg);
+	}
+}
+
+static void test_map_kptr_success(void)
 {
 	struct map_kptr *skel;
 	int key = 0, ret;
@@ -35,3 +113,10 @@ void test_map_kptr(void)
 
 	map_kptr__destroy(skel);
 }
+
+void test_map_kptr(void)
+{
+	if (test__start_subtest("success"))
+		test_map_kptr_success();
+	test_map_kptr_fail();
+}
diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
new file mode 100644
index 000000000000..05e209b1b12a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
@@ -0,0 +1,418 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+
+struct map_value {
+	char buf[8];
+	struct prog_test_ref_kfunc __kptr *unref_ptr;
+	struct prog_test_ref_kfunc __kptr_ref *ref_ptr;
+	struct prog_test_member __kptr_ref *ref_memb_ptr;
+};
+
+struct array_map {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+} array_map SEC(".maps");
+
+extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *sp) __ksym;
+extern struct prog_test_ref_kfunc *
+bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **p, int a, int b) __ksym;
+
+SEC("?tc")
+int size_not_bpf_dw(struct __sk_buff *ctx)
+{
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 0;
+
+	*(u32 *)&v->unref_ptr = 0;
+	return 0;
+}
+
+SEC("?tc")
+int non_const_var_off(struct __sk_buff *ctx)
+{
+	struct map_value *v;
+	int key = 0, id;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 0;
+
+	id = ctx->protocol;
+	if (id < 4 || id > 12)
+		return 0;
+	*(u64 *)((void *)v + id) = 0;
+
+	return 0;
+}
+
+SEC("?tc")
+int non_const_var_off_kptr_xchg(struct __sk_buff *ctx)
+{
+	struct map_value *v;
+	int key = 0, id;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 0;
+
+	id = ctx->protocol;
+	if (id < 4 || id > 12)
+		return 0;
+	bpf_kptr_xchg((void *)v + id, NULL);
+
+	return 0;
+}
+
+SEC("?tc")
+int misaligned_access_write(struct __sk_buff *ctx)
+{
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 0;
+
+	*(void **)((void *)v + 7) = NULL;
+
+	return 0;
+}
+
+SEC("?tc")
+int misaligned_access_read(struct __sk_buff *ctx)
+{
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 0;
+
+	return *(u64 *)((void *)v + 1);
+}
+
+SEC("?tc")
+int reject_var_off_store(struct __sk_buff *ctx)
+{
+	struct prog_test_ref_kfunc *unref_ptr;
+	struct map_value *v;
+	int key = 0, id;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 0;
+
+	unref_ptr = v->unref_ptr;
+	if (!unref_ptr)
+		return 0;
+	id = ctx->protocol;
+	if (id < 4 || id > 12)
+		return 0;
+	unref_ptr += id;
+	v->unref_ptr = unref_ptr;
+
+	return 0;
+}
+
+SEC("?tc")
+int reject_bad_type_match(struct __sk_buff *ctx)
+{
+	struct prog_test_ref_kfunc *unref_ptr;
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 0;
+
+	unref_ptr = v->unref_ptr;
+	if (!unref_ptr)
+		return 0;
+	unref_ptr = (void *)unref_ptr + 4;
+	v->unref_ptr = unref_ptr;
+
+	return 0;
+}
+
+SEC("?tc")
+int marked_as_untrusted_or_null(struct __sk_buff *ctx)
+{
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 0;
+
+	bpf_this_cpu_ptr(v->unref_ptr);
+	return 0;
+}
+
+SEC("?tc")
+int correct_btf_id_check_size(struct __sk_buff *ctx)
+{
+	struct prog_test_ref_kfunc *p;
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 0;
+
+	p = v->unref_ptr;
+	if (!p)
+		return 0;
+	return *(int *)((void *)p + bpf_core_type_size(struct prog_test_ref_kfunc));
+}
+
+SEC("?tc")
+int inherit_untrusted_on_walk(struct __sk_buff *ctx)
+{
+	struct prog_test_ref_kfunc *unref_ptr;
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 0;
+
+	unref_ptr = v->unref_ptr;
+	if (!unref_ptr)
+		return 0;
+	unref_ptr = unref_ptr->next;
+	bpf_this_cpu_ptr(unref_ptr);
+	return 0;
+}
+
+SEC("?tc")
+int reject_kptr_xchg_on_unref(struct __sk_buff *ctx)
+{
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 0;
+
+	bpf_kptr_xchg(&v->unref_ptr, NULL);
+	return 0;
+}
+
+SEC("?tc")
+int reject_kptr_get_no_map_val(struct __sk_buff *ctx)
+{
+	bpf_kfunc_call_test_kptr_get((void *)&ctx, 0, 0);
+	return 0;
+}
+
+SEC("?tc")
+int reject_kptr_get_no_null_map_val(struct __sk_buff *ctx)
+{
+	bpf_kfunc_call_test_kptr_get(bpf_map_lookup_elem(&array_map, &(int){0}), 0, 0);
+	return 0;
+}
+
+SEC("?tc")
+int reject_kptr_get_no_kptr(struct __sk_buff *ctx)
+{
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 0;
+
+	bpf_kfunc_call_test_kptr_get((void *)v, 0, 0);
+	return 0;
+}
+
+SEC("?tc")
+int reject_kptr_get_on_unref(struct __sk_buff *ctx)
+{
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 0;
+
+	bpf_kfunc_call_test_kptr_get(&v->unref_ptr, 0, 0);
+	return 0;
+}
+
+SEC("?tc")
+int reject_kptr_get_bad_type_match(struct __sk_buff *ctx)
+{
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 0;
+
+	bpf_kfunc_call_test_kptr_get((void *)&v->ref_memb_ptr, 0, 0);
+	return 0;
+}
+
+SEC("?tc")
+int mark_ref_as_untrusted_or_null(struct __sk_buff *ctx)
+{
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 0;
+
+	bpf_this_cpu_ptr(v->ref_ptr);
+	return 0;
+}
+
+SEC("?tc")
+int reject_untrusted_store_to_ref(struct __sk_buff *ctx)
+{
+	struct prog_test_ref_kfunc *p;
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 0;
+
+	p = v->ref_ptr;
+	if (!p)
+		return 0;
+	/* Checkmate, clang */
+	*(struct prog_test_ref_kfunc * volatile *)&v->ref_ptr = p;
+	return 0;
+}
+
+SEC("?tc")
+int reject_untrusted_xchg(struct __sk_buff *ctx)
+{
+	struct prog_test_ref_kfunc *p;
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 0;
+
+	p = v->ref_ptr;
+	if (!p)
+		return 0;
+	bpf_kptr_xchg(&v->ref_ptr, p);
+	return 0;
+}
+
+SEC("?tc")
+int reject_bad_type_xchg(struct __sk_buff *ctx)
+{
+	struct prog_test_ref_kfunc *ref_ptr;
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 0;
+
+	ref_ptr = bpf_kfunc_call_test_acquire(&(unsigned long){0});
+	if (!ref_ptr)
+		return 0;
+	bpf_kptr_xchg(&v->ref_memb_ptr, ref_ptr);
+	return 0;
+}
+
+SEC("?tc")
+int reject_member_of_ref_xchg(struct __sk_buff *ctx)
+{
+	struct prog_test_ref_kfunc *ref_ptr;
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 0;
+
+	ref_ptr = bpf_kfunc_call_test_acquire(&(unsigned long){0});
+	if (!ref_ptr)
+		return 0;
+	bpf_kptr_xchg(&v->ref_memb_ptr, &ref_ptr->memb);
+	return 0;
+}
+
+SEC("?syscall")
+int reject_indirect_helper_access(struct __sk_buff *ctx)
+{
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 0;
+
+	bpf_get_current_comm(v, sizeof(v->buf) + 1);
+	return 0;
+}
+
+__noinline
+int write_func(int *p)
+{
+	return p ? *p = 42 : 0;
+}
+
+SEC("?tc")
+int reject_indirect_global_func_access(struct __sk_buff *ctx)
+{
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 0;
+
+	return write_func((void *)v + 5);
+}
+
+SEC("?tc")
+int kptr_xchg_ref_state(struct __sk_buff *ctx)
+{
+	struct prog_test_ref_kfunc *p;
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 0;
+
+	p = bpf_kfunc_call_test_acquire(&(unsigned long){0});
+	if (!p)
+		return 0;
+	bpf_kptr_xchg(&v->ref_ptr, p);
+	return 0;
+}
+
+SEC("?tc")
+int kptr_get_ref_state(struct __sk_buff *ctx)
+{
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 0;
+
+	bpf_kfunc_call_test_kptr_get(&v->ref_ptr, 0, 0);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.35.1

