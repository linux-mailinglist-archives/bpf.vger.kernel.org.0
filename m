Return-Path: <bpf+bounces-5870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C097623B5
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 22:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FCA81C20FD5
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 20:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9C226B33;
	Tue, 25 Jul 2023 20:42:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085C725937
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 20:42:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D5FC433C7;
	Tue, 25 Jul 2023 20:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690317720;
	bh=O/gvRDbAo1+qfKzhqxHNd4QCmaOLg095hAsSaLBvB7A=;
	h=From:To:Cc:Subject:Date:From;
	b=U96/uUjVNsF5ZPDGSmjhAi26ndBRdrgmoQUvoxGViq/F45bF6m/0ghSMSUlD3rsyH
	 SuIdyXiKVU3xtfMkbawyJa8Dc7JX2Z8BSukRNX0olo4fK01QMrP13nvgAQyqO6zWrY
	 il9tCMbFbgVhzSawQ6AxivfEkOJYU7/f3RgXs7gomFRGoTOjBnMTUtKjY+GM6hAxxB
	 qLfaHj1zxDlC5z7ghFeTZxLrVaxFbJpuBXH3AG2CYEu2JaK4hBQb91+UCT3sY+S+sw
	 QLF98JAaL1/BD+kNNjXGNc1XKB9nTGw/t65+Rg6+MtGp744za8emZA6qMpelK7Gd40
	 joGdvGkdGhBBA==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	stable@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	David Vernet <void@manifault.com>,
	Kees Cook <keescook@chromium.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] [v4] bpf: fix bpf_probe_read_kernel prototype mismatch
Date: Tue, 25 Jul 2023 22:41:12 +0200
Message-Id: <20230725204149.3411961-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

bpf_probe_read_kernel() has a __weak definition in core.c and another
definition with an incompatible prototype in kernel/trace/bpf_trace.c,
when CONFIG_BPF_EVENTS is enabled.

Since the two are incompatible, there cannot be a shared declaration in
a header file, but the lack of a prototype causes a W=1 warning:

kernel/bpf/core.c:1638:12: error: no previous prototype for 'bpf_probe_read_kernel' [-Werror=missing-prototypes]

On 32-bit architectures, the local prototype

u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)

passes arguments in other registers as the one in bpf_trace.c

BPF_CALL_3(bpf_probe_read_kernel, void *, dst, u32, size,
            const void *, unsafe_ptr)

which uses 64-bit arguments in pairs of registers.

As both versions of the function are fairly simple and only really
differ in one line, just move them into a header file as an inline
function that does not add any overhead for the bpf_trace.c callers
and actually avoids a function call for the other one.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/ac25cb0f-b804-1649-3afb-1dc6138c2716@iogearbox.net/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
--
v4: rewrite again to use a shared inline helper
v3: clarify changelog text further.
v2: rewrite completely to fix the mismatch.
---
 include/linux/bpf.h      | 12 ++++++++++++
 kernel/bpf/core.c        | 10 ++--------
 kernel/trace/bpf_trace.c | 11 -----------
 3 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ceaa8c23287fc..abe75063630b8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2661,6 +2661,18 @@ static inline void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr)
 }
 #endif /* CONFIG_BPF_SYSCALL */
 
+static __always_inline int
+bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
+{
+	int ret = -EFAULT;
+
+	if (IS_ENABLED(CONFIG_BPF_EVENTS))
+		ret = copy_from_kernel_nofault(dst, unsafe_ptr, size);
+	if (unlikely(ret < 0))
+		memset(dst, 0, size);
+	return ret;
+}
+
 void __bpf_free_used_btfs(struct bpf_prog_aux *aux,
 			  struct btf_mod_pair *used_btfs, u32 len);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index dd70c58c9d3a3..9cdf53bfb8bd3 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1634,12 +1634,6 @@ bool bpf_opcode_in_insntable(u8 code)
 }
 
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
-u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
-{
-	memset(dst, 0, size);
-	return -EFAULT;
-}
-
 /**
  *	___bpf_prog_run - run eBPF program on a given context
  *	@regs: is the array of MAX_BPF_EXT_REG eBPF pseudo-registers
@@ -1930,8 +1924,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 		DST = *(SIZE *)(unsigned long) (SRC + insn->off);	\
 		CONT;							\
 	LDX_PROBE_MEM_##SIZEOP:						\
-		bpf_probe_read_kernel(&DST, sizeof(SIZE),		\
-				      (const void *)(long) (SRC + insn->off));	\
+		bpf_probe_read_kernel_common(&DST, sizeof(SIZE),	\
+			      (const void *)(long) (SRC + insn->off));	\
 		DST = *((SIZE *)&DST);					\
 		CONT;
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index c92eb8c6ff08d..83bde2475ae54 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -223,17 +223,6 @@ const struct bpf_func_proto bpf_probe_read_user_str_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
-static __always_inline int
-bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
-{
-	int ret;
-
-	ret = copy_from_kernel_nofault(dst, unsafe_ptr, size);
-	if (unlikely(ret < 0))
-		memset(dst, 0, size);
-	return ret;
-}
-
 BPF_CALL_3(bpf_probe_read_kernel, void *, dst, u32, size,
 	   const void *, unsafe_ptr)
 {
-- 
2.39.2


