Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC7163A983
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 14:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiK1NaP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 08:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiK1NaF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 08:30:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F5B1EADC
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 05:30:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB54BB80D55
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 13:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BA3C433D7;
        Mon, 28 Nov 2022 13:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669642201;
        bh=zV+YRalJGKtT9zjKFQxNaLpehblgjfu6rWjhOYXJIIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d8pUrjl5LzLFXIIcStZbMPiJUjW/xjMjbS7F0Q53vA0/scfCy19HZHCgsqiuNP/UE
         aLVJ2gxqpGChlDgCf1K/WmKJ2QtJcXK8hrLX7411dKOi1P0ZIJmVFurt881TV3sY4H
         3SQARCDpU4kL3DbSwmxxrl+JddGNt3tThJHMT4bvXj4O8S0oyNwSaffH6qVddeNVjh
         09z1bvO0vM3z0Ow2iGa2nG8vyMixRPUT5is0W0KALEVKjYlbAD2BS+lDq/PlQYeRQY
         8Cb0ZhgSXG28PWa/St5TnM7uI3MXqrxNV+FW2yqhju4DLZ2ZlQa423jr7M+jLeubHh
         b0svXw+No5d6Q==
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
Subject: [PATCHv4 bpf-next 3/4] selftests/bpf: Add bpf_vma_build_id_parse find_vma callback test
Date:   Mon, 28 Nov 2022 14:29:14 +0100
Message-Id: <20221128132915.141211-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221128132915.141211-1-jolsa@kernel.org>
References: <20221128132915.141211-1-jolsa@kernel.org>
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

Adding tests for using new bpf_vma_build_id_parse kfunc in find_vma
callback function.

On bpf side the test finds the vma of the test_progs text through the
test function pointer and reads its build id with the new kfunc.

On user side the test uses readelf to get test_progs build id and
compares it with the one from bpf side.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/bpf_vma_build_id_parse.c   | 55 +++++++++++++++++++
 .../bpf/progs/bpf_vma_build_id_parse.c        | 40 ++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.c   | 40 ++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.h   |  1 +
 4 files changed, 136 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_vma_build_id_parse.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_vma_build_id_parse.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_vma_build_id_parse.c b/tools/testing/selftests/bpf/prog_tests/bpf_vma_build_id_parse.c
new file mode 100644
index 000000000000..895a5ba47f47
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_vma_build_id_parse.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include "bpf_vma_build_id_parse.skel.h"
+#include "trace_helpers.h"
+
+#define BUILDID_STR_SIZE (BPF_BUILD_ID_SIZE*2 + 1)
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
+	if (!ASSERT_OK(read_self_buildid(&build_id), "read_buildid"))
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
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 09a16a77bae4..bdd486de17ee 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -9,6 +9,7 @@
 #include <poll.h>
 #include <unistd.h>
 #include <linux/perf_event.h>
+#include <linux/limits.h>
 #include <sys/mman.h>
 #include "trace_helpers.h"
 
@@ -230,3 +231,42 @@ ssize_t get_rel_offset(uintptr_t addr)
 	fclose(f);
 	return -EINVAL;
 }
+
+int read_self_buildid(char **build_id)
+{
+	char path[PATH_MAX], buf[PATH_MAX + 200];
+	char tmp[] = "/tmp/dataXXXXXX";
+	int err, fd;
+	FILE *f;
+
+	fd = mkstemp(tmp);
+	if (fd == -1)
+		return -1;
+	close(fd);
+
+	err = readlink("/proc/self/exe", path, sizeof(path));
+	if (err == -1)
+		goto out;
+	path[err] = 0;
+
+	snprintf(buf, sizeof(buf),
+		"readelf -n %s 2>/dev/null | grep 'Build ID' | awk '{print $3}' > %s",
+		path, tmp);
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
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
index 53efde0e2998..c19bd06231d7 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -23,4 +23,5 @@ void read_trace_pipe(void);
 ssize_t get_uprobe_offset(const void *addr);
 ssize_t get_rel_offset(uintptr_t addr);
 
+int read_self_buildid(char **build_id);
 #endif
-- 
2.38.1

