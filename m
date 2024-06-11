Return-Path: <bpf+bounces-31818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDFE9039F4
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 13:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08CB31C2144D
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 11:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B331117BB1F;
	Tue, 11 Jun 2024 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8D2OKRs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295C117A93A;
	Tue, 11 Jun 2024 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718105036; cv=none; b=qB35osB5FDT1lFB9hZOnmkr7/TewKob2NFR+GaCsCehWfD3tcvvWN6FtfLb/kGGAloS+4fE/pJhDwC4cqJv7ZnYW5hz8RFFE09WxUSRbQFjd12nvpG6PM1L83hhbnbbR1ppPFS7x6dpzcJym9nzB4Soc70uVPUQVHPCcxo4A9BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718105036; c=relaxed/simple;
	bh=/8nbAp1OS2X1ovAw089c1Fq7pMcHWVM163XH0tCI8M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXR8+H8ANGn4llM9AH74FTAH00rOAuPwg1VrBRtvrwHhyG92sUCDD6McaS9EXVbsCblMWaBsu9a5vWB+NlOAMKy6WpDDfnpFZgHjhiMGWbGA9zEF2Q5o4KI109YOOnKtd5HgSSWIkIdDS537mHlrXpkAif1H27akKCV9RVeEmXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8D2OKRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9361EC2BD10;
	Tue, 11 Jun 2024 11:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718105035;
	bh=/8nbAp1OS2X1ovAw089c1Fq7pMcHWVM163XH0tCI8M0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L8D2OKRsMCOkyWAJXAdC5j6d8MlciLvsnlc0yB2gnuY7N4CrjOoZrm9ZVr1CP45FJ
	 oob9F2O+eRZpmi+MvB/dHJem9Sx3Rd412NZ7zGDqU7zfUsO2B9JCnyjWcaQCmI/mPc
	 CckGizsqCttV0oFQX6qDE6MlUjiBEDAJOSwmGTtHptiDsOWm7L3IknfMVtGhXkj+Hd
	 pQHjTqoPnR2DVp/bj6IIreeMAdRtM7dI7LEnNTR4F0DHzKt4rDJ4svOnDvtN+AxBLI
	 5R8h5P6bg9pXo7KIjTjjjOYslRO3UGf5r3Mg2ydCXFRuUT6FJYrjvb39fxLO1dOjgl
	 +aHb3gK1FZOBg==
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
Subject: [PATCHv8 9/9] man2: Add uretprobe syscall page
Date: Tue, 11 Jun 2024 13:21:58 +0200
Message-ID: <20240611112158.40795-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611112158.40795-1-jolsa@kernel.org>
References: <20240611112158.40795-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding man page for new uretprobe syscall.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
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


