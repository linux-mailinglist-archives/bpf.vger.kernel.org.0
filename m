Return-Path: <bpf+bounces-44352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865119C1E68
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 14:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3388B2187A
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 13:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6201F12EF;
	Fri,  8 Nov 2024 13:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGJdCzle"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B75E1EF935;
	Fri,  8 Nov 2024 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073713; cv=none; b=UcYA/eyWVwZjJ5oL//D4BzvNCTlWh7Pg+Fr4EjZptOUD+Ylg3/esXLpIrCeBGKBwWbmf8vHmEUJ8arKmxFP709h8ZKWPsvwwr1NjCBp1bSlOGv5q5f5teKXDWxtnc12YeUJrP7wQhEQC4EXY0xLBBzCWlZeZlw/ipjL6sEUmNZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073713; c=relaxed/simple;
	bh=m03RbtHaJ1wSanq35C6qO/NPF0kBT1tb+6ISO1ytOW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGUv2atwc4+PI6WQsGy1H0R/lkHoTBn8R9DX7iVJ7RXvqc9+sD3TQP47319pSiYHNYg8snbdmQ+aFRP6zLbbaxLTqUupS54rpRXlEHqkixuoKOJ5NQvONIyGXUB5iWOQzzDVc8Nj4lRz100RkcnZfmBWCygFsBgO6w8Zv20OAX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGJdCzle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010CAC4CECD;
	Fri,  8 Nov 2024 13:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731073713;
	bh=m03RbtHaJ1wSanq35C6qO/NPF0kBT1tb+6ISO1ytOW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aGJdCzlecrywibVbzhuyKuvtSemKstgo8Sy+6c+vUXX79ZNTH/DSCr8N+7PTuF+2h
	 I9hIR6Sj86r4+oIr4mAEQRyYjpeZ4s1EjBZ7/dunowrHTglzdRFGSARAoF8F8KSzvg
	 5A9vsQUOplKji20dnQjuZ6xkHh4vcvojCWpprcqcgg2nJFf4dUD/FrfiaKcxRbGBUo
	 +mWxWuGG+jg8mlNegsIDPAETwOb6yaLx2UUKhqZQgU/LlSat8SK18rDVcVT7mgPJ+Z
	 bUDPHeK2VcUL1W/BC9y18Owaelr6CsX7f7Gs7GFQqsdDJoOrjUe+D0ph3jX+s4mXr1
	 WPyKKB78xAdvg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv9 bpf-next 12/13] selftests/bpf: Add uprobe sessions to consumer test
Date: Fri,  8 Nov 2024 14:45:43 +0100
Message-ID: <20241108134544.480660-13-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108134544.480660-1-jolsa@kernel.org>
References: <20241108134544.480660-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding uprobe session consumers to the consumer test,
so we get the session into the test mix.

In addition scaling down the test to have just 1 uprobe
and 1 uretprobe, otherwise the test time grows and is
unsuitable for CI even with threads.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 70 +++++++++++++------
 .../bpf/progs/uprobe_multi_consumers.c        |  6 +-
 2 files changed, 52 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 93f5cabd6d01..0a31ba2d6fb2 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -799,10 +799,13 @@ static int uprobe_attach(struct uprobe_multi_consumers *skel, int idx)
 		return -1;
 
 	/*
-	 * bit/prog: 0,1 uprobe entry
-	 * bit/prog: 2,3 uprobe return
+	 * bit/prog: 0 uprobe entry
+	 * bit/prog: 1 uprobe return
+	 * bit/prog: 2 uprobe session without return
+	 * bit/prog: 3 uprobe session with return
 	 */
