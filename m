Return-Path: <bpf+bounces-38457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E000F965035
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 21:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E541C22A97
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 19:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779F71BCA01;
	Thu, 29 Aug 2024 19:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QivdvlDH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDFC1B86EE;
	Thu, 29 Aug 2024 19:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960726; cv=none; b=chcLKmSpyifHznB0mNgHcOkVy00Tu6A2V0HxjObgDoQcAKY66JOzpLVVDMFY24p332uEj3gouNsua17i+/gM4lOOcEIqpUOG+MkDAwuLLsVOXLcSZPWdhWL1FiVNwx3uDJLtWhgfHYk7DbRru4HcOZEOv2KLwi+hMVq+T0fuxm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960726; c=relaxed/simple;
	bh=BJ0uQV1Yd2KsDe/PvMljMfOBKIPbpYo8HoBH6L01n7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkfkUjDysWyDxXOhFg5INHJGzMNMexebIW8KJBIUcuZEZvVJvjwtK0TgLDwpEDEe8UBCYoqjhEJrjVFvaD7QVQypNxlSHqI8IssEedCgo+uNVvm7MGThhkVQVpxDeWbrIm4TLv9Fcrh4lbwAdqoW/vmofSGuyeTX5MLwK+iSE/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QivdvlDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D416DC4CEC2;
	Thu, 29 Aug 2024 19:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724960725;
	bh=BJ0uQV1Yd2KsDe/PvMljMfOBKIPbpYo8HoBH6L01n7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QivdvlDH9E2OJ4wDwAsys0bdwscFnOeC+HdkASE5Zc3QuSkiBrrjZrAgIe4Nn3/PO
	 omTKMQ36m9Z96ypfLbKKgF0BAizQIgv66RVMsEc9ylA+yNIlQyUEetZ03zBO+sOkbH
	 JCBiLlerFE2kZPxhuTVr34s3eafM3XuMcafImP3Sw4LfcLcirwdXRA2CHRUcB1cNcM
	 YjbokfUT5iBZlIKpceKynJ/obiORljdFvWzZMsXA9eWj8Kpi1R+FsNhlFHgHlHE1Xb
	 SOw4AOFXEpx8pH5m2WvWrvfaSQwk73AORyNPFPEvxsr2zF2xQWKOz0YfElI8rjk7ca
	 7Takr0Dj+8O0g==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Tianyi Liu <i.pear@outlook.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] selftests/bpf: Add child argument to spawn_child function
Date: Thu, 29 Aug 2024 21:45:04 +0200
Message-ID: <20240829194505.402807-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829194505.402807-1-jolsa@kernel.org>
References: <20240829194505.402807-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding child argument to spawn_child function to allow
to create multiple children in following change.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 85 +++++++++----------
 1 file changed, 39 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index acb62675ff65..250eb47c68f9 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -68,29 +68,27 @@ static void kick_child(struct child *child)
 	fflush(NULL);
 }
 
