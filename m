Return-Path: <bpf+bounces-49747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BE8A1C06C
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 03:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 642527A1C5C
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 02:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCD8204685;
	Sat, 25 Jan 2025 02:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fxQpCLUE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503501FC7F8
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 02:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737771515; cv=none; b=CwiD62d+8Vsm/pPre+jYbZwtXhwDOvziJsmpA3Q8jinfSDSNNvfEhdcHMgfeH6qJOcXsMsqtpNevpddiQaR0rcc9JbDUmNh+OCp46B3nkcz7hKRFLeWtRpulNvgFFclNVnPzxJrz+YIPsV3x15bT+l0jbC6xwBWFHdEHxh6flt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737771515; c=relaxed/simple;
	bh=W+asjXCva3OY6TwW9ZwkDRuUpSqpwovOTccr00UGmtw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jVg0SNh6P0FF8p8Ui/yUjjTq4yPj+Oasy1QoNYh1e1M1P9G3Bc0EbvPGvjOb7d2qJJzkkn7j5HzadYnL0y2npQo+5xgEf9nmW3E0gHZhgGTPuoQjjw+JNp28ogLK9gZIdodv1HN0g8wsccDlJUCDmHp1kntMOouuoPpiL/JAE18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fxQpCLUE; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21661949f23so77647735ad.3
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 18:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737771512; x=1738376312; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QfXz68+jbykT93+Op9h9AP72g+l2XAcrP0ZoIG9EpCQ=;
        b=fxQpCLUEdDYY1J0RUWOdLiSTVnWDOMnkB75ra86M8ATLJRAyDsnhdAKVjRpRtILMVN
         i6RztGmpAuRPPcP2UhR3duoBoNGH9j+lImiAwWWhwkQEZBOzzSm5NRZbzk2Hqxtyi3rh
         x+T33rcDqVpqcEYM1O6iFkHjKmSMjGP8Ir0kknvInjWjW97+dmeH/RFFSPYwHgxYcWyg
         6OCWG/RTP3iblQxJakiGC3Pf7qdhVDuC8Ax0q9At308waGhA5c6OOL9a5/KKOy1Mq5rV
         DSOSyhjA6Ni/Z2bEPg0E2ZDG8eE7eOQm7CgMF0B5vQtl30lc0wy7dROku49v+VZP6W8A
         ONIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737771512; x=1738376312;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QfXz68+jbykT93+Op9h9AP72g+l2XAcrP0ZoIG9EpCQ=;
        b=CxRa/N5M4/9Hw3uxZA06iIugA0GZFIh5GXf8zUeNh0a4M/SFMk2yBFB7yFWEfpZfLJ
         X4c8m2v7psGN8kkCec52GLqImH61LqpGOF34ObbnH07MgIrtUWm49sux5HG+c7Uhh1LQ
         62xiA+johUqTA8SUFTb875zaq0ecfVIYEgr9KDfBIy2idXjtdTN7DXp4x/RK0I+E636N
         xI45uWW2CsKhU0RuCTYgpKkCxo43rOs9vncwsEtMQgx0KNhlol/OCxlmhYy2QE1vUvtP
         ESsfXffu5EnWIcBnmF/Ts/nVEtaILUmhiV9D3jiZBXae0RZvh++C2/0lUWFclFUCN7si
         fZaA==
X-Gm-Message-State: AOJu0YwuAR45d+Y6+r/eJvtqJGi2z7v0eowYU36LBq1ioEJkqgaqs1RJ
	wOhhEMbPk6sK10WYGdVUz7duYxr/zx1e2DmCdr/P/4hsBYNUsdYpLqvg/r5bMut3T8GcqoY+h5R
	8ZyUIyPpKHetutAMcO5EwTpq3DRFYzwLjiAtvTIYbyLT1r5fbOL6bGOrMfpbtpv2wB3k9nf8u+/
	SF6JstHQ0vzm6p93Ao64Zutow+ly6qFLSZLExb0Jc=
X-Google-Smtp-Source: AGHT+IGZQK7/pNts6mhkSIhk0pPUdISf5PSC4pmQWwsrIxHaXQTvoanEm5EYdjLznU9XH91CE3rnm6GOlT11cA==
X-Received: from pldt14.prod.google.com ([2002:a17:903:40ce:b0:20c:5d5a:9d64])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d4d2:b0:215:94eb:adb6 with SMTP id d9443c01a7336-21c3563c51amr523357365ad.40.1737771512513;
 Fri, 24 Jan 2025 18:18:32 -0800 (PST)
Date: Sat, 25 Jan 2025 02:18:26 +0000
In-Reply-To: <cover.1737763916.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1737763916.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <e52e4ab7bea5b29475d70e164c4b07992afd6033.1737763916.git.yepeilin@google.com>
Subject: [PATCH bpf-next v1 3/8] bpf: Introduce load-acquire and store-release instructions
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
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
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

