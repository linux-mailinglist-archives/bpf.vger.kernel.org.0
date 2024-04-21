Return-Path: <bpf+bounces-27337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 490EC8AC101
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 21:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6902811CE
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 19:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8276B40860;
	Sun, 21 Apr 2024 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQm8lrPM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22033FB14;
	Sun, 21 Apr 2024 19:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713728547; cv=none; b=Tefcbbj9DcbfDX3CUm1ZH6wKcU4PIS+JC5jljIg9Kze0ztVjhK+TXU0eMDQ/iPHwXjGyxZjq94G6Q07d4Motf+OHneoj5lH4KjbUgsQhvpT2/2Vmp3hR1gj5Hy5cDgk6VL4u9aBY9UxSsq6dOmzKL+/JdXcSnk7xm/wkwr+en+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713728547; c=relaxed/simple;
	bh=WN9IWTdTK5TSpbOfDXO0WV3z3MUbFSE4i1zq1kirIpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUuXCq39S403SA4MYtgPF8/N4WYmEoAwuNM2q5lPVL5xWd/UuvGFyThzgZ7JU7oKJTNp12Se75yKwMp5lRuxBKsJfYhXyRzTR7dWtmku7FpNR4N77twvMVB38phY7WmZfMJG2hx4J4CgH4yg8zjHpWeXfsN9z2njhclSM9aPhgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQm8lrPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED84C113CE;
	Sun, 21 Apr 2024 19:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713728546;
	bh=WN9IWTdTK5TSpbOfDXO0WV3z3MUbFSE4i1zq1kirIpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mQm8lrPM+Jog/b41kpEzCz2NNZlfVKPNNkXBcctQwfNZIVmVd53iDJGrx5OG/a7GJ
	 jBiU6MTPWD5kqys3uRFOpx0LQ2+diSVm+EG82908oOEDwW04pgsgGFUDtJUGa/Yd4T
	 P1CFxGZAFpwpaQdtsTabHRU80cIdXFruxYqVIwMqxl3PpoSfbv0lhDQy7JE1nQWfoY
	 +eUQiibhxHZPl66/bTKESMN/VMsRLi/1Bcm/1YOO4UZRzYdAQQmaMjBOJApqmUPW/k
	 MWSDz/WZLksMWq3wyTgtrtficU5iQ9Duef4Z3JyFBDk0dFCtDxz0yvT/ZNk/5FpJH0
	 M0Fz7RHUEt8lQ==
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
Subject: [PATCHv3 bpf-next 1/7] uprobe: Wire up uretprobe system call
Date: Sun, 21 Apr 2024 21:42:00 +0200
Message-ID: <20240421194206.1010934-2-jolsa@kernel.org>
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

Wiring up uretprobe system call, which comes in following changes.
We need to do the wiring before, because the uretprobe implementation
needs the syscall number.

Note at the moment uretprobe syscall is supported only for native
64-bit process.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/entry/syscalls/syscall_64.tbl | 1 +
 include/linux/syscalls.h               | 2 ++
 include/uapi/asm-generic/unistd.h      | 5 ++++-
 kernel/sys_ni.c                        | 2 ++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 7e8d46f4147f..af0a33ab06ee 100644
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
2.44.0


