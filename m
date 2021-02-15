Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A6031BE5F
	for <lists+bpf@lfdr.de>; Mon, 15 Feb 2021 17:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhBOQHu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Feb 2021 11:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbhBOQBl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Feb 2021 11:01:41 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D850AC061574
        for <bpf@vger.kernel.org>; Mon, 15 Feb 2021 08:00:56 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id s131so7278123wme.7
        for <bpf@vger.kernel.org>; Mon, 15 Feb 2021 08:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=jD2cOif5PsUyf6bKm+J1UlU+7a9Tk3VjHfv1dzww5kg=;
        b=nfX3aM9meFczvLhTQ17NHT31YXBFRbLIFR5/nunmIpz9rUdLTIUo7fpIPPDnJIOBxU
         6Cbi9Rr07gfty0+Tuqm6UxOBotpX9E3a8st343e2iGDylCfNvvCL/rxkrOK5KPlreyCf
         ux8ZKA0N1fkan64IxdNBWdxmcV6vioV2M+1aHzPne0k98nZnE3G3Z/auJXDkBwOgxTPU
         wB930tZjnXbl8tShdgb9rNoL/14hGzfgdv4aIjjbL1zHCEz19pVFSj9HtcmvVFmu28Bg
         WvQYqqJeuRFaS1vOt7eZElH4C+P9hds/h4cR6oCSQ4lwl+55k5G2JgonO0pxGlruT1QN
         5GuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=jD2cOif5PsUyf6bKm+J1UlU+7a9Tk3VjHfv1dzww5kg=;
        b=hTFHVM/SfKWh/QloP5IfmupU3rhCYEm8OR40U97nZ0+H70qCZKGolRaZQRUMfPbKVj
         w7aAx1PvCIWMSretEt+OJQrwHQDh1cBMxjVzsYYJCv2ZO4ZcIw/4+EoRuB8HqsWnnPg7
         Sav7SR9abZVV0rKh5W1vRRatVoNtR3URyo/5KNcChIARmOAZ8WGSJ5I+nFh2+MHQ1P9q
         bLBrkURt4JPvzt0H6pqfrPS524dC9mgBwp3RFb/yxihGIT732LIvy21U6buQXzXQvVW+
         8Gw1pvZ2TW0p08NXkzTDUTlHW1TYVySabHr2ya6lQJpnmZEuH/7ESFG7NRiQaHM5nUfT
         2cog==
X-Gm-Message-State: AOAM532jlsvd51viuscy6znjUtitIssz1aXU94XpJpkCScanTTK8ArWr
        wNrc69yxzXVqlI/NcMszt9nuJvBsuBbC9YnHxW5yEtpAJ+LQAuNVrqOVOhCnQ5cbwa6oyRFkfKk
        oD1wQp7Ddc87I+Q/2fxe3b3T8pfm2WXC9uW37KDj1AZjbhFLjh9OkXMF5tZ4E6dA=
X-Google-Smtp-Source: ABdhPJwx7H0n0TwoPU4G7aglIjyQ/KE1UqZIkeELHMY0LKrzuXGLVr3FwdDNCbb3jQsbdCnWf0vOUd5x8TzzOA==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a7b:ce95:: with SMTP id
 q21mr14832322wmj.178.1613404855357; Mon, 15 Feb 2021 08:00:55 -0800 (PST)
Date:   Mon, 15 Feb 2021 16:00:44 +0000
Message-Id: <20210215160044.1108652-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH bpf-next] bpf: x86: Fix BPF_FETCH atomic and/or/xor with r0 as src
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
 arch/x86/net/bpf_jit_comp.c                   |  7 +++---
 .../selftests/bpf/verifier/atomic_and.c       | 23 +++++++++++++++++++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 79e7a0ec1da5..0c9edfe42340 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1349,6 +1349,7 @@ st:			if (is_imm8(insn->off))
 			    insn->imm == (BPF_XOR | BPF_FETCH)) {
 				u8 *branch_target;
 				bool is64 = BPF_SIZE(insn->code) == BPF_DW;
+				u32 real_src_reg = src_reg == BPF_REG_0 ? BPF_REG_AX : src_reg;
 
 				/*
 				 * Can't be implemented with a single x86 insn.
@@ -1366,9 +1367,9 @@ st:			if (is_imm8(insn->off))
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
@@ -1381,7 +1382,7 @@ st:			if (is_imm8(insn->off))
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

base-commit: 5e1d40b75ed85ecd76347273da17e5da195c3e96
-- 
2.30.0.478.g8a0d178c01-goog

