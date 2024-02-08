Return-Path: <bpf+bounces-21550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B6784EAEC
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 22:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3E128F4A5
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 21:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5914F5EF;
	Thu,  8 Feb 2024 21:54:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21EB4F5ED
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 21:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429283; cv=none; b=lndBH06R0JN8Ry5RNhos4o70TMxJV8GitkynAEB674V1d3rGrGO7Zc5SwnLGzrI+m5gRT8ZORwuMndPvFETK75UvVH+mMTVSvStxsFXW3MPxa1FYzZr2GDYGh4Bay6j0XyB9Zqg0naPxKnGa4U8A57pSBXwFpklAVu/cyNUaw+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429283; c=relaxed/simple;
	bh=g7cMBzQ9PcdLLCrcgouFWmtnHhEp/iuVczebiWL/lq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HjRRlT/IFkCjE00Xm9X8BtwbYxElw0MI7JZzRI0dbwB3BmhMHGOE1ZvYfJJoyTnWWUL+Kk/0sPt1NxUDj+aRvtP2aXmTq1IktMXWHSZ0kAE7gbvAiO7AcXLYDtUVvkmgtwP+SV02A2ucgxp+Va1gpj7WEIVWFmtsaKVO5ZgjHvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id ABCB726CC7F; Thu,  8 Feb 2024 13:54:27 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add a negative test for stack accounting in jit mode
Date: Thu,  8 Feb 2024 13:54:27 -0800
Message-Id: <20240208215427.111319-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240208215422.110920-1-yonghong.song@linux.dev>
References: <20240208215422.110920-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The new test is very similar to test_global_func1.c, but
is modified to fail on jit mode.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/prog_tests/test_global_funcs.c        |  3 ++
 .../selftests/bpf/progs/test_global_func18.c  | 44 +++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func18.=
c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b=
/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
index a3a41680b38e..dccbf2213135 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
@@ -18,6 +18,7 @@
 #include "test_global_func15.skel.h"
 #include "test_global_func16.skel.h"
 #include "test_global_func17.skel.h"
+#include "test_global_func18.skel.h"
 #include "test_global_func_ctx_args.skel.h"
=20
 #include "bpf/libbpf_internal.h"
@@ -140,6 +141,8 @@ void test_test_global_funcs(void)
 {
 	if (!env.jit_enabled) {
 		RUN_TESTS(test_global_func1);
+	} else {
+		RUN_TESTS(test_global_func18);
 	}
=20
 	RUN_TESTS(test_global_func2);
diff --git a/tools/testing/selftests/bpf/progs/test_global_func18.c b/too=
ls/testing/selftests/bpf/progs/test_global_func18.c
new file mode 100644
index 000000000000..d1aa3b2c68fe
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_func18.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#define MAX_STACK1 (512 - 3 * 32 + 8)
+#define MAX_STACK2 (3 * 32)
+
+__attribute__ ((noinline))
+int f1(struct __sk_buff *skb)
+{
+	return skb->len;
+}
+
+int f3(int, struct __sk_buff *skb, int);
+
+__attribute__ ((noinline))
+int f2(int val, struct __sk_buff *skb)
+{
+	volatile char buf[MAX_STACK1] =3D {};
+
+	__sink(buf[MAX_STACK1 - 1]);
+
+	return f1(skb) + f3(val, skb, 1);
+}
+
+__attribute__ ((noinline))
+int f3(int val, struct __sk_buff *skb, int var)
+{
+	volatile char buf[MAX_STACK2] =3D {};
+
+	__sink(buf[MAX_STACK2 - 1]);
+
+	return skb->ifindex * val * var;
+}
+
+SEC("tc")
+__failure __msg("combined stack size of 3 calls is 528")
+int global_func18(struct __sk_buff *skb)
+{
+	return f1(skb) + f2(2, skb) + f3(3, skb, 4);
+}
--=20
2.39.3


