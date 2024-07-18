Return-Path: <bpf+bounces-35017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3BA935266
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 22:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3050D1C20F7F
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 20:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14986145FE3;
	Thu, 18 Jul 2024 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVi+LNeh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED8E145B17
	for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 20:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721334257; cv=none; b=f9F1BvY4Fwgj00gZHzNvV0asPJCWQiq6F3SNn1iglwguckTFm3nNbv4KCnoJwLVs/0NK2lcysyGjaq4l28FZYGWQ9KefdNJncCbcc8rpSfFtVgXOnYdaL9vmi5CWmjHFDYZqZAze9DXvqkrJPhuK6d6OYzzmVia3Fh9lmdGfOn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721334257; c=relaxed/simple;
	bh=GrWVkglQvGQK9WhdSQcQ1GQYgFIbbzuhZkGezi/Lgdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHi0R8foY4TPTO7xYmwR/8tsfzo2/+NIHFxOdWn/1/ubUmzfkpYi6es3fXfIcWW3T/SmIF/ayEresJZjX0j4Jqk57Ld9bg+iKNn5AE6ZDwnjhU9iZluxqIEgruSdo+WOhPALsCpo+/6KS677+ak65aZ8BHFCmqdPCwJYCWUop90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVi+LNeh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fb05b0be01so8157775ad.2
        for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 13:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721334255; x=1721939055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9rbmWhvbvh/zuWQ/6RPcFsuyhUbzOATRVVgdGrhuLQ=;
        b=UVi+LNehx7m1GqrZgcD/avlF3j6n8JWMrPiJfiIaeK2j5w+yCnKP9PM6Kgx2nOsU6w
         C/x7cuczzOI5WsDLOckj6mrDorbyr42llzcq/HeeF6nO51PV+RtfHe+6PAeqQCqNv4vx
         h6P/M2Xv57eed4+7kA5QI+npFi4+shxDZaqiBCQaenX+NBv7nM6DnxgUkKao5dBTdHgY
         3pNHZzrUBR1KViVnt4HiwqHiXazeH+m81Zul9yJnbIA53jeESfUE0iVesov8i/ZUcnk4
         iwaGt3+iaBbZ0goUFa1AdBftI0Fyoj1EgNr3jsum+k2c2ktKFo2kZ1qwfJCEXfR0PTCy
         +naw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721334255; x=1721939055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9rbmWhvbvh/zuWQ/6RPcFsuyhUbzOATRVVgdGrhuLQ=;
        b=t4d/9VNQliJGJDvH7ExQxQ7fr/gfWdwKlfZfRPiu33QDHfJJkI5xgWGJq0be3j28WW
         Ss7T6DTKIgXCu6EmucPSz51JJOMt1oiH7EyFKVyhi67r2ddRjVesXnKK+b2EAAd+3nNo
         3az2XEES36SSk8itr057kCqGeeosps8LssFSvMx5w/CStZzAIISFAjjYZoXmCH9XPNq0
         3w48cna1gxZIXuDZNAWBByhWOaK+zT0Yv0Htpl3BZkq9VUhP8/pJjYxsjJaoIb+MyXXx
         XIDiW/Odnj5X9IFMKbxC3xcBSKzhsZs7RaU+WtX4epTIViN/otYVziFyt3oen3092dEB
         zEAA==
X-Gm-Message-State: AOJu0Yy/5N+XkrEhkEzqVmyhY1sS9iM+vBBdiEKilZSJ+6lBw43c8lxV
	MOIFJcC5eBd1/pSfXdr7iNpkOg+4VpR6kKWZC7st0L+pPiPj3dFVeQcnRgXZ
X-Google-Smtp-Source: AGHT+IFcyamMc12XeBG9vR6u/kmJh7nlhrHYrdk4DBKSBOMTRAjL/JN9dnew2oLA9xYaFsFSpF9ULw==
X-Received: by 2002:a17:902:f681:b0:1fb:76d9:fe7e with SMTP id d9443c01a7336-1fc4e17cbecmr70175045ad.14.1721334255063;
        Thu, 18 Jul 2024 13:24:15 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc505basm96888235ad.270.2024.07.18.13.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 13:24:14 -0700 (PDT)
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
Subject: [bpf-next v3 3/4] selftests/bpf: tests for per-insn sync_linked_regs() precision tracking
Date: Thu, 18 Jul 2024 13:23:55 -0700
Message-ID: <20240718202357.1746514-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718202357.1746514-1-eddyz87@gmail.com>
References: <20240718202357.1746514-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a few test cases to verify precision tracking for scalars gaining
range because of sync_linked_regs():
- check what happens when more than 6 registers might gain range in
  sync_linked_regs();
- check if precision is propagated correctly when operand of
  conditional jump gained range in sync_linked_regs() and one of
  linked registers is marked precise;
- check if precision is propagated correctly when operand of
  conditional jump gained range in sync_linked_regs() and a
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
index b642d5c24154..2ecf77b623e0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -47,6 +47,72 @@ __naked void linked_regs_bpf_k(void)
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
+__naked void linked_regs_bpf_x_src(void)
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
+__naked void linked_regs_bpf_x_dst(void)
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
 /* Same as linked_regs_bpf_k, but break one of the
  * links, note that r1 is absent from regs=... in __msg below.
  */
@@ -280,6 +346,105 @@ __naked void precision_two_ids(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__success __log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+/* check thar r0 and r6 have different IDs after 'if',
+ * collect_linked_regs() can't tie more than 6 registers for a single insn.
+ */
+__msg("8: (25) if r0 > 0x7 goto pc+0         ; R0=scalar(id=1")
+__msg("9: (bf) r6 = r6                       ; R6_w=scalar(id=2")
+/* check that r{0-5} are marked precise after 'if' */
+__msg("frame0: regs=r0 stack= before 8: (25) if r0 > 0x7 goto pc+0")
+__msg("frame0: parent state regs=r0,r1,r2,r3,r4,r5 stack=:")
+__naked void linked_regs_too_many_regs(void)
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
+__naked void linked_regs_broken_link_2(void)
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
+__naked void cjmp_no_linked_regs_trigger(void)
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


