Return-Path: <bpf+bounces-19934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C86A8330FA
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 23:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBDB71F21B14
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 22:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746DE58AA9;
	Fri, 19 Jan 2024 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKz1SQs7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE6759171
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 22:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704648; cv=none; b=anIZZEZbITF5/WQinKlNP1YxhRVbpm8Nqx4TVTfcPrBOb3ClvqP7LCiNyCtrtDRhABZYnKYSc8yQXuyMwl7TW1ZS3kQ7MSyD+fyaO3eGLHWFBbA8ghJX0hK4g0CC0re3jDyQkN8qquEIChPfgHjb6H3LldVHF1+GqLaANyHuvFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704648; c=relaxed/simple;
	bh=SWB0ZHfeZoPg6tPNyHp8VWB8XO0lWeqASaf+7PmFZ80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nMopPk/fviM2K/Y3j+lloPVK+5fQ7Yd3FdJ6CIFfhbA8QvzO2en9wtsLhbOQpR4Ol+iUS96vNnX8BCBVrZ4Qtblw1K1rbsO8qDNRvvV2gnRtjpEgAyKrybQOC5DHHK49VLj/FSPNbsxxYAYeEY2Bn6LtN3hDWIeWHaTCMXfnl4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKz1SQs7; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5ff9eed5278so8507177b3.0
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 14:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705704645; x=1706309445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHUnm4yqsXHk4+Bq4H3avgcQOFnpIHhWYLrlVivvdZY=;
        b=ZKz1SQs7Ti/jRcbxICkN4i6uZerUi+GGItJZZlADWUS5SQ6Q6UOdd8hRIWyUmOFaLM
         IsesNi9lzQ5dtGucjnyldVJLF44g2HW1zwUDshZnOG2mddEw4+F4o8opMoATJXh66QaF
         7MLoRqgH5/4qIxXZ57Lq7uZNq3/nfPu51E1N/9rOJXsXNBWQ5SIb1rMOwto9oVeOBGd6
         +uJGYz1BXs5x2Rj+sJcrmVqzTr71bDE9k1U2Mo/xaU0B44ZW00ZjLnHm57NaYvR+GRlS
         FR0cSzjTBviIRMxXCTKFrcLNxRNYJIQn0ZcaYJITOhJAYclbbpYVpn+iYf6VM3ZTVUWf
         wIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705704645; x=1706309445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHUnm4yqsXHk4+Bq4H3avgcQOFnpIHhWYLrlVivvdZY=;
        b=ha3HiMnEqVmig8xZi73nCHI3odbTRldDgbOxnJl1FbHW1utbnFyaafzHL9OkvBgqOy
         TcJMXom5e+G8PN7T02R8boQGPoAWOSyiaH248760DlZMBPhPj2JsryrZCXU3iAhVlnTH
         NhLL2B2gvTozLUZvzpQc44BsAxAzEtQV/95DJWr8IUWcIn3Mf3uN+2j1s7qBai3k90k9
         0CZX+u0ONv3BbkgOd2NtL2TsUycPlz3xknqoTAN1RXBoQAxvQzINEH7f2LbmElKmcksh
         7T8yopfDE/gwDlCfyoLdCNv0HlDbrFAm7vLGi1JWEAmZZarZTE0owOJOM2fvIKUWpiSc
         X6Ww==
X-Gm-Message-State: AOJu0YyD2RjdDvcQVd0rz7luhrwC9Vt2DXt7sjyYamKaJ37iIognM33y
	jLTV+ChJq8yzA6u8SpwZfhNUAfZPo8TZoT+0LqIRENNltDxRiGv16GThD5Su
X-Google-Smtp-Source: AGHT+IHk7scZfICzX2ODbMBhecVxZZxik3drH3SKMoc6Hqus6t5naC8ZZ+iGifP5uDhzPWXE0RkLtA==
X-Received: by 2002:a0d:dd91:0:b0:5ff:9565:6f59 with SMTP id g139-20020a0ddd91000000b005ff95656f59mr608618ywe.3.1705704644769;
        Fri, 19 Jan 2024 14:50:44 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b170:5bda:247f:8c47])
        by smtp.gmail.com with ESMTPSA id s184-20020a819bc1000000b005ffa70964f4sm411770ywg.115.2024.01.19.14.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 14:50:44 -0800 (PST)
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
Subject: [PATCH bpf-next v17 14/14] selftests/bpf: test case for register_bpf_struct_ops().
Date: Fri, 19 Jan 2024 14:50:05 -0800
Message-Id: <20240119225005.668602-15-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119225005.668602-1-thinker.li@gmail.com>
References: <20240119225005.668602-1-thinker.li@gmail.com>
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
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 66 ++++++++++++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  5 ++
 .../bpf/prog_tests/test_struct_ops_module.c   | 75 +++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_module.c   | 30 ++++++++
 4 files changed, 176 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_module.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 91907b321f91..9a7949730137 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
+#include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
 #include <linux/error-injection.h>
@@ -520,11 +521,75 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
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
+static int bpf_testmod_test_1(void)
+{
+	return 0;
+}
+
+static int bpf_testmod_test_2(int a, int b)
+{
+	return 0;
+}
+
+static struct bpf_testmod_ops __bpf_testmod_ops = {
+	.test_1 = bpf_testmod_test_1,
+	.test_2 = bpf_testmod_test_2,
+};
+
+struct bpf_struct_ops bpf_bpf_testmod_ops = {
+	.verifier_ops = &bpf_testmod_verifier_ops,
+	.init = bpf_testmod_ops_init,
+	.init_member = bpf_testmod_ops_init_member,
+	.reg = bpf_dummy_reg,
+	.unreg = bpf_dummy_unreg,
+	.cfi_stubs = &__bpf_testmod_ops,
+	.name = "bpf_testmod_ops",
+	.owner = THIS_MODULE,
+};
+
 extern int bpf_fentry_test1(int a);
 
 static int bpf_testmod_init(void)
@@ -535,6 +600,7 @@ static int bpf_testmod_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_testmod_kfunc_set);
+	ret = ret ?: register_bpf_struct_ops(&bpf_bpf_testmod_ops, bpf_testmod_ops);
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
index 000000000000..8d833f0c7580
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <time.h>
+
+#include "struct_ops_module.skel.h"
+
+static void check_map_info(struct bpf_map_info *info)
+{
+	struct bpf_btf_info btf_info;
+	char btf_name[256];
+	u32 btf_info_len = sizeof(btf_info);
+	int err, fd;
+
+	fd = bpf_btf_get_fd_by_id(info->btf_vmlinux_id);
+	if (!ASSERT_GE(fd, 0, "get_value_type_btf_obj_fd"))
+		return;
+
+	memset(&btf_info, 0, sizeof(btf_info));
+	btf_info.name = ptr_to_u64(btf_name);
+	btf_info.name_len = sizeof(btf_name);
+	err = bpf_btf_get_info_by_fd(fd, &btf_info, &btf_info_len);
+	if (!ASSERT_OK(err, "get_value_type_btf_obj_info"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(strcmp(btf_name, "bpf_testmod"), 0, "get_value_type_btf_obj_name"))
+		goto cleanup;
+
+cleanup:
+	close(fd);
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
+	check_map_info(&info);
+
+cleanup:
+	struct_ops_module__destroy(skel);
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
index 000000000000..e44ac55195ca
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
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


