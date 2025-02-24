Return-Path: <bpf+bounces-52356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 770A0A4229F
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3BB16E865
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 14:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD26F9F8;
	Mon, 24 Feb 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnsGlYyg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817677CF16;
	Mon, 24 Feb 2025 14:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405862; cv=none; b=OGIz84gBgoh59z34rUkvzrke62WFQuOaLafK1YSGVKDYs3bsy4Op4sUyPOF19y7bJTQxhq+O79Y0Z7Ymri0zIttLgxxtC5UY+tTOZssvowSC67uDAy/rPeQeJOFmGetaCho2u7VummUj1eaPH2jWp2UoRvTaKBUvs8DfkkfXbLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405862; c=relaxed/simple;
	bh=qgvtAvy/lQHHyQlSO/MP+VPDW1YH/O+scJk5Yrfi5EA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBsY3ycmHuTDGf2kDYp/VgADKn6/X/A8E6IZ1ddPC9wHnfF/BbHTT2o0kJr7qdLzV/EHTFkYcp2X99J4GHAakQ89DYVnWKd5MlR8xG/ViXmwA/EIASwipAXAf7aPcecjORc5r+QmU+iMpfvU4JqOJR3zkgiWOK3f7wq5khr9m3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnsGlYyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA1AC4CED6;
	Mon, 24 Feb 2025 14:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405862;
	bh=qgvtAvy/lQHHyQlSO/MP+VPDW1YH/O+scJk5Yrfi5EA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WnsGlYygn21uLlFUrTxlZT8TviSYmrs45cWMSiUn6jU3DZU+kQJ8NFA9zJPe8tnJD
	 +Je+kKjOS7BimRyJyWVT5XYSnyKzek9HK7HvnpOwU0kmOfvRFzMld/wxFIwQxslLKJ
	 L+NH+pwICiIotHhmBvU0AroCjm2NKq8ZlYnaBDPOMFBvl/MSvX78enGLJbFK8XdvGu
	 CBqA4KJ3uhcqRDJl57wZpxbS+vgUSWJxknRjwyLjn+vu0zQ0yhE81eTjJ/qonSGgcC
	 e9WCUOLwjoqZ+qkxGPP9R4QAzCwK7iZ6HruK2PpaaaWyLcnF8rFSNt8UuyPkIWP31n
	 EJXBvSrSij60g==
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
Subject: [PATCH RFCv2 13/18] selftests/bpf: Reorg the uprobe_syscall test function
Date: Mon, 24 Feb 2025 15:01:45 +0100
Message-ID: <20250224140151.667679-14-jolsa@kernel.org>
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

Adding __test_uprobe_syscall with non x86_64 stub to execute all the tests,
so we don't need to keep adding non x86_64 stub functions for new tests.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 34 +++++++------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index c397336fe1ed..2b00f16406c8 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -350,29 +350,8 @@ static void test_uretprobe_shadow_stack(void)
 
 	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
 }
-#else
-static void test_uretprobe_regs_equal(void)
-{
-	test__skip();
-}
-
-static void test_uretprobe_regs_change(void)
-{
-	test__skip();
-}
-
-static void test_uretprobe_syscall_call(void)
-{
-	test__skip();
-}
 
-static void test_uretprobe_shadow_stack(void)
-{
-	test__skip();
-}
-#endif
-
-void test_uprobe_syscall(void)
+static void __test_uprobe_syscall(void)
 {
 	if (test__start_subtest("uretprobe_regs_equal"))
 		test_uretprobe_regs_equal();
@@ -383,3 +362,14 @@ void test_uprobe_syscall(void)
 	if (test__start_subtest("uretprobe_shadow_stack"))
 		test_uretprobe_shadow_stack();
 }
+#else
+static void __test_uprobe_syscall(void)
+{
+	test__skip();
+}
+#endif
+
+void test_uprobe_syscall(void)
+{
+	__test_uprobe_syscall();
+}
-- 
2.48.1


