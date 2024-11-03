Return-Path: <bpf+bounces-43855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F0E9BA976
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 00:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79CC1F21385
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 23:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D4A18CC04;
	Sun,  3 Nov 2024 22:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUfU0ivY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEF018B497
	for <bpf@vger.kernel.org>; Sun,  3 Nov 2024 22:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730674789; cv=none; b=YG7DWuZEziRbRAgRQoynV4znN5Ja6B5KY0zh6PW3du64tld4j20Pe5muUuMhxwpyWAV08dxO2xnyMb36Sp6QbevIbSoGkw6tuaAB4W9GYhDLzvdQjdZFJ9IE/BgHKDnik/Re6KbpbjXA93LJurHy6QCN+8W44cAJ8yCiSE6Se1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730674789; c=relaxed/simple;
	bh=T0ikGcuZLizG+9qdvlh2bCrtYoBDsSk1JaKHw8b29HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCkMSpBBZWJgA7rzQfpqmBdgKI+ofzx2v2+kEnNfjXFjviCOBNB+j+Z024tsTGR2tEABRFoXiVL4GaJp/RcDEhwOTYXdwKTGexscFb9TcstKjlE9jytI6n5t3kiAGkZf0gT/hMx1VENJr2UxL4Q0S9ammlJw7vNSShTwWgtgbEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUfU0ivY; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-37d50fad249so2650176f8f.1
        for <bpf@vger.kernel.org>; Sun, 03 Nov 2024 14:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730674786; x=1731279586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8W8p0I3ZORpkSffN3EQ//vJwQVZRFBeB8L+KyUHq4I=;
        b=iUfU0ivYll+VuPgUOPW63l1y4ob5lvBuny0wpkApJy+lMJwGfcAXpTR+D9MfzJjMs8
         uR/DXvHrLFr2AkuouyHwASwF/A1y0Av2q25hWebcQUVLwDeY7lI29Sh4A211iwFfIx2M
         MYMC0nBEijHzNdnNNWQjZLUbrAPUXJu7rnWZ+EmyvyHdd18p7HK8seW+50N235yYrjNx
         6wZ198fGbDrSLoPWRC6v+RqHT3Vq5539qJXNYg+4Uqa/wq+biySU0u/4HTiGurCZbOKe
         6raindeOB/Vw9qwJ8fWjPvqUAHLdN24t5lC8qhp1Gm9TVG4YZguQ0iuRny1B0Om3upko
         hyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730674786; x=1731279586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8W8p0I3ZORpkSffN3EQ//vJwQVZRFBeB8L+KyUHq4I=;
        b=QWy3mUDBfebV4P2cQ899doAFoToxFzXx0sPdLtYqpQ0evJL87C5pk1C1DaQj+Jg0Tw
         ApLfM4e3kycrusRHIkqznb9px+lD/AZRHnLeRe1ZJiNF/KI3v9obWYXvx8QAgftabKJP
         LT/HfXFVjwmJyn/cQ0PC9sXNhGf/Lh7vflGEtCykYB/XCjCLj9g6gK8Xe6opsWYy6IgV
         /Gc84CJsryRY9m4VJv/3oC3s/KvhQioFcSTSnrbQdNVBwL+saSZiAJCzAYg2VDAo2a1w
         uL/pJ6DNTm7CZcPRVz/gWthR4aDePWOs0ENUpPhkvuyV5il3pHCdpJrQrpwzt1dbyADp
         L+FA==
X-Gm-Message-State: AOJu0YwS873mZeFwiZ3CT58uGNtS7OAUf9S4OQZv/t/l9trQnbnMAwyW
	Q3RMlqlHdT/fdzaE5/V60vLkDnC4BbbIyvTURt9ToQ/olUKOi4csjwJHNc/wcC8AFA==
X-Google-Smtp-Source: AGHT+IHmA9Zf803ad7nVOpbQgsxrXBta39UFPvGP2ucDNAx3MRS2nFqXyVIBqgWj6SBjYx3d4ZcmxQ==
X-Received: by 2002:a05:6000:7:b0:37c:d162:8297 with SMTP id ffacd0b85a97d-380611edf92mr21006368f8f.47.1730674786292;
        Sun, 03 Nov 2024 14:59:46 -0800 (PST)
