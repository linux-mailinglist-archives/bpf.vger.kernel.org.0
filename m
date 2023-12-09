Return-Path: <bpf+bounces-17291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0733180B100
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 01:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390611C20D82
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 00:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A4F1101;
	Sat,  9 Dec 2023 00:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRwy4JIC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D89171F
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 16:27:30 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5d852ac9bb2so25589027b3.2
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 16:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702081649; x=1702686449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0acVKzFK0l5xHCXVGmgKp6gPcv7+cgFgaMCBNwj/ibY=;
        b=iRwy4JIC8LizVHwRRyuyswoMk9+YZ1zLDlzEnP0J6jVMELWFw1u95bn59ROaW1hqJl
         dvaJfiptlnzGXX7fLn9JKV0vVhU48NGeb1aNIpYnXjBgqQ/fCntUglMTgfIhzPPb8McH
         Z7HqajmkA9fl80wi8MefwYDNymcn39yiHHairovLnXzcdcazzNxrSFFBgaWHs750iqd8
         CeEQ3P7KTpmPATNGba7awrNb/E1yfwvH/V+j+P4ImfaJfN2YA1rxY0hcFHednyu8+pxQ
         H2X7itsuNkY52Ryrk6JKgb/un5DcSP916zKCp6Q4G8l5WyJBXC1ST5hlv3LF3rPDtt5W
         76sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702081649; x=1702686449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0acVKzFK0l5xHCXVGmgKp6gPcv7+cgFgaMCBNwj/ibY=;
        b=GnmaYtQxFnAT6pIjvjcYzx9LwF0aD9skobCMc2wclIVb8GbRfCdLDUel4BLv9z/Dtf
         HXbZHWL9Y9pIKYvQ9gOvY51MQiDnJmC7ZIVXq4oAiF9RwRKIE8XY1BGvWoJ3HYPCCIF4
         P9ojYe8CRTKuGNnebIifZFmYFwSZJwcJwVHFz/I3Jyr17W1g41tYglGQ2roNnnldGQK9
         ytDs7njfauPAQKIHNRci1C02WvEmid/DthVYnA9oqE2+8TVNpINv78bf+BvxCj+6aFcC
         0NIct3y/PxqI/G4QzdUqKykAmjLAIk3aS+cryuIFHZH4iYNB+9TTBd5svFhZTCX7nRfM
         R1LA==
X-Gm-Message-State: AOJu0YyO3BusqHuM0AyqFEK38cMexCiV7M3XnwhK2cjwio9fjMbeuQhJ
	R8GOYxmVhqXdkDpXehiU7+x683x1/3quCg==
X-Google-Smtp-Source: AGHT+IEe+zAXYpIk4GONxK091xBrBsIlulNgCsV5cwsfZryIpKBRTx8ABFwUukRR299B13KiO9QdYA==
X-Received: by 2002:a0d:cbd2:0:b0:5d4:1fbf:d08d with SMTP id n201-20020a0dcbd2000000b005d41fbfd08dmr756435ywd.14.1702081649437;
        Fri, 08 Dec 2023 16:27:29 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:65fe:fe26:c15:a05c])
        by smtp.gmail.com with ESMTPSA id v4-20020a818504000000b005d9729068f5sm1057450ywf.42.2023.12.08.16.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 16:27:28 -0800 (PST)
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
Subject: [PATCH bpf-next v13 13/14] selftests/bpf: test case for register_bpf_struct_ops().
Date: Fri,  8 Dec 2023 16:27:08 -0800
Message-Id: <20231209002709.535966-14-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209002709.535966-1-thinker.li@gmail.com>
References: <20231209002709.535966-1-thinker.li@gmail.com>
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


