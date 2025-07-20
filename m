Return-Path: <bpf+bounces-63852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93671B0B58F
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 13:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9643BDCCD
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 11:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9201FBCB0;
	Sun, 20 Jul 2025 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2dZXs22"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED1D1F874F;
	Sun, 20 Jul 2025 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753010728; cv=none; b=pp655mV7eawgvSYEUSgDIaLQjIZYhoZQAGwmL1Xq80iRATL0RZeG9/NbkHAKG9h9ZgCdIEw2vudmTK+SJaqXlkVjL9YUMI+S/M1reU61wy7DlLn3WdSdsC+oghNn20WnItOGk3q54Qc9rno0xXUKktGhsZk0AQZHCH57JRG8we8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753010728; c=relaxed/simple;
	bh=u2WElNou00r4N/xZHGUZ6efEeZsgVdxZMo7zSDdQsag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Csk/ytaB4c/Mi8kFJ+KuKmdgycEDVLZe5sb+8+efsfmQygLJstl+oE9HcajsEePDo3iaGKN+3qywvOHDcnlJGmHuPCwsVGLr4QISpywxEBWd19LYN00gnXtU+tpQLi4GxTUyOuhGZGpN9ES6/0AHOMD926FuZZLVQ7nso1o9hZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2dZXs22; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCC3C4CEE7;
	Sun, 20 Jul 2025 11:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753010728;
	bh=u2WElNou00r4N/xZHGUZ6efEeZsgVdxZMo7zSDdQsag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T2dZXs22cCuomt8poj1nlMH+NvE04+HeEaJBnxc/slJCC0hUK8HbdSBQm3Mb6+bGE
	 3cMAcTNCQzyHK0f6+GnNhUqLbRBY7Z1oN8VUHI7PuNIXl8hMnNFJ9b3mv4w1+lNYQM
	 qcpWAr2CqeA919cobG2or5pdWfSML3w3KhfxcIZYlfEAdEuOHiDlIdnJpaqtdkXINO
	 ozN0MoqlrG7MvHIAmVtNOOSlOtdOwqePvggnw/Tv0igllyDZb5q475s4bGUlfFQYTo
	 TRtszduIlTPLBdtYT5RwmOFaNFd+i3OuYkGELiBYkQ85PA5zHO8qsLKCraIyC3z5eB
	 gD8KSNG6UBFig==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	Kees Cook <kees@kernel.org>,
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
Subject: [PATCHv6 perf/core 20/22] seccomp: passthrough uprobe systemcall without filtering
Date: Sun, 20 Jul 2025 13:21:30 +0200
Message-ID: <20250720112133.244369-21-jolsa@kernel.org>
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

Adding uprobe as another exception to the seccomp filter alongside
with the uretprobe syscall.

Same as the uretprobe the uprobe syscall is installed by kernel as
replacement for the breakpoint exception and is limited to x86_64
arch and isn't expected to ever be supported in i386.

Cc: Kees Cook <keescook@chromium.org>
Cc: Eyal Birger <eyal.birger@gmail.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/seccomp.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 41aa761c7738..7daf2da09e8e 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -741,6 +741,26 @@ seccomp_prepare_user_filter(const char __user *user_filter)
 }
 
 #ifdef SECCOMP_ARCH_NATIVE
+static bool seccomp_uprobe_exception(struct seccomp_data *sd)
+{
+#if defined __NR_uretprobe || defined __NR_uprobe
+#ifdef SECCOMP_ARCH_COMPAT
+	if (sd->arch == SECCOMP_ARCH_NATIVE)
+#endif
+	{
+#ifdef __NR_uretprobe
+		if (sd->nr == __NR_uretprobe)
+			return true;
+#endif
+#ifdef __NR_uprobe
+		if (sd->nr == __NR_uprobe)
+			return true;
+#endif
+	}
+#endif
+	return false;
+}
+
 /**
  * seccomp_is_const_allow - check if filter is constant allow with given data
  * @fprog: The BPF programs
@@ -758,13 +778,8 @@ static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
 		return false;
 
 	/* Our single exception to filtering. */
-#ifdef __NR_uretprobe
-#ifdef SECCOMP_ARCH_COMPAT
-	if (sd->arch == SECCOMP_ARCH_NATIVE)
-#endif
-		if (sd->nr == __NR_uretprobe)
-			return true;
-#endif
+	if (seccomp_uprobe_exception(sd))
+		return true;
 
 	for (pc = 0; pc < fprog->len; pc++) {
 		struct sock_filter *insn = &fprog->filter[pc];
@@ -1042,6 +1057,9 @@ static const int mode1_syscalls[] = {
 	__NR_seccomp_read, __NR_seccomp_write, __NR_seccomp_exit, __NR_seccomp_sigreturn,
 #ifdef __NR_uretprobe
 	__NR_uretprobe,
+#endif
+#ifdef __NR_uprobe
+	__NR_uprobe,
 #endif
 	-1, /* negative terminated */
 };
-- 
2.50.1


