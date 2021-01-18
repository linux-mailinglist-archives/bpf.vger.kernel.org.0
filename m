Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5AD52FA59C
	for <lists+bpf@lfdr.de>; Mon, 18 Jan 2021 17:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392545AbhARQHO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jan 2021 11:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392145AbhARQHJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jan 2021 11:07:09 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39483C061757
        for <bpf@vger.kernel.org>; Mon, 18 Jan 2021 08:06:29 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id 5so1712895wmq.0
        for <bpf@vger.kernel.org>; Mon, 18 Jan 2021 08:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=fseQZC2z3/hCn+AUW1qbQoNHcJK9F6WJRE0sDWzBE4A=;
        b=lgK97nkynzgkiD2qXBqtYzFJxHbCDUgmNAo31Abw6d3x05grRmNMS8BgLa2UHOkDjI
         wZLRZrAkZCksg8LnP1eMeeSIX2np8Ulju/rlSegTHoeNrwH8hhF9kixm/0+DqpEHSib3
         pA6q7LD9aU2WbmwOX/Zid/xD6f0bc8eLpRqT3W7+Pb0gMO5j0kdpmYEXARQ6RJ04zOjn
         BPWBPaZNml4GgIt955DUlhzIB5Q9HQQ3DPrDtWjBk7MjLIdLVt8CpH5K5mn8DzY5Ohiq
         sFXCWbuwAaF1YwmkuccvaiOgRFNJoAydgj5VFQ7RC0bb2r5PwCv1A9Q41cOB0hYnlfR0
         lH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=fseQZC2z3/hCn+AUW1qbQoNHcJK9F6WJRE0sDWzBE4A=;
        b=fASsMaNz3pAC+Ww98rTIIp9kVbsIlLwQXlglV6pVh0KrgwU1jp7KOX2QjqYlxEwYMI
         +2ao0e2cHU018CZRDJaaCmqcNQqHKlZzbNq2nFcEfFq+ddvTMQh+j8JAGRhvJnT/alVP
         agltUMu2cWhCqd5BxXxUCU+RmhyMmLi8sCdpydaLL+7kDQ8Dao43RUr/zVn8Z9NTraZh
         Ft8nWRRgxlnQDKqheY69VVBH1aU7T8+xkpl86AGKlaeDJbK/l/7/4M8D1S2UnZWDKwv7
         6Nzxp2F1Gj66ONujDKZ59+RRxcnG96xA8LvIeJINwTw7RKZZGj61507vpXAarj9fmw99
         n6UA==
X-Gm-Message-State: AOAM532Gxa3eeEZH3ArPxSPZhjthYYdbzQui/5llAKAic6qRmgdxuPaJ
        DiPlgwyvj2PR7+OYI40Imqj1GnG12x0F1Y0GlEbKfWNDJVib46hC5g66q1mEBwWrNT4RQQyI4XN
        dl5sXXDDYIldscdKVyJlofY+gsOfrj2RXK/oOyo07/YYxR5iAiE8UjoUM+Z78DXw=
X-Google-Smtp-Source: ABdhPJyshsLFlpro9xgpb1Vpx6VuTaHda/g+0PitiNDQWtVpGTWdH8A2NGf8+6lRdmeWUbfmCEBtDwwohqohFA==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a7b:c044:: with SMTP id
 u4mr59238wmc.1.1610985987578; Mon, 18 Jan 2021 08:06:27 -0800 (PST)
Date:   Mon, 18 Jan 2021 16:06:13 +0000
Message-Id: <20210118160613.541020-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next] bpf: Propagate memory bounds to registers in atomics
 w/ BPF_FETCH
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When BPF_FETCH is set, atomic instructions load a value from memory
into a register. The current verifier code first checks via
check_mem_access whether we can access the memory, and then checks
via check_reg_arg whether we can write into the register.

For loads, check_reg_arg has the side-effect of marking the
register's value as unkonwn, and check_mem_access has the side effect
of propagating bounds from memory to the register.

Therefore with the current order, bounds information is thrown away,
but by simply reversing the order of check_reg_arg
vs. check_mem_access, we can instead propagate bounds smartly.

A simple test is added with an infinite loop that can only be proved
unreachable if this propagation is present.

Note that in the test, the memory value has to be written with two
instructions:

		BPF_MOV64_IMM(BPF_REG_0, 0),
		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),

instead of one:

		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),

Because BPF_ST_MEM doesn't seem to set the stack slot type to 0 when
storing an immediate.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 kernel/bpf/verifier.c                         | 32 +++++++++++--------
 .../selftests/bpf/verifier/atomic_bounds.c    | 18 +++++++++++
 2 files changed, 36 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_bounds.c

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0f82d5d46e2c..0512695c70f4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3663,9 +3663,26 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 		return -EACCES;
 	}
 
+	if (insn->imm & BPF_FETCH) {
+		if (insn->imm == BPF_CMPXCHG)
+			load_reg = BPF_REG_0;
+		else
+			load_reg = insn->src_reg;
+
+		/* check and record load of old value */
+		err = check_reg_arg(env, load_reg, DST_OP);
+		if (err)
+			return err;
+	} else {
+		/* This instruction accesses a memory location but doesn't
+		 * actually load it into a register.
+		 */
+		load_reg = -1;
+	}
+
 	/* check whether we can read the memory */
 	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
-			       BPF_SIZE(insn->code), BPF_READ, -1, true);
+			       BPF_SIZE(insn->code), BPF_READ, load_reg, true);
 	if (err)
 		return err;
 
@@ -3675,19 +3692,6 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	if (err)
 		return err;
 
-	if (!(insn->imm & BPF_FETCH))
-		return 0;
-
-	if (insn->imm == BPF_CMPXCHG)
-		load_reg = BPF_REG_0;
-	else
-		load_reg = insn->src_reg;
-
-	/* check and record load of old value */
-	err = check_reg_arg(env, load_reg, DST_OP);
-	if (err)
-		return err;
-
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/verifier/atomic_bounds.c b/tools/testing/selftests/bpf/verifier/atomic_bounds.c
new file mode 100644
index 000000000000..45030165ed63
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/atomic_bounds.c
@@ -0,0 +1,18 @@
+{
+	"BPF_ATOMIC bounds propagation, mem->reg",
+	.insns = {
+		/* a = 0; */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
+		/* b = atomic_fetch_add(&a, 1); */
+		BPF_MOV64_IMM(BPF_REG_1, 1),
+		BPF_ATOMIC_OP(BPF_DW, BPF_ADD | BPF_FETCH, BPF_REG_10, BPF_REG_1, -8),
+		/* Verifier should be able to tell that this infinite loop isn't reachable. */
+		/* if (b) while (true) continue; */
+		BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, -1),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "back-edge",
+},

base-commit: 232164e041e925a920bfd28e63d5233cfad90b73
-- 
2.30.0.284.gd98b1dd5eaa7-goog

