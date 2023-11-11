Return-Path: <bpf+bounces-14871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 478CC7E89FB
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 10:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3D34B20DFF
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 09:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3800E11CBD;
	Sat, 11 Nov 2023 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwMfM69X"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09896125A3
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 09:00:49 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7960E4496
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 01:00:48 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6c3363a2b93so2868477b3a.3
        for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 01:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699693248; x=1700298048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WW4O8PrsRmSU0aOFilfYLgf4S87uet0NV6y+4+mCKtQ=;
        b=SwMfM69XV2hVxL2yPUlIKabYx/zpsK8vxSZnx1a13XDbrRXTbcMAgXW9Jmw6r/tlML
         yDcbmjtVBEwDCqiDkIT1vqg2s7A1rdE5MB8n4rsbYiVGHeeGkidm9NJ2VFR1JwCDRn/Q
         6A46MW3/yiQd7rk/aDhaDN8NvYJ8Y5jXsD0yFSZjiEYMG7yml578nvGv7ezM1ecJ3PXh
         Xpe5QKoAZ8n/Ats90Bv3gCP60a6427idgD9HvbGTr7aP3MSbrItP3yAjS/eWvAySQZFk
         cUjgf+bzP2bz45Bpa43Sz5PMY877HAdAfmhMlHjTms+/iBU7iur4Tl2ttWt0Axx1rBs6
         6xGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699693248; x=1700298048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WW4O8PrsRmSU0aOFilfYLgf4S87uet0NV6y+4+mCKtQ=;
        b=ebB65dMv2OVvpFK09AKBr2BmJkY9bdbaDLi+l5kcdYOVd91bguG/+yO9e2G6Ci6Q4H
         MtNwMKimyI0/TOTyjTN/RrponvdlTfVPQ1LtWSFi2WIKk60AP7StZxjxFR03rJVFjK3e
         cM+S59vRHEj8yd9KeICQimGHbXDnLJOI0v4xxvsvzWBsRs+ypHbcIBno2SjyVJKJ5r3e
         SPEEquOQFN8wliw3ZEi+rZWyGwC9pnZRaMO7e9N2BXj6JMJ66+L6cQ+f8lH3Xbs95XP1
         9XXNqNpHywTbThKJLNk0WERMz1myJHMbMPOUyEZ/m2Ui+TdOu0PX/Xv0AwE+G/YUGbry
         iVNw==
X-Gm-Message-State: AOJu0YyPimDDc/KCZkMqDJ49RkQHXbbuT7lsG8qmlAJNmKbrIdktlkgi
	0MgtCLh87kCfZRiSXTN6YamxPVx1AtoqzMyZ4JQ=
X-Google-Smtp-Source: AGHT+IEEIdMwaTbYLT6km4m/MTPNUO29gL6+3D5CBKqsOxYyPUfoOEFcp0DVohaPt2c3Fxe6KP6Jjw==
X-Received: by 2002:a62:e418:0:b0:6be:23dd:d62c with SMTP id r24-20020a62e418000000b006be23ddd62cmr1533037pfh.2.1699693247620;
        Sat, 11 Nov 2023 01:00:47 -0800 (PST)
Received: from vultr.guest ([45.63.84.83])
        by smtp.gmail.com with ESMTPSA id fh38-20020a056a00392600b006b2e07a6235sm894254pfb.136.2023.11.11.01.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 01:00:47 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 bpf-next 6/6] selftests/bpf: Add selftests for cgroup1 hierarchy
Date: Sat, 11 Nov 2023 09:00:34 +0000
Message-Id: <20231111090034.4248-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231111090034.4248-1-laoar.shao@gmail.com>
References: <20231111090034.4248-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for cgroup1 hierarchy.
The result as follows,

  $ tools/testing/selftests/bpf/test_progs --name=cgroup1_hierarchy
  #36/1    cgroup1_hierarchy/test_cgroup1_hierarchy:OK
  #36/2    cgroup1_hierarchy/test_root_cgid:OK
  #36/3    cgroup1_hierarchy/test_invalid_level:OK
  #36/4    cgroup1_hierarchy/test_invalid_cgid:OK
  #36/5    cgroup1_hierarchy/test_invalid_hid:OK
  #36/6    cgroup1_hierarchy/test_invalid_cgrp_name:OK
  #36/7    cgroup1_hierarchy/test_invalid_cgrp_name2:OK
  #36/8    cgroup1_hierarchy/test_sleepable_prog:OK
  #36      cgroup1_hierarchy:OK
  Summary: 1/8 PASSED, 0 SKIPPED, 0 FAILED

