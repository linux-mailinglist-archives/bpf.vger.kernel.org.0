Return-Path: <bpf+bounces-74728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 322F4C6439A
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 13:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64D304F1FCC
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 12:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BCB33C50D;
	Mon, 17 Nov 2025 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRY0mm8X"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2109C3328F3;
	Mon, 17 Nov 2025 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763383358; cv=none; b=AzsUH0sZVrxZ+Ow2Owj0VlgI2Y9dX+H7PVmj9UGncnbb5ZHxqCWoQA0MKIELq7ft1SFrXrkKXmhw6cwMMkHNGvR8IvNBLQJ4w8oh6PXCVR2+sAppK04H9E7HerNnnIpvJb5TNpuqaQpULfDCiQHFYTq5/5CRXravNWBNRZv2KO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763383358; c=relaxed/simple;
	bh=krID4USAu/VFMjYRujB6HjwRNiyiLnLONylIJbyfjr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlDmKylOUfkNpAomOPLtksq09ol1zrJQbaf0Mvj5M3nZFpgS6xCNZxDf8Ynzruy8B3QFA5tcmqTw5Fo7OHDLyyjxZXkKQuZlhYVohEcShljkPS8mKyMqQqct8C+ZdPemBzUPC6btgaWnxP3fcUOSJci3YDyn8/9EjenmQb+4gnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRY0mm8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E18C4CEFB;
	Mon, 17 Nov 2025 12:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763383357;
	bh=krID4USAu/VFMjYRujB6HjwRNiyiLnLONylIJbyfjr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aRY0mm8X9uQlQN3P2nZoW7GfrzSyqoVX98DyAXdccm0zaLBt7GgoeIK6MRU4lXWzH
	 hIoMEbVIUla1jFR0Ty24KiJmEsQmfIZuw1dyWuu8Mpvpe4WZKPlOQ0x71X3Njaw5U6
	 9O9XgD7ipljVmNwGG9EUkqe0EQcnPzfMBOOD9PxxRQc9Rp2qW+KMAmlvNj8IQTOYkF
	 vVznioDU0T83XNTJMhLSnJQXpWevrHarPihdVVFnpS3gTDiLsPbnXabZrzI16U6sQk
	 MBaYORnfTVtKpBDgSkiD/PIXHDKUOVcTNHZV6X4If0e21FuF/NUReDL4mg7kvx2Akw
	 xGCMPQDYPVGbA==
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
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@ACULAB.COM>
Subject: [RFC PATCH 8/8] selftests/bpf: Add race test for uprobe proglog optimization
Date: Mon, 17 Nov 2025 13:40:57 +0100
Message-ID: <20251117124057.687384-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117124057.687384-1-jolsa@kernel.org>
References: <20251117124057.687384-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding uprobe race test on top of prologue instructions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c    | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index c6a58afc7ace..8793fbd61ffd 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -654,10 +654,11 @@ static USDT_DEFINE_SEMA(race);
 
 static void *worker_trigger(void *arg)
 {
+	trigger_t trigger = (trigger_t) arg;
 	unsigned long rounds = 0;
 
 	while (!race_stop) {
-		uprobe_test();
+		trigger();
 		rounds++;
 	}
 
@@ -667,6 +668,7 @@ static void *worker_trigger(void *arg)
 
 static void *worker_attach(void *arg)
 {
+	trigger_t trigger = (trigger_t) arg;
 	LIBBPF_OPTS(bpf_uprobe_opts, opts);
 	struct uprobe_syscall_executed *skel;
 	unsigned long rounds = 0, offset;
@@ -677,7 +679,7 @@ static void *worker_attach(void *arg)
 	unsigned long *ref;
 	int err;
 
-	offset = get_uprobe_offset(&uprobe_test);
+	offset = get_uprobe_offset(trigger);
 	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
 		return NULL;
 
@@ -722,7 +724,7 @@ static useconds_t race_msec(void)
 	return 500;
 }
 
-static void test_uprobe_race(void)
+static void test_uprobe_race(trigger_t trigger)
 {
 	int err, i, nr_threads;
 	pthread_t *threads;
@@ -738,7 +740,7 @@ static void test_uprobe_race(void)
 
 	for (i = 0; i < nr_threads; i++) {
 		err = pthread_create(&threads[i], NULL, i % 2 ? worker_trigger : worker_attach,
-				     NULL);
+				     trigger);
 		if (!ASSERT_OK(err, "pthread_create"))
 			goto cleanup;
 	}
@@ -870,8 +872,10 @@ static void __test_uprobe_syscall(void)
 		test_uprobe_session();
 	if (test__start_subtest("uprobe_usdt"))
 		test_uprobe_usdt();
-	if (test__start_subtest("uprobe_race"))
-		test_uprobe_race();
+	if (test__start_subtest("uprobe_race_nop5"))
+		test_uprobe_race(uprobe_test);
+	if (test__start_subtest("uprobe_race_prologue"))
+		test_uprobe_race(prologue_trigger);
 	if (test__start_subtest("uprobe_error"))
 		test_uprobe_error();
 	if (test__start_subtest("uprobe_regs_equal"))
-- 
2.51.1


