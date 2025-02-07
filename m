Return-Path: <bpf+bounces-50718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1048BA2B89B
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 03:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9664A166E15
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 02:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939FB31A89;
	Fri,  7 Feb 2025 02:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UXALrdZZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1651311AC
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 02:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738893959; cv=none; b=khVjk2j0S6ABMcwyoHNrN1rQ6aihGwJ1tE4gNUBxCLKTJ44AuKwWTEl5fWVNrsCXVsZff43hiKt0S2sBQakVyyUYz1TgtRvrZgWZCE2l3LD8KGLT6xU/vJ1+5jq3Odg5pj/VBTKnEU2xfnhHtfdzDLD2iMfUGFlFV7R/6SEVJoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738893959; c=relaxed/simple;
	bh=fPq9XWtsOtc69mPeFIsRa2N34NkEV9jtbVKr6QyBnbc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rXIqXRsvk3LDLHKUNoOUNaG0z81BEZYP1LjLLYCZJZzoR3WP31KepwgfKTcYFMAOIfDDl81h/kKOmBekCIca4gQexw846V3Agb5XlLETEzKl9oE7cOlmLpZy4ri2w8IGcJJe8z1UoEBW00LyP+HoGpHVVxqoOEXRSYuugc97KG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UXALrdZZ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21f1919a7beso32777465ad.2
        for <bpf@vger.kernel.org>; Thu, 06 Feb 2025 18:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738893956; x=1739498756; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ddcXobZXl7/L485JhUMDf0sDIc/e0wxrN1hs3/Yc8Ck=;
        b=UXALrdZZmMfaabZ+uoszA+BvPhGcY35/62nR5qqLmJaoBXuCUfV/bx46U7gQ4HVcJI
         5maHLXCCq7R/gMgKVbGstXv7nzgEdonRrEedwseucmaj7D3Q5fVIa9Uy6icJEbF3NoTt
         xk6L0XiOWo+g/A+U6Q8Jp9+FUtoEV4SctzdglSD51gg/wyjTPAtqg83+Z8Uz4PsOxjAt
         zPTWP/5n0qNenmOKDvJyhCkgR5BWukpC5gi6ObXfD5VktJ0xD5smcl3LIzFIdYOZ9WQn
         Kh0w9C51h8qvrLDfA+fBENZKiJSjg9pyIAZR51EGeR+2jDToJjZHN87mKXdok0FAbvCw
         K3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738893956; x=1739498756;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddcXobZXl7/L485JhUMDf0sDIc/e0wxrN1hs3/Yc8Ck=;
        b=vw5oJP/N0JhL/g6BBEc+f0M0iJZ4B0cz2zmnBVOye7B1OlVe6amrqYJKywH2y8nYnv
         iuPESBCtMwAMlQlZ8N4ZqAarKmbcOLEV6DfLDEuUmhxFfLROMc+07GlRQLp/4o080p+8
         3b9f73nXCQ79Zqx6XkPci2kIE41JS71lsvRY4tczV/8XSQ1fpgPF/UH3hifeXoerQKqs
         jHOSlbMhEerGZn5x+pUqSQP2I4dJrrcDxTZgkPeGR7yvI9oI3+0nUTVYCUmc1+xLMik+
         Zi3J8ppkZZ2yPjGKV6gB6KPyqR+fzU2NgmdPZNcymqDpL91JlXZsXVt+xmotaMJ2YBXq
         dzAg==
X-Gm-Message-State: AOJu0YwFNXkkNuik2BAYSGRsgIFPpzou4ECqM5TcBY2FTeL0XpkO+4m4
	yhVzcdkzgL1dl+vCUkEs3oqMsgiYu1RNcilMlGiPuS3nwtXNWokmEsakHjotl7x6xyjlB0WKC51
	Y975VckoI3ILXavy24tomvo3D1CmNCyBXOHSe+vulRJggsVDdo2dly4jgq3eWuSqLrFzbXJXD8w
	9EdAv5URTwnMJPFs9HUXxUiO3bvgmbw/iQJKpR7Tk=
