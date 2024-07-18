Return-Path: <bpf+bounces-35016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F207935264
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 22:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32BAF1C20EE3
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 20:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71928145B32;
	Thu, 18 Jul 2024 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nsw73/gD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0E253E22
	for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721334257; cv=none; b=RDWt+0nk3nsAD+o5lTfAlheOYhlOgTQ2Uhph/8nMZYR3AD11yGVNWV1SKc2xCXMuVU627/27Xg/zsvjz0OE5Pac2OIQ8myfmy7nVoJUGbpXicsKB+dRTlSv4TCooVjWLJWvZI240CBYGuBECAkKwmh2S0CSSTSRYtIWBeueA+9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721334257; c=relaxed/simple;
	bh=AtLk8iLkEZKPli3EnGFCY9hX7r7zVKxGsDsp3QESKYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fT0AEVKOGYPyiR1Gqi8sketyEcggVaAdsQ4CtdTVi3O7B5kH4NNK9WJzbfOkThGP49Y/w4UEAsQvxJbflGo0uDIcYNru1mmQHXQUi3OfJ4Ri4sH6SwFCdkCAD8b8Q6jr1bJW9SalzZNgH+xa1gMgNOEWNsW1F8eAkMaXPkdLgVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nsw73/gD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fb1c918860so18346865ad.1
        for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 13:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721334254; x=1721939054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTcwsVtRtTs+xd4dx7Ob7hQzuv0c8j4MLLxNkjXdOkI=;
        b=Nsw73/gDi9RKCoFpgH6c/f0yi7uel9unXFC7eJlDHZ9I8PpHC36vL+EKFnil8kWWb4
         wPoLYS5EMwDNXbXwzkFxRNvOjcR3ea2FS1cVxWle/f1c4buihgAN56kn3YHeJ6nxWAZP
         htnNoObtPnLQuV41fqb9AScBeAv4QKydPd9sgqpGLUbuir+uIB0OiFv+NulZpxrlV6nE
         XiAK2rsiyzDn5oHFfI6CgSGxLOFYhBChGL4GiKCpB0lWIZHNoZikp6wVHLSSPgL8g/UH
         lbPKxQjh+n/g15u76IBqabBAgSo2qQ6b5T5Gg7VC74s8CV8QKkj/q18EXi1+4scju/vw
         7T0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721334254; x=1721939054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTcwsVtRtTs+xd4dx7Ob7hQzuv0c8j4MLLxNkjXdOkI=;
        b=LA++R7kv0ZyDX9J7oNVmLSI5rYuQZwud9aqvxV69HMIJ0EStkjI9pJEjHbwaGuVBTY
         AEXc9CnPCEfOfZv026vlaMqyNiBUCnVHudqy4sC68SLGy8F3GCsx/JVwII8ZKTGf7Zjl
         A8toC+iIykhT7gFzvWkRliXDgo9MZV0Ck+pfMxnAbqWEWK/1S4jkPgw6Ig7rQlQiiclA
         BApxUdRBEEl9+IXY6bqYI4B6lYyTmT5JNHFMOHaE2k9fsIDK0v0lETuj9BOrXwPsXI1X
         MVbaVeAT6qrcaBrcHR+z8pJC4bs0A4U7QRszix3UXaIGAUH81+EinaE6RWTxXcK3bnMM
         a81g==
X-Gm-Message-State: AOJu0Yw9qGuKINqw/l4uy50nkopLKbqAg2ytZX/z4qczfh3G64CEzyH0
	WnLjH/lJ9hdywXsK1YdmwpZ8zoA2cXfQ/Bfmxue6BdRuxh85dUgDG1/iCNcn
X-Google-Smtp-Source: AGHT+IECR9lvJLnUkpsTA4ZrxMFFqZZczk8lDWoLFp5pHjuGbwFXk0OJjRqy7ucuHEA9Pts3W3eHEg==
X-Received: by 2002:a17:902:cec2:b0:1fb:24ea:fe29 with SMTP id d9443c01a7336-1fc5b62125emr65188865ad.15.1721334253925;
        Thu, 18 Jul 2024 13:24:13 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc505basm96888235ad.270.2024.07.18.13.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 13:24:13 -0700 (PDT)
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
Subject: [bpf-next v3 2/4] bpf: remove mark_precise_scalar_ids()
Date: Thu, 18 Jul 2024 13:23:54 -0700
Message-ID: <20240718202357.1746514-3-eddyz87@gmail.com>
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

