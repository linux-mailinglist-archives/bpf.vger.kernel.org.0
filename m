Return-Path: <bpf+bounces-12934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F557D2118
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 07:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6AF1C209F4
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 05:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F51B15A1;
	Sun, 22 Oct 2023 05:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4bbZ6UT"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AE91FA4
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 05:04:02 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E5E11B
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 22:04:00 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a82c2eb50cso21993697b3.2
        for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 22:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697951039; x=1698555839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hr4BB6xMm96dKQlIq1m6N5v/m3o/73pMeTPNbjiLvqo=;
        b=P4bbZ6UTSI5Y8XrU2RUJZ1HY8vTYLGBdeXrYoLPNriYGTEWuu2rSSMd3yjF37+2NfP
         f7+FsyhEOKgcUdYYuhFyxdHAwrXp8RUzlK35Pz7HrVmgOGCc/v8Rx09kvtNZvDc/9Us3
         8CTKT4zf4x5uCz3AUxyzSwvUghF84ytzXdLGI2MbCkUaCZTZU3FSlnHx60huxo1COFNC
         EudUCggeC93k092dtVHdbH6uBSwrZa7kXf6GeGzZHaf6qKu9nyQ+c16LpkwDVqLHLEWL
         lw2qtlMeKSnQU0gyxRCUnxzXvpXf2NtMkt0nm/yIHBvzLwaoEmvjNmUI9jBgM2MIzt7E
         Hkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697951039; x=1698555839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hr4BB6xMm96dKQlIq1m6N5v/m3o/73pMeTPNbjiLvqo=;
        b=cEQhHCogUjxfKmn7ecTmrB1YJVpHxY3bpp4UPpCErAgeFthmwLWQoY9Ko1YXx/p1Q2
         E0Ngk1CFMRpNQzxAf4Hgu069oB+uHzeRS7QD/3KkiLVHOAvhv94vTcWGXIWTyXUnaAMt
         TuYzKZSI1dmer3wzzqxZFihpzwSWdLdLLhzzNAFmKhwXQ/BKe9CzGhQxwaRMb8D+pDMc
         pjCURpcmYSBNth+/TEOOlwLyg3m4qBJcikPvmBXriqBtGZwCCROR0ufcWnXnnA/qS9tn
         Q4pvTZKEQsbpnnjmkr1BDDJhkFF5U19UrUtETr3vDiZ4S8cXD6holjf/J32O+jFTHQUl
         hc0Q==
X-Gm-Message-State: AOJu0Yz1HnkA/dvr8D/7OnKAxGcpxzbBC1zkVotxYEzAP16l5qeiKHA2
	guxN79wS3D0wmVLfxWECRRc3qqQwr6I=
X-Google-Smtp-Source: AGHT+IF9IbkSuAftL7Yq9PR+ZHNvUL42myf6KBDNphTZzRu/x0u6vXxbamqK4TLnhsSCzQ+RsV07oQ==
X-Received: by 2002:a0d:e254:0:b0:5a8:d790:87df with SMTP id l81-20020a0de254000000b005a8d79087dfmr6504385ywe.19.1697951039183;
        Sat, 21 Oct 2023 22:03:59 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:9904:3214:88c1:e733])
        by smtp.gmail.com with ESMTPSA id j1-20020a0de001000000b005a8c392f498sm2035169ywe.82.2023.10.21.22.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 22:03:58 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 10/10] selftests/bpf: test case for register_bpf_struct_ops().
Date: Sat, 21 Oct 2023 22:03:35 -0700
Message-Id: <20231022050335.2579051-11-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022050335.2579051-1-thinker.li@gmail.com>
References: <20231022050335.2579051-1-thinker.li@gmail.com>
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
 tools/testing/selftests/bpf/Makefile          |  2 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 59 +++++++++++++++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  5 ++
 .../bpf/prog_tests/test_struct_ops_module.c   | 38 ++++++++++++
 .../selftests/bpf/progs/struct_ops_module.c   | 30 ++++++++++
 tools/testing/selftests/bpf/testing_helpers.c | 35 +++++++++++
 6 files changed, 169 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_module.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index caede9b574cb..dd7ff14e1fdf 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -706,6 +706,8 @@ $(OUTPUT)/uprobe_multi: uprobe_multi.c
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
 
+$(OUTPUT)/testing_helpers.o: $(OUTPUT)/rcu_tasks_trace_gp.skel.h
+
 EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
 	feature bpftool							\
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index cefc5dd72573..f1a20669d884 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
+#include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
 #include <linux/error-injection.h>
@@ -517,11 +518,66 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
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
@@ -532,6 +588,9 @@ static int bpf_testmod_init(void)
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
index 000000000000..7261fc6c377a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -0,0 +1,38 @@
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


