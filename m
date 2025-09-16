Return-Path: <bpf+bounces-68563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381AEB5A459
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2004F5833A3
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 21:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898CD3294EE;
	Tue, 16 Sep 2025 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwBZCfP9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022BB31FEE4;
	Tue, 16 Sep 2025 21:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059665; cv=none; b=fUbF49tFvcf5egjcNC/D4MmnxGqjmJNEVMGdAUSDibXIRw5IfyvU8M4lRAhHIlxTyAdhT6ZSCQYTzRBb3iFalzDopryYSir7i9p3/3KW1t5ShooSSrThNFPDDsnD7IsjyHxdc+jk71l4EWkSTPmGnv/K/hKLh/q4B3LtLk7gp3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059665; c=relaxed/simple;
	bh=OsEEWV4wNkbsvLkZHIBDGiDZBWoY4hQzlY0ncyYsXjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6WLUtw7vG45k+fJNLfRdkIhLiKE8QWv6GChW5moICC3lYe7KviSs9WUfen51qIfPb/pdZZYjiCze7B3LwQIJqg6BCOd4K2l1Gfcv5FbK/YGxpba1bPpSVg6/tIpUtJppjDN/BN+3Zni0ujIsA/oRltYG4TmXMDXj7Zk0Z2TmpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwBZCfP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD58C4CEF9;
	Tue, 16 Sep 2025 21:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758059664;
	bh=OsEEWV4wNkbsvLkZHIBDGiDZBWoY4hQzlY0ncyYsXjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iwBZCfP9Ol3xjNu04Rpzhae7+ENY9bGrvTObrEij5MSNmeTI8QPz3y/DkglGNUUu5
	 BF9ziHp/vTpqq7PkLgh1XQej2UzJkcPiwZ7PfBOlD7Q806ETF+3DyidATmnfPLPhrR
	 DWPcnutLhcYj8idhWF9F5B2o+QhLB8Y3kizSiwzRYNTC5s2k6nurAvIDYzW9TFMwb2
	 fV0U5eLCgsp/WSdVfqQsKBVvjH3BIUBOnWXLFXq5DNfprGlpyx6KQGvkNN2yLdQz1r
	 FRaekHmI6ARNupz7C2RzW/KluTjcs9C4z3FsfDl5nkm+P+FbvBXeu6HU58IBkcxLhT
	 DzRD0WQd25EYA==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCHv4 bpf-next 6/6] selftests/bpf: Add kprobe multi write ctx attach test
Date: Tue, 16 Sep 2025 23:53:01 +0200
Message-ID: <20250916215301.664963-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916215301.664963-1-jolsa@kernel.org>
References: <20250916215301.664963-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test to check we can't attach kprobe multi program
that writes to the context.

It's x86_64 specific test.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/kprobe_multi_test.c        | 27 +++++++++++++++++++
 .../selftests/bpf/progs/kprobe_write_ctx.c    |  7 +++++
 2 files changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 171706e78da8..6cfaa978bc9a 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -7,6 +7,7 @@
 #include "kprobe_multi_session.skel.h"
 #include "kprobe_multi_session_cookie.skel.h"
 #include "kprobe_multi_verifier.skel.h"
+#include "kprobe_write_ctx.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "bpf/hashmap.h"
 
@@ -539,6 +540,30 @@ static void test_attach_override(void)
 	kprobe_multi_override__destroy(skel);
 }
 
+#ifdef __x86_64__
+static void test_attach_write_ctx(void)
+{
+	struct kprobe_write_ctx *skel = NULL;
+	struct bpf_link *link = NULL;
+
+	skel = kprobe_write_ctx__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "kprobe_write_ctx__open_and_load"))
+		return;
+
+	link = bpf_program__attach_kprobe_opts(skel->progs.kprobe_multi_write_ctx,
+						     "bpf_fentry_test1", NULL);
+	if (!ASSERT_ERR_PTR(link, "bpf_program__attach_kprobe_opts"))
+		bpf_link__destroy(link);
+
+	kprobe_write_ctx__destroy(skel);
+}
+#else
+static void test_attach_write_ctx(void)
+{
+	test__skip();
+}
+#endif
+
 void serial_test_kprobe_multi_bench_attach(void)
 {
 	if (test__start_subtest("kernel"))
@@ -578,5 +603,7 @@ void test_kprobe_multi_test(void)
 		test_session_cookie_skel_api();
 	if (test__start_subtest("unique_match"))
 		test_unique_match();
+	if (test__start_subtest("attach_write_ctx"))
+		test_attach_write_ctx();
 	RUN_TESTS(kprobe_multi_verifier);
 }
diff --git a/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c b/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c
index 4621a5bef4e2..f77aef0474d3 100644
--- a/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c
+++ b/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c
@@ -12,4 +12,11 @@ int kprobe_write_ctx(struct pt_regs *ctx)
 	ctx->ax = 0;
 	return 0;
 }
+
+SEC("kprobe.multi")
+int kprobe_multi_write_ctx(struct pt_regs *ctx)
+{
+	ctx->ax = 0;
+	return 0;
+}
 #endif
-- 
2.51.0


