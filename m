Return-Path: <bpf+bounces-6979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2AD76FD86
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 11:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43261C217B5
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 09:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E68AD2D;
	Fri,  4 Aug 2023 09:38:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEDAAD29
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 09:38:29 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2DE30EB
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 02:38:28 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686ba29ccb1so1306452b3a.1
        for <bpf@vger.kernel.org>; Fri, 04 Aug 2023 02:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691141908; x=1691746708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01G/dGmCoWPYOyR3VsPv/eL5+i89PsgHn5Vivri25As=;
        b=if8fIwb8lSueExAsbM1/AY31VsruqCA6SyziSadQfaBWq7gobGORNAvSo/zEC9G/B/
         kx7iEKa2pPfVyH5IjW7i2e+sbal6F4+sIDqsBQ+zlCKBbhEJ9uh377bznGNXWviF0+tH
         2kGckdyM1I5UV/+SApN/JG7mlMsv3FAcAid7Zt0pWw0ANaqIZDleN+JBQoyYev9okSe+
         B68RzPb+ONsCtSqdCmgGDR//GVLTDlcw9xWlSLtTBW3hpgCXHXg+UvcPgAmhWfuA+Lmz
         X3+OukpfFFHT+4dWzM5c7Cc0Fm8HVIrE+M3PBAl6+wgMKQgTinPSh0Egt+VYrxtTQAxi
         ZxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691141908; x=1691746708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01G/dGmCoWPYOyR3VsPv/eL5+i89PsgHn5Vivri25As=;
        b=DfbyevAxuW8euX8rT3MJd02oUPAzHmdzzCAUxvVE7BsdObAIkIleXQN1much/kPMae
         Ys5+H4tWl9dG8CKqTQ/WE1CVaDQhnUsQeCj+SlFqDQVx3zUStG3B80jLryQwEc5APSDa
         pjj4ctDWWhZotyqWH5urlMJFvStM96RLS4qbtqXUpvpwZpHtaJxefu+96wWfkluJW9C8
         cvXMwn7U/IZjwPkkk3G5Ww39g5PH81/3XVycSE3gT39dpzU2xBMqCAkRzqhRXM8kJgyB
         1WBUUfn95P4r61kLXyYSjlFoxMfbkwUdd+ayca+702rSW9wykCHWSGNBkCIc+2s/efdR
         SYeA==
X-Gm-Message-State: AOJu0YxhODq0+/GtjEZcx8rGVIAYfH47ItcJt0xKio6BMQcuH0vtQDVH
	io9UnPte1IaveqYNPuyhtYimsA==
X-Google-Smtp-Source: AGHT+IFjeFRo03zgYga5XtByDq/AZ59O6vv/ZtAYjs3lW/GmRpRrS/F+pY5M7Plb4ZjvmaErR7eQ8A==
X-Received: by 2002:a05:6a20:3d84:b0:137:c971:6a0c with SMTP id s4-20020a056a203d8400b00137c9716a0cmr1405040pzi.31.1691141907829;
        Fri, 04 Aug 2023 02:38:27 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.142])
        by smtp.gmail.com with ESMTPSA id c23-20020aa78817000000b00687933946ddsm1214837pfo.23.2023.08.04.02.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 02:38:27 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	muchun.song@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wuyun.abel@bytedance.com,
	robin.lu@bytedance.com,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RFC PATCH 2/2] bpf: Add OOM policy test
Date: Fri,  4 Aug 2023 17:38:04 +0800
Message-Id: <20230804093804.47039-3-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230804093804.47039-1-zhouchuyi@bytedance.com>
References: <20230804093804.47039-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds a test which implements a priority-based policy through
bpf_select_task.

The BPF program, oom_policy.c, compares the cgroup priority of two tasks
and select the lower one. The userspace program test_oom_policy.c
maintains a priority map by using cgroup id as the keys and priority as
the values. We could protect certain cgroups from oom-killer by setting
higher priority.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 .../bpf/prog_tests/test_oom_policy.c          | 140 ++++++++++++++++++
 .../testing/selftests/bpf/progs/oom_policy.c  |  77 ++++++++++
 2 files changed, 217 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
 create mode 100644 tools/testing/selftests/bpf/progs/oom_policy.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_oom_policy.c b/tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
