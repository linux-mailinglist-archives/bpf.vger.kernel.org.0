Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957EE4CDD45
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 20:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiCDTSK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 14:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiCDTSJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 14:18:09 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F780230E6E
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 11:17:12 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d726bd83a2so78853537b3.20
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 11:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7Fdyq2zl3Pn/KJWhFsp8uIQPyOE72aunF6Y/Yf0GGQI=;
        b=s6aV8QLut1V+onK6489O8IDLDeMnKDrp75Va/PwX/npSBsBixhEyLAxXvzXVc1xMxA
         skrK+8Nqg3q7pycesMMQ9GgWeOtWQ/AH5mznt7KZzkTGb+qAKWeWpbD3xIRgHMABdToX
         BUABCCiPHA1f3RGyJTiFqSQoO7RHq4hkvYn2zT7WW6tXTNpeQF95ySUFNQayYtBJFQbZ
         kRtTC+UKStRYIm7iAol4JEsNiZ71jycfjIlboGzapdieXZsfC+wnod/ygU9/0Q5iVxMh
         vzrb00OfroXKdttxiD1J1C0xEKi2T2/fAx9tAe75sDCWdWRMeG3Kw83K8+YP1gxxesyx
         aoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7Fdyq2zl3Pn/KJWhFsp8uIQPyOE72aunF6Y/Yf0GGQI=;
        b=HqRCik07cxzIQE6e+AlSjUPb4HJHhVytsNValmrnOhO65jdQoslQdSR0ltvWlBMsK2
         MwFDhLd60lZ5sq0lJL7b6Anf+/WpoYVSAweYZQv/rJCw1OtbJL6gPrBcpCRhyX09cXFA
         0eGcRbg9MzsfEFMoPxZjlz6suuWdK+AB8LR6f8+K3TN4n8ek5jkJm+51eFa/QFfG7wYz
         REpxp4D/ARGxfUuwD1DfeLiYxL51Bp7N6babzF2dW/jq61odc9P5v8nzqa9r2vjLqJlA
         pEjNBIc2UyMnuQto1O7wC+e9CLX4vnRvEW+cCZoXtIWbY4zI9FyCqDKg4uXxAena/Br+
         4G3A==
X-Gm-Message-State: AOAM532SRB2ElFjaLfiB5qUEuOt4AwmUPLvQYwjBzdn0eyT3wHvmGpAl
        C36Y8gD7Q1GwomAMOkmuPr/m0jbJIqE=
X-Google-Smtp-Source: ABdhPJyiCfBKoQ9i/MFZRr93lw0d4r7iOLd5mSKkWydJ7oR1xp5xZ79128CVeq29B8xM9Gr7k1VOlHzxTPQ=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:d204:6f81:5498:9251])
 (user=haoluo job=sendgmr) by 2002:a25:7804:0:b0:628:ec4c:989b with SMTP id
 t4-20020a257804000000b00628ec4c989bmr3202280ybc.428.1646421430967; Fri, 04
 Mar 2022 11:17:10 -0800 (PST)
Date:   Fri,  4 Mar 2022 11:16:57 -0800
In-Reply-To: <20220304191657.981240-1-haoluo@google.com>
Message-Id: <20220304191657.981240-5-haoluo@google.com>
Mime-Version: 1.0
References: <20220304191657.981240-1-haoluo@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH bpf-next v1 4/4] selftests/bpf: Add a test for btf_type_tag "percpu"
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, yhs@fb.com
Cc:     acme@kernel.org, KP Singh <kpsingh@kernel.org>,
        bpf@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add test for percpu btf_type_tag. Similar to the "user" tag, we test
the following cases:

 1. __percpu struct field.
 2. __percpu as function parameter.
 3. per_cpu_ptr() accepts dynamically allocated __percpu memory.

Because the test for "user" and the test for "percpu" are very similar,
a little bit of refactoring has been done in btf_tag.c. Basically, both
tests share the same function for loading vmlinux and module btf.

