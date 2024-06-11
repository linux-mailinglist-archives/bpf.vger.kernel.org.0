Return-Path: <bpf+bounces-31811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C189B9039D9
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 13:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A329B22E57
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 11:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FEF17B437;
	Tue, 11 Jun 2024 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyu3zz8w"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD569171644;
	Tue, 11 Jun 2024 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718104950; cv=none; b=RiPl3IqQj8huyZ2LbsxuTG92YlBlz0BfgX04Y39p2y83hvdoV00KOLn6KjgIcGz1h+a6Ble5+0sqvwMA14255HFtslyyqoYMrgJtMZcCYuLSfC3i1+StEatvTKW0stndr1gruqWLKkxXb/On7t7RuBLWAzz6nxHXQ5Vt/IEz26Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718104950; c=relaxed/simple;
	bh=miTQKniStPWOLHCjonpZHPXe/BQEitRNyP42meyvNGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMqlMRoKIHI3hxzTMMLL4ocS3jXfz91OiseGZQXV9hsGCBPYxPBswvujpp4rdsjhwB9F8toKcIcAu5cmtnBYNstuC8K6BbpnvL+3u6TyVPhvrD+YimXmv5Ps+Khe5xueYAWa8akesHuPmw5xViNDQjQsp+XBeSrEhWNpOfOvtz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyu3zz8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF67C2BD10;
	Tue, 11 Jun 2024 11:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718104950;
	bh=miTQKniStPWOLHCjonpZHPXe/BQEitRNyP42meyvNGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hyu3zz8w9AzukgR9e59gtFNxVI0sw+TuiiWPgYvOTQ9F7qN83rvOGEYn4/AAKVVyZ
	 jSKoOIHxt35hzBYZwc5pVBsj7hSmlXqFhzranc+pKKo+n5KPybmFc2ZW4ZEFj9Eg9+
	 0nEd8BHToi3x4ve5/sqS2pK04sqHQTVGK0d/Al98cYjMEewTi+Ep2xWLoduPzJL/JY
	 Nz4ZOTIMsyoGRdry03VcPLAwIKP/ARjTg4A6F6eoLWzFJB+HHkngnb4NdfT7UGjYXq
	 d09MFwf0Mu7IUI6lj8gZb1o5dKHIRZ4kVrPfjuAufDOAKc+4VgU4lkhybXlnKw8cBr
	 8Fopa8srj7GFg==
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
Subject: [PATCHv8 bpf-next 2/9] uprobe: Wire up uretprobe system call
Date: Tue, 11 Jun 2024 13:21:51 +0200
Message-ID: <20240611112158.40795-3-jolsa@kernel.org>
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
index a396f6e6ab5b..6452c2ec469a 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -384,6 +384,7 @@
 460	common	lsm_set_self_attr	sys_lsm_set_self_attr
 461	common	lsm_list_modules	sys_lsm_list_modules
 462 	common  mseal			sys_mseal
+463	64	uretprobe		sys_uretprobe
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 9104952d323d..494f5e0f61f7 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -973,6 +973,8 @@ asmlinkage long sys_lsm_list_modules(u64 *ids, u32 *size, u32 flags);
 /* x86 */
 asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
 
+asmlinkage long sys_uretprobe(void);
+
 /* pciconfig: alpha, arm, arm64, ia64, sparc */
 asmlinkage long sys_pciconfig_read(unsigned long bus, unsigned long dfn,
 				unsigned long off, unsigned long len,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index d983c48a3b6a..2378f88d5ad4 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -845,8 +845,11 @@ __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
 #define __NR_mseal 462
 __SYSCALL(__NR_mseal, sys_mseal)
 
+#define __NR_uretprobe 463
+__SYSCALL(__NR_uretprobe, sys_uretprobe)
+
 #undef __NR_syscalls
-#define __NR_syscalls 463
+#define __NR_syscalls 464
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index d7eee421d4bc..5ce9fa0dc195 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -392,3 +392,5 @@ COND_SYSCALL(setuid16);
 
 /* restartable sequence */
 COND_SYSCALL(rseq);
+
+COND_SYSCALL(uretprobe);
-- 
2.45.1


