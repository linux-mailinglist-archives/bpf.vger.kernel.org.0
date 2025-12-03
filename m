Return-Path: <bpf+bounces-76001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 846B0CA1FA2
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 00:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CFCB3040A51
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 23:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7E12F39D6;
	Wed,  3 Dec 2025 23:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cb5J8Gk2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8312F39B7
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 23:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764805078; cv=none; b=nJ4PxXRX64IvQC8Ysl6r4gi1gySEst2/JclCpAmteQYA+zT8o2HzReCtx2wyljrIxik5RqXruP1bUsEZjfGcRVK+P1rQ6/7wFf3KEJh7TCcZRSk4xY/HCUUk5f3VXRGw1zaqO7hDIRqokhvGajHtlL65ZV17z6ByEsH87LSCjlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764805078; c=relaxed/simple;
	bh=b2+mo05KHmvIFruIXAYw3DLQ1dMZzy0HjD8vNsxkQgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pt2tJV7LIkiguvF1fWTOxogFeZdjPh5veTr0NnuIzyrYirS9BnzNncFTEDJQzHe+vULcofq8pv9I/AR0dP2OnQHTmxy29nuEQf68Hbvj43XGJT9IQkD42jFriTNvgDaYzLhks9fpbt3/YiDNFhHfRMf8Wr1is5ZGJFn5QYq4y2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cb5J8Gk2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297d4a56f97so4619595ad.1
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 15:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764805076; x=1765409876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5Z3VvHmgKK+clwAW2hreL2ZCB9Y13djD3aVcskyvAw=;
        b=Cb5J8Gk2UwRNbjx/sOJ/1LFrXAY+EgcPZXpESaUoTaEjPYWhPF6Zs27YiVX3mE7pli
         P/FbN3PvBgYh7KYFdOzz30axerTcrlwiJHEu3OdFSHnk1LJe8t2IHtviJkS6ln7otbNi
         HDZHltHQWhFVBbcrZXbzCHZiBrpStS2WUkAO+JNObxyKwssti7ncIaeyYBZr1QIGkuDY
         GXuTDZfTRd093+X+YodZM/3YW1hTFDisDtttyOR2iPi8umkYj5bZkIC+au84bgUP6+Tf
         +2Q7XHLTp42ksMUjWRAx5PFRyscqCWSmQkb0gV1podNDLDhflSp63Vxbs9OsVP0ouluo
         i/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764805076; x=1765409876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E5Z3VvHmgKK+clwAW2hreL2ZCB9Y13djD3aVcskyvAw=;
        b=mCxFKRVgar5Kfm+GeL1Zx4Vazk/CUL0wL4oFNwleCGH6UAJy82YWkpg4W7thAjCOLg
         0vmdgqq11UzwkAJqmiEe36My+BEglhks/JfNB6Z2PUhrH1jEU3uzTQpLPwcUB+H1C7hH
         +QSthtms3faZehHn5syUzY4Kr9D7vxQX3QwK3a+GU5yD5u/tO7Lot3wXWgUERNxap2Ia
         wymh3cYUAb2X5KJwkVt3BFdT6lR9xf/f056xnPFmz8G6raS0JsvS3qwjczOjVBHFlZcD
         RVgTYDNzQHXJfl9WC/JxRGkBFWY5bDI/IXewxBXMhVWQ+bnsYzOC17eInBQiA4l/v1pA
         3AXA==
X-Gm-Message-State: AOJu0YyKLlmhIvo6NVn7YPrPKi1fekjQCRGilQi3U2po8FuqtjHzlP2P
	Hqh8yW7Z0SGsAJgBBzCzB+HxWQNio47APRNaKgnBRyEZaq3TeQovkOEBz+HPAw==
X-Gm-Gg: ASbGnctrT3UTert7T2KDvqUijyKq+ACScnsxu0YfZ8JCHesqT0aMaKg6/CuM9LipEx7
	92fbHj6mYMLykc2YIcD8uVv6Nx3Q5DNpcVYIPpzmtP40/ED7R4xKufEXIDOYoqSOVHaZjyOEbW0
	cemMQz9lj8wruXBAVnl4zvW6t2RlzeQOOvYycYhRPkcatfxxbOdtaQZsYAtwySth8HKJQfv6Vb+
	/ma3uUbjrJgPtHKPPa826SBHSWniR9eWTqYnT0/dMt/5nOvIQOS9YtQ+jv9BSpWxizQAS8zSvNX
	TofEuF27db04XduavgfRveqR9lWidhYD4CF8vuq1Qog/pylyvrSYEMQqz2qynCMp3sE6pefWEh2
	kCa/OzcjnLLp4W9Zd6LQjvAs98t4z65nS71ZSrBy0LZDFY3v4KsY3+ZkisUH6S5sMFF295FV071
	1iM0ez8JXxEVgCDA==
X-Google-Smtp-Source: AGHT+IHclGT+vWQEi132dUdvQFuEDPzqEDT8MXre0ExH2p2PtJ7dQyaW96ATHSuw56RCAKFgNeqUSw==
X-Received: by 2002:a17:902:daca:b0:298:529b:8956 with SMTP id d9443c01a7336-29d684767a9mr45615665ad.56.1764805076119;
        Wed, 03 Dec 2025 15:37:56 -0800 (PST)
