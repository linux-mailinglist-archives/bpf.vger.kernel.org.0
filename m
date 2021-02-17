Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E869831D708
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 10:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhBQJ3g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 04:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhBQJ3Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Feb 2021 04:29:24 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C002C061574
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 01:28:44 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v196so17225291ybv.3
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 01:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=v5jBbr6b0B4lSa4YmRRzjuSB0WItCbUUSXfLsKCZts8=;
        b=bPguaVMcg+sgSrKD/HfMnzTYlNcD57zH2qH5JJ9RurnPulKZFsexf0CvOV4e0jeXvD
         dAdJjR4pWzLO4qJtm19VFNYHVXJBoKHUQCFm8+K1bn8x7cSEPuJ6qUAau4GOE1O3Vrfv
         6tnq8ieF/FUatGCwHV9g2T0d1qw0yTaW35HFRiuQbIEk7+6Sqn+itOkqBmeZ0G3a/9Z/
         F6lvizkFXzqYlzW2dURpL9E/f2UgGFpksZmMVjoMspYJuPVrDNFwkUBSG1oohL6ze5Dg
         PXJ3jFBcSkDkGYPjcP0aOWbmmOIkYdqaHoUdVgPTR1FyfoJMQZqguCfMVp4wqIKC4s3q
         128w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=v5jBbr6b0B4lSa4YmRRzjuSB0WItCbUUSXfLsKCZts8=;
        b=b+edCs6/uS4naHHJHJ66BedehchNcmBjf2eMFY6PLieDPddtqCguT6KNUfhuwGXx9C
         2zpWChAbrIRoR3wCHT3oxreOb1U/nHINOurR1RyAZiSdv3yV/kgxqrOs/5wfyhVfronG
         ALGHmAfjSodAi1roWR0sWsM3QN3Cj6ZuS2h12ANKmXThxkzVgTfawTfmHMGpgClTvg0w
         XepIgLdJ88UrFQiCb7B+1t7f9GN9hax5lKOlC0YozIOo618x3e8pQxvOT/kCMu6E2hrN
         VguHXrtwAgznAFEMvaCted3wYBQwqp7gYlE7F/oB6ijwzMpfoaAchTwZe01gISlS+RqY
         MXMA==
X-Gm-Message-State: AOAM533FbdCOE356FkHhXBSPEH7m+YmFu9mwwW0hJsBzNmvYrK6gcRdL
        4bFk0QLe5uzu02T/gyGZRTmFXJR4jwU/CYXKsPoX8ff2H+IkxxZHAwmbqK7MrwkIUzv48cIEx4Z
        ZdOFcLJFJLT+fL5KZu6ckqtLNeaWK8s8kF5v5JnZ9SV2wDm/6QFNI1r2Tb1Lrs9E=
X-Google-Smtp-Source: ABdhPJx++gxAmcPWKhonfwO43Ps2UZ0HbUgLkEqB+enJvyldYfZhHesUy85GtNDRe2vvyeTJSJMq9mKBaJmZLw==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a25:807:: with SMTP id
 7mr34652857ybi.503.1613554123532; Wed, 17 Feb 2021 01:28:43 -0800 (PST)
Date:   Wed, 17 Feb 2021 09:28:31 +0000
Message-Id: <20210217092831.2366396-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v3 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit cmpxchg
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

As pointed out by Ilya and explained in the new comment, there's a
discrepancy between x86 and BPF CMPXCHG semantics: BPF always loads
the value from memory into r0, while x86 only does so when r0 and the
value in memory are different. The same issue affects s390.

At first this might sound like pure semantics, but it makes a real
difference when the comparison is 32-bit, since the load will
zero-extend r0/rax.

The fix is to explicitly zero-extend rax after doing such a
CMPXCHG. Since this problem affects multiple archs, this is done in
the verifier by patching in a BPF_ZEXT_REG instruction after every
32-bit cmpxchg. Any archs that don't need such manual zero-extension
can do a look-ahead with insn_is_zext to skip the unnecessary mov.

Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---

Differences v2->v3[1]:
 - Moved patching into fixup_bpf_calls (patch incoming to rename this function)
 - Added extra commentary on bpf_jit_needs_zext
 - Added check to avoid adding a pointless zext(r0) if there's already one there.

Difference v1->v2[1]: Now solved centrally in the verifier instead of
  specifically for the x86 JIT. Thanks to Ilya and Daniel for the suggestions!

