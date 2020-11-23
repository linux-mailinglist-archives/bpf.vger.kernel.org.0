Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E4F2C1203
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 18:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732710AbgKWRcb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 12:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733249AbgKWRcb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Nov 2020 12:32:31 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF222C061A4D
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 09:32:30 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id q11so1379597wrw.14
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 09:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ft4bHD8EsMd9SqVUJwRKkVubU/kVN30r9eKdrVsbAnQ=;
        b=KPfAyxpvDnNNH8rUl4u7iT1ypfls+RjApI04vvajKLrJITGWRSv14V32te/jODrPta
         2paGSvn05R+95IPPhRcbxYJjTPkV00JuSu/dPl8zAlyvopds6rReQhvT50BURaTRapiy
         MQITaBJY1wW7d4v9+gDTwxkKJkyrI9oKBhmfIfQf3eh9kuT9YFB84Expg7VeP1QFf1ZF
         C76luqI+Yt0dZCnGj7FtBSIHnn+nVP19EdhY/mYz6hvPB+p4Hv8GlBKITA/6sxRWNc1+
         bRmFiXkxCtJ/xnrKwyPB99ZxU8Ji4JHM70zyO8LOadpLw+hsUG/1Apl0BzRi835MzR/c
         pOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ft4bHD8EsMd9SqVUJwRKkVubU/kVN30r9eKdrVsbAnQ=;
        b=Wua+yTz/m4/S6N1kVNQs0uVE5v2u7zqgX3MpnnTDALr+rK/gkWyorPEhccXIk+GbsW
         DmYoaX4JjKjwa1ZhzlAOxltZM2wZxuL4tS3j2JGH52lva/RNDe2NfZxuteQ5pdQq2UYu
         tM6N8uXMH6iFoopUaSaf6ElgEotFDs89zHERDDWvzNiDMGMWF+28yUtaQc1w6aeFUJ73
         8pJxgs07f46s6TFn/putaPmd/c7REwIl0t94+fdt05Ad6QnbDrnUpjrsePXLnJUqpdT6
         xZGQ5ND5LwIsaKV+3Cb0aJF1yTAYsst73vTWkFNTVLFYQAXBHQ2WAi/QmZAV24N1thOy
         vwow==
X-Gm-Message-State: AOAM532BKQ9CzPG8MXGutAmNTIfQse5NrJZ9LL8c8cHB7dGnRh0mHVS5
        7weSZzmYWxANubZuXlwpXdb7Voc6bKsRsXs7/O4DPrc7vWHh1pUhZeycZrButNxSWvv41ZUqc22
        apOLAuqSj6QLt8GDYsEMfsOVqDlNOsPu/nmTQkmsh+xRI9R//+1uc93apig6qP6w=
X-Google-Smtp-Source: ABdhPJwnhfDKHIO3W1Yi+Fezxl7Scn1xoiWbrtbteiQMCFBGa+rVbGgMi3DSlKyj+UtYUTiQ1i0Kfy+hLj5Q4g==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a5d:62ca:: with SMTP id
 o10mr755622wrv.422.1606152749508; Mon, 23 Nov 2020 09:32:29 -0800 (PST)
Date:   Mon, 23 Nov 2020 17:32:01 +0000
In-Reply-To: <20201123173202.1335708-1-jackmanb@google.com>
Message-Id: <20201123173202.1335708-7-jackmanb@google.com>
Mime-Version: 1.0
References: <20201123173202.1335708-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH 6/7] bpf: Add instructions for atomic_cmpxchg and friends
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These are the operations that implement atomic exchange and
compare-exchange.

They are peculiarly named because of the presence of the separate
FETCH field that tells you whether the instruction writes the value
back to the src register. Neither operation is supported without
BPF_FETCH:

- BPF_CMPSET without BPF_FETCH (i.e. an atomic compare-and-set
  without knowing whether the write was successfully) isn't implemented
  by the kernel, x86, or ARM. It would be a burden on the JIT and it's
  hard to imagine a use for this operation, so it's not supported.

- BPF_SET without BPF_FETCH would be bpf_set, which has pretty
  limited use: all it really lets you do is atomically set 64-bit
  values on 32-bit CPUs. It doesn't imply any barriers.

