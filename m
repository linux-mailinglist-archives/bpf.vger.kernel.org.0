Return-Path: <bpf+bounces-53008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E28BFA4B7A3
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 06:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B260116D385
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 05:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351F21E285A;
	Mon,  3 Mar 2025 05:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Frq2Ikae"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FE71E1C1A
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 05:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740980263; cv=none; b=Yb/vsDvd6k3nnSZ6Ur/znoxZcyqPgZflSsPrEV2KLKL46pPYfwmLRUro76dA+0iVKwGvWv5YmH2Y/PKFiQ1DmpG5SMjRwsu6+43Z2yQnP+Bbha4+Fc56vm5HgU3uSHWfeF2GL00I2jVAK2mo45pfFw7lxKmQumrtQrdQq2xzMW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740980263; c=relaxed/simple;
	bh=5wr7vxk8liM0wH1qhV3nDjFzBUNy2v/TiNM4weiWYcQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A8DhHyY3Mvnx01kP3pknYmJ1OKwVzQAU/Pj8oHNRhu0wGGglhloFMife20o0zmt8hZjLXRfKp78V3wsoTt7gkEwIAjcgqQ1qz00uv/GWzbN5/C7x/9n2dk9jzoBI1+qQEfdB7o8MqvPLrLO2YCTFCQ78GZFW8MIr3G9+F62+Png=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Frq2Ikae; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-223863d0d94so22530495ad.3
        for <bpf@vger.kernel.org>; Sun, 02 Mar 2025 21:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740980261; x=1741585061; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SQHObxRFv3b1dtkhqcCo12kh/bUbqfHPaXfLX2WxZNw=;
        b=Frq2IkaeMhGYvAvu4n4yNb4dwxKIwzy4GPyg+MEMc+uL8B247gr5130snPQ+S6gxMo
         a39Sm/EOW6Fxlxvnn0MmEQbH+cd454OpH/j0NroXtLxOMwN4vNeebGRgUxqPGWod7hK3
         VMjUvf84z/Bgl9o9SNFJw930EVysZeT5TdeVuN0sjBmYM3RFADCkpimuTdHz/fS4OkqD
         lpA63SXF/cUaQbRnGJOcf0+Aurp6JY74grDGd0o8q6ILn93mJFbX33mlU8jN7rbra4lW
         xvZ1FRdWWocLZEa7d6Bca+isu53U6xGGw5WWqezH+L+Js2B/FKcghGYG72QpmtmbDU1P
         Itsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740980261; x=1741585061;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQHObxRFv3b1dtkhqcCo12kh/bUbqfHPaXfLX2WxZNw=;
        b=m/TBmyBsK5lsOTYgJsd38D4dAfdYDT9LwUh7ZgnKKKum2ARcXcBfeMLXm1OsesNhDf
         dpaxa18Jw4Y9Td2YPVsZbPDj9PEF5V5K4dW/tbTcq1snPQ5IzQMouoUb7N2ZEoXbRFGZ
         IYTznhED0Mo4KhAdYIxr3WAfBB4ODMtr7+hr4rMHQGC0MRZw7xUOIWEloAiWmW2ml7w9
         9+KzIq8N1/da/ieHg1SAo21SYctRuJlOjSaVmfJF01oVgXC5UHln6/PR6PemihZsr1kY
         aZtZHWlD6Smf8y7h8vLiHZtEQ0gTDzf4ScHc1Rp8Q28TswDeUSokXWjDVVk5YhCRwyBW
         aEjA==
X-Gm-Message-State: AOJu0YxxLZ1szmUCKkTOwzFRlf2VCLdBcqJ6xky0KEV/LGe4pspLP4D3
	IqO88ZeAIRSYMscjTQlLef6FFSsaKB9DmX+PSCBYiY/KRQiIQp5Jg2Nax5wNKWUdby7YbX62yFG
	xAbfhPOJ/OYINiNncqQqe8JP3KrOwkOlvHgwXkyOuEvDs12QsQx+aDn3BPZFIcoMtDCOCwzLP8m
	oIDk3K/F36hn0kks3nMzEt62WBDrwkfo4UUdyDNYA=
X-Google-Smtp-Source: AGHT+IGVBM97b1TKWcrlp1EX6pOOu/P0bD82xs6zMcoigcFS91E2Bq0KHib9VoJogvCerWoWgXJW1aWjzHCRJw==
X-Received: from pfht3.prod.google.com ([2002:a62:ea03:0:b0:730:8e17:ed06])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e54a:b0:220:bdf2:e51e with SMTP id d9443c01a7336-22368fa90cbmr198079885ad.26.1740980261030;
 Sun, 02 Mar 2025 21:37:41 -0800 (PST)
Date: Mon,  3 Mar 2025 05:37:37 +0000
In-Reply-To: <cover.1740978603.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740978603.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <2c82b29f3530b961b41f94a4942e490ab35a31c8.1740978603.git.yepeilin@google.com>
Subject: [PATCH bpf-next v4 04/10] bpf: Introduce load-acquire and
 store-release instructions
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Alexei Starovoitov <ast@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	David Vernet <void@manifault.com>, Daniel Borkmann <daniel@iogearbox.net>, 
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
semantics, as discussed in [1].  Define 2 new flags:

  #define BPF_LOAD_ACQ    0x100
  #define BPF_STORE_REL   0x110

A "load-acquire" is a BPF_STX | BPF_ATOMIC instruction with the 'imm'
field set to BPF_LOAD_ACQ (0x100).

Similarly, a "store-release" is a BPF_STX | BPF_ATOMIC instruction with
the 'imm' field set to BPF_STORE_REL (0x110).

