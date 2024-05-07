Return-Path: <bpf+bounces-28783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BABCF8BE038
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 12:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7991F22E4A
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 10:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A9115253E;
	Tue,  7 May 2024 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IE8j+ILp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B1015250E;
	Tue,  7 May 2024 10:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715079222; cv=none; b=qZDcd8D+WxQWZSLqjKd9pc5z03A0UILs89wA7+DgroRQNz/5CVf5ZVW/1pMtmMsv3aNFwh+YueZvtwcl/4frixJwg5zcUW11JyyPkDaywkGEHmIR5Bg2lAfTe6enWOJMjB/ichBeVwddtjOt2KQIncKY6BHzZw2/bLci4uN+q3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715079222; c=relaxed/simple;
	bh=E5mBBj7H+FbDyWHA7CcEj363KWYlCnqsF3O54TPh5Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvI/YnhOgP0fJMiPDtRkMNvMQ4180h/X4cEcicrrZdqsp3t4QrbBv6nm4g9K54jjdrjtu/4+CArFbRsjAUyHQxDfBmYeBRxs3/dPr5MP9kS/Kwzk6WvwdHsUsqSWP15wLG6L06gQMBExXX7npYz/LXU5zH18kaJRevdnEm6/a2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IE8j+ILp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25E9C3277B;
	Tue,  7 May 2024 10:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715079221;
	bh=E5mBBj7H+FbDyWHA7CcEj363KWYlCnqsF3O54TPh5Qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IE8j+ILpZhneZ+eS16hdwp4q4UWGdV3m3stCDpmOJ1ffS19nCy73C6e+KWeRarjfC
	 vr53EKHeuAwV80AQQtRbNxL5V3634fmuPMGWKMgfE1NbrHp3vrAkaw5Iyc5i1kqtKl
	 epXgCvuCCK45WUmicfJXlhnp1hSRrCG8qaatX4t2MqARo+P1LvHGoi3xJrw/OtOCBo
	 sIrXU6m0cINym7sBgQGK+wlZswzINuFklchvt27ygZpTCphv7Udr110rMUPUvSlOF1
	 v8GwfllwG6Ef0CqdV5+mDyQZgXC0+zombzsZq4UQbS76EZn2XO/inUNFxC3VkhO+XS
	 m54RypKyozoRg==
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
Subject: [PATCHv5 bpf-next 1/8] uprobe: Wire up uretprobe system call
Date: Tue,  7 May 2024 12:53:14 +0200
Message-ID: <20240507105321.71524-2-jolsa@kernel.org>
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


