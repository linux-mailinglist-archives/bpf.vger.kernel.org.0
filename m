Return-Path: <bpf+bounces-1131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD6B70E5F3
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 21:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6703E281350
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 19:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA4121CF7;
	Tue, 23 May 2023 19:50:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6531F934
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 19:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB75C433D2;
	Tue, 23 May 2023 19:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684871402;
	bh=fBS/TFMmP5wWRy24F52O1gwfStwYk0nNfHkwST2oexI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NG455Tl0vWLpNic92+yDmnydWpWAOAAxtUmp/dTwFggd4/CtMVMKZIqB6o9vFVF7p
	 8ZDXi/cDVJA+QrAgVNU7tQMV9jCFKsRMWPLtUSJ+xCfIELMXFWu1TRAbynXFmudQgG
	 aiILmeO+z++iOIYl7sPUdbqKgBD4n1b94lSXjEpFUVd1qahQuPj5FItjnq7Jc3NJF0
	 zWet0be6sE9jG5K99mRyWsiTFKPy/Nusdokl4atQTRDYWZ+Oy4QZnfzAjR9q/3OKRs
	 7E/1vAWF3Hx8Eo7hMopeUmge8NDk8zlNHs8cjjORHyVNWUOsZUbb670U8CMOqTpidz
	 XARRjGUWtsBRw==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	stable@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Delyan Kratunov <delyank@fb.com>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/2] [v2] bpf: fix bpf_probe_read_kernel prototype mismatch
Date: Tue, 23 May 2023 21:43:07 +0200
Message-Id: <20230523194930.2116181-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523194930.2116181-1-arnd@kernel.org>
References: <20230523194930.2116181-1-arnd@kernel.org>
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

Since the two are incompatible, there cannot be a shared declaration
in a header file, but the lack of a prototype causes a W=1 warning:

kernel/bpf/core.c:1638:12: error: no previous prototype for 'bpf_probe_read_kernel' [-Werror=missing-prototypes]

Change the core.c file to only reference the inner
bpf_probe_read_kernel_common() helper and provide a prototype for that.

Aside from the warning, this addresses a bug on 32-bit architectures
from incorrect argument passing with the mismatched prototype.

Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
--
v2: rewrite completely to fix the mismatch.
---
 include/linux/bpf.h      | 2 ++
 kernel/bpf/core.c        | 9 ++++++---
 kernel/trace/bpf_trace.c | 3 +--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 36e4b2d8cca2..6a231ec61a87 100644
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
index 0926714641eb..e7f0d5f146fa 100644
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
+int bpf_probe_read_kernel_common(void * dst, u32 size, const void *unsafe_ptr)
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
index 2bc41e6ac9fe..290fdce2ce53 100644
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


