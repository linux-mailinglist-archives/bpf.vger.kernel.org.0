Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48512D15A7
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 17:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgLGQJq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 11:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbgLGQJm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 11:09:42 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900EAC0619D2
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 08:08:28 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id z29so18504298ybi.23
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 08:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=KFgD8YIRWXpoDvV2V8052aIfA4U5x1v+0l9kUcqRm+k=;
        b=Ghj1R+EJ/qdBT/riYw4m213zqxkgLqS+z4feLKEzpN/nnE6G/Mysyc3eEH0tTzikEO
         VPQeYcOjl8vEyd6V7EP9Y4BllHRC9krTw9kbY8kjeNWCXEymYDD/klnI/qv8qS3Yz8Fg
         jOe4+L91kVhCtaSwJiYW+ENDHQmuhGLEZbDZXWh2Oyma9dHh1G/QduKNWYI+bUEHLUk7
         V4LJ3iI7YfCMwCNRXYHFZCro62pP4woGoJUNqQxOhhcapYX+2e8FpfStO2cdccfqpvAe
         L1PNGQ9AV4CQomvGlq+aPDvgBQG2kYmPV9RabYA4Uf1tudwNe3LHGoGNNhVkx36TGjyN
         EsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KFgD8YIRWXpoDvV2V8052aIfA4U5x1v+0l9kUcqRm+k=;
        b=OtCPw90xTX8HWzSdNB6YDrHHbFLy3wLx+gmfsZGQt4W/3ImJaDhc3mSTpbe/W9mx+H
         +Uddoktct2xg86EP8N8YyzatCy3uK92aUGViSbrfbyJQWV68zNskRH8hW6QSzIDOlZ96
         zho15REyYxfe8DxahxN2tpDjSesQ+lh09bh4SKs8MMTA/dMfXo6REITISVl8ckaudOP0
         n5XYZQ8a+nrn4sZqPpxRJ48lqhcTnNwgEm3XvyqVHFG5o1W3uVcxDpvmXH0CgYr/IM5N
         11H0iVx3WiUAEUEPvbUGHYp/zKUFvcMQbIb2FfTsOTGiwc9Tz1zfb/Dum8Ywidypeglx
         aDxw==
X-Gm-Message-State: AOAM531Sl4MS9sMNa6PP45dsYiFouuMoh9YvmH6j8ZOanXqxYRF2Gbx/
        IFgwZiZo54x877d4cE/S7ZuNmkn0cW38Yo05lqXB1t//zGQWgyDx99B7mW4UM7A9+AFxvMPlLTt
        aAdQyTqcKdjbSz4bbRIXGm12i6v6iOhZx9/AyJNBlr6nyfxgWfciXiqguHr5BBA0=
X-Google-Smtp-Source: ABdhPJz+kZV/dfJkzyYsmLtUvRn80DVTGUoiQDhMe1ef9+pTPsU+LNOyBFTohQLsJiL7hXi7+VBjiO/X96Jtiw==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a25:c647:: with SMTP id
 k68mr24475368ybf.337.1607357307680; Mon, 07 Dec 2020 08:08:27 -0800 (PST)
