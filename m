Return-Path: <bpf+bounces-33971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFF5928E6B
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 22:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756021C248A7
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 20:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01721145A14;
	Fri,  5 Jul 2024 20:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnxDVQ2c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B0B1459F9
	for <bpf@vger.kernel.org>; Fri,  5 Jul 2024 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213150; cv=none; b=qZFXzwTXwyyuXViRha+6wBNMfxYueDF3jxXG7wpG8T17vCNRskPakdZH3HpFnwWDRmwZFjR1YVCX44iUY+j6RqDaIYlyFqHHpoUHkEf5LSszft2CkuY37IkP0yHZywKw0Eg2yzpohsxfBE4nlJ7VxgrUTm57q9ulTajfyWJtfyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213150; c=relaxed/simple;
	bh=TX4pt3jt6//jb5FavZnRh/kqZ88SIqQnCgOULnFrEb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4OsSA+x+CHK1WH2OBe2QgCag64qe+ZB0DvhonV3ttVxmGgHOzuwQtCre6D8l9tjlr55kReVQVpevZ7G67aTxAPDtNJTBu6jFywQgdnG+uWmFm54GbvMaBv+GZeS+wUarXRO53MrA39sggN8dTjdII/xqPUQwndqDkMVjXQF7jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnxDVQ2c; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fb3cf78fbdso11542975ad.1
        for <bpf@vger.kernel.org>; Fri, 05 Jul 2024 13:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720213148; x=1720817948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+2J22QjEqG7RedVQ+I6NCeL5gQ5Va/n0Fq4dvBpMQA=;
        b=gnxDVQ2cXxWG2E7iIjcUvIb0OJl2zVUxJD8muw+ulhAiUk8fJY7910fPHLUrE1Rdfu
         nsVKGVaZuB1VFPWi8uzx+FxWloL7AEE/hyC4LGYOuhGsfwrV1l4nHRlrHGtx3EnYf2w0
         ivS5W9RAs/iso9/7GYovpwXw3aySdFMfDH/UHJCR5aP4aQ9DaMPYI4r7GcjL4H0aelS9
         LCgr2cBdyZcnrn1gG1CgGEC2msbE+xSp7l/eBS99TelYQ07D7nLb884XSc/+JTg1G7tu
         XqmY8P8/0ryYRaL0B5xQTeq0zke73STGhimawqnHaXcSvSEe4IgACfGQsApKUi4S2ovc
         xRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720213148; x=1720817948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+2J22QjEqG7RedVQ+I6NCeL5gQ5Va/n0Fq4dvBpMQA=;
        b=CW+kdoieYWcaBlejsBFkFf22xis4YSkXmKRbnYfIrxoFak8cltzf+6rQYs3hCtJCYa
         3I0SoYSmtzv3aWIh+Tql9gSYeqUauAJRKoPjF4UadiOOqrG/7rioj0HN9XlcHF42oL9v
         4PQ85BTa+qn+VOhMxMTN9m8E8KM8kwVGSHzoBm7+RiCVZmPy6CClK0Cr6McIo347j7RK
         SbSCne0MkReXQlghQMsO0Xvocps3wCD6RFQMsiEN2Y8lrLMCPtCQ8+4BcbmtYbPUSsjg
         DrWjG4O/uXAv8sMI4759x/30Nge+jxaG9b081jjP2i4+brf5zlsD8J448notofjea6Wa
         IPqw==
X-Gm-Message-State: AOJu0YzT5i8QkycmxvW2pBICerk3gvHzZ3M6xiH195Kvp2ib0Z4UAVYg
	thYOJct4KtCIgLNYq//woSo/QFv8EEVRTm+sTAeldq/lEpmhuDOgFFsdEJRS
X-Google-Smtp-Source: AGHT+IGwvLjlxkEf/qnMeMyiexMMPYXGj4KLtYpv6uOiARwRRlrUGVuIDt2uNLRabLmRpEGRoFnQpw==
X-Received: by 2002:a17:902:f541:b0:1fa:2b11:4583 with SMTP id d9443c01a7336-1fb33df623dmr48175745ad.4.1720213148063;
        Fri, 05 Jul 2024 13:59:08 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac11d8c52sm144767705ad.112.2024.07.05.13.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 13:59:07 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: tests for per-insn find_equal_scalars() precision tracking
Date: Fri,  5 Jul 2024 13:58:50 -0700
Message-ID: <20240705205851.2635794-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705205851.2635794-1-eddyz87@gmail.com>
References: <20240705205851.2635794-1-eddyz87@gmail.com>
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
2.45.2


