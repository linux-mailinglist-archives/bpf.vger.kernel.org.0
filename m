Return-Path: <bpf+bounces-52359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBBBA422BB
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5FD443040
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 14:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3505257AF4;
	Mon, 24 Feb 2025 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0DQHa2F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42869189919;
	Mon, 24 Feb 2025 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405895; cv=none; b=fCX+Wefy7UvUNbyV9G0hODDATOtXApFLXfkCKRBhmxtotBM1uVYsrH+3ncF/Hs7t6CvB7LuBy7/P0yxo36iATXCxutfhKLa0OAprvoFN9N+ITP4VQJwygYl9qr/qhVMsHU48tRsEHDQfAaQZkQW0wMbnNH0VjWE1Xsmst6XXWvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405895; c=relaxed/simple;
	bh=JbGJaHSVed+ELnCA8sbA8yO96hrYhyAbp8Q38B7qOHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okRfFMCKdD0Vead4Q4tnZKAlCmiGey8ng57wypn6JGrVtjCxQGUqkA4MV0GqA/lvT+FOEboLfOLLONQcwyTnj1Hb/uYdjD7xv0Du2oAJSTgu/Mz3ylRkX+o8r/AkxCxP942z8pMkVXttdo72zrNmHQkNp25MSB7wnoULzGamvXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0DQHa2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE59C4CED6;
	Mon, 24 Feb 2025 14:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405895;
	bh=JbGJaHSVed+ELnCA8sbA8yO96hrYhyAbp8Q38B7qOHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0DQHa2Fa6r4ntsI8OAL/Ycw8jyUhH4xXP5R5DFCwVUvg8ZECrqeUtcWSuu80DwPM
	 4KfCZYTSgPpAiE6VJthpv1HShjm5x4ayqKFXEokC8qSEZhr8CGv6F5ugb9RlwViauZ
	 0JRASwZErLBHvOV7iXPQYkPexp6LF2feWx47iEFQPJpjJTt2y45KBKcGsWMDi7mxRV
	 cHCuKkRH8qJCs4liVi9oN6YU1U4c8HQ/AzcyXdxlkI8Ewd7xZdUj4TBB2QuITpzQ2+
	 XTw6aNsdHQ9sgc1FACShyAOXl/absjjGkE4AIMvOF+F4NlNdRUaFKJaeWoG9gUwpYL
	 nL4a/h+Q9SmGA==
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
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH RFCv2 16/18] selftests/bpf: Add hit/attach/detach race optimized uprobe test
Date: Mon, 24 Feb 2025 15:01:48 +0100
Message-ID: <20250224140151.667679-17-jolsa@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224140151.667679-1-jolsa@kernel.org>
References: <20250224140151.667679-1-jolsa@kernel.org>
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
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index b337db6e12be..3f320da4ac46 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -558,6 +558,79 @@ static void test_uprobe_usdt(void)
 	uprobe_syscall_executed__destroy(skel);
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
+	unsigned long rounds = 0;
+
+	skel = uprobe_syscall_executed__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_syscall_executed__open_and_load"))
+		return NULL;
+
+	while (!race_stop) {
+		skel->links.test_uprobe_multi = bpf_program__attach_uprobe_multi(skel->progs.test_uprobe_multi,
+						-1, "/proc/self/exe", "uprobe_test", NULL);
+		if (!ASSERT_OK_PTR(skel->links.test_uprobe_multi, "bpf_program__attach_uprobe_multi"))
+			break;
+		bpf_link__destroy(skel->links.test_uprobe_multi);
+		skel->links.test_uprobe_multi = NULL;
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
+	for (nr = i, i = 0; i < nr; i++)
+		pthread_join(threads[i], NULL);
+}
+
 static void __test_uprobe_syscall(void)
 {
 	if (test__start_subtest("uretprobe_regs_equal"))
@@ -574,6 +647,8 @@ static void __test_uprobe_syscall(void)
 		test_uprobe_multi();
 	if (test__start_subtest("uprobe_usdt"))
 		test_uprobe_usdt();
+	if (test__start_subtest("uprobe_race"))
+		test_uprobe_race();
 }
 #else
 static void __test_uprobe_syscall(void)
-- 
2.48.1


