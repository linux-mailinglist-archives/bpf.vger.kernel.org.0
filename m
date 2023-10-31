Return-Path: <bpf+bounces-13670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1D07DC5A5
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8DD1C20BD5
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 05:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44D4CA7B;
	Tue, 31 Oct 2023 05:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IvpHygHq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15716FD8
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 05:04:53 +0000 (UTC)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6070EF9
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:04:52 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27d0e3d823fso3702471a91.1
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698728691; x=1699333491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqCtKR6VA8EtQ7XQ5WZSgGs52BD+takdwiFmeHfAd18=;
        b=IvpHygHq0xXnJPsM7HZJz35sR6OzGeuGBd227lCi8qImDWeLMQDC3hNhU0KpvreFzl
         kLwGBqUvEk2Q8EAVX6CdBM7Bk1y0uzu8hIpLy9Pol87oUHGEsrL8hlfa0IRJIGzpouaG
         gjEwPw+efVK4EEZ4NuMJ8rvqKn1tFLiehIpousqnnuqtb23dbO2sQG917egwkgRp7pyf
         XnKEUMAJkOhlAwfBZvetHUut3D+SEz1YSSXfTaLIr1k9UuyA8AhDf+Yhl8qg/ka6/oE9
         0uXrIkQ00/9ccOCsSjXSUckBNSDMX7MF2XLlQUkwRSMWrxPWFsr1IEBFQVR7lnSDaVGE
         wJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698728691; x=1699333491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqCtKR6VA8EtQ7XQ5WZSgGs52BD+takdwiFmeHfAd18=;
        b=P3gRm+he97+QgErhrifgcKoi8F7Lz60VZzikDHCFGnbymbHBp/IMS2E/r6MRyctMPy
         BIBSlX/hitbixWe/idb6JDpA/cyl2l7AlRyJcYUvYTyo216JlvQqsrviRmoA+tvhFtOi
         Jw/r74d95RRJnlq96LpJNkq3UknGm72xZNVmkC+g9yYmcTB9NCqplAFVTyXs/g48liHR
         ZUe7F0jw9gneiDVZargV4hnyvkeY1kHwHz3QcEOb7+D9rbEPnE4aR/9AdwSBKDUKRWPi
         ZqSbO6tGcs7DdD9Ta7GHyszn7aSQ3D+fe+kw4i+Ju0+Zr0LKzpPdKkew72lY+IIVVJNT
         rx6A==
X-Gm-Message-State: AOJu0YzxMi7aoyTY03sxk/VM5D1UHRt4NHTPLR7GX3Cgm+RRKICNkbK1
	CBIhL6nxBsdb8OsabtUtsns33RUAD/Yj3NYkRxA=
X-Google-Smtp-Source: AGHT+IEeAuMjgbWw0ybKIuiRRXdzgtWXz0PMeAZ9+966Wo0Rzf6dCL6JWbvLUtg3xtXrP8iyeEhlYA==
X-Received: by 2002:a17:90a:357:b0:27c:f9e7:30fd with SMTP id 23-20020a17090a035700b0027cf9e730fdmr8398717pjf.7.1698728691350;
        Mon, 30 Oct 2023 22:04:51 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.142])
        by smtp.gmail.com with ESMTPSA id 21-20020a17090a195500b0027ce34334f5sm350951pjh.37.2023.10.30.22.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 22:04:51 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v4 2/3] selftests/bpf: Add tests for css_task iter combining with cgroup iter
Date: Tue, 31 Oct 2023 13:04:37 +0800
Message-Id: <20231031050438.93297-3-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231031050438.93297-1-zhouchuyi@bytedance.com>
References: <20231031050438.93297-1-zhouchuyi@bytedance.com>
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
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/cgroup_iter.c    | 33 ++++++++++++++
 .../selftests/bpf/progs/iters_css_task.c      | 44 +++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
index e02feb5fae97..574d9a0cdc8e 100644
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
+	struct iters_css_task *skel;
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
index 5089ce384a1c..384ff806990f 100644
--- a/tools/testing/selftests/bpf/progs/iters_css_task.c
+++ b/tools/testing/selftests/bpf/progs/iters_css_task.c
@@ -10,6 +10,7 @@
 
 char _license[] SEC("license") = "GPL";
 
+struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
 struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
 void bpf_cgroup_release(struct cgroup *p) __ksym;
 
@@ -45,3 +46,46 @@ int BPF_PROG(iter_css_task_for_each, struct vm_area_struct *vma,
 
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
+	u64 cgrp_id;
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
+	cgrp_id = cgroup_id(cgrp);
+
+	BPF_SEQ_PRINTF(seq, "%8llu\n", cgrp_id);
+
+	acquired = bpf_cgroup_from_id(cgrp_id);
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


