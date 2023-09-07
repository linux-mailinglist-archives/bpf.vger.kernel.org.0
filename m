Return-Path: <bpf+bounces-9456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6303797D6A
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 22:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FC81C20B8A
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 20:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC8213AC1;
	Thu,  7 Sep 2023 20:32:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F67263A3
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 20:32:08 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110381703
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 13:32:07 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a85c5854deso992798b6e.0
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 13:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694118726; x=1694723526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zOtJyPWWV6Wi32fSnwNYUmstiHT7+qEZgDspDq6c1OU=;
        b=E28P/tfV+vQk24lNF/QJOzUYCB4LboSvtqfJkJGYAz2XRvbZvdOrp8GSgqZHaryg0F
         2jP8mzaEYHVSPJKCTSpNe7YAwx/2jYt8if/qdMu3DE9sHgr3WMOUGFPIRaiAT0YVXF50
         ptUisSO4T5gvAvMn1MseUZLBmn486eWC+T/N4MDf0KvU85VbVc9t2nSr8lxJjzRP+BbZ
         5TZfzg4q+ipCs85orwq8rkHh5UDXccmOL4VqzTTztxctF2unxQuy6a6d1/+zNC7mLYPd
         MhdyGC/a/ZjGlcgGL5izqPKF9lAc9IHNkbIrjj/ZgC7oOgHvoM/UDEEv+DSgwjldcj0Y
         tSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694118726; x=1694723526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOtJyPWWV6Wi32fSnwNYUmstiHT7+qEZgDspDq6c1OU=;
        b=TxtAOLetEx8u1r/LOycMNjN4Pl5sbbFcNiBEfkAAEOjV8ixBBcVgyKHDWTe4XO3h3B
         OAylitwrYSv63cqGEFXQL3ce32xxJF+4dtwhN4wdKJBbu68XyY65am2oqRAWULUfE4qg
         Yi4ymL9B2PMB7YIMiXuZhG0bt2IDbLfh4nsD/COTBHArGEVgZZMvqFzS8kOmUxY/y+BP
         OxKgN0WODajhh0oK/kXOmck/1bPZlkRxp7ymcyiSlsONc5tcG4BpMg6NZI98DMlMq58o
         VCiRB/KUCbZByfsYpssX3NNoKydC8ORwz2wGfDPSwWpaY1hbhZW+2aRJQka/PLRVenR2
         Hr5Q==
X-Gm-Message-State: AOJu0Yzs54DHkTTPccvShBafAYc+spx7mqPtj9t1y8ufBq7Ozaednh9k
	Hd96/L46m9HkcN/EMqd/W+F2NKi1+KE=
X-Google-Smtp-Source: AGHT+IGk5X+tWJARbVISEwwtQljkWoKZFiwfTIZDN1Nr/YlDQSj+csCuqXJQd6lIxOIsP0vHiuPlug==
X-Received: by 2002:a05:6808:356:b0:3a7:4646:4475 with SMTP id j22-20020a056808035600b003a746464475mr650807oie.55.1694118725906;
        Thu, 07 Sep 2023 13:32:05 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:fe6d:cbb9:9c9f:13ce])
        by smtp.gmail.com with ESMTPSA id z62-20020a0dd741000000b005869f734036sm64370ywd.19.2023.09.07.13.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 13:32:05 -0700 (PDT)
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
Subject: [RFC bpf-next] Registering struct_ops types from modules.
Date: Thu,  7 Sep 2023 13:32:02 -0700
Message-Id: <20230907203202.90790-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Resend to remove noise!

Given the current constraints of the current implementation, struct_ops
cannot be registered dynamically. This presents a significant limitation
for modules like fuse-bpf, which seeks to implement a new struct_ops
type. To address this issue, here it proposes the introduction of a new
API. This API will enable the registering of new struct_ops types from
modules.

The following code is an example of how to implement a new struct_ops type
in a module with the proposed API. It adds a new type bpf_testmod_ops in
the bpf_testmod module. And, call register_bpf_struct_ops() and
unregister_bpf_struct_ops() when init and exit the module.

A module may forget or be unable to call unregister_bpf_struct_ops(). That
may cause tragedies. So, the bpf_struct_ops subsystem should handle it
automatically, as a fallback, when the module registered a struct_ops type
is unloaded.

---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 58 +++++++++++++++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  5 ++
 .../bpf/prog_tests/test_struct_ops_module.c   | 49 ++++++++++++++++
 .../selftests/bpf/progs/struct_ops_module.c   | 27 +++++++++
 9 files changed, 170 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_module.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index cefc5dd72573..5687ad53a093 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
+#include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
 #include <linux/error-injection.h>
@@ -517,11 +518,62 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
 BTF_SET8_END(bpf_testmod_check_kfunc_ids)
 
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
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
+	return 0;
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
@@ -532,6 +584,9 @@ static int bpf_testmod_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_testmod_kfunc_set);
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_struct_ops);
+#endif
 	if (ret < 0)
 		return ret;
 	if (bpf_fentry_test1(0) < 0)
@@ -541,6 +596,9 @@ static int bpf_testmod_init(void)
 
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
index 000000000000..a6dee4b6dd68
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -0,0 +1,49 @@
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
+	extern int turnon_kk;
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
+	int err;
+
+	turnon_kk = true;
+	opts.btf_custom_path = "/sys/kernel/btf/bpf_testmod",
+
+#if 0
+	unload_bpf_testmod(true);
+	if (!ASSERT_OK(load_bpf_testmod(true), "load_bpf_testmod"))
+		return;
+#endif
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
+	bpf_link__destroy(link);
+
+	struct_ops_module__destroy(skel);
+
+#if 0
+	unload_bpf_testmod(false);
+#endif
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
index 000000000000..e77d29ae29a1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
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


