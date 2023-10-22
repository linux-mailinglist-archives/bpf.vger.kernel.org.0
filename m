Return-Path: <bpf+bounces-12946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D2C7D239B
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 17:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 606AEB20D9D
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 15:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3C810960;
	Sun, 22 Oct 2023 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KUoMLtYJ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFD1107A4
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 15:45:45 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBC1F4
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 08:45:43 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b5af4662b7so1938036b3a.3
        for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 08:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697989543; x=1698594343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaiHO7SBSXsd0QCikkafn6mecL9krZTUGDMsMzgZbU4=;
        b=KUoMLtYJBWNkrrVLl+plSUHrq1Fg+FsIPl7ptEVl+ZmN7S4o0y8XuRvFXl7yUlAhCr
         MKG1giiHv5N2Qi//y5MI+45b2TYKTVtR6mQRjgOMuXBssnbIuybkvgKfN3bld0zZEfSk
         b8AjE36CIKas9UsdKt/h/JIocxjjp5EN/4U7nJ32Qo9P7s0q40QmsFFfJA7dL8bb6zPt
         jef/uNQa7uclgbU0aUqw5M1MCzXlg+as48xZS9wJH0t5lhSVC5ymFXjV2Jb6utEa7ZJg
         Rq6coRBdTMwYXHOR2ispcSAQO9PGt8GaxylZemNRhcHK8pEukNhQl43jGLmWPBAv/keq
         5x6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697989543; x=1698594343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaiHO7SBSXsd0QCikkafn6mecL9krZTUGDMsMzgZbU4=;
        b=LS9sROb/sRFKZt4LDeDjz4Btl1GPyz+54EQ8DcpLJ4mWTdHrDjvJWFzJsyV50KIrSY
         moYW0BeUrsTy8yTaFl5rcPshAo7YEpsNoeFk8yUfIwKWODXBZp0K1TBbMYB5ZbpaC2DT
         eL3P2qtcWQ+4ASlxT/g2wC7+kSCTivneISuxbQfsKmuz8u9GnrOYzSwOpuQRJQ78xlBw
         tvgRFNcKA5TzLYmXFg/DpaZDWyNFmwafej+KtU2/GnznL0BQttts1y6aNAzFCxRZTVlv
         cBcgU6h4P3sWatqHzNrnXKZxzKgF9WdU2yNOrmCSUpm+gBUADzLN3/9WFDDnlOa4Btck
         cG2w==
X-Gm-Message-State: AOJu0Ywv5V/l+KM2gb7yXdUy0XFXtsj1C6ptuZCzNGWpGBhsRk0wpSG/
	o6fJZbu7NtPVcem2Jyfl+9o+kV+xjUQPzApfQyE3ew==
X-Google-Smtp-Source: AGHT+IFrzhHTXSfJpZpO4bd3xmL0DHpuCTad9SyeO3RAV7nuOssFJCsOh/MPLmRTHp8r2I2HDjrXGg==
X-Received: by 2002:a05:6a21:6d94:b0:171:e3b2:7d52 with SMTP id wl20-20020a056a216d9400b00171e3b27d52mr4892588pzb.59.1697989543143;
        Sun, 22 Oct 2023 08:45:43 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.49.4])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902d34200b001bbdd44bbb6sm4551996plk.136.2023.10.22.08.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 08:45:42 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test for css_task iter combining with cgroup iter
Date: Sun, 22 Oct 2023 23:45:27 +0800
Message-Id: <20231022154527.229117-3-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231022154527.229117-1-zhouchuyi@bytedance.com>
References: <20231022154527.229117-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a test which demonstrates how css_task iter can be combined
with cgroup iter and it won't cause deadlock, though cgroup iter is not
sleepable.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 .../selftests/bpf/prog_tests/cgroup_iter.c    | 33 +++++++++++++++
 .../selftests/bpf/progs/iters_css_task.c      | 41 +++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
