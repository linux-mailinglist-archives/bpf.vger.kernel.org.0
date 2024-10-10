Return-Path: <bpf+bounces-41634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1904999385
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3FA282BCA
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 20:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45C21E3773;
	Thu, 10 Oct 2024 20:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9xq3G4a"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396D31D31B2;
	Thu, 10 Oct 2024 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728591182; cv=none; b=Fwg1sCCgyeaqu1kEtKgLxy2cDETmlgm6yOeafTl00iXGfQBdf2IoqyNFE/e3ytwHsLm+6x+NKzs+v7Aw5SywgNEE7cPrASHchwH4EHVxR4XQQwsOHa0sh42jvCbQ5pJMR3n2zb7yFZSZ7rJDBHLpCqP59Z9XVxHanlOTTYObIMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728591182; c=relaxed/simple;
	bh=JGc9i062+P//gbMEIPHizp07D5rtK3D6ZFWovEKATw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwI1i7pxqMUebe75aAaPNGaz0OEw4dTj6zwaddcMejSIcIyrquIf/Ry/UTRhrhv2X//XysmbPuJh2zgQpfFqUWBzn4DvI4RIuKu8uEE4sAXk11pCoRUrHTM08Q32Td0mO1F/Ti5POX8bsQLR7wJexHPDPM8Qzu6xuOABTFx8aW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9xq3G4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DA6C4CEC5;
	Thu, 10 Oct 2024 20:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728591181;
	bh=JGc9i062+P//gbMEIPHizp07D5rtK3D6ZFWovEKATw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A9xq3G4ajGFnJ/xOnKI7s8+OWKGqLUrSGPBZuZlFZXqfhz5Y6DqpEwel3Tw/50Yzg
	 2NkNsbMBWI4CF34SzQBIVi2BzVtSJvbsy2vKaimyVy6q0yiumrZvpsaPdCWagudUJP
	 gahhyJbmOaaBx7hr7FfszBqGWY0Sk3qZ3AoRq4vXE/RH1uYRzYbpskuAjYya1NvV4G
	 Kziry/YV8hny2lf/Q3cGlx9kGqtmLL5V9A1VLEEBg+FDUVdMr6JL8hx7n/kbXjlK92
	 pXgUxP0Sh052+n44GtzK1AS4Yg4/lzPXtYqR5esskfWHswouxIb7eoCjFlFepE+f/1
	 hEfmUn08pRGvw==
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
Subject: [PATCHv6 bpf-next 15/16] selftests/bpf: Add uprobe sessions to consumer test
Date: Thu, 10 Oct 2024 22:09:56 +0200
Message-ID: <20241010200957.2750179-16-jolsa@kernel.org>
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

Adding uprobe session consumers to the consumer test,
so we get the session into the test mix.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 63 +++++++++++++++----
 .../bpf/progs/uprobe_multi_consumers.c        | 16 ++++-
 2 files changed, 66 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 2effe4d693b4..df9314309bc3 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -761,6 +761,10 @@ get_program(struct uprobe_multi_consumers *skel, int prog)
 		return skel->progs.uprobe_0;
 	case 1:
 		return skel->progs.uprobe_1;
+	case 2:
+		return skel->progs.uprobe_2;
+	case 3:
+		return skel->progs.uprobe_3;
 	default:
 		ASSERT_FAIL("get_program");
 		return NULL;
@@ -775,6 +779,10 @@ get_link(struct uprobe_multi_consumers *skel, int link)
 		return &skel->links.uprobe_0;
 	case 1:
 		return &skel->links.uprobe_1;
+	case 2:
+		return &skel->links.uprobe_2;
+	case 3:
+		return &skel->links.uprobe_3;
 	default:
 		ASSERT_FAIL("get_link");
 		return NULL;
@@ -793,8 +801,11 @@ static int uprobe_attach(struct uprobe_multi_consumers *skel, int idx)
 	/*
 	 * bit/prog: 0 uprobe entry
 	 * bit/prog: 1 uprobe return
+	 * bit/prog: 2 uprobe session without return
+	 * bit/prog: 3 uprobe session with return
 	 */
 	opts.retprobe = idx == 1;
