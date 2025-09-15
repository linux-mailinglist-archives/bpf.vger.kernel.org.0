Return-Path: <bpf+bounces-68368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5464B56ED4
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 05:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EB41726F5
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 03:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7AD25F96B;
	Mon, 15 Sep 2025 03:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXvA2Jtb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFEBEEAB
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 03:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757906786; cv=none; b=oBLS7lBQufQgm2tDrA+T7JqeOdPz29j5aZyetWo2cD0bsWAWxgE3nL9WOqFeq3HiGqubSvNEU9Fj1zpISnU9VKZi51RrHTyeqClaQMCLM0/5AdiAIxm4rQvbFv8reMjQxxKp5oeFeAGVnFwrXPAVlnmADoMOVtvVBIWHymG7z4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757906786; c=relaxed/simple;
	bh=IA7ErIe3fSrpmmbZrhmfYIBPTFxjdXLetBm5xIkRa78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJLFx4Gj77xYANZ/LFeJZsRZZWn6x4Z9Dxu174IByKGjzTQ6YgH03XzsHIclHLFM5WOxuIGG2SX+p/FoyFbwCsOi59J4Ki+Nm2D7rxFz/2zLSr7JaGtgxU1wsBsPGtZY8S+5qHlEmDeJjX9HDv1YOje+YaFEfmY6ZsYcFIuFFu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXvA2Jtb; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-45de56a042dso23445355e9.3
        for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 20:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757906782; x=1758511582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KpssDyJX1P39IXzavoJXTy0ead3IW2zXk9jwql8Jvg=;
        b=hXvA2JtbKZDTDPgCa30hkFDrORr+aLUEIBdroZ1DgVdQ1b8WSl4n7B/lqBbytXi+kz
         TV+poOZxUhbC8mTc2N9EWUac9zKazhnZCVdy3g/hzT49KLpXYmjob4XqHV9IHGvfv0/K
         AkEPgZsWdZ5yUR5kmhuS9b4gnVj7brg3K3LKfGrVulrpHWDo31PIeaIzvXwQNbVJNs5I
         EPHvy5Cb9gLAyGQBryiLvbxRJFDEbuOr3qo/Q/tD+Kn5L2LgK9vbmXfaSRzqgc6V3ddg
         Sen0UdXvJzv8yPpPfsENwmQyWeU5BOHUBacPauoC22W+zYQA072IUy7gbrpFvyHpdDyZ
         gvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757906782; x=1758511582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KpssDyJX1P39IXzavoJXTy0ead3IW2zXk9jwql8Jvg=;
        b=BNY+HKdvhGPwLz9R8Ooci0ZOKOW3hlBCHTmM88X+Rk1FP3d17Rdv7cVLRYmxF6p144
         TrsxV4VlEfQHYuh2YrG6BwbMEPVaKuMOPn2g1LYeC5PyFdgKI0X5XG0TJfP9LvlLhzCm
         J49AWzTGWe2xJ0SyYLtJDiRnFqlemlqD3bWDRPERNxxmI4U8YgtFZl4htQEvjtlB43Gx
         6ODCHcUAkLpXoQcRWpWcx638mfMFCDqgt8JLjbRs6EhirVqc+GBgZl9Cevulq1mX2Kxx
         aoOfbjOS2bSRDD1yNMA4RUptpKQAlOEoYg9y2yTikvCE4Mrl4hLH1zkH/lXD+3dN+Dls
         Vrrw==
X-Gm-Message-State: AOJu0YxwvWh0HeBh4sOyZPPSTLGY4e5EIjm7DhZcnlNDx4zTobQcVtIK
	AGSJulroKDVZMYwKehxUjoxK2VdYPza5s3pe3K3fGHw0CzwJG1Q+OQS6wq7hV78e
X-Gm-Gg: ASbGnctbvNdhSEiWwVePD7bzlxhkeIL1yS7FMzlRFwyJFqvTMW3AsYlvLBvCqqLTUrJ
	IivVBbGsDnUPuY0Uw7Theu+Pxtsr/OMb44zSVCDKs9T/CcZb/kEuRYLZt1JUPDSZuIeU/na92iw
	j0+SxMgBwHP+LK1SmC1USv2dv841t4/aADO3JDOXQFwn6gVJOA2nXed492n4l9Bima9bJ/G6Axo
	W7dNjzS9/NAE6LnPfvHl+ahCHhnB9tJZ410sknByxXI8KPSujEB5BblYKRchFyodnb9sEYKOO9y
	f4NVJRBt/Uug0eN5eXr/jSp4XnFUc1PZ3d1hNxUxLbQlqvEcngbGWqCvx5pONq5KWB9dTFwzIQJ
	j9AtyzYUWaGZpsKsy+gOf7n7kEEQgNXVe7dNLpsu8srzV
