Return-Path: <bpf+bounces-41633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1D8999383
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501A21C2144D
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 20:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C5F1E5027;
	Thu, 10 Oct 2024 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0pScCIF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543181D31B2;
	Thu, 10 Oct 2024 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728591170; cv=none; b=V+SQKTT0efWPnWySyLZLl0+gPspzLkuPVSgv6dJvI0nG8XSICcGDpwsi5tsvt9k4Q7OQpZWlUZ6pRHJnzl7Dw5lTS+Ij4X5FySD/hydaLoqKixb1ON784m+428elGDENqqfqL0pYVVEW47C2kw+SAKdKKHFRmFkcW57J5KZ/sl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728591170; c=relaxed/simple;
	bh=U/bLZDppAfaNNv5D7VdyCPV08xWP80i4ouw+8O8MYJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVe1D6jNmFiGO479sFwelHqTHB8XiV4DKrdzXrDbDdHjV5LGCs0E9LIS6JZ4hlOO+ocXCH5VFuZ+ENxl2PtmISz5XunEelCkN35qcNZ2thS7+Lxe+zruJ4eT9B/w1XoSbnkMtMQTSkapv66T9KF2OtD139kMVmSzejmAZ7INm/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0pScCIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95AEDC4CEC5;
	Thu, 10 Oct 2024 20:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728591170;
	bh=U/bLZDppAfaNNv5D7VdyCPV08xWP80i4ouw+8O8MYJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p0pScCIF7wGzfula9l/0/yy2HGyyFOYxiqajdAgEiejc4GGt2SYTp+XnvY8UxN315
	 yyz8pinFn7s/gMdF9xeSS2iqhezKPlSq7ozkDYC9Y9UYAGU9VUQKkKJ8gNGCUmDrOB
	 F+k/FVManD61OVleXofiHlCfg+suYOrVsQGXxF20IQgjzZsddDVycFMCRdQsm+hWE2
	 8tTePKv8y/KcA3wRURwhS4w8jpotfFukqhEtfSjYUCDtwMYptE9PAam6TPkdcsia4o
	 ofgC5uNz4o2JCB1HZDGSo4KjtMUmBPIg43IOBnmcr1WpBloSk/5GrRop2zpEELgFHz
	 WWrc25ke247+A==
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
Subject: [PATCHv6 bpf-next 14/16] selftests/bpf: Scale down uprobe multi consumer test
Date: Thu, 10 Oct 2024 22:09:55 +0200
Message-ID: <20241010200957.2750179-15-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010200957.2750179-1-jolsa@kernel.org>
References: <20241010200957.2750179-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have currently 2 uprobes and 2 uretprobes and we are about
to add sessions uprobes in following change, which makes the
test time unsuitable for CI even with threads.

It's enough for the test to have just 1 uprobe and 1 uretprobe.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 57 ++++++++-----------
 .../bpf/progs/uprobe_multi_consumers.c        | 16 +-----
 2 files changed, 25 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 7e0228f8fcfc..2effe4d693b4 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -761,10 +761,6 @@ get_program(struct uprobe_multi_consumers *skel, int prog)
 		return skel->progs.uprobe_0;
 	case 1:
 		return skel->progs.uprobe_1;
-	case 2:
-		return skel->progs.uprobe_2;
-	case 3:
-		return skel->progs.uprobe_3;
 	default:
 		ASSERT_FAIL("get_program");
 		return NULL;
@@ -779,10 +775,6 @@ get_link(struct uprobe_multi_consumers *skel, int link)
 		return &skel->links.uprobe_0;
 	case 1:
 		return &skel->links.uprobe_1;
-	case 2:
-		return &skel->links.uprobe_2;
-	case 3:
-		return &skel->links.uprobe_3;
 	default:
 		ASSERT_FAIL("get_link");
 		return NULL;
@@ -799,10 +791,10 @@ static int uprobe_attach(struct uprobe_multi_consumers *skel, int idx)
 		return -1;
 
 	/*
-	 * bit/prog: 0,1 uprobe entry
-	 * bit/prog: 2,3 uprobe return
+	 * bit/prog: 0 uprobe entry
+	 * bit/prog: 1 uprobe return
 	 */