Example output from log:

 > ./test_progs -v -t btf_tag

 libbpf: prog 'test_percpu1': BPF program load failed: Permission denied
 libbpf: prog 'test_percpu1': -- BEGIN PROG LOAD LOG --
 ...
 ; g = arg->a;
 1: (61) r1 = *(u32 *)(r1 +0)
 R1 is ptr_bpf_testmod_btf_type_tag_1 access percpu memory: off=0
 ...
 test_btf_type_tag_mod_percpu:PASS:btf_type_tag_percpu 0 nsec
 #26/6 btf_tag/btf_type_tag_percpu_mod1:OK

 libbpf: prog 'test_percpu2': BPF program load failed: Permission denied
 libbpf: prog 'test_percpu2': -- BEGIN PROG LOAD LOG --
 ...
 ; g = arg->p->a;
 2: (61) r1 = *(u32 *)(r1 +0)
 R1 is ptr_bpf_testmod_btf_type_tag_1 access percpu memory: off=0
 ...
 test_btf_type_tag_mod_percpu:PASS:btf_type_tag_percpu 0 nsec
 #26/7 btf_tag/btf_type_tag_percpu_mod2:OK

 libbpf: prog 'test_percpu_load': BPF program load failed: Permission denied
 libbpf: prog 'test_percpu_load': -- BEGIN PROG LOAD LOG --
 ...
 ; g = (__u64)cgrp->rstat_cpu->updated_children;
 2: (79) r1 = *(u64 *)(r1 +48)
 R1 is ptr_cgroup_rstat_cpu access percpu memory: off=48
 ...
 test_btf_type_tag_vmlinux_percpu:PASS:btf_type_tag_percpu_load 0 nsec
 #26/8 btf_tag/btf_type_tag_percpu_vmlinux_load:OK

 load_btfs:PASS:could not load vmlinux BTF 0 nsec
 test_btf_type_tag_vmlinux_percpu:PASS:btf_type_tag_percpu 0 nsec
 test_btf_type_tag_vmlinux_percpu:PASS:btf_type_tag_percpu_helper 0 nsec
 #26/9 btf_tag/btf_type_tag_percpu_vmlinux_helper:OK

Signed-off-by: Hao Luo <haoluo@google.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  17 ++
 .../selftests/bpf/prog_tests/btf_tag.c        | 164 ++++++++++++++----
 .../selftests/bpf/progs/btf_type_tag_percpu.c |  66 +++++++
 3 files changed, 218 insertions(+), 29 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 27d63be47b95..17c211f3b924 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -33,6 +33,10 @@ struct bpf_testmod_btf_type_tag_2 {
 	struct bpf_testmod_btf_type_tag_1 __user *p;
 };
 
