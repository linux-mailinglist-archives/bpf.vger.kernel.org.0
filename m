Return-Path: <bpf+bounces-64842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F05ECB177DA
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 23:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13D73B14E4
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 21:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1562E1D07BA;
	Thu, 31 Jul 2025 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XruprMPy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B0025F79A;
	Thu, 31 Jul 2025 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753996196; cv=none; b=oDefrsoY18VM1SlVMZGO9bpdUErMcpOcccjiNQrpRSpRehcUmJ9lF27bmr+sn6lT58qvtu1RYhefM+Ea6TBzQYYrFcL+5WczYuBtEYJw/XHPWmbf1n9C/sivTIlFz94hMuDSrONbDd/B/FhLTn0MizRDGFfdp1WoQh9DJYsz5Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753996196; c=relaxed/simple;
	bh=CVhW8Yy0MvlXu6PSs0vmMSbk4gyHepiCYpH6SLH/RZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTAmhfHtQ63ojauWAYPqMBu/c2zrpf1QkxhhcU2cZlUY5kAE3CvJgrzra5rBdYg/R0c47EbItZfJ1pC5AW4LFbViPYM60YVHOy01tTjC1LHt7w+NlUkZl+CR0aH0Yz/3tmZFH3iXryRVTiH8dFJjrJ1yf7VDaLLrefTQDlzS23s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XruprMPy; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76bd050184bso1237486b3a.2;
        Thu, 31 Jul 2025 14:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753996194; x=1754600994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5QMqYHT8ATUJCCYmRy0NklYO69OdqRBCvNnUdi7/U0=;
        b=XruprMPySprrjqn/9PZSyfZ3Hj9y61lx2b/Y6FXtd/znOIxrVo7JLxFZpBpNc571ji
         6Tk3kY1scGXeOzFFc81fNxc5O1Zsid3QwsVVZgHP+E+xEFFQSMMXVKQoY7eTnmwV1ltE
         +AynRSymMZKzpk3cU+jT/fKGrvHjSDs2ieNkH11vxFifQew5m7rEtbdW8ton53osxHA9
         /yAXQFR9MGWgEh4ocZ6lZDeF1+IxPTFYj7Oywq7NYMK7xUOP5jbols//E3vFJj9W1UQt
         GU2tp0pWKFMHOHZop8xseJ3dDkPPLJKYd8mD7HLoY3m8S6jTOTyyHlIiEjKf9tvRe7K7
         hprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753996194; x=1754600994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5QMqYHT8ATUJCCYmRy0NklYO69OdqRBCvNnUdi7/U0=;
        b=UWCmp5ahQHwaCxsZou8QXA6RkcyIN9uPtBmV/ELBdcltfLLfYTeEJrqgR/sA08kK5r
         RzRNJO6JuIX5FvsFGmJFkPC/iozmVYqH5KksTpFv6CwNbGJvrFDPk3OQg1h+L9DHbQ8F
         HAn2pwF2JI6QtcNVXx48Nvolk5w2dzLykTHBYoZvFoqv4zAEWmgZLa41VZ2VA6Lkabmv
         5RtG4kY3RdRaQ6cJe8p9YNm32+MAC10D7OXp3fres0N7/nuh9bsPLmdluo+SrmJrLR4s
         7kJfJfdK42R7f0ibWtP0JJy430qTcnCMB7DtHhvhNMNXq2isEMTY0RpyNU76ePls2nJP
         D0Aw==
X-Gm-Message-State: AOJu0YzfmtvsrsuL9AHHUJHejPS+WC7Zq48Egd7lilwgEqKvnt/3TMW9
	REjnJkrPst9mMYxbjafBR7mVkAxdwWaKia4LdvTfZKcpY0gRvBW3KZPzfKh5EQ==
X-Gm-Gg: ASbGncvQQaQgVir/4QIfV0fjeKXwpoENTRTZUFFC6dj/TrtankWWqNjoJ7Fozk1yVYO
	HCfLL+gTGhbdwbGNFv5itVhftIgyckzLrX5/xnl1uqTC0rmNr7Nzqpx82W4IZQpoGZVf+Kv1Ivp
	ZbIIxL/AET+TO9mTid0zIA37oMqHqwUprbcm2+QjO0+4YkutypcJn4CXSLbeAmtthGU0ze/ce3u
	Ut3Yk2wNTOxdAWCbfylLEQb9nKeKLeixlc4b0tSQAquJz/s1e7hp3WjDvfZrq/G0RRCbFKaYGjl
	Up2pAGLzrrGEwvh71Hy+jEXGFUMKVLhYV2gx/3JQ0kElzKCem0fhoZgjsWxUhZbQAjqC9OvyogM
	3FuwNdL7dXyYkhteVbZgnO7M=
