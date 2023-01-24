Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFAC679E40
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 17:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbjAXQKA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 11:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbjAXQJy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 11:09:54 -0500
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3124ABD0;
        Tue, 24 Jan 2023 08:09:32 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-4fda31c3351so195900877b3.11;
        Tue, 24 Jan 2023 08:09:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqp9aSOT9za2yKZpSIP55Z7jUl/+T4V00ezoEYQ+5+I=;
        b=v6FTruwW8YFQaDOzbMgIpJ/OlMMJT5sbN2DzFW4X8LDIltjrU2TNVtPeVol+BHTQ14
         4GrcMgA70V0HTERiv8VOUYiYGgLfLpS7PYOUVFR+KWe2uF3NUtvtQHx/uVk+DANKYQ9R
         GwGjvMtRdsIWKJmKimAzleocMSUbL2Cdxs4r61zm6wPw06bM0KGt0EZY+D15mM7nVkFk
         XErmcKlZMmDHsFCAEKXw620zzYj5xSV3d+NI0kj0ajiDd++6Qiuwacrmmk9m8u2Al1cj
         0woW7Y+vCTYSrpAyyPWoOiPlI6EcjMM1e8uO0Bo23ig/KdI2XNzdvSUW3SLQcqw0dpn8
         JdKA==
X-Gm-Message-State: AFqh2kpRAOpoRe9exK2QUbk24xSUFqn/pqwyX/9ReL/TNR6doSTk1QjX
        tbxtrd/IwUJHsga6GUV3M6N86BpqQkX2jh3t
X-Google-Smtp-Source: AMrXdXvXHmfwHHa38EHzipxl2U3KGrghCriJMQgWD9F+lPBjWHV3JKc2Dlu4upeG+aRgswVOJWifpw==
X-Received: by 2002:a05:7500:631c:b0:f1:e53f:ed8f with SMTP id ib28-20020a057500631c00b000f1e53fed8fmr2253743gab.6.1674576570877;
        Tue, 24 Jan 2023 08:09:30 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:93a0])
        by smtp.gmail.com with ESMTPSA id 71-20020a370c4a000000b006fc5a1d9cd4sm1660355qkm.34.2023.01.24.08.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 08:09:30 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next v2 4/4] bpf/selftests: Verify struct_ops prog sleepable behavior
Date:   Tue, 24 Jan 2023 10:08:02 -0600
Message-Id: <20230124160802.1122124-5-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230124160802.1122124-1-void@manifault.com>
References: <20230124160802.1122124-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In a set of prior changes, we added the ability for struct_ops programs
to be sleepable. This patch enhances the dummy_st_ops selftest suite to
validate this behavior by adding a new struct_ops entry to dummy_st_ops
which calls a KF_SLEEPABLE kfunc.

Signed-off-by: David Vernet <void@manifault.com>
---
 include/linux/bpf.h                           |  1 +
 net/bpf/bpf_dummy_struct_ops.c                | 18 ++++++
 net/bpf/test_run.c                            |  6 ++
 .../selftests/bpf/prog_tests/dummy_st_ops.c   | 56 ++++++++++++++-----
 .../selftests/bpf/progs/dummy_st_ops_common.h | 20 +++++++
 .../selftests/bpf/progs/dummy_st_ops_fail.c   | 41 ++++++++++++++
 ...{dummy_st_ops.c => dummy_st_ops_success.c} | 18 +++---
 7 files changed, 136 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/dummy_st_ops_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/dummy_st_ops_fail.c
 rename tools/testing/selftests/bpf/progs/{dummy_st_ops.c => dummy_st_ops_success.c} (75%)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 50123afab9bf..64034311c5f7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1474,6 +1474,7 @@ struct bpf_dummy_ops {
 	int (*test_1)(struct bpf_dummy_ops_state *cb);
 	int (*test_2)(struct bpf_dummy_ops_state *cb, int a1, unsigned short a2,
 		      char a3, unsigned long a4);
+	int (*test_3)(struct bpf_dummy_ops_state *cb);
 };
 
 int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index 1ac4467928a9..46099737d1da 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -154,6 +154,23 @@ static bool bpf_dummy_ops_is_valid_access(int off, int size,
 	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
 }
 