There are two significant design decisions made for the CMPSET
instruction:

 - To solve the issue that this operation fundamentally has 3
   operands, but we only have two register fields. Therefore the
   operand we compare against (the kernel's API calls it 'old') is
   hard-coded to be R0. x86 has similar design (and A64 doesn't
   have this problem).

   A potential alternative might be to encode the other operand's
   register number in the immediate field.

 - The kernel's atomic_cmpxchg returns the old value, while the C11
   userspace APIs return a boolean indicating the comparison
   result. Which should BPF do? A64 returns the old value. x86 returns
   the old value in the hard-coded register (and also sets a
   flag). That means return-old-value is easier to JIT.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/net/bpf_jit_comp.c    | 29 ++++++++++++++++++++++++-----
 include/linux/filter.h         | 30 ++++++++++++++++++++++++++++++
 include/uapi/linux/bpf.h       |  3 +++
 kernel/bpf/core.c              | 20 ++++++++++++++++++++
 kernel/bpf/disasm.c            | 13 +++++++++++++
 kernel/bpf/verifier.c          | 22 +++++++++++++++++++---
 tools/include/linux/filter.h   | 30 ++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  3 +++
 8 files changed, 142 insertions(+), 8 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index b475bf525424..252b556e8abf 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1255,9 +1255,13 @@ st:			if (is_imm8(insn->off))
 
 		case BPF_STX | BPF_ATOMIC | BPF_W:
 		case BPF_STX | BPF_ATOMIC | BPF_DW:
-			if (BPF_OP(insn->imm) != BPF_ADD) {
-				pr_err("bpf_jit: unknown opcode %02x\n", insn->imm);
-				return -EFAULT;
+			if (insn->imm == BPF_SET) {
+				/*
+				 * atomic_set((u32/u64*)(dst_reg + off), src_reg);
+				 * On x86 atomic_set is just WRITE_ONCE.
+				 */
+				emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
+				break;
 			}
 
 			EMIT1(0xF0); /* lock prefix */
@@ -1266,15 +1270,30 @@ st:			if (is_imm8(insn->off))
 				       BPF_SIZE(insn->code) == BPF_DW);
 
 			/* emit opcode */
-			if (insn->imm & BPF_FETCH) {
+			switch (insn->imm) {
+			case BPF_SET | BPF_FETCH:
+				/* src_reg = atomic_chg(*(u32/u64*)(dst_reg + off), src_reg); */
+				EMIT1(0x87);
+				break;
+			case BPF_CMPSET | BPF_FETCH:
+				/* r0 = atomic_cmpxchg(*(u32/u64*)(dst_reg + off), r0, src_reg); */
+				EMIT2(0x0F, 0xB1);
+				break;
+			case BPF_ADD | BPF_FETCH:
 				/* src_reg = sync_fetch_and_add(*(dst_reg + off), src_reg); */
 				EMIT2(0x0F, 0xC1);
-			} else {
+				break;
+			case BPF_ADD:
 				/* lock *(u32/u64*)(dst_reg + off) += src_reg */
 				EMIT1(0x01);
+				break;
+			default:
+				pr_err("bpf_jit: unknown atomic opcode %02x\n", insn->imm);
+				return -EFAULT;
 			}
 
 			emit_modrm_dstoff(&prog, dst_reg, src_reg, insn->off);
+
 			break;
 
 			/* call */
diff --git a/include/linux/filter.h b/include/linux/filter.h
index bf0ff3649f46..402a47fa2276 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -280,6 +280,36 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 		.off   = OFF,					\
 		.imm   = BPF_ADD | BPF_FETCH })
 
+/* Atomic exchange, src_reg = atomic_xchg((dst_reg + off), src_reg) */
+
+#define BPF_ATOMIC_XCHG(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_SET | BPF_FETCH  })
+
+/* Atomic compare-exchange, r0 = atomic_cmpxchg((dst_reg + off), r0, src_reg) */
+
+#define BPF_ATOMIC_CMPXCHG(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_CMPSET | BPF_FETCH })
+
+/* Atomic set, atomic_set((dst_reg + off), src_reg) */
+
+#define BPF_ATOMIC_SET(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_SET })
+
 /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
 
 #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ec7f415f331b..6996c1856f53 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -45,6 +45,9 @@
 #define BPF_EXIT	0x90	/* function return */
 
 /* atomic op type fields (stored in immediate) */
+#define BPF_SET		0xe0	/* atomic write */
+#define BPF_CMPSET	0xf0	/* atomic compare-and-write */
+
 #define BPF_FETCH	0x01	/* fetch previous value into src reg */
 
 /* Register numbers */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 49a2a533db60..a549ac2d7651 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1638,6 +1638,16 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 				(u32) SRC,
 				(atomic_t *)(unsigned long) (DST + insn->off));
 			break;
+		case BPF_SET | BPF_FETCH:
+			SRC = (u32) atomic_xchg(
+				(atomic_t *)(unsigned long) (DST + insn->off),
+				(u32) SRC);
+			break;
+		case BPF_CMPSET | BPF_FETCH:
+			BPF_R0 = (u32) atomic_cmpxchg(
+				(atomic_t *)(unsigned long) (DST + insn->off),
+				(u32) BPF_R0, (u32) SRC);
+			break;
 		default:
 			goto default_label;
 		}
