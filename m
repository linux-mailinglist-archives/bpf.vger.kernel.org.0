Return-Path: <bpf+bounces-5069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAA9754E93
	for <lists+bpf@lfdr.de>; Sun, 16 Jul 2023 14:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C423E2814B5
	for <lists+bpf@lfdr.de>; Sun, 16 Jul 2023 12:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B268836;
	Sun, 16 Jul 2023 12:11:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE17882F
	for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 12:11:04 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59B710E
	for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 05:11:02 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6686a05bc66so2547335b3a.1
        for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 05:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689509462; x=1692101462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qjSmlCfCw3325MFOhBSaBqZhjziPOzsAFf2ePB7sLs=;
        b=jTZ5PrUIOwShM8LlFzVtfBj6YV4YtGn2/tWePw45cVnomTPYaG++BeoAfnW4olD39s
         jOCXhduXd0KTo5Pq7k5q4ykA6+C4QK4lT9WK6qei+B0FnsoezXHcC85CHz+35pbCXfYN
         KlJT27SoA4GNUDu/V6nMc44Y5CTZETUfecdSAY4NlBUEKyQAk+a+6EuLDGBrcdzLJgUZ
         SKko4+S2Yh+X1g97yuhwCDkLgYdUTsryuDeRRceSzIajTFHs8hzKVvEaz2O+gC3cGV3x
         wA3e3zHmHc+qsJ/UxOnXK4Iz/qfaigDFg/950PpscHJJ9CrqilLib0JtBuVo41Jo4gjE
         SLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689509462; x=1692101462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qjSmlCfCw3325MFOhBSaBqZhjziPOzsAFf2ePB7sLs=;
        b=jOS5LLo3/yDueSsneIArKjLLq0VMlBHu7/JvoymGUUQjUgwiTG6tQJPccPhCw079MV
         9w/JSM4dLiH3khVn47eRgw/AninFLGQJZi3ePqFP3IVgfE9AJTASKpuiGzzdhGrHtJgv
         WYuRGDBQosmeshHYpuxf2EVZ2lgwaeV8sIgUptXGRmWXV7mOcUZp1F1HXSXaWbheGqSp
         UVm+5KvmFqcDhCfpI/SBEz/2pZg5qqRT/qtAGKZ/4D/suTHMfYZDXY+tw4fyoguY4KjI
         zCtWnC9vHxHo5T9QmZCTcY0JGf8SABKtJWi/mlEk9vWSeM3udgN9CGx2eWX9wpWxXWjv
         m5yw==
X-Gm-Message-State: ABy/qLbY69gzRD7ENI5nQJvskK+vKgHekuP0m+aKkOItTZn2Ut0b403p
	BOu+mIs75ta6J8s/Y2VxXKE=
X-Google-Smtp-Source: APBJJlFKHfFdF/RS2p9h3seDSo7l+C9jzJsOYOWnkMDydMK5IM61NxaIt1Zo6hxTfCTfcJ/CJ7lASg==
X-Received: by 2002:a05:6a21:6da3:b0:121:bda6:2f85 with SMTP id wl35-20020a056a216da300b00121bda62f85mr10617636pzb.30.1689509462194;
        Sun, 16 Jul 2023 05:11:02 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:697:5400:4ff:fe82:495b])
        by smtp.gmail.com with ESMTPSA id u8-20020a62ed08000000b0062cf75a9e6bsm10128730pfh.131.2023.07.16.05.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 05:11:01 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 4/4] selftests/bpf: Add selftest for cgroup_task iter
Date: Sun, 16 Jul 2023 12:10:46 +0000
Message-Id: <20230716121046.17110-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230716121046.17110-1-laoar.shao@gmail.com>
References: <20230716121046.17110-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add selftests for the newly introduced cgroup_task iter.