+static int bpf_dummy_ops_check_member(const struct btf_type *t,
+				      const struct btf_member *member,
+				      const struct bpf_prog *prog)
+{
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+
+	switch (moff) {
+	case offsetof(struct bpf_dummy_ops, test_3):
+		break;
+	default:
+		if (prog->aux->sleepable)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int bpf_dummy_ops_btf_struct_access(struct bpf_verifier_log *log,
 					   const struct bpf_reg_state *reg,
 					   int off, int size, enum bpf_access_type atype,
@@ -208,6 +225,7 @@ static void bpf_dummy_unreg(void *kdata)
 struct bpf_struct_ops bpf_bpf_dummy_ops = {
 	.verifier_ops = &bpf_dummy_verifier_ops,
 	.init = bpf_dummy_init,
+	.check_member = bpf_dummy_ops_check_member,
 	.init_member = bpf_dummy_init_member,
 	.reg = bpf_dummy_reg,
 	.unreg = bpf_dummy_unreg,
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 8da0d73b368e..33ea57d34c0b 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -730,6 +730,10 @@ noinline void bpf_kfunc_call_test_destructive(void)
 {
 }
 
+noinline void bpf_kfunc_call_test_sleepable(void)
+{
+}
+
 __diag_pop();
 
 BTF_SET8_START(bpf_test_modify_return_ids)
@@ -767,6 +771,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_sleepable, KF_SLEEPABLE)
 BTF_SET8_END(test_sk_check_kfunc_ids)
 
 static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
@@ -1680,6 +1685,7 @@ static int __init bpf_prog_test_run_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_prog_test_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_prog_test_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_prog_test_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_prog_test_kfunc_set);
 	return ret ?: register_btf_id_dtor_kfuncs(bpf_prog_test_dtor_kfunc,
 						  ARRAY_SIZE(bpf_prog_test_dtor_kfunc),
 						  THIS_MODULE);
diff --git a/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c b/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
index c11832657d2b..dbf568e0ade2 100644
--- a/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
+++ b/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2021. Huawei Technologies Co., Ltd */
 #include <test_progs.h>
-#include "dummy_st_ops.skel.h"
+#include "dummy_st_ops_success.skel.h"
+#include "dummy_st_ops_fail.skel.h"
 #include "trace_dummy_st_ops.skel.h"
 
 /* Need to keep consistent with definition in include/linux/bpf.h */
@@ -11,17 +12,17 @@ struct bpf_dummy_ops_state {
 
 static void test_dummy_st_ops_attach(void)
 {
-	struct dummy_st_ops *skel;
+	struct dummy_st_ops_success *skel;
 	struct bpf_link *link;
 
-	skel = dummy_st_ops__open_and_load();
+	skel = dummy_st_ops_success__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "dummy_st_ops_load"))
 		return;
 
 	link = bpf_map__attach_struct_ops(skel->maps.dummy_1);
 	ASSERT_EQ(libbpf_get_error(link), -EOPNOTSUPP, "dummy_st_ops_attach");
 
-	dummy_st_ops__destroy(skel);
+	dummy_st_ops_success__destroy(skel);
 }
 
 static void test_dummy_init_ret_value(void)
@@ -31,10 +32,10 @@ static void test_dummy_init_ret_value(void)
 		.ctx_in = args,
 		.ctx_size_in = sizeof(args),
 	);
-	struct dummy_st_ops *skel;
+	struct dummy_st_ops_success *skel;
 	int fd, err;
 
-	skel = dummy_st_ops__open_and_load();
+	skel = dummy_st_ops_success__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "dummy_st_ops_load"))
 		return;
 
