Return-Path: <bpf+bounces-13095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B617D45A9
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 04:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4EB8281389
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 02:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81E6257D;
	Tue, 24 Oct 2023 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jvpBVNRI"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA22A23AE
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 02:43:04 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0091E10CE
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 19:42:59 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ca3a54d2c4so33313755ad.3
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 19:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698115379; x=1698720179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaiHO7SBSXsd0QCikkafn6mecL9krZTUGDMsMzgZbU4=;
        b=jvpBVNRIxAdtm45FDvF3M9wlu8O2agb2p9CLkmsL88cOqT2yTnNcreF+6qzoevMXdG
         ERviHDTZtW2O7a47yXyOT384YkDp2QzwZfsGQe1bLuUCxJ6Ue259C3wO4C5thuVbO0P/
         JjRse5ZAMFXBX1NPlaPD1K5ndDLUH2HbAagncjT94OjVyHF1gxeo1jqZMyV//T2Sljrx
         83nWVTgQ3YO6e3JvRomRAiYgJhu9H4HnhTV6LG0VjodB3BtuiMQO1NiXQLJKQUeaeG9M
         k5fBdw1Fb41ODUuaKKsrbGD5T4m6bI1Vokx4ias7/wD62kmB3A9o+whLheY7KCvJORdz
         ZZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698115379; x=1698720179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaiHO7SBSXsd0QCikkafn6mecL9krZTUGDMsMzgZbU4=;
        b=Y6vgvQG0X0whlYnpqBQlo+23OWkgGlCGsGzv4UqcNShLJiuJpgwqmb4t3kCix8/LRZ
         VdCGVksLClwautHbcedz2wWhPucTszTVLbL03GtU2AXItsycefXkkaPMoZGzIy2TAc1E
         FTkAxjbLSF/wKTAxG6Zvjj+BUtkE7eZY8VCl7pCWW6Wz3eWIXZr6XWW9Tj+0+a3s7IFD
         BN43CAC5Eyvpx2kJfHjwcC6v8adJTTbkCXavOGHACNGlCAaSIAER5FmpIsBOkL3NWeK7
         dX/Th/te76E6XYjRai34ZxROjUqXgsF9rqHd1PVKCnp3TRBe9EvgJWDa9NklRMmVYDi8
         Axfg==
X-Gm-Message-State: AOJu0YxL8/Uo25x+yGVTVrwdgZfk7pCPzTI2HZpe1EpnE8aXcERSCSh4
	+Hxtr9iDIaVcrvVbCXt9mTzJL7qV3SeVV9TwXG0=
X-Google-Smtp-Source: AGHT+IFhWpY9mUsOiw/SSaG8aYEIl2GFH5togi/2a8niykegEL6J/SpzLIlXPC/e0MOeJ3ia1pGiEA==
X-Received: by 2002:a17:903:2846:b0:1c9:cc88:5029 with SMTP id kq6-20020a170903284600b001c9cc885029mr10530143plb.32.1698115379262;
        Mon, 23 Oct 2023 19:42:59 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.70])
        by smtp.gmail.com with ESMTPSA id l15-20020a170903244f00b001c62b9a51a4sm6619539pls.239.2023.10.23.19.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 19:42:59 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add test for css_task iter combining with cgroup iter
Date: Tue, 24 Oct 2023 10:42:40 +0800
Message-Id: <20231024024240.42790-3-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231024024240.42790-1-zhouchuyi@bytedance.com>
References: <20231024024240.42790-1-zhouchuyi@bytedance.com>
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


