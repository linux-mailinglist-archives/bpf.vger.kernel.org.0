Return-Path: <bpf+bounces-56342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A5AA9584F
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 23:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401183B6C17
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 21:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA23F21C9FF;
	Mon, 21 Apr 2025 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3ref8Qx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F33821B909;
	Mon, 21 Apr 2025 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745272029; cv=none; b=Jfb3hfoTt6rO66DjcevkbyJyQT5k4B+sf7NhNcNsMGneftinTREo5b4JiodUKnp6cGzcyCIvLoCAfS7jpFPwIV/++DWwFdNtdCnjJz52cKUqplrfinVW17Himdhc9pPb1o4Ln7MZ7tZ4BI/kcYd9cTQ0O8k5uwWhOpWRAj/1w5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745272029; c=relaxed/simple;
	bh=QVQ6qfmvUrSx0DydWdPijoOQliv6RaIe4HgM86uPyfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpNZBMk845/qX6BExU5SiG01ECrryT5JxiXc4bUyvQ3jM8vPDDnlAaie1NA2IaYvOybUb9hz/VMYxyVugrzgb5Thh6U0Di7whDPJNFXaOl5aD86QwFEJWWTB0VGePUrKtB99bBNd/lWNqiEzn2YqLoW8b0HRXmeQGmm2e3t8cCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3ref8Qx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B480DC4CEE4;
	Mon, 21 Apr 2025 21:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745272029;
	bh=QVQ6qfmvUrSx0DydWdPijoOQliv6RaIe4HgM86uPyfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S3ref8QxeNdSlGO49mcYKZDWNLyPqc7ezuxj8vPUPuWH4HA95NObE8dnpxIC0Fla3
	 WXGQk6YwBTgFEdGr8OEvZqVS7d1Jro7DbM59Ys3xgx0l9lJPO066Eg8zTMDGgY/3UY
	 0MsR0dmNjl5/+uWTzQhJECP8vQC7RSEGvm00jWSe3WKYGxL/BoyEpUiSyZnZ0Poobm
	 LrHwA3f7yfVCvmu+gFkYFRHE0rMUNaULmepbscTEfqLpxh0GkulslN1/kNF82YtRjO
	 mU6iqn0E8FrZFnydT7FfDTT75Lb1UR3YugYvLicSxJ+U+qzbgjgsHUkZ8quC5ntVIJ
	 aWh+xP9aLDLNw==
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
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH perf/core 13/22] selftests/bpf: Rename uprobe_syscall_executed prog to test_uretprobe_multi
Date: Mon, 21 Apr 2025 23:44:13 +0200
Message-ID: <20250421214423.393661-14-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421214423.393661-1-jolsa@kernel.org>
References: <20250421214423.393661-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Renaming uprobe_syscall_executed prog to test_uretprobe_multi
to fit properly in the following changes that add more programs.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c   | 8 ++++----
 .../testing/selftests/bpf/progs/uprobe_syscall_executed.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 2b00f16406c8..3c74a079e6d9 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -277,10 +277,10 @@ static void test_uretprobe_syscall_call(void)
 		_exit(0);
 	}
 
-	skel->links.test = bpf_program__attach_uprobe_multi(skel->progs.test, pid,
-							    "/proc/self/exe",
-							    "uretprobe_syscall_call", &opts);
-	if (!ASSERT_OK_PTR(skel->links.test, "bpf_program__attach_uprobe_multi"))
+	skel->links.test_uretprobe_multi = bpf_program__attach_uprobe_multi(skel->progs.test_uretprobe_multi,
+							pid, "/proc/self/exe",
+							"uretprobe_syscall_call", &opts);
+	if (!ASSERT_OK_PTR(skel->links.test_uretprobe_multi, "bpf_program__attach_uprobe_multi"))
 		goto cleanup;
 
 	/* kick the child */
diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
index 0d7f1a7db2e2..2e1b689ed4fb 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
@@ -10,8 +10,8 @@ char _license[] SEC("license") = "GPL";
 int executed = 0;
 
 SEC("uretprobe.multi")
-int test(struct pt_regs *regs)
+int test_uretprobe_multi(struct pt_regs *ctx)
 {
-	executed = 1;
+	executed++;
 	return 0;
 }
-- 
2.49.0


