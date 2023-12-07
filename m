Return-Path: <bpf+bounces-16972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4C5807E0A
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 02:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70EF7281023
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 01:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AA1566E;
	Thu,  7 Dec 2023 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1S4MaCR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9214D59
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 17:40:21 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5d4f71f7e9fso1675197b3.0
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 17:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701913220; x=1702518020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0acVKzFK0l5xHCXVGmgKp6gPcv7+cgFgaMCBNwj/ibY=;
        b=N1S4MaCRpvdUEipX80KlxjriGCLTOcdMNJlzFthDwZu37O36nKDhSkIlAqy0rOBsJB
         WWcl2lh2f2goYkEiEA5yZQ0guIzDpIE14EpquE0wV9PzlHXP0V+7IYJA5HopLLwGaTSu
         Pp/uOxFEo4LVUcVHfGXfXOuVNXyjNdA6SEOE4zPkYmQhai1uRBfqP1BGjf+w11SGkKLV
         dmv7l+W63nq4A4e0CyN8jN56BM4jHn3q78j1l5JtVzovJJW/BKZbQ2D9f90Y4qWRJAhG
         lX1xMzdgO4si+MGI0Uke6sw3QYTmO1pFJ/w/0kKNgTylzzWX3ZoyZpnVFCZfKIdQcH3c
         cweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701913220; x=1702518020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0acVKzFK0l5xHCXVGmgKp6gPcv7+cgFgaMCBNwj/ibY=;
        b=u062z+qicefHvNiMZWHIjHQXypcAjItgW+PwebNnUpPDBWcNGUtdO0NJPkfSrrzlCm
         Oie2vqTx5GQAJSskT8uXvaOQ9B6DBrCSFMly4OMpRlYJ5hHaNptU04bnMTuRIj3OR50p
         P3JX7vW4gUcvV9H6d/86lo7DkrDuQAO/Fughgv37bWkMmlqpYt3b/OyZH6sHnPurQe//
         BbsWwUgHx7/tn8gYChOoV6/f2OZjDpWjIXyehQzBQ+NvrkpNApy/KbaQOY9U0Z9ZgKsB
         tdwhW096D/PDu71wrjF1AI2CJvxmKV/VcJantv9fS2SSGd5vXx2SdazITQbBDZPMUsMB
         4N3g==
X-Gm-Message-State: AOJu0YzWJ7cwhx0vkMmX6fvVPiaU33CMBs9sv2iigTjuk6oirRMgYZb7
	UdFu/3gpTOd/G+5algHbie0qanpQbcw=
X-Google-Smtp-Source: AGHT+IEhTdp2JwKjSZMLxAkjePWl69QIFn2N/mWFlo3gN1bnKCqCwdAMH6U1JC7+Ypbh1aN5dTzHSA==
X-Received: by 2002:a05:690c:732:b0:5d7:1940:dd7c with SMTP id bt18-20020a05690c073200b005d71940dd7cmr1512577ywb.82.1701913220410;
        Wed, 06 Dec 2023 17:40:20 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:c8f2:3a3b:3003:f559])
        by smtp.gmail.com with ESMTPSA id v134-20020a81488c000000b005d997db3b2fsm60768ywa.23.2023.12.06.17.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 17:40:20 -0800 (PST)
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
Subject: [PATCH bpf-next v12 13/14] selftests/bpf: test case for register_bpf_struct_ops().
Date: Wed,  6 Dec 2023 17:39:49 -0800
Message-Id: <20231207013950.1689269-14-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207013950.1689269-1-thinker.li@gmail.com>
References: <20231207013950.1689269-1-thinker.li@gmail.com>
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
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 52 +++++++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  5 +
 .../bpf/prog_tests/test_struct_ops_module.c   | 92 +++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_module.c   | 30 ++++++
 .../selftests/bpf/progs/testmod_unload.c      | 25 +++++
 5 files changed, 204 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/testmod_unload.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 91907b321f91..804a67bbb479 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
+#include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
 #include <linux/error-injection.h>
@@ -520,11 +521,61 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
 BTF_SET8_END(bpf_testmod_check_kfunc_ids)
 
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
 extern int bpf_fentry_test1(int a);
 
 static int bpf_testmod_init(void)
@@ -535,6 +586,7 @@ static int bpf_testmod_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_testmod_kfunc_set);
+	ret = ret ?: REGISTER_BPF_STRUCT_OPS(&bpf_bpf_testmod_ops, bpf_testmod_ops);
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
index 000000000000..55a4c6ed92aa
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <time.h>
+
+#include "struct_ops_module.skel.h"
+#include "testmod_unload.skel.h"
+
+static void test_regular_load(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
+	struct struct_ops_module *skel;
+	struct testmod_unload *skel_unload;
+	struct bpf_link *link_map_free = NULL;
+	struct bpf_link *link;
+	int err, i;
+
+	skel = struct_ops_module__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
+		return;
+
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
+	skel_unload = testmod_unload__open_and_load();
+
+	if (ASSERT_OK_PTR(skel_unload, "testmod_unload_open"))
+		link_map_free = bpf_program__attach(skel_unload->progs.trace_map_free);
+	struct_ops_module__destroy(skel);
+
+	if (!ASSERT_OK_PTR(link_map_free, "create_link_map_free"))
+		return;
+
+	/* Wait for the struct_ops map to be freed. Struct_ops maps hold a
+	 * refcount to the module btf. And, this function unloads and then
+	 * loads bpf_testmod. Without waiting the map to be freed, the next
+	 * test may fail to unload the bpf_testmod module since the map is
+	 * still holding a refcnt to the module.
+	 */
+	for (i = 0; i < 10; i++) {
+		if (skel_unload->bss->bpf_testmod_put)
+			break;
+		usleep(100000);
+	}
+	ASSERT_EQ(skel_unload->bss->bpf_testmod_put, 1, "map_free");
+
+	bpf_link__destroy(link_map_free);
+	testmod_unload__destroy(skel_unload);
+}
+
+static void test_load_without_module(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
+	struct struct_ops_module *skel;
+	int err;
+
+	err = unload_bpf_testmod(false);
+	if (!ASSERT_OK(err, "unload_bpf_testmod"))
+		return;
+
+	skel = struct_ops_module__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
+		goto cleanup;
+	err = struct_ops_module__load(skel);
+	ASSERT_ERR(err, "struct_ops_module_load");
+
+	struct_ops_module__destroy(skel);
+
+cleanup:
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
diff --git a/tools/testing/selftests/bpf/progs/testmod_unload.c b/tools/testing/selftests/bpf/progs/testmod_unload.c
new file mode 100644
index 000000000000..bb17914ecca3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/testmod_unload.c
@@ -0,0 +1,25 @@
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
+SEC("fentry/__bpf_struct_ops_map_free")
+int BPF_PROG(trace_map_free, struct bpf_map *map)
+{
+	static const char name[] = "testmod_1";
+	int i;
+
+	for (i = 0; i < sizeof(name); i++) {
+		if (map->name[i] != name[i])
+			return 0;
+	}
+
+	bpf_testmod_put = 1;
+
+	return 0;
+}
-- 
2.34.1


