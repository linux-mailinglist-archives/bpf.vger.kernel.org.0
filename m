Return-Path: <bpf+bounces-40528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777DE989782
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 23:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 088FDB2285A
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 21:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC9C17E003;
	Sun, 29 Sep 2024 21:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHloHK0D"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CE3175D32;
	Sun, 29 Sep 2024 20:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727643599; cv=none; b=FFcRUqHH+WGimbe7jSZkMhXjU2M+8xcynCM6wUd38jSVpsyuFX+YDVM9CPJYseWYAR2qceRl+Lj/XdYe7EXA0kFjdoSDgPduT6pZ5Iwa0o8/HuKM1HhDGIMv7JEN7hWCyW8PygOFmb/deFvh6XsTqnmBtHGT63CqztuABAgnKHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727643599; c=relaxed/simple;
	bh=Oqo2qdNBfGiUDUhpK1HFYYjwJGAT2CrPMHcWSzbsz2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkHNRucOzk1ii2vSHlUERTCDx8YS2OdDYJ8WY1a2CcP4uhfmwsGjUzvU43/gcveucZ894KA7RY9GgdQXubX/JoTal4zyKwXTk/Qd3yNLDPc6GDzrgUh2/oCj2CzK1PGlPxPTHZCLKeXmKk7MoxnJ3ABaoWSiMHrvO/vbGWduFS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHloHK0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858B1C4CEC5;
	Sun, 29 Sep 2024 20:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727643599;
	bh=Oqo2qdNBfGiUDUhpK1HFYYjwJGAT2CrPMHcWSzbsz2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MHloHK0DOhwH4MfFZPaIht+ZdK4lvfs4qkPkmZmEGM91b8n0NN2qmvGmYDnqZcItJ
	 7v6HkWOo8B2XifqS9QyYWXK516Mgootod7pSgcnmkpZL5zl6EaUK2ciqBrLRMm1a6K
	 tCi6ys0N3FFqtHke5yfyb871zB+UquDyyFMy8k42LRdvblw/ruhHcNL1sjgbCxh3cV
	 dZXPD3ZU4VxFpaeqdeiPpSjuhR7sIZr4q9DLvuK4TXP06CihblGyHxlZE3DA4XWt7a
	 /hmstAHCjsb3avo3RFjbokNgEiKWf1l7Y9sJE8wMRv0+pCcG0FYEKXDNdUSKUL2kze
	 2lWnpJ+1gsZpw==
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
Subject: [PATCHv5 bpf-next 13/13] selftests/bpf: Add uprobe sessions to consumer test
Date: Sun, 29 Sep 2024 22:57:17 +0200
Message-ID: <20240929205717.3813648-14-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240929205717.3813648-1-jolsa@kernel.org>
References: <20240929205717.3813648-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding uprobe session consumers to the consumer test,
so we get the session into the test mix.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 63 ++++++++++++++-----
 .../bpf/progs/uprobe_multi_consumers.c        | 16 ++++-
 2 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 7e0228f8fcfc..b43107e87e78 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -765,6 +765,10 @@ get_program(struct uprobe_multi_consumers *skel, int prog)
 		return skel->progs.uprobe_2;
 	case 3:
 		return skel->progs.uprobe_3;
+	case 4:
+		return skel->progs.uprobe_4;
+	case 5:
+		return skel->progs.uprobe_5;
 	default:
 		ASSERT_FAIL("get_program");
 		return NULL;
@@ -783,6 +787,10 @@ get_link(struct uprobe_multi_consumers *skel, int link)
 		return &skel->links.uprobe_2;
 	case 3:
 		return &skel->links.uprobe_3;
+	case 4:
+		return &skel->links.uprobe_4;
+	case 5:
+		return &skel->links.uprobe_5;
 	default:
 		ASSERT_FAIL("get_link");
 		return NULL;
@@ -801,8 +809,10 @@ static int uprobe_attach(struct uprobe_multi_consumers *skel, int idx)
 	/*
 	 * bit/prog: 0,1 uprobe entry
 	 * bit/prog: 2,3 uprobe return
+	 * bit/prog: 4,5 uprobe session
 	 */
 	opts.retprobe = idx == 2 || idx == 3;