new file mode 100644
index 000000000000..2400cc48ba83
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <sys/stat.h>
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include <bpf/bpf.h>
+
+#include "cgroup_helpers.h"
+#include "oom_policy.skel.h"
+
+static int map_fd;
+static int cg_nr;
+struct {
+	const char *path;
+	int fd;
+	unsigned long long id;
+} cgs[] = {
+	{ "/cg1" },
+	{ "/cg2" },
+};
+
+
+static struct oom_policy *open_load_oom_policy_skel(void)
+{
+	struct oom_policy *skel;
+	int err;
+
+	skel = oom_policy__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return NULL;
+
+	err = oom_policy__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	return skel;
+
+cleanup:
+	oom_policy__destroy(skel);
+	return NULL;
+}
+
+static void run_memory_consume(unsigned long long consume_size, int idx)
+{
+	char *buf;
+
+	join_parent_cgroup(cgs[idx].path);
+	buf = malloc(consume_size);
+	memset(buf, 0, consume_size);
+	sleep(2);
+	exit(0);
+}
+
+static int set_cgroup_prio(unsigned long long cg_id, int prio)
+{
+	int err;
+
+	err = bpf_map_update_elem(map_fd, &cg_id, &prio, BPF_ANY);
+	ASSERT_EQ(err, 0, "update_map");
+	return err;
+}
+
+static int prepare_cgroup_environment(void)
+{
+	int err;
+
+	err = setup_cgroup_environment();
+	if (err)
+		goto clean_cg_env;
+	for (int i = 0; i < cg_nr; i++) {
+		err = cgs[i].fd = create_and_get_cgroup(cgs[i].path);
+		if (!ASSERT_GE(cgs[i].fd, 0, "cg_create"))
+			goto clean_cg_env;
+		cgs[i].id = get_cgroup_id(cgs[i].path);
+	}
+	return 0;
+clean_cg_env:
+	cleanup_cgroup_environment();
+	return err;
+}
+
+void test_oom_policy(void)
+{
+	struct oom_policy *skel;
+	struct bpf_link *link;
+	int err;
+	int victim_pid;
+	unsigned long long victim_cg_id;
+
+	link = NULL;
+	cg_nr = ARRAY_SIZE(cgs);
+
+	skel = open_load_oom_policy_skel();
+	err = oom_policy__attach(skel);
+	if (!ASSERT_OK(err, "oom_policy__attach"))
+		goto cleanup;
+
+	map_fd = bpf_object__find_map_fd_by_name(skel->obj, "cg_map");
+	if (!ASSERT_GE(map_fd, 0, "find map"))
+		goto cleanup;
+
+	err = prepare_cgroup_environment();
+	if (!ASSERT_EQ(err, 0, "prepare cgroup env"))
+		goto cleanup;
+
+	write_cgroup_file("/", "memory.max", "10M");
+
+	/*
+	 * Set higher priority to cg2 and lower to cg1, so we would select
+	 * task under cg1 as victim.(see oom_policy.c)
+	 */
+	set_cgroup_prio(cgs[0].id, 10);
+	set_cgroup_prio(cgs[1].id, 50);
+
+	victim_cg_id = cgs[0].id;
+	victim_pid = fork();
+
+	if (victim_pid == 0)
+		run_memory_consume(1024 * 1024 * 4, 0);
+
+	if (fork() == 0)
+		run_memory_consume(1024 * 1024 * 8, 1);
+
+	while (wait(NULL) > 0)
+		;
+
+	ASSERT_EQ(skel->bss->victim_pid, victim_pid, "victim_pid");
+	ASSERT_EQ(skel->bss->victim_cg_id, victim_cg_id, "victim_cgid");
+
+cleanup:
+	bpf_link__destroy(link);
+	oom_policy__destroy(skel);
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/progs/oom_policy.c b/tools/testing/selftests/bpf/progs/oom_policy.c
new file mode 100644
index 000000000000..d269ea52bcb2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/oom_policy.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int);
+	__type(value, int);
+	__uint(max_entries, 24);
+} cg_map SEC(".maps");
+
+unsigned int victim_pid;
+u64 victim_cg_id;
+
+enum bpf_select_ret {
+	BPF_SELECT_DISABLE,
+	BPF_SELECT_TASK,
+	BPF_SELECT_CHOSEN,
+};
+
+static __always_inline u64 task_cgroup_id(struct task_struct *task)
+{
+	struct kernfs_node *node;
+	struct task_group *tg;
+
+	if (!task)
+		return 0;
+
+	tg = task->sched_task_group;
+	node = tg->css.cgroup->kn;
+
+	return node->id;
+}
+
+SEC("fentry/oom_kill_process")
+int BPF_PROG(oom_kill_process_k, struct oom_control *oc, const char *message)
+{
+	struct task_struct *victim = oc->chosen;
+
+	if (!victim)
+		return 0;
+
+	victim_pid = victim->pid;
+	victim_cg_id = task_cgroup_id(victim);
+	return 0;
+}
+
+SEC("fmod_ret/bpf_select_task")
+int BPF_PROG(select_task_test, struct oom_control *oc, struct task_struct *task, long points)
+{
+	u64 chosen_cg_id, task_cg_id;
+	int chosen_cg_prio, task_cg_prio;
+	struct task_struct *chosen;
+	int *val;
+
+	chosen = oc->chosen;
+	chosen_cg_id = task_cgroup_id(chosen);
+	task_cg_id = task_cgroup_id(task);
+	chosen_cg_prio = task_cg_prio = 0;
+	val = bpf_map_lookup_elem(&cg_map, &chosen_cg_id);
+	if (val)
+		chosen_cg_prio = *val;
+	val = bpf_map_lookup_elem(&cg_map, &task_cg_id);
+	if (val)
+		task_cg_prio = *val;
+
+	if (chosen_cg_prio > task_cg_prio)
+		return BPF_SELECT_TASK;
+	if (chosen_cg_prio < task_cg_prio)
+		return BPF_SELECT_CHOSEN;
+
+	return BPF_SELECT_DISABLE;
+
+}
+
-- 
2.20.1


