Return-Path: <bpf+bounces-56344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BDCA95856
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 23:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997313B7A50
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 21:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD4421B9F4;
	Mon, 21 Apr 2025 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u979u3Wd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2A31D63D3;
	Mon, 21 Apr 2025 21:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745272053; cv=none; b=Z9tAMJPufDlcPbLUueqJOWVZS3j4NqIt5l3Oduarnmrzq+BDOYtkHSAFmtzHZWRiEDaubtPSUnOXj3a0woQD7E0iKOg2eqHUcb4GAiaNxprs53XtlIzAmxSVAtqSnhnS43F/PoQDQZlT6CU1O4zWuKLzMI11jwRIISgCuIRtDRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745272053; c=relaxed/simple;
	bh=aI9whqPW5DtGUUIX0VMcRWnf+t2wx4QcdG0DrI/uDXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqbVI5EzCZPFMz3INxxY411mWCGarhg70enDrIwgSZ61Jzje0Qg24NyV/98DWgwuP1u3nl7L3UAy4v/Bi8vdHoAZYamRwi/dD3D/uAsPLZ36QHkexLnplgRRnFNML/rzpJSqk8lyafNiKkq0x4aQlmtxOwYgg+h9B4TYpiPrkMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u979u3Wd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C61C4CEE4;
	Mon, 21 Apr 2025 21:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745272053;
	bh=aI9whqPW5DtGUUIX0VMcRWnf+t2wx4QcdG0DrI/uDXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u979u3WdPag7zDwXfjeoNiYIqVhIYNhB+6laUxSASVVcK4pap7B6BAA8y5w/WVxWT
	 LsTHMTbC/Iez77n+fDo2oceSNi93VP6vNArd3La4UMWo9A3fhjsfO5mBddXLHTZcv+
	 BS9iJ6zDoRCkVdpGSrw8Xu0eoI8LzNG8ZkzuV8Q15cbdvIt2TJaa9U5aFZ69NDyIVU
	 I+DpRcKU+4p9tGpeuNpqTFVIppl8IuTSbI8ZcGqeiW1KkSCvnctbWGshZtAr4vQKIT
	 gXwkve0/MfGaIj0B9rJs59FucfuzK9e7uXXdR2Nx5409+/rczHLsI6KPHW6Benuv+3
	 +fg+rdrPVSibA==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
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
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH perf/core 15/22] selftests/bpf: Add hit/attach/detach race optimized uprobe test
Date: Mon, 21 Apr 2025 23:44:15 +0200
Message-ID: <20250421214423.393661-16-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421214423.393661-1-jolsa@kernel.org>
References: <20250421214423.393661-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test that makes sure parallel execution of the uprobe and
attach/detach of optimized uprobe on it works properly.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 16effe0bca1d..57ef1207c3f5 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -619,6 +619,78 @@ static void test_uretprobe_shadow_stack(void)
 	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
 }
 
+static volatile bool race_stop;
+
+static void *worker_trigger(void *arg)
+{
+	unsigned long rounds = 0;
+
+	while (!race_stop) {
+		uprobe_test();
+		rounds++;
+	}
+
+	printf("tid %d trigger rounds: %lu\n", gettid(), rounds);
+	return NULL;
+}
+
+static void *worker_attach(void *arg)
+{
+	struct uprobe_syscall_executed *skel;
+	unsigned long rounds = 0, offset;
+
+	offset = get_uprobe_offset(&uprobe_test);
+	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
+		return NULL;
+
+	skel = uprobe_syscall_executed__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_syscall_executed__open_and_load"))
+		return NULL;
+
+	while (!race_stop) {
+		skel->links.test_uprobe = bpf_program__attach_uprobe_opts(skel->progs.test_uprobe,
+					0, "/proc/self/exe", offset, NULL);
+		if (!ASSERT_OK_PTR(skel->links.test_uprobe, "bpf_program__attach_uprobe_opts"))
+			break;
+
+		bpf_link__destroy(skel->links.test_uprobe);
+		skel->links.test_uprobe = NULL;
+		rounds++;
+	}
+
+	printf("tid %d attach rounds: %lu hits: %d\n", gettid(), rounds, skel->bss->executed);
+	uprobe_syscall_executed__destroy(skel);
+	return NULL;
+}
+
+static void test_uprobe_race(void)
+{
+	int err, i, nr_threads;
+	pthread_t *threads;
+
+	nr_threads = libbpf_num_possible_cpus();
+	if (!ASSERT_GE(nr_threads, 0, "libbpf_num_possible_cpus"))
+		return;
+
+	threads = malloc(sizeof(*threads) * nr_threads);
+	if (!ASSERT_OK_PTR(threads, "malloc"))
+		return;
+
+	for (i = 0; i < nr_threads; i++) {
+		err = pthread_create(&threads[i], NULL, i % 2 ? worker_trigger : worker_attach,
+				     NULL);
+		if (!ASSERT_OK(err, "pthread_create"))
+			goto cleanup;
+	}
+
+	sleep(4);
+
+cleanup:
+	race_stop = true;
+	for (nr_threads = i, i = 0; i < nr_threads; i++)
+		pthread_join(threads[i], NULL);
+}
+
 static void __test_uprobe_syscall(void)
 {
 	if (test__start_subtest("uretprobe_regs_equal"))
@@ -637,6 +709,8 @@ static void __test_uprobe_syscall(void)
 		test_uprobe_session();
 	if (test__start_subtest("uprobe_usdt"))
 		test_uprobe_usdt();
+	if (test__start_subtest("uprobe_race"))
+		test_uprobe_race();
 }
 #else
 static void __test_uprobe_syscall(void)
-- 
2.49.0


