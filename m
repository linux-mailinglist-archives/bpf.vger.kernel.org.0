Return-Path: <bpf+bounces-1684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7957203C3
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 15:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD792281882
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 13:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F4E19523;
	Fri,  2 Jun 2023 13:51:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E5719509
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 13:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239A4C433D2;
	Fri,  2 Jun 2023 13:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685713916;
	bh=8hDakrUZAZcYTZfGnQ3DNtCp7igSQOT1sESi2A5X7JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iftz4zlbGT83MJweTTJpH3wQdggzYX6b+QAx9Koo1cv+16rmDoY0nvXO6m3xj06gj
	 lFhzkTunQOpyko5GnC4nfOhIHj0SkwImYV4qStyONP6+MJKD0dulfUFetxSZe67aM7
	 OPzMQ8lUQagZ5mhexu5mPM8oUZ4Hw5WftHXsVwsRSapgjTRKvcG0sUatLogGT9Gndk
	 GsEKI6E55mt4WjfPQBgknPAfxt6v2njHB9PZzPFQ1nhCz+KZYC939jBFpWEAJ2q3Ib
	 W/rzdigetrW5OnLbh9inqnOBhVFXERpFmS/veBTt+MblQ1zwbPw7WBODQVTgySSLp4
	 LV91jautrX54g==
From: Arnd Bergmann <arnd@kernel.org>
To: Yonghong Song <yhs@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
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
	Delyan Kratunov <delyank@fb.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/2] [v3] bpf: fix bpf_probe_read_kernel prototype mismatch
Date: Fri,  2 Jun 2023 15:50:19 +0200
Message-Id: <20230602135128.1498362-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230602135128.1498362-1-arnd@kernel.org>
References: <20230602135128.1498362-1-arnd@kernel.org>
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

Change the core.c file to only reference the inner
bpf_probe_read_kernel_common() helper and provide a prototype for that,
to ensure this is compatible with both definitions.

Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
--
v3: clarify changelog text further.
v2: rewrite completely to fix the mismatch.
---
 include/linux/bpf.h      | 2 ++
 kernel/bpf/core.c        | 9 ++++++---
 kernel/trace/bpf_trace.c | 3 +--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f58895830adae..55826398acfba 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2619,6 +2619,8 @@ static inline void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr)
 }
 #endif /* CONFIG_BPF_SYSCALL */
 
+int bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr);
+
 void __bpf_free_used_btfs(struct bpf_prog_aux *aux,
 			  struct btf_mod_pair *used_btfs, u32 len);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 0926714641eb5..565ef6950c7a8 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -35,6 +35,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/nodemask.h>
 #include <linux/nospec.h>
+#include <linux/bpf.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/memcontrol.h>
 
@@ -1635,11 +1636,13 @@ bool bpf_opcode_in_insntable(u8 code)
 }
 
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
-u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
+#ifndef CONFIG_BPF_EVENTS
+int bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
 {
 	memset(dst, 0, size);
 	return -EFAULT;
 }
+#endif
 
 /**
  *	___bpf_prog_run - run eBPF program on a given context
@@ -1931,8 +1934,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
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
index 2bc41e6ac9fe0..290fdce2ce535 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -223,8 +223,7 @@ const struct bpf_func_proto bpf_probe_read_user_str_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
-static __always_inline int
-bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
+int bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
 {
 	int ret;
 
-- 
2.39.2


