Return-Path: <bpf+bounces-14184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AC57E0C2B
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 00:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659971C210F8
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540DE262A7;
	Fri,  3 Nov 2023 23:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkqWT7hM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5741F601
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 23:22:36 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0147DD48
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 16:22:34 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-586a516755aso1759904eaf.0
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 16:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699053754; x=1699658554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPBiRRuyx3z2R42MjqqIVGC0j+M+DHXDWZcdo57iNnE=;
        b=PkqWT7hMFFhYGxHq7137fJHPymicw5rpATDroxUOCh4NdT5A/7beskEgfhv1UkqIWP
         l8M1Y3kD1mBShG3VXaWmF42Fqt3ubYRlUHtp6a8ktraBz/dzwQFmiLO3HIB3PRVMS48q
         chiCzJ1LxILhnPVTYIgBdeKYG+LBsLDqn6m59RWrFECpjjGwfrrGRKlPdqPNljoPfJIf
         2MsTIL5P3a/PMArDQSNQHgLUmQF1PLMESLux/xyisU0Ot8dCg/bYiTzRERkuRAZ2Rv1v
         wMiMGaZ5sD6nyr4FLAs7eCuXEVXOE4GmCXfArh7Y+ETNqT9Oju7GyGBefKtyj3hgxgXM
         9JqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699053754; x=1699658554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPBiRRuyx3z2R42MjqqIVGC0j+M+DHXDWZcdo57iNnE=;
        b=BOyWxwRyOL4bXN/XrYBnwpzoZIJUHyZsK5LMqijV78rNnGX3fwZ6p2xtmumwHrc9ai
         iBjWCLLTirSxqVfQFLOFoF9ScKkpUhfgEMaprb/otITNUswBTg4vHpiw/zLRy0AnBMQy
         sdZ6ivYuJ0HETxdCz5sw1owFQhuwXf4NLyOzFUrhe+E13NCv2dIxuj7/W6wyEVVYnmtZ
         ifkxhnruq/7k6cAspodc6Xj6gcqODmMgCcSe84y3Tn28hnfjTdnUHzwnbFRPRku9TBA6
         S+aqblpEmCr+m2HbgGsW/4JNRrjqzzsA+yTge0YeWbxOne64qxjkNJjyoLRBPLuEltzK
         YHyQ==
X-Gm-Message-State: AOJu0Yw/IBx94hSnNOD5zhse7AE/RQ97/hOYZuzFALJdhucq+yh9nESE
	7KPWYIZu0fhxhojGkQy8MuuCUR7dkU0=
X-Google-Smtp-Source: AGHT+IGpq92mdL7pZ8CfmJfZtTRrV1lqK50b9qJw8aoQfHSO9DzZ0Z4N0VwY/dLTknISBdGjUtWTGg==
X-Received: by 2002:a05:6808:f15:b0:3b2:e085:2483 with SMTP id m21-20020a0568080f1500b003b2e0852483mr1840772oiw.2.1699053753840;
        Fri, 03 Nov 2023 16:22:33 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:287:9d8c:4ad:9459])
        by smtp.gmail.com with ESMTPSA id 186-20020a4a14c3000000b0057b8baf00bbsm532288ood.22.2023.11.03.16.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 16:22:33 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	drosen@google.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v10 13/13] selftests/bpf: test case for register_bpf_struct_ops().
Date: Fri,  3 Nov 2023 16:22:02 -0700
Message-Id: <20231103232202.3664407-14-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103232202.3664407-1-thinker.li@gmail.com>
References: <20231103232202.3664407-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Create a new struct_ops type called bpf_testmod_ops within the bpf_testmod
module. When a struct_ops object is registered, the bpf_testmod module will
invoke test_2 from the module.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  59 +++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   5 +
 .../bpf/prog_tests/test_struct_ops_module.c   | 144 ++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_module.c   |  30 ++++
 .../testing/selftests/bpf/progs/testmod_btf.c |  26 ++++
 5 files changed, 264 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/testmod_btf.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index a5e246f7b202..418e10311c33 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
+#include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
 #include <linux/error-injection.h>
