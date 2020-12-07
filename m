Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5782D15A9
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 17:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgLGQJr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 11:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbgLGQJr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 11:09:47 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A75C0611D0
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 08:08:26 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id j62so5506387wma.4
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 08:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=gxx2FbbCW7hbLKnAQIkI4+xIkMuXLrdGlKPV2mI9Xto=;
        b=f8SBI7Qe/pem04/GXA+1zz/xII3/Zl6NcNKLAEFcIyCIaSK22PqeXRDHV9BKcCzt4b
         nOsVbsS3083paQzlt1yE3tadJ2Bcq6l9a3YmBFV71uSNh27ZogIEURmjiwloWCAlKduc
         ca35FlMwDTQ3G9bXYW9beOfeTRhnj/rE0yBkVsmfocKNRjSUrTIwJGIB39MEJad3lJ6y
         WcGX3ya5M1I7t+yzv6JIQ6kk1+CuzAdcPTEY1xEbchEiXFkcy2DVJdd3HF//+iYzU+Qj
         IP/9ZOu2rpi6UAqjl7SHOkcMugWf7xZugmT0LvKZnX9EebTcRENvZID1H8TplLgXKQNo
         QUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gxx2FbbCW7hbLKnAQIkI4+xIkMuXLrdGlKPV2mI9Xto=;
        b=UX2zqwSGL9EqKQOnj1NRV2D7Ww44NtcwnkGGLw3HBd0HIzrGVMGUDXG5sItTh7Pp2h
         gmrl5Ek3ouynCALtYzrBFQnmY0BHEfDnLOvzX24UqKxSo9tikBhMRKuFrPJ5E8LoryX4
         pWurK6qp6YJLZLWoLX4Mjlrd/tJ4iHl3I1+LFPfhD4PEQov4HArixilMg4MGeCM9Lc6p
         JDQQS0q+8C8wXw1pspeoEph9HLX2XcWbh7nhZ301yDRds9s7iSskSbq+uwZqeLlk4pdx
         wmQEkmIGjIvH8iFukP6kjFoXdfMPEpuOQeNwS+cIDV2bIFFbHhbAmMQCAAXZtfb5YS9J
         n+gA==
X-Gm-Message-State: AOAM533rn8ICZm/CXjIJBPNbwwg6rLwlVAWXI7DoZUoQsEfPl6DkUEo0
        6FIg+AyWvRDwdW1wXAW+5cuADKXdLFRI22BXufI9VYrUWiJmCBr3UTqDwJQ6fV4XgEc6LYHTpVY
        cxuv3219w64b0X9GR9v5fAwACZy6Nut8O+W6TorPZP1u6hB6C6LX0ZVpeDdUvz/g=
X-Google-Smtp-Source: ABdhPJzZRoEJchhljgUUusfHGKMj4wIUtWIaFHjBLcoy3gz3zXu5QH06kDlemBFRUFoSmGszgNXOkWJdgS/W3g==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:61c3:: with SMTP id
 v186mr19139744wmb.146.1607357305625; Mon, 07 Dec 2020 08:08:25 -0800 (PST)
Date:   Mon,  7 Dec 2020 16:07:29 +0000
In-Reply-To: <20201207160734.2345502-1-jackmanb@google.com>
Message-Id: <20201207160734.2345502-7-jackmanb@google.com>
Mime-Version: 1.0
References: <20201207160734.2345502-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH bpf-next v4 06/11] bpf: Add BPF_FETCH field / create
 atomic_fetch_add instruction
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

The BPF_FETCH field can be set in bpf_insn.imm, for BPF_ATOMIC
instructions, in order to have the previous value of the
atomically-modified memory location loaded into the src register
after an atomic op is carried out.

Suggested-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/net/bpf_jit_comp.c    |  4 ++++
 include/linux/filter.h         |  1 +
 include/uapi/linux/bpf.h       |  3 +++
 kernel/bpf/core.c              | 13 +++++++++++++
 kernel/bpf/disasm.c            |  7 +++++++
 kernel/bpf/verifier.c          | 33 ++++++++++++++++++++++++---------
 tools/include/linux/filter.h   | 11 +++++++++++
 tools/include/uapi/linux/bpf.h |  3 +++
 8 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index b1829a534da1..eea7d8b0bb12 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -811,6 +811,10 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
 		/* lock *(u32/u64*)(dst_reg + off) <op>= src_reg */
 		EMIT1(simple_alu_opcodes[atomic_op]);
 		break;
+	case BPF_ADD | BPF_FETCH:
+		/* src_reg = atomic_fetch_add(dst_reg + off, src_reg); */
+		EMIT2(0x0F, 0xC1);
+		break;
 	default:
 		pr_err("bpf_jit: unknown atomic opcode %02x\n", atomic_op);
 		return -EFAULT;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 45be19408f68..b5258bca10d2 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -264,6 +264,7 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
  * Atomic operations:
  *
  *   BPF_ADD                  *(uint *) (dst_reg + off16) += src_reg
+ *   BPF_ADD | BPF_FETCH      src_reg = atomic_fetch_add(dst_reg + off16, src_reg);
  */
 
 #define BPF_ATOMIC64(OP, DST, SRC, OFF)				\
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 98161e2d389f..d5389119291e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -44,6 +44,9 @@
 #define BPF_CALL	0x80	/* function call */
 #define BPF_EXIT	0x90	/* function return */
 
