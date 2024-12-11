Return-Path: <bpf+bounces-46636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A4C9ECD60
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 14:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FFED188BA16
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 13:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70B6237FD0;
	Wed, 11 Dec 2024 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDNINR25"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2686B236914;
	Wed, 11 Dec 2024 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924168; cv=none; b=ANH+sqJvpSDQfqRcebMygQgE46ducZs0wSWH9Vtkd9uWZTc/R8jJo+IYULEVVdrXLQTdnkpgFvsm1X2FwrlVIeoxaUe3yKi7hlkZnSbHOUXCOZws1J2oT7+B/++oTzeiolkzQRH/HjDJoEakBlh26Qe2NdA7xZLLUyZKhLHF2jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924168; c=relaxed/simple;
	bh=9WHW7RegrBjWfp1MlD/1r5aFn90BYcuUDsDRM91xMic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZo28hMiUsnbAWFcsG8GcgZ0UwVsJCXiU15V5gR21omk5pCANrOUTNWZXLA4J564Rv8gwW0+Ot+3AZNT5A1bSwdBinVQCI9gnrphJDHU5Grfpoady/TzoVM9H14Bp+LsBlC0qc1Dc5SWcGisdKsmeQpaXvM0IMv2tu1coS/8Tcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDNINR25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1259C4CED2;
	Wed, 11 Dec 2024 13:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733924168;
	bh=9WHW7RegrBjWfp1MlD/1r5aFn90BYcuUDsDRM91xMic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QDNINR25L96CIschb+h6elOZECzE7h/kUSsVsH3uqAXLbBxIKsiIC7DGaJwlWKP+C
	 82GioyKpz/HSL//+JxiHcsSGmMXo89/ai2V6T/ctQW4klYBBEc9k0WJa6uZO66NQmY
	 BqRDgHkl5tDKFWVGYVO/dnt7FeDPbW1jtoX0n/jpIqv3HItHdV+FKsYVudkSdpJqCO
	 ysRAS+3dsCYsfgN9v+SfvSMJYDjGcgzPV5rk300DSzV0OWtvG7lhNxA8uzCeqIeGn8
	 kn0KWpMlq6yIBPkrqRjJ4qwbTjBzPcbSdmI09afgddBbU7e4n/xEN0c4Lc6z7OYbvZ
	 09RcWWu+m8pwQ==
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
Subject: [PATCH bpf-next 11/13] selftests/bpf: Add hit/attach/detach race optimized uprobe test
Date: Wed, 11 Dec 2024 14:34:00 +0100
Message-ID: <20241211133403.208920-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241211133403.208920-1-jolsa@kernel.org>
References: <20241211133403.208920-1-jolsa@kernel.org>
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
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 1dbc26a1130c..eacd14db8f8d 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -532,6 +532,81 @@ static void test_uprobe_usdt(void)
 cleanup:
 	uprobe_optimized__destroy(skel);
 }
+
+static bool race_stop;
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
+	struct uprobe_optimized *skel;
+	unsigned long rounds = 0;
+
+	skel = uprobe_optimized__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_optimized__open_and_load"))
+		goto cleanup;
+
+	while (!race_stop) {
+		skel->links.test_2 = bpf_program__attach_uprobe_multi(skel->progs.test_2, -1,
+						"/proc/self/exe", "uprobe_test_nop5", NULL);
+		if (!ASSERT_OK_PTR(skel->links.test_2, "bpf_program__attach_uprobe_multi"))
+			break;
+		bpf_link__destroy(skel->links.test_2);
+		skel->links.test_2 = NULL;
+		rounds++;
+	}
+
+	printf("tid %d attach rounds: %lu hits: %lu\n", gettid(), rounds, skel->bss->executed);
+
+cleanup:
+	uprobe_optimized__destroy(skel);
+	return NULL;
+}
+
+static void test_uprobe_race(void)
+{
+	int err, i, nr_cpus, nr;
+	pthread_t *threads;
+
+        nr_cpus = libbpf_num_possible_cpus();
+	if (!ASSERT_GE(nr_cpus, 0, "nr_cpus"))
+		return;
+
+	nr = nr_cpus * 2;
+	threads = malloc(sizeof(*threads) * nr);
+	if (!ASSERT_OK_PTR(threads, "malloc"))
+		return;
+
+	for (i = 0; i < nr_cpus; i++) {
+		err = pthread_create(&threads[i], NULL, worker_trigger, NULL);
+		if (!ASSERT_OK(err, "pthread_create"))
+			goto cleanup;
+	}
+
+	for (; i < nr; i++) {
+		err = pthread_create(&threads[i], NULL, worker_attach, NULL);
+		if (!ASSERT_OK(err, "pthread_create"))
+			goto cleanup;
+	}
+
+	sleep(4);
+
+cleanup:
+	race_stop = true;
+	for (i = 0; i < nr; i++)
+		pthread_join(threads[i], NULL);
+}
 #else
 static void test_uretprobe_regs_equal(void)
 {
@@ -567,6 +642,11 @@ static void test_uprobe_usdt(void)
 {
 	test__skip();
 }
+
+static void test_uprobe_race(void)
+{
+	test__skip();
+}
 #endif
 
 void test_uprobe_syscall(void)
@@ -585,4 +665,6 @@ void test_uprobe_syscall(void)
 		test_uprobe_multi();
 	if (test__start_subtest("uprobe_usdt"))
 		test_uprobe_usdt();
+	if (test__start_subtest("uprobe_race"))
+		test_uprobe_race();
 }
-- 
2.47.0


