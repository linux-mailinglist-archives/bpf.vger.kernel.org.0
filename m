Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9680A553BC9
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 22:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354153AbiFUUq6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 16:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353351AbiFUUq6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 16:46:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30E72A26F
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 13:46:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80CFD6185A
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 20:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B7AC341C4;
        Tue, 21 Jun 2022 20:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655844416;
        bh=0LgVkL1ldA/mk8/nk4zJk2Opn3AP379tvwspSLDBYjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T9SHqXsiITJJd/FqE9FcXh0RlIkoyN9oVfMn7gzWRzjOxBYxiieKgRh3WNoz9kUHq
         t20qetBM2X2gi86OAI29MdFuC63Xa1sxumMWzfG5prBk5LhK2aIMj0EqLUe44BJD5A
         KgTkzvz+WcRFsJfk5A4aYuGMfZ9ICz5fxCoLL7Gc9Q7YjY4yyv1vObK/mUOCW/gQA+
         fE2XnTd+376Y2UgCGUTENeb0ga/Fi5dgdUhyKw6/NrgZhok7zudNPf2nVs9i/DV3zx
         1PNOXWcOIRPhSCalBjql53xv0ltu2mtoTANlIr4/+UH8ETAf+zJAeQ1kaMwMFPU04O
         fUNhBPokSmXkg==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH v3 bpf-next 5/5] bpf/selftests: Add a selftest for bpf_getxattr
Date:   Tue, 21 Jun 2022 20:46:42 +0000
Message-Id: <20220621204642.2891979-6-kpsingh@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220621204642.2891979-1-kpsingh@kernel.org>
References: <20220621204642.2891979-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A simple test that adds an xattr on a copied /bin/ls and reads it back
when the copied ls is executed.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/xattr.c  | 58 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/xattr.c     | 37 ++++++++++++
 2 files changed, 95 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/xattr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xattr.c b/tools/testing/selftests/bpf/prog_tests/xattr.c
new file mode 100644
index 000000000000..442b6c1aed0e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xattr.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2022 Google LLC.
+ */
+
+#include <test_progs.h>
+#include <sys/xattr.h>
+#include "xattr.skel.h"
+
+#define XATTR_NAME "security.bpf"
+#define XATTR_VALUE "test_progs"
+
+static unsigned int duration;
+
+void test_xattr(void)
+{
+	struct xattr *skel = NULL;
+	char tmp_dir_path[] = "/tmp/xattrXXXXXX";
+	char tmp_exec_path[64];
+	char cmd[256];
+	int err;
+
+	if (CHECK(!mkdtemp(tmp_dir_path), "mkdtemp",
+		  "unable to create tmpdir: %d\n", errno))
+		goto close_prog;
+
+	snprintf(tmp_exec_path, sizeof(tmp_exec_path), "%s/copy_of_ls",
+		 tmp_dir_path);
+	snprintf(cmd, sizeof(cmd), "cp /bin/ls %s", tmp_exec_path);
+	if (CHECK_FAIL(system(cmd)))
+		goto close_prog_rmdir;
+
+	if (CHECK(setxattr(tmp_exec_path, XATTR_NAME, XATTR_VALUE,
+			   sizeof(XATTR_VALUE), 0),
+		  "setxattr", "unable to setxattr: %d", errno))
+		goto close_prog_rmdir;
+
+	skel = xattr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto close_prog_rmdir;
+
+	err = xattr__attach(skel);
+	if (!ASSERT_OK(err, "xattr__attach failed"))
+		goto close_prog_rmdir;
+
+	snprintf(cmd, sizeof(cmd), "%s -l", tmp_exec_path);
+	if (CHECK_FAIL(system(cmd)))
+		goto close_prog_rmdir;
+
+	ASSERT_EQ(skel->bss->result, 1, "xattr result");
+
+close_prog_rmdir:
+	snprintf(cmd, sizeof(cmd), "rm -rf %s", tmp_dir_path);
+	system(cmd);
+close_prog:
+	xattr__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/xattr.c b/tools/testing/selftests/bpf/progs/xattr.c
new file mode 100644
index 000000000000..ccc078fb8ebd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/xattr.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2022 Google LLC.
+ */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define XATTR_NAME "security.bpf"
+#define XATTR_VALUE "test_progs"
+
+__u64 result = 0;
+
+extern ssize_t bpf_getxattr(struct dentry *dentry, struct inode *inode,
+			    const char *name, void *value, int size) __ksym;
+
+SEC("lsm.s/bprm_committed_creds")
+void BPF_PROG(bprm_cc, struct linux_binprm *bprm)
+{
+	struct task_struct *current = bpf_get_current_task_btf();
+	char dir_xattr_value[64] = {0};
+	int xattr_sz = 0;
+
+	xattr_sz = bpf_getxattr(bprm->file->f_path.dentry,
+				bprm->file->f_path.dentry->d_inode, XATTR_NAME,
+				dir_xattr_value, 64);
+
+	if (xattr_sz <= 0)
+		return;
+
+	if (!bpf_strncmp(dir_xattr_value, sizeof(XATTR_VALUE), XATTR_VALUE))
+		result = 1;
+}
-- 
2.37.0.rc0.104.g0611611a94-goog

