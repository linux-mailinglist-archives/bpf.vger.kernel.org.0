Return-Path: <bpf+bounces-42480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024229A4864
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 22:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B5AFB2607C
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 20:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE1A20CCDE;
	Fri, 18 Oct 2024 20:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqFxPx2D"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AEA2071FD;
	Fri, 18 Oct 2024 20:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729284227; cv=none; b=kbucgszDdPMIQ43VcMwsAEgBZztO+J8xEn/aH+fIEOyYLYhHDVuFTDcDAxAYQwQZDaLFPErppgsNHnFrqWHOiaG5ZcmDCZyO5ZN93ikNN1BJ2K6ANRYxD4madHjlyniGjUAGD8Amumde+Twds4BmkhbJhNGSpjpPCKXz5IsdKts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729284227; c=relaxed/simple;
	bh=SRJ7iIqpFdc57svkJVfVWiyC4I6Wo1VBhjnyzeaFXpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJWs0tewPg5dh555sNvVJ4pOEN7gCEbzSiZRi2z3kpHkkb/qxjhanVJFDV1Nw/mKtq4cg7L28ZvzxwQc4uVeVEJRqSL1G/HcyuL3sLNVn9t22uujXkpj+33ynMQNiNhkb6LqLKbTKAIiUKre/eQER+OYp7FStvLj5pdPeziy0DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqFxPx2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3E3C4CEC5;
	Fri, 18 Oct 2024 20:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729284227;
	bh=SRJ7iIqpFdc57svkJVfVWiyC4I6Wo1VBhjnyzeaFXpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CqFxPx2D/DHSYVsSN9Pu1y5oUu4HCBCmqWdOq2JnOTompR1Tg76p/T2rxIBuB3JLS
	 hFZAgsRIyVjZY6dUp97kNQ/+0G575G0HUQBY0aOA5FwBpRUGmPEIh4N7d0AsaiK8Jr
	 y+CCdBf+cRkb2a+LxiS7o06mV/ZbRNRzXdibC7B/3Hbwbuey9vF9zpEOJLByafTnjC
	 u9ZEkmHUyZ/InvDkOi4QdxgnLv6q2EeCnOFr1faTLdkUMzHzHS6oaY5Ziir13zHg9l
	 8q0STCIiau8ePa3sVGMoJ3NrKPMGW9GGYnCwttn8qp+SBZ3oAc4/vHtq2BO8T1fZOC
	 Y/173ZRz2e5Fw==
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
Subject: [PATCHv8 bpf-next 12/13] selftests/bpf: Add uprobe sessions to consumer test
Date: Fri, 18 Oct 2024 22:41:08 +0200
Message-ID: <20241018204109.713820-13-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018204109.713820-1-jolsa@kernel.org>
References: <20241018204109.713820-1-jolsa@kernel.org>
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
 .../bpf/prog_tests/uprobe_multi_test.c        | 68 +++++++++++++------
 .../bpf/progs/uprobe_multi_consumers.c        |  6 +-
 2 files changed, 52 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 7e0228f8fcfc..e96b153a0f5d 100644
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
@@ -867,29 +870,55 @@ static int consumer_test(struct uprobe_multi_consumers *skel,
 		goto cleanup;
 
 	for (idx = 0; idx < 4; idx++) {
+		unsigned long had_uretprobes;
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
 			 * to trigger uretprobe consumer, the uretprobe needs to be installed,
 			 * which means one of the 'return' uprobes was alive when probe was hit:
 			 *
-			 *   idxs: 2/3 uprobe return in 'installed' mask
+			 *   idxs: 1/2 uprobe return in 'installed' mask
 			 */
-			unsigned long had_uretprobes  = before & 0b1100; /* is uretprobe installed */
+			had_uretprobes = before & 0b0110; /* is uretprobe installed */
 
 			if (had_uretprobes && test_bit(idx, after))
 				val++;
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
@@ -918,8 +947,10 @@ static void test_consumers(void)
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
@@ -927,25 +958,24 @@ static void test_consumers(void)
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
2.46.2


