Return-Path: <bpf+bounces-16029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5487FB5C8
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 10:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637511F20FBC
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 09:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7671348CC0;
	Tue, 28 Nov 2023 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwX0iZwc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2F02E3F2
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 09:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143D5C433C8;
	Tue, 28 Nov 2023 09:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701163749;
	bh=0h63TygKs4z4JwfPEY6dMw+mngPjEukaMF/IjusSGvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GwX0iZwc2dxXmoSTDowLhneB2wz+r0VKeMh+wE6uVIxfa3ORTflfc2RudVCHrVhJv
	 U2VfgBkh838Geem95PqO77vMtQ+/wtejo6TPkXa3sn7X5dVtXgTz+GQFsjd5Bh5LrX
	 8WqQhujno/ATgjOwrxPKEkeuB1bv4R4rW2lNMdGz3yi4jnwQk+GLMzCrpXtyngimd1
	 xiyT3lslvQkk9s6UIDtuFUqS0WYav8VWeZaZWRzWTvhQZrkZwMQ3p89qV6PxKJB8+n
	 rbx3nzzz9ZSyNwwRPp/wQt8ltBO5ZprhTjoLqb16lcgT4iCS4cU549x/tBnZFWIx9d
	 Bd9s26wS4JT+Q==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Xu Kuohai <xukuohai@huawei.com>,
	Will Deacon <will@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Lee Jones <lee@kernel.org>
