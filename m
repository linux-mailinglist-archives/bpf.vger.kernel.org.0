Return-Path: <bpf+bounces-37625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2F1958463
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 12:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60BA284B62
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 10:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC18518FC8E;
	Tue, 20 Aug 2024 10:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lz9Rmnua"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A823318FC7E
	for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149464; cv=none; b=b3/ksF7shPMPZAqSaSbogSjIW/p7xvzlljgOLaEQqmtJuqhlglCKcDNr3FEBiGlEjhCPMekOa5K/I2jOfRjnlf92bY/SyHVNKxWJc2kXh4WvZu2JZ+1jtfTcZrFGVveTYJ1j4pvSis4hf4qLKIGegw3Y2EMnjQcIGmMlOKr8IYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149464; c=relaxed/simple;
	bh=sBsz/BF4EIAtMVTzSPH2fY/lwM1MNP6NBuFOQXELEXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6VmlLnMy0SSwop3akKW6b6MLrvGGlbgwLDzfQ81C81nfUnv5lXxDkYZ3NF2wbNfdPynzJ+/97P/fdiB+iFRCrx83AUK916iL6daNyr7OdAo6JqqC3bBtAGb5MHHdOCJxfv1uftjEnpfWIBlB8O3ppKurjonANaHgjoFRViRBbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lz9Rmnua; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7afd1aeac83so4181734a12.0
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 03:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724149462; x=1724754262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dix3ORoee+sfVX+vgLhY+ruQb6NILRgW8sq48cMvmzI=;
        b=Lz9RmnuagzlntkOoyXZilx1wYYhoJ556dt6EPw+xfAc6nYALgdjIBfi5EVVsjdeKCj
         LiTv0AQ2L/BskF0mzUaMoF+5S2fK2ojELjLYEr9gP/K3CCsf3bcFNQiWqw5JxpgWQpAg
         6jJ94jxeYW+MOKxSClipDYRWyKII/pVmNsDwW3/31u82J0UUKo/syMqzhvV4TPwRsaF+
         luW2t3BfOKMdVHWVfZ5Z0YispVDSTCJVHhx14hjQ0EX0beY7rI37ScNvT0XJwQdWMP6K
         CUXmNVotITJjp7vOzNm5GKNf1ZdXQ2OrSzqxxJEFQR2Gm3+WJEKpR7zNgUJUKlnEmqte
         sjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724149462; x=1724754262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dix3ORoee+sfVX+vgLhY+ruQb6NILRgW8sq48cMvmzI=;
        b=CkvxujZuwYzyoSiVKa6jqzdAgMEdCJstfrFlRxgQ+Y/kF22k8StOWOXcH1j60UQmBS
         QqPgsAM5kME/aKLfO8Ino1CSPtlydI2y1a+i8zrLoQ0yG5QtQGfJiyIQ/JJ2vYSHOh9J
         k+DxFQTHxvxLF0NVRZT5+Fks3HjJTtRhLuPSNSpZZDTdGKRLQaNzDwcriD4kSLKzA1a5
         Sk7FHTJTyVDolmlPrFYL5p4T4RqhutEFBjmq3M8vZx5I3kEp/rBYk9WAi+/ZoR41S7pi
         rkwn77crAfrnFnScRHKiC/M8TslX/62kJExBSWXjWhuU2QKoYBq7RzivIG26+hJwwt0G
         W3OA==
X-Gm-Message-State: AOJu0YwV59pDZvUDWXVSlWVhxFYflbIYMHZsbESntKeDVJVKs5iCwxC1
	WQwdSa7rmHnrITrII5RKjHnbtaagGRdISlKQ89zisJHHCOekR/C76Nk/9wsK
X-Google-Smtp-Source: AGHT+IFboRhfFfK6sJveLRpVelQkD6+XJdENs+Gn/oPH59+dGvFKuW1xBnfWwFhvBluRj+6b3g61lQ==
X-Received: by 2002:a17:90b:38c7:b0:2c7:49b4:7e3a with SMTP id 98e67ed59e1d1-2d47321a170mr3591956a91.7.1724149461615;
        Tue, 20 Aug 2024 03:24:21 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3174bfdsm8976166a91.27.2024.08.20.03.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 03:24:21 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	hffilwlqm@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 8/8] selftests/bpf: validate __xlated same way as __jited