Besides, I also did some stress test similar to the patch #2 in this
series, as follows (with CONFIG_PROVE_RCU_LIST enabled):

- Continuously mounting and unmounting named cgroups in some tasks,
  for example:

  cgrp_name=$1
  while true
  do
      mount -t cgroup -o none,name=$cgrp_name none /$cgrp_name
      umount /$cgrp_name
  done

- Continuously run this selftest concurrently,
  while true; do ./test_progs --name=cgroup1_hierarchy; done

They can ran successfully without any RCU warnings in dmesg.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/cgroup1_hierarchy.c   | 158 +++++++++++++++++++++
 .../selftests/bpf/progs/test_cgroup1_hierarchy.c   |  72 ++++++++++
 2 files changed, 230 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c b/tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c
new file mode 100644
index 0000000..74d6d75
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include <sys/types.h>
+#include <unistd.h>
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+#include "test_cgroup1_hierarchy.skel.h"
+
+static void bpf_cgroup1(struct test_cgroup1_hierarchy *skel)
+{
+	struct bpf_link *lsm_link, *fentry_link;
+	int err;
+
+	/* Attach LSM prog first */
+	lsm_link = bpf_program__attach_lsm(skel->progs.lsm_run);
+	if (!ASSERT_OK_PTR(lsm_link, "lsm_attach"))
+		return;
+
+	/* LSM prog will be triggered when attaching fentry */
+	fentry_link = bpf_program__attach_trace(skel->progs.fentry_run);
+	ASSERT_NULL(fentry_link, "fentry_attach_fail");
+
+	err = bpf_link__destroy(lsm_link);
+	ASSERT_OK(err, "destroy_lsm");
+}
+
+static void bpf_cgroup1_sleepable(struct test_cgroup1_hierarchy *skel)
+{
+	struct bpf_link *lsm_link, *fentry_link;
+	int err;
+
+	/* Attach LSM prog first */
+	lsm_link = bpf_program__attach_lsm(skel->progs.lsm_s_run);
+	if (!ASSERT_OK_PTR(lsm_link, "lsm_attach"))
+		return;
+
+	/* LSM prog will be triggered when attaching fentry */
+	fentry_link = bpf_program__attach_trace(skel->progs.fentry_run);
+	ASSERT_NULL(fentry_link, "fentry_attach_fail");
+
+	err = bpf_link__destroy(lsm_link);
+	ASSERT_OK(err, "destroy_lsm");
+}
+
+static void bpf_cgroup1_invalid_id(struct test_cgroup1_hierarchy *skel)
+{
+	struct bpf_link *lsm_link, *fentry_link;
+	int err;
+
+	/* Attach LSM prog first */
+	lsm_link = bpf_program__attach_lsm(skel->progs.lsm_run);
+	if (!ASSERT_OK_PTR(lsm_link, "lsm_attach"))
+		return;
+
+	/* LSM prog will be triggered when attaching fentry */
+	fentry_link = bpf_program__attach_trace(skel->progs.fentry_run);
+	if (!ASSERT_OK_PTR(fentry_link, "fentry_attach_success"))
+		goto cleanup;
+
+	err = bpf_link__destroy(fentry_link);
+	ASSERT_OK(err, "destroy_lsm");
+
+cleanup:
+	err = bpf_link__destroy(lsm_link);
+	ASSERT_OK(err, "destroy_fentry");
+}
+
+void test_cgroup1_hierarchy(void)
+{
+	struct test_cgroup1_hierarchy *skel;
+	__u64 current_cgid;
+	int hid, err;
+
+	skel = test_cgroup1_hierarchy__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	skel->bss->target_pid = getpid();
+
+	err = bpf_program__set_attach_target(skel->progs.fentry_run, 0, "bpf_fentry_test1");
+	if (!ASSERT_OK(err, "fentry_set_target"))
+		goto destroy;
+
+	err = test_cgroup1_hierarchy__load(skel);
+	if (!ASSERT_OK(err, "load"))
+		goto destroy;
+
+	/* Setup cgroup1 hierarchy */
+	err = setup_classid_environment();
+	if (!ASSERT_OK(err, "setup_classid_environment"))
+		goto destroy;
+
+	err = join_classid();
+	if (!ASSERT_OK(err, "join_cgroup1"))
+		goto cleanup;
+
+	current_cgid = get_classid_cgroup_id();
+	if (!ASSERT_GE(current_cgid, 0, "cgroup1 id"))
+		goto cleanup;
+
+	hid = get_cgroup1_hierarchy_id("net_cls");
+	if (!ASSERT_GE(hid, 0, "cgroup1 id"))
+		goto cleanup;
+	skel->bss->target_hid = hid;
+
+	if (test__start_subtest("test_cgroup1_hierarchy")) {
+		skel->bss->target_ancestor_cgid = current_cgid;
+		bpf_cgroup1(skel);
+	}
+
+	if (test__start_subtest("test_root_cgid")) {
+		skel->bss->target_ancestor_cgid = 1;
+		skel->bss->target_ancestor_level = 0;
+		bpf_cgroup1(skel);
+	}
+
+	if (test__start_subtest("test_invalid_level")) {
+		skel->bss->target_ancestor_cgid = 1;
+		skel->bss->target_ancestor_level = 1;
+		bpf_cgroup1_invalid_id(skel);
+	}
+
+	if (test__start_subtest("test_invalid_cgid")) {
+		skel->bss->target_ancestor_cgid = 0;
+		bpf_cgroup1_invalid_id(skel);
+	}
+
+	if (test__start_subtest("test_invalid_hid")) {
+		skel->bss->target_ancestor_cgid = 1;
+		skel->bss->target_ancestor_level = 0;
+		skel->bss->target_hid = -1;
+		bpf_cgroup1_invalid_id(skel);
+	}
+
+	if (test__start_subtest("test_invalid_cgrp_name")) {
+		skel->bss->target_hid = get_cgroup1_hierarchy_id("net_cl");
+		skel->bss->target_ancestor_cgid = current_cgid;
+		bpf_cgroup1_invalid_id(skel);
+	}
+
+	if (test__start_subtest("test_invalid_cgrp_name2")) {
+		skel->bss->target_hid = get_cgroup1_hierarchy_id("net_cls,");
+		skel->bss->target_ancestor_cgid = current_cgid;
+		bpf_cgroup1_invalid_id(skel);
+	}
+
+	if (test__start_subtest("test_sleepable_prog")) {
+		skel->bss->target_hid = hid;
+		skel->bss->target_ancestor_cgid = current_cgid;
+		bpf_cgroup1_sleepable(skel);
+	}
+
+cleanup:
+	cleanup_classid_environment();
+destroy:
+	test_cgroup1_hierarchy__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c b/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c
new file mode 100644
index 0000000..979ff4e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+//#endif
+/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+__u32 target_ancestor_level;
+__u64 target_ancestor_cgid;
+int target_pid, target_hid;
+
+struct cgroup *bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id) __ksym;
+struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level) __ksym;
+void bpf_cgroup_release(struct cgroup *cgrp) __ksym;
+
+static int bpf_link_create_verify(int cmd)
+{
+	struct cgroup *cgrp, *ancestor;
+	struct task_struct *task;
+	int ret = 0;
+
+	if (cmd != BPF_LINK_CREATE)
+		return 0;
+
+	task = bpf_get_current_task_btf();
+
+	/* Then it can run in parallel with others */
+	if (task->pid != target_pid)
+		return 0;
+
+	cgrp = bpf_task_get_cgroup1(task, target_hid);
+	if (!cgrp)
+		return 0;
+
+	/* Refuse it if its cgid or its ancestor's cgid is the target cgid */
+	if (cgrp->kn->id == target_ancestor_cgid)
+		ret = -1;
+
+	ancestor = bpf_cgroup_ancestor(cgrp, target_ancestor_level);
+	if (!ancestor)
+		goto out;
+
+	if (ancestor->kn->id == target_ancestor_cgid)
+		ret = -1;
+	bpf_cgroup_release(ancestor);
+
+out:
+	bpf_cgroup_release(cgrp);
+	return ret;
+}
+
+SEC("lsm/bpf")
+int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size)
+{
+	return bpf_link_create_verify(cmd);
+}
+
+SEC("lsm.s/bpf")
+int BPF_PROG(lsm_s_run, int cmd, union bpf_attr *attr, unsigned int size)
+{
+	return bpf_link_create_verify(cmd);
+}
+
+SEC("fentry")
+int BPF_PROG(fentry_run)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
1.8.3.1