@@ -43,7 +44,7 @@ static void test_dummy_init_ret_value(void)
 	ASSERT_OK(err, "test_run");
 	ASSERT_EQ(attr.retval, 0xf2f3f4f5, "test_ret");
 
-	dummy_st_ops__destroy(skel);
+	dummy_st_ops_success__destroy(skel);
 }
 
 static void test_dummy_init_ptr_arg(void)
@@ -58,17 +59,17 @@ static void test_dummy_init_ptr_arg(void)
 		.ctx_size_in = sizeof(args),
 	);
 	struct trace_dummy_st_ops *trace_skel;
-	struct dummy_st_ops *skel;
+	struct dummy_st_ops_success *skel;
 	int fd, err;
 
-	skel = dummy_st_ops__open_and_load();
+	skel = dummy_st_ops_success__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "dummy_st_ops_load"))
 		return;
 
 	fd = bpf_program__fd(skel->progs.test_1);
 
 	trace_skel = trace_dummy_st_ops__open();
-	if (!ASSERT_OK_PTR(trace_skel, "trace_dummy_st_ops__open"))
+	if (!ASSERT_OK_PTR(trace_skel, "trace_dummy_st_ops_success__open"))
 		goto done;
 
 	err = bpf_program__set_attach_target(trace_skel->progs.fentry_test_1,
@@ -91,7 +92,7 @@ static void test_dummy_init_ptr_arg(void)
 	ASSERT_EQ(trace_skel->bss->val, exp_retval, "fentry_val");
 
 done:
-	dummy_st_ops__destroy(skel);
+	dummy_st_ops_success__destroy(skel);
 	trace_dummy_st_ops__destroy(trace_skel);
 }
 
@@ -102,12 +103,12 @@ static void test_dummy_multiple_args(void)
 		.ctx_in = args,
 		.ctx_size_in = sizeof(args),
 	);
-	struct dummy_st_ops *skel;
+	struct dummy_st_ops_success *skel;
 	int fd, err;
 	size_t i;
 	char name[8];
 
-	skel = dummy_st_ops__open_and_load();
+	skel = dummy_st_ops_success__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "dummy_st_ops_load"))
 		return;
 
@@ -119,10 +120,31 @@ static void test_dummy_multiple_args(void)
 		ASSERT_EQ(skel->bss->test_2_args[i], args[i], name);
 	}
 
-	dummy_st_ops__destroy(skel);
+	dummy_st_ops_success__destroy(skel);
 }
 
-void test_dummy_st_ops(void)
+static void test_dummy_sleepable(void)
+{
+	__u64 args[1] = {0};
+	LIBBPF_OPTS(bpf_test_run_opts, attr,
+		.ctx_in = args,
+		.ctx_size_in = sizeof(args),
+	);
+	struct dummy_st_ops_success *skel;
+	int fd, err;
+
+	skel = dummy_st_ops_success__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "dummy_st_ops_load"))
+		return;
+
+	fd = bpf_program__fd(skel->progs.test_3);
+	err = bpf_prog_test_run_opts(fd, &attr);
+	ASSERT_OK(err, "test_run");
+
+	dummy_st_ops_success__destroy(skel);
+}
+
+void test_dummy_st_ops_success(void)
 {
 	if (test__start_subtest("dummy_st_ops_attach"))
 		test_dummy_st_ops_attach();
@@ -132,4 +154,8 @@ void test_dummy_st_ops(void)
 		test_dummy_init_ptr_arg();
 	if (test__start_subtest("dummy_multiple_args"))
 		test_dummy_multiple_args();
+	if (test__start_subtest("dummy_sleepable"))
+		test_dummy_sleepable();
+
+	RUN_TESTS(dummy_st_ops_fail);
 }