Date: Tue, 20 Aug 2024 03:23:57 -0700
Message-ID: <20240820102357.3372779-10-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240820102357.3372779-1-eddyz87@gmail.com>
References: <20240820102357.3372779-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both __xlated and __jited work with disassembly.
It is logical to have both work in a similar manner.

This commit updates __xlated macro handling in test_loader.c by making
it expect matches on sequential lines, same way as __jited operates.
For example:

    __xlated("1: *(u64 *)(r10 -16) = r1")      ;; matched on line N
    __xlated("3: r0 = &(void __percpu *)(r0)") ;; matched on line N+1

Also:

    __xlated("1: *(u64 *)(r10 -16) = r1")      ;; matched on line N
    __xlated("...")                            ;; not matched
    __xlated("3: r0 = &(void __percpu *)(r0)") ;; mantched on any
                                               ;; line >= N

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_nocsr.c      | 53 ++++++++++++++++++-
 tools/testing/selftests/bpf/test_loader.c     |  8 ++-
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_nocsr.c b/tools/testing/selftests/bpf/progs/verifier_nocsr.c
index a7fe277e5167..666c736d196f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_nocsr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_nocsr.c
@@ -78,6 +78,7 @@ __naked void canary_arm64_riscv64(void)
 SEC("raw_tp")
 __arch_x86_64
 __xlated("1: r0 = &(void __percpu *)(r0)")
+__xlated("...")
 __xlated("3: exit")
 __success
 __naked void canary_zero_spills(void)
@@ -94,7 +95,9 @@ SEC("raw_tp")
 __arch_x86_64
 __log_level(4) __msg("stack depth 16")
 __xlated("1: *(u64 *)(r10 -16) = r1")
+__xlated("...")
 __xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("...")
 __xlated("5: r2 = *(u64 *)(r10 -16)")
 __success
 __naked void wrong_reg_in_pattern1(void)
@@ -113,7 +116,9 @@ __naked void wrong_reg_in_pattern1(void)
 SEC("raw_tp")
 __arch_x86_64
 __xlated("1: *(u64 *)(r10 -16) = r6")
+__xlated("...")
 __xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("...")
 __xlated("5: r6 = *(u64 *)(r10 -16)")
 __success
 __naked void wrong_reg_in_pattern2(void)
@@ -132,7 +137,9 @@ __naked void wrong_reg_in_pattern2(void)
 SEC("raw_tp")
 __arch_x86_64
 __xlated("1: *(u64 *)(r10 -16) = r0")
+__xlated("...")
 __xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("...")
 __xlated("5: r0 = *(u64 *)(r10 -16)")
 __success
 __naked void wrong_reg_in_pattern3(void)
@@ -151,7 +158,9 @@ __naked void wrong_reg_in_pattern3(void)
 SEC("raw_tp")
 __arch_x86_64
 __xlated("2: *(u64 *)(r2 -16) = r1")
+__xlated("...")
 __xlated("4: r0 = &(void __percpu *)(r0)")
+__xlated("...")
 __xlated("6: r1 = *(u64 *)(r10 -16)")
 __success
 __naked void wrong_base_in_pattern(void)
@@ -171,7 +180,9 @@ __naked void wrong_base_in_pattern(void)
 SEC("raw_tp")
 __arch_x86_64
 __xlated("1: *(u64 *)(r10 -16) = r1")
+__xlated("...")
 __xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("...")
 __xlated("5: r2 = 1")
 __success
 __naked void wrong_insn_in_pattern(void)
@@ -191,7 +202,9 @@ __naked void wrong_insn_in_pattern(void)
 SEC("raw_tp")
 __arch_x86_64
 __xlated("2: *(u64 *)(r10 -16) = r1")
+__xlated("...")
 __xlated("4: r0 = &(void __percpu *)(r0)")
+__xlated("...")
 __xlated("6: r1 = *(u64 *)(r10 -8)")
 __success
 __naked void wrong_off_in_pattern1(void)
@@ -211,7 +224,9 @@ __naked void wrong_off_in_pattern1(void)
 SEC("raw_tp")
 __arch_x86_64
 __xlated("1: *(u32 *)(r10 -4) = r1")