@@ -1655,6 +1665,16 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 				(u64) SRC,
 				(atomic64_t *)(s64) (DST + insn->off));
 			break;
+		case BPF_SET | BPF_FETCH:
+			SRC = (u64) atomic64_xchg(
+				(atomic64_t *)(u64) (DST + insn->off),
+				(u64) SRC);
+			break;
+		case BPF_CMPSET | BPF_FETCH:
+			BPF_R0 = (u64) atomic64_cmpxchg(
+				(atomic64_t *)(u64) (DST + insn->off),
+				(u64) BPF_R0, (u64) SRC);
+			break;
 		default:
 			goto default_label;
 		}
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 669cef265493..7e4a5bfb4e67 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -166,6 +166,19 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				insn->code, insn->src_reg,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off, insn->src_reg);
+		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
+			   insn->imm == (BPF_CMPSET | BPF_FETCH)) {
+			verbose(cbs->private_data, "(%02x) r0 = atomic_cmpxchg(*(%s *)(r%d %+d), r0, r%d)\n",
+				insn->code,
+				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
+				insn->dst_reg, insn->off,
+				insn->src_reg);
+		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
+			   insn->imm == (BPF_SET | BPF_FETCH)) {
+			verbose(cbs->private_data, "(%02x) r%d = atomic_xchg(*(%s *)(r%d %+d), r%d)\n",
+				insn->code, insn->src_reg,
+				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
+				insn->dst_reg, insn->off, insn->src_reg);
 		} else {
 			verbose(cbs->private_data, "BUG_%02x\n", insn->code);
 		}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 14f5053daf22..2e611d3695bf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3602,10 +3602,14 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 {
 	struct bpf_reg_state *regs = cur_regs(env);
 	int err;
+	int load_reg;
 
 	switch (insn->imm) {
 	case BPF_ADD:
 	case BPF_ADD | BPF_FETCH:
+	case BPF_SET:
+	case BPF_SET | BPF_FETCH:
+	case BPF_CMPSET | BPF_FETCH: /* CMPSET without FETCH is not supported */
 		break;
 	default:
 		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
@@ -3627,6 +3631,13 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	if (err)
 		return err;
 
+	if (BPF_OP(insn->imm) == BPF_CMPSET) {
+		/* check src3 operand */
+		err = check_reg_arg(env, BPF_REG_0, SRC_OP);
+		if (err)
+			return err;
+	}
+
 	if (is_pointer_value(env, insn->src_reg)) {
 		verbose(env, "R%d leaks addr into mem\n", insn->src_reg);
 		return -EACCES;
@@ -3657,11 +3668,16 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	if (!(insn->imm & BPF_FETCH))
 		return 0;
 
-	/* check and record load of old value into src reg  */
-	err = check_reg_arg(env, insn->src_reg, DST_OP);
+	if (BPF_OP(insn->imm) == BPF_CMPSET)
+		load_reg = BPF_REG_0;
+	else
+		load_reg = insn->src_reg;
+
+	/* check and record load of old value */
+	err = check_reg_arg(env, load_reg, DST_OP);
 	if (err)
 		return err;
-	regs[insn->src_reg].type = SCALAR_VALUE;
+	regs[load_reg].type = SCALAR_VALUE;
 
 	return 0;
 }
diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
index 8f2707ebab18..5a5e4c39c639 100644
--- a/tools/include/linux/filter.h
+++ b/tools/include/linux/filter.h
@@ -190,6 +190,36 @@
 		.off   = OFF,					\
 		.imm   = BPF_ADD | BPF_FETCH })
 
+/* Atomic exchange, src_reg = atomic_xchg((dst_reg + off), src_reg) */
+
+#define BPF_ATOMIC_XCHG(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_SET | BPF_FETCH })
+
+/* Atomic compare-exchange, r0 = atomic_cmpxchg((dst_reg + off), r0, src_reg) */
+
+#define BPF_ATOMIC_CMPXCHG(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_CMPSET | BPF_FETCH })
+
+/* Atomic set, atomic_set((dst_reg + off), src_reg) */
+
+#define BPF_ATOMIC_SET(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_SET })
+
 #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
 	((struct bpf_insn) {					\
 		.code  = BPF_ST | BPF_SIZE(SIZE) | BPF_MEM,	\
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ec7f415f331b..6996c1856f53 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -45,6 +45,9 @@
 #define BPF_EXIT	0x90	/* function return */
 
 /* atomic op type fields (stored in immediate) */
+#define BPF_SET		0xe0	/* atomic write */
+#define BPF_CMPSET	0xf0	/* atomic compare-and-write */
+
 #define BPF_FETCH	0x01	/* fetch previous value into src reg */
 
 /* Register numbers */
-- 
2.29.2.454.gaff20da3a2-goog

