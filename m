Return-Path: <bpf+bounces-8770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3757789BC4
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 09:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55E51C2090E
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 07:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A314417E4;
	Sun, 27 Aug 2023 07:21:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BAE20EC
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 07:21:19 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0B212A
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 00:21:17 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68c0d262933so1108534b3a.0
        for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 00:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693120877; x=1693725677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuhzP1mvDliga8ZbFq7tNuDQGJoX13wAFAeRiusEr7I=;
        b=SOl9rzX3hguTSxfuEkxfuXzVtNZ5qfD4ojQw7O7tIc1ndHCwJzXzN1T2XQ+ytML/0b
         MEZIW+DY7E8Y7hyI21eH9SNzkdIssGL6M12YDMq2Sh38jPO5YBh40rU9DzZbH0ZxJeEm
         zPJAbJ7xblpXB3fgSUZ61l49B6+dr43mnNzZRa0C+YaCTYzEr11HnaS8qitqPWj/rRgX
         WqE2+CB/EbpZyZl9A/DIIpd7WkclPFyYjRWuTTSWXX+YEmSsiHT2P1vmpXj0PmgYqtbJ
         dxkIELZunwXiauQyfEuraD/tE5y3JExEZ556CWusZ+bKpVsOppUSI55WEN7mJLkyE9yf
         2kaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693120877; x=1693725677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuhzP1mvDliga8ZbFq7tNuDQGJoX13wAFAeRiusEr7I=;
        b=LZ1A97apyivveU+TV4k+jWgPP109Ko9KXpv61IR0isVJibyf96SdKVYnDD0udFEi9X
         v7b8D6d8ZYPAsehelAlhZQgoDAje3FPMo0wMOSVQUk+gECRP6oZyIGVJ0ZUq9bFZdx+6
         v9+AdPwYEiG6Z3i+uuuQzVTGEDggFPt18K/U/j2LXPCU3IqrpgKXNHlHQOZTUx9xyGEA
         aQXgKvWhFsR/0B4aACi2BvYbmFQUJuvXbYIfzPWljROA7TcRX2zE4SPP8l/QwJi5WnKd
         /pM2bJUhcZJc3Srl5U9e6OdlpIBpAigA/IUYCYpPmhtwt0reUA0xCvOCnuvppn4TL19c
         icow==
X-Gm-Message-State: AOJu0YwJrS1rZ6YHlG/nyCKfbDbhfEYKaB7xrLzhG9X/GO8y5F4Rql/n
	BRvaBr0yUej/Rg70x2HI6CgX2PHQBXcF2weSq4E=
X-Google-Smtp-Source: AGHT+IGWV2gD2RUmv9++GcZpjEOn0s1qVF1eTnrQZ8zvHW1Ywv6QKs+mggUI3tHsWbQu7TX5S5PCDg==
X-Received: by 2002:a17:903:1212:b0:1b0:3df7:5992 with SMTP id l18-20020a170903121200b001b03df75992mr21746419plh.32.1693120877251;
        Sun, 27 Aug 2023 00:21:17 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id m3-20020a1709026bc300b001befac3b3cbsm4769723plt.290.2023.08.27.00.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 00:21:17 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RFC PATCH bpf-next 4/4] selftests/bpf: Add tests for open-coded task and css iter
Date: Sun, 27 Aug 2023 15:20:57 +0800
Message-Id: <20230827072057.1591929-5-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230827072057.1591929-1-zhouchuyi@bytedance.com>
References: <20230827072057.1591929-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds three tests to demonstrate these patterns and validating
correctness.

test1: We use bpf_for_each(process, task) to iterate all processed in the
system and search for the current process with a given pid.

test2: We create a cgroup and add the current process to the cgroup. In the
BPF program, we would use bpf_for_each(css_task, task, css) to iterate all
tasks under the cgroup. As expected, we would find the current process.

test3: We create a cgroup tree. In the BPF program, we use
bpf_for_each(css, pos, root) to iterate all descendant under the root with
post order. As expected, we would find all descendant and the last
iterating cgroup is root cgroup.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 .../testing/selftests/bpf/prog_tests/iters.c  | 123 ++++++++++++++++++
 .../testing/selftests/bpf/progs/iters_task.c  |  83 ++++++++++++
 2 files changed, 206 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task.c

diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testing/selftests/bpf/prog_tests/iters.c
index 10804ae5ae97..88fb565a3e97 100644
--- a/tools/testing/selftests/bpf/prog_tests/iters.c
+++ b/tools/testing/selftests/bpf/prog_tests/iters.c
@@ -2,12 +2,14 @@
 /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
 
 #include <test_progs.h>
+#include "cgroup_helpers.h"
 
 #include "iters.skel.h"
 #include "iters_state_safety.skel.h"
 #include "iters_looping.skel.h"
 #include "iters_num.skel.h"
 #include "iters_testmod_seq.skel.h"
+#include "iters_task.skel.h"
 
 static void subtest_num_iters(void)
 {
@@ -90,6 +92,121 @@ static void subtest_testmod_seq_iters(void)
 	iters_testmod_seq__destroy(skel);
 }
 
