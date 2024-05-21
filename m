Return-Path: <bpf+bounces-30110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B82738CACA2
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 12:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72610283F14
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 10:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11364763F9;
	Tue, 21 May 2024 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6Gtns3+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A97873173;
	Tue, 21 May 2024 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716288624; cv=none; b=HK/A6NmF+on0jUB4lArA0vorZkv7hzEaVcxBOde3o1vBWew1SPOET3LGA6o5R/06aA+EqAQH3yLOrq0VYcSwPBBS5y61jODn8QIhlUObcfNnEqTJLZDMmS3ygbb+fRba1288GHxOZAarMRWfNUZVbGiGmniNVfzYsYOKpsKm9QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716288624; c=relaxed/simple;
	bh=YOJAMtCe8DK1ux8SakApe84VXlSr5Oi60Hn13JG7aeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGg+AbSHaig26OewEKEWmiQd5MBHF/ME/k22kITgpTUP7fAN4CM4M1CYSk5lNbV65ApHyNZEW/GiTBKuje7X7y7RAh/zCVfVbKGO8TQSc/jbZUae9+bVZQoov5SIGHNsnRo4ljcBiGQ/FC5q0Ov47gPOvPu/4pjSeJuhrD/VjgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6Gtns3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E526EC2BD11;
	Tue, 21 May 2024 10:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716288624;
	bh=YOJAMtCe8DK1ux8SakApe84VXlSr5Oi60Hn13JG7aeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r6Gtns3+EMo4boeflOX9A0YnShB9U6p772Ihi403MnCCYGGoKfoZo7bSuQ7XrrnrY
	 luxesIqv7GkZyJUc5lO+DSO/ft4OqIy0c/qQg5ftHEHHmZZODQKonagHIRqfGjH/Kz
	 n2+iHDPWtYjBq456+Z+Kdb/IV11nGCKSx+yvKH/qlROFLw4/EYEs5dyp9phI/XL7Fi
	 zfi2Ruz2ur43lbunsLkzGBubg0+MNh9jtYKpVqpj+QMBOU5SKAQAAfJAOBk5GvpW3D
	 qmGEPAT+YegAT6I0bv6xMmlraGQCMpGohCS/5UpPWLeh4pwZBKqxJPVdaYNTz8nv0x
	 ygkMXgc9GcNew==
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
Subject: [PATCHv6 9/9] man2: Add uretprobe syscall page
Date: Tue, 21 May 2024 12:48:25 +0200
Message-ID: <20240521104825.1060966-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240521104825.1060966-1-jolsa@kernel.org>
References: <20240521104825.1060966-1-jolsa@kernel.org>
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


