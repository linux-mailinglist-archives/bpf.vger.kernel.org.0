Return-Path: <bpf+bounces-65142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCD1B1C9C3
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 18:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92DFB1749CD
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 16:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8865229A9C3;
	Wed,  6 Aug 2025 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLNIl6kQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E48D29ACED;
	Wed,  6 Aug 2025 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497548; cv=none; b=GsvwCagFKmeH/+tnfGa3OOq2ZJ1FbtLaGGxMD6AGZz/uJnVL+gg53VjePxcgKuJ2qs+hkv5YuW/DMWtNNtm9WBibONJZKxnedgPtN5WkQ/qapdHre+wjUTvuRL2EoWU5ddnnKyJH+W6fWzyrkSSO9wEmSjkv/w/bFVtDoFkLlOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497548; c=relaxed/simple;
	bh=ik1BVy8P7QDCfK2VV451z+3FF4NtkIHA6vllA+q+kCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8rqaHh3E4jlonBojzFjlJBe+ndaNGY8TZtKY2rg9bsb2vFIVjS8u5VMcPWR+XHauqVnppXLhAR/veErHxYTdCTNKO8gJ5Oe1ib5Qhp/NPdI3hbjt4qn/RW4C1Kh9I6KTtc8r8fhLCQqSLv/E+FG/l6fkeJdf0eVMxne8l6fQaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLNIl6kQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7426c44e014so126441b3a.3;
        Wed, 06 Aug 2025 09:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754497545; x=1755102345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuxfmeNOLVIBHpuIfIxq3sjTHMQqRbvSPqDkreNU4nk=;
        b=mLNIl6kQ3/W2YO8CSHbZarQWDVDoa0KOUocXqnF0fSSLfSjuSX3wRYwJDbAofU/EFa
         qJ7pmkmOzrl5qUvzpBcSSPQ/+isqCOOKamgNaFnySUYRLLdKJTRp93GGazNw5xcFpXs1
         SjP/gOSu6uIWj+12Y7CBBhyaMOlawmu+ryhogl8bBV0Sd33GNSUbR5sCLllrPQG4TcoT
         +6dFmIEyiEu/aSfwr/uNCiUOV7uaxgeMiUhRK9Swij4aySQIVvRRJgw3jMZWGatCaw05
         pfA8s+ZsC6HQWvdHz5plezYvONphw4mluVpZO9JauohGF8jSaquYv4PwM/QgQJuNMBPP
         8xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754497545; x=1755102345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuxfmeNOLVIBHpuIfIxq3sjTHMQqRbvSPqDkreNU4nk=;
        b=HqEWfl6b6tAJkKT6inMEp/lUTPKdEgSJOiZ/GTSelxOuX0A6YCl19ZPKFZnv0hj5KM
         V6Kwphq+qPM2QKFumn7/vjt2QoW5esB1nGuQk7y/RDQ0Jb4kzdyTh6M/W3cnyHQdpFhh
         +3YTg1c59Vc4Pjw0N1kGWfCp6RVDNdxnwarwtfE+Q2xI/3NcRvNkmtAkxE5c+4gKxstV
         oIQsIIZdxNU3UfOHI9EismwLvMY2nHTeuQl7PQ5VPN5YGg4iMfW9BID4tkE8hSloYiQn
         RqjbVC2uLND5qx82k7JoaqLogqjMw+7Cay3cudna4QnKqZ1QOBSbIDtQoaaAVZqHmjnP
         ZD7A==
X-Gm-Message-State: AOJu0YxTK0B46wQrVHFdxqDrj6Zjz+f7gqmw/ftAc88IjBxqW8UcqPZ9
	fLfQHARvH5TubjCMcLyyZ0v8K5sNU9/9i9NJ/nbMLVFiEENBRoNJzIdkh2nbjg==
X-Gm-Gg: ASbGnct7bgEHFmgDUBowJdobZ6xID8CCyukvNDJJFgjUvd1b4oNZ7qyFREdGZdV4Vc6
	nstQbRM9CmZpv96tLx6HXG3fr6N2kdNt97JWhhs29rsVxJ/JT9msHGiHNrSugxovQOaIqaK4Fiu
	/TJgwu4mfy8LG0AMV0W+hqRJuECDuwNYqfQXgVvSrmyELS+7ZgiMdwEN5lvGblIp8mFWNHDLv19
	muuirwQGzKs0cDy3kYRbZpnGdGddWMZ1JD63RptLQY2uQQ1uevB0nrTWSbZWnCpmz9leo1fdn1N
	+fRCHG7pTd3QqFO/ZtL847dqJ1L4dOwdCUJHowNOgq61+L83KH/yUhKrsu0FYupoSNH7fyrSvRN
	seVvP3DkD9z4pJwRJaoGCgnWyCa2S/yLGFQ==
X-Google-Smtp-Source: AGHT+IGa/Fq6DAXnTHOqc9uwgqR5Mcg9Mf0sxmYBqk8Z6ZYL3lIP/fDU12PQhg6/ZmAY+h02HquYNg==
X-Received: by 2002:a05:6a20:9389:b0:240:af8:176b with SMTP id adf61e73a8af0-240312d0baamr5454961637.19.1754497545292;
        Wed, 06 Aug 2025 09:25:45 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4236edbb31sm12830813a12.55.2025.08.06.09.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 09:25:44 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Test multi_st_ops and calling kfuncs from different programs
Date: Wed,  6 Aug 2025 09:25:40 -0700
Message-ID: <20250806162540.681679-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250806162540.681679-1-ameryhung@gmail.com>
References: <20250806162540.681679-1-ameryhung@gmail.com>
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
 .../bpf/progs/struct_ops_id_ops_mapping1.c    | 59 ++++++++++++++
 .../bpf/progs/struct_ops_id_ops_mapping2.c    | 59 ++++++++++++++
 3 files changed, 195 insertions(+)
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
index 000000000000..ad8bb546c9bf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_id_ops_mapping1.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+
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
index 000000000000..cea1a2f4b62f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_id_ops_mapping2.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+
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


