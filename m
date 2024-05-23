Return-Path: <bpf+bounces-30397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA158CD20B
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 14:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539211F227B1
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 12:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995151494D3;
	Thu, 23 May 2024 12:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oerBvj3h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1314778C8B;
	Thu, 23 May 2024 12:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716466428; cv=none; b=JGGEu89J4U5XQQAXZ4UlB7zXFcia3mOjZT7tc0IeVVx+BUN3bx1kQnSaCa7UcMID83yQUV9jtSS8xdXEAO7nWGGKnizYmyeDCcUEVAeENF0fN1bicViGxKAJKqycbpsJeeSstKXPz+akLbaNBkKAoA5jwnAu4DXXFZnGY268uLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716466428; c=relaxed/simple;
	bh=MfUbeJoTsjQv1oAgkHcvkP4o8mZqbSse0UJ8mAO3EvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/C860NmTUCQItPBoGrS5zbEUl2SWP4Cv6tBZ8wtXKSZ8dlo1nGGKUMNM6pF4RDV4T2VBeOFpiw61SxImNp0fipkOn6BavmlSzyTCXUSMQm7s2n0o7QlI+44MjUUo98pbkiqEMnV+1HKJaGPNICxk6tBZPdwDI1BQ2xtjGjMfyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oerBvj3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC32AC2BD10;
	Thu, 23 May 2024 12:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716466427;
	bh=MfUbeJoTsjQv1oAgkHcvkP4o8mZqbSse0UJ8mAO3EvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oerBvj3h3QKjPUtyfXJaHNzzjfYa/N7eUF/3TlAAqIT11+KljwgDP6PsbAMCnM77e
	 nYKcjeINjpVZjePyZHmxLlKIIrAohYv6Rv+apTvTS+qiPZCrSQegaI83EJlzwpot/H
	 O0NqdO1g6da4w3HlAGCj2FUulCiwT44Thax2f27r44DENF8oBkgNXez5PbBCvaT6ni
	 9hmLZSXExvBnKdrMKsCrFbMjKnQbiCgOzUC6jCRWAsYxUuyYNAmjV0mG3OcjGFn94j
	 yKTHtbkSVNrhiPraDpVWWxMz7AalL7wr7OBwsg4vxRyOQxqwLLyRe/MoJ9S1Vs7+Bq
	 LNgrSWOR2XTJw==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-man@vger.kernel.org,
	x86@kernel.org,
	bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>
Subject: [PATCHv7 9/9] man2: Add uretprobe syscall page
Date: Thu, 23 May 2024 14:11:49 +0200
Message-ID: <20240523121149.575616-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523121149.575616-1-jolsa@kernel.org>
References: <20240523121149.575616-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding man page for new uretprobe syscall.

Reviewed-by: Alejandro Colomar <alx@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 man/man2/uretprobe.2 | 56 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 man/man2/uretprobe.2

diff --git a/man/man2/uretprobe.2 b/man/man2/uretprobe.2
new file mode 100644
index 000000000000..cf1c2b0d852e
--- /dev/null
+++ b/man/man2/uretprobe.2
@@ -0,0 +1,56 @@
+.\" Copyright (C) 2024, Jiri Olsa <jolsa@kernel.org>
+.\"
+.\" SPDX-License-Identifier: Linux-man-pages-copyleft
+.\"
+.TH uretprobe 2 (date) "Linux man-pages (unreleased)"
+.SH NAME
+uretprobe \- execute pending return uprobes
+.SH SYNOPSIS
+.nf
+.B int uretprobe(void)
+.fi
+.SH DESCRIPTION
+The
+.BR uretprobe ()
+system call is an alternative to breakpoint instructions for triggering return
+uprobe consumers.
+.P
+Calls to
+.BR uretprobe ()
+system call are only made from the user-space trampoline provided by the kernel.
+Calls from any other place result in a
+.BR SIGILL .
+.SH RETURN VALUE
+The
+.BR uretprobe ()
+system call return value is architecture-specific.
+.SH ERRORS
+.TP
+.B SIGILL
+The
+.BR uretprobe ()
+system call was called by a user-space program.
+.SH VERSIONS
+Details of the
+.BR uretprobe ()
+system call behavior vary across systems.
+.SH STANDARDS
+None.
+.SH HISTORY
+TBD
+.SH NOTES
+The
+.BR uretprobe ()
+system call was initially introduced for the x86_64 architecture
+where it was shown to be faster than breakpoint traps.
+It might be extended to other architectures.
+.P
+The
+.BR uretprobe ()
+system call exists only to allow the invocation of return uprobe consumers.
+It should
+.B never
+be called directly.
+Details of the arguments (if any) passed to
+.BR uretprobe ()
+and the return value are architecture-specific.
-- 
2.45.1


