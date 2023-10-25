Return-Path: <bpf+bounces-13216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBF67D6453
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 10:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3CF1C20E0B
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 08:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F05E1C6A3;
	Wed, 25 Oct 2023 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Qwj96157"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B75C63CA
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 08:00:25 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37800116
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 01:00:24 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-581fb6f53fcso3153514eaf.2
        for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 01:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698220823; x=1698825623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaiHO7SBSXsd0QCikkafn6mecL9krZTUGDMsMzgZbU4=;
        b=Qwj96157JNxA7rQQUAFID3bigfzFyCWZ7J9xAJ/FGosmsUQgSJRU8cw9CjX+jjdpuL
         T42a9U5/3+z1X/SbmopGM6kOo+nqpjieg5epqzCMFvLxQfxS9yYYWryXeQfBgyFvimgi
         gcT4rlmhwQRASM06GKAntSBzTUOLwPDXUkZzj9CEEXbkyyRJiRVsECGYL5HWPZAskfMK
         aqmveqoSbwXw5T+Gd11J/nRJvhrwv3jre/MUclSK/FpK05iGgpNXVmPHKGE0/ca+S14a
         dIMi9xj3uubL1dnnLPLS2GqxH5odLfI9/pUnMPe1+9btnHQ8Z/v0UMw8yjb3ODej6Azc
         nkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698220823; x=1698825623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaiHO7SBSXsd0QCikkafn6mecL9krZTUGDMsMzgZbU4=;
        b=ZK0ecwhtxgU2xPJi1Dzu4Q44djJg2uRL/4WfB40JEL9W3ryweSA2iD8FmE2qsB/OS1
         EJwDDP0LCrhQLXDZ2wxxuRf0uvhsud5EkcGh9dVZ51scwVeQptzEeWE4fuKYGZYDd8UZ
         6IqE8wvSNGGcmRf7MyKfZrBdv3x/G87eXPQCWOJAge7s/aX/EGa+xZKx3yKQaeeWhP8j
         Shg03YHwkguxMABktBYOtCQum1nPs1JilnK/k3f+QTD2gXc8/jG11MtU6+H11ZE6If3H
         4PIgHaG5xHO1maTi+IGsHViAX4GMvKtvVHLy169tsIzppqqlhf1aax+qomnc+DwS6ep6
         zRhw==
X-Gm-Message-State: AOJu0YwwgSbzWT7X98/4+VaTf/lHKmrP+4erFGqsK2r5Q7CS3nGRv4H0
	zH9tPQSFzgiZ9/ahgox9kky5kupMWpcn+k+nazw=
X-Google-Smtp-Source: AGHT+IGajCKoEf9uKr96cuek8ikK010TTGEC7NNwwNktxU1Llh1DQENQfFk86x4NWzzchOWCE8ktgg==
X-Received: by 2002:a05:6359:593:b0:168:e9d2:6568 with SMTP id ee19-20020a056359059300b00168e9d26568mr6618931rwb.25.1698220823170;
        Wed, 25 Oct 2023 01:00:23 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.40])
        by smtp.gmail.com with ESMTPSA id 23-20020a630f57000000b0059cc2f1b7basm8118187pgp.11.2023.10.25.01.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 01:00:22 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: Add tests for css_task iter combining with cgroup iter
Date: Wed, 25 Oct 2023 15:59:13 +0800
Message-Id: <20231025075914.30979-3-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231025075914.30979-1-zhouchuyi@bytedance.com>
References: <20231025075914.30979-1-zhouchuyi@bytedance.com>
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


