Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFE2322D28
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 16:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbhBWPJa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 10:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbhBWPJa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Feb 2021 10:09:30 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB33C06174A
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 07:08:49 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v196so20757357ybv.3
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 07:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=IcvKgRWgaPnM+uCFX8OhEgFA/fRNp3jDY+qhXpGIDY0=;
        b=sbhlEaYNViFxtngnd1qCfmtGZOQpdqMMNaYQWji9Iv1EA9oI2/psmR5qwpTVvKuxmB
         yA6RaUTo6qJLUaPiYRXFKNOd3JJUTZaAeokajDxzpPMJWC7VC3aC1asejqPPKNJYO0ki
         YL/mmUgH5wEFgRLnnniQ8043zBBkobP6sGT17tEYaAV0+GIuGTW6Hs+aiSGozR0nVLsH
         rMH1gstN+/83OMD5eI3tCUUey1zQTW5n7vFNZeiU207RjxsRmQfl4U3iD79saV8o0GsB
         ejZjDy8ENoJdYirCUWGLYaW1vV34YqrygIPcXIOOGBQlVRHI2NheM6sTOyQDEcDWszrU
         Ni4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=IcvKgRWgaPnM+uCFX8OhEgFA/fRNp3jDY+qhXpGIDY0=;
        b=KhHHfJCeUg1mHzP4TzBO40p18bG4uenoZa6g5sI4RrSs9/1bbJeXOzl/1hhuKacSHA
         m6KSiMSkdXPscumfDwGXKgdwz2rzpJzRMPhICCylRo5QlM6Gdsti4IJGhxUQeBLRCjL4
         N3MIK3+WKQEj0YzIHXXjFqD5BP/KrH2aygqEp3ZGA67GGh3vdBCFV5XDkxVA3kLtblPJ
         9YGjO3yYYGfxrWhOH8DBDWZx0JZ2NQg8TjYC3pYDbWstf/nQIXTRM5sJnjlieNP60RGu
         RWo7P8eXtXRLwoW6i7HN7Kjw2jETCjlzd1BzsAIn/ZIHeWWfdoT9O/ef8atDx8r9KNNk
         wFHw==
X-Gm-Message-State: AOAM533zAX2Zk1VPArMgomdNBKFH1ojf9t97kYv4RfkxBaKVSIVysw2v
        gfgvGGv8K10iwvA9mVECqFEWcjbwRXKXvBGQWAAQ2krv39VpNwZyXHJ1hocO4UHqqeAASMUh0qs
        X8VrXYIbJa7OBwGCs2iHx1IBww0Td4U62HGw1zvGapIjD2hcxxZ6QMbQrNDUrSsQ=
X-Google-Smtp-Source: ABdhPJyA0hvwqYyvMUbKRorRz3TkYE34iT1SK0Y2sX6448dJeHvL3xOFJz/e2FlLXvgsV90H7C956HpPRzwRvg==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a25:5289:: with SMTP id
 g131mr16482848ybb.178.1614092928477; Tue, 23 Feb 2021 07:08:48 -0800 (PST)
Date:   Tue, 23 Feb 2021 15:08:45 +0000
Message-Id: <20210223150845.1857620-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v4 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit cmpxchg
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

There was actually already logic to patch in zero-extension insns
after 32-bit cmpxchgs, in opt_subreg_zext_lo32_rnd_hi32. To avoid
bloating the prog with unnecessary movs, we now explicitly check and
skip that logic for this case.

Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---

Differences v3->v4[1]:
 - Moved the optimization against pointless zext into the correct place:
   opt_subreg_zext_lo32_rnd_hi32 is called _after_ fixup_bpf_calls.

Differences v2->v3[1]:
 - Moved patching into fixup_bpf_calls (patch incoming to rename this function)
 - Added extra commentary on bpf_jit_needs_zext
 - Added check to avoid adding a pointless zext(r0) if there's already one there.

Difference v1->v2[1]: Now solved centrally in the verifier instead of
  specifically for the x86 JIT. Thanks to Ilya and Daniel for the suggestions!

[1] v3: https://lore.kernel.org/bpf/08669818-c99d-0d30-e1db-53160c063611@iogearbox.net/T/#t
    v2: https://lore.kernel.org/bpf/08669818-c99d-0d30-e1db-53160c063611@iogearbox.net/T/#t
    v1: https://lore.kernel.org/bpf/d7ebaefb-bfd6-a441-3ff2-2fdfe699b1d2@iogearbox.net/T/#t

 kernel/bpf/core.c                             |  4 +++
 kernel/bpf/verifier.c                         | 33 +++++++++++++++++--
 .../selftests/bpf/verifier/atomic_cmpxchg.c   | 25 ++++++++++++++
 .../selftests/bpf/verifier/atomic_or.c        | 26 +++++++++++++++
 4 files changed, 86 insertions(+), 2 deletions(-)

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
index 3d34ba492d46..ec1cbd565140 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11061,8 +11061,16 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 			 */
 			if (WARN_ON(!(insn.imm & BPF_FETCH)))
 				return -EINVAL;
-			load_reg = insn.imm == BPF_CMPXCHG ? BPF_REG_0
-							   : insn.src_reg;
+			/* There should already be a zero-extension inserted after BPF_CMPXCHG. */
+			if (insn.imm == BPF_CMPXCHG) {
+				struct bpf_insn *next = &insns[adj_idx + 1];
+
+				if (WARN_ON(!insn_is_zext(next) || next->dst_reg != insn.src_reg))
+					return -EINVAL;
+				continue;
+			}
+
+			load_reg = insn.src_reg;
 		} else {
 			load_reg = insn.dst_reg;
 		}
@@ -11666,6 +11674,27 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
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
+			struct bpf_insn zext_patch[2] = { *insn, BPF_ZEXT_REG(BPF_REG_0) };
+
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

base-commit: 7b1e385c9a488de9291eaaa412146d3972e9dec5
--
2.30.0.617.g56c4b15f3c-goog