Date:   Mon,  7 Dec 2020 16:07:30 +0000
In-Reply-To: <20201207160734.2345502-1-jackmanb@google.com>
Message-Id: <20201207160734.2345502-8-jackmanb@google.com>
Mime-Version: 1.0
References: <20201207160734.2345502-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH bpf-next v4 07/11] bpf: Add instructions for atomic_[cmp]xchg
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds two atomic opcodes, both of which include the BPF_FETCH
flag. XCHG without the BPF_FETCH flag would naturally encode
atomic_set. This is not supported because it would be of limited
value to userspace (it doesn't imply any barriers). CMPXCHG without
BPF_FETCH woulud be an atomic compare-and-write. We don't have such
an operation in the kernel so it isn't provided to BPF either.

There are two significant design decisions made for the CMPXCHG
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
 arch/x86/net/bpf_jit_comp.c    |  8 ++++++++
 include/linux/filter.h         | 22 ++++++++++++++++++++++
 include/uapi/linux/bpf.h       |  4 +++-
 kernel/bpf/core.c              | 20 ++++++++++++++++++++
 kernel/bpf/disasm.c            | 15 +++++++++++++++
 kernel/bpf/verifier.c          | 19 +++++++++++++++++--
 tools/include/linux/filter.h   | 22 ++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  4 +++-
 8 files changed, 110 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index eea7d8b0bb12..308241187582 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -815,6 +815,14 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
 		/* src_reg = atomic_fetch_add(dst_reg + off, src_reg); */
 		EMIT2(0x0F, 0xC1);
 		break;
+	case BPF_XCHG:
+		/* src_reg = atomic_xchg(dst_reg + off, src_reg); */
+		EMIT1(0x87);
+		break;
+	case BPF_CMPXCHG:
+		/* r0 = atomic_cmpxchg(dst_reg + off, r0, src_reg); */
+		EMIT2(0x0F, 0xB1);
+		break;
 	default:
 		pr_err("bpf_jit: unknown atomic opcode %02x\n", atomic_op);
 		return -EFAULT;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index b5258bca10d2..e1e1fc946a7c 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -265,6 +265,8 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
  *
  *   BPF_ADD                  *(uint *) (dst_reg + off16) += src_reg
  *   BPF_ADD | BPF_FETCH      src_reg = atomic_fetch_add(dst_reg + off16, src_reg);
+ *   BPF_XCHG                 src_reg = atomic_xchg(dst_reg + off16, src_reg)
+ *   BPF_CMPXCHG              r0 = atomic_cmpxchg(dst_reg + off16, r0, src_reg)
  */
 
 #define BPF_ATOMIC64(OP, DST, SRC, OFF)				\
@@ -293,6 +295,26 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 		.off   = OFF,					\
 		.imm   = BPF_ADD })
 
+/* Atomic exchange, src_reg = atomic_xchg(dst_reg + off, src_reg) */
+
+#define BPF_ATOMIC_XCHG(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_XCHG  })
+
+/* Atomic compare-exchange, r0 = atomic_cmpxchg(dst_reg + off, r0, src_reg) */
+
+#define BPF_ATOMIC_CMPXCHG(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_CMPXCHG })
+
 /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
 
 #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d5389119291e..b733af50a5b9 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -45,7 +45,9 @@
 #define BPF_EXIT	0x90	/* function return */
 
 /* atomic op type fields (stored in immediate) */
-#define BPF_FETCH	0x01	/* fetch previous value into src reg */
+#define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
+#define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
+#define BPF_FETCH	0x01	/* not an opcode on its own, used to build others */
 
 /* Register numbers */
 enum {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 61e93eb7d363..28f960bc2e30 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1630,6 +1630,16 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 				(u32) SRC,
 				(atomic_t *)(unsigned long) (DST + insn->off));
 			break;
+		case BPF_XCHG:
+			SRC = (u32) atomic_xchg(
+				(atomic_t *)(unsigned long) (DST + insn->off),
+				(u32) SRC);
+			break;
+		case BPF_CMPXCHG:
+			BPF_R0 = (u32) atomic_cmpxchg(
+				(atomic_t *)(unsigned long) (DST + insn->off),
+				(u32) BPF_R0, (u32) SRC);
+			break;
 		default:
 			goto default_label;
 		}
@@ -1647,6 +1657,16 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 				(u64) SRC,
 				(atomic64_t *)(s64) (DST + insn->off));
 			break;