+struct bpf_testmod_btf_type_tag_3 {
+	struct bpf_testmod_btf_type_tag_1 __percpu *p;
+};
+
 noinline int
 bpf_testmod_test_btf_type_tag_user_1(struct bpf_testmod_btf_type_tag_1 __user *arg) {
 	BTF_TYPE_EMIT(func_proto_typedef);
@@ -46,6 +50,19 @@ bpf_testmod_test_btf_type_tag_user_2(struct bpf_testmod_btf_type_tag_2 *arg) {
 	return arg->p->a;
 }
 
+noinline int
+bpf_testmod_test_btf_type_tag_percpu_1(struct bpf_testmod_btf_type_tag_1 __percpu *arg) {
+	BTF_TYPE_EMIT(func_proto_typedef);
+	BTF_TYPE_EMIT(func_proto_typedef_nested1);
+	BTF_TYPE_EMIT(func_proto_typedef_nested2);
+	return arg->a;
+}
+
+noinline int
+bpf_testmod_test_btf_type_tag_percpu_2(struct bpf_testmod_btf_type_tag_3 *arg) {
+	return arg->p->a;
+}
+
 noinline int bpf_testmod_loop_test(int n)
 {
 	int i, sum = 0;
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_tag.c b/tools/testing/selftests/bpf/prog_tests/btf_tag.c
index f7560b54a6bb..071430cd54de 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_tag.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_tag.c
@@ -10,6 +10,7 @@ struct btf_type_tag_test {
 };
 #include "btf_type_tag.skel.h"
 #include "btf_type_tag_user.skel.h"
+#include "btf_type_tag_percpu.skel.h"
 
 static void test_btf_decl_tag(void)
 {
@@ -43,38 +44,81 @@ static void test_btf_type_tag(void)
 	btf_type_tag__destroy(skel);
 }
 
-static void test_btf_type_tag_mod_user(bool load_test_user1)
+/* loads vmlinux_btf as well as module_btf. If the caller passes NULL as
+ * module_btf, it will not load module btf.
+ *
+ * Returns 0 on success.
+ * Return -1 On error. In case of error, the loaded btf will be freed and the
+ * input parameters will be set to pointing to NULL.
+ */
+static int load_btfs(struct btf **vmlinux_btf, struct btf **module_btf,
+		     bool needs_vmlinux_tag)
 {
 	const char *module_name = "bpf_testmod";
-	struct btf *vmlinux_btf, *module_btf;
-	struct btf_type_tag_user *skel;
 	__s32 type_id;
-	int err;
 
 	if (!env.has_testmod) {
 		test__skip();
-		return;
+		return -1;
 	}
 
-	/* skip the test if the module does not have __user tags */
-	vmlinux_btf = btf__load_vmlinux_btf();
-	if (!ASSERT_OK_PTR(vmlinux_btf, "could not load vmlinux BTF"))
-		return;
+	*vmlinux_btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(*vmlinux_btf, "could not load vmlinux BTF"))
+		return -1;
+
+	if (!needs_vmlinux_tag)
+		goto load_module_btf;
 
-	module_btf = btf__load_module_btf(module_name, vmlinux_btf);
-	if (!ASSERT_OK_PTR(module_btf, "could not load module BTF"))
+	/* skip the test if the vmlinux does not have __user tags */
+	type_id = btf__find_by_name_kind(*vmlinux_btf, "user", BTF_KIND_TYPE_TAG);
+	if (type_id <= 0) {
+		printf("%s:SKIP: btf_type_tag attribute not in vmlinux btf", __func__);
+		test__skip();
 		goto free_vmlinux_btf;
+	}
 
-	type_id = btf__find_by_name_kind(module_btf, "user", BTF_KIND_TYPE_TAG);
+load_module_btf:
+	/* skip loading module_btf, if not requested by caller */
+	if (!module_btf)
+		return 0;
+
+	*module_btf = btf__load_module_btf(module_name, *vmlinux_btf);
+	if (!ASSERT_OK_PTR(*module_btf, "could not load module BTF"))
+		goto free_vmlinux_btf;
+
+	/* skip the test if the module does not have __user tags */
+	type_id = btf__find_by_name_kind(*module_btf, "user", BTF_KIND_TYPE_TAG);
 	if (type_id <= 0) {
 		printf("%s:SKIP: btf_type_tag attribute not in %s", __func__, module_name);
 		test__skip();
 		goto free_module_btf;
 	}
 
+	return 0;
+
+free_module_btf:
+	btf__free(*module_btf);
+free_vmlinux_btf:
+	btf__free(*vmlinux_btf);
+
+	*vmlinux_btf = NULL;
+	if (module_btf)
+		*module_btf = NULL;
+	return -1;
+}
+
+static void test_btf_type_tag_mod_user(bool load_test_user1)
+{
+	struct btf *vmlinux_btf = NULL, *module_btf = NULL;
+	struct btf_type_tag_user *skel;
+	int err;
+
+	if (load_btfs(&vmlinux_btf, &module_btf, /*needs_vmlinux_tag=*/false))
+		return;
+
 	skel = btf_type_tag_user__open();
 	if (!ASSERT_OK_PTR(skel, "btf_type_tag_user"))
-		goto free_module_btf;
+		goto cleanup;
 
 	bpf_program__set_autoload(skel->progs.test_sys_getsockname, false);
 	if (load_test_user1)
@@ -87,34 +131,23 @@ static void test_btf_type_tag_mod_user(bool load_test_user1)
 
 	btf_type_tag_user__destroy(skel);
 
-free_module_btf:
+cleanup:
 	btf__free(module_btf);
-free_vmlinux_btf:
 	btf__free(vmlinux_btf);
 }
 
 static void test_btf_type_tag_vmlinux_user(void)
 {
 	struct btf_type_tag_user *skel;
-	struct btf *vmlinux_btf;
-	__s32 type_id;
+	struct btf *vmlinux_btf = NULL;
 	int err;
 
-	/* skip the test if the vmlinux does not have __user tags */
-	vmlinux_btf = btf__load_vmlinux_btf();
-	if (!ASSERT_OK_PTR(vmlinux_btf, "could not load vmlinux BTF"))
+	if (load_btfs(&vmlinux_btf, NULL, /*needs_vmlinux_tag=*/true))
 		return;
 
-	type_id = btf__find_by_name_kind(vmlinux_btf, "user", BTF_KIND_TYPE_TAG);
-	if (type_id <= 0) {
-		printf("%s:SKIP: btf_type_tag attribute not in vmlinux btf", __func__);
-		test__skip();
-		goto free_vmlinux_btf;
-	}
-
 	skel = btf_type_tag_user__open();
 	if (!ASSERT_OK_PTR(skel, "btf_type_tag_user"))
-		goto free_vmlinux_btf;
+		goto cleanup;
 
 	bpf_program__set_autoload(skel->progs.test_user2, false);
 	bpf_program__set_autoload(skel->progs.test_user1, false);
@@ -124,7 +157,70 @@ static void test_btf_type_tag_vmlinux_user(void)
 
 	btf_type_tag_user__destroy(skel);
 
-free_vmlinux_btf:
+cleanup:
+	btf__free(vmlinux_btf);
+}
+
+static void test_btf_type_tag_mod_percpu(bool load_test_percpu1)
+{
+	struct btf *vmlinux_btf, *module_btf;
+	struct btf_type_tag_percpu *skel;
+	int err;
+
+	if (load_btfs(&vmlinux_btf, &module_btf, /*needs_vmlinux_tag=*/false))
+		return;
+
+	skel = btf_type_tag_percpu__open();
+	if (!ASSERT_OK_PTR(skel, "btf_type_tag_percpu"))
+		goto cleanup;
+
+	bpf_program__set_autoload(skel->progs.test_percpu_load, false);
+	bpf_program__set_autoload(skel->progs.test_percpu_helper, false);
+	if (load_test_percpu1)
+		bpf_program__set_autoload(skel->progs.test_percpu2, false);
+	else
+		bpf_program__set_autoload(skel->progs.test_percpu1, false);
+
+	err = btf_type_tag_percpu__load(skel);
+	ASSERT_ERR(err, "btf_type_tag_percpu");
+
+	btf_type_tag_percpu__destroy(skel);
+
+cleanup:
+	btf__free(module_btf);
+	btf__free(vmlinux_btf);
+}
+
+static void test_btf_type_tag_vmlinux_percpu(bool load_test)
+{
+	struct btf_type_tag_percpu *skel;
+	struct btf *vmlinux_btf = NULL;
+	int err;
+
+	if (load_btfs(&vmlinux_btf, NULL, /*needs_vmlinux_tag=*/true))
+		return;
+
+	skel = btf_type_tag_percpu__open();
+	if (!ASSERT_OK_PTR(skel, "btf_type_tag_percpu"))
+		goto cleanup;
+
+	bpf_program__set_autoload(skel->progs.test_percpu2, false);
+	bpf_program__set_autoload(skel->progs.test_percpu1, false);
+	if (load_test) {
+		bpf_program__set_autoload(skel->progs.test_percpu_helper, false);
+
+		err = btf_type_tag_percpu__load(skel);
+		ASSERT_ERR(err, "btf_type_tag_percpu_load");
+	} else {
+		bpf_program__set_autoload(skel->progs.test_percpu_load, false);
+
+		err = btf_type_tag_percpu__load(skel);
+		ASSERT_OK(err, "btf_type_tag_percpu_helper");
+	}
+
+	btf_type_tag_percpu__destroy(skel);
+
+cleanup:
 	btf__free(vmlinux_btf);
 }
 
@@ -134,10 +230,20 @@ void test_btf_tag(void)
 		test_btf_decl_tag();
 	if (test__start_subtest("btf_type_tag"))
 		test_btf_type_tag();
+
 	if (test__start_subtest("btf_type_tag_user_mod1"))
 		test_btf_type_tag_mod_user(true);
 	if (test__start_subtest("btf_type_tag_user_mod2"))
 		test_btf_type_tag_mod_user(false);
 	if (test__start_subtest("btf_type_tag_sys_user_vmlinux"))
 		test_btf_type_tag_vmlinux_user();
+
+	if (test__start_subtest("btf_type_tag_percpu_mod1"))
+		test_btf_type_tag_mod_percpu(true);
+	if (test__start_subtest("btf_type_tag_percpu_mod2"))
+		test_btf_type_tag_mod_percpu(false);
+	if (test__start_subtest("btf_type_tag_percpu_vmlinux_load"))
+		test_btf_type_tag_vmlinux_percpu(true);
+	if (test__start_subtest("btf_type_tag_percpu_vmlinux_helper"))
+		test_btf_type_tag_vmlinux_percpu(false);
 }
