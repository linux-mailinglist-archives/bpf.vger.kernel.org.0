Return-Path: <bpf+bounces-18127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E99AC815E11
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 09:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628EA1F21245
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 08:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7FC539C;
	Sun, 17 Dec 2023 08:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hauM2RfL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0BC538D
	for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6d9d2f2b25aso1662403a34.1
        for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 00:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702800719; x=1703405519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUhgAq7db0WtpwW7kA9tjRgbOGrTmBL+Co859tlclOQ=;
        b=hauM2RfLTdPKNPMCyCUF9Up0/ILPhYUaVjbRX05oKqljg7DndEkZcSzcu3ksOlljSN
         P/b/4jnj6TqVJjKMoem5vLqDmAuu1mEsd7wrTdoy/YRdPUlSm4LMWngU9gyud4h2Johb
         CAfiiH7en9P+gI9wmTVCYehzKoALXfqBf3qoDWPtAD1lCgTwQJFhqdYg+usLnhdvMYfQ
         iZu4dM5oiH0yr8JubdG51u2cnTKLQzyj8J8CSb1pv6XwdkQOPqfMf/bO6fs26baNIzUb
         TrHwRjhsJkrQtEB53Bn8t8ki/jCZwV/Drffa/Htfp9etplFwEdMLej7HHQ/UULQHzgpO
         bAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702800719; x=1703405519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUhgAq7db0WtpwW7kA9tjRgbOGrTmBL+Co859tlclOQ=;
        b=XjuPEC98pKw6itbWMqN9ksB9RIi4bNlEeVGzeOWGCB97CruYYGc/pMH99i9YwHtejB
         VIYnp/vipW1uZMmFbMgmqJ1YVJvLNL+N5pCy7eOBFv3D/w77MXpACPTHSBfKnOPrAKXC
         F7PPix6xILd3ks4a30XDGsmRa1zSL6w3seoGDznAgpHmxKE9S6GZ7z56T5a1HsfmjUQd
         82apsbinaftaqZ4i/UjqBLycr9nWp5fD1gIRt0zs3FHmkVH/L1a7V9m8KzXe06YSZtMn
         xTFwBFqiuo5GWKVc/dC9X9y4Z0SDW+s5IE89quyflifkTCsy+j9SyTcW7K/HaoGffsP/
         U77Q==
X-Gm-Message-State: AOJu0YwtSq6Til3vDmgClmE1cg+rbk+EXWOgxT+I616Dzviqrfz3mIhf
	HLUJFGM+eq+nd1TNF7RlcLabEqj8y0w=
X-Google-Smtp-Source: AGHT+IEtj9WDbbnV7gA3Kg0ECzOC+SxGUlFma8/yfuB0Awb2kZjnVh7dKH4dKPmKJOBXgUo4eSEp5w==
X-Received: by 2002:a05:6808:648e:b0:3ba:10b1:7a1d with SMTP id fh14-20020a056808648e00b003ba10b17a1dmr12325342oib.63.1702800719610;
        Sun, 17 Dec 2023 00:11:59 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:bb8c:c0f2:4408:50cf])
        by smtp.gmail.com with ESMTPSA id c85-20020a814e58000000b005e303826838sm3399415ywb.56.2023.12.17.00.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 00:11:59 -0800 (PST)
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
Subject: [PATCH bpf-next v14 14/14] selftests/bpf: test case for register_bpf_struct_ops().
Date: Sun, 17 Dec 2023 00:11:31 -0800
Message-Id: <20231217081132.1025020-15-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231217081132.1025020-1-thinker.li@gmail.com>
References: <20231217081132.1025020-1-thinker.li@gmail.com>
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
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  50 +++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   5 +
 .../bpf/prog_tests/test_struct_ops_module.c   | 137 ++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_module.c   |  30 ++++
 .../selftests/bpf/progs/testmod_unload.c      |  25 ++++
 5 files changed, 247 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/testmod_unload.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 91907b321f91..25ce13760807 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
