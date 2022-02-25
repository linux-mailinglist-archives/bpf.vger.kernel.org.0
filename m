Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527F64C5223
	for <lists+bpf@lfdr.de>; Sat, 26 Feb 2022 00:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239587AbiBYXo3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Feb 2022 18:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239510AbiBYXo2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Feb 2022 18:44:28 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05FC189A95
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 15:43:51 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d07ae11467so46378807b3.12
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 15:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CQ83ADA826CcNYM4PsEmnTeYIiXeHVnMOlfVD0fM6L8=;
        b=oSWxFXNgsoQGu7aE46foiUXppB7TXXZzWVMgqHDgDZ7rKr3uOpTNXNAp6WU4aMzbTM
         31r1/g51RRVW7n+rDBe8ChRuToecXHCIjVmuAMDoFh7tzDepFlrYDXHAVIfoH+UzjssI
         FxN0YEzmQ5hcJl+8r+Dq8Q4JSBnPFhOsbxPeI9VPwpCuxXYW0aeE6bhz0o9Cgimyt5am
         32FluCPLSqEGXiO1PqKHp8jhntngq1gSXfv1ScMWOG9wlcaYkJ9TKysC/cW4+HH5QWqq
         kncug2mNPqW/21Ma3WpTcZELZ2YuScl1Kh1dgH/9/bI3Ydnk6yR1LLkeBIgM+9LzNAho
         b9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CQ83ADA826CcNYM4PsEmnTeYIiXeHVnMOlfVD0fM6L8=;
        b=yhfiyfyw+lmVFdwziJw0dMtE0fRZ9hBr+YiC2SkLo/nI3orFVk2JYFrM8VlDmjao/S
         xEXMHYk5Z2xRjnrKiZLwEKz9pdbzikPyHx0fb9PWaOwbcWvJK2C5LzwnPk7gz3jPyXuf
         IeqNvW95S78/7//jI61ziu2MWhqa1x+cG8Nf2joHWzeRRz5Zz9y7rs9eU75ZE4z8K2b8
         P8Na7mVJZ+riKh6po+b1PuU3RMJ1iM/hrg8hg2mBhLrzh8EQoa+NYWgIKuvmtVAz9muA
         nE8ybNhQ4UBxYIxb7yNfwnC64S9U05Mt3CNABfvNctgybW/NOhXt3LG4ifw+MJ6sSMBx
         nyLg==
X-Gm-Message-State: AOAM532ZKYx9kKqssrlTIxUtteG2wY/vfQQkq6d/BrYNAznaK78xKt0P
        b+1UeiVXRU9N0A1LjWKMtgnEFulsxUs=
X-Google-Smtp-Source: ABdhPJwMhAIVAKEuRaaDmgn4bLiE++XUv4sp87DRSHk0UYkM2EhEzAHSjiM6bmZERZ0vbVtNhzllW6aTM/M=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:378d:645d:49ad:4f8b])
 (user=haoluo job=sendgmr) by 2002:a0d:d697:0:b0:2d4:2ff7:5c5c with SMTP id
 y145-20020a0dd697000000b002d42ff75c5cmr9978773ywd.495.1645832630812; Fri, 25
 Feb 2022 15:43:50 -0800 (PST)
Date:   Fri, 25 Feb 2022 15:43:33 -0800
In-Reply-To: <20220225234339.2386398-1-haoluo@google.com>
Message-Id: <20220225234339.2386398-4-haoluo@google.com>
Mime-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH bpf-next v1 3/9] selftests/bpf: tests mkdir, rmdir, unlink and
 pin in syscall
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a subtest in syscall to test bpf_mkdir(), bpf_rmdir(),
bpf_unlink() and object pinning in syscall prog.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 .../selftests/bpf/prog_tests/syscall.c        | 67 +++++++++++++++++-
 .../testing/selftests/bpf/progs/syscall_fs.c  | 69 +++++++++++++++++++
 2 files changed, 135 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/syscall_fs.c

diff --git a/tools/testing/selftests/bpf/prog_tests/syscall.c b/tools/testing/selftests/bpf/prog_tests/syscall.c
index f4d40001155a..782b5fe73096 100644
--- a/tools/testing/selftests/bpf/prog_tests/syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/syscall.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Facebook */
+#include <sys/stat.h>
 #include <test_progs.h>
 #include "syscall.skel.h"
