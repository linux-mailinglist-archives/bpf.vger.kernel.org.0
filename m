Return-Path: <bpf+bounces-22479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63C585EE4E
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 01:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153901C20EFD
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 00:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C833C111B2;
	Thu, 22 Feb 2024 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haAgv/XS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CE011712
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708563033; cv=none; b=QaG5pZFY+aQ5HhzJBBLg96E/I4QnQ2gaN2z7g6Qru8XB8MPbsigz63D/zhfNeIa2KlnmWbCXYxMzMcP7UwTMZ1GpKV4BSRjAXcEB3cBiPI8D0R+wQZ5/sv9ShTkg/RYGIl6V5oakdvwMqH9j3shuzpRSLyuE8mJpGaEcjfUfTSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708563033; c=relaxed/simple;
	bh=sm/zi4BAYhK0oXd2Ui+UTSdQgAGy1sC/8HLhXDkPggY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+ZjCwl1s3Ggwp2wx6ezC6/1ozKvZleXkIdUfHviTuHdUfoR4mXlRKMoy6dlPkL3rH0Tj0qlZTg+qVzyb+GpQFOWix7LlE1StuKkv4r90GdWdV4wM4suvreZWH6YF+r99iBea8Elp7RHWCatBEDC08bNZrpNKlsZjfsOoM3ysZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haAgv/XS; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3394bec856fso183942f8f.0
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 16:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708563029; x=1709167829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=od5FUctHBa5MP/BQQSw6kIbGqjimFTpHBHCf3SHkStg=;
        b=haAgv/XSoLmPcJWk4V0V549SRW0gldEtJmfMva1+mScpooxasmHXq1SYIHGV2EFM9W
         KSIrKBQz/e868SdgUH0dta/E13HOEXMJy1xOqEJeNxunqqjFWihUs6+z40sKiKCg+J0V
         xXZX9S4tv0cuOx7xn4y5f7iOnBVr/V5uIoeDDEJk1QiugSzJf8ji0U4Sl3H1x671k7Fo
         reooxbbSi859To/2bryOPIL7Eu/mcZLfudl36adn/axOV22dlOIGYp0bd4K+uMZOfDPf
         MpS5j9zRnuhPG1IE93w5TuTijSTZCER6kx/UNGAlX8SeIXZ/ObFs43PlOtgTMDk04E0S
         mGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708563029; x=1709167829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=od5FUctHBa5MP/BQQSw6kIbGqjimFTpHBHCf3SHkStg=;
        b=kuo6kwhzhdUAvGwaO/ouPc5FNpyYPzeb3ZTt/sv5JCdOk3MPn0VMyrrxfszWeucjSN
         dXMu55ZzNh2XY9n3k3PVmcNg1H5rZwINiRof/bP67imwJrUeoi/lG6zC1kAK618sNUeB
         E2mQIbDYezN22qF7T0sX8jWLFhTIw90otM+qWBEezAuOl0qzgd9h2lIxW1ksHMbS/1+S
         UrZ5o5qiNorzpiQdTeJqMRmCIHsM2M93qb8rpnQTxYS4cCGlePjZOXcm5lpEirEwVWwq
         AvPv8HT1sxTv2OSCbMXpJzEc8z1cjCGayoL0naEzGk3Ii6zGJ/0Y4nAimA4ql9iLenkW
         uQgg==
X-Gm-Message-State: AOJu0Yzcz2SGWi9Qu5f3cyJDsUQqlmZmQ/U92Q7dU5l0FROq/1/GMBZh
	RNmwqHi6lUf6XW5Ivvy5Tvm8HuREKrth87whaX8s75lAhwq7zjqDeyGyyHGO
X-Google-Smtp-Source: AGHT+IHCmX4iwTM5kVnfxB3KKd7/1z4r6VSjU/2JRsvxuIb6fg1d7R4oro6hxJbB9OSZoR4CC7o5Qg==
X-Received: by 2002:adf:e687:0:b0:33d:8e93:9524 with SMTP id r7-20020adfe687000000b0033d8e939524mr172726wrm.29.1708563029274;
        Wed, 21 Feb 2024 16:50:29 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i17-20020a05600c355100b0041279ac13adsm2031992wmq.36.2024.02.21.16.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 16:50:28 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	sunhao.th@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 4/4] selftests/bpf: tests for per-insn find_equal_scalars() precision tracking
Date: Thu, 22 Feb 2024 02:50:05 +0200
Message-ID: <20240222005005.31784-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222005005.31784-1-eddyz87@gmail.com>
References: <20240222005005.31784-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a few test cases to verify precision tracking for scalars gaining
range because of find_equal_scalars():
- check what happens when more than 6 registers might gain range in
  find_equal_scalars();
- check if precision is propagated correctly when operand of
  conditional jump gained range in find_equal_scalars() and one of
  linked registers is marked precise;
- check if precision is propagated correctly when operand of
  conditional jump gained range in find_equal_scalars() and a
  other-linked operand of the conditional jump is marked precise;
- add a minimized reproducer for precision tracking bug reported in [0];
- Check that mark_chain_precision() for one of the conditional jump
  operands does not trigger equal scalars precision propagation.

[0] https://lore.kernel.org/bpf/CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com/

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_scalar_ids.c | 165 ++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 639db72b1c55..993c5affb3d7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -47,6 +47,72 @@ __naked void equal_scalars_bpf_k(void)
 	: __clobber_all);
 }
 
