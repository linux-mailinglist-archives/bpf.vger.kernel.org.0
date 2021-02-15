Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BBC31C038
	for <lists+bpf@lfdr.de>; Mon, 15 Feb 2021 18:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhBORNO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Feb 2021 12:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbhBORMz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Feb 2021 12:12:55 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3887C061574
        for <bpf@vger.kernel.org>; Mon, 15 Feb 2021 09:12:15 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id b125so2732514qkf.19
        for <bpf@vger.kernel.org>; Mon, 15 Feb 2021 09:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=AdXasaDzn6aBUh486v66coR52m5c40x50FUPTwcwjnk=;
        b=FmmQSa+QIfOn4nkWJ33Z3+R4n1YzoTHtWGzbrj1oKT1nEdamJAqZ2zlMN1LEmjQwEM
         3TnCKu0FcC5pl5Ru2XMmF3odwUWOXkE2cPVVUcpBeEFRDKih9AbDzaTv95mQ+p5OmKqD
         IwizU7pGeo7riIjc8ud6Edq475yY5gxUMRw3SNqQsqlm1KgPlMMfJ6vU/dQL0nCLZutd
         LgGPeoclBzSLqBmsz1ZXsQl0xQ1h9PA035qzMjOQcEYOnkbWR5FlzUl8+Xq9xkA4fQAR
         18oaiEbkAye2SdwKmF3lLPKzoSsrltJQJ8AWm46z1jGbNeVZld9iqpIq1/ZgNGBHY6iI
         Imiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=AdXasaDzn6aBUh486v66coR52m5c40x50FUPTwcwjnk=;
        b=C411EO5/KlWB0kzuW9LsNZ838FAN06/ZgCoWxKZe+ElR4QQJLlZgzuwMBkgzD0qtOG
         F1v3rS2igJgFZmVEwEghfmsDy9XaKqj92FnzwqxJnwT48osiZfFaaeuAXtCU5Z1LOe0x
         hGCYdWJkWOKDvXVp+SjLJtXsr+3YfWaIyJw064JeslgegNTIEPH9j3pPQnmK1v66rPMh
         vJEJ+xI+TWUCGnStOavC+S4e9mKo2xYeyAMtMUr/JOOd6h5s7V3xCOfrYcWBIOS+1OeS
         sjLOCGa7myvR3IFERd5WckWLXJduNp6cL7dNvuHnShJvii+FxhuJ5SQZqumsPYZnZKFU
         tF1Q==
X-Gm-Message-State: AOAM531aDmVMWePz1c/sqYdl1DmGvKDdgS6gmjpsY/f+hs6NM2vftRgl
        450V5qOmxgNZFRwEBh52KqDBr7glRcplIjc8ByGAXvunlnHzPlkdzTacYvZ7Yg2GPYzzU0c5shj
        z3PDCPkJ6y4g240AiwmYSdppbRemw+M4UDubBpK91eCucSPDQzm+sMlwrbTgCgNk=
X-Google-Smtp-Source: ABdhPJwV/Dt/xFxO4X9kJNyvquI20VIBstxV7L7UEEmAZFpLLrfHlKRhkpRiWM0R54MCf4eXEGICJSdSXmRtZg==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a0c:a282:: with SMTP id
 g2mr4912313qva.14.1613409134928; Mon, 15 Feb 2021 09:12:14 -0800 (PST)
Date:   Mon, 15 Feb 2021 17:12:08 +0000
Message-Id: <20210215171208.1181305-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH bpf-next] bpf: x86: Explicitly zero-extend rax after 32-bit cmpxchg
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
value in memory are different.

At first this might sound like pure semantics, but it makes a real
difference when the comparison is 32-bit, since the load will
zero-extend r0/rax.

The fix is to explicitly zero-extend rax after doing such a CMPXCHG.

Note that this doesn't generate totally optimal code: at one of
emit_atomic's callsites (where BPF_{AND,OR,XOR} | BPF_FETCH are
implemented), the new mov is superfluous because there's already a
mov generated afterwards that will zero-extend r0. We could avoid
this unnecessary mov by just moving the new logic outside of
emit_atomic. But I think it's simpler to keep emit_atomic as a unit
of correctness (it generates the correct x86 code for a certain set
of BPF instructions, no further knowledge is needed to use it
correctly).

Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/net/bpf_jit_comp.c                   | 10 +++++++
 .../selftests/bpf/verifier/atomic_cmpxchg.c   | 25 ++++++++++++++++++
 .../selftests/bpf/verifier/atomic_or.c        | 26 +++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 79e7a0ec1da5..7919d5c54164 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -834,6 +834,16 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
 
 	emit_insn_suffix(&prog, dst_reg, src_reg, off);
 
+	if (atomic_op == BPF_CMPXCHG && bpf_size == BPF_W) {
+		/*
+		 * BPF_CMPXCHG unconditionally loads into R0, which means it
+		 * zero-extends 32-bit values. However x86 CMPXCHG doesn't do a
+		 * load if the comparison is successful. Therefore zero-extend
+		 * explicitly.
+		 */
+		emit_mov_reg(&prog, false, BPF_REG_0, BPF_REG_0);
+	}
+
 	*pprog = prog;
 	return 0;
 }
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
index 70f982e1f9f0..e0811eb11542 100644
--- a/tools/testing/selftests/bpf/verifier/atomic_or.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_or.c
@@ -75,3 +75,29 @@
 	},
 	.result = ACCEPT,
 },
+{
+	"BPF_W atomic or should zero top 32 bits",
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

base-commit: 5e1d40b75ed85ecd76347273da17e5da195c3e96
-- 
2.30.0.478.g8a0d178c01-goog