diff --git a/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c b/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
new file mode 100644
index 000000000000..8feddb8289cf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Google */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct bpf_testmod_btf_type_tag_1 {
+	int a;
+};
+
+struct bpf_testmod_btf_type_tag_2 {
+	struct bpf_testmod_btf_type_tag_1 *p;
+};
+
+__u64 g;
+
+SEC("fentry/bpf_testmod_test_btf_type_tag_percpu_1")
+int BPF_PROG(test_percpu1, struct bpf_testmod_btf_type_tag_1 *arg)
+{
+	g = arg->a;
+	return 0;
+}
+
+SEC("fentry/bpf_testmod_test_btf_type_tag_percpu_2")
+int BPF_PROG(test_percpu2, struct bpf_testmod_btf_type_tag_2 *arg)
+{
+	g = arg->p->a;
+	return 0;
+}
+
+/* trace_cgroup_mkdir(struct cgroup *cgrp, const char *path)
+ *
+ * struct cgroup_rstat_cpu {
+ *   ...
+ *   struct cgroup *updated_children;
+ *   ...
+ * };
+ *
+ * struct cgroup {
+ *   ...
+ *   struct cgroup_rstat_cpu __percpu *rstat_cpu;
+ *   ...
+ * };
+ */
+SEC("tp_btf/cgroup_mkdir")
+int BPF_PROG(test_percpu_load, struct cgroup *cgrp, const char *path)
+{
+	g = (__u64)cgrp->rstat_cpu->updated_children;
+	return 0;
+}
+
+SEC("tp_btf/cgroup_mkdir")
+int BPF_PROG(test_percpu_helper, struct cgroup *cgrp, const char *path)
+{
+	struct cgroup_rstat_cpu *rstat;
+	__u32 cpu;
+
+	cpu = bpf_get_smp_processor_id();
+	rstat = (struct cgroup_rstat_cpu *)bpf_per_cpu_ptr(cgrp->rstat_cpu, cpu);
+	if (rstat) {
+		/* READ_ONCE */
+		*(volatile int *)rstat;
+	}
+
+	return 0;
+}
-- 
2.35.1.616.g0bdcbb4464-goog