Function mark_precise_scalar_ids() is superseded by
bt_sync_linked_regs() and equal scalars tracking in jump history.
mark_precise_scalar_ids() propagates precision over registers sharing
same ID on parent/child state boundaries, while jump history records
allow bt_sync_linked_regs() to propagate same information with
instruction level granularity, which is strictly more precise.

This commit removes mark_precise_scalar_ids() and updates test cases
in progs/verifier_scalar_ids to reflect new verifier behavior.

The tests are updated in the following manner:
- mark_precise_scalar_ids() propagated precision regardless of
  presence of conditional jumps, while new jump history based logic
  only kicks in when conditional jumps are present.
  Hence test cases are augmented with conditional jumps to still
  trigger precision propagation.
- As equal scalars tracking no longer relies on parent/child state
  boundaries some test cases are no longer interesting,
  such test cases are removed, namely:
  - precision_same_state and precision_cross_state are superseded by
    linked_regs_bpf_k;
  - precision_same_state_broken_link and equal_scalars_broken_link
    are superseded by linked_regs_broken_link.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c                         | 115 ------------
 .../selftests/bpf/progs/verifier_scalar_ids.c | 171 ++++++------------
 .../testing/selftests/bpf/verifier/precise.c  |   8 +-
 3 files changed, 59 insertions(+), 235 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5d44ab3cbb2f..9383a9639bec 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4124,96 +4124,6 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
 	}
 }
 