+/* Registers r{0,1,2} share same ID when 'if r1 > ...' insn is processed,
+ * check that verifier marks r{1,2} as precise while backtracking
+ * 'if r1 > ...' with r0 already marked.
+ */
+SEC("socket")
+__success __log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("frame0: regs=r0 stack= before 5: (2d) if r1 > r3 goto pc+0")
+__msg("frame0: parent state regs=r0,r1,r2,r3 stack=:")
+__msg("frame0: regs=r0,r1,r2,r3 stack= before 4: (b7) r3 = 7")
+__naked void equal_scalars_bpf_x_src(void)
+{
+	asm volatile (
+	/* r0 = random number up to 0xff */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	/* tie r0.id == r1.id == r2.id */
+	"r1 = r0;"
+	"r2 = r0;"
+	"r3 = 7;"
+	"if r1 > r3 goto +0;"
+	/* force r0 to be precise, this eventually marks r1 and r2 as
+	 * precise as well because of shared IDs
+	 */
+	"r4 = r10;"
+	"r4 += r0;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* Registers r{0,1,2} share same ID when 'if r1 > r3' insn is processed,
+ * check that verifier marks r{0,1,2} as precise while backtracking
+ * 'if r1 > r3' with r3 already marked.
+ */
+SEC("socket")
+__success __log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("frame0: regs=r3 stack= before 5: (2d) if r1 > r3 goto pc+0")
+__msg("frame0: parent state regs=r0,r1,r2,r3 stack=:")
+__msg("frame0: regs=r0,r1,r2,r3 stack= before 4: (b7) r3 = 7")
+__naked void equal_scalars_bpf_x_dst(void)
+{
+	asm volatile (
+	/* r0 = random number up to 0xff */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	/* tie r0.id == r1.id == r2.id */
+	"r1 = r0;"
+	"r2 = r0;"
+	"r3 = 7;"
+	"if r1 > r3 goto +0;"
+	/* force r0 to be precise, this eventually marks r1 and r2 as
+	 * precise as well because of shared IDs
+	 */
+	"r4 = r10;"
+	"r4 += r3;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
 /* Same as equal_scalars_bpf_k, but break one of the
  * links, note that r1 is absent from regs=... in __msg below.
  */
@@ -280,6 +346,105 @@ __naked void precision_two_ids(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__success __log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+/* check thar r0 and r6 have different IDs after 'if',
+ * find_equal_scalars() can't tie more than 6 registers for a single insn.
+ */
+__msg("8: (25) if r0 > 0x7 goto pc+0         ; R0=scalar(id=1")
+__msg("9: (bf) r6 = r6                       ; R6_w=scalar(id=2")
+/* check that r{0-5} are marked precise after 'if' */
+__msg("frame0: regs=r0 stack= before 8: (25) if r0 > 0x7 goto pc+0")
+__msg("frame0: parent state regs=r0,r1,r2,r3,r4,r5 stack=:")
+__naked void equal_scalars_too_many_regs(void)
+{
+	asm volatile (
+	/* r0 = random number up to 0xff */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	/* tie r{0-6} IDs */
+	"r1 = r0;"
+	"r2 = r0;"
+	"r3 = r0;"
+	"r4 = r0;"
+	"r5 = r0;"
+	"r6 = r0;"
+	/* propagate range for r{0-6} */
+	"if r0 > 7 goto +0;"
+	/* make r6 appear in the log */
+	"r6 = r6;"
+	/* force r0 to be precise,
+	 * this would cause r{0-4} to be precise because of shared IDs
+	 */
+	"r7 = r10;"
+	"r7 += r0;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__failure __log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("regs=r7 stack= before 5: (3d) if r8 >= r0")
+__msg("parent state regs=r0,r7,r8")
+__msg("regs=r0,r7,r8 stack= before 4: (25) if r0 > 0x1")
+__msg("div by zero")
+__naked void equal_scalars_broken_link_2(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r7 = r0;"
+	"r8 = r0;"
+	"call %[bpf_get_prandom_u32];"
+	"if r0 > 1 goto +0;"
+	/* r7.id == r8.id,
+	 * thus r7 precision implies r8 precision,
+	 * which implies r0 precision because of the conditional below.
+	 */
+	"if r8 >= r0 goto 1f;"
+	/* break id relation between r7 and r8 */
+	"r8 += r8;"
+	/* make r7 precise */
+	"if r7 == 0 goto 1f;"
+	"r0 /= 0;"
+"1:"
+	"r0 = 42;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* Check that mark_chain_precision() for one of the conditional jump
+ * operands does not trigger equal scalars precision propagation.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("3: (25) if r1 > 0x100 goto pc+0")
+__msg("frame0: regs=r1 stack= before 2: (bf) r1 = r0")
+__naked void cjmp_no_equal_scalars_trigger(void)
+{
+	asm volatile (
+	/* r0 = random number up to 0xff */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	/* tie r0.id == r1.id */
+	"r1 = r0;"
+	/* the jump below would be predicted, thus r1 would be marked precise,
+	 * this should not imply precision mark for r0
+	 */
+	"if r1 > 256 goto +0;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
 /* Verify that check_ids() is used by regsafe() for scalars.
  *
  * r9 = ... some pointer with range X ...
-- 
2.43.0