+#include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
 #include <linux/error-injection.h>
@@ -520,11 +521,59 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
 BTF_SET8_END(bpf_testmod_check_kfunc_ids)
 
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
@@ -535,6 +584,7 @@ static int bpf_testmod_init(void)
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
index 000000000000..7ec340bba5d7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <time.h>
+
+#include "struct_ops_module.skel.h"
+#include "testmod_unload.skel.h"
+
+static int unload_testmod_wait(void)
+{
+	struct testmod_unload *skel_unload;
+	struct bpf_link *link_map_free;
+	int err, i;
+
+	skel_unload = testmod_unload__open_and_load();
+	if (!ASSERT_OK_PTR(skel_unload, "testmod_unload_open"))
+		return -1;
+
+	link_map_free = bpf_program__attach(skel_unload->progs.trace_map_free);
+	if (!ASSERT_OK_PTR(link_map_free, "create_link_map_free")) {
+		testmod_unload__destroy(skel_unload);
+		return -1;
+	}
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
+
+	err = unload_bpf_testmod(false);
+	ASSERT_OK(err, "unload_bpf_testmod");
+
+	return err;
+}
+
+static void test_without_testmod(struct bpf_map_info *info)
+{
+	DECLARE_LIBBPF_OPTS(bpf_map_create_opts, map_opts);
+	int err, fd;
+
+	/* Prepare map create opts */
+	fd = bpf_btf_get_fd_by_id(info->btf_id);
+	if (!ASSERT_GT(fd, 0, "get_btf_fd"))
+		goto cleanup;
+	map_opts.btf_fd = fd;
+
+	fd = bpf_btf_get_fd_by_id(info->btf_vmlinux_id);
+	if (!ASSERT_GT(fd, 0, "get_value_type_btf_obj_fd"))
+		goto cleanup;
+	map_opts.value_type_btf_obj_fd = fd;
+
+	map_opts.btf_vmlinux_value_type_id = info->btf_vmlinux_value_type_id;
+
+	/* Create a struct_ops map */
+	fd = bpf_map_create(BPF_MAP_TYPE_STRUCT_OPS, "testmod_success",
+			    info->key_size, info->value_size,
+			    info->max_entries, &map_opts);
+	if (!ASSERT_GT(fd, 0, "bpf_map_create_testmod_success"))
+		goto cleanup;
+
+	close(fd);
+
+	err = unload_testmod_wait();
+	if (err)
+		goto cleanup;
+
+	/* Create a struct_ops map again while bpf_testmod.ko is
+	 * unloaded.
+	 */
+	fd = bpf_map_create(BPF_MAP_TYPE_STRUCT_OPS, "testmod_fail",
+			    info->key_size, info->value_size,
+			    info->max_entries, &map_opts);
+	if (ASSERT_LT(fd, 0, "bpf_map_create_testmod_fail"))
+		close(fd);
+	load_bpf_testmod(false);
+
+cleanup:
+	if (map_opts.btf_fd > 0)
+		close(map_opts.btf_fd);
+	if (map_opts.value_type_btf_obj_fd > 0)
+		close(map_opts.value_type_btf_obj_fd);
+}
+
+static void test_struct_ops_load(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
+	struct struct_ops_module *skel;
+	struct bpf_map_info info = {};
+	struct bpf_link *link;
+	int err;
+	u32 len;
+
+	skel = struct_ops_module__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
+		return;
+
+	err = struct_ops_module__load(skel);
+	if (!ASSERT_OK(err, "struct_ops_module_load"))
+		goto cleanup;
+
+	len = sizeof(info);
+	err = bpf_map_get_info_by_fd(bpf_map__fd(skel->maps.testmod_1), &info,
+				     &len);
+	if (!ASSERT_OK(err, "bpf_map_get_info_by_fd"))
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
+
+	test_without_testmod(&info);
+}
+
+void serial_test_struct_ops_module(void)
+{
+	if (test__start_subtest("test_struct_ops_load"))
+		test_struct_ops_load();
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