diff --git a/tools/testing/selftests/bpf/progs/dummy_st_ops_common.h b/tools/testing/selftests/bpf/progs/dummy_st_ops_common.h
new file mode 100644
index 000000000000..7d0761594b69
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/dummy_st_ops_common.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#ifndef _DUMMY_ST_OPS_COMMON_H
+#define _DUMMY_ST_OPS_COMMON_H
+
+struct bpf_dummy_ops_state {
+	int val;
+} __attribute__((preserve_access_index));
+
+struct bpf_dummy_ops {
+	int (*test_1)(struct bpf_dummy_ops_state *state);
+	int (*test_2)(struct bpf_dummy_ops_state *state, int a1, unsigned short a2,
+		      char a3, unsigned long a4);
+	int (*test_3)(struct bpf_dummy_ops_state *state);
+};
+
+void bpf_kfunc_call_test_sleepable(void) __ksym;
+
+#endif /* _DUMMY_ST_OPS_COMMON_H */
diff --git a/tools/testing/selftests/bpf/progs/dummy_st_ops_fail.c b/tools/testing/selftests/bpf/progs/dummy_st_ops_fail.c
new file mode 100644
index 000000000000..e3f6c5445e0d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/dummy_st_ops_fail.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+#include "dummy_st_ops_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops.s/test_2")
+__failure __msg("attach to unsupported member test_2 of struct bpf_dummy_ops")
+int BPF_PROG(test_unsupported_field_sleepable,
+	     struct bpf_dummy_ops_state *state, int a1, unsigned short a2,
+	     char a3, unsigned long a4)
+{
+	/* Tries to mark an unsleepable field in struct bpf_dummy_ops as sleepable. */
+	return 0;
+}
+
+SEC("struct_ops/test_3")
+__failure __msg("program must be sleepable to call sleepable kfunc bpf_kfunc_call_test_sleepable")
+int BPF_PROG(test_supported_field_not_in_sleepable_section, struct bpf_dummy_ops_state *state)
+{
+	/*
+	 * Calls a sleepable kfunc, but doesn't mark self as sleepable, even
+	 * though test_3 is allowed to be a sleepable field in struct
+	 * bpf_ops_dummy.
+	 */
+	bpf_kfunc_call_test_sleepable();
+	return 0;
+}
+
+SEC(".struct_ops")
+struct bpf_dummy_ops dummy_1 = {
+	.test_1 = NULL,
+	.test_2 = (void *)test_unsupported_field_sleepable,
+	.test_3 = (void *)test_supported_field_not_in_sleepable_section,
+};
diff --git a/tools/testing/selftests/bpf/progs/dummy_st_ops.c b/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c
similarity index 75%
rename from tools/testing/selftests/bpf/progs/dummy_st_ops.c
rename to tools/testing/selftests/bpf/progs/dummy_st_ops_success.c
index ead87edb75e2..1e9fab99ac0d 100644
--- a/tools/testing/selftests/bpf/progs/dummy_st_ops.c
+++ b/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c
@@ -4,15 +4,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
-struct bpf_dummy_ops_state {
-	int val;
-} __attribute__((preserve_access_index));
-
-struct bpf_dummy_ops {
-	int (*test_1)(struct bpf_dummy_ops_state *state);
-	int (*test_2)(struct bpf_dummy_ops_state *state, int a1, unsigned short a2,
-		      char a3, unsigned long a4);
-};
+#include "dummy_st_ops_common.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -43,8 +35,16 @@ int BPF_PROG(test_2, struct bpf_dummy_ops_state *state, int a1, unsigned short a
 	return 0;
 }
 
+SEC("struct_ops.s/test_3")
+int BPF_PROG(test_3, struct bpf_dummy_ops_state *state)
+{
+	bpf_kfunc_call_test_sleepable();
+	return 0;
+}
+
 SEC(".struct_ops")
 struct bpf_dummy_ops dummy_1 = {
 	.test_1 = (void *)test_1,
 	.test_2 = (void *)test_2,
+	.test_3 = (void *)test_3,
 };
-- 
2.39.0