+	opts.session  = idx == 2 || idx == 3;
 
 	*link = bpf_program__attach_uprobe_multi(prog, 0, "/proc/self/exe",
 						"uprobe_consumer_test",
@@ -824,7 +835,7 @@ uprobe_consumer_test(struct uprobe_multi_consumers *skel,
 	int idx;
 
 	/* detach uprobe for each unset programs in 'before' state ... */
-	for (idx = 0; idx < 1; idx++) {
+	for (idx = 0; idx < 4; idx++) {
 		if (test_bit(idx, before) && !test_bit(idx, after))
 			uprobe_detach(skel, idx);
 	}
@@ -847,7 +858,7 @@ static int consumer_test(struct uprobe_multi_consumers *skel,
 	printf("consumer_test before %lu after %lu\n", before, after);
 
 	/* 'before' is each, we attach uprobe for every set idx */
-	for (idx = 0; idx < 1; idx++) {
+	for (idx = 0; idx < 4; idx++) {
 		if (test_bit(idx, before)) {
 			if (!ASSERT_OK(uprobe_attach(skel, idx), "uprobe_attach_before"))
 				goto cleanup;
@@ -858,11 +869,13 @@ static int consumer_test(struct uprobe_multi_consumers *skel,
 	if (!ASSERT_EQ(err, 0, "uprobe_consumer_test"))
 		goto cleanup;
 
-	for (idx = 0; idx < 1; idx++) {
+	for (idx = 0; idx < 4; idx++) {
+		unsigned long had_uretprobes;
 		const char *fmt = "BUG";
 		__u64 val = 0;
 
-		if (idx == 0) {
+		switch (idx) {
+		case 0:
 			/*
 			 * uprobe entry
 			 *   +1 if define in 'before'
@@ -870,18 +883,42 @@ static int consumer_test(struct uprobe_multi_consumers *skel,
 			if (test_bit(idx, before))
 				val++;
 			fmt = "prog 0: uprobe";
-		} else {
+			break;
+		case 1:
 			/*
 			 * to trigger uretprobe consumer, the uretprobe needs to be installed,
 			 * which means one of the 'return' uprobes was alive when probe was hit:
 			 *
-			 *   idxs: 2/3 uprobe return in 'installed' mask
+			 *   idxs: 1/2 uprobe return in 'installed' mask
 			 */
-			unsigned long had_uretprobes = before & 0b10; /* is uretprobe installed */
+			had_uretprobes = before & 0b0110; /* is uretprobe installed */
 
 			if (had_uretprobes && test_bit(idx, after))
 				val++;
 			fmt = "prog 1: uretprobe";
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
+			fmt = "prog 2  : session with return";
+			break;
+		case 3:
+			/*
+			 * session without return
+			 *   +1 if defined in 'before'
+			 */
+			if (test_bit(idx, before))
+				val++;
+			fmt = "prog 3  : session with NO return";
+			break;
 		}
 
 		if (!ASSERT_EQ(skel->bss->uprobe_result[idx], val, fmt))
@@ -892,7 +929,7 @@ static int consumer_test(struct uprobe_multi_consumers *skel,
 	ret = 0;
 
 cleanup:
-	for (idx = 0; idx < 1; idx++)
+	for (idx = 0; idx < 4; idx++)
 		uprobe_detach(skel, idx);
 	return ret;
 }
@@ -912,9 +949,11 @@ static void test_consumers(void)
 	 *
 	 *  - 1 uprobe entry consumer
 	 *  - 1 uprobe exit consumer
+	 *  - 1 uprobe session with return
+	 *  - 1 uprobe session without return
 	 *
-	 * The test uses 2 uprobes attached on single function, but that
-	 * translates into single uprobe with 2 consumers in kernel.
+	 * The test uses 4 uprobes attached on single function, but that
+	 * translates into single uprobe with 4 consumers in kernel.
 	 *
 	 * The before/after values present the state of attached consumers
 	 * before and after the probed function:
@@ -943,8 +982,8 @@ static void test_consumers(void)
 	 * before/after bits.
 	 */
 
-	for (before = 0; before < 4; before++) {
-		for (after = 0; after < 4; after++)
+	for (before = 0; before < 16; before++) {
+		for (after = 0; after < 16; after++)
 			if (consumer_test(skel, before, after))
 				goto out;
 	}
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c b/tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c
index 1c64d7263911..93752bb5690b 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c
@@ -8,7 +8,7 @@
 
 char _license[] SEC("license") = "GPL";
 
-__u64 uprobe_result[2];
+__u64 uprobe_result[4];
 
 SEC("uprobe.multi")
 int uprobe_0(struct pt_regs *ctx)
@@ -23,3 +23,17 @@ int uprobe_1(struct pt_regs *ctx)
 	uprobe_result[1]++;
 	return 0;
 }
+
+SEC("uprobe.session")
+int uprobe_2(struct pt_regs *ctx)
+{
+	uprobe_result[2]++;
+	return 0;
+}
+
+SEC("uprobe.session")
+int uprobe_3(struct pt_regs *ctx)
+{
+	uprobe_result[3]++;
+	return 1;
+}
-- 
2.46.2