+static void subtest_process_iters(void)
+{
+	struct iters_task *skel;
+	int err;
+
+	skel = iters_task__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+	bpf_program__set_autoload(skel->progs.iter_task_for_each, true);
+	err = iters_task__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+	skel->bss->target_pid = getpid();
+	err = iters_task__attach(skel);
+	if (!ASSERT_OK(err, "iters_task__attach"))
+		goto cleanup;
+
+	iters_task__detach(skel);
+	ASSERT_EQ(skel->bss->process_cnt, 1, "process_cnt");
+
+cleanup:
+	iters_task__destroy(skel);
+}
+
+static void subtest_css_task_iters(void)
+{
+	struct iters_task *skel;
+	int err, cg_fd, cg_id;
+	const char *cgrp_path = "/cg1";
+
+	err = setup_cgroup_environment();
+	if (!ASSERT_OK(err, "setup_cgroup_environment"))
+		goto cleanup;
+	cg_fd = create_and_get_cgroup(cgrp_path);
+	if (!ASSERT_GE(cg_fd, 0, "cg_create"))
+		goto cleanup;
+	cg_id = get_cgroup_id(cgrp_path);
+	err = join_cgroup(cgrp_path);
+	if (!ASSERT_OK(err, "setup_cgroup_environment"))
+		goto cleanup;
+
+	skel = iters_task__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	bpf_program__set_autoload(skel->progs.iter_css_task_for_each, true);
+	err = iters_task__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	skel->bss->target_pid = getpid();
+	skel->bss->cg_id = cg_id;
+	err = iters_task__attach(skel);
+
+	if (!ASSERT_OK(err, "iters_task__attach"))
+		goto cleanup;
+
+	iters_task__detach(skel);
+	ASSERT_EQ(skel->bss->css_task_cnt, 1, "css_task_cnt");
+
+cleanup:
+	cleanup_cgroup_environment();
+	iters_task__destroy(skel);
+}
+
+static void subtest_css_dec_iters(void)
+{
+	struct iters_task *skel;
+	struct {
+		const char *path;
+		int fd;
+	} cgs[] = {
+		{ "/cg1" },
+		{ "/cg1/cg2" },
+		{ "/cg1/cg2/cg3" },
+		{ "/cg1/cg2/cg3/cg4" },
+	};
+	int err, cg_nr = ARRAY_SIZE(cgs);
+	int i;
+
+	err = setup_cgroup_environment();
+	if (!ASSERT_OK(err, "setup_cgroup_environment"))
+		goto cleanup;
+	for (i = 0; i < cg_nr; i++) {
+		cgs[i].fd = create_and_get_cgroup(cgs[i].path);
+		if (!ASSERT_GE(cgs[i].fd, 0, "cg_create"))
+			goto cleanup;
+	}
+
+	skel = iters_task__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+	bpf_program__set_autoload(skel->progs.iter_css_dec_for_each, true);
+	err = iters_task__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	skel->bss->target_pid = getpid();
+	skel->bss->cg_id = get_cgroup_id(cgs[0].path);
+
+	err = iters_task__attach(skel);
+
+	if (!ASSERT_OK(err, "iters_task__attach"))
+		goto cleanup;
+
+	iters_task__detach(skel);
+	ASSERT_EQ(skel->bss->css_dec_cnt, cg_nr, "post order search dec count");
+	ASSERT_EQ(skel->bss->last_cg_id, get_cgroup_id(cgs[0].path),
+				"post order search last cgroup id");
+
+cleanup:
+	cleanup_cgroup_environment();
+	iters_task__destroy(skel);
+}
+
 void test_iters(void)
 {
 	RUN_TESTS(iters_state_safety);
@@ -103,4 +220,10 @@ void test_iters(void)
 		subtest_num_iters();
 	if (test__start_subtest("testmod_seq"))
 		subtest_testmod_seq_iters();
+	if (test__start_subtest("process"))
+		subtest_process_iters();
+	if (test__start_subtest("css_task"))
+		subtest_css_task_iters();
+	if (test__start_subtest("css_dec"))
+		subtest_css_dec_iters();
 }
diff --git a/tools/testing/selftests/bpf/progs/iters_task.c b/tools/testing/selftests/bpf/progs/iters_task.c
new file mode 100644
index 000000000000..524926b505b0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_task.c
@@ -0,0 +1,83 @@
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+pid_t target_pid = 0;
+int process_cnt = 0;
+int css_task_cnt = 0;
+int css_dec_cnt = 0;
+
+u64 cg_id;
+u64 last_cg_id;
+
+struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
+struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp) __ksym;
+void bpf_cgroup_release(struct cgroup *p) __ksym;
+
+SEC("?tp_btf/sys_enter")
+int BPF_PROG(iter_task_for_each)
+{
+	struct task_struct *task;
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+
+	if (cur_task->pid != target_pid)
+		return 0;
+
+	bpf_for_each(process, task)
+		if (task->pid == target_pid)
+			process_cnt += 1;
+
+	return 0;
+}
+
+SEC("?tp_btf/sys_enter")
+int iter_css_task_for_each(const void *ctx)
+{
+	struct task_struct *task;
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+
+	if (cur_task->pid != target_pid)
+		return 0;
+
+	struct cgroup *cgrp = bpf_cgroup_from_id(cg_id);
+
+	if (cgrp == NULL)
+		return 0;
+	struct cgroup_subsys_state *css = &cgrp->self;
+
+	bpf_for_each(css_task, task, css, 0)
+		if (task->pid == target_pid)
+			css_task_cnt += 1;
+
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
+
+SEC("?tp_btf/sys_enter")
+int iter_css_dec_for_each(const void *ctx)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+	bool is_post_order = true;
+
+	if (cur_task->pid != target_pid)
+		return 0;
+
+	struct cgroup *cgrp = bpf_cgroup_from_id(cg_id);
+
+	if (cgrp == NULL)
+		return 0;
+	struct cgroup_subsys_state *root = &cgrp->self;
+	struct cgroup_subsys_state *pos = NULL;
+
+	bpf_for_each(css, pos, root, is_post_order) {
+		struct cgroup *cur_cgrp = pos->cgroup;
+
+		css_dec_cnt += 1;
+		if (cur_cgrp)
+			last_cg_id = cur_cgrp->kn->id;
+	}
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
-- 
2.20.1


