Return-Path: <bpf+bounces-54454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5566A6A53E
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 12:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE52F883957
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 11:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C088C221578;
	Thu, 20 Mar 2025 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozQA0tXz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4219121D3EB;
	Thu, 20 Mar 2025 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471073; cv=none; b=hAK0l3/rhQllp+3kfUMgu+NBEjvw6PK5BkRdKx82n+gMke1bt5diDaImmlry97EjnRFJosNxNXp6l1XCWwGqkOAV06ml1ln9/qoR8PgoWK+4esztIP6Dg0lzDi++OqHSpUXRKpb296UcplBLi90A9lVnxPhIZ03YA7/PbFgA/gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471073; c=relaxed/simple;
	bh=QHeRP+3vFIU4kzTD64Z50sxitOHVSEPLwnAxE9SvpDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzsnQFCeYuRBQVcuVb1fy80wBLTpe4gaGaqTnMnS83SShM71uMs9n05AoUzwp8RwLX/fMs6HHUCaeT3lTQ23TQA/6mZZBjxRMGRKSiQNEkpxqvexkPb+8Vy7ePAN5hIUd7LPoJ1RnJDA0ZaEzklc6/6X7KrbyHQtkQ0V4jpni+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozQA0tXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B2CC4CEDD;
	Thu, 20 Mar 2025 11:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742471072;
	bh=QHeRP+3vFIU4kzTD64Z50sxitOHVSEPLwnAxE9SvpDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ozQA0tXzVwBTPNlA7ZheDZOSRMmKXEP+mmAMnjHpBp6WxSzAzr3T1586ngxyRcPWK
	 M8xBP62SSlS6FQ/bA6XgSZCEF3/5hK9ikG+OqxZFxQMwt6mApegxPJj8joOMCyjb6W
	 zj41DBk/2+mgemsxQ9KE6xPh/uVfEjZT2YW7fhGnmZTDLjosGkVvBqWxig/D04Hm1k
	 UDRBPGzHSD+G+NVY2F++nmYgMN9pd1S3VR6nVU2bcxhHYUungey/6JL5rG4ndr9zPj
	 3C5zHeram9bLxfYqQSXZ3TymKpGnQqfaPrUBSx1nrtr2vrNGDtnXCSudE4aFrmDCGD
	 1hYDPK3I4WT7A==
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
Subject: [PATCH RFCv3 13/23] selftests/bpf: Reorg the uprobe_syscall test function
Date: Thu, 20 Mar 2025 12:41:48 +0100
Message-ID: <20250320114200.14377-14-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320114200.14377-1-jolsa@kernel.org>
References: <20250320114200.14377-1-jolsa@kernel.org>
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
2.49.0