+__xlated("...")
 __xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("...")
 __xlated("5: r1 = *(u32 *)(r10 -4)")
 __success
 __naked void wrong_off_in_pattern2(void)
@@ -230,7 +245,9 @@ __naked void wrong_off_in_pattern2(void)
 SEC("raw_tp")
 __arch_x86_64
 __xlated("1: *(u32 *)(r10 -16) = r1")
+__xlated("...")
 __xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("...")
 __xlated("5: r1 = *(u32 *)(r10 -16)")
 __success
 __naked void wrong_size_in_pattern(void)
@@ -249,7 +266,9 @@ __naked void wrong_size_in_pattern(void)
 SEC("raw_tp")
 __arch_x86_64
 __xlated("2: *(u32 *)(r10 -8) = r1")
+__xlated("...")
 __xlated("4: r0 = &(void __percpu *)(r0)")
+__xlated("...")
 __xlated("6: r1 = *(u32 *)(r10 -8)")
 __success
 __naked void partial_pattern(void)
@@ -275,11 +294,15 @@ __xlated("1: r2 = 2")
 /* not patched, spills for -8, -16 not removed */
 __xlated("2: *(u64 *)(r10 -8) = r1")
 __xlated("3: *(u64 *)(r10 -16) = r2")
+__xlated("...")
 __xlated("5: r0 = &(void __percpu *)(r0)")
+__xlated("...")
 __xlated("7: r2 = *(u64 *)(r10 -16)")
 __xlated("8: r1 = *(u64 *)(r10 -8)")
 /* patched, spills for -24, -32 removed */
+__xlated("...")
 __xlated("10: r0 = &(void __percpu *)(r0)")
+__xlated("...")
 __xlated("12: exit")
 __success
 __naked void min_stack_offset(void)
@@ -308,7 +331,9 @@ __naked void min_stack_offset(void)
 SEC("raw_tp")
 __arch_x86_64
 __xlated("1: *(u64 *)(r10 -8) = r1")
+__xlated("...")
 __xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("...")
 __xlated("5: r1 = *(u64 *)(r10 -8)")
 __success
 __naked void bad_fixed_read(void)
@@ -330,7 +355,9 @@ __naked void bad_fixed_read(void)
 SEC("raw_tp")
 __arch_x86_64
 __xlated("1: *(u64 *)(r10 -8) = r1")
+__xlated("...")
 __xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("...")
 __xlated("5: r1 = *(u64 *)(r10 -8)")
 __success
 __naked void bad_fixed_write(void)
@@ -352,7 +379,9 @@ __naked void bad_fixed_write(void)
 SEC("raw_tp")
 __arch_x86_64
 __xlated("6: *(u64 *)(r10 -16) = r1")
+__xlated("...")
 __xlated("8: r0 = &(void __percpu *)(r0)")
+__xlated("...")
 __xlated("10: r1 = *(u64 *)(r10 -16)")
 __success
 __naked void bad_varying_read(void)
@@ -379,7 +408,9 @@ __naked void bad_varying_read(void)
 SEC("raw_tp")
 __arch_x86_64
 __xlated("6: *(u64 *)(r10 -16) = r1")
+__xlated("...")
 __xlated("8: r0 = &(void __percpu *)(r0)")
+__xlated("...")
 __xlated("10: r1 = *(u64 *)(r10 -16)")
 __success
 __naked void bad_varying_write(void)
@@ -406,7 +437,9 @@ __naked void bad_varying_write(void)
 SEC("raw_tp")
 __arch_x86_64
 __xlated("1: *(u64 *)(r10 -8) = r1")
+__xlated("...")
 __xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("...")
 __xlated("5: r1 = *(u64 *)(r10 -8)")
 __success
 __naked void bad_write_in_subprog(void)
@@ -438,7 +471,9 @@ __naked static void bad_write_in_subprog_aux(void)
 SEC("raw_tp")
 __arch_x86_64
 __xlated("1: *(u64 *)(r10 -8) = r1")
+__xlated("...")
 __xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("...")
 __xlated("5: r1 = *(u64 *)(r10 -8)")
 __success
 __naked void bad_helper_write(void)