X-Google-Smtp-Source: AGHT+IHaFr+HT1k7LbVBAkON0Sg6P00qfAjEH6NZPFl87AchQ8sNqQ5UN8DGIlVFWcsU20JIhNme+XM/inTD9A==
X-Received: from plbkn6.prod.google.com ([2002:a17:903:786:b0:21f:544:758])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:244c:b0:215:401b:9535 with SMTP id d9443c01a7336-21f4e756726mr24529425ad.47.1738893956357;
 Thu, 06 Feb 2025 18:05:56 -0800 (PST)
Date: Fri,  7 Feb 2025 02:05:44 +0000
In-Reply-To: <cover.1738888641.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1738888641.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <d03d8c3305e311c6cb29924119b5eecae8370bbc.1738888641.git.yepeilin@google.com>
Subject: [PATCH bpf-next v2 4/9] bpf: Introduce load-acquire and store-release instructions
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, David Vernet <void@manifault.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long <longyingchi24s@ict.ac.cn>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce BPF instructions with load-acquire and store-release
semantics, as discussed in [1].  The following new flags are defined:

  BPF_ATOMIC_LOAD         0x10
  BPF_ATOMIC_STORE        0x20
  BPF_ATOMIC_TYPE(imm)    ((imm) & 0xf0)

  BPF_RELAXED        0x0
  BPF_ACQUIRE        0x1
  BPF_RELEASE        0x2
  BPF_ACQ_REL        0x3
  BPF_SEQ_CST        0x4

  BPF_LOAD_ACQ       (BPF_ATOMIC_LOAD | BPF_ACQUIRE)
  BPF_STORE_REL      (BPF_ATOMIC_STORE | BPF_RELEASE)

A "load-acquire" is a BPF_STX | BPF_ATOMIC instruction with the 'imm'
field set to BPF_LOAD_ACQ (0x11).

Similarly, a "store-release" is a BPF_STX | BPF_ATOMIC instruction with
the 'imm' field set to BPF_STORE_REL (0x22).

Unlike existing atomic operations that only support BPF_W (32-bit) and
BPF_DW (64-bit) size modifiers, load-acquires and store-releases also
support BPF_B (8-bit) and BPF_H (16-bit).  An 8- or 16-bit load-acquire
zero-extends the value before writing it to a 32-bit register, just like
ARM64 instruction LDARH and friends.

As an example, consider the following 64-bit load-acquire BPF
instruction:

  db 10 00 00 11 00 00 00  r0 = load_acquire((u64 *)(r1 + 0x0))

  opcode (0xdb): BPF_ATOMIC | BPF_DW | BPF_STX
  imm (0x00000011): BPF_LOAD_ACQ

Similarly, a 16-bit BPF store-release:

  cb 21 00 00 22 00 00 00  store_release((u16 *)(r1 + 0x0), w2)

  opcode (0xcb): BPF_ATOMIC | BPF_H | BPF_STX
  imm (0x00000022): BPF_STORE_REL

In arch/{arm64,s390,x86}/net/bpf_jit_comp.c, have
bpf_jit_supports_insn(..., /*in_arena=*/true) return false for the new
instructions, until the corresponding JIT compiler supports them.