-	opts.retprobe = idx == 2 || idx == 3;
+	opts.retprobe = idx == 1;
+	opts.session  = idx == 2 || idx == 3;
 
 	*link = bpf_program__attach_uprobe_multi(prog, 0, "/proc/self/exe",
 						"uprobe_consumer_test",
@@ -867,31 +870,55 @@ static int consumer_test(struct uprobe_multi_consumers *skel,
 		goto cleanup;
 
 	for (idx = 0; idx < 4; idx++) {
+		bool uret_stays, uret_survives;
 		const char *fmt = "BUG";
 		__u64 val = 0;
 
-		if (idx < 2) {
+		switch (idx) {
+		case 0:
 			/*
 			 * uprobe entry
 			 *   +1 if define in 'before'
 			 */
 			if (test_bit(idx, before))
 				val++;
-			fmt = "prog 0/1: uprobe";
-		} else {
+			fmt = "prog 0: uprobe";
+			break;
+		case 1:
 			/*
 			 * To trigger uretprobe consumer, the uretprobe under test either stayed from
 			 * before to after (uret_stays + test_bit) or uretprobe instance survived and
 			 * we have uretprobe active in after (uret_survives + test_bit)
 			 */
-
-			bool uret_stays = before & after & 0b1100;
-			bool uret_survives = (before & 0b1100) && (after & 0b1100) && (before & 0b0011);
+			uret_stays = before & after & 0b0110;
+			uret_survives = ((before & 0b0110) && (after & 0b0110) && (before & 0b1001));
 
 			if ((uret_stays || uret_survives) && test_bit(idx, after))
 				val++;
-
-			fmt = "idx 2/3: uretprobe";
+			fmt = "prog 1: uretprobe";
+			break;
+		case 2:
+			/*
+			 * session with return
+			 *  +1 if defined in 'before'
+			 *  +1 if defined in 'after'
+			 */
+			if (test_bit(idx, before)) {
+				val++;
+				if (test_bit(idx, after))
+					val++;
+			}
+			fmt = "prog 2: session with return";
+			break;
+		case 3:
+			/*
+			 * session without return
+			 *   +1 if defined in 'before'
+			 */
+			if (test_bit(idx, before))
+				val++;
+			fmt = "prog 3: session with NO return";
+			break;
 		}
 
 		if (!ASSERT_EQ(skel->bss->uprobe_result[idx], val, fmt))
@@ -920,8 +947,10 @@ static void test_consumers(void)
 	 * The idea of this test is to try all possible combinations of
 	 * uprobes consumers attached on single function.
 	 *
-	 *  - 2 uprobe entry consumer
-	 *  - 2 uprobe exit consumers
+	 *  - 1 uprobe entry consumer
+	 *  - 1 uprobe exit consumer
+	 *  - 1 uprobe session with return
+	 *  - 1 uprobe session without return
 	 *
 	 * The test uses 4 uprobes attached on single function, but that
 	 * translates into single uprobe with 4 consumers in kernel.
@@ -929,25 +958,24 @@ static void test_consumers(void)
 	 * The before/after values present the state of attached consumers
 	 * before and after the probed function:
 	 *
-	 *  bit/prog 0,1 : uprobe entry
-	 *  bit/prog 2,3 : uprobe return
+	 *  bit/prog 0 : uprobe entry
+	 *  bit/prog 1 : uprobe return
 	 *
 	 * For example for:
 	 *
-	 *   before = 0b0101
-	 *   after  = 0b0110
+	 *   before = 0b01
+	 *   after  = 0b10
 	 *
 	 * it means that before we call 'uprobe_consumer_test' we attach
 	 * uprobes defined in 'before' value:
 	 *
-	 *   - bit/prog 0: uprobe entry
-	 *   - bit/prog 2: uprobe return
+	 *   - bit/prog 1: uprobe entry
 	 *
 	 * uprobe_consumer_test is called and inside it we attach and detach
 	 * uprobes based on 'after' value:
 	 *
-	 *   - bit/prog 0: stays untouched
-	 *   - bit/prog 2: uprobe return is detached
+	 *   - bit/prog 0: is detached
+	 *   - bit/prog 1: is attached
 	 *
 	 * uprobe_consumer_test returns and we check counters values increased
 	 * by bpf programs on each uprobe to match the expected count based on
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c b/tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c
index 7e0fdcbbd242..93752bb5690b 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c
@@ -24,16 +24,16 @@ int uprobe_1(struct pt_regs *ctx)
 	return 0;
 }
 
-SEC("uprobe.multi")
+SEC("uprobe.session")
 int uprobe_2(struct pt_regs *ctx)
 {
 	uprobe_result[2]++;
 	return 0;
 }
 
-SEC("uprobe.multi")
+SEC("uprobe.session")
 int uprobe_3(struct pt_regs *ctx)
 {
 	uprobe_result[3]++;
-	return 0;
+	return 1;
 }
-- 
2.47.0


