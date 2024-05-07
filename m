Return-Path: <bpf+bounces-28794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1058BE077
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 12:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FAE01F28305
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 10:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E685156F57;
	Tue,  7 May 2024 10:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXgJTo8F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACB614EC4D;
	Tue,  7 May 2024 10:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715079311; cv=none; b=LEWrJFxryrFgoBk5uuz9u9kYZ2UP2Hrtarq41rBBB2w8Sr8uQ5FZVqwj5/YEuxnZKtDADH3sKgQFEvXiVpELU/ESKwrsfYXSYnC/3UbgVTVVNmUBE+tl6j35ToiVUyFXwuOTw4zlbYhCS+volqSv3MMjgsHrrGo48iF3P/3SJV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715079311; c=relaxed/simple;
	bh=YOJAMtCe8DK1ux8SakApe84VXlSr5Oi60Hn13JG7aeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9Y/3K7NCPy39adYdVnaXRj+YNfLv2iGfwqLXxRHCfDkRTcuyC9xwYoffLiAZ3cPjmiKvkmTQ/JI81wkcAQXTy/H7kkagcV9di6W+oO8QAN+zhm6dl9SQeacjfKmFN8HESzBc7dIh5LVP7/FE+MnhEiem1UdGbYNK/4oatGSTc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXgJTo8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591AFC2BBFC;
	Tue,  7 May 2024 10:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715079310;
	bh=YOJAMtCe8DK1ux8SakApe84VXlSr5Oi60Hn13JG7aeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hXgJTo8FdTyeyQiASmgfgUOm4EvxnCORiGM3pHBT6jFPxPh4c+niH0HnaiEWp/GX0
	 COlf5kA99GDqMrGwcLIAaKkvH1uV83qJXgnGCgbt71t4+0yuW8s6tVVONfHoyFsegP
	 7b2Zgx2YdZ44jAR3CEdeXmv4NYClE7EwBRENHZ38gGNWfx9HZvxqz9FsIxEXS1blmr
	 lq8/c59Zr7V7wTNhBVux/kUpX0oWOP9rR3NeikvGVyWkaULiYzyC4nj8r0CgW5b+Mq
	 hbh2XuVnqwxR5UwwD8jlAdq2ExY8fZT//hBNjUYt4zGNAAScXcVemskf4Ic+WMdVv2
	 By8lQWXPsEWEA==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org,
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
Subject: [PATCHv5 8/8] man2: Add uretprobe syscall page
Date: Tue,  7 May 2024 12:53:21 +0200
Message-ID: <20240507105321.71524-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240507105321.71524-1-jolsa@kernel.org>
References: <20240507105321.71524-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding man page for new uretprobe syscall.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 man2/uretprobe.2 | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 man2/uretprobe.2

diff --git a/man2/uretprobe.2 b/man2/uretprobe.2
new file mode 100644
index 000000000000..690fe3b1a44f
--- /dev/null
+++ b/man2/uretprobe.2
@@ -0,0 +1,50 @@
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
+syscall is an alternative to breakpoint instructions for
+triggering return uprobe consumers.
+.P
+Calls to
+.BR uretprobe ()
+suscall are only made from the user-space trampoline provided by the kernel.
+Calls from any other place result in a
+.BR SIGILL .
+
+.SH RETURN VALUE
+The
+.BR uretprobe ()
+syscall return value is architecture-specific.
+
+.SH VERSIONS
+This syscall is not specified in POSIX,
+and details of its behavior vary across systems.
+.SH STANDARDS
+None.
+.SH HISTORY
+TBD
+.SH NOTES
+The
+.BR uretprobe ()
+syscall was initially introduced for the x86_64 architecture where it was shown
+to be faster than breakpoint traps. It might be extended to other architectures.
+.P
+The
+.BR uretprobe ()
+syscall exists only to allow the invocation of return uprobe consumers.
+It should
+.B never
+be called directly.
+Details of the arguments (if any) passed to
+.BR uretprobe ()
+and the return value are architecture-specific.
-- 
2.44.0