[1] https://lore.kernel.org/all/20240729183246.4110549-1-yepeilin@google.com/

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 arch/arm64/net/bpf_jit_comp.c  |  4 +++
 arch/s390/net/bpf_jit_comp.c   | 14 +++++---
 arch/x86/net/bpf_jit_comp.c    |  4 +++
 include/linux/bpf.h            | 11 ++++++
 include/linux/filter.h         |  2 ++
 include/uapi/linux/bpf.h       | 13 +++++++
 kernel/bpf/core.c              | 63 ++++++++++++++++++++++++++++++----
 kernel/bpf/disasm.c            | 12 +++++++
 kernel/bpf/verifier.c          | 45 ++++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h | 13 +++++++
 10 files changed, 168 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 8446848edddb..8c3b47d9e441 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2667,8 +2667,12 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 	if (!in_arena)
 		return true;
 	switch (insn->code) {
+	case BPF_STX | BPF_ATOMIC | BPF_B:
+	case BPF_STX | BPF_ATOMIC | BPF_H:
 	case BPF_STX | BPF_ATOMIC | BPF_W:
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
+		if (bpf_atomic_is_load_store(insn))
+			return false;
 		if (!cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
 			return false;
 	}
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 9d440a0b729e..0776dfde2dba 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2919,10 +2919,16 @@ bool bpf_jit_supports_arena(void)
 
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 {
-	/*
-	 * Currently the verifier uses this function only to check which
-	 * atomic stores to arena are supported, and they all are.
-	 */
+	if (!in_arena)
+		return true;
+	switch (insn->code) {
+	case BPF_STX | BPF_ATOMIC | BPF_B:
+	case BPF_STX | BPF_ATOMIC | BPF_H:
+	case BPF_STX | BPF_ATOMIC | BPF_W:
+	case BPF_STX | BPF_ATOMIC | BPF_DW:
+		if (bpf_atomic_is_load_store(insn))
+			return false;
+	}
 	return true;
 }
 
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a43fc5af973d..f0c31c940fb8 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3771,8 +3771,12 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 	if (!in_arena)
 		return true;
 	switch (insn->code) {
+	case BPF_STX | BPF_ATOMIC | BPF_B:
+	case BPF_STX | BPF_ATOMIC | BPF_H:
 	case BPF_STX | BPF_ATOMIC | BPF_W:
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
+		if (bpf_atomic_is_load_store(insn))
+			return false;
 		if (insn->imm == (BPF_AND | BPF_FETCH) ||
 		    insn->imm == (BPF_OR | BPF_FETCH) ||
 		    insn->imm == (BPF_XOR | BPF_FETCH))
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f3f50e29d639..96c936fd125f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -990,6 +990,17 @@ static inline bool bpf_pseudo_func(const struct bpf_insn *insn)
 	return bpf_is_ldimm64(insn) && insn->src_reg == BPF_PSEUDO_FUNC;
 }
 
+/* Given a BPF_ATOMIC instruction @atomic_insn, return true if it is an
+ * atomic load or store, and false if it is a read-modify-write instruction.
+ */
+static inline bool
+bpf_atomic_is_load_store(const struct bpf_insn *atomic_insn)
+{
+	const s32 type = BPF_ATOMIC_TYPE(atomic_insn->imm);
+
+	return type == BPF_ATOMIC_LOAD || type == BPF_ATOMIC_STORE;
+}
+
 struct bpf_prog_ops {
 	int (*test_run)(struct bpf_prog *prog, const union bpf_attr *kattr,
 			union bpf_attr __user *uattr);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index a3ea46281595..e36812a5b01f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -364,6 +364,8 @@ static inline bool insn_is_cast_user(const struct bpf_insn *insn)
  *   BPF_XOR | BPF_FETCH      src_reg = atomic_fetch_xor(dst_reg + off16, src_reg);
  *   BPF_XCHG                 src_reg = atomic_xchg(dst_reg + off16, src_reg)
  *   BPF_CMPXCHG              r0 = atomic_cmpxchg(dst_reg + off16, r0, src_reg)
+ *   BPF_LOAD_ACQ             dst_reg = smp_load_acquire(src_reg + off16)
+ *   BPF_STORE_REL            smp_store_release(dst_reg + off16, src_reg)
  */
 
 #define BPF_ATOMIC_OP(SIZE, OP, DST, SRC, OFF)			\
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index fff6cdb8d11a..e78306e6e2be 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -51,6 +51,19 @@
 #define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
 #define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
 
+#define BPF_ATOMIC_LOAD		0x10
+#define BPF_ATOMIC_STORE	0x20
+#define BPF_ATOMIC_TYPE(imm)	((imm) & 0xf0)
+
+#define BPF_RELAXED	0x00
+#define BPF_ACQUIRE	0x01
+#define BPF_RELEASE	0x02
+#define BPF_ACQ_REL	0x03
+#define BPF_SEQ_CST	0x04
+
+#define BPF_LOAD_ACQ	(BPF_ATOMIC_LOAD | BPF_ACQUIRE)		/* load-acquire */
+#define BPF_STORE_REL	(BPF_ATOMIC_STORE | BPF_RELEASE)	/* store-release */
+
 enum bpf_cond_pseudo_jmp {
 	BPF_MAY_GOTO = 0,
 };
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index da729cbbaeb9..3f3127479a93 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1663,14 +1663,17 @@ EXPORT_SYMBOL_GPL(__bpf_call_base);
 	INSN_3(JMP, JSET, K),			\
 	INSN_2(JMP, JA),			\
 	INSN_2(JMP32, JA),			\
+	/* Atomic operations. */		\
+	INSN_3(STX, ATOMIC, B),			\
+	INSN_3(STX, ATOMIC, H),			\
+	INSN_3(STX, ATOMIC, W),			\
+	INSN_3(STX, ATOMIC, DW),		\
 	/* Store instructions. */		\
 	/*   Register based. */			\
 	INSN_3(STX, MEM,  B),			\
 	INSN_3(STX, MEM,  H),			\
 	INSN_3(STX, MEM,  W),			\
 	INSN_3(STX, MEM,  DW),			\
-	INSN_3(STX, ATOMIC, W),			\
-	INSN_3(STX, ATOMIC, DW),		\
 	/*   Immediate based. */		\
 	INSN_3(ST, MEM, B),			\
 	INSN_3(ST, MEM, H),			\
@@ -2152,24 +2155,33 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 			if (BPF_SIZE(insn->code) == BPF_W)		\
 				atomic_##KOP((u32) SRC, (atomic_t *)(unsigned long) \
 					     (DST + insn->off));	\
-			else						\
+			else if (BPF_SIZE(insn->code) == BPF_DW)	\
 				atomic64_##KOP((u64) SRC, (atomic64_t *)(unsigned long) \
 					       (DST + insn->off));	\
