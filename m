Return-Path: <bpf+bounces-54455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9FDA6A542
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 12:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1947D885CD8
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 11:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E07A22157E;
	Thu, 20 Mar 2025 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQImAj/f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8520421D3DD;
	Thu, 20 Mar 2025 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471083; cv=none; b=fGoW/mVGRZ59GxN+DxEexRZYjK0+Et+oehKYzB9xsovZu1oHmvY7s7BHR1lWPYuUPrTrZ6rTw7mLY1I3oiNgy++v0jNiryIIKcFEze0Y7I8VoUwuAIx5mjeJAjj6QZxM17Z8vp+6TRmZKZJiPulpnm79a1lHcwe0skCbkeyVaww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471083; c=relaxed/simple;
	bh=QVQ6qfmvUrSx0DydWdPijoOQliv6RaIe4HgM86uPyfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N35nZrBl4ID5P/dDP+0ErP4mdaUHyPu/kzaCOIyFSh2d8D5sY8RlJFM+Ho9+SeqUM5ArlAkqkjqoA+jMWhXnxYPOZTzeb6G3tG2+Bg8jj38fEwmEwRQsWA51OqyDYVwDIM/w00IDrBtsoDZltkzniTbpQ+DaqnO7w4Ds8SMB+xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQImAj/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3461C4CEDD;
	Thu, 20 Mar 2025 11:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742471083;
	bh=QVQ6qfmvUrSx0DydWdPijoOQliv6RaIe4HgM86uPyfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bQImAj/flnPXh4Q26y1WGu3RyEprlDQHFDXBRWk9ZW0CxgB4LKTVMhLarQepHmpex
	 bs0h+2vvtdHcvGz3hpii48FoWQrTb3VYa4t9GTtM+VgnnRsyWpkaDsSfwBR0RGRNuO
	 kqdEEtoKc4edl4nu7dv853qEA3RFupWa/gurYbtuep4qTahrXD6Gtqo2ZtUVEEUp0d
	 zI+Nxwu++UiEh81iFlyqjkof9qrXjd/JEtbsTMW5RDJcNK0/RsmggFYJjRw/o7bbMh
	 4t7VjxwHhgTzFsoyhqXJNXcp0fhFBqisPhr3SP8SNqIy23w3f7VrJ46qJ2j9lA0OEw
	 e6//3a7XF/qFA==
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
Subject: [PATCH RFCv3 14/23] selftests/bpf: Rename uprobe_syscall_executed prog to test_uretprobe_multi
Date: Thu, 20 Mar 2025 12:41:49 +0100
Message-ID: <20250320114200.14377-15-jolsa@kernel.org>
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


