Return-Path: <bpf+bounces-19787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332BE83111A
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 02:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83D29B25787
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 01:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74099477;
	Thu, 18 Jan 2024 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpZCp9ni"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A6D947F
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 01:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542609; cv=none; b=CDQmVOpJyjoDbI3r9x+3fQKCRLMX7hNwzq8JwPUWQsmrDfW6tvsb3IW2DAF1n3lOU5Sqpxmh4ouY0smSpVkwgcRKGc5e/qx/OnPoq6eJabAe8/xvhpH4tfs1UPygabLVrnRQakIp7bqaaNHTMGBHLRhEDFdFswfEKKi3ktbpeEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542609; c=relaxed/simple;
	bh=iyhHvIPvaBBtfmoJDpxo9OZbZ7hgn3EAMrvPEF5dFGQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=qXNsK4In+Pk9tMOT71ntQAPQ9JMQJMLotTQ4Ayipf8n+k2dUrxB0kxy/v3nlkJ4suOwZx3MqGhU/UJIdLXvzZEBZhtyW9laFeVm0zQpnrArMGLU+QaKskM3mfxElm/fDCkU859kuHBK55eR6uC6vvGtm3kBxiidi2aiFVtdiU4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpZCp9ni; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5fc2e997804so53566697b3.3
        for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 17:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705542606; x=1706147406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/0XNGTvS6j7zkOcjeg62IEHvsHjUequp8YwrgIRsYg=;
        b=SpZCp9niSV6VVDh5W08moV60czyqIXO3zMkABALBTZs+BEHEa5Ok5CmSgTaLpBt1qe
         oJqJ8B/WQ6yn8IpAWaneXMjtgWw1U1uBi6JUWMuhxwa5AI3wgTWh5ea/tlDnRZhxFOTj
         QtGE3cJ/obOxQHyXsf04Aoh3qO5brhcW2lb4b4bQg2L1P6lK2BeYB/05OrLSdiHlavqx
         m1gbIy6VtpSCUGlDpelvqovq+9EW/tDLshAqvzLhH0tgDJdg4n6y1ZzPYmHDMIsP8X/L
         lSRc48ZK/8uMxgYfMTJJc9u9Eap6HkUf7viNyHxA5Q/80wDxYmnfN+1zHnUdLj1X3OQm
         W/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542606; x=1706147406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/0XNGTvS6j7zkOcjeg62IEHvsHjUequp8YwrgIRsYg=;
        b=EJD9Wh4OdRGY7XPeqCgOfZ3oBlfbL7I4bQ9HsMetXu27/8QbFp3teTDcSfT2RQQzpu
         qqFYo1D5BYI8RDXpcJLT18mNs7YUrWRkLoArROcAFGG0uAGPwnWi4HsLODjJ8ki2LgnU
         gY8qoA65THM2RK6uYR/EkN3nCBgtnKOrTijCswWa/X3siSrHhWaKuQ3KqTk64xEkzXfe
         q2Yl6tKFQzlX3BvmzkWPB/EwxhYkQfilld45I+JCB6DxvrlGUqYO53wMnl8H2bE0lxIT
         ViHbJnXGUGguwJ6nd2QWhtrrywfVPdR8fArIWUKxDhfwh4+g37w/05e89Cd1YuSNPgb0
         ooZA==
X-Gm-Message-State: AOJu0Yz3YQoP+R2u1DC8Q5gujADhdhEX+vYZJw4pLFL4mTKzm2/C2IUK
	WEvwPVx7Exd3AWW+xxsi1eEGo9Ba/Euo6ZQ1WeNT9hQJFyc3l5xZPHEN4yB5
X-Google-Smtp-Source: AGHT+IH0FgckQgiL+DxRmx3xBOTinZBWZxnuWzSuPOeIqQKuED3tcw+kZ5zctn5/TEW9j1KhRl08mA==
X-Received: by 2002:a81:6544:0:b0:5f0:3620:2909 with SMTP id z65-20020a816544000000b005f036202909mr148736ywb.66.1705542606486;
        Wed, 17 Jan 2024 17:50:06 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:8b90:cd6a:b588:8d99])
        by smtp.gmail.com with ESMTPSA id cb9-20020a05690c090900b005e5fff5c537sm6248606ywb.85.2024.01.17.17.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 17:50:06 -0800 (PST)
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
Subject: [PATCH bpf-next v16 14/14] selftests/bpf: test case for register_bpf_struct_ops().
Date: Wed, 17 Jan 2024 17:49:30 -0800
Message-Id: <20240118014930.1992551-15-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118014930.1992551-1-thinker.li@gmail.com>
References: <20240118014930.1992551-1-thinker.li@gmail.com>
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
index 91907b321f91..fe945d093378 100644
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
index 000000000000..333d70c5f708
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
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


