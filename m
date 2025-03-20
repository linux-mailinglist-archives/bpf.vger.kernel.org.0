Return-Path: <bpf+bounces-54463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F3AA6A55D
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 12:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF22460E7D
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 11:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443272288D5;
	Thu, 20 Mar 2025 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QskBzkPm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5CB221542;
	Thu, 20 Mar 2025 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471172; cv=none; b=Ss/TFIN65y6WG/iikPEIPSy78TmDSojAbeMXP/boYaU6kytUZQqw1R98Ck0AfLrfh4CilUKuFqoBbzNAowO+daChCeUulpG8HGokFicyOGDyxVG/7nSJ/vKbHS0KiMY7lQPBsF6cAFKSv5NhFJC/5W1aL9HFMnUwjnKidFm1OVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471172; c=relaxed/simple;
	bh=TNawAD/Q15Z8vgi9Q29fAyG16I2zonXpOf6oa09NE50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtLMkNxOkp7GSaU1J7l10jMgDsSnY3ojNx8e6LNZlI8dLQ7reCGrZ/i20IMssa9OR8Dh/y4ITvP/+ux7Akj2jtFt4ybf5RmGol+SEAerIU13QVzst6Zlh83iEffe/dKHKtJSgn2M83BkIGHevax1pT4pb+V/N3fw913mb148dso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QskBzkPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9826C4CEEE;
	Thu, 20 Mar 2025 11:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742471172;
	bh=TNawAD/Q15Z8vgi9Q29fAyG16I2zonXpOf6oa09NE50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QskBzkPmfwHmv9fc6CEZz2to7E17sRzfuW57lam99yG2EEhRvrw3gz8i2dEY4PQhc
	 XiBhBYkQXf3/LeJ0WydDbyoeAnoxQKL0c4ICEh9vXkbfPpvlIw1/R8mPpH6HaL3e1T
	 CgK73W4lBnH6+GuxPLrqLqXerBhl39uU6pn4X5B5jIi05P6YalGluEy50eX6xAYfXh
	 acT2crQM2RouHwi63fEgOlVi88aQfw+Fs1u5U9iLKtN0yOXWMxiSDePpE1/ghuG/m3
	 5qIxROvVTkFVtAXE8Do7g6aQjPv3bTS8IyCu6SXvT9/iclzcT1FhlgMo/3AujoKQzz
	 oW/ecWg1qe9jw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Eyal Birger <eyal.birger@gmail.com>,
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
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH RFCv3 22/23] seccomp: passthrough uprobe systemcall without filtering
Date: Thu, 20 Mar 2025 12:41:57 +0100
Message-ID: <20250320114200.14377-23-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320114200.14377-1-jolsa@kernel.org>
References: <20250320114200.14377-1-jolsa@kernel.org>
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
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/seccomp.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 7bbb408431eb..44a469b01898 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -733,6 +733,26 @@ seccomp_prepare_user_filter(const char __user *user_filter)
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
@@ -750,13 +770,8 @@ static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
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
@@ -1034,6 +1049,9 @@ static const int mode1_syscalls[] = {
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