index e02feb5fae97..3679687a6927 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
@@ -4,6 +4,7 @@
 #include <test_progs.h>
 #include <bpf/libbpf.h>
 #include <bpf/btf.h>
+#include "iters_css_task.skel.h"
 #include "cgroup_iter.skel.h"
 #include "cgroup_helpers.h"
 
@@ -263,6 +264,35 @@ static void test_walk_dead_self_only(struct cgroup_iter *skel)
 	close(cgrp_fd);
 }
 
+static void test_walk_self_only_css_task(void)
+{
+	struct iters_css_task *skel = NULL;
+	int err;
+
+	skel = iters_css_task__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.cgroup_id_printer, true);
+
+	err = iters_css_task__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	err = join_cgroup(cg_path[CHILD2]);
+	if (!ASSERT_OK(err, "join_cgroup"))
+		goto cleanup;
+
+	skel->bss->target_pid = getpid();
+	snprintf(expected_output, sizeof(expected_output),
+		PROLOGUE "%8llu\n" EPILOGUE, cg_id[CHILD2]);
+	read_from_cgroup_iter(skel->progs.cgroup_id_printer, cg_fd[CHILD2],
+		BPF_CGROUP_ITER_SELF_ONLY, "test_walk_self_only_css_task");
+	ASSERT_EQ(skel->bss->css_task_cnt, 1, "css_task_cnt");
+cleanup:
+	iters_css_task__destroy(skel);
+}
+
 void test_cgroup_iter(void)
 {
 	struct cgroup_iter *skel = NULL;
@@ -293,6 +323,9 @@ void test_cgroup_iter(void)
 		test_walk_self_only(skel);
 	if (test__start_subtest("cgroup_iter__dead_self_only"))
 		test_walk_dead_self_only(skel);
+	if (test__start_subtest("cgroup_iter__self_only_css_task"))
+		test_walk_self_only_css_task();
+
 out:
 	cgroup_iter__destroy(skel);
 	cleanup_cgroups();
diff --git a/tools/testing/selftests/bpf/progs/iters_css_task.c b/tools/testing/selftests/bpf/progs/iters_css_task.c
index 5089ce384a1c..0974e6f44328 100644
--- a/tools/testing/selftests/bpf/progs/iters_css_task.c
+++ b/tools/testing/selftests/bpf/progs/iters_css_task.c
@@ -10,6 +10,7 @@
 
 char _license[] SEC("license") = "GPL";
 
+struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
 struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
 void bpf_cgroup_release(struct cgroup *p) __ksym;
 
@@ -45,3 +46,43 @@ int BPF_PROG(iter_css_task_for_each, struct vm_area_struct *vma,
 
 	return -EPERM;
 }
+
+static inline u64 cgroup_id(struct cgroup *cgrp)
+{
+	return cgrp->kn->id;
+}
+
+SEC("?iter/cgroup")
+int cgroup_id_printer(struct bpf_iter__cgroup *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
+	struct cgroup *cgrp, *acquired;
+	struct cgroup_subsys_state *css;
+	struct task_struct *task;
+
+	cgrp = ctx->cgroup;
+
+	/* epilogue */
+	if (cgrp == NULL) {
+		BPF_SEQ_PRINTF(seq, "epilogue\n");
+		return 0;
+	}
+
+	/* prologue */
+	if (ctx->meta->seq_num == 0)
+		BPF_SEQ_PRINTF(seq, "prologue\n");
+
+	BPF_SEQ_PRINTF(seq, "%8llu\n", cgroup_id(cgrp));
+
+	acquired = bpf_cgroup_from_id(cgroup_id(cgrp));
+	if (!acquired)
+		return 0;
+	css = &acquired->self;
+	css_task_cnt = 0;
+	bpf_for_each(css_task, task, css, CSS_TASK_ITER_PROCS) {
+		if (task->pid == target_pid)
+			css_task_cnt++;
+	}
+	bpf_cgroup_release(acquired);
+	return 0;
+}
-- 
2.20.1