+			else						\
+				goto default_label;			\
 			break;						\
 		case BOP | BPF_FETCH:					\
 			if (BPF_SIZE(insn->code) == BPF_W)		\
 				SRC = (u32) atomic_fetch_##KOP(		\
 					(u32) SRC,			\
 					(atomic_t *)(unsigned long) (DST + insn->off)); \
-			else						\
+			else if (BPF_SIZE(insn->code) == BPF_DW)	\
 				SRC = (u64) atomic64_fetch_##KOP(	\
 					(u64) SRC,			\
 					(atomic64_t *)(unsigned long) (DST + insn->off)); \
+			else						\
+				goto default_label;			\
 			break;
 
 	STX_ATOMIC_DW:
 	STX_ATOMIC_W:
+	STX_ATOMIC_H:
+	STX_ATOMIC_B:
 		switch (IMM) {
+		/* Atomic read-modify-write instructions support only W and DW
+		 * size modifiers.
+		 */
 		ATOMIC_ALU_OP(BPF_ADD, add)
 		ATOMIC_ALU_OP(BPF_AND, and)
 		ATOMIC_ALU_OP(BPF_OR, or)
@@ -2181,20 +2193,59 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 				SRC = (u32) atomic_xchg(
 					(atomic_t *)(unsigned long) (DST + insn->off),
 					(u32) SRC);
-			else
+			else if (BPF_SIZE(insn->code) == BPF_DW)
 				SRC = (u64) atomic64_xchg(
 					(atomic64_t *)(unsigned long) (DST + insn->off),
 					(u64) SRC);
+			else
+				goto default_label;
 			break;
 		case BPF_CMPXCHG:
 			if (BPF_SIZE(insn->code) == BPF_W)
 				BPF_R0 = (u32) atomic_cmpxchg(
 					(atomic_t *)(unsigned long) (DST + insn->off),
 					(u32) BPF_R0, (u32) SRC);
-			else
+			else if (BPF_SIZE(insn->code) == BPF_DW)
 				BPF_R0 = (u64) atomic64_cmpxchg(
 					(atomic64_t *)(unsigned long) (DST + insn->off),
 					(u64) BPF_R0, (u64) SRC);
+			else
+				goto default_label;
+			break;
+		/* Atomic load and store instructions support all size
+		 * modifiers.
+		 */
+		case BPF_LOAD_ACQ:
+			switch (BPF_SIZE(insn->code)) {
+#define LOAD_ACQUIRE(SIZEOP, SIZE)				\
+			case BPF_##SIZEOP:			\
+				DST = (SIZE)smp_load_acquire(	\
+					(SIZE *)(unsigned long)(SRC + insn->off));	\
+				break;
+			LOAD_ACQUIRE(B,   u8)
+			LOAD_ACQUIRE(H,  u16)
+			LOAD_ACQUIRE(W,  u32)
+			LOAD_ACQUIRE(DW, u64)
+#undef LOAD_ACQUIRE
+			default:
+				goto default_label;
+			}
+			break;
+		case BPF_STORE_REL:
+			switch (BPF_SIZE(insn->code)) {
+#define STORE_RELEASE(SIZEOP, SIZE)			\
+			case BPF_##SIZEOP:		\
+				smp_store_release(	\
+					(SIZE *)(unsigned long)(DST + insn->off), (SIZE)SRC);	\
+				break;
+			STORE_RELEASE(B,   u8)
+			STORE_RELEASE(H,  u16)
+			STORE_RELEASE(W,  u32)
+			STORE_RELEASE(DW, u64)
+#undef STORE_RELEASE
+			default:
+				goto default_label;
+			}
 			break;
 
 		default:
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 309c4aa1b026..974d172d6735 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -267,6 +267,18 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off, insn->src_reg);
+		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
+			   insn->imm == BPF_LOAD_ACQ) {
+			verbose(cbs->private_data, "(%02x) r%d = load_acquire((%s *)(r%d %+d))\n",
+				insn->code, insn->dst_reg,
+				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
+				insn->src_reg, insn->off);
+		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
+			   insn->imm == BPF_STORE_REL) {
+			verbose(cbs->private_data, "(%02x) store_release((%s *)(r%d %+d), r%d)\n",
+				insn->code,
+				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
+				insn->dst_reg, insn->off, insn->src_reg);
 		} else {
 			verbose(cbs->private_data, "BUG_%02x\n", insn->code);
 		}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 82a5a4acf576..7ebc224bf9cb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -579,6 +579,13 @@ static bool is_cmpxchg_insn(const struct bpf_insn *insn)
 	       insn->imm == BPF_CMPXCHG;
 }
 