Received: from localhost ([2a03:2880:ff:56::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb40276sm196322845ad.73.2025.12.03.15.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 15:37:55 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v8 5/6] selftests/bpf: Test ambiguous associated struct_ops
Date: Wed,  3 Dec 2025 15:37:47 -0800
Message-ID: <20251203233748.668365-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251203233748.668365-1-ameryhung@gmail.com>
References: <20251203233748.668365-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test to make sure implicit struct_ops association does not
break backward compatibility nor return incorrect struct_ops.
struct_ops programs should still be allowed to be reused in
different struct_ops map. The associated struct_ops map set implicitly
however will be poisoned. Trying to read it through the helper
bpf_prog_get_assoc_struct_ops() should result in a NULL pointer.

While recursion of test_1() cannot happen due to the associated
struct_ops being ambiguois, explicitly check for it to prevent stack
overflow if the test regresses.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_assoc.c    | 38 ++++++++++
 .../bpf/progs/struct_ops_assoc_reuse.c        | 75 +++++++++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc_reuse.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
index 1e24a4915524..02173504f675 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
@@ -2,6 +2,7 @@
 
 #include <test_progs.h>
 #include "struct_ops_assoc.skel.h"
+#include "struct_ops_assoc_reuse.skel.h"
 
 static void test_st_ops_assoc(void)
 {
@@ -65,8 +66,45 @@ static void test_st_ops_assoc(void)
 	struct_ops_assoc__destroy(skel);
 }
 
+static void test_st_ops_assoc_reuse(void)
+{
+	struct struct_ops_assoc_reuse *skel = NULL;
+	int err;
+
+	skel = struct_ops_assoc_reuse__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_assoc_reuse__open"))
+		goto out;
+
+	err = bpf_program__assoc_struct_ops(skel->progs.syscall_prog_a,
+					    skel->maps.st_ops_map_a, NULL);
+	ASSERT_OK(err, "bpf_program__assoc_struct_ops(syscall_prog_a, st_ops_map_a)");
+
+	err = bpf_program__assoc_struct_ops(skel->progs.syscall_prog_b,
+					    skel->maps.st_ops_map_b, NULL);
+	ASSERT_OK(err, "bpf_program__assoc_struct_ops(syscall_prog_b, st_ops_map_b)");
+
+	err = struct_ops_assoc_reuse__attach(skel);
+	if (!ASSERT_OK(err, "struct_ops_assoc__attach"))
+		goto out;
+
+	/* run syscall_prog that calls .test_1 and checks return */
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.syscall_prog_a), NULL);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.syscall_prog_b), NULL);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+
+	ASSERT_EQ(skel->bss->test_err_a, 0, "skel->bss->test_err_a");
+	ASSERT_EQ(skel->bss->test_err_b, 0, "skel->bss->test_err_b");
+
+out:
+	struct_ops_assoc_reuse__destroy(skel);
+}
+
 void test_struct_ops_assoc(void)
 {
 	if (test__start_subtest("st_ops_assoc"))
 		test_st_ops_assoc();
+	if (test__start_subtest("st_ops_assoc_reuse"))
+		test_st_ops_assoc_reuse();
 }
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_assoc_reuse.c b/tools/testing/selftests/bpf/progs/struct_ops_assoc_reuse.c
new file mode 100644
index 000000000000..5bb6ebf5eed4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_assoc_reuse.c
@@ -0,0 +1,75 @@
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
+#define MAP_A_MAGIC 1234
+int test_err_a;
+int recur;
+
+/*
+ * test_1_a is reused. The kfunc should not be able to get the associated
+ * struct_ops and call test_1 recursively as it is ambiguous.
+ */
+SEC("struct_ops")
+int BPF_PROG(test_1_a, struct st_ops_args *args)
+{
+	int ret;
+
+	if (!recur) {
+		recur++;
+		ret = bpf_kfunc_multi_st_ops_test_1_impl(args, NULL);
+		if (ret != -1)
+			test_err_a++;
+		recur--;
+	}
+
+	return MAP_A_MAGIC;
+}
+
+/* Programs associated with st_ops_map_a */
+
+SEC("syscall")
+int syscall_prog_a(void *ctx)
+{
+	struct st_ops_args args = {};
+	int ret;
+
+	ret = bpf_kfunc_multi_st_ops_test_1_impl(&args, NULL);
+	if (ret != MAP_A_MAGIC)
+		test_err_a++;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_multi_st_ops st_ops_map_a = {
+	.test_1 = (void *)test_1_a,
+};
+
+/* Programs associated with st_ops_map_b */
+
+int test_err_b;
+
+SEC("syscall")
+int syscall_prog_b(void *ctx)
+{
+	struct st_ops_args args = {};
+	int ret;
+
+	ret = bpf_kfunc_multi_st_ops_test_1_impl(&args, NULL);
+	if (ret != MAP_A_MAGIC)
+		test_err_b++;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_multi_st_ops st_ops_map_b = {
+	.test_1 = (void *)test_1_a,
+};
-- 
2.47.3