X-Google-Smtp-Source: AGHT+IERk1mRUtx1++CGiUneiJ1pURerCNC6X4CyqiCyTDCf83LoHgomXOMOP8zvcTY2c2VmWwJuPQ==
X-Received: by 2002:a17:902:e848:b0:240:636c:df91 with SMTP id d9443c01a7336-24096aef320mr126810385ad.34.1753996194155;
        Thu, 31 Jul 2025 14:09:54 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8ab0a00sm25721355ad.177.2025.07.31.14.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 14:09:53 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 3/3] selftests/bpf: Test multi_st_ops and calling kfuncs from different programs
Date: Thu, 31 Jul 2025 14:09:50 -0700
Message-ID: <20250731210950.3927649-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250731210950.3927649-1-ameryhung@gmail.com>
References: <20250731210950.3927649-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test multi_st_ops and demonstrate how different bpf programs can call
a kfuncs that refers to the struct_ops instance in the same source file
by id. The id is defined as a global vairable and initialized before
attaching the skeleton. Kfuncs that take the id can hide the argument
with a macro to make it almost transparent to bpf program developers.

The test involves two struct_ops returning different values from
.test_1. In syscall and tracing programs, check if the correct value is
returned by a kfunc that calls .test_1.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../test_struct_ops_id_ops_mapping.c          | 77 +++++++++++++++++++
 .../bpf/progs/struct_ops_id_ops_mapping1.c    | 57 ++++++++++++++
 .../bpf/progs/struct_ops_id_ops_mapping2.c    | 57 ++++++++++++++
 3 files changed, 191 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_id_ops_mapping.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_id_ops_mapping1.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_id_ops_mapping2.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_id_ops_mapping.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_id_ops_mapping.c