+static bool is_atomic_load_insn(const struct bpf_insn *insn)
+{
+	return BPF_CLASS(insn->code) == BPF_STX &&
+	       BPF_MODE(insn->code) == BPF_ATOMIC &&
+	       BPF_ATOMIC_TYPE(insn->imm) == BPF_ATOMIC_LOAD;
+}
+
 static int __get_spi(s32 off)
 {
 	return (-off - 1) / BPF_REG_SIZE;
@@ -3481,7 +3488,7 @@ static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	}
 
 	if (class == BPF_STX) {
-		/* BPF_STX (including atomic variants) has multiple source
+		/* BPF_STX (including atomic variants) has one or more source
 		 * operands, one of which is a ptr. Check whether the caller is
 		 * asking about it.
 		 */
@@ -4095,7 +4102,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			   * dreg still needs precision before this insn
 			   */
 		}
-	} else if (class == BPF_LDX) {
+	} else if (class == BPF_LDX || is_atomic_load_insn(insn)) {
 		if (!bt_is_reg_set(bt, dreg))
 			return 0;
 		bt_clear_reg(bt, dreg);
@@ -7686,6 +7693,32 @@ static int check_atomic_rmw(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int check_atomic_load(struct bpf_verifier_env *env,
+			     struct bpf_insn *insn)
+{
+	if (!atomic_ptr_type_ok(env, insn->src_reg, insn)) {
+		verbose(env, "BPF_ATOMIC loads from R%d %s is not allowed\n",
+			insn->src_reg,
+			reg_type_str(env, reg_state(env, insn->src_reg)->type));
+		return -EACCES;
+	}
+
+	return check_load_mem(env, insn, true, false, false, "atomic_load");
+}
+
+static int check_atomic_store(struct bpf_verifier_env *env,
+			      struct bpf_insn *insn)
+{
+	if (!atomic_ptr_type_ok(env, insn->dst_reg, insn)) {
+		verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
+			insn->dst_reg,
+			reg_type_str(env, reg_state(env, insn->dst_reg)->type));
+		return -EACCES;
+	}
+
+	return check_store_reg(env, insn, true);
+}
+
 static int check_atomic(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
 	switch (insn->imm) {
@@ -7700,6 +7733,10 @@ static int check_atomic(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	case BPF_XCHG:
 	case BPF_CMPXCHG:
 		return check_atomic_rmw(env, insn);
+	case BPF_LOAD_ACQ:
+		return check_atomic_load(env, insn);
+	case BPF_STORE_REL:
+		return check_atomic_store(env, insn);
 	default:
 		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n",
 			insn->imm);
@@ -20445,7 +20482,9 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			   insn->code == (BPF_ST | BPF_MEM | BPF_W) ||
 			   insn->code == (BPF_ST | BPF_MEM | BPF_DW)) {
 			type = BPF_WRITE;
-		} else if ((insn->code == (BPF_STX | BPF_ATOMIC | BPF_W) ||
+		} else if ((insn->code == (BPF_STX | BPF_ATOMIC | BPF_B) ||
+			    insn->code == (BPF_STX | BPF_ATOMIC | BPF_H) ||
+			    insn->code == (BPF_STX | BPF_ATOMIC | BPF_W) ||
 			    insn->code == (BPF_STX | BPF_ATOMIC | BPF_DW)) &&
 			   env->insn_aux_data[i + delta].ptr_type == PTR_TO_ARENA) {
 			insn->code = BPF_STX | BPF_PROBE_ATOMIC | BPF_SIZE(insn->code);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 2acf9b336371..4a20a125eb46 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -51,6 +51,19 @@
 #define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
 #define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
 
+#define BPF_ATOMIC_LOAD		0x10
+#define BPF_ATOMIC_STORE	0x20
+#define BPF_ATOMIC_TYPE(imm)	((imm) & 0xf0)
+
+#define BPF_RELAXED	0x00
+#define BPF_ACQUIRE	0x01
+#define BPF_RELEASE	0x02
+#define BPF_ACQ_REL	0x03
+#define BPF_SEQ_CST	0x04
+
+#define BPF_LOAD_ACQ	(BPF_ATOMIC_LOAD | BPF_ACQUIRE)		/* load-acquire */
+#define BPF_STORE_REL	(BPF_ATOMIC_STORE | BPF_RELEASE)	/* store-release */
+
 enum bpf_cond_pseudo_jmp {
 	BPF_MAY_GOTO = 0,
 };
-- 
2.48.1.502.g6dc24dfdaf-goog


