Return-Path: <bpf+bounces-58307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA278AB8638
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 14:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357B94A1B02
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 12:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C7929AB15;
	Thu, 15 May 2025 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdqcUjUD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF430299944;
	Thu, 15 May 2025 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747311375; cv=none; b=VXZoy2aKQOSrlMYRNmDFljapwVmmDfKtqKNeLolSEEHP33CTAEcryul/hAwJRNGravpVBOshdaHRRxnQuw/AsF+1s2GoAk+nVbvioaoS1TQ0/85SLwgcbGdMM2iWj2lEvMJTdjxc0UOXzjCwMT9CyuVntZ+u3CpLEty+IUYOyLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747311375; c=relaxed/simple;
	bh=nOuJ0zPf5iOtT5uJqMvTNsUEr2bIu+00SAIDOFCtLhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjJGZ2xbTwajsInUyNj7V82fwHX/L78B+vBVd9TLg2ColbpchHRzgX6ALwpEKUpkrL48FtUFOZVI6FTtLluxWITiwSusYmTEWEmXAwHnwxvJJIJupw9iGuh+I58wveXQx5D6ZwV7KLMMj1uXbRjgvNexK/8MBtz2FW0qlR5V504=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdqcUjUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A37C4CEE7;
	Thu, 15 May 2025 12:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747311375;
	bh=nOuJ0zPf5iOtT5uJqMvTNsUEr2bIu+00SAIDOFCtLhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sdqcUjUDJpZhYdGcbA+xlMjDvkswByo8bUeAqfSf+xNOWR3sFTpqOme5Q96YfffiR
	 EIF7rnt7yaT+6jGR0XaSK4xA7iKV0YUoNlXBbHKURM+UZEYvEwS3HBUW1lUJ/NN71M
	 JNnkZbvbNI4IDLrLgxNhcYLDGE9wWhXTrHILPcfmSkvW+6Rq+c8xlUqryDEvp97cH5
	 i6MAUMEAalLhrKtHI+LD98+TJ0Rtg8hUIMQmbeWVx53ylm83Ney4aGJKLDMtRQFqwG
	 cneq3QgUaikx5j7aw1bQ/38MJ6GrY5h+y0kA3x8bu4W9Xl0oJaEWXjNFrh82hNv1lz
	 BuziSAxJ8dtNw==
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
Subject: [PATCHv2 perf/core 20/22] seccomp: passthrough uprobe systemcall without filtering
Date: Thu, 15 May 2025 14:11:17 +0200
Message-ID: <20250515121121.2332905-21-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515121121.2332905-1-jolsa@kernel.org>
References: <20250515121121.2332905-1-jolsa@kernel.org>
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
2.49.0