Unlike existing atomic read-modify-write operations that only support
BPF_W (32-bit) and BPF_DW (64-bit) size modifiers, load-acquires and
store-releases also support BPF_B (8-bit) and BPF_H (16-bit).  An 8- or
16-bit load-acquire zero-extends the value before writing it to a 32-bit
register, just like ARM64 instruction LDARH and friends.

Similar to existing atomic read-modify-write operations, misaligned
load-acquires/store-releases are not allowed (even if
BPF_F_ANY_ALIGNMENT is set).

As an example, consider the following 64-bit load-acquire BPF
instruction (assuming little-endian):

  db 10 00 00 00 01 00 00  r0 = load_acquire((u64 *)(r1 + 0x0))

  opcode (0xdb): BPF_ATOMIC | BPF_DW | BPF_STX
  imm (0x00000100): BPF_LOAD_ACQ

Similarly, a 16-bit BPF store-release:

  cb 21 00 00 10 01 00 00  store_release((u16 *)(r1 + 0x0), w2)

  opcode (0xcb): BPF_ATOMIC | BPF_H | BPF_STX
  imm (0x00000110): BPF_STORE_REL

In arch/{arm64,s390,x86}/net/bpf_jit_comp.c, have
bpf_jit_supports_insn(..., /*in_arena=*/true) return false for the new
instructions, until the corresponding JIT compiler supports them in
arena.

[1] https://lore.kernel.org/all/20240729183246.4110549-1-yepeilin@google.com/

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 arch/arm64/net/bpf_jit_comp.c  |  4 +++
 arch/s390/net/bpf_jit_comp.c   | 14 +++++---
 arch/x86/net/bpf_jit_comp.c    |  4 +++
 include/linux/bpf.h            | 15 ++++++++
 include/linux/filter.h         |  2 ++
 include/uapi/linux/bpf.h       |  3 ++
 kernel/bpf/core.c              | 63 ++++++++++++++++++++++++++++++----
 kernel/bpf/disasm.c            | 12 +++++++
 kernel/bpf/verifier.c          | 45 ++++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h |  3 ++
 10 files changed, 152 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 7409c8acbde3..bdda5a77bb16 100644
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
index 4c4028d865ee..b556a26d8150 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -991,6 +991,21 @@ static inline bool bpf_pseudo_func(const struct bpf_insn *insn)
 	return bpf_is_ldimm64(insn) && insn->src_reg == BPF_PSEUDO_FUNC;
 }
 
+/* Given a BPF_ATOMIC instruction @atomic_insn, return true if it is an
+ * atomic load or store, and false if it is a read-modify-write instruction.
+ */
+static inline bool
+bpf_atomic_is_load_store(const struct bpf_insn *atomic_insn)
+{
+	switch (atomic_insn->imm) {
+	case BPF_LOAD_ACQ:
+	case BPF_STORE_REL:
+		return true;
+	default:
+		return false;
+	}
+}
+
 struct bpf_prog_ops {
 	int (*test_run)(struct bpf_prog *prog, const union bpf_attr *kattr,
 			union bpf_attr __user *uattr);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 3ed6eb9e7c73..24e94afb5622 100644
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
index beac5cdf2d2c..bb37897c0393 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -51,6 +51,9 @@
 #define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
 #define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
 
+#define BPF_LOAD_ACQ	0x100	/* load-acquire */
+#define BPF_STORE_REL	0x110	/* store-release */
+
 enum bpf_cond_pseudo_jmp {
 	BPF_MAY_GOTO = 0,
 };
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a0200fbbace9..323af18d7d49 100644
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
index 22c4edc8695c..dac7af73ac8a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -579,6 +579,13 @@ static bool is_cmpxchg_insn(const struct bpf_insn *insn)
 	       insn->imm == BPF_CMPXCHG;
 }
 
+static bool is_atomic_load_insn(const struct bpf_insn *insn)
+{
+	return BPF_CLASS(insn->code) == BPF_STX &&
+	       BPF_MODE(insn->code) == BPF_ATOMIC &&
+	       insn->imm == BPF_LOAD_ACQ;
+}
+
 static int __get_spi(s32 off)
 {
 	return (-off - 1) / BPF_REG_SIZE;
@@ -3567,7 +3574,7 @@ static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	}
 
 	if (class == BPF_STX) {
-		/* BPF_STX (including atomic variants) has multiple source
+		/* BPF_STX (including atomic variants) has one or more source
 		 * operands, one of which is a ptr. Check whether the caller is
 		 * asking about it.
 		 */
@@ -4181,7 +4188,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			   * dreg still needs precision before this insn
 			   */
 		}
-	} else if (class == BPF_LDX) {
+	} else if (class == BPF_LDX || is_atomic_load_insn(insn)) {
 		if (!bt_is_reg_set(bt, dreg))
 			return 0;
 		bt_clear_reg(bt, dreg);
@@ -7766,6 +7773,32 @@ static int check_atomic_rmw(struct bpf_verifier_env *env,
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
@@ -7780,6 +7813,10 @@ static int check_atomic(struct bpf_verifier_env *env, struct bpf_insn *insn)
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
@@ -20605,7 +20642,9 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
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
index beac5cdf2d2c..bb37897c0393 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -51,6 +51,9 @@
 #define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
 #define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
 
+#define BPF_LOAD_ACQ	0x100	/* load-acquire */
+#define BPF_STORE_REL	0x110	/* store-release */
+
 enum bpf_cond_pseudo_jmp {
 	BPF_MAY_GOTO = 0,
 };
-- 
2.48.1.711.g2feabab25a-goog