Received: from localhost (fwdproxy-cln-015.fbsv.net. [2a03:2880:31ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113dd7fsm11642708f8f.70.2024.11.03.14.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 14:59:45 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v1 3/3] selftests/bpf: Add tests for tail calls with locks and refs
Date: Sun,  3 Nov 2024 14:59:40 -0800
Message-ID: <20241103225940.1408302-4-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241103225940.1408302-1-memxor@gmail.com>
References: <20241103225940.1408302-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3612; h=from:subject; bh=T0ikGcuZLizG+9qdvlh2bCrtYoBDsSk1JaKHw8b29HY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnJ//pkJMSKXM/W9xMBwJFvINFWL8peWEhJIFBcsx1 3nCmdgaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZyf/6QAKCRBM4MiGSL8RygFCD/ 4xn1AClGr2Llr1NGXIXjKnV9QDFHsIjRHrFdCxXpR0CyBYP3ikEj/wGH3x1VfnqhPv/Pl+ZySAL0vi AWAibkLPvHEbciEA6DXUw+Lndtho/wKpXBQXurvs4drHfkx1OWuTTg+R/LEYxzu3v70nGivbm01O43 vEgEGzST0wcmPLkh245o7SKqcB872G/M6nGCMEAbG27k4xgCEJvoG7EaKvh6nct0uDHuAXOOEL4ZbE iAQ15t1jCbwye9dR0E7xFF56mBY/Jlo5JOpsXZnNSc6pGiC39d4y5CfuZvzkI+bDBYLlthfr89gEnL l4QIv428VyXd5uOGCd/qctMQshfz9hWTd7yYC3TeVJwXqpJ/a77hsIcHzVtGcfvd19Y+yVJQiu4qLC dRdQgBouMiq/3B1zqsLchMDkOoRPc8/CEWYKIj7GjfuYupUHy8vp/jdCYAx6C0926100fkKZexFUnW Hj5cL5Qlr61mBF0H0XXTW1zmu+hopWTUMGIXyS+Ca/FBGIvqrz6cjWgyyhNGi7F56yusZIjuKfeIT1 5m++tVnolN26lTY6ujanFrliUYAH8uMyRIjGwRXokc7e4LY3grFzbBjhT8DXvroZF3LIjHGLihOjEw Rou8fuP5DqbvnIUo1bhj6p/MRDUAVAA0CDLPGMHSx5kyacQPuHvC5RnsvUaA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add failure tests to ensure bugs don't slip through for tail calls and
lingering locks, RCU sections, preemption disabled sections, and
references prevent tail calls.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/tailcalls.c      |  8 +++
 .../selftests/bpf/progs/tailcall_fail.c       | 64 +++++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 40f22454cf05..544144620ca6 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -7,6 +7,7 @@
 #include "tailcall_bpf2bpf_hierarchy3.skel.h"
 #include "tailcall_freplace.skel.h"
 #include "tc_bpf2bpf.skel.h"
+#include "tailcall_fail.skel.h"
 
 /* test_tailcall_1 checks basic functionality by patching multiple locations
  * in a single program for a single tail call slot with nop->jmp, jmp->nop
@@ -1646,6 +1647,11 @@ static void test_tailcall_bpf2bpf_freplace(void)
 	tc_bpf2bpf__destroy(tc_skel);
 }
 
+static void test_tailcall_failure()
+{
+	RUN_TESTS(tailcall_fail);
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -1698,4 +1704,6 @@ void test_tailcalls(void)
 		test_tailcall_freplace();
 	if (test__start_subtest("tailcall_bpf2bpf_freplace"))
 		test_tailcall_bpf2bpf_freplace();
+	if (test__start_subtest("tailcall_failure"))
+		test_tailcall_failure();
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall_fail.c b/tools/testing/selftests/bpf/progs/tailcall_fail.c
new file mode 100644
index 000000000000..bc77921d2bb0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_fail.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+extern void bpf_rcu_read_lock(void) __ksym;
+extern void bpf_rcu_read_unlock(void) __ksym;
+
+#define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
+
+private(A) struct bpf_spin_lock lock;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 3);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+SEC("?tc")
+__failure __msg("function calls are not allowed while holding a lock")
+int reject_tail_call_spin_lock(struct __sk_buff *ctx)
+{
+	bpf_spin_lock(&lock);
+	bpf_tail_call_static(ctx, &jmp_table, 0);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("tail_call cannot be used inside bpf_rcu_read_lock-ed region")
+int reject_tail_call_rcu_lock(struct __sk_buff *ctx)
+{
+	bpf_rcu_read_lock();
+	bpf_tail_call_static(ctx, &jmp_table, 0);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("tail_call cannot be used inside bpf_preempt_disable-ed region")
+int reject_tail_call_preempt_lock(struct __sk_buff *ctx)
+{
+	bpf_guard_preempt();
+	bpf_tail_call_static(ctx, &jmp_table, 0);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("tail_call would lead to reference leak")
+int reject_tail_call_ref(struct __sk_buff *ctx)
+{
+	struct foo { int i; } *p;
+
+	p = bpf_obj_new(typeof(*p));
+	bpf_tail_call_static(ctx, &jmp_table, 0);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.5


