Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D922F67B734
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 17:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbjAYQr5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 11:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbjAYQry (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 11:47:54 -0500
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D7FA5C1;
        Wed, 25 Jan 2023 08:47:47 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id m199so7997685ybm.4;
        Wed, 25 Jan 2023 08:47:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jin40lfggyQ0e+XmjWmUlagBMngNuJsNbxMgU6ErLIQ=;
        b=AODcPH4v6rSSAPj4G/tniCx2QyMQOoWhqBhcfaJFFQ73WdkXlXmKhXG2TzbR0UE+PB
         ykib7s76KIxzqsrcPQAs39M0DxABFUWliZByNqpAqrisvFfaHSdJesy7ZNsltHI9XiI8
         sfvzxefuCHTnd8RuAQZskHuaSTUrChi8VgqAtTZ1FQdGp9EgCRxZaOzNZpaZxEZ/Juld
         l1iIahc5/OEFEhJuErxa13RNdgfZIls5z8PgbUHhJiq1boiO3DEDL8k7Q3x1EzhO7gA7
         tZU3Ze+QXobfNHLH7wIUf/0jWZc6NU478L4XZS9ktWIOWHwHHvv22WAKZoviAQESAAL0
         fR1g==
X-Gm-Message-State: AFqh2krJO+9n+73rYvVP88dbEruuWTqFJmRzgPRpQxD88GPGCE3jGFJk
        5amIbe+AlBJ8+TfcasTmaRmyHc7Knm5yAMdY
X-Google-Smtp-Source: AMrXdXsEgrsa+d5TQsgyPxAMatmFOaLT/tCf4ouiSBaZa60DP0b5WXRKzEq8HWbJywnUiu3IsH6BSQ==
X-Received: by 2002:a25:a2c2:0:b0:801:6611:ca81 with SMTP id c2-20020a25a2c2000000b008016611ca81mr13130580ybn.16.1674665266478;
        Wed, 25 Jan 2023 08:47:46 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:113e])
        by smtp.gmail.com with ESMTPSA id b5-20020a378005000000b00704a2a40cf2sm3760465qkd.38.2023.01.25.08.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 08:47:46 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next v4 4/4] bpf/selftests: Verify struct_ops prog sleepable behavior
Date:   Wed, 25 Jan 2023 10:47:35 -0600
Message-Id: <20230125164735.785732-5-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125164735.785732-1-void@manifault.com>
References: <20230125164735.785732-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
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
validate this behavior by adding a new sleepable struct_ops entry to
dummy_st_ops.

Signed-off-by: David Vernet <void@manifault.com>
---
 include/linux/bpf.h                           |  1 +
 net/bpf/bpf_dummy_struct_ops.c                | 18 +++++++
 .../selftests/bpf/prog_tests/dummy_st_ops.c   | 52 ++++++++++++++-----
 .../selftests/bpf/progs/dummy_st_ops_fail.c   | 27 ++++++++++
 ...{dummy_st_ops.c => dummy_st_ops_success.c} | 19 +++----
 5 files changed, 93 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/dummy_st_ops_fail.c
 rename tools/testing/selftests/bpf/progs/{dummy_st_ops.c => dummy_st_ops_success.c} (72%)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0d868ef1b973..14a0264fac57 100644
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
index c11832657d2b..f43fcb13d2c4 100644
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
 
@@ -119,7 +120,28 @@ static void test_dummy_multiple_args(void)
 		ASSERT_EQ(skel->bss->test_2_args[i], args[i], name);
 	}
 
-	dummy_st_ops__destroy(skel);
+	dummy_st_ops_success__destroy(skel);
+}
+
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
 }
 
 void test_dummy_st_ops(void)
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

