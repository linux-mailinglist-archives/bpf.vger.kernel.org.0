Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B352F347C
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 16:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405360AbhALPos (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 10:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405323AbhALPol (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 10:44:41 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEC0C0617BD
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 07:42:59 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id l7so1766142qth.15
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 07:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zHEOu/9QmNp0RJDSfMyBw4HdEGXSo7okAY0TE31s3K4=;
        b=M94+uVX5CXS1JXO7V4FmfwzrMnEtWfTQJoOfxlZS4frsfa+/Wjt2IQwbxu0XelLxqb
         u/3psu7erHA595YqE6bhDG8gEp7zBS/UytQ7osLE8ONfWua3qfL7YRlV8n+O1i0zfaY7
         kx19JUHhZp4pCC6ZkjL+DnV7cYCx/HGxD7Otcg9c5Py2teRD2f4PGjCIzKcwjV9MVo0J
         pQ30v60WF7FKLaVN77tprOKt7e6QRPK+a18A3ldT/FV/A2Fc4grTIDWZ7fb61nzNbXcj
         n4boPG937yKq6uxsrikdh/xvUpi4nHwzefhhMNeUQnegU7kDjIIagZgWNEB0XHU+1S0T
         PG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zHEOu/9QmNp0RJDSfMyBw4HdEGXSo7okAY0TE31s3K4=;
        b=dk8FTwlCAuFAW+7YQMIlWUjHlUVS/tjAyz1zkUWeCZOPN078uMmcBDaqX2fhjuVTpq
         lZp9syDX4bLEAKKj8+PeMdicT0BZ+yVE9SZyWz4tX/KE7KvM8bieL5hr3Wfs/cxtzoQg
         0BXWr8wfgJskqdIHYlczZyYSFNjMtBhCwS34x46DfSQS67n0Lg/eeamr6AYY1iSFliku
         kaBhf5QgPEHf0dAjcMpNIkZQEX1RjIy3xnAETK/4V7ULaKHoVH0ayOFF3Iq/+Ci+Vt8D
         YiID3B6Yy54VNDmbjuZj+DX0H65Fc/UsmJLJJo+SsrEpIRR6XCO+hUgW48LikWl/++AC
         a8Iw==
X-Gm-Message-State: AOAM530cQpfBWdxOhsL4bgGUW4oe0A1q/fJ7h/8Qhrsd4qd9ZXXEDCg7
        YudZ4Z6Vqbs9Lkc18PA9/JVhzi83Kq3noAvoBsqUjCHPj1FXYAKXyj1TD1yuICeDD6TYChOtBhL
        RVXIaVfiRqz1axQVFIYKh//26PfIjaofn/YmmmsiFiYGuU4DCw9/3BN+bgvNhgUo=
X-Google-Smtp-Source: ABdhPJy0wdr5sAqZSsRhlCZg1krFN2DrbKIHSkUbF6oz9KE+Lrztq6ituk9pk+dyRoa5FzCriSRzEv9MrjvLbg==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a0c:fc4e:: with SMTP id
 w14mr5201786qvp.23.1610466178602; Tue, 12 Jan 2021 07:42:58 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:42:33 +0000
In-Reply-To: <20210112154235.2192781-1-jackmanb@google.com>
Message-Id: <20210112154235.2192781-10-jackmanb@google.com>
Mime-Version: 1.0
References: <20210112154235.2192781-1-jackmanb@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v6 09/11] bpf: Add bitwise atomic instructions
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn.topel@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds instructions for

atomic[64]_[fetch_]and
atomic[64]_[fetch_]or
atomic[64]_[fetch_]xor

All these operations are isomorphic enough to implement with the same
verifier, interpreter, and x86 JIT code, hence being a single commit.

The main interesting thing here is that x86 doesn't directly support
the fetch_ version these operations, so we need to generate a CMPXCHG
loop in the JIT. This requires the use of two temporary registers,
IIUC it's safe to use BPF_REG_AX and x86's AUX_REG for this purpose.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 arch/x86/net/bpf_jit_comp.c  | 50 +++++++++++++++++++++++++++++++++++-
 include/linux/filter.h       |  6 +++++
 kernel/bpf/core.c            |  3 +++
 kernel/bpf/disasm.c          | 21 ++++++++++++---
 kernel/bpf/verifier.c        |  6 +++++
 tools/include/linux/filter.h |  6 +++++
 6 files changed, 87 insertions(+), 5 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 308241187582..1d4d50199293 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -808,6 +808,10 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
 	/* emit opcode */
 	switch (atomic_op) {
 	case BPF_ADD:
+	case BPF_SUB:
+	case BPF_AND:
+	case BPF_OR:
+	case BPF_XOR:
 		/* lock *(u32/u64*)(dst_reg + off) <op>= src_reg */
 		EMIT1(simple_alu_opcodes[atomic_op]);
 		break;
@@ -1292,8 +1296,52 @@ st:			if (is_imm8(insn->off))
 
 		case BPF_STX | BPF_ATOMIC | BPF_W:
 		case BPF_STX | BPF_ATOMIC | BPF_DW:
+			if (insn->imm == (BPF_AND | BPF_FETCH) ||
+			    insn->imm == (BPF_OR | BPF_FETCH) ||
+			    insn->imm == (BPF_XOR | BPF_FETCH)) {
+				u8 *branch_target;
+				bool is64 = BPF_SIZE(insn->code) == BPF_DW;
+
+				/*
+				 * Can't be implemented with a single x86 insn.
+				 * Need to do a CMPXCHG loop.
+				 */
+
+				/* Will need RAX as a CMPXCHG operand so save R0 */
+				emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
+				branch_target = prog;
+				/* Load old value */
+				emit_ldx(&prog, BPF_SIZE(insn->code),
+					 BPF_REG_0, dst_reg, insn->off);
+				/*
+				 * Perform the (commutative) operation locally,
+				 * put the result in the AUX_REG.
+				 */
+				emit_mov_reg(&prog, is64, AUX_REG, BPF_REG_0);
+				maybe_emit_mod(&prog, AUX_REG, src_reg, is64);
+				EMIT2(simple_alu_opcodes[BPF_OP(insn->imm)],
+				      add_2reg(0xC0, AUX_REG, src_reg));
+				/* Attempt to swap in new value */
+				err = emit_atomic(&prog, BPF_CMPXCHG,
+						  dst_reg, AUX_REG, insn->off,
+						  BPF_SIZE(insn->code));
+				if (WARN_ON(err))
+					return err;
+				/*
+				 * ZF tells us whether we won the race. If it's
+				 * cleared we need to try again.
+				 */
+				EMIT2(X86_JNE, -(prog - branch_target) - 2);
+				/* Return the pre-modification value */
+				emit_mov_reg(&prog, is64, src_reg, BPF_REG_0);
+				/* Restore R0 after clobbering RAX */
+				emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
+				break;
+
+			}
+
 			err = emit_atomic(&prog, insn->imm, dst_reg, src_reg,
-					  insn->off, BPF_SIZE(insn->code));
+						  insn->off, BPF_SIZE(insn->code));
 			if (err)
 				return err;
 			break;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index ab2b2185f2d7..e05702282e73 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -264,7 +264,13 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
  * Atomic operations:
  *
  *   BPF_ADD                  *(uint *) (dst_reg + off16) += src_reg
+ *   BPF_AND                  *(uint *) (dst_reg + off16) &= src_reg
+ *   BPF_OR                   *(uint *) (dst_reg + off16) |= src_reg
+ *   BPF_XOR                  *(uint *) (dst_reg + off16) ^= src_reg
  *   BPF_ADD | BPF_FETCH      src_reg = atomic_fetch_add(dst_reg + off16, src_reg);
+ *   BPF_AND | BPF_FETCH      src_reg = atomic_fetch_and(dst_reg + off16, src_reg);
+ *   BPF_OR | BPF_FETCH       src_reg = atomic_fetch_or(dst_reg + off16, src_reg);
+ *   BPF_XOR | BPF_FETCH      src_reg = atomic_fetch_xor(dst_reg + off16, src_reg);
  *   BPF_XCHG                 src_reg = atomic_xchg(dst_reg + off16, src_reg)
  *   BPF_CMPXCHG              r0 = atomic_cmpxchg(dst_reg + off16, r0, src_reg)
  */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7b52affc5bd8..4399890b7584 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1642,6 +1642,9 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 	STX_ATOMIC_W:
 		switch (IMM) {
 		ATOMIC_ALU_OP(BPF_ADD, add)
+		ATOMIC_ALU_OP(BPF_AND, and)
+		ATOMIC_ALU_OP(BPF_OR, or)
+		ATOMIC_ALU_OP(BPF_XOR, xor)
 #undef ATOMIC_ALU_OP
 
 		case BPF_XCHG:
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index ee8d1132767b..19ff8fed7f4b 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -80,6 +80,13 @@ const char *const bpf_alu_string[16] = {
 	[BPF_END >> 4]  = "endian",
 };
 
+static const char *const bpf_atomic_alu_string[16] = {
+	[BPF_ADD >> 4]  = "add",
+	[BPF_AND >> 4]  = "and",
+	[BPF_OR >> 4]  = "or",
+	[BPF_XOR >> 4]  = "or",
+};
+
 static const char *const bpf_ldst_string[] = {
 	[BPF_W >> 3]  = "u32",
 	[BPF_H >> 3]  = "u16",
@@ -154,17 +161,23 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				insn->dst_reg,
 				insn->off, insn->src_reg);
 		else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
-			 insn->imm == BPF_ADD) {
-			verbose(cbs->private_data, "(%02x) lock *(%s *)(r%d %+d) += r%d\n",
+			 (insn->imm == BPF_ADD || insn->imm == BPF_ADD ||
+			  insn->imm == BPF_OR || insn->imm == BPF_XOR)) {
+			verbose(cbs->private_data, "(%02x) lock *(%s *)(r%d %+d) %s r%d\n",
 				insn->code,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off,
+				bpf_alu_string[BPF_OP(insn->imm) >> 4],
 				insn->src_reg);
 		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
-			   insn->imm == (BPF_ADD | BPF_FETCH)) {
-			verbose(cbs->private_data, "(%02x) r%d = atomic%s_fetch_add((%s *)(r%d %+d), r%d)\n",
+			   (insn->imm == (BPF_ADD | BPF_FETCH) ||
+			    insn->imm == (BPF_AND | BPF_FETCH) ||
+			    insn->imm == (BPF_OR | BPF_FETCH) ||
+			    insn->imm == (BPF_XOR | BPF_FETCH))) {
+			verbose(cbs->private_data, "(%02x) r%d = atomic%s_fetch_%s((%s *)(r%d %+d), r%d)\n",
 				insn->code, insn->src_reg,
 				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
+				bpf_atomic_alu_string[BPF_OP(insn->imm) >> 4],
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off, insn->src_reg);
 		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b1226bcd9765..d980c5207e50 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3612,6 +3612,12 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	switch (insn->imm) {
 	case BPF_ADD:
 	case BPF_ADD | BPF_FETCH:
+	case BPF_AND:
+	case BPF_AND | BPF_FETCH:
+	case BPF_OR:
+	case BPF_OR | BPF_FETCH:
+	case BPF_XOR:
+	case BPF_XOR | BPF_FETCH:
 	case BPF_XCHG:
 	case BPF_CMPXCHG:
 		break;
diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
index d75998b0d5ac..736bdeccdfe4 100644
--- a/tools/include/linux/filter.h
+++ b/tools/include/linux/filter.h
@@ -173,7 +173,13 @@
  * Atomic operations:
  *
  *   BPF_ADD                  *(uint *) (dst_reg + off16) += src_reg
+ *   BPF_AND                  *(uint *) (dst_reg + off16) &= src_reg
+ *   BPF_OR                   *(uint *) (dst_reg + off16) |= src_reg
+ *   BPF_XOR                  *(uint *) (dst_reg + off16) ^= src_reg
  *   BPF_ADD | BPF_FETCH      src_reg = atomic_fetch_add(dst_reg + off16, src_reg);
+ *   BPF_AND | BPF_FETCH      src_reg = atomic_fetch_and(dst_reg + off16, src_reg);
+ *   BPF_OR | BPF_FETCH       src_reg = atomic_fetch_or(dst_reg + off16, src_reg);
+ *   BPF_XOR | BPF_FETCH      src_reg = atomic_fetch_xor(dst_reg + off16, src_reg);
  *   BPF_XCHG                 src_reg = atomic_xchg(dst_reg + off16, src_reg)
  *   BPF_CMPXCHG              r0 = atomic_cmpxchg(dst_reg + off16, r0, src_reg)
  */
-- 
2.30.0.284.gd98b1dd5eaa7-goog

