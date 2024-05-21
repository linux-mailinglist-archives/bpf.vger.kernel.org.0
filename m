Return-Path: <bpf+bounces-30103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 248B08CAC81
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 12:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60491F22C9A
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 10:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51C57353F;
	Tue, 21 May 2024 10:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpYM/Nqi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AE56D1BC;
	Tue, 21 May 2024 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716288538; cv=none; b=qLPPxka34DfHPmYYYGiSd/sx8rPRiMQitEEndRM22fSjIqT7pqBfZabAgXx66By7XonfDTCfr+ijPNkJWfLU31u1XBZVS9CllvIHjA4om+u3NMAX52iCnID0Ccu5OyImBt4wCVe5NjGkcZmZQWeJgu2Vvokes28tpCLS9mYn8o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716288538; c=relaxed/simple;
	bh=Rwhd1hPDiyj5tuZNx5+dYKU/Rm8mY6QrTxHfDT/vTy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggtMBEdvMTET6Oskv7618ngFsh9VLwOn91I6YFEOIYEurk4cfwmL+t/h+J9/FejtbSqM6hE9EYRkkprtCXwKo5F5gM0VC19Xd7Q+QcmrvAyVNN4qIa3J3DhuMcoAk99qkrl7qa5MEesLy136cNreNBH9WmLX1X9dD0r5vs8Ioos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpYM/Nqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952D2C2BD11;
	Tue, 21 May 2024 10:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716288537;
	bh=Rwhd1hPDiyj5tuZNx5+dYKU/Rm8mY6QrTxHfDT/vTy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LpYM/NqiAFq/Ct+bnB0THT8cngkofO3MegOsNCqz5hAJLM3mK6wxV1c9gg+lZ6gQF
	 pUIdn/rKrr2+5UsuTt8WFUkpodFo1t1bQU6OScojqMCVHL9vlmaJvp6bWrD9HfrMEE
	 Z2yfnucBB/UU/uxyug0vZm7FvtAqvLJ9ShG8WbNos+401TmpCpyw9mjDDTV9Ei4MYb
	 SyW/+r48nRWfV23Qy28WohLayFOaPW1fUuoIAzLbbwfk7cUOch6jxPZv+1wTWKTkcF
	 djVmfk8BBpRQ9RtTOAJ5PEa9Szlb2d5p/kuZ+NPw9yxH7JYQ2OUH7tVv9lkK9LrVR3
	 rikASh35bP0XA==
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
Subject: [PATCHv6 bpf-next 2/9] uprobe: Wire up uretprobe system call
Date: Tue, 21 May 2024 12:48:18 +0200
Message-ID: <20240521104825.1060966-3-jolsa@kernel.org>
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

Wiring up uretprobe system call, which comes in following changes.
We need to do the wiring before, because the uretprobe implementation
needs the syscall number.

Note at the moment uretprobe syscall is supported only for native
64-bit process.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/entry/syscalls/syscall_64.tbl | 1 +
 include/linux/syscalls.h               | 2 ++
 include/uapi/asm-generic/unistd.h      | 5 ++++-
 kernel/sys_ni.c                        | 2 ++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index cc78226ffc35..47dfea0a827c 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -383,6 +383,7 @@
 459	common	lsm_get_self_attr	sys_lsm_get_self_attr
 460	common	lsm_set_self_attr	sys_lsm_set_self_attr
 461	common	lsm_list_modules	sys_lsm_list_modules
+462	64	uretprobe		sys_uretprobe
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e619ac10cd23..5318e0e76799 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -972,6 +972,8 @@ asmlinkage long sys_lsm_list_modules(u64 *ids, u32 *size, u32 flags);
 /* x86 */
 asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
 
+asmlinkage long sys_uretprobe(void);
+
 /* pciconfig: alpha, arm, arm64, ia64, sparc */
 asmlinkage long sys_pciconfig_read(unsigned long bus, unsigned long dfn,
 				unsigned long off, unsigned long len,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 75f00965ab15..8a747cd1d735 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -842,8 +842,11 @@ __SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
 #define __NR_lsm_list_modules 461
 __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
 
+#define __NR_uretprobe 462
+__SYSCALL(__NR_uretprobe, sys_uretprobe)
+
 #undef __NR_syscalls
-#define __NR_syscalls 462
+#define __NR_syscalls 463
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index faad00cce269..be6195e0d078 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -391,3 +391,5 @@ COND_SYSCALL(setuid16);
 
 /* restartable sequence */
 COND_SYSCALL(rseq);
+
+COND_SYSCALL(uretprobe);
-- 
2.45.0