@@ -522,11 +523,66 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
 BTF_SET8_END(bpf_testmod_check_kfunc_ids)
 
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+
+DEFINE_STRUCT_OPS_VALUE_TYPE(bpf_testmod_ops);
+
+static int bpf_testmod_ops_init(struct btf *btf)
+{
+	return 0;
+}
+
+static bool bpf_testmod_ops_is_valid_access(int off, int size,
+					    enum bpf_access_type type,
+					    const struct bpf_prog *prog,
+					    struct bpf_insn_access_aux *info)
+{
+	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
+}
+
+static int bpf_testmod_ops_init_member(const struct btf_type *t,
+				       const struct btf_member *member,
+				       void *kdata, const void *udata)
+{
+	return 0;
+}
+
 static const struct btf_kfunc_id_set bpf_testmod_kfunc_set = {
 	.owner = THIS_MODULE,
 	.set   = &bpf_testmod_check_kfunc_ids,
 };
 
+static const struct bpf_verifier_ops bpf_testmod_verifier_ops = {
+	.is_valid_access = bpf_testmod_ops_is_valid_access,
+};
+
+static int bpf_dummy_reg(void *kdata)
+{
+	struct bpf_testmod_ops *ops = kdata;
+	int r;
+
+	BTF_STRUCT_OPS_TYPE_EMIT(bpf_testmod_ops);
+	r = ops->test_2(4, 3);
+
+	return 0;
+}
+
+static void bpf_dummy_unreg(void *kdata)
+{
+}
+
+struct bpf_struct_ops bpf_bpf_testmod_ops = {
+	.verifier_ops = &bpf_testmod_verifier_ops,
+	.init = bpf_testmod_ops_init,
+	.init_member = bpf_testmod_ops_init_member,
+	.reg = bpf_dummy_reg,
+	.unreg = bpf_dummy_unreg,
+	.name = "bpf_testmod_ops",
+	.owner = THIS_MODULE,
+};
+
+#endif /* CONFIG_DEBUG_INFO_BTF_MODULES */
+
 extern int bpf_fentry_test1(int a);
 
 static int bpf_testmod_init(void)
@@ -537,6 +593,9 @@ static int bpf_testmod_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_testmod_kfunc_set);
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+	ret = ret ?: register_bpf_struct_ops(&bpf_bpf_testmod_ops);
+#endif
 	if (ret < 0)
 		return ret;
 	if (bpf_fentry_test1(0) < 0)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index f32793efe095..ca5435751c79 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -28,4 +28,9 @@ struct bpf_iter_testmod_seq {
 	int cnt;
 };
 
+struct bpf_testmod_ops {
+	int (*test_1)(void);
+	int (*test_2)(int a, int b);
+};
+
 #endif /* _BPF_TESTMOD_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