+#include "syscall_fs.skel.h"
 
 struct args {
 	__u64 log_buf;
@@ -12,7 +14,7 @@ struct args {
 	int btf_fd;
 };
 
-void test_syscall(void)
+static void test_syscall_basic(void)
 {
 	static char verifier_log[8192];
 	struct args ctx = {
@@ -53,3 +55,66 @@ void test_syscall(void)
 	if (ctx.btf_fd > 0)
 		close(ctx.btf_fd);
 }
+
+static void test_syscall_fs(void)
+{
+	char tmpl[] = "/sys/fs/bpf/syscall_XXXXXX";
+	struct stat statbuf = {};
+	static char verifier_log[8192];
+	struct args ctx = {
+		.log_buf = (uintptr_t) verifier_log,
+		.log_size = sizeof(verifier_log),
+		.prog_fd = 0,
+	};
+	LIBBPF_OPTS(bpf_test_run_opts, tattr,
+		.ctx_in = &ctx,
+		.ctx_size_in = sizeof(ctx),
+	);
+	struct syscall_fs *skel = NULL;
+	int err, mkdir_fd, rmdir_fd;
+	char *root, *dir, *path;
+
+	/* prepares test directories */
+	system("mount -t bpf bpffs /sys/fs/bpf");
+	root = mkdtemp(tmpl);
+	chmod(root, 0755);
+
+	/* loads prog */
+	skel = syscall_fs__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	dir = skel->bss->dirname;
+	snprintf(dir, sizeof(skel->bss->dirname), "%s/test", root);
+	path = skel->bss->pathname;
+	snprintf(path, sizeof(skel->bss->pathname), "%s/prog", dir);
+
+	/* tests mkdir */
+	mkdir_fd = bpf_program__fd(skel->progs.mkdir_prog);
+	err = bpf_prog_test_run_opts(mkdir_fd, &tattr);
+	ASSERT_EQ(err, 0, "mkdir_err");
+	ASSERT_EQ(tattr.retval, 0, "mkdir_retval");
+	ASSERT_OK(stat(dir, &statbuf), "mkdir_success");
+	ASSERT_OK(stat(path, &statbuf), "pin_success");
+
+	/* tests rmdir */
+	rmdir_fd = bpf_program__fd(skel->progs.rmdir_prog);
+	err = bpf_prog_test_run_opts(rmdir_fd, &tattr);
+	ASSERT_EQ(err, 0, "rmdir_err");
+	ASSERT_EQ(tattr.retval, 0, "rmdir_retval");
+	ASSERT_ERR(stat(path, &statbuf), "unlink_success");
+	ASSERT_ERR(stat(dir, &statbuf), "rmdir_success");
+
+cleanup:
+	syscall_fs__destroy(skel);
+	if (ctx.prog_fd > 0)
+		close(ctx.prog_fd);
+	rmdir(root);
+}
+
+void test_syscall(void) {
+	if (test__start_subtest("basic"))
+		test_syscall_basic();
+	if (test__start_subtest("filesystem"))
+		test_syscall_fs();
+}
diff --git a/tools/testing/selftests/bpf/progs/syscall_fs.c b/tools/testing/selftests/bpf/progs/syscall_fs.c
new file mode 100644
index 000000000000..9418d1364c09
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/syscall_fs.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Google */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <../../../tools/include/linux/filter.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct args {
+	__u64 log_buf;
+	__u32 log_size;
+	int max_entries;
+	int map_fd;
+	int prog_fd;
+	int btf_fd;
+};
+
+char dirname[64];
+char pathname[64];
+
+SEC("syscall")
+int mkdir_prog(struct args *ctx)
+{
+	static char license[] = "GPL";
+	static struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	static union bpf_attr load_attr = {
+		.prog_type = BPF_PROG_TYPE_XDP,
+		.insn_cnt = sizeof(insns) / sizeof(insns[0]),
+	};
+	static union bpf_attr pin_attr = {
+		.file_flags = 0,
+	};
+	int ret;
+
+	ret = bpf_mkdir(dirname, sizeof(dirname), 0644);
+	if (ret)
+		return ret;
+
+	load_attr.license = (long) license;
+	load_attr.insns = (long) insns;
+	load_attr.log_buf = ctx->log_buf;
+	load_attr.log_size = ctx->log_size;
+	load_attr.log_level = 1;
+	ret = bpf_sys_bpf(BPF_PROG_LOAD, &load_attr, sizeof(load_attr));
+	if (ret < 0)
+		return ret;
+	else if (ret == 0)
+		return -1;
+	ctx->prog_fd = ret;
+
+	pin_attr.pathname = (__u64)pathname;
+	pin_attr.bpf_fd = ret;
+	return bpf_sys_bpf(BPF_OBJ_PIN, &pin_attr, sizeof(pin_attr));
+}
+
+SEC("syscall")
+int rmdir_prog(struct args *ctx)
+{
+	int ret;
+
+	ret = bpf_unlink(pathname, sizeof(pathname));
+	if (ret)
+		return ret;
+
+	return bpf_rmdir(dirname, sizeof(dirname));
+}
-- 
2.35.1.574.g5d30c73bfb-goog

