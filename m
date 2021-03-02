Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46EE32B324
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbhCCDrW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1838441AbhCBKyp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 05:54:45 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30996C061756
        for <bpf@vger.kernel.org>; Tue,  2 Mar 2021 02:54:04 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id o14so3489376qvn.18
        for <bpf@vger.kernel.org>; Tue, 02 Mar 2021 02:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=UaL/obIV/vl3QgVaAAc0Jkk0RlY66nUKoXeA4xxLVu4=;
        b=stKAlQwkY9TWIzC6VN0GZc6EMeWJFR8vro6Q6cJSYkyYdjh1uORi1uZfZK86P4ZuoR
         it9k4u0WRwmY1E7vV/BhYN+YnBDD6GLu0AbDn3znlnlnvcdMZNunCmyEbTf9mu1791ts
         TmQMK7bjPDlEvBf7rnmNx7ExIpcuIFp9GymkSND5Fs013wc2wdD2J/V58R0bkX3HMo5A
         PBQU24Y7ZMsQRAHeG8ydKDXCEJi50qmWvdJb4FwxW1bieuln0gwfkcEgkeehjwYHnCJ2
         gaDqURDv8oDS1QqGzuUns1Vuknr0tfuCXBvR1vTiDBW3QCqut1MFkpRJHSSqUWmNylP3
         Mhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=UaL/obIV/vl3QgVaAAc0Jkk0RlY66nUKoXeA4xxLVu4=;
        b=q20eCcIPrL9b27v9F6BcVDa776AlHlFqC+A1tmwIo6LOssLbDFxqUYstO/gGc+fdWI
         rXvLbyacmxri1gWbNu/YPd455wQ1Ns3u15FBdmsQEllLA1HvXROr7G3PfLUPE4hOBCrP
         vRlTN8IGfYG/tK2u5dAvghRCDTStkoD6BsfbIczofvbVrPdW1YXUrLMUv7hrW/Ra7HFD
         bBwD4cdFwby+ButKuAev8Q6AzKyFVf5xqKbBNFNUszE+FEfCzqzF/n8BKYct3H7+RUWg
         YSQ+imq6/MNzTibmIz1U1Ex3ucGPfUy6QCYuVn4C2Gk/tKFovzrreQE+L5k+ro4FuVmA
         E43g==
X-Gm-Message-State: AOAM531jiD2wMZVNx/aJhE+sfGfACrFgJ7zKZ3kkKncNwvJBbPBa3cxA
        FTpn/4rZhxkpaj4bLuC2VJhoSVhzU/WKv9P9D53pMCqnFv/QKxORUh8AOuyw/l0i7XKZ3JpbbnE
        c8gWy6FHIGIVQiiPrX7kAwQuTs+Sp+uSbIMl25jstA2o+pdIK+akB5n08A7fdjnE=
X-Google-Smtp-Source: ABdhPJysfS7KEAAsNV4JRENXYMOWvT0ppdfdX7LOfkl2PLTKNlfQbXLWafjoNYKw9KZevZWhjHHYoMtKKrzwjQ==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:6214:7cd:: with SMTP id
 bb13mr3068402qvb.7.1614682443510; Tue, 02 Mar 2021 02:54:03 -0800 (PST)
Date:   Tue,  2 Mar 2021 10:54:00 +0000
Message-Id: <20210302105400.3112940-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v5 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit cmpxchg
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Martin KaFai Lau <kafai@fb.com>,
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


Differences v4->v5[1]:
 - Moved the logic entirely into opt_subreg_zext_lo32_rnd_hi32, thanks to Martin
   for suggesting this.

Differences v3->v4[1]:
 - Moved the optimization against pointless zext into the correct place:
   opt_subreg_zext_lo32_rnd_hi32 is called _after_ fixup_bpf_calls.

Differences v2->v3[1]:
 - Moved patching into fixup_bpf_calls (patch incoming to rename this function)
 - Added extra commentary on bpf_jit_needs_zext
 - Added check to avoid adding a pointless zext(r0) if there's already one there.

Difference v1->v2[1]: Now solved centrally in the verifier instead of
  specifically for the x86 JIT. Thanks to Ilya and Daniel for the suggestions!

[1] v4: https://lore.kernel.org/bpf/CA+i-1C3ytZz6FjcPmUg5s4L51pMQDxWcZNvM86w4RHZ_o2khwg@mail.gmail.com/T/#t
    v3: https://lore.kernel.org/bpf/08669818-c99d-0d30-e1db-53160c063611@iogearbox.net/T/#t
    v2: https://lore.kernel.org/bpf/08669818-c99d-0d30-e1db-53160c063611@iogearbox.net/T/#t
    v1: https://lore.kernel.org/bpf/d7ebaefb-bfd6-a441-3ff2-2fdfe699b1d2@iogearbox.net/T/#t


 kernel/bpf/core.c                             |  4 +++
 kernel/bpf/verifier.c                         | 17 +++++++++++-
 .../selftests/bpf/verifier/atomic_cmpxchg.c   | 25 ++++++++++++++++++
 .../selftests/bpf/verifier/atomic_or.c        | 26 +++++++++++++++++++
 4 files changed, 71 insertions(+), 1 deletion(-)

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
index 4c373589273b..37076e4c6175 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11237,6 +11237,11 @@ static int opt_remove_nops(struct bpf_verifier_env *env)
 	return 0;
 }

+static inline bool is_cmpxchg(struct bpf_insn *insn)
+{
+	return (BPF_MODE(insn->code) == BPF_ATOMIC && insn->imm == BPF_CMPXCHG);
+}
+
 static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 					 const union bpf_attr *attr)
 {
@@ -11296,7 +11301,17 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 			goto apply_patch_buffer;
 		}

-		if (!bpf_jit_needs_zext())
+		/* Add in an zero-extend instruction if a) the JIT has requested
+		 * it or b) it's a CMPXCHG.
+		 *
+		 * The latter is because: BPF_CMPXCHG always loads a value into
+		 * R0, therefore always zero-extends. However some archs'
+		 * equivalent instruction only does this load when the
+		 * comparison is successful. This detail of CMPXCHG is
+		 * orthogonal to the general zero-extension behaviour of the
+		 * CPU, so it's treated independently of bpf_jit_needs_zext.
+		 */
+		if (!bpf_jit_needs_zext() && !is_cmpxchg(&insn))
 			continue;

 		if (WARN_ON_ONCE(load_reg == -1)) {
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

base-commit: f2cfe32e8a965a86e512dcb2e6251371d4a60c63
--
2.30.1.766.gb4fecdf3b7-goog

