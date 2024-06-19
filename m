Return-Path: <bpf+bounces-32481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 588D890E131
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 03:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A739AB22344
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 01:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A09363D0;
	Wed, 19 Jun 2024 01:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTSsK88r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78577AD24
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 01:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718759945; cv=none; b=mUYrj+zw+7WNAGLMrTZ0EaAZpu5d5jPlwSLmQaewkyY4XHiSpDbHS3YVCGQsQKtZjp4N7nYaxC+vTB7BgSVEo4Cd1tUxKQPXSeO4PmLrpSZRXueGepCiYeFhACuN/+bCpg5vqcqoJR17oodajFSjGDvtbuD4tTlynsb6ACQhjf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718759945; c=relaxed/simple;
	bh=e77DLA6028b5BFSlWHf0akYiSkNdRn8Vh/5Kd5rGLHk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OqLf+SLhRbXnbpxyKG6yNRwUzNV/d2V6PgY9flNdYC5ztzxErwbBUe9RShI2DEncfzzFUFhulxV1O9xcsC1FrZX7i4EQWuewc+UQadEEcb6CUzSz22jDQNoEqgorEbmCfXdeVbULbYiNBI5wyXey3NHzr7sTyAruryqi+6wJIbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTSsK88r; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f70131063cso48273245ad.2
        for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 18:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718759943; x=1719364743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QZ9KPcIDP6RbgStz4eZd0IPK1X0gzFYWhtvhEBA6rSs=;
        b=GTSsK88r5dfidz7VbSqcxJWRHJ99jYR3Z/+MqUn5XZ4kCe6WBD/r+b1S0F70I2pm7/
         o5lC1YR3kgAEdK676arnDJFgR1IOAz+2BsSEY1i6qqRj/qLjaJCgd2Q28knlud7Iittp
         ljP6K6Wbp33JfsuMDqsuif88oFaH6lIGPY+SDfiNfiBVkiKJSa+e9xQxYSNXxu1fb7km
         rUNTAMlhpGcHlWJeP27KWgs8dgzxa04h+veDLAf7VQBH9NVrJmkeGWHKK/FXTwvA7rpw
         tMFn1waszI7ggd9yzYDAPCuIuZOTH6ZQcosDxQr9MMpZGo/JSeyVFsC8Q5b8iVO1xJxH
         FWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718759943; x=1719364743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZ9KPcIDP6RbgStz4eZd0IPK1X0gzFYWhtvhEBA6rSs=;
        b=njcPnwjo23OhUuChWi7HMlIaLs/0JxODGzP/JQ+maR1D80rvi8RRKKHO9kVav1CoBO
         FQqEhOSpUEYiVb14rFXI8m/Mngz10f04UASytmAY+gmDr29Reym9F//D2LET9yLAOvRA
         qdR9Kkon6Z5u93S2oSQyoxhFPf+GE9B/tcxEArXZG2azNcvEXafcalo2NuebxzHQDkLC
         r23OOA8GkEq+MtgrWJx/dm3/sH5qYZo6Lv1D+/+Z+7METRXNkq+FsSc7W5AZyQuQPiY6
         Jdafhq9jtY6vQVpF6Oy3567QNegP0lIsCaPvRvt2yd/rjA0oLuBAA9LOBZ3cBYUyLSO2
         LoGA==
X-Gm-Message-State: AOJu0Yzf0Ng/PiWNJY1rNpvsioGkh21joXMmTaXLDh72MyKmOgAVt6f2
	cO2M+P85Z5eIdr/QJ5clndmP/+eK4/X4kEnKsjnUv/o7U454bJgVCA1OSg==
X-Google-Smtp-Source: AGHT+IGJvYPOhPbT8Qo+SEdTUmgD+I5iku4UE3wraugyMT3fi/GzmbSK3mx0LVQg3QZC/lW/T3DF6g==
X-Received: by 2002:a17:902:d4c7:b0:1f7:17c2:118b with SMTP id d9443c01a7336-1f9aa3e9e49mr12391995ad.27.1718759942846;
        Tue, 18 Jun 2024 18:19:02 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:fc92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f99d3fb36dsm16955985ad.186.2024.06.18.18.19.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Jun 2024 18:19:02 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	zacecob@protonmail.com,
	kernel-team@fb.com
Subject: [PATCH v2 bpf 1/2] bpf: Fix the corner case with may_goto and jump to the 1st insn.
Date: Tue, 18 Jun 2024 18:18:58 -0700
Message-Id: <20240619011859.79334-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

When the following program is processed by the verifier:
L1: may_goto L2
    goto L1
L2: w0 = 0
    exit

the may_goto insn is first converted to:
L1: r11 = *(u64 *)(r10 -8)
    if r11 == 0x0 goto L2
    r11 -= 1
    *(u64 *)(r10 -8) = r11
    goto L1