+		case BPF_XCHG:
+			SRC = (u64) atomic64_xchg(
+				(atomic64_t *)(u64) (DST + insn->off),
+				(u64) SRC);
+			break;
+		case BPF_CMPXCHG:
+			BPF_R0 = (u64) atomic64_cmpxchg(
+				(atomic64_t *)(u64) (DST + insn->off),
+				(u64) BPF_R0, (u64) SRC);
+			break;
 		default:
 			goto default_label;
 		}
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index d2e20f6d0516..ee8d1132767b 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -167,6 +167,21 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off, insn->src_reg);
+		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
+			   insn->imm == BPF_CMPXCHG) {
+			verbose(cbs->private_data, "(%02x) r0 = atomic%s_cmpxchg((%s *)(r%d %+d), r0, r%d)\n",
+				insn->code,
+				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
+				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
+				insn->dst_reg, insn->off,
+				insn->src_reg);
+		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
+			   insn->imm == BPF_XCHG) {
+			verbose(cbs->private_data, "(%02x) r%d = atomic%s_xchg((%s *)(r%d %+d), r%d)\n",
+				insn->code, insn->src_reg,
+				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
+				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
+				insn->dst_reg, insn->off, insn->src_reg);
 		} else {
 			verbose(cbs->private_data, "BUG_%02x\n", insn->code);
 		}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f8c4e809297d..f5f4460b3e4e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3608,11 +3608,14 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 
 static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
 {
+	int load_reg;
 	int err;
 
 	switch (insn->imm) {
 	case BPF_ADD:
 	case BPF_ADD | BPF_FETCH:
+	case BPF_XCHG:
+	case BPF_CMPXCHG:
 		break;
 	default:
 		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
@@ -3634,6 +3637,13 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	if (err)
 		return err;
 
+	if (insn->imm == BPF_CMPXCHG) {
+		/* Check comparison of R0 with memory location */
+		err = check_reg_arg(env, BPF_REG_0, SRC_OP);
+		if (err)
+			return err;
+	}
+
 	if (is_pointer_value(env, insn->src_reg)) {
 		verbose(env, "R%d leaks addr into mem\n", insn->src_reg);
 		return -EACCES;
@@ -3664,8 +3674,13 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	if (!(insn->imm & BPF_FETCH))
 		return 0;
 
-	/* check and record load of old value into src reg  */
-	err = check_reg_arg(env, insn->src_reg, DST_OP);
+	if (insn->imm == BPF_CMPXCHG)
+		load_reg = BPF_REG_0;
+	else
+		load_reg = insn->src_reg;
+
+	/* check and record load of old value */
+	err = check_reg_arg(env, load_reg, DST_OP);
 	if (err)
 		return err;
 
diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
index 4e0100ba52c2..21598053fd40 100644
--- a/tools/include/linux/filter.h
+++ b/tools/include/linux/filter.h
@@ -174,6 +174,8 @@
  *
  *   BPF_ADD                  *(uint *) (dst_reg + off16) += src_reg
  *   BPF_ADD | BPF_FETCH      src_reg = atomic_fetch_add(dst_reg + off16, src_reg);
+ *   BPF_XCHG                 src_reg = atomic_xchg(dst_reg + off16, src_reg)
+ *   BPF_CMPXCHG              r0 = atomic_cmpxchg(dst_reg + off16, r0, src_reg)
  */
 
 #define BPF_ATOMIC64(OP, DST, SRC, OFF)				\
@@ -212,6 +214,26 @@
 		.off   = OFF,					\
 		.imm   = BPF_ADD | BPF_FETCH })
 
+/* Atomic exchange, src_reg = atomic_xchg(dst_reg + off, src_reg) */
+
+#define BPF_ATOMIC_XCHG(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_XCHG })
+
+/* Atomic compare-exchange, r0 = atomic_cmpxchg(dst_reg + off, r0, src_reg) */
+
+#define BPF_ATOMIC_CMPXCHG(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_CMPXCHG })
+
 /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
 
 #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d5389119291e..b733af50a5b9 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -45,7 +45,9 @@
 #define BPF_EXIT	0x90	/* function return */
 
 /* atomic op type fields (stored in immediate) */
-#define BPF_FETCH	0x01	/* fetch previous value into src reg */
+#define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
+#define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
+#define BPF_FETCH	0x01	/* not an opcode on its own, used to build others */
 
 /* Register numbers */
 enum {
-- 
2.29.2.576.ga3fc446d84-goog

