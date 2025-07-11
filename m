Return-Path: <bpf+bounces-63031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B56FB0166A
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 10:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01A75C1658
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 08:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB1F2222BF;
	Fri, 11 Jul 2025 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/anLJyk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A79221734;
	Fri, 11 Jul 2025 08:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222858; cv=none; b=sdAchnmepp0x0LR9xgdY6GcSDooDJvLHurEkEqgzXwnJTk4flHr9hS7s1LlR42gNwZigVFOjwpyTVPGmAmqpa8d5+6g9AsEXNKLeGERg8lY9RovOsee5wEWWVk7JNKAmqP/4DnjoU9ZX9/pQlmXu0nh/u7+muP1SJIs2xJTSpyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222858; c=relaxed/simple;
	bh=jrtUBEXr/HBWduLFh4HBAKqnbKpMavXjwB5mCt2wdr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxKCgSOlKJo1ZoSzNpQFETAwIQjh0pFgUWGho79nO98SbZhUp/D9n2bmvJ4d+4O4LGKiNmEMIABndOPy2H4PQf7J/J7fEcZ8LcFmmPFT22PQgr8XpyzaZR2VHGRWWXOF1mh9gEhk9K578If6w8xcaKZ3/y3p2CkJo4Y8hOWmT5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/anLJyk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77365C4CEED;
	Fri, 11 Jul 2025 08:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752222856;
	bh=jrtUBEXr/HBWduLFh4HBAKqnbKpMavXjwB5mCt2wdr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n/anLJykAkwr5mYuzdLQBE2o1MJ6e/AnSCA/gjL9Pgci6NK6Sx8EKRIakSpp+ANVk
	 2n+4HJJp9vZdl2ZIT+VIRcvZFtmzclVZkbNwn3d2NIyad0bHrTm7Pkiy9R4l+VrOgW
	 RWgt+QOwngEdplZGtl6XAL5T5/ugotc4q6SKG7EgJusPp8rVul9jZv3PtUzOiuR1xd
	 xUICy3pukGDjUs+KR/IUF11iBK5lxIawo415doxiImPve593eaAGinXJ2u557WRNE4
	 pT8MHMKFB/cVF7o5f4rOfyv/bRKEANmfPrLgaDgCHBMPbrO5FvLN5w3DEOPpyw3Txc
	 BxgNZQlXb5hVQ==
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
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCHv5 22/22] man2: Add uprobe syscall page
Date: Fri, 11 Jul 2025 10:29:30 +0200
Message-ID: <20250711082931.3398027-23-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711082931.3398027-1-jolsa@kernel.org>
References: <20250711082931.3398027-1-jolsa@kernel.org>
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
Reviewed-by: Alejandro Colomar <alx@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 man/man2/uprobe.2    |  1 +
 man/man2/uretprobe.2 | 36 ++++++++++++++++++++++++------------
 2 files changed, 25 insertions(+), 12 deletions(-)
 create mode 100644 man/man2/uprobe.2

diff --git a/man/man2/uprobe.2 b/man/man2/uprobe.2
new file mode 100644
index 000000000000..ea5ccf901591
--- /dev/null
+++ b/man/man2/uprobe.2
@@ -0,0 +1 @@
+.so man2/uretprobe.2
diff --git a/man/man2/uretprobe.2 b/man/man2/uretprobe.2
index bbbfb0c59335..df0e5d92e5ed 100644
--- a/man/man2/uretprobe.2
+++ b/man/man2/uretprobe.2
@@ -2,22 +2,28 @@
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
 .BR SIGILL .
@@ -26,22 +32,28 @@ The return value is architecture-specific.
 .SH ERRORS
 .TP
 .B SIGILL
-.BR uretprobe ()
-was called by a user-space program.
+These system calls
+were called by a user-space program.
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
2.49.0