new file mode 100644
index 000000000000..927524ac191d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_id_ops_mapping.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "struct_ops_id_ops_mapping1.skel.h"
+#include "struct_ops_id_ops_mapping2.skel.h"
+
+static void test_st_ops_id_ops_mapping(void)
+{
+	struct struct_ops_id_ops_mapping1 *skel1 = NULL;
+	struct struct_ops_id_ops_mapping2 *skel2 = NULL;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct bpf_map_info info = {};
+	__u32 len = sizeof(info);
+	int err, pid, prog1_fd, prog2_fd;
+
+	skel1 = struct_ops_id_ops_mapping1__open_and_load();
+	if (!ASSERT_OK_PTR(skel1, "struct_ops_id_ops_mapping1__open"))
+		goto out;
+
+	skel2 = struct_ops_id_ops_mapping2__open_and_load();
+	if (!ASSERT_OK_PTR(skel2, "struct_ops_id_ops_mapping2__open"))
+		goto out;
+
+	err = bpf_map_get_info_by_fd(bpf_map__fd(skel1->maps.st_ops_map),
+				     &info, &len);
+	if (!ASSERT_OK(err, "bpf_map_get_info_by_fd"))
+		goto out;
+
+	skel1->bss->st_ops_id = info.id;
+
+	err = bpf_map_get_info_by_fd(bpf_map__fd(skel2->maps.st_ops_map),
+				     &info, &len);
+	if (!ASSERT_OK(err, "bpf_map_get_info_by_fd"))
+		goto out;
+
+	skel2->bss->st_ops_id = info.id;
+
+	err = struct_ops_id_ops_mapping1__attach(skel1);
+	if (!ASSERT_OK(err, "struct_ops_id_ops_mapping1__attach"))
+		goto out;
+
+	err = struct_ops_id_ops_mapping2__attach(skel2);
+	if (!ASSERT_OK(err, "struct_ops_id_ops_mapping2__attach"))
+		goto out;
+
+	/* run tracing prog that calls .test_1 and checks return */
+	pid = getpid();
+	skel1->bss->test_pid = pid;
+	skel2->bss->test_pid = pid;
+	sys_gettid();
+	skel1->bss->test_pid = 0;
+	skel2->bss->test_pid = 0;
+
+	/* run syscall_prog that calls .test_1 and checks return */
+	prog1_fd = bpf_program__fd(skel1->progs.syscall_prog);
+	err = bpf_prog_test_run_opts(prog1_fd, &topts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+
+	prog2_fd = bpf_program__fd(skel2->progs.syscall_prog);
+	err = bpf_prog_test_run_opts(prog2_fd, &topts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+
+	ASSERT_EQ(skel1->bss->test_err, 0, "skel1->bss->test_err");
+	ASSERT_EQ(skel2->bss->test_err, 0, "skel2->bss->test_err");
+
+out:
+	if (skel1)
+		struct_ops_id_ops_mapping1__destroy(skel1);
+	if (skel2)
+		struct_ops_id_ops_mapping2__destroy(skel2);
+}
+
+void test_struct_ops_id_ops_mapping(void)
+{
+	if (test__start_subtest("st_ops_id_ops_mapping"))
+		test_st_ops_id_ops_mapping();
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_id_ops_mapping1.c b/tools/testing/selftests/bpf/progs/struct_ops_id_ops_mapping1.c
new file mode 100644
index 000000000000..a99b8b2aa2fb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_id_ops_mapping1.c
@@ -0,0 +1,57 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define bpf_kfunc_multi_st_ops_test_1(args) bpf_kfunc_multi_st_ops_test_1(args, st_ops_id)
+int st_ops_id;
+
+int test_pid;
+int test_err;
+
+#define MAP1_MAGIC 1234
+
+SEC("struct_ops")
+int BPF_PROG(test_1, struct st_ops_args *args)
+{
+	return MAP1_MAGIC;
+}
+
+SEC("tp_btf/sys_enter")
+int BPF_PROG(sys_enter, struct pt_regs *regs, long id)
+{
+	struct st_ops_args args = {};
+	struct task_struct *task;
+	int ret;
+
+	task = bpf_get_current_task_btf();
+	if (!test_pid || task->pid != test_pid)
+		return 0;
+
+	ret = bpf_kfunc_multi_st_ops_test_1(&args);
+	if (ret != MAP1_MAGIC)
+		test_err++;
+
+	return 0;
+}
+
+SEC("syscall")
+int syscall_prog(void *ctx)
+{
+	struct st_ops_args args = {};
+	int ret;
+
+	ret = bpf_kfunc_multi_st_ops_test_1(&args);
+	if (ret != MAP1_MAGIC)
+		test_err++;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_multi_st_ops st_ops_map = {
+	.test_1 = (void *)test_1,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_id_ops_mapping2.c b/tools/testing/selftests/bpf/progs/struct_ops_id_ops_mapping2.c
new file mode 100644
index 000000000000..4ad62963261f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_id_ops_mapping2.c
@@ -0,0 +1,57 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define bpf_kfunc_multi_st_ops_test_1(args) bpf_kfunc_multi_st_ops_test_1(args, st_ops_id)
+int st_ops_id;
+
+int test_pid;
+int test_err;
+
+#define MAP2_MAGIC 4567
+
+SEC("struct_ops")
+int BPF_PROG(test_1, struct st_ops_args *args)
+{
+	return MAP2_MAGIC;
+}
+
+SEC("tp_btf/sys_enter")
+int BPF_PROG(sys_enter, struct pt_regs *regs, long id)
+{
+	struct st_ops_args args = {};
+	struct task_struct *task;
+	int ret;
+
+	task = bpf_get_current_task_btf();
+	if (!test_pid || task->pid != test_pid)
+		return 0;
+
+	ret = bpf_kfunc_multi_st_ops_test_1(&args);
+	if (ret != MAP2_MAGIC)
+		test_err++;
+
+	return 0;
+}
+
+SEC("syscall")
+int syscall_prog(void *ctx)
+{
+	struct st_ops_args args = {};
+	int ret;
+
+	ret = bpf_kfunc_multi_st_ops_test_1(&args);
+	if (ret != MAP2_MAGIC)
+		test_err++;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_multi_st_ops st_ops_map = {
+	.test_1 = (void *)test_1,
+};
-- 
2.47.3


