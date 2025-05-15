Return-Path: <bpf+bounces-58300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A01AB8617
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 14:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 649D07A8166
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 12:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC08D29A9D3;
	Thu, 15 May 2025 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIOLwQe8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3717429A9C2;
	Thu, 15 May 2025 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747311275; cv=none; b=KjKag+fcMGSf0jLO2ibwkqA/cXT7DyScvZuPqRqldK5U6vQi0l0qgGRFETqF9iEliyFlsZV1+8o+QFeft1w7Kq9N10+O33R+BzBNs0PJQwNGccS6wmkUToL6Dp2sn0olsJNiPL3nppdH+KdczFNPIV+0X5/nik2yq92HiCODrXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747311275; c=relaxed/simple;
	bh=wkfoSntm5Pp+UmDvoO0w7Y7p9+zHwOucSdUtKm/ugzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdKF3YKMGDB8AOdx3T7RuFZOxU2Mw36q6yL9LbMFt5oXhfkp3PTg0UR4bcd5FMYbRN3FOtbi8KGq3yQcci3GceEbJ7SFPjVacwKSNlwCDGE1jZGH45bO4Seuoe1819kMx7+nQN3i/Fs4dMdFlFBgPgsEFhWgRsD2sgyzcDZyCmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIOLwQe8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7E5C4CEE7;
	Thu, 15 May 2025 12:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747311273;
	bh=wkfoSntm5Pp+UmDvoO0w7Y7p9+zHwOucSdUtKm/ugzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rIOLwQe8RDjwzDbYMjrVwVXewi5hCJdnLs7OS7PqrDJlvBIbQb505uVUTZLK/luYZ
	 gaIsAitCYhWT+0KCYAdOljk8c1q5Esz9Zd5i6EqEzSUZ7EJ3C67w0oTc05LPK3kr6I
	 wn5jPVFyKwTQA/tQwwcW436hIh3mjkrNTfk/oHuZWiVTEQfi0omZXmlRCIdSn2HwMx
	 dcf5sgJ9eC3Ckc5SIgAEFju3rdcHAXqPrfp2tLw5jcZQjagsO9mcNCgM0UeOwIVFUS
	 tC8fYb6RACqx4Fo6TfL9TbkJW8jZna7jI6zQmTbJSkfwyrTpO+V8H5RNdaaGSzbBPV
	 5vCS39NpnWdEA==
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
Subject: [PATCHv2 perf/core 13/22] selftests/bpf: Rename uprobe_syscall_executed prog to test_uretprobe_multi
Date: Thu, 15 May 2025 14:11:10 +0200
Message-ID: <20250515121121.2332905-14-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515121121.2332905-1-jolsa@kernel.org>
References: <20250515121121.2332905-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Renaming uprobe_syscall_executed prog to test_uretprobe_multi
to fit properly in the following changes that add more programs.

Plus adding pid filter and increasing executed variable.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c       | 12 ++++++++----
 .../selftests/bpf/progs/uprobe_syscall_executed.c   | 13 ++++++++++---
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 2b00f16406c8..1cce50b5d18c 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -252,6 +252,7 @@ static void test_uretprobe_syscall_call(void)
 	);
 	struct uprobe_syscall_executed *skel;
 	int pid, status, err, go[2], c;
+	struct bpf_link *link;
 
 	if (!ASSERT_OK(pipe(go), "pipe"))
 		return;
@@ -277,11 +278,14 @@ static void test_uretprobe_syscall_call(void)
 		_exit(0);
 	}
 
-	skel->links.test = bpf_program__attach_uprobe_multi(skel->progs.test, pid,
-							    "/proc/self/exe",
-							    "uretprobe_syscall_call", &opts);
-	if (!ASSERT_OK_PTR(skel->links.test, "bpf_program__attach_uprobe_multi"))
+	skel->bss->pid = pid;
+
+	link = bpf_program__attach_uprobe_multi(skel->progs.test_uretprobe_multi,
+						pid, "/proc/self/exe",
+						"uretprobe_syscall_call", &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_multi"))
 		goto cleanup;
+	skel->links.test_uretprobe_multi = link;
 
 	/* kick the child */
 	write(go[1], &c, 1);
diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
index 0d7f1a7db2e2..c4c3447378ba 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
@@ -8,10 +8,17 @@ struct pt_regs regs;
 char _license[] SEC("license") = "GPL";
 
 int executed = 0;
+int pid;
 
-SEC("uretprobe.multi")
-int test(struct pt_regs *regs)
+static int inc_executed(void)
 {
-	executed = 1;
+	if (bpf_get_current_pid_tgid() >> 32 == pid)
+		executed++;
 	return 0;
 }
+
+SEC("uretprobe.multi")
+int test_uretprobe_multi(struct pt_regs *ctx)
+{
+	return inc_executed();
+}
-- 
2.49.0