-static bool idset_contains(struct bpf_idset *s, u32 id)
-{
-	u32 i;
-
-	for (i = 0; i < s->count; ++i)
-		if (s->ids[i] == (id & ~BPF_ADD_CONST))
-			return true;
-
-	return false;
-}
-
-static int idset_push(struct bpf_idset *s, u32 id)
-{
-	if (WARN_ON_ONCE(s->count >= ARRAY_SIZE(s->ids)))
-		return -EFAULT;
-	s->ids[s->count++] = id & ~BPF_ADD_CONST;
-	return 0;
-}
-
-static void idset_reset(struct bpf_idset *s)
-{
-	s->count = 0;
-}
-
-/* Collect a set of IDs for all registers currently marked as precise in env->bt.
- * Mark all registers with these IDs as precise.
- */
-static int mark_precise_scalar_ids(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
-{
-	struct bpf_idset *precise_ids = &env->idset_scratch;
-	struct backtrack_state *bt = &env->bt;
-	struct bpf_func_state *func;
-	struct bpf_reg_state *reg;
-	DECLARE_BITMAP(mask, 64);
-	int i, fr;
-
-	idset_reset(precise_ids);
-
-	for (fr = bt->frame; fr >= 0; fr--) {
-		func = st->frame[fr];
-
-		bitmap_from_u64(mask, bt_frame_reg_mask(bt, fr));
-		for_each_set_bit(i, mask, 32) {
-			reg = &func->regs[i];
-			if (!reg->id || reg->type != SCALAR_VALUE)
-				continue;
-			if (idset_push(precise_ids, reg->id))
-				return -EFAULT;
-		}
-
-		bitmap_from_u64(mask, bt_frame_stack_mask(bt, fr));
-		for_each_set_bit(i, mask, 64) {
-			if (i >= func->allocated_stack / BPF_REG_SIZE)
-				break;
-			if (!is_spilled_scalar_reg(&func->stack[i]))
-				continue;
-			reg = &func->stack[i].spilled_ptr;
-			if (!reg->id)
-				continue;
-			if (idset_push(precise_ids, reg->id))
-				return -EFAULT;
-		}
-	}
-
-	for (fr = 0; fr <= st->curframe; ++fr) {
-		func = st->frame[fr];
-
-		for (i = BPF_REG_0; i < BPF_REG_10; ++i) {
-			reg = &func->regs[i];
-			if (!reg->id)
-				continue;
-			if (!idset_contains(precise_ids, reg->id))
-				continue;
-			bt_set_frame_reg(bt, fr, i);
-		}
-		for (i = 0; i < func->allocated_stack / BPF_REG_SIZE; ++i) {
-			if (!is_spilled_scalar_reg(&func->stack[i]))
-				continue;
-			reg = &func->stack[i].spilled_ptr;
-			if (!reg->id)
-				continue;
-			if (!idset_contains(precise_ids, reg->id))
-				continue;
-			bt_set_frame_slot(bt, fr, i);
-		}
-	}
-
-	return 0;
-}
-
 /*
  * __mark_chain_precision() backtracks BPF program instruction sequence and
  * chain of verifier states making sure that register *regno* (if regno >= 0)
@@ -4346,31 +4256,6 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 				bt->frame, last_idx, first_idx, subseq_idx);
 		}
 
-		/* If some register with scalar ID is marked as precise,
-		 * make sure that all registers sharing this ID are also precise.
-		 * This is needed to estimate effect of find_equal_scalars().
-		 * Do this at the last instruction of each state,
-		 * bpf_reg_state::id fields are valid for these instructions.
-		 *
-		 * Allows to track precision in situation like below:
-		 *
-		 *     r2 = unknown value
-		 *     ...
-		 *   --- state #0 ---
-		 *     ...
-		 *     r1 = r2                 // r1 and r2 now share the same ID
-		 *     ...
-		 *   --- state #1 {r1.id = A, r2.id = A} ---
-		 *     ...
-		 *     if (r2 > 10) goto exit; // find_equal_scalars() assigns range to r1
-		 *     ...
-		 *   --- state #2 {r1.id = A, r2.id = A} ---
-		 *     r3 = r10
-		 *     r3 += r1                // need to mark both r1 and r2
-		 */
-		if (mark_precise_scalar_ids(env, st))
-			return -EFAULT;
-
 		if (last_idx < 0) {
 			/* we are at the entry into subprog, which
 			 * is expected for global funcs, but only if
diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 13b29a7faa71..b642d5c24154 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -5,54 +5,27 @@
 #include "bpf_misc.h"
 
 /* Check that precision marks propagate through scalar IDs.
- * Registers r{0,1,2} have the same scalar ID at the moment when r0 is
- * marked to be precise, this mark is immediately propagated to r{1,2}.
+ * Registers r{0,1,2} have the same scalar ID.
+ * Range information is propagated for scalars sharing same ID.
+ * Check that precision mark for r0 causes precision marks for r{1,2}
+ * when range information is propagated for 'if <reg> <op> <const>' insn.
  */
 SEC("socket")
 __success __log_level(2)
-__msg("frame0: regs=r0,r1,r2 stack= before 4: (bf) r3 = r10")
-__msg("frame0: regs=r0,r1,r2 stack= before 3: (bf) r2 = r0")
-__msg("frame0: regs=r0,r1 stack= before 2: (bf) r1 = r0")
-__msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
-__msg("frame0: regs=r0 stack= before 0: (85) call bpf_ktime_get_ns")
-__flag(BPF_F_TEST_STATE_FREQ)
-__naked void precision_same_state(void)
-{
-	asm volatile (
-	/* r0 = random number up to 0xff */
-	"call %[bpf_ktime_get_ns];"
-	"r0 &= 0xff;"
-	/* tie r0.id == r1.id == r2.id */
-	"r1 = r0;"
-	"r2 = r0;"
-	/* force r0 to be precise, this immediately marks r1 and r2 as
-	 * precise as well because of shared IDs
-	 */
-	"r3 = r10;"
-	"r3 += r0;"
-	"r0 = 0;"
-	"exit;"
-	:
-	: __imm(bpf_ktime_get_ns)
-	: __clobber_all);
-}
-
-/* Same as precision_same_state, but mark propagates through state /
- * parent state boundary.
- */
-SEC("socket")
-__success __log_level(2)
-__msg("frame0: last_idx 6 first_idx 5 subseq_idx -1")
-__msg("frame0: regs=r0,r1,r2 stack= before 5: (bf) r3 = r10")
+/* first 'if' branch */
+__msg("6: (0f) r3 += r0")
+__msg("frame0: regs=r0 stack= before 4: (25) if r1 > 0x7 goto pc+0")
 __msg("frame0: parent state regs=r0,r1,r2 stack=:")
-__msg("frame0: regs=r0,r1,r2 stack= before 4: (05) goto pc+0")
 __msg("frame0: regs=r0,r1,r2 stack= before 3: (bf) r2 = r0")
-__msg("frame0: regs=r0,r1 stack= before 2: (bf) r1 = r0")
-__msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
-__msg("frame0: parent state regs=r0 stack=:")
-__msg("frame0: regs=r0 stack= before 0: (85) call bpf_ktime_get_ns")
+/* second 'if' branch */
+__msg("from 4 to 5: ")
+__msg("6: (0f) r3 += r0")
+__msg("frame0: regs=r0 stack= before 5: (bf) r3 = r10")
+__msg("frame0: regs=r0 stack= before 4: (25) if r1 > 0x7 goto pc+0")
+/* parent state already has r{0,1,2} as precise */
+__msg("frame0: parent state regs= stack=:")
 __flag(BPF_F_TEST_STATE_FREQ)
-__naked void precision_cross_state(void)
+__naked void linked_regs_bpf_k(void)
 {
 	asm volatile (
 	/* r0 = random number up to 0xff */
@@ -61,9 +34,8 @@ __naked void precision_cross_state(void)
 	/* tie r0.id == r1.id == r2.id */
 	"r1 = r0;"
 	"r2 = r0;"
-	/* force checkpoint */
-	"goto +0;"
-	/* force r0 to be precise, this immediately marks r1 and r2 as
+	"if r1 > 7 goto +0;"
+	/* force r0 to be precise, this eventually marks r1 and r2 as
 	 * precise as well because of shared IDs
 	 */
 	"r3 = r10;"
@@ -75,59 +47,18 @@ __naked void precision_cross_state(void)
 	: __clobber_all);
 }
 
-/* Same as precision_same_state, but break one of the
+/* Same as linked_regs_bpf_k, but break one of the
  * links, note that r1 is absent from regs=... in __msg below.
  */
 SEC("socket")
 __success __log_level(2)
-__msg("frame0: regs=r0,r2 stack= before 5: (bf) r3 = r10")
-__msg("frame0: regs=r0,r2 stack= before 4: (b7) r1 = 0")
-__msg("frame0: regs=r0,r2 stack= before 3: (bf) r2 = r0")
-__msg("frame0: regs=r0 stack= before 2: (bf) r1 = r0")
-__msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
-__msg("frame0: regs=r0 stack= before 0: (85) call bpf_ktime_get_ns")
-__flag(BPF_F_TEST_STATE_FREQ)
-__naked void precision_same_state_broken_link(void)
-{
-	asm volatile (
-	/* r0 = random number up to 0xff */
-	"call %[bpf_ktime_get_ns];"
-	"r0 &= 0xff;"
-	/* tie r0.id == r1.id == r2.id */
-	"r1 = r0;"
-	"r2 = r0;"
-	/* break link for r1, this is the only line that differs
-	 * compared to the previous test
-	 */
-	"r1 = 0;"
-	/* force r0 to be precise, this immediately marks r1 and r2 as
-	 * precise as well because of shared IDs
-	 */
-	"r3 = r10;"
-	"r3 += r0;"
-	"r0 = 0;"
-	"exit;"
-	:
-	: __imm(bpf_ktime_get_ns)
-	: __clobber_all);
-}
-
-/* Same as precision_same_state_broken_link, but with state /
- * parent state boundary.
- */
-SEC("socket")
-__success __log_level(2)
-__msg("frame0: regs=r0,r2 stack= before 6: (bf) r3 = r10")
-__msg("frame0: regs=r0,r2 stack= before 5: (b7) r1 = 0")
-__msg("frame0: parent state regs=r0,r2 stack=:")
-__msg("frame0: regs=r0,r1,r2 stack= before 4: (05) goto pc+0")
-__msg("frame0: regs=r0,r1,r2 stack= before 3: (bf) r2 = r0")
-__msg("frame0: regs=r0,r1 stack= before 2: (bf) r1 = r0")
-__msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
+__msg("7: (0f) r3 += r0")
+__msg("frame0: regs=r0 stack= before 6: (bf) r3 = r10")
 __msg("frame0: parent state regs=r0 stack=:")
-__msg("frame0: regs=r0 stack= before 0: (85) call bpf_ktime_get_ns")
+__msg("frame0: regs=r0 stack= before 5: (25) if r0 > 0x7 goto pc+0")
+__msg("frame0: parent state regs=r0,r2 stack=:")
 __flag(BPF_F_TEST_STATE_FREQ)
-__naked void precision_cross_state_broken_link(void)
+__naked void linked_regs_broken_link(void)
 {
 	asm volatile (
 	/* r0 = random number up to 0xff */
@@ -136,18 +67,13 @@ __naked void precision_cross_state_broken_link(void)
 	/* tie r0.id == r1.id == r2.id */
 	"r1 = r0;"
 	"r2 = r0;"
-	/* force checkpoint, although link between r1 and r{0,2} is
-	 * broken by the next statement current precision tracking
-	 * algorithm can't react to it and propagates mark for r1 to
-	 * the parent state.
-	 */
-	"goto +0;"
 	/* break link for r1, this is the only line that differs
-	 * compared to precision_cross_state()
+	 * compared to the previous test
 	 */
 	"r1 = 0;"
-	/* force r0 to be precise, this immediately marks r1 and r2 as
-	 * precise as well because of shared IDs
+	"if r0 > 7 goto +0;"
+	/* force r0 to be precise,
+	 * this eventually marks r2 as precise because of shared IDs
 	 */
 	"r3 = r10;"
 	"r3 += r0;"
@@ -164,10 +90,16 @@ __naked void precision_cross_state_broken_link(void)
  */
 SEC("socket")
 __success __log_level(2)
-__msg("11: (0f) r2 += r1")
+__msg("12: (0f) r2 += r1")
 /* Current state */
-__msg("frame2: last_idx 11 first_idx 10 subseq_idx -1")
-__msg("frame2: regs=r1 stack= before 10: (bf) r2 = r10")
+__msg("frame2: last_idx 12 first_idx 11 subseq_idx -1 ")
+__msg("frame2: regs=r1 stack= before 11: (bf) r2 = r10")
+__msg("frame2: parent state regs=r1 stack=")
+__msg("frame1: parent state regs= stack=")
+__msg("frame0: parent state regs= stack=")
+/* Parent state */
+__msg("frame2: last_idx 10 first_idx 10 subseq_idx 11 ")
+__msg("frame2: regs=r1 stack= before 10: (25) if r1 > 0x7 goto pc+0")
 __msg("frame2: parent state regs=r1 stack=")
 /* frame1.r{6,7} are marked because mark_precise_scalar_ids()
  * looks for all registers with frame2.r1.id in the current state
@@ -192,7 +124,7 @@ __msg("frame1: regs=r1 stack= before 4: (85) call pc+1")
 __msg("frame0: parent state regs=r1,r6 stack=")
 /* Parent state */
 __msg("frame0: last_idx 3 first_idx 1 subseq_idx 4")
-__msg("frame0: regs=r0,r1,r6 stack= before 3: (bf) r6 = r0")
+__msg("frame0: regs=r1,r6 stack= before 3: (bf) r6 = r0")
 __msg("frame0: regs=r0,r1 stack= before 2: (bf) r1 = r0")
 __msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
 __flag(BPF_F_TEST_STATE_FREQ)
@@ -230,7 +162,8 @@ static __naked __noinline __used
 void precision_many_frames__bar(void)
 {
 	asm volatile (
-	/* force r1 to be precise, this immediately marks:
+	"if r1 > 7 goto +0;"
+	/* force r1 to be precise, this eventually marks:
 	 * - bar frame r1
 	 * - foo frame r{1,6,7}
 	 * - main frame r{1,6}
@@ -247,14 +180,16 @@ void precision_many_frames__bar(void)
  */
 SEC("socket")
 __success __log_level(2)
+__msg("11: (0f) r2 += r1")
 /* foo frame */
-__msg("frame1: regs=r1 stack=-8,-16 before 9: (bf) r2 = r10")
+__msg("frame1: regs=r1 stack= before 10: (bf) r2 = r10")
+__msg("frame1: regs=r1 stack= before 9: (25) if r1 > 0x7 goto pc+0")
 __msg("frame1: regs=r1 stack=-8,-16 before 8: (7b) *(u64 *)(r10 -16) = r1")
 __msg("frame1: regs=r1 stack=-8 before 7: (7b) *(u64 *)(r10 -8) = r1")
 __msg("frame1: regs=r1 stack= before 4: (85) call pc+2")
 /* main frame */
-__msg("frame0: regs=r0,r1 stack=-8 before 3: (7b) *(u64 *)(r10 -8) = r1")
-__msg("frame0: regs=r0,r1 stack= before 2: (bf) r1 = r0")
+__msg("frame0: regs=r1 stack=-8 before 3: (7b) *(u64 *)(r10 -8) = r1")
+__msg("frame0: regs=r1 stack= before 2: (bf) r1 = r0")
 __msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
 __flag(BPF_F_TEST_STATE_FREQ)
 __naked void precision_stack(void)
@@ -283,7 +218,8 @@ void precision_stack__foo(void)
 	 */
 	"*(u64*)(r10 - 8) = r1;"
 	"*(u64*)(r10 - 16) = r1;"
-	/* force r1 to be precise, this immediately marks:
+	"if r1 > 7 goto +0;"
+	/* force r1 to be precise, this eventually marks:
 	 * - foo frame r1,fp{-8,-16}
 	 * - main frame r1,fp{-8}
 	 */
@@ -299,15 +235,17 @@ void precision_stack__foo(void)
 SEC("socket")
 __success __log_level(2)
 /* r{6,7} */
-__msg("11: (0f) r3 += r7")
-__msg("frame0: regs=r6,r7 stack= before 10: (bf) r3 = r10")
+__msg("12: (0f) r3 += r7")
+__msg("frame0: regs=r7 stack= before 11: (bf) r3 = r10")
+__msg("frame0: regs=r7 stack= before 9: (25) if r7 > 0x7 goto pc+0")
 /* ... skip some insns ... */
 __msg("frame0: regs=r6,r7 stack= before 3: (bf) r7 = r0")
 __msg("frame0: regs=r0,r6 stack= before 2: (bf) r6 = r0")
 /* r{8,9} */
-__msg("12: (0f) r3 += r9")
-__msg("frame0: regs=r8,r9 stack= before 11: (0f) r3 += r7")
+__msg("13: (0f) r3 += r9")
+__msg("frame0: regs=r9 stack= before 12: (0f) r3 += r7")
 /* ... skip some insns ... */
+__msg("frame0: regs=r9 stack= before 10: (25) if r9 > 0x7 goto pc+0")
 __msg("frame0: regs=r8,r9 stack= before 7: (bf) r9 = r0")
 __msg("frame0: regs=r0,r8 stack= before 6: (bf) r8 = r0")
 __flag(BPF_F_TEST_STATE_FREQ)
@@ -328,8 +266,9 @@ __naked void precision_two_ids(void)
 	"r9 = r0;"
 	/* clear r0 id */
 	"r0 = 0;"
-	/* force checkpoint */
-	"goto +0;"
+	/* propagate equal scalars precision */
+	"if r7 > 7 goto +0;"
+	"if r9 > 7 goto +0;"
 	"r3 = r10;"
 	/* force r7 to be precise, this also marks r6 */
 	"r3 += r7;"
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
index 64d722199e8f..59a020c35647 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -106,7 +106,7 @@
 	mark_precise: frame0: regs=r2 stack= before 22\
 	mark_precise: frame0: parent state regs=r2 stack=:\
 	mark_precise: frame0: last_idx 20 first_idx 20\
-	mark_precise: frame0: regs=r2,r9 stack= before 20\
+	mark_precise: frame0: regs=r2 stack= before 20\
 	mark_precise: frame0: parent state regs=r2,r9 stack=:\
 	mark_precise: frame0: last_idx 19 first_idx 17\
 	mark_precise: frame0: regs=r2,r9 stack= before 19\
@@ -183,10 +183,10 @@
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.flags = BPF_F_TEST_STATE_FREQ,
 	.errstr = "mark_precise: frame0: last_idx 7 first_idx 7\
-	mark_precise: frame0: parent state regs=r4 stack=-8:\
+	mark_precise: frame0: parent state regs=r4 stack=:\
 	mark_precise: frame0: last_idx 6 first_idx 4\
-	mark_precise: frame0: regs=r4 stack=-8 before 6: (b7) r0 = -1\
-	mark_precise: frame0: regs=r4 stack=-8 before 5: (79) r4 = *(u64 *)(r10 -8)\
+	mark_precise: frame0: regs=r4 stack= before 6: (b7) r0 = -1\
+	mark_precise: frame0: regs=r4 stack= before 5: (79) r4 = *(u64 *)(r10 -8)\
 	mark_precise: frame0: regs= stack=-8 before 4: (7b) *(u64 *)(r3 -8) = r0\
 	mark_precise: frame0: parent state regs=r0 stack=:\
 	mark_precise: frame0: last_idx 3 first_idx 3\
-- 
2.45.2


