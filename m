Return-Path: <bpf+bounces-9869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4716979DFD9
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 08:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00FF6281A25
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 06:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6136C1799B;
	Wed, 13 Sep 2023 06:15:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B16A45
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 06:15:18 +0000 (UTC)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985D8172E
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:15:17 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-58fba83feb0so62618257b3.3
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694585716; x=1695190516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PVz59K5l8Xp4iimWiGaL0A+Vn+eobZxCGm5oc1YD5A=;
        b=TZNJD+mLvqCpelWfdPAmJC7jwbpk/mfTQn8SMHuTIWEpNABfPgXL4jjsL+rNeX2KVz
         4XVsoj641Q9e84+VJVP+rF7/PjB5SYQXVX3ZV8wtuA61vGATX7wRMb6wWq7Dr3owbFol
         2YOy5CGmwlimgtnCoGc6hfM3aynUNFPl4ry9tZpE4f1XFNs3JP6QcGQ4ksFAbVQB/4XH
         i1xjN0N6/wUG9Im90vtpyY/grdUJn4zYTvBIPzfc/nRD8Ge778o1TAJdwkmzRyn155xA
         7AAPSwBpXGKR2uTOW6WoobuN4D1vaeaiVytwbMQQ7WKmA37DPKd9yA2fviViPdkEMvpb
         kxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694585716; x=1695190516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PVz59K5l8Xp4iimWiGaL0A+Vn+eobZxCGm5oc1YD5A=;
        b=ngO84l+vZIOX28LeAhjZq1cKW7yCpxCQ9rCfJd+ky/3NY5GvFMHKlG6xp5R+qDiUG9
         2VFRprBCeqL8UjrhOAEyAtxFW41N1tvlo5RDciRONjLC1s2h7qXDC3Zz6c+5lMPJKWuE
         cSqpkiaK1iJDcFK7MuW6nZMWkHEmRU8z3i54H4OwRWRP+8DGful4kW3kbCNTJm97Pamm
         32VzHQPcNi3Y3Ztwk5Aq5G/NvNgWUV2cEyrElLgnc7HolIMdR7vthE+Xjnebr8k1TSGe
         POi3f/q7niTTzvtG20rtodsZLBcGNdRnJ1pjfJrCD2wFaGwOeMfpsGIcGVA1c16hBrPg
         tD/A==
X-Gm-Message-State: AOJu0YyDka3iOIUH56jSFud578EcCkgPMnn8sSnyaEu1N4DWiaHidlmi
	EjN/eT9TJnWlNa5gHyPXT6ZYFeWIDsw=
X-Google-Smtp-Source: AGHT+IECrY0cnyvjn/w/bhwUMAIcgZG5w46kRKvEzr9vpHPGJg7IGMGusXt61aZnA59qyHSzc8AHzg==
X-Received: by 2002:a81:918d:0:b0:589:f5c1:aaf3 with SMTP id i135-20020a81918d000000b00589f5c1aaf3mr1565165ywg.17.1694585716576;
        Tue, 12 Sep 2023 23:15:16 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:34c0:240e:9597:d8ed])
        by smtp.gmail.com with ESMTPSA id b132-20020a0dd98a000000b0057a5302e2fesm2961454ywe.5.2023.09.12.23.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 23:15:16 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v2 8/9] selftests/bpf: test case for register_bpf_struct_ops().
Date: Tue, 12 Sep 2023 23:14:48 -0700
Message-Id: <20230913061449.1918219-9-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913061449.1918219-1-thinker.li@gmail.com>
References: <20230913061449.1918219-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 84 +++++++++++++++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  5 ++
 .../bpf/prog_tests/test_struct_ops_module.c   | 40 +++++++++
 .../selftests/bpf/progs/struct_ops_module.c   | 30 +++++++
 4 files changed, 159 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_module.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index cefc5dd72573..136638c15047 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
+#include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
 #include <linux/error-injection.h>
@@ -517,11 +518,88 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
 BTF_SET8_END(bpf_testmod_check_kfunc_ids)
 
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+
+enum bpf_struct_ops_state {
+	BPF_STRUCT_OPS_STATE_INIT,
+	BPF_STRUCT_OPS_STATE_INUSE,
+	BPF_STRUCT_OPS_STATE_TOBEFREE,
+	BPF_STRUCT_OPS_STATE_READY,
+};
+
+#define BPF_STRUCT_OPS_COMMON_VALUE			\
+	refcount_t refcnt;				\
+	enum bpf_struct_ops_state state
+
+#define BPF_STRUCT_OPS_TYPE(_name)				\
+struct bpf_struct_ops_##_name {						\
+	BPF_STRUCT_OPS_COMMON_VALUE;				\
+	struct _name data ____cacheline_aligned_in_smp;		\
+}
+
+BPF_STRUCT_OPS_TYPE(bpf_testmod_ops);
+
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
+	((struct bpf_struct_ops_bpf_testmod_ops *)0);
+	r = ops->test_2(4, 3);
+	printk(KERN_CRIT "bpf_dummy_reg: test_2 %d\n", r);
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
+};
+
+static struct bpf_struct_ops_mod bpf_testmod_struct_ops = {
+	.owner = THIS_MODULE,
+	.st_ops = &bpf_bpf_testmod_ops,
+};
+
+#endif /* CONFIG_DEBUG_INFO_BTF_MODULES */
+
 extern int bpf_fentry_test1(int a);
 
 static int bpf_testmod_init(void)
@@ -532,6 +610,9 @@ static int bpf_testmod_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_testmod_kfunc_set);
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_struct_ops);
+#endif
 	if (ret < 0)
 		return ret;
 	if (bpf_fentry_test1(0) < 0)
@@ -541,6 +622,9 @@ static int bpf_testmod_init(void)
 
 static void bpf_testmod_exit(void)
 {
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+	unregister_bpf_struct_ops(&bpf_testmod_struct_ops);
+#endif
 	return sysfs_remove_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
 }
 
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
index 000000000000..29dd203121f5
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+
+#include "struct_ops_module.skel.h"
+#include "testing_helpers.h"
+
+static void test_regular_load()
+{
+	struct struct_ops_module *skel;
+	struct bpf_link *link;
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
+	int err;
+
+	opts.btf_custom_path = "/sys/kernel/btf/bpf_testmod",
+
+	printf("test_regular_load\n");
+	skel = struct_ops_module__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
+		return;
+	err = struct_ops_module__load(skel);
+	if (!ASSERT_OK(err, "struct_ops_module_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
+	ASSERT_OK_PTR(link, "attach_test_mod_1");
+
+	ASSERT_EQ(skel->bss->test_2_result, 7, "test_2_result");
+
+	bpf_link__destroy(link);
+
+	struct_ops_module__destroy(skel);
+}
+
+void serial_test_struct_ops_module(void)
+{
+	if (test__start_subtest("regular_load"))
+		test_regular_load();
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
-- 
2.34.1


