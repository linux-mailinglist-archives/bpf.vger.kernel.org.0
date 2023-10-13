Return-Path: <bpf+bounces-12205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7556D7C9069
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 00:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C44A0B20E0D
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 22:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71152C84A;
	Fri, 13 Oct 2023 22:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhMR7sT9"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2032C86B
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 22:43:22 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBD6BF
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 15:43:20 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7afd45199so32513357b3.0
        for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 15:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697236999; x=1697841799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJAZJUcHz3+rFEe8pLqDD8lzPRBc2xq9/lPwU5QkiWQ=;
        b=nhMR7sT9MoHF7m7rdMLb3tR3ICDVYXW2Bv0HVM2DdEdWL7MaSfyjFaS+DlBYSEEnwo
         H2xe2olKJIbR3cLzysrZQFt2lRwW5nsbDKdmF3iuor4K6CjafbWT2cxfOJ4HWdWpaiYR
         s+MdP9MDcWXRtHF6hJxIrZfEObQresBE9wcN/qxLHWjn0C8T6FAJin8/m+TRzWqiLKhh
         no/Cj/TjIsQhM1a382ZF8NqT0mXRkZzfEY/7gTJh53HFOqwYZ09U9Srqse5DgGYVo1fU
         p3yXTSRvU8ljqKlk8Dirp9F3JN4vN+4xR7CmgGymXhY39fW7wME8bXvy+xte4KK5H6B0
         f3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697236999; x=1697841799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJAZJUcHz3+rFEe8pLqDD8lzPRBc2xq9/lPwU5QkiWQ=;
        b=lsSzveGOY7VknsKuo8jAC/TPyPW42lZu3LBxZ2HqbRnrwT1eVU0z8iX+8OfTKGq2zd
         W4Qj5eC93us5f9ouj7wT8RknobikEX89bzX19HPHCduqh6fDSC5Y5CqRjSQxksfWC6Cq
         7oGVvuZ+ELPjwCbbAc0IA0dNxQANKLilYaL88ZDbt6qut5SR7PxPIiZCR08G8e/rRvue
         y1uJ2HsTbTDQ2tycKOkGwgGuqWASHYZPq1LNDsV3d6kC79/BP3jtGEzNQK8XHNJ4HrcY
         PlxcCSGJCLCp9SaSm02G1yd4A6rQ4BaXVw42DFnMueWnCrolqvkPnSqUG83K63Aef4Ud
         sQ4g==
X-Gm-Message-State: AOJu0YzrAUo5shYuAqWKHWCH5+8/4cFtzxCB/PE+ZAWA1NkOojaTe0Vz
	9+zU4iEvhfmFm3N8v6x6R6LDfpCxKT4=
X-Google-Smtp-Source: AGHT+IHBoxkd9XmwvOW1s/AdmA8illwJ9dkbB2OfdcNeYt76mUGayp0g0MN8rY6vx18xZwUSVt/gpg==
X-Received: by 2002:a81:6c84:0:b0:5a8:205e:1f1f with SMTP id h126-20020a816c84000000b005a8205e1f1fmr2900501ywc.17.1697236999360;
        Fri, 13 Oct 2023 15:43:19 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:df89:3514:fdf4:ee2])
        by smtp.gmail.com with ESMTPSA id g141-20020a0ddd93000000b00592548b2c47sm101989ywe.80.2023.10.13.15.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 15:43:19 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 9/9] selftests/bpf: test case for register_bpf_struct_ops().
Date: Fri, 13 Oct 2023 15:43:04 -0700
Message-Id: <20231013224304.187218-10-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013224304.187218-1-thinker.li@gmail.com>
References: <20231013224304.187218-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

Create a new struct_ops type called bpf_testmod_ops within the bpf_testmod
module. When a struct_ops object is registered, the bpf_testmod module will
invoke test_2 from the module.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 59 +++++++++++++++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  5 ++
 .../bpf/prog_tests/test_struct_ops_module.c   | 38 ++++++++++++
 .../selftests/bpf/progs/struct_ops_module.c   | 30 ++++++++++
 tools/testing/selftests/bpf/testing_helpers.c | 35 +++++++++++
 5 files changed, 167 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_module.c

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


