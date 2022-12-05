Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BB0642BBF
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 16:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbiLEP3Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 10:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiLEP3F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 10:29:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2031EAFC
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 07:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670253993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uKvjKCdmkZB6NQ/bdjjalHt9P1pJFFM/EqdFh8BTkbY=;
        b=Yf8bEIReKVn6O/sTik0nSjhRZytoRXVgT917y3swtcmn0uZTF/mLVrngvPhvHkf2kqVNm2
        yBvpqV4se9sIuqDeeJhFDBlQybuMF6wYi9bceJ1UcVBWLmer4Jm6Gnqrqo394p+iqLlF/K
        DV4I84RQwLK4qqSo+zyZPL0W3N8FABE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-Kwxs43jeO1SsU25OnBblNw-1; Mon, 05 Dec 2022 10:26:29 -0500
X-MC-Unique: Kwxs43jeO1SsU25OnBblNw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C4231C05149;
        Mon,  5 Dec 2022 15:26:27 +0000 (UTC)
Received: from ovpn-193-115.brq.redhat.com (ovpn-193-115.brq.redhat.com [10.40.193.115])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 275E040C6EC3;
        Mon,  5 Dec 2022 15:26:24 +0000 (UTC)
From:   Viktor Malik <vmalik@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v3 3/3] bpf/selftests: Test fentry attachment to shadowed functions
Date:   Mon,  5 Dec 2022 16:26:06 +0100
Message-Id: <db2560ea17db7c207a4de31fb84f0ccd5435245f.1670249590.git.vmalik@redhat.com>
In-Reply-To: <cover.1670249590.git.vmalik@redhat.com>
References: <cover.1670249590.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adds a new test that tries to attach a program to fentry of two
functions of the same name, one located in vmlinux and the other in
bpf_testmod.

To avoid conflicts with existing tests, a new function
"bpf_fentry_shadow_test" was created both in vmlinux and in bpf_testmod.

The previous commit fixed a bug which caused this test to fail. The
verifier would always use the vmlinux function's address as the target
trampoline address, hence trying to attach two programs to the same
trampoline.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 net/bpf/test_run.c                            |   5 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   7 +
 .../bpf/prog_tests/module_attach_shadow.c     | 124 ++++++++++++++++++
 3 files changed, 136 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 6094ef7cffcd..71e36a85573b 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -536,6 +536,11 @@ int noinline bpf_modify_return_test(int a, int *b)
 	return a + *b;
 }
 
+int noinline bpf_fentry_shadow_test(int a)
+{
+	return a + 1;
+}
+
 u64 noinline bpf_kfunc_call_test1(struct sock *sk, u32 a, u64 b, u32 c, u64 d)
 {
 	return a + b + c + d;
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 5085fea3cac5..d23127a5ec68 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -229,6 +229,13 @@ static const struct btf_kfunc_id_set bpf_testmod_kfunc_set = {
 	.set   = &bpf_testmod_check_kfunc_ids,
 };
 
+noinline int bpf_fentry_shadow_test(int a)
+{
+	return a + 2;
+}
+EXPORT_SYMBOL_GPL(bpf_fentry_shadow_test);
+ALLOW_ERROR_INJECTION(bpf_fentry_shadow_test, ERRNO);
+
 extern int bpf_fentry_test1(int a);
 
 static int bpf_testmod_init(void)
diff --git a/tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c b/tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c
new file mode 100644
index 000000000000..bf511e61ec1f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Red Hat */
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "bpf/libbpf_internal.h"
+#include "cgroup_helpers.h"
+
+static const char *module_name = "bpf_testmod";
+static const char *symbol_name = "bpf_fentry_shadow_test";
+
+int get_bpf_testmod_btf_fd(void)
+{
+	struct bpf_btf_info info;
+	char name[64];
+	__u32 id = 0, len;
+	int err, fd;
+
+	while (true) {
+		err = bpf_btf_get_next_id(id, &id);
+		if (err) {
+			log_err("failed to iterate BTF objects");
+			return err;
+		}
+
+		fd = bpf_btf_get_fd_by_id(id);
+		if (fd < 0) {
+			err = -errno;
+			log_err("failed to get FD for BTF object #%d", id);
+			return err;
+		}
+
+		len = sizeof(info);
+		memset(&info, 0, sizeof(info));
+		info.name = ptr_to_u64(name);
+		info.name_len = sizeof(name);
+
+		err = bpf_obj_get_info_by_fd(fd, &info, &len);
+		if (err) {
+			err = -errno;
+			log_err("failed to get info for BTF object #%d", id);
+			close(fd);
+			return err;
+		}
+
+		if (strcmp(name, module_name) == 0)
+			return fd;
+
+		close(fd);
+	}
+	return -ENOENT;
+}
+
+void test_module_fentry_shadow(void)
+{
+	struct btf *vmlinux_btf = NULL, *mod_btf = NULL;
+	int err, i;
+	int btf_fd[2] = {};
+	int prog_fd[2] = {};
+	int link_fd[2] = {};
+	__s32 btf_id[2] = {};
+
+	const struct bpf_insn trace_program[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+
+	LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
+		.expected_attach_type = BPF_TRACE_FENTRY,
+	);
+
+	LIBBPF_OPTS(bpf_test_run_opts, test_opts);
+
+	vmlinux_btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(vmlinux_btf, "load_vmlinux_btf"))
+		return;
+
+	btf_fd[1] = get_bpf_testmod_btf_fd();
+	if (!ASSERT_GT(btf_fd[1], 0, "get_bpf_testmod_btf_fd"))
+		goto out;
+
+	mod_btf = btf_get_from_fd(btf_fd[1], vmlinux_btf);
+	if (!ASSERT_OK_PTR(mod_btf, "btf_get_from_fd"))
+		goto out;
+
+	btf_id[0] = btf__find_by_name_kind(vmlinux_btf, symbol_name, BTF_KIND_FUNC);
+	if (!ASSERT_GT(btf_id[0], 0, "btf_find_by_name"))
+		goto out;
+
+	btf_id[1] = btf__find_by_name_kind(mod_btf, symbol_name, BTF_KIND_FUNC);
+	if (!ASSERT_GT(btf_id[1], 0, "btf_find_by_name"))
+		goto out;
+
+	for (i = 0; i < 2; i++) {
+		load_opts.attach_btf_id = btf_id[i];
+		load_opts.attach_btf_obj_fd = btf_fd[i];
+		prog_fd[i] = bpf_prog_load(BPF_PROG_TYPE_TRACING, NULL, "GPL",
+					   trace_program,
+					   sizeof(trace_program) / sizeof(struct bpf_insn),
+					   &load_opts);
+		if (!ASSERT_GE(prog_fd[i], 0, "bpf_prog_load"))
+			goto out;
+
+		link_fd[i] = bpf_link_create(prog_fd[i], 0, BPF_TRACE_FENTRY, NULL);
+		if (!ASSERT_GE(link_fd[i], 0, "bpf_link_create"))
+			goto out;
+	}
+
+	err = bpf_prog_test_run_opts(prog_fd[0], &test_opts);
+	ASSERT_OK(err, "running test");
+
+out:
+	if (vmlinux_btf)
+		btf__free(vmlinux_btf);
+	if (mod_btf)
+		btf__free(mod_btf);
+	for (i = 0; i < 2; i++) {
+		if (btf_fd[i])
+			close(btf_fd[i]);
+		if (prog_fd[i])
+			close(prog_fd[i]);
+		if (link_fd[i])
+			close(link_fd[i]);
+	}
+}
-- 
2.38.1

