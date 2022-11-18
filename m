Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866E462F989
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 16:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241949AbiKRPk7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 10:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242238AbiKRPk6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 10:40:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2DE748C6
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 07:40:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D5AFB8244F
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 15:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C91C433D6;
        Fri, 18 Nov 2022 15:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668786054;
        bh=7wovpbCN6iri8bpiqnWAMrbiiRxRb+uXy0ogxgWGH3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ugMQiZq6pct+gQVWy25cA7rO6dTr+Z3wr9TGPjBWewj4MFbBSUJuG3Z4tBlOZ/VTd
         CRTm7L4BfQ7X6XJSAvF+WCsR8E5bWAmNsGga50IoPJpkdeCvw1gf0l9gbV3XCA/w0r
         odKMG5jbPSCXPndfjaFQ6ZPUoa/mBRRFoOu6F/hiAewGeQ3fVRlQA+F0LPAyhkVQ7g
         7z6+zmyi7ztEowuKk7wvF3W673NzhkBDVGU3w0wHZ3OU/BaUOUwN+/3y7t4jjucVa0
         5Ahli7hoicAx/E3BqHKJLRcfmCKUEPn/V6EcD8EWbqKJBwlNpiKcHvHZBSVAN5noER
         ld2x3Wa2z3/Lg==
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
Subject: [PATCHv3 bpf-next 2/2] selftests/bpf: Add bpf_vma_build_id_parse kfunc test
Date:   Fri, 18 Nov 2022 16:40:28 +0100
Message-Id: <20221118154028.251399-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118154028.251399-1-jolsa@kernel.org>
References: <20221118154028.251399-1-jolsa@kernel.org>
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

Adding test for bpf_vma_build_id_parse kfunc.

On bpf side the test finds the vma of the test_progs text through the
test function pointer and reads its build id with the new kfunc.

On user side the test uses readelf to get test_progs build id and
compares it with the one from bpf side.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/bpf_vma_build_id_parse.c   | 88 +++++++++++++++++++
 .../bpf/progs/bpf_vma_build_id_parse.c        | 40 +++++++++
 2 files changed, 128 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_vma_build_id_parse.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_vma_build_id_parse.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_vma_build_id_parse.c b/tools/testing/selftests/bpf/prog_tests/bpf_vma_build_id_parse.c
new file mode 100644
index 000000000000..83030a3b2c42
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_vma_build_id_parse.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include "bpf_vma_build_id_parse.skel.h"
+
+#define BUILDID_STR_SIZE (BPF_BUILD_ID_SIZE*2 + 1)
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
+
+	err = system(buf);
+	if (err)
+		goto out;
+
+	f = fopen(tmp, "r");
+	if (f) {
+		if (fscanf(f, "%ms$*\n", build_id) != 1) {
+			*build_id = NULL;
+			err = -1;
+		}
+		fclose(f);
+	}
+
+out:
+	unlink(tmp);
+	return err;
+}
+
+void test_bpf_vma_build_id_parse(void)
+{
+	char bpf_build_id[BUILDID_STR_SIZE] = {}, *build_id;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct bpf_vma_build_id_parse *skel;
+	int i, err, prog_fd;
+
+	skel = bpf_vma_build_id_parse__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_vma_build_id_parse__open_and_load"))
+		return;
+
+	skel->bss->target_pid = getpid();
+	skel->bss->addr = (__u64)(uintptr_t)test_bpf_vma_build_id_parse;
+
+	err = bpf_vma_build_id_parse__attach(skel);
+	if (!ASSERT_OK(err, "bpf_vma_build_id_parse__attach"))
+		goto out;
+
+	prog_fd = bpf_program__fd(skel->progs.test1);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run_err");
+	ASSERT_EQ(topts.retval, 0, "test_run_retval");
+
+	ASSERT_EQ(skel->data->ret, 0, "ret");
+
+	ASSERT_GT(skel->data->size_pass, 0, "size_pass");
+	ASSERT_EQ(skel->data->size_fail, -EINVAL, "size_fail");
+
+	/* Read build id via readelf to compare with build_id. */
+	if (!ASSERT_OK(read_buildid(&build_id), "read_buildid"))
+		goto out;
+
+	ASSERT_EQ(skel->data->size_pass, strlen(build_id)/2, "build_id_size");
+
+	/* Convert bpf build id to string, so we can compare it later. */
+	for (i = 0; i < skel->data->size_pass; i++) {
+		sprintf(bpf_build_id + i*2, "%02x",
+			(unsigned char) skel->bss->build_id[i]);
+	}
+	ASSERT_STREQ(bpf_build_id, build_id, "build_id_match");
+
+	free(build_id);
+out:
+	bpf_vma_build_id_parse__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_vma_build_id_parse.c b/tools/testing/selftests/bpf/progs/bpf_vma_build_id_parse.c
new file mode 100644
index 000000000000..8937212207db
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_vma_build_id_parse.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define BPF_BUILD_ID_SIZE 20
+
+extern int bpf_vma_build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
+				  size_t build_id__sz) __ksym;
+
+pid_t target_pid = 0;
+__u64 addr = 0;
+
+int ret = -1;
+int size_pass = -1;
+int size_fail = -1;
+
+unsigned char build_id[BPF_BUILD_ID_SIZE];
+
+static long check_vma(struct task_struct *task, struct vm_area_struct *vma,
+		      void *data)
+{
+	size_fail = bpf_vma_build_id_parse(vma, build_id, sizeof(build_id)/2);
+	size_pass = bpf_vma_build_id_parse(vma, build_id, sizeof(build_id));
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
+	ret = bpf_find_vma(task, addr, check_vma, NULL, 0);
+	return 0;
+}
-- 
2.38.1