[1] v2: https://lore.kernel.org/bpf/08669818-c99d-0d30-e1db-53160c063611@iogearbox.net/T/#t
    v1: https://lore.kernel.org/bpf/d7ebaefb-bfd6-a441-3ff2-2fdfe699b1d2@iogearbox.net/T/#t

 kernel/bpf/core.c                             |  4 +++
 kernel/bpf/verifier.c                         | 26 +++++++++++++++++++
 .../selftests/bpf/verifier/atomic_cmpxchg.c   | 25 ++++++++++++++++++
 .../selftests/bpf/verifier/atomic_or.c        | 26 +++++++++++++++++++
 4 files changed, 81 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 0ae015ad1e05..dcf18612841b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2342,6 +2342,10 @@ bool __weak bpf_helper_changes_pkt_data(void *func)
 /* Return TRUE if the JIT backend wants verifier to enable sub-register usage
  * analysis code and wants explicit zero extension inserted by verifier.
  * Otherwise, return FALSE.
+ *
+ * The verifier inserts an explicit zero extension after BPF_CMPXCHGs even if
+ * you don't override this. JITs that don't want these extra insns can detect
+ * them using insn_is_zext.
  */
 bool __weak bpf_jit_needs_zext(void)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 16ba43352a5f..a0d19be13558 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11662,6 +11662,32 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 			continue;
 		}

+		/* BPF_CMPXCHG always loads a value into R0, therefore always
+		 * zero-extends. However some archs' equivalent instruction only
+		 * does this load when the comparison is successful. So here we
+		 * add a BPF_ZEXT_REG after every 32-bit CMPXCHG, so that such
+		 * archs' JITs don't need to deal with the issue. Archs that
+		 * don't face this issue may use insn_is_zext to detect and skip
+		 * the added instruction.
+		 */
+		if (insn->code == (BPF_STX | BPF_W | BPF_ATOMIC) && insn->imm == BPF_CMPXCHG) {
+			struct bpf_insn zext_patch[2] = { [1] = BPF_ZEXT_REG(BPF_REG_0) };
+
+			if (!memcmp(&insn[1], &zext_patch[1], sizeof(struct bpf_insn)))
+				/* Probably done by opt_subreg_zext_lo32_rnd_hi32. */
+				continue;
+
+			zext_patch[0] = *insn;
+			new_prog = bpf_patch_insn_data(env, i + delta, zext_patch, 2);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			continue;
+		}
+
 		if (insn->code != (BPF_JMP | BPF_CALL))
 			continue;
 		if (insn->src_reg == BPF_PSEUDO_CALL)
diff --git a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
index 2efd8bcf57a1..6e52dfc64415 100644
--- a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
@@ -94,3 +94,28 @@
 	.result = REJECT,
 	.errstr = "invalid read from stack",
 },
+{
+	"BPF_W cmpxchg should zero top 32 bits",
+	.insns = {
+		/* r0 = U64_MAX; */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_ALU64_IMM(BPF_SUB, BPF_REG_0, 1),
+		/* u64 val = r0; */
+		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
+		/* r0 = (u32)atomic_cmpxchg((u32 *)&val, r0, 1); */
+		BPF_MOV32_IMM(BPF_REG_1, 1),
+		BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, BPF_REG_10, BPF_REG_1, -8),
+		/* r1 = 0x00000000FFFFFFFFull; */
+		BPF_MOV64_IMM(BPF_REG_1, 1),
+		BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 32),
+		BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 1),
+		/* if (r0 != r1) exit(1); */
+		BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_1, 2),
+		BPF_MOV32_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+		/* exit(0); */
+		BPF_MOV32_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
diff --git a/tools/testing/selftests/bpf/verifier/atomic_or.c b/tools/testing/selftests/bpf/verifier/atomic_or.c
index 70f982e1f9f0..0a08b99e6ddd 100644
--- a/tools/testing/selftests/bpf/verifier/atomic_or.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_or.c
@@ -75,3 +75,29 @@
 	},
 	.result = ACCEPT,
 },
+{
+	"BPF_W atomic_fetch_or should zero top 32 bits",
+	.insns = {
+		/* r1 = U64_MAX; */
+		BPF_MOV64_IMM(BPF_REG_1, 0),
+		BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 1),
+		/* u64 val = r0; */
+		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
+		/* r1 = (u32)atomic_sub((u32 *)&val, 1); */
+		BPF_MOV32_IMM(BPF_REG_1, 2),
+		BPF_ATOMIC_OP(BPF_W, BPF_OR | BPF_FETCH, BPF_REG_10, BPF_REG_1, -8),
+		/* r2 = 0x00000000FFFFFFFF; */
+		BPF_MOV64_IMM(BPF_REG_2, 1),
+		BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 32),
+		BPF_ALU64_IMM(BPF_SUB, BPF_REG_2, 1),
+		/* if (r2 != r1) exit(1); */
+		BPF_JMP_REG(BPF_JEQ, BPF_REG_2, BPF_REG_1, 2),
+		/* BPF_MOV32_IMM(BPF_REG_0, 1), */
+		BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+		BPF_EXIT_INSN(),
+		/* exit(0); */
+		BPF_MOV32_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},

base-commit: 45159b27637b0fef6d5ddb86fc7c46b13c77960f
--
2.30.0.478.g8a0d178c01-goog

