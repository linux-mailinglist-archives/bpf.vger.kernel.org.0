Return-Path: <bpf+bounces-64523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7953EB13D09
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 16:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 572C47A2C80
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 14:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D604426E6ED;
	Mon, 28 Jul 2025 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qD+CJrJa"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F72026CE39
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712693; cv=none; b=fS5SIFM9SHTXjjK5qMGiA6Ofx1gSU1xAeYxA8qAjKXRUZBFXqDXCQ7YMaJPKf/yOe6OlgnSyVCbaXOkisjOvoX9kGREX6IPu9pLz6eHdbBTKNxQgYUDsHISR/ifO7zHrumwB/rpUhZXEZvT2oyP1jCOZVSv2ZsKVVGBjvaJkekE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712693; c=relaxed/simple;
	bh=RwsvN7h+MwIAp1Q3rRY5hTjTjLcDI1591n8pAm4pp5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ne791sTjnTLIRgo/6F9sIowj67s6XWYVZdA+c7jMCwRqJ1iYbXh4fGzn0+iH/iLGGXDEeRW4I9vyFYddaSkoBXn3p72Q7sQbfWhVxX+vbVyI1PzoHu00V58CJerLsTikRdIFLOnawepSCLujLsG/55YC4pCPWx3oN5W11TyREV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qD+CJrJa; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753712689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2UtlBjYCHd4WXPHz2y7B6ReYPn5VzXGTSRNx+oZieM=;
	b=qD+CJrJapOE3LYAKFbckTc9BiX3PWEMD92mdjVnI0Ruhp0wDo9zG1WYRVcUxsrNxqJqE00
	qug4Ol4SuV5ld/K3/Xz/Lhf0c88XlWMmp+iHFmhAx3FPE7XCscn7Jl/lUholEwG6r2sNHU
	SpB7cKzOIcdrDdEJ7RhyIR+EOzbZNUM=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	menglong8.dong@gmail.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next 5/5] selftests/bpf: Add case to test freplace attach failure log
Date: Mon, 28 Jul 2025 22:23:46 +0800
Message-ID: <20250728142346.95681-6-leon.hwang@linux.dev>
In-Reply-To: <20250728142346.95681-1-leon.hwang@linux.dev>
References: <20250728142346.95681-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Test the new libbpf API 'bpf_program__attach_freplace_log()':

 cd tools/testing/selftests/bpf/
 ./test_progs -t tracing_failure/freplace_attach_log
 #468/3   tracing_failure/freplace_attach_log:OK
 #468     tracing_failure:OK
 Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../bpf/prog_tests/tracing_failure.c          | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
index a222df765bc3..05c3a5a9db2a 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
@@ -2,6 +2,8 @@
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
 #include <test_progs.h>
 #include "tracing_failure.skel.h"
+#include "tailcall_bpf2bpf1.skel.h"
+#include "freplace_global_func.skel.h"
 
 static void test_bpf_spin_lock(bool is_spin_lock)
 {
@@ -28,10 +30,51 @@ static void test_bpf_spin_lock(bool is_spin_lock)
 	tracing_failure__destroy(skel);
 }
 
+static void test_freplace_attach_log(void)
+{
+	struct freplace_global_func *freplace_skel = NULL;
+	struct tailcall_bpf2bpf1 *tailcall_skel = NULL;
+	struct bpf_link *freplace_link = NULL;
+	struct bpf_program *prog;
+	char log_buf[64];
+	int err, prog_fd;
+
+	tailcall_skel = tailcall_bpf2bpf1__open_and_load();
+	if (!ASSERT_OK_PTR(tailcall_skel, "tailcall_bpf2bpf1__open_and_load"))
+		return;
+
+	freplace_skel = freplace_global_func__open();
+	if (!ASSERT_OK_PTR(freplace_skel, "freplace_global_func__open"))
+		goto out;
+
+	prog = freplace_skel->progs.new_test_pkt_access;
+	prog_fd = bpf_program__fd(tailcall_skel->progs.entry);
+	err = bpf_program__set_attach_target(prog, prog_fd, "entry");
+	if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
+		goto out;
+
+	err = freplace_global_func__load(freplace_skel);
+	if (!ASSERT_OK(err, "freplace_global_func__load"))
+		goto out;
+
+	log_buf[0] = '\0';
+	freplace_link = bpf_program__attach_freplace_log(prog, prog_fd, "subprog_tail", log_buf,
+							 sizeof(log_buf));
+	ASSERT_ERR_PTR(freplace_link, "bpf_program__attach_freplace_log");
+	ASSERT_STREQ(log_buf, "subprog_tail() is not a global function\n", "log_buf");
+
+out:
+	bpf_link__destroy(freplace_link);
+	freplace_global_func__destroy(freplace_skel);
+	tailcall_bpf2bpf1__destroy(tailcall_skel);
+}
+
 void test_tracing_failure(void)
 {
 	if (test__start_subtest("bpf_spin_lock"))
 		test_bpf_spin_lock(true);
 	if (test__start_subtest("bpf_spin_unlock"))
 		test_bpf_spin_lock(false);
+	if (test__start_subtest("freplace_attach_log"))
+		test_freplace_attach_log();
 }
-- 
2.50.1


