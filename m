Return-Path: <bpf+bounces-38192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B83961700
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 20:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF571C230D3
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 18:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED96E1D2F47;
	Tue, 27 Aug 2024 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FDN0/Wsk"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47B11D279D
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724783411; cv=none; b=Pupmc7OaJxxaiHwkgxa4v8E0QYSjXbS3iJUPmz4I2jfZhTwrnvGrFRat1VUOVFwBTBmMbPYsXwDmJptg21fEfNPqJXbqx182XuwhzxNophEX3owef8vYNNYPtcqIqKwo2iqJaQ8rXjLw2lrg0uuxHsErsp4U5LLgJ3am5p/87ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724783411; c=relaxed/simple;
	bh=P5vL0GU2GdAXpXOJZpCtJiJ41Rl5TvhlKGALkhvRpOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBg6o++3EzgsGqn+RfS/EmmlDaabOr1Z69lvwwj9nThHXX+niT3jOo7GSI5ZNtH9jIrR32+yKrwn1jLRodbfIiTVplbU45fQCQAnR5x/vbUio9i9VuFFqgNI1cUnqys/tTS7DZxrN5bVdnDjHft1oDAnVtCY55t09uxdfQBewXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FDN0/Wsk; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724783407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9rIum6Tlk68haTWumoIKSXGOj7KCH1RT3rD2OnSeY90=;
	b=FDN0/WskIqb/SKchu3j+TBPiGVObRW2MQHkKZsg9JAuet0Jl2jd7xsqSk4nYnv+KctlNW7
	ZSYI78jc0NziD+Xe11Ydx8zFm2HU2GbftLjNKW48LbgzMbUHDeDJ/1pIA+0xL/MkzJZ5U2
	TAhkUKuBCAXLUb8RUiWVn8THsQzmCmE=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v3 bpf-next 7/9] selftests/bpf: Add tailcall epilogue test
Date: Tue, 27 Aug 2024 11:29:57 -0700
Message-ID: <20240827182957.893616-1-martin.lau@linux.dev>
In-Reply-To: <20240827181647.847890-1-martin.lau@linux.dev>
References: <20240827181647.847890-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch adds a gen_epilogue test to test a main prog
using a bpf_tail_call.

A non test_loader test is used. The tailcall target program,
"test_epilogue_subprog", needs to be used in a struct_ops map
before it can be loaded. Another struct_ops map is also needed
to host the actual "test_epilogue_tailcall" struct_ops program
that does the bpf_tail_call. The earlier test_loader patch
will attach all struct_ops maps but the bpf_testmod.c does
not support >1 attached struct_ops.

The earlier patch used the test_loader which has already covered
checking for the patched pro/epilogue instructions. This is done
by the __xlated tag.

This patch goes for the regular skel load and syscall test to do
the tailcall test that can also allow to directly pass the
the "struct st_ops_args *args" as ctx_in to the
SEC("syscall") program.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../selftests/bpf/prog_tests/pro_epilogue.c   | 38 ++++++++++++
 .../selftests/bpf/progs/epilogue_tailcall.c   | 58 +++++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/epilogue_tailcall.c

diff --git a/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
index 69e4a5a1756d..98de677c55a9 100644
--- a/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
+++ b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
@@ -4,9 +4,47 @@
 #include <test_progs.h>
 #include "pro_epilogue_subprog.skel.h"
 #include "pro_epilogue_kfunc.skel.h"
+#include "epilogue_tailcall.skel.h"
+
+struct st_ops_args {
+	int a;
+};
+
+static void test_tailcall(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct epilogue_tailcall *skel;
+	struct st_ops_args args;
+	int err, prog_fd;
+
+	skel = epilogue_tailcall__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "epilogue_tailcall__open_and_load"))
+		return;
+
+	topts.ctx_in = &args;
+	topts.ctx_size_in = sizeof(args);
+
+	skel->links.epilogue_tailcall =
+		bpf_map__attach_struct_ops(skel->maps.epilogue_tailcall);
+	if (!ASSERT_OK_PTR(skel->links.epilogue_tailcall, "attach_struct_ops"))
+		goto done;
+
+	/* tailcall prog + gen_epilogue */
+	memset(&args, 0, sizeof(args));
+	prog_fd = bpf_program__fd(skel->progs.syscall_epilogue_tailcall);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+	ASSERT_EQ(args.a, 10001, "args.a");
+	ASSERT_EQ(topts.retval, 10001 * 2, "topts.retval");
+
+done:
+	epilogue_tailcall__destroy(skel);
+}
 
 void test_pro_epilogue(void)
 {
 	RUN_TESTS(pro_epilogue_subprog);
 	RUN_TESTS(pro_epilogue_kfunc);
+	if (test__start_subtest("tailcall"))
+		test_tailcall();
 }
diff --git a/tools/testing/selftests/bpf/progs/epilogue_tailcall.c b/tools/testing/selftests/bpf/progs/epilogue_tailcall.c
new file mode 100644
index 000000000000..7275dd594de0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/epilogue_tailcall.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "../bpf_testmod/bpf_testmod.h"
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+static __noinline __used int subprog(struct st_ops_args *args)
+{
+	args->a += 1;
+	return args->a;
+}
+
+SEC("struct_ops/test_epilogue_subprog")
+int BPF_PROG(test_epilogue_subprog, struct st_ops_args *args)
+{
+	subprog(args);
+	return args->a;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+	__array(values, void (void));
+} epilogue_map SEC(".maps") = {
+	.values = {
+		[0] = (void *)&test_epilogue_subprog,
+	}
+};
+
+SEC("struct_ops/test_epilogue_tailcall")
+int test_epilogue_tailcall(unsigned long long *ctx)
+{
+	bpf_tail_call(ctx, &epilogue_map, 0);
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_st_ops epilogue_tailcall = {
+	.test_epilogue = (void *)test_epilogue_tailcall,
+};
+
+SEC(".struct_ops.link")
+struct bpf_testmod_st_ops epilogue_subprog = {
+	.test_epilogue = (void *)test_epilogue_subprog,
+};
+
+SEC("syscall")
+int syscall_epilogue_tailcall(struct st_ops_args *args)
+{
+	return bpf_kfunc_st_ops_test_epilogue(args);
+}
-- 
2.43.5


