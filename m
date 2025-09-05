Return-Path: <bpf+bounces-67615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F8BB4650F
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 22:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A981CC7C6F
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 20:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281472ECE89;
	Fri,  5 Sep 2025 20:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxBVW1vW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988612E36F1;
	Fri,  5 Sep 2025 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757105902; cv=none; b=XvHRJvqvutXoKgNHyZ+ZdHS/h0kZ8O+Y13CecTRT04x+3XDTnHUWuQv7uFHAD5l2kprSC+ov9nPX6+HyCum7vdrPgXGgPSEwgJK56Xy4qhfjPK5Pnif4cr6zHlaYUxH/nQ/G6RId9y/SfIqu04yMTqYdqzNioKYnJ0WFAzej5Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757105902; c=relaxed/simple;
	bh=JKhp4iQNMvplNSLCvN5SbNCBpcxiojFisJJsDiDMSK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqJGQtIuIjOrLa7EkztLH+e5oSZMq5GU3Ui9sH9fLddRk8uACD9PrSVXvBs1N0VIorF101hgHPqUN3DC6KSJm3314CZa7M3IT2PnpXndWmioVl5tT/ta2TECwWjmkn4aYBBrm6XeIuG5Oge+Sci2c3/k1kh6jBh1HTR3psQsp6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxBVW1vW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3AEC4CEF5;
	Fri,  5 Sep 2025 20:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757105902;
	bh=JKhp4iQNMvplNSLCvN5SbNCBpcxiojFisJJsDiDMSK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YxBVW1vWumM5gPr2bg33BaUr70e2KrfBOaxFU20CtmMlS7kxaWIuTMVyw6ZMnt5Bk
	 icOm9PeLGdLK2SDkPxYKaMXBZYfV6Y23i0udnpdvneysBIer2KI5gWr/Mfo1XNmpsF
	 k4wQ6zhy8t+eaNMQD2B73LrIiSvsQS0TZ9G9MvjBP6faOqFKZPyFYae2kRnmDk33Ya
	 Iww5HG1inffS+2oJBtcq9isHAgZ7hBqD75qZ+pm0gQWXCoQjcQU581NQ66Bur5CgEH
	 SdXeJ5OpYUgiDGjpVctfFjcRAC6FS22M+dpDJM9vahQJIwaYenPL2h3ZeBvuI6jx/t
	 GLtsNs690QyHw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>,
	bpf@vger.kernel.org,
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
	Ingo Molnar <mingo@kernel.org>,
	Jann Horn <jannh@google.com>
Subject: [PATCH 3/3] man2: Add uprobe syscall page
Date: Fri,  5 Sep 2025 22:57:31 +0200
Message-ID: <20250905205731.1961288-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905205731.1961288-1-jolsa@kernel.org>
References: <20250905205731.1961288-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changing uretprobe syscall man page to be shared with new
uprobe syscall man page.

Cc: Alejandro Colomar <alx@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 man/man2/uprobe.2    |  1 +
 man/man2/uretprobe.2 | 42 +++++++++++++++++++++++++++++-------------
 2 files changed, 30 insertions(+), 13 deletions(-)
 create mode 100644 man/man2/uprobe.2

diff --git a/man/man2/uprobe.2 b/man/man2/uprobe.2
new file mode 100644
index 000000000000..ea5ccf901591
--- /dev/null
+++ b/man/man2/uprobe.2
@@ -0,0 +1 @@
+.so man2/uretprobe.2
diff --git a/man/man2/uretprobe.2 b/man/man2/uretprobe.2
index c81d4c5313a3..a1e4a1fa56f4 100644
--- a/man/man2/uretprobe.2
+++ b/man/man2/uretprobe.2
@@ -2,46 +2,62 @@
 .\"
 .\" SPDX-License-Identifier: Linux-man-pages-copyleft
 .\"
-.TH uretprobe 2 (date) "Linux man-pages (unreleased)"
+.TH uprobe 2 (date) "Linux man-pages (unreleased)"
 .SH NAME
+uprobe,
 uretprobe
 \-
-execute pending return uprobes
+execute pending entry or return uprobes
 .SH SYNOPSIS
 .nf
+.B int uprobe(void);
 .B int uretprobe(void);
 .fi
 .SH DESCRIPTION
+.BR uprobe ()
+is an alternative to breakpoint instructions
+for triggering entry uprobe consumers.
+.P
 .BR uretprobe ()
 is an alternative to breakpoint instructions
 for triggering return uprobe consumers.
 .P
 Calls to
-.BR uretprobe ()
+these system calls
 are only made from the user-space trampoline provided by the kernel.
 Calls from any other place result in a
-.BR SIGILL .
+.BR SIGILL
+or error value (see below).
+
 .SH RETURN VALUE
 The return value is architecture-specific.
 .SH ERRORS
 .TP
 .B SIGILL
-.BR uretprobe ()
-was called by a user-space program.
+uretprobe() was called by a user-space program.
+.TP
+.B ENXIO
+uprobe() was called by a user-space program.
 .SH VERSIONS
 The behavior varies across systems.
 .SH STANDARDS
 None.
 .SH HISTORY
+.TP
+.BR uprobe ()
+TBD
+.TP
+.BR uretprobe ()
 Linux 6.11.
 .P
-.BR uretprobe ()
-was initially introduced for the x86_64 architecture
-where it was shown to be faster than breakpoint traps.
-It might be extended to other architectures.
+These system calls
+were initially introduced for the x86_64 architecture
+where they were shown to be faster than breakpoint traps.
+They might be extended to other architectures.
 .SH CAVEATS
-.BR uretprobe ()
-exists only to allow the invocation of return uprobe consumers.
-It should
+These system calls
+exist only to allow the invocation of
+entry or return uprobe consumers.
+They should
 .B never
 be called directly.
-- 
2.51.0