-	opts.retprobe = idx == 2 || idx == 3;
+	opts.retprobe = idx == 1;
 
 	*link = bpf_program__attach_uprobe_multi(prog, 0, "/proc/self/exe",
 						"uprobe_consumer_test",
@@ -832,7 +824,7 @@ uprobe_consumer_test(struct uprobe_multi_consumers *skel,
 	int idx;
 
 	/* detach uprobe for each unset programs in 'before' state ... */
-	for (idx = 0; idx < 4; idx++) {
+	for (idx = 0; idx < 1; idx++) {
 		if (test_bit(idx, before) && !test_bit(idx, after))
 			uprobe_detach(skel, idx);
 	}
@@ -855,7 +847,7 @@ static int consumer_test(struct uprobe_multi_consumers *skel,
 	printf("consumer_test before %lu after %lu\n", before, after);
 
 	/* 'before' is each, we attach uprobe for every set idx */
-	for (idx = 0; idx < 4; idx++) {
+	for (idx = 0; idx < 1; idx++) {
 		if (test_bit(idx, before)) {
 			if (!ASSERT_OK(uprobe_attach(skel, idx), "uprobe_attach_before"))
 				goto cleanup;
@@ -866,18 +858,18 @@ static int consumer_test(struct uprobe_multi_consumers *skel,
 	if (!ASSERT_EQ(err, 0, "uprobe_consumer_test"))
 		goto cleanup;
 
-	for (idx = 0; idx < 4; idx++) {
+	for (idx = 0; idx < 1; idx++) {
 		const char *fmt = "BUG";
 		__u64 val = 0;
 
-		if (idx < 2) {
+		if (idx == 0) {
 			/*
 			 * uprobe entry
 			 *   +1 if define in 'before'
 			 */
 			if (test_bit(idx, before))
 				val++;
-			fmt = "prog 0/1: uprobe";
+			fmt = "prog 0: uprobe";
 		} else {
 			/*
 			 * to trigger uretprobe consumer, the uretprobe needs to be installed,
@@ -885,11 +877,11 @@ static int consumer_test(struct uprobe_multi_consumers *skel,
 			 *
 			 *   idxs: 2/3 uprobe return in 'installed' mask
 			 */
-			unsigned long had_uretprobes  = before & 0b1100; /* is uretprobe installed */
+			unsigned long had_uretprobes = before & 0b10; /* is uretprobe installed */
 
 			if (had_uretprobes && test_bit(idx, after))
 				val++;
-			fmt = "idx 2/3: uretprobe";
+			fmt = "prog 1: uretprobe";
 		}
 
 		if (!ASSERT_EQ(skel->bss->uprobe_result[idx], val, fmt))
@@ -900,7 +892,7 @@ static int consumer_test(struct uprobe_multi_consumers *skel,
 	ret = 0;
 
 cleanup:
-	for (idx = 0; idx < 4; idx++)
+	for (idx = 0; idx < 1; idx++)
 		uprobe_detach(skel, idx);
 	return ret;
 }
@@ -918,42 +910,41 @@ static void test_consumers(void)
 	 * The idea of this test is to try all possible combinations of
 	 * uprobes consumers attached on single function.
 	 *
-	 *  - 2 uprobe entry consumer
-	 *  - 2 uprobe exit consumers
+	 *  - 1 uprobe entry consumer
+	 *  - 1 uprobe exit consumer
 	 *
-	 * The test uses 4 uprobes attached on single function, but that
-	 * translates into single uprobe with 4 consumers in kernel.
+	 * The test uses 2 uprobes attached on single function, but that
+	 * translates into single uprobe with 2 consumers in kernel.
 	 *
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
 	 * before/after bits.
 	 */
 
-	for (before = 0; before < 16; before++) {
-		for (after = 0; after < 16; after++)
+	for (before = 0; before < 4; before++) {
+		for (after = 0; after < 4; after++)
 			if (consumer_test(skel, before, after))
 				goto out;
 	}
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c b/tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c
index 7e0fdcbbd242..1c64d7263911 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c
@@ -8,7 +8,7 @@
 
 char _license[] SEC("license") = "GPL";
 
-__u64 uprobe_result[4];
+__u64 uprobe_result[2];
 
 SEC("uprobe.multi")
 int uprobe_0(struct pt_regs *ctx)
@@ -23,17 +23,3 @@ int uprobe_1(struct pt_regs *ctx)
 	uprobe_result[1]++;
 	return 0;
 }
-
-SEC("uprobe.multi")
-int uprobe_2(struct pt_regs *ctx)
-{
-	uprobe_result[2]++;
-	return 0;
-}
-
-SEC("uprobe.multi")
-int uprobe_3(struct pt_regs *ctx)
-{
-	uprobe_result[3]++;
-	return 0;
-}
-- 
2.46.2