+	opts.session  = idx == 4 || idx == 5;
 
 	*link = bpf_program__attach_uprobe_multi(prog, 0, "/proc/self/exe",
 						"uprobe_consumer_test",
@@ -832,13 +842,13 @@ uprobe_consumer_test(struct uprobe_multi_consumers *skel,
 	int idx;
 
 	/* detach uprobe for each unset programs in 'before' state ... */
-	for (idx = 0; idx < 4; idx++) {
+	for (idx = 0; idx < 6; idx++) {
 		if (test_bit(idx, before) && !test_bit(idx, after))
 			uprobe_detach(skel, idx);
 	}
 
 	/* ... and attach all new programs in 'after' state */
-	for (idx = 0; idx < 4; idx++) {
+	for (idx = 0; idx < 6; idx++) {
 		if (!test_bit(idx, before) && test_bit(idx, after)) {
 			if (!ASSERT_OK(uprobe_attach(skel, idx), "uprobe_attach_after"))
 				return -1;
@@ -855,7 +865,7 @@ static int consumer_test(struct uprobe_multi_consumers *skel,
 	printf("consumer_test before %lu after %lu\n", before, after);
 
 	/* 'before' is each, we attach uprobe for every set idx */
-	for (idx = 0; idx < 4; idx++) {
+	for (idx = 0; idx < 6; idx++) {
 		if (test_bit(idx, before)) {
 			if (!ASSERT_OK(uprobe_attach(skel, idx), "uprobe_attach_before"))
 				goto cleanup;
@@ -866,7 +876,7 @@ static int consumer_test(struct uprobe_multi_consumers *skel,
 	if (!ASSERT_EQ(err, 0, "uprobe_consumer_test"))
 		goto cleanup;
 
-	for (idx = 0; idx < 4; idx++) {
+	for (idx = 0; idx < 6; idx++) {
 		const char *fmt = "BUG";
 		__u64 val = 0;
 
@@ -878,18 +888,38 @@ static int consumer_test(struct uprobe_multi_consumers *skel,
 			if (test_bit(idx, before))
 				val++;
 			fmt = "prog 0/1: uprobe";
-		} else {
+		} else if (idx < 4) {
 			/*
 			 * to trigger uretprobe consumer, the uretprobe needs to be installed,
 			 * which means one of the 'return' uprobes was alive when probe was hit:
 			 *
-			 *   idxs: 2/3 uprobe return in 'installed' mask
+			 *   idxs: 2/3/4 uprobe return in 'installed' mask
 			 */
-			unsigned long had_uretprobes  = before & 0b1100; /* is uretprobe installed */
+			unsigned long had_uretprobes  = before & 0b011100; /* is uretprobe installed */
 
 			if (had_uretprobes && test_bit(idx, after))
 				val++;
 			fmt = "idx 2/3: uretprobe";
+		} else if (idx == 4) {
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
+			fmt = "idx 4  : session with return";
+		} else if (idx == 5) {
+			/*
+			 * session without return
+			 *   +1 if defined in 'before'
+			 */
+			if (test_bit(idx, before))
+				val++;
+			fmt = "idx 5  : session with NO return";
 		}
 
 		if (!ASSERT_EQ(skel->bss->uprobe_result[idx], val, fmt))
@@ -900,7 +930,7 @@ static int consumer_test(struct uprobe_multi_consumers *skel,
 	ret = 0;
 
 cleanup:
-	for (idx = 0; idx < 4; idx++)
+	for (idx = 0; idx < 6; idx++)
 		uprobe_detach(skel, idx);
 	return ret;
 }
@@ -920,40 +950,45 @@ static void test_consumers(void)
 	 *
 	 *  - 2 uprobe entry consumer
 	 *  - 2 uprobe exit consumers
+	 *  - 2 uprobe session consumers
 	 *
-	 * The test uses 4 uprobes attached on single function, but that
-	 * translates into single uprobe with 4 consumers in kernel.
+	 * The test uses 6 uprobes attached on single function, but that
+	 * translates into single uprobe with 6 consumers in kernel.
 	 *
 	 * The before/after values present the state of attached consumers
 	 * before and after the probed function:
 	 *
 	 *  bit/prog 0,1 : uprobe entry
 	 *  bit/prog 2,3 : uprobe return
+	 *  bit/prog 4   : uprobe session with return
+	 *  bit/prog 5   : uprobe session without return
 	 *
 	 * For example for:
 	 *
-	 *   before = 0b0101
-	 *   after  = 0b0110
+	 *   before = 0b010101
+	 *   after  = 0b000110
 	 *
 	 * it means that before we call 'uprobe_consumer_test' we attach
 	 * uprobes defined in 'before' value:
 	 *
 	 *   - bit/prog 0: uprobe entry
 	 *   - bit/prog 2: uprobe return
+	 *   - bit/prog 4: uprobe session with return
 	 *
 	 * uprobe_consumer_test is called and inside it we attach and detach
 	 * uprobes based on 'after' value:
 	 *
 	 *   - bit/prog 0: stays untouched
 	 *   - bit/prog 2: uprobe return is detached
+	 *   - bit/prog 4: uprobe session is detached
 	 *
 	 * uprobe_consumer_test returns and we check counters values increased
 	 * by bpf programs on each uprobe to match the expected count based on
 	 * before/after bits.
 	 */
 
-	for (before = 0; before < 16; before++) {
-		for (after = 0; after < 16; after++)
+	for (before = 0; before < 64; before++) {
+		for (after = 0; after < 64; after++)
 			if (consumer_test(skel, before, after))
 				goto out;
 	}
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c b/tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c
index 7e0fdcbbd242..448b753a4c66 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c
@@ -8,7 +8,7 @@
 
 char _license[] SEC("license") = "GPL";
 
-__u64 uprobe_result[4];
+__u64 uprobe_result[6];
 
 SEC("uprobe.multi")
 int uprobe_0(struct pt_regs *ctx)
@@ -37,3 +37,17 @@ int uprobe_3(struct pt_regs *ctx)
 	uprobe_result[3]++;
 	return 0;
 }
+
+SEC("uprobe.session")
+int uprobe_4(struct pt_regs *ctx)
+{
+	uprobe_result[4]++;
+	return 0;
+}
+
+SEC("uprobe.session")
+int uprobe_5(struct pt_regs *ctx)
+{
+	uprobe_result[5]++;
+	return 1;
+}
-- 
2.46.1