-static struct child *spawn_child(void)
+static int spawn_child(struct child *child)
 {
-	static struct child child;
-	int err;
-	int c;
+	int err, c;
 
 	/* pipe to notify child to execute the trigger functions */
-	if (pipe(child.go))
-		return NULL;
+	if (pipe(child->go))
+		return -1;
 
-	child.pid = child.tid = fork();
-	if (child.pid < 0) {
-		release_child(&child);
+	child->pid = child->tid = fork();
+	if (child->pid < 0) {
+		release_child(child);
 		errno = EINVAL;
-		return NULL;
+		return -1;
 	}
 
 	/* child */
-	if (child.pid == 0) {
-		close(child.go[1]);
+	if (child->pid == 0) {
+		close(child->go[1]);
 
 		/* wait for parent's kick */
-		err = read(child.go[0], &c, 1);
+		err = read(child->go[0], &c, 1);
 		if (err != 1)
 			exit(err);
 
@@ -102,7 +100,7 @@ static struct child *spawn_child(void)
 		exit(errno);
 	}
 
-	return &child;
+	return 0;
 }
 
 static void *child_thread(void *ctx)
@@ -131,39 +129,38 @@ static void *child_thread(void *ctx)
 	pthread_exit(&err);
 }
 
-static struct child *spawn_thread(void)
+static int spawn_thread(struct child *child)
 {
-	static struct child child;
 	int c, err;
 
 	/* pipe to notify child to execute the trigger functions */
-	if (pipe(child.go))
-		return NULL;
+	if (pipe(child->go))
+		return -1;
 	/* pipe to notify parent that child thread is ready */
-	if (pipe(child.c2p)) {
-		close(child.go[0]);
-		close(child.go[1]);
-		return NULL;
+	if (pipe(child->c2p)) {
+		close(child->go[0]);
+		close(child->go[1]);
+		return -1;
 	}
 
-	child.pid = getpid();
+	child->pid = getpid();
 
-	err = pthread_create(&child.thread, NULL, child_thread, &child);
+	err = pthread_create(&child->thread, NULL, child_thread, child);
 	if (err) {
 		err = -errno;
-		close(child.go[0]);
-		close(child.go[1]);
-		close(child.c2p[0]);
-		close(child.c2p[1]);
+		close(child->go[0]);
+		close(child->go[1]);
+		close(child->c2p[0]);
+		close(child->c2p[1]);
 		errno = -err;
-		return NULL;
+		return -1;
 	}
 
-	err = read(child.c2p[0], &c, 1);
+	err = read(child->c2p[0], &c, 1);
 	if (!ASSERT_EQ(err, 1, "child_thread_ready"))
-		return NULL;
+		return -1;
 
-	return &child;
+	return 0;
 }
 
 static void uprobe_multi_test_run(struct uprobe_multi *skel, struct child *child)
@@ -304,24 +301,22 @@ __test_attach_api(const char *binary, const char *pattern, struct bpf_uprobe_mul
 static void
 test_attach_api(const char *binary, const char *pattern, struct bpf_uprobe_multi_opts *opts)
 {
-	struct child *child;
+	static struct child child;
 
 	/* no pid filter */
 	__test_attach_api(binary, pattern, opts, NULL);
 
 	/* pid filter */
-	child = spawn_child();
-	if (!ASSERT_OK_PTR(child, "spawn_child"))
+	if (!ASSERT_OK(spawn_child(&child), "spawn_child"))
 		return;
 
-	__test_attach_api(binary, pattern, opts, child);
+	__test_attach_api(binary, pattern, opts, &child);
 
 	/* pid filter (thread) */
-	child = spawn_thread();
-	if (!ASSERT_OK_PTR(child, "spawn_thread"))
+	if (!ASSERT_OK(spawn_thread(&child), "spawn_thread"))
 		return;
 
-	__test_attach_api(binary, pattern, opts, child);
+	__test_attach_api(binary, pattern, opts, &child);
 }
 
 static void test_attach_api_pattern(void)
@@ -712,24 +707,22 @@ static void __test_link_api(struct child *child)
 
 static void test_link_api(void)
 {
-	struct child *child;
+	static struct child child;
 
 	/* no pid filter */
 	__test_link_api(NULL);
 
 	/* pid filter */
-	child = spawn_child();
-	if (!ASSERT_OK_PTR(child, "spawn_child"))
+	if (!ASSERT_OK(spawn_child(&child), "spawn_child"))
 		return;
 
-	__test_link_api(child);
+	__test_link_api(&child);
 
 	/* pid filter (thread) */
-	child = spawn_thread();
-	if (!ASSERT_OK_PTR(child, "spawn_thread"))
+	if (!ASSERT_OK(spawn_thread(&child), "spawn_thread"))
 		return;
 
-	__test_link_api(child);
+	__test_link_api(&child);
 }
 
 static struct bpf_program *
-- 
2.46.0