L2: w0 = 0
    exit

then later as the last step the verifier inserts:
  *(u64 *)(r10 -8) = BPF_MAX_LOOPS
as the first insn of the program to initialize loop count.

When the first insn happens to be a branch target of some jmp the
bpf_patch_insn_data() logic will produce:
L1: *(u64 *)(r10 -8) = BPF_MAX_LOOPS
    r11 = *(u64 *)(r10 -8)
    if r11 == 0x0 goto L2
    r11 -= 1
    *(u64 *)(r10 -8) = r11
    goto L1
L2: w0 = 0
    exit

because instruction patching adjusts all jmps and calls, but for this
particular corner case it's incorrect and the L1 label should be one
instruction down, like:
    *(u64 *)(r10 -8) = BPF_MAX_LOOPS
L1: r11 = *(u64 *)(r10 -8)
    if r11 == 0x0 goto L2
    r11 -= 1
    *(u64 *)(r10 -8) = r11
    goto L1
L2: w0 = 0
    exit

and that's what this patch is fixing.
After bpf_patch_insn_data() call adjust_jmp_off() to adjust all jmps
that point to newly insert BPF_ST insn to point to insn after.

Note that bpf_patch_insn_data() cannot easily be changed to accommodate
this logic, since jumps that point before or after a sequence of patched
instructions have to be adjusted with the full length of the patch.

Conceptually it's somewhat similar to "insert" of instructions between other
instructions with weird semantics. Like "insert" before 1st insn would require
adjustment of CALL insns to point to newly inserted 1st insn, but not an
adjustment JMP insns that point to 1st, yet still adjusting JMP insns that
cross over 1st insn (point to insn before or insn after), hence use simple
adjust_jmp_off() logic to fix this corner case. Ideally bpf_patch_insn_data()
would have an auxiliary info to say where 'the start of newly inserted patch
is', but it would be too complex for backport.

Reported-by: Zac Ecob <zacecob@protonmail.com>
Closes: https://lore.kernel.org/bpf/CAADnVQJ_WWx8w4b=6Gc2EpzAjgv+6A0ridnMz2TvS2egj4r3Gw@mail.gmail.com/
Fixes: 011832b97b31 ("bpf: Introduce may_goto instruction")
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 50 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e0a398a97d32..5586a571bf55 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12721,6 +12721,16 @@ static bool signed_add32_overflows(s32 a, s32 b)
 	return res < a;
 }
 
+static bool signed_add16_overflows(s16 a, s16 b)
+{
+	/* Do the add in u16, where overflow is well-defined */
+	s16 res = (s16)((u16)a + (u16)b);
+
+	if (b < 0)
+		return res > a;
+	return res < a;
+}
+
 static bool signed_sub_overflows(s64 a, s64 b)
 {
 	/* Do the sub in u64, where overflow is well-defined */
@@ -18732,6 +18742,39 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
 	return new_prog;
 }
 
+/*
+ * For all jmp insns in a given 'prog' that point to 'tgt_idx' insn adjust the
+ * jump offset by 'delta'.
+ */
+static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta)
+{
+	struct bpf_insn *insn = prog->insnsi;
+	u32 insn_cnt = prog->len, i;
+
+	for (i = 0; i < insn_cnt; i++, insn++) {
+		u8 code = insn->code;
+
+		if ((BPF_CLASS(code) != BPF_JMP && BPF_CLASS(code) != BPF_JMP32) ||
+		    BPF_OP(code) == BPF_CALL || BPF_OP(code) == BPF_EXIT)
+			continue;
+
+		if (insn->code == (BPF_JMP32 | BPF_JA)) {
+			if (i + 1 + insn->imm != tgt_idx)
+				continue;
+			if (signed_add32_overflows(insn->imm, delta))
+				return -ERANGE;
+			insn->imm += delta;
+		} else {
+			if (i + 1 + insn->off != tgt_idx)
+				continue;
+			if (signed_add16_overflows(insn->imm, delta))
+				return -ERANGE;
+			insn->off += delta;
+		}
+	}
+	return 0;
+}
+
 static int adjust_subprog_starts_after_remove(struct bpf_verifier_env *env,
 					      u32 off, u32 cnt)
 {
@@ -20548,6 +20591,13 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		if (!new_prog)
 			return -ENOMEM;
 		env->prog = prog = new_prog;
+		/*
+		 * If may_goto is a first insn of a prog there could be a jmp
+		 * insn that points to it, hence adjust all such jmps to point
+		 * to insn after BPF_ST that inits may_goto count.
+		 * Adjustment will succeed because bpf_patch_insn_data() didn't fail.
+		 */
+		WARN_ON(adjust_jmp_off(env->prog, subprog_start, 1));
 	}
 
 	/* Since poke tab is now finalized, publish aux to tracker. */
-- 
2.43.0