[1] https://lore.kernel.org/all/20240729183246.4110549-1-yepeilin@google.com/

Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 include/linux/filter.h         |  2 +
 include/uapi/linux/bpf.h       | 13 +++++
 kernel/bpf/core.c              | 41 +++++++++++++-
 kernel/bpf/disasm.c            | 12 +++++
 kernel/bpf/verifier.c          | 99 ++++++++++++++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h | 13 +++++
 6 files changed, 175 insertions(+), 5 deletions(-)

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
index 2acf9b336371..4a20a125eb46 100644
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
index da729cbbaeb9..ab082ab9d535 100644
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
@@ -2169,6 +2172,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 
 	STX_ATOMIC_DW:
 	STX_ATOMIC_W:
+	STX_ATOMIC_H:
+	STX_ATOMIC_B:
 		switch (IMM) {
 		ATOMIC_ALU_OP(BPF_ADD, add)
 		ATOMIC_ALU_OP(BPF_AND, and)
@@ -2196,6 +2201,38 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 					(atomic64_t *)(unsigned long) (DST + insn->off),
 					(u64) BPF_R0, (u64) SRC);
 			break;
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
+			break;
 
 		default:
 			goto default_label;
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
index 2b3caa7549af..e44abe22aac9 100644
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
@@ -7625,6 +7632,86 @@ static int check_atomic_rmw(struct bpf_verifier_env *env, int insn_idx,
 	return 0;
 }
 
+static int check_atomic_load(struct bpf_verifier_env *env, int insn_idx,
+			     struct bpf_insn *insn)
+{
+	struct bpf_reg_state *regs = cur_regs(env);
+	int err;
+
+	err = check_reg_arg(env, insn->src_reg, SRC_OP);
+	if (err)
+		return err;
+
+	err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
+	if (err)
+		return err;
+
+	if (!atomic_ptr_type_ok(env, insn->src_reg, insn)) {
+		verbose(env, "BPF_ATOMIC loads from R%d %s is not allowed\n",
+			insn->src_reg,
+			reg_type_str(env, reg_state(env, insn->src_reg)->type));
+		return -EACCES;
+	}
+
+	if (is_arena_reg(env, insn->src_reg)) {
+		err = save_aux_ptr_type(env, PTR_TO_ARENA, false);
+		if (err)
+			return err;
+	}
+
+	/* Check whether we can read the memory. */
+	err = check_mem_access(env, insn_idx, insn->src_reg, insn->off,
+			       BPF_SIZE(insn->code), BPF_READ, insn->dst_reg,
+			       true, false);
+	if (err)
+		return err;
+
+	err = reg_bounds_sanity_check(env, &regs[insn->dst_reg], "atomic_load");
+	if (err)
+		return err;
+	return 0;
+}
+
+static int check_atomic_store(struct bpf_verifier_env *env, int insn_idx,
+			      struct bpf_insn *insn)
+{
+	int err;
+
+	err = check_reg_arg(env, insn->src_reg, SRC_OP);
+	if (err)
+		return err;
+
+	err = check_reg_arg(env, insn->dst_reg, SRC_OP);
+	if (err)
+		return err;
+
+	if (is_pointer_value(env, insn->src_reg)) {
+		verbose(env, "R%d leaks addr into mem\n", insn->src_reg);
+		return -EACCES;
+	}
+
+	if (!atomic_ptr_type_ok(env, insn->dst_reg, insn)) {
+		verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
+			insn->dst_reg,
+			reg_type_str(env, reg_state(env, insn->dst_reg)->type));
+		return -EACCES;
+	}
+
+	if (is_arena_reg(env, insn->dst_reg)) {
+		err = save_aux_ptr_type(env, PTR_TO_ARENA, false);
+		if (err)
+			return err;
+	}
+
+	/* Check whether we can write into the memory. */
+	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
+			       BPF_SIZE(insn->code), BPF_WRITE, insn->src_reg,
+			       true, false);
+	if (err)
+		return err;
+	return 0;
+}
+
 static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
 {
 	switch (insn->imm) {
@@ -7639,6 +7726,10 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	case BPF_XCHG:
 	case BPF_CMPXCHG:
 		return check_atomic_rmw(env, insn_idx, insn);
+	case BPF_LOAD_ACQ:
+		return check_atomic_load(env, insn_idx, insn);
+	case BPF_STORE_REL:
+		return check_atomic_store(env, insn_idx, insn);
 	default:
 		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
 		return -EINVAL;
@@ -20420,7 +20511,9 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
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
2.48.1.262.g85cc9f2d1e-goog


