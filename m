Return-Path: <bpf+bounces-72164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A97E9C082EE
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 23:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752501C21D90
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 21:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2CA303CBF;
	Fri, 24 Oct 2025 21:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPLIFnnV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A613054EA
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 21:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761341362; cv=none; b=HP9xqdbSP8cmUSnVt8+FNWTl3eoVXr0adJfyL/E9hwsT5K0OF3c2CHq3laO1LF8ExHis4YWpMdNBHIeaUoTPiCHkTaM7rFGhBlGKsbm2yoJgVFqSy6UrkX6Be6x8cV2bpM7uLJos6H3Y4fkUelWEPB5gvy2AtrDZiHQdjYkcfu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761341362; c=relaxed/simple;
	bh=r2cpypKNtoxrCoOvB0Flt6y7nwCGfjTBReWiMPCT4XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3OjB5A5r8Nmk8bJWwThhLAEJEMcTaFppLEdT+9aDjbEfjZGMAABIUBWO+3q9ONf/HG1IAN1JcakYXY3jBmVFn6GRbW0qgGtgtWE5uKdY7KsOpmDJCR6yXcO8Zxmr/HrAimloZDzbHjHCfa0W896rLcerNGWxvFEeAy52/aO284=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPLIFnnV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27c369f8986so22185835ad.3
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 14:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761341360; x=1761946160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kxji5vPXaBJXOxG97hmDiCyJP+BVSgMVlP1dhR088Aw=;
        b=UPLIFnnVRnazlQ9/bk+bn1gf5lXyEKzrzWI2en6ViSG+zjIx6a9VzzlLTqfuV8NMIQ
         oTKKeJPw0ujQkp8kBaaDkJKfEPULi2EhZOGZr3gdQo8ridnBLGrkulBxChwnUkUFcuBk
         PXz+VSsqUf5Y4XOhBVDPfuW4+YWbUtKDOD2XI5duJX42y0pm/vVvIczaSfRcH5LqGoTU
         23bSdTKU3z+KLqVlL1FXuBlhsjbewkrywHUMnGHCiX/JVbpsq/t4fYC94jkJiVm7nAqr
         Jd4VOyE4Vs2UKHBmlZhe/L0ylDQnGtgyauk0v8G+2pXwHNRwb19CZ7IRmLNQXsrTbVBe
         icVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761341360; x=1761946160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kxji5vPXaBJXOxG97hmDiCyJP+BVSgMVlP1dhR088Aw=;
        b=fyF15cWkiZTdK5b5Xjikq6LnoGwttiCwGMbRGRrlLCQ6CkoxLBsEtAYHUYrO06Y4Vz
         eZ0rxqQrY66P67vKXRHYnCkRKI/32SS1Ms5sxwfoBN37/0SOnvuXbvKj1fEeDs3/9fA0
         50MSgIv8YfRSeaCbf7Jz+whMZlYwIXsP3mxoBo+LPT0JKtkU3j/+38FdUnDCW/m7TfQJ
         BVLWyagA7zeRlcNKGesDHrimAZ2K0lrJ9AiP09ESglVxSUSA2+/frZ93iqepyIntbSWk
         XTf1LaOnUMFZrDfmd7Rrr8fHelxENu5SpwmBbgnO9Km4m124LqA/uuv6zWbzaU2PN+rO
         /SRQ==
X-Gm-Message-State: AOJu0Yx5lJyhXHQgi8+H5cLV1sT0eB+DSL6rdxTfq38nei4qpctjmLPA
	DBZQLv3C89UZBjSkNcv91AmkKiJ9AZ3W2YgStMvdDaz9McHA0BTvaVnJgqZ7WA==
X-Gm-Gg: ASbGncs4Vj/trV25OUFU3j/C+bJTUhe1sPdy4ixFZ85i9hxuM0frkhyvmlHPK3vXwGE
	WMKQTqfoCLhduMvHUYv9yFnqwNIymn6M+eONm8NS6peNEE2DvgNAMmPTMSezIp67eh3rvG57lTZ
	wNhYDOosWk/IiK3qOslbhBCGddaFs/E0cEf3k4E9/+E8t9asEqHnT1JLOYe+Gmdc1mWJ5JijBkw
	WgFcrzEWtbBi8tF+xzDCk5vYSuEpZ9S7GB+5WSTvsHO2dsnvy7IEnluvjmn7MRBZ/WI8WrqaJ0+
	HXHSbTJemfPaO50ipXlczXgBUa4vLUJclZb6ceH32XBZOxZHTo8Zb8SdyI5/NpDy8LoTUeypNJ0
	m59ihbN3bGLf70iCZ5+ZS4+lAQ4AxRTlowcIgcimWJlVWcDvcEqkw8eiHTlzhHxfWmupdcv0IgK
	nDZw==
X-Google-Smtp-Source: AGHT+IE/H+mcnDamh+XsMwVUPM1Zz3aChiuIHmNBUtifeQlhfMUmVhkDcubthLuP99pAF9GIuOPAww==
X-Received: by 2002:a17:902:ccc3:b0:28e:9a74:7b58 with SMTP id d9443c01a7336-2948ba3ba9dmr50888565ad.31.1761341359980;
        Fri, 24 Oct 2025 14:29:19 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0ac07sm2044045ad.43.2025.10.24.14.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 14:29:19 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 5/6] selftests/bpf: Test ambiguous associated struct_ops
Date: Fri, 24 Oct 2025 14:29:13 -0700
Message-ID: <20251024212914.1474337-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024212914.1474337-1-ameryhung@gmail.com>
References: <20251024212914.1474337-1-ameryhung@gmail.com>
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
index 29e8b58a14fa..f69306cb8974 100644
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
+	ASSERT_OK(err, "bpf_program__assoc_struct_ops");
+
+	err = bpf_program__assoc_struct_ops(skel->progs.syscall_prog_b,
+					    skel->maps.st_ops_map_b, NULL);
+	ASSERT_OK(err, "bpf_program__assoc_struct_ops");
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
index 000000000000..caaa45bdccc2
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
+		ret = bpf_kfunc_multi_st_ops_test_1_prog_arg(args, NULL);
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
+	ret = bpf_kfunc_multi_st_ops_test_1_prog_arg(&args, NULL);
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
+	ret = bpf_kfunc_multi_st_ops_test_1_prog_arg(&args, NULL);
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


