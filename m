Return-Path: <bpf+bounces-27343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902EA8AC113
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 21:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E9E1C208B2
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 19:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4215A43ACC;
	Sun, 21 Apr 2024 19:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpN+maUP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03523FE4B;
	Sun, 21 Apr 2024 19:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713728620; cv=none; b=u490vPHZW1I1WmbaHw8rqyp9+/N6Ofljn3x1kHJZicPA6KnvRo8vCSjVCevn8xWYRGe54jJUOFGZw34joy1TBudQYHelcVhgwB5Qv3MIyeQ65qBpqHSyUgJt4DEtQfCWNIkbNZj9rvMNxgpACDuBXNUKz4f1Je24OkiyxjSfVVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713728620; c=relaxed/simple;
	bh=iIPEN5LzK/t1QT6usY68cfJg0ttPxsTTf/Tw7WiSAXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svfAwqnSzm64RBD601b3R1oE+maLgdRqw+cnwGOlV7vQaN6XnNFJMxVN0/Fjecgr+uWlsNpcl8GH+5iDy6giAMfYM3mYg1pVNUbpGBUgHx55NFoZ1dARjcjJxnkLfMvMmsIo7qofcJ12Yif2mV4KOxUhOlBJbWtz5AH7hBanE3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpN+maUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1710C113CE;
	Sun, 21 Apr 2024 19:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713728620;
	bh=iIPEN5LzK/t1QT6usY68cfJg0ttPxsTTf/Tw7WiSAXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QpN+maUPquceVNspLlWizuG9q7VdrvDmDtuZbIYKsEnKOWuvxtDxJqolXNmn7FF0U
	 Cx2E5dlNsZ0S+S2/NCYWFZatGuz3DQyt6yVPBN/MLrohxXEe/lA/K3CuZN9mo5MZLs
	 KdAS3yxsbnvWfzhWJ5N7tf88Z7BG1wlTbJ6QHI/G2p8EeWCnXcprJGrZK4LilrYzDS
	 ybOP9AUBOLIS0R/kG7x6aOtnRqR5Mx9jDLVjTw1MPKGUUUJzxsCFY7qSyEDGmV4MtX
	 O4ExJ1o8TcmhuAi/87nfPyaDrbsotAjJuhdET/fwVGTf8XKCOjoLL+P2DlUGLUZ7qH
	 L6whLvqu6lkog==
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
	x86@kernel.org,
	bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 7/7] man2: Add uretprobe syscall page
Date: Sun, 21 Apr 2024 21:42:06 +0200
Message-ID: <20240421194206.1010934-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240421194206.1010934-1-jolsa@kernel.org>
References: <20240421194206.1010934-1-jolsa@kernel.org>
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
 man2/uretprobe.2 | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 man2/uretprobe.2

diff --git a/man2/uretprobe.2 b/man2/uretprobe.2
new file mode 100644
index 000000000000..c0343a88bb57
--- /dev/null
+++ b/man2/uretprobe.2
@@ -0,0 +1,40 @@
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
+On x86_64 architecture the kernel is using uretprobe syscall to trigger
+uprobe return probe consumers instead of using standard breakpoint instruction.
+The reason is that it's much faster to do syscall than breakpoint trap
+on x86_64 architecture.
+
+The uretprobe syscall is not supposed to be called directly by user, it's allowed
+to be invoked only through user space trampoline provided by kernel.
+When called from outside of this trampoline, the calling process will receive
+.BR SIGILL .
+
+.SH RETURN VALUE
+.BR uretprobe()
+return value is specific for given architecture.
+
+.SH VERSIONS
+This syscall is not specified in POSIX,
+and details of its behavior vary across systems.
+.SH STANDARDS
+None.
+.SH NOTES
+.BR uretprobe()
+exists only to allow the invocation of return uprobe consumers.
+It should
+.B never
+be called directly.
+Details of the arguments (if any) passed to
+.BR uretprobe ()
+and the return value are specific for given architecture.
-- 
2.44.0