new file mode 100644
index 000000000000..49f4a4460642
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <time.h>
+
+#include "rcu_tasks_trace_gp.skel.h"
+#include "struct_ops_module.skel.h"
+#include "testmod_btf.skel.h"
+
+static void test_regular_load(void)
+{
+	struct struct_ops_module *skel;
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
+	struct bpf_link *link;
+	int err;
+
+	skel = struct_ops_module__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
+		return;
+	err = struct_ops_module__load(skel);
+	if (!ASSERT_OK(err, "struct_ops_module_load"))
+		goto cleanup;
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
+	ASSERT_OK_PTR(link, "attach_test_mod_1");
+
+	/* test_2() will be called from bpf_dummy_reg() in bpf_testmod.c */
+	ASSERT_EQ(skel->bss->test_2_result, 7, "test_2_result");
+
+	bpf_link__destroy(link);
+
+cleanup:
+	struct_ops_module__destroy(skel);
+}
+
+static void test_load_without_module(void)
+{
+	struct struct_ops_module *skel = NULL;
+	struct testmod_btf *skel_btf;
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
+	struct bpf_link *link_btf = NULL;;
+	int err, i;
+
+	skel_btf = testmod_btf__open_and_load();
+	if (!ASSERT_OK_PTR(skel_btf, "testmod_btf_open"))
+		return;
+
+	link_btf = bpf_program__attach(skel_btf->progs.kprobe_btf_put);
+	if (!ASSERT_OK_PTR(link_btf, "kprobe_btf_put_attach"))
+		goto cleanup;
+
+	err = unload_bpf_testmod(false);
+	if (!ASSERT_OK(err, "unload_bpf_testmod"))
+		goto cleanup;
+
+	skel = struct_ops_module__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
+		goto cleanup;
+	err = struct_ops_module__load(skel);
+	ASSERT_ERR(err, "struct_ops_module_load");
+
+	/* Wait for the struct_ops map to be freed. Struct_ops maps hold a
+	 * refcount to the module btf. And, this function unloads and then
+	 * loads bpf_testmod. Without waiting the map to be freed, the next
+	 * test may fail since libbpf may use the old btf that is still
+	 * alive instead of the new one that is created for the newly
+	 * loaded module.
+	 */
+	for (i = 0; i < 10; i++) {
+		if (skel_btf->bss->bpf_testmod_put)
+			break;
+		usleep(100000);
+	}
+	ASSERT_EQ(skel_btf->bss->bpf_testmod_put, 1, "btf_put");
+
+cleanup:
+	bpf_link__destroy(link_btf);
+	struct_ops_module__destroy(skel);
+	testmod_btf__destroy(skel_btf);
+	/* Without this, the next test may fail */
+	load_bpf_testmod(false);
+}
+
+static void test_attach_without_module(void)
+{
+	struct struct_ops_module *skel = NULL;
+	struct testmod_btf *skel_btf;
+	struct bpf_link *link, *link_btf = NULL;
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
+	int err, i;
+
+	skel_btf = testmod_btf__open_and_load();
+	if (!ASSERT_OK_PTR(skel_btf, "testmod_btf_open"))
+		return;
+
+	link_btf = bpf_program__attach(skel_btf->progs.kprobe_btf_put);
+	if (!ASSERT_OK_PTR(link_btf, "kprobe_btf_put_attach"))
+		goto cleanup;
+
+	skel = struct_ops_module__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
+		goto cleanup;
+	err = struct_ops_module__load(skel);
+	if (!ASSERT_OK(err, "struct_ops_module_load"))
+		goto cleanup;
+
+	err = unload_bpf_testmod(false);
+	if (!ASSERT_OK(err, "unload_bpf_testmod"))
+		goto cleanup;
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
+	ASSERT_ERR_PTR(link, "attach_test_mod_1");
+
+	struct_ops_module__destroy(skel);
+	skel = NULL;
+
+	/* Wait for the struct_ops map to be freed */
+	for (i = 0; i < 10; i++) {
+		if (skel_btf->bss->bpf_testmod_put)
+			break;
+		usleep(100000);
+	}
+	ASSERT_EQ(skel_btf->bss->bpf_testmod_put, 1, "btf_put");
+
+cleanup:
+	bpf_link__destroy(link_btf);
+	struct_ops_module__destroy(skel);
+	testmod_btf__destroy(skel_btf);
+	/* Without this, the next test may fail */
+	load_bpf_testmod(false);
+}
+
+void serial_test_struct_ops_module(void)
+{
+	if (test__start_subtest("regular_load"))
+		test_regular_load();
+
+	if (test__start_subtest("load_without_module"))
+		test_load_without_module();
+
+	if (test__start_subtest("attach_without_module"))
+		test_attach_without_module();
+}
+
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
new file mode 100644
index 000000000000..cb305d04342f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+int test_2_result = 0;
+
+SEC("struct_ops/test_1")
+int BPF_PROG(test_1)
+{
+	return 0xdeadbeef;
+}
+
+SEC("struct_ops/test_2")
+int BPF_PROG(test_2, int a, int b)
+{
+	test_2_result = a + b;
+	return a + b;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_1 = {
+	.test_1 = (void *)test_1,
+	.test_2 = (void *)test_2,
+};
+
diff --git a/tools/testing/selftests/bpf/progs/testmod_btf.c b/tools/testing/selftests/bpf/progs/testmod_btf.c
new file mode 100644
index 000000000000..cfcd269f07fe
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/testmod_btf.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+int bpf_testmod_put = 0;
+
+SEC("kprobe/btf_put")
+int BPF_KPROBE(kprobe_btf_put, struct btf *btf)
+{
+	const char name[] = "bpf_testmod";
+	int i;
+
+	for (i = 0; i < sizeof(name); i++) {
+		if (BPF_CORE_READ(btf, name[i]) != name[i])
+			return 0;
+	}
+
+	if (BPF_CORE_READ(btf, refcnt.refs.counter) == 1)
+		bpf_testmod_put = 1;
+
+	return 0;
+}
-- 
2.34.1


