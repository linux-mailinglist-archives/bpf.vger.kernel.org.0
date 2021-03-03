Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852C832C16E
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347199AbhCCWn6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350759AbhCCLgS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 06:36:18 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE506C06178A
        for <bpf@vger.kernel.org>; Wed,  3 Mar 2021 03:04:06 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id l23so12002940edt.23
        for <bpf@vger.kernel.org>; Wed, 03 Mar 2021 03:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=L9NxHFlQycMA7jO714/5ybw/GslCpc0qFqitFFYyaT8=;
        b=mNiqlwG37F8/cqcFTt/EnGeWNc+MuaoyHGpU86CfGkQ/d7U6x/QZThmYMk4lqnkU8r
         s5xSJXfyMzgrLynFxAKcFNnB9nM6PEtYllSk+UmOp0on1gfdCHlaP+QIVYK3VWBEUum7
         D7+Fkzak8PTfUeD5Q/5CejGaAE5zDi2PF9OnAallxVT4T9grvHRGmby2zfpIElfu4jU8
         3eq+8annSLj/PL3/UPDZ/dNabfwZyOsyex/LVBBR/ZJepNkGPb0PCzdF1quZaPFgHjyE
         PRfVIxFVyEWCO2dciBnx0QwIINh1j2vUY6q5tJ233NnnUpHS06Uocdbqo1FgGgx581MU
         sxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=L9NxHFlQycMA7jO714/5ybw/GslCpc0qFqitFFYyaT8=;
        b=JiFYRj6lwb0rNMmz6Da0Qa1UDIyqM00OOQPfiK8uJHUjq8oLXRnARVwDso8mUcfMXT
         KwO2M1+7uxqGW9DJyFSUckHH7ovtYw70aHBcK7kTyqwU5bfGOPEFJZiSZWORNyp3WEz6
         2xOLAwCRHDKghh/D965D7czfsd1gqIgvOOOXejWmQt/L9REuR10SHdk0fpHk4YEgPz+c
         b4cVm10eydutvEBzB/1yUt/8rafXIL7ftvE8RGI6vJAUXrnByCRvDwHPLcCH62Duu4hb
         9HIZi7n3JfHpbRxsTiMbD3uDNEo1UcoIf6TmSMO8f1QQRtxDF4lxGEbM018WMwEMxF44
         YjCA==
X-Gm-Message-State: AOAM530Io1oDKwKzGlPIpJO8Uzs+h2GHHPg+nwuAROW4TG8mXauyqa0L
        AGP0HtlKRgfyWXJnc0PXYH9NAvXnMFZXzbL4TGWbjnugbAUdsjnpltZZ9ZPgbMsVe5UrRIg8rpx
        Qdwf4HTX884DO0o3ikYehf+ur5+/Z41PsYyq2zJlR2zFTIpRqiPzU6NDyyEdZxRc=
X-Google-Smtp-Source: ABdhPJzZH963UTgJJjL6A+74PQ2zYxR4QpVuWsAhgfXMd3QPxLtHoFvNQ5n8AQ2MALjM4W+JkhCxnvSyxzqmVQ==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a17:906:8408:: with SMTP id
 n8mr24242753ejx.152.1614769445223; Wed, 03 Mar 2021 03:04:05 -0800 (PST)
Date:   Wed,  3 Mar 2021 11:04:02 +0000
Message-Id: <20210303110402.3965626-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v6 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit cmpxchg
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

Note this still goes on top of Ilya's patch:

https://lore.kernel.org/bpf/20210301154019.129110-1-iii@linux.ibm.com/T/#u

Differences v5->v6[1]:
 - Moved is_cmpxchg_insn and ensured it can be safely re-used. Also renamed it
   and removed 'inline' to match the style of the is_*_function helpers.
 - Fixed up comments in verifier test (thanks for the careful review, Martin!)

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

[1] v5: https://lore.kernel.org/bpf/CA+i-1C3ytZz6FjcPmUg5s4L51pMQDxWcZNvM86w4RHZ_o2khwg@mail.gmail.com/T/#t
    v4: https://lore.kernel.org/bpf/CA+i-1C3ytZz6FjcPmUg5s4L51pMQDxWcZNvM86w4RHZ_o2khwg@mail.gmail.com/T/#t
    v3: https://lore.kernel.org/bpf/08669818-c99d-0d30-e1db-53160c063611@iogearbox.net/T/#t
    v2: https://lore.kernel.org/bpf/08669818-c99d-0d30-e1db-53160c063611@iogearbox.net/T/#t
    v1: https://lore.kernel.org/bpf/d7ebaefb-bfd6-a441-3ff2-2fdfe699b1d2@iogearbox.net/T/#t

 kernel/bpf/core.c                             |  4 +++
 kernel/bpf/verifier.c                         | 19 +++++++++++++-
 .../selftests/bpf/verifier/atomic_cmpxchg.c   | 25 +++++++++++++++++++
 .../selftests/bpf/verifier/atomic_or.c        | 25 +++++++++++++++++++
 4 files changed, 72 insertions(+), 1 deletion(-)

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
index 4c373589273b..ac800d1277f7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -531,6 +531,13 @@ static bool is_ptr_cast_function(enum bpf_func_id func_id)
 		func_id == BPF_FUNC_skc_to_tcp_request_sock;
 }

+static bool is_cmpxchg_insn(const struct bpf_insn *insn)
+{
+	return (BPF_CLASS(insn->code) == BPF_STX &&
+		BPF_MODE(insn->code) == BPF_ATOMIC &&
+		insn->imm == BPF_CMPXCHG);
+}
+
 /* string representation of 'enum bpf_reg_type' */
 static const char * const reg_type_str[] = {
 	[NOT_INIT]		= "?",
@@ -11296,7 +11303,17 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
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
+		if (!bpf_jit_needs_zext() && !is_cmpxchg_insn(&insn))
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
index 70f982e1f9f0..9d0716ac5080 100644
--- a/tools/testing/selftests/bpf/verifier/atomic_or.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_or.c
@@ -75,3 +75,28 @@
 	},
 	.result = ACCEPT,
 },
+{
+	"BPF_W atomic_fetch_or should zero top 32 bits",
+	.insns = {
+		/* r1 = U64_MAX; */
+		BPF_MOV64_IMM(BPF_REG_1, 0),
+		BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 1),
+		/* u64 val = r1; */
+		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
+		/* r1 = (u32)atomic_fetch_or((u32 *)&val, 2); */
+		BPF_MOV32_IMM(BPF_REG_1, 2),
+		BPF_ATOMIC_OP(BPF_W, BPF_OR | BPF_FETCH, BPF_REG_10, BPF_REG_1, -8),
+		/* r2 = 0x00000000FFFFFFFF; */
+		BPF_MOV64_IMM(BPF_REG_2, 1),
+		BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 32),
+		BPF_ALU64_IMM(BPF_SUB, BPF_REG_2, 1),
+		/* if (r2 != r1) exit(1); */
+		BPF_JMP_REG(BPF_JEQ, BPF_REG_2, BPF_REG_1, 2),
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

