Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6CA67A9DA
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 06:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbjAYFEZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 00:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbjAYFES (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 00:04:18 -0500
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08E14FC2E;
        Tue, 24 Jan 2023 21:04:15 -0800 (PST)
Received: by mail-pj1-f47.google.com with SMTP id h5-20020a17090a9c0500b0022bb85eb35dso869299pjp.3;
        Tue, 24 Jan 2023 21:04:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rova6ngLsYq2rnb5PiS/P21X822PIKJ9gJ36rqMX2HQ=;
        b=4+CfiGFiIcjz3v+JUl/Tgfc4VTiOWoB6taOYmw6h+6fidDQOwqorNjR5sy5Seok4EO
         Pw4c70aa6ENBnNk5s498rKrU+fkTUdsR3mhJD4UxFObm+RR56sNp6JNxNvRn36uacOtZ
         kEHgN8/cwKxnlRtkrik2LiXik7dbwvKJByTAno/Ij3+Lz6rDiY4e+qF0gz/DTv3OiZSg
         C/ImDicciAMlZUrCGckWCD1DKnH8qdaQ3sAwHnQwcwJOT1ZKvzZuQnbncqmX2fxLF4mH
         C5Rp6lXW8aGeYuPdTmgzNJZx4zJ10HTOxx0EtvGtig/wrmoh51o+uW4H+8ccpMKuYB0h
         Djyg==
X-Gm-Message-State: AFqh2kpd8IPBestdRtYP0IaRBOQFLKgaCAeCCti61rUIcHHRNIVQSHdi
        d8kf/OxxgNPRlbXxoeR674eltjfW62SQFNOb
X-Google-Smtp-Source: AMrXdXsJmyHH/HlSW7m0L3d1wRaK/jz9TJ1U1mJazBNViHOnvF4SwFjHLJL6ZR40mqi9GJiIyfdzIA==
X-Received: by 2002:a17:90a:1a5c:b0:22b:b76b:5043 with SMTP id 28-20020a17090a1a5c00b0022bb76b5043mr17760297pjl.9.1674623054737;
        Tue, 24 Jan 2023 21:04:14 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:d24a])
        by smtp.gmail.com with ESMTPSA id o9-20020a17090a744900b00229f74a4323sm464229pjk.34.2023.01.24.21.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 21:04:14 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next v3 4/4] bpf/selftests: Verify struct_ops prog sleepable behavior
Date:   Tue, 24 Jan 2023 23:03:59 -0600
Message-Id: <20230125050359.339273-5-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125050359.339273-1-void@manifault.com>
References: <20230125050359.339273-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In a set of prior changes, we added the ability for struct_ops programs
to be sleepable. This patch enhances the dummy_st_ops selftest suite to
validate this behavior by adding a new sleepable struct_ops entry to
dummy_st_ops.

Signed-off-by: David Vernet <void@manifault.com>
---
 include/linux/bpf.h                           |  1 +
 net/bpf/bpf_dummy_struct_ops.c                | 18 +++++++
 .../selftests/bpf/prog_tests/dummy_st_ops.c   | 54 ++++++++++++++-----
 .../selftests/bpf/progs/dummy_st_ops_fail.c   | 27 ++++++++++
 ...{dummy_st_ops.c => dummy_st_ops_success.c} | 19 +++----
 5 files changed, 94 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/dummy_st_ops_fail.c
 rename tools/testing/selftests/bpf/progs/{dummy_st_ops.c => dummy_st_ops_success.c} (72%)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 50123afab9bf..d92a6e0fde97 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1474,6 +1474,7 @@ struct bpf_dummy_ops {
 	int (*test_1)(struct bpf_dummy_ops_state *cb);
 	int (*test_2)(struct bpf_dummy_ops_state *cb, int a1, unsigned short a2,
 		      char a3, unsigned long a4);
+	int (*test_sleepable)(struct bpf_dummy_ops_state *cb);
 };
 
 int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index 1ac4467928a9..ff4f89a2b02a 100644
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
+	case offsetof(struct bpf_dummy_ops, test_sleepable):
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
diff --git a/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c b/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
index c11832657d2b..135514fad83a 100644
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
@@ -58,10 +59,10 @@ static void test_dummy_init_ptr_arg(void)
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
+	fd = bpf_program__fd(skel->progs.test_sleepable);
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
diff --git a/tools/testing/selftests/bpf/progs/dummy_st_ops_fail.c b/tools/testing/selftests/bpf/progs/dummy_st_ops_fail.c
new file mode 100644
index 000000000000..0bf969a0b5ed
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/dummy_st_ops_fail.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
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
+SEC(".struct_ops")
+struct bpf_dummy_ops dummy_1 = {
+	.test_1 = NULL,
+	.test_2 = (void *)test_unsupported_field_sleepable,
+	.test_sleepable = (void *)NULL,
+};
diff --git a/tools/testing/selftests/bpf/progs/dummy_st_ops.c b/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c
similarity index 72%
rename from tools/testing/selftests/bpf/progs/dummy_st_ops.c
rename to tools/testing/selftests/bpf/progs/dummy_st_ops_success.c
index ead87edb75e2..1efa746c25dc 100644
--- a/tools/testing/selftests/bpf/progs/dummy_st_ops.c
+++ b/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c
@@ -1,19 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2021. Huawei Technologies Co., Ltd */
-#include <linux/bpf.h>
+#include "vmlinux.h"
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
-
 char _license[] SEC("license") = "GPL";
 
 SEC("struct_ops/test_1")
@@ -43,8 +33,15 @@ int BPF_PROG(test_2, struct bpf_dummy_ops_state *state, int a1, unsigned short a
 	return 0;
 }
 
+SEC("struct_ops.s/test_sleepable")
+int BPF_PROG(test_sleepable, struct bpf_dummy_ops_state *state)
+{
+	return 0;
+}
+
 SEC(".struct_ops")
 struct bpf_dummy_ops dummy_1 = {
 	.test_1 = (void *)test_1,
 	.test_2 = (void *)test_2,
+	.test_sleepable = (void *)test_sleepable,
 };
-- 
2.39.0