Subject: [PATCHv2 bpf 1/2] bpf: Add checkip argument to bpf_arch_text_poke
Date: Tue, 28 Nov 2023 10:28:49 +0100
Message-ID: <20231128092850.1545199-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128092850.1545199-1-jolsa@kernel.org>
References: <20231128092850.1545199-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to be able to skip ip address check for caller in following
changes. Adding checkip argument to allow that.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c   |  3 ++-
 arch/riscv/net/bpf_jit_comp64.c |  5 +++--
 arch/s390/net/bpf_jit_comp.c    |  3 ++-
 arch/x86/net/bpf_jit_comp.c     | 24 +++++++++++++-----------
 include/linux/bpf.h             |  2 +-
 kernel/bpf/arraymap.c           |  8 ++++----
 kernel/bpf/core.c               |  2 +-
 kernel/bpf/trampoline.c         | 12 ++++++------
 8 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 7d4af64e3982..b52549d18730 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2167,7 +2167,8 @@ static int gen_branch_or_nop(enum aarch64_insn_branch_type type, void *ip,
  * locations during the patching process, making the patching process easier.
  */
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
-		       void *old_addr, void *new_addr)
+		       void *old_addr, void *new_addr,
+		       bool checkip __maybe_unused)
 {
 	int ret;
 	u32 old_insn;
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 8581693e62d3..cd1c9fa39a03 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -667,13 +667,14 @@ static int gen_jump_or_nops(void *target, void *ip, u32 *insns, bool is_call)
 }
 
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
-		       void *old_addr, void *new_addr)
+		       void *old_addr, void *new_addr, bool checkip)
 {
 	u32 old_insns[RV_FENTRY_NINSNS], new_insns[RV_FENTRY_NINSNS];
 	bool is_call = poke_type == BPF_MOD_CALL;
 	int ret;
 
-	if (!is_kernel_text((unsigned long)ip) &&
+	if (checkip &&
+	    !is_kernel_text((unsigned long)ip) &&
 	    !is_bpf_text_address((unsigned long)ip))
 		return -ENOTSUPP;
 
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index bf06b7283f0c..7333a78a30e5 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2146,7 +2146,8 @@ bool bpf_jit_supports_far_kfunc_call(void)
 }
 
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
-		       void *old_addr, void *new_addr)
+		       void *old_addr, void *new_addr,
+		       bool checkip __maybe_unused)
 {
 	struct {
 		u16 opc;
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8c10d9abc239..163bb392c02e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -435,19 +435,21 @@ static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 }
 
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
-		       void *old_addr, void *new_addr)
+		       void *old_addr, void *new_addr, bool checkip)
 {
-	if (!is_kernel_text((long)ip) &&
-	    !is_bpf_text_address((long)ip))
-		/* BPF poking in modules is not supported */
-		return -EINVAL;
+	if (checkip) {
+		if (!is_kernel_text((long)ip) &&
+		    !is_bpf_text_address((long)ip))
+			/* BPF poking in modules is not supported */
+			return -EINVAL;
 
-	/*
-	 * See emit_prologue(), for IBT builds the trampoline hook is preceded
-	 * with an ENDBR instruction.
-	 */
-	if (is_endbr(*(u32 *)ip))
-		ip += ENDBR_INSN_SIZE;
+		/*
+		 * See emit_prologue(), for IBT builds the trampoline hook is preceded
+		 * with an ENDBR instruction.
+		 */
+		if (is_endbr(*(u32 *)ip))
+			ip += ENDBR_INSN_SIZE;
+	}
 
 	return __bpf_arch_text_poke(ip, t, old_addr, new_addr);
 }
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6762dac3ef76..182544e12ef4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3173,7 +3173,7 @@ enum bpf_text_poke_type {
 };
 
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
-		       void *addr1, void *addr2);
+		       void *addr1, void *addr2, bool checkip);
 
 void *bpf_arch_text_copy(void *dst, void *src, size_t len);
 int bpf_arch_text_invalidate(void *dst, size_t len);
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 2058e89b5ddd..7ba389f7212f 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -1075,20 +1075,20 @@ static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
 			if (new) {
 				ret = bpf_arch_text_poke(poke->tailcall_target,
 							 BPF_MOD_JUMP,
-							 old_addr, new_addr);
+							 old_addr, new_addr, true);
 				BUG_ON(ret < 0 && ret != -EINVAL);
 				if (!old) {
 					ret = bpf_arch_text_poke(poke->tailcall_bypass,
 								 BPF_MOD_JUMP,
 								 poke->bypass_addr,
-								 NULL);
+								 NULL, true);
 					BUG_ON(ret < 0 && ret != -EINVAL);
 				}
 			} else {
 				ret = bpf_arch_text_poke(poke->tailcall_bypass,
 							 BPF_MOD_JUMP,
 							 old_bypass_addr,
-							 poke->bypass_addr);
+							 poke->bypass_addr, true);
 				BUG_ON(ret < 0 && ret != -EINVAL);
 				/* let other CPUs finish the execution of program
 				 * so that it will not possible to expose them
@@ -1098,7 +1098,7 @@ static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
 					synchronize_rcu();
 				ret = bpf_arch_text_poke(poke->tailcall_target,
 							 BPF_MOD_JUMP,
-							 old_addr, NULL);
+							 old_addr, NULL, true);
 				BUG_ON(ret < 0 && ret != -EINVAL);
 			}
 		}
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index cd3afe57ece3..c7fdc68116f3 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2903,7 +2903,7 @@ int __weak skb_copy_bits(const struct sk_buff *skb, int offset, void *to,
 }
 
 int __weak bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
-			      void *addr1, void *addr2)
+			      void *addr1, void *addr2, bool checkip)
 {
 	return -ENOTSUPP;
 }
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index e97aeda3a86b..826f08f26e10 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -179,7 +179,7 @@ static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
 	if (tr->func.ftrace_managed)
 		ret = unregister_ftrace_direct(tr->fops, (long)old_addr, false);
 	else
-		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, NULL);
+		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, NULL, true);
 
 	return ret;
 }
@@ -196,7 +196,7 @@ static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_ad
 		else
 			ret = modify_ftrace_direct_nolock(tr->fops, (long)new_addr);
 	} else {
-		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, new_addr);
+		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, new_addr, true);
 	}
 	return ret;
 }
@@ -219,7 +219,7 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 		ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 1);
 		ret = register_ftrace_direct(tr->fops, (long)new_addr);
 	} else {
-		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, NULL, new_addr);
+		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, NULL, new_addr, true);
 	}
 
 	return ret;
@@ -331,7 +331,7 @@ static void bpf_tramp_image_put(struct bpf_tramp_image *im)
 	 */
 	if (im->ip_after_call) {
 		int err = bpf_arch_text_poke(im->ip_after_call, BPF_MOD_JUMP,
-					     NULL, im->ip_epilogue);
+					     NULL, im->ip_epilogue, true);
 		WARN_ON(err);
 		if (IS_ENABLED(CONFIG_PREEMPTION))
 			call_rcu_tasks(&im->rcu, __bpf_tramp_image_put_rcu_tasks);
@@ -533,7 +533,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tr
 			return -EBUSY;
 		tr->extension_prog = link->link.prog;
 		return bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP, NULL,
-					  link->link.prog->bpf_func);
+					  link->link.prog->bpf_func, true);
 	}
 	if (cnt >= BPF_MAX_TRAMP_LINKS)
 		return -E2BIG;
@@ -576,7 +576,7 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_
 	if (kind == BPF_TRAMP_REPLACE) {
 		WARN_ON_ONCE(!tr->extension_prog);
 		err = bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP,
-					 tr->extension_prog->bpf_func, NULL);
+					 tr->extension_prog->bpf_func, NULL, true);
 		tr->extension_prog = NULL;
 		return err;
 	}
-- 
2.43.0


