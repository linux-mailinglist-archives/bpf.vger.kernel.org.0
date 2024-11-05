Return-Path: <bpf+bounces-44044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515B89BCE0D
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 14:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBDE9B221CC
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 13:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9101D8E05;
	Tue,  5 Nov 2024 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5OWEeZJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916131D799D;
	Tue,  5 Nov 2024 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813768; cv=none; b=BJvJ/KaH+mt29QBAHqU2jALpjqdwpWiCJoBKV/6LNHHwTuL9uO5Yv1IM8PHgDU0+oZxYrbpScHG1uIOG44IP5csK/gYgDcAZNxGoTDJuEHTQaEf2gZv2Hm1E0t6ZZ8Mz8dOw4/DG/U0OLw9lkUq0cXwPdr5wC8neGkXPtQ9B0Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813768; c=relaxed/simple;
	bh=ka2R4E6eJ9tB1uYMv+2eDuyQ2Np/aM7mXyHoDxFqX8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCOOfG2h4Y3mapGHW87e5uZUQkxEfSqPkELX73nNSy9Jq39RIbl3ee0HmqUfsHVt96JTSkZ1N4OXjrvlQilLljjST169laJB3mBCcFB5QHgVW6zJH8WYdp7N3T3cKFaBddaViUC2F997AMUnw3JT9b57A5/vhoMjrSP6RnxEIQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5OWEeZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BB2C4CECF;
	Tue,  5 Nov 2024 13:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730813768;
	bh=ka2R4E6eJ9tB1uYMv+2eDuyQ2Np/aM7mXyHoDxFqX8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G5OWEeZJkRVIplFYgYgCUvcUo3Aes5lzA19k2VESuc6gFjeEqJR23WfogwYtRWEDZ
	 aiu/otEPLc3p1rGJeCI5PZuKhppcLPpufplwBTQY9RUP+eH1JfPHHjaJ/zEBbxhFaH
	 toS+hl71cjkr1Nrgi5kHjF31Jaxio56qnQJydxHu8Vr7Vmbp5AuFtAWxoDNhjBDB38
	 9Xh68CEU+2mmBJBK9HXDrnq4gbo0CoDrapyvusOQK1dtjdjzalh78GguyIKV/dxn9N
	 daQDbzCr2dDQnVfxViKPFvuWxwSLUduqAxLKF1sxufSWAjw/QulsDp+qS19aTCYr/Y
	 m3ksw+GsP4s0w==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC bpf-next 11/11] selftests/bpf: Add hit/attach/detach race optimized uprobe test
Date: Tue,  5 Nov 2024 14:34:05 +0100
Message-ID: <20241105133405.2703607-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105133405.2703607-1-jolsa@kernel.org>
References: <20241105133405.2703607-1-jolsa@kernel.org>
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
 .../bpf/prog_tests/uprobe_optimized.c         | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_optimized.c b/tools/testing/selftests/bpf/prog_tests/uprobe_optimized.c
index f6eb4089b1e2..4b9a579c232d 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_optimized.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_optimized.c
@@ -170,6 +170,64 @@ static void test_usdt(void)
 	uprobe_optimized__destroy(skel);
 }
 
+static bool race_stop;
+
+static void *worker(void*)
+{
+	while (!race_stop)
+		uprobe_test();
+	return NULL;
+}
+
+static void test_race(void)
+{
+	int err, i, nr_cpus, rounds = 0;
+	struct uprobe_optimized *skel;
+	pthread_t *threads;
+	time_t start;
+
+        nr_cpus = libbpf_num_possible_cpus();
+	if (!ASSERT_GE(nr_cpus, 0, "nr_cpus"))
+		return;
+
+	threads = malloc(sizeof(*threads) * nr_cpus);
+	if (!ASSERT_OK_PTR(threads, "malloc"))
+		return;
+
+	for (i = 0; i < nr_cpus; i++) {
+		err = pthread_create(&threads[i], NULL, worker, NULL);
+		if (!ASSERT_OK(err, "pthread_create"))
+			goto cleanup;
+	}
+
+	skel = uprobe_optimized__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_optimized__open_and_load"))
+		goto cleanup;
+
+	start = time(NULL);
+	while (1) {
+		skel->links.test_2 = bpf_program__attach_uprobe_multi(skel->progs.test_2, -1,
+						"/proc/self/exe", "uprobe_test", NULL);
+		if (!ASSERT_OK_PTR(skel->links.test_2, "bpf_program__attach_uprobe_multi"))
+			break;
+
+		bpf_link__destroy(skel->links.test_2);
+		skel->links.test_2 = NULL;
+		rounds++;
+
+		if (start + 2 < time(NULL))
+			break;
+	}
+
+	printf("rounds: %d hits: %d\n", rounds, skel->bss->executed);
+
+cleanup:
+	race_stop = true;
+	for (i = 0; i < nr_cpus; i++)
+		pthread_join(threads[i], NULL);
+	uprobe_optimized__destroy(skel);
+}
+
 static void test_optimized(void)
 {
 	if (test__start_subtest("uprobe"))
@@ -178,6 +236,8 @@ static void test_optimized(void)
 		test_uprobe_multi();
 	if (test__start_subtest("usdt"))
 		test_usdt();
+	if (test__start_subtest("race"))
+		test_race();
 }
 #else
 static void test_optimized(void)
-- 
2.47.0


