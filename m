Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B778621F25
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 23:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiKHWW7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 17:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiKHWWB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 17:22:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACE664A11
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 14:21:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABDF1617A8
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 22:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7CCC433C1;
        Tue,  8 Nov 2022 22:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667946064;
        bh=qOaGh6hOF/6MVI+s42ftP3+7M7eAFu77s1gXQKVKFjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d9KXRK2qsK3coG3YqD+spdfYzGy7pmP5Fv9cM+ao9bISy82bbIl843eF5/Nfif97t
         YvzRS+jq8Kl4jQ6B8snv0EIkF/K2FAB8ucuQjMKk5SBrBionOlmp7dH8aM8czZQgcO
         iE9YWAL/Len9iHOsU2Bw58Rgpg+glINLNBqYm1Zi/M8eYRA/Eqwwr+vEFaalfaPR6q
         YH+T2adE/Qpi2Ki00/7/Yb10GwDi6ZIhOUGHr3d1MlZc1QYQr9MOZKhdcdILGbEphG
         vr2Re32rhP2lwX11Wl8H3m8Vyr7Shvbm8fxX+diTVby+hDIn2lVuVyrfnD9ApC3W6z
         yicx20YioW+mQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add build_id_parse kfunc test
Date:   Tue,  8 Nov 2022 23:20:27 +0100
Message-Id: <20221108222027.3409437-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221108222027.3409437-1-jolsa@kernel.org>
References: <20221108222027.3409437-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding test for build_id_parse kfunc.

On bpf side it finds the vma of the test_progs text through
the test function pointer and reads its build id. On user
side we use readelf to get test_progs build id and compare
it with the one from bpf side.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/vma_build_id_parse.c       | 84 +++++++++++++++++++
 .../selftests/bpf/progs/vma_build_id_parse.c  | 34 ++++++++
 2 files changed, 118 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/vma_build_id_parse.c
 create mode 100644 tools/testing/selftests/bpf/progs/vma_build_id_parse.c

diff --git a/tools/testing/selftests/bpf/prog_tests/vma_build_id_parse.c b/tools/testing/selftests/bpf/prog_tests/vma_build_id_parse.c
new file mode 100644
index 000000000000..21c6f7771251
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/vma_build_id_parse.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include "vma_build_id_parse.skel.h"
+
+static int read_buildid(char **build_id)
+{
+	char tmp[] = "/tmp/dataXXXXXX";
+	char buf[200];
+	int err, fd;
+	FILE *f;
+
+	fd = mkstemp(tmp);
+	if (fd == -1)
+		return -1;
+	close(fd);
+
+	snprintf(buf, sizeof(buf),
+		"readelf -n ./test_progs 2>/dev/null | grep 'Build ID' | awk '{print $3}' > %s",
+		tmp);
+	err = system(buf);
+	if (!ASSERT_OK(err, "system"))
+		goto out;
+
+	f = fopen(tmp, "r");
+	if (!ASSERT_OK_PTR(f, "fopen")) {
+		err = -1;
+		goto out;
+	}
+	if (fscanf(f, "%ms$*\n", build_id) != 1) {
+		*build_id = NULL;
+		err = -1;
+	}
+	fclose(f);
+out:
+	unlink(tmp);
+	return err;
+}
+
+void test_vma_build_id_parse(void)
+{
+	char bpf_build_id[BPF_BUILD_ID_SIZE*2 + 1] = {}, *build_id;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct vma_build_id_parse *skel;
+	int i, err, prog_fd, size;
+
+	skel = vma_build_id_parse__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "vma_build_id_parse__open_and_load"))
+		return;
+
+	skel->bss->target_pid = getpid();
+	skel->bss->addr = (__u64)(uintptr_t)test_vma_build_id_parse;
+
+	err = vma_build_id_parse__attach(skel);
+	if (!ASSERT_OK(err, "vma_build_id_parse__attach"))
+		goto out;
+
+	prog_fd = bpf_program__fd(skel->progs.test1);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	ASSERT_EQ(skel->data->find_addr_ret, 0, "find_addr_ret");
+	ASSERT_GT(skel->data->vma_build_id_parse_ret, 0, "vma_build_id_parse_ret");
+
+	if (!ASSERT_OK(read_buildid(&build_id), "read_buildid"))
+		goto out;
+
+	size = skel->data->vma_build_id_parse_ret;
+	ASSERT_EQ(size, strlen(build_id)/2, "build_id_size");
+
+	/* Convert bpf build id to string, so we can compare it. */
+	for (i = 0; i < size; i++) {
+		sprintf(bpf_build_id + i*2, "%02x",
+			(unsigned char) skel->bss->build_id[i]);
+	}
+	ASSERT_STREQ(bpf_build_id, build_id, "build_ids_match");
+
+	free(build_id);
+out:
+	vma_build_id_parse__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/vma_build_id_parse.c b/tools/testing/selftests/bpf/progs/vma_build_id_parse.c
new file mode 100644
index 000000000000..bc5bc9e1808c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/vma_build_id_parse.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define BPF_BUILD_ID_SIZE 20
+
+__u64 addr = 0;
+pid_t target_pid = 0;
+int find_addr_ret = -1;
+int vma_build_id_parse_ret = -1;
+
+unsigned char build_id[BPF_BUILD_ID_SIZE];
+
+static long check_vma(struct task_struct *task, struct vm_area_struct *vma,
+		      void *data)
+{
+	vma_build_id_parse_ret = bpf_vma_build_id_parse(vma, (char *) build_id);
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test1, int a)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+
+	if (task->pid != target_pid)
+		return 0;
+
+	find_addr_ret = bpf_find_vma(task, addr, check_vma, NULL, 0);
+	return 0;
+}
-- 
2.38.1