+/* atomic op type fields (stored in immediate) */
+#define BPF_FETCH	0x01	/* fetch previous value into src reg */
+
 /* Register numbers */
 enum {
 	BPF_REG_0 = 0,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3abc6b250b18..61e93eb7d363 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1624,16 +1624,29 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 			/* lock xadd *(u32 *)(dst_reg + off16) += src_reg */
 			atomic_add((u32) SRC, (atomic_t *)(unsigned long)
 				   (DST + insn->off));
+			break;
+		case BPF_ADD | BPF_FETCH:
+			SRC = (u32) atomic_fetch_add(
+				(u32) SRC,
+				(atomic_t *)(unsigned long) (DST + insn->off));
+			break;
 		default:
 			goto default_label;
 		}
 		CONT;
+
 	STX_ATOMIC_DW:
 		switch (IMM) {
 		case BPF_ADD:
 			/* lock xadd *(u64 *)(dst_reg + off16) += src_reg */
 			atomic64_add((u64) SRC, (atomic64_t *)(unsigned long)
 				     (DST + insn->off));
+			break;
+		case BPF_ADD | BPF_FETCH:
+			SRC = (u64) atomic64_fetch_add(
+				(u64) SRC,
+				(atomic64_t *)(s64) (DST + insn->off));
+			break;
 		default:
 			goto default_label;
 		}
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 37c8d6e9b4cc..d2e20f6d0516 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -160,6 +160,13 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off,
 				insn->src_reg);
+		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
+			   insn->imm == (BPF_ADD | BPF_FETCH)) {
+			verbose(cbs->private_data, "(%02x) r%d = atomic%s_fetch_add((%s *)(r%d %+d), r%d)\n",
+				insn->code, insn->src_reg,
+				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
+				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
+				insn->dst_reg, insn->off, insn->src_reg);
 		} else {
 			verbose(cbs->private_data, "BUG_%02x\n", insn->code);
 		}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 745c53df0485..f8c4e809297d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3610,7 +3610,11 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 {
 	int err;
 
-	if (insn->imm != BPF_ADD) {
+	switch (insn->imm) {
+	case BPF_ADD:
+	case BPF_ADD | BPF_FETCH:
+		break;
+	default:
 		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
 		return -EINVAL;
 	}
@@ -3652,8 +3656,20 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 		return err;
 
 	/* check whether we can write into the same memory */
-	return check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
-				BPF_SIZE(insn->code), BPF_WRITE, -1, true);
+	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
+			       BPF_SIZE(insn->code), BPF_WRITE, -1, true);
+	if (err)
+		return err;
+
+	if (!(insn->imm & BPF_FETCH))
+		return 0;
+
+	/* check and record load of old value into src reg  */
+	err = check_reg_arg(env, insn->src_reg, DST_OP);
+	if (err)
+		return err;
+
+	return 0;
 }
 
 static int __check_stack_boundary(struct bpf_verifier_env *env, u32 regno,
@@ -9527,12 +9543,6 @@ static int do_check(struct bpf_verifier_env *env)
 		} else if (class == BPF_STX) {
 			enum bpf_reg_type *prev_dst_type, dst_reg_type;
 
-			if (((BPF_MODE(insn->code) != BPF_MEM &&
-			      BPF_MODE(insn->code) != BPF_ATOMIC) || insn->imm != 0)) {
-				verbose(env, "BPF_STX uses reserved fields\n");
-				return -EINVAL;
-			}
-
 			if (BPF_MODE(insn->code) == BPF_ATOMIC) {
 				err = check_atomic(env, env->insn_idx, insn);
 				if (err)
@@ -9541,6 +9551,11 @@ static int do_check(struct bpf_verifier_env *env)
 				continue;
 			}
 
+			if (BPF_MODE(insn->code) != BPF_MEM || insn->imm != 0) {
+				verbose(env, "BPF_STX uses reserved fields\n");
+				return -EINVAL;
+			}
+
 			/* check src1 operand */
 			err = check_reg_arg(env, insn->src_reg, SRC_OP);
 			if (err)
diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
index f345f12c1ff8..4e0100ba52c2 100644
--- a/tools/include/linux/filter.h
+++ b/tools/include/linux/filter.h
@@ -173,6 +173,7 @@
  * Atomic operations:
  *
  *   BPF_ADD                  *(uint *) (dst_reg + off16) += src_reg
+ *   BPF_ADD | BPF_FETCH      src_reg = atomic_fetch_add(dst_reg + off16, src_reg);
  */
 
 #define BPF_ATOMIC64(OP, DST, SRC, OFF)				\
@@ -201,6 +202,16 @@
 		.off   = OFF,					\
 		.imm   = BPF_ADD })
 
+/* Atomic memory add with fetch, src_reg = atomic_fetch_add(dst_reg + off, src_reg); */
+
+#define BPF_ATOMIC_FETCH_ADD(SIZE, DST, SRC, OFF)		\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_ADD | BPF_FETCH })
+
 /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
 
 #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 98161e2d389f..d5389119291e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -44,6 +44,9 @@
 #define BPF_CALL	0x80	/* function call */
 #define BPF_EXIT	0x90	/* function return */
 
+/* atomic op type fields (stored in immediate) */
+#define BPF_FETCH	0x01	/* fetch previous value into src reg */
+
 /* Register numbers */
 enum {
 	BPF_REG_0 = 0,
-- 
2.29.2.576.ga3fc446d84-goog

