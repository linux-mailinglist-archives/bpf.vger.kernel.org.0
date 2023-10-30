Return-Path: <bpf+bounces-13631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1177DC080
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 20:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 788B5B20F75
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 19:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECC11A73F;
	Mon, 30 Oct 2023 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tl9l9jfN"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879F61A73A
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 19:28:31 +0000 (UTC)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D48D9
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 12:28:29 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a7af52ee31so45497187b3.2
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 12:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698694109; x=1699298909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7X6eDWH84YiiA/yviMS1DD8P2E6WYBibPMTFCKAaRw=;
        b=Tl9l9jfN8BhIby33zkfX4KBOUZVvtxB//nomqUgwIhrsxPdFPN/Me2X9ivgBbSisdO
         AgNtIdn7JsexMqpbOEmRkcc0CJVFSjIta1EZhL9aCZGfC7eL2Lv4JrJitNyxQeOL6GlD
         HdoNhTcEi6vfMUxn1Q8BVcQ5PbPy09/xU345MwYOyhj3p+Xr9S1CH27+WWK++Uz3CGtw
         7hO6HmkS8AWhsm2XedWk6nbp9f8IBKfA3fsbLUPxLhb23YixLP5XhyvLCZ6H58dasJ2a
         5CpcS4bJNs70ax+oYIsctVUrkQWbs1MSB3bAQI0O5lUse+2Ha+eL6rKuiEW9zhTK6ZQT
         u4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698694109; x=1699298909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7X6eDWH84YiiA/yviMS1DD8P2E6WYBibPMTFCKAaRw=;
        b=VlbROnTvSPJ4DMFyTXYc8cqsqAuea2jTm7kSteBMxfjEIeIrApy39lbl3Vnaq3iQyL
         uEDcmgI392v9Zi8BzqWChRwWQnYfLDgDHDiKYYNIzpYL9Rxe93CXfjaHCNodr5C7IwLo
         01ruin+mWMn7Ky3pWt/OtTx+ozIK64CP5rFsI0EVmR0eJoh56fd9Fvr70Xv/+NqDz+tj
         mPaBGLoe+7PnttVv/He+Vy4Jhxb6FeRTZQKSX1+cV8J/sq7fu22II7irv86iHimriUvY
         zBNakGVjreiA9jXfpR83sMGU0wUBh8US17uX0Kskm9Fpf3lAtxqmxEOYTPEL04s4EBD4
         7C2A==
X-Gm-Message-State: AOJu0Yw3hE9w0SjoaZ7rFi/P5xdv12ttGtqdNpGqzagCnlNGdjNDw9LS
	wkgNnO2lGPSKRmYTaGwZKo9WwuOL/aM=
X-Google-Smtp-Source: AGHT+IGYQfM+Iguxnj8rvmPmizBRVkg3JQhXApPHimuhj7YXVB/fMQIzY+rgc+zTCpSjb0169bIo+w==
X-Received: by 2002:a81:4405:0:b0:5a7:cfdc:d7b1 with SMTP id r5-20020a814405000000b005a7cfdcd7b1mr10616875ywa.4.1698694108650;
        Mon, 30 Oct 2023 12:28:28 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:5b04:e8d1:ce5:8164])
        by smtp.gmail.com with ESMTPSA id n12-20020a819c4c000000b005b03d703564sm35821ywa.137.2023.10.30.12.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:28:28 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 10/10] selftests/bpf: test case for register_bpf_struct_ops().
Date: Mon, 30 Oct 2023 12:28:10 -0700
Message-Id: <20231030192810.382942-11-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030192810.382942-1-thinker.li@gmail.com>
References: <20231030192810.382942-1-thinker.li@gmail.com>
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
 tools/testing/selftests/bpf/Makefile          |  4 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 59 +++++++++++++++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  5 ++
 .../bpf/prog_tests/test_struct_ops_module.c   | 39 ++++++++++++
 .../selftests/bpf/progs/struct_ops_module.c   | 30 ++++++++++
 tools/testing/selftests/bpf/testing_helpers.c | 35 +++++++++++
 6 files changed, 171 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_module.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 9c27b67bc7b1..1b02e3fdaf21 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -458,7 +458,8 @@ TRUNNER_TEST_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,	\
 				 $$(notdir $$(wildcard $(TRUNNER_TESTS_DIR)/*.c)))
 TRUNNER_EXTRA_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o,		\
 				 $$(filter %.c,$(TRUNNER_EXTRA_SOURCES)))
-TRUNNER_EXTRA_HDRS := $$(filter %.h,$(TRUNNER_EXTRA_SOURCES))
+TRUNNER_EXTRA_HDRS := $$(filter %.h,$(TRUNNER_EXTRA_SOURCES)) \
+	$$(TRUNNER_OUTPUT)$(if $$(TRUNNER_OUTPUT),/)rcu_tasks_trace_gp.skel.h
 TRUNNER_TESTS_HDR := $(TRUNNER_TESTS_DIR)/tests.h
 TRUNNER_BPF_SRCS := $$(notdir $$(wildcard $(TRUNNER_BPF_PROGS_DIR)/*.c))
 TRUNNER_BPF_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.bpf.o, $$(TRUNNER_BPF_SRCS))
@@ -724,6 +725,7 @@ $(OUTPUT)/uprobe_multi: uprobe_multi.c
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
 
+
 EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
 	feature bpftool							\
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
index 000000000000..3a00dc294583
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <time.h>
+
+#include "rcu_tasks_trace_gp.skel.h"
+#include "struct_ops_module.skel.h"
+
+static void test_regular_load(void)
+{
+	struct struct_ops_module *skel;
+	struct bpf_link *link;
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
+	int err;
+
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
+	/* test_2() will be called from bpf_dummy_reg() in bpf_testmod.c */
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
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 8d994884c7b4..05870cd62458 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -10,6 +10,7 @@
 #include "test_progs.h"
 #include "testing_helpers.h"
 #include <linux/membarrier.h>
+#include "rcu_tasks_trace_gp.skel.h"
 
 int parse_num_list(const char *s, bool **num_set, int *num_set_len)
 {
@@ -380,10 +381,44 @@ int load_bpf_testmod(bool verbose)
 	return 0;
 }
 
+/* This function will trigger call_rcu_tasks_trace() in the kernel */
+static int kern_sync_rcu_tasks_trace(void)
+{
+	struct rcu_tasks_trace_gp *rcu;
+	time_t start;
+	long gp_seq;
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+
+	rcu = rcu_tasks_trace_gp__open_and_load();
+	if (IS_ERR(rcu))
+		return -EFAULT;
+	if (rcu_tasks_trace_gp__attach(rcu))
+		return -EFAULT;
+
+	gp_seq = READ_ONCE(rcu->bss->gp_seq);
+
+	if (bpf_prog_test_run_opts(bpf_program__fd(rcu->progs.do_call_rcu_tasks_trace),
+				   &opts))
+		return -EFAULT;
+	if (opts.retval != 0)
+		return -EFAULT;
+
+	start = time(NULL);
+	while ((start + 2) > time(NULL) &&
+	       gp_seq == READ_ONCE(rcu->bss->gp_seq))
+		sched_yield();
+
+	rcu_tasks_trace_gp__destroy(rcu);
+
+	return 0;
+}
+
 /*
  * Trigger synchronize_rcu() in kernel.
  */
 int kern_sync_rcu(void)
 {
+	if (kern_sync_rcu_tasks_trace())
+		return -EFAULT;
 	return syscall(__NR_membarrier, MEMBARRIER_CMD_SHARED, 0, 0);
 }
-- 
2.34.1


