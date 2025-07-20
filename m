Return-Path: <bpf+bounces-63854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA5FB0B595
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 13:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7726C189C94E
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 11:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B0D219A6B;
	Sun, 20 Jul 2025 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOC4qUcr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45C62080C8;
	Sun, 20 Jul 2025 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753010751; cv=none; b=aww5uLe17jt6R5S/XkHyriKsfbqM9qd2IIGJB2DZXtvlGMgtYjDyqac8XXWQWNpv98g0Ea9cbr3YqxTWOsu8NygE6qWa5ML0Bc72Zuci6p79naemPUNkE8qXDrMEq1J5NV/EOO/UvusRSkKTK9FpgJmat2qyI27VwocfslS1DxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753010751; c=relaxed/simple;
	bh=0SrhICvUGRiP7kpUGTH3UD+WPF2mV6G/vO2pnCZmge4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=InrXAQPeTbA2yEBA30XWgNDKGVlwDBncQhanbxiGtITIsQ3yO+SfR5mEtyYq0N9K894icwlkSnu5IRNmjWbeE924OxDLR/M7/zCwVX6+Kqqm/ttEV6OMym6vClMAmFwDhn2q3uLZV/5yjW0n4DqECJs4em+ipExffophoOaBIpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOC4qUcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99857C4CEE7;
	Sun, 20 Jul 2025 11:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753010750;
	bh=0SrhICvUGRiP7kpUGTH3UD+WPF2mV6G/vO2pnCZmge4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kOC4qUcrfqDyhup7CQD+kZURESws7IE/gk1MObkHQDz3o5aasiUSla0twppHPtb78
	 0sWwY5qza7ZsM0B+tckv+rz3HS9Tx974q+Cu9XqSbVK+UX5CxoF5JtUko+WdWpJi1O
	 ka4O/WAuR16Bb6LS20dBIo4eINqi2GnJGq0YuRyMHlYJlm35MPtclEydTU4sMDelUU
	 6z69mSZ65bn0lYCqpit59ncUlyvjuMPwOEhyHUFc/WCsP1p5JWenSg878DefpriFxY
	 BvqxRPCv07QdpW7jYHmcmjd6ruLySzTVQoclBulFlWLFNKGBSEEMyXnck5BnYWIcmH
	 /kVK/K2wpe38g==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCHv5 22/22] man2: Add uprobe syscall page
Date: Sun, 20 Jul 2025 13:21:32 +0200
Message-ID: <20250720112133.244369-23-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250720112133.244369-1-jolsa@kernel.org>
References: <20250720112133.244369-1-jolsa@kernel.org>
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
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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


