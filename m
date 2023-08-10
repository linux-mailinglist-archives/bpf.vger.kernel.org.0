Return-Path: <bpf+bounces-7435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1C5777298
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 10:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D3C1C202E7
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 08:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CD51E500;
	Thu, 10 Aug 2023 08:13:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25B71ADE8
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 08:13:47 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C422DE7E
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 01:13:45 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso3451635ad.1
        for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 01:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691655225; x=1692260025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEsujYzeHDJksabxHXYH7r+I+WQ8F1nGq024d8cm1KU=;
        b=VuTFtoYEBUXlmZ/xn9ftnduPgMunFsfNJN8FNbD7NPo+XLvQDZC82CdMZileZgf7Ju
         J6N3h2CD+mAIE6hKRtUvuxSpadHUagPDYdUrTa4ay0ncTKS2MyjfNBe6eVPT14fr1HD5
         kq6marMYBOiAeqDY6CTWVjuC3XM5YtbqNlCNH/aIP8g8SlkuknQocQyNqJtsiB6YzuhB
         uIJNNN8uyjXlvs3eP+8s4hLCB1yjUKioQZcsW+p7dsPom0psuNhy8Tf73mLptX1KoVFy
         9AQav14P/kk92N8V/4fpdXgdt5oHI3z4UP1dFui92Em4UReElSPkLCYpVCWza+wM+d8m
         Fu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691655225; x=1692260025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEsujYzeHDJksabxHXYH7r+I+WQ8F1nGq024d8cm1KU=;
        b=hjJR9IMUqJOM+BZor4VqR21E/FhFtxOIEc7sh21bZc7oV1ieWxk3NXGILTRmlym60/
         ypuUk8X1UD9cE+FtBrtQdMheOYoW8MdPTByz/GoTnbsPz5GzpZNjZBAXaEWa9TSmi5Z0
         QL2VtiMBZYWiqaNyfIYaILN21Oj53w1N5NP+SKbkw2/4qxuRrjMGayc2aCRTs/HcyqkB
         MB8DV/P4Khvg3LbdGUPE4FyYzO6cMTsWjNq3P7pSwO6loIh3ZyYbYnzZ4ZlweEOCsn33
         JZM3luCunAh8Jze4kWFQb3X6PQSr8xEThBB7QjXfYqrGKQ/OtRYoafw5kwiAqVDYWO84
         SqSA==
X-Gm-Message-State: AOJu0YwLdMYNAc0DV/qR7yg7FG2fKu/zCT8C8cLtYuM+vC0XFHNN4kyI
	jHGsoZbi2MlLoZ2j3HPn1I2HUgsPc/MsyrQ6BnY=
X-Google-Smtp-Source: AGHT+IGBzcA4i2z/gDQv/UTkeNvJUtjNcqDbRAxVuixYlcfF4sIbOkxh+w7RKS0ZxncRcZaqWF8dTg==
X-Received: by 2002:a17:903:11c8:b0:1b6:4bbd:c3a7 with SMTP id q8-20020a17090311c800b001b64bbdc3a7mr1431227plh.66.1691655225352;
        Thu, 10 Aug 2023 01:13:45 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.40])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b001b1a2c14a4asm1019036plg.38.2023.08.10.01.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:13:45 -0700 (PDT)
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
Subject: [RFC PATCH v2 4/5] bpf: Add a OOM policy test
Date: Thu, 10 Aug 2023 16:13:18 +0800
Message-Id: <20230810081319.65668-5-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230810081319.65668-1-zhouchuyi@bytedance.com>
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds a test which implements a priority-based policy through
bpf_oom_evaluate_task.

The BPF program, oom_policy.c, compares the cgroup priority of two tasks
and select the lower one. The userspace program test_oom_policy.c
maintains a priority map by using cgroup id as the keys and priority as
the values. We could protect certain cgroups from oom-killer by setting
higher priority.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 .../bpf/prog_tests/test_oom_policy.c          | 140 ++++++++++++++++++
 .../testing/selftests/bpf/progs/oom_policy.c  | 104 +++++++++++++
 2 files changed, 244 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
 create mode 100644 tools/testing/selftests/bpf/progs/oom_policy.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_oom_policy.c b/tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
new file mode 100644
index 000000000000..bea61ff22603
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
+	ASSERT_EQ(skel->bss->failed_cnt, 1, "failed_cnt");
+cleanup:
+	bpf_link__destroy(link);
+	oom_policy__destroy(skel);
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/progs/oom_policy.c b/tools/testing/selftests/bpf/progs/oom_policy.c
new file mode 100644
index 000000000000..fc9efc93914e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/oom_policy.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int);
+	__type(value, int);
+	__uint(max_entries, 24);
+} cg_map SEC(".maps");
+
+unsigned int victim_pid;
+u64 victim_cg_id;
+int failed_cnt;
+
+#define	EOPNOTSUPP	95
+
+enum {
+	NO_BPF_POLICY,
+	BPF_EVAL_ABORT,
+	BPF_EVAL_NEXT,
+	BPF_EVAL_SELECT,
+};
+
+extern void set_oom_policy_name(struct oom_control *oc, const char *buf, size_t sz) __ksym;
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
+	if (victim) {
+		victim_cg_id = task_cgroup_id(victim);
+		victim_pid = victim->pid;
+	}
+
+	return 0;
+}
+
+SEC("fentry/bpf_set_policy_name")
+int BPF_PROG(set_police_name_k, struct oom_control *oc)
+{
+	char name[] = "cg_prio";
+	set_oom_policy_name(oc, name, sizeof(name));
+	return 0;
+}
+
+SEC("tp_btf/select_bad_process_end")
+int BPF_PROG(record_failed, struct oom_control *oc)
+{
+	failed_cnt += 1;
+	return 0;
+}
+
+SEC("fmod_ret/bpf_oom_evaluate_task")
+int BPF_PROG(bpf_oom_evaluate_task, struct task_struct *task, struct oom_control *oc)
+{
+	int chosen_cg_prio, task_cg_prio;
+	u64 chosen_cg_id, task_cg_id;
+	struct task_struct *chosen;
+	int *val;
+
+	if (!failed_cnt)
+		return BPF_EVAL_NEXT;
+
+	chosen = oc->chosen;
+	if (!chosen)
+		return BPF_EVAL_SELECT;
+
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
+		return BPF_EVAL_SELECT;
+	if (chosen_cg_prio < task_cg_prio)
+		return BPF_EVAL_NEXT;
+
+	return NO_BPF_POLICY;
+}
+
-- 
2.20.1


