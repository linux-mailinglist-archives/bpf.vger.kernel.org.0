Return-Path: <bpf+bounces-32425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B3890DBD2
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 20:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2ADAB2110F
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 18:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CD915ECC9;
	Tue, 18 Jun 2024 18:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJ3BvCgz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E8813B5B8
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718736145; cv=none; b=IHSLpcqjidtrMfISUYxBm0w/zme8Qa/VqomhQEWQSL4kDgSBRR1lO4QGD1bJaM5VXpQqeyk2XJjLyLGIS6MzGmTw+f9v8gFzFmNrPOIKHYjJ3wNBCMX2Uu01rk1uweF005fgZCbjC/dn0QndyWU467C+iAQNVfIalYHJXRF49vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718736145; c=relaxed/simple;
	bh=IwNwD4BfI4Aws5zmxL5SenLaoapWzggGWYQ//LawsUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TPoN6f5et+8MZ/WKP2+Dg3HsXgv1CtM11AbOstOFHvrkUBcTl3p77fDPXNSjTzllwQirmr47KMIYa781yoa390bEX3Eggi/Rkq83f+2NRNvbOdSvM+Ldlifq915gQRfVUIemoA2sNgrTGvWAFSqwT6J0DgzQ+OXFP2kxz8jnMKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJ3BvCgz; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7046211e455so4176880b3a.3
        for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 11:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718736143; x=1719340943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q9xBZQea3q38Pq0Yhk15FO2OpQj3OGzC8yq3o7xBjWA=;
        b=SJ3BvCgzgIETc6intPO3EjCDtS2qYU2frQWdEpjxY6paSbS9RqAY64VbLNOpGlr42p
         HY2d4VNBSBcBie+Fkjo4bsB8msTaU9dydaLhkI+GKswkTnkvq5COkBF0EoT/Q+y2sU5R
         J+3yRLvTto5CySyhGntKHPIpx9zhGh8CyJg+dJCZhznzF2Z9aLJbqD85gBvPFt+Yj3tx
         VhlTsQnhIfNMYD3iZje54W/lFCxU2JMXaKCac2RVA0W+gB9CSXNeNwJQIaqvDkdp3ik0
         XdUlHIrTs1aBjPxjIaZWlAYG/6csgqaicbYqB9al7p31SYMWqCdr+d5U+Z7xlWfPMAPC
         YsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718736143; x=1719340943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9xBZQea3q38Pq0Yhk15FO2OpQj3OGzC8yq3o7xBjWA=;
        b=PhBlXtk36Z0co0P5IMcYwXTBR/gK85/Q2lIOz/V4fN6DMguAFdjPSeMUGc3Q378KID
         Thi3jI5sGOOs6ijGu0RPrjKhNrd7vCb4+kTFLLNWwPKdgMU67oPhEdJmLAtkGPCCeRwu
         TrCMXujoeQrMr+/KKJn4vFgI6XAadHn0Hvoqgyrxzz4PAlVeWJv7QmObGyugZkErWx3C
         kLor+IOwMK926Yi3+Va/lJ8d+Zu86pquvvGsA9xi5v998MuwbhTUyjQdt9XEnKcwqTr2
         dI2V+DbxSVcQhT/e6ExiHe3Ajq567H/KEO1LMHI/bQwMIyCqgeboDl60uSRSE+KGE4VV
         RI0Q==
X-Gm-Message-State: AOJu0YyhgW9STj85ZRd+uqZvN6wPIbjjK3M0syqOg2U7ZSUHCkRqZait
	Efw+j/T9tA0iKcoDdBlXo69rpCxhswR2UFrJj7CgTXSMKgpNsVnEer4Wdg==
X-Google-Smtp-Source: AGHT+IFYXdkyUqlJS+XCuhBipkJwmZsugwUFAbO5mLUN14tyMse5kHyfuVL+xbNjALIX26DTL3N7rA==
X-Received: by 2002:a05:6a20:6a1a:b0:1af:a45a:a8de with SMTP id adf61e73a8af0-1bcbb3dccb7mr492206637.5.1718736142830;
        Tue, 18 Jun 2024 11:42:22 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::5:5466])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96ad04sm9295568b3a.64.2024.06.18.11.42.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Jun 2024 11:42:22 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	zacecob@protonmail.com,
	kernel-team@fb.com
Subject: [PATCH bpf 1/2] bpf: Fix the corner case where may_goto is a 1st insn.
Date: Tue, 18 Jun 2024 11:42:18 -0700
Message-Id: <20240618184219.20151-1-alexei.starovoitov@gmail.com>
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
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 51 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e0a398a97d32..2b8738160ce6 100644
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
@@ -18732,6 +18742,40 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
 	return new_prog;
 }
 
+/*
+ * For all jmp insns in a given 'prog' that point to 'tgt_idx' insn adjust the
+ * jump offset by 'delta'.
+ */
+static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta)
+{
+	struct bpf_insn *insn = prog->insnsi;
+	u32 insn_cnt = prog->len, idx, i;
+	int ret = 0;
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
@@ -20548,6 +20592,13 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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


