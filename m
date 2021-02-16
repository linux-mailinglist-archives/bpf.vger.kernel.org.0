Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C1731CAC4
	for <lists+bpf@lfdr.de>; Tue, 16 Feb 2021 13:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhBPMx6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Feb 2021 07:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhBPMx4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Feb 2021 07:53:56 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8BFC061574
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 04:53:15 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id z28so7622713qva.15
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 04:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=82yR4201nyNIROn8a1Ln/eFx+kpi6YiF9jEcnW6uIPg=;
        b=rpbolJx1NyGnBLfDzPz5atWJsjEzwkyDnt9RvR0Nym3U3SNekTdS4j6J3CFeMdnyRs
         sYfizWSsatEKsgQ7OghfN6giu5g0od4LJ1oFdIANXBtwtk2kZyXnrtlzL/Ukg3LFPSnA
         xtzwzMlc9iLQWqP/egxplrlUt8p51HdZyfqrxq6wCcHbbjCpoOJdoNtlvWSTOxVVSmFX
         AD/LaHdpFocmPUWjpjS4poYkB5y82wd9Jbgm1NcZ54+14DjwH9PZXysXbkF6TOmjHdWp
         X230g72BluMcRel4NbtRR6YUzhiQVlJ3qzZJL/rt8+szYEP/E8dD8cNarxNdv0dbAnLK
         Xl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=82yR4201nyNIROn8a1Ln/eFx+kpi6YiF9jEcnW6uIPg=;
        b=uLLcQlwcI6mBI2p3L09+NXI20kUGyEwsFZUGtIn6GvGeFbH7edRtbJsBb/O1AztV+i
         e1s8sfAeGBlM4PyC3b6M128h6re9p2D4TTsCHnEy5pTRIPY10xYWrecyUWACpr0vmcmE
         xyIEYAaueSAr6i1cZYufly/H6E6vzRg4FfqLIh4Wf1aCzEBquHaguIFFaquksAgF/KNC
         XbKCSfGfhzXGEOWjEHWUd706t7OUUpXzMGIJ4ff1EggHJ+slLuUMkzjlO04db4QIwtWy
         Ah+kmv4zot0wd1/RjXU0E85vpQrSfNbVBBeVFTPV+OL8WTJbxnMmukQK3w99bStENF60
         hxTw==
X-Gm-Message-State: AOAM530cBia+dv8rLLefeNlaDGOcpIqoeE/em2Pivq4gH6JML+/GPcwv
        VcBrsXCIdxrZR9z3U2R4aOguXqqodfz+3rLomYb8FL5wryM8emoWtrwiFoMpaZ5sMM8YumzvsTd
        usLaf4D228Z8ynfI0FhSdSMbK2HEJn0O6Go7Gk7r2UMh/BXtIfBwMlep1EcLp90w=
X-Google-Smtp-Source: ABdhPJwz/A2Ws4xhDgneqBbEhHPrcNwaRwrSsNM7JDUTdgTRLhPA8VNzT/jFRcRPS6iRwX0oyduAqIxNZYU6yA==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a0c:a918:: with SMTP id
 y24mr13896703qva.17.1613479994391; Tue, 16 Feb 2021 04:53:14 -0800 (PST)
Date:   Tue, 16 Feb 2021 12:53:07 +0000
Message-Id: <20210216125307.1406237-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v2 bpf-next] bpf: x86: Fix BPF_FETCH atomic and/or/xor with r0
 as src
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This code generates a CMPXCHG loop in order to implement atomic_fetch
bitwise operations. Because CMPXCHG is hard-coded to use rax (which
holds the BPF r0 value), it saves the _real_ r0 value into the
internal "ax" temporary register and restores it once the loop is
complete.

In the middle of the loop, the actual bitwise operation is performed
using src_reg. The bug occurs when src_reg is r0: as described above,
r0 has been clobbered and the real r0 value is in the ax register.

Therefore, perform this operation on the ax register instead, when
src_reg is r0.

Fixes: 981f94c3e921 ("bpf: Add bitwise atomic instructions")
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---

Changes v1->v2: Just shifted real_src_reg assignment for clarity.

 arch/x86/net/bpf_jit_comp.c                   | 10 +++++---
 .../selftests/bpf/verifier/atomic_and.c       | 23 +++++++++++++++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 79e7a0ec1da5..6926d0ca6c71 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1349,6 +1349,7 @@ st:			if (is_imm8(insn->off))
 			    insn->imm == (BPF_XOR | BPF_FETCH)) {
 				u8 *branch_target;
 				bool is64 = BPF_SIZE(insn->code) == BPF_DW;
+				u32 real_src_reg = src_reg;

 				/*
 				 * Can't be implemented with a single x86 insn.
@@ -1357,6 +1358,9 @@ st:			if (is_imm8(insn->off))

 				/* Will need RAX as a CMPXCHG operand so save R0 */
 				emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
+				if (src_reg == BPF_REG_0)
+					real_src_reg = BPF_REG_AX;
+
 				branch_target = prog;
 				/* Load old value */
 				emit_ldx(&prog, BPF_SIZE(insn->code),
@@ -1366,9 +1370,9 @@ st:			if (is_imm8(insn->off))
 				 * put the result in the AUX_REG.
 				 */
 				emit_mov_reg(&prog, is64, AUX_REG, BPF_REG_0);
-				maybe_emit_mod(&prog, AUX_REG, src_reg, is64);
+				maybe_emit_mod(&prog, AUX_REG, real_src_reg, is64);
 				EMIT2(simple_alu_opcodes[BPF_OP(insn->imm)],
-				      add_2reg(0xC0, AUX_REG, src_reg));
+				      add_2reg(0xC0, AUX_REG, real_src_reg));
 				/* Attempt to swap in new value */
 				err = emit_atomic(&prog, BPF_CMPXCHG,
 						  dst_reg, AUX_REG, insn->off,
@@ -1381,7 +1385,7 @@ st:			if (is_imm8(insn->off))
 				 */
 				EMIT2(X86_JNE, -(prog - branch_target) - 2);
 				/* Return the pre-modification value */
-				emit_mov_reg(&prog, is64, src_reg, BPF_REG_0);
+				emit_mov_reg(&prog, is64, real_src_reg, BPF_REG_0);
 				/* Restore R0 after clobbering RAX */
 				emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
 				break;
diff --git a/tools/testing/selftests/bpf/verifier/atomic_and.c b/tools/testing/selftests/bpf/verifier/atomic_and.c
index 1bdc8e6684f7..fe4bb70eb9c5 100644
--- a/tools/testing/selftests/bpf/verifier/atomic_and.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_and.c
@@ -75,3 +75,26 @@
 	},
 	.result = ACCEPT,
 },
+{
+	"BPF_ATOMIC_AND with fetch - r0 as source reg",
+	.insns = {
+		/* val = 0x110; */
+		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0x110),
+		/* old = atomic_fetch_and(&val, 0x011); */
+		BPF_MOV64_IMM(BPF_REG_0, 0x011),
+		BPF_ATOMIC_OP(BPF_DW, BPF_AND | BPF_FETCH, BPF_REG_10, BPF_REG_0, -8),
+		/* if (old != 0x110) exit(3); */
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0x110, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 3),
+		BPF_EXIT_INSN(),
+		/* if (val != 0x010) exit(2); */
+		BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -8),
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x010, 2),
+		BPF_MOV64_IMM(BPF_REG_1, 2),
+		BPF_EXIT_INSN(),
+		/* exit(0); */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},

base-commit: 45159b27637b0fef6d5ddb86fc7c46b13c77960f
--
2.30.0.478.g8a0d178c01-goog