@@ -466,13 +501,19 @@ SEC("raw_tp")
 __arch_x86_64
 /* main, not patched */
 __xlated("1: *(u64 *)(r10 -8) = r1")
+__xlated("...")
 __xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("...")
 __xlated("5: r1 = *(u64 *)(r10 -8)")
+__xlated("...")
 __xlated("9: call pc+1")
+__xlated("...")
 __xlated("10: exit")
 /* subprogram, patched */
 __xlated("11: r1 = 1")
+__xlated("...")
 __xlated("13: r0 = &(void __percpu *)(r0)")
+__xlated("...")
 __xlated("15: exit")
 __success
 __naked void invalidate_one_subprog(void)
@@ -510,12 +551,16 @@ SEC("raw_tp")
 __arch_x86_64
 /* main */
 __xlated("0: r1 = 1")
+__xlated("...")
 __xlated("2: r0 = &(void __percpu *)(r0)")
+__xlated("...")
 __xlated("4: call pc+1")
 __xlated("5: exit")
 /* subprogram */
 __xlated("6: r1 = 1")
+__xlated("...")
 __xlated("8: r0 = &(void __percpu *)(r0)")
+__xlated("...")
 __xlated("10: *(u64 *)(r10 -16) = r1")
 __xlated("11: exit")
 __success
@@ -576,7 +621,9 @@ __log_level(4) __msg("stack depth 16")
 /* may_goto counter at -16 */
 __xlated("0: *(u64 *)(r10 -16) =")
 __xlated("1: r1 = 1")
+__xlated("...")
 __xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("...")
 /* may_goto expansion starts */
 __xlated("5: r11 = *(u64 *)(r10 -16)")
 __xlated("6: if r11 == 0x0 goto pc+3")
@@ -623,13 +670,15 @@ __xlated("5: r0 = *(u32 *)(r0 +0)")
 __xlated("6: r2 =")
 __xlated("7: r3 = 0")
 __xlated("8: r4 = 0")
+__xlated("...")
 /* ... part of the inlined bpf_loop */
 __xlated("12: *(u64 *)(r10 -32) = r6")
 __xlated("13: *(u64 *)(r10 -24) = r7")
 __xlated("14: *(u64 *)(r10 -16) = r8")
-/* ... */
+__xlated("...")
 __xlated("21: call pc+8") /* dummy_loop_callback */
 /* ... last insns of the bpf_loop_interaction1 */
+__xlated("...")
 __xlated("28: r0 = 0")
 __xlated("29: exit")
 /* dummy_loop_callback */
@@ -670,7 +719,7 @@ __xlated("5: r0 = *(u32 *)(r0 +0)")
 __xlated("6: *(u64 *)(r10 -16) = r1")
 __xlated("7: call")
 __xlated("8: r1 = *(u64 *)(r10 -16)")
-/* ... */
+__xlated("...")
 /* ... part of the inlined bpf_loop */
 __xlated("15: *(u64 *)(r10 -40) = r6")
 __xlated("16: *(u64 *)(r10 -32) = r7")
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index d588c612ac03..b229dd013355 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -365,6 +365,8 @@ static int parse_test_spec(struct test_loader *tester,
 	const char *description = NULL;
 	bool has_unpriv_result = false;
 	bool has_unpriv_retval = false;
+	bool unpriv_xlated_on_next_line = true;
+	bool xlated_on_next_line = true;
 	bool unpriv_jit_on_next_line;
 	bool jit_on_next_line;
 	bool collect_jit = false;
@@ -461,12 +463,14 @@ static int parse_test_spec(struct test_loader *tester,
 				spec->mode_mask |= UNPRIV;
 			}
 		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_XLATED_PFX))) {
-			err = push_msg(msg, &spec->priv.expect_xlated);
+			err = push_disasm_msg(msg, &xlated_on_next_line,
+					      &spec->priv.expect_xlated);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
 		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_XLATED_PFX_UNPRIV))) {
-			err = push_msg(msg, &spec->unpriv.expect_xlated);
+			err = push_disasm_msg(msg, &unpriv_xlated_on_next_line,
+					      &spec->unpriv.expect_xlated);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
-- 
2.45.2