X-Google-Smtp-Source: AGHT+IFIeD2Mq30+ywKeY6fF8/4Z2Yif9v+zrAccz62V6crOTQsalYVfelYmZ13JyRejdUknQBcgGQ==
X-Received: by 2002:a05:600c:45d1:b0:45b:47e1:ef6d with SMTP id 5b1f17b1804b1-45f212253f8mr93157305e9.36.1757906782431;
        Sun, 14 Sep 2025 20:26:22 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45f2c7f5108sm19151125e9.0.2025.09.14.20.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 20:26:21 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <dschatzberg@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add a test for bpf_cgroup_from_id lookup in non-root cgns
Date: Mon, 15 Sep 2025 03:26:18 +0000
Message-ID: <20250915032618.1551762-3-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915032618.1551762-1-memxor@gmail.com>
References: <20250915032618.1551762-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5914; i=memxor@gmail.com; h=from:subject; bh=IA7ErIe3fSrpmmbZrhmfYIBPTFxjdXLetBm5xIkRa78=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBox4bqgW7TcP0oXSBvpaMQu9uAVESTwuXplvG11 xVWsuxR26GJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaMeG6gAKCRBM4MiGSL8R yn44EACOsjGKnhkWRjfeIVxlW8G585buXYYW369Ds4LUhcru03kPu40tLD0CXDodbznsScWQ+xd QSBczeuUe8iisszDIlbplV/0J1UCr1y/0QnChU7msyFOwhrUqSDbcpfmbR6y5p87o3j/UDVSNix +VtuWtSiHhwCJpTsXiWX7LXlXEts9xgIHSAU809OYP2CUoZWw9cI7ctOcqEoT77xo/UZV3grrL8 NmgOo4TNZRRFbG64x7Lysw6UpAonWWa3/MQ1WEyoDwbw+YpOeWwG00thTsWY6iJ+tAt2uRPQDFI 346p+8y0uvIjqS9jcsFC0EaNaUN3wfVHSaiaoiGuMTaIX9V2NHKDJRX6fltnkA+ckzV8SOdRh9h +3bbLBJ0lLuCLreYrW6AGg2TGHyGurwymoBl6+0XNeUdTcGrJC2bBisZdlwmfaYxas+xWmvIAxI I/5F7NsLmhnDnbbH5frcXddc9JPRmCMVp71uMkWbnBNrS3QrwtIzasNWz0usIDr5T7igv/leg4J BpYqCIXcyXDRx4VTqwqmSTglx1HGUalQlHuJE8Ih+ZGlc+F8PQhVk+5ZjqkYZkQjUG9ld8d9jsv WJ2w9wKHUoIyRvTa1+aQKX5o/znWxjCDredMOqYl9dw7/KsiKn1Y1sQ6///qrhO1SNc8m6rszO7 xJjeTozp0WiAriQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Make sure that we only switch the cgroup namespace and enter a new
cgroup in a child process separate from test_progs, to not mess up the
environment for subsequent tests.

To remove this cgroup, we need to wait for the child to exit, and then
rmdir its cgroup. If the read call fails, or waitpid succeeds, we know
the child exited (read call would fail when the last pipe end is closed,
otherwise waitpid waits until exit(2) is called). We then invoke a newly
introduced remove_cgroup_pid() helper, that identifies cgroup path using
the passed in pid of the now dead child, instead of using the current
process pid (getpid()).

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c  | 20 ++++++
 tools/testing/selftests/bpf/cgroup_helpers.h  |  1 +
 .../selftests/bpf/prog_tests/cgrp_kfunc.c     | 71 +++++++++++++++++++
 .../selftests/bpf/progs/cgrp_kfunc_success.c  | 12 ++++
 4 files changed, 104 insertions(+)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 15f626014872..20cede4db3ce 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -412,6 +412,26 @@ void remove_cgroup(const char *relative_path)
 		log_err("rmdiring cgroup %s .. %s", relative_path, cgroup_path);
 }
 