The result:
  #42/1    cgroup_task_iter/cgroup_task_iter__invalid_order:OK
  #42/2    cgroup_task_iter/cgroup_task_iter__no_task:OK
  #42/3    cgroup_task_iter/cgroup_task_iter__task_pid:OK
  #42/4    cgroup_task_iter/cgroup_task_iter__task_cnt:OK
  #42      cgroup_task_iter:OK
  Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../bpf/prog_tests/cgroup_task_iter.c         | 197 ++++++++++++++++++
 .../selftests/bpf/progs/cgroup_task_iter.c    |  39 ++++
 2 files changed, 236 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_task_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_task_iter.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_task_iter.c b/tools/testing/selftests/bpf/prog_tests/cgroup_task_iter.c
new file mode 100644
index 000000000000..9123577524b5
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_task_iter.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include <signal.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <test_progs.h>
+#include <bpf/libbpf.h>
+#include <bpf/btf.h>
+#include "cgroup_helpers.h"
+#include "cgroup_task_iter.skel.h"
+
+#define PID_CNT (2)
+static char expected_output[128];
+
+static void read_from_cgroup_iter(struct bpf_program *prog, int cgroup_fd,
+				  int order, const char *testname)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo;
+	struct bpf_link *link;
+	int len, iter_fd;
+	static char buf[128];
+	size_t left;
+	char *p;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.cgroup.cgroup_fd = cgroup_fd;
+	linfo.cgroup.order = order;
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+
+	link = bpf_program__attach_iter(prog, &opts);
+	if (!ASSERT_OK_PTR(link, "attach_iter"))
+		return;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (iter_fd < 0)
+		goto free_link;
+
+	memset(buf, 0, sizeof(buf));
+	left = ARRAY_SIZE(buf);
+	p = buf;
+	while ((len = read(iter_fd, p, left)) > 0) {
+		p += len;
+		left -= len;
+	}
+
+	ASSERT_STREQ(buf, expected_output, testname);
+
+	/* read() after iter finishes should be ok. */
+	if (len == 0)
+		ASSERT_OK(read(iter_fd, buf, sizeof(buf)), "second_read");
+
+	close(iter_fd);
+free_link:
+	bpf_link__destroy(link);
+}
+
+/* Invalid walk order */
+static void test_invalid_order(struct cgroup_task_iter *skel, int fd)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	enum bpf_cgroup_iter_order order;
+	union bpf_iter_link_info linfo;
+	struct bpf_link *link;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.cgroup.cgroup_fd = fd;
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+
+	/* Only BPF_CGROUP_ITER_SELF_ONLY is supported */
+	for (order = 0; order <= BPF_CGROUP_ITER_ANCESTORS_UP; order++) {
+		if (order == BPF_CGROUP_ITER_SELF_ONLY)
+			continue;
+		linfo.cgroup.order = order;
+		link = bpf_program__attach_iter(skel->progs.cgroup_task_cnt, &opts);
+		ASSERT_ERR_PTR(link, "attach_task_iter");
+		ASSERT_EQ(errno, EINVAL, "error code on invalid walk order");
+	}
+}
+
+/*  Iterate a cgroup withouth any task */
+static void test_walk_no_task(struct cgroup_task_iter *skel, int fd)
+{
+	snprintf(expected_output, sizeof(expected_output), "nr_total 0\n");
+
+	read_from_cgroup_iter(skel->progs.cgroup_task_cnt, fd,
+			      BPF_CGROUP_ITER_SELF_ONLY, "self_only");
+}
+
+/* The forked child process do nothing. */
+static void child_sleep(void)
+{
+	while (1)
+		sleep(1);
+}
+
+/* Get task pid under a cgroup */
+static void test_walk_task_pid(struct cgroup_task_iter *skel, int fd)
+{
+	int pid, status, err;
+	char pid_str[16];
+
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork_task"))
+		return;
+	if (pid) {
+		snprintf(pid_str, sizeof(pid_str), "%u", pid);
+		err = write_cgroup_file("cgroup_task_iter", "cgroup.procs", pid_str);
+		if (!ASSERT_EQ(err, 0, "write cgrp file"))
+			goto out;
+		snprintf(expected_output, sizeof(expected_output), "pid %u\n", pid);
+		read_from_cgroup_iter(skel->progs.cgroup_task_pid, fd,
+				      BPF_CGROUP_ITER_SELF_ONLY, "self_only");
+out:
+		kill(pid, SIGKILL);
+		waitpid(pid, &status, 0);
+	} else {
+		child_sleep();
+	}
+}
+
+/* Get task count under a cgroup */
+static void test_walk_task_cnt(struct cgroup_task_iter *skel, int fd)
+{
+	int pids[PID_CNT], pid, status, err, i;
+	char pid_str[16];
+
+	for (i = 0; i < PID_CNT; i++)
+		pids[i] = 0;
+
+	for (i = 0; i < PID_CNT; i++) {
+		pid = fork();
+		if (!ASSERT_GE(pid, 0, "fork_task"))
+			goto out;
+		if (pid) {
+			pids[i] = pid;
+			snprintf(pid_str, sizeof(pid_str), "%u", pid);
+			err = write_cgroup_file("cgroup_task_iter", "cgroup.procs", pid_str);
+			if (!ASSERT_EQ(err, 0, "write cgrp file"))
+				goto out;
+		} else {
+			child_sleep();
+		}
+	}
+
+	snprintf(expected_output, sizeof(expected_output), "nr_total %u\n", PID_CNT);
+	read_from_cgroup_iter(skel->progs.cgroup_task_cnt, fd,
+			      BPF_CGROUP_ITER_SELF_ONLY, "self_only");
+
+out:
+	for (i = 0; i < PID_CNT; i++) {
+		if (!pids[i])
+			continue;
+		kill(pids[i], SIGKILL);
+		waitpid(pids[i], &status, 0);
+	}
+}
+
+void test_cgroup_task_iter(void)
+{
+	struct cgroup_task_iter *skel = NULL;
+	int cgrp_fd;
+
+	if (setup_cgroup_environment())
+		return;
+
+	cgrp_fd = create_and_get_cgroup("cgroup_task_iter");
+	if (!ASSERT_GE(cgrp_fd, 0, "create cgrp"))
+		goto cleanup_cgrp_env;
+
+	skel = cgroup_task_iter__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "cgroup_task_iter__open_and_load"))
+		goto out;
+
+	if (test__start_subtest("cgroup_task_iter__invalid_order"))
+		test_invalid_order(skel, cgrp_fd);
+	if (test__start_subtest("cgroup_task_iter__no_task"))
+		test_walk_no_task(skel, cgrp_fd);
+	if (test__start_subtest("cgroup_task_iter__task_pid"))
+		test_walk_task_pid(skel, cgrp_fd);
+	if (test__start_subtest("cgroup_task_iter__task_cnt"))
+		test_walk_task_cnt(skel, cgrp_fd);
+
+out:
+	cgroup_task_iter__destroy(skel);
+	close(cgrp_fd);
+	remove_cgroup("cgroup_task_iter");
+cleanup_cgrp_env:
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/progs/cgroup_task_iter.c b/tools/testing/selftests/bpf/progs/cgroup_task_iter.c
new file mode 100644
index 000000000000..b9a6d9d29d58
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_task_iter.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include "bpf_iter.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("iter/cgroup_task")
+int cgroup_task_cnt(struct bpf_iter__cgroup_task *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
+	struct task_struct *task = ctx->task;
+	static __u32 nr_total;
+
+	if (!task) {
+		BPF_SEQ_PRINTF(seq, "nr_total %u\n", nr_total);
+		return 0;
+	}
+
+	if (ctx->meta->seq_num == 0)
+		nr_total = 0;
+	nr_total++;
+	return 0;
+}
+
+SEC("iter/cgroup_task")
+int cgroup_task_pid(struct bpf_iter__cgroup_task *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
+	struct task_struct *task = ctx->task;
+
+	if (!task)
+		return 0;
+
+	BPF_SEQ_PRINTF(seq, "pid %u\n", task->pid);
+	return 0;
+}
-- 
2.39.3


