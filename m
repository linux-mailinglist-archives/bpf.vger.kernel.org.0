Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F309522634
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 23:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbiEJVRQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 17:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbiEJVRL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 17:17:11 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181A250B36
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 14:17:10 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id i24so230200pfa.7
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 14:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wdNYtEXqXnxe/bOH0cqt6IjHmEIdndQN3AFnleszWM4=;
        b=AR1M9REaQiXXyH81ZnwBpQZYnrLDiV6goG8S1wMSeQ+b9gVkc9j7sM83PvlWZERP8I
         XEEnCUxaF1qC+ELmNvlc995qL+o92p4wvv/0lZRzqn0npmJGyd7p86REG0wxsm/M7gz2
         2LU+ypud1dOdQa3Vzo2R29LmYoN+uDcuKooE5HcE6JbILSgn6OBzok+zrQINMcxYxX6f
         yphzbvD6kh2GtTbf6eY6wlCXCNoeXGyXg0dpLmANNZIXpy6xZU5sLPSchx4a+oE851uM
         7KdZcwXgFPqk//gt8qFzQXyRkwDbG5aR7FGgKobfaLui/M5DY4uhBOtCMeMJ6VyqetcI
         u8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wdNYtEXqXnxe/bOH0cqt6IjHmEIdndQN3AFnleszWM4=;
        b=NwpUtMXeJgZZQQbQBNJomwVJs1oMAsaLgW85gw7WOB2uZlZyMOBZENKoBDVvnOA5ja
         wVewEvD4xJWoHnEAbq5GdwuJgzzwnbrS45dTkbEZZc0xQ/vcdi8Y7ZXA3iR9+QqkBPLH
         EqpNDficfiqEDIL/fYywWLhbNHP+4oav/nEz1GOTpwN+2hXJF4YZr6Rp7w3NSMtzAEtc
         rMkX79yfh7iXhc++sKw/ekgIoAxqUjpGA0eljD+8T18x+tNJtkZbI81EKM1fUy+pHyCM
         RraUQ/rG86PLFaVbBRA2Xxp1YCBmsZps8WNVv/lO9qgKU+scMrZfsAM+JtQRywMz7BtW
         JeYg==
X-Gm-Message-State: AOAM530NrvqvgSgvuLHKK9c3IuR2t7ELrPauY5F2ZDG2axa+TTYpytiT
        U4ix6BMCipLOcpybhv0T8TazqkqNLTg=
X-Google-Smtp-Source: ABdhPJy/eF8E9WjhT9s4xjLJOP4cPkHnAN6RoqhHKNz57qNURdaKuz4/wwQR2FYo/2B5MlmfCa4HOg==
X-Received: by 2002:a05:6a00:b94:b0:50f:2255:ae03 with SMTP id g20-20020a056a000b9400b0050f2255ae03mr22435088pfj.74.1652217429282;
        Tue, 10 May 2022 14:17:09 -0700 (PDT)
Received: from localhost ([112.79.164.242])
        by smtp.gmail.com with ESMTPSA id w11-20020a627b0b000000b0050dc76281c7sm1701pfc.161.2022.05.10.14.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 14:17:08 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v1 3/4] selftests/bpf: Add negative C tests for kptrs
Date:   Wed, 11 May 2022 02:47:26 +0530
Message-Id: <20220510211727.575686-4-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220510211727.575686-1-memxor@gmail.com>
References: <20220510211727.575686-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13305; h=from:subject; bh=RgYQauBkTcoWSet6Nm5n73hArWfqreZruZIqXu4SDeM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBietZj4jDMXGxaoXaXBS9FZblSlijfTOK6gyV5kaEC cTMOwOmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYnrWYwAKCRBM4MiGSL8RyrgnD/ 4lkr9ISJhfO7gI111EZaa8Ta76Xx1yS5f5HNcdY8/Ro0J8ZINMXuo0eLPqznhiQ3ri18nK5Lc9iyCO heIxEK9rPqlAbx9F7wZ3CBQqP0nJH2maVabJAt9Q+qJ3J3PmwQXjXeOua1a4dT4kaMupYBmkGXCKG+ KsCaoXKv8ocORxV+1bsch3HBhbsO0BC3lqCt/shIa0eXNmnozxbYjIc+YBa3LdJ5wI5nm+wUBFBhDi 3s7Xj/ma54TEXROrdmFovtbkn2oh7MoClTuCDLHhAFkJIzeDK7JYAXJiKU7JHZdzg7cmxbx65YcmdY 79yb2hdvj/LedHHrpDQuMO7s7yrX9rKLmvI+K3X0figsZr5qsibGie8z/vSIDlIarwhySHHiqA/wBp mgKRPdkeN610Us3dMBrzFgzzAjNUNQEFWNVC38DkFlxUdkG+kRxUcYZ7VDyZrYrYMMv/L9aarQEnAS ejS4kHIj+BrBkeKhCyJcuIJ/6D5W8OMK/Oj+iZiv/riByyoibb62PaB06YFA7CgG5CeurCcikCaiA3 x4ipIFspGIAKrr6FWT308FWdgZ5ZmyurdM//Y6ra7qJNqJdVmChPcRVT1Srbf/DRXbezEyysrXbttZ 2YcixW92W7Lnbh3Vsk5byBfL2nqh6dJrXg1i7fphmYmqRk0FLTtVX/+/xoUw==
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
 .../selftests/bpf/progs/map_kptr_fail.c       | 419 ++++++++++++++++++
 2 files changed, 505 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/map_kptr_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
index 9e2fbda64a65..ffef3a319bac 100644
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
+	{ "kptr_xchg_ref_state", "Unreleased reference id=5 alloc_insn=18" },
+	{ "kptr_get_ref_state", "Unreleased reference id=3 alloc_insn=12" },
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
index 000000000000..c4ef48224362
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
@@ -0,0 +1,419 @@
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
+
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