+/*
+ * remove_cgroup_pid() - Remove a cgroup setup by process identified by PID
+ * @relative_path: The cgroup path, relative to the workdir, to remove
+ * @pid: PID to be used to find cgroup_path
+ *
+ * This function expects a cgroup to already be created, relative to the cgroup
+ * work dir. It also expects the cgroup doesn't have any children or live
+ * processes and it removes the cgroup.
+ *
+ * On failure, it will print an error to stderr.
+ */
+void remove_cgroup_pid(const char *relative_path, int pid)
+{
+	char cgroup_path[PATH_MAX + 1];
+
+	format_cgroup_path_pid(cgroup_path, relative_path, pid);
+	if (rmdir(cgroup_path))
+		log_err("rmdiring cgroup %s .. %s", relative_path, cgroup_path);
+}
+
 /**
  * create_and_get_cgroup() - Create a cgroup, relative to workdir, and get the FD
  * @relative_path: The cgroup path, relative to the workdir, to join
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
index 182e1ac36c95..3857304be874 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -19,6 +19,7 @@ int cgroup_setup_and_join(const char *relative_path);
 int get_root_cgroup(void);
 int create_and_get_cgroup(const char *relative_path);
 void remove_cgroup(const char *relative_path);
+void remove_cgroup_pid(const char *relative_path, int pid);
 unsigned long long get_cgroup_id(const char *relative_path);
 int get_cgroup1_hierarchy_id(const char *subsys_name);
 
diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
index adda85f97058..4b42fbc96efc 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
@@ -4,6 +4,8 @@
 #define _GNU_SOURCE
 #include <cgroup_helpers.h>
 #include <test_progs.h>
+#include <sched.h>
+#include <sys/wait.h>
 
 #include "cgrp_kfunc_failure.skel.h"
 #include "cgrp_kfunc_success.skel.h"
@@ -87,6 +89,72 @@ static const char * const success_tests[] = {
 	"test_cgrp_from_id",
 };
 
+static void test_cgrp_from_id_ns(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct cgrp_kfunc_success *skel;
+	struct bpf_program *prog;
+	int pid, pipe_fd[2];
+
+	skel = open_load_cgrp_kfunc_skel();
+	if (!ASSERT_OK_PTR(skel, "open_load_skel"))
+		return;
+
+	if (!ASSERT_OK(skel->bss->err, "pre_mkdir_err"))
+		goto cleanup;
+
+	prog = skel->progs.test_cgrp_from_id_ns;
+
+	if (!ASSERT_OK(pipe(pipe_fd), "pipe"))
+		goto cleanup;
+
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork result")) {
+		close(pipe_fd[0]);
+		close(pipe_fd[1]);
+		goto cleanup;
+	}
+
+	if (pid == 0) {
+		int ret = 0;
+
+		close(pipe_fd[0]);
+
+		if (!ASSERT_GE(cgroup_setup_and_join("cgrp_from_id_ns"), 0, "join cgroup"))
+			exit(1);
+
+		if (!ASSERT_OK(unshare(CLONE_NEWCGROUP), "unshare cgns"))
+			exit(1);
+
+		ret = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+		if (!ASSERT_OK(ret, "test run ret"))
+			exit(1);
+
+		if (!ASSERT_OK(opts.retval, "test run retval"))
+			exit(1);
+
+		if (!ASSERT_EQ(write(pipe_fd[1], &ret, sizeof(ret)), sizeof(ret), "write pipe"))
+			exit(1);
+
+		exit(0);
+	} else {
+		int res;
+
+		close(pipe_fd[1]);
+
+		ASSERT_EQ(read(pipe_fd[0], &res, sizeof(res)), sizeof(res), "read res");
+		ASSERT_EQ(waitpid(pid, NULL, 0), pid, "wait on child");
+
+		remove_cgroup_pid("cgrp_from_id_ns", pid);
+
+		ASSERT_OK(res, "result from run");
+	}
+
+	close(pipe_fd[0]);
+cleanup:
+	cgrp_kfunc_success__destroy(skel);
+}
+
 void test_cgrp_kfunc(void)
 {
 	int i, err;
@@ -102,6 +170,9 @@ void test_cgrp_kfunc(void)
 		run_success_test(success_tests[i]);
 	}
 
+	if (test__start_subtest("test_cgrp_from_id_ns"))
+		test_cgrp_from_id_ns();
+
 	RUN_TESTS(cgrp_kfunc_failure);
 
 cleanup:
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c b/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
index 5354455a01be..02d8f160ca0e 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
@@ -221,3 +221,15 @@ int BPF_PROG(test_cgrp_from_id, struct cgroup *cgrp, const char *path)
 
 	return 0;
 }
+
+SEC("syscall")
+int test_cgrp_from_id_ns(void *ctx)
+{
+	struct cgroup *cg;
+
+	cg = bpf_cgroup_from_id(1);
+	if (!cg)
+		return 42;
+	bpf_cgroup_release(cg);
+	return 0;
+}
-- 
2.51.0


